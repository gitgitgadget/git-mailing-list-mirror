Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C7C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbiDRQb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344662AbiDRQbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2E82FFC0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so11287547wrc.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDe8t/x5+WUUS4SOtXrPqKR+w60bAiNijmvB3nHSKms=;
        b=QMuOGjSPpfJNjBdt/mZ+duRjXcwq/lJyU6s4oJRQaM619APqQ+jkiifCyGWvw3BryS
         neSuRocmLozWj+DQG8ZyN7fhXpEnkCVTmzeEHZKAOf8TjqVSOCDtByEzGazoNM/5x4mg
         hGhJJe5P1CIzM4WF7KevSSfIvV7y8ijcyLPt51bFakGL4TvOaip44k9KwGLBx8dMjWDj
         VABtxEgdNeGtsKDEoqYbyPpKPqqnnxnKqENnRgOwjmI1HjpoaaHk/7C8FA7iqCQqaKY/
         fYcFlGw862b/+GnhSdgkGg1YAwj+WVMLiul0wjfMlAI7qQKyTFmpQzk9RrHC9r3oI4nf
         +hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDe8t/x5+WUUS4SOtXrPqKR+w60bAiNijmvB3nHSKms=;
        b=K//Yt0SGwHG2Q/AKFP1sfB2FZGOU9DLrruBZkbzukD5o3cyDNDQ6/IbG9mzosjKs4c
         46sCCWyV5zakHW5M7irASRDslJ88IvzP0qcUOtIpscVeUeaejNmUfu46JAE7HxClsgqv
         hBGbbTl1tRMyQSrG3dU9tNiw7vp7BEXsUMPv8f9JQ2quwpB6tqd8dQiRH3fzObu30o6O
         46KIpKxqzAJSFMndiPkP6OapsRH3dTeODYu3Ogz8FDUFzbYN/D3gd6KHyHbd4E2NGCOY
         4Y0wd3+k7VI6tskGUbDFRXwB+r/bHpvgXW2DxW+JgJ5EXS5VBXrScRsX7E/JcicoelVZ
         bBiQ==
X-Gm-Message-State: AOAM532XEFh0PX+/a4ouCvkzfGx7ppG7amhOE2SLkdC/xhqFXNaPC/MG
        J3JTFLME9+DEPZ2TDrxCNSbRAISAtfM=
X-Google-Smtp-Source: ABdhPJxo6LytlcwtRD9Vv5pTCA2gy4io5JiDAKhHIVmSW6S/K3ehHeMhXJKD0gHhNWAUf0v0cPFbVg==
X-Received: by 2002:a5d:59af:0:b0:20a:8428:1902 with SMTP id p15-20020a5d59af000000b0020a84281902mr9333925wrr.282.1650299351575;
        Mon, 18 Apr 2022 09:29:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:11 -0700 (PDT)
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
Subject: [PATCH v4 00/31] CI: run "make" in CI "steps", improve UX
Date:   Mon, 18 Apr 2022 18:28:37 +0200
Message-Id: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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

Changes since v3:

 * Typo/grammar fixes pointed out by Eric Sunshine

 * The ci/print-test-failures.sh scripts still had some dead Travis
   code (noticed while re-rolling). Removed it, and squashed into the
   travis removal commit.

 * Split up the part of "CI: combine
   ci/install{,-docker}-dependencies.sh" that was replacing bash
   constructs with POSIX ones into a preceding commit doing only that.

 * There was a regression in "CI: set CC in MAKEFLAGS directly, don't
   add it to the environment" where we didn't properly install the
   right CI package. The whole CC_PACKAGE is now contained within
   "ci/install-dependencies.sh".

 * In addition to the regression Carlo noted already on "master" where
   the osx-gcc job is using clang. That's now fixed in a new "CI: have
   osx-gcc use gcc, not clang".

 * Extend the last commit to have an "nproc" on BSD/OSX/Windows too,
   this is only for the case of ad-hoc running ci/lib.sh locally.

