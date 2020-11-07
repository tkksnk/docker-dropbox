FROM frolvlad/alpine-glibc:alpine-3.12

MAINTAINER Yusuke KOMORI <komo@littleforest.jp>

USER root

ARG DBOX_USER="dbox"
ARG DBOX_GROUP=${DBOX_USER}
ENV DBOX_USER  ${DBOX_USER}

RUN apk update && apk add --no-cache ca-certificates curl glib libstdc++ libatomic su-exec shadow python3 \
    && apk add openssl mesa-glapi libxext libxdamage libxfixes libxshmfence libxxf86vm \
    && addgroup -g 9999 ${DBOX_GROUP} && adduser -u 9999 -h /home/${DBOX_USER} -s /bin/sh -D -G ${DBOX_GROUP} ${DBOX_USER} \
    && mkdir -p /home/${DBOX_USER}/.dropbox /home/${DBOX_USER}/Dropbox /home/${DBOX_USER}/bin

COPY dropbox /
COPY entrypoint.sh /

EXPOSE 17500

VOLUME ["/home/${DBOX_USER}/Dropbox", "/home/${DBOX_USER}/.dropbox"]

ENTRYPOINT ["/entrypoint.sh"]

