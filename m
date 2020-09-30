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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD0AC4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601B3207C3
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikhLWGJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgI3P0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgI3P0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B0C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so2276734wru.6
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vcskzXK9EhFcrWXUKoLHVMIaYwYhGcUQ60l9JuhR1gY=;
        b=ikhLWGJlKz6CPou13x0OKDtHDc7XQwgXqYew0xGhZuwYxkyjDsVPjFpweKgEGfaTlG
         s72Tyl5E9jSQYKAKZTC4aVZpHEXFOKwQmDjkPf2qmRD3ZntxnfdIU/ryV2Agv/Esq796
         YAz6uM6Zq4qLN1jAg/z7gfkJUKz4YGBzCUjAvlNsw+MJILRaY/adtBiLLrxWsH7yx7D0
         a0fAfqNqwGSd06qMM8kOg1GzlcKONty+rnQqhEWelUyw0Jf4DsMtdQl6TzvUNAuqNWcR
         YOpG11vZsp1CiuVUbM/htHEp9Kxb7y6hLF5DVVCHNfrVyFxOK/rf2gyXJDR1sTu9DgZn
         zdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vcskzXK9EhFcrWXUKoLHVMIaYwYhGcUQ60l9JuhR1gY=;
        b=jYhDkwCyQfmxDkupVIxdiksm6VUxgH4fV5kM40RM2cCewtCbFL24zzYad5zShti0i6
         dSRDFDp80NpE5EeSuac5YuWA/UHjcb1wZbhrX2TTAXqVbpJkNaohN3P51yLa5hK1xedS
         bO3nQwS3rI1ieDTprcJXcCbZUir2i7zvERq/O07cNbO+KYFkN7O2hcRYb81PPEmo2ZOy
         C6bA0KDFzQeOubYW2DHEVfJddUghUlyjWwHHSZpySU63/Stj+6pP5wbfVYLM7ZNOGgf9
         HDxtESfMFvCkquWjWkLprskyQf0uKG1QlvOKoPZExSPYEPhydkG/T9Sym3ipf5Bn+zAj
         qfbg==
X-Gm-Message-State: AOAM533cBT+qvWIeGEEHRFFz0/5paFFm/XYQgRuQtE0CkPDXR/yF/vBA
        uOibwhzgp50ksJH4NXnW8OhTdJh/kgY=
X-Google-Smtp-Source: ABdhPJw5/fM4+eJ0uCU3WrbfO/WjEc8SyscnEjDZ+0fEZn4ggueSx6qr3CKV0DoQFm8Y5cGgddXBlQ==
X-Received: by 2002:adf:f701:: with SMTP id r1mr3799397wrp.341.1601479588661;
        Wed, 30 Sep 2020 08:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm3814093wmf.32.2020.09.30.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:28 -0700 (PDT)
Message-Id: <a49b28e001ffaf73d290a6c75943ff7650f87eda.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:17 +0000
Subject: [PATCH v4 03/10] cmake: ensure that the `vcpkg` packages are found on
 Windows
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

On Windows, we use the `vcpkg` project to manage the dependencies, via
`compat/vcbuild/`. Let's make sure that these dependencies are found by
default.

This is needed because we are about to recommend loading the Git
worktree as a folder into Visual Studio, relying on the automatic CMake
support (which would make it relatively cumbersome to adjust the search
path used by CMake manually).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1847a6fd58..12268f61ba 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -40,6 +40,13 @@ cmake_minimum_required(VERSION 3.14)
 
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
+if(WIN32)
+	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
+
+	# In the vcpkg edition, we need this to be able to link to libcurl
+	set(CURL_NO_CURL_CMAKE ON)
+endif()
 
 find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
 if(NOT SH_EXE)
-- 
gitgitgadget

