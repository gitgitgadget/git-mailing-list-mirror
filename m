Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFBBC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiLSK1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLSK04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:26:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99449AD
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:26:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o15so6048932wmr.4
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfhQu6h2PAJV8R2Opb4Nv9RkqOMTorzq5HX3nSxNuJc=;
        b=UYpJns0SzkM8IVBRTbW1POdhcpbX+5XUncreD2VcW/IKfZTVXfSUJeuVh0V23faGRS
         fm+PDwBj/zlnfMHUWDkJ0Bw2kQ2q0IgUi9o+Fi0giLd2d7+YeH2262ELOloY/2Y+O3UZ
         mtFTcUkh51o900k+1Vjq30eA6CP8wdlsfQ7xq1p0w8QVjtgvKwmA7eTaMtTGrZgCTPAc
         tAOPBQ/4ICNrzuhBnM2FgfJ7dyX+Ejixa9P2K0tieJwMC0k+I2VFvoysWBum6V+/GhPy
         K2b2I7zo0IJkvjW/2nwHsEO8lxj++Y/S+bqpNqGWvGAnIGcVpCz4TP9dTDX9VaVEeS/j
         Q7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfhQu6h2PAJV8R2Opb4Nv9RkqOMTorzq5HX3nSxNuJc=;
        b=zh1UDw9KJQ5UrDI9lWT99SQIr3dxZm8nuIR3sNK/VSGIKoTtXcLh+CJipX6/SqZ34Z
         mlOUZSQ00Qz7axbPtKrIJG3aGBeSMGVal1S7ukebR2zYTH+CzqqB8c/bTq0KzU0+RdF7
         V/9IRgeFIjTcAcizjb7T4sisjhKfSXVbkrqpqoH0gb7KcoUQ4nJWlW0MUaOpkTKOysKN
         aySItcK5AhoT3AQ6iXqNmdhWThDQkv/7Zm2TZNcsCYQKTDyhRbxje2CbCrWIP91dE2Kj
         ic+XQdBFwUVzivaDprbBAMBUvJSgp8CfwtYu3D919VS3XQn/+2ZEXihAZAEy4gjHyilU
         M4QQ==
X-Gm-Message-State: ANoB5pn2+/YN0vHhctqGpXEfSNBVDERN8NqUJyY6fWSfxJsmmwBIFMMI
        OJxt6vwRdNNNqTxJFIDQPZqWrE+u6aPXhg==
X-Google-Smtp-Source: AA0mqf7nDz3LQ3KT/j4HNYRQFiuw6Dh5HorpZ0rFPphAInxw56yrZUnR5hE0co4ieBY+Z4E2CW0reg==
X-Received: by 2002:a05:600c:4909:b0:3d1:f3eb:c718 with SMTP id f9-20020a05600c490900b003d1f3ebc718mr42674642wmp.19.1671445612802;
        Mon, 19 Dec 2022 02:26:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b003cf54b77bfesm21850008wmb.28.2022.12.19.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:26:52 -0800 (PST)
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
Subject: [PATCH] cmake: don't invoke msgfmt with --statistics
Date:   Mon, 19 Dec 2022 11:26:46 +0100
Message-Id: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In [1] I made the same change to our Makefile, let's follow-up and do
the same here.

For "cmake" this is particularly nice with "-G Ninja", as before we'd
emit ~40 lines of overflowed progress bar output, but now it's only
the one line of "ninja"'s progress bar.

1. 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
   2021-12-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This trivial fix is extracted from the ab/cmake-nix-and-ci topic which
was ejected around the time of the release for that previous
submission see [1], the range-diff is to that topic.

I'm re-arranging and re-submitting topic more piecemeal. There were no
outstanding issues or feedback with this part of it, so hopefully this
can advance relatively quickly.

I'll also submit some of the other uncontroversial bits today
independently, none of which conflict with one another. Then once
those have landed try to find some acceptable way forward for the
later bits, which at that point will be easier to review.

1. https://lore.kernel.org/git/cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com/

Range-diff:
 1:  fc190b379cd =  1:  0fa41115261 cmake: don't invoke msgfmt with --statistics
 2:  1a11aa233a3 <  -:  ----------- cmake: use "-S" and "-B" to specify source and build directories
 3:  b9ddb5db1d3 <  -:  ----------- cmake: update instructions for portable CMakeLists.txt
 4:  7b7850c00ee <  -:  ----------- cmake: don't copy chainlint.pl to build directory
 5:  82ecb797915 <  -:  ----------- cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
 6:  1f326944a07 <  -:  ----------- cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 7:  973c8038f54 <  -:  ----------- cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 8:  b8448c7a8a6 <  -:  ----------- Makefile + test-lib.sh: don't prefer cmake-built to make-built git
 9:  5135e40969e <  -:  ----------- test-lib.sh: support a "GIT_TEST_BUILD_DIR"
10:  65204463730 <  -:  ----------- cmake: optionally be able to run tests before "ctest"
11:  e25992b16f1 <  -:  ----------- cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
12:  4905ce5321d <  -:  ----------- cmake: increase test timeout on Windows only
13:  6c6b530965d <  -:  ----------- cmake: only look for "sh" in "C:/Program Files" on Windows
14:  563f1b9b045 <  -:  ----------- cmake: copy over git-p4.py for t983[56] perforce test
15:  917a884eb65 <  -:  ----------- CI: add a "linux-cmake-test" to run cmake & ctest on linux

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2f6e0197ffa..8f8b6f375f7 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -897,7 +897,7 @@ if(MSGFMT_EXE)
 	foreach(po ${po_files})
 		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
-				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
+				COMMAND ${MSGFMT_EXE} --check -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
 		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
 	endforeach()
 	add_custom_target(po-gen ALL DEPENDS ${po_gen})
-- 
2.39.0.1071.g97ce8966538

