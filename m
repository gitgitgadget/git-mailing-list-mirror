Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D172AC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D620725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlMUIsJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGJBmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBmy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 21:42:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C83C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 18:42:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k1so3283833qko.14
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qp8daOPSlpL2ljIlIlHHek3K8YkiH+eW5qtnM7P8A0Y=;
        b=BlMUIsJ7en0+Af9bdRdhLCcCcs+OtCadPaDz7ZVFM0Pg6MWJg1BwKMEtgYxjNEPzw9
         LvVdn5hgEzEBr/eCacq2ATrq7ZPAgNChBd/G1nk2OzwbxBauhhdO+R+cnZZU2wQkk2wN
         Kee1ZoZvll+Oq4Z26VQA/MYEXLsGCOnW2NP+hIUQ4FHojIXyQPJ0rstI7ij3QyQRH2S/
         sTgOPbiMgCdJgQexTQ+TmPfs2OWCSZy3bEVKTpv/4N7nICFOCGD4PQrL/+8I+rbh4yvj
         F7Gl4mH/dCbIVfqTDu22bHXD7DWNgM2ky2qbTeyjbv0k8XK/fzEdXeWgWuKLoCBJ/Mwh
         dh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qp8daOPSlpL2ljIlIlHHek3K8YkiH+eW5qtnM7P8A0Y=;
        b=C+tF/wK6WKeF/5M8xz1SNUmIE4SRsQ5R0JMzny/vpVzdjWPh+VexuqWPhz8L9IbQOp
         0Hmystasj+0Q8S+e00E3ir31iH84bTjBmaIfcWTwJ8QUJ8RQT0/PHaNkolefwZySUd3r
         xnbsY8ZA7wc6IhgXENBxeIj9Tk3KsdnJ8zzCuTszqTfUUp+5HrvKUzViaDakcinGJCTa
         CldKfrhWUspBb3kSDw4EGpOv/VkXb4WEsyHcluFfnBIIwRbETTcsoq4ONDT1TfLUhbPD
         zvr0xHKVK1zWQLSusHOLhfGumwNdcf5Uz2SQEOSSDHpB0ci/rLXXXqnZ0RV33xCjmRPz
         nqcw==
X-Gm-Message-State: AOAM532GraJw1j8XATTKSZXhwpzagExpJ6PmsFqBJwgpa2QISD6dBIF/
        0Efz39uoc9PzowzrqjNaUsa0AZcVqXQK/fv1B58EqQuF5OXFfsZb/Pw1bHQfBVJfCBFTyRwWebx
        nrADO0P9/SB0dd2yzncUK8NyNkHOmObGk4gpEI4MMqOjP5gFtHxqUlknDlWSgIrjk1LGNYyMB9Q
        ==
X-Google-Smtp-Source: ABdhPJwjY/3xmFyNU8oe93iZOuygSzSWIG/e0Mk9wU0JKy6PF7nZU3r7bC2ljP/evSDIPFNFrUDmvUS72XNxYbCOqcg=
X-Received: by 2002:ad4:45a2:: with SMTP id y2mr37612549qvu.187.1594345373336;
 Thu, 09 Jul 2020 18:42:53 -0700 (PDT)
Date:   Thu,  9 Jul 2020 18:42:41 -0700
In-Reply-To: <20200710014242.1088216-1-emilyshaffer@google.com>
Message-Id: <20200710014242.1088216-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200710014242.1088216-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 1/2] progress: create progress struct in 'verbose' mode
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before now, the progress API is used by conditionally calling
start_progress() or a similar call, and then unconditionally calling
display_progress() and stop_progress(), both of which are tolerant of
NULL or uninitialized inputs. However, in
98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
throughput), the progress library learned to log traces during expensive
operations. In cases where progress should not be displayed to the user
- such as when Git is called by a script - no traces will be logged,
because the progress object is never created.

Instead, to allow us to collect traces from scripted Git commands, teach
a progress->verbose flag, which is specified via a new argument to
start_progress() and friends. display_progress() also learns to filter
for that flag. With these changes, start_progress() can be called
unconditionally but with a conditional as an argument to determine
whether to report progress to the user.

