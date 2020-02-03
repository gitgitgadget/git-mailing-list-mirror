Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF90C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880D20838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lcVUtDc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBCVSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:18:07 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39089 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCVSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:18:06 -0500
Received: by mail-pj1-f68.google.com with SMTP id e9so320304pjr.4
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 13:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=em6c8ZImZhOvxlvjBPGoFZifAkC+lBV7+zc6bNqtq18=;
        b=lcVUtDc6aLWycXD7s1RPy/EYb1xaFtN8ziCZaR40S4aOyLTORxB7WndUK5bCZ2TgeF
         9hEby/7Gruqyzsn6nxNYdEVvUe5yzVvkInyi9Q+RT7PN5zEN6CjbOhLZWXqzbhgSYimg
         pq7+bYISNZJCdhF+xcQIwFJWYDsA4Or17npgWstSI0GLHFDRkWwMAqEvFAHr/AVPO+4w
         aiwVjOZmu+TgtPqxsp8JKJ6VMs+6jjxhdIMgMWl30iofwFasOVzJNx4n5reJjlvg6hwB
         UMggSbYeRXnnr8gxdaoeMlr5wFah1FIlss8PGAcTmQ8wHjC3HcaV54mip/voDzrP3bYe
         wVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=em6c8ZImZhOvxlvjBPGoFZifAkC+lBV7+zc6bNqtq18=;
        b=Pv+rJyeCzsRdRsWNsg9HvA6QIsJ1ETNpjRPLE3T4U1uxPp/1dXAQEyPAZI7+xwXc/u
         Ad3lSdKqRRzJoV2WM1KbBsB3rbcvRdlzzGJuenBz7yXfW5ppEZvKnTrjHZpdk0HwbwNs
         ylecRAaJI2RsiVc6+uAm5nGl9kCTrj673+NpKZBEPYVJvErfaPWNl01uiDI7CSZBR/Sv
         xUWkbY12kairbuw2bUFCeQ8dIe3aeX6JDRdJ5laRKGZpuubksS8t5Tp4NmOa5rdhZ7Cp
         QBlDyIqIdlwiRnA4CHdc94Im7aLURn4BLw0hzz4BfeOdB/hs9AMCrpKn8XIfF46IuwuL
         iw3A==
X-Gm-Message-State: APjAAAVwa0SUdxnAC1stNRujj5TRG76legQXREVB9oocwiX+qoLtbsa7
        w12VF3VikRFPtvViNuiqo58Q83oCkhOwKQ==
X-Google-Smtp-Source: APXvYqz/rsw96/r8xWIjHm7cplW1hQJ7DYshg2YgHRRgG8wo+diSbOlDrhifCi7yBJ24ryZnlRpHnw==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr1273189pjv.73.1580764683472;
        Mon, 03 Feb 2020 13:18:03 -0800 (PST)
Received: from localhost ([205.175.106.126])
        by smtp.gmail.com with ESMTPSA id b21sm22045422pfp.0.2020.02.03.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:18:03 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:18:02 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 4/5] commit-graph.c: remove path normalization, comparison
Message-ID: <f14e95aa7eb2fa4dce2c3e1a1d81dd022efede0b.1580764494.git.me@ttaylorr.com>
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

As of the previous patch, all calls to 'commit-graph.c' functions which
perform path normalization (for e.g., 'get_commit_graph_filename()') are
of the form 'ctx->odb->path', which is always in normalized form.

Now that there are no callers passing non-normalized paths to these
functions, ensure that future callers are bound by the same restrictions
by making these functions take a 'struct object_directory *' instead of
a 'const char *'. To match, replace all calls with arguments of the form
'ctx->odb->path' with 'ctx->odb' To recover the path, functions that
perform path manipulation simply use 'odb->path'.

Further, avoid string comparisons with arguments of the form
'odb->path', and instead prefer raw pointer comparisons, which
accomplish the same effect, but are far less brittle.

This has a pleasant side-effect of making these functions much more
robust to paths that cannot be normalized by 'normalize_path_copy()',
i.e., because they are outside of the current working directory.

For example, prior to this patch, Valgrind reports that the following
uninitialized memory read [1]:

  $ ( cd t && GIT_DIR=../.git valgrind git rev-parse HEAD^ )

because 'normalize_path_copy()' can't normalize '../.git' (since it's
relative to but above of the current working directory) [2].

By using a 'struct object_directory *' directly,
'get_commit_graph_filename()' does not need to normalize, because all
paths are relative to the current working directory since they are
always read from the '->path' of an object directory.

