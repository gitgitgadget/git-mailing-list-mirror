Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32CCC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05F661405
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGDW54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhGDW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F6BC061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g10so4289550wmh.2
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5tssxgXBNdmehgBPfSsJoodec/GZNGIGBmTzK8DcXo=;
        b=STvERgc5VeNaojbQCVEmIhkDeH/Ux/vj+C253b1eTvcKGNYBPk1eWb4n3xMAdKxBke
         J+1KVysGI7b0vzgVMqUFVDRa8e3m4xpcfm2qgzrl/UJk7GNpZxq08ohBcyj+VhaEM9PX
         jBjurh/qnhtAAgQ/BiYUdg//jofekHb8zJ51lCsoBimus9wxOi4ObGhp4vzTuk1KMzQO
         m90jT1QZI4ed6eplgwaQcr9gDV1+5x1d2XYQK0XZt8dtSy3oM7rxFuvWNFTOT0PD93wi
         9GbL6S9zPGCWlrLJ7NCzNW9vC1PUBV2k0eC6cwWXbjiY/AIwAGUPleS4xSMav9q7qTYI
         dtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5tssxgXBNdmehgBPfSsJoodec/GZNGIGBmTzK8DcXo=;
        b=HGGh4Wsc7vjOuTlv4tI/N9PDSU+ubwhsMDGJGLOt8ZZ9y6lchocWiqcV+py+Si7H/I
         YF2oorXFkDex1Ce4CaWl2V9L/ol5vjR8ye7n8hSiBRVOgiF/GVirGJ5oFJDT2JHwiDRb
         vmjN3ASkw5S7SpW1rsKG+PkcTUVjZcROH1XTsy1nTbidMrj828BC1lxJTXBpjnFeokCg
         UgHXyTp5eM76z8VRLs080b6LjrhU8VKBvgX3FIrIT+5rdiPK0l4qkBfdg2RMf+AAXrGG
         V/8sY/23mqOpi8Lm3HL0Gb3oc7Lo3POccjydkbryHiW9Yi7l5jWAReI7ZguRdLNWxpcc
         f07g==
X-Gm-Message-State: AOAM5327QulquwvsKv7zn6VrfgKdauddWLhL4akcXpr/qUe87GhGlpYN
        wo5WOupkpg+SgM2A1xnr6sBROdPIADA=
X-Google-Smtp-Source: ABdhPJyioU+4AY5qZj+r+c+VOJGw/9tagKmr+O9ti3KQqAUCNjs0+3WOn00e9j7uF5Uu6+c7729fiw==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr11921310wmc.65.1625439316947;
        Sun, 04 Jul 2021 15:55:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm10136491wmi.13.2021.07.04.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:16 -0700 (PDT)
Message-Id: <6b12fe2284cb5949a57d2e39c543bef3ff12784d.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:09 +0000
Subject: [PATCH v3 2/7] ci (vs-build): use `cmd` to copy the DLLs, not
 `powershell`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We use a `.bat` script to copy the DLLs in the `vs-build` job, and those
type of scripts are native to CMD, not to PowerShell.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c62766e7b1a..d430c4e0d20 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -152,10 +152,8 @@ jobs:
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v1
     - name: copy dlls to root
-      shell: powershell
-      run: |
-        & compat\vcbuild\vcpkg_copy_dlls.bat release
-        if (!$?) { exit(1) }
+      shell: cmd
+      run: compat\vcbuild\vcpkg_copy_dlls.bat release
     - name: generate Visual Studio solution
       shell: bash
       run: |
-- 
gitgitgadget

