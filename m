Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B89C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F8F610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhDISMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbhDISMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:12:00 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5799C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:47 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b17so5455747ilh.6
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T54RqKagbgC8VyzwQE2celhWYWYnr72WXfewtIcTOtA=;
        b=KCAKb3v+m0yZaAV84uJntF2HobCy/m4G2cLCZH08IFBwG803hhFqp5rHIInmc+qDe0
         3SqtCiM9cx9PQFN9ah0CljVr3RYOqPyAdZ5+8uWeHWS33bvhXqeVVuiUHDQj/4vHZtSI
         o1T+8J5VnQO8rnd3B+psix0NmZSMqn3RLwNElCaBQ90zQDXe2gnblXrlqYeelxibW/ec
         6hnGZ0xSRaloOWAcxhR3K4q0JPy9oWp0uiMDRBL1bD5ACaT4/Pp8g3TIbBYcucDVfB9T
         jc6YWuk1ROXnRfU8VV4COxvXmsonn8srhsoiAmVW1qiyqPwQNrdPDm7knn/7DH+VOxjp
         D+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T54RqKagbgC8VyzwQE2celhWYWYnr72WXfewtIcTOtA=;
        b=N5y4vGunRUMAMgF8yv4qAM2qKa52z62Jrbpi2C4m9pSWRJ0Z+b5AG/B+au038Z2z4+
         RlVBflCfWNcZJg6Gj660sGSdF+zAIFA/JBM0avfb/6Fc8W8n4cSVCBN/fTLSVfg1wz8+
         wyToCl7F2MWvD+q6sEEfA9gnosXU7gPyy5IOPTVr/KOCM0rsSpABlkPtx/tF/KtpOHQG
         ryl71KajQzBkCYSb621bVLJTGz6u0Bc831NNsGery32+yXJhh6I7cqM8meOXp6N/yMuC
         KWR2ty5h7squMoXfSIl8Cb7WcKoXck+nOz4cdnTa2ze9w5YT4LkFXRLhHEwA+fyYjsfM
         IRxA==
X-Gm-Message-State: AOAM530XvZomNgYj7/s7p6tydJo9kD7D6SZLzWM7NCtgoeq8RPhHx140
        JMrHMOEQLtr7uqTHFVt+6rFogmKmh/k6E4P2
X-Google-Smtp-Source: ABdhPJxT47PsRoTORZLKswcWstr8/NeUCqDsfq9rhhywqrD99Tx9gpohdHmQzE+EqVWrXVLKqjYBpQ==
X-Received: by 2002:a92:ad07:: with SMTP id w7mr10826716ilh.98.1617991906629;
        Fri, 09 Apr 2021 11:11:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id h2sm1552969ioj.30.2021.04.09.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:46 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 12/22] pack-bitmap: read multi-pack bitmaps
Message-ID: <d5eeca4f112f70343b069fcb68fe61e26831843f.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This prepares the code in pack-bitmap to interpret the new multi-pack
bitmaps described in Documentation/technical/bitmap-format.txt, which
mostly involves converting bit positions to accommodate looking them up
in a MIDX.

Note that there are currently no writers who write multi-pack bitmaps,
and that this will be implemented in the subsequent commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  12 +-
 pack-bitmap-write.c    |   2 +-
 pack-bitmap.c          | 349 +++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h          |   5 +
 packfile.c             |   2 +-
 5 files changed, 338 insertions(+), 32 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5205dde2e1..a4e4e4ebcc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -984,7 +984,17 @@ static void write_reused_pack(struct hashfile *f)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			write_reused_pack_one(pos + offset, f, &w_curs);