[1]: https://lore.kernel.org/git/20191027042116.GA5801@sigill.intra.peff.net.
[2]: The bug here is that 'get_commit_graph_filename()' returns the
     result of 'normalize_path_copy()' without checking the return
     value.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c     |  2 +-
 commit-graph.c             | 47 +++++++++++++++-----------------------
 commit-graph.h             |  2 +-
 t/helper/test-read-graph.c |  6 ++---
 4 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3501d9077b..b16eba2a7a 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -87,7 +87,7 @@ static int graph_verify(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	odb = find_odb(the_repository, opts.obj_dir);
-	graph_name = get_commit_graph_filename(odb->path);
+	graph_name = get_commit_graph_filename(odb);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok && errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
diff --git a/commit-graph.c b/commit-graph.c
index 3af4a721ee..49541760b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -44,30 +44,21 @@
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
-char *get_commit_graph_filename(const char *obj_dir)
+char *get_commit_graph_filename(struct object_directory *odb)
 {
-	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
-	char *normalized = xmalloc(strlen(filename) + 1);
-	normalize_path_copy(normalized, filename);
-	free(filename);
-	return normalized;
+	return xstrfmt("%s/info/commit-graph", odb->path);
 }
 
-static char *get_split_graph_filename(const char *obj_dir,
+static char *get_split_graph_filename(struct object_directory *odb,
 				      const char *oid_hex)
 {
-	char *filename = xstrfmt("%s/info/commit-graphs/graph-%s.graph",
-				 obj_dir,
-				 oid_hex);
-	char *normalized = xmalloc(strlen(filename) + 1);
-	normalize_path_copy(normalized, filename);
-	free(filename);
-	return normalized;
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph", odb->path,
+		       oid_hex);
 }
 
-static char *get_chain_filename(const char *obj_dir)
+static char *get_chain_filename(struct object_directory *odb)
 {
-	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", obj_dir);
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
 
 static uint8_t oid_version(void)
@@ -330,7 +321,7 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 static struct commit_graph *load_commit_graph_v1(struct repository *r,
 						 struct object_directory *odb)
 {
-	char *graph_name = get_commit_graph_filename(odb->path);
+	char *graph_name = get_commit_graph_filename(odb);
 	struct commit_graph *g = load_commit_graph_one(graph_name);
 	free(graph_name);
 
@@ -381,7 +372,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct stat st;
 	struct object_id *oids;
 	int i = 0, valid = 1, count;
-	char *chain_name = get_chain_filename(odb->path);
+	char *chain_name = get_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
 
@@ -414,7 +405,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 
 		valid = 0;
 		for (odb = r->objects->odb; odb; odb = odb->next) {
-			char *graph_name = get_split_graph_filename(odb->path, line.buf);
+			char *graph_name = get_split_graph_filename(odb, line.buf);
 			struct commit_graph *g = load_commit_graph_one(graph_name);
 
 			free(graph_name);
@@ -1375,7 +1366,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			    ctx->odb->path);
 		ctx->graph_name = strbuf_detach(&tmp_file, NULL);
 	} else {
-		ctx->graph_name = get_commit_graph_filename(ctx->odb->path);
+		ctx->graph_name = get_commit_graph_filename(ctx->odb);
 	}
 
 	if (safe_create_leading_directories(ctx->graph_name)) {
@@ -1386,7 +1377,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	if (ctx->split) {
-		char *lock_name = get_chain_filename(ctx->odb->path);
+		char *lock_name = get_chain_filename(ctx->odb);
 
 		hold_lock_file_for_update(&lk, lock_name, LOCK_DIE_ON_ERROR);
 
@@ -1474,7 +1465,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
-		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb->path, new_base_hash);
+		char *new_base_name = get_split_graph_filename(ctx->new_base_graph->odb, new_base_hash);
 
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 2]);
 		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2]);
@@ -1510,12 +1501,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 				}
 			}
 		} else {
-			char *graph_name = get_commit_graph_filename(ctx->odb->path);
+			char *graph_name = get_commit_graph_filename(ctx->odb);
 			unlink(graph_name);
 		}
 
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(oid_to_hex(&file_hash));
-		final_graph_name = get_split_graph_filename(ctx->odb->path,
+		final_graph_name = get_split_graph_filename(ctx->odb,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
 
@@ -1557,7 +1548,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 
 	while (g && (g->num_commits <= size_mult * num_commits ||
 		    (max_commits && num_commits > max_commits))) {
-		if (strcmp(g->odb->path, ctx->odb->path))
+		if (g->odb != ctx->odb)
 			break;
 
 		num_commits += g->num_commits;
@@ -1569,10 +1560,10 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	ctx->new_base_graph = g;
 
 	if (ctx->num_commit_graphs_after == 2) {
-		char *old_graph_name = get_commit_graph_filename(g->odb->path);
+		char *old_graph_name = get_commit_graph_filename(g->odb);
 
 		if (!strcmp(g->filename, old_graph_name) &&
-		    strcmp(g->odb->path, ctx->odb->path)) {
+		    g->odb != ctx->odb) {
 			ctx->num_commit_graphs_after = 1;
 			ctx->new_base_graph = NULL;
 		}
@@ -1723,7 +1714,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	if (ctx->split_opts && ctx->split_opts->expire_time)
 		expire_time -= ctx->split_opts->expire_time;
 	if (!ctx->split) {
-		char *chain_file_name = get_chain_filename(ctx->odb->path);
+		char *chain_file_name = get_chain_filename(ctx->odb);
 		unlink(chain_file_name);
 		free(chain_file_name);
 		ctx->num_commit_graphs_after = 0;
diff --git a/commit-graph.h b/commit-graph.h
index 2448134378..5a690723b0 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -12,7 +12,7 @@
 
 struct commit;
 
-char *get_commit_graph_filename(const char *obj_dir);
+char *get_commit_graph_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index d2884efe0a..2c2f65f06c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -11,12 +11,12 @@ int cmd__read_graph(int argc, const char **argv)
 	int open_ok;
 	int fd;
 	struct stat st;
-	const char *object_dir;
+	struct object_directory *odb;
 
 	setup_git_directory();
-	object_dir = get_object_directory();
+	odb = the_repository->objects->odb;
 
-	graph_name = get_commit_graph_filename(object_dir);
+	graph_name = get_commit_graph_filename(odb);
 
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok)
-- 
2.25.0.119.gaa12b7378b

