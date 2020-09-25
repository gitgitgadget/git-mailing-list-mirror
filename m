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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50CC4741F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4447F20BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEhD1s8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgIYO2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIYO2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F37C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so3261616wmj.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xnkt83SLDEtUSWd+hVptfxemrNoGCKpXXnlEscdf5MA=;
        b=bEhD1s8SBFPY4rdSy6AZxdFlV5+UD5MbY7PMtcAQ0b+42E5euuUdUtGhJ5vdL/1gxz
         xk9FGhC0NNENZkhCRco4BnjDWiKWpKZXd+2kfKaG79U+xY2epNY2uRutprun3ZunPEoG
         bCutxHdz7FBb8ZBtNc/zaABt2zZCsvcsQ3JJRaakMJHp260VmNqFeDatVj445GEiCJ1K
         HP5gM79ze5eMUlVR0vNgGGz5lcmeBE6Rw1dvzDUrI8kdb19A2WZIUOczOEF1zZcGqkcJ
         6Vs7ofH/yARUfHoDht50nDQ+tPkqoVkmd6Cl8p8IxOl4JDCG7TkaxyEEXeHM+0MvJzT9
         xG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xnkt83SLDEtUSWd+hVptfxemrNoGCKpXXnlEscdf5MA=;
        b=pdJAWKDoM3QpgG9SWdO0f6DZZABj3JrrkQ0gZjOraxJETaZF7InTrAqZHNqRvvy/iA
         9Pc9kgDxVH6I5oI1RUqfNCfZHos3AvMICrpKk0lSBPRXnINVuEq61abAPTbc1eBopTZ/
         6QRQseQkFo/D+VCYNCGTHjUtC2ambPABT8R6QNpTSp3LyWGx2ZcWW/ceci4mCX5ATmFB
         8M+UtXrDsUK8IOYeAoiWJLVY7a2OcdN5+mkM+272O5hCrygvPS6/IqZGwJmQ9/pHn0m8
         O1/8Xtz4pFdfEq3W1gVKhE+USElAIwkLY+I2SP8YtzTG+J2CNluaWeF6bwJywHRv0i9O
         69pw==
X-Gm-Message-State: AOAM531ve5/YAfKQYx7F4O3nVXhzJWoDNDAeqre6RAAylkv1hfdxgqpj
        6gFfnVnBOZ+/EdtkziJQ+OFaE7d2G+s=
X-Google-Smtp-Source: ABdhPJxLr1vQ6Hub8ed9/RV9fjnOqyL7ObygcASf3ugANLwLGJo/DkdOvnl26XzfvcrfxSv3LrGDHg==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25mr3631128wmj.4.1601044121773;
        Fri, 25 Sep 2020 07:28:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm3072568wrp.44.2020.09.25.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:41 -0700 (PDT)
Message-Id: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:30 +0000
Subject: [PATCH 02/10] cmake: do find Git for Windows' shell interpreter
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

