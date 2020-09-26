Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D73BC4741F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4123719
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsV1Zm+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgIZVcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIZVcx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88194C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so7632869wrx.7
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=A9j6nH825/bojLrBIZTJQMr6KXiaQWDUsr3gBwpnPgQ=;
        b=YsV1Zm+9AaU+iWpn/jF53QOkRqFieiqZF8Z5eNGhw76A8N+Jqlk5cvsTSWwITkbLJW
         8I2KoO1eQuBpDrvbbswohi33/RsGVgEc8BZ8nGodJOyxkqgzx0BwBERDxq7DRIxhd3dE
         uIZvFqv5VN3YeULR2WXIPjDl3u6UGOsfyPxa3ZS1bWfamBW+11qzk5T6KRPQoSP962/6
         7BQxOZqSNsb7xeEcbzGwVOZG6qb7TyqA4kKNJo4BLq1Vg7iqk/Tme0REnpxmAYohgqOf
         IYR+fbcWvXyEy6rJqPuSXkU7rmq2BtneNZk+ygXpFnqSVdC9/AmysP1p9Gt1czQRagp+
         qjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=A9j6nH825/bojLrBIZTJQMr6KXiaQWDUsr3gBwpnPgQ=;
        b=SAvbb7Gb4tZLGDtf6trzF7DP608UfQuJpdq2tkWZOjFAubpHXZd1g3RHzZVsENuw+j
         03S9fUOBKjgu2hovcmLcfpMogzDeeBRIoXS21YfajKVCsOy1Kl4NoSbTI31gz+JcDHKk
         2sysBV9NJaGBj//DLCVwGtiNkN/S96we/VUGTemkuqZpxA3toW42OvPq7yENwnlA5QlO
         AgLh0Y4YbBBMU1UsrYLbyGyVA5XyCK88IMrphdafdn5DSg+SJzzfQCFM3vV8awHtUNpE
         /SXu/k6XX/7wbVrmIwZJksFMhkA/dllxIgS7P7ZfMJq8zCuzlnMtcmgRbiv6pIkaGVPP
         EPBw==
X-Gm-Message-State: AOAM533IijCdgisy7oeZWXT4MsTJDkPtzsEbz/X1rCqm7bEhUp8Ic9Oj
        SZYm9oEEuNuiZJFz3KKwd7L4bDasLm0=
X-Google-Smtp-Source: ABdhPJwVsgs1IqBN0tZQMct/Z1vh/jB0eDJjmxLG+Y4PaIB5wzgkgnnSJpdV2SSc/7UjaqgdHnp0OQ==
X-Received: by 2002:adf:e989:: with SMTP id h9mr11816318wrm.38.1601155971000;
        Sat, 26 Sep 2020 14:32:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm3538005wmm.40.2020.09.26.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:50 -0700 (PDT)
Message-Id: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:39 +0000
Subject: [PATCH v2 00/10] CMake and Visual Studio
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

It does require a Git for Windows to be installed (so that the source can be
cloned, but also to run the shell script parts of the CMake configuration),
and also to run the tests.

This patch series replaces the patch "Ignore files generated by CMake" I
sent via https://github.com/gitgitgadget/git/pull/735.

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
 contrib/buildsystems/CMakeLists.txt | 57 ++++++++++++++++++++++-------
 hashmap.h                           |  3 +-
 3 files changed, 47 insertions(+), 14 deletions(-)


base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-738%2Fdscho%2Fcmake-and-visual-studio-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-738/dscho/cmake-and-visual-studio-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/738

Range-diff vs v1:

  1:  ba314373e9 =  1:  ba314373e9 cmake: ignore files generated by CMake as run in Visual Studio
  2:  05b4b69fee =  2:  05b4b69fee cmake: do find Git for Windows' shell interpreter
  3:  5967822a0c =  3:  5967822a0c cmake: ensure that the `vcpkg` packages are found on Windows
  4:  efc93f1dd9 =  4:  efc93f1dd9 cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
  5:  8b3500a07c =  5:  8b3500a07c cmake: quote the path accurately when editing `test-lib.sh`
  6:  bb8f122cde !  6:  88abbd9a78 cmake (Windows): let the `.dll` files are found when running the tests
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    cmake (Windows): let the `.dll` files are found when running the tests
     +    cmake (Windows): let the `.dll` files be found when running the tests
      
          Contrary to Unix-ish platforms, the dependencies' shared libraries are
          not usually found in one central place. In our case, since we use
  7:  dddfa3a9b4 !  7:  26ebeecb14 cmake (Windows): complain when encountering an unknown compiler
     @@ Commit message
          We have some custom handling regarding the link options, which are
          specific to each compiler.
      
     -    Therefore: let's not just continue without setting the link options when
     +    Therefore: let's not just continue without setting the link options if
          configuring for a currently unhandled compiler, but error out.
      
     -    Note: for some reason, the `invalidcontinue.obj` trick seems not to work
     -    in this developer's hands when building Git in Debug mode: the assertion
     -    dialog that is supposed to be suppressed still pops up, complaining
     -    about the `entry` variable being uninitialized when it is used in
     -    `config.c`'s line 1961.
     -
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/buildsystems/CMakeLists.txt ##
  8:  3a07bd4916 =  8:  3587ee5e8d cmake (Windows): initialize vcpkg/build dependencies automatically
  9:  f07e421666 !  9:  68a7d984ec cmake (Windows): recommend using Visual Studio's built-in CMake support
     @@ Commit message
          configuration in CMake manually (does not matter whether using the
          command-line or CMake's GUI).
      
     +    While at it, recommend using `contrib/buildsystems/out/` as build
     +    directory also in the part that talks about running CMake manually.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt
       
      -Instructions to run CMake:
      +Instructions how to use this in Visual Studio:
     -+
     + 
     +-cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
     +-Eg.
     +-From the root of git source tree
     +-	`cmake contrib/buildsystems/ `
     +-This will build the git binaries at the root
      +Open the worktree as a folder. Visual Studio 2019 and later will detect
      +the CMake configuration automatically and set everything up for you,
      +ready to build. You can then run the tests in `t/` via a regular Git Bash.
     -+
     -+Note: Visual Studio also has the option of opening the CMake configuration
     + 
     +-For out of source builds, say build in 'git/git-build/'
     +-	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
     +-This will build the git binaries in git-build directory
     ++Note: Visual Studio also has the option of opening `CMakeLists.txt`
      +directly; Using this option, Visual Studio will not find the source code,
      +though, therefore the `File>Open>Folder...` option is preferred.
      +
      +Instructions to run CMake manually:
     ++
     ++    mkdir -p contrib/buildsystems/out
     ++    cd contrib/buildsystems/out
     ++    cmake ../ -DCMAKE_BUILD_TYPE=Release
     ++
     ++This will build the git binaries in contrib/buildsystems/out
     ++directory (our top-level .gitignore file knows to ignore contents of
     ++this directory).
       
     - cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
     - Eg.
     + Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
     + compiler flags
 10:  dc46d39611 <  -:  ---------- hashmap_for_each_entry(): work around MSVC's run-time check failure #3
  -:  ---------- > 10:  152705bbc6 hashmap_for_each_entry(): workaround MSVC's runtime check failure #3

-- 
gitgitgadget
