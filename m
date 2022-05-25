Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6471C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiEYKFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiEYKFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F276D965
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so29405000wra.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=geuTPMRLF/iDT2MlysZcLrWTlwVSkSOnoLSL9MP8SkQ=;
        b=l8g4L9rfiZNeeuOiir+tmJYnW+OGdC7NwaHWQ8XF2x86ZjUyxsNP8F1tTXs1hxiBOC
         O+jv4D5JNgGPsX1lfvqNZwLdnaHd5FLW59qnfnDDPuzO7jSgWu3GBkkNKHgTd5sxOJBW
         vqWvCMInpZZUEL4G/Yd+GCRY8NVNXeqYtMxeJZBc286gQmuQrvQAvIZ+64d2nfF2iO/z
         Hx5twKllKQIeSKaTXuIZWr390Aq46v9C9eU6XkkXP6P3eJPs/+xflGfMDXB44u1/e7Pm
         kFIq2X3GXoM/O3nhYW0Hkvx2+aaCQT6b/E3Gg5rDoVHbhvSDAj+omHivG5Uec1hsVCPJ
         /0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=geuTPMRLF/iDT2MlysZcLrWTlwVSkSOnoLSL9MP8SkQ=;
        b=3i+Kd1uUiF0fuYVAp1zRmAcTn9VOXIUvIf5DmHDBfxnP3l0tHu5O5gIERtKoqdWwb6
         Q5ki+Uw5zuyZKz+Ychmly7j7PGzWloZwZRPRhl9d91zjlJwlLT7yUvpeU3L4Q8Vc0OTT
         y6wUNAbihdDQ3Vay1xgH0jsGyVplcg74T544JvkRzfUNG/3LJ2d1KumJ+F0X4UWuFv5X
         qb8QfjZgF29xyeGVDHg5nCqBe6JOcIJNR+WL9oDQJCQCIO0YfYv1eofrUKOt1enwLxlt
         qxkyIticOGxMwOmA8ynzqskK8qgWLMHXSwIc7D8wE/vHsTzuwCvGSApC2uYbrds7f62B
         RXvQ==
X-Gm-Message-State: AOAM532FHvvl9pI2KLM2iaUCl9I+4ziuee5FIwaBwvvNbLRrko68C9TJ
        sTuYZIAwnmjzzglYJldoCHfMienR4TRgEg==
X-Google-Smtp-Source: ABdhPJz9AF/fa6+hpBZT4Q6c5qF3roNy/8Mk0FTMiXS/2oXE3LF5/T7gJEUbMJmeFf9BG/5UJ8sUOQ==
X-Received: by 2002:a05:6000:1621:b0:20f:f723:ec49 with SMTP id v1-20020a056000162100b0020ff723ec49mr5210872wrb.284.1653473108201;
        Wed, 25 May 2022 03:05:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 25/29] CI: set CC in MAKEFLAGS directly, don't add it to the environment
Date:   Wed, 25 May 2022 12:04:04 +0200
Message-Id: <patch-v6-25.29-377460e8024-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than pass a "$CC" in the environment to be picked up in
ci/lib.sh let's instead have ci/lib.sh itself add it directly to
MAKEFLAGS. For "$CC_PACKAGE" its setting and use can stay within
ci/install-dependencies.sh.

Setting CC=gcc by default made for confusing trace output, and since a
preceding change to carry it and others over across "steps" in the
GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
confusingly has CC=gcc set, even though it builds with MSVC.

Let's instead rely on the Makefile default of CC=cc, and only override
it for those jobs where it's needed. This does mean that we'll need to
set it for the "pedantic" job, which previously relied on the default
CC=gcc in case "clang" become the default on that platform.

This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23), i.e. we're now
aiming to only set those variables specific jobs need.

