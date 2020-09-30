Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C9C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B132071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZFEQwVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgI3P0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3P02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ADC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so2285590wrr.4
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NuoFNogahFW/Vlhfn9g9vpZhr/JcqZk4VPF7J/IRV/w=;
        b=sZFEQwVgWx4uz+pVY82FgEVFb6J0Wd32AphXNOBe3Uy9tHfB66ALX4Q1LJGdjLMx6U
         Bpy+lGkX+4sRGdo/JhmR3zFyuF7BpSzdcH7Ris9IXtjyH/HFww1qQ+sCW9Wl2kxV4YYV
         JQzUdyBLjUGOcySsXXG7spGLD4wPlnSCPEbMny8jKtm/RbkjKN8qmwDwergXIHVNV0lA
         vKYRJEaarR64TkFkSMRgQK/Mea2fb2jXtmRxLBWDOwxGcfLSuHsnYN7FDAOa8Peu6Wsm
         BaBwzm/u+j6mwPS31EpWou2pt0psW6TDV7yke90MTl3AEB5p0Lvi/hJApeAbSWoTl065
         irdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NuoFNogahFW/Vlhfn9g9vpZhr/JcqZk4VPF7J/IRV/w=;
        b=NO5MROTUrB3cfcp4o1CUAWEV5d3tLNusCD5GV7rPwtiafwpFyDnYQXYaSvimaxBsiL
         /UQNc2Gva2DrA1OzHAur561Y/dbAWGgHJh0LtJHJJjWD1w97FeCZ2XfXzjpJW/5njEpN
         G4XJEhb9I3l5Q6V14PCPi2jsilsJ00N1BUVUKtOysqGERLg0XphMMLFzdWFIHO4TXb4u
         FxyCHMUuso4tea/v5IQ3Upb3Ohn7/uvQ1J0Q+xPDFi67QmnlEvjTM4+F3nZCIuuam3I4
         j6bE4Nee71hrp1chO9+jyUUe3OlJc6GR/qf2sSr9/dCSffS1pLpHt8r0eGQhc7EIPl+/
         DrqA==
X-Gm-Message-State: AOAM530AcD6n1DKpFX3PWudCmynuJbFjuy7WU8+ljZ51AozLp74I6uwl
        agQdOeX7qcgevMOjSdbjqnUxIQc3+H8=
X-Google-Smtp-Source: ABdhPJyYKxU7tLFQeYzGohMfIwFkOJC1Xize8mQ0M7sSUoqUE0YqdC19BJ33fs7nQAgDRE9axwb2TQ==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr3634961wrm.136.1601479586174;
        Wed, 30 Sep 2020 08:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm3323851wmj.28.2020.09.30.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:25 -0700 (PDT)
Message-Id: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:14 +0000
Subject: [PATCH v4 00/10] CMake and Visual Studio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intention of this patch series is to make it as easy as possible for a
Visual Studio user to start building Git from scratch. The idea is to

 * clone Git's source code,
 * open it in Visual Studio via File>Open>Folder...
 * let CMake configure things (and vcpkg build the dependencies, which will
   take a while), and
 * start the build.

It does require a Git for Windows to be installed so that the source can be
cloned, but also to run the shell script parts of the CMake configuration,
and also to run the tests.

This patch series replaces the patch "Ignore files generated by CMake" I
sent via https://github.com/gitgitgadget/git/pull/735.

