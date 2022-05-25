Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC5C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiEYKE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371576D84B
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c9-20020a7bc009000000b0039750ec5774so3007827wmb.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ns6obRq4kNkwGpc/+ioHIGMKVirKKf+Je0HKhrnH+4=;
        b=J9k6M6i7rl4z09nyC3JYmcjgYbHRo9uo65N8c+5br5K7Z1Rq927K3uzMlY7mjLyo4j
         38e8eoGjr2Lb9aEBVuVatUmPZOc2jwWf5Yp8aMVqy/3ct2uOWVv26adv1tr5O+8Cwkj1
         /uyhFi4K/Yk6mvSoc4iFAJVXEYDB+ArySTGyS/FyYTxvyC8jv4rITIzCuKrSZeWaaIlu
         d1dOCeVVLeoZysB72DGFkVYl4AA439qBMjAIueooVa80p0IiSjrDsVpni654NFxdcrfX
         dGWEa6rwmywomlfTWYSafYJ9u297q56OMAvw2oUmDsVUhcnaE13Sq4EtZTvcM3qQDQ0Q
         K2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ns6obRq4kNkwGpc/+ioHIGMKVirKKf+Je0HKhrnH+4=;
        b=5Sz5aloIhLPmvWS/FGeDinX9hNZzZTpxQwWHwDyidqChCsrjZEjL5FnlDxMblUSnMP
         SLG9NXaXMIH1eTENFkanA/XZFAPIvl9i9ageRX1QgCOOfRtsHeWfK8W4FvfSoOMTjmur
         3apUrWzOV5SXERrir3aNC4+NrPSBRuasYjvG1y/cjWd4a8DSAM7yNptYXqnRu5nz56th
         V6GB/nR5n2OrLz3sAiHGtINhc+JnuLyV/o/1qFFUwJB5OSt5VU4xE8Jsz5E0HNGixFFI
         dcPLZDSQXMaOMbpMKuueK33aK89ktkErtIPlywRmWxJkIUVDT37s3gdApTK0OiMvbx+b
         9Ilg==
X-Gm-Message-State: AOAM533rMT+qXviJGL5JksdyWvXU4Q5hlPc0xfK/HpQoP0voNTJAILI7
        SNvwgui+LN49In/KTXc7EOSpB9P+wYivOw==
X-Google-Smtp-Source: ABdhPJwMA1+wR1nDubhAE8R+nv2JM7MNPpuKF59avi88SDsrGXv/oASKLNPK0osoehxHwDkKS/+FyQ==
X-Received: by 2002:a7b:c109:0:b0:397:43ef:b66f with SMTP id w9-20020a7bc109000000b0039743efb66fmr7355122wmi.44.1653473051817;
        Wed, 25 May 2022 03:04:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:11 -0700 (PDT)
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
Subject: [PATCH v6 00/29] CI: run "make" in CI "steps", improve UX
Date:   Wed, 25 May 2022 12:03:39 +0200
Message-Id: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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

The only changes since v5 are to rebase this on an updated "master",
which had some small fixes in the ci/ directory. For the last
iteration see:
https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com/

I'll follow this up with a re-roll of
https://lore.kernel.org/git/RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com/
which is a replacement for
https://lore.kernel.org/git/pull.1117.v3.git.1653171536.gitgitgadget@gmail.com/
based on this topic.

To view the CI output differences this topic makes see these two runs:

  master: https://github.com/avar/git/actions/runs/2377697338
  this: https://github.com/avar/git/actions/runs/2377257487

These runs have a commit on top to trigger CI build and test failures
in various areas. One example is here:

 master: https://github.com/avar/git/runs/6573059000?check_suite_focus=true
 this: https://github.com/avar/git/runs/6571804790?check_suite_focus=true

This shows that we fail on "make" instead of a monolothic
"ci/run-build-and-test.sh" step. Furthermore we can see that a
preceding "ci/lib.sh --build" step has been added to set & export (via
$GITHUB_ENV) the full set of variables "make" will use in the failing
step. Those are then visible at (click to expand it):

  https://github.com/avar/git/runs/6571804790?check_suite_focus=true#step:5:1

