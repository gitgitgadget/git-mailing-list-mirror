Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802C8C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbiEYKHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242116AbiEYKFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A868FB0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so29410403wrg.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBaSE9xs/DJloVTK+2kFOfNhxCA9fEHIoPLLlR9YFp0=;
        b=UjlXXOIYOp3IJRqjaY9KvQq/MTkciQWDLMuWsfRExlyiZkrN25WH0s0e+cedx0JIFU
         2UAL7c92CMpKZzLtZX+dlOcVX5FatAKRhTq56ENBARagGeroD5Xse9PwglvsLDHUjkCW
         0Jl/ioUlszYxgR5SscIiq+KbLQpGfdy2CJ2wiyjYIl4Vx84+2K/zokZU6ikPTcRgqZB7
         ZTF18DqZ4luGNCes3md5MZHtdkWF0L5TX4A7iX/dhnGyTLpPlR064TS1b67m+QgkwXms
         HHpiMiuavPFQYV2Y6/qXBCew3cN0NH2V/FV+gLWUpMetC/dnD1A66EHdUzJTnkrvqtmM
         gnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBaSE9xs/DJloVTK+2kFOfNhxCA9fEHIoPLLlR9YFp0=;
        b=cdHUDZQOkzkU743OiilwV/v5q6ASDa4cyCQhKgnZKlcjejQDZ8edrRIN+JHpk1D+4W
         ALzUZdA5aZLlt7YJEY80UEgEF3b/irrHr0tuZtLUJLDxF4uI7LrSbaMVMnhNcM+VstKm
         RnxBNu29nouk+xvTZZVFMA9010V3SYsUfSNVN7bOU8RE4B2iKIvSIpgIaAQZbKZBpMEO
         Cslz1uQRG+Khf0Ilkt3bui1gCtgxqhA5txmndZKRjNmvd5Kn0gSjl4oWiy1SpVdeYoBE
         KXNqd5DL7uLXKR3FWma8HjJJOHkLjJ5tHxNj7iBJSe2d9fWdfOwZld9LxGVznxxa6Y0i
         H2pw==
X-Gm-Message-State: AOAM533tOcczLKp21EYHN3aaLA62KtUi4YD6AkKQCmcxiQu4aCcrNvkU
        0Ddr/7BFFJslZ+wQmVI8bTnGcdg4M/SnfQ==
X-Google-Smtp-Source: ABdhPJwKGMN3dpjSlYU2Icy95SLekJkB2DuACoPwndfmaREUaiscEEzBnmnRIc0T/SDZT3mCKSvQvg==
X-Received: by 2002:a5d:4e08:0:b0:210:297:7d4b with SMTP id p8-20020a5d4e08000000b0021002977d4bmr894290wrt.112.1653473106061;
        Wed, 25 May 2022 03:05:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:05 -0700 (PDT)
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
Subject: [PATCH v6 23/29] CI: narrow down variable definitions in --build and --test
Date:   Wed, 25 May 2022 12:04:02 +0200
Message-Id: <patch-v6-23.29-e2b3bf032d6-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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

For the "pedantic" job (which has no test phase) we won't run the
"ci/lib.sh --test" step, which will be clearly visible as a skipped
step in the UX.

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
 .github/workflows/main.yml | 21 ++++++++-------
 ci/lib.sh                  | 52 +++++++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 83e0aa1f469..bb62b4ff725 100644
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
@@ -310,8 +311,10 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make
+    - run: ci/lib.sh --test
+      if: success() && matrix.vector.skip-tests != 'yes'
     - run: make test
       if: success() && matrix.vector.skip-tests != 'yes'
     - run: ci/print-test-failures.sh
@@ -331,7 +334,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make ci-static-analysis
   sparse:
     needs: ci-config
@@ -352,7 +355,7 @@ jobs:
     - uses: actions/checkout@v2
     - name: Install other dependencies
       run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make sparse
   documentation:
     name: documentation
@@ -364,7 +367,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make check-docs
     - run: "make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)"
       shell: bash
diff --git a/ci/lib.sh b/ci/lib.sh
index 15a0011f6aa..96919882c11 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -4,6 +4,30 @@ set -ex
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
 
+# Parse options
+mode_build=
+mode_test=
+while test $# != 0
+do
+	case "$1" in
+	--build)
+		mode_build=t
+		;;
+	--test)
+		mode_test=t
+		;;
+	-*)
+		echo "error: invalid option: $1" >&2
+		exit 1
+		;;
+	*)
+		echo "error: invalid argument: $1" >&2
+		exit 1
+		;;
+	esac
+	shift
+done
+
 # Starting assertions
 if test -z "$jobname"
 then
@@ -11,16 +35,28 @@ then
 	exit 1
 fi
 
+if test "$mode_test$mode_build" != "t"
+then
+	echo "error: need one mode, e.g. --build or --test" >&2
+	exit 1
+fi
+
 # Helper functions
 setenv () {
 	while test $# != 0
 	do
 		case "$1" in
 		--build)
+			if test -z "$mode_build"
+			then
+				return 0
+			fi
 			;;
 		--test)
-			;;
-		--all)
+			if test -z "$mode_test"
+			then
+				return 0
+			fi
 			;;
 		-*)
 			echo "BUG: bad setenv() option '$1'" >&2
@@ -46,8 +82,12 @@ setenv () {
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
@@ -101,6 +141,9 @@ windows-build)
 	setenv --build NO_PERL NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
 	;;
+windows-test)
+	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
+	;;
 vs-build)
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
@@ -117,6 +160,7 @@ vs-build)
 	;;
 vs-test)
 	setenv --test NO_SVN_TESTS YesPlease
+	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 linux-gcc)
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
@@ -162,4 +206,4 @@ linux-leaks)
 	;;
 esac
 
-setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
+setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
-- 
2.36.1.1045.gf356b5617dd

