Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AC7C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiLSSjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiLSSjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:39:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D53194
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:35 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h12so9567500wrv.10
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63oeiQDMqgIrLsutQP66d08v98DT5QkEwaVddx+Yxdc=;
        b=BjfXg41jFGYa2d2AzHc2wHrA/66JdRCNtX2VVhBh9CggSOyQ73PzuZfNmw5wICQI1P
         gjYTNRSCpOrbg/JDl24vSdEKAZm5pl5zKLi0f7BZgUIF4MLOee3fhCFGyNMqoK4SR9+F
         M+3LTIoUJFkJFoz21tsnXgdm9fAoEVUtaUjdn7hYJtrMG5LD304DCLHrrx4mWD8r4TnL
         IFaab5ggwntFo1L/rf+Y0K7uzqIdi6T8mCkRls32KNU01adOKsjMcU/MpK5w6L2xET8o
         BFTBiWBdUO5l78AucrxTJr5Sy26bF2Q7hw4LFxkCSInan7OPjhcUQb2biP0iWpE4FYDH
         m0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63oeiQDMqgIrLsutQP66d08v98DT5QkEwaVddx+Yxdc=;
        b=6H/11bJiC+X7hw1V2m79/97grn7zCbNXHDculew8vQOBQLdibRT3Av3cGYYdamJjCR
         uAGVs4A2pSspyyb5EpPx3cdX79OiPS/+BlImTu+zLUZqaw+PhWqmpGlGZRjtNUlL+oHd
         Do5Nf/AfPp4IDwkCGKPkDsGMTNkIeQHh6H0UX+0hpZuaGRCSGpFRpgFBNTe6B1KFkPJn
         B7Ao0TlmhVoWB/tYqa1qUlU5nwWfre0X0YHwnZpgT4vUue6iUJOeB2F6Gvo2Qnz6p9zH
         sjCMVOdyM2UZssGB9Bekl9es3lk65MFAuViIUFIhqo4mxPLrnHl7mBczRzFQUQ5bVX5R
         bVeA==
X-Gm-Message-State: ANoB5plPlJbcnBT7APv+BAe8BVvGbEczbILj2WJ8DFtjRzo4yzcglRjQ
        tH0nWqGIo77MZWdStIj05/hLnpowosuSuQ==
X-Google-Smtp-Source: AA0mqf6MbuW0mfh9+yiyMvgHXZTjuEzw0EgR2xELUd1jLgRkMGbShglnCNYKsxWh+AJOPPOYH0I8Tg==
X-Received: by 2002:adf:e301:0:b0:242:30c8:c36a with SMTP id b1-20020adfe301000000b0024230c8c36amr27072447wrj.45.1671475173451;
        Mon, 19 Dec 2022 10:39:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adfe5cd000000b0025dac4b615dsm7286790wrn.3.2022.12.19.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:39:32 -0800 (PST)
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
Subject: [PATCH 4/6] cmake: only look for "sh" in "C:/Program Files" on Windows
Date:   Mon, 19 Dec 2022 19:39:22 +0100
Message-Id: <patch-4.6-c23f659c054-20221219T183623Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221219T183623Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guard the finding of "SH_EXE" in "C:\Program Files" with a check for
whether we're on Windows.

This Windows-specific code was first added in [1], and later expanded
on [2], but since some of that was added this build recipe has been
made portable outside of Windows.

1. 72b6eeb81b1 (cmake: do find Git for Windows' shell interpreter,
   2020-09-28)
2. 476e54b1c60 (cmake: support local installations of git,
   2022-07-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d45b9c8e00a..560a15ed35a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -107,10 +107,17 @@ if(USE_VCPKG)
 	set(CMAKE_TOOLCHAIN_FILE ${VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake CACHE STRING "Vcpkg toolchain file")
 endif()
 
-find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin" "$ENV{LOCALAPPDATA}/Programs/Git/bin")
-if(NOT SH_EXE)
-	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
-			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+if(WIN32)
+	find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin" "$ENV{LOCALAPPDATA}/Programs/Git/bin")
+	if(NOT SH_EXE)
+		message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
+				"You can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+	endif()
+else()
+	find_program(SH_EXE sh)
+	if(NOT SH_EXE)
+		message(FATAL_ERROR "cannot find 'sh' in '$PATH'")
+	endif()
 endif()
 
 #Create GIT-VERSION-FILE using GIT-VERSION-GEN
-- 
2.39.0.1071.g97ce8966538

