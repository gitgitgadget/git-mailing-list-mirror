Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A14CC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0B7207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hkz9kYFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHCS5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465CC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l13so11482632qvt.10
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XySvQ/33jS+7MSIqB0IzojUu84o+bNSIGkfxH8mq4q0=;
        b=hkz9kYFwAntxayUlguONG9SvGm26Q1RainmBFX2pI7wHNXC9Gxly4ZEKOdDNXrGJ2i
         klm7qwDEdsc5vewSp+bhtWTww5rQjp9fh99iWY0WRx6Vwyx5ydYUzQqdAhHnQkAC7doP
         GAJ4Eto9BFVexrbrisxdwPQK0aW1qlRg5dS4lR0ZViuLqVdEdwNOnsJOym5KakVtP2H3
         Fz8VqVqFmuvSnP3htsrFtLrYDmfCpWRJfrjCjYNMSE+hmGWpG8yv7pW2UU7Gd/lz2akj
         h1GQMIklHK3zboF2kxTRFHguJn5xfXpJrSS+r1YL0IEQ93YxHstl2wJKfzRDDuUT5QpP
         qskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XySvQ/33jS+7MSIqB0IzojUu84o+bNSIGkfxH8mq4q0=;
        b=UJ8JU7QoKl0duwlHD656QJyg60STe26I0m/AFi+lCDUbWWpe/u7UscYfqeAETtlaMA
         pXz4iuoiwMNEvfhYw9+pgy/RvxRECNabzo/vmUXS/oRqMdAcJK9pE1ryZgqd/LxZ3bwM
         eoPMygIOVzAxr1zt5JIMRiqQ8O2epnojQCeNpMaM/wABWIcoCVXIwMXj3+txNQa/4YZd
         I3xjt9BLjGq6BpmW+Bt5bAsaZM/ppB34AaWgOshT1BqiEHuFtyYbrs+GETqc9VuiLVTn
         D+b0AVUO/Ujly+gEVC7QkraTf7maUGvI2+nWd2wWw842fj0V+ONDQeAk9sNkzAij9n04
         aMWQ==
X-Gm-Message-State: AOAM531nq8IUVzVpq5j1cG4aeWbdIZ7Wm2mo5cJpoLJJXofW11SGLRUu
        Xe0W9yV7Up9u/HLsJHoUeOKuanbdLXcX7g==
X-Google-Smtp-Source: ABdhPJypusE8kpE2dCoZ9xf9TxiT6dRAwtvxhPgHcVpnNDXBvkQ4FJ2Qup9uBtzHR1HNRBEGef/7rw==
X-Received: by 2002:a0c:a342:: with SMTP id u60mr7563845qvu.48.1596481052197;
        Mon, 03 Aug 2020 11:57:32 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id s184sm21372495qkf.50.2020.08.03.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:31 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 06/10] commit-graph.c: sort index into commits list
Message-ID: <b31c60d71266c40ae23a619d5ac5fd99148e1649.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For locality, 'compute_bloom_filters()' sorts the commits for which it
wants to compute Bloom filters in a preferred order (cf., 3d11275505
(commit-graph: examine commits by generation number, 2020-03-30) for
details).

The subsequent patch will want to recover the new graph position of each
commit. Since the 'packed_commit_list' already stores a double-pointer,
avoid a 'COPY_ARRAY' and instead keep track of an index into the
original list. (Use an integer index instead of a memory address, since
this involves a needlessly confusing triple-pointer).

Alter the two sorting routines 'commit_pos_cmp' and 'commit_gen_cmp' to
take into account the packed_commit_list they are sorting with respect
to. Since 'compute_bloom_filters()' is the only caller for each of those
comparison functions, no other call-sites need updating.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cb9d7fea04..d6ea556649 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -79,10 +79,18 @@ static void set_commit_pos(struct repository *r, const struct object_id *oid)
 	*commit_pos_at(&commit_pos, commit) = max_pos++;
 }
 
-static int commit_pos_cmp(const void *va, const void *vb)
+struct packed_commit_list {
+	struct commit **list;
+	int nr;
+	int alloc;
+};
+
+static int commit_pos_cmp(const void *va, const void *vb, void *ctx)
 {
-	const struct commit *a = *(const struct commit **)va;
-	const struct commit *b = *(const struct commit **)vb;
+	struct packed_commit_list *commits = ctx;
+
+	const struct commit *a = commits->list[*(int *)va];
+	const struct commit *b = commits->list[*(int *)vb];
 	return commit_pos_at(&commit_pos, a) -
 	       commit_pos_at(&commit_pos, b);
 }
@@ -139,10 +147,12 @@ static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 	return data;
 }
 
-static int commit_gen_cmp(const void *va, const void *vb)
+static int commit_gen_cmp(const void *va, const void *vb, void *ctx)
 {
-	const struct commit *a = *(const struct commit **)va;
-	const struct commit *b = *(const struct commit **)vb;
+	struct packed_commit_list *commits = ctx;
+
+	const struct commit *a = commits->list[*(int *)va];
+	const struct commit *b = commits->list[*(int *)vb];
 
 	uint32_t generation_a = commit_graph_generation(a);
 	uint32_t generation_b = commit_graph_generation(b);
@@ -923,12 +933,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
-struct packed_commit_list {
-	struct commit **list;
-	int nr;
-	int alloc;
-};
-
 struct packed_oid_list {
 	struct object_id *list;
 	int nr;
@@ -1389,7 +1393,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
-	struct commit **sorted_commits;
+	int *sorted_commits;
 
 	init_bloom_filters();
 
@@ -1399,15 +1403,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			ctx->commits.nr);
 
 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
-	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
-
-	if (ctx->order_by_pack)
-		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
-	else
-		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
+	for (i = 0; i < ctx->commits.nr; i++)
+		sorted_commits[i] = i;
+	QSORT_S(sorted_commits, ctx->commits.nr,
+		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
+		&ctx->commits);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = sorted_commits[i];
+		int pos = sorted_commits[i];
+		struct commit *c = ctx->commits.list[pos];
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c, 1);
 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
-- 
2.28.0.rc1.13.ge78abce653

