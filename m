Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC2C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22A9608FB
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhIPD5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 23:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhIPD5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 23:57:52 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85244C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 20:56:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a10so5984334qka.12
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bn0awdTOTMN7Ha8rBFBqMN1Nyyp/BXrH9xuCHOGTc8U=;
        b=abcCeQq7KNG2aPj5nc5wiqwvM9Vt8NHipWqhcw9N5DJ9+aGXaBd/ToPVEV5hJR/el3
         uUaWSfliggmG1OJcluGO+D/EH2ADdgM99eJvWUjW/Br6xMnSC80HNCT3bMHo6P6nT+em
         H2JUenjlAZrVos9/F1BgK0Ap9JpA8UWWOIECOG3P6GQ43iu5bkcToqICQSi/K0c/e3Bu
         P1FiNazhbfDZlRJ+HPYDGXIPb2xRDQqaH/wqlkEUSCs48/rkwV0LTmnZ/cQOKjlTteB3
         csZBtVQScdK63wPDotCciVwJtw0XHSVt7Bz4nqb+/BkK5UdN228hRQunSSIgkr3sa8Eb
         yt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bn0awdTOTMN7Ha8rBFBqMN1Nyyp/BXrH9xuCHOGTc8U=;
        b=ebeG3Goh/ddl6B9nnauiz2faP50sxZ0R+UY0mgq2Mjg86ELw2Z8JMTElL8ZZofjdRn
         FSO9qVTWTOCNP3rHDHFyGkwLRaPFrPoB7c3MmxduxIj0OkDCxrWhR9UQLki+zTytjL9o
         /l92x+qAfag2BkTPwqdV4N3Nncina3cnMNsEETgoUWf80zlKfWw/ApqRByZ7cEx2GTzd
         EQF/MCPaSIqWICZowR49bRPRAyMmSWvqhdBT9IpxwJMp26NvM31NsoVsW8Q2laAX+g2K
         /mWHmt5hxFzx3oe7yljJupBlFnAeQZBSBZ1iTRXMl+TtHh4WTqMOQGG3xNUgneiGMMVZ
         MLIg==
X-Gm-Message-State: AOAM532A5vFAP2WvwtTZSzT08FXQKrQBSWpDKa+7SQMfQWXm5DM8vRAl
        2p8K7S6je8hwgvHVA+zuEVuA3XNa+oA=
X-Google-Smtp-Source: ABdhPJyesc+D4f4xbEC0/xwjDXTgmHBqNuvO5WaR4mdbTjdLRU/m0/Kqu9FhQBAYk/tS80keApk/yQ==
X-Received: by 2002:a05:620a:159a:: with SMTP id d26mr3292701qkk.399.1631764591475;
        Wed, 15 Sep 2021 20:56:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w20sm1370774qtj.72.2021.09.15.20.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 20:56:31 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! tests: add a test mode for SANITIZE=leak, run it in CI
Date:   Wed, 15 Sep 2021 20:56:03 -0700
Message-Id: <20210916035603.76369-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
References: <patch-v5-3.3-f3cd04b16d1-20210907T212626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the standard gcc in Linux, instead of the older version

Remove the osx-leaks job; neither clang or gcc support it and won't
until clang 14 is released.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .github/workflows/main.yml | 3 ---
 ci/install-dependencies.sh | 4 ++--
 ci/lib.sh                  | 8 ++++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7c273147a0..59acc35d37 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -234,9 +234,6 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
-          - jobname: osx-leaks
-            cc: gcc
-            pool: macos-latest
     env:
       CC: ${{matrix.vector.cc}}
       jobname: ${{matrix.vector.jobname}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index bb88afd369..1d0e48f451 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -18,7 +18,7 @@ linux-clang|linux-gcc|linux-leaks)
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS
 	case "$jobname" in
-	linux-gcc|linux-leaks)
+	linux-gcc)
 		sudo apt-get -q -y install gcc-8
 		;;
 	esac
@@ -37,7 +37,7 @@ linux-clang|linux-gcc|linux-leaks)
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
 	;;
-osx-clang|osx-gcc|osx-leaks)
+osx-clang|osx-gcc)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
diff --git a/ci/lib.sh b/ci/lib.sh
index cf62f786a3..36f594751d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -185,7 +185,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 case "$jobname" in
 linux-clang|linux-gcc|linux-leaks)
 	case "$jobname" in
-	linux-gcc|linux-leaks)
+	linux-gcc)
 		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 		;;
@@ -208,9 +208,9 @@ linux-clang|linux-gcc|linux-leaks)
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
-osx-clang|osx-gcc|osx-leaks)
+osx-clang|osx-gcc)
 	case "$jobname" in
-	osx-gcc|osx-leaks)
+	osx-gcc)
 		export CC=gcc-9
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 		;;
@@ -239,7 +239,7 @@ linux-musl)
 esac
 
 case "$jobname" in
-linux-leaks|osx-leaks)
+*-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	;;
-- 
2.33.0.481.g26d3bed244

