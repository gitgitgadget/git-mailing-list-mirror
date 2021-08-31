Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22EBC4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6D660ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbhHaUxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbhHaUxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D2C0612A7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so764222ioq.9
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CFCC1BXGCVDgg84FP4CQpcCdwosXuE7A34ek0ZMYfdI=;
        b=wJdZheh8xrt74r+W/OHNIJDY4dZf7M0Yovwkk/of+kQLELKlWU79sLOnGWax9Hm/bQ
         tNJSbVq3U2LuWmYYQRH2ejRmbdxd6zJKZesDDD0bTNwP19MV3V+smRS9SgKUIQgUlyoj
         8+dK0+lkERQHJ9r1zg0sEKFFY9+KSk6EbuAYOxVwubrFHG/lAjLM/uxa1IGCY0NXuh+c
         mLHyYJvpS583l1WZ2pI/VTNvafQ/F9aVg67Or33lYs97xPfTRJpbCwGpgOqbt9HnSbhR
         6yluMmonqOPeKMGSE/dNg7BZmNc5z8P0jLbeE/f+2z92H2wfItG07CoJW/nvrzP9L8CI
         IiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CFCC1BXGCVDgg84FP4CQpcCdwosXuE7A34ek0ZMYfdI=;
        b=Y9qzrSO63szlesy6F2xZJXxzJbJyFNPaA6bRzwWT3eJhsMvABpbbaI5MgO3q82XbV0
         Bu2Ou40K+RnNJAD+oxNyIPMr65W7ZhcLd/5g6hmud24N0PH/CPtjjV9zfHygLv0l9Ug/
         9ijdtc9tUIxny5UAawHLf6Yixq64fRMJ9Q6haOVykNqYbgYwp8a++OohkoG5NGahxFzk
         Jgnv8SOvblcBubRVYds8TqAUCtvnGGVttw3dQNI/0DnbJkbn5NCDZ4e1974K4SA+ueca
         mwc7ucY+tkUlMuAL4TZLVb9FSMg9arJPdefXMkH5KGJ6qfO9jQIfhJcsy1l+DdkfB700
         gpwQ==
X-Gm-Message-State: AOAM531za6QEPzoflraZHG+hRXMB9Ig69y6iJAtgItBMQjiLpHAzLGqf
        eLnAi1XjFCDTuorEaaWGNsdQAox4g5y5GrDb
X-Google-Smtp-Source: ABdhPJwr+6aiYta0YtFeQGyzRItZvnrIKz2bcENvz//OU1gHShrSijOtRN5wZQgMIC792WILI4G+kQ==
X-Received: by 2002:a5d:9ada:: with SMTP id x26mr23488262ion.50.1630443142559;
        Tue, 31 Aug 2021 13:52:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 12sm10673837ilq.37.2021.08.31.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:22 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 16/27] pack-bitmap: read multi-pack bitmaps
Message-ID: <61798853b6c5bec0ecc92d8aacc6c676441840d3.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This prepares the code in pack-bitmap to interpret the new multi-pack
bitmaps described in Documentation/technical/bitmap-format.txt, which
mostly involves converting bit positions to accommodate looking them up
in a MIDX.

Note that there are currently no writers who write multi-pack bitmaps,
and that this will be implemented in the subsequent commit. Note also
that get_midx_checksum() and get_midx_filename() are made non-static so
they can be called from pack-bitmap.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |   5 +
 midx.c                 |   4 +-
 midx.h                 |   2 +
 pack-bitmap-write.c    |   2 +-
 pack-bitmap.c          | 357 ++++++++++++++++++++++++++++++++++++-----
 pack-bitmap.h          |   6 +
 packfile.c             |   2 +-
 7 files changed, 336 insertions(+), 42 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b63e06e46c..c26dedfe5d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1124,6 +1124,11 @@ static void write_reused_pack(struct hashfile *f)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
+			/*
+			 * Can use bit positions directly, even for MIDX
+			 * bitmaps. See comment in try_partial_reuse()
+			 * for why.
+			 */
 			write_reused_pack_one(pos + offset, f, &w_curs);
 			display_progress(progress_state, ++written);
 		}
diff --git a/midx.c b/midx.c
index 43510290dc..6a10f7a042 100644
--- a/midx.c
+++ b/midx.c
@@ -48,12 +48,12 @@ static uint8_t oid_version(void)
 	}
 }
 
-static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
 	return m->data + m->data_len - the_hash_algo->rawsz;
 }
 
