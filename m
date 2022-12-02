Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B7CC4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiLBL3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiLBL2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC1AA8EA
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so10953844ejh.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQIvTIZ4/KHmpng16vdl5w4Sb9d89J6nNV1pntof7mk=;
        b=k0t8Vjuz3QfmoZu2PiNth8rCaCEDx1jiy15nOKmktSPPZUK9mR57ukayv+p8u6ECzP
         +qDjTclkLs9bJM1tFWezheAr4qvS8f4cJHatDrHMRoGY7Xq07XO9I/NpX2n1nKOtCu/k
         nZO+hpUJ3Nr5mn3s3xRN23tp4Qe4u3txLWzFVTiHorFtJTDXaniimcXvxmcL4y135RdI
         Mypwn6t17EJvSFmFlAHaBCP2vgBkycl7d+FZSTHGndw0VQHCceC0b5BQgeF85O8OxeGP
         /KX8urhghyAAjUSt8TPkOAaL0EQcEoZDj6GLNMB7FlUfuL0RDFh2x4nCkp/+iYMTySx7
         lkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQIvTIZ4/KHmpng16vdl5w4Sb9d89J6nNV1pntof7mk=;
        b=TQnivFfn2HmtCf0iHlVkSvMzti//TKNBLCcMtsAAKYJghtsTlsTYVV6ObdrZh0bGwg
         LuouJE1gEtLBv2DWLlplAX6xBDStKzJ5RyFZlHpN0hvuTSeoQJeCY3/6D5rnrsfgZI59
         jXraev6f4Dp04WdXxcrzAuB3Hjhyyn0zIrSQ/d1CyG0SiwXpSBJlLSXIeMAXTqy4VI+f
         Q+7ogm4IxtJmip+d9X2zSF9ZqmeB+dBtcVyX82tTdxJxM0qQLhfdgyWwDFXD9ckpMz79
         2bCylOqL+m2SiXCBiv7kNuSrf9Kz6rYlifgpYt9sPwNO/bkDP57+Q7BepOWL7euDrjBS
         sQ8Q==
X-Gm-Message-State: ANoB5pmyA1M4Kb+IfwYUEJPP5zXoVMPN1RjvDqHl/s2bRGXztjSXB+i6
        MEuKLtnG0M3LkHP24msadDBwVPWcu6i9NQ==
X-Google-Smtp-Source: AA0mqf5rDLbi2D/Z+ou2oR9vzTK7/gnO5dSNebRnMVjnoyx56rpeQNNW5aiR/AE3XZ+EqWrOf+AbqQ==
X-Received: by 2002:a17:907:75c7:b0:7c0:8371:97a9 with SMTP id jl7-20020a17090775c700b007c0837197a9mr15550489ejc.583.1669980519848;
        Fri, 02 Dec 2022 03:28:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/15] cmake: document, fix on *nix, add CI
Date:   Fri,  2 Dec 2022 12:28:21 +0100
Message-Id: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic gets our tests from passing ~80% with ctest on *nix to
passing 100%.

See passing CI job for "cmake + ctest" on Ubuntu at:
https://github.com/avar/git/actions/runs/3598398023

See
https://lore.kernel.org/git/cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com/
for the v4.

The v4 of this is in "next", but expected to be ejected & re-queued
per [1].

Changes since v4.

* Rebased on master. Junio: I think the merge you had for main.yml was
  a mismerge, i.e. the new job here wanted "ubuntu-latest". Per
  0178420b9ca (github-actions: run gcc-8 on ubuntu-20.04 image,
  2022-11-25) only the gcc-8 jobs want to pin the version.

  In practice that merge resolution was harmless, as the job ran just
  fine on ubuntu-20.04.

* Per the discussion starting at [2] this v5 doesn't remove the
  GIT-BUILD-DIR file, but if we have it and build directory built
  with "make" we'll prefer the "make" one.

  This supports the use-case of running the tests discovering the
  "cmake" build directory using the same mechanism as before, while
  fixing the edge cases where the two will trip over one
  another. E.g. a "make git" after a "cmake" still running the tests
  with the "cmake".

