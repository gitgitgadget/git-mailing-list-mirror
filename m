Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4ABC3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 05:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F7C20674
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 05:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hW3HWYJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgBDFvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:51:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36842 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDFvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 00:51:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so6814115plm.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pcCSlJG6b1M778R1Sra3XEeH76tHN/uGG6sDk4UxAAE=;
        b=hW3HWYJy21YuyOiLkjL2/gC3I8salF6bLKUIdLtYFXYQP4bazkxE6B20UJ7rlo1i3F
         DQRMn8UcFjzNbRsjuMX6tQAhIMRejYoddxyzyLCRCpQ0TaU5ZfQepiSTVpiHQjIkPY4i
         umnCU5nVkqlohsSBsirKP+fOxvqZEFumioepEj+a7CyvzpHEBiS4Fti2uhJKhBiLKAOK
         Ly+MCHApMTJKq2qADBy8Bj1NWr32q6iJkNKQp/JKSVupRvrHQJARL5v7rxNKtpvmNgXL
         UdDgfJK5Yw0sOe0Hcjdo2Zdq0BFmtuUphzOCHD3OZ2r2r/LHHMUr/tP3zOnAfj8xJzjZ
         c/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pcCSlJG6b1M778R1Sra3XEeH76tHN/uGG6sDk4UxAAE=;
        b=Klq+JuY9FPi4R8xLh1XoOIM8fNgeKEATWxJNW/SFPUvNvbvuQpPe2AD7K3d+5lvAJ9
         QM1aikur8L0dWl/u+wlN3Lfp+aJJgMn/7CCAwt+EU08ZIm8xyT8GRprGbt5orOBSwSIf
         MpGk49jibm3AqesPTZuyBUB3pRK3V3qg74ORPOOdMeEmKv/oPBlx0s+KBGVOs11Fomqq
         Lz7s2efq0PhzCDmwcfmFeIHb/Zt2hXVNYAyJBgz0fQlmdZNEZOjArQXRK1+o/cFloI69
         voqcfI9+7AVskKSLnWR1SbgSf1Yw2a3mkOetSMg7Vn51u7fuFp6kVYQ1xnPl7LBzS4Ck
         v9gw==
X-Gm-Message-State: APjAAAW43WqAiksglFWLbXVX73dj4Y1rK7rI3OMfNUpjfNCMiSpoxsSk
        pLZDBD3JlVfK9fjhPLm6XcmrWB7xuucKGA==
X-Google-Smtp-Source: APXvYqwGbnHsf3hk9UV0gViNDefCI6A7n5FXIw64Mnyh/aKa2eD7XjckvapZxEpyMMZx2UgycwGsGg==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr4048470pjt.95.1580795511803;
        Mon, 03 Feb 2020 21:51:51 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id t8sm1390533pjy.20.2020.02.03.21.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 21:51:51 -0800 (PST)
Date:   Mon, 3 Feb 2020 21:51:50 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct
 write_commit_graph_context'
Message-ID: <5d3819180dbc9bc33a8fe4354e2320f497151fb4.1580795403.git.me@ttaylorr.com>
References: <d9819cfb33ad95d4206dd1bbf4b38b7fdf69130f.1580764494.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9819cfb33ad95d4206dd1bbf4b38b7fdf69130f.1580764494.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops. In v2, this patch introduces 'find_odb()' as a function in
'builtin/commit-graph.c', but does not declare it static. This causes
breakage in gcc with '-Wmissing-prototypes'. Here is a correct version
of the patch that does not cause such breakage.

-- 8< --

Subject: [PATCH v2 2/5] commit-graph.h: store an odb in 'struct

There are lots of places in 'commit-graph.h' where a function either has
(or almost has) a full 'struct object_directory *', accesses '->path',
and then throws away the rest of the struct.

This can cause headaches when comparing the locations of object
directories across alternates (e.g., in the case of deciding if two
commit-graph layers can be merged). These paths are normalized with
'normalize_path_copy()' which mitigates some comparison issues, but not
all [1].

Replace usage of 'char *object_dir' with 'odb->path' by storing a
'struct object_directory *' in the 'write_commit_graph_context'
structure. This is an intermediate step towards getting rid of all path
normalization in 'commit-graph.c'.

Resolving a user-provided '--object-dir' argument now requires that we
compare it to the known alternates for equality.  Prior to this patch,
an unknown '--object-dir' argument would silently exit with status zero.

This can clearly lead to unintended behavior, such as verifying
commit-graphs that aren't in a repository's own object store (or one of
its alternates), or causing a typo to mask a legitimate commit-graph
verification failure. Make this error non-silent by 'die()'-ing when the
given '--object-dir' does not match any known alternate object store.

[1]: In my testing, for example, I can get one side of the commit-graph
code to fill object_dir with "./objects" and the other with just
"objects".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  5 +++-
 builtin/commit-graph.c             | 33 ++++++++++++++++++++----
 builtin/commit.c                   |  2 +-
 builtin/fetch.c                    |  2 +-
 builtin/gc.c                       |  2 +-
 commit-graph.c                     | 41 ++++++++++++------------------
 commit-graph.h                     |  5 ++--
 7 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index bcd85c1976..28d1fee505 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -26,7 +26,10 @@ OPTIONS
 	file. This parameter exists to specify the location of an alternate
 	that only has the objects directory, not a full `.git` directory. The
 	commit-graph file is expected to be in the `<dir>/info` directory and
