Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA6C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF2561007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhDISMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhDISMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:06 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCDBC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:51 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id bs7so2622453qvb.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZiG1NnlzlmLSJHzO32tUvfpX78lDOrTGm4HUo1MIDto=;
        b=UszBudJfUE1IMHhDqVfzRZaZdT9ZcMzDSfa00/O90EtvEPRBJxHyfKnAOvhn0rEmdi
         DkTcnJjxqpulWtKHVhmhV7nkC4dPiPAGG2IhHMQ/NW4Y5t5UaeYCfW8/03gO6uvDZ5b+
         UHLQLkt2rCfkqLSZ4cETetma1POus8DF9+mNEh5Hhi5FA6S7eRx3YtBWfvghmqj8B4B6
         qsi8RXWtL8b6pIvBTZc6QqcdsJksEElXOePKvEastG3pl2uf7BC7t1cV5HSciWmTESdh
         Elq5t0KRpZ/W0916XSLNImGCfbBGe/+yIeJ1HNvhdO9sNNfBJQkwF1/oe9z/rO2XZjdR
         gDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZiG1NnlzlmLSJHzO32tUvfpX78lDOrTGm4HUo1MIDto=;
        b=AL6ebCJPXzDdOgiR7sQldvImAtHPh4RLiwILlmrZ+HXnbHVW8SWO+5kxXIoZ5eGGGe
         e5HxQa6N4uDQEwWFMc/E1Qatv9C0SZWku/7lSUuzzcVFsW7MZVnHZ/w9nl1axeROdCN9
         IyEDTSFaBSZNs9qQhvOMIqM9SuW9UlZIhHB7h7YAL2D2yEVU8QtJiJn4yBt+eqmKbwXZ
         qNvveBBO5/SsNwkdSp4aDen+iny6uVNC6qeLQOPyoPBZqjjWVwZlhepAXRu+pYVgt2jh
         tBly/2CYlg1HODn2pJJZbJng837kccWrUC6ul+NvgrfUdFaxy4rDBkz+peOmMTHtyfhL
         HW/w==
X-Gm-Message-State: AOAM531NcRLDaP9ikMlaosUJO0j/xl7fgU+d375Sp9GMsqBTtoyjhYTF
        yyDgx/AegljrgxV9QlpQ5A6SfzvpH4iEmyfW
X-Google-Smtp-Source: ABdhPJxRC18BzNPlCTeymzO21DWDwLcjQ6bP8S9MgI17NQZfiApK3LphTVOZY174rmUSZKzj155ytg==
X-Received: by 2002:ad4:576a:: with SMTP id r10mr15575648qvx.12.1617991910618;
        Fri, 09 Apr 2021 11:11:50 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id q4sm2274060qkq.134.2021.04.09.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:50 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 13/22] pack-bitmap: write multi-pack bitmaps
Message-ID: <fd320c5ed48c7431b64b898f49101b0f53655a95.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
 midx.c                                 | 195 ++++++++++++++++++++++++-
 midx.h                                 |   1 +
 4 files changed, 202 insertions(+), 8 deletions(-)

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
index 567cdf0fcf..32d7d184c0 100644
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
@@ -885,6 +889,145 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
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
+	fetch_if_missing = 0;
+	revs.exclude_promisor_objects = 1;
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
+	 * bitmap_writer_select_commits expects objects in lex order, but
+	 * pack_order gives us exactly that. use it directly instead of
+	 * re-sorting the array
+	 */
+	for (i = 0; i < pdata.nr_objects; i++)
+		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
+
+	bitmap_writer_select_commits(commits, commits_nr, -1);
+	ret = bitmap_writer_build(&pdata);
+	if (!ret)
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
@@ -930,9 +1073,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
@@ -947,8 +1097,26 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
 
 	ctx.preferred_pack_idx = -1;
 	if (preferred_pack_name) {
@@ -1048,9 +1216,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
-	if (ctx.m)
-		close_midx(ctx.m);
-
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
@@ -1081,14 +1246,17 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX)
+	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
 		ctx.pack_order = midx_pack_order(&ctx);
 
 	if (flags & MIDX_WRITE_REV_INDEX)
 		write_midx_reverse_index(midx_name, midx_hash, &ctx);
+	if (flags & MIDX_WRITE_BITMAP)
+		write_midx_bitmap(midx_name, midx_hash, &ctx, flags);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 cleanup:
@@ -1096,6 +1264,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
@@ -1105,6 +1282,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	free(midx_name);
+	if (ctx.m)
+		close_midx(ctx.m);
+
 	return result;
 }
 
@@ -1166,6 +1346,7 @@ void clear_midx_file(struct repository *r)
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

