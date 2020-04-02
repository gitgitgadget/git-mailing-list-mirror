Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B17C2D0F3
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87306206F5
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUxSjGul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbgDBNEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:45 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39839 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbgDBNEo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:44 -0400
Received: by mail-pj1-f52.google.com with SMTP id z3so1477602pjr.4
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZsbfhHg1d/pKYF4FSc/InjvjWMthEBndeltLqsIzSE=;
        b=EUxSjGulJmWeAUo7HqOiJeioDGobUJlJ8ZssBxQppJeGP3b1dz4pCTZDReze29Ef+c
         TElFrqRi/5o0g6x8LOTgz0CYmKv1oczlbzBy+KAesU5cUcuwXkjKzvnQbYnUv4+Q2ZlT
         u+GoD+mk/C4yiV6nSw02Aohi0MAXIcpI58mRj3G0dpMRZSJF0S200WFkkJPV7OXn4cKH
         tjY44xev/pMkviUP+e3njNu1mLKV/5gK0jozbhBDNj3c6tzH2q+p3tZoWsZQxuPJgjIk
         4NwI7uqQLB+DyRGlRAwKIr0DUPPWeBscqh7UTO/Jmoi2vXxGBqMcdxtwKjVYDN2fw5Jp
         iZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZsbfhHg1d/pKYF4FSc/InjvjWMthEBndeltLqsIzSE=;
        b=AQwtxrjrWFGbE30OhcIjy9QwyBezXVyVc0dYFGLmnuuQV5hyfj6aBfkDU+u9BowO1U
         5ad7HqBZU1vFheck0w/btHbyKuY7gl6PQ4uzNvMvBq85eI/F5kPlRUt6VSGtlNvCasmk
         wgGNGrqamcIIG97Alor1l/OOCDz//utkhurWBPToKyrFscl1sCP8R+KAYlrKUHSJEOzd
         vEbzlYI7di2hwgowS/urH3DKvimmRDhGfCcB3akwbkPneEeOeFmJXM7VY7GtvzxBGMyd
         Uy0w9itE34L+koFbgyD/t8gvWCc/BWEN9V+rHAjRs4KJNDevwJhx026Wx7OYtWQ0oX8o
         0JTA==
X-Gm-Message-State: AGi0PuZjJgtWvaWvmb49Xcp8ojWBuzUyBUpQD2UCgD/S4m1dlN8gZlC8
        wb2t9uJz+oiCbINC8SxPpB/47FJ6
X-Google-Smtp-Source: APiQypIjZS3S3Oz8ANKSShhhH4Idg5P/9s2ranLZiAqEv9+3mRwxkw98NsYpEJjkIUVxqKHEXUbM5g==
X-Received: by 2002:a17:902:164:: with SMTP id 91mr2791473plb.207.1585832682862;
        Thu, 02 Apr 2020 06:04:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:42 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 4/6] ci: refactor docker runner script
Date:   Thu,  2 Apr 2020 20:04:03 +0700
Message-Id: <22cc7960c3a3a74ad3cd8e7e9ea36d3952249702.1585832270.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585832270.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com> <cover.1585832270.git.congdanhqx@gmail.com>
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

