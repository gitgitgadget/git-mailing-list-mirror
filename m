Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E7FC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AFD9206BE
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 16:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPz+j+eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgFZQLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 12:11:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53588C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so10074120wrm.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YjeptlGRUg8RAmue3ZEaJnUfIJ9ghWZrbNSouMzTWfA=;
        b=JPz+j+eRBjTNPAeDASwJ4tk2jj6QnFvxTxe4P1+bvi8p1ztbhmHXGTfdVH45W4XkRq
         0PgrLKdjj6uVgGHAh55u2gvrIeB499przBtBjMBSX3jgOqc+/4w6aLJP+mMZcbaw5bC7
         OI+bwg12JbZkRFS5jZSowAYkl9jp17dIG+3aKNYQc7LiZCTvANDfZlYEeUTi9plUTVqs
         NnuukEsEn918K7lamKl5T8kaqw1STwmnlPmhLgOcF2+T1Jo5qT1uOVIvckoIetmGg33M
         GsObvykSnAdxEORe4a4EzYjsvH5sBuNYIueFkxj9ddUvP4xgfJArHTe58wFhBUjClNIq
         5ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YjeptlGRUg8RAmue3ZEaJnUfIJ9ghWZrbNSouMzTWfA=;
        b=fKKBXAZZaqjG1zVRbkER8nz8dUp/iEQxuE6MirGaFqkiZu/MUgyyzGcHOV0Ag3jNDw
         1zjAShktt7XBFNVjIbvoAXd1J1ziyNne3pxdkWa9lbHOq5xLF1qV9GGx4rOGDS1pwyz8
         PAeWFRrcQmSNz1e32czAt73sot5ddGOqNBMebVraDaztWikVSK+M7X78IFqRcyohLYpP
         iIcK2GzW0dLqjFrd7oDz3wJvy5d6mm2Duh31jgdGV2S18yXXo7Pf9XXUAeQoHCUNfbSE
         9XtIM+b2gMCmeXGF+8LJsNkYKJHmz0yf4hGMw2XnhY/UOyUrm4hSAsDv/HZ6v2B39ymp
         50Lg==
X-Gm-Message-State: AOAM531ySQjvmxLQ0vs2UcuSD9XyGPf6RmVb59pD29700R0kNqqT33Rt
        dg4FCSNfo3QtJBNNs3n8QaMKrhjz
X-Google-Smtp-Source: ABdhPJyk6YWZcg4XXY0e7gRoUtqULUEkR1e9cSC6jdbjiJq0vmgcpGnvrStcOkrAFnYTl+UC3Kx44w==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr4446981wrq.322.1593187900676;
        Fri, 26 Jun 2020 09:11:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e25sm37949809wrc.69.2020.06.26.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:11:39 -0700 (PDT)
Message-Id: <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 16:11:30 +0000
Subject: [PATCH v5 0/8] CMake build system for git
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
script parses the Makefile for the sources. LIB_OBJS BUILTIN_OBJS XDIFF_OBJS
VCSSVN_OBJS TEST_BUILTINS_OBJS SCRIPT_SH SCRIPT_PERL 3) Philip suggested to
change the error message if sh/bash was not found on windows. 4) CMake now
tests for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT 5) Renamed the
variable test_helper_sources to test-tool_SOURCES [PATCH 4/8] to be
consistent with the naming of source variables.

Changes v2: Changes 1,2,4 have been rebased to PATCH 01/xx CMake uses
GIT-VERSION-GEN to get the version of Git Fixed a bug where a Windows user
can pose as Linux user and vice versa. [PATCH 6/8]

Changes v3: Patch changes are moved from the commit messages and are placed
here. Code inside check_c_source_(compiles/runs) have been formatted
according to git coding guidelines. [PATCH 1/8] The CMake script parses the
Makefile for SCRIPT_LIB also. [PATCH 2/8] The CMake script globs templates,
po files. Logic has been added to place the template files in their
respective directories instead of hard-coding them. [PATCH 2/8]

