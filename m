Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0310C49EA4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D036D6023E
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFWP0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhFWP0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9896C061760
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n23so1923561wms.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eCYRoFHN1s610lMicf90LmLzggLEe+t0r6vMfIYNzFA=;
        b=Xln+yn8m3AA8WxaGIwX25MFjEteQ5wcDFOdUKdPstFMOJn1H+fXIFPTymXLQWrBcyq
         PmAmS6XcmR2WfnX4ML7qVmZRyGTgsJYZ2HuTECXduGzMr4l3LEpWtI+J5SO5e0iOGL5J
         EChp6A1TXXxYZFLACTx2E5uUEMtvaWIVvcDSvSAR2SHajhAPpedMJhquujC5r1KHyv4r
         Jnf12UNmWhX1orYjjqct4g2mRq4QFZ399npLdp2S52u+hI+ljAUJDF1EbySdybl3nKMP
         oHxV1e/B1r8WUhBKD8CE1zvYjCk8bC3ormwA1vxtZBCIhhc+a0Bl2jrkVFqMiws+uyfA
         SpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eCYRoFHN1s610lMicf90LmLzggLEe+t0r6vMfIYNzFA=;
        b=GnGbtkDr3dIW0kD/22kpd2EJyb9y6GehxpT0jMqN3OQAG6+M5FOjgPMWNDsys2uKs3
         fY8EUJrBT5kUAG60yC5yNA891FcIE4rzue6r9pnVl1O29GREq5IhbpR+7Jn1htu+fO+C
         yLxV6gQQRHRxDDYQtUiTsdlsjkf0rP3KSMalJLRBM4VwrDVK2SGQUoEIwIvxpCMKQkxQ
         Tclx4HJ1eKwBfjhdI9zfQDV+ysQO6X549choB2GLEo7Q4nzwrXnch4Elxja5u/mKCacx
         b7UAjunVf/K30Wp7tbbLpGMGZKcBEODU3ubJ0PFpKQ9DWiDKSno4PRYMTlKtCL/25cVU
         2TIA==
X-Gm-Message-State: AOAM532PoOL4ZA+ZwDz5OzuEVHqwV4DD4JevQt9tKAN3EwlgAamEJ7ux
        Z7Y16QWWxBN1NsCodmF4DzYhpCzCiAM=
X-Google-Smtp-Source: ABdhPJxioRq6+FoHXke4owQVXX8IXmnURpzwXh2rFb0Od1BvRJumm2pLLVk0vkX1bnStYbVOgpbVKw==
X-Received: by 2002:a05:600c:4f09:: with SMTP id l9mr11838290wmq.114.1624461861483;
        Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3sm5766867wmi.42.2021.06.23.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Message-Id: <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:15 +0000
Subject: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dennis Ameling <dennis@dennisameling.com>

We already build Git for Windows with `NO_GETTEXT` when compiling with
GCC. Let's do the same with Visual C, too.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0f7516c9ef..3b40c677ab 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -159,7 +159,7 @@ jobs:
       shell: bash
       run: |
         cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
-        -DMSGFMT_EXE=C:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
+        -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
     - name: bundle artifact tar
-- 
gitgitgadget

