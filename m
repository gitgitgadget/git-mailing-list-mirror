Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ACCC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbiDRQeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346247AbiDRQcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0830577
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k22so19135107wrd.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hu5K5HKPloRmbpcbyfoWJTEXZrYGqUBwYG5mppzJvQk=;
        b=JHZDJ4k0H8S4rzmOtass4PFZTFGC1noDmqVhIEe1ay86AWL/P+aY3yyK9acVSn4tc1
         QvJ6RlHamgisOlSPz49W74mlVKGMAky5EgqVmACHJtOp/hSeXPNcM5koq+u0w0GMq1mb
         k0hBLVeKZckBz9Oh7Ib4kh9kqLCDFqVXc2xoV+vbhDuCb+DTIxd1o8pjbZQjLmB7sWL2
         2q2gv2uxaNJ7xPTm6eJnNKHEnS7H8ZQGIiXYOuexGogCVMjgx1ypsytTZ/HDadu4fAFv
         QusNf7W9JhEqrQWsIZGWTkIb9GH6nys1/dsLP2EWKlEdzPPWdlsAPfCBgVNb8D+qB3dc
         dhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hu5K5HKPloRmbpcbyfoWJTEXZrYGqUBwYG5mppzJvQk=;
        b=y9W5/odMeG0kd6KcYGvhe2GeHhkS3SPuU3bsoR9F2ute4OopszTXSuhDSXVta4ZRyw
         NPXSuCRmXjTzvtp/Om1S9gdZlsByCgVKU3ryJYIvL5RF96u+Xom2ViDhdx4eNZVdaJjJ
         KUh0bqc9jsgccA3XQCKdTPW20WilmK1qg/y7I+j7GVeOksNa2jWxiM+4h6vRESl2SCtO
         kGL35inS4ynf9z8q8pmfDlJtyo6hCuw1k/6B7/DAi8XVdaw7KZZ0kzDR2siUMfFFD6sx
         HnKLVWKTHSjRClcOUKqcEEt+aB6KaMr3/NirzbvgbZgUGCVucvKlBecmkDWHKGE7D/0K
         HB+A==
X-Gm-Message-State: AOAM531xpZoN5cAN9YakeSAF0ZBbGVIf41p1nqCK+ZdIwexuKyUlB3yb
        mMIob/z7R593k9eQ9YQxYg81zLfOoNoXmA==
X-Google-Smtp-Source: ABdhPJwQ4pdroALbpV0+SWPwAZBfOIOE+r0q1BWCAhj2PS6aORPfhzCb46pyukU2yRpmAgDEr4nOqQ==
X-Received: by 2002:a5d:64c8:0:b0:204:ccc:4ba5 with SMTP id f8-20020a5d64c8000000b002040ccc4ba5mr9083443wri.409.1650299375357;
        Mon, 18 Apr 2022 09:29:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:34 -0700 (PDT)
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
Subject: [PATCH v4 24/31] CI: narrow down variable definitions in --build and --test
Date:   Mon, 18 Apr 2022 18:29:01 +0200
Message-Id: <patch-v4-24.31-a7434b215db-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
2.36.0.rc2.898.gdf6bbac50ff