-	the packfiles are expected to be in `<dir>/pack`.
+	the packfiles are expected to be in `<dir>/pack`. If the directory
+	could not be made into an absolute path, or does not match any known
+	object directory, `git commit-graph ...` will exit with non-zero
+	status.

 --[no-]progress::
 	Turn progress on/off explicitly. If neither is specified, progress is
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e0c6fc4bbf..20a3d31b76 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -34,9 +34,29 @@ static struct opts_commit_graph {
 	int progress;
 } opts;

+static struct object_directory *find_odb(struct repository *r,
+					 const char *obj_dir)
+{
+	struct object_directory *odb;
+	char *obj_dir_real = real_pathdup(obj_dir, 1);
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		if (!strcmp(obj_dir_real, real_path(odb->path)))
+			break;
+	}
+
+	free(obj_dir_real);
+
+	if (!odb)
+		die(_("could not find object directory matching %s"), obj_dir);
+	return odb;
+}
+
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
+	struct object_directory *odb = NULL;
 	char *graph_name;
 	int open_ok;
 	int fd;
@@ -67,7 +87,8 @@ static int graph_verify(int argc, const char **argv)
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;

-	graph_name = get_commit_graph_filename(opts.obj_dir);
+	odb = find_odb(the_repository, opts.obj_dir);
+	graph_name = get_commit_graph_filename(odb->path);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok && errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
@@ -76,8 +97,8 @@ static int graph_verify(int argc, const char **argv)

 	if (open_ok)
 		graph = load_commit_graph_one_fd_st(fd, &st);
-	 else
-		graph = read_commit_graph_one(the_repository, opts.obj_dir);
+	else
+		graph = read_commit_graph_one(the_repository, odb->path);

 	/* Return failure if open_ok predicted success */
 	if (!graph)
@@ -94,6 +115,7 @@ static int graph_write(int argc, const char **argv)
 {
 	struct string_list *pack_indexes = NULL;
 	struct string_list *commit_hex = NULL;
+	struct object_directory *odb = NULL;
 	struct string_list lines;
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
@@ -145,9 +167,10 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;

 	read_replace_refs = 0;
+	odb = find_odb(the_repository, opts.obj_dir);

 	if (opts.reachable) {
-		if (write_commit_graph_reachable(opts.obj_dir, flags, &split_opts))
+		if (write_commit_graph_reachable(odb, flags, &split_opts))
 			return 1;
 		return 0;
 	}
@@ -169,7 +192,7 @@ static int graph_write(int argc, const char **argv)
 		UNLEAK(buf);
 	}

-	if (write_commit_graph(opts.obj_dir,
+	if (write_commit_graph(odb,
 			       pack_indexes,
 			       commit_hex,
 			       flags,
diff --git a/builtin/commit.c b/builtin/commit.c
index 646e84547d..9e124aaa7b 100644
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
index b205e65ed1..cbfeece112 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -772,7 +772,7 @@ struct packed_oid_list {

 struct write_commit_graph_context {
 	struct repository *r;
-	char *obj_dir;
+	struct object_directory *odb;
 	char *graph_name;
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -1149,7 +1149,7 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }

-int write_commit_graph_reachable(const char *obj_dir,
+int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts)
 {
@@ -1157,7 +1157,7 @@ int write_commit_graph_reachable(const char *obj_dir,
 	int result;

 	for_each_ref(add_ref_to_list, &list);
-	result = write_commit_graph(obj_dir, NULL, &list,
+	result = write_commit_graph(odb, NULL, &list,
 				    flags, split_opts);

 	string_list_clear(&list, 0);
@@ -1172,7 +1172,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	struct strbuf packname = STRBUF_INIT;
 	int dirlen;

-	strbuf_addf(&packname, "%s/pack/", ctx->obj_dir);
+	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
 	dirlen = packname.len;
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
@@ -1368,10 +1368,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)

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
@@ -1382,7 +1382,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}

 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->obj_dir);
+		char *lock_name = get_chain_filename(ctx->odb->path);

 		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);

@@ -1506,12 +1506,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

@@ -1553,7 +1553,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)

 	while (g && (g->num_commits <= size_mult * num_commits ||
 		    (max_commits && num_commits > max_commits))) {
-		if (strcmp(g->obj_dir, ctx->obj_dir))
+		if (strcmp(g->obj_dir, ctx->odb->path))
 			break;

 		num_commits += g->num_commits;
@@ -1568,7 +1568,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		char *old_graph_name = get_commit_graph_filename(g->obj_dir);

 		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->obj_dir, ctx->obj_dir)) {
+		    strcmp(g->obj_dir, ctx->odb->path)) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -1719,13 +1719,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
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

@@ -1764,7 +1764,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	strbuf_release(&path);
 }

-int write_commit_graph(const char *obj_dir,
+int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
 		       enum commit_graph_write_flags flags,
@@ -1772,7 +1772,6 @@ int write_commit_graph(const char *obj_dir,
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
-	size_t len;
 	int res = 0;

 	if (!commit_graph_compatible(the_repository))
@@ -1780,14 +1779,7 @@ int write_commit_graph(const char *obj_dir,

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
@@ -1824,7 +1816,7 @@ int write_commit_graph(const char *obj_dir,
 		ctx->oids.alloc = split_opts->max_commits;

 	if (ctx->append) {
-		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
+		prepare_commit_graph_one(ctx->r, ctx->odb->path);
 		if (ctx->r->objects->commit_graph)
 			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
 	}
@@ -1898,7 +1890,6 @@ int write_commit_graph(const char *obj_dir,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
-	free(ctx->obj_dir);

 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
diff --git a/commit-graph.h b/commit-graph.h
index 7f5c933fa2..2a6251bd3d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "string-list.h"
 #include "cache.h"
+#include "object-store.h"

 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
@@ -91,10 +92,10 @@ struct split_commit_graph_opts {
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
2.25.0.119.gaa12b7378b
