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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC676C4741F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FCC2371F
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2a0w6cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIZVdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgIZVcz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:32:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09AC0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so2648446wmd.5
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eZubIZIwUMiFrmcNwqR+VL9ixmOdNHlOZovIEYzMITo=;
        b=T2a0w6cp3ib42t8Jn3/JWZoFshPEiLB/tqtLqyV1j8BbNu5Gr11Ss+WtzghD/CCrI5
         XAvG+HBAGaHmMBZ1rn/V2rV4d9PLWdeSAQlMkHKCesxsQ7yf5fnHVgq3CS4xlPnYkUx9
         +vrd9l7yrRUYrXZ8S/UvGiCHcsYgZJ2z27tZEejVpDI3O8z+IP++UKyoXqu2oxM/hPdx
         ELsC0n9vGP/DcqnBJBThsKSIGqhEAqNtXomrH2mn5OWMrdNCPwbQV2h5/3OLU6b52+9t
         DhTN1yjsOC4z1Ftrh6Sd/RTLuhAYLqTzXBMDvyUL7YUdb+UwBk8SYVvuvW0k4rkbtlQS
         wn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eZubIZIwUMiFrmcNwqR+VL9ixmOdNHlOZovIEYzMITo=;
        b=QmzCrVdVwIs+ZYxmaji2feZPbmdkvHycOaCmZ850GWe1HYQ2yI0PPGY7C90kXRJdjx
         DrbwXv8WpE3I/UsGobEsuzPxT0eNt5x0/2kXX/mwMYv/yP3tllV++xEHUrwX9HlrYaZH
         iSHiVUrLwmFF5YWYqt1fchue8UhBXmMvTkFitGisP5pKFRDvy+Of7qXXsp+gIE/zW93m
         CpvQrKmY3BY/DMorvS5rTTvjEfeeRKF4gGYyTN554tOf7GOogaXOfHWmDhCapJ93vmcb
         zF7so1uj6/JkL6SyzRMMd3G6gjiZrb02aHAkRMTTtJmoOBm/tep7XPLb5N55oMG/j2+m
         Kw+Q==
X-Gm-Message-State: AOAM533vsUJ6QZ7JZFPTCIEq/tsM/jFEgGN+8wadLKrosoAfvkaDeXoM
        i6QwTe9PfOkTG2A+aofDrWuKL9vGaKs=
X-Google-Smtp-Source: ABdhPJxTL/XqYBL9FTA7IIp5EqiJZufn7i6smweNavIpUrUWAiCRvRDVeNAUmlTYjfoBsuqkP1pzag==
X-Received: by 2002:a05:600c:215:: with SMTP id 21mr4041989wmi.105.1601155973320;
        Sat, 26 Sep 2020 14:32:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 92sm8268306wra.19.2020.09.26.14.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:32:52 -0700 (PDT)
Message-Id: <5967822a0c69b9f822d3a4f6412c626c4a43cc35.1601155970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
        <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:32:42 +0000
Subject: [PATCH v2 03/10] cmake: ensure that the `vcpkg` packages are found on
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
index d14fa4f3dc..16014ac4f7 100644
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
 
 find_program(SH_EXE sh)
 if(NOT SH_EXE)
-- 
gitgitgadget

