Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1683C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391307AbiDUS0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391253AbiDUS02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8E4991B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so3974880wmq.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=roUfQAK0NPPgUM9JdPEHzF584UKxIGUwskcnGrJW8mY=;
        b=iODfi5nNB0hsci2qnwr4h5hB0wLg2w737jJ0G2Ka7VHcMti75VZBSjtgnTcMdmsrQK
         Pie+szsgRt2Xa/B6bleQW6QUYAnSF17cq6d6LojUuAJgwNgeoBH1iN0zy1kG3j6Zvd2S
         +TTGXNpDkXNOmM0rtZpuyFrpwhyAnS0H1W3dGunNIjJQtUNbF/15n1WIbN+RV3XfY14t
         Lk2h1NniYW1hLScE53bQJUwkV5r2y1SCaU3xx4x+jaaLnOV58nG8ILJMTd0RZD6asjcY
         DbwgbyrskEk5uOVbnLDNXzzKp1EsB1u4NkX+ZV5TZm/ZAHOmlJx2bHb46JC6MyJNilD0
         KdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=roUfQAK0NPPgUM9JdPEHzF584UKxIGUwskcnGrJW8mY=;
        b=d6yM7N74ZDww989AIra4a/K8Za29Cb56tFu2g2Nw+w75fAjQQyHwP87olh/2Kdvr2/
         OnyLGdGGc5hzy7aMdsaZjb5+qKcv5+lMU7Ovt03RLfLjeq6EGFMXYEh62fCHiKANVO97
         b/dUCDviYGhA00q6AVkCGtAqGn4ffFfg7s6ziUxhioQR+4I3ECXypR2h5NZmaWEvQSmH
         /04PL/oYhjD+kq2HRw59w/nnyXB4PUIPTNQG9dIKieDgSNTodb2wGUgGNuEJETDZr02t
         mWkE2C2hgIEFBqnd5lHgLZphgd+ljBm0dQQ47BPWXaKRziM7oPvdekP9Y8OQFU83hBMo
         rIAA==
X-Gm-Message-State: AOAM533mocMY4rKy1HLlJu46rwShHSm6AosJs/JNpYKmYcQgVWnW1IEj
        gA+IXhsX03jenrIiBILvJn8BpviFHBBieg==
X-Google-Smtp-Source: ABdhPJxFdHc1yEyOlcQQtfIkoR37/KoE8CMf2kdV/t4OB7W5Jq7dfHySuDdN5aIHC4tzdks4b4IxFg==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr9931760wma.140.1650565414562;
        Thu, 21 Apr 2022 11:23:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:34 -0700 (PDT)
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
Subject: [PATCH v5 00/29] CI: run "make" in CI "steps", improve UX
Date:   Thu, 21 Apr 2022 20:22:55 +0200
Message-Id: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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

