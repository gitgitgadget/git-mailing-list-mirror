Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E882C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiKCQmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiKCQkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF91CB04
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k2so6840357ejr.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbnMqUTiNILuMGC+62pKqhLkXJbxmjD4qQOvijcSwO4=;
        b=NLbR7yXAzWjSGrKpYw10ErsxwCmceRaGonZZdU1sKLFV0P0oQiuQ9dNi1S7Bi+gfr9
         /k8KRE2jLaG39B8Lub+qVT1ehQdaOtgrOoNKOo/OC/mAprtwVZHpIuWX9q3Z67P3zJAf
         inbrC0ADtMt92/xVzGTguCF1m2dMLSreep29Mc4jBXY5H+GWDas5e7pj8bCP2dlhZGqK
         f4W4/Io/jQGMPr1Sul8204qhUkkbC1b19o2tl0KhwUoAcgYztHytHpV9cWZg9PCuK1W5
         BONARinWLv4GFrwHguxLwhBCErXESeF22SwapinJvJ9SGrCdnb+TwG2Ka7eFsuI2Mhzb
         0v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbnMqUTiNILuMGC+62pKqhLkXJbxmjD4qQOvijcSwO4=;
        b=0+nyinosaIJgaSMXct14le6jvoWXpenKzEEWW6kVzIDd0pc1xirIxg300XRkTwarZE
         UbCipPIJaat4sYL928CqKnX5yCQz1NINBeegD48zE5bH6UPOde2E4cut9NMOkLa+EDrd
         65yx8dsjjb2JjBjMZDBIFvP6kqsrTBkL+E1sBV+nScBA19vgq3FiNKXSd6vC9TfkxYRS
         X1+oDllOaMdw0N6Hd7HCc9s22MvH5fKt9xhAMwY8aQldmg9ZvWSdsIhKgBNrpIoRfpFS
         ssFQxDHQuQiUeEu/AQhQQwX6IvkeJRiNq6vFV+lESGps9HZACasS4RhNRtxmjoLvnnSU
         QUQA==
X-Gm-Message-State: ACrzQf0Z7qxf+/tM1w/xUB2PnLUIi0KwwcZyVvsQFpQ4OcqhcL1zrcj2
        4+8saGMWH0JXIje9Pwu5X65ousYgEWo=
X-Google-Smtp-Source: AMsMyM5KTYry6RlNspbloT5JP4jZb4lObOLRkQWCoxh86AGkDdrS9FyirVw4teDR2vCrFCEo0s6WXg==
X-Received: by 2002:a17:906:846c:b0:7ad:c8c0:5a52 with SMTP id hx12-20020a170906846c00b007adc8c05a52mr23980164ejc.167.1667493486966;
        Thu, 03 Nov 2022 09:38:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:06 -0700 (PDT)
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
Subject: [PATCH v4 00/14] cmake: document, fix on *nix, add CI
Date:   Thu,  3 Nov 2022 17:37:50 +0100
Message-Id: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic gets our tests from passing ~80% with ctest on *nix to
passing 100%.

See passing CI job for "cmake + ctest" on Ubuntu at:
https://github.com/avar/git/actions/runs/3387253536/jobs/5627772317

See
http://lore.kernel.org/git/cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com
for v3.

