Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34BC2D0E8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9577206F8
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmjSXJI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCZHfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:35:48 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:36534 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCZHfr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:35:47 -0400
Received: by mail-pf1-f173.google.com with SMTP id i13so2358877pfe.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDdQ9X5EqB5qJyPwsDerek/uo5jgzzuWWCUHTNiXobs=;
        b=dmjSXJI3LVU5aZl6YvBbVehzV/Y3BGkZpNYF9uaNqIu46wh9JxkNOx6P6jO7gsSi1e
         3HVcIStY9E/rtEVf9xEOWlr6yJ+upIY5+qDHj3Iu729hkaMmId6U0Dj2pLJHHqpQ64t9
         jEYjIrFcF/BN8yavZIctS06Xy7dTF9QosVW3dltbTVe4VERTdtp7ondHxIKzbziwKR2D
         WkRLKzk5zBn7UQ3SVyOPBHKUxFtG8w27niTCNJiF7Q9OmWNYAWp7D1oTSFYNhKUUCs4W
         FroX7LhoIhXWcihOp4YXF4bAd55UdmlfbQ9QY/0j8TZaCp96HaS1J8h1HS4SQo0DjqGA
         Tung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDdQ9X5EqB5qJyPwsDerek/uo5jgzzuWWCUHTNiXobs=;
        b=bS4i6L7A8GxgO8NuXbDwaFqqdvHTmrA00yWhIFkr7TQax7OrkAat3CfYaBb18aLyms
         A2xDtOLKCdjo8Z+L9d5hrxGNh1BY1Nuyx5e6S02HwrE/gshe8XzCOboO7BEu4C8reCcp
         QByT4Cmg8hrYHI0r13K3jkJRBdVwZSkfn43oO5k4iGk5Un9X7OLM978/+tq+vT0Fm7OR
         1d0trbYjOV656uW0Vh8yGJHF0NAJcCdfPeN4MALtOcWRbqM5bo7Mi0Gs12NdkZNah9T1
         z61RrpXj+IpuVSdgQ0GaFNwGhJQTMWXSQnsJq/B0J7m/YXRfkiEwdCh+vD63FXTplIiL
         xhdg==
X-Gm-Message-State: ANhLgQ2SQE7MRI7G6wsyHxhjAOd/ULUwn+AcIqC382cljMV9IYtcbIEc
        MCHdhCzomAaYupGjq/tsYESiioiT
X-Google-Smtp-Source: ADFU+vuGU470tjYRzdv3ah58A+LlbhKx9i+a0Uh98mvsvdy5EBQW3Fe5IkH6joOfqKlzJhBUS5NsjQ==
X-Received: by 2002:a63:78e:: with SMTP id 136mr6927512pgh.181.1585208145828;
        Thu, 26 Mar 2020 00:35:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id d188sm968049pfa.7.2020.03.26.00.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 00:35:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/3] ci: refactor docker runner script
Date:   Thu, 26 Mar 2020 14:35:18 +0700
Message-Id: <2fada3db3d0c802b45551671dcb75e406e3ed2b6.1585203294.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585203294.git.congdanhqx@gmail.com>
References: <cover.1585203294.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will support alpine check in docker later in this serie.

While we're at it, tell people to run as root in podman.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .travis.yml                                 |  2 +-
 azure-pipelines.yml                         |  4 ++--
 ci/{run-linux32-docker.sh => run-docker.sh} | 19 +++++++++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)
 rename ci/{run-linux32-docker.sh => run-docker.sh} (48%)

diff --git a/.travis.yml b/.travis.yml
index fc5730b085..32e80e2670 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,7 @@ matrix:
       services:
         - docker
       before_install:
-      script: ci/run-linux32-docker.sh
+      script: ci/run-docker.sh linux32
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 675c3a43c9..ef504ff29f 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -489,14 +489,14 @@ jobs:
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
 
        res=0
-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-docker.sh linux32 || res=1
 
        sudo chmod a+r t/out/TEST-*.xml
        test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
 
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
        exit $res
-    displayName: 'ci/run-linux32-docker.sh'
+    displayName: 'ci/run-docker.sh linux32'
     env:
       GITFILESHAREPWD: $(gitfileshare.pwd)
   - task: PublishTestResults@2
diff --git a/ci/run-linux32-docker.sh b/ci/run-docker.sh
similarity index 48%
rename from ci/run-linux32-docker.sh
rename to ci/run-docker.sh
index 751acfcf8a..c8dff9d41a 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-docker.sh
@@ -1,15 +1,22 @@
 #!/bin/sh
 #
-# Download and run Docker image to build and test 32-bit Git
+# Download and run Docker image to build and test git
 #
 
 . ${0%/*}/lib.sh
 
-docker pull daald/ubuntu32:xenial
+CI_TARGET=${1:-linux32}
+case "$CI_TARGET" in
+linux32) CI_CONTAINER="daald/ubuntu32:xenial" ;;
+*)       exit 1 ;;
+esac
+
+docker pull "$CI_CONTAINER"
 
 # Use the following command to debug the docker build locally:
-# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
-# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
+# <host-user-id> must be 0 if podman is used in place of docker
+# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/sh "$CI_CONTAINER"
+# root@container:/# /usr/src/git/ci/run-$CI_TARGET-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
 
@@ -23,8 +30,8 @@ docker run \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-	daald/ubuntu32:xenial \
-	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
+	"$CI_CONTAINER" \
+	"/usr/src/git/ci/run-$CI_TARGET-build.sh" $(id -u $USER)
 
 check_unignored_build_artifacts
 
-- 
2.26.0.rc2.357.g1e1ba0441d

