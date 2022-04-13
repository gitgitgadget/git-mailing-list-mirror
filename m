Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20384C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiDMTyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiDMTyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189432C116
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so643292wms.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBUCbkBWJzRwqt1VBn5zfFS/aEAwXAZ1wU9yYrl0SPE=;
        b=lB4w1vEKwNI/m/4xkhCJUUKSInhrzuTFtOXl9bZXbSdpKEzx0Aj6M9Kvs6rw6jnOvq
         izjAW7XfjPl8xT1fZZD/b7SxNcSFgL09rNKIBwAIxy/pIInzd9HPfnNzld5XJjvoc9Su
         x77fLA3hkJUNmR7Tr41c9Kmw++6QLhyD6Wg7H88IR20l76G6WlsKwKH1/SKLx4590jB2
         PIGnF6B8TPibPtWfaDcVRDMYuWGSR4yxkDyKy+JYB44vXlvDfIdK6YcAL5JN411kAHlV
         uR1NirwztTdPZ/EVoa7QYIGDbibiLmWRL758yeg/qC5nNzfYCWzdq5ET75blN82XWCdB
         Uplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBUCbkBWJzRwqt1VBn5zfFS/aEAwXAZ1wU9yYrl0SPE=;
        b=CtABIugWdTiw11OAn2+pC3IrrZRT1DhGMB8sV+j+TfPPEdkhvTeNYRSLMNbJg+FPHn
         cE9OQT2QY3q7pkDUOEVjGyQFy/GI+OtvIeU2G6t7IfUonzGvKQi3X6WTDxTyNzyrxGlt
         6YwihM4G8Mja+Pd+9i/cYnGUY2JFdZvqrQFvrWKR3dPC1/Echuw3P7Ttm5I0LUJC0Db/
         VmRiVYcj7xaQ6524UUyXl+Mx7YNq/ttgeeJophoRDmuuyuPUtb7+uqC0KXL95GMrnmFf
         1K39bHt8NXS3n1H7nqFF4IyR7tCW0r6V5CDgJzgMBdcTzTRPz2A4qlTdSPUhKJVrPeMZ
         5Fnw==
X-Gm-Message-State: AOAM5329Kh0nLs5Qdzzqel0GvYz6xAG0W7r5MihnnWXhGCaontw6q1wE
        A27u7SGK/xAUFc/XG9tG9IQS4CrGUJ3CxQ==
X-Google-Smtp-Source: ABdhPJxIA/kkXPhVL3nDG4ETsZESs5w08sZ1jGDZFbjxhZ3TDX/QwBSvBsq7OxdW2CffmfDfX9hKOg==
X-Received: by 2002:a1c:7408:0:b0:38e:b7af:c503 with SMTP id p8-20020a1c7408000000b0038eb7afc503mr297597wmc.58.1649879513068;
        Wed, 13 Apr 2022 12:51:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:52 -0700 (PDT)
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
Subject: [PATCH v3 00/29] CI: run "make" in CI "steps", improve UX
Date:   Wed, 13 Apr 2022 21:51:13 +0200
Message-Id: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes CI "step" targets that are shellscripts that do N
things to instead be single command invocations at the "step" level,
driven by the CI recipe itself.

To do that we need to pass state that we previously re-setup for every
"step" via $GITHUB_ENV, whose state we then helpfully show (this is just
a standard GitHub CI feature) in a drop-down at the start of every
"step".

I.e. at the tip of this series you can reliably look at that
$GITHUB_ENV view to see what the full and relevant environment was for
that "make", "make test" or whatever.