* There are other behavior differences to fix what I consider bugs in
  the existing behavior, but that new behavior is guarded by a
  "GIT_CTEST_SETS_BUILD_DIR" variable. On Windows it's "ON" by default
  (the old behavior), elsewhere it's "OFF".

  As the test suite wasn't close to running succesfully before this
  the non-Windows users should benefit from the new behavior, but it
  is different. So Windows users get old semantics, unless they'd like
  to opt-in.

  The resulting behavior differences are the following (table taken
  from 10/15):

	|---+----+-----|
	|   | ON | OFF |
	|---+----+-----|
	| A | N  | Y   |
	| B | N  | Y   |
	| C | Y  | Y   |
	| D | Y  | N   |
	| E | N  | Y   |
	|---+----+-----|
	A. Can manually run tests before ctest?
	B. Manually run tests point to latest cmake build?...
	C. Manually run tests point to latest "ctest"'d build?
        D. "git" picked at ctest start time?
        E. "git" picked at test start time?

1. https://lore.kernel.org/git/xmqq5yeuspam.fsf@gitster.g/
2. https://lore.kernel.org/git/544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk/

Branch & passing CI at
https://github.com/avar/git/tree/avar/cmake-test-path-5

Ævar Arnfjörð Bjarmason (15):
  cmake: don't invoke msgfmt with --statistics
  cmake: use "-S" and "-B" to specify source and build directories
  cmake: update instructions for portable CMakeLists.txt
  cmake: don't copy chainlint.pl to build directory
  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
  cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  Makefile + test-lib.sh: don't prefer cmake-built to make-built git
  test-lib.sh: support a "GIT_TEST_BUILD_DIR"
  cmake: optionally be able to run tests before "ctest"
  cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
  cmake: increase test timeout on Windows only
  cmake: only look for "sh" in "C:/Program Files" on Windows
  cmake: copy over git-p4.py for t983[56] perforce test
  CI: add a "linux-cmake-test" to run cmake & ctest on linux

 .github/workflows/main.yml          |   3 +
 Makefile                            |   1 -
 ci/run-build-and-tests.sh           |  13 +-
 contrib/buildsystems/CMakeLists.txt | 211 ++++++++++++++++++++++------
 t/README                            |   3 +
 t/lib-gettext.sh                    |   2 +-
 t/lib-gitweb.sh                     |   2 +-
 t/t7609-mergetool--lib.sh           |   2 +-
 t/t9902-completion.sh               |  14 +-
 t/t9903-bash-prompt.sh              |   2 +-
 t/test-lib.sh                       |  19 ++-
 11 files changed, 211 insertions(+), 61 deletions(-)

