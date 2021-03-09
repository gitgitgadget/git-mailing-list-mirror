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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B18DC4332D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAC9652BE
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 00:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCIAKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCIAKG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 19:10:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89617C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 16:10:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f12so13301260wrx.8
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=C9kP6y0QQbh5bjK+FNiTeo+2CujVbad8UAP6L8gcidQ=;
        b=h0GD8tqVmtlyB48qcfACpgJZEHRplMQxv3b+58l2BF9kakWf9NGL/tf+UX7DQuQ6v0
         XOrJjDCSWViXjJCCmW13y3lLa7RpdNI/mYMD6mQsK/4+Jo9KWz5EZWBfb7hLY8NDYzIE
         ANxn09ryJQAvvPG9R5F+uHOZrUW9NG+Z/dHmI6AYcJBGfu+kBhTWze6MYIL5LBu6o7nk
         UzppcAwtneQ5fqt+XNbO6kaRHLU3BDI7rvRGgWhqZXfVqKwOC6fDxy35K68r89+ILiNF
         SbQ4TgevjHeRL5hx7L0h/dMru/iPwYELEzUElX54CGHRJvoJJU83chg+6VaAw3ldJK+j
         Wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=C9kP6y0QQbh5bjK+FNiTeo+2CujVbad8UAP6L8gcidQ=;
        b=htF0IkJfZsBrxdH5Lx5cBdtyCa05X1s1L/WgiIdqxvnTJO8zT4zDiodi6f82oEQdZU
         AaFm3iIBiSX/M3eJ0FZbHplUXYQidVCEXL2ra4Ou3Jx+il5Q2mocLomBdqinlfui0oAr
         zAW5QZdWyW+vjtywu61xfASZ6OCnxWctGIryZ1XLxkggBcZ7KxmT9qp1rcih830gmZoY
         gAgzXN7SqfrN+N3S3dMNx/qGvwJftIgEWpJ4p4gt41BLkwbS7nb2dW9AYWVSIuI62y3c
         aZhrfZjMC/HuXyoeQygSoAMxMpXt/cbt9R3UjlnuZmxH7gr3T5kL5lmARvkOo2P7vCHO
         KiyA==
X-Gm-Message-State: AOAM532QOB1JnJKZdZoJLEXWFBgM/w7q+on9nXLp5WDTE811p0PStrVo
        yfLvb84Wxbo+1K0pn0eqBR/QkyE81e0=
X-Google-Smtp-Source: ABdhPJwz9loiKqiPpjdZoAuqIk/N8vRJ6FGZSn3rUNK4JDqekZEbkUbhOdIuFlnCYIKt1gEkTa3znA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr13858780wru.381.1615248605368;
        Mon, 08 Mar 2021 16:10:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm1207116wmc.42.2021.03.08.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 16:10:05 -0800 (PST)
Message-Id: <c443ba8abb89458cf2b883d8777fb3f703a90ff9.1615248599.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
        <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 00:09:59 +0000
Subject: [PATCH v2 8/8] diffcore-rename: avoid doing basename comparisons for
 irrelevant sources
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The basename comparison optimization implemented in
find_basename_matches() is very beneficial since it allows a source to
sometimes only be compared with one other file instead of N other files.
When a match is found, both a source and destination can be removed from
the matrix of inexact rename comparisons.  In contrast, the irrelevant
source optimization only allows us to remove a source from the matrix of
inexact rename comparisons...but it has the advantage of allowing a
source file to not even be loaded into memory at all and be compared to
0 other files.  Generally, not even comparing is a bigger performance
win, so when both optimizations could apply, prefer to use the
irrelevant-source optimization.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.708 s ±  0.111 s     5.680 s ±  0.096 s
    mega-renames:    102.171 s ±  0.440 s    13.812 s ±  0.162 s
    just-one-mega:     3.471 s ±  0.015 s   506.0  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7f6115fd9018..e8508541be14 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -527,6 +527,7 @@ static void update_dir_rename_counts(struct dir_rename_info *info,
 }
 
 static void initialize_dir_rename_info(struct dir_rename_info *info,
+				       struct strset *relevant_sources,
 				       struct strset *dirs_removed,
 				       struct strmap *dir_rename_count)
 {
@@ -534,7 +535,7 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	struct strmap_entry *entry;
 	int i;
 
-	if (!dirs_removed) {
+	if (!dirs_removed && !relevant_sources) {
 		info->setup = 0;
 		return;
 	}
@@ -549,7 +550,20 @@ static void initialize_dir_rename_info(struct dir_rename_info *info,
 	strmap_init_with_options(&info->dir_rename_guess, NULL, 0);
 
 	/* Setup info->relevant_source_dirs */
-	info->relevant_source_dirs = dirs_removed;
+	info->relevant_source_dirs = NULL;
+	if (dirs_removed || !relevant_sources) {
+		info->relevant_source_dirs = dirs_removed; /* might be NULL */
+	} else {
+		info->relevant_source_dirs = xmalloc(sizeof(struct strintmap));
+		strset_init(info->relevant_source_dirs);
+		strset_for_each_entry(relevant_sources, &iter, entry) {
+			char *dirname = get_dirname(entry->key);
+			if (!dirs_removed ||
+			    strset_contains(dirs_removed, dirname))
+				strset_add(info->relevant_source_dirs, dirname);
+			free(dirname);
+		}
+	}
 
 	/*
 	 * Loop setting up both info->idx_map, and doing setup of
@@ -627,6 +641,13 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	/* dir_rename_guess */
 	strmap_clear(&info->dir_rename_guess, 1);
 
+	/* relevant_source_dirs */
+	if (info->relevant_source_dirs &&
+	    info->relevant_source_dirs != dirs_removed) {
+		strset_clear(info->relevant_source_dirs);
+		FREE_AND_NULL(info->relevant_source_dirs);
+	}
+
 	/* dir_rename_count */
 	if (!keep_dir_rename_count) {
 		partial_clear_dir_rename_count(info->dir_rename_count);
@@ -749,6 +770,7 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
+				 struct strset *relevant_sources,
 				 struct strset *dirs_removed)
 {
 	/*
@@ -839,6 +861,11 @@ static int find_basename_matches(struct diff_options *options,
 		intptr_t src_index;
 		intptr_t dst_index;
 
+		/* Skip irrelevant sources */
+		if (relevant_sources &&
+		    !strset_contains(relevant_sources, filename))
+			continue;
+
 		/*
 		 * If the basename is unique among remaining sources, then
 		 * src_index will equal 'i' and we can attempt to match it
@@ -1164,7 +1191,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 		/* Preparation for basename-driven matching. */
 		trace2_region_enter("diff", "dir rename setup", options->repo);
-		initialize_dir_rename_info(&info,
+		initialize_dir_rename_info(&info, relevant_sources,
 					   dirs_removed, dir_rename_count);
 		trace2_region_leave("diff", "dir rename setup", options->repo);
 
@@ -1172,7 +1199,9 @@ void diffcore_rename_extended(struct diff_options *options,
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
 						      min_basename_score,
-						      &info, dirs_removed);
+						      &info,
+						      relevant_sources,
+						      dirs_removed);
 		trace2_region_leave("diff", "basename matches", options->repo);
 
 		/*
-- 
gitgitgadget
