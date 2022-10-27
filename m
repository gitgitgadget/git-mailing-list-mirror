Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C5EC38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiJ0D1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiJ0D1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3647F7086
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:26:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n14so40365wmq.3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9VYgeJSfytL8c64uekujnaLI9Kum3KdskOFGI8deUQ=;
        b=TJCwc0QfHeETtK45tlGbUg+ZQygR4WQqkMcDCyPpVvCaCVMP4xfbu2WlJQAqrsoEe4
         8om2J6LdSV1G2JKYd53WcSODXngywvuaQotn8MWMPCmn01Y2Utx98LYNW2uaSeaTAiP3
         VhavSj3m8sMrgR9zFZufTBchq1uLxRDU3UGosfLZDsuBIMprvkxQePhl4Sc72GA/Qljv
         7Nd+OhqT5TsTJJ09AZZMblRjnW6RGVMLE5GfcUc0/Vcny0AR0D88x92BUVYHJygN7nFZ
         w9DyNjdBAGalx5ahPgWCkElqqP0IIg+JewNzRhXQxLTQKk/y6BLnurEt3ymER9WN9K2t
         SFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9VYgeJSfytL8c64uekujnaLI9Kum3KdskOFGI8deUQ=;
        b=Xecs5KRn56azbLBIgKyt1frlQZsPk33TakdsE/QOAc1P5UBm2oGmxUe2q26u+R47yo
         f5rcgN3VXSB4glBsISkG26dARaCDW78E7+qDKpcAtnzcxOtCYkQDrh4M6vorYTiIwzD7
         yh5+27iKkkG0rfO/wE3qZYjj6jHxlhnA2gxRXy9S+YANxnOHo23uDTYJ25RquqyseXeQ
         S7ED7jwzDSvKveKeg3EnGOImL2Ntk3oyhkodCzmO9wNIvSDEF+Kd/boJG28HiYah6IK4
         dvZ5cv35SrnFf5M/82N5rGwDSv9ZHUlhCCGNSZRraCC6iEW+69S2rrJQg+M0TycU3ktQ
         4wPg==
X-Gm-Message-State: ACrzQf2z+ddPSEJRrrhx6eRcSRJm3v1sAE8bh2/H9dkK4binxz2V55Td
        AM8w+Ifr/t2ZqbvQorjVD+mQQCGojHeyyQ==
X-Google-Smtp-Source: AMsMyM5rd04i09GYS3lZJIZkvnxeMzEjflJ2sD61cqTF3KmtPpXBoWHM4SHZyR3zRMujKT76ii+O6Q==
X-Received: by 2002:a05:600c:444f:b0:3c6:deac:d662 with SMTP id v15-20020a05600c444f00b003c6deacd662mr4368168wmn.89.1666841217509;
        Wed, 26 Oct 2022 20:26:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:26:56 -0700 (PDT)
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
Subject: [PATCH v2 00/11] cmake: document, fix on *nix, add CI
Date:   Thu, 27 Oct 2022 05:26:41 +0200
Message-Id: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topig gets our tests from passing ~80% with ctest on *nix to
passing 100%. Now on top of next's js/cmake-updates. Comments inline
on patches:n

Ævar Arnfjörð Bjarmason (11):
  cmake: don't "mkdir -p" and "cd" in build instructions
  cmake: update instructions for portable CMakeLists.txt

These are new, and document how to use cmake+ctest, and make the
instructions more OS-agnostic.

  cmake: don't copy chainlint.pl to build directory

Same, except to rebase on js/cmake-updates.

  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4

I tried to use the suggested "write_script" function, but couldn't get
past cmake quoting issues. So the commit message is updated, but the
change is the same.

  cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  test-lib.sh: support a "GIT_TEST_BUILD_DIR"
  Makefile + cmake: use environment, not GIT-BUILD-DIR

Generalize the whole "test a build dir over there", and have cmake &
make not step on each other's toes.

  cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults

The test param defaults in js/cmake-updates are kept on Windows, all
platforms benefit from having an easier way to provide custom test
options.

  cmake: copy over git-p4.py for t983[56] perforce test

Now at 101% tests passing :)

  CI: add a "linux-cmake-test" to run cmake & ctest on linux

See the CI (and topic itself) at https://github.com/avar/git/actions/runs/3333306724/jobs/5515607569

 .github/workflows/main.yml          |   3 +
 .gitignore                          |   1 -
 Makefile                            |   1 -
 ci/run-build-and-tests.sh           |  13 ++-
 contrib/buildsystems/CMakeLists.txt | 133 +++++++++++++++++++++-------
 t/README                            |   3 +
 t/lib-gettext.sh                    |   2 +-
 t/lib-gitweb.sh                     |   2 +-
 t/t7609-mergetool--lib.sh           |   2 +-
 t/t9902-completion.sh               |  14 +--
 t/t9903-bash-prompt.sh              |   2 +-
 t/test-lib.sh                       |  27 +++++-
 12 files changed, 152 insertions(+), 51 deletions(-)