Since this changes the API, also modify callers of start_progress() and
friends to drop their conditional and pass a new argument in instead.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/blame.c             |   4 +-
 builtin/commit-graph.c      |   5 +-
 builtin/fsck.c              |  25 ++++---
 builtin/index-pack.c        |  16 ++---
 builtin/log.c               |   4 +-
 builtin/pack-objects.c      |  18 +++--
 builtin/prune.c             |   4 +-
 builtin/rev-list.c          |   9 ++-
 builtin/unpack-objects.c    |   3 +-
 commit-graph.c              | 140 +++++++++++++++++-------------------
 delta-islands.c             |   4 +-
 diffcore-rename.c           |   9 ++-
 entry.c                     |   2 +-
 midx.c                      |  43 +++++------
 pack-bitmap-write.c         |   8 +--
 pack-bitmap.c               |   5 +-
 preload-index.c             |   7 +-
 progress.c                  |  27 ++++---
 progress.h                  |  10 +--
 prune-packed.c              |   4 +-
 read-cache.c                |   6 +-
 t/helper/test-progress.c    |   6 +-
 t/t0500-progress-display.sh |  27 +++++++
 unpack-trees.c              |  14 ++--
 walker.c                    |   4 +-
 25 files changed, 212 insertions(+), 192 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 94ef57c1cc..1d72b27fda 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1129,8 +1129,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.found_guilty_entry = &found_guilty_entry;
 	sb.found_guilty_entry_data = &pi;
