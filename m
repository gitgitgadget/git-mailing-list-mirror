Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B947C4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326FA208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlgpsnPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgI1VJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgI1VJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DEFC0613CE
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so2534684wmj.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P+1UcXSjxVBg36V9LODbOciDWEAxpf7ke05kH2Rw6l4=;
        b=BlgpsnPgwUFUOVCacQTSuB2bLyb/o7weDCtc+M1m3dQnGKWJacVufxOcAJl8X3iNgy
         QH8voLm/lxMOXR5d3VsxJmd+HGDzYR/5zCQUMrBLd5nKAfr30I6dW4XXjzRk1/SL4ny5
         EKrTaOu+rCYGupumUKYd/mwIokW2avZs7Md/qSIT4FTDNrznyVU+lekkxTGwfx+KLoPQ
         GMgemhJGibS+Fv/b0nSI7Pnqjflc+QjZKRFBE90IJY8UYC35eJGXi9+6U5m3C+CE6zKi
         S5IUwG4vIRnnidJicZKyFHONvXkFBYXcjwzEp6rPNC2ndQxyuxdLlMDyJx09qooXBWl4
         0j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P+1UcXSjxVBg36V9LODbOciDWEAxpf7ke05kH2Rw6l4=;
        b=LwjHzMFWd6011PWJUF8p9HTmYj1+qtFPGmfwzzKpBpfkZwejhRDJDfx/I+G6GFTE/O
         XFST5Ae1FXb+sxYbiA7m/fr3jb8BDSkIngTgXfO1VtHip5PZ1LTIDpgWg3GuoFol585J
         fUPvC0pjqY1t0fY4HrKYm1J75rcUfjQ1MmWDHXUbteq1M1Py1W9MbxWtuPSYifmhruAo
         2HV2Fu+Aj++oIkaxqsPZub8zvEToDlMPva11JhmrSMoVq23bZZ7b/fE3dbBdnzDCPGUK
         50J6Bbtgv51AgIRkYv2qGDrblxmcJtfT5AH7jqa+qdczxZuBLi597PuAfqjgBPuQ2dBt
         eRvg==
X-Gm-Message-State: AOAM531v8IhKTmc46ep3hceciQZskc5fUgigPFjkC1BjyRRrUtb9ro8D
        rTO0Z1TZuHnIH3R+/fQeSvt9k0ZEFOo=
X-Google-Smtp-Source: ABdhPJxka1bKlYStnU2i6CsEjtyicL4EL9/0CzrjzwENPpgXZDTkp0YIcX4Jn4+GR40bY76ZwIVdjQ==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr1010548wma.162.1601327367339;
        Mon, 28 Sep 2020 14:09:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h204sm2704970wmf.35.2020.09.28.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:26 -0700 (PDT)
Message-Id: <7a4346a437b9bf1ebddafa5f3d92c118793c0078.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:12 +0000
Subject: [PATCH v3 07/11] cmake (Windows): complain when encountering an
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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
index 361fe3de6d..13d958f5a6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -617,6 +617,8 @@ if(WIN32)
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

