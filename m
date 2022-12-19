Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63A9C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiLSSjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSSjd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE62AA
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h11so9551250wrw.13
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8tippjWZo+425YDwMhwp+rIZ6l4ZWXRKUWSKWbZ7gM=;
        b=nIwGFbAuJABL8H6TQsrcDUpad/IjpxFePdrWw+VVlztfWacacnrbIh1j9Pr3OImnnZ
         IfJQWK7xxPPduRJ2nPHc/l6Z5Ma2D7JmmMc4MjsdCCuqDbH76Suow7Vw+mIOjUjp4eIj
         E6Ar5eRGJODTzR+1cXkg9MpNqdZ2gvULKE1EQ6kRXa4/DdFY2WZvq4t257i6rEZev9Md
         zLtJ6bPRm5CX48bpbO7e8bVlX2IBYkqapJvyyAXm0hTiGG8nVQ2YyilmIBCDplvFDGh8
         Cn+hQ48zGETWG1zRT1axSRptVzCuEsvxSe+H5FuBFfPU7M5WlZza4QrDr6ylLWX2ibFa
         gGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8tippjWZo+425YDwMhwp+rIZ6l4ZWXRKUWSKWbZ7gM=;
        b=u97Scm3/uzBYt8KAR8ZFSOrSouUD3R6OtR8DLCDcV6JkXRttjuEvHeD3CXYCP98Czy
         tRnx/aWsmUHl9i6tyipse5QmZ/Tsa6Vn3vgoV1tRPikUQdilYKXJVomynMHQpZKB9hW3
         spcoGT7RY96C1MqcnSHSiWNZjcd88zjqoOE2PU4S8+BdDhSipUOxjbEgHZZYOelppvHc
         hmUVZIs4KViKmNr0mzn+bsw+azBC7KZxe95qaZBBucS1dcFj3DfzWsqzx/r2j+cfvcuI
         WaleeSjLyEBPlGNMLS7tfOjvAmkko+LhbqT7xFvT1L5Gy9ykok2puaj6OPCvmXa20s7X
         llmA==
X-Gm-Message-State: ANoB5plx4HbuecGYQgPaxbcxDIm/nb5nFrJiGDZKLmoFcJpLdErEE8M1
        FYY97rFzAdSZXpFNv8qQEt15mV/UEuUpAA==
X-Google-Smtp-Source: AA0mqf71tOP+RglFz2EekrNvE1ck6qlAhZepkXfuL5LHe6tvysFqQJMr1ftwC+yOBlTSQq2CDJSoGw==
X-Received: by 2002:a05:6000:1f15:b0:242:6588:3aa9 with SMTP id bv21-20020a0560001f1500b0024265883aa9mr40805360wrb.32.1671475169863;
        Mon, 19 Dec 2022 10:39:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:29 -0800 (PST)
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
Subject: [PATCH 0/6] cmake: guard OS-specific code & cleanup & chmod +x on *nix
Date:   Mon, 19 Dec 2022 19:39:18 +0100
Message-Id: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with [1] and [2] submitted today these are extracted from the
ejected [2]. This is independent from [1] and [2]. These are all the
cmake changes I'll be submitting for now.

This series:

 - Cleans up some dead code in the recipe (1/6)
 - Adds a missing USE_LIBPCRE2 to GIT-BUILD-OPTIONS. We didn't see
   failures due to this because the win+VS job doesn't build with
   libpcre2 (2/6)
 - Wraps Windows-specific code in "if" checks for that platform
   (3-4/6). We already support cmake on *nix, this makes it clearer
   which bits are OS-specific
 - We had failing p4 tests due to omitting copying over
   git-p4.py. This is anotehr case where we didn't see a failure
   because the "win+VS" job doesn't test that part.
 - Do a "chmod +x" of the bin-wrappers, Windows didn't care, but on
   *nix running the tests would fail *a lot* due to this.

