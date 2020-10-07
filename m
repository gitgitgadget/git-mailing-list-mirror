Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8701EC4727E
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359CB2076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA/5JsT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgJGOKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgJGOJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BC5C0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so2318900wrq.11
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MqpZbVRT0AAkrfqM5/ytby9slzWuY5bfW7NJH6O8wUE=;
        b=AA/5JsT+naD5Ok/hQeuxXZ2t3c5bQrTdIMfeqdbebR+SDk9rw0e5fsPZc1VvZ0PQs/
         Ks5F1A9SL0LFfXbfCN/EuslW04LS2bI0350K82s/RMXsyBSAYlamkjj5I1f31d7lANbZ
         3arNJXayccav3GwfHD1w1jkVL5IRjyvVEcjgNBKzRg3tuxLPP+lTUftXSLLEgZS6V83B
         YmvNloqNuOsY0Uj3P+nnVDpNjIlMbbRaBA/HINxCbOl5VcKuRNIQt8Nn4zePgA4lOmWF
         fYanBe3+uIWAwKkrs6GI6HMHREbfgBIrMXNPwNibkZqU206N0ZzLS01Bi5s/TGSYlAyU
         SikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MqpZbVRT0AAkrfqM5/ytby9slzWuY5bfW7NJH6O8wUE=;
        b=MLyQSXIE70Pziu3V7EC3L1RC+tfBvhPJNoMgCVZAOsJ81Eo2RPSLzcmwX3YLYD7vi1
         ak7RL7l1p/E1rhzWNZd1wth2iBY2ZD1Qi3zQKH3+SJsgv83YtioHOxUZ4JFeycMJJQpn
         WzEd81ixd3hYiZTNl/YECIIsuu0abrIIUH/EM74sGD27XLsdZ8OtzynRyVhL+qyhBGBg
         UF6km01XgWwMk5JuaoX/vpXz/HGmT1IEHlAhciSfy0tGwDME2wU8jio6pqKA/aJIMH75
         VFjbpI8umeiWCyQ2dHQT81amdqsUp3jrHWA/NMWd2mtNBlOmSu3/R/90++mXZy6EoIHG
         OO9w==
X-Gm-Message-State: AOAM533Gbs0wD3n1ok5djY77UW3qVYqLhmJKOtPfjHIUeuwEXGi3xJ+C
        FAw3ykFjpoBeBrmNJEgR/N/uxKWR5H8=
X-Google-Smtp-Source: ABdhPJz3l/kKdlrX1j57Vrht3XBKLRX7m9PV4f47YtRrOmPSFVFJu8rxl5D7ecLMA0v4Ot6Var1l4g==
X-Received: by 2002:adf:9541:: with SMTP id 59mr3795473wrs.396.1602079793955;
        Wed, 07 Oct 2020 07:09:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a199sm2960371wmd.8.2020.10.07.07.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:52 -0700 (PDT)
Message-Id: <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:41 +0000
Subject: [PATCH v4 06/10] commit-graph: implement corrected commit date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
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

As a special case, a root commit with timestamp of zero (01.01.1970
00:00:00Z) has corrected commit date of one, to be able to distinguish
from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
date).

To minimize the space required to store corrected commit date, Git
stores corrected commit date offsets into the commit-graph file. The
corrected commit date offset for a commit is defined as the difference
between its corrected commit date and actual commit date.

Storing corrected commit date requires sizeof(timestamp_t) bytes, which
in most cases is 64 bits (uintmax_t). However, corrected commit date
offsets can be safely stored using only 32-bits. This halves the size
of GDAT chunk, which is a reduction of around 6% in the size of
commit-graph file.

However, using offsets be problematic if one of commits is malformed but
valid and has committerdate of 0 Unix time, as the offset would be the
same as corrected commit date and thus require 64-bits to be stored
properly.

While Git does not write out offsets at this stage, Git stores the
corrected commit dates in member generation of struct commit_graph_data.
It will begin writing commit date offsets with the introduction of
generation data chunk.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index cedd311024..03948adfce 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -154,11 +154,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
 	else if (generation_a > generation_b)
 		return 1;
 
-	/* use date as a heuristic when generations are equal */
-	if (a->date < b->date)
-		return -1;
-	else if (a->date > b->date)
-		return 1;
 	return 0;
 }
 
@@ -1357,10 +1352,14 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
+		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
 
 		display_progress(ctx->progress, i + 1);
 		if (level != GENERATION_NUMBER_INFINITY &&
-		    level != GENERATION_NUMBER_ZERO)
+		    level != GENERATION_NUMBER_ZERO &&
+		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
+		    corrected_commit_date != GENERATION_NUMBER_ZERO
+		    )
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1369,17 +1368,25 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit_list *parent;
 			int all_parents_computed = 1;
 			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
-
+				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 				if (level == GENERATION_NUMBER_INFINITY ||
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
 
@@ -1389,6 +1396,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+
+				if (current->date && current->date > max_corrected_commit_date)
+					max_corrected_commit_date = current->date - 1;
+				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
 			}
 		}
 	}
@@ -2485,17 +2496,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		if (generation_zero == GENERATION_ZERO_EXISTS)
 			continue;
 
-		/*
-		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
-		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
-		 * extra logic in the following condition.
-		 */
-		if (max_generation == GENERATION_NUMBER_V1_MAX)
-			max_generation--;
-
 		generation = commit_graph_generation(graph_commit);
-		if (generation != max_generation + 1)
-			graph_report(_("commit-graph generation for commit %s is %u != %u"),
+		if (generation < max_generation + 1)
+			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
 				     oid_to_hex(&cur_oid),
 				     generation,
 				     max_generation + 1);
-- 
gitgitgadget

