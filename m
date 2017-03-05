Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD8E20254
	for <e@80x24.org>; Sun,  5 Mar 2017 18:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbdCESdu (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 13:33:50 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36391 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdCESdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 13:33:49 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so19163600wrc.3
        for <git@vger.kernel.org>; Sun, 05 Mar 2017 10:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bUO7x3qqNBVkNJJPn4vlj9ukMIALZSQeX96NAAPPM+4=;
        b=G6sKAvDtI47avXiNA5msuDTy1PfP9/Zep2A+JjAkbNk53vz24czfkawfXEMb9Vb7ZO
         74X1Q5ZZPdjgW+lR0Mw1GhJmUPXlDweTtRG7XEn38I+SVOF/DmRzG7ZfNUP7rYqQk/Qk
         9LpGVGqcpNXwo/9W9rlXWViVXdK0V6QBGn6wUZgjRNjJ0IzLzQtlJEr6FF4Fu0oxPeps
         gJVzEJ34QaCChVXNyFvExsh68RvX2lESs9v9DAHrkVPhWJlK7Mr02tNbAhvyb2ZOt8Y7
         4LaKmqMNnmvno1lBlt688DQgF6KVKGvDlkIWvXPMZNfAmgV2gDWZyV2cwrnsG3AwztQn
         6B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bUO7x3qqNBVkNJJPn4vlj9ukMIALZSQeX96NAAPPM+4=;
        b=Sh+x8Wvgc9HSnUW2+IV9SRyUQmDWxMx/rvboK6KjvO5KGB/jFcyxOeE9Hk0GrB2qdz
         N3tiiVLoMcKWwISWXrjyDvhJWxU6FMKafvoYbP4msQW36UprYwwsxDwnxZR1oIVVswd3
         cBodKFLxcLJAlod42tJit2KylnN6JPYSUa0zev1amQpxz4BFH1ubplDQYkaTe/ccWnUE
         FIhDO03EUdtM8vL9pqr65f1OBGlpjwpRe7VWuJaO8luvcZF0cvRpRLdBz1wgwD8kaNbP
         +0Rlnv8bqV2CqUfqrx37jVVteZvXVJbEfg53T2WXCR7zCL/LXakU31eIHoFbsNFi21ay
         sAow==
X-Gm-Message-State: AMke39kH7YplfOh4E6tED+QzvX/+3tztXkjzM+7oNGNNXqxWfwLkBVsEM1t+hVxIa5bGvg==
X-Received: by 10.223.128.202 with SMTP id 68mr11429422wrl.108.1488738323423;
        Sun, 05 Mar 2017 10:25:23 -0800 (PST)
Received: from slxBook4.fritz.box (p5DDB65AD.dip0.t-ipconnect.de. [93.219.101.173])
        by smtp.gmail.com with ESMTPSA id x23sm24013924wrb.49.2017.03.05.10.25.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 05 Mar 2017 10:25:22 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, christian.couder@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] Travis: also test on 32-bit Linux
Date:   Sun,  5 Mar 2017 19:25:19 +0100
Message-Id: <20170305182519.98925-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git v2.9.1 was released, it had a bug that showed only on Windows
and on 32-bit systems: our assumption that `unsigned long` can hold
64-bit values turned out to be wrong.

This could have been caught earlier if we had a Continuous Testing
set up that includes a build and test run on 32-bit Linux.

Let's do this (and take care of the Windows build later). This patch
asks Travis CI to install a Docker image with 32-bit libraries and then
goes on to build and test Git using this 32-bit setup.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

when I looked into the 32-bit/line-log issue [1], I realized that my
proposed docker setup is not ideal for local debugging. Here is an
approach that I think is better. I changed the following:
    - disable sudo as it is not required for the Travis job
    - keep all docker commands in the .travis.yml
    - add option to run commands inside docker with the same UID as the
      host user to make output files accessible
    - pass environment variables directly to the docker container

Sorry for the back and forth.

Cheers,
Lars


