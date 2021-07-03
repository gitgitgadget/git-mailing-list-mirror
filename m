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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A5C07E98
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4995A613E2
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGCV3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhGCV3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C115FC061765
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l5so279718wrv.7
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l5tssxgXBNdmehgBPfSsJoodec/GZNGIGBmTzK8DcXo=;
        b=gRwH1ASyMzHRDbCSk7mqzlhaL+a/UWOY/53qSOQXWFwro7/cCuQEwl/nxL/EW7iIGe
         pPUNUZQ3kSlcpWn3A0eLEYAOcYxqtvh+cGPY7fBWSMNO6wvFXHsNW0QXgWzeotIKddZh
         edh1ihRykJgqAXMP5MZAUSbKaIHq3tlaPSIHlKb0BPxv9uRPnwHHUPTkjmJNtgRc6dhu
         HSdAAU4PdxDxwDgTjHgQ8+QXvosZKNq0cXwHROhLrZV3cP1oJv3s0yEiK8u31s6N0jo1
         G/SxoIAF+rh3/9DJx3IP2wwvgBZr3JqbWW8Hojgfy0NWsswfGQvEhRf6STXPw3oOZUuk
         qCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l5tssxgXBNdmehgBPfSsJoodec/GZNGIGBmTzK8DcXo=;
        b=NhXTPPhYAxbxEW2LB7h7iUGUaZ+9t4SQnDyRts4kTDR4LwvTUIRHViKpK2ACcJBKIZ
         2IEGsMbGHUZJrDynjaynoElpJvcspxW3UktEwLD9IRZfenxiMSMe0hRrM4+T0Gn0bsui
         vSCY4MAaS/VpREi2ac++Z7G+guyUdefY9tXmnlTQYK9HTiQd+lRK/afLakV2bE/icNWd
         j3RDDTxOTp1XyL2e9IKWBNV50LGBVSmfKN0VK/rKE4MvVDUGGe9pXlP3jTTXOaQFGPIE
         7zwj4iDJHUILktgzu6TZi2pIvUi9tfGBbc0tKlQ8gtEYuFMsIfnj3jFZ7KE8twuJ1Eg7
         MxlA==
X-Gm-Message-State: AOAM531JeYVWXxSJiPB8QW7YPq9QBtA7hM4aPXOaNaaidBbjvgv96vRe
        7Y4rHmHLXtAqlkYdyWoKQFjox9oeC3k=
X-Google-Smtp-Source: ABdhPJwrLiZSoQ2wSYUi8Ycb9Rw6JtKUHrzG4zzTJJ5do4aLUMLvwOrvtV9gykMxs9rMbGVSr1ho/A==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr6809576wrr.47.1625347595395;
        Sat, 03 Jul 2021 14:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g125sm8761686wmg.27.2021.07.03.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:35 -0700 (PDT)
Message-Id: <6b12fe2284cb5949a57d2e39c543bef3ff12784d.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:27 +0000
Subject: [PATCH v2 2/7] ci (vs-build): use `cmd` to copy the DLLs, not
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