Changes since the v3:

 * A small "while at it" change in 1/14 to make the build output nicer
   (particularly for "ninja, as it's not verbose). It's just the
   "msgfmt without --statistics" change we've got in the Makefile
   already.

 * Discuss more about -S and -B in 2/14. It's supported by our cmake
   version(s0.

 * Re-arranged the docs in 3/14 as Phillip Wood suggested.

 * Used Phillip's write_script(). I tested the emitted files
   carefully, and they're the same. So something went wrong in my
   testing before.

 * Use Phillip's file(CHMOD ...) if we have a new enough cmake
   version, otherwise shell out to "chmod +x".

 * Use /dev/shm instead of /run/user/`id -u` in an exmaple, and other
   small things noted in replies to v3.

 * A new 12/14 to do less Windows-specific stuff on *nix, we were
   looking for "sh" in C:\Program\ Files on *nix...

 * The GIT_TEST_OPTS integration with cmake-gui now works.

 * Various small rewording/typo etc. changes to commit messages, see
   range-diff below.

Ævar Arnfjörð Bjarmason (14):
  cmake: don't invoke msgfmt with --statistics
  cmake: use "-S" and "-B" to specify source and build directories
  cmake: update instructions for portable CMakeLists.txt
  cmake: don't copy chainlint.pl to build directory
  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
  cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  test-lib.sh: support a "GIT_TEST_BUILD_DIR"
  Makefile + cmake: use environment, not GIT-BUILD-DIR
  cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
  cmake: increase test timeout on Windows only
  cmake: only look for "sh" in "C:/Program Files" on Windows
  cmake: copy over git-p4.py for t983[56] perforce test
  CI: add a "linux-cmake-test" to run cmake & ctest on linux

 .github/workflows/main.yml          |   3 +
 .gitignore                          |   1 -
 Makefile                            |   1 -
 ci/run-build-and-tests.sh           |  13 +-
 contrib/buildsystems/CMakeLists.txt | 183 +++++++++++++++++++++-------
 t/README                            |   3 +
 t/lib-gettext.sh                    |   2 +-
 t/lib-gitweb.sh                     |   2 +-
 t/t7609-mergetool--lib.sh           |   2 +-
 t/t9902-completion.sh               |  14 +--
 t/t9903-bash-prompt.sh              |   2 +-
 t/test-lib.sh                       |  27 +++-
 12 files changed, 188 insertions(+), 65 deletions(-)

Range-diff against v3:
 -:  ----------- >  1:  78dfc2a69b7 cmake: don't invoke msgfmt with --statistics
 1:  028fa1436d8 !  2:  dd934b0597d cmake: don't "mkdir -p" and "cd" in build instructions
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cmake: don't "mkdir -p" and "cd" in build instructions
    +    cmake: use "-S" and "-B" to specify source and build directories
     
    -    Use the "-S" and -B" flags instead of "mkdir -p" and "cd". The "-p"
    -    flag to "mkdir" wasn't needed as "contrib/buildsystems" is tracked,
    -    and the rest of this is now easier to copy/paste into a shell without
    -    having one's directory changed.
    +    Rather than the multi-line "mkdir/cd/cmake" recipe provide an
    +    equivalent one-liner using the "-S" and "-B" options, and then suggest building with "make -C <build-dir>".
    +
    +    The rest of these instructions discuss e.g. running tests from our
    +    top-level "t/" directory, so it's more helpful to avoid changing the
    +    user's current directory.
    +
    +    The "-S" and "-B" options were added in cmake v3.13.0, which is older
    +    than the version we have a hard dependency on[1].
    +
    +    As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
    +    as "contrib/buildsystems" is tracked
    +
    +    1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ contrib/buildsystems/CMakeLists.txt: NOTE: -DCMAKE_BUILD_TYPE is optional. For m
      This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
     -Run `make` to build Git on Linux/*BSD/MacOS.
     -Open git.sln on Windows and build Git.
    -+Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
    ++Run `make -C contrib/buildsystems/out` to build Git on Linux/*BSD/MacOS.
     +Open contrib/buildsystems/git.sln on Windows and build Git.
      
      NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 2:  7a21f4aa24c !  3:  6f0eae7a02a cmake: update instructions for portable CMakeLists.txt
    @@ contrib/buildsystems/CMakeLists.txt
     +alternative.
     +
     +The primary use-case for maintaining this CMake build recipe is to
    -+have nicer IDE integration on Windows. To get Visual Studio-specific
    -+instructions see "== Visual Studio & Windows ==" below.
    ++have nicer IDE integration on Windows.
     +
     +== Creating a build recipe ==
     +
    -+To create the build recipe run:
    ++The "cmake" command creates a build file from this recipe:
     +
     +    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
     +
    -+For alternative "-DCMAKE_BUILD_TYPE=<type>" flags see instructions
    -+under the "== -DCMAKE_BUILD_TYPE=<type> ==" heading below.
    ++Running this will create files in the contrib/buildsystems/out
    ++directory (our top-level .gitignore file knows to ignore contents of
    ++this directory).
     +
    -+== Building ==
    ++See "cmake options" below for a discussion of
    ++"-DCMAKE_BUILD_TYPE=Release" and other options to "cmake".
     +
    -+The "cmake" command creates a build file from this recipe. For Windows
    -+Open contrib/buildsystems/git.sln and build Git. Or use the
    -+"msbuild" command-line tool (see our own ".github/workflows/main.yml"
    -+for a real example):
    ++== Building with Visual Visual Studio ==
    ++
    ++To use this in Visual Studio:
    + 
    + Open the worktree as a folder. Visual Studio 2019 and later will detect
    + the CMake configuration automatically and set everything up for you,
    +@@ contrib/buildsystems/CMakeLists.txt: Note: Visual Studio also has the option of opening `CMakeLists.txt`
    + directly; Using this option, Visual Studio will not find the source code,
    + though, therefore the `File>Open>Folder...` option is preferred.
    + 
    +-Instructions to run CMake manually:
    ++By default CMake will install vcpkg locally to your source tree on configuration,
    ++to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
    + 
    +-    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
    ++== Building on Windows without Visual Studio ==
    + 
    +-This will build the git binaries in contrib/buildsystems/out
    +-directory (our top-level .gitignore file knows to ignore contents of
    +-this directory).
    ++Open contrib/buildsystems/git.sln and build Git. Or use the "msbuild"
    ++command-line tool (see our own ".github/workflows/main.yml" for a real
    ++example):
     +
     +	msbuild git.sln
     +
    ++== Building on *nix ==
    ++
     +On all other platforms running "cmake" will generate a Makefile; to
     +build with it run:
     +
    @@ contrib/buildsystems/CMakeLists.txt
     +
     +It's also possible to use other generators, e.g. Ninja has arguably
     +slightly better output. Add "-G Ninja" to the cmake command above,
    -+then e.g.:
    ++then:
     +
     +	ninja -C contrib/buildsystems/out
     +
    -+== Visual Studio & Windows ==
    ++== cmake options ==
     +
    -+To use this in Visual Studio:
    ++=== -DCMAKE_BUILD_TYPE=<type> ===
      
    - Open the worktree as a folder. Visual Studio 2019 and later will detect
    - the CMake configuration automatically and set everything up for you,
    -@@ contrib/buildsystems/CMakeLists.txt: Note: Visual Studio also has the option of opening `CMakeLists.txt`
    - directly; Using this option, Visual Studio will not find the source code,
    - though, therefore the `File>Open>Folder...` option is preferred.
    - 
    --Instructions to run CMake manually:
    --
    --    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
    --
    --This will build the git binaries in contrib/buildsystems/out
    -+Following the instructions above will build the git binaries in the contrib/buildsystems/out
    - directory (our top-level .gitignore file knows to ignore contents of
    - this directory).
    - 
    -+By default CMake will install vcpkg locally to your source tree on configuration,
    -+to avoid this, add `-DNO_VCPKG=TRUE` to the command line when configuring.
    -+
    -+== -DCMAKE_BUILD_TYPE=<type> ==
    -+
      Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
      compiler flags
    - Debug : -g
     @@ contrib/buildsystems/CMakeLists.txt: empty(default) :
      
      NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
      this option is ignored
     -
     -This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
    --Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
    +-Run `make -C contrib/buildsystems/out` to build Git on Linux/*BSD/MacOS.
     -Open contrib/buildsystems/git.sln on Windows and build Git.
     -
     -NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
 3:  3bfa873e792 =  4:  0f0eb2a76c7 cmake: don't copy chainlint.pl to build directory
 4:  ad551f53de9 !  5:  eda1c1e95e5 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
    @@ Commit message
                 make -C contrib/buildsystems/out &&
                 ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)" --output-on-failure
     
    -    Fails around 20% of our testts on *nix. So even with [3] we'd fail any
    +    Fails around 20% of our tests on *nix. So even with [3] we'd fail any
         test that needed to invoke one of our built shell, perl or Python
         scripts on *nix. E.g. t0012-help.sh would fail on a test that tried to
         invoke "git web--browse". The equivalent of this (in the "out"
    @@ Commit message
         our built "git-p4" wasn't executable, etc. There's also a few other
         outstanding issues, which will be fixed in subsequent commits.
     
    -    This change should ideally use file(CHMOD ...), but the "file(CHMOD"
    -    feature is much newer than our required cmake version[5].
    +    Ideally we'd use the file(CHMOD ...) form everywhere, but that syntax
    +    was introduced in cmake 3.19[4], whereas we only require 3.14. Let's
    +    provide a fallback behind a version check, so that we'll eventually be
    +    able to delete the "else" part. Both forms result in the same file
    +    modes.
     
         Before this change:
     
    @@ Commit message
     
         The remaining failures will be addressed in subsequent commits.
     
    -    There was a suggestion of using a function to abstract this away[6],
    -    which sounds good. But after spending too long trying to get all
    -    combinations of "${content}" and ${content} (unqoted) in the function
    -    and its callers working I wasn't able to fix the quoting issues it
    -    introduced.
    -
    -    A lot of this is duplicated already, we can follow-up at some other
    -    time with refactoring, and address any tricky quoting issues in
    -    calling function with these parameters then.
    -
         1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
         2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
         3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
            runs, 2022-10-18)
    -    4. a30e4c531d9 (Merge branch 'ss/cmake-build', 2020-08-11)
    -    5. https://cmake.org/cmake/help/latest/command/file.html#chmod
    -    6. https://lore.kernel.org/git/0fda0e54-0432-7690-74a7-3d1a59923e0c@dunelm.org.uk/
    +    4. https://cmake.org/cmake/help/latest/command/file.html#chmod
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    +    write script
    +
      ## contrib/buildsystems/CMakeLists.txt ##
    +@@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${git_http_links}
    + 		DEPENDS git git-remote-http)
    + add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
    + 
    ++function(write_script path content)
    ++	file(WRITE ${path} ${content})
    ++
    ++	if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
    ++		file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
    ++	else()
    ++		execute_process(COMMAND chmod +x ${path}
    ++				RESULT_VARIABLE CHILD_ERROR)
    ++		if(CHILD_ERROR)
    ++			message(FATAL_ERROR "failed to chmod +x '${path}': '${CHILD_ERROR}'")
    ++		endif()
    ++	endif()
    ++endfunction()
    + 
    + #creating required scripts
    + set(SHELL_PATH /bin/sh)
     @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
    + 	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
      	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
      	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
    - 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
    -+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
    +-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
    ++	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
      endforeach()
      
      #perl scripts
     @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_perl_scripts})
    + 	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
      	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
      	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
    - 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
    -+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/${script})
    +-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
    ++	write_script(${CMAKE_BINARY_DIR}/${script} "${content}")
      endforeach()
      
      #python script
      file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
      string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
    - file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    -+execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/git-p4)
    +-file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    ++write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
      
      #perl modules
      file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
     @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${wrapper_scripts})
    + 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
      	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
      	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
    - 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
    -+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/${script})
    +-	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
    ++	write_script(${CMAKE_BINARY_DIR}/bin-wrappers/${script} "${content}")
      endforeach()
      
      foreach(script ${wrapper_test_scripts})
    -@@ contrib/buildsystems/CMakeLists.txt: foreach(script ${wrapper_test_scripts})
    + 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
      	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
      	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
    - 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
    -+	execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/${script})
    +-	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
    ++	write_script(${CMAKE_BINARY_DIR}/bin-wrappers/${script} "${content}")
      endforeach()
      
      file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
      string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
      string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
    - file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
    -+execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver)
    +-file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
    ++write_script(${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver "${content}")
      
      #options for configuring test options
      option(PERL_TESTS "Perform tests that use perl" ON)
 5:  5c7b64286ce =  6:  6c254f8cb9f cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 6:  cba90650879 =  7:  1685a58e13a cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 7:  bd7fb1eec24 =  8:  87a2c77ee68 test-lib.sh: support a "GIT_TEST_BUILD_DIR"
 8:  fd3e6be5689 =  9:  6187ded42db Makefile + cmake: use environment, not GIT-BUILD-DIR
 9:  8a660a2baa4 ! 10:  3ea4a61698e cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
    @@ Commit message
         Windows-specific anymore.
     
         So let's set those same options by default on Windows, but do so with
    -    the set() facility. As noted in cmake's documentation[1] this
    -    integrates nicely with e.g. cmake-gui.
    +    the set(... CACHE <type> <docstring>) facility. As noted in cmake's
    +    documentation[1] this integrates nicely with e.g. cmake-gui.
     
         On *nix we don't set any custom options. The change in 2ea1d8b5563
         didn't discuss why Windows should have divergent defaults with "cmake"
    @@ Commit message
                 GIT_TEST_OPTS=-i cmake -S contrib/buildsystems -B contrib/buildsystems/out &&
                 ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out -R t0071 --verbose
     
    +    The "separate_arguments()" here will do the right thing for arguments
    +    that don't contain whitespace, so e.g. the path to --root="" can't
    +    have a space in it. There's supposedly a way to work around that with
    +    separate_arguments(), but it requires features newer than our required
    +    cmake version, so let's live with that edge case for now.
    +
         1. https://cmake.org/cmake/help/latest/command/set.html#set-cache-entry
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ contrib/buildsystems/CMakeLists.txt: empty(default) :
     +The tests can also be run with ctest, e.g. after building with "cmake"
     +and "make" or "msbuild" run, from the top-level e.g.:
     +
    ++	# "--test-dir" is new in cmake v3.20, so "(cd
    ++	# contrib/buildsystems/out && ctest ...)" on older versions.
     +	ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)"--output-on-failure
     +
     +Options can be passed by setting GIT_TEST_OPTIONS before invoking
     +cmake. E.g. on a Linux system with systemd the tests can be sped up by
     +using a ramdisk for the scratch files:
     +
    -+	GIT_TEST_OPTS="--root=/run/user/$(id -u)/ctest" cmake -S contrib/buildsystems -B contrib/buildsystems/out
    ++	GIT_TEST_OPTS="--root=/dev/shm/$(id -u)/ctest" cmake -S contrib/buildsystems -B contrib/buildsystems/out
     +	[...]
    -+	-- Using user-selected test options: --root=/run/user/1001/ctest
    ++	-- Using user-selected test options: --root=/dev/shm/<uid>/ctest
     +
     +Then running the tests with "ctest" (here with --jobs="$(nproc)"):
     +
    @@ contrib/buildsystems/CMakeLists.txt: endif()
      
      file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
      
    -+string(COMPARE NOTEQUAL "$ENV{GIT_TEST_OPTS}" "" HAVE_USER_GIT_TEST_OPTS)
    -+if(HAVE_USER_GIT_TEST_OPTS)
    -+	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
    ++if(DEFINED ENV{GIT_TEST_OPTS})
    ++	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}"
    ++		CACHE STRING "test options, see t/README")
     +	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
     +elseif(WIN32)
    -+	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx")
    ++	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx"
    ++		CACHE STRING "test options, see t/README")
     +	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
     +else()
    -+	set(GIT_TEST_OPTS "")
    ++	set(GIT_TEST_OPTS ""
    ++		CACHE STRING "test options, see t/README")
     +	message(STATUS "No custom test options selected, set e.g. GIT_TEST_OPTS=\"-vixd\"")
     +endif()
     +separate_arguments(GIT_TEST_OPTS)
10:  966fec83b77 = 11:  8ccf5c8c265 cmake: increase test timeout on Windows only
 -:  ----------- > 12:  7b1f10eb4c0 cmake: only look for "sh" in "C:/Program Files" on Windows
11:  aad17d8f858 ! 13:  0699e398e89 cmake: copy over git-p4.py for t983[56] perforce test
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/buildsystems/CMakeLists.txt ##
    -@@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
    +@@ contrib/buildsystems/CMakeLists.txt: endforeach()
    + file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
      string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
    - file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    - execute_process(COMMAND chmod +x ${CMAKE_BINARY_DIR}/git-p4)
    + write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
     +file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
      
      #perl modules
12:  c27f620dfa3 = 14:  277028678c8 CI: add a "linux-cmake-test" to run cmake & ctest on linux
-- 
2.38.0.1451.g86b35f4140a

