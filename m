Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE1BC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5B611CE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhFUW14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFUW1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CFC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b5so4768557ilc.12
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C0G7B0yqrJmr7K3MFzz6OBt0KR3MXS3lVJZ4/8QMd1s=;
        b=KGIruIBDWF3LgzQ6DeDajsJbfH7UDlw2l21Kc/TNBIF2quLL/U6wqPhjyTJJLW0Y8Z
         WMKhfV7nRYGoCyC5ZyWxmufvpkJpmZq2wiHCyTtMiP8UMo//e6mTUPG88MisAavrGUYr
         dffszynVA+cG1eWclw3AoSNFCQG6wnrTf7nf1eVYBpDacECbjlv4kAHcFoPz7LlcMGSs
         xIDIs+2jOA6Rd4Bc7n4diMOlvSS2uCCE+OZBfL3tSBtwHrXJ0PMUSVw8WWXExxjFJc1L
         N94oVN3oBRyQWPUlEGaE5YMEEPY5NLIm9l/XYyfmmx/KFRQUBhwGKqkngzwDJCke74XU
         0FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C0G7B0yqrJmr7K3MFzz6OBt0KR3MXS3lVJZ4/8QMd1s=;
        b=LO+DlpHXg7e/7pra+/X/NDin1gqIFe4WdJAuB2rvmedjZc8D1oHiiNJbYn7X4BhbtD
         LHfTeu8jXh05mSSdDTWbKUfFBXsrThFeVg8je15N0sQXNpZVEHsAbDq7xCtL2QniY+Kj
         dF6Jtvet5uiUBpAX+yMZ2XuUdoVD+n049mStUg0cPEPF0sZO2BrE19YQ68JrUlQO65hc
         IDTAWF9uyOPFyIzB5jTG5Henp+HJUJqU+Xxx3L0j94en8kxMjIvpu6Vs9vb9MtoDrvrR
         lIHD637i+yj1IVIz8m/qnlZlAvnsAGZbFAiK3IB7GhXEwQDGXXONQ8CqbLbqXR5ZjYrI
         3CeA==
X-Gm-Message-State: AOAM5332jRIjdEfezvgPcv37IU05azXYdzYL+/zwnWFfCQVODk/1p/uj
        6hGRtL4jCL0FHd4Zhkou6xXGYsySGOvfXz8D
X-Google-Smtp-Source: ABdhPJzWb0zylmcXbEG/VJ6oGjtr+T6B1mHOhHe040xEV8eZkeM+1eFnD8sRKUWE+MPne4e0FBhYog==
X-Received: by 2002:a05:6e02:cd1:: with SMTP id c17mr349472ilj.86.1624314335832;
        Mon, 21 Jun 2021 15:25:35 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id c19sm6912790ili.62.2021.06.21.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:35 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write multi-pack bitmaps in the format described by
Documentation/technical/bitmap-format.txt, inferring their presence with
the absence of '--bitmap'.

To write a multi-pack bitmap, this patch attempts to reuse as much of
the existing machinery from pack-objects as possible. Specifically, the
MIDX code prepares a packing_data struct that pretends as if a single
packfile has been generated containing all of the objects contained
within the MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt |  12 +-
 builtin/multi-pack-index.c             |   2 +
 midx.c                                 | 230 ++++++++++++++++++++++++-
 midx.h                                 |   1 +
 4 files changed, 236 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ffd601bc17..ada14deb2c 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
-	[--preferred-pack=<pack>] <subcommand>
+	[--preferred-pack=<pack>] [--[no-]bitmap] <subcommand>
 
 DESCRIPTION
 -----------
@@ -40,6 +40,9 @@ write::
 		multiple packs contain the same object. If not given,
 		ties are broken in favor of the pack with the lowest
 		mtime.
+
+	--[no-]bitmap::
+		Control whether or not a multi-pack bitmap is written.
 --
 
 verify::
@@ -81,6 +84,13 @@ EXAMPLES
 $ git multi-pack-index write
 -----------------------------------------------
 
+* Write a MIDX file for the packfiles in the current .git folder with a
+corresponding bitmap.
++
+-------------------------------------------------------------
+$ git multi-pack-index write --preferred-pack <pack> --bitmap
+-------------------------------------------------------------
+
 * Write a MIDX file for the packfiles in an alternate object store.
 +
 -----------------------------------------------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5d3ea445fd..bf6fa982e3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -68,6 +68,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
 			   N_("preferred-pack"),
 			   N_("pack for reuse when computing a multi-pack bitmap")),
+		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
+			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_END(),
 	};
 