-	if (show_progress)
-		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
+	pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines,
+					     show_progress);
 
 	assign_blame(&sb, opt);
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f6797e2a9f..ae4dc2dfcd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -240,9 +240,8 @@ static int graph_write(int argc, const char **argv)
 					   strbuf_detach(&buf, NULL));
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
-		if (opts.progress)
-			progress = start_delayed_progress(
-				_("Collecting commits from input"), 0);
+		progress = start_delayed_progress(
+			_("Collecting commits from input"), 0, opts.progress);
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
 			if (read_one_commit(&commits, progress, buf.buf)) {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 37aa07da78..3236ed91ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -205,8 +205,8 @@ static int traverse_reachable(void)
 	struct progress *progress = NULL;
 	unsigned int nr = 0;
 	int result = 0;
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	progress = start_delayed_progress(_("Checking connectivity"), 0,
+					  show_progress);
 	while (pending.nr) {
 		result |= traverse_one_object(object_array_pop(&pending));
 		display_progress(progress, ++nr);
@@ -672,8 +672,8 @@ static void fsck_object_dir(const char *path)
 	if (verbose)
 		fprintf_ln(stderr, _("Checking object directory"));
 
-	if (show_progress)
-		progress = start_progress(_("Checking object directories"), 256);
+	progress = start_progress(_("Checking object directories"), 256,
+				  show_progress);
 
 	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
 				      progress);
@@ -836,16 +836,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			if (show_progress) {
-				for (p = get_all_packs(the_repository); p;
-				     p = p->next) {
-					if (open_pack_index(p))
-						continue;
-					total += p->num_objects;
-				}
-
-				progress = start_progress(_("Checking objects"), total);
+			for (p = get_all_packs(the_repository); p;
+			     p = p->next) {
+				if (open_pack_index(p))
+					continue;
+				total += p->num_objects;
 			}
+
+			progress = start_progress(_("Checking objects"), total,
+						  show_progress);
 			for (p = get_all_packs(the_repository); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f865666db9..945fc13ddd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -221,8 +221,7 @@ static unsigned check_objects(void)
 
 	max = get_max_object_index();
 
-	if (verbose)
-		progress = start_delayed_progress(_("Checking objects"), max);
+	progress = start_delayed_progress(_("Checking objects"), max, verbose);
 
 	for (i = 0; i < max; i++) {
 		foreign_nr += check_object(get_indexed_object(i));
@@ -1116,10 +1115,9 @@ static void parse_pack_objects(unsigned char *hash)
 	struct object_id ref_delta_oid;
 	struct stat st;
 
-	if (verbose)
-		progress = start_progress(
-				from_stdin ? _("Receiving objects") : _("Indexing objects"),
-				nr_objects);
+	progress = start_progress(
+			from_stdin ? _("Receiving objects") : _("Indexing objects"),
+			nr_objects, verbose);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		void *data = unpack_raw_entry(obj, &ofs_delta->offset,
@@ -1194,9 +1192,9 @@ static void resolve_deltas(void)
 	QSORT(ofs_deltas, nr_ofs_deltas, compare_ofs_delta_entry);
 	QSORT(ref_deltas, nr_ref_deltas, compare_ref_delta_entry);
 
-	if (verbose || show_resolving_progress)
-		progress = start_progress(_("Resolving deltas"),
-					  nr_ref_deltas + nr_ofs_deltas);
+	progress = start_progress(_("Resolving deltas"),
+				  nr_ref_deltas + nr_ofs_deltas,
+				  (verbose || show_resolving_progress));
 
 	nr_dispatched = 0;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..71874df75c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2045,8 +2045,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	rev.add_signoff = do_signoff;
 
-	if (show_progress)
-		progress = start_delayed_progress(_("Generating patches"), total);
+	progress = start_delayed_progress(_("Generating patches"), total,
+					  show_progress);
 	while (0 <= --nr) {
 		int shown;
 		display_progress(progress, total - nr);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7016b28485..1a97a9f0be 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1012,8 +1012,8 @@ static void write_pack_file(void)
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
 
-	if (progress > pack_to_stdout)
-		progress_state = start_progress(_("Writing objects"), nr_result);
+	progress_state = start_progress(_("Writing objects"), nr_result,
+					(progress > pack_to_stdout));
 	ALLOC_ARRAY(written_list, to_pack.nr_objects);
 	write_order = compute_write_order();
 
@@ -2050,9 +2050,9 @@ static void get_object_details(void)
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
 
-	if (progress)
-		progress_state = start_progress(_("Counting objects"),
-						to_pack.nr_objects);
+	progress_state = start_progress(_("Counting objects"),
+					to_pack.nr_objects,
+					progress);
 
 	sorted_by_offset = xcalloc(to_pack.nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < to_pack.nr_objects; i++)
@@ -2847,9 +2847,8 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
 
-		if (progress)
-			progress_state = start_progress(_("Compressing objects"),
-							nr_deltas);
+		progress_state = start_progress(_("Compressing objects"),
+						nr_deltas, progress);
 		QSORT(delta_list, n, type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		stop_progress(&progress_state);
@@ -3699,8 +3698,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
-	if (progress)
-		progress_state = start_progress(_("Enumerating objects"), 0);
+	progress_state = start_progress(_("Enumerating objects"), 0, progress);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
diff --git a/builtin/prune.c b/builtin/prune.c
index 02c6ab7cba..004338f7e0 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -41,8 +41,8 @@ static void perform_reachability_traversal(struct rev_info *revs)
 	if (initialized)
 		return;
 
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	progress = start_delayed_progress(_("Checking connectivity"), 0,
+					  show_progress);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
 	initialized = 1;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f520111eda..f64cad8390 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -620,8 +620,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list)
 		revs.limited = 1;
 
-	if (show_progress)
-		progress = start_delayed_progress(show_progress, 0);
+	/*
+	 * When progress is not printed to the user, we still want to be able to
+	 * classify the progress during tracing. So, use a placeholder name.
+	 */
+	progress = start_delayed_progress(
+			show_progress ? show_progress : _("Quiet rev-list operation"),
+			0, show_progress != NULL);
 
 	if (use_bitmap_index) {
 		if (!try_bitmap_count(&revs, &filter_options))
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dd4a75e030..719d446916 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -498,8 +498,7 @@ static void unpack_all(void)
 			ntohl(hdr->hdr_version));
 	use(sizeof(struct pack_header));
 
-	if (!quiet)
-		progress = start_progress(_("Unpacking objects"), nr_objects);
+	progress = start_progress(_("Unpacking objects"), nr_objects, !quiet);
 	obj_list = xcalloc(nr_objects, sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
diff --git a/commit-graph.c b/commit-graph.c
index 328ab06fd4..b9a784fece 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1152,10 +1152,10 @@ static void write_graph_chunk_bloom_indexes(struct hashfile *f,
 	struct progress *progress = NULL;
 	int i = 0;
 
-	if (ctx->report_progress)
-		progress = start_delayed_progress(
-			_("Writing changed paths Bloom filters index"),
-			ctx->commits.nr);
+	progress = start_delayed_progress(
+		_("Writing changed paths Bloom filters index"),
+		ctx->commits.nr,
+		ctx->report_progress);
 
 	while (list < last) {
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
@@ -1177,10 +1177,10 @@ static void write_graph_chunk_bloom_data(struct hashfile *f,
 	struct progress *progress = NULL;
 	int i = 0;
 
-	if (ctx->report_progress)
-		progress = start_delayed_progress(
-			_("Writing changed paths Bloom filters data"),
-			ctx->commits.nr);
+	progress = start_delayed_progress(
+		_("Writing changed paths Bloom filters data"),
+		ctx->commits.nr,
+		ctx->report_progress);
 
 	hashwrite_be32(f, settings->hash_version);
 	hashwrite_be32(f, settings->num_hashes);
@@ -1213,8 +1213,7 @@ static int add_packed_commits(const struct object_id *oid,
 	off_t offset = nth_packed_object_offset(pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
-	if (ctx->progress)
-		display_progress(ctx->progress, ++ctx->progress_done);
+	display_progress(ctx->progress, ++ctx->progress_done);
 
 	oi.typep = &type;
 	if (packed_object_info(ctx->r, pack, offset, &oi) < 0)
@@ -1252,10 +1251,10 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	enum commit_graph_split_flags flags = ctx->split_opts ?
 		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Loading known commits in commit graph"),
-					ctx->oids.nr);
+	ctx->progress = start_delayed_progress(
+				_("Loading known commits in commit graph"),
+				ctx->oids.nr,
+				ctx->report_progress);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
@@ -1269,10 +1268,9 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	 * than the number of missing commits in the reachable
 	 * closure.
 	 */
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Expanding reachable commits in commit graph"),
-					0);
+	ctx->progress = start_delayed_progress(
+				_("Expanding reachable commits in commit graph"),
+				0, ctx->report_progress);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
@@ -1289,10 +1287,9 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 	}
 	stop_progress(&ctx->progress);
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Clearing commit marks in commit graph"),
-					ctx->oids.nr);
+	ctx->progress = start_delayed_progress(
+				_("Clearing commit marks in commit graph"),
+				ctx->oids.nr, ctx->report_progress);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
@@ -1308,10 +1305,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	int i;
 	struct commit_list *list = NULL;
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Computing commit graph generation numbers"),
-					ctx->commits.nr);
+	ctx->progress = start_delayed_progress(
+				_("Computing commit graph generation numbers"),
+				ctx->commits.nr,
+				ctx->report_progress);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
 
@@ -1362,10 +1359,10 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	init_bloom_filters();
 
-	if (ctx->report_progress)
-		progress = start_delayed_progress(
-			_("Computing commit changed paths Bloom filters"),
-			ctx->commits.nr);
+	progress = start_delayed_progress(
+		_("Computing commit changed paths Bloom filters"),
+		ctx->commits.nr,
+		ctx->report_progress);
 
 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
 	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
@@ -1418,9 +1415,9 @@ int write_commit_graph_reachable(struct object_directory *odb,
 
 	memset(&data, 0, sizeof(data));
 	data.commits = &commits;
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
-		data.progress = start_delayed_progress(
-			_("Collecting referenced commits"), 0);
+	data.progress = start_delayed_progress(
+		_("Collecting referenced commits"), 0,
+		(flags & COMMIT_GRAPH_WRITE_PROGRESS));
 
 	for_each_ref(add_ref_to_set, &data);
 	result = write_commit_graph(odb, NULL, &commits,
@@ -1442,15 +1439,14 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 
 	strbuf_addf(&packname, "%s/pack/", ctx->odb->path);
 	dirlen = packname.len;
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Finding commits for commit graph in %d pack",
-			       "Finding commits for commit graph in %d packs",
-			       pack_indexes->nr),
-			    pack_indexes->nr);
-		ctx->progress = start_delayed_progress(progress_title.buf, 0);
-		ctx->progress_done = 0;
-	}
+	strbuf_addf(&progress_title,
+		    Q_("Finding commits for commit graph in %d pack",
+		       "Finding commits for commit graph in %d packs",
+		       pack_indexes->nr),
+		    pack_indexes->nr);
+	ctx->progress = start_delayed_progress(progress_title.buf, 0,
+					       ctx->report_progress);
+	ctx->progress_done = 0;
 	for (i = 0; i < pack_indexes->nr; i++) {
 		struct packed_git *p;
 		strbuf_setlen(&packname, dirlen);
@@ -1498,10 +1494,10 @@ static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
 
 static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Finding commits for commit graph among packed objects"),
-			ctx->approx_nr_objects);
+	ctx->progress = start_delayed_progress(
+		_("Finding commits for commit graph among packed objects"),
+		ctx->approx_nr_objects,
+		ctx->report_progress);
 	for_each_packed_object(add_packed_commits, ctx,
 			       FOR_EACH_OBJECT_PACK_ORDER);
 	if (ctx->progress_done < ctx->approx_nr_objects)
@@ -1513,10 +1509,9 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i, count_distinct = 1;
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Counting distinct commits in commit graph"),
-			ctx->oids.nr);
+	ctx->progress = start_delayed_progress(
+		_("Counting distinct commits in commit graph"),
+		ctx->oids.nr, ctx->report_progress);
 	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 
@@ -1545,10 +1540,10 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
 	ctx->num_extra_edges = 0;
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Finding extra edges in commit graph"),
-			ctx->oids.nr);
+	ctx->progress = start_delayed_progress(
+		_("Finding extra edges in commit graph"),
+		ctx->oids.nr,
+		ctx->report_progress);
 	for (i = 0; i < ctx->oids.nr; i++) {
 		unsigned int num_parents;
 
@@ -1723,16 +1718,15 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		hashwrite(f, chunk_write, 12);
 	}
 
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Writing out commit graph in %d pass",
-			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
-		ctx->progress = start_delayed_progress(
-			progress_title.buf,
-			num_chunks * ctx->commits.nr);
-	}
+	strbuf_addf(&progress_title,
+		    Q_("Writing out commit graph in %d pass",
+		       "Writing out commit graph in %d passes",
+		       num_chunks),
+		    num_chunks);
+	ctx->progress = start_delayed_progress(
+		progress_title.buf,
+		num_chunks * ctx->commits.nr,
+		ctx->report_progress);
 	write_graph_chunk_fanout(f, ctx);
 	write_graph_chunk_oids(f, hashsz, ctx);
 	write_graph_chunk_data(f, hashsz, ctx);
@@ -1930,10 +1924,10 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-					_("Scanning merged commits"),
-					ctx->commits.nr);
+	ctx->progress = start_delayed_progress(
+				_("Scanning merged commits"),
+				ctx->commits.nr,
+				ctx->report_progress);
 
 	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
 
@@ -1965,8 +1959,8 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 	while (g && current_graph_number >= ctx->num_commit_graphs_after) {
 		current_graph_number--;
 
-		if (ctx->report_progress)
-			ctx->progress = start_delayed_progress(_("Merging commit-graph"), 0);
+		ctx->progress = start_delayed_progress(_("Merging commit-graph"), 0,
+						       ctx->report_progress);
 
 		merge_commit_graph(ctx, g);
 		stop_progress(&ctx->progress);
@@ -2301,9 +2295,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
-		progress = start_progress(_("Verifying commits in commit graph"),
-					g->num_commits);
+	progress = start_progress(_("Verifying commits in commit graph"),
+				g->num_commits,
+				(flags & COMMIT_GRAPH_WRITE_PROGRESS));
 
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
diff --git a/delta-islands.c b/delta-islands.c
index aa98b2e541..102d4a5573 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -268,8 +268,8 @@ void resolve_tree_islands(struct repository *r,
 	}
 	QSORT(todo, nr, tree_depth_compare);
 
-	if (progress)
-		progress_state = start_progress(_("Propagating island marks"), nr);
+	progress_state = start_progress(_("Propagating island marks"), nr,
+					progress);
 
 	for (i = 0; i < nr; i++) {
 		struct object_entry *ent = todo[i].entry;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 99e63e90f8..4fd5a7b9da 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -587,11 +587,10 @@ void diffcore_rename(struct diff_options *options)
 		break;
 	}
 
-	if (options->show_rename_progress) {
-		progress = start_delayed_progress(
-				_("Performing inexact rename detection"),
-				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
-	}
+	progress = start_delayed_progress(
+			_("Performing inexact rename detection"),
+			(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr,
+			options->show_rename_progress);
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
diff --git a/entry.c b/entry.c
index 449bd32dee..e46e5b56ed 100644
--- a/entry.c
+++ b/entry.c
@@ -174,7 +174,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 
 	dco->state = CE_RETRY;
 	delayed_object_count = dco->paths.nr;
-	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
+	progress = start_delayed_progress(_("Filtering content"), delayed_object_count, 1);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
diff --git a/midx.c b/midx.c
index 6d1584ca51..d9ab163340 100644
--- a/midx.c
+++ b/midx.c
@@ -836,10 +836,8 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	}
 
 	packs.pack_paths_checked = 0;
-	if (flags & MIDX_PROGRESS)
-		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
-	else
-		packs.progress = NULL;
+	packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0,
+						(flags & MIDX_PROGRESS));
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
 	stop_progress(&packs.progress);
@@ -973,9 +971,8 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		written += MIDX_CHUNKLOOKUP_WIDTH;
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Writing chunks to multi-pack-index"),
-					  num_chunks);
+	progress = start_progress(_("Writing chunks to multi-pack-index"),
+				  num_chunks, (flags & MIDX_PROGRESS));
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -1108,9 +1105,8 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	if (!m)
 		return 0;
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Looking for referenced packfiles"),
-					  m->num_packs);
+	progress = start_progress(_("Looking for referenced packfiles"),
+				  m->num_packs, (flags & MIDX_PROGRESS));
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
@@ -1137,9 +1133,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		return verify_midx_error;
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
-						 m->num_objects - 1);
+	progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
+					 m->num_objects - 1,
+					 (flags & MIDX_PROGRESS));
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -1166,15 +1162,16 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Sorting objects by packfile"),
-						 m->num_objects);
+	progress = start_sparse_progress(_("Sorting objects by packfile"),
+					 m->num_objects,
+					 (flags & MIDX_PROGRESS));
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
+	progress = start_sparse_progress(_("Verifying object offsets"),
+					 m->num_objects,
+					 (flags & MIDX_PROGRESS));
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -1229,9 +1226,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Counting referenced objects"),
-					  m->num_objects);
+	progress = start_progress(_("Counting referenced objects"),
+				  m->num_objects, (flags & MIDX_PROGRESS));
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
 		count[pack_int_id]++;