Change since v4:

 * Minor UX improvements for 29/29, e.g. "error: " prefixes for error
   messages.
 * Addressed feedback from Phillip Wood at
   https://lore.kernel.org/git/1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com/:

   - That bash-specific ${../../} syntax is gone
   - The inverted "skip-test: no" is now a "skip-test: yes", as it should be.

   - The new "trace" output from ci/lib.sh now doesn't have "SKIP"
     lines, i.e. we just say what variables we do set, not what we
     don't set. E.g.:
     https://github.com/avar/git/runs/6093145633?check_suite_focus=true#step:4:13

   - I looked at the "a lot of churn" comment, there's e.g. "CI:
     export variables via a wrapper" where we first make a wrapper to
     "export" variables, then make further use of it, some of which
     involves touching the same lines again.

     Likewise first invoking ci/lib.sh, then splitting that up into
     ci/lib.sh --build and ci/lib.sh --test.

     I looked at squashing some of that together, but I think it
     really makes it harder to review & reason about to do N things at
     the same time, even if the net diff size is bigger.
 * Squashed together two commits that were adjusting bash syntax to be
   POSIX syntax.
 * For the pedantic job that skips tests the "ci/lib.sh --test" step
   of setting up variables for it is now also skipped. See:
   https://github.com/avar/git/runs/6093144782?check_suite_focus=true
 * Made ci/select-test-slice.sh do the same "are we in GitHub CI?"
   check as the rest of the scripts, it's now easier to run it
   stand-alone for testing.
 * Adjusted usage output, made it friendlier, moved those UX bits over
   to a test_commit-like getopts parsing.
 * Fixed a typo/commit message suggestion by Eric Sunshine.

 * This series contained a regression fix for an issue already on
   "master", which I've split out in
   https://lore.kernel.org/git/patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com/

   When the two are merged there's a conflict that's resolved thusly,
   per a --remerge-diff (which I snipped away with [...]). I.e. gcc-8
   and gcc-9 need to be added to the linux-gcc and osx-gcc part of
   ci/lib.sh:
	
	diff --git a/ci/lib.sh b/ci/lib.sh
	remerge CONFLICT (content): Merge conflict in ci/lib.sh
	index 407e994edcd..a4e9d51ad6c 100755
	--- a/ci/lib.sh
	+++ b/ci/lib.sh
	@@ -30,126 +30,6 @@ usage() {
	 	then
	 		echo "$CI_TYPE_HELP" >&2
	 	fi
	-<<<<<<< ca24940186b (Merge branch 'avar/ci-have-osx-p4-install-fall-back-on-sha256-no-check' into build-master)
	-=======
	[...snipped ~100 lines ... ]
	->>>>>>> 92acf9420a9 (CI: select CC based on CC_PACKAGE (again))
	 	exit 1
	 }
	 
	@@ -373,7 +253,7 @@ vs-test)
	 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
	 	;;
	 linux-gcc)
	-	CC=gcc
	+	CC=gcc-8
	 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
	 	;;
	 linux-gcc-default)
	@@ -397,7 +277,7 @@ linux-TEST-vars)
	 	;;
	 osx-gcc)
	 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
	-	CC=gcc
	+	CC=gcc-9
	 	;;
	 osx-clang)
	 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"

