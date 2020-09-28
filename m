Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05969C4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EE22100A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnu3Q8ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgI1VJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgI1VJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43745C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g4so2858204wrs.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Cv2hV50IGRpCuikm0oiPVWbUQpQbkCq13gQ6/mp//dA=;
        b=mnu3Q8ZWFRMjFyUb8aYIdfhpbcNN4rLeTDRqmkt4w6djCDHsoGoSgWWKMk0GZ8OLog
         IXr9cA5ZiXj6tqMp27OnZw4SsmF1C/8HC0e1tCajmA3WFze8HGbvEuRjZa8tg25cfy/X
         Snt2ZiNX0Sd/wRGYq7oquvhG8VAb+U01LAB23omwGFuR0SBZAsYSyk0zFSoenYGPmPfn
         ECeH9abHdhhU3/qaGF+NA54+tfT6y+aOsWZ4GBKbVNxNiYTPkswH51uGU/NFJH7NlPYS
         xvpEkbxtKG49OnSEebZB/sNydTq8mJieAwBUsgAZn+OHdtGOvY00E9W7lVTO7l90tUhm
         qMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Cv2hV50IGRpCuikm0oiPVWbUQpQbkCq13gQ6/mp//dA=;
        b=YykjuIPw5jon1x33iUm8d/8mfWNSA+vo2qPjNWoB2d/HP+SJSMTqJgdr/vtQgOXtLD
         cFe0SYQG4fp++K2Zj7C3EQBSTujMX7xXSWMYWiBazBLtqTCvaMv88O1hDhTlbiih6JWW
         NP4WrovmFcFSHPDHrwMgJkYlVCfoz/pbdGM634bQ5242MQ+w27tfwwGvYD3rXvfBPEAS
         /XBZvTlkQzT+dPHWgCPX6OOWhJmCLjJR7x08QqfQmFgE3ZX3vCMk4xd/+AuhQCtVyqA1
         Mpz33TIO0TKBWLNnZBSx6/Sf0SqRrX3YPUju7KbCjJ1a3WtDxI9uY0bvrtil/NFMI+rY
         A/CA==
X-Gm-Message-State: AOAM533vtGwFg7jgf8B8HrNuzv97EBP6+R1GtNq+sxA4P0G0s2Cc2Hkx
        /aAAQqnpYaptTEGYkh1rzJTBEEFUQ20=
X-Google-Smtp-Source: ABdhPJy+bosetPWQc12zyrSYlP8c3/qfyXDngDHCkj27x5DKFPLcV4mORgS0B1+hL4XhuYtf7OeHng==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr375633wrp.384.1601327358773;
        Mon, 28 Sep 2020 14:09:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm2629593wma.36.2020.09.28.14.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:17 -0700 (PDT)
Message-Id: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:05 +0000
Subject: [PATCH v3 00/11] CMake and Visual Studio
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

Johannes Schindelin (10):
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
  cmake: fix typo in message when `msgfmt` was not found

Junio C Hamano (1):
  hashmap_for_each_entry(): workaround MSVC's runtime check failure #3

 .gitignore                          |  1 +
 contrib/buildsystems/CMakeLists.txt | 52 ++++++++++++++++++++++-------
 hashmap.h                           |  3 +-
 3 files changed, 43 insertions(+), 13 deletions(-)


base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-738%2Fdscho%2Fcmake-and-visual-studio-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-738/dscho/cmake-and-visual-studio-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/738

Range-diff vs v2:

  1:  ba314373e9 =  1:  9c7a964519 cmake: ignore files generated by CMake as run in Visual Studio
  2:  05b4b69fee <  -:  ---------- cmake: do find Git for Windows' shell interpreter
  -:  ---------- >  2:  3b467360bb cmake: do find Git for Windows' shell interpreter
  3:  5967822a0c !  3:  a49b28e001 cmake: ensure that the `vcpkg` packages are found on Windows
     @@ contrib/buildsystems/CMakeLists.txt: cmake_minimum_required(VERSION 3.14)
      +	set(CURL_NO_CURL_CMAKE ON)
      +endif()
       
     - find_program(SH_EXE sh)
     + find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
       if(NOT SH_EXE)
  4:  efc93f1dd9 =  4:  f1baf0f974 cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
  5:  8b3500a07c =  5:  8380aa55ab cmake: quote the path accurately when editing `test-lib.sh`
  6:  88abbd9a78 =  6:  f61c3ef442 cmake (Windows): let the `.dll` files be found when running the tests
  7:  26ebeecb14 =  7:  7a4346a437 cmake (Windows): complain when encountering an unknown compiler
  8:  3587ee5e8d =  8:  7c1601c7e3 cmake (Windows): initialize vcpkg/build dependencies automatically
  9:  68a7d984ec =  9:  ec182738f0 cmake (Windows): recommend using Visual Studio's built-in CMake support
 10:  152705bbc6 = 10:  38cef4deb5 hashmap_for_each_entry(): workaround MSVC's runtime check failure #3
  -:  ---------- > 11:  c3e235fe39 cmake: fix typo in message when `msgfmt` was not found

-- 
gitgitgadget