-static char *get_midx_filename(const char *object_dir)
+char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
diff --git a/midx.h b/midx.h
index 8684cf0fef..1172df1a71 100644
--- a/midx.h
+++ b/midx.h
@@ -42,6 +42,8 @@ struct multi_pack_index {
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 
+const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+char *get_midx_filename(const char *object_dir);
 char *get_midx_rev_filename(struct multi_pack_index *m);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 142fd0adb8..9c55c1531e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -48,7 +48,7 @@ void bitmap_writer_show_progress(int show)
 }
 
 /**
- * Build the initial type index for the packfile
+ * Build the initial type index for the packfile or multi-pack-index
  */
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4e37f5d574..fa69ed7a6d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -13,6 +13,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "list-objects-filter-options.h"
+#include "midx.h"
 #include "config.h"
 
 /*
@@ -35,8 +36,15 @@ struct stored_bitmap {
  * the active bitmap index is the largest one.
  */
 struct bitmap_index {
-	/* Packfile to which this bitmap index belongs to */
+	/*
+	 * The pack or multi-pack index (MIDX) that this bitmap index belongs
+	 * to.
+	 *
+	 * Exactly one of these must be non-NULL; this specifies the object
+	 * order used to interpret this bitmap.
+	 */
 	struct packed_git *pack;
+	struct multi_pack_index *midx;
 
 	/*
 	 * Mark the first `reuse_objects` in the packfile as reused:
@@ -71,6 +79,9 @@ struct bitmap_index {
 	/* If not NULL, this is a name-hash cache pointing into map. */
 	uint32_t *hashes;
 
+	/* The checksum of the packfile or MIDX; points into map. */
+	const unsigned char *checksum;
+
 	/*
 	 * Extended index.
 	 *
@@ -138,6 +149,8 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 
 static uint32_t bitmap_num_objects(struct bitmap_index *index)
 {
+	if (index->midx)
+		return index->midx->num_objects;
 	return index->pack->num_objects;
 }
 
@@ -175,6 +188,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
+	index->checksum = header->checksum;
 	index->map_pos += header_size;
 	return 0;
 }
@@ -227,6 +241,8 @@ static int nth_bitmap_object_oid(struct bitmap_index *index,
 				 struct object_id *oid,
 				 uint32_t n)
 {
+	if (index->midx)
+		return nth_midxed_object_oid(oid, index->midx, n) ? 0 : -1;
 	return nth_packed_object_id(oid, index->pack, n);
 }
 
@@ -274,7 +290,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 	return 0;
 }
 
-static char *pack_bitmap_filename(struct packed_git *p)
+char *midx_bitmap_filename(struct multi_pack_index *midx)
+{
+	return xstrfmt("%s-%s.bitmap",
+		       get_midx_filename(midx->object_dir),
+		       hash_to_hex(get_midx_checksum(midx)));
+}
+
+char *pack_bitmap_filename(struct packed_git *p)
 {
 	size_t len;
 
@@ -283,6 +306,57 @@ static char *pack_bitmap_filename(struct packed_git *p)
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
+static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
+			      struct multi_pack_index *midx)
+{
+	struct stat st;
+	char *idx_name = midx_bitmap_filename(midx);
+	int fd = git_open(idx_name);
+
+	free(idx_name);
+
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, &st)) {
+		close(fd);
+		return -1;
+	}
+
+	if (bitmap_git->pack || bitmap_git->midx) {
+		/* ignore extra bitmap file; we can only handle one */
+		warning("ignoring extra bitmap file: %s",
+			get_midx_filename(midx->object_dir));
+		close(fd);
+		return -1;
+	}
+
+	bitmap_git->midx = midx;
+	bitmap_git->map_size = xsize_t(st.st_size);
+	bitmap_git->map_pos = 0;
+	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ,
+				MAP_PRIVATE, fd, 0);
+	close(fd);
+
+	if (load_bitmap_header(bitmap_git) < 0)
+		goto cleanup;
+
+	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum))
+		goto cleanup;
+
+	if (load_midx_revindex(bitmap_git->midx) < 0) {
+		warning(_("multi-pack bitmap is missing required reverse index"));
+		goto cleanup;
+	}
+	return 0;
+
+cleanup:
+	munmap(bitmap_git->map, bitmap_git->map_size);
+	bitmap_git->map_size = 0;
+	bitmap_git->map = NULL;
+	return -1;
+}
+
 static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
 {
 	int fd;
@@ -304,7 +378,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
-	if (bitmap_git->pack) {
+	if (bitmap_git->pack || bitmap_git->midx) {
+		/* ignore extra bitmap file; we can only handle one */
 		warning("ignoring extra bitmap file: %s", packfile->pack_name);
 		close(fd);
 		return -1;
@@ -331,13 +406,39 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	return 0;
 }
 
-static int load_pack_bitmap(struct bitmap_index *bitmap_git)
+static int load_reverse_index(struct bitmap_index *bitmap_git)
+{
+	if (bitmap_is_midx(bitmap_git)) {
+		uint32_t i;
+		int ret;
+
+		/*
+		 * The multi-pack-index's .rev file is already loaded via
+		 * open_pack_bitmap_1().
+		 *
+		 * But we still need to open the individual pack .rev files,
+		 * since we will need to make use of them in pack-objects.
+		 */
+		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
+				die(_("load_reverse_index: could not open pack"));
+			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
+			if (ret)
+				return ret;
+		}
+		return 0;
+	}
+	return load_pack_revindex(bitmap_git->pack);
+}
+
+static int load_bitmap(struct bitmap_index *bitmap_git)
 {
 	assert(bitmap_git->map);
 
 	bitmap_git->bitmaps = kh_init_oid_map();
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
-	if (load_pack_revindex(bitmap_git->pack))
+
+	if (load_reverse_index(bitmap_git))
 		goto failed;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
@@ -381,11 +482,47 @@ static int open_pack_bitmap(struct repository *r,
 	return ret;
 }
 
+static int open_midx_bitmap(struct repository *r,
+			    struct bitmap_index *bitmap_git)
+{
+	struct multi_pack_index *midx;
+
+	assert(!bitmap_git->map);
+
+	for (midx = get_multi_pack_index(r); midx; midx = midx->next) {
+		if (!open_midx_bitmap_1(bitmap_git, midx))
+			return 0;
+	}
+	return -1;
+}
+
+static int open_bitmap(struct repository *r,
+		       struct bitmap_index *bitmap_git)
+{
+	assert(!bitmap_git->map);
+
+	if (!open_midx_bitmap(r, bitmap_git))
+		return 0;
+	return open_pack_bitmap(r, bitmap_git);
+}
+
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_pack_bitmap(r, bitmap_git) && !load_pack_bitmap(bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
+		return bitmap_git;
+
+	free_bitmap_index(bitmap_git);
+	return NULL;
+}
+
+struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
+					     struct multi_pack_index *midx)
+{
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+
+	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -435,10 +572,26 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 	return pos;
 }
 
+static int bitmap_position_midx(struct bitmap_index *bitmap_git,
+				const struct object_id *oid)
+{
+	uint32_t want, got;
+	if (!bsearch_midx(oid, bitmap_git->midx, &want))
+		return -1;
+
+	if (midx_to_pack_pos(bitmap_git->midx, want, &got) < 0)
+		return -1;
+	return got;
+}
+
 static int bitmap_position(struct bitmap_index *bitmap_git,
 			   const struct object_id *oid)
 {
-	int pos = bitmap_position_packfile(bitmap_git, oid);
+	int pos;
+	if (bitmap_is_midx(bitmap_git))
+		pos = bitmap_position_midx(bitmap_git, oid);
+	else
+		pos = bitmap_position_packfile(bitmap_git, oid);
 	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, oid);
 }
 
