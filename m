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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEFC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4DA61168
	for <git@archiver.kernel.org>; Tue,  4 May 2021 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhEDJ0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhEDJ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 05:26:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1ADC061761
        for <git@vger.kernel.org>; Tue,  4 May 2021 02:25:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l13so6968899wru.11
        for <git@vger.kernel.org>; Tue, 04 May 2021 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LiJlbmNXBvMA/OO136LVN3hGqlUno/btLJuFodifthM=;
        b=O8STf+W/R2TOBPXZNoEIZKlgrkSfZv9VauPDNvNYie4nLjTEQrQEHq+EzQpKYKRqxo
         LgsSafRIOW7w7OhIktgQSjyth+897M8EhemiuQNwpNODZaBCKQgB10sWrMJaUuCXwu2q
         oVrF0yLbGQlIJGUaizFSG5CmmS8BfRkj+Nss9EeniGeaRUqaIq5+TZwxKf5fzhakSZa1
         reUTfR0ZbA2XXX9Ewf1NSavGbjB7NnRhnp7lcdjYlOdmGJ9sqj13q5yv/bdMRNqeTt2Z
         rWhjLMxWJicMJlRmotLyqUb9dTr4t73doUirGe4ouxtlo/EUjCdnKnbV8Z72J2gqMmNK
         af/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LiJlbmNXBvMA/OO136LVN3hGqlUno/btLJuFodifthM=;
        b=Lm+k9GR5KCVzr2WcRheVs4u8MD1E2Bae+qI5XTlHgKbj4iQ1LEkXidMpBSTRugq06T
         SRIokqT6FYYBqB0Lt4n57qBlZ3saKrMiG2TrfJLGuCizaqc+vW9A7lzRp+QvfcxZEmXq
         f7QbvexPkBjBE3Q6gok/XK3t0Xc2liElAQzo8onG28SNTlxbqUwm8qEbOK/fn0mjTaEI
         if6fHf+hjryGcDetrKl3jdZ6mNKxZHuDtVsiV3+1WOmsF7ZgKXAOZrfi+gcFTRAEC0R7
         20fpiA71sro45j9Wiu7n2l3HmiOqXUp/Danwu4be7B2pvJH4Rs8aG/g6eH4sl1HJgPAd
         O3HA==
X-Gm-Message-State: AOAM531gLcNcBTpVZs+iwnFcmLAQ4AlP5m1j33GLaYy3yq+8LXBOBEXu
        Iwopln7dd65l+WRNwVg4CoQAuUbEhY0=
X-Google-Smtp-Source: ABdhPJzpmROcwOYcAD5wu7E5p3KEYovLSgEy8ryeMxYKRmFB6G7tFXAZJd2sdIZgToV3AP0jAN1rJw==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr30171946wrq.267.1620120348376;
        Tue, 04 May 2021 02:25:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm15377496wrh.16.2021.05.04.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:25:47 -0700 (PDT)
Message-Id: <b38a4e02d4f1c8e77bbc8ed1e4e8507d41ab9fd8.1620120345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.948.git.1620120345.gitgitgadget@gmail.com>
References: <pull.948.git.1620120345.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 09:25:45 +0000
Subject: [PATCH 2/2] patience diff: remove unused variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xpatience.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index db2d53e89cb0..c5d48e80aefb 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -284,9 +284,6 @@ static int walk_common_sequence(struct hashmap *map, struct entry *first,
 
 		/* Recurse */
 		if (next1 > line1 || next2 > line2) {
-			struct hashmap submap;
-
-			memset(&submap, 0, sizeof(submap));
 			if (patience_diff(map->file1, map->file2,
 					map->xpp, map->env,
 					line1, next1 - line1,
-- 
gitgitgadget
