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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FFC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADFD208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hth0doFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgI1VJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgI1VJa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F2C0613CF
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so2882603wrm.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rX2Dj+oWrd4r59ndA5A4C2d6k95oGn7NtTa+QgL9tws=;
        b=hth0doFFak+NAmXfuXJzhV3xNlJ4E8ZJFrhzgnrMm9hT1NGWmXShhb2dh9AdTfBJec
         u+Qt5dJt9j9W570NoYZ2tvrffDeKdospkLiwK4XVBj2C2uNKG8VhwZGx6E0bCnB2Qeek
         dAjC3G/OuhSS2aeUJQUUMMEK9f0nB19pKJU6iCJWzvG5yO6itP6TZs2KUnhqTwwb9SzO
         ZyCLjlUPn1k421Wm16SVVwegewCcoV5EK3/6+Q0KCGk2HuuAd6SnM5HAFpkr+2e4WFm2
         lA/KIoC8jFlL7sB4ZKKVb4XjCyMvJKY1qCOADR1m9tpmPgQzwhbo6X4AxMnnsm+5NZyO
         Pbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rX2Dj+oWrd4r59ndA5A4C2d6k95oGn7NtTa+QgL9tws=;
        b=NKLnCsyJs2hNnLQsXdDhGy3R9el/H4yBRmjrFg3+30y+cTubl18WeP9nM4Mhce0ijN
         0FS6N7ERmpdfSOImKfiTh0EXxZnO7+A1eetCilg0QkfUtcXMSz22laAhHLCek6OQ3Hxx
         oDR9YsRKk3MlZIgjeSmiW9rd2+EBkyMO+yS7Xh3Oys/zwkve2ZU8SYYP7zYC7eIM9pOF
         Pu+x/63el8vr54N5wXrkzzxwWI3TECuvJvRgOhokRvTRkWAFgBVlmXOdo26gsBIjNRSX
         02loiciOMSNkLotz6k2Oh1T+aa4rw9t48HcJjpDtXXNLrwcsqHpr2Z2RgpDmZzirSI5Z
         BCDg==
X-Gm-Message-State: AOAM533mJUk+fOe51vPANSEsNb/Dzf9j2kkJT1ch6Uksaf2AbGn8XeeM
        X/mMP3XnYWu5ez2WV80HZ+cLZy0sLtA=
X-Google-Smtp-Source: ABdhPJyfqQjTgYM0qXgadHfADaBy5oskyuF2S72L+UA64uCkspYUT9EPDB53LZTPqL4qgI36MJFDlA==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr418189wrl.54.1601327368356;
        Mon, 28 Sep 2020 14:09:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13sm650624wml.5.2020.09.28.14.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:27 -0700 (PDT)
Message-Id: <7c1601c7e351855fd720df05efc44440374792ce.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:13 +0000
Subject: [PATCH v3 08/11] cmake (Windows): initialize vcpkg/build dependencies
 automatically
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

The idea of having CMake support in Git's source tree is to enable
contributors on Windows to start contributing with little effort. To
that end, we just added some sensible defaults that will let users open
the worktree in Visual Studio and start building.

This expects the dependencies (such as zlib) to be available already,
though. If they are not available, we expect the user to run
`compat/vcbuild/vcpkg_install.bat`.

Rather than requiring this step to be manual, detect the situation and
run it as part of the CMake configuration step.

This concludes our journey to make it as effortless as possible to start
developing Git in Visual Studio: all the developer needs to do is to
clone Git's repository, open the worktree via `File>Open>Folder...` and
wait for CMake to finish configuring.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 13d958f5a6..6a92ec9763 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 if(WIN32)
 	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	if(NOT EXISTS ${VCPKG_DIR})
+		message("Initializinge vcpkg and building the Git's dependencies (this will take a while...)")
+		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
+	endif()
 	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
 
 	# In the vcpkg edition, we need this to be able to link to libcurl
-- 
gitgitgadget

