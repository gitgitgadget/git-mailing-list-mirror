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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D18C4727D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AB120936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX1lH25L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgIYO2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgIYO2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01CC0613D4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so3863515wrm.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bRp5s+30vZ/dwGxaU1pFoSCDKRfHr+eKVN9HMmOsOR8=;
        b=DX1lH25LZ4AxHdDPXmtSHKOdCVVpv1iRkdh23bmUGDljgSDisBa4e5tiBH3GxRPshS
         68Xer4PTeKeGMJW/cCctNb8XVaLV6F3xBTLpBWZn+JFkwsqaeJyGdsN6CjwE8DxneVQQ
         sxtjRmf2KC32uix8YHWFZOaVgwVlsI1P64AENVVTCjz+XjVcY+YiP5WEnG1ojf+aOtS2
         wo9zYi9W+W5vQEaGg7AmEmZIGJucfNsLL36oW2Mnf15USkpJlVuP4VL5FoqixuO6LW8+
         8p6SfXtrWMUTyrzYNtDBvG8jXvO9O03kRbfViDEWPh8uauNkkA/71pJjqUb4dFtzXHgh
         o/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bRp5s+30vZ/dwGxaU1pFoSCDKRfHr+eKVN9HMmOsOR8=;
        b=pdUH6CVeUg/KYJQKFOa927DoOKznaBBiY7A2IIwROxTKBqi/GmFe5JOK+SO72LY0hb
         2R1xI0fQ9AXQoewq+ajl2Fqe1XFvVqmmHyPDnN/7UAB7n6/0DAwHVvtJhQB8mucdEXVu
         tyU6Xh3+H4M1TOMgDD8jeWP7iyfq+CFaL5EoKUXp8USk1lM+iXyXI94E0GgqLY0v7kqT
         XbhhBEvMOXF52S4DZzTIH2H2nd9Nek0vxEsXS1TJA7sGloR/+xFsLNYurW7xKoR6MMAa
         vTHWdchTbptdCAFnPEJ+hGiMLFmJu4que1zSkBCkkr1UuWI0vcUaKEqAWWOTCXLY2P8n
         vPkA==
X-Gm-Message-State: AOAM530d+OtzSznvxa+qvWrW0eb7cuCsUdq22lhIZxFmggVeCgvDDX6o
        zXwvIrBYtnvkDrgHTx/Rrh3Zn1q8+Fc=
X-Google-Smtp-Source: ABdhPJxc9uYZ8rTOf120IveHUeXQUD6dmHmmnVD7GyGfGQ6UZ0BjnSES80KcVS6HevkQTVQYecz+Mw==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr4803686wrt.84.1601044125000;
        Fri, 25 Sep 2020 07:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm3032610wrl.11.2020.09.25.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
Message-Id: <bb8f122cdec94e1ec77b37ed16a7151f5e35a93a.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:34 +0000
Subject: [PATCH 06/10] cmake (Windows): let the `.dll` files are found when
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
index e66ae137c2..5a4e0ccb01 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -942,6 +942,9 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
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

