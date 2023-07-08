Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF29EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjGHAb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjGHAbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:52 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0151FEF
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:47 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so2764680276.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776306; x=1691368306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAoObB6O5zDm5Zz7Y3UEnCaXUR8VFfPpX+eRjYZ+vtE=;
        b=Ig60hNiFyTJIysjYbbqHvvKtYWh1w5adZeZWS/b82+r1fXBgMa6T/tln46jgyM4neq
         xPIV1wDbWgdhSba2rP4vF52gPjWvay3EIJbJCEPnUgX08+7sfPKKcLU+NL1AYDk7pIHz
         s4kPLk68LQwxgadiCVKfbsIjhGWyvzk3XbbEhJFS6uTj+IGHo0UbBC3atOYm/BaSCmY9
         G6fp2M6+AQcYN5rjB7e5uDo5oyxH5F42yRDD9yqMts3PWVn0Ni5wZBaH2tCoSk45zuIJ
         aRkIh40q5lc4zAvxTjgPZJaZQ6cxWklVgKXWxQDsQ+QqD4oxaDj0V06Ntf6yh3txyu6Q
         foUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776306; x=1691368306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAoObB6O5zDm5Zz7Y3UEnCaXUR8VFfPpX+eRjYZ+vtE=;
        b=e0gDl0l0d4kO9aO/3fz2B2LPMifxq50V3Xl8gOMkz8/HGdkFHXj47BKoaN5REnZ6yu
         rH/eu2RrwsHRIEvElHAlSP55IfJriBW5Ju0EQSeFWkENgZcV/JoxpSwzpXvxnGjyS9xh
         Qf1YTtkY1XTuR30MlD2nZSxxpjCd4JsCRb7KSk86znLNhbaxpc7VbSxJfBFW324XVT4R
         b7JZFcLcc89j3v1PApjjSqYThLMlgn0ergjj4PHUjSnByI1V7DOsMnj8doCYViLuYQ/2
         7p5fmbCWyLu1R2Mj7QckpdUj8xMW6P+9n/H0gCW6nmziMHh8MzlHv1aRyJAMk/BVZAo/
         nTUg==
X-Gm-Message-State: ABy/qLaoOY3L8b7h3RIE7rRJwttlXTa1iRzrNcMm64u2gE4rvGKeU2Zx
        cTaMYFWgKRkAaaq71z7BrlOBdlXk6l8e7bhD6itsiw==
X-Google-Smtp-Source: APBJJlFZY9dj7GdpkrMXk6MZC0duKHIUU0NAwQkNabWv74SsahgJFHPsSqkw/DoEdYT/rX+uqKxVCQ==
X-Received: by 2002:a0d:e8c8:0:b0:576:896a:dbc5 with SMTP id r191-20020a0de8c8000000b00576896adbc5mr6230268ywe.48.1688776306443;
        Fri, 07 Jul 2023 17:31:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b127-20020a816785000000b0057a44e20fb8sm1396280ywc.73.2023.07.07.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:46 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 6/6] commit-graph.c: avoid duplicated progress output during
 `verify`
Message-ID: <6eec849fa5aa734670bfcba359ad470efbaf383c.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git commit-graph verify` was taught how to verify commit-graph
chains in 3da4b609bb1 (commit-graph: verify chains with --shallow mode,
2019-06-18), it produced one line of progress per layer of the
commit-graph chain.

    $ git.compile commit-graph verify
    Verifying commits in commit graph: 100% (4356/4356), done.
    Verifying commits in commit graph: 100% (131912/131912), done.

This could be somewhat confusing to users, who may wonder why there are
multiple occurrences of "Verifying commits in commit graph".

There are likely good arguments on whether or not there should be
one line of progress output per commit-graph layer. On the one hand, the
existing output shows us verifying each individual layer of the chain.
But on the other hand, the fact that a commit-graph may be stored among
multiple layers is an implementation detail that the caller need not be
aware of.

Clarify this by showing a single progress meter regardless of the number
of layers in the commit-graph chain. After this patch, the output
reflects the logical contents of a commit-graph chain, instead of
showing one line of output per commit-graph layer:

    $ git.compile commit-graph verify
    Verifying commits in commit graph: 100% (136268/136268), done.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                | 27 +++++++++++++++++----------
 t/t5324-split-commit-graph.sh |  3 ++-
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 65dd4edf0e1..ffcf548223f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2544,7 +2544,8 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
 
 static int verify_one_commit_graph(struct repository *r,
 				   struct commit_graph *g,
-				   struct progress *progress)
+				   struct progress *progress,
+				   uint64_t *seen)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
@@ -2605,7 +2606,7 @@ static int verify_one_commit_graph(struct repository *r,
 		timestamp_t max_generation = 0;
 		timestamp_t generation;
 
-		display_progress(progress, i + 1);
+		display_progress(progress, ++(*seen));
 		oidread(&cur_oid, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
@@ -2694,26 +2695,32 @@ static int verify_one_commit_graph(struct repository *r,
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
+	struct progress *progress = NULL;
 	int local_error = 0;
+	uint64_t seen = 0;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
 		return 1;
 	}
 
+	if (flags & COMMIT_GRAPH_WRITE_PROGRESS) {
+		uint64_t total = g->num_commits;
+		if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW))
+			total += g->num_commits_in_base;
+
+		progress = start_progress(_("Verifying commits in commit graph"),
+					  total);
+	}
+
 	for (; g; g = g->base_graph) {
-		struct progress *progress = NULL;
-		if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
-			progress = start_progress(_("Verifying commits in commit graph"),
-						g->num_commits);
-
-		local_error |= verify_one_commit_graph(r, g, progress);
+		local_error |= verify_one_commit_graph(r, g, progress, &seen);
 		if (flags & COMMIT_GRAPH_VERIFY_SHALLOW)
 			break;
-
-		stop_progress(&progress);
 	}
 
+	stop_progress(&progress);
+
 	return local_error;
 }
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 669ddc645fa..36c4141e67b 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -351,7 +351,8 @@ test_expect_success 'add octopus merge' '
 	git branch merge/octopus &&
 	git commit-graph write --reachable --split &&
 	git commit-graph verify --progress 2>err &&
-	test_line_count = 3 err &&
+	test_line_count = 1 err &&
+	grep "Verifying commits in commit graph: 100% (18/18)" err &&
 	test_i18ngrep ! warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
 '
-- 
2.41.0.242.g6eec849fa5a
