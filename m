Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B26BC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKAWvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKAWvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757791EAE5
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f27so40858273eje.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2BbpZNA47v8Q5f2wPdA9Z2Ii+AHIDAOQHlGnawbKJI=;
        b=cFPNb195DYTeB6JoS91q0+d0JCxFtQvqz74eHROb3M5m2P9M2C7iurfPqITNlAX2rD
         ccD0ZLwqBWreimQ0//iVggAR+y2owwFHFvyCjVPREmX8e7NzNzhn248NPnadbi53lX8P
         yscVHKTDhqJw9pOb8yjbubhE+r0R3VYyEYVEDfcVy2X2ZOVgUDO7D3XRFHl90T84qVDh
         MSroe/Iju0q5KvorR6hxXNGdvwyHvw2NTgQtwPJ740g8uwNtg9Nlg4S/y+2Y6R9KQtWx
         5MOr52JDYb1mBITTL5HYgpC7Jop3tGLe7hFH+s6JDgKarDBoGnixhevHv6Ul3O2vsln4
         Sv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2BbpZNA47v8Q5f2wPdA9Z2Ii+AHIDAOQHlGnawbKJI=;
        b=18S6WeR9dEuskGBB/Ff+Daj4rvDH/lVkuKD0Wms0G8aqIIwmwugEbc2+Je1bjbRWaI
         xdqjI+/H/KMxcsffWs/X/x81s9a75gW3S9M9S0//zhjhpz8xKv8X+kag8UJ8PC1l88r8
         R/95eylWhWs8rabKDwSt3EXx6MbzQTFCNAJKlUYe6zz2anPyip9r3uHn4YnKdI7FLwzF
         wjZdYyhYMnCaKS/z9+gwbj3oCod63Z2AFVmQBkAFLhWnTXyTBlWUfj1zlLb06K8xjWhQ
         jU9AyueLwChzmwDtKS0y2+fE8QdTtnbOlIPWTKl8EOB2PqY0uZsRHZyW7wnabBiE+knV
         Ku4g==
X-Gm-Message-State: ACrzQf0k5iwPAyZrTPXMvhBydzLS6UcPCHLvXTnMhmI0Sr37cHNvRM0p
        PTvk6TmsudYgSqwYO8ZQUzXan0pULmLYng==
X-Google-Smtp-Source: AMsMyM6C7yxFa0nxjUGWpoE1fgvR/Ctnf4HFcc/jg0tMFrg3T67ETSfFkutL4zL8BOX8B2DjEK3nww==
X-Received: by 2002:a17:906:730c:b0:791:997f:d65d with SMTP id di12-20020a170906730c00b00791997fd65dmr21500088ejc.18.1667343108725;
        Tue, 01 Nov 2022 15:51:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:48 -0700 (PDT)
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
Subject: [PATCH v3 00/12] cmake: document, fix on *nix, add CI
Date:   Tue,  1 Nov 2022 23:51:24 +0100
Message-Id: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic gets our tests from passing ~80% with ctest on *nix to
passing 100%. Now on top of master, as js/cmake-updates landed.

See passing CI job for "cmake + ctest" on Ubuntu at:
https://github.com/avar/git/actions/runs/3370930115/jobs/5593431733

Changes since the v2:

 * Documentation rewording/updates/grammar fixes, thanks to Eric
   Sunshine.

 * A whitespace nit for set_property(), I wasn't using the indenting
   style that's prevalent in the CMakeLists.txt (not our usual "align
   the argument list" tab-indent).

 * Added a Windows ifdef around the recent timeout increase for a
   single submodule test (not an issue on *nix).

Ævar Arnfjörð Bjarmason (12):
  cmake: don't "mkdir -p" and "cd" in build instructions
  cmake: update instructions for portable CMakeLists.txt
  cmake: don't copy chainlint.pl to build directory
  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
  cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  test-lib.sh: support a "GIT_TEST_BUILD_DIR"
  Makefile + cmake: use environment, not GIT-BUILD-DIR
  cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
  cmake: increase test timeout on Windows only
  cmake: copy over git-p4.py for t983[56] perforce test
  CI: add a "linux-cmake-test" to run cmake & ctest on linux

 .github/workflows/main.yml          |   3 +
 .gitignore                          |   1 -
 Makefile                            |   1 -
 ci/run-build-and-tests.sh           |  13 ++-
 contrib/buildsystems/CMakeLists.txt | 141 +++++++++++++++++++++-------
 t/README                            |   3 +
 t/lib-gettext.sh                    |   2 +-
 t/lib-gitweb.sh                     |   2 +-
 t/t7609-mergetool--lib.sh           |   2 +-
 t/t9902-completion.sh               |  14 +--
 t/t9903-bash-prompt.sh              |   2 +-
 t/test-lib.sh                       |  27 +++++-
 12 files changed, 157 insertions(+), 54 deletions(-)

Range-diff against v2:
 1:  667a2bd5271 =  1:  028fa1436d8 cmake: don't "mkdir -p" and "cd" in build instructions
 2:  9e2470dcb95 !  2:  7a21f4aa24c cmake: update instructions for portable CMakeLists.txt
    @@ contrib/buildsystems/CMakeLists.txt
     +
     +== Building ==
     +
    -+One the recipe is created a build recipe will be created. For Windows
    -+Open contrib/buildsystems/git.sln on Windows and build Git. Or use the
    ++The "cmake" command creates a build file from this recipe. For Windows
    ++Open contrib/buildsystems/git.sln and build Git. Or use the
     +"msbuild" command-line tool (see our own ".github/workflows/main.yml"
     +for a real example):
     +
     +	msbuild git.sln
     +
    -+On all other platforms running "cmake" will generate a Makefile, to
    ++On all other platforms running "cmake" will generate a Makefile; to
     +build with it run:
     +
     +	make -C contrib/buildsystems/out
 3:  2d7d9742a73 =  3:  3bfa873e792 cmake: don't copy chainlint.pl to build directory
 4:  ea8a3feec81 =  4:  ad551f53de9 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
 5:  6387682db06 =  5:  5c7b64286ce cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 6:  29a9811857f =  6:  cba90650879 cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 7:  a9ea3867f5f =  7:  bd7fb1eec24 test-lib.sh: support a "GIT_TEST_BUILD_DIR"
 8:  51bb01b99d4 !  8:  fd3e6be5689 Makefile + cmake: use environment, not GIT-BUILD-DIR
    @@ contrib/buildsystems/CMakeLists.txt: foreach(tsh ${test_scipts})
      	add_test(NAME ${tsh}
      		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
      		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
    -+       set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    -+		    GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})		
    ++	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    ++		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
      endforeach()
      
      # This test script takes an extremely long time and is known to time out even
 9:  9f5276d79c9 !  9:  8a660a2baa4 cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
    @@ contrib/buildsystems/CMakeLists.txt: endif()
     -		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
     +		COMMAND ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
      		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
    -        set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    - 		    GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})		
    + 	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
    + 		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
 -:  ----------- > 10:  966fec83b77 cmake: increase test timeout on Windows only
10:  ef6a304368c = 11:  aad17d8f858 cmake: copy over git-p4.py for t983[56] perforce test
11:  158a41ca7a4 = 12:  c27f620dfa3 CI: add a "linux-cmake-test" to run cmake & ctest on linux
-- 
2.38.0.1280.g8136eb6fab2