@@ -749,6 +902,7 @@ static void show_objects_for_type(
 			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			struct packed_git *pack;
 			struct object_id oid;
 			uint32_t hash = 0, index_pos;
 			off_t ofs;
@@ -758,14 +912,28 @@ static void show_objects_for_type(
 
 			offset += ewah_bit_ctz64(word >> offset);
 
-			index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
-			ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-			nth_packed_object_id(&oid, bitmap_git->pack, index_pos);
+			if (bitmap_is_midx(bitmap_git)) {
+				struct multi_pack_index *m = bitmap_git->midx;
+				uint32_t pack_id;
+
+				index_pos = pack_pos_to_midx(m, pos + offset);
+				ofs = nth_midxed_offset(m, index_pos);
+				nth_midxed_object_oid(&oid, m, index_pos);
+
+				pack_id = nth_midxed_pack_int_id(m, index_pos);
+				pack = bitmap_git->midx->packs[pack_id];
+			} else {
+				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
+				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
+				nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
+
+				pack = bitmap_git->pack;
+			}
 
 			if (bitmap_git->hashes)
 				hash = get_be32(bitmap_git->hashes + index_pos);
 
-			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
+			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
 }
@@ -777,8 +945,13 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
-			return 1;
+		if (bitmap_is_midx(bitmap_git)) {
+			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
+				return 1;
+		} else {
+			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
+				return 1;
+		}
 	}
 
 	return 0;
