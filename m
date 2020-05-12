Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99467CA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B12206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A11km0Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgELQvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELQu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:50:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDB1C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:50:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so16341000wrn.6
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uNMuEEWe6df5+a+iF01nPiolccSZBVId1MPWOIsHXVk=;
        b=A11km0Dx1U1D7Peub2xPYwYA1bh21/PW+K4MslSl1OyCb8KchrlC1zBe23QttO3vCQ
         l1wVJpikJxWTp2X2Cv02W7e9GEhWHQNHJeOj2ycnlBqz5z4brEjXBCUnPR6WDSGHicyE
         Zub1sKhoxRl8KHoTPGc2fpcEULJI5Qi2IODDUkXjTovWj7PSrbRt8QGRM7O0LI7ax/KM
         6QdUBkq2LoGEcMhQj9PY7uDz1YZWh9bHj3hnV7MPowIu38WZ0GAWIMUSVTlLHDdiiwp3
         4ob44PGd869uoFWUp9C9CpaS4q5BXY+BIE/XEqfsmHQMJ1qPH8YoqGchYRpbtxbUqLrU
         OUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uNMuEEWe6df5+a+iF01nPiolccSZBVId1MPWOIsHXVk=;
        b=VRd45C2QW7eXoeZM/sIiUMxT51t1J7yJO2VkVkA9LOsOnzS0eOGYM8DunHfs1Y7khk
         mQyMa0GIwjADOOH/PTL5wiuf+nA+zURPdHGwrpD4TYL0JoljNxyKz3O9Yy/UtV7rDaLi
         CI9xkqFlAZzM6qcj3GE1/e6YNoMZGmLFTK+ggFahDXuY9AfzJwsEvNENYfB8N1YuJyLV
         QMMDqx3QVDxc6OMgy8jYVV9UlXECVfN0JVck7tFGs6KAdlEWVNmOpMr8+6s/1YaOpKkU
         yqNRJV6EGqPvKm+5PV94G7RH6Ju0Mw/XfUfipewAImkcNJIzyuITarPjFJACD1u38UlB
         WpWg==
X-Gm-Message-State: AGi0PubKzqAd9+yDWu9Mzz99Xzdby7FQmxLZRac1JenFhl8/EuclK2JK
        QxDUjVXDCJSMUwpZVz8YnSNZ97fF
X-Google-Smtp-Source: APiQypImaTAzYxYZNkI4vejNUbzRiiV957LvGWxi1RlNZYx7y/IUmkwCU95EzsI/dcA/JD1yYeq7eQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr10448089wrn.268.1589302256340;
        Tue, 12 May 2020 09:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5sm24826783wro.12.2020.05.12.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:50:55 -0700 (PDT)
Message-Id: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.git.1587700897.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:43 +0000
Subject: [PATCH v2 00/11] CMake build system for git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to build Git using CMake. CMake is cross-platform build
generator which works well on a variety of platforms(primarily Linux and
Windows). Using CMake we can check whether certain headers exist, certain
functions exist, the required libraries are present and configure the build
accordingly. Using CMake we can also build and test Git out of source,
resulting in a clean source tree.

Tested platforms

Ubuntu 18.04 GCC 7.4 Clang 8.0.1

Windows MinGW GCC 9.2 Clang 9 Visual Studio 2015,2017,2019

Changes:

1) The CMake script has been relocated to contrib/buildsystems 2) The CMake
script parses the Makefile for the sources. 3) Philip suggested to change
the error message if sh/bash was not found on windows. 4) CMake now tests
for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT

Sibi Siddharthan (11):
  Introduce CMake support for configuring Git on Linux
  cmake: generate the shell/perl/python scripts and templates,
    translations
  cmake: installation support for git
  cmake: support for testing git with ctest
  cmake: support for testing git when building out of the source tree
  cmake: support for building git on windows with mingw
  cmake: support for building git on windows with msvc and clang.
  cmake: added checks for struct stat and libiconv
  cmake: relocated script file contrib/buildsystems
  cmake: parse the makefile for the sources.
  ci: modification of main.yml to use cmake for vs-build job

 .github/workflows/main.yml          |  46 +-
 contrib/buildsystems/CMakeLists.txt | 945 ++++++++++++++++++++++++++++
 2 files changed, 971 insertions(+), 20 deletions(-)
 create mode 100644 contrib/buildsystems/CMakeLists.txt


base-commit: 744177e7f7fd407c26e9e4aa3b19696859010c48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-614%2FSibiSiddharthan%2Fgit-og-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-614/SibiSiddharthan/git-og-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/614