For every step we now do the same, i.e. it's immediately obvious what
parameters go into running that step. The last step in this series
then makes it easy to run builds and tests "like CI" using the same
tooling:

	$ ci/lib.sh 
	error: must set a CI jobname in the environment
	usage: jobname=<job-name> [runs_on_pool=<pool-name>] ci/lib.sh (--build | --test)

	Running ci/lib.sh outside of CI? You can use ci/lib.sh to set up your
	environment like a given CI job. E.g.:

	        # run "make all test" like the "linux-leaks" job
	        (eval $(jobname=linux-leaks ci/lib.sh --all) && make test)

	        # run "make all test" like the "linux-musl" job
	        (eval $(jobname=linux-musl ci/lib.sh --all) && make test)

	        # run "make test" like the "linux-TEST-vars" job (uses various GIT_TEST_* modes)
	        make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)

	        # run "make test" like the "linux-sha256" job
	        make && (eval $(jobname=linux-sha256 ci/lib.sh --test) && make test)

	Note that some of these (e.g. the linux-musl one) may not work as
	expected due to the CI job configuring a platform that may not match
	yours.

As noted in the usage this can then be directly eval'd:

	$ jobname=osx-gcc ci/lib.sh --build 2>/dev/null 
	MAKEFLAGS="j8 DEVELOPER=1 SKIP_DASHED_BUILT_INS=YesPlease PYTHON_PATH=/usr/bin/python3 CC=gcc"
	export MAKEFLAGS

Of course YMMV when doing so, running that on my Linux box won't
magically give me an OSX environment. But it's very useful to be able
to to e.g.:

	jobname=linux-TEST-vars ci/lib.sh --test

Which allows myself and others to tweak our local build scripts to
test things locally with setups that mirror these CI setups as far as
GIT_TEST_* etc. parameters are concerned.

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

