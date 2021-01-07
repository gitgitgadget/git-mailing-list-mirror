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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE75C43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F87423433
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbhAGQdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbhAGQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C19C0612FF
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so6210273wrm.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=RWzNeO0RUBCbiAHqidiz31YNJN86Cus3A4MuiXII+/s=;
        b=RtAPVIWEieGYsb9bWyM4S2J3cEVTLBi1lWao5b9gx10IgP9arcPnR9aZVmbNJX5Rjm
         tPhsKKbbekF5NnydQ0myDFQOCKAbyGC15LYzOi07kERyTG0GYts+y/zUi7TnqXZJMfX1
         A5HBhO64Rjyf9NYR9r9YE+JQTzm7SX2A0TjGL8X1pkPtTyWnTQjM76S722rD01pPy0Sb
         WMiFHv12iiYehEUU2mxag/5ullhyiMQsGc3jrgu95+V12U/S5oFqC0ktRd0gC9b2AqGv
         pvoOs70eefEaFd5oGI06jwPmOSqFheeJ5vMNUXVn6R/+smdkK0A7Qtz5QWJHP/uDwKET
         fczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=RWzNeO0RUBCbiAHqidiz31YNJN86Cus3A4MuiXII+/s=;
        b=umX1pWStaW1vhVbYG0IH1OIGCP9i4rodT1OirS3PlaOrsg9aUeYP/vu9O2SmDm6jLC
         PhVDGQoB+ryvKN+1dXSDts9NPKFxSTPQS5uc9Xx41ZzZeJC1UqC1Av3m9WkGyHtrsk2Q
         4mdnzxVIN4LG8DWsGKD7i7DfIprQxxoN9bkercDoQBQM5Qy2iw7zTIO5DiwZvJLrw8QM
         UkKSTQQFEyzUdX8V7V5gm/u/AtDp96ADhiS3Pi3pyfnIAHzKWRbaEPwlz0TL3yxHZqyX
         8rWhWyntivvfn8OECQDWJr84MubJTwjsKBf/hyV6BMR8AHquZ0klYRvmv54dSE920O2e
         a0uw==
X-Gm-Message-State: AOAM530bpn7m0C/9aQsVkStAJnBU5M1L2otEgxQ3BM2UqsNLHSlKImfQ
        RaAKAQJCQNWNFBOVXGDSJZK4DMVBcUk=
X-Google-Smtp-Source: ABdhPJzuXbPgIt3cz3Cc4lhx7gAVnoIqIh6HNsd7d+YC0aktUYifF8UcAJIsNqEWJhSoq4pSUk1eZA==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr9611469wrn.190.1610037142689;
        Thu, 07 Jan 2021 08:32:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm8625068wru.4.2021.01.07.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:22 -0800 (PST)
Message-Id: <7c1c206a0bccd25842e49b282d64432d61e879d8.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:11 +0000
Subject: [PATCH v3 10/10] cache-tree: speed up consecutive path comparisons
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change reduced time spent in strlen() while comparing
consecutive paths in verify_cache(), but we can do better. The
conditional checks the existence of a directory separator at the correct
location, but only after doing a string comparison. Swap the order to be
logically equivalent but perform fewer string comparisons.

To test the effect on performance, I used a repository with over three
million paths in the index. I then ran the following command on repeat:

  git -c index.threads=1 commit --amend --allow-empty --no-edit

Here are the measurements over 10 runs after a 5-run warmup:

  Benchmark #1: v2.30.0
    Time (mean ± σ):     854.5 ms ±  18.2 ms
    Range (min … max):   825.0 ms … 892.8 ms

  Benchmark #2: Previous change
    Time (mean ± σ):     833.2 ms ±  10.3 ms
    Range (min … max):   815.8 ms … 849.7 ms

  Benchmark #3: This change
    Time (mean ± σ):     815.5 ms ±  18.1 ms
    Range (min … max):   795.4 ms … 849.5 ms

This change is 2% faster than the previous change and 5% faster than
v2.30.0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 4274de75bac..3f1a8d4f1b7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -191,8 +191,8 @@ static int verify_cache(struct cache_entry **cache,
 		const char *next_name = next_ce->name;
 		int this_len = ce_namelen(this_ce);
 		if (this_len < ce_namelen(next_ce) &&
-		    strncmp(this_name, next_name, this_len) == 0 &&
-		    next_name[this_len] == '/') {
+		    next_name[this_len] == '/' &&
+		    strncmp(this_name, next_name, this_len) == 0) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
-- 
gitgitgadget
