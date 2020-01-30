Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D760C33CB3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963820CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cJRQBy34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgA3XAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36883 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgA3XAz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so2263846pfn.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tgk0JrDIqvDuykRzCwC+WD+4tjEASuJ1j6oVKK/t4cs=;
        b=cJRQBy34vj7/Qy5SQXXuaY19InbVnxhq2Kfmrs91KL4I9NwM4EUKxbfpE83zzAvbtR
         EYSBra00pQnvGkSvW64N0wkAJBqwncnHA6A4vNF9mPp9+9E0dTSdgoxfFpZXPHq/kgxq
         IsTnULlbTz/EE9JSFYq94dQY36W7y6IfDza6VwRvpZ4oI0Zra+pGz3vhwgomTRhgF6Kn
         isPxk3XK8yWywhF6g+2TXiPZ6HWpZzQoS0CBdLz/HVx8aI9TtKFODF+bfNzbc0q5bZ7h
         yuDwlD9B1cu3HHVpkx96/pN8uriP9hkIVy7/LnzZotk8lN0XXZFWcPGLgf6OxfN3nDJo
         sYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgk0JrDIqvDuykRzCwC+WD+4tjEASuJ1j6oVKK/t4cs=;
        b=GZEZ/u/zAemi/WXlklRKFKnWJDNEAaSoQJqP7vPIZIH4Vm9AmrRXrLYgrKHNmd0lwA
         273qndGp5MRkFvdKi4Lj/4BrdVJHouwJa/Ux6M71WYSGQhGxgLB33BcKW5bS8fDeE1bR
         X1aWJ91aFxQPPgZ3kv8dSUKX1fiFDoN5VteOvVaJYKDRtcdaNitOjNWEPsU6iSmEz3w+
         hhPlannzdQheRSkfVZHYrrodukUv4m7FXU7cGqdJeHY/Jf5DW4uWP7KITm4pz6rNNTHS
         r3yxuNASM50O/L2bmVbj78gKIMfqimgeE8tF0w9zpI7DZZL2eODYZY58g8DRRJpMyjfW
         39sg==
X-Gm-Message-State: APjAAAVLRPK1GG+9xc0QSbcDVthN1lfeelr65XiYpa/Rflr8zrbbrs7D
        SLfOpvqsXcM/IHz7b/ioVn5M9Ik2gUOUog==
X-Google-Smtp-Source: APXvYqzDQFGAigfUwffcaK05hzeLl9bDvULKjjTo/2lNdzPFL7vkVioBkbC7GjGdc3ssC6w55TJ2NA==
X-Received: by 2002:a63:696:: with SMTP id 144mr7439336pgg.260.1580425253635;
        Thu, 30 Jan 2020 15:00:53 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id c6sm7751439pgk.78.2020.01.30.15.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:53 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:52 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 4/6] commit-graph.h: store an odb in 'struct
 write_commit_graph_context'
Message-ID: <3ddec36ba3f8929e5099fd9476de2cdfd06db4d7.1580424766.git.me@ttaylorr.com>
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

In a previous patch, the 'char *object_dir' in 'struct commit_graph' was
replaced with a 'struct object_directory'. This patch applies the same
treatement to 'struct write_commit_graph_context', which is an
intermediate step towards getting rid of all path normalization in
'commit-graph.c'.

Instead of taking a 'char *object_dir', functions that construct a
'struct write_commit_graph_context' now take a 'struct object_directory
*'. Any code that needs an object directory path use '->path' instead.

This ensures that all calls to functions that perform path normalization
are given arguments which do not themselves require normalization. This
prepares those functions to drop their normalization entirely, which
will occur in the subsequent patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c |  4 ++--
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  2 +-
 builtin/gc.c           |  2 +-
 commit-graph.c         | 42 ++++++++++++++++--------------------------
 commit-graph.h         |  4 ++--
 6 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 93ff90d73b..9b1148a60a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -161,7 +161,7 @@ static int graph_write(int argc, const char **argv)
 	odb = find_odb_or_die(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb->path, flags, &split_opts))
+		if (write_commit_graph_reachable(odb, flags, &split_opts))
 			return 1;
 		return 0;
 	}
@@ -183,7 +183,7 @@ static int graph_write(int argc, const char **argv)
 		UNLEAK(buf);
 	}
 
