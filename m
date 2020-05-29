Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88FC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0828C207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vX/hJaID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgE2Ivt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgE2Ivo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28947C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so2504012wrn.11
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpWiAPkGbMrBYhRMZNhm1LsT741LFFYvJlM/7/Welho=;
        b=vX/hJaIDd9DG+lfuslti65P2YhCY3SY/SCKMtO57T2Rtoa31TyXrlRht49xi/9RoE/
         fqDkT9ygNIBJksenlFaeyLFHC+ShS6UpY0NuyRbDuG4ld8CduiVrjbb8CandU8snUlJA
         9BWVRl6OC2YJtWs4Nd5VXDJ1tDnQTkDyntBnBFbv+Z+rrACnHZ07ITlbDNdY3DKP+SzJ
         I/qRzIll6AnHiLD1zmkM/MZHG+tRXWifcMTFfHSjpOcrrl3U2e+ouDGh1GI1ZYORJsRn
         IhXNDuwqy2GBqHvfZ4Xl0vne/rWTOrsEudwVy2tIwRlTsLHsUiXH0bnetsnpP4ImBdey
         NgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpWiAPkGbMrBYhRMZNhm1LsT741LFFYvJlM/7/Welho=;
        b=BxDf53OcrJ3dJ1lEGA5Ydfw7C8SHlOMleyWkeLnupguAs95gwRHNbjgzFX0xRXaiwm
         yF/FF24e8NGQuQPygKY7qwwRX/aGQFCr4QQCay0CuZjPei+G+hDvfKAFtPYM7jhEZRSF
         PMacZk7xz2EShQs+tRpFteTYuC/jgUaWAe1JiG9ude13CPl/C+gsovxCtjrNvbWVc146
         2kNSFGqcfhN9xSMhLXzSQb99MeknCHW+1KmweTD807oi9UeIEKr/T1CU93vkkSVLF3Lu
         zkgzTUzVwxVbtlsrrbs8arY49YWCi+o4uwvJMzSiXuip1JIMKDymw22ClzIrSaUVFQ9Y
         lWTA==
X-Gm-Message-State: AOAM5303ZtWofCsyMc3JjXySJOGxy7OFEhWm+9r6JsYhGvGTJHD38aLx
        M/byJpXupyhgJjT0NFWw+d+X9dOj
X-Google-Smtp-Source: ABdhPJx4Up8r7+Jdrw5Y8J9amTggxoroapi2PA2Ukeimg0w2td3QHcdxIfvDSKzTQKX8az2nzxqFDg==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr3892939wrn.16.1590742302464;
        Fri, 29 May 2020 01:51:42 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 29/34] commit-graph: extract init and free write_commit_graph_context
Date:   Fri, 29 May 2020 10:50:33 +0200
Message-Id: <20200529085038.26008-30-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_commit_graph() function is just over 180 lines long, among
which 86 lines initialize the 'struct write_commit_graph_context'
instance and 32 lines free its resources.

