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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3828C48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EBD60241
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWP0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhFWP0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 11:26:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6C3C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o22so966403wms.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lSTXDNWYcAL9DpcFZ+0+bcXl3TPysug+LpauhKfnhnc=;
        b=OF/13vC4VZ0FLPe333SHUUoizsenZ1e8q44xvPopV6HZL21fL13B65ORdUGE982xzf
         848XLcB61xgdqExSUQ7yB/j/HAZBI3+pKEMO1WQcaA3KyCs1jXYOOriWdatCeynoY61w
         Gg1Hu5x5qXvd03FHfwCoaxP68r+V/LQMXs09XnZhAu9XTT40sr5Ii5vsAW3j0JPfnZDK
         24QcTHwS8OgD6S7moM31EaVtFyf0ImXcRffHFgxCK4DdvXS6kv4QUoIIf4WZQ2Ygiulz
         2bjjJI1QFOJTZUmAd67ZEYL06DdxDh02sBv8DKEg6CGGm02YH5TsSFRalAEfy3R179lo
         AwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lSTXDNWYcAL9DpcFZ+0+bcXl3TPysug+LpauhKfnhnc=;
        b=t8f4O8VmnRBYSbOCa+P8pvQDhbk+K7yz5H44v6mBW35xEABK9R9Z25Rj8ro43dkp2h
         82LW3cRgHoR4/17I+IgQjb0O3Ufgyzjrfi4ja3bJg9nDgdYQNSjD+zX2NO2ppY1FO124
         aV9qNWm8NeFS3Ttqv2RxVh4dAGpnSdW5oFEN0iJuIRf/n2DV8mM180jcg9ffb4OtS3Cl
         h22vuTCHjt2t97K02CYRPIiRrJFmxpa2MmIz5F28COhzpdQbcUG58TJ0XQkvevoZEj48
         NEmlw07sGZTuuu5CUnW4d6nC8RNrVlJQUNrUh4CIp8c5T3GwO20Wv6yxVGSNqIGmdnba
         LoOA==
X-Gm-Message-State: AOAM532bH2Zm3kLgGHwNOX00z6QYb38hcP9rgxIxyXknE6N4InDNv3KQ
        FUTgYnERIg/r9Kc/1Mwh3MW89FydFTM=
X-Google-Smtp-Source: ABdhPJyx7phztc6VP+YAU/5B6eWVZ9AOIClOY8Oe29/TnUWYpk/Pyx2V1BmPgjsabHW87XvudSasWQ==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr11666650wmj.111.1624461859842;
        Wed, 23 Jun 2021 08:24:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm6630733wmi.2.2021.06.23.08.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:24:19 -0700 (PDT)
Message-Id: <a913af64f9dbed880a736e5d2da330aff76794b2.1624461857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.git.1624461857.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Jun 2021 15:24:12 +0000
Subject: [PATCH 2/6] ci (vs-build): use `cmd` to copy the DLLs, not
 `powershell`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index c62766e7b1..d430c4e0d2 100644
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