@@ -865,14 +1038,26 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
 static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 				     uint32_t pos)
 {
-	struct packed_git *pack = bitmap_git->pack;
 	unsigned long size;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = &size;
 
 	if (pos < bitmap_num_objects(bitmap_git)) {
-		off_t ofs = pack_pos_to_offset(pack, pos);
+		struct packed_git *pack;
+		off_t ofs;
+
+		if (bitmap_is_midx(bitmap_git)) {
+			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
+			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
+
+			pack = bitmap_git->midx->packs[pack_id];
+			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
+		} else {
+			pack = bitmap_git->pack;
+			ofs = pack_pos_to_offset(pack, pos);
+		}
+
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
 			nth_bitmap_object_oid(bitmap_git, &oid,
@@ -1053,7 +1238,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
 	CALLOC_ARRAY(bitmap_git, 1);
-	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
+	if (open_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
@@ -1097,7 +1282,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_pack_bitmap(bitmap_git) < 0)
+	if (load_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
@@ -1145,19 +1330,43 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
  * reused, but you can keep feeding bits.
  */
 static int try_partial_reuse(struct bitmap_index *bitmap_git,
+			     struct packed_git *pack,
 			     size_t pos,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
 {
-	off_t offset, header;
+	off_t offset, delta_obj_offset;
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_num_objects(bitmap_git))
-		return -1; /* not actually in the pack or MIDX */
+	/*
+	 * try_partial_reuse() is called either on (a) objects in the
+	 * bitmapped pack (in the case of a single-pack bitmap) or (b)
+	 * objects in the preferred pack of a multi-pack bitmap.
+	 * Importantly, the latter can pretend as if only a single pack
+	 * exists because:
+	 *
+	 *   - The first pack->num_objects bits of a MIDX bitmap are
+	 *     reserved for the preferred pack, and
+	 *
+	 *   - Ties due to duplicate objects are always resolved in
+	 *     favor of the preferred pack.
+	 *
+	 * Therefore we do not need to ever ask the MIDX for its copy of
+	 * an object by OID, since it will always select it from the
+	 * preferred pack. Likewise, the selected copy of the base
+	 * object for any deltas will reside in the same pack.
+	 *
+	 * This means that we can reuse pos when looking up the bit in
+	 * the reuse bitmap, too, since bits corresponding to the
+	 * preferred pack precede all bits from other packs.
+	 */
 
-	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
-	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
+	if (pos >= pack->num_objects)
+		return -1; /* not actually in the pack or MIDX preferred pack */
+
+	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
+	type = unpack_object_header(pack, w_curs, &offset, &size);
 	if (type < 0)
 		return -1; /* broken packfile, punt */
 
@@ -1173,11 +1382,11 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * and the normal slow path will complain about it in
 		 * more detail.
 		 */
-		base_offset = get_delta_base(bitmap_git->pack, w_curs,
-					     &offset, type, header);
+		base_offset = get_delta_base(pack, w_curs, &offset, type,
+					     delta_obj_offset);
 		if (!base_offset)
 			return 0;
-		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
+		if (offset_to_pack_pos(pack, base_offset, &base_pos) < 0)
 			return 0;
 
 		/*
@@ -1211,24 +1420,48 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
+static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
+{
+	struct multi_pack_index *m = bitmap_git->midx;
+	if (!m)
+		BUG("midx_preferred_pack: requires non-empty MIDX");
+	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
+}
+
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				       struct packed_git **packfile_out,
 				       uint32_t *entries,
 				       struct bitmap **reuse_out)
 {
+	struct packed_git *pack;
 	struct bitmap *result = bitmap_git->result;
 	struct bitmap *reuse;
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
-	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
+	uint32_t objects_nr;
 
 	assert(result);
 
+	load_reverse_index(bitmap_git);
+
+	if (bitmap_is_midx(bitmap_git))
+		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
+	else
+		pack = bitmap_git->pack;
+	objects_nr = pack->num_objects;
+
 	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
 		i++;
 
-	/* Don't mark objects not in the packfile */
+	/*
+	 * Don't mark objects not in the packfile or preferred pack. This bitmap
+	 * marks objects eligible for reuse, but the pack-reuse code only
+	 * understands how to reuse a single pack. Since the preferred pack is
+	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
+	 * we use it instead of another pack. In single-pack bitmaps, the choice
+	 * is made for us.
+	 */
 	if (i > objects_nr / BITS_IN_EWORD)
 		i = objects_nr / BITS_IN_EWORD;
 
@@ -1244,8 +1477,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			if (try_partial_reuse(bitmap_git, pos + offset, reuse,
-					      &w_curs) < 0) {
+			if (try_partial_reuse(bitmap_git, pack, pos + offset,
+					      reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
@@ -1274,7 +1507,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = bitmap_git->pack;
+	*packfile_out = pack;
 	*reuse_out = reuse;
 	return 0;
 }
@@ -1548,6 +1781,12 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
+	if (!bitmap_is_midx(bitmap_git))
+		load_reverse_index(bitmap_git);
+	else if (load_midx_revindex(bitmap_git->midx) < 0)
+		BUG("rebuild_existing_bitmaps: missing required rev-cache "
+		    "extension");
+
 	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
@@ -1555,8 +1794,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 		struct object_id oid;
 		struct object_entry *oe;
 
-		nth_packed_object_id(&oid, bitmap_git->pack,
-				     pack_pos_to_index(bitmap_git->pack, i));
+		if (bitmap_is_midx(bitmap_git))
+			nth_midxed_object_oid(&oid,
+					      bitmap_git->midx,
+					      pack_pos_to_midx(bitmap_git->midx, i));
+		else
+			nth_packed_object_id(&oid, bitmap_git->pack,
+					     pack_pos_to_index(bitmap_git->pack, i));
 		oe = packlist_find(mapping, &oid);
 
 		if (oe)
@@ -1582,6 +1826,19 @@ void free_bitmap_index(struct bitmap_index *b)
 	free(b->ext_index.hashes);
 	bitmap_free(b->result);
 	bitmap_free(b->haves);
+	if (bitmap_is_midx(b)) {
+		/*
+		 * Multi-pack bitmaps need to have resources associated with
+		 * their on-disk reverse indexes unmapped so that stale .rev and
+		 * .bitmap files can be removed.
+		 *
+		 * Unlike pack-based bitmaps, multi-pack bitmaps can be read and
+		 * written in the same 'git multi-pack-index write --bitmap'
+		 * process. Close resources so they can be removed safely on
+		 * platforms like Windows.
+		 */
+		close_midx_revindex(b->midx);
+	}
 	free(b);
 }
 
@@ -1596,7 +1853,6 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				     enum object_type object_type)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
 	off_t total = 0;
 	struct ewah_iterator it;
 	eword_t filter;
@@ -1613,15 +1869,35 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
-			size_t pos;
-
 			if ((word >> offset) == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			pos = base + offset;
-			total += pack_pos_to_offset(pack, pos + 1) -
-				 pack_pos_to_offset(pack, pos);
+
+			if (bitmap_is_midx(bitmap_git)) {
+				uint32_t pack_pos;
+				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
+				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
+
+				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
+				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+
+				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
+					struct object_id oid;
+					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
+
+					die(_("could not find %s in pack %s at offset %"PRIuMAX),
+					    oid_to_hex(&oid),
+					    pack->pack_name,
+					    (uintmax_t)offset);
+				}
+
+				total += pack_pos_to_offset(pack, pack_pos + 1) - offset;
+			} else {
+				size_t pos = base + offset;
+				total += pack_pos_to_offset(bitmap_git->pack, pos + 1) -
+					 pack_pos_to_offset(bitmap_git->pack, pos);
+			}
 		}
 	}
 
@@ -1672,6 +1948,11 @@ off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
 	return total;
 }
 
+int bitmap_is_midx(struct bitmap_index *bitmap_git)
+{
+	return !!bitmap_git->midx;
+}
+
 const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 52ea10de51..81664f933f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,6 +44,8 @@ typedef int (*show_reachable_fn)(
 struct bitmap_index;
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
+struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
+					     struct multi_pack_index *midx);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(struct bitmap_index *,
@@ -92,6 +94,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
+char *midx_bitmap_filename(struct multi_pack_index *midx);
+char *pack_bitmap_filename(struct packed_git *p);
+
+int bitmap_is_midx(struct bitmap_index *bitmap_git);
 
 const struct string_list *bitmap_preferred_tips(struct repository *r);
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
diff --git a/packfile.c b/packfile.c
index 9ef6d98292..371f5488cf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -860,7 +860,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	if (!strcmp(file_name, "multi-pack-index"))
 		return;
 	if (starts_with(file_name, "multi-pack-index") &&
-	    ends_with(file_name, ".rev"))
+	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
 		return;
 	if (ends_with(file_name, ".idx") ||
 	    ends_with(file_name, ".rev") ||
-- 
2.33.0.96.g73915697e6