Range-diff against v4:
 1:  78dfc2a69b7 =  1:  7d83ff44c61 cmake: don't invoke msgfmt with --statistics
 2:  dd934b0597d =  2:  314c5e40cff cmake: use "-S" and "-B" to specify source and build directories
 3:  6f0eae7a02a =  3:  5c4ba2425b6 cmake: update instructions for portable CMakeLists.txt
 4:  0f0eb2a76c7 =  4:  e86245ffbab cmake: don't copy chainlint.pl to build directory
 5:  eda1c1e95e5 =  5:  435452314fa cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
 6:  6c254f8cb9f =  6:  7ee341245a8 cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 7:  1685a58e13a =  7:  49645cb1643 cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 -:  ----------- >  8:  9e10cd5bd8a Makefile + test-lib.sh: don't prefer cmake-built to make-built git
 8:  87a2c77ee68 !  9:  df5aea35bbd test-lib.sh: support a "GIT_TEST_BUILD_DIR"
    @@ Commit message
                 (cd git2 && GIT_TEST_BUILD_DIR="$PWD/../git1" make -C t prove)
     
         This facility and file-based instructions to have the test suite use
    -    another build directory[2] are mutually exclusive, but in a subsequent
    -    commit we'll make CMake use this instead.
    +    another build directory[2] are mutually exclusive. In a subsequent
    +    commit we'll make CMake and CTest optionally prefer this method.
     
         1. 6720721e152 (test-lib.sh: Allow running the test suite against
            installed git, 2009-03-16)
    @@ t/README: override the location of the dashed-form subcommands (what
      --------------
     
      ## t/test-lib.sh ##
    -@@ t/test-lib.sh: fi
    - # For CMake the top-level source directory is different from our build
    - # directory. With the top-level Makefile they're the same.
    - GIT_SOURCE_DIR="$GIT_BUILD_DIR"
    --if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
    -+if test -n "$GIT_TEST_BUILD_DIR"
    -+then
    -+	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
    -+elif test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
    +@@ t/test-lib.sh: if test ! -x "$GIT_BUILD_DIR/git" &&
    + 	test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
      then
      	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
    ++elif test -n "$GIT_TEST_BUILD_DIR"
    ++then
    ++	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
    ++fi
    ++
    ++if test "$GIT_SOURCE_DIR" != "$GIT_BUILD_DIR"
    ++then
      	# On Windows, we must convert Windows paths lest they contain a colon
    + 	case "$(uname -s)" in
    + 	*MINGW*)
 9:  6187ded42db ! 10:  529e18f7f72 Makefile + cmake: use environment, not GIT-BUILD-DIR
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile + cmake: use environment, not GIT-BUILD-DIR
    +    cmake: optionally be able to run tests before "ctest"
     
    -    Change the method used to have building with "cmake" followed by
    -    running the tests manually work without creating inter-dependency issues with the Makefile.
    +    Since [1] the "cmake" build has had support for running the tests
    +    manually from the "t/" directory once we've built with "cmake", but
    +    only after a one-off run of "ctest".
     
    -    Per ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18) and
    -    the surrounding discussion the goal of that change was to have
    -    building with cmake and:
    +    I.e. we create the build recipe via "cmake" and build with
    +    e.g. "make", but after doing so would get:
     
    -            (cd t && ./t0001-init.sh)
    +            $ (cd t && ./t0071-sort.sh)
    +            error: GIT-BUILD-OPTIONS missing (has Git been built?).
     
    -    Work, to do so we need some way to make the test-lib.sh aware that we
    -    have a build in contrib/buildsystems/out. The downside of doing it via
    -    the GIT-BUILD-DIR facility in ee9e66e4e76 is:
    +    The recently added amendment to this of using a "GIT-BUILD-DIR"[2]
    +    didn't change these semantics. After we did a one-off run of "ctest"
    +    we'd be able to run the tests without "ctest":
     
    -    - A "remove this file while at it" only fits into the Makefile
    -      dependency graph if we "FORCE" a shell command to be run, so doing it
    -      this way precludes speeding up the Makefile by e.g. making use of the
    -      "$(file)" function (for which I've got follow-up patches).
    -
    -    - If you build with make, then with cmake, and then e.g.:
    -
    -            make -C t prove
    -
    -      We'll run the tests against the cmake version of the tests, not the
    -      "make" built ones. It's important to get any subtle interaction
    -      between two conflicting build systems right.
    -
    -    Now we'll instead:
    -
    -    - Check if the top-level "git" exists, if not we'll look in
    -      "contrib/buildsystems/out/git", and when running interactively inform
    -      the user about the fallback being picked.
    -
    -            $ ./t0001-init.sh
    -            setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
    -            ok 1 - plain
    +            $ ctest --test-dir contrib/buildsystems/out -R t0071
                 [...]
    -
    -    - This also makes things more obvious on the cmake side, because we'll
    -      now use an environment variable to select the test environment, which
    -      ctest it notes in its verbose output, e.g.:
    -
    -            [...]
    -            2: Test command: /bin/sh "/home/avar/g/git/contrib/buildsystems/../../t/t0001-init.sh" "--no-bin-wrappers" "--no-chain-lint" "-vx"
    -            2: Working Directory: /home/avar/g/git/contrib/buildsystems/../../t
    -            2: Environment variables:
    -            2:  GIT_TEST_BUILD_DIR=/home/avar/g/git/contrib/buildsystems/out
    +            100% tests passed, 0 tests failed out of 1
                 [...]
    -
    -       See [1] for the relevant cmake language references.
    -
    -    - We don't support an arbitrary build directory outside of
    -      "contrib/buildsystems/out". This is OK because the reason for doing
    -      this part is to support the workflow documented in [2].
    -
    -      As [3] notes "contrib/buildsystems/out" isn't just the directory that
    -      happens to be documented in "contrib/buildsystems/CMakeLists.txt", but
    -      the one that VS will use when building git.
    -
    -    1. https://cmake.org/cmake/help/latest/command/set_property.html
    -       https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#test-properties
    -       https://cmake.org/cmake/help/latest/manual/cmake-language.7.html#cmake-language-lists
    -    1. f2f1250c47f (cmake (Windows): recommend using Visual Studio's
    -       built-in CMake support, 2020-09-30)
    -    2. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in
    -       Visual Studio, 2020-09-25)
    +            $ (cd t && ./t0071-sort.sh)
    +            ok 1 - DEFINE_LIST_SORT_DEBUG
    +            # passed all 1 test(s)
    +            1..1
    +
    +    This change optionally closes that gap, and allows for more sensible
    +    behavior. Due to concerns about existing MS Visual Studio users
    +    relying on some of these edge cases this is being made optional, with
    +    the default of the new "GIT_CTEST_SETS_BUILD_DIR" being "ON" on
    +    Windows (i.e. the old behavior), and "OFF" elsewhere.
    +
    +    The resulting behavior differences are the following:
    +
    +            |---+----+-----|
    +            |   | ON | OFF |
    +            |---+----+-----|
    +            | A | N  | Y   |
    +            | B | N  | Y   |
    +            | C | Y  | Y   |
    +            | D | Y  | N   |
    +            | E | N  | Y   |
    +            |---+----+-----|
    +            A. Can manually run tests before ctest?
    +            B. Manually run tests point to latest cmake build?...
    +            C. Manually run tests point to latest "ctest"'d build?
    +            D. "git" picked at ctest start time?
    +            E. "git" picked at test start time?
    +
    +    On "D" and "E": Because GIT_CTEST_SETS_BUILD_DIR=ON relies on the
    +    global "GIT-BUILD-DIR" when using "ctest" it cannot be used to run
    +    concurrent tests for two different builds from the same source
    +    directory.
    +
    +    But as noted in [3] existing users using Visual Studio may be relying
    +    on some of these edge cases, so let's make this optional on Windows,
    +    but switch the default to this new discover method on other platforms.
    +
    +    1. 7f5397a07c6 (cmake: support for testing git when building out of
    +       the source tree, 2020-06-26)
    +    2. ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
    +    3. https://lore.kernel.org/git/663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## .gitignore ##
    -@@
    - /fuzz_corpora
    --/GIT-BUILD-DIR
    - /GIT-BUILD-OPTIONS
    - /GIT-CFLAGS
    - /GIT-LDFLAGS
    -
    - ## Makefile ##
    -@@ Makefile: else
    - 	@echo RUNTIME_PREFIX=\'false\' >>$@+
    - endif
    - 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
    --	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
    - 
    - ### Detect Python interpreter path changes
    - ifndef NO_PYTHON
    -
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: if(USE_VCPKG)
      	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
    @@ contrib/buildsystems/CMakeLists.txt: if(USE_VCPKG)
     -	#Setting the build directory in test-lib.sh before running tests
     -	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
     -		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
    --endif()
    --
    - file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
    ++set(GIT_CTEST_SETS_BUILD_DIR_DOC "find cmake build dir via ctest-set GIT-BUILD-DIR?")
    ++if(DEFINED ENV{GIT_CTEST_SETS_BUILD_DIR})
    ++	set(GIT_CTEST_SETS_BUILD_DIR "$ENV{GIT_CTEST_SETS_BUILD_DIR}"
    ++		CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
    ++elseif(WIN32)
    ++	set(GIT_CTEST_SETS_BUILD_DIR "ON" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
    ++else()
    ++	set(GIT_CTEST_SETS_BUILD_DIR "OFF" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
    ++endif()
    ++if(GIT_CTEST_SETS_BUILD_DIR)
    ++	message(STATUS "Enabling manual runs of t/* tests once ctest writes CMAKE-BUILD-DIR")
    ++else()
    ++	message(STATUS "Enabling manual runs of t/* tests via cmake build dir discovery")
    ++endif()
    ++
    ++# When using GIT_CTEST_SETS_BUILD_DIR, running the tests from the "t/"
    ++# directory will only work once "ctest" has been run, as we write to
    ++# "GIT-BUILD-DIR" from the optional "ctest" invocation following the
    ++# "cmake"
    ++if(GIT_CTEST_SETS_BUILD_DIR)
    ++	get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
    ++	if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
    ++		file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
    ++			"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
    ++	endif()
    ++else()
    ++	file(WRITE "${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR" "${CMAKE_BINARY_DIR}")
    + endif()
      
    - #test
    + file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
     @@ contrib/buildsystems/CMakeLists.txt: foreach(tsh ${test_scipts})
      	add_test(NAME ${tsh}
      		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
      		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
    ++if(NOT GIT_CTEST_SETS_BUILD_DIR)
     +	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    ++		GIT_TEST_PREFER_BUILD_DIR_ENV="Yes, ignore GIT-BUILD-DIR"
     +		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
    ++endif()
      endforeach()
      
      # This test script takes an extremely long time and is known to time out even
    @@ t/test-lib.sh: fi
      # For CMake the top-level source directory is different from our build
      # directory. With the top-level Makefile they're the same.
      GIT_SOURCE_DIR="$GIT_BUILD_DIR"
    -+
    -+GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=
    - if test -n "$GIT_TEST_BUILD_DIR"
    - then
    - 	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
    --elif test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
    -+elif ! test -x "$GIT_BUILD_DIR/git" &&
    -+     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"
    - then
    --	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
    -+	GIT_BUILD_DIR="$GIT_SOURCE_DIR/contrib/buildsystems/out"
    -+	GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=t
    -+
    - 	# On Windows, we must convert Windows paths lest they contain a colon
    - 	case "$(uname -s)" in
    - 	*MINGW*)
    -@@ t/test-lib.sh: remove_trash_directory "$TRASH_DIRECTORY" || {
    - 	BAIL_OUT 'cannot prepare test area'
    - }
    - 
    -+# Emitting this now because earlier we didn't have "say", but not in
    -+# anything using lib-subtest.sh
    -+if test -n "$GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT" && test -t 1
    -+then
    -+	say "setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git"
    -+fi
    -+
    - remove_trash=t
    - if test -z "$TEST_NO_CREATE_REPO"
    +-if test ! -x "$GIT_BUILD_DIR/git" &&
    ++if test -z "$GIT_TEST_PREFER_BUILD_DIR_ENV" &&
    ++	test ! -x "$GIT_BUILD_DIR/git" &&
    + 	test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
      then
    + 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
10:  3ea4a61698e ! 11:  a5dd4fa1d00 cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
    @@ contrib/buildsystems/CMakeLists.txt: endif()
     -		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
     +		COMMAND ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
      		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
    + if(NOT GIT_CTEST_SETS_BUILD_DIR)
      	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    - 		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
11:  8ccf5c8c265 ! 12:  c9d550b8558 cmake: increase test timeout on Windows only
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/buildsystems/CMakeLists.txt ##
    -@@ contrib/buildsystems/CMakeLists.txt: foreach(tsh ${test_scipts})
    - 		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
    +@@ contrib/buildsystems/CMakeLists.txt: if(NOT GIT_CTEST_SETS_BUILD_DIR)
    + endif()
      endforeach()
      
     -# This test script takes an extremely long time and is known to time out even
12:  7b1f10eb4c0 = 13:  7a5dd684d40 cmake: only look for "sh" in "C:/Program Files" on Windows
13:  0699e398e89 = 14:  c9c895bb794 cmake: copy over git-p4.py for t983[56] perforce test
14:  277028678c8 ! 15:  a6f343b6221 CI: add a "linux-cmake-test" to run cmake & ctest on linux
    @@ Commit message
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    -             os: ubuntu
    +             cc: gcc
                  cc_package: gcc-8
    -             pool: ubuntu-latest
    +             pool: ubuntu-20.04
     +          - jobname: linux-cmake-ctest
     +            cc: gcc
     +            pool: ubuntu-latest
-- 
2.39.0.rc1.981.gf846af54b4b

