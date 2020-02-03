Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0170C35249
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B420838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lZvmp4Uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBCVSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:18:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35668 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBCVSD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:18:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so8226856pfg.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rpt9qlFI/odbFse2IdV+tb0tpQ/vmzBN9ScpN0TY4RI=;
        b=lZvmp4UvsLtFE9mbfw02x/SxsFgsE9oZGzRNUanhlSOih2Ul9G8ZdtGOGHlQtQIdQq
         fnYwrivrva7Xo2PVhevCu064nwyk4KIqFdPYS2oNHcujc5cBzmpDn9/3ZhHWpue2RKH6
         EzrSmLPrN624SV2R22u/wN3Dal8sf/Eks1tnIJpHeehAAotZUmKuMrAOgc1LXPVRH2FU
         AvmjmfsrMlZGUjvVaywzgSNVJz5vb93IRRMDDKTlw8YPrX8FMgy7Y2y+RyG2maMNuVbG
         2ES2xHdfzfbwD2MLkvT61mxOMMGSPa9xRnGnzYdLfHm7rbEI3tRzwXe6QemfZQWsE/0c
         nVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rpt9qlFI/odbFse2IdV+tb0tpQ/vmzBN9ScpN0TY4RI=;
        b=BzQVOKpKYOxdo0YHhmsm6rZ50G8DPLm0XullJshKTjWHSbupXqH90PAIN1RRWrXGJ3
         GbkTaZCcFQbRwnym0aHGq2JuxsuCznkWwsNlYYLbE/xmR9q06RF299/68mug4M3CEQbo
         /ivLS4N0SXVnj6pk/IPIckS7ymhE1B+RUcpj4ni7oBfIoZ1Va2Cjktm3pS3VtRbhvUPC
         y8eZwoVJLDwnW/62v5qSHZFVyd5cvVsJx3/kBq6wYqBdRzi2NQLAMjobGWls10ZPWQsD
         4bTavio3QiaUlu9DIdjBjqAHUVSk2iKhVrl4+uzhqGNZiAk/a3RjKTSwlYLupFdw8ZoO
         EW6g==
X-Gm-Message-State: APjAAAUchwFBIj8mQQgX0nMT0O+WJtP6WNo2ZOD0G1GQ3PleUItHk3no
        ckIzIBL1+hXTbx+kg4JRsL37A25Nb/JNEw==
X-Google-Smtp-Source: APXvYqwlLeTVor7R+anbZcdjGho1WtHfwxqtlv+D0O+MkX9uwhJM+l/h0tWCqioOduM+UQoofh3oqw==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr26858960pfh.92.1580764681813;
        Mon, 03 Feb 2020 13:18:01 -0800 (PST)
Received: from localhost ([205.175.106.126])
        by smtp.gmail.com with ESMTPSA id y190sm21964577pfb.82.2020.02.03.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:18:01 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:18:00 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 3/5] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <5fd5cfca6e9a59c0bbf62501e6064106cf87df49.1580764494.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
 <cover.1580764494.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580764494.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous patch, the 'char *object_dir' in 'struct commit_graph' was
replaced with a 'struct object_directory'. This patch applies the same
treatment to 'struct commit_graph', which is another intermediate step
towards getting rid of all path normalization in 'commit-graph.c'.

Instead of taking a 'char *object_dir', functions that construct a
'struct commit_graph' now take a 'struct object_directory *'. Any code
that needs an object directory path use '->path' instead.

This ensures that all calls to functions that perform path normalization
are given arguments which do not themselves require normalization. This
prepares those functions to drop their normalization entirely, which
will occur in the subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c |  2 +-
 commit-graph.c         | 38 +++++++++++++++++++++-----------------
 commit-graph.h         |  5 +++--
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 31b57e4e1d..3501d9077b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -97,7 +97,7 @@ static int graph_verify(int argc, const char **argv)
 	if (open_ok)
 		graph = load_commit_graph_one_fd_st(fd, &st);
 	else
