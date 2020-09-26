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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1BCC2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5345A2371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpJzDxGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIZVdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgIZVcy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A5C0613D3
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so7672275wrr.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xnkt83SLDEtUSWd+hVptfxemrNoGCKpXXnlEscdf5MA=;
        b=ZpJzDxGWj0D2KBE32RpFDHf5pFpJsIsCuAQyHh7vgsntw0z43mEwb3lph5NbdEvs1o
         HYyQIUOU0aEapjJKI2tI4TUFv+2tUlH7neBLmTbnUPf81J95vHj9S6qNcLLrnlZ9Erpp
         1IlRGOfMvawQOVbJ31yd94AtwPQmsTOTNgeLqrQ1LcRuo+Wr0nXnfMoah57qhAO7xXx3
         21st+L1es+/Kk+wGCVylmCge4p4feErRNG8QxnvCvneIgAhZF3cCam7Pv3VIXpwBeCxi
         mvrVtG1FdVqybwObeNvRlY9A74opMSlt25UoGxfjlPg3cCcKPzQVnyBEJCpu4tf34Z0R
         X/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xnkt83SLDEtUSWd+hVptfxemrNoGCKpXXnlEscdf5MA=;
        b=Gpkk25grxPyXxwHY6JHIg7lDAJifMUnCLjak+J+rC2sC9vRueQEE8K1wlWYPuDvRjQ
         kLMPL9jifAMK/5BWmgpWRXJNqx2QZn1KLNFwApuDUKh8JdVzcRvo8HxwZeB3RVt4Jidr
         o48ayhhnqN9LO74hSHohjSobQ94YttktBWpexFfZN5SDfA2abgaGkJ+3te9Xo9CMRGf8
         uBbORL+cUafzqlmYac1/XRCXE2V/zsdREAku44PKwVrMRnf+i1CgZuZcHm73hBn6S6Ci
         b3Ms96tRsSSP7ROhgPZUam7gDpkdgsQwiUiAHl81s3Pl2DvHZe/jPAmhxDmbBgzlODcU
         usgA==
X-Gm-Message-State: AOAM530fmalQjEhFFKKd5GxuRMX/BdLvt3/7ClWd2hyzKMFIUzVnbHTd
        u/WhivGkR2wLoe9fKz6qschzqHEqdok=
X-Google-Smtp-Source: ABdhPJxuW1rsS/SxwSkI20rDdST1Mqnpibf1+LgrAh2mwWdkJYzPsmau/eYFTYmzFuZsYSjcn4UvZA==
X-Received: by 2002:adf:f78f:: with SMTP id q15mr11104421wrp.206.1601155972602;
        Sat, 26 Sep 2020 14:32:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm9035747wrm.54.2020.09.26.14.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:52 -0700 (PDT)
Message-Id: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:41 +0000
Subject: [PATCH v2 02/10] cmake: do find Git for Windows' shell interpreter
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

By default, Git for Windows does not install its `sh.exe` into the
`PATH`. However, our current `CMakeLists.txt` expects to find a shell
interpreter in the `PATH`.

So let's fall back to looking in the default location where Git for
Windows _does_ install a relatively convenient `sh.exe`:
`C:\Program Files\Git\bin\sh.exe`

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5007f173f1..d14fa4f3dc 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -43,8 +43,11 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
 find_program(SH_EXE sh)
 if(NOT SH_EXE)
-	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
-			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+	set(SH_EXE "C:/Program Files/Git/bin/sh.exe")
+	if(NOT EXISTS ${SH_EXE})
+		message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
+				"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+	endif()
 endif()
 
 #Create GIT-VERSION-FILE using GIT-VERSION-GEN
-- 
gitgitgadget

