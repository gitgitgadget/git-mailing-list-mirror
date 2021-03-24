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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD80C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C723061A1F
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 21:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhCXVcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238491AbhCXVci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 17:32:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146BC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3403202wmq.1
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7nRedVQaoNiBIqDox5yv7uQyk1IOzoWKCIVl/e4A2oo=;
        b=Naokp0511WwvonJZeH4ujKsAALYPawDa46mLn3Wg9Z18A1YLh2vOfacLA0z+BKyibu
         y2S4nf3ZfZwPYO3EjU0S1wox6SZXzREeRblIGutqKOJ8TUfPLrPETsfKNJAAP8DvCl1r
         MxuCnPFERbHWDT6slYD83YCXvcCTsqGTZLSesjbKY/JpXAJlQNylRVeGJgR65Zouf22p
         jn2PY/2xGE+5poqw0eUM/AlIbGpPcxKouL26YXsBFfDJZDAGlMFIYYZeyu0t6MCCSbXH
         6R3yrMmH3FtaS7eOPGvkx/nkS/QZ3j2bi3LojfJMktc6F4t23zUqZayf3O9G/vjAuCLA
         NUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7nRedVQaoNiBIqDox5yv7uQyk1IOzoWKCIVl/e4A2oo=;
        b=o/nxxKdnju32/tqEDJ9THuBN0FVt6NCg06hOzc1N2m6pq9dF7n2Yon+spdkox74/5/
         OPx7jSaZ8pRxOv7HCbdUbbabLLKU7WJaNwEzg8XnA31Dw799nrDAOFpvMDn8DmkQdRWr
         FUBhcelhpq5cN3Du3IGbid2emzl1ewaiTgRaDT6gINDQlZBACMG2EmjBNEXJYZB9x5gG
         BSbkBpQsHUN9iHXI9oYtK3XzdLIU15yXYn8XSxqQBer6ihudS0KaaJj8u0XEL20jUnIy
         MYzRz8tuqA+ebDYsbrL8a5ia16Tdc09AhwVirWDsH/qY6Meod4VHTLCZPYhLMXZW2ZdR
         p1vw==
X-Gm-Message-State: AOAM530bx7UXz7aE09f6SxcvpfEpMMp4YJNK3VrHXhBKD5EcNhn0bj3q
        taC+K+Lk5HTRsNGml4CfXpk8kdvNPZg=
X-Google-Smtp-Source: ABdhPJzrFut4ecnEqtqn/bTiTumTgv6LU9VvTrtNUxzukBbs7n64Y43AR5kN/SJWU2F/YARfEw4NDQ==
X-Received: by 2002:a05:600c:3647:: with SMTP id y7mr4808743wmq.17.1616621556883;
        Wed, 24 Mar 2021 14:32:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm3762716wme.14.2021.03.24.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:32:36 -0700 (PDT)
Message-Id: <5f34332c96053f28eeae0b7ba43e4c65c7896899.1616621553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 21:32:28 +0000
Subject: [PATCH 2/7] merge-ort: populate caches of rename detection results
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Fill in cache_pairs, cached_target_names, and cached_irrelevant based on
rename detection results.  Future commits will make use of these values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0774152ea64a..2303d88e6a92 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2333,6 +2333,47 @@ static void resolve_diffpair_statuses(struct diff_queue_struct *q)
 	}
 }
 
+static void possibly_cache_new_pair(struct rename_info *renames,
+				    struct diff_filepair *p,
+				    unsigned side,
+				    char *new_path)
+{
+	char *old_value;
+
+	if (!new_path) {
+		int val = strintmap_get(&renames->relevant_sources[side],
+					p->one->path);
+		if (val == 0) {
+			assert(p->status == 'D');
+			strset_add(&renames->cached_irrelevant[side],
+				   p->one->path);
+		}
+		if (val <= 0)
+			return;
+	}
+	if (p->status == 'D') {
+		/*
+		 * If we already had this delete, we'll just set it's value
+		 * to NULL again, so no harm.
+		 */
+		strmap_put(&renames->cached_pairs[side], p->one->path, NULL);
+	} else if (p->status == 'R') {
+		if (!new_path)
+			new_path = p->two->path;
+		new_path = xstrdup(new_path);
+		old_value = strmap_put(&renames->cached_pairs[side],
+				       p->one->path, new_path);
+		strset_add(&renames->cached_target_names[side], new_path);
+		free(old_value);
+	} else if (p->status == 'A' && new_path) {
+		new_path = xstrdup(new_path);
+		old_value = strmap_put(&renames->cached_pairs[side],
+				       p->two->path, new_path);
+		strset_add(&renames->cached_target_names[side], new_path);
+		assert(!old_value);
+	}
+}
+
 static int compare_pairs(const void *a_, const void *b_)
 {
 	const struct diff_filepair *a = *((const struct diff_filepair **)a_);
@@ -2414,6 +2455,7 @@ static int collect_renames(struct merge_options *opt,
 		struct diff_filepair *p = side_pairs->queue[i];
 		char *new_path; /* non-NULL only with directory renames */
 
+		possibly_cache_new_pair(renames, p, side_index, NULL);
 		if (p->status != 'A' && p->status != 'R') {
 			diff_free_filepair(p);
 			continue;
@@ -2430,7 +2472,7 @@ static int collect_renames(struct merge_options *opt,
 			diff_free_filepair(p);
 			continue;
 		}
-
+		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (new_path)
 			apply_directory_rename_modifications(opt, p, new_path);
 
@@ -3709,8 +3751,16 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
 					 NULL, 0);
+		/*
+		 * relevant_sources uses -1 for the default, because we need
+		 * to be able to distinguish not-in-strintmap from valid
+		 * relevant_source values from enum file_rename_relevance.
+		 * In particular, possibly_cache_new_pair() expects a negative
+		 * value for not-found entries.
+		 */
 		strintmap_init_with_options(&renames->relevant_sources[i],
-					    0, NULL, 0);
+					    -1 /* explicitly invalid */,
+					    NULL, 0);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
-- 
gitgitgadget

