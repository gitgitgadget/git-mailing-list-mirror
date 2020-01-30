Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EDC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFA9214AF
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qFkfxtN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgA3XAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52664 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgA3XAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so1971962pjb.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cW4oxAZ+Ys9mN8o11f40V2w4JU4mKeA8zVfZFWdQVxM=;
        b=qFkfxtN9LnMdbMQP+VbDRrWILDvoC/hhBqakLPZNqioZd5SuWo1cLEh/4AthO64KxZ
         7dECWMCwJ85NFjNmhsflh6XAh29hD5VM0zEuVuYLzjr0ll03QLlzV24oAhEIi6zPbvaS
         8ED0ccT3PyEWn43Rs/JSgm9NmiBmNdM3vZ551FCcOCN2bpSjGnpyuoyGEta/8ZmS4wks
         NkwdOYDP1jrMIth+bD8NGfiCXQ6uWG0TC2Tg9KoJhXOLGiDZfI7F129zuEBoM6om354F
         818dV69vwqW7sUsOImDB5DuX8dkOBK1wkz1y+BDs1Mx1m5JrV2SmXQRfFVtdWsW5B93s
         BbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cW4oxAZ+Ys9mN8o11f40V2w4JU4mKeA8zVfZFWdQVxM=;
        b=idAoZv1dNBFDsC2uyotgLLnYfMbm1apUo0W1chOjIT3qKpbxfwAkKcXXtW+hhW0nQl
         3WShHpHpS1SIjVHK+40agWGtV3rUJBRuOlJQrqTts8Pc5nHsJHMchzeBVEFxYTXhorI/
         0zNkI0nfXGQPB7x83Ii6kuhcyRkl0SHkBx/DUWuljA+/nIisKPPLARz8BPWx3frsMYyT
         lXSv3nrrLAirLHSt/yUjGU2pVqnqG3MC58/iBa4SrGndgF+wZedFlG0cV7MIoDfz52Ya
         qoKwJTHc6GOnE4xV1sIstxGu+KgH2lAfcdD0kj8Wv+hmHOath0Dv+LmF0F3EZGv8a3yq
         6/qA==
X-Gm-Message-State: APjAAAUM0UWTKp5MD5AIZU+Pv8eT9+IxheK/BrFZ+eoOpIxhTi/WVf9H
        Bp9MxzgyzNvr3ZqlyMKdjHg9PK6PQNpGNg==
X-Google-Smtp-Source: APXvYqx4YkKsSKdEX3GzT98pLoGoQ9S3mTxe1pYqHVEc1UkKYPyR+NhAkEVGgUTaL1+CGsJWzd67hw==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr8300247pjx.13.1580425251684;
        Thu, 30 Jan 2020 15:00:51 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id 133sm7790090pfy.14.2020.01.30.15.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:51 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:50 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 2/6] commit-graph.h: store object directory in 'struct
 commit_graph'
Message-ID: <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are lots of places in 'commit-graph.h' where a function either has
(or almost has) a full 'struct object_directory *', accesses '->path',
and then throws away the rest of the struct.

This can cause headaches when comparing the locations of object
directories across alternates (e.g., in the case of deciding if two
commit-graph layers can be merged). These paths are normalized with
'normalize_path_copy()' which mitigates some comparison issues, but not
all [1].

Instead of getting rid of the 'struct object_directory *', store that
insead of a 'char *odb' in 'struct commit_graph'. Once the 'struct
write_commit_graph_context' has an object_directory pointer, too, this
will allow calling code to replace these error-prone path comparisons
with raw pointer comparisons, thereby circumventing any
normalization-related errors. This will be introduced in a subsequent
patch.

[1]: In my testing, for example, I can get one side of the commit-graph
code to fill object_dir with "./objects" and the other with just
"objects".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 13 +++++++---
 builtin/commit.c       |  1 +
 commit-graph.c         | 59 ++++++++++++++++++++++++++++++------------
 commit-graph.h         |  8 ++++--
 4 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e0c6fc4bbf..3edac318e8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -76,8 +76,11 @@ static int graph_verify(int argc, const char **argv)
 
 	if (open_ok)
 		graph = load_commit_graph_one_fd_st(fd, &st);
-	 else
-		graph = read_commit_graph_one(the_repository, opts.obj_dir);
+	else {
+		struct object_directory *odb;
+		if ((odb = find_odb(the_repository, opts.obj_dir)))
+			graph = read_commit_graph_one(the_repository, odb);
+	}
 
 	/* Return failure if open_ok predicted success */
 	if (!graph)