[1] http://public-inbox.org/git/2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com/


Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/a6fe1def16
    Checkout: git fetch https://github.com/larsxschneider/git travisci/linux32-v3 && git checkout a6fe1def16

    Interdiff (v2..v3):

    diff --git a/.travis.yml b/.travis.yml
    index fd60fd8328..591cc57b80 100644
    --- a/.travis.yml
    +++ b/.travis.yml
    @@ -41,13 +41,25 @@ matrix:
       include:
         - env: Linux32
           os: linux
    -      sudo: required
           services:
             - docker
           before_install:
             - docker pull daald/ubuntu32:xenial
           before_script:
    -      script: ci/run-linux32-build.sh daald/ubuntu32:xenial
    +      script:
    +        - >
    +          docker run
    +          --interactive
    +          --env DEFAULT_TEST_TARGET
    +          --env GIT_PROVE_OPTS
    +          --env GIT_TEST_OPTS
    +          --env GIT_TEST_CLONE_2GB
    +          --volume "${PWD}:/usr/src/git"
    +          daald/ubuntu32:xenial
    +          /usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
    +        # Use the following command to debug the docker build locally:
    +        # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
    +        # root@container:/# /usr/src/git/ci/run-linux32-build.sh
         - env: Documentation
           os: linux
           compiler: clang
    diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
    index 13c184d41c..f7a3434985 100755
    --- a/ci/run-linux32-build.sh
    +++ b/ci/run-linux32-build.sh
    @@ -1,31 +1,30 @@
     #!/bin/sh
     #
    -# Build and test Git in a docker container running a 32-bit Ubuntu Linux
    +# Build and test Git in a 32-bit environment
     #
     # Usage:
    -#   run-linux32-build.sh [container-image]
    +#   run-linux32-build.sh [host-user-id]
     #

    -CONTAINER="${1:-daald/ubuntu32:xenial}"
    -
    -sudo docker run --interactive --volume "${PWD}:/usr/src/git" "$CONTAINER" \
    -    /bin/bash -c 'linux32 --32bit i386 sh -c "
    -    : update packages &&
    +# Update packages to the latest available versions
    +linux32 --32bit i386 sh -c '
         apt update >/dev/null &&
         apt install -y build-essential libcurl4-openssl-dev libssl-dev \
    -        libexpat-dev gettext python >/dev/null &&
    +        libexpat-dev gettext python >/dev/null
    +' &&
    +
    +# If this script runs inside a docker container, then all commands are
    +# usually executed as root. Consequently, the host user might not be
    +# able to access the test output files.
    +# If a host user id is given, then create a user "ci" with the host user
    +# id to make everything accessible to the host user.
    +HOST_UID=$1 &&
    +CI_USER=$USER &&
    +test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&

    -    : build and test &&
    +# Build and test
    +linux32 --32bit i386 su -m -l $CI_USER -c '
         cd /usr/src/git &&
    -    export DEFAULT_TEST_TARGET='$DEFAULT_TEST_TARGET' &&
    -    export GIT_PROVE_OPTS=\"'"$GIT_PROVE_OPTS"'\" &&
    -    export GIT_TEST_OPTS=\"'"$GIT_TEST_OPTS"'\" &&
    -    export GIT_TEST_CLONE_2GB='$GIT_TEST_CLONE_2GB' &&
         make --jobs=2 &&
    -    make --quiet test || (
    -
    -    : make test-results readable to non-root user on TravisCI &&
    -    test '$TRAVIS' &&
    -    find t/test-results/ -type f -exec chmod o+r {} \; &&
    -    false )
    -"'
    +    make --quiet test
    +'

    \0

 .travis.yml             | 21 +++++++++++++++++++++
 ci/run-linux32-build.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 ci/run-linux32-build.sh

diff --git a/.travis.yml b/.travis.yml
index 9c63c8c3f6..591cc57b80 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,27 @@ env:

 matrix:
   include:
+    - env: Linux32
+      os: linux
+      services:
+        - docker
+      before_install:
+        - docker pull daald/ubuntu32:xenial
+      before_script:
+      script:
+        - >
+          docker run
+          --interactive
+          --env DEFAULT_TEST_TARGET
+          --env GIT_PROVE_OPTS
+          --env GIT_TEST_OPTS
+          --env GIT_TEST_CLONE_2GB
+          --volume "${PWD}:/usr/src/git"
+          daald/ubuntu32:xenial
+          /usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
+        # Use the following command to debug the docker build locally:
+        # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
+        # root@container:/# /usr/src/git/ci/run-linux32-build.sh
     - env: Documentation
       os: linux
       compiler: clang
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
new file mode 100755
index 0000000000..f7a3434985
--- /dev/null
+++ b/ci/run-linux32-build.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Build and test Git in a 32-bit environment
+#
+# Usage:
+#   run-linux32-build.sh [host-user-id]
+#
+
+# Update packages to the latest available versions
+linux32 --32bit i386 sh -c '
+    apt update >/dev/null &&
+    apt install -y build-essential libcurl4-openssl-dev libssl-dev \
+        libexpat-dev gettext python >/dev/null
+' &&
+
+# If this script runs inside a docker container, then all commands are
+# usually executed as root. Consequently, the host user might not be
+# able to access the test output files.
+# If a host user id is given, then create a user "ci" with the host user
+# id to make everything accessible to the host user.
+HOST_UID=$1 &&
+CI_USER=$USER &&
+test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
+
+# Build and test
+linux32 --32bit i386 su -m -l $CI_USER -c '
+    cd /usr/src/git &&
+    make --jobs=2 &&
+    make --quiet test
+'

base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
--
2.11.1