+			if (bitmap_is_midx(bitmap_git)) {
+				off_t pack_offs = bitmap_pack_offset(bitmap_git,
+								     pos + offset);
+				uint32_t pos;
+
+				if (offset_to_pack_pos(reuse_packfile, pack_offs, &pos) < 0)
+					die(_("write_reused_pack: could not locate %"PRIdMAX),
+					    (intmax_t)pack_offs);
+				write_reused_pack_one(pos, f, &w_curs);
+			} else
+				write_reused_pack_one(pos + offset, f, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f90e100e3e..020c1774c8 100644
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
index be52570b0f..e41fce9675 100644
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
@@ -71,6 +79,8 @@ struct bitmap_index {
 	/* If not NULL, this is a name-hash cache pointing into map. */
 	uint32_t *hashes;
 
+	const unsigned char *checksum;
+
 	/*
 	 * Extended index.
 	 *
@@ -138,6 +148,8 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 
 static uint32_t bitmap_num_objects(struct bitmap_index *index)
 {
+	if (index->midx)
+		return index->midx->num_objects;
 	return index->pack->num_objects;
 }
 
@@ -175,6 +187,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	}
 
 	index->entry_count = ntohl(header->entry_count);
+	index->checksum = header->checksum;
 	index->map_pos += header_size;
 	return 0;
 }
@@ -227,7 +240,10 @@ static void nth_bitmap_object_oid(struct bitmap_index *index,
 				  struct object_id *oid,
 				  uint32_t n)
 {
-	nth_packed_object_id(oid, index->pack, n);
+	if (index->midx)
+		nth_midxed_object_oid(oid, index->midx, n);
+	else
+		nth_packed_object_id(oid, index->pack, n);
 }
 
 static int load_bitmap_entries_v1(struct bitmap_index *index)
@@ -272,7 +288,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
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
 
@@ -281,6 +304,54 @@ static char *pack_bitmap_filename(struct packed_git *p)
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
@@ -302,12 +373,18 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
-	if (bitmap_git->pack) {
+	if (bitmap_git->pack || bitmap_git->midx) {
+		/* ignore extra bitmap file; we can only handle one */
 		warning("ignoring extra bitmap file: %s", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
 
+	if (!is_pack_valid(packfile)) {
+		close(fd);
+		return -1;
+	}
+
 	bitmap_git->pack = packfile;
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -324,13 +401,36 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	return 0;
 }
 
-static int load_pack_bitmap(struct bitmap_index *bitmap_git)
+static int load_reverse_index(struct bitmap_index *bitmap_git)
+{
+	if (bitmap_is_midx(bitmap_git)) {
+		uint32_t i;
+		int ret;
+
+		ret = load_midx_revindex(bitmap_git->midx);
+		if (ret)
+			return ret;
+
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
@@ -374,11 +474,35 @@ static int open_pack_bitmap(struct repository *r,
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
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -428,10 +552,26 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
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
 
@@ -721,6 +861,7 @@ static void show_objects_for_type(
 			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			struct packed_git *pack;
 			struct object_id oid;
 			uint32_t hash = 0, index_pos;
 			off_t ofs;
@@ -730,14 +871,28 @@ static void show_objects_for_type(
 
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
@@ -749,8 +904,13 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
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
@@ -839,14 +999,26 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
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
@@ -990,7 +1162,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
 	CALLOC_ARRAY(bitmap_git, 1);
-	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
+	if (open_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
@@ -1034,7 +1206,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_pack_bitmap(bitmap_git) < 0)
+	if (load_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
@@ -1081,15 +1253,29 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 			      struct bitmap *reuse,
 			      struct pack_window **w_curs)
 {
-	off_t offset, header;
+	struct packed_git *pack;
+	off_t offset, delta_obj_offset;
 	enum object_type type;
 	unsigned long size;
 
 	if (pos >= bitmap_num_objects(bitmap_git))
 		return; /* not actually in the pack or MIDX */
 
-	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
-	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
+	if (bitmap_is_midx(bitmap_git)) {
+		uint32_t pack_id, midx_pos;
+
+		midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
+		pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
+
+		pack = bitmap_git->midx->packs[pack_id];
+		offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
+	} else {
+		pack = bitmap_git->pack;
+		offset = pack_pos_to_offset(bitmap_git->pack, pos);
+	}
+
+	delta_obj_offset = offset;
+	type = unpack_object_header(pack, w_curs, &offset, &size);
 	if (type < 0)
 		return; /* broken packfile, punt */
 
@@ -1105,11 +1291,11 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * and the normal slow path will complain about it in
 		 * more detail.
 		 */
-		base_offset = get_delta_base(bitmap_git->pack, w_curs,
-					     &offset, type, header);
+		base_offset = get_delta_base(pack, w_curs, &offset, type,
+					     delta_obj_offset);
 		if (!base_offset)
 			return;
-		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
+		if (offset_to_pack_pos(pack, base_offset, &base_pos) < 0)
 			return;
 
 		/*
@@ -1120,6 +1306,16 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * packs we write fresh, and OFS_DELTA is the default). But
 		 * let's double check to make sure the pack wasn't written with
 		 * odd parameters.
+		 *
+		 * Note that the base does not need to be repositioned, i.e.,
+		 * the MIDX is guaranteed to have selected the copy of "base"
+		 * from the same pack, since this function is only ever called
+		 * on the preferred pack (and all duplicate objects are resolved
+		 * in favor of the preferred pack).
+		 *
+		 * This means that we can reuse base_pos when looking up the bit
+		 * in the reuse bitmap, too, since bits corresponding to the
+		 * preferred pack precede all bits from other packs.
 		 */
 		if (base_pos >= pos)
 			return;
@@ -1142,6 +1338,14 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	bitmap_set(reuse, pos);
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
@@ -1153,13 +1357,29 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	size_t i = 0;
 	uint32_t offset;
 	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
+	uint32_t preferred_pack = 0;
 
 	assert(result);
 
+	load_reverse_index(bitmap_git);
+
+	if (bitmap_is_midx(bitmap_git)) {
+		preferred_pack = midx_preferred_pack(bitmap_git);
+		objects_nr = bitmap_git->midx->packs[preferred_pack]->num_objects;
+	} else
+		objects_nr = bitmap_git->pack->num_objects;
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
 
@@ -1175,6 +1395,14 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
+			if (bitmap_is_midx(bitmap_git)) {
+				/*
+				 * Can't reuse from a non-preferred pack (see
+				 * above).
+				 */
+				if (pos + offset >= objects_nr)
+					continue;
+			}
 			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
 		}
 	}
@@ -1192,7 +1420,9 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = bitmap_git->pack;
+	*packfile_out = bitmap_git->pack ?
+		bitmap_git->pack :
+		bitmap_git->midx->packs[preferred_pack];
 	*reuse_out = reuse;
 	return 0;
 }
@@ -1466,6 +1696,12 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
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
 
@@ -1473,8 +1709,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
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
@@ -1500,6 +1741,19 @@ void free_bitmap_index(struct bitmap_index *b)
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
 
@@ -1514,7 +1768,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				     enum object_type object_type)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
+	struct packed_git *pack;
 	off_t total = 0;
 	struct ewah_iterator it;
 	eword_t filter;
@@ -1538,6 +1792,29 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 
 			offset += ewah_bit_ctz64(word >> offset);
 			pos = base + offset;
+
+			if (bitmap_is_midx(bitmap_git)) {
+				uint32_t pack_pos;
+				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
+				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
+				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
+
+				pack = bitmap_git->midx->packs[pack_id];
+
+				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
+					struct object_id oid;
+					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
+
+					die(_("could not find %s in pack #%"PRIu32" at offset %"PRIuMAX),
+					    oid_to_hex(&oid),
+					    pack_id,
+					    (uintmax_t)offset);
+				}
+
+				pos = pack_pos;
+			} else
+				pack = bitmap_git->pack;
+
 			total += pack_pos_to_offset(pack, pos + 1) -
 				 pack_pos_to_offset(pack, pos);
 		}
@@ -1590,6 +1867,20 @@ off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
 	return total;
 }
 
+int bitmap_is_midx(struct bitmap_index *bitmap_git)
+{
+	return !!bitmap_git->midx;
+}
+
+off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos)
+{
+	if (bitmap_is_midx(bitmap_git))
+		return nth_midxed_offset(bitmap_git->midx,
+					 pack_pos_to_midx(bitmap_git->midx, pos));
+	return nth_packed_object_offset(bitmap_git->pack,
+					pack_pos_to_index(bitmap_git->pack, pos));
+}
+
 const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
 	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 0bf75ff2a7..0dc6f7a7e4 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -91,6 +91,11 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
+char *midx_bitmap_filename(struct multi_pack_index *midx);
+char *pack_bitmap_filename(struct packed_git *p);
+
+int bitmap_is_midx(struct bitmap_index *bitmap_git);
+off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos);
 
 const struct string_list *bitmap_preferred_tips(struct repository *r);
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
diff --git a/packfile.c b/packfile.c
index 8668345d93..c444e365a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -863,7 +863,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	if (!strcmp(file_name, "multi-pack-index"))
 		return;
 	if (starts_with(file_name, "multi-pack-index") &&
-	    ends_with(file_name, ".rev"))
+	    (ends_with(file_name, ".bitmap") || ends_with(file_name, ".rev")))
 		return;
 	if (ends_with(file_name, ".idx") ||
 	    ends_with(file_name, ".rev") ||
-- 
2.31.1.163.ga65ce7f831