diff --git a/midx.c b/midx.c
index 752d36c57f..a58cca707b 100644
--- a/midx.c
+++ b/midx.c
@@ -13,6 +13,10 @@
 #include "repository.h"
 #include "chunk-format.h"
 #include "pack.h"
+#include "pack-bitmap.h"
+#include "refs.h"
+#include "revision.h"
+#include "list-objects.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -885,6 +889,172 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 static void clear_midx_files_ext(struct repository *r, const char *ext,
 				 unsigned char *keep_hash);
 
+static void prepare_midx_packing_data(struct packing_data *pdata,
+				      struct write_midx_context *ctx)
+{
+	uint32_t i;
+
+	memset(pdata, 0, sizeof(struct packing_data));
+	prepare_packing_data(the_repository, pdata);
+
+	for (i = 0; i < ctx->entries_nr; i++) {
+		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
+		struct object_entry *to = packlist_alloc(pdata, &from->oid);
+
+		oe_set_in_pack(pdata, to,
+			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
+	}
+}
+
+static int add_ref_to_pending(const char *refname,
+			      const struct object_id *oid,
+			      int flag, void *cb_data)
+{
+	struct rev_info *revs = (struct rev_info*)cb_data;
+	struct object *object;
+
+	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+		warning("symbolic ref is dangling: %s", refname);
+		return 0;
+	}
+
+	object = parse_object_or_die(oid, refname);
+	if (object->type != OBJ_COMMIT)
+		return 0;
+
+	add_pending_object(revs, object, "");
+	if (bitmap_is_preferred_refname(revs->repo, refname))
+		object->flags |= NEEDS_BITMAP;
+	return 0;
+}
+
+struct bitmap_commit_cb {
+	struct commit **commits;
+	size_t commits_nr, commits_alloc;
+
+	struct write_midx_context *ctx;
+};
+
+static const struct object_id *bitmap_oid_access(size_t index,
+						 const void *_entries)
+{
+	const struct pack_midx_entry *entries = _entries;
+	return &entries[index].oid;
+}
+
+static void bitmap_show_commit(struct commit *commit, void *_data)
+{
+	struct bitmap_commit_cb *data = _data;
+	if (oid_pos(&commit->object.oid, data->ctx->entries,
+		    data->ctx->entries_nr,
+		    bitmap_oid_access) > -1) {
+		ALLOC_GROW(data->commits, data->commits_nr + 1,
+			   data->commits_alloc);
+		data->commits[data->commits_nr++] = commit;
+	}
+}
+
+static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
+						    struct write_midx_context *ctx)
+{
+	struct rev_info revs;
+	struct bitmap_commit_cb cb;
+
+	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
+	cb.ctx = ctx;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	for_each_ref(add_ref_to_pending, &revs);
+
+	/*
+	 * Skipping promisor objects here is intentional, since it only excludes
+	 * them from the list of reachable commits that we want to select from
+	 * when computing the selection of MIDX'd commits to receive bitmaps.
+	 *
+	 * Reachability bitmaps do require that their objects be closed under
+	 * reachability, but fetching any objects missing from promisors at this
+	 * point is too late. But, if one of those objects can be reached from
+	 * an another object that is included in the bitmap, then we will
+	 * complain later that we don't have reachability closure (and fail
+	 * appropriately).
+	 */
+	fetch_if_missing = 0;
+	revs.exclude_promisor_objects = 1;
+
+	/*
+	 * Pass selected commits in topo order to match the behavior of
+	 * pack-bitmaps when configured with delta islands.
+	 */
+	revs.topo_order = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+
+	if (prepare_revision_walk(&revs))
+		die(_("revision walk setup failed"));
+
+	traverse_commit_list(&revs, bitmap_show_commit, NULL, &cb);
+	if (indexed_commits_nr_p)
+		*indexed_commits_nr_p = cb.commits_nr;
+
+	return cb.commits;
+}
+
+static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
+			     struct write_midx_context *ctx,
+			     unsigned flags)
+{
+	struct packing_data pdata;
+	struct pack_idx_entry **index;
+	struct commit **commits = NULL;
+	uint32_t i, commits_nr;
+	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
+	int ret;
+
+	prepare_midx_packing_data(&pdata, ctx);
+
+	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
+
+	/*
+	 * Build the MIDX-order index based on pdata.objects (which is already
+	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
+	 * this order).
+	 */
+	ALLOC_ARRAY(index, pdata.nr_objects);
+	for (i = 0; i < pdata.nr_objects; i++)
+		index[i] = (struct pack_idx_entry *)&pdata.objects[i];
+
+	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
+	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
+
+	/*
+	 * bitmap_writer_finish expects objects in lex order, but pack_order
+	 * gives us exactly that. use it directly instead of re-sorting the
+	 * array.
+	 *
+	 * This changes the order of objects in 'index' between
+	 * bitmap_writer_build_type_index and bitmap_writer_finish.
+	 *
+	 * The same re-ordering takes place in the single-pack bitmap code via
+	 * write_idx_file(), which is called by finish_tmp_packfile(), which
+	 * happens between bitmap_writer_build_type_index() and
+	 * bitmap_writer_finish().
+	 */
+	for (i = 0; i < pdata.nr_objects; i++)
+		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
+
+	bitmap_writer_select_commits(commits, commits_nr, -1);
+	ret = bitmap_writer_build(&pdata);
+	if (ret < 0)
+		goto cleanup;
+
+	bitmap_writer_set_checksum(midx_hash);
+	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);
+
+cleanup:
+	free(index);
+	free(bitmap_name);
+	return ret;
+}
+
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		for (i = 0; i < ctx.m->num_packs; i++) {
 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
 
+			if (prepare_midx_pack(the_repository, ctx.m, i)) {
+				error(_("could not load pack %s"),
+				      ctx.m->pack_names[i]);
+				result = 1;
+				goto cleanup;
+			}
+
 			ctx.info[ctx.nr].orig_pack_int_id = i;
 			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
-			ctx.info[ctx.nr].p = NULL;
+			ctx.info[ctx.nr].p = ctx.m->packs[i];
 			ctx.info[ctx.nr].expired = 0;
 			ctx.nr++;
 		}
