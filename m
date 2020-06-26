Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7644CC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52259207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkeYfq0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgFZMau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgFZMao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C8C08C5DC
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so9318764wrv.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Oc2qesnf6Ofc1rRneszz/pg/RVXkcL/ntZlyvZAqpF0=;
        b=nkeYfq0YJnC6uxt2dJWkrHKCDalZ1qov2EJH2HjgrtNwc/hRW1j8GOHbXw3aKAZQXV
         vnsK2v+OIR0r003j4Ds3NO13DutYc66zmWEUPzKl9selG7BSFqR3pSNadEG5M7UNJKsF
         eKb7leJQTS4qcDLZ/JsKQzwd7GQrbkINGLIIHBMG4SCrM33hvpwhzjwv5VbFnozHWtbR
         ITm5kHaXd3h18EiaVWBczsSu0I2XaE9CIzAZ2wXUrZpEa6VLuBBSavu+FOtKWSg/g/an
         0a/VM0Ce7aW9yt8M8B5oCndWfVSQvI5N5+rhN5jrT8n9N0nHP56hH0pEyWM7f2vV1IW+
         B2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Oc2qesnf6Ofc1rRneszz/pg/RVXkcL/ntZlyvZAqpF0=;
        b=h9U17wrS0Ky6CwcGRI8iWQ3kjSZwV/JA2SJeWZgij3VSjIGuIInsvcxZLTYebdEshv
         VfGEEFfGrjZMUtLY4lUT57IE6+D7+mgvakjLs8iIbY039wX8WYE8Gg/q7cLvN3k2ZiZb
         QRSxB8JOYaTI1ATtCJpblzE2r+a4ZSA6HRro3wnWHAOy3vzm4gvMeqH18htGo7LlGixC
         d2e3f2LPPz2KIUfX8TzIeOEyXMPyrQGeQsxCYCwkN/dKQ463r9VXhb1jX9LzJViXB6fQ
         ja/cJdBh1Ktfyc3Y0WeR0lWLmPcYdJwvIsZf0i4uV8Vst5DbzxB4/xv4O1zEHhhads81
         QCUg==
X-Gm-Message-State: AOAM531mEPOg2Jgda6/Fv3e7A/rs8h5U2yFWGOTfhe0v1Orn7ymLvusd
        HjlncxQ3PojkCI3YRkRIC7hxYyfT
X-Google-Smtp-Source: ABdhPJwjvhQ9OYVUjmkuUBC8qWCUQDRb2UqfUj2kjdvGBogh8atK4URaZsN2IsKkd+JkHIqGWiVhzg==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr3947224wrs.60.1593174642934;
        Fri, 26 Jun 2020 05:30:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o82sm17921636wmo.40.2020.06.26.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:42 -0700 (PDT)
Message-Id: <81c45d5260f4aaf885aa51d19e3ab891aa2988c1.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:31 +0000
Subject: [PATCH v3 05/10] commit-graph: unify the signatures of all
 write_graph_chunk_*() functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Update the write_graph_chunk_*() helper functions to have the same
signature:

  - Return an int error code from all these functions.
    write_graph_chunk_base() already has an int error code, now the
    others will have one, too, but since they don't indicate any
    error, they will always return 0.

  - Drop the hash size parameter of write_graph_chunk_oids() and
    write_graph_chunk_data(); its value can be read directly from
    'the_hash_algo' inside these functions as well.

This opens up the possibility for further cleanups and foolproofing in
the following two patches.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 11088fc11f..d51682998d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -891,8 +891,8 @@ struct write_commit_graph_context {
 	const struct bloom_filter_settings *bloom_settings;
 };
 
-static void write_graph_chunk_fanout(struct hashfile *f,
-				     struct write_commit_graph_context *ctx)
+static int write_graph_chunk_fanout(struct hashfile *f,
+				    struct write_commit_graph_context *ctx)
 {
 	int i, count = 0;
 	struct commit **list = ctx->commits.list;
@@ -913,17 +913,21 @@ static void write_graph_chunk_fanout(struct hashfile *f,
 
 		hashwrite_be32(f, count);
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_oids(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_oids(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	int count;
 	for (count = 0; count < ctx->commits.nr; count++, list++) {
 		display_progress(ctx->progress, ++ctx->progress_cnt);
-		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
+		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
 	}
+
+	return 0;
 }
 
 static const unsigned char *commit_to_sha1(size_t index, void *table)
@@ -932,8 +936,8 @@ static const unsigned char *commit_to_sha1(size_t index, void *table)
 	return commits[index]->object.oid.hash;
 }
 
-static void write_graph_chunk_data(struct hashfile *f, int hash_len,
-				   struct write_commit_graph_context *ctx)
+static int write_graph_chunk_data(struct hashfile *f,
+				  struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -950,7 +954,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 			die(_("unable to parse commit %s"),
 				oid_to_hex(&(*list)->object.oid));
 		tree = get_commit_tree_oid(*list);
-		hashwrite(f, tree->hash, hash_len);
+		hashwrite(f, tree->hash, the_hash_algo->rawsz);
 
 		parent = (*list)->parents;
 
@@ -1030,10 +1034,12 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_extra_edges(struct hashfile *f,
-					  struct write_commit_graph_context *ctx)
+static int write_graph_chunk_extra_edges(struct hashfile *f,
+					 struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1082,10 +1088,12 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 
 		list++;
 	}
+
+	return 0;
 }
 
-static void write_graph_chunk_bloom_indexes(struct hashfile *f,
-					    struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_indexes(struct hashfile *f,
+					   struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1107,6 +1115,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
@@ -1124,8 +1133,8 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_release(&jw);
 }
 
-static void write_graph_chunk_bloom_data(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_data(struct hashfile *f,
+					struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1151,6 +1160,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static int oid_compare(const void *_a, const void *_b)
@@ -1667,8 +1677,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
+	write_graph_chunk_oids(f, ctx);
+	write_graph_chunk_data(f, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->changed_paths) {
-- 
gitgitgadget