Range-diff against v5:
 1:  84d8098e365 =  1:  25cb08ad06c CI: run "set -ex" early in ci/lib.sh
 2:  3f5c071b0f6 =  2:  1be7910c728 CI: make "$jobname" explicit, remove fallback
 3:  c64845a4efb !  3:  234e248e831 CI: remove more dead Travis CI support
    @@ ci/lib.sh: then
     -	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
     -	CI_REPO_SLUG="$GITHUB_REPOSITORY"
      	CI_JOB_ID="$GITHUB_RUN_ID"
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
      	DONT_SKIP_TAGS=t
     @@ ci/lib.sh: then
      	export GIT_PROVE_OPTS="--timer --jobs 10"
 4:  45856e67d5d !  4:  36a6287ee9b CI: remove dead "tree skipping" code
    @@ ci/lib.sh: then
     -	CI_BRANCH="$GITHUB_REF"
     -	CI_COMMIT="$GITHUB_SHA"
     -	CI_JOB_ID="$GITHUB_RUN_ID"
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
     -	DONT_SKIP_TAGS=t
     -
     -	cache_dir="$HOME/none"
 5:  d4671148eb7 !  5:  66b0a383daf CI: remove unused Azure ci/* code
    @@ ci/install-dependencies.sh: macos-latest)
     -	test -z "$BREW_INSTALL_PACKAGES" ||
     -	brew install $BREW_INSTALL_PACKAGES
      	brew link --force gettext
    - 	brew install --cask --no-quarantine perforce || {
    - 		# Update the definitions and try again
    + 	mkdir -p $HOME/bin
    + 	(
     @@ ci/install-dependencies.sh: Documentation)
      	sudo apt-get -q update
      	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
    @@ ci/lib.sh: export TERM=${TERM:-dumb}
     +if test "$GITHUB_ACTIONS" = "true"
      then
      	CI_TYPE=github-actions
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
     
      ## ci/mount-fileshare.sh (deleted) ##
     @@
 6:  45ea80d0495 !  6:  d96333c1bd8 CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
    @@ ci/lib.sh: check_unignored_build_artifacts ()
      if test "$GITHUB_ACTIONS" = "true"
      then
      	CI_TYPE=github-actions
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
      
     -	export GIT_PROVE_OPTS="--timer --jobs 10"
     +	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
 7:  a264b40ba0d =  7:  d0780ab4a96 CI: don't have "git grep" invoke a pager in tree content check
 8:  4a58f7be8d4 =  8:  84e368736e2 CI: have "static-analysis" run a "make ci-static-analysis" target
 9:  78c0c81af43 =  9:  1a9c98b909c CI: have "static-analysis" run "check-builtins", not "documentation"
10:  07e36035a1e ! 10:  e208a9ab1e2 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
    @@ ci/install-dependencies.sh
      
      . ${0%/*}/lib.sh
      
    --P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
    +-P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
     -LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
      UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
       tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
    @@ ci/install-dependencies.sh
     +	GIT_LFS_PATH="$HOME/custom/git-lfs"
     +	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
     +
    -+	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
    ++	P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
     +	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
     +
      	sudo apt-get -q update
11:  272bd590a95 ! 11:  9655bae9e21 CI: consistently use "export" in ci/lib.sh
    @@ ci/lib.sh: export TERM=${TERM:-dumb}
      if test "$GITHUB_ACTIONS" = "true"
      then
     @@ ci/lib.sh: then
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
      
      	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
     -	export GIT_TEST_OPTS="--verbose-log -x"
12:  ea35327e24c ! 12:  2da0aa1d40e CI: export variables via a wrapper
    @@ ci/lib.sh: check_unignored_build_artifacts ()
      NPROC=10
     @@ ci/lib.sh: then
      	CI_TYPE=github-actions
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
      
     -	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
     +	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
13:  f6ff81f48ab ! 13:  6e97633652e CI: remove "run-build-and-tests.sh", run "make [test]" directly
    @@ ci/install-dependencies.sh: ubuntu-latest)
     +		echo "$PATH" >>"$GITHUB_PATH"
     +	fi
      
    - 	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
    + 	P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
      	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
     
      ## ci/lib.sh ##
14:  533dbc50c4f = 14:  0488e29859b CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
15:  6044c2b383f = 15:  f7ac6c33044 CI: check ignored unignored build artifacts in "win[+VS] build" too
16:  4d1a9f88c32 = 16:  f89346f11eb CI: invoke "make artifacts-tar" directly in windows-build
17:  5c8f464a60f = 17:  7fa9c69e3ca CI: split up and reduce "ci/test-documentation.sh"
18:  a218be76819 ! 18:  7925b2610fc CI: combine ci/install{,-docker}-dependencies.sh
    @@ ci/install-dependencies.sh: linux-gcc-default)
     +	;;
      esac
      
    - if type p4d >/dev/null && type p4 >/dev/null
    + if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
     
      ## ci/install-docker-dependencies.sh (deleted) ##
     @@
19:  83e21b4f501 = 19:  b00abc07637 CI: move "env" definitions into ci/lib.sh
20:  fd0e1610577 = 20:  bb5960355fe ci/run-test-slice.sh: replace shelling out with "echo"
21:  0c7cd9d64ba = 21:  1eeb2e8e7f0 CI: pre-select test slice in Windows & VS tests
22:  1b077665352 ! 22:  39979d9887d CI: only invoke ci/lib.sh as "steps" in main.yml
    @@ ci/lib.sh: setenv () {
     -	CI_TYPE=github-actions
     +case "$CI_TYPE" in
     +github-actions)
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
      
      	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
     @@ ci/lib.sh: then
23:  1867da7eddb = 23:  e2b3bf032d6 CI: narrow down variable definitions in --build and --test
24:  a4e3a9d2c28 ! 24:  c6f47d52823 CI: add more variables to MAKEFLAGS, except under vs-build
    @@ ci/lib.sh: COMMON_MAKEFLAGS=--jobs=$NPROC
     +
      case "$CI_TYPE" in
      github-actions)
    - 	CC="${CC:-gcc}"
    + 	CC="${CC_PACKAGE:-${CC:-gcc}}"
     @@ ci/lib.sh: github-actions)
      	;;
      esac
25:  48d99cee809 ! 25:  377460e8024 CI: set CC in MAKEFLAGS directly, don't add it to the environment
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      ubuntu-latest)
      	# The Linux build installs the defined dependency versions below.
     @@ ci/install-dependencies.sh: macos-latest)
    - 	} ||
    - 	brew install homebrew/cask/perforce
    + 	PATH="$PATH:${HOME}/bin"
    + 	export PATH
      
     -	if test -n "$CC_PACKAGE"
     +	if test -n "$BREW_CC_PACKAGE"
    @@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
      
      case "$CI_TYPE" in
      github-actions)
    --	CC="${CC:-gcc}"
    +-	CC="${CC_PACKAGE:-${CC:-gcc}}"
     -
      	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
      	GIT_TEST_OPTS="--verbose-log -x"
26:  07a6c087297 = 26:  98e320d5e67 CI: set SANITIZE=leak in MAKEFLAGS directly
27:  50f21ffdffe = 27:  282b7c89a4f CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
28:  e35dff2bef3 = 28:  7a208927819 CI: don't use "set -x" in "ci/lib.sh" output
29:  13d8c6997c3 = 29:  4d8a8f3be07 CI: make it easy to use ci/*.sh outside of CI
-- 
2.36.1.1045.gf356b5617dd