Range-diff against v1:
 1:  16c99177e6d <  -:  ----------- cmake: don't copy chainlint.pl to build directory
 -:  ----------- >  1:  667a2bd5271 cmake: don't "mkdir -p" and "cd" in build instructions
 -:  ----------- >  2:  9e2470dcb95 cmake: update instructions for portable CMakeLists.txt
 -:  ----------- >  3:  2d7d9742a73 cmake: don't copy chainlint.pl to build directory
 2:  2c1d194e590 !  4:  ea8a3feec81 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
    @@ Metadata
      ## Commit message ##
         cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
     
    -    The cmake recipe added in [1] did not create the bin-wrappers/*
    -    directory, and thus fell back on running the tests with the equivalent
    -    of "--no-bin-wrappers".
    +    Since the cmake file was made to run on *nix in [1] running the tests
    +    with "ctest" broken, because we'd attempt to invoke our bin-wrappers/,
    +    but they didn't have the executable bit.
     
    -    Thus the. "t/test-lib.sh" would be unable to find "bin-wrappers/git",
    -    and we'd fall back on "GIT_EXEC_PATH=$GIT_BUILD_DIR" using the
    -    fallback behavior added in [2]:
    +    In the best case, the "t/test-lib.sh" would be unable to find
    +    "bin-wrappers/git", and we'd fall back on
    +    "GIT_EXEC_PATH=$GIT_BUILD_DIR" using the fallback behavior added in
    +    [2]:
     
                 $ ./t0001-init.sh
                 <GIT_BUILD_DIR>/t/../contrib/buildsystems/out/bin-wrappers/git is not executable; using GIT_EXEC_PATH
     
    -    Or rather, this is what would have happened on *nix, but until [3]
    -    there wasn't any non-Windows support for "cmake". On Windows it didn't
    -    matter that the bin-wrappers weren't made executable, since there's no
    -    executable bit, instead the emulation layer looks at whether a file
    -    has a shebang.
    +    This was recently somewhat swept under the rug in [3], as ctest would
    +    run them with "--no-bin-wrappers". But still with [3], running e.g.:
     
    -    But with [3] we've effectively used the semi-equivalent of
    -    "--no-bin-wrappers" unintentionally on *nix, and furthermore because
    -    we didn't make these executable
    +            cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Debug &&
    +            make -C contrib/buildsystems/out &&
    +            ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)" --output-on-failure
     
    -    In addition, we'd fail any test that needed to invoke one of our built
    -    shell, perl or Python scripts on *nix. E.g. t0012-help.sh would fail
    -    on a test that tried to invoke "git web--browse". I.e. the equivalent
    -    of this (in the "out" directory) would happen:
    +    Fails around 20% of our testts on *nix. So even with [3] we'd fail any
    +    test that needed to invoke one of our built shell, perl or Python
    +    scripts on *nix. E.g. t0012-help.sh would fail on a test that tried to
    +    invoke "git web--browse". The equivalent of this (in the "out"
    +    directory) would happen:
     
                 $ ./git --exec-path=$PWD web--browse
                 git: 'web--browse' is not a git command. See 'git --help'.
    @@ Commit message
                 usage: git web--browse [--browser=browser|--tool=browser] [--config=conf.var] url/file ...
     
         The same goes for e.g. the "git-p4" tests, which would fail because
    -    our built "git-p4" wasn't executable, etc.
    +    our built "git-p4" wasn't executable, etc. There's also a few other
    +    outstanding issues, which will be fixed in subsequent commits.
     
    -    This change should ideally use file(CHMOD ...), but that's much newer
    -    than our required cmake version[1].
    +    This change should ideally use file(CHMOD ...), but the "file(CHMOD"
    +    feature is much newer than our required cmake version[5].
     
    -    1. a30e4c531d9 (Merge branch 'ss/cmake-build', 2020-08-11)
    +    Before this change:
    +
    +            80% tests passed, 196 tests failed out of 977
    +
    +    After:
    +
    +            99% tests passed, 5 tests failed out of 977
    +
    +    The remaining failures will be addressed in subsequent commits.
    +
    +    There was a suggestion of using a function to abstract this away[6],
    +    which sounds good. But after spending too long trying to get all
    +    combinations of "${content}" and ${content} (unqoted) in the function
    +    and its callers working I wasn't able to fix the quoting issues it
    +    introduced.
    +
    +    A lot of this is duplicated already, we can follow-up at some other
    +    time with refactoring, and address any tricky quoting issues in
    +    calling function with these parameters then.
    +
    +    1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
         2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
    -    3. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
    -    4. https://cmake.org/cmake/help/latest/command/file.html#chmod
    +    3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
    +       runs, 2022-10-18)
    +    4. a30e4c531d9 (Merge branch 'ss/cmake-build', 2020-08-11)
    +    5. https://cmake.org/cmake/help/latest/command/file.html#chmod
    +    6. https://lore.kernel.org/git/0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 3:  addaf73992f !  5:  6387682db06 cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
    @@ Commit message
         recipe has needed to copy various assets to that
         "contrib/buildsystems/out" directory.
     
    -    Let's instead teach the test-lib.sh that there's such a thing as the
    -    "$GIT_SOURCE_DIR" distinct from the "$GIT_BUILD_DIR".
    +    But we've only been doing this for the subsets of tests that run on
    +    Windows, and which have otherwise been covered by that CI target. The
    +    CI target builds (among other things) with "-DPERL_TESTS=OFF
    +    -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON", see [1]. Furthermore, the
    +    CI isn't testing from the "contrib/buildsystems/out" directory,
    +    instead it clobbers the top-level MAkefile.
    +
    +    There was a recent commit to fix a subset of these issues, see
    +    6a83b5f0810 (cmake: copy the merge tools for testing, 2022-10-18).
    +
    +    Let's stop going for that approach, and instead teach the test-lib.sh
    +    that there's such a thing as the "$GIT_SOURCE_DIR" distinct from the
    +    "$GIT_BUILD_DIR".
     
         Just as the "$TEST_DIRECTORY" always points to our actual "t"
         directory (not the "[...]/out/t" cmake creates), this new
         "$GIT_SOURCE_DIR" will always be the top-level source directory.
     
    -    So even though the "GIT_BUILD_DIR=(.*)" line in t/test-lib.sh will
    -    still be altered by CMakeLists.txt, that recipe will no longer need to
    -    copy over various things from our source directory, as the tests now
    -    know where to find those assets.
    +    With this change we now pass 3/5 of the tests that we still had
    +    failing with the fixes in the preceding commit.
    +
    +    1. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
    +       job, 2020-06-26)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
    - 		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
    - 		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
    - 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
    + 	#Setting the build directory in test-lib.sh before running tests
    + 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
    + 		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
     -	#misc copies
     -	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
    --	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
    +-	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
    +-	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
     -	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
     -	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
      endif()
    @@ t/t9903-bash-prompt.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
    - 	# elsewhere
    - 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
    + 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
    + 	exit 1
      fi
    --GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
    -+
    -+# The GIT_{SOURCE,BUILD}_DIR is always the same, except when
    -+# CMakeLists.txt replaces the "GIT_BUILD_DIR" line with the path to
    -+# its build directory.
    -+GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
    -+GIT_BUILD_DIR="$GIT_SOURCE_DIR"
     +
    - if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
    ++# For CMake the top-level source directory is different from our build
    ++# directory. With the top-level Makefile they're the same.
    ++GIT_SOURCE_DIR="$GIT_BUILD_DIR"
    + if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
      then
    - 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
    + 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
     @@ t/test-lib.sh: then
      		make_valgrind_symlink $file
      	done
 4:  52cd674d5b8 !  6:  29a9811857f cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
    @@ Commit message
         on the behavior of !PCRE2. The reason this hasn't been noticed is that
         the Windows CI doesn't have access to libpcre2.
     
    +    With this the remaining two failures we had left after the preceding
    +    step are resolved, but note that that test run didn't include the
    +    git-p4 tests, which a subsequent commit will address).
    +
         1. 80431510a2b (cmake: add pcre2 support, 2022-05-24)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 5:  6199a913c0a !  7:  a9ea3867f5f test-lib.sh: support a "GIT_TEST_BUILD_DIR"
    @@ Commit message
                 [apply this change to git2]
                 (cd git2 && GIT_TEST_BUILD_DIR="$PWD/../git1" make -C t prove)
     
    +    This facility and file-based instructions to have the test suite use
    +    another build directory[2] are mutually exclusive, but in a subsequent
    +    commit we'll make CMake use this instead.
    +
         1. 6720721e152 (test-lib.sh: Allow running the test suite against
            installed git, 2009-03-16)
    +    2. 350a005e366 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/README: override the location of the dashed-form subcommands (what
     
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: fi
    - # its build directory.
    - GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
    - GIT_BUILD_DIR="$GIT_SOURCE_DIR"
    + # For CMake the top-level source directory is different from our build
    + # directory. With the top-level Makefile they're the same.
    + GIT_SOURCE_DIR="$GIT_BUILD_DIR"
    +-if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
     +if test -n "$GIT_TEST_BUILD_DIR"
     +then
     +	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
    -+fi
    - 
    - if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
    ++elif test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
      then
    + 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
    + 	# On Windows, we must convert Windows paths lest they contain a colon
 6:  45f1a4e6f93 <  -:  ----------- cmake: use GIT_TEST_BUILD_DIR instead of editing hack
 7:  fc9f036695f <  -:  ----------- cmake: support using GIT_TEST_OPTS from the environment
 -:  ----------- >  8:  51bb01b99d4 Makefile + cmake: use environment, not GIT-BUILD-DIR
 -:  ----------- >  9:  9f5276d79c9 cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
 8:  56102c2a4bf = 10:  ef6a304368c cmake: copy over git-p4.py for t983[56] perforce test
 9:  b81f18dec61 = 11:  158a41ca7a4 CI: add a "linux-cmake-test" to run cmake & ctest on linux
-- 
2.38.0.1250.ge066ede4da3