Changes since v3:

 * Squashed the typo fix into the correct commit (d'oh!)
 * Fixed another typo (thanks, Sibi!)
 * Guarded the code block that initializes vcpkg and builds the dependencies
   behind the MSVC conditional (thanks, Sibi!)

Changes since v2:

 * Fixed a typo in the message when msgfmt.exe is not found.
 * Simplified the logic to find sh.exe (thanks Øystein).

Changes since v1:

 * Touched up a couple commit messages in response to reviewer comments
 * Adjusted the instructions at the top of CMakeLists.txt so that the part
   talking about running CMake manually also talks about using 
   contrib/buildsystems/out/ as build directory (in line with the part
   talking about Visual Studio's out-of-the-box experience)
 * Replaced patch 10/10 with Junio's much more elegant solution of editing
   the hashmap_for_each_entry() macro instead of all of its callers.

Johannes Schindelin (9):
  cmake: ignore files generated by CMake as run in Visual Studio
  cmake: do find Git for Windows' shell interpreter
  cmake: ensure that the `vcpkg` packages are found on Windows
  cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
  cmake: quote the path accurately when editing `test-lib.sh`
  cmake (Windows): let the `.dll` files be found when running the tests
  cmake (Windows): complain when encountering an unknown compiler
  cmake (Windows): initialize vcpkg/build dependencies automatically
  cmake (Windows): recommend using Visual Studio's built-in CMake
    support

Junio C Hamano (1):
  hashmap_for_each_entry(): workaround MSVC's runtime check failure #3

 .gitignore                          |  1 +
 contrib/buildsystems/CMakeLists.txt | 52 ++++++++++++++++++++++-------
 hashmap.h                           |  3 +-
 3 files changed, 43 insertions(+), 13 deletions(-)


base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-738%2Fdscho%2Fcmake-and-visual-studio-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-738/dscho/cmake-and-visual-studio-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/738

Range-diff vs v3:

  1:  9c7a964519 =  1:  9c7a964519 cmake: ignore files generated by CMake as run in Visual Studio
  2:  3b467360bb =  2:  3b467360bb cmake: do find Git for Windows' shell interpreter
  3:  a49b28e001 =  3:  a49b28e001 cmake: ensure that the `vcpkg` packages are found on Windows
  4:  f1baf0f974 !  4:  56cfdb2ee9 cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
     @@ contrib/buildsystems/CMakeLists.txt: endif()
      -	message(WARNING "Text Translations won't be build")
      +	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
      +	if(NOT EXISTS ${MSGFMT_EXE})
     -+		message(WARNING "Text Translations won't be build")
     ++		message(WARNING "Text Translations won't be built")
      +		unset(MSGFMT_EXE)
      +	endif()
       endif()
  5:  8380aa55ab =  5:  cfedb1673a cmake: quote the path accurately when editing `test-lib.sh`
  6:  f61c3ef442 =  6:  d402f721c2 cmake (Windows): let the `.dll` files be found when running the tests
  7:  7a4346a437 =  7:  0e7fdfddb4 cmake (Windows): complain when encountering an unknown compiler
  8:  7c1601c7e3 !  8:  14ddfc1781 cmake (Windows): initialize vcpkg/build dependencies automatically
     @@ Commit message
          Rather than requiring this step to be manual, detect the situation and
          run it as part of the CMake configuration step.
      
     +    Note that this obviously only applies to the scenario when we want to
     +    compile in Visual Studio (i.e. with MS Visual C), not with GCC.
     +    Therefore, we guard this new code block behind the `MSVC` conditional.
     +
          This concludes our journey to make it as effortless as possible to start
          developing Git in Visual Studio: all the developer needs to do is to
          clone Git's repository, open the worktree via `File>Open>Folder...` and
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     +    squash! cmake (Windows): initialize vcpkg/build dependencies automatically
     +
     +    MSVC
     +
       ## contrib/buildsystems/CMakeLists.txt ##
      @@ contrib/buildsystems/CMakeLists.txt: cmake_minimum_required(VERSION 3.14)
       set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
       if(WIN32)
       	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
     -+	if(NOT EXISTS ${VCPKG_DIR})
     -+		message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
     ++	if(MSVC AND NOT EXISTS ${VCPKG_DIR})
     ++		message("Initializing vcpkg and building the Git's dependencies (this will take a while...)")
      +		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
      +	endif()
       	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
  9:  ec182738f0 =  9:  b239162eb2 cmake (Windows): recommend using Visual Studio's built-in CMake support
 10:  38cef4deb5 = 10:  7643a766b7 hashmap_for_each_entry(): workaround MSVC's runtime check failure #3
 11:  c3e235fe39 <  -:  ---------- cmake: fix typo in message when `msgfmt` was not found

-- 
gitgitgadget
