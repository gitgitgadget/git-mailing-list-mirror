Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BFC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2F022CF7
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Tgw7z+R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHERFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgHERCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:02:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B9C0617A3
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:02:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so42377453qka.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnfpCipl9Slkz8EUOG39zqbhG2/9zqI8fjgty/iURK8=;
        b=Tgw7z+R1pP1CmrXus4Gw+lxVj8kmxi65zPlw/u/KvDjsc9q9jVsVS3oQpilF4Uop/D
         VCFwZjEHRQlaCbaScAVmFFCxa9jK6ahuYp3FHRo8ReWvgkbNOdn1wK3zV3s2O1/XYZyx
         6osPRnG1fxJn8RnosECwS4zCMVcqsmpryAZwQ11E227v+RfFkEwR9rNHJ18W4OCulB+5
         JE/UzBLntEob5Cgqn6KBl8Zh1OCsI2NbUPrxkVduuUlAlzPC9ZicRK+xFmYtU+Tmf6wD
         pU0ub5/kqbHOitmOzZItycIdUg0YeJCkZuUPVEStPN7Bj/ucXNRkCZAm1dFBG9WWEDD2
         jGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnfpCipl9Slkz8EUOG39zqbhG2/9zqI8fjgty/iURK8=;
        b=o23J8m13Pkk0yd+HgmtBGExH/eMla3gnG4UnHuP+16ck0/LDSEdplP6BVng1WBMdGb
         b6QWaVf3cbJOauSIzFy50aBNgU4E4Ellj59WJIalKVeJ3V6iTHP5ZTVtteFQ4qIzsaP3
         PH91UM96uWwcdHb35X0nKmIXu7trk8cFhpqAnDfsrx9DTCupVDbeajbkqRCXEH0Mt1l4
         poAUYTEImT/TGf1B6MynmIn/V0w6ebLLWPLYTK9ju/xcNeBG9EwDYBjocBRG+8tTx+yC
         DSR2ll1x/wfAnDa359XipI5XPcw8yvfbqmf31I4vNF+bSsElZF5z4OWwxi90MYuJf0Wp
         +WHQ==
X-Gm-Message-State: AOAM5317hpM3KEwTu3QsTOUJSNNpUg03G4Zi5i4rNLl8SOuI8tC8bgES
        dT8YOoqk9ztkxDqlOsWbb0wwNbgeGyrJeg==
X-Google-Smtp-Source: ABdhPJwEM7a0bZATGsA9auO68PNPkidpwwRF5w400obsVYgVdBWaf+LMRq+/VNXnN1Qj3EcGPGmTJg==
X-Received: by 2002:a05:620a:12af:: with SMTP id x15mr4124305qki.441.1596646972568;
        Wed, 05 Aug 2020 10:02:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id k134sm1980868qke.60.2020.08.05.10.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:51 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 10/14] commit-graph.c: sort index into commits list
Message-ID: <e92ccafcf7e0efe6e7e1b3af8f2e2e8634a1816b.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For locality, 'compute_bloom_filters()' sorts the commits for which it
wants to compute Bloom filters in a preferred order (cf., 3d11275505
(commit-graph: examine commits by generation number, 2020-03-30) for
details).

A future patch will want to recover the new graph position of each
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
 commit-graph.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 48d4697f54..0d70545149 100644
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
@@ -922,11 +932,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
-struct packed_commit_list {
-	struct commit **list;
-	int nr;
-	int alloc;
-};
 
 struct packed_oid_list {
 	struct object_id *list;
@@ -1408,7 +1413,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
-	struct commit **sorted_commits;
+	int *sorted_commits;
 
 	init_bloom_filters();
 
@@ -1418,16 +1423,16 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
 		int computed = 0;
-		struct commit *c = sorted_commits[i];
+		int pos = sorted_commits[i];
+		struct commit *c = ctx->commits.list[pos];
 		struct bloom_filter *filter = get_or_compute_bloom_filter(
 			ctx->r,
 			c,
-- 
2.28.0.rc1.13.ge78abce653