All in all on my *nix box this brings us from:

	80% tests passed, 194 tests failed out of 983

To:

	99% tests passed, 3 tests failed out of 983

The remaining failures are due to "gitweb" being broken, but that's a
general known shortcoming of the "cmake" recipe (which again, isn't
spotted by "win+VS" in CI because it skips those tests).

The remaining bits in [3] will get us to 100% passing. I still think
those are worthwhile, but there were some outstanding concerns about
them (e.g. changing how "GIT-BUILD-DIR" worked, and adding a *nix CI
job for cmake).

I don't think there's any outstanding comments or known or potential
concerns/breakages with these changes that have to be addressed, these
are all straightforward fixes.

CI & branch for this at [4] (where I have it on top of [1] and [2])

1. https://lore.kernel.org/git/patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com
2. https://lore.kernel.org/git/cover-0.2-00000000000-20221219T102813Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com/
4. https://github.com/avar/git/tree/avar/cmake-flags-and-os-specific

Ævar Arnfjörð Bjarmason (6):
  cmake: don't copy chainlint.pl to build directory
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  cmake: increase test timeout on Windows only
  cmake: only look for "sh" in "C:/Program Files" on Windows
  cmake: copy over git-p4.py for t983[56] perforce test
  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4

 contrib/buildsystems/CMakeLists.txt | 55 +++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 14 deletions(-)

Range-diff:
 1:  fc190b379cd <  -:  ----------- cmake: don't invoke msgfmt with --statistics
 2:  1a11aa233a3 <  -:  ----------- cmake: use "-S" and "-B" to specify source and build directories
 3:  b9ddb5db1d3 <  -:  ----------- cmake: update instructions for portable CMakeLists.txt
 4:  7b7850c00ee =  1:  95a6ce2f1c7 cmake: don't copy chainlint.pl to build directory
 7:  973c8038f54 =  2:  a1653607aaf cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
12:  4905ce5321d !  3:  2b5a9d2c628 cmake: increase test timeout on Windows only
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/buildsystems/CMakeLists.txt ##
    -@@ contrib/buildsystems/CMakeLists.txt: if(NOT GIT_CTEST_SETS_BUILD_DIR)
    - endif()
    +@@ contrib/buildsystems/CMakeLists.txt: foreach(tsh ${test_scipts})
    + 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
      endforeach()
      
     -# This test script takes an extremely long time and is known to time out even
13:  6c6b530965d =  4:  c23f659c054 cmake: only look for "sh" in "C:/Program Files" on Windows
14:  563f1b9b045 !  5:  70a7f3e19b2 cmake: copy over git-p4.py for t983[56] perforce test
    @@ contrib/buildsystems/CMakeLists.txt
     @@ contrib/buildsystems/CMakeLists.txt: endforeach()
      file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
      string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
    - write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
    + file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
     +file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
      
      #perl modules
 5:  82ecb797915 !  6:  3724cad82e0 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
    @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_perl_scripts})
      string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
     -file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
     +write_script(${CMAKE_BINARY_DIR}/git-p4 "${content}")
    + file(COPY ${CMAKE_SOURCE_DIR}/git-p4.py DESTINATION ${CMAKE_BINARY_DIR}/)
      
      #perl modules
    - file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
     @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${wrapper_scripts})
      	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
      	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 6:  1f326944a07 <  -:  ----------- cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 8:  b8448c7a8a6 <  -:  ----------- Makefile + test-lib.sh: don't prefer cmake-built to make-built git
 9:  5135e40969e <  -:  ----------- test-lib.sh: support a "GIT_TEST_BUILD_DIR"
10:  65204463730 <  -:  ----------- cmake: optionally be able to run tests before "ctest"
11:  e25992b16f1 <  -:  ----------- cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
15:  917a884eb65 <  -:  ----------- CI: add a "linux-cmake-test" to run cmake & ctest on linux
-- 
2.39.0.1071.g97ce8966538

