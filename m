Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE704C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A270C206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aramdzxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgGAN1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731088AbgGAN1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:27:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E6EC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:27:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so10789845wmi.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fJHYFO+7x6kA0BJFGtB61JVFGUyOmqi3FbQlHe8Geqs=;
        b=aramdzxZyX2BeWZXh8xMxTOS7E73KXT4pyPYrIVRC+RFAesgWrAem1pb48ZLlFlIWN
         WU67OUD0/PNnJPQkjv8k7VUhFBM/6Aynkbr351hR/z7poi+rA2US61jiHwdG8Ol8Filj
         /euDXFRnRcTnKL7liEbGQ/6PGg5svX6rkGHRokpChhN12lytpR5m4yTIdmVXB3P9OkeF
         1rEmvU8UppqkS6qwFb4YOg7wzVHQ4kohBqLeO198yG4deGmLDI2VthZKDDtusSTkSCsE
         BIaSSxK8s5XAlW/Xe6qfPFLOUmweBzlyBfq4wbCLUMJBxF+q6FgpRFggl714Ey9jS/nG
         feSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fJHYFO+7x6kA0BJFGtB61JVFGUyOmqi3FbQlHe8Geqs=;
        b=uSlwtIqbdM8EQdF/aMe/TDbKpo21/jI92e6kk9BJe0IVEz0ZPmR2cEA6srDHFGo+Me
         4HchVPHwpgyPrNm4Qt5PPrW3w3RlYiLmmoAdQ12NVDLDtHcRGZDWIWOt1d+LzpIlcGoT
         ey5ZQFEyUFQ7kYidEJBTzkrGeCwEFljxqHv2Yv6RBg8GtjWzGJe61npT0WO9VOdfwDLu
         bvzfr4BOMPmVd6UW3Zq+d2lK/O3DRC7zCoQnQj84eOJ5wTwW1zEG/m6uK3NwhMCOPSmI
         KKuRXJ4ivchVMOh4NwFUTKduIv2fOsro3Gk3zZuxQIVsu0gjHqAw+ZtIQqdOtiI5onFv
         VyGw==
X-Gm-Message-State: AOAM533aQ4trtFacRL5WF0GTa28YjHbSd2uVLfmLNvlM6tDGeqD+3VQ6
        AQjdqHwtngLfRnQeWykdIe0/F3FE
X-Google-Smtp-Source: ABdhPJyQk2NSifm3zE5lJKiGpDN49xq4YgqybFSDksPrXlF7DhHdYLH1W8IytgTZkYbVGHVP4/yiFQ==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr25784722wmc.154.1593610056161;
        Wed, 01 Jul 2020 06:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm7431330wmc.32.2020.07.01.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:27:35 -0700 (PDT)
Message-Id: <c07992147354258c3ea76bba4d85f430ddda5632.1593610050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
        <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 13:27:25 +0000
Subject: [PATCH v4 05/10] commit-graph: unify the signatures of all
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
index 6762704324..1a6d26f864 100644
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
@@ -1108,6 +1116,7 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
@@ -1125,8 +1134,8 @@ static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
 	jw_release(&jw);
 }
 
-static void write_graph_chunk_bloom_data(struct hashfile *f,
-					 struct write_commit_graph_context *ctx)
+static int write_graph_chunk_bloom_data(struct hashfile *f,
+					struct write_commit_graph_context *ctx)
 {
 	struct commit **list = ctx->commits.list;
 	struct commit **last = ctx->commits.list + ctx->commits.nr;
@@ -1155,6 +1164,7 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	}
 
 	stop_progress(&progress);
+	return 0;
 }
 
 static int oid_compare(const void *_a, const void *_b)
@@ -1671,8 +1681,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

