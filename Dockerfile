# Dockerfile provisions postgresql and deepdive all together!
FROM ubuntu:14.04
MAINTAINER Ahmed Masud <ahmed.masud@trustifier.com>
ARG BT_PASSWORD
ENV BT_PASSWORD=${BT_PASSWORD:-changeme}
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y ssh
RUN groupadd -r admin
RUN sed -i -e '/^%admin/s/ALL[ \t]*$/NOPASSWD: ALL/' /etc/sudoers
RUN useradd -c "Deep Diver,,," -m -s /bin/bash --groups admin,sudo deepdiver \
        && echo deepdiver:${BT_PASSWORD} | chpasswd -c SHA512
USER deepdiver
ENTRYPOINT "/bin/bash"
CMD [ "--login" ]