Extract these into init_write_commit_graph_context() and
free_write_commit_graph_context() functions, respectively, to make
write_commit_graph() look much simpler, and, more importantly, to be
able to reuse those init and free functions in the next patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 102 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9cce79d452..b5cd4c863a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2570,19 +2570,16 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(const char *obj_dir,
-		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
-		       enum commit_graph_write_flags flags,
-		       const struct split_commit_graph_opts *split_opts)
+static struct write_commit_graph_context *init_write_commit_graph_context(
+		const char *obj_dir, enum commit_graph_write_flags flags,
+		const struct split_commit_graph_opts *split_opts)
 {
 	struct write_commit_graph_context *ctx;
-	uint32_t i, count_distinct = 0;
 	size_t len;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
-		return 0;
+		return NULL;
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
 	ctx->r = the_repository;
@@ -2637,6 +2634,7 @@ int write_commit_graph(const char *obj_dir,
 		}
 
 		if (ctx->num_commit_graphs_before) {
+			int i;
 			ALLOC_ARRAY(ctx->commit_graph_filenames_before, ctx->num_commit_graphs_before);
 			i = ctx->num_commit_graphs_before;
 			g = ctx->r->objects->commit_graph;
@@ -2664,8 +2662,64 @@ int write_commit_graph(const char *obj_dir,
 		ctx->oids.alloc = 1024;
 	ALLOC_ARRAY(ctx->oids.list, ctx->oids.alloc);
 
+	return ctx;
+}
+
+static void free_write_commit_graph_context(
+		struct write_commit_graph_context *ctx)
+{
+	free(ctx->graph_name);
+	free(ctx->commits.list);
+	free(ctx->oids.list);
+	free(ctx->obj_dir);
+
+	if (ctx->commit_graph_filenames_after) {
+		int i;
+		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
+			free(ctx->commit_graph_filenames_after[i]);
+			free(ctx->commit_graph_hash_after[i]);
+		}
+
+		for (i = 0; i < ctx->num_commit_graphs_before; i++)
+			free(ctx->commit_graph_filenames_before[i]);
+
+		free(ctx->commit_graph_filenames_after);
+		free(ctx->commit_graph_filenames_before);
+		free(ctx->commit_graph_hash_after);
+	}
+
+	if (ctx->mpbfctx.use_modified_path_bloom_filters) {
+		deep_clear_modified_path_bloom_filters(
+				&modified_path_bloom_filters,
+				free_modified_path_bloom_filter_info_in_slab);
+		strbuf_release(&ctx->mpbfctx.prev_path);
+		free(ctx->mpbfctx.hashed_prefix_lengths);
+		free(ctx->mpbfctx.hashes);
+		hashmap_free_entries(&ctx->mpbfctx.dedup_hashmap,
+				struct modified_path_bloom_filter_dedup_entry,
+				entry);
+	}
+
+	free(ctx);
+}
+
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       enum commit_graph_write_flags flags,
+		       const struct split_commit_graph_opts *split_opts)
+{
+	struct write_commit_graph_context *ctx;
+	uint32_t count_distinct = 0;
+	int res = 0;
+
+	ctx = init_write_commit_graph_context(obj_dir, flags, split_opts);
+	if (!ctx)
+		return 0;
+
 	if (ctx->append && ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
+		int i;
 		for (i = 0; i < g->num_commits; i++) {
 			const unsigned char *hash = g->chunk_oid_lookup + g->hash_len * i;
 			hashcpy(ctx->oids.list[ctx->oids.nr++].hash, hash);
@@ -2726,39 +2780,7 @@ int write_commit_graph(const char *obj_dir,
 	expire_commit_graphs(ctx);
 
 cleanup:
-	free(ctx->graph_name);
-	free(ctx->commits.list);
-	free(ctx->oids.list);
-	free(ctx->obj_dir);
-
-	if (ctx->commit_graph_filenames_after) {
-		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
-			free(ctx->commit_graph_filenames_after[i]);
-			free(ctx->commit_graph_hash_after[i]);
-		}
-
-		for (i = 0; i < ctx->num_commit_graphs_before; i++)
-			free(ctx->commit_graph_filenames_before[i]);
-
-		free(ctx->commit_graph_filenames_after);
-		free(ctx->commit_graph_filenames_before);
-		free(ctx->commit_graph_hash_after);
-	}
-
-	if (ctx->mpbfctx.use_modified_path_bloom_filters) {
-		deep_clear_modified_path_bloom_filters(
-				&modified_path_bloom_filters,
-				free_modified_path_bloom_filter_info_in_slab);
-		strbuf_release(&ctx->mpbfctx.prev_path);
-		free(ctx->mpbfctx.hashed_prefix_lengths);
-		free(ctx->mpbfctx.hashes);
-		hashmap_free_entries(&ctx->mpbfctx.dedup_hashmap,
-				struct modified_path_bloom_filter_dedup_entry,
-				entry);
-	}
-
-	free(ctx);
-
+	free_write_commit_graph_context(ctx);
 	return res;
 }
 
-- 
2.27.0.rc1.431.g5c813f95dc

