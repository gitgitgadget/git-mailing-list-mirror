Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93699C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C92C61212
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhHXQRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhHXQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:17:23 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7746C0613CF
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:29 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y3so21090929ilm.6
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbD9gRFTn1o9opXaNS7VNsVkBvZ7OlmNxUee53rlVDY=;
        b=MCwV82oGeZFkxe4X90MVQLYTOpnMWjhBBEKjyEQ32XvEoohmZbF8/fiGIUIIaukgBU
         nr049aZNJ7qTFFbtlNYT36zOwt9oWCimTjY9y6l1XeVDYQL7l0SmHwLl1mPrLfZmgDbf
         DJ1sRcQbCBBt3WElqOxW0QO5DDHUb6vGqxMfvv32NIR8zqGJCXfMwRe4L4PyMMswAjhx
         ogYDstr/kWGD3CbG3VA36nXG4Hc+mLfgHLd4qNX6gG2kC6/J74OAdf8dNr24liOsjvLN
         stK8sTHTCJlVGFMYtF4EKABo9apn3/saeW6PzL1gbpktedKoyh4GLaThYHT06O+JJPud
         efcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbD9gRFTn1o9opXaNS7VNsVkBvZ7OlmNxUee53rlVDY=;
        b=jLc4Qi0rSQPcYbrJy9fSsQQ7DG4btds0lNc8/1B0x/rmodLVoJb3WFIsmOUVvVQe6k
         qtNGFiWafhqIoMa5sxEH2+ndbipBx1MiBT2Meea5Oy43AKpaU6VVkQXimbwyzsedf8L/
         pj+D7rNUW8hScYnbcxdJL0QdT2ABu/jH1rOjkt6HB2TCXXmBPAHIQRU/F3pE8qk5o7UA
         Joos0Q5NL6pESdKAMzvkaW4TsaQ39ODLdZOpS81Ktgvyi4LplwtP56SFvBh7lXI/ptaz
         yiglG5ENZEOioz/idtJSaKaz9ypc/WgZT+L5cxjixPbwcza1YVMN75BhxRdEyCW1v3YR
         GLwA==
X-Gm-Message-State: AOAM533Xk3ao994BOrn2Pvhy7ncPqcpaZhrCFeV1HervkYHLOgR+P16B
        FFi/ZxxuPMOAr11uQrIruV7FYtYXsd56DA3L
X-Google-Smtp-Source: ABdhPJz398Bz5EJpV0OU5NmyJl+Ld28/0LLwteeOX9UH1vfl6eeNKA/B6JnyrcuhtAKmRm5CtP8oPw==
X-Received: by 2002:a92:b111:: with SMTP id t17mr27981784ilh.208.1629821788867;
        Tue, 24 Aug 2021 09:16:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7sm10202708ilz.25.2021.08.24.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:28 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 15/25] pack-bitmap: write multi-pack bitmaps
Message-ID: <9d83ad77abff76b0c9e43603295461009cefa415.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
index 8ff0dee2ec..73c0113b48 100644
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
index 2dceaf9565..4574e6d411 100644
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
@@ -938,7 +1102,7 @@ static int write_midx_internal(const char *object_dir,
 
 			ctx.info[ctx.nr].orig_pack_int_id = i;
 			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
-			ctx.info[ctx.nr].p = NULL;
+			ctx.info[ctx.nr].p = ctx.m->packs[i];
 			ctx.info[ctx.nr].expired = 0;
 
 			if (flags & MIDX_WRITE_REV_INDEX) {
@@ -972,8 +1136,26 @@ static int write_midx_internal(const char *object_dir,
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
@@ -989,7 +1171,8 @@ static int write_midx_internal(const char *object_dir,
 		if (!found)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
-	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
+	} else if (ctx.nr &&
+		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
 		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
 		ctx.preferred_pack_idx = 0;
 
@@ -1121,9 +1304,6 @@ static int write_midx_internal(const char *object_dir,
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 
-	if (ctx.m)
-		close_object_store(the_repository->objects);
-
 	if (ctx.nr - dropped_packs == 0) {
 		error(_("no pack files to index."));
 		result = 1;
@@ -1154,14 +1334,24 @@ static int write_midx_internal(const char *object_dir,
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
+	close_object_store(the_repository->objects);
 
 	commit_lock_file(&lk);
 
+	clear_midx_files_ext(the_repository, ".bitmap", midx_hash);
 	clear_midx_files_ext(the_repository, ".rev", midx_hash);
 
 cleanup:
@@ -1178,6 +1368,7 @@ static int write_midx_internal(const char *object_dir,
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	free(midx_name);
+
 	return result;
 }
 
@@ -1238,6 +1429,7 @@ void clear_midx_file(struct repository *r)
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