Ævar Arnfjörð Bjarmason (31):
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
  ci/lib.sh: use "test" instead of "["
  CI: check ignored unignored build artifacts in "win[+VS] build" too
  CI: invoke "make artifacts-tar" directly in windows-build
  CI: split up and reduce "ci/test-documentation.sh"
  CI: make ci/install-dependencies.sh POSIX-compatible
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
  CI: have osx-gcc use gcc, not clang
  CI: make it easy to use ci/*.sh outside of CI

 .github/workflows/main.yml            | 100 ++++---
 Makefile                              |  31 ++-
 ci/check-directional-formatting.bash  |   2 +-
 ci/check-unignored-build-artifacts.sh |  20 ++
 ci/install-dependencies.sh            |  74 ++++-
 ci/install-docker-dependencies.sh     |  22 --
 ci/lib-ci-type.sh                     |   6 +
 ci/lib-online_cpus.sh                 |  26 ++
 ci/lib-tput.sh                        |   5 +
 ci/lib.sh                             | 379 +++++++++++++++-----------
 ci/make-test-artifacts.sh             |  12 -
 ci/mount-fileshare.sh                 |  25 --
 ci/print-test-failures.sh             |  53 +---
 ci/run-build-and-tests.sh             |  54 ----
 ci/run-docker-build.sh                |  66 -----
 ci/run-docker.sh                      |  47 ----
 ci/run-static-analysis.sh             |  32 ---
 ci/run-test-slice.sh                  |  17 --
 ci/select-test-slice.sh               |  10 +
 ci/test-documentation.sh              |  37 +--
 ci/util/extract-trash-dirs.sh         |  50 ----
 shared.mak                            |   1 +
 22 files changed, 453 insertions(+), 616 deletions(-)
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

Range-diff against v3:
 1:  3cb4749c5ea =  1:  ed27ca0b7e7 CI: run "set -ex" early in ci/lib.sh
 2:  7de95ff437e =  2:  737fe1e2c4c CI: make "$jobname" explicit, remove fallback
 3:  820c4e551d9 !  3:  d875069fc28 CI: remove more dead Travis CI support
    @@ Commit message
         would do the wrong thing, because the different test slices would each
         try to clobber the same "t/.prove" file.
     
    -    If a subsequent run then used the -"-state=failed,slow,save" it would
    +    If a subsequent run then used the "--state=failed,slow,save" it would
         defeat the purpose of "ci/run-test-slice.sh", since all slices would
         then run all tests. I.e. behavior of prove's "--state" options is to
         select tests to run from the provided "--state" file, in addition to
    @@ Commit message
         ".github/workflows/main.yml" calls the same entry points as the main
         "regular" job.
     
    +    For "ci/print-test-failures.sh" the creation of the tarball added in
    +    aea8879a6ac (travis-ci: include the trash directories of failed tests
    +    in the trace log, 2018-08-01) has been dead since my 4a6e4b96026,
    +    which removed the fall-through case from the "case/esac" statement.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    @@ ci/lib.sh: then
      	echo "Could not identify CI type" >&2
     
      ## ci/print-test-failures.sh ##
    -@@ ci/print-test-failures.sh: do
    - 			fi
    - 			combined_trash_size=$new_combined_trash_size
    +@@ ci/print-test-failures.sh: then
    + 	exit
    + fi
      
    +-case "$jobname" in
    +-osx-clang|osx-gcc)
    +-	# base64 in OSX doesn't wrap its output at 76 columns by
    +-	# default, but prints a single, very long line.
    +-	base64_opts="-b 76"
    +-	;;
    +-esac
    +-
    +-combined_trash_size=0
    + for TEST_EXIT in test-results/*.exit
    + do
    + 	if [ "$(cat "$TEST_EXIT")" != "0" ]
    +@@ ci/print-test-failures.sh: do
    + 		azure-pipelines)
    + 			mkdir -p failed-test-artifacts
    + 			mv "$trash_dir" failed-test-artifacts
    +-			continue
    + 			;;
    + 		github-actions)
    + 			mkdir -p failed-test-artifacts
    + 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
    + 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
    + 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
    +-			continue
    + 			;;
    + 		*)
    + 			echo "Unhandled CI type: $CI_TYPE" >&2
    + 			exit 1
    + 			;;
    + 		esac
    +-		trash_tgz_b64="trash.$test_name.base64"
    +-		if [ -d "$trash_dir" ]
    +-		then
    +-			tar czp "$trash_dir" |base64 $base64_opts >"$trash_tgz_b64"
    +-
    +-			trash_size=$(wc -c <"$trash_tgz_b64")
    +-			if [ $trash_size -gt 1048576 ]
    +-			then
    +-				# larger than 1MB
    +-				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, it's too big$(tput sgr0)"
    +-				continue
    +-			fi
    +-
    +-			new_combined_trash_size=$(($combined_trash_size + $trash_size))
    +-			if [ $new_combined_trash_size -gt 1048576 ]
    +-			then
    +-				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, there is plenty of trash in there already.$(tput sgr0)"
    +-				continue
    +-			fi
    +-			combined_trash_size=$new_combined_trash_size
    +-
     -			# DO NOT modify these two 'echo'-ed strings below
     -			# without updating 'ci/util/extract-trash-dirs.sh'
     -			# as well.
    - 			echo "$(tput setaf 1)Start of trash directory of '$test_name':$(tput sgr0)"
    - 			cat "$trash_tgz_b64"
    - 			echo "$(tput setaf 1)End of trash directory of '$test_name'$(tput sgr0)"
    +-			echo "$(tput setaf 1)Start of trash directory of '$test_name':$(tput sgr0)"
    +-			cat "$trash_tgz_b64"
    +-			echo "$(tput setaf 1)End of trash directory of '$test_name'$(tput sgr0)"
    +-		fi
    + 	fi
    + done
     
      ## ci/run-build-and-tests.sh ##
     @@
 4:  914e81118b8 =  4:  2590459db33 CI: remove dead "tree skipping" code
 5:  b2e456f9a9b !  5:  e311ea8b9b3 CI: remove unused Azure ci/* code
    @@ ci/print-test-failures.sh: do
     -		azure-pipelines)
     -			mkdir -p failed-test-artifacts
     -			mv "$trash_dir" failed-test-artifacts
    --			continue
     -			;;
      		github-actions)
      			mkdir -p failed-test-artifacts
 6:  30968e36bdd =  6:  151f28e3818 CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
 7:  cc81b9fe37e =  7:  6c2a8ee9c4e CI: don't have "git grep" invoke a pager in tree content check
 8:  2387b0c5842 =  8:  64a0a1fc8ce CI: have "static-analysis" run a "make ci-static-analysis" target
 9:  54a4d79bf8d =  9:  0f780bf9e3c CI: have "static-analysis" run "check-builtins", not "documentation"
10:  9a31b7d5011 = 10:  3cdeae9c141 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
11:  8ab4e81e1ca = 11:  1d3d357dcef CI: consistently use "export" in ci/lib.sh
12:  9fe00566767 = 12:  5ef0756d095 CI: export variables via a wrapper
13:  13feda050c0 ! 13:  e0ce614eb6d CI: remove "run-build-and-tests.sh", run "make [test]" directly
    @@ Commit message
     
            Now that verbosity is in the earlier "ci/lib.sh" step, and not in
            any subsequent one. The "make" targets then start out with the
    -       relevant output non-trace output right away.
    +       relevant non-trace output right away.
     
          * If we do want to use the grouping syntax within a "step" it'll now
            be easier to do so. It doesn't support nesting, so we'd have to
14:  d3909b8e896 = 14:  a8e70124929 ci/lib.sh: use "test" instead of "["
15:  d63a689eae0 = 15:  bb335d1c0ca CI: check ignored unignored build artifacts in "win[+VS] build" too
16:  ac1ffe9c642 = 16:  5458e6dab0b CI: invoke "make artifacts-tar" directly in windows-build
17:  8837bfa5433 ! 17:  5e5a5b71700 CI: split up and reduce "ci/test-documentation.sh"
    @@ Commit message
         parts in as one command in the CI job itself, and to run the two "make
         doc" commands at the top-level.
     
    -    It'll now be obvious from the title of the step if if we failed in the
    +    It'll now be obvious from the title of the step if we failed in the
         asciidoc or asciidoctor step.
     
         Since the "check_unignored_build_artifacts()" function is now only
 -:  ----------- > 18:  eec7a11376e CI: make ci/install-dependencies.sh POSIX-compatible
18:  aa491990c1a ! 19:  a9c98582de1 CI: combine ci/install{,-docker}-dependencies.sh
    @@ Commit message
         statement in the latter only cared about "$jobname", and can be folded
         into the same "case" statement in the former.
     
    -    The reason they split up is historical, and because the
    -    "ci/install-dependencies.sh" used "ci/lib.sh", which requires
    -    "bash". At least one of the docker containers doesn't have "bash". To
    -    make the existing code POSIX-compatible we need to replace pushd/popd
    -    with a sub-shell, but no other changes were needed.
    +    The reason they split up is historical, until a preceding commit
    +    "ci/lib.sh" required "bash", which might not have been available in
    +    "docker".
     
         This also fixes issue in "ci/install-docker-dependencies.sh" where
         we'd hide errors due to not using "set -e". Now that we include
    @@ .github/workflows/main.yml: jobs:
          - run: make test
     
      ## ci/install-dependencies.sh ##
    -@@
    --#!/usr/bin/env bash
    -+#!/bin/sh
    - #
    - # Install dependencies required to build and test Git on Linux and macOS
    - #
    -@@ ci/install-dependencies.sh: ubuntu-latest)
    - 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
    - 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
    - 	mkdir --parents "$P4_PATH"
    --	pushd "$P4_PATH"
    -+	(
    -+		cd "$P4_PATH"
    - 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
    - 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
    - 		chmod u+x p4d
    - 		chmod u+x p4
    --	popd
    -+	)
    - 	mkdir --parents "$GIT_LFS_PATH"
    --	pushd "$GIT_LFS_PATH"
    -+	(
    -+		cd "$GIT_LFS_PATH"
    - 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
    - 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
    - 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
    --	popd
    -+	)
    - 	;;
    - macos-latest)
    - 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
     @@ ci/install-dependencies.sh: linux-gcc-default)
      	sudo apt-get -q update
      	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
19:  39b13298425 = 20:  96e7eb68906 CI: move "env" definitions into ci/lib.sh
20:  0a92c478d28 = 21:  fdbe8554f5d ci/run-test-slice.sh: replace shelling out with "echo"
21:  16ac7f5c210 = 22:  f257ab59971 CI: pre-select test slice in Windows & VS tests
22:  939ef573b75 = 23:  1d95088da29 CI: only invoke ci/lib.sh as "steps" in main.yml
23:  8e79c3e39e0 = 24:  a7434b215db CI: narrow down variable definitions in --build and --test
24:  d1d5c1e2f65 = 25:  78f4609a9c1 CI: add more variables to MAKEFLAGS, except under vs-build
25:  1268792233f ! 26:  26a34f1d4b9 CI: set CC in MAKEFLAGS directly, don't add it to the environment
    @@ Metadata
      ## Commit message ##
         CI: set CC in MAKEFLAGS directly, don't add it to the environment
     
    -    Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
    -    picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
    -    directly to MAKEFLAGS.
    +    Rather than pass a "$CC" in the environment to be picked up in
    +    ci/lib.sh let's instead have ci/lib.sh itself add it directly to
    +    MAKEFLAGS. For "$CC_PACKAGE" its setting and use can stay within
    +    ci/install-dependencies.sh.
     
         Setting CC=gcc by default made for confusing trace output, and since a
         preceding change to carry it and others over across "steps" in the
         GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
         confusingly has CC=gcc set, even though it builds with MSVC.
     
    -    Let's instead reply on the Makefile default of CC=cc, and only
    -    override it for those jobs where it's needed. This does mean that
    -    we'll need to set it for the "pedantic" job, which previously relied
    -    on the default CC=gcc in case "clang" become the default on that
    -    platform.
    +    Let's instead rely on the Makefile default of CC=cc, and only override
    +    it for those jobs where it's needed. This does mean that we'll need to
    +    set it for the "pedantic" job, which previously relied on the default
    +    CC=gcc in case "clang" become the default on that platform.
     
         This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
         "$jobname" to select packages & config, 2021-11-23), i.e. we're now
    @@ .github/workflows/main.yml: jobs:
            runs_on_pool: ${{matrix.vector.pool}}
          runs-on: ${{matrix.vector.pool}}
     
    + ## ci/install-dependencies.sh ##
    +@@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
    +  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
    +  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
    + 
    ++CC_PACKAGE=
    ++case "$jobname" in
    ++linux-gcc | linux-TEST-vars)
    ++	CC_PACKAGE=gcc-8
    ++	;;
    ++osx-gcc)
    ++	CC_PACKAGE=gcc-9
    ++	;;
    ++esac
    ++
    + case "$runs_on_pool" in
    + ubuntu-latest)
    + 	# The Linux build installs the defined dependency versions below.
    +
      ## ci/lib.sh ##
     @@ ci/lib.sh: setenv () {
      	fi
    @@ ci/lib.sh: setenv () {
      
     +# Clear variables that may come from the outside world.
     +CC=
    -+CC_PACKAGE=
     +
      # How many jobs to run in parallel?
      NPROC=10
    @@ ci/lib.sh: vs-test)
      	;;
      linux-gcc)
     +	CC=gcc
    -+	CC_PACKAGE=gcc-8
      	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
      	;;
     +linux-gcc-default)
    @@ ci/lib.sh: vs-test)
     +	;;
      linux-TEST-vars)
     +	CC=gcc
    -+	CC_PACKAGE=gcc-8
      	setenv --test GIT_TEST_SPLIT_INDEX yes
      	setenv --test GIT_TEST_MERGE_ALGORITHM recursive
      	setenv --test GIT_TEST_FULL_IN_PACK_ARRAY true
    @@ ci/lib.sh: linux-TEST-vars)
      	;;
     +osx-gcc)
     +	CC=gcc
    -+	CC_PACKAGE=gcc-9
     +	;;
     +osx-clang)
     +	CC=clang
26:  83138dacd3e = 27:  514de8d16b0 CI: set SANITIZE=leak in MAKEFLAGS directly
27:  0508777c68e ! 28:  6501059c594 CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
    @@ ci/lib.sh: linux-TEST-vars)
      osx-gcc)
     +	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
      	CC=gcc
    - 	CC_PACKAGE=gcc-9
      	;;
      osx-clang)
     +	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
28:  c0ce0fd3a80 = 29:  1bdcf1399d9 CI: don't use "set -x" in "ci/lib.sh" output
 -:  ----------- > 30:  94abb826627 CI: have osx-gcc use gcc, not clang
29:  2e3c02fa0df ! 31:  4fc67e668da CI: make it easy to use ci/*.sh outside of CI
    @@ Commit message
         environment if we're outside of CI, in case the user has e.g. "jN" or
         other flags to "make" that they'd prefer configured already.
     
    +    Using "ci/lib.sh" as a stand-alone script is much more useful if it
    +    doesn't hardcode NPROC=10, let's provide a poor shellscript
    +    replacement for the online_cpus() we have in thread-utils.c to cover
    +    the most common OS's. It was suggested to use "2>&1" to invoke
    +    "command -v", but per my reading of [2] and my own testing that
    +    doesn't seem to be needed. Perhaps it's only needed for "which(1)"?
    +
    +    1. https://lore.kernel.org/git/214f8670-91d5-f4b6-efa1-76966c3ab1ee@sunshineco.com/
    +    2. https://pubs.opengroup.org/onlinepubs/009604499/utilities/command.html
    +
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib-ci-type.sh ##
    @@ ci/lib-ci-type.sh
     -	exit 1
      fi
     
    + ## ci/lib-online_cpus.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++# TODO: Ideally we'd compile t/helper/test-online-cpus.c early, but
    ++# that presents a chicken & egg problem. But if we move it to a
    ++# stand-oline command...
    ++online_cpus() {
    ++	NPROC=
    ++
    ++	if command -v nproc >/dev/null
    ++	then
    ++		# GNU coreutils
    ++		NPROC=$(nproc)
    ++	elif command -v sysctl >/dev/null
    ++	then
    ++		# BSD & Mac OS X
    ++		NPROC=$(sysctl -n hw.ncpu)
    ++	elif test -n "$NUMBER_OF_PROCESSORS"
    ++	then
    ++		# Windows
    ++		NPROC="$NUMBER_OF_PROCESSORS"
    ++	else
    ++		NPROC=1
    ++	fi
    ++
    ++	echo $NPROC
    ++}
    +
      ## ci/lib.sh ##
     @@
      #!/bin/sh
    @@ ci/lib.sh: setenv () {
      	fi
      
      	echo "SET: '$key=$val'" >&2
    -@@ ci/lib.sh: CC_PACKAGE=
    +@@ ci/lib.sh: CC=
      
      # How many jobs to run in parallel?
      NPROC=10
     +case "$CI_TYPE" in
     +'')
    -+	if command -v nproc >/dev/null
    -+	then
    -+		NPROC=$(nproc)
    -+	else
    -+		NPROC=1
    -+	fi
    ++	. ${0%/*}/lib-online_cpus.sh
    ++	NPROC=$(online_cpus)
     +
     +	if test -n "$MAKEFLAGS"
     +	then
    @@ ci/lib.sh: github-actions)
     
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: do
    - 		test_name="${TEST_EXIT%.exit}"
    - 		test_name="${test_name##*/}"
    - 		trash_dir="trash directory.$test_name"
    --		case "$CI_TYPE" in
    --		github-actions)
    -+		if test "$CI_TYPE" = "github-actions"
    -+		then
    - 			mkdir -p failed-test-artifacts
    - 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
      			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
      			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
    - 			continue
    --			;;
    + 			;;
     -		*)
     -			echo "Unhandled CI type: $CI_TYPE" >&2
     -			exit 1
     -			;;
    --		esac
    -+		fi
    - 		trash_tgz_b64="trash.$test_name.base64"
    - 		if [ -d "$trash_dir" ]
    - 		then
    + 		esac
    + 	fi
    + done
-- 
2.36.0.rc2.898.gdf6bbac50ff

