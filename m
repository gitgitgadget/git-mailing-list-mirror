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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A161C47426
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B743A2087D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXlMUbRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgI3P0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgI3P0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:26:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A861C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so2294357wrm.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3+v/NPeohgIj/LltCpX/xIOVrwjdX9QYWXChmKgwU2E=;
        b=nXlMUbRisPRmHqM9fSZaURr82pp8iLQHAqD+/grrgpw4y/u4IgSFgb8j4H+tSAXpLt
         i0g6F08OD5hV+3yxShJN7ciiRCJxAVP+OYheL+NgTG55zOvG8T6JxA+/HPu3Pw5MWWHo
         /mH7EAYZe8ipW3vpZeDY2/UghrdYEqR9FcWXTQTIX5Ix8dmGZKL1tjRbaMJ9hPx/rdWX
         uFNeFrTirEXHInnVosjaIkVAv+kaN07sziLk19VRwcj1yPRkGJuUKwyyi1F293v4eB74
         NfRYau3ovS/qVP22DXPTjiDZqBHKec7afwcWuiHkB+e+A2pZsqdXgrNI+GOu7rZt+jku
         bdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3+v/NPeohgIj/LltCpX/xIOVrwjdX9QYWXChmKgwU2E=;
        b=Lv0inJo7qsI+e86jgMKYlxPuZDhdy6x2BiaJV+0QBDuXLUNiHrJ50MoM8qpdd2AJ5D
         lBu2kPMOPjVJ5aV+HqxHRHi7mhXmd9c4AIJTV1LtuyuOPu1VZbR36029yM6hw9yotpw9
         7UtuAw35x0htELdrEMXDdAT4QkBfw/AENwp/g4hdjAnueFG1vF43NU5mT792ZFM+vKB6
         ud4nLCX0cmGacSdkF1g/qX9OOa0/8wnHsCGbmLqWqP5TmdqXPsY6hItnKGv9a5XEl+NM
         YkG4rJO/xWluYRkwVRUqW19tavtZjsp3l2aoUq+VVD9DK6RznHKzQo2N/HPArYVVg1RT
         X59g==
X-Gm-Message-State: AOAM533DbSTQ4GQSGFmSKzp4UQKs8S3tQMYXL4szaVzXg11cO8JRAe/B
        nMeV2PVa/ED8SUVNx1HQaALzkfypAhQ=
X-Google-Smtp-Source: ABdhPJzDNRG/7lt53h22vZHdLDuzlg+oOPE4ZYxC96/l+yQNcs7oGD87v3d92Uw5D4qjN0nSsDEwig==
X-Received: by 2002:a5d:4c86:: with SMTP id z6mr3612126wrs.23.1601479591005;
        Wed, 30 Sep 2020 08:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26sm3426252wmh.44.2020.09.30.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:26:30 -0700 (PDT)
Message-Id: <d402f721c2568486f2ed2c58341b9ebd4594356c.1601479585.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Sep 2020 15:26:20 +0000
Subject: [PATCH v4 06/10] cmake (Windows): let the `.dll` files be found when
 running the tests
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

Contrary to Unix-ish platforms, the dependencies' shared libraries are
not usually found in one central place. In our case, since we use
`vcpkg`, they are to be found inside the `compat/vcbuild/vcpkg/` tree.

Let's make sure that they are in the search path when running the tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 3bb74337e1..55d0960002 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -939,6 +939,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
+if(WIN32)
+	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
+endif()
 
 #Make the tests work when building out of the source tree
 get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
-- 
gitgitgadget