Changes since v2:

 * A new CL summary, based on
   https://lore.kernel.org/git/220326.861qypldwn.gmgdl@evledraar.gmail.com/

 * It's now 29 patches instead of 25, but 3/4 of those are trivial
   (see range-diff), it just made sense to split them up for
   readability.

 * The rather minor in code but rather big in UX terms is that I've
   added 29/29, which explicitly documents and shows examples of using
   the CI tooling in a way where you can locally run a CI target as if
   though it were a given $jobname, e.g.:

	# run "make all test" like the "linux-leaks" job
	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)

	# run "make test" like the "linux-TEST-vars" job (uses various GIT_TEST_* modes)
	make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)

   The rest of the changes in this series are all here to make that
   nicer, i.e. ci/lib.sh has been taught to not panic if it's not
   under a known CI platform, but instead to fall back on doing as
   well as it can, and suggesting that you provide it with a "jobname"
   so it can be used as in the examples above.

   Likewise the ci/print-test-failures.sh script can now be run
   locally without any extra mock-ups, e.g.:

	make test || ci/print-test-failures.sh

The CI run for this series can be seen at:
https://github.com/avar/git/tree/avar/ci-unroll-make-commands-to-ci-recipe-3

 .github/workflows/main.yml            | 100 ++++---
 Makefile                              |  31 ++-
 ci/check-directional-formatting.bash  |   2 +-
 ci/check-unignored-build-artifacts.sh |  20 ++
 ci/install-dependencies.sh            |  53 +++-
 ci/install-docker-dependencies.sh     |  22 --
 ci/lib-ci-type.sh                     |   6 +
 ci/lib-tput.sh                        |   5 +
 ci/lib.sh                             | 387 +++++++++++++++-----------
 ci/make-test-artifacts.sh             |  12 -
 ci/mount-fileshare.sh                 |  25 --
 ci/print-test-failures.sh             |  25 +-
 ci/run-build-and-tests.sh             |  54 ----
 ci/run-docker-build.sh                |  66 -----
 ci/run-docker.sh                      |  47 ----
 ci/run-static-analysis.sh             |  32 ---
 ci/run-test-slice.sh                  |  17 --
 ci/select-test-slice.sh               |  10 +
 ci/test-documentation.sh              |  37 +--
 ci/util/extract-trash-dirs.sh         |  50 ----
 shared.mak                            |   1 +
 21 files changed, 420 insertions(+), 582 deletions(-)
 create mode 100755 ci/check-unignored-build-artifacts.sh
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-tput.sh
 delete mode 100755 ci/make-test-artifacts.sh
 delete mode 100755 ci/mount-fileshare.sh
 delete mode 100755 ci/run-build-and-tests.sh
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh
 delete mode 100755 ci/run-static-analysis.sh
 delete mode 100755 ci/run-test-slice.sh
 create mode 100755 ci/select-test-slice.sh
 delete mode 100755 ci/util/extract-trash-dirs.sh

Range-diff against v2:
 1:  4addbd70213 =  1:  3cb4749c5ea CI: run "set -ex" early in ci/lib.sh
 2:  b23aa99fd37 !  2:  7de95ff437e CI: make "$jobname" explicit, remove fallback
    @@ ci/lib.sh
     +# Starting assertions
     +if test -z "$jobname"
     +then
    -+	echo "must set a CI jobname" >&2
    ++	echo "must set a CI jobname in the environment" >&2
     +	exit 1
     +fi
     +
 3:  eec15a95879 =  3:  820c4e551d9 CI: remove more dead Travis CI support
 4:  73c894f1665 =  4:  914e81118b8 CI: remove dead "tree skipping" code
 5:  b5e6d538554 !  5:  b2e456f9a9b CI: remove unused Azure ci/* code
    @@ ci/mount-fileshare.sh (deleted)
     
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: do
    - 		test_name="${TEST_EXIT%.exit}"
      		test_name="${test_name##*/}"
      		trash_dir="trash directory.$test_name"
    -+		mkdir -p failed-test-artifacts
      		case "$CI_TYPE" in
     -		azure-pipelines)
     -			mkdir -p failed-test-artifacts
    @@ ci/print-test-failures.sh: do
     -			continue
     -			;;
      		github-actions)
    --			mkdir -p failed-test-artifacts
    + 			mkdir -p failed-test-artifacts
      			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
    - 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
    - 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 -:  ----------- >  6:  30968e36bdd CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
 6:  a4b9febbdca =  7:  cc81b9fe37e CI: don't have "git grep" invoke a pager in tree content check
 7:  5d46d5b34c9 =  8:  2387b0c5842 CI: have "static-analysis" run a "make ci-static-analysis" target
 8:  81e06f13d84 =  9:  54a4d79bf8d CI: have "static-analysis" run "check-builtins", not "documentation"
 9:  3be91c26d44 = 10:  9a31b7d5011 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
