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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C08C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685AF61164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhD0KkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhD0KjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E946CC061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so4760692wmq.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wod2A27fy11LyRODnuCxhNiKLVgYgInfwpEit4Of9S0=;
        b=hvPuNxWqbEpK4fmUHnsXtHqTuByJ+/E/iqOWmKNAF8Phf8zexAuW6K9TxlSCevNGwI
         nFMUc/mMlORVlCVF/VPWslgTH3wBVuf9uHHLyAtHYGlYrsghoe3AxD3CdhbJnn2+On3g
         B0lP5Tyd97eqASJ9wgJG8MKjFtxHSWGPnidO6vDAX5joyzQ2AyXAAh+JNkanpn4tq70t
         nf6B9msrBVH2zTlxpTK4BzTOu0ayMpnmaPiY5+ZWK3fbWHat7Yb+8Hl/49bYpmYFWuRJ
         58k8uayNJARDEKnkXPm3PHodzwp1OCkEZZDD6zY3SDCPhIX3dHWFAWSrH5Ae37m2ar/x
         NjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wod2A27fy11LyRODnuCxhNiKLVgYgInfwpEit4Of9S0=;
        b=EbmjGbZbDN1BjYgJcrT/VOQo8TEke69R4ZPcOJeUQV5ckLNcUjOJ55Tz6A+yuwvBL3
         mzTVhxgaVuo7AAxCe004dc/LG0cnlI4VClbwir5JStJaxa8Ba531j8wBJTWdkv4taaKl
         2gPy7ON9Q8tTQ0I5NPOjLTZkkNQEdNrnBT9Q3tE9F5RGWc8V4VljtckZHWueb/aeQN1K
         o9Ra04LjMBbJaABCxn0776e8ulZmPNyQcGout6n99j0YHj00LVJgBsSP/Fb1u5UXNbRp
         yDkDjEWpZqEeGT7f3YkOSPzCPLOOAwj1iwpJbc1osis45shS92UCAVt/s6Oskf4LZaOe
         ZkaQ==
X-Gm-Message-State: AOAM532NfS4OORYWNs2J82z+gxu+EQcewZUow8E7b3Zj2sZczxAahr6t
        1PjYiu3SVR6kmg2mSlFY8LJhuf88mP8=
X-Google-Smtp-Source: ABdhPJwNWnAgI/0RSrR6olgaR/o8PU7LWtZ+6HylmJKvhsUhh+bYn3lkCZniouWhRre+I3+dI2KYnA==
X-Received: by 2002:a7b:c150:: with SMTP id z16mr24184311wmi.81.1619519912808;
        Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm18782713wmq.4.2021.04.27.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Message-Id: <0d3b18cd35423dadd35d55073bd7230bfc908fee.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:16 +0000
Subject: [PATCH v2 15/21] t1414: mark corruption test with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable format guarantees that reflog entries are well-formed

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1414-reflog-walk.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 80d94704d012..72a5ac61a520 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -119,7 +119,7 @@ test_expect_success 'min/max age uses entry date to limit' '
 	test_cmp expect actual
 '
 
-test_expect_success 'walk prefers reflog to ref tip' '
+test_expect_success REFFILES 'walk prefers reflog to ref tip' '
 	head=$(git rev-parse HEAD) &&
 	one=$(git rev-parse one) &&
 	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-- 
gitgitgadget

