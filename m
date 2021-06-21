Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB5C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C37560FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFUW1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFUW1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C2C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h2so5930719iob.11
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OG1X0+UmaoWYYtrYOOtZ4vQY9d5o/MVCkebNzcSIOO8=;
        b=PPs6LJoyJUIaY4QxopeQkZTOKnUboR4mKz6qwXn4MYeL+MgPG0dvGVE1SW2jptkF9P
         hwS4xrefq7Db3WyAXb0egSo8xLgiXLzMNacQMFWbY7XokM0He4HgTw/QFRzBHmpVmLjD
         +7mUYlBErZro/BVB19Sbmm57ubFw9mw5FEZWBLsx9EXyvMNZBd7fr94OyAcYDAsFCVy3
         aGApCdVFohxBYJQLyUzKNGs86O/vdqBKSoHcBk1RUP86jxhv/0/aLekmqvwVwrKZOB2h
         OT2QXayqYj6VN5ArJsGwqwE93u7eIDC2w93yl1jycFA6o3Rvc3lvviuUIVYBCrCCekom
         SfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OG1X0+UmaoWYYtrYOOtZ4vQY9d5o/MVCkebNzcSIOO8=;
        b=kRx4ONZ5Wvf7tkra/rU/8O6kqpHi7aaQ/YTUv8PLEs2snUjKiZGCODECQxSDhPc/YM
         znXUxXrMI9AF9chMcDVlvVRkcRaW0sBvaeZtkkc9bvOL+WSE0OEnPEMw1mqk6OwHJU9s
         DH35fizkQqCkDi0sK47cpDaHy16Ta5qYszBoAplgX+TVgCXJ/UbQ75/7xLTUvNuzREPU
         WXfCFwOC9BPMHFFNtRFA3awi+7hcF/Vdsc4drCOuNIxOcknw6VVclOmnU1NsDxiCpG/a
         jli3NxPGhmyU2ZI2Agyow9+8+qn2MM87FkZBgaIPmwTGjJ7Fp+w2oE1p4Uwn5ZAh7YxD
         U/5Q==
X-Gm-Message-State: AOAM530yD3zSrCo5lm9f+ObXnxZ5YQv9wht6WF+xPNkY8/GhFcO/c6fg
        3R3OBRrARbzubrpnFfLGmAj8UZbrWFa+4BAw
X-Google-Smtp-Source: ABdhPJzf4/fo2T96r/cmpMdm/KniDnrk2MqpVd5nRSdIiFQ//qAjDraXG1LL8qlvf1CuXoKVObiO2w==
X-Received: by 2002:a6b:7009:: with SMTP id l9mr251012ioc.82.1624314333092;
        Mon, 21 Jun 2021 15:25:33 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id g8sm4493692iop.31.2021.06.21.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:32 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
 builtin/pack-objects.c |   5 +
 pack-bitmap-write.c    |   2 +-
 pack-bitmap.c          | 362 +++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h          |   5 +
 packfile.c             |   2 +-
 5 files changed, 340 insertions(+), 36 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8a523624a1..e11d3ac2e5 100644
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
index d882bf7ce1..4110d23ca1 100644
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
@@ -227,7 +241,10 @@ static void nth_bitmap_object_oid(struct bitmap_index *index,
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
@@ -272,7 +289,14 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
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
 
@@ -281,6 +305,57 @@ static char *pack_bitmap_filename(struct packed_git *p)
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
@@ -302,12 +377,18 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
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
@@ -324,13 +405,36 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
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
@@ -374,11 +478,35 @@ static int open_pack_bitmap(struct repository *r,
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
@@ -428,10 +556,26 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
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
 
@@ -724,6 +868,7 @@ static void show_objects_for_type(
 			continue;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
+			struct packed_git *pack;
 			struct object_id oid;
 			uint32_t hash = 0, index_pos;
 			off_t ofs;
@@ -733,14 +878,28 @@ static void show_objects_for_type(
 
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
@@ -752,8 +911,13 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
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
@@ -839,14 +1003,26 @@ static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
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
@@ -1027,7 +1203,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
 	CALLOC_ARRAY(bitmap_git, 1);
-	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
+	if (open_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	for (i = 0; i < revs->pending.nr; ++i) {
@@ -1071,7 +1247,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_pack_bitmap(bitmap_git) < 0)
+	if (load_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
@@ -1115,19 +1291,43 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 }
 
 static void try_partial_reuse(struct bitmap_index *bitmap_git,
+			      struct packed_git *pack,
 			      size_t pos,
 			      struct bitmap *reuse,
 			      struct pack_window **w_curs)
 {
-	off_t offset, header;
+	off_t offset, delta_obj_offset;
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_num_objects(bitmap_git))
-		return; /* not actually in the pack or MIDX */
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
+		return; /* not actually in the pack or MIDX preferred pack */
+
+	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
+	type = unpack_object_header(pack, w_curs, &offset, &size);
 	if (type < 0)
 		return; /* broken packfile, punt */
 
@@ -1143,11 +1343,11 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
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
@@ -1180,24 +1380,48 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
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
 
@@ -1213,7 +1437,15 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
+			if (bitmap_is_midx(bitmap_git)) {
+				/*
+				 * Can't reuse from a non-preferred pack (see
+				 * above).
+				 */
+				if (pos + offset >= objects_nr)
+					continue;
+			}
+			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
 		}
 	}
 
@@ -1230,7 +1462,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = bitmap_git->pack;
+	*packfile_out = pack;
 	*reuse_out = reuse;
 	return 0;
 }
@@ -1504,6 +1736,12 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
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
 
@@ -1511,8 +1749,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
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
@@ -1538,6 +1781,19 @@ void free_bitmap_index(struct bitmap_index *b)
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
 
@@ -1552,7 +1808,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				     enum object_type object_type)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
+	struct packed_git *pack;
 	off_t total = 0;
 	struct ewah_iterator it;
 	eword_t filter;
@@ -1575,7 +1831,31 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			pos = base + offset;
+
+			if (bitmap_is_midx(bitmap_git)) {
+				uint32_t pack_pos;
+				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
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
+			} else {
+				pack = bitmap_git->pack;
+				pos = base + offset;
+			}
+
 			total += pack_pos_to_offset(pack, pos + 1) -
 				 pack_pos_to_offset(pack, pos);
 		}
@@ -1628,6 +1908,20 @@ off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
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
index 52ea10de51..30396a7a4a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -92,6 +92,11 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
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
index 755aa7aec5..e855b93208 100644
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
2.31.1.163.ga65ce7f831