Since we don't need to make this generic enough to handle "gcc-9"
turning into "gcc@9" for "brew install" let's remove what was
originally a bash-specific replacement in 707d2f2fe86 (CI: use
"$runs_on_pool", not "$jobname" to select packages & config,
2021-11-23), and which a preceding commit changed to a "tr"
invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 13 -------------
 ci/install-dependencies.sh | 18 ++++++++++++++----
 ci/lib.sh                  | 23 ++++++++++++++++++++---
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index bb62b4ff725..6835e942280 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -238,37 +238,24 @@ jobs:
       matrix:
         vector:
           - jobname: linux-clang
-            cc: clang
             pool: ubuntu-latest
           - jobname: linux-sha256
-            cc: clang
             os: ubuntu
             pool: ubuntu-latest
           - jobname: linux-gcc
-            cc: gcc
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: linux-TEST-vars
-            cc: gcc
             os: ubuntu
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
-            cc: clang
             pool: macos-latest
           - jobname: osx-gcc
-            cc: gcc
-            cc_package: gcc-9
             pool: macos-latest
           - jobname: linux-gcc-default
-            cc: gcc
             pool: ubuntu-latest
           - jobname: linux-leaks
-            cc: gcc
             pool: ubuntu-latest
     env:
-      CC: ${{matrix.vector.cc}}
-      CC_PACKAGE: ${{matrix.vector.cc_package}}
       jobname: ${{matrix.vector.jobname}}
       runs_on_pool: ${{matrix.vector.pool}}
     runs-on: ${{matrix.vector.pool}}
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 9ee52769cbe..b2be92f4370 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,6 +9,17 @@ UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
+CC_PACKAGE=
+BREW_CC_PACKAGE=
+case "$jobname" in
+linux-gcc | linux-TEST-vars)
+	CC_PACKAGE=gcc-8
+	;;
+osx-gcc)
+	BREW_CC_PACKAGE=gcc@9
+	;;
+esac
+
 case "$runs_on_pool" in
 ubuntu-latest)
 	# The Linux build installs the defined dependency versions below.
@@ -69,11 +80,10 @@ macos-latest)
 	PATH="$PATH:${HOME}/bin"
 	export PATH
 
-	if test -n "$CC_PACKAGE"
+	if test -n "$BREW_CC_PACKAGE"
 	then
-		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
-		brew install "$BREW_PACKAGE"
-		brew link "$BREW_PACKAGE"
+		brew install "$BREW_CC_PACKAGE"
+		brew link "$BREW_CC_PACKAGE"
 	fi
 	;;
 esac
diff --git a/ci/lib.sh b/ci/lib.sh
index 16bac966d76..8d19ca5ced8 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ setenv () {
 	fi
 }
 
+# Clear variables that may come from the outside world.
+CC=
+
 # How many jobs to run in parallel?
 NPROC=10
 
@@ -98,8 +101,6 @@ MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
 
 case "$CI_TYPE" in
 github-actions)
-	CC="${CC_PACKAGE:-${CC:-gcc}}"
-
 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
 	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
@@ -171,9 +172,14 @@ vs-test)
 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 linux-gcc)
+	CC=gcc
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
 	;;
+linux-gcc-default)
+	CC=gcc
+	;;
 linux-TEST-vars)
+	CC=gcc
 	setenv --test GIT_TEST_SPLIT_INDEX yes
 	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
 	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
@@ -188,13 +194,22 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
+osx-gcc)
+	CC=gcc
+	;;
+osx-clang)
+	CC=clang
+	;;
 linux-clang)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha1
 	;;
 linux-sha256)
+	CC=clang
 	setenv --test GIT_TEST_DEFAULT_HASH sha256
 	;;
 pedantic)
+	CC=gcc
 	# Don't run the tests; we only care about whether Git can be
 	# built.
 	setenv --build DEVOPTS pedantic
@@ -209,9 +224,11 @@ linux-musl)
 	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
 	;;
 linux-leaks)
+	CC=gcc
 	setenv --build SANITIZE leak
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
 
-setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+MAKEFLAGS="$MAKEFLAGS${CC:+ CC=$CC}"
+setenv --build MAKEFLAGS "$MAKEFLAGS"
-- 
2.36.1.1045.gf356b5617dd