-	if (write_commit_graph(odb->path,
+	if (write_commit_graph(odb,
 			       pack_indexes,
 			       commit_hex,
 			       flags,
diff --git a/builtin/commit.c b/builtin/commit.c
index bd071169d7..9df3733e96 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1689,7 +1689,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0, NULL))
+	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b4c6d921d0..1ce16c96e9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1870,7 +1870,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		if (progress)
 			commit_graph_flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-		write_commit_graph_reachable(get_object_directory(),
+		write_commit_graph_reachable(the_repository->objects->odb,
 					     commit_graph_flags,
 					     NULL);
 	}
diff --git a/builtin/gc.c b/builtin/gc.c
index 3f76bf4aa7..8e0b9cf41b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -686,7 +686,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	prepare_repo_settings(the_repository);
 	if (the_repository->settings.gc_write_commit_graph == 1)
-		write_commit_graph_reachable(get_object_directory(),
+		write_commit_graph_reachable(the_repository->objects->odb,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
diff --git a/commit-graph.c b/commit-graph.c
index 2c06876b26..19889e5fea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -796,7 +796,7 @@ struct packed_oid_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	char *obj_dir;
+	struct object_directory *odb;
 	char *graph_name;
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -1173,7 +1173,7 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir,
+int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts)
 {
@@ -1181,7 +1181,7 @@ int write_commit_graph_reachable(const char *obj_dir,
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
-	result = write_commit_graph(obj_dir, NULL, &list,
+	result = write_commit_graph(odb, NULL, &list,
 				    flags, split_opts);
 
 	string_list_clear(&list, 0);
@@ -1196,7 +1196,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	struct strbuf packname = STRBUF_INIT;
 	int dirlen;
 
-	strbuf_addf(&packname, "%s/pack/", ctx->obj_dir);
+	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
@@ -1392,10 +1392,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		strbuf_addf(&tmp_file,
 			    "%s/info/commit-graphs/tmp_graph_XXXXXX",
-			    ctx->obj_dir);
+			    ctx->odb->path);
 		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
 	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+		ctx->graph_name = get_commit_graph_filename(ctx->odb->path);
 	}
 
 	if (safe_create_leading_directories(ctx->graph_name)) {
@@ -1406,7 +1406,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->obj_dir);
+		char *lock_name = get_chain_filename(ctx->odb->path);
 
 		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);
 
@@ -1530,12 +1530,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				}
 			}
 		} else {
-			char *graph_name = get_commit_graph_filename(ctx->obj_dir);
+			char *graph_name = get_commit_graph_filename(ctx->odb->path);
 			unlink(graph_name);
 		}
 
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(oid_to_hex(&file_hash));
-		final_graph_name = get_split_graph_filename(ctx->obj_dir,
+		final_graph_name = get_split_graph_filename(ctx->odb->path,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
 
@@ -1577,7 +1577,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
 		    (max_commits && num_commits > max_commits))) {
-		if (strcmp(g->odb->path, ctx->obj_dir))
+		if (strcmp(g->odb->path, ctx->odb->path))
 			break;
 
 		num_commits += g->num_commits;
@@ -1592,7 +1592,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		char *old_graph_name = get_commit_graph_filename(g->odb->path);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->odb->path, ctx->obj_dir)) {
+		    strcmp(g->odb->path, ctx->odb->path)) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -1743,13 +1743,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time -= ctx->split_opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_chain_filename(ctx->obj_dir);
+		char *chain_file_name = get_chain_filename(ctx->odb->path);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
 	}
 
-	strbuf_addstr(&path, ctx->obj_dir);
+	strbuf_addstr(&path, ctx->odb->path);
 	strbuf_addstr(&path, "/info/commit-graphs");
 	dir = opendir(path.buf);
 
@@ -1788,7 +1788,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }
 
-int write_commit_graph(const char *obj_dir,
+int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
 		       enum commit_graph_write_flags flags,
@@ -1796,7 +1796,6 @@ int write_commit_graph(const char *obj_dir,
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
-	size_t len;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1804,14 +1803,7 @@ int write_commit_graph(const char *obj_dir,
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
 	ctx->r = the_repository;
-
-	/* normalize object dir with no trailing slash */
-	ctx->obj_dir = xmallocz(strlen(obj_dir) + 1);
-	normalize_path_copy(ctx->obj_dir, obj_dir);
-	len = strlen(ctx->obj_dir);
-	if (len && ctx->obj_dir[len - 1] == '/')
-		ctx->obj_dir[len - 1] = 0;
-
+	ctx->odb = odb;
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
@@ -1848,8 +1840,7 @@ int write_commit_graph(const char *obj_dir,
 		ctx->oids.alloc = split_opts->max_commits;
 
 	if (ctx->append) {
-		struct object_directory *odb = find_odb(ctx->r, ctx->obj_dir);
-		prepare_commit_graph_one(ctx->r, odb);
+		prepare_commit_graph_one(ctx->r, ctx->odb);
 		if (ctx->r->objects->commit_graph)
 			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
 	}
@@ -1923,7 +1914,6 @@ int write_commit_graph(const char *obj_dir,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
-	free(ctx->obj_dir);
 
 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
diff --git a/commit-graph.h b/commit-graph.h
index 9700a6c7c2..39c0c0e51c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,10 +95,10 @@ struct split_commit_graph_opts {
  * is not compatible with the commit-graph feature, then the
  * methods will return 0 without writing a commit-graph.
  */
-int write_commit_graph_reachable(const char *obj_dir,
+int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts);
-int write_commit_graph(const char *obj_dir,
+int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
 		       enum commit_graph_write_flags flags,
-- 
2.25.0.dirty

