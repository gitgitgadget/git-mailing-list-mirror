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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347AC43381
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7F364F55
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhBCPwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhBCPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:37:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D1C061794
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id z6so24798719wrq.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JewujSwXcnrJrGpQL58DN1s7LbKqF3XLqwqHhLqPPEA=;
        b=heqe3bwy+ZKUhqXD0bSjNerrcFsOcJXUuzuZTO0GU2qzypk4FfTT0rTpVvVzC46eAl
         sO2xLtqiTYs7gJuEvSXavlU6YDvVH7a3OQCrJy2ENM1eNfnhW19k1i0p+q158hvC3uhr
         2MCQkzfmaLtCYs/bmYKsdrJL876sR6Lw9vQYeByaydXVFqvohDfnPdOoF40+0nJXyqPm
         Zr9uU2asIgQq5WsQz/iLT9jcxCkwCW0YZAQsnrJJA2uyqhSzKeG75yqBf5RnLi71fZsK
         Vk0VNxPFr1A06w1MUy9RYzgy+Zef2XSGLpQ4jqXj2BXeKoODk0Rylc9HAV75LWjVj1lF
         wpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JewujSwXcnrJrGpQL58DN1s7LbKqF3XLqwqHhLqPPEA=;
        b=Dz8uFKh3ZTWlh7eCWCXj3+zQGD21+o1FZlUfajZGYUvkNB+PI/IDbumr83BVDWqEGI
         UkTc178In8OfglMTweRWh1GIvBJgA12Ww0lGoNnFegPrZu9xuaSFzPMg+iQh9NR0eQSZ
         Ln1kEzecigG6cKFmoxXPvz8VlBdKjSiOjkiGpICJjATVhrYJFTO0+aYZ1C3vsQS2ZSqm
         CHtESkhoV5/qguG5L0blulI5OEMX1Qnz97FbT6SI9pUD1JsvJyglIXV1eR6+rMCemqkL
         DXT2JsjAGwQi8mIpRPAfVh4VuTPblHH2pc+9ojhE60iQ+yTy/H5HykTrl1ZXzFyvjQNb
         vPHQ==
X-Gm-Message-State: AOAM532z2bW9SM0phnh2+Da4QqUiAUN310j+NbEnMjYAWvuMFaeox0r7
        xsAX6sAKzkqTkOlRZUEbD2mhv2HluWM=
X-Google-Smtp-Source: ABdhPJzTTlp3Cd43395vAAp2iZKmrHVFLE/d8th86iry4XD4AtOPslS5O61q7gn+HiAL7vWdGSfh8Q==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr4211734wrw.305.1612366497930;
        Wed, 03 Feb 2021 07:34:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v25sm3355487wmh.4.2021.02.03.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:57 -0800 (PST)
Message-Id: <3c5035e4649d18d96fc0206c2ceacc6ffe99deff.1612366490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:44 +0000
Subject: [PATCH v2 05/11] preload-index: log the number of lstat calls to
 trace2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Report the total number of calls made to lstat() inside preload_index().

FSMonitor improves the performance of commands like `git status` by
avoiding scanning the disk for changed files.  This can be seen in
`preload_index()`.  Let's measure this.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 preload-index.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index ed6eaa47388..e5529a58636 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -31,6 +31,7 @@ struct thread_data {
 	struct pathspec pathspec;
 	struct progress_data *progress;
 	int offset, nr;
+	int t2_nr_lstat;
 };
 
 static void *preload_thread(void *_data)
@@ -73,6 +74,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))
 			continue;
+		p->t2_nr_lstat++;
 		if (lstat(ce->name, &st))
 			continue;
 		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR))
@@ -98,6 +100,7 @@ void preload_index(struct index_state *index,
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
+	int t2_sum_lstat = 0;
 
 	if (!HAVE_THREADS || !core_preload_index)
 		return;
@@ -107,6 +110,9 @@ void preload_index(struct index_state *index,
 		threads = 2;
 	if (threads < 2)
 		return;
+
+	trace2_region_enter("index", "preload", NULL);
+
 	trace_performance_enter();
 	if (threads > MAX_PARALLEL)
 		threads = MAX_PARALLEL;
@@ -141,10 +147,14 @@ void preload_index(struct index_state *index,
 		struct thread_data *p = data+i;
 		if (pthread_join(p->pthread, NULL))
 			die("unable to join threaded lstat");
+		t2_sum_lstat += p->t2_nr_lstat;
 	}
 	stop_progress(&pd.progress);
 
 	trace_performance_leave("preload index");
+
+	trace2_data_intmax("index", NULL, "preload/sum_lstat", t2_sum_lstat);
+	trace2_region_leave("index", "preload", NULL);
 }
 
 int repo_read_index_preload(struct repository *repo,
-- 
gitgitgadget

