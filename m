Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F7C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25C96023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhG0VWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhG0VV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03157C061764
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:04 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c3so663926ilh.3
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YAnx9yKeXHw8PLwFeGB/SZ45k6jh63AZT3CbMzV2zDk=;
        b=v86k/tzc0aHGTWoF4MLFoy/NEVqj4VSYE60ZscMkT0qxx7Vq8P1ioiMZQYaU9llFC6
         vJPv+UQuCmwRVPKPrH71P8l84qDYr4husWJJR9s0PekO2vuTg7SX4s9DYvnZBkcKG3Jm
         x2lBiWuu8KzJngjh9UUzgfKI2WzA3ghwGeiwxHtDkZCgY0iiRgcF7i2WD6R/+qyRXjb/
         w7utm0J1VVzQtkEFGc9BFh9oAO7oT9W9gXX4G2Fay2/YNxrecewokAObNJfJza32weUk
         s+W1tk+mdtcOk5+ezJh+x9p31170Ecgm34Lvp2xaMPb1hb0zifdtEDQAcKis/W711wpe
         DHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAnx9yKeXHw8PLwFeGB/SZ45k6jh63AZT3CbMzV2zDk=;
        b=eSDcjEZYyqqd9HR4DRWPnbCdtrPoiTpqxa1FF68EUwj7/1cIYVH7sqqjCMaJJPVl3R
         Sl3V2cQ5lWLCZmChY2/iYuYAj0mF1PmZad4UytBfDPcMXz82ZS3J4X2Ze8zUDJowmT5F
         QA07q8b1KfIkfv2zL5vAg5yi/d/aYibZSmlkvDM6Ah88TQ4LRBdjiWOPsgDS9mV/vy5u
         yRb+rc8Gbhv9lOG1Yf8jbiUWUFatGq7bsr1uJ0+mesOSMeql2RhZ0Oe3tVOkIj4JXVHs
         FwtjEeUN8pkwXMZrx7Bb4yyRUO61ncOkVooVcfSGUfTxMdKUcwNCFhEDmmWuOQrimjXA
         uSxg==
X-Gm-Message-State: AOAM5330Wmp/ahJ3tHZQv42w+dmC/igeXKpeAF76MLiWZpDNy29RMqtD
        dXuuso/AGzattUL8dascMU5WwSVMl72iTXMs
X-Google-Smtp-Source: ABdhPJz2IoJFHnm908tY5UbcdkrYmmKyHXHvyyxzBCtfLWIjFZngrGwKDTznGrL4qdBknphsG8njqg==
X-Received: by 2002:a92:de4f:: with SMTP id e15mr13942095ilr.267.1627420803177;
        Tue, 27 Jul 2021 14:20:03 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id p21sm3010581iog.37.2021.07.27.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:02 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 15/25] pack-bitmap: write multi-pack bitmaps
Message-ID: <54600b58143f482dcddbaba5edbed70481a90c01.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
 midx.c                                 | 208 ++++++++++++++++++++++++-
 midx.h                                 |   1 +
 4 files changed, 214 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index c9b063d31e..ed52459a9d 100644
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
 		multiple packs contain the same object. `<pack>` must
 		contain at least one object. If not given, ties are
 		broken in favor of the pack with the lowest mtime.
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
+$ git multi-pack-index write --preferred-pack=<pack> --bitmap
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
index db21727c62..ce6cc62c20 100644
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
@@ -893,6 +897,166 @@ static int midx_checksum_valid(struct multi_pack_index *m)
 	return hashfile_checksum_valid(m->data, m->data_len);
 }
 
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
+	int pos = oid_pos(&commit->object.oid, data->ctx->entries,
+			  data->ctx->entries_nr,
+			  bitmap_oid_access);
+	if (pos < 0)
+		return;
+
+	ALLOC_GROW(data->commits, data->commits_nr + 1, data->commits_alloc);
+	data->commits[data->commits_nr++] = commit;
+}
+
+static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
+						    struct write_midx_context *ctx)
+{
+	struct rev_info revs;
+	struct bitmap_commit_cb cb = {0};
+
+	cb.ctx = ctx;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	setup_revisions(0, NULL, &revs, NULL);
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
+		index[i] = &pdata.objects[i].idx;
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
+		index[ctx->pack_order[i]] = &pdata.objects[i].idx;
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
 static int write_midx_internal(const char *object_dir,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -940,7 +1104,7 @@ static int write_midx_internal(const char *object_dir,
 
 			ctx.info[ctx.nr].orig_pack_int_id = i;
 			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
-			ctx.info[ctx.nr].p = NULL;
+			ctx.info[ctx.nr].p = ctx.m->packs[i];
 			ctx.info[ctx.nr].expired = 0;
 
 			if (flags & MIDX_WRITE_REV_INDEX) {
@@ -974,8 +1138,26 @@ static int write_midx_internal(const char *object_dir,
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
 	stop_progress(&ctx.progress);
 
-	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
-		goto cleanup;
+	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop) {
+		struct bitmap_index *bitmap_git;
+		int bitmap_exists;
+		int want_bitmap = flags & MIDX_WRITE_BITMAP;
+
+		bitmap_git = prepare_midx_bitmap_git(the_repository, ctx.m);
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
@@ -991,7 +1173,8 @@ static int write_midx_internal(const char *object_dir,
 		if (!found)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
-	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
+	} else if (ctx.nr &&
+		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
 		ctx.preferred_pack_idx = 0;
 
@@ -1123,9 +1306,6 @@ static int write_midx_internal(const char *object_dir,
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
-	if (ctx.m)
-		close_midx(ctx.m);
-
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
@@ -1156,14 +1336,24 @@ static int write_midx_internal(const char *object_dir,
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
+
+	close_midx(ctx.m);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 cleanup:
@@ -1180,6 +1370,7 @@ static int write_midx_internal(const char *object_dir,
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	free(midx_name);
+
 	return result;
 }
 
@@ -1240,6 +1431,7 @@ void clear_midx_file(struct repository *r)
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