Changes v4: Removed EXE_EXTENSION conditional stuff using
CMAKE_EXECUTABLE_SUFFIX [PATCH 4/8] There was an issue in build pipelines
where CMake was not able to find the correct iconv library (caused by an
update that installed PostgreSQL), so we need to manually set the location
of the iconv library and its includes. This issue is extremely rare and is
specific to the implementation of FindIconv.cmake. Other libraries are
unaffected. [PATCH 8/8]

Sibi Siddharthan (8):
  Introduce CMake support for configuring Git
  cmake: generate the shell/perl/python scripts and templates,
    translations
  cmake: installation support for git
  cmake: support for testing git with ctest
  cmake: support for testing git when building out of the source tree
  cmake: support for building git on windows with mingw
  cmake: support for building git on windows with msvc and clang.
  ci: modification of main.yml to use cmake for vs-build job

 .github/workflows/main.yml          |   39 +-
 contrib/buildsystems/CMakeLists.txt | 1000 +++++++++++++++++++++++++++
 2 files changed, 1024 insertions(+), 15 deletions(-)
 create mode 100644 contrib/buildsystems/CMakeLists.txt


base-commit: e8ba1cc988e122f1a74cda161ba3ec1bf22fe88f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-614%2FSibiSiddharthan%2Fgit-og-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-614/SibiSiddharthan/git-og-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/614

Range-diff vs v4:

 1:  c4e1ba7446 = 1:  07ae9f0a49 Introduce CMake support for configuring Git
 2:  abb9e6e1d5 ! 2:  74358b389d cmake: generate the shell/perl/python scripts and templates, translations
     @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${gi
      +list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
      +list(REMOVE_ITEM templates ".gitignore")
      +list(REMOVE_ITEM templates "Makefile")
     ++list(REMOVE_ITEM templates "blt")# Prevents an error when reconfiguring for in source builds
      +
      +list(REMOVE_ITEM templates "branches--")
      +file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
 3:  4a0dd23cbb = 3:  a60e7472d3 cmake: installation support for git
 4:  db05180e98 = 4:  fedda55fc2 cmake: support for testing git with ctest
 5:  17e7f3e9de = 5:  398a578558 cmake: support for testing git when building out of the source tree
 6:  549f0cd5ff ! 6:  10acdbf5e4 cmake: support for building git on windows with mingw
     @@ contrib/buildsystems/CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX
      +	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
      +	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
      +endif()
     - 
     --add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
     --list(APPEND compat_SOURCES unix-socket.c)
     ++
      +
      +#Platform Specific
      +if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     @@ contrib/buildsystems/CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX
      +	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
      +	list(APPEND compat_SOURCES unix-socket.c)
      +endif()
     -+
     -+if(WIN32)
     -+	set(EXE_EXTENSION .exe)
     -+else()
     -+	set(EXE_EXTENSION)
     -+endif()
     + 
     +-add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
     +-list(APPEND compat_SOURCES unix-socket.c)
     ++set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
       
       #header checks
       check_include_file(libgen.h HAVE_LIBGEN_H)
 7:  f85ea0ac0c = 7:  0b921545d2 cmake: support for building git on windows with msvc and clang.
 8:  2f7cf41e08 ! 8:  3cdefab43a ci: modification of main.yml to use cmake for vs-build job
     @@ .github/workflows/main.yml: jobs:
      +        if (!$?) { exit(1) }
      +    - name: generate Visual Studio solution
      +      shell: bash
     -+      run: cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     ++      run: |
     ++        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
     ++        -DIconv_LIBRARY=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/lib/libiconv.lib -DIconv_INCLUDE_DIR=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows/include \
     ++        -DMSGFMT_EXE=`pwd`/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
           - name: MSBuild
             run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
           - name: bundle artifact tar

-- 
gitgitgadget
