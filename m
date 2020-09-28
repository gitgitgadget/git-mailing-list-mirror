Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C995C4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B13208FE
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnYwE+Is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgI1VJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgI1VJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D367CC0613D4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id s13so2470223wmh.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mROlaAqGuleOiQrwsPI1QWzk+QPq1+bLzH417ff8OEA=;
        b=SnYwE+IsJpkf7qLDHwYBGgWvjaN5kdjrbAbHGeKMsJo/I6NF2arKlVFXsST8kpaEeu
         kF7Xoy02HfQfeqpzqQo+Qr+IQH/fiVA+167DYuSupgoCmkB/G7nXxkFEmcRXZ1j+T1Ar
         AN4h4ugx2NZN6/WYv8D24kQ/3sClGhvbLe8S/PcwS4Ab7rQ7jS9zjyGzX9Jq0tHnCWTP
         BLA0j59znW/K8+madeszM0/EYzMpnDg/bCPaqVYw4r8STPt391Cg4YV9bYR/pvpWouZb
         kJFRNX3r+/7/mUoLeGPHKHlCGn2fphdqvd4YOotbT6ULSbkIqhDNgEPGGv4JXDDVFJt5
         sjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mROlaAqGuleOiQrwsPI1QWzk+QPq1+bLzH417ff8OEA=;
        b=E34F1mS0iB3UXgDMQbb/4zjKQdQJeOgOobQ6geqfBq3FLpJNZkySYXqd9YvCQ7iI+o
         e9IVKd00HzRkLeypC8NF1F2o1yD/YM3x8GbzGK1FZf2Z0oOvebDiO4YbDTDsfoH8rhLq
         tpTaoEUEUOTNoKNb8srgqxy6DumdaNF0UBiRkHqClJaKhMn6OwxMd8Z/z7j1poa7A69p
         EYpVWmacIs6LT5tUwa6Md2Pt6cVmRfxYCSrKJwpPiK0MHtjXhXoNNO1yrhR2OaA++dVc
         H27qOAOS8/yxqJZeRTpuF/KQrMtGIyES/AtcunGCvIJd1Iml0z1j1iSQ3Rl0hnF35Xos
         UvXA==
X-Gm-Message-State: AOAM5319RVtI6yr7bonesAqLh7VTgjhVvSshxdL44UCTFS+C7157zp96
        mQr7pEn8rhpvspqf+GJNsMmm6lMw248=
X-Google-Smtp-Source: ABdhPJw8JrpcxYPmSEcI6dyTLKFirzYncUDwTRK3/HmIft3tgwlfzkGgyq94jc8SU2AnXLzxk15vRw==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr1036971wmk.10.1601327371337;
        Mon, 28 Sep 2020 14:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm2568415wme.11.2020.09.28.14.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:30 -0700 (PDT)
Message-Id: <c3e235fe39b41b90a8a00d81220cb28e83580f13.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:16 +0000
Subject: [PATCH v3 11/11] cmake: fix typo in message when `msgfmt` was not
 found
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4b16744847..b9fced682e 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -166,7 +166,7 @@ find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
 	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
 	if(NOT EXISTS ${MSGFMT_EXE})
-		message(WARNING "Text Translations won't be build")
+		message(WARNING "Text Translations won't be built")
 		unset(MSGFMT_EXE)
 	endif()
 endif()
-- 
gitgitgadget
