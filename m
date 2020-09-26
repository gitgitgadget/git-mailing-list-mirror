Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ADC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614AA2371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba3/e6/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgIZVdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgIZVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6122AC0613D7
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so7656426wrt.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OybwSjx477A1L5ryGyugpej9EqrdVCq1vXQ4tzYvW/A=;
        b=ba3/e6/QNJJU/MIi09nmzct3dx8BJkUmFXIacm2W+C+XwhzZFMtKHP2AIuPUMOVQyS
         KqkcMLMOtvF8cJYhc/xfilaoRoUGKD4xVdCyq/UiVhpV3pnRr9uN1ZZjs7KExmTFGwvt
         VFF/1td6xGyXc5JmtlvJHlbFAyYG8+YiF0cEeroNN6xXusvsIj6794doi7kuieLugDZv
         GyDZbXMAUIYvL4hCJtWW5q2dXk7zBhNsaixdjj8dBwQ8rQA0aPgzbF9ZNVy1qNMzTFPI
         OIVbDRJyOHrBh6vSKd2DUoxirCXmfpYKCeAyzh1BgWM142vvKgNpq27FoEtuh4jj0bBL
         8n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OybwSjx477A1L5ryGyugpej9EqrdVCq1vXQ4tzYvW/A=;
        b=lzetZRcMHKbfy3aUyBDvPGaGdHbtM/zWXQuwTQPoIl8H34DU9TBNBggVytLcZJZYtr
         b937RPIK6XY3se2cazopXhKZvYEZwZewRlCAafm9PGjG45Mz//aHYfp3LWodY/9tR1Wz
         IANiGtmXKs9840dSheEcYKXCKxj63SAb+e6OjYMpEvaYqL3jwgJbuRLlz/Bi8sLFzc+c
         ZYL4poRrKCvKxHMzaq3lDJIw1ZTMzcPKCTo/V6eWwntX57XBjT/Spcu5495y8nVLh0Bf
         hjRMeZWqYz2HtuijB7DFqO1nhHwyaTSFQQ4ldfrzc3Sy5FezFFcJKp1k9ldYGNY8bgoQ
         o3TA==
X-Gm-Message-State: AOAM531D7j4vBdgtisnZfJ0IAtm5SNftkUCcPk4cd+DNi/fa+pm932kB
        fvLyxz8pKzNMF6x2eVNVtLHBaSh+YD8=
X-Google-Smtp-Source: ABdhPJz8aRSMZnHNMQq5Ui5KaR+mFIdaB4BVTy9f+ZIAPhzPJQ0pYC45tHxxktg4hA2NTHllu9fnMA==
X-Received: by 2002:adf:ce01:: with SMTP id p1mr11221518wrn.61.1601155976046;
        Sat, 26 Sep 2020 14:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm3622145wmh.29.2020.09.26.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:55 -0700 (PDT)
Message-Id: <26ebeecb140e26938ecea04e2df2b8c000888162.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:46 +0000
Subject: [PATCH v2 07/10] cmake (Windows): complain when encountering an
 unknown compiler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have some custom handling regarding the link options, which are
specific to each compiler.

Therefore: let's not just continue without setting the link options if
configuring for a currently unhandled compiler, but error out.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5a4e0ccb01..d21849b730 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -620,6 +620,8 @@ if(WIN32)
 		target_link_options(common-main PUBLIC -municode -Wl,-nxcompat -Wl,-dynamicbase -Wl,-entry:wmainCRTStartup -Wl,invalidcontinue.obj)
 	elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
 		target_link_options(common-main PUBLIC /IGNORE:4217 /IGNORE:4049 /NOLOGO /ENTRY:wmainCRTStartup /SUBSYSTEM:CONSOLE invalidcontinue.obj)
+	else()
+		message(FATAL_ERROR "Unhandled compiler: ${CMAKE_C_COMPILER_ID}")
 	endif()
 elseif(UNIX)
 	target_link_libraries(common-main pthread rt)
-- 
gitgitgadget