-		graph = read_commit_graph_one(the_repository, odb->path);
+		graph = read_commit_graph_one(the_repository, odb);
 
 	/* Return failure if open_ok predicted success */
 	if (!graph)
diff --git a/commit-graph.c b/commit-graph.c
index cbfeece112..3af4a721ee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -327,14 +327,15 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return g;
 }
 
-static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
+static struct commit_graph *load_commit_graph_v1(struct repository *r,
+						 struct object_directory *odb)
 {
-	char *graph_name = get_commit_graph_filename(obj_dir);
+	char *graph_name = get_commit_graph_filename(odb->path);
 	struct commit_graph *g = load_commit_graph_one(graph_name);
 	free(graph_name);
 
 	if (g)
-		g->obj_dir = obj_dir;
+		g->odb = odb;
 
 	return g;
 }
@@ -372,14 +373,15 @@ static int add_graph_to_chain(struct commit_graph *g,
 	return 1;
 }
 
-static struct commit_graph *load_commit_graph_chain(struct repository *r, const char *obj_dir)
+static struct commit_graph *load_commit_graph_chain(struct repository *r,
+						    struct object_directory *odb)
 {
 	struct commit_graph *graph_chain = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_chain_filename(obj_dir);
+	char *chain_name = get_chain_filename(odb->path);
 	FILE *fp;
 	int stat_res;
 
@@ -418,7 +420,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 			free(graph_name);
 
 			if (g) {
-				g->obj_dir = odb->path;
+				g->odb = odb;
 
 				if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain = g;
@@ -442,23 +444,25 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 	return graph_chain;
 }
 
-struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+struct commit_graph *read_commit_graph_one(struct repository *r,
+					   struct object_directory *odb)
 {
-	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
+	struct commit_graph *g = load_commit_graph_v1(r, odb);
 
 	if (!g)
-		g = load_commit_graph_chain(r, obj_dir);
+		g = load_commit_graph_chain(r, odb);
 
 	return g;
 }
 
-static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
+static void prepare_commit_graph_one(struct repository *r,
+				     struct object_directory *odb)
 {
 
 	if (r->objects->commit_graph)
 		return;
 
-	r->objects->commit_graph = read_commit_graph_one(r, obj_dir);
+	r->objects->commit_graph = read_commit_graph_one(r, odb);
 }
 
 /*
@@ -505,7 +509,7 @@ static int prepare_commit_graph(struct repository *r)
 	for (odb = r->objects->odb;
 	     !r->objects->commit_graph && odb;
 	     odb = odb->next)
-		prepare_commit_graph_one(r, odb->path);
+		prepare_commit_graph_one(r, odb);
 	return !!r->objects->commit_graph;
 }
 
@@ -1470,7 +1474,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->obj_dir, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb->path, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -1553,7 +1557,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
 		    (max_commits && num_commits > max_commits))) {
-		if (strcmp(g->obj_dir, ctx->odb->path))
+		if (strcmp(g->odb->path, ctx->odb->path))
 			break;
 
 		num_commits += g->num_commits;
@@ -1565,10 +1569,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	ctx->new_base_graph = g;
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->obj_dir);
+		char *old_graph_name = get_commit_graph_filename(g->odb->path);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->obj_dir, ctx->odb->path)) {
+		    strcmp(g->odb->path, ctx->odb->path)) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -1816,7 +1820,7 @@ int write_commit_graph(struct object_directory *odb,
 		ctx->oids.alloc = split_opts->max_commits;
 
 	if (ctx->append) {
-		prepare_commit_graph_one(ctx->r, ctx->odb->path);
+		prepare_commit_graph_one(ctx->r, ctx->odb);
 		if (ctx->r->objects->commit_graph)
 			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 2a6251bd3d..2448134378 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -49,7 +49,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
-	const char *obj_dir;
+	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
 	struct commit_graph *base_graph;
@@ -62,7 +62,8 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir);
+struct commit_graph *read_commit_graph_one(struct repository *r,
+					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
 
-- 
2.25.0.119.gaa12b7378b