10:  9dc148341ba ! 11:  8ab4e81e1ca CI: consistently use "export" in ci/lib.sh
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: check_unignored_build_artifacts ()
    - export TERM=${TERM:-dumb}
    +@@ ci/lib.sh: export TERM=${TERM:-dumb}
    + NPROC=10
      
      # Clear MAKEFLAGS that may come from the outside world.
    --export MAKEFLAGS=
    -+MAKEFLAGS=
    +-export MAKEFLAGS=--jobs=$NPROC
    ++MAKEFLAGS=--jobs=$NPROC
      
      if test "$GITHUB_ACTIONS" = "true"
      then
     @@ ci/lib.sh: then
      	CC="${CC:-gcc}"
      
    - 	export GIT_PROVE_OPTS="--timer --jobs 10"
    + 	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
     -	export GIT_TEST_OPTS="--verbose-log -x"
     +	GIT_TEST_OPTS="--verbose-log -x"
    - 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    -+
     +	export GIT_TEST_OPTS
      else
      	echo "Could not identify CI type" >&2
11:  e9c7ba492e8 ! 12:  9fe00566767 CI: export variables via a wrapper
    @@ Commit message
         "--test" and "--all" parameters to indicate whether they're needed for
         building, testing or both.
     
    -    We currently ignore this parameter, but will make use of it in a
    +    We currently ignore the "varname" parameter, but will make use of it in a
         subsequent commit. Adding it here reduces the needless churn, as we
         won't need to change all these lines again for that subsequent change.
     
    @@ ci/lib.sh: then
      
     +# Helper functions
     +setenv () {
    -+	varmode=
    -+	case "$1" in
    -+	--*)
    -+		varmode=$1
    ++	while test $# != 0
    ++	do
    ++		case "$1" in
    ++		--build)
    ++			;;
    ++		--test)
    ++			;;
    ++		--all)
    ++			;;
    ++		-*)
    ++			echo "BUG: bad setenv() option '$1'" >&2
    ++			exit 1
    ++			;;
    ++		*)
    ++			break
    ++			;;
    ++		esac
     +		shift
    -+		;;
    -+	esac
    ++	done
     +
     +	key=$1
     +	val=$2
    @@ ci/lib.sh: check_unignored_build_artifacts ()
     -export TERM=${TERM:-dumb}
     +setenv TERM ${TERM:-dumb}
      
    - # Clear MAKEFLAGS that may come from the outside world.
    - MAKEFLAGS=
    + # How many jobs to run in parallel?
    + NPROC=10
     @@ ci/lib.sh: then
      	CI_TYPE=github-actions
      	CC="${CC:-gcc}"
      
    --	export GIT_PROVE_OPTS="--timer --jobs 10"
    -+	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
    +-	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
    ++	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
      	GIT_TEST_OPTS="--verbose-log -x"
    - 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    - 
     -	export GIT_TEST_OPTS
     +	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
      else
12:  86d5a48d59a ! 13:  13feda050c0 CI: remove "run-build-and-tests.sh", run "make [test]" directly
    @@ ci/lib.sh: setenv () {
     +	if test -n "$GITHUB_ENV"
     +	then
     +		echo "$key=$val" >>"$GITHUB_ENV"
    -+	else
    -+		# For local debugging. Not used by the GitHub CI
    -+		# itself.
    -+		eval "export $key=\"$val\""
     +	fi
      }
      
 -:  ----------- > 14:  d3909b8e896 ci/lib.sh: use "test" instead of "["
