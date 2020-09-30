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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA8C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C020789
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhKTGH2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgI3P0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgI3P0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6C4C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so2294409wrm.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kItUiuMF+nPlM0/CHYf8311+S+IUXrTOtwdzzttdUoA=;
        b=qhKTGH2sRM9LhgfyHpLr0pc2nQlrvlK8VHcsqgymZQM88Esb7CQ2rfAkaEFqsuNRLn
         hvYRypMpzH6+ZGd/BWslGvSpCtxqam8pWzpEtnQwq0dBokqM6x+/mdtmIyntvgWl/WiA
         eg+MjHRIz14+Ud789A9Z06lb72LpbYIZK9RURYNr/+MQY7X5ctKqqD/1qaGFPZAsNlXs
         eUStquSDupSdmRLEkAvCjDbnNL8UrvxhUvm00K3NV6vEq7Oki1nXPU3YIJyHSaKzy194
         Yc2QX2EHqroI81NvFMmsMQHc4IetbE232eJPbB09hOxg89jQWU/eeikZsT01hBBQSIes
         Rl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kItUiuMF+nPlM0/CHYf8311+S+IUXrTOtwdzzttdUoA=;
        b=if9Wv9Fw/A39ZgfzSwFDuN/G8Do2QV2MLAbf8nKNqO6aYRDtOHjfwlFHVQEtxSM8A0
         DMY2gAByFb71pWpV6QVoGWJ2Q+Qw+t3FwOsjJvJ95cO4BqcPC6MHeBvQZpHCWLN4TPdv
         P+z9u7qrxRblBHVFC46dE/cz/bZMcxchn7CAJYip/2D3TUD0RZS8+OXd+wgAUT8i+jq1
         7Xt79pHntZNwyYmSkT+l6RyCKKdC9ZDqc6sZMG7hEFNG2y3MY2U9xCGvcAK3WnltP9SG
         9ay4EEt1IDycxu7xzosdC8pDNKKV6opGpcJJfGlhrAVo1gwYJpHK4L9qEjSU4FoDR5fo
         JEDA==
X-Gm-Message-State: AOAM533hwSvNRdZA+1JcGRglQ1TdOWIoZJAgFBoi/Ng747pCoDtuRRxc
        ebzbVzhWynUWFp5G+FxtSD4/EF9WYRw=
X-Google-Smtp-Source: ABdhPJwb/lnf51RG8oiFw7l/yZ5A4HVYc0ODLzPr1cb9VE8rOdzEwljJ1MFThdrVUrLA3397EbAg5A==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr3988795wrt.247.1601479591761;
        Wed, 30 Sep 2020 08:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm3630253wrn.41.2020.09.30.08.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:31 -0700 (PDT)
Message-Id: <0e7fdfddb4105032226d7ff16447a8cdc3020f33.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:21 +0000
Subject: [PATCH v4 07/10] cmake (Windows): complain when encountering an
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
index 55d0960002..78b90abe5e 100644
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

