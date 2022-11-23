Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32857C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 15:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiKWPDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiKWPCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 10:02:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9004E415
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y10so15697831plp.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cK9hYmHVVuOFM+fWUibo0z2hoi6jbpVyFvkmAjahQI=;
        b=ZvsF9bgUd9wv5p3Uqs1O/U6/Kyd3aVKu4T3vcixyDW7zpBxdOUzV/VslqdlWmjlusT
         4PuTu+K+CMEeUhNZhX9T++o2GOYisZDq8h5WfyWDMELbqqTjAKwCMDsQt5Kg/BnaI9fy
         Bgu8GXgA9ysf0l1e3vjPunuHgoR4+jjB9ckPayGO4dXFLFvRj3ls98EQkSOafTz1EeZr
         6sm1gGFQMpbGAeIBFZrgKIwb0W2QsBDz6d/ObXQcsgBCCXqts6kHg9cHhNk6emzDu069
         iGN1JCIk1ISqwbvx04bWEWE7hz64VGmJ29RBnjL6SSizAKoHPWMsKgAaZiujmSfcrLh2
         CwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cK9hYmHVVuOFM+fWUibo0z2hoi6jbpVyFvkmAjahQI=;
        b=JD2gjq/l9z84X/zTLPKB8md4yuAfDWsbE1iPAzW84XioCVyfMSD7ITt2WNI2thvGnn
         X+PEGPsUIau0EDIH33vEB+mk8enZHT4/nDCg/WMWWqdgQ4GzdSIqp1sPy2p5Llh9JOfW
         X4ZNDa9+M7oHWhYp1V1thgY8du9owhz0GZft9BFV3WQ06SNqQJRjzftrbyq3KWl/FNbY
         Kff0fmmEgPezkeXHejke3kzqZk1CTb93oLItIndmvyhqV5E/LLuJLgu0SarxNC+g5fU6
         SxHCdRD0B6d18hW8IERxknCRgLz+3KvWgCujXB487FjvyTQCbCLYqO1P2RPFfvqxK9ku
         xNzQ==
X-Gm-Message-State: ANoB5pl0RHMZM2gUGBQkAFV9+sE7dJt7OZw5rcwI3NURiOLTizkZALzW
        ZPhVbJ/UsAM9lDTD2ZCmzfnEa4qjHkY=
X-Google-Smtp-Source: AA0mqf42NOs8s+RW2xwQbeX2lpv1NqrlV4brRj34oaNyfJfr75MAxa9CYR+Y4iginNCzz5Ev9gb9Ig==
X-Received: by 2002:a17:902:e492:b0:17f:72c3:8922 with SMTP id i18-20020a170902e49200b0017f72c38922mr9732848ple.167.1669215757691;
        Wed, 23 Nov 2022 07:02:37 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y185-20020a6232c2000000b0056ddd2b5e9bsm12783263pfy.41.2022.11.23.07.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:02:37 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/2] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Wed, 23 Nov 2022 23:02:32 +0800
Message-Id: <20221123150233.13039-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

GitHub starts to upgrade its runner image "ubuntu-latest" from version
"ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
install "gcc-8" package on the new runner image.

Change the runner images from "ubuntu-latest" to "ubuntu-20.04" in order
to run with "gcc-8" as a dependency.

Instead of use the environment "$runs_on_pool" as below:

    case "$runs_on_pool" in
    ubuntu-20.04 | ubuntu-latest)
	;;

we can reuse the os field in the matrix, and use a new environment
"$runs_on_os" as below:

    case "$runs_on_os" in
    ubuntu)
        ;;

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .github/workflows/main.yml | 16 ++++++++++++----
 ci/install-dependencies.sh |  6 +++---
 ci/lib.sh                  |  6 +++---
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 592f9193a8..da0d8ab0bf 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -224,6 +224,7 @@ jobs:
         vector:
           - jobname: linux-clang
             cc: clang
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-sha256
             cc: clang
@@ -232,36 +233,43 @@ jobs:
           - jobname: linux-gcc
             cc: gcc
             cc_package: gcc-8
-            pool: ubuntu-latest
+            os: ubuntu
+            pool: ubuntu-20.04
           - jobname: linux-TEST-vars
             cc: gcc
-            os: ubuntu
             cc_package: gcc-8
-            pool: ubuntu-latest
+            os: ubuntu
+            pool: ubuntu-20.04
           - jobname: osx-clang
             cc: clang
+            os: macos
             pool: macos-latest
           - jobname: osx-gcc
             cc: gcc
             cc_package: gcc-9
+            os: macos
             pool: macos-latest
           - jobname: linux-gcc-default
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-leaks
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-asan
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-ubsan
             cc: gcc
+            os: ubuntu
             pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
-      runs_on_pool: ${{matrix.vector.pool}}
+      runs_on_os: ${{matrix.vector.os}}
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v2
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 107757a1fe..f639263a62 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -11,8 +11,8 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
-case "$runs_on_pool" in
-ubuntu-latest)
+case "$runs_on_os" in
+ubuntu)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
@@ -30,7 +30,7 @@ ubuntu-latest)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-macos-latest)
+macos)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib.sh b/ci/lib.sh
index 24d20a5d64..0c0767d354 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -225,8 +225,8 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
-case "$runs_on_pool" in
-ubuntu-latest)
+case "$runs_on_os" in
+ubuntu)
 	if test "$jobname" = "linux-gcc-default"
 	then
 		break
@@ -253,7 +253,7 @@ ubuntu-latest)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-macos-latest)
+macos)
 	if [ "$jobname" = osx-gcc ]
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-- 
2.39.0.rc0

