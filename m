Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585BFC07E9B
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3EC613E2
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGCV3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhGCV3O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B9C061765
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i94so17039412wri.4
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gjdrgQN4gfFTjqrbkjCP8ra/tLumx3K8Cnpmwr6Qgjg=;
        b=A1WNXjp3BfAgIHeXARbu3ulW4WKnw5/SJ297eL8CljU8fdYN4zNhislsQP2Loe1xAx
         Y/HIxNGphT2EBMPaQqPsQrLP3z4htQ1VfS59hrDly9U2mGJsudg3K3yRH8D635omOWeX
         RkKFs1pvoTjDZ/Eo/uPJjfaGBi0fHIAF/+jiU7KXAjaAT1QxBq2XKf9hmiL6iZIc9UAP
         qlxqDr7DnIOje9Xm+Atxt5lQ2GAZWqpa2KaNo4blnGnrIdXnJVSzp5QnUh9NrYLvYmnM
         bBy1eP3R1zAnbQdxvtBuMB0vcGo5Jzom7NCw38YNJ/rKOBV+K3ADbChGmBtRRzT0J7iw
         mK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gjdrgQN4gfFTjqrbkjCP8ra/tLumx3K8Cnpmwr6Qgjg=;
        b=cGdEm7fXVSF/Dq+z9CPsvdu9jpGjqjmholo6iwx0UTzT24qXi1sWSGvnFkQ+t1/YNo
         TL5u4rTI5hUKReq/kyTujJeEDNkTXPZA2Mvox8QYgD3cu5HhNwuqtn7Yp0objp0dF0YW
         tKVjIG1NM7z4Yhs/YQfLXliDIZ/AmktJDywibKW592yfBYg1PoqJvx5T5RCQyeX7YYO5
         uCBFt3qENVrkK9S3pSA055nzRjjNpc8GBaNHarcCLHqlexFgVmRrOh1LyrqnevA9LLEv
         caMaaSsJBVlgtSRjd41rqTCab3txpJN+VUZW435RY0urmEB1cwcTjtREzMU3IDHkEFne
         RYJQ==
X-Gm-Message-State: AOAM530OvIAz8j4jifeNio3xux5Fc0PHIk8nAWFY5VF46z0AeDqlIyZK
        5kBEDCsQAv4sy7yv5FEpQBdtZ2Y9YuA=
X-Google-Smtp-Source: ABdhPJymqpWMEwu3qxQfwr0uHTsGlBtu7NXDhKx7WZ6ytpf7I0PF3CC0ydTA+Qt7C3rTHmXP/SuWTA==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr6823816wrc.371.1625347597391;
        Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm2492683wmi.48.2021.07.03.14.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:37 -0700 (PDT)
Message-Id: <8bab4c17b8a6d7a3ed66e5d9e3eb8f598b35b874.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:31 +0000
Subject: [PATCH v2 6/7] ci(vs-build): build with NO_GETTEXT
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
index 0f7516c9ef3..3b40c677ab5 100644
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

