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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EC764ED3
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBAWDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBAWDh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:03:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C4C06178C
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:02:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o5so629820wmq.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JewujSwXcnrJrGpQL58DN1s7LbKqF3XLqwqHhLqPPEA=;
        b=eykLUXBzWnv9rhOpD+B6HZ1XrdKr/qUFOtXZ+mKbh7zMsedk5A/F2i21/qgL7EX6XX
         aFiQEYeRV7kWXEFESdd3tIQnqWxUsGsXw92c1/CQHDywXUSA2po4XT9sD73wvNpZg0RY
         N+ZRY0dkd6vGBuFjQihia2Q6lfQ8eEKXLGfE6tJQWV3h0508e1+USMUZe3c4ALA9v5rF
         tMaBRpwJVfuFDhmFzC4VvyupQ5Jl7VQ5Cfv8HDk21HD27hACQg0HJlrwDrZITntnM9KZ
         zFg7Y+hBsVtokSWVxB5wvvyCONxLEQ+oSk7zP2ye1An4lCm/4ccG4suI4gonbY55PjjW
         u9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JewujSwXcnrJrGpQL58DN1s7LbKqF3XLqwqHhLqPPEA=;
        b=Hf3flYqkFDXWKKRCGZr1kRNUR+1clG4d4tKcbKFo06gpjiPrWBxsw7ZZLMEbnMhiQ5
         r3F+uMx4Yf/ILeJ/awc9eciwoQgGNS4f7J/HhNdWaYgmnzp6S7+g8H0Ak5qyTMAIXjpr
         UxID4FDu1zPKYMJHrpLrBPxjfLD8sGYT4NkQf0UCcgeG1z/Go4ddoglQUpXk8GEm63SW
         lNVKTh+B42QPg2V3Gb+ymk/q+Td/xAaXAmMGpR+nAzAbG+B38cFBPAaf6bJCNzK6igk/
         2u/4O0ZGM5VUMRWh+8WKEJpn+udmXxr4V/2zaGkZwQOmzE5q+nW9ajbybXPVbvNF2Yd7
         vXhw==
X-Gm-Message-State: AOAM533HiG1wXIeo9xz7uPJ7nKZRPcRvHMmuDOIWMrqFUQ4M8b3RLpvG
        qf6bCInPpeR+Tt4yUuZghHvcPTuDL9A=
X-Google-Smtp-Source: ABdhPJzkPuRpZprcjKP2LpapQ65vIvSTlxsa1KjBA/YQ72JJZsDOfcNFIFDDf4Knbtd/nsnI8OiNfA==
X-Received: by 2002:a7b:cb8f:: with SMTP id m15mr789038wmi.65.1612216948534;
        Mon, 01 Feb 2021 14:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u6sm29982898wro.75.2021.02.01.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:02:27 -0800 (PST)
Message-Id: <cdd49f1fdb18b85430c39f65d2a85890abf927e7.1612216941.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 22:02:14 +0000
Subject: [PATCH 05/11] preload-index: log the number of lstat calls to trace2
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