@@ -947,8 +1124,26 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
-		goto cleanup;
+	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
+		struct bitmap_index *bitmap_git;
+		int bitmap_exists;
+		int want_bitmap = flags & MIDX_WRITE_BITMAP;
+
+		bitmap_git = prepare_bitmap_git(the_repository);
+		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
+		free_bitmap_index(bitmap_git);
+
+		if (bitmap_exists || !want_bitmap) {
+			/*
+			 * The correct MIDX already exists, and so does a
+			 * corresponding bitmap (or one wasn't requested).
+			 */
+			if (!want_bitmap)
+				clear_midx_files_ext(the_repository, ".bitmap",
+						     NULL);
+			goto cleanup;
+		}
+	}
 
 	if (preferred_pack_name) {
 		int found = 0;
@@ -964,7 +1159,8 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		if (!found)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
-	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
+	} else if (ctx.nr &&
+		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		time_t oldest = ctx.info[0].p->mtime;
 		ctx.preferred_pack_idx = 0;
 
@@ -1075,9 +1271,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
-	if (ctx.m)
-		close_midx(ctx.m);
-
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
@@ -1108,14 +1301,22 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX)
+	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
 		ctx.pack_order = midx_pack_order(&ctx);
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
+	if (flags & MIDX_WRITE_BITMAP) {
+		if (write_midx_bitmap(midx_name, midx_hash, &ctx, flags) < 0) {
+			error(_("could not write multi-pack bitmap"));
+			result = 1;
+			goto cleanup;
+		}
+	}
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 cleanup:
@@ -1123,6 +1324,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		if (ctx.info[i].p) {
 			close_pack(ctx.info[i].p);
 			free(ctx.info[i].p);
+			if (ctx.m) {
+				/*
+				 * Destroy a stale reference to the pack in
+				 * 'ctx.m'.
+				 */
+				uint32_t orig = ctx.info[i].orig_pack_int_id;
+				if (orig < ctx.m->num_packs)
+					ctx.m->packs[orig] = NULL;
+			}
 		}
 		free(ctx.info[i].pack_name);
 	}
@@ -1132,6 +1342,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	free(midx_name);
+	if (ctx.m)
+		close_midx(ctx.m);
+
 	return result;
 }
 
@@ -1193,6 +1406,7 @@ void clear_midx_file(struct repository *r)
 	if (remove_path(midx))
 		die(_("failed to clear multi-pack-index at %s"), midx);
 
+	clear_midx_files_ext(r, ".bitmap", NULL);
 	clear_midx_files_ext(r, ".rev", NULL);
 
 	free(midx);
diff --git a/midx.h b/midx.h
index 1172df1a71..350f4d0a7b 100644
--- a/midx.h
+++ b/midx.h
@@ -41,6 +41,7 @@ struct multi_pack_index {
 
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
+#define MIDX_WRITE_BITMAP (1 << 2)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 char *get_midx_filename(const char *object_dir);
-- 
2.31.1.163.ga65ce7f831

