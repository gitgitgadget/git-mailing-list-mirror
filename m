Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A4C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKXPjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKXPjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D734A591
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b11so1644161pjp.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avf/eaLDZ+faqe4g0/bm3f0HXP2JQxdX0woN8nnI/yE=;
        b=hbQU03AAJNoaV6Wf3tEXjAdU2gBWI4HE/ZKrYPSVJPuuunsjcNQ09tL6PkU8Dojaw/
         GcMhs5zExOMDco2Oj+HT7eV6er12nmUQsU97EdqEthZC30IVeVEk4GqPJY+OhGNkjEvQ
         DcxVyySl3CqeR82+p3Izk9VEdky55gST2zXkz78ExKVAiLQQib4ffh3QerNv9s5oXFfm
         Trza3tNwzh+h0rEYDrY/Tukis7HeGskj6jPefrZKdC4WXfvhL/TyzSw6QtYas24fZIpg
         0WlhH4k3PJxtNTONzwGhU6Fcg0Ed8zI2zIH+hdhwg/a/4ENA/03coQdvhzGMG5uxOJh4
         q02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avf/eaLDZ+faqe4g0/bm3f0HXP2JQxdX0woN8nnI/yE=;
        b=xwwaUpd2B4dAJxg1nNWndXkXBIW9n9LmshqiLxahS72idrRNCzNiGN17CfrbgWU4Mp
         NvnfYZ7qkCGrS8LkW1o77kDAp37D7dX6l6arh6DYwX1wm7RJaL9oTHPmGVFkVPkFZNor
         IQVRIxx2UFRqDfAAq0MXmVQbBBEPlVmKVW5m3nEgR25AWaXeT3H88mqqoB01eIEwfZAV
         Vq3bmC0WvpCJ3mC1tnH2p9Mar3P6+dEHLmKAcCm/ZkSFP7UH1peA2SMGl0gPTbnPApeL
         Pu6xoLvixdqo9Ssn7i4CCL0tIZHIoTH+8EZ3yQN5mU7WtykD5HFWIIi4oVwBxF0BkU6h
         jyZg==
X-Gm-Message-State: ANoB5pnGjWTUk/w3sJwCXu1GvKTjfE2x12r+JueB+2Z08Qc+CCZWOA5H
        cXCCan9IwF3zx0bwgY4DMxbYAmUYAbM=
X-Google-Smtp-Source: AA0mqf6biK7htWFRB5QCILsga3xkqoH8IO50RSWEr/F+9PCRmiRe3y8b3D9atOSw78jjRIAje9jVCw==
X-Received: by 2002:a17:902:ec01:b0:186:878e:3b0d with SMTP id l1-20020a170902ec0100b00186878e3b0dmr14006670pld.149.1669304379143;
        Thu, 24 Nov 2022 07:39:39 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm1413089pln.292.2022.11.24.07.39.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:39:38 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/4] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Thu, 24 Nov 2022 23:39:31 +0800
Message-Id: <20221124153934.12470-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
References: <20221124090545.4790-1-worldhello.net@gmail.com>
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

In this way, we can change the "ubuntu-latest" runner image to any
version such as "ubuntu-22.04" to test CI behavior in advance.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
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