Ævar Arnfjörð Bjarmason (29):
  CI: run "set -ex" early in ci/lib.sh
  CI: make "$jobname" explicit, remove fallback
  CI: remove more dead Travis CI support
  CI: remove dead "tree skipping" code
  CI: remove unused Azure ci/* code
  CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
  CI: don't have "git grep" invoke a pager in tree content check
  CI: have "static-analysis" run a "make ci-static-analysis" target
  CI: have "static-analysis" run "check-builtins", not "documentation"
  CI: move p4 and git-lfs variables to ci/install-dependencies.sh
  CI: consistently use "export" in ci/lib.sh
  CI: export variables via a wrapper
  CI: remove "run-build-and-tests.sh", run "make [test]" directly
  CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
  CI: check ignored unignored build artifacts in "win[+VS] build" too
  CI: invoke "make artifacts-tar" directly in windows-build
  CI: split up and reduce "ci/test-documentation.sh"
  CI: combine ci/install{,-docker}-dependencies.sh
  CI: move "env" definitions into ci/lib.sh
  ci/run-test-slice.sh: replace shelling out with "echo"
  CI: pre-select test slice in Windows & VS tests
  CI: only invoke ci/lib.sh as "steps" in main.yml
  CI: narrow down variable definitions in --build and --test
  CI: add more variables to MAKEFLAGS, except under vs-build
  CI: set CC in MAKEFLAGS directly, don't add it to the environment
  CI: set SANITIZE=leak in MAKEFLAGS directly
  CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
  CI: don't use "set -x" in "ci/lib.sh" output
  CI: make it easy to use ci/*.sh outside of CI

 .github/workflows/main.yml            | 101 +++---
 Makefile                              |  31 +-
 ci/check-directional-formatting.bash  |   2 +-
 ci/check-unignored-build-artifacts.sh |  20 ++
 ci/install-dependencies.sh            |  82 +++--
 ci/install-docker-dependencies.sh     |  22 --
 ci/lib-ci-type.sh                     |   6 +
 ci/lib-online_cpus.sh                 |  26 ++
 ci/lib-tput.sh                        |   5 +
 ci/lib.sh                             | 424 ++++++++++++++++----------
 ci/make-test-artifacts.sh             |  12 -
 ci/mount-fileshare.sh                 |  25 --
 ci/print-test-failures.sh             |  53 +---
 ci/run-build-and-tests.sh             |  54 ----
 ci/run-docker-build.sh                |  66 ----
 ci/run-docker.sh                      |  47 ---
 ci/run-static-analysis.sh             |  32 --
 ci/run-test-slice.sh                  |  17 --
 ci/select-test-slice.sh               |  13 +
 ci/test-documentation.sh              |  37 +--
 ci/util/extract-trash-dirs.sh         |  50 ---
 shared.mak                            |   1 +
 22 files changed, 508 insertions(+), 618 deletions(-)
 create mode 100755 ci/check-unignored-build-artifacts.sh
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-online_cpus.sh
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

Range-diff against v4:
 1:  ed27ca0b7e7 =  1:  84d8098e365 CI: run "set -ex" early in ci/lib.sh
 2:  737fe1e2c4c !  2:  3f5c071b0f6 CI: make "$jobname" explicit, remove fallback
    @@ ci/lib.sh
     +# Starting assertions
     +if test -z "$jobname"
     +then
    -+	echo "must set a CI jobname in the environment" >&2
    ++	echo "error: must set a CI jobname in the environment" >&2
     +	exit 1
     +fi
     +
 3:  d875069fc28 =  3:  c64845a4efb CI: remove more dead Travis CI support
 4:  2590459db33 =  4:  45856e67d5d CI: remove dead "tree skipping" code
 5:  e311ea8b9b3 =  5:  d4671148eb7 CI: remove unused Azure ci/* code
 6:  151f28e3818 =  6:  45ea80d0495 CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
 7:  6c2a8ee9c4e =  7:  a264b40ba0d CI: don't have "git grep" invoke a pager in tree content check
 8:  64a0a1fc8ce =  8:  4a58f7be8d4 CI: have "static-analysis" run a "make ci-static-analysis" target
 9:  0f780bf9e3c =  9:  78c0c81af43 CI: have "static-analysis" run "check-builtins", not "documentation"
10:  3cdeae9c141 = 10:  07e36035a1e CI: move p4 and git-lfs variables to ci/install-dependencies.sh
11:  1d3d357dcef = 11:  272bd590a95 CI: consistently use "export" in ci/lib.sh
12:  5ef0756d095 = 12:  ea35327e24c CI: export variables via a wrapper
13:  e0ce614eb6d ! 13:  f6ff81f48ab CI: remove "run-build-and-tests.sh", run "make [test]" directly
    @@ .github/workflows/main.yml: jobs:
                image: daald/ubuntu32:xenial
              - jobname: pedantic
                image: fedora
    -+          skip-tests: no
    ++          skip-tests: yes
          env:
            jobname: ${{matrix.vector.jobname}}
          runs-on: ubuntu-latest
    @@ .github/workflows/main.yml: jobs:
     +    - run: ci/lib.sh
     +    - run: make
     +    - run: make test
    -+      if: success() && matrix.vector.skip-tests != 'no'
    ++      if: success() && matrix.vector.skip-tests != 'yes'
          - run: ci/print-test-failures.sh
     -      if: failure()
    -+      if: failure() && matrix.vector.skip-tests != 'no'
    ++      if: failure() && matrix.vector.skip-tests != 'yes'
          - name: Upload failed tests' directories
            if: failure() && env.FAILED_TEST_ARTIFACTS != ''
            uses: actions/upload-artifact@v1
14:  a8e70124929 <  -:  ----------- ci/lib.sh: use "test" instead of "["
18:  eec7a11376e ! 14:  533dbc50c4f CI: make ci/install-dependencies.sh POSIX-compatible
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    CI: make ci/install-dependencies.sh POSIX-compatible
    +    CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
     
         Change the unportable constructs in the "ci/install-dependencies.sh"
         scripts to use POSIX replacements, and have it run under "/bin/sh"
    @@ Commit message
         "ci/install-docker-dependencies.sh", which doesn't have access to
         "bash".
     
    +    While we're at it change "if [" to "if test" in ci/lib.sh. This isn't
    +    strictly speaking a case of POSIX-incompatibility, but that syntax was
    +    being used there because this code was using idiomatic bash
    +    constructs. Let's have it use our usual style of "if test" instead.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/install-dependencies.sh ##
    @@ ci/install-dependencies.sh: ubuntu-latest)
      	# Uncomment this if you want to run perf tests:
      	# brew install gnu-time
      	brew link --force gettext
    +@@ ci/install-dependencies.sh: macos-latest)
    + 
    + 	if test -n "$CC_PACKAGE"
    + 	then
    +-		BREW_PACKAGE=${CC_PACKAGE/-/@}
    ++		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
    + 		brew install "$BREW_PACKAGE"
    + 		brew link "$BREW_PACKAGE"
    + 	fi
    +
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: ubuntu-latest)
    + 		break
    + 	fi
    + 
    +-	if [ "$jobname" = linux-gcc ]
    ++	if test "$jobname" = linux-gcc
    + 	then
    + 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
    + 	else
    +@@ ci/lib.sh: ubuntu-latest)
    + 	setenv --test GIT_TEST_HTTPD true
    + 	;;
    + macos-latest)
    +-	if [ "$jobname" = osx-gcc ]
    ++	if test "$jobname" = osx-gcc
    + 	then
    + 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
    + 	else
15:  bb335d1c0ca = 15:  6044c2b383f CI: check ignored unignored build artifacts in "win[+VS] build" too
16:  5458e6dab0b = 16:  4d1a9f88c32 CI: invoke "make artifacts-tar" directly in windows-build
17:  5e5a5b71700 = 17:  5c8f464a60f CI: split up and reduce "ci/test-documentation.sh"
19:  a9c98582de1 = 18:  a218be76819 CI: combine ci/install{,-docker}-dependencies.sh
20:  96e7eb68906 = 19:  83e21b4f501 CI: move "env" definitions into ci/lib.sh
21:  fdbe8554f5d = 20:  fd0e1610577 ci/run-test-slice.sh: replace shelling out with "echo"
22:  f257ab59971 ! 21:  0c7cd9d64ba CI: pre-select test slice in Windows & VS tests
    @@ ci/run-test-slice.sh => ci/select-test-slice.sh
      tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
      	t[0-9]*.sh))
     -make --quiet -C t T="$tests"
    -+echo T="$tests" >>$GITHUB_ENV
    ++if test -n "$GITHUB_ENV"
    ++then
    ++	echo T="$tests" >>$GITHUB_ENV
    ++fi
23:  1d95088da29 = 22:  1b077665352 CI: only invoke ci/lib.sh as "steps" in main.yml
24:  a7434b215db ! 23:  1867da7eddb CI: narrow down variable definitions in --build and --test
    @@ Commit message
         fewer, which makes diagnosing anything going on there easier, as we
         won't have to look at a deluge of e.g. GIT_TEST_* variables.
     
    +    For the "pedantic" job (which has no test phase) we won't run the
    +    "ci/lib.sh --test" step, which will be clearly visible as a skipped
    +    step in the UX.
    +
         Since we'll now always run "--build" for "make" and "--test" for "make
         test" we can stop setting the "fat" MAKEFLAGS entirely on the "test"
         steps, i.e. the one with PYTHON_PATH, CC etc. These will all be
    @@ .github/workflows/main.yml: jobs:
     +    - run: ci/lib.sh --build
          - run: make
     +    - run: ci/lib.sh --test
    ++      if: success() && matrix.vector.skip-tests != 'yes'
          - run: make test
    -       if: success() && matrix.vector.skip-tests != 'no'
    +       if: success() && matrix.vector.skip-tests != 'yes'
          - run: ci/print-test-failures.sh
     @@ .github/workflows/main.yml: jobs:
          steps:
    @@ .github/workflows/main.yml: jobs:
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: set -ex
    + # Helper libraries
      . ${0%/*}/lib-ci-type.sh
      
    ++# Parse options
    ++mode_build=
    ++mode_test=
    ++while test $# != 0
    ++do
    ++	case "$1" in
    ++	--build)
    ++		mode_build=t
    ++		;;
    ++	--test)
    ++		mode_test=t
    ++		;;
    ++	-*)
    ++		echo "error: invalid option: $1" >&2
    ++		exit 1
    ++		;;
    ++	*)
    ++		echo "error: invalid argument: $1" >&2
    ++		exit 1
    ++		;;
    ++	esac
    ++	shift
    ++done
    ++
      # Starting assertions
    -+mode=$1
    -+if test -z "$mode"
    + if test -z "$jobname"
    + then
    +@@ ci/lib.sh: then
    + 	exit 1
    + fi
    + 
    ++if test "$mode_test$mode_build" != "t"
     +then
    -+	echo "need a $0 mode, e.g. --build or --test" >&2
    ++	echo "error: need one mode, e.g. --build or --test" >&2
     +	exit 1
     +fi
     +
    - if test -z "$jobname"
    - then
    - 	echo "must set a CI jobname in the environment" >&2
    -@@ ci/lib.sh: setenv () {
    + # Helper functions
    + setenv () {
      	while test $# != 0
      	do
      		case "$1" in
    --		--build)
    --			;;
    --		--test)
    + 		--build)
    ++			if test -z "$mode_build"
    ++			then
    ++				return 0
    ++			fi
    + 			;;
    + 		--test)
     -			;;
     -		--all)
    -+		--build | --test)
    -+			if test "$1" != "$mode"
    ++			if test -z "$mode_test"
     +			then
     +				return 0
     +			fi
    -+
      			;;
      		-*)
      			echo "BUG: bad setenv() option '$1'" >&2
25:  78f4609a9c1 = 24:  a4e3a9d2c28 CI: add more variables to MAKEFLAGS, except under vs-build
26:  26a34f1d4b9 ! 25:  48d99cee809 CI: set CC in MAKEFLAGS directly, don't add it to the environment
    @@ Commit message
         "$jobname" to select packages & config, 2021-11-23), i.e. we're now
         aiming to only set those variables specific jobs need.
     
    +    Since we don't need to make this generic enough to handle "gcc-9"
    +    turning into "gcc@9" for "brew install" let's remove what was
    +    originally a bash-specific replacement in 707d2f2fe86 (CI: use
    +    "$runs_on_pool", not "$jobname" to select packages & config,
    +    2021-11-23), and which a preceding commit changed to a "tr"
    +    invocation.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
       libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
      
     +CC_PACKAGE=
    ++BREW_CC_PACKAGE=
     +case "$jobname" in
     +linux-gcc | linux-TEST-vars)
     +	CC_PACKAGE=gcc-8
     +	;;
     +osx-gcc)
    -+	CC_PACKAGE=gcc-9
    ++	BREW_CC_PACKAGE=gcc@9
     +	;;
     +esac
     +
      case "$runs_on_pool" in
      ubuntu-latest)
      	# The Linux build installs the defined dependency versions below.
    +@@ ci/install-dependencies.sh: macos-latest)
    + 	} ||
    + 	brew install homebrew/cask/perforce
    + 
    +-	if test -n "$CC_PACKAGE"
    ++	if test -n "$BREW_CC_PACKAGE"
    + 	then
    +-		BREW_PACKAGE=$(echo $CC_PACKAGE | tr '-' '@')
    +-		brew install "$BREW_PACKAGE"
    +-		brew link "$BREW_PACKAGE"
    ++		brew install "$BREW_CC_PACKAGE"
    ++		brew link "$BREW_CC_PACKAGE"
    + 	fi
    + 	;;
    + esac
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: setenv () {
27:  514de8d16b0 = 26:  07a6c087297 CI: set SANITIZE=leak in MAKEFLAGS directly
28:  6501059c594 = 27:  50f21ffdffe CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
29:  1bdcf1399d9 ! 28:  e35dff2bef3 CI: don't use "set -x" in "ci/lib.sh" output
    @@ Commit message
         script doesn't "set -x" and will act differently depending on the
         $CI_TYPE.
     
    +    It's useful when developing this script to see what variables
    +    it *doesn't* set, but such output isn't useful to users, so let's hide
    +    the "SKIP" output behind a --debug option.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    @@ ci/lib.sh
      
      # Helper libraries
      . ${0%/*}/lib-ci-type.sh
    +@@ ci/lib.sh: set -ex
    + # Parse options
    + mode_build=
    + mode_test=
    ++mode_debug=
    + while test $# != 0
    + do
    + 	case "$1" in
    + 	--build)
    ++		echo "MODE: $1" >&2
    + 		mode_build=t
    + 		;;
    + 	--test)
    ++		echo "MODE: $1" >&2
    + 		mode_test=t
    + 		;;
    ++	--debug)
    ++		echo "DEBUG: $1" >&2
    ++		mode_debug=t
    ++		;;
    + 	-*)
    + 		echo "error: invalid option: $1" >&2
    + 		exit 1
     @@ ci/lib.sh: then
      	exit 1
      fi
    @@ ci/lib.sh: then
     +echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
     +echo "CONFIG: jobname=$jobname" >&2
     +echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
    -+echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
     +if test -n "$GITHUB_ENV"
     +then
     +	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
     +fi
    ++echo >&2
     +
      # Helper functions
      setenv () {
    -+	local skip=
    ++	skip=
      	while test $# != 0
      	do
      		case "$1" in
    - 		--build | --test)
    - 			if test "$1" != "$mode"
    + 		--build)
    + 			if test -z "$mode_build"
    + 			then
    +-				return 0
    ++				skip=t
    + 			fi
    + 			;;
    + 		--test)
    + 			if test -z "$mode_test"
      			then
     -				return 0
     +				skip=t
      			fi
    - 
      			;;
    + 		-*)
     @@ ci/lib.sh: setenv () {
      	val=$2
      	shift 2
      
     +	if test -n "$skip"
     +	then
    -+		echo "SKIP '$key=$val'" >&2
    ++		if test -n "$mode_debug"
    ++		then
    ++			echo "SKIP: '$key=$val'" >&2
    ++		fi
     +		return 0
     +	fi
     +
30:  94abb826627 <  -:  ----------- CI: have osx-gcc use gcc, not clang
31:  4fc67e668da ! 29:  13d8c6997c3 CI: make it easy to use ci/*.sh outside of CI
    @@ Commit message
         Using "ci/lib.sh" as a stand-alone script is much more useful if it
         doesn't hardcode NPROC=10, let's provide a poor shellscript
         replacement for the online_cpus() we have in thread-utils.c to cover
    -    the most common OS's. It was suggested to use "2>&1" to invoke
    -    "command -v", but per my reading of [2] and my own testing that
    -    doesn't seem to be needed. Perhaps it's only needed for "which(1)"?
    -
    -    1. https://lore.kernel.org/git/214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com/
    -    2. https://pubs.opengroup.org/onlinepubs/009604499/utilities/command.html
    +    the most common OS's.
     
         Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ ci/lib-online_cpus.sh (new)
     +#!/bin/sh
     +
     +# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
    -+# that presents a chicken & egg problem. But if we move it to a
    -+# stand-oline command...
    ++# that currently presents a chicken & egg problem. We need this before
    ++# we build (much of) anything.
     +online_cpus() {
     +	NPROC=
     +
    @@ ci/lib.sh
      #!/bin/sh
      set -e
      
    -+#  Usage
    ++# Usage
     +CI_TYPE_HELP_COMMANDS='
     +	# run "make all test" like the "linux-leaks" job
     +	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)
    @@ ci/lib.sh
     +'
     +
     +CI_TYPE_HELP="
    -+running $0 outside of CI? You can use ci/lib.sh to set up your
    ++Running $0 outside of CI? You can use ci/lib.sh to set up your
     +environment like a given CI job. E.g.:
     +$CI_TYPE_HELP_COMMANDS
    -+
    -+note that some of these (e.g. the linux-musl one) may not work as
    ++Note that some of these (e.g. the linux-musl one) may not work as
     +expected due to the CI job configuring a platform that may not match
     +yours."
     +
    - # Helper libraries
    - . ${0%/*}/lib-ci-type.sh
    - 
    -@@ ci/lib.sh: mode=$1
    - if test -z "$mode"
    - then
    - 	echo "need a $0 mode, e.g. --build or --test" >&2
    ++usage() {
    ++	echo "usage: jobname=<job-name> [runs_on_pool=<pool-name>] $0 (--build | --test)" >&2
     +	if test -z "$CI_TYPE"
     +	then
     +		echo "$CI_TYPE_HELP" >&2
     +	fi
    - 	exit 1
    ++	exit 1
    ++}
    ++
    + # Helper libraries
    + . ${0%/*}/lib-ci-type.sh
    + 
    + # Parse options
    ++mode_all=
    + mode_build=
    + mode_test=
    + mode_debug=
    + while test $# != 0
    + do
    + 	case "$1" in
    ++	--all)
    ++		echo "MODE: $1" >&2
    ++		mode_all=t
    ++		mode_build=t
    ++		mode_test=t
    ++		;;
    + 	--build)
    + 		echo "MODE: $1" >&2
    + 		mode_build=t
    +@@ ci/lib.sh: do
    + 		;;
    + 	-*)
    + 		echo "error: invalid option: $1" >&2
    +-		exit 1
    ++		usage
    + 		;;
    + 	*)
    + 		echo "error: invalid argument: $1" >&2
    +-		exit 1
    ++		usage
    + 		;;
    + 	esac
    + 	shift
    +@@ ci/lib.sh: done
    + if test -z "$jobname"
    + then
    + 	echo "error: must set a CI jobname in the environment" >&2
    +-	exit 1
    ++	usage
      fi
      
    +-if test "$mode_test$mode_build" != "t"
    ++if test "$mode_test$mode_build" != "t" && test -z "$mode_all"
    + then
    + 	echo "error: need one mode, e.g. --build or --test" >&2
    +-	exit 1
    ++	usage
    + fi
    + 
    + # Show our configuration
     @@ ci/lib.sh: setenv () {
      	do
      		case "$1" in
    - 		--build | --test)
    --			if test "$1" != "$mode"
    -+			if test "$1" != "$mode" && test "$mode" != "--all"
    + 		--build)
    +-			if test -z "$mode_build"
    ++			if test -z "$mode_build$mode_all"
    + 			then
    + 				skip=t
    + 			fi
    + 			;;
    + 		--test)
    +-			if test -z "$mode_test"
    ++			if test -z "$mode_test$mode_all"
      			then
      				skip=t
      			fi
-- 
2.36.0.879.g3659959fcca

