Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EEC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiKXJGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKXJFv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:05:51 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E210FEEC
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so1099155pfu.8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roKzEtt64xogp5SrDegHycn5LX+ehj2r6dRzkZZoxxw=;
        b=pTY8V9iFzGHeF/BGhE8DGR7pc5QASLERHdmpKfKS5TrigUkxM41JsIwMei0hAN/hrz
         upMKvX4gdrmtb3WzBzgNhA31FJsVs74WPB3qFwP4nIuWHGqSYdjddOLMheiTVbVIvXEU
         a+Zk150bX/E8oIHcpoUZKfzkXBLoqc+Tf88X16ayay/WKnhLUChLWUkqVF2fzeGGgtI1
         109uFeKULtLn8H02bPGBmb0DGdwR0J87oarmEJL59Rl90OZ+rsGmL1kK/RKEdF9hh+CZ
         TPb96gXlRPmoNxsS2ItFme87i6h273FBXtLYpScAQDSw+Jgq1yXbBiZwqipoB9pW/7k1
         GAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roKzEtt64xogp5SrDegHycn5LX+ehj2r6dRzkZZoxxw=;
        b=wHSLXPgMZ3fCP1pxUE9cok8HA44LjCETue/8px52y6DzO0dXILS317Cm9M60HzOrzO
         zkVvpbYxyX6YfOBbeybS10RS93z+/DdG4EnYMs5rUhTnlk4mtgjup+/XFDksKKuKib5T
         saLnwwQgAAaaCGbeJpVvEagg2pdMIhbgRduZ9CbK6g0xKo5r4Z/iF7rtIIB/mvEqZ/s0
         JcNeTc8HXR1hJsysgy4uDRsWvvW/FO1i+WK58xKJIMtmzw0ndg+oe0HP4VouUik0k3+Y
         RYzLySIS5mtS0XLNnn66ddahcGV1V1EJraMqXPK7VdC5rOTddvhJSZry30kF1W3yQCF9
         565Q==
X-Gm-Message-State: ANoB5pmdy45lBmFtdSKrzPMc/1b9u8Qz3nYhyo5vFHjEozBS4P5Yqh1Z
        71jUwXJV/Rn6f3DzAI2tWiqRtNJ2XKc=
X-Google-Smtp-Source: AA0mqf4r3JyyN7408zZrAw5jurBE+1D1yrDxd+PQFAYUYugbw0OZRuj1szxIkNZSspKmK8ltpE/NNw==
X-Received: by 2002:a63:e44:0:b0:475:2f61:bbc3 with SMTP id 4-20020a630e44000000b004752f61bbc3mr12866630pgo.435.1669280750306;
        Thu, 24 Nov 2022 01:05:50 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001893dbd8963sm689356plg.239.2022.11.24.01.05.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:05:49 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/3] github-actions: run gcc-8 on ubuntu-20.04 image
Date:   Thu, 24 Nov 2022 17:05:43 +0800
Message-Id: <20221124090545.4790-2-worldhello.net@gmail.com>
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

In this way, we can change the "ubuntu-latest" runner image to any
version such as "ubuntu-22.04" to test CI behavior in advance.

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

