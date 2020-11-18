Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD14C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C2A2225B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRuDAmEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKRTZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKRTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:25:29 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A2C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:25:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so3359488wrp.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KvKPCoShK0PCTxTVEmAqiSqBspvDtYJYt1J57Tv6cGM=;
        b=mRuDAmEYIB/qIvbdH8TG0kejWsuLeepO1TcVEVvmxwuz1hW8YX6J5q7IRcyQqDvvf7
         L0leSdhXD1naxbJ8ueoSJScModizMU1Ce2FgIREvLG73mb+0xBAUye64Fn9XbF5DI1Wc
         4F71lq45alUCEIiKTO3sXbmQa++UWf1QzWj03VnDeC1lRpPQIwfPZUiWSaxGTM8GZeP4
         fddCnYxhVl/Rq4mzjuG+HB9pIvO2rj6JiSmSnE6JevwxxxZKdezrXzJ8PL6rYzlBcvgK
         EInbVMWvsrYpPzVJXXAnGjXm5x1X+16zrvho812zWbbEYRtqlCiwk9WJlgJ9Wk0ci7BP
         6KRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KvKPCoShK0PCTxTVEmAqiSqBspvDtYJYt1J57Tv6cGM=;
        b=oM0iJIaxoTpkQqAJp5ifndoX1LnfyldPw9uXI2Uo3gsGrd/RUoKMsj74sqoOrkB8CR
         UkpSO5AnoFJElmhR6m779N3Q0xckGtcCuvdWId6HuI9k9s9Hsv11I5HRA9yOp6PufyFb
         p6M9DlTS9jXPrLwmqVfJLomoTdAiC0+Lj5AmplMmDrUXX+DYKyNzS33M8h7jnVzTLCoy
         BdKM8F9nfWOWjH5r/DUcqcAP9F4Gz4KJWjKbmvAxDGF9MH7qQ3FWGFGWWEaQ+IB4WSVT
         EU14btSVC97BAq2puqbxOOrysW4N/lV6NnpyFTJ4JB+ZV8m7nEesUJL8kbM9Otul6DTC
         hQMg==
X-Gm-Message-State: AOAM531yNq6UkmKWsQBgD44CrDBFrBJHeZbkojOi1E/BDIpgu8qR7IHK
        w0y/S0K5tZ3FpZaWlVa5A5lyQFnhJ0g=
X-Google-Smtp-Source: ABdhPJzEV/YsaumN7t6vSOPYTErKvMi16+LVbP1HcOdt/tAkvHmISeGwrS7T1JSv2Eehh6vWiAYSYQ==
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr6542269wrt.308.1605727527732;
        Wed, 18 Nov 2020 11:25:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm33367800wrx.5.2020.11.18.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:25:27 -0800 (PST)
Message-Id: <pull.793.git.1605727526797.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 19:25:26 +0000
Subject: [PATCH] t3040: remove stale note
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Riesen <raa.lkml@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This comment was most likely a "note to self" during the development of
1c3e5c4ebc3 (Tests for core subproject support, 2007-04-19) and is
neither needed nor comprehensible at this point. Let's remove it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t3040: remove stale note
    
    And yet another thing I noticed while working on 
    https://github.com/gitgitgadget/git/pull/762.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-793%2Fdscho%2Ft3040-and-default-branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-793/dscho/t3040-and-default-branch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/793

 t/t3040-subprojects-basic.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index b81eb5fd6f..6abdcbbc94 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -79,7 +79,4 @@ test_expect_success 'checkout in superproject' '
 	git diff-index --exit-code --raw --cached save -- sub1
 '
 
-# just interesting what happened...
-# git diff --name-status -M save master
-
 test_done

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