@@ -1239,9 +1235,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	}
 	stop_progress(&progress);
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
-					  m->num_packs);
+	progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+				  m->num_packs, (flags & MIDX_PROGRESS));
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
 		display_progress(progress, i + 1);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a7a4964b50..9a8bfefeb5 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -259,8 +259,8 @@ void bitmap_writer_build(struct packing_data *to_pack)
 	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Building bitmaps", writer.selected_nr);
+	writer.progress = start_progress("Building bitmaps", writer.selected_nr,
+					 writer.show_progress);
 
 	repo_init_revisions(to_pack->repo, &revs, NULL);
 	revs.tag_objects = 1;
@@ -397,8 +397,8 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	QSORT(indexed_commits, indexed_commits_nr, date_compare);
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Selecting bitmap commits", 0);
+	writer.progress = start_progress("Selecting bitmap commits", 0,
+					 writer.show_progress);
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4077e731e8..73232d460f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1313,7 +1313,7 @@ void test_bitmap_walk(struct rev_info *revs)
 
 	tdata.bitmap_git = bitmap_git;
 	tdata.base = bitmap_new();
-	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
+	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt, 1);
 	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
@@ -1392,8 +1392,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 	rebuild = bitmap_new();
 	i = 0;
 
-	if (show_progress)
-		progress = start_progress("Reusing bitmaps", 0);
+	progress = start_progress("Reusing bitmaps", 0, show_progress);
 
 	kh_foreach_value(bitmap_git->bitmaps, stored, {
 		if (stored->flags & BITMAP_FLAG_REUSE) {
diff --git a/preload-index.c b/preload-index.c
index ed6eaa4738..a924a84a14 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -115,10 +115,9 @@ void preload_index(struct index_state *index,
 	memset(&data, 0, sizeof(data));
 
 	memset(&pd, 0, sizeof(pd));
-	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
-		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
-		pthread_mutex_init(&pd.mutex, NULL);
-	}
+	pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr,
+					     (refresh_flags & REFRESH_PROGRESS && isatty(2)));
+	pthread_mutex_init(&pd.mutex, NULL);
 
 	for (i = 0; i < threads; i++) {
 		struct thread_data *p = data+i;
diff --git a/progress.c b/progress.c
index 3eda914518..f014908b05 100644
--- a/progress.c
+++ b/progress.c
@@ -43,6 +43,7 @@ struct progress {
 	struct strbuf counters_sb;
 	int title_len;
 	int split;
+	int verbose;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -245,12 +246,13 @@ void display_throughput(struct progress *progress, uint64_t total)
 
 void display_progress(struct progress *progress, uint64_t n)
 {
-	if (progress)
+	if (progress && progress->verbose)
 		display(progress, n, NULL);
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
-					     unsigned delay, unsigned sparse)
+					     unsigned delay, unsigned sparse,
+					     int verbose)
 {
 	struct progress *progress = xmalloc(sizeof(*progress));
 	progress->title = title;
@@ -264,6 +266,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
+	progress->verbose = verbose;
 	set_progress_signal();
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
@@ -279,14 +282,16 @@ static int get_default_delay(void)
 	return delay_in_secs;
 }
 
-struct progress *start_delayed_progress(const char *title, uint64_t total)
+struct progress *start_delayed_progress(const char *title, uint64_t total,
+					int verbose)
 {
-	return start_progress_delay(title, total, get_default_delay(), 0);
+	return start_progress_delay(title, total, get_default_delay(), 0,
+				    verbose);
 }
 
-struct progress *start_progress(const char *title, uint64_t total)
+struct progress *start_progress(const char *title, uint64_t total, int verbose)
 {
-	return start_progress_delay(title, total, 0, 0);
+	return start_progress_delay(title, total, 0, 0, verbose);
 }
 
 /*
@@ -298,15 +303,17 @@ struct progress *start_progress(const char *title, uint64_t total)
  * When "sparse" is set, stop_progress() will automatically force the done
  * message to show 100%.
  */
-struct progress *start_sparse_progress(const char *title, uint64_t total)
+struct progress *start_sparse_progress(const char *title, uint64_t total,
+				       int verbose)
 {
-	return start_progress_delay(title, total, 0, 1);
+	return start_progress_delay(title, total, 0, 1, verbose);
 }
 
 struct progress *start_delayed_sparse_progress(const char *title,
-					       uint64_t total)
+					       uint64_t total, int verbose)
 {
-	return start_progress_delay(title, total, get_default_delay(), 1);
+	return start_progress_delay(title, total, get_default_delay(), 1,
+				    verbose);
 }
 
 static void finish_if_sparse(struct progress *progress)
diff --git a/progress.h b/progress.h
index f1913acf73..0c64557231 100644
--- a/progress.h
+++ b/progress.h
@@ -13,11 +13,13 @@ void progress_test_force_update(void);
 
 void display_throughput(struct progress *progress, uint64_t total);
 void display_progress(struct progress *progress, uint64_t n);
-struct progress *start_progress(const char *title, uint64_t total);
-struct progress *start_sparse_progress(const char *title, uint64_t total);
-struct progress *start_delayed_progress(const char *title, uint64_t total);
+struct progress *start_progress(const char *title, uint64_t total, int verbose);
+struct progress *start_sparse_progress(const char *title, uint64_t total,
+				       int verbose);
+struct progress *start_delayed_progress(const char *title, uint64_t total,
+					int verbose);
 struct progress *start_delayed_sparse_progress(const char *title,
-					       uint64_t total);
+					       uint64_t total, int verbose);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
diff --git a/prune-packed.c b/prune-packed.c
index 261520b472..dcc982e369 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -31,8 +31,8 @@ static int prune_object(const struct object_id *oid, const char *path,
 
 void prune_packed_objects(int opts)
 {
-	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
+	progress = start_delayed_progress(_("Removing duplicate objects"), 256,
+					  (opts & PRUNE_PACKED_VERBOSE));
 
 	for_each_loose_file_in_objdir(get_object_directory(),
 				      prune_object, NULL, prune_subdir, &opts);
diff --git a/read-cache.c b/read-cache.c
index aa427c5c17..2ddc422dbd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1532,9 +1532,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	const char *unmerged_fmt;
 	struct progress *progress = NULL;
 
-	if (flags & REFRESH_PROGRESS && isatty(2))
-		progress = start_delayed_progress(_("Refresh index"),
-						  istate->cache_nr);
+	progress = start_delayed_progress(_("Refresh index"),
+					  istate->cache_nr,
+					  (flags & REFRESH_PROGRESS && isatty(2)));
 
 	trace_performance_enter();
 	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe789..19b874f9cd 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -23,16 +23,18 @@
 int cmd__progress(int argc, const char **argv)
 {
 	int total = 0;
+	int quiet = 0;
 	const char *title;
 	struct strbuf line = STRBUF_INIT;
 	struct progress *progress;
 
 	const char *usage[] = {
-		"test-tool progress [--total=<n>] <progress-title>",
+		"test-tool progress [--total=<n>] [--quiet] <progress-title>",
 		NULL
 	};
 	struct option options[] = {
 		OPT_INTEGER(0, "total", &total, "total number of items"),
+		OPT_BOOL(0, "quiet", &quiet, "suppress stderr"),
 		OPT_END(),
 	};
 
@@ -42,7 +44,7 @@ int cmd__progress(int argc, const char **argv)
 	title = argv[0];
 
 	progress_testing = 1;
-	progress = start_progress(title, total);
+	progress = start_progress(title, total, !quiet);
 	while (strbuf_getline(&line, stdin) != EOF) {
 		char *end;
 
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1ed1df351c..9d6e6274ad 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -309,4 +309,31 @@ test_expect_success 'progress generates traces' '
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
 
+test_expect_success 'progress generates traces even quietly' '
+	cat >in <<-\EOF &&
+	throughput 102400 1000
+	update
+	progress 10
+	throughput 204800 2000
+	update
+	progress 20
+	throughput 307200 3000
+	update
+	progress 30
+	throughput 409600 4000
+	update
+	progress 40
+	EOF
+
+	GIT_TRACE2_EVENT="$(pwd)/trace.event" test-tool progress --total=40 \
+		--quiet "Working hard" <in 2>stderr &&
+
+	# t0212/parse_events.perl intentionally omits regions and data.
+	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
+	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
+	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
+	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
+'
+
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 4be5fc3075..fa84244466 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -338,16 +338,14 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 {
 	unsigned cnt = 0, total = 0;
 
-	if (!o->update || !o->verbose_update)
-		return NULL;
-
 	for (; cnt < index->cache_nr; cnt++) {
 		const struct cache_entry *ce = index->cache[cnt];
 		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
 			total++;
 	}
 
-	return start_delayed_progress(_("Updating files"), total);
+	return start_delayed_progress(_("Updating files"), total,
+				      (o->update && o->verbose_update));
 }
 
 static void setup_collided_checkout_detection(struct checkout *state,
@@ -1493,10 +1491,10 @@ static int clear_ce_flags(struct index_state *istate,
 	int rval;
 
 	strbuf_reset(&prefix);
-	if (show_progress)
-		istate->progress = start_delayed_progress(
-					_("Updating index flags"),
-					istate->cache_nr);
+	istate->progress = start_delayed_progress(
+				_("Updating index flags"),
+				istate->cache_nr,
+				show_progress);
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
diff --git a/walker.c b/walker.c
index 4984bf8b3d..4758bdde70 100644
--- a/walker.c
+++ b/walker.c
@@ -166,8 +166,8 @@ static int loop(struct walker *walker)
 	struct progress *progress = NULL;
 	uint64_t nr = 0;
 
-	if (walker->get_progress)
-		progress = start_delayed_progress(_("Fetching objects"), 0);
+	progress = start_delayed_progress(_("Fetching objects"), 0,
+					  walker->get_progress);
 
 	while (process_queue) {
 		struct object *obj = process_queue->item;
-- 
2.27.0.383.g050319c2ae-goog

