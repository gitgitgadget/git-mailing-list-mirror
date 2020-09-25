Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0BC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D77208A9
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHkKpUBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgIYO2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgIYO2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D1C0613D5
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so3792137wrn.10
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A7/vEiSfbruVzpIjxqhvsJGFYNIJMT4r2lhIkZ+V9Eg=;
        b=YHkKpUBChgdmOPW7YwfZe9FNQk5awBC+Y2lD/VhfegafYkRx+u4ZlDDnBNDFfocvIR
         nuJ6kz8qdMW5Wnhcz1E32olVikxfLxYiF8DV7z+Aj2LfudHCwGZtDsdszhbbhi/K5JGX
         gW+38UmMnE42yNlSvbh22/msaEpkZB64rj5LLNftjX+pGZWj/051loouP08ay1yNXNaZ
         yVhgHrMVQvBOqz7Oxj+ZSu2AfFRNqeu56YRi4Z14ejovYT/gHf2MYd03of95F6XpE5kL
         c/TAtI81U67FL8XE8P4wBIKFpw7Ak4JmQRVEydh0VljVdX+xXImXCMLIAsnZt9nEMllu
         Y47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A7/vEiSfbruVzpIjxqhvsJGFYNIJMT4r2lhIkZ+V9Eg=;
        b=Sh0Ex/bPidkVWshwKZ5pnfspZ2+ZxDSzZC6ZI2BfwJXb1eChBounFU8i61ac3k86Da
         Lp6Wc8YTg82ZDGMWhUeVf9z/iQKjCkFqKt9n5pZt0+f2LC2YS2Jf33OZs/0NsTaf7HGA
         QFiXjmu6U0ZWznlJEc20TXkKAHocZ3xENUDTZx8ozDRWPaSlDh2dIKD6h8e3s3We38dc
         KOs+qSlI3uupNT5DDy1Ikb/JFbQt+KN7msZoBkxkdLTrqVpRhPcL/EMw29dxTEd56Kvw
         EQcE04ZhzRsV4Cl9blFmvOqzvgilXJo13Yyk7hPpmDv+IKIhLy1rI36BukGWfjt3vdTY
         zGDQ==
X-Gm-Message-State: AOAM533RI9tR+wgzDWlU40tP1DFLkj7AmKDZACjibfFEX4ITfJl63nAs
        dQo4ziXzyyDWrD8MjBT3kadlYQZ7i9M=
X-Google-Smtp-Source: ABdhPJyr5zthRmE9JlPbNHM23QTeI9htGGf1tLpSb1fG+BlRx10LFIxpYmFLf6j9xRZSTJT2CSQXLQ==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr4680832wrq.278.1601044125910;
        Fri, 25 Sep 2020 07:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u186sm3122898wmu.34.2020.09.25.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:45 -0700 (PDT)
Message-Id: <dddfa3a9b48fa24466a20952d485be1a7f515019.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:35 +0000
Subject: [PATCH 07/10] cmake (Windows): complain when encountering an unknown
 compiler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have some custom handling regarding the link options, which are
specific to each compiler.

Therefore: let's not just continue without setting the link options when
configuring for a currently unhandled compiler, but error out.

Note: for some reason, the `invalidcontinue.obj` trick seems not to work
in this developer's hands when building Git in Debug mode: the assertion
dialog that is supposed to be suppressed still pops up, complaining
about the `entry` variable being uninitialized when it is used in
`config.c`'s line 1961.

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

