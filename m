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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4ECC4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE14621775
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezSNJgbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgI1VJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1VJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:09:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A00C0613CE
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so2876818wrv.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wJhsn9s9LUmr1GfM3h5PzVUuBc9RI5okijDIrwGDNOI=;
        b=ezSNJgbU2MJt7rnO2aBx8waougkukLT054gPpOBbcHBtljfdhuEuW2GKPPqxCdwCfR
         3LS5moofPjDLsjuNjFYNszGvzEkpQA/9Q2sEaKKwvndTOXvLCTFG9gM7Vx8e+oKvQJYk
         SKoFTZ1OwCe26LcljlT5SGKYRJlZj9jJ5Yv9MLIlKTPFgIW1DG4KICc5s6h7HHUcN9Pi
         Q8agIFu2hdcEAciK4O01ZrAkMRgQK+9EjB81Mh9ln2Mmc+JZGsPH3Meu9BCkB1bZjKZ2
         SkuLYsmhpXFFIBzfr5j743Gl83Gc5EVr0JCOoJ5rXF394lbpw9Xj6PPv4Sx1vVTAM9/4
         D9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wJhsn9s9LUmr1GfM3h5PzVUuBc9RI5okijDIrwGDNOI=;
        b=f5NR91mgYgTkNb8c5QCQyssA5q7RK/XroXex16vO4E7rd81uGShcG04WQQ4R/dCalh
         /wCt1EjpIB7wNf1IdnTqg5HEc7sTvcsm/cT1P5BDJXcJRLxd6L0+QvZDpaqWbTXKSYRB
         B1/qWWhbnQEPQ71ONooEOMZPkrjYlgIHdyV+YDH8DWHfDT4HrbwiLJSr6FPVji4BNI6X
         50qoZgTI2XVN7ZEeJvBlUMRtecEdRXuAXYyiUVmLPfBwSnFUiEgYPtlgj3mNMj+pQ+mz
         ZOgQ4MWkXqZ5UKZteXpHDlhVJMdi8GnEUtlU9sUuT+nY2gex1mdqBLHargj9kwNoDSfZ
         eXnQ==
X-Gm-Message-State: AOAM531ni7gtTAx1pmh70h3EJx0KgReb3oJD2+/cbN+ZYE8EJIXQnqPs
        SHEa+Rn5MWK8IhVjt1RoTp+kY9uC+tQ=
X-Google-Smtp-Source: ABdhPJxtBlKHQdRgT1kYg0SKEQpoX9zPn/8j4FJLlpMBvUCIdxfn17dd/jZ7wEGRgYEfeCO+rR5MJQ==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr418773wro.178.1601327361258;
        Mon, 28 Sep 2020 14:09:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm2791602wru.65.2020.09.28.14.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:09:20 -0700 (PDT)
Message-Id: <3b467360bbc2c03474a7f704d23b1fe1df56dc49.1601327357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 21:09:07 +0000
Subject: [PATCH v3 02/11] cmake: do find Git for Windows' shell interpreter
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

