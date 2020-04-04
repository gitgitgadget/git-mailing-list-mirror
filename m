Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F345FC2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C975F2074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkdbqytD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDDBJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:09:09 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:35165 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgDDBJI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:09:08 -0400
Received: by mail-pj1-f49.google.com with SMTP id g9so3824617pjp.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZsbfhHg1d/pKYF4FSc/InjvjWMthEBndeltLqsIzSE=;
        b=IkdbqytDzCvPQWUQ18ddQNeNhOv/zbF3+4ThgULsEO7dLldTmDQtf/Ur4Nh5jD73d6
         9tUmtzNbA3hzoOxD6HpTY7OVmJoBtqo7TW1yYrnlVGw7cAQ8BOceB1MvdYAk/L7zUONk
         bYWyUUaTcvbM4RhUwpWyUzf+cMRq1QTJIwS9DYPyKuTOAB2kGzb48O+vaaFQW0hfHDi3
         DMQ2keRT5+2Yzb8dViO5S+DwkKXYA4JhPaTbu9j3Oor5UfPah2Jpj+DCTUD7M9JdOXZD
         V+gsStjXcxGxBDZJXvKpLTdcLLbTEiqkq0l5npWjkAp3V7Tv0CAAGePqh7iJVE/pMbzM
         fIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZsbfhHg1d/pKYF4FSc/InjvjWMthEBndeltLqsIzSE=;
        b=Z+igc7tLjMAxpJqX4pbJThxflw97cUvD8O5pUgsl3JdjZ/ig+xAPYi83KmOZ/zP8Q7
         AOkb4NdLQxr4iVjuRv0qo3i0m9rGySZT63y7M9bkjP8J2tJ+8+TcHWJldvJHfu7/e9Kn
         DCvKsYp1LwzXWlSRHLohkaZa3hCjD7DuHDBotevmyrEeqGQh3o3Sum7Z9ayBSsjNdtNI
         1RqMssMR2Aa5oD4pn2dqRCTMDTdFrPsIGc0eqRIX2hbak350E8kHPtdj/C/5sh7dx8fe
         GM/NttVBhyY/E+W5fDhBScoKLeTRbCry3+YYGUFJIFoXOsRmV9I+mM43BKEAcEf35LLd
         3+Vw==
X-Gm-Message-State: AGi0PubtCxE8ADPZCVbZmq71gC8y/SIJctDfKFcv88g3i2Q0ZTY4GCFU
        vweO3mfzyQ0Z0YTtmv7mli1qlEpJ
X-Google-Smtp-Source: APiQypLSbhpp9pCekmzkMVYOzEN2bWGV9x9dP4SKgcy/Nw8vcM0nFQrBQvSHnWZqHJajzaGsvMii7Q==
X-Received: by 2002:a17:90a:8c1:: with SMTP id 1mr13510738pjn.77.1585962545708;
        Fri, 03 Apr 2020 18:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o12sm6664319pjt.16.2020.04.03.18.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:09:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 4/6] ci: refactor docker runner script
Date:   Sat,  4 Apr 2020 08:08:48 +0700
Message-Id: <b5de868c1e354153bec78d892e13a6faf03c4f31.1585961568.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585961568.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585961568.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will support alpine check in docker later in this series.

While we're at it, tell people to run as root in podman,
if podman is used as drop-in replacement for docker,
because podman will map host-user to container's root,
therefore, mapping their permission.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml                                   |  2 +-
 azure-pipelines.yml                           |  4 ++--
 ...n-linux32-build.sh => run-docker-build.sh} |  6 ++---
 ci/{run-linux32-docker.sh => run-docker.sh}   | 22 ++++++++++++++-----
 4 files changed, 22 insertions(+), 12 deletions(-)
 rename ci/{run-linux32-build.sh => run-docker-build.sh} (93%)
 rename ci/{run-linux32-docker.sh => run-docker.sh} (53%)

diff --git a/.travis.yml b/.travis.yml
index fc5730b085..069aeeff3c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,7 @@ matrix:
       services:
         - docker
       before_install:
-      script: ci/run-linux32-docker.sh
+      script: ci/run-docker.sh
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 675c3a43c9..11413f66f8 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -489,14 +489,14 @@ jobs:
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
 
        res=0
-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
 
        sudo chmod a+r t/out/TEST-*.xml
        test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
 
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
        exit $res
-    displayName: 'ci/run-linux32-docker.sh'
+    displayName: 'jobname=Linux32 ci/run-docker.sh'
     env:
       GITFILESHAREPWD: $(gitfileshare.pwd)
   - task: PublishTestResults@2
diff --git a/ci/run-linux32-build.sh b/ci/run-docker-build.sh
similarity index 93%
rename from ci/run-linux32-build.sh
rename to ci/run-docker-build.sh
index 44bb332f64..a05b48c559 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-docker-build.sh
@@ -1,16 +1,16 @@
 #!/bin/sh
 #
-# Build and test Git in a 32-bit environment
+# Build and test Git inside container
 #
 # Usage:
-#   run-linux32-build.sh <host-user-id>
+#   run-docker-build.sh <host-user-id>
 #
 
 set -ex
 
 if test $# -ne 1 || test -z "$1"
 then
-	echo >&2 "usage: run-linux32-build.sh <host-user-id>"
+	echo >&2 "usage: run-docker-build.sh <host-user-id>"
 	exit 1
 fi
 
diff --git a/ci/run-linux32-docker.sh b/ci/run-docker.sh
similarity index 53%
rename from ci/run-linux32-docker.sh
rename to ci/run-docker.sh
index 54186b6aa7..3881f99b53 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-docker.sh
@@ -1,16 +1,26 @@
 #!/bin/sh
 #
-# Download and run Docker image to build and test 32-bit Git
+# Download and run Docker image to build and test Git
 #
 
 . ${0%/*}/lib.sh
 
-docker pull daald/ubuntu32:xenial
+case "$jobname" in
+Linux32)
+	CI_CONTAINER="daald/ubuntu32:xenial"
+	;;
+*)
+	exit 1
+	;;
+esac
+
+docker pull "$CI_CONTAINER"
 
 # Use the following command to debug the docker build locally:
-# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
+# <host-user-id> must be 0 if podman is used as drop-in replacement for docker
+# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
 # root@container:/# export jobname=<jobname>
-# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
+# root@container:/# /usr/src/git/ci/run-docker-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
 
@@ -26,8 +36,8 @@ docker run \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-	daald/ubuntu32:xenial \
-	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
+	"$CI_CONTAINER" \
+	/usr/src/git/ci/run-docker-build.sh $(id -u $USER)
 
 check_unignored_build_artifacts
 
-- 
2.26.0.334.g6536db25bb

