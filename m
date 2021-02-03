Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A1DC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8393464F50
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhBCDbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhBCDaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:30:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8571C061351
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p15so22512387wrq.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=thYEocGQJPioK5+ITiYvpClQ2jSd48xHDyqjgFWcUv8=;
        b=PDvIOGVw3/7rKKKzaIMSWTZauzvgGIOeE/q9Jk421qJMGwaF7t5FJleeUhytmiMhVR
         EaKtcT+L+CB5gUQJl48pijSRZq76G5qrJ/Pa7h4Mc7dcn/GyNCWfb7LMNsgUintqxkEc
         Db1TWjkWXtXpt/GRLRgXn6uDarDBygxNGjE9PvcfsTx7yNOyQm1ycfXiVWjq8tl6523l
         5eZDITHnXSxRscd8A2jgV2YYiMMpgjq7lngrui6DLyWrkIvYEROGixklE78iSemitAbs
         WDyhWhn/khxiVaIc2DP+6p9lsDJ4uc36RhDSHDvTz4kICgMMFZdurtnWGjMGwCWllx5O
         aWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=thYEocGQJPioK5+ITiYvpClQ2jSd48xHDyqjgFWcUv8=;
        b=TbjRS7SjFxNLqy7ceEYkENYCeecCJGeWvjBN6gyxgX6crzipyg3Qk29WdhXyqDP9x6
         /NvGPQOBHHfXWDNpNgfJU/aQYcBUy7LSpubv9KT7WQ1fWIpvK76cDXHzwnvnC8OQFga3
         tJdB9ZPUfpey5NN89XLkNIsvCdbr/0/h3DOtFe/f9CCqXDS2tvPiSfuVwAAfXYjHsRuo
         4TFs/ro4eARkqGheK3WOPoeywJmoduKElCjfYHQW4nPyRPzR1unDdiVd7qunoghZrWVM
         J6zMJTp+dwZBuaOl9AZ7+p5+X1tdOurkymIdqIj7EB8bqIrKyhFxqYMUwLXhIDzT4gFk
         p5YA==
X-Gm-Message-State: AOAM5325Opn8Cb1f/2oizbvK8bzt8NcCSYor6wS7qk++tH2h1UxrlwaC
        0vRHI8AKXgXlE1bJOA5lHocR+Bk3rjDs0w==
X-Google-Smtp-Source: ABdhPJz2XXcIPaT5ofo1Wdpnve6n4BYdb9x3dDEcRExXTfUOdrs5Ex/dRHpUQqyjEwZn4xFs6ifeYA==
X-Received: by 2002:a5d:5902:: with SMTP id v2mr1032025wrd.426.1612322912324;
        Tue, 02 Feb 2021 19:28:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/25] pickaxe/style: consolidate declarations and assignments
Date:   Wed,  3 Feb 2021 04:28:01 +0100
Message-Id: <20210203032811.14979-16-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor contains() to do its assignments at the same time that it
does its declarations.

This code could have been refactored in ef90ab66e8e (pickaxe: use
textconv for -S counting, 2012-10-28) when a function call between the
declarations and assignments was removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diffcore-pickaxe.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 8df76afb6e..cb865c8b29 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -70,13 +70,9 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
-	unsigned int cnt;
-	unsigned long sz;
-	const char *data;
-
-	sz = mf->size;
-	data = mf->ptr;
-	cnt = 0;
+	unsigned int cnt = 0;
+	unsigned long sz = mf->size;
+	const char *data = mf->ptr;
 
 	if (regexp) {
 		regmatch_t regmatch;
-- 
2.30.0.284.gd98b1dd5eaa7

