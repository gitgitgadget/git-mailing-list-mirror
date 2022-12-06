Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A654C636F9
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiLFCJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiLFCJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:32 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC21240A4
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so2811784eja.7
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJkBq6PZeFBCPcIjC/HmEmzRP4j5MgoNWjk09cgNPIU=;
        b=WIHvHip8LKirAvGBJRshdo9h9Frb8ML4OsYch1gUQAiqqsbEy964vQHkZSXhkdK8xp
         2251sIuCmMy9BEjc0FIJMdFyf0dwVM8aErgco3R/suxCplhF9i09vIYwfTxPiXF10gOM
         T+jlzZ/S7WjzJ/DSsTfCnvJX7q2Knqr4NTrwwSUke11uTW92ynZWnlCxk5/hFHLEp6Si
         u5X/U/qTTJAlJ2eq1yw12jb3Tu5uJ9ZgW0zhUInTMg+bscg7RiPdMnAgsWL6YzKaOoFH
         dnH/GxE9kaFdIoodvJrYOhrKIdxvy6qpld4NqMNzth7EJas12rKEk3m9yG4CrI2+JVRC
         MYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJkBq6PZeFBCPcIjC/HmEmzRP4j5MgoNWjk09cgNPIU=;
        b=1Bf4gSfV1DRS1juzhqlfifIIDXhZPsS89W0vKkBVfKSrt1U077raomQmVkBeMBsgnQ
         x/NCUdNFRIGvel718gN4hqBC/oPig7X0+vJtd/XWFIeTUJ+ngpeQk9SJCF0dd79ok7fm
         1wYVUfZyQbH4JtGqr8/2+uheT5HdjMJtccvb8nf/jA4miDgfRo7Txl0LC8F4zeEbIvyB
         xK1gVWeR1MRxfOIUWICnFB69bEXdAIyHAt+7hbCkf9l2x3lU9fkdJQwZSYTIjst9hhBo
         0BLyMTYGY/t2DmN+L5VjOrFuEHy4OafBdXV/QBzX1S/F6gG9U3O9ADmzbzKVMSyjRZjN
         O+nw==
X-Gm-Message-State: ANoB5pkfPkhySW0WQD+G3EhZhfc0wLjMSto3+zQMcEQa7tdXLzu31BN8
        jTQD8f8eU1YFn2qJk+bhzfx0lDS6lpPhRA==
X-Google-Smtp-Source: AA0mqf5fLVLvXG8GGT9+L0xugGaB3QH2ERpegZckp+ngBJtUhaXmsAGLyzp5GGYxInAuAwZr7rRMuQ==
X-Received: by 2002:a17:906:6681:b0:7ae:732d:bc51 with SMTP id z1-20020a170906668100b007ae732dbc51mr9492945ejo.549.1670292567640;
        Mon, 05 Dec 2022 18:09:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:27 -0800 (PST)
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
Subject: [PATCH v6 00/15] cmake: document, fix on *nix, add CI
Date:   Tue,  6 Dec 2022 03:08:58 +0100
Message-Id: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic gets our tests from passing ~80% with ctest on *nix to
passing 100%.

See passing CI job for "cmake + ctest" on Ubuntu at:
https://github.com/avar/git/actions/runs/3625189647

See
https://lore.kernel.org/git/cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com/
for the v5.

Changes since v5:

* Typo/grammar etc. fixes noted by Eric.
* Phillip reported the "chmod" fallback no working on Windows. I
  couldn't reproduce that, but running it was always redundant there
  we'll now skip doing that on Windows.
* Adjust 15/15 to fold into an existing "case" statement, rather than
  adding a new "if" statement.

For this v6 I experimented with changing the "win+VS build|test" job
build in "contrib/buildsystems/out" rather than at the top-level[1]. I
left those changes out here, but doing so makes that a lot simpler, as
it no longer needs to rely on the Makefile to tell it what cmake might
have built.