@@ -97,6 +100,7 @@ static int graph_write(int argc, const char **argv)
 	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
+	struct object_directory *odb = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -145,9 +149,10 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	read_replace_refs = 0;
+	odb = find_odb(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(opts.obj_dir, flags, &split_opts))
+		if (write_commit_graph_reachable(odb->path, flags, &split_opts))
 			return 1;
 		return 0;
 	}
@@ -169,7 +174,7 @@ static int graph_write(int argc, const char **argv)
 		UNLEAK(buf);
 	}
 
-	if (write_commit_graph(opts.obj_dir,
+	if (write_commit_graph(odb->path,
 			       pack_indexes,
 			       commit_hex,
 			       flags,
diff --git a/builtin/commit.c b/builtin/commit.c
index aa1332308a..bd071169d7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "object-store.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
diff --git a/commit-graph.c b/commit-graph.c
index b205e65ed1..2c06876b26 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -75,6 +75,26 @@ static uint8_t oid_version(void)
 	return 1;
 }
 
+struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+{
+	struct object_directory *odb;
+	char *obj_dir_real = real_pathdup(obj_dir, 1);
+	int cmp = -1;
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		cmp = strcmp(obj_dir_real, real_path(odb->path));
+		if (!cmp)
+			break;
+	}
+
+	free(obj_dir_real);
+
+	if (cmp)
+		odb = NULL;
+	return odb;
+}
+
 static struct commit_graph *alloc_commit_graph(void)
 {
 	struct commit_graph *g = xcalloc(1, sizeof(*g));
@@ -327,14 +347,15 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
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
@@ -372,14 +393,15 @@ static int add_graph_to_chain(struct commit_graph *g,
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
 
@@ -418,7 +440,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 			free(graph_name);
 
 			if (g) {
-				g->obj_dir = odb->path;
+				g->odb = odb;
 
 				if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain = g;
@@ -442,23 +464,25 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
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
@@ -505,7 +529,7 @@ static int prepare_commit_graph(struct repository *r)
 	for (odb = r->objects->odb;
 	     !r->objects->commit_graph && odb;
 	     odb = odb->next)
-		prepare_commit_graph_one(r, odb->path);
+		prepare_commit_graph_one(r, odb);
 	return !!r->objects->commit_graph;
 }
 
@@ -1470,7 +1494,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->obj_dir, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb->path, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -1553,7 +1577,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
 		    (max_commits && num_commits > max_commits))) {
-		if (strcmp(g->obj_dir, ctx->obj_dir))
+		if (strcmp(g->odb->path, ctx->obj_dir))
 			break;
 
 		num_commits += g->num_commits;
@@ -1565,10 +1589,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	ctx->new_base_graph = g;
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->obj_dir);
+		char *old_graph_name = get_commit_graph_filename(g->odb->path);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->obj_dir, ctx->obj_dir)) {
+		    strcmp(g->odb->path, ctx->obj_dir)) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -1824,7 +1848,8 @@ int write_commit_graph(const char *obj_dir,
 		ctx->oids.alloc = split_opts->max_commits;
 
 	if (ctx->append) {
-		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
+		struct object_directory *odb = find_odb(ctx->r, ctx->obj_dir);
+		prepare_commit_graph_one(ctx->r, odb);
 		if (ctx->r->objects->commit_graph)
 			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
 	}
diff --git a/commit-graph.h b/commit-graph.h
index 7f5c933fa2..9700a6c7c2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "string-list.h"
 #include "cache.h"
+#include "object-store.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
@@ -14,6 +15,8 @@ struct commit;
 char *get_commit_graph_filename(const char *obj_dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
+struct object_directory *find_odb(struct repository *r, const char *obj_dir);
+
 /*
  * Given a commit struct, try to fill the commit struct info, including:
  *  1. tree object
@@ -48,7 +51,7 @@ struct commit_graph {
 	uint32_t num_commits;
 	struct object_id oid;
 	char *filename;
-	const char *obj_dir;
+	struct object_directory *odb;
 
 	uint32_t num_commits_in_base;
 	struct commit_graph *base_graph;
@@ -61,7 +64,8 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir);
+struct commit_graph *read_commit_graph_one(struct repository *r,
+					   struct object_directory *odb);
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
 
-- 
2.25.0.dirty

