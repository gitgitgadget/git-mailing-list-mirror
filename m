Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE9DC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4223C2053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5o+bE5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgHOWFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgHOVux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A045C0A3BF3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so10945607wrm.6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3YuPMWbjM1ZnPG3IVZSLcSZcfSHeNABaP5tzmsVTiKU=;
        b=s5o+bE5/5PTiH4lKDujfr33VaV9h6FiwcpkvPIFHAhRE8BrSb72S9CdPkqHmE894Xj
         DBqp382gkJ5Ag8QOgKbY4lX3urUbKph8onWtrlX9nNN7d0BITlrsv21OG3eu7p1C8uaZ
         zgfNH4/ldYaP88vHQyvLxZDWsmEOVjVLuAiv1BC9PlFAEzS2ScKoZfm2UvamKqho0XES
         gcjg+wg4WF4EnRpNu32XFwT3b+wZ19E98QoLI1rTeVIVrEjAjwD48C2o+OXP0fyo5ZDR
         dMqWGzjSAte1F8x5HVymrvlM3XDxRAkkZk5g2xHjyuB7WpZfwprY0E8phTs/jyYwVabL
         5fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3YuPMWbjM1ZnPG3IVZSLcSZcfSHeNABaP5tzmsVTiKU=;
        b=VfbyMK9ur4r6sfho2zT/W3ZMJtP1jWFrKbbHs6anDjv3CtT0b1R/yF5gHDQkWDd4oU
         0K9kuOGDIYUQkAmmvOGItgl2NlRE+ZdD2l3Ejq3XWRTwFJzwcNbCXu6PtGRrqq7Glfu7
         FWOFZOd2FlHUMOlthz0pwtlyuBybmD1HHpeQqcDOlBL6FmKmvGLt0fY+e5UpFm5EuQGz
         U8i6UcGue9KouO9dn2HQ3p8gpfvcFwuocoWVaKTxc1XQKTimxJKlBRMO7cqF2Jx2NnVF
         qTEgMeNkRqlZJhpF1i8IS5WFClBgeTMI0Wzuc/yBdGDjhKHWXAFaewJ4GeG+0TkKSsTp
         W+6g==
X-Gm-Message-State: AOAM531b+WKvJTD6NcdlTh1+fh/l1fPvKXmRT85FvKY9s/dnlUcqoCQT
        fI2/Wg56ua8RFLxtnalD0yX9Q6eveew=
X-Google-Smtp-Source: ABdhPJz7r8kYN2m6bSdjVEDlMr/5ZlUfKuDbpdinGQB64C1lBGt30DiQiLrc4qxS0hizmqNP3cxhVA==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr2423778wrq.78.1597509591084;
        Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16sm25724784wrr.13.2020.08.15.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:50 -0700 (PDT)
Message-Id: <4074ace65be3094d35dd0aaedb89eb5a0ec98cee.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:39 +0000
Subject: [PATCH v3 07/11] commit-graph: implement corrected commit date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With most of preparations done, let's implement corrected commit date.

The corrected commit date for a commit is defined as:

* A commit with no parents (a root commit) has corrected commit date
  equal to its committer date.
* A commit with at least one parent has corrected commit date equal to
  the maximum of its commit date and one more than the largest corrected
  commit date among its parents.

To minimize the space required to store corrected commit date, Git
stores corrected commit date offsets into the commit-graph file. The
corrected commit date offset for a commit is defined as the difference
between its corrected commit date and actual commit date.

While Git does not write out offsets at this stage, Git stores the
corrected commit dates in member generation of struct commit_graph_data.
It will begin writing commit date offsets with the introduction of
generation data chunk.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 58 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a2f15b2825..fd69534dd5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -169,11 +169,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	else if (generation_a > generation_b)
 		return 1;
 
-	/* use date as a heuristic when generations are equal */
-	if (a->date < b->date)
-		return -1;
-	else if (a->date > b->date)
-		return 1;
 	return 0;
 }
 
@@ -1342,10 +1337,14 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
+		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
 
 		display_progress(ctx->progress, i + 1);
 		if (level != GENERATION_NUMBER_V1_INFINITY &&
-		    level != GENERATION_NUMBER_ZERO)
+		    level != GENERATION_NUMBER_ZERO &&
+		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
+		    corrected_commit_date != GENERATION_NUMBER_ZERO
+		    )
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1354,17 +1353,26 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit_list *parent;
 			int all_parents_computed = 1;
 			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
+				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
 				if (level == GENERATION_NUMBER_V1_INFINITY ||
-				    level == GENERATION_NUMBER_ZERO) {
+				    level == GENERATION_NUMBER_ZERO ||
+				    corrected_commit_date == GENERATION_NUMBER_INFINITY ||
+				    corrected_commit_date == GENERATION_NUMBER_ZERO
+				    ) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (level > max_level) {
-					max_level = level;
+				} else {
+					if (level > max_level)
+						max_level = level;
+
+					if (corrected_commit_date > max_corrected_commit_date)
+						max_corrected_commit_date = corrected_commit_date;
 				}
 			}
 
@@ -1374,6 +1382,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (max_level > GENERATION_NUMBER_MAX - 1)
 					max_level = GENERATION_NUMBER_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+
+				if (current->date > max_corrected_commit_date)
+					max_corrected_commit_date = current->date - 1;
+				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
 			}
 		}
 	}
@@ -2372,8 +2384,8 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
-		timestamp_t max_generation = 0;
-		timestamp_t generation;
+		timestamp_t max_corrected_commit_date = 0;
+		timestamp_t corrected_commit_date;
 
 		display_progress(progress, i + 1);
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
@@ -2412,9 +2424,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			generation = commit_graph_generation(graph_parents->item);
-			if (generation > max_generation)
-				max_generation = generation;
+			corrected_commit_date = commit_graph_generation(graph_parents->item);
+			if (corrected_commit_date > max_corrected_commit_date)
+				max_corrected_commit_date = corrected_commit_date;
 
 			graph_parents = graph_parents->next;
 			odb_parents = odb_parents->next;
@@ -2436,20 +2448,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
 
-		/*
-		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
-		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
-		 * extra logic in the following condition.
-		 */
-		if (max_generation == GENERATION_NUMBER_MAX)
-			max_generation--;
-
-		generation = commit_graph_generation(graph_commit);
-		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
+		corrected_commit_date = commit_graph_generation(graph_commit);
+		if (corrected_commit_date < max_corrected_commit_date + 1)
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
 				     oid_to_hex(&cur_oid),
-				     generation,
-				     max_generation + 1);
+				     corrected_commit_date,
+				     max_corrected_commit_date + 1);
 
 		if (graph_commit->date != odb_commit->date)
 			graph_report(_("commit date for commit %s in commit-graph is %"PRItime" != %"PRItime),
-- 
gitgitgadget

