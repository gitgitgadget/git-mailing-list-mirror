Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB23C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiDMTzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiDMTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04B78917
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so4119089wrr.9
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bRnEfBrn6ZL38hGLbyN7ReuRiuXEP9h79QAJEf8/Ik=;
        b=XgCpTl3txT2OTf82zAgGJwboL1CoIGKQt5gVy/9PkDpfLgxs27uXh901hV59ly8F43
         HhBM0YCTc38cFDqgT16sdqiazdPrDMPq3Jfun9MB0FODSe1FtkFqpGNGBmaILJ5+6x17
         p4VSkMPeUbYcnTm250JR1/+t59OZ3mbRGnHh+OLjvUq22+zPYb9eFUS0dzlnl9BRUy4B
         NOxjt6tspm48j80dapnUJNXwVGZmlMOl+kqjarNCTh1JRwnWQOtQfQ6uu7sYHiA9owSG
         de6s4H1CMT/X00A/PzUzM9qP5P9UHxv3dW3uSJc3I7aO6eJmu4S7FI5ACId/jWr9G5Qs
         9Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bRnEfBrn6ZL38hGLbyN7ReuRiuXEP9h79QAJEf8/Ik=;
        b=yzqMAxIbmX5YYYvujowLSglFxOJGnCWLS2Zuydy9lNtSgFqU1c8NxsZy49ItvbYRSK
         9uoJIFka4nb7Tq/9zA5eZzloqP09jCSUVeUTXC45jo6bnPOQFZ0O3XlA1b70G49Hpw4j
         7Ha2uLXTFg/yOz8U9Vgl09ZQL+qBUt/UIZIu22zjjvO1q7vDze/vPcbvzB/q5M+sLC1O
         s1PcpHvZmKSza/xMIJO3RDu+Y5SWvON4i8VRAgHUIdJfQm7+nLIUlYbc/n7jMT7p16FF
         sukpeo5Psj8nW83wAm5yRfcNsUjr/2rzxqA3PdFaQHErptuQ/6GpK7gxWoOzOW8zrZuN
         yftQ==
X-Gm-Message-State: AOAM532dhwrD75kE8/GwYVsHnCel03NAcGYZ0GuGSTLC0fJpqTusicpW
        cwtyapwT9yYaoLTQq0auKi5KkxLGrAlxVA==
X-Google-Smtp-Source: ABdhPJykF4ZNm2hSN0GWEHgdMAN3s/T6ssh/g2uCiU2MPNrD2f6M0YdCuIIjpyADMjBP1fz+EdiUmw==
X-Received: by 2002:a05:6000:186f:b0:205:857d:dee8 with SMTP id d15-20020a056000186f00b00205857ddee8mr339559wri.532.1649879536718;
        Wed, 13 Apr 2022 12:52:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:16 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 23/29] CI: narrow down variable definitions in --build and --test
Date:   Wed, 13 Apr 2022 21:51:36 +0200
Message-Id: <patch-v3-23.29-8e79c3e39e0-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding step the "setvar" function was made to take a
"--build", "--test" or "--all" argument to indicate where the
variables it sets were used.

Let's make use of that by having the relevant parts of
".github/workflows/main.yml" invoke "ci/lib.sh" with those options.

By doing this the set of variables shown in build-only steps will be
fewer, which makes diagnosing anything going on there easier, as we
won't have to look at a deluge of e.g. GIT_TEST_* variables.

Since we'll now always run "--build" for "make" and "--test" for "make
test" we can stop setting the "fat" MAKEFLAGS entirely on the "test"
steps, i.e. the one with PYTHON_PATH, CC etc. These will all be
carried over from the earlier --build step.

That won't be true in the case of the "windows-test" and "vs-test"
jobs, since they run separately from the corresponding "build"
step. So we'll need to make sure that we have the --jobs=N argument
for those.

This doesn't matter that much, as we'll still have --jobs=N in
GIT_PROVE_OPTS. So the only thing we'll use it for is parallelism in
the t/Makefile before we get to running "prove". Still, it's good to
be consistent for good measure, and to run the t/Makefile itself in
parallel.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 20 +++++++++++---------
 ci/lib.sh                  | 30 +++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1e13718b989..0787cadc76b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -84,7 +84,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
       shell: bash
     - name: build
       shell: bash
@@ -122,7 +122,7 @@ jobs:
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
-    - run: ci/lib.sh
+    - run: ci/lib.sh --test
       shell: bash
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
@@ -169,7 +169,7 @@ jobs:
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
       shell: bash
     - name: generate Visual Studio solution
       shell: bash
@@ -211,7 +211,7 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - run: ci/lib.sh
+    - run: ci/lib.sh --test
       shell: bash
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
@@ -275,8 +275,9 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make
+    - run: ci/lib.sh --test
     - run: make test
       if: success()
     - run: ci/print-test-failures.sh
@@ -310,8 +311,9 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make
+    - run: ci/lib.sh --test
     - run: make test
       if: success() && matrix.vector.skip-tests != 'no'
     - run: ci/print-test-failures.sh
@@ -331,7 +333,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make ci-static-analysis
   sparse:
     needs: ci-config
@@ -352,7 +354,7 @@ jobs:
     - uses: actions/checkout@v2
     - name: Install other dependencies
       run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make sparse
   documentation:
     name: documentation
@@ -364,7 +366,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make check-docs
     - run: "make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)"
       shell: bash
diff --git a/ci/lib.sh b/ci/lib.sh
index 8f7e178f3ff..50bc766254b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -5,6 +5,13 @@ set -ex
 . ${0%/*}/lib-ci-type.sh
 
 # Starting assertions
+mode=$1
+if test -z "$mode"
+then
+	echo "need a $0 mode, e.g. --build or --test" >&2
+	exit 1
+fi
+
 if test -z "$jobname"
 then
 	echo "must set a CI jobname in the environment" >&2
@@ -16,11 +23,12 @@ setenv () {
 	while test $# != 0
 	do
 		case "$1" in
-		--build)
-			;;
-		--test)
-			;;
-		--all)
+		--build | --test)
+			if test "$1" != "$mode"
+			then
+				return 0
+			fi
+
 			;;
 		-*)
 			echo "BUG: bad setenv() option '$1'" >&2
@@ -46,8 +54,12 @@ setenv () {
 # How many jobs to run in parallel?
 NPROC=10
 
+# For "--test" we carry the MAKEFLAGS over from earlier steps, except
+# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
+COMMON_MAKEFLAGS=--jobs=$NPROC
+
 # Clear MAKEFLAGS that may come from the outside world.
-MAKEFLAGS=--jobs=$NPROC
+MAKEFLAGS=$COMMON_MAKEFLAGS
 
 case "$CI_TYPE" in
 github-actions)
@@ -101,6 +113,9 @@ windows-build)
 	setenv --build NO_PERL NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
 	;;
+windows-test)
+	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
+	;;
 vs-build)
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
@@ -117,6 +132,7 @@ vs-build)
 	;;
 vs-test)
 	setenv --test NO_SVN_TESTS YesPlease
+	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 linux-gcc)
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
@@ -162,4 +178,4 @@ linux-leaks)
 	;;
 esac
 
-setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
-- 
2.36.0.rc2.843.g193535c2aa7