But even without including that here, those changes should give more
confidence in these changes, i.e. they show that our CI's "msbuild"
doesn't require the "cmake" to build things at the top-level.

1. https://github.com/avar/git/tree/avar/cmake-test-path-no-make-for-windows-ci

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
 ci/run-build-and-tests.sh           |  11 +-
 contrib/buildsystems/CMakeLists.txt | 213 ++++++++++++++++++++++------
 t/README                            |   3 +
 t/lib-gettext.sh                    |   2 +-
 t/lib-gitweb.sh                     |   2 +-
 t/t7609-mergetool--lib.sh           |   2 +-
 t/t9902-completion.sh               |  14 +-
 t/t9903-bash-prompt.sh              |   2 +-
 t/test-lib.sh                       |  19 ++-
 11 files changed, 211 insertions(+), 61 deletions(-)

Range-diff against v5:
 1:  7d83ff44c61 !  1:  fc190b379cd cmake: don't invoke msgfmt with --statistics
    @@ Metadata
      ## Commit message ##
         cmake: don't invoke msgfmt with --statistics
     
    -    In 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
    -    2021-12-17) I made the same change to our Makefile, let's follow-up
    -    and do the same here.
    +    In [1] I made the same change to our Makefile, let's follow-up and do
    +    the same here.
     
         For "cmake" this is particularly nice with "-G Ninja", as before we'd
         emit ~40 lines of overflowed progress bar output, but now it's only
         the one line of "ninja"'s progress bar.
     
    +    1. 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
    +       2021-12-17)
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/buildsystems/CMakeLists.txt ##
 2:  314c5e40cff !  2:  1a11aa233a3 cmake: use "-S" and "-B" to specify source and build directories
    @@ Commit message
         The "-S" and "-B" options were added in cmake v3.13.0, which is older
         than the version we have a hard dependency on[1].
     
    -    As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
    +    As an aside, the "-p" flag to "mkdir" in the pre-image wasn't needed,
         as "contrib/buildsystems" is tracked
     
         1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
 3:  5c4ba2425b6 =  3:  b9ddb5db1d3 cmake: update instructions for portable CMakeLists.txt
 4:  e86245ffbab =  4:  7b7850c00ee cmake: don't copy chainlint.pl to build directory
 5:  435452314fa !  5:  82ecb797915 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
    @@ Commit message
     
         The remaining failures will be addressed in subsequent commits.
     
    +    As this isn't needed on Windows let's skip this there. There's also an
    +    unconfirmed (it works in CI) report[5] that invoking the "chmod"
    +    command fails in some scenarios.
    +
         1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
         2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
         3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
            runs, 2022-10-18)
         4. https://cmake.org/cmake/help/latest/command/file.html#chmod
    +    5. https://lore.kernel.org/git/87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${gi
     +function(write_script path content)
     +	file(WRITE ${path} ${content})
     +
    -+	if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
    ++	if(WIN32)
    ++		message(TRACE "skipping chmod +x '${path}' on Windows")
    ++	elseif("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
     +		file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
     +	else()
     +		execute_process(COMMAND chmod +x ${path}
 6:  7ee341245a8 =  6:  1f326944a07 cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 7:  49645cb1643 =  7:  973c8038f54 cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 8:  9e10cd5bd8a =  8:  b8448c7a8a6 Makefile + test-lib.sh: don't prefer cmake-built to make-built git
 9:  df5aea35bbd !  9:  5135e40969e test-lib.sh: support a "GIT_TEST_BUILD_DIR"
    @@ Metadata
      ## Commit message ##
         test-lib.sh: support a "GIT_TEST_BUILD_DIR"
     
    -    Compliment the existing GIT_TEST_INSTALLED variable added in [1] with
    +    Complement the existing GIT_TEST_INSTALLED variable added in [1] with
         one that allows for testing a git built in a directory that's not
         "../".
     
10:  529e18f7f72 ! 10:  65204463730 cmake: optionally be able to run tests before "ctest"
    @@ contrib/buildsystems/CMakeLists.txt: if(USE_VCPKG)
     +	set(GIT_CTEST_SETS_BUILD_DIR "OFF" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
     +endif()
     +if(GIT_CTEST_SETS_BUILD_DIR)
    -+	message(STATUS "Enabling manual runs of t/* tests once ctest writes CMAKE-BUILD-DIR")
    ++	message(STATUS "Have GIT_CTEST_SETS_BUILD_DIR=ON. Need a 'ctest' run to write GIT-BUILD-DIR")
     +else()
    -+	message(STATUS "Enabling manual runs of t/* tests via cmake build dir discovery")
    ++	message(STATUS "Have GIT_CTEST_SETS_BUILD_DIR=OFF. Wrote out a GIT-BUILD-DIR, no 'ctest' required")
     +endif()
     +
     +# When using GIT_CTEST_SETS_BUILD_DIR, running the tests from the "t/"
11:  a5dd4fa1d00 ! 11:  e25992b16f1 cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
    @@ contrib/buildsystems/CMakeLists.txt: endif()
     +elseif(WIN32)
     +	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx"
     +		CACHE STRING "test options, see t/README")
    -+	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
    ++	message(STATUS "Using Windows-specific default test options: ${GIT_TEST_OPTS}")
     +else()
     +	set(GIT_TEST_OPTS ""
     +		CACHE STRING "test options, see t/README")
12:  c9d550b8558 = 12:  4905ce5321d cmake: increase test timeout on Windows only
13:  7a5dd684d40 = 13:  6c6b530965d cmake: only look for "sh" in "C:/Program Files" on Windows
14:  c9c895bb794 = 14:  563f1b9b045 cmake: copy over git-p4.py for t983[56] perforce test
15:  a6f343b6221 ! 15:  917a884eb65 CI: add a "linux-cmake-test" to run cmake & ctest on linux
    @@ Commit message
         To ensure that it doesn't break again let's add a "linux-cmake-ctest"
         target to build and test "cmake" on Linux, in addition to that we'll
         also run the tests with "ctest" instead of "make" or "prove", so we
    -    can assert that testing with that method works..
    +    can assert that testing with that method works.
     
         This also stress tests running "cmake" (and "ctest") out of a build
         directory that isn't the top-level. The "vs-build" job uses "cmake"
    @@ Commit message
         "$GIT_SOURCE_DIR" in a preceding commit.
     
         Since the "ci/lib.sh" already creates and exports a
    -    GIT_TEST_OPTS="..." we'll pick that up in our CI, see the preceding
    +    GIT_TEST_OPTS="..." we'll pick that up in our CI; see the preceding
         commit. Because we pass the "--verbose-log -x
         --github-workflow-markup" in the GitHub CI as a result the interaction
         with "handle_failed_tests" here works correctly. I.e. on failure we'll
    @@ .github/workflows/main.yml: jobs:
                  pool: macos-latest
     
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: pedantic)
    - 	;;
    - esac
    +@@ ci/run-build-and-tests.sh: esac
    + 
    + run_tests=t
      
    --group Build make
     +mc=
    -+if test "$jobname" = "linux-cmake-ctest"
    -+then
    + case "$jobname" in
    + linux-gcc)
    + 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    +@@ ci/run-build-and-tests.sh: pedantic)
    + 	export DEVOPTS=pedantic
    + 	run_tests=
    + 	;;
    ++linux-cmake-ctest)
     +	cb=contrib/buildsystems
     +	group CMake cmake -S "$cb" -B "$cb/out"
     +	mc="-C $cb/out"
    -+fi
    -+
    ++	;;
    + esac
    + 
    +-group Build make
     +group Build make $mc
     +
      if test -n "$run_tests"
-- 
2.39.0.rc1.1006.gb4c675778ba