13:  649ad1ae249 = 15:  d63a689eae0 CI: check ignored unignored build artifacts in "win[+VS] build" too
14:  b1b5b083389 = 16:  ac1ffe9c642 CI: invoke "make artifacts-tar" directly in windows-build
15:  dfa91ac8938 = 17:  8837bfa5433 CI: split up and reduce "ci/test-documentation.sh"
16:  ba4ed216769 = 18:  aa491990c1a CI: combine ci/install{,-docker}-dependencies.sh
17:  b5e89a33340 = 19:  39b13298425 CI: move "env" definitions into ci/lib.sh
18:  571f4d0f441 = 20:  0a92c478d28 ci/run-test-slice.sh: replace shelling out with "echo"
19:  2edea06ee4d = 21:  16ac7f5c210 CI: pre-select test slice in Windows & VS tests
20:  ef9daa6882f ! 22:  939ef573b75 CI: only invoke ci/lib.sh as "steps" in main.yml
    @@ ci/install-dependencies.sh
     
      ## ci/lib-ci-type.sh (new) ##
     @@
    ++#!/bin/sh
    ++
     +if test "$GITHUB_ACTIONS" = "true"
     +then
     +	CI_TYPE=github-actions
     +else
     +	echo "Could not identify CI type" >&2
    -+	env >&2
     +	exit 1
     +fi
     
      ## ci/lib-tput.sh (new) ##
     @@
    ++#!/bin/sh
    ++
     +# GitHub Action doesn't set TERM, which is required by tput
    -+export TERM=${TERM:-dumb}
    ++TERM=${TERM:-dumb}
    ++export TERM
     
      ## ci/lib.sh ##
     @@
    @@ ci/lib.sh: setenv () {
     -# GitHub Action doesn't set TERM, which is required by tput
     -setenv TERM ${TERM:-dumb}
     -
    + # How many jobs to run in parallel?
    + NPROC=10
    + 
      # Clear MAKEFLAGS that may come from the outside world.
    - MAKEFLAGS=
    + MAKEFLAGS=--jobs=$NPROC
      
     -if test "$GITHUB_ACTIONS" = "true"
     -then
    @@ ci/lib.sh: setenv () {
     +github-actions)
      	CC="${CC:-gcc}"
      
    - 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
     @@ ci/lib.sh: then
    + 	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    - 
      	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
     -else
     -	echo "Could not identify CI type" >&2
21:  44e3ace5fbe ! 23:  8e79c3e39e0 CI: narrow down variable definitions in --build and --test
    @@ Commit message
         fewer, which makes diagnosing anything going on there easier, as we
         won't have to look at a deluge of e.g. GIT_TEST_* variables.
     
    +    Since we'll now always run "--build" for "make" and "--test" for "make
    +    test" we can stop setting the "fat" MAKEFLAGS entirely on the "test"
    +    steps, i.e. the one with PYTHON_PATH, CC etc. These will all be
    +    carried over from the earlier --build step.
    +
    +    That won't be true in the case of the "windows-test" and "vs-test"
    +    jobs, since they run separately from the corresponding "build"
    +    step. So we'll need to make sure that we have the --jobs=N argument
    +    for those.
    +
    +    This doesn't matter that much, as we'll still have --jobs=N in
    +    GIT_PROVE_OPTS. So the only thing we'll use it for is parallelism in
    +    the t/Makefile before we get to running "prove". Still, it's good to
    +    be consistent for good measure, and to run the t/Makefile itself in
    +    parallel.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
    @@ ci/lib.sh: set -ex
     +mode=$1
     +if test -z "$mode"
     +then
    -+	echo "need a $0 mode, e.g. --build or --test"
    ++	echo "need a $0 mode, e.g. --build or --test" >&2
     +	exit 1
     +fi
     +
      if test -z "$jobname"
      then
    - 	echo "must set a CI jobname" >&2
    -@@ ci/lib.sh: fi
    - 
    - # Helper functions
    - setenv () {
    -+	skip=
    - 	varmode=
    - 	case "$1" in
    - 	--*)
    -+		if test "$1" != "$mode" && test "$1" != "--all"
    -+		then
    -+			skip=t
    -+		fi
    - 		varmode=$1
    - 		shift
    - 		;;
    + 	echo "must set a CI jobname in the environment" >&2
     @@ ci/lib.sh: setenv () {
    - 	val=$2
    - 	shift 2
    + 	while test $# != 0
    + 	do
    + 		case "$1" in
    +-		--build)
    +-			;;
    +-		--test)
    +-			;;
    +-		--all)
    ++		--build | --test)
    ++			if test "$1" != "$mode"
    ++			then
    ++				return 0
    ++			fi
    ++
    + 			;;
    + 		-*)
    + 			echo "BUG: bad setenv() option '$1'" >&2
    +@@ ci/lib.sh: setenv () {
    + # How many jobs to run in parallel?
    + NPROC=10
      
    -+	if test -n "$skip"
    -+	then
    -+		return 0
    -+	fi
    ++# For "--test" we carry the MAKEFLAGS over from earlier steps, except
    ++# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
    ++COMMON_MAKEFLAGS=--jobs=$NPROC
     +
    - 	if test -n "$GITHUB_ENV"
    - 	then
    - 		echo "$key=$val" >>"$GITHUB_ENV"
    + # Clear MAKEFLAGS that may come from the outside world.
    +-MAKEFLAGS=--jobs=$NPROC
    ++MAKEFLAGS=$COMMON_MAKEFLAGS
    + 
    + case "$CI_TYPE" in
    + github-actions)
    +@@ ci/lib.sh: windows-build)
    + 	setenv --build NO_PERL NoThanks
    + 	setenv --build ARTIFACTS_DIRECTORY artifacts
    + 	;;
    ++windows-test)
    ++	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
    ++	;;
    + vs-build)
    + 	setenv --build NO_PERL NoThanks
    + 	setenv --build NO_GETTEXT NoThanks
    +@@ ci/lib.sh: vs-build)
    + 	;;
    + vs-test)
    + 	setenv --test NO_SVN_TESTS YesPlease
    ++	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
    + 	;;
    + linux-gcc)
    + 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
    +@@ ci/lib.sh: linux-leaks)
    + 	;;
    + esac
    + 
    +-setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
    ++setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
