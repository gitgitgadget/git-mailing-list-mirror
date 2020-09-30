Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D85520789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtuH6Wtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgI3P0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3P03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D5C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so2148135wmi.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wJhsn9s9LUmr1GfM3h5PzVUuBc9RI5okijDIrwGDNOI=;
        b=TtuH6WtuHHaG+qXmRVxyx0NpB6jNUKhkMYEsftk44Z++AT23SSZ5UeYFGve20ZUU6c
         LaTHhPYi4xXYT+d088xmYE73rRmGBXqjk6J8kEM4DvnHEZE4x1sZmPebknmcMC3GGRis
         gcy0/8Ejx5Ie26WoG7strjqGW3/NItHWm71+J7Q1obFyUF/Z7TA2slnwrKEEnjVOlPo6
         naEg/44zLA24kkoVsxrw20Vdwr7nY9NLS9gYZnNPG8A1WvRBIRmljmPKkg4sypR+Z7wl
         iajo5NT9AcLiEztv/ntgEG1rHhbNFbQV6jjmC5sRsvUv2/S4HUUDbjaiHusR898gOIcQ
         +ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wJhsn9s9LUmr1GfM3h5PzVUuBc9RI5okijDIrwGDNOI=;
        b=cZgVl9FZjbpOiaQLT4nV/PCZ2x4l1DVh5ExsOo5x7GINKu+CT8S4QCaBjAHdkv0PYn
         BPXhN6i5kTkRk05pmWbHtCSrjg0FJ+NSh0CkiMGz3BjtiDFD2mR8u7nwiWWcBLqa49Nl
         D+LZN6lhxQNkmEFOv4Jaf566bTQt1kglMqfjP1Z4b8prulho0uobUmT4UgR7pjgDGABP
         6dkGkw7gb9DkLidIdOqG9tGRiQpsMEjpeQJrqq7Ud6LhaS0J+B65zmh5rbSdCd9tzqB/
         rJq/EPfNHlgk2x84aMuII5DEkB8ut4u6TjUr7HOtloode4SGVmCnt3X9BWOLlsqQoskJ
         g6jA==
X-Gm-Message-State: AOAM530cAglIZX/Olv4D0/dBsOH0lKE3s+L4O5ZiX4KiCUCyC1K4iF8F
        JsXTiXg9DE5kdAilV71JCLYtN6YCvH0=
X-Google-Smtp-Source: ABdhPJx8Jpm0a4ZJSRy5Z1DtA2BEhX6zR2OKIIdj5UUH7SjouZ6PeNxjyYgXQEFQ+Ai7PuM+80ck3Q==
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr3757833wml.145.1601479587876;
        Wed, 30 Sep 2020 08:26:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm3674794wmb.17.2020.09.30.08.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:27 -0700 (PDT)
Message-Id: <3b467360bbc2c03474a7f704d23b1fe1df56dc49.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:16 +0000
Subject: [PATCH v4 02/10] cmake: do find Git for Windows' shell interpreter
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
        =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
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

Helped-by: Øystein Walle <oystwa@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5007f173f1..1847a6fd58 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -41,7 +41,7 @@ cmake_minimum_required(VERSION 3.14)
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
-find_program(SH_EXE sh)
+find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
 if(NOT SH_EXE)
 	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
-- 
gitgitgadget