Range-diff vs v1:

  1:  70ab1f03dd5 =  1:  70ab1f03dd5 Introduce CMake support for configuring Git on Linux
  2:  ca242cf5bda =  2:  ca242cf5bda cmake: generate the shell/perl/python scripts and templates, translations
  3:  10390063a39 !  3:  b2974432d77 cmake: installation support for git
     @@ Commit message
      
          Then run `make install`
      
     +    Changes:
     +    Removed a comment regarding the installation of gitk.
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## CMakeLists.txt ##
     @@ CMakeLists.txt: if(MSGFMT_EXE)
      +#install
      +install(TARGETS git git-shell
      +	RUNTIME DESTINATION bin)
     -+install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver  #${CMAKE_SOURCE_DIR}/gitk-git/gitk check
     ++install(PROGRAMS ${CMAKE_BINARY_DIR}/git-cvsserver
      +	DESTINATION bin)
      +
      +list(REMOVE_ITEM PROGRAMS_BUILT git git-shell)
  4:  35a3554df3e !  4:  2bd8870fb96 cmake: support for testing git with ctest
     @@ Commit message
      
          NOTE: Testing only works when building in source for now.
      
     +    Changes:
     +    Renamed the variable test_helper_sources to test-tool_SOURCES
     +    to be consistent with the naming of source variables.
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## CMakeLists.txt ##
     @@ CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION
      +add_executable(test-svn-fe t/helper/test-svn-fe.c)
      +target_link_libraries(test-svn-fe common-main vcs-svn)
      +
     -+set(test_helper_sources
     ++set(test-tool_SOURCES
      +	t/helper/test-tool.c t/helper/test-advise.c t/helper/test-bloom.c t/helper/test-chmtime.c
      +	t/helper/test-config.c t/helper/test-ctype.c t/helper/test-date.c t/helper/test-delta.c
      +	t/helper/test-dir-iterator.c t/helper/test-drop-caches.c t/helper/test-dump-cache-tree.c
     @@ CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION
      +	t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
      +	t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
      +
     -+add_executable(test-tool ${test_helper_sources})
     ++add_executable(test-tool ${test-tool_SOURCES})
      +target_link_libraries(test-tool common-main)
      +
      +set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
  5:  166b78f7175 =  5:  096f6311ad5 cmake: support for testing git when building out of the source tree
  6:  d6c630028bf !  6:  00cae10bbb7 cmake: support for building git on windows with mingw
     @@ Commit message
          To use CMake on Windows with MinGW do this:
          cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
      
     +    Changes:
     +    Changed the error message when sh.exe is not found on Windows as
     +    suggested by Philip Oakley <philipoakley@iee.email>
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## CMakeLists.txt ##
     @@ CMakeLists.txt: if(Intl_FOUND)
       
       find_program(SH_EXE sh)
      +if(NOT SH_EXE)
     -+	message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
     ++	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
     ++			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
      +endif()
      +
      +if(WIN32)
  7:  0577d7bf0a8 !  7:  af6c606881d cmake: support for building git on windows with msvc and clang.
     @@ CMakeLists.txt: find_package(ZLIB REQUIRED)
       if(NOT Intl_FOUND)
       	add_compile_definitions(NO_GETTEXT)
      @@ CMakeLists.txt: if(NOT SH_EXE)
     - 	message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
     + 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
       endif()
       
      -if(WIN32)
  -:  ----------- >  8:  f496cd7d8aa cmake: added checks for struct stat and libiconv
  -:  ----------- >  9:  9c674372fb5 cmake: relocated script file contrib/buildsystems
  -:  ----------- > 10:  b0a321a714a cmake: parse the makefile for the sources.
  8:  f0294be3f11 ! 11:  fa1b8032906 ci: modification of main.yml to use cmake for vs-build job
     @@ Commit message
          FindCURL module. An extra definition (-DCURL_NO_CURL_CMAKE=ON) has been
          added to revert to the old behaviour.
      
     +    Edit(Explanation for the reordering of build steps):
     +    In the configuration phase CMake looks for the required libraries for
     +    building git (eg zlib,libiconv). So we extract the libraries before we
     +    configure.
     +
     +    Changes:
     +    The CMake script has been relocated to contib/buildsystems, so point
     +    to the CMakeLists.txt in the invocation commands.
     +
     +    The generation command now uses the absolute paths for the generation
     +    step.
     +
     +    To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
     +    directory of script or path. So we copy the dlls before we configure.
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
               Remove-Item compat.zip
           - name: add msbuild to PATH
             uses: microsoft/setup-msbuild@v1.0.0
     -+    - name: generate Visual Studio solution
     ++    - name: copy dlls to root
      +      shell: powershell
      +      run: |
     -+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     -+          cmake . -DCMAKE_PREFIX_PATH=./compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=./git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     -+        "@
     ++        & compat\vcbuild\vcpkg_copy_dlls.bat release
      +        if (!$?) { exit(1) }
     ++    - name: generate Visual Studio solution
     ++      shell: bash
     ++      run: cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
           - name: MSBuild
             run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
           - name: bundle artifact tar
     +@@ .github/workflows/main.yml: jobs:
     +         MSVC: 1
     +         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
     +       run: |
     +-        & compat\vcbuild\vcpkg_copy_dlls.bat release
     +-        if (!$?) { exit(1) }
     +         & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     +           mkdir -p artifacts &&
     +           eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
      @@ .github/workflows/main.yml: jobs:
               nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
           steps:

-- 
gitgitgadget