22:  5f56b922e08 ! 24:  d1d5c1e2f65 CI: add more variables to MAKEFLAGS, except under vs-build
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: setenv () {
    +@@ ci/lib.sh: COMMON_MAKEFLAGS=--jobs=$NPROC
      # Clear MAKEFLAGS that may come from the outside world.
    - MAKEFLAGS=
    + MAKEFLAGS=$COMMON_MAKEFLAGS
      
    -+# Common make and cmake build options
    ++# Use common options for "make" (cmake in "vs-build" below uses the
    ++# intermediate variables directly)
     +DEVELOPER=1
    ++MAKEFLAGS="$MAKEFLAGS DEVELOPER=$DEVELOPER"
     +SKIP_DASHED_BUILT_INS=YesPlease
    -+
    -+# Use common options for "make" (cmake in "vs-build" below)
    -+MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    ++MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
     +
      case "$CI_TYPE" in
      github-actions)
    @@ ci/lib.sh: github-actions)
      
      case "$runs_on_pool" in
      ubuntu-latest)
    -@@ ci/lib.sh: windows-build)
    - 	setenv --build ARTIFACTS_DIRECTORY artifacts
    +@@ ci/lib.sh: windows-test)
    + 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
      	;;
      vs-build)
     +	setenv --build DEVELOPER $DEVELOPER
23:  b45b7cec94e ! 25:  1268792233f CI: set CC in MAKEFLAGS directly, don't add it to the environment
    @@ ci/lib.sh: setenv () {
      	fi
      }
      
    --# Clear MAKEFLAGS that may come from the outside world.
     +# Clear variables that may come from the outside world.
     +CC=
     +CC_PACKAGE=
    - MAKEFLAGS=
    ++
    + # How many jobs to run in parallel?
    + NPROC=10
      
    - # Common make and cmake build options
    -@@ ci/lib.sh: MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    +@@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
      
      case "$CI_TYPE" in
      github-actions)
     -	CC="${CC:-gcc}"
     -
    - 	setenv --test GIT_PROVE_OPTS "--timer --jobs 10"
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
      	GIT_TEST_OPTS="--verbose-log -x"
    - 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
    + 	test Windows != "$RUNNER_OS" ||
     @@ ci/lib.sh: vs-test)
    - 	setenv --test NO_SVN_TESTS YesPlease
    + 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
      	;;
      linux-gcc)
     +	CC=gcc
    @@ ci/lib.sh: linux-musl)
      	;;
      esac
      
    --setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
    +-setenv --build MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
     +MAKEFLAGS="$MAKEFLAGS${CC:+ CC=$CC}"
    -+setenv --all MAKEFLAGS "$MAKEFLAGS"
    ++setenv --build MAKEFLAGS "$MAKEFLAGS"
 -:  ----------- > 26:  83138dacd3e CI: set SANITIZE=leak in MAKEFLAGS directly
24:  06bf8d9f61b ! 27:  0508777c68e CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
    @@ ci/lib.sh: ubuntu-latest)
      	setenv --test GIT_TEST_HTTPD true
      	;;
     -macos-latest)
    --	if [ "$jobname" = osx-gcc ]
    +-	if test "$jobname" = osx-gcc
     -	then
     -		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
     -	else
25:  6dc96ba8b82 ! 28:  c0ce0fd3a80 CI: don't use "set -x" in "ci/lib.sh" output
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## ci/lib-ci-type.sh ##
    -@@ ci/lib-ci-type.sh: else
    - 	env >&2
    - 	exit 1
    - fi
    -+
    -+echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
    -
      ## ci/lib.sh ##
     @@
      #!/bin/sh
    @@ ci/lib.sh
      # Helper libraries
      . ${0%/*}/lib-ci-type.sh
     @@ ci/lib.sh: then
    - 	echo "need a $0 mode, e.g. --build or --test"
      	exit 1
      fi
    -+echo "CONFIG: mode=$mode" >&2
      
    - if test -z "$jobname"
    - then
    - 	echo "must set a CI jobname" >&2
    - 	exit 1
    - fi
    ++# Show our configuration
    ++echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
     +echo "CONFIG: jobname=$jobname" >&2
     +echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
     +echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
    - 
    ++if test -n "$GITHUB_ENV"
    ++then
    ++	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
    ++fi
    ++
      # Helper functions
      setenv () {
    ++	local skip=
    + 	while test $# != 0
    + 	do
    + 		case "$1" in
    + 		--build | --test)
    + 			if test "$1" != "$mode"
    + 			then
    +-				return 0
    ++				skip=t
    + 			fi
    + 
    + 			;;
     @@ ci/lib.sh: setenv () {
    + 	val=$2
    + 	shift 2
      
    - 	if test -n "$skip"
    - 	then
    ++	if test -n "$skip"
    ++	then
     +		echo "SKIP '$key=$val'" >&2
    - 		return 0
    - 	fi
    - 
    -@@ ci/lib.sh: setenv () {
    - 		# itself.
    - 		eval "export $key=\"$val\""
    ++		return 0
    ++	fi
    ++
    + 	if test -n "$GITHUB_ENV"
    + 	then
    + 		echo "$key=$val" >>"$GITHUB_ENV"
      	fi
     +
     +	echo "SET: '$key=$val'" >&2
 -:  ----------- > 29:  2e3c02fa0df CI: make it easy to use ci/*.sh outside of CI
-- 
2.36.0.rc2.843.g193535c2aa7

