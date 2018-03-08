Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3551FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935797AbeCHLms (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:42:48 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34597 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935789AbeCHLmr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:42:47 -0500
Received: by mail-pg0-f46.google.com with SMTP id m19so2115742pgn.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwnpWRnvInAdMDXMIA7+upyBurtx4/SqUuBtHR8gCvg=;
        b=P1+xLqHIiT22Ny1vs6VSRsxLllXPERH0rCxZIN8mb3HUSaHknNf6/N7MAcvubG2p7v
         q0yN/chQx6dklvNuz9yuyhYsmKN6rBdphoxydAeDwEcEJM5orjZ0c/qx6VuwHrRR/RY0
         glTfKPthiGnPlj0H0x3rvx0zN+OVaa5/EM3s1cT8QqIXCWiFHpOlYlH/pFwAJkN7CWzH
         Vv7/wvwPuMN7Lof6R81lgZgZ4ihPXqWrttGkzNO/BG9UibpXL22Lcp4nrkK20/sHXrvq
         1hl9atAgWq48hYtM++59CcQmQakhGFIOs/MFvr1VOkiKuIfPSqeMeh8tC3Zi16yuHwh6
         H6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwnpWRnvInAdMDXMIA7+upyBurtx4/SqUuBtHR8gCvg=;
        b=S0WcwPa7HSZQEVzYiaTYu2v1JT6r3GzHBWltdb3VI2d5/X/jRMeEyfvSTiPGUSavMV
         oDH+f8TRSytDSs+mvLv/h5SvPE1Ptc8a2i80Jq32gAvSQb9v+b5CERIdOQBUG5lOLh4v
         tqGzv57m8rQk+aEcJqxBdSuVTCxh8Fkt2AjB8bJM83ixRJKEkCCe+s3W9mBeJUiaVgHC
         3SzKwRwQ8MpwAouDkh3WK6sfmBzHkDThxwvFNnIIjmCTan+LBlpBuZodx785hb+Heeds
         /KO4Akr9+mu9UOGep1Ct/MDJ6A/CtCtF+IZvBaeLSXg6DJzdyGg9lnLLs0RgxWnfDsg7
         i1Jg==
X-Gm-Message-State: APf1xPC5sU/x6+uutXb/aR5DJo7pXeJ2A5HLicpblCMKgu55qdc5dBrl
        nnCkOo5V4vi8jttcV+UHiPGBkw==
X-Google-Smtp-Source: AG47ELt4RWg5VQFf3g/emJxNccTCHXm+tB+H9WyMc4liaIPzHdAQfY8BwUpZr5rv1NlLkbJYm9wjAg==
X-Received: by 10.98.223.143 with SMTP id d15mr26188140pfl.208.1520509365627;
        Thu, 08 Mar 2018 03:42:45 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id a67sm33296979pgc.6.2018.03.08.03.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:42:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:42:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 00/12] Reduce pack-objects memory footprint
Date:   Thu,  8 Mar 2018 18:42:20 +0700
Message-Id: <20180308114232.10508-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180303024706.31465-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 cleans up a bit to avoid the horrible macros that v2 adds, and
adds some more documentation for this struct since it's getting harder
to just look at the struct and see what field is related to what.

v3 also adds three more patches and reduces another 16 bytes (total
struct reduction now is 41%). After this there's hardly anything else I
could do. Two 64-bit fields left, but even if I shrink them, I'd lose
it to padding. There's still one possibility to share in_pack_offset
with idx.offset, but it's risky.

These three patches are made to optimize for the common case. The
incommon cases will suffer some performance loss:

- 10/12 limits the cached compressed delta size to 64k (default 1000
  bytes). If you normally have lots of huge deltas, you're going to
  take a hit because more deltas must be recreated at writing phase.
  Note that it does not stop pack-objects from creating deltas larger
  than 64k.

- 11/12 reduces uncompressed object size to 4GB. Whenever we need to
  read object size of those larger than that, we read the pack again
  to retrieve the information, which is much slower than accessing a
  piece of memory. Again I'm assuming these giant blobs are really
  really rare that this performance hit won't matter.

- 12/12 is similar to 11/12 and reduces uncompressed delta size to
  4GB. Frankly a 4GB delta is still ridiculous, but I don't think we
  gain more by shrinking it further. If your packs have one of those
  giant deltas, it still works, delta_size will be read back from the
  pack again.

The following interdiff does _NOT_ cover the new patches, just the
first nine that v2 has.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 55f19a1f18..82a4a95888 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -29,19 +29,13 @@
 #include "list.h"
 #include "packfile.h"
 
-#define DELTA(obj) \
-	((obj)->delta_idx ? &to_pack.objects[(obj)->delta_idx - 1] : NULL)
-#define DELTA_CHILD(obj) \
-	((obj)->delta_child_idx ? &to_pack.objects[(obj)->delta_child_idx - 1] : NULL)
-#define DELTA_SIBLING(obj) \
-	((obj)->delta_sibling_idx ? &to_pack.objects[(obj)->delta_sibling_idx - 1] : NULL)
-
-#define CLEAR_DELTA(obj) (obj)->delta_idx = 0
-#define CLEAR_DELTA_CHILD(obj) (obj)->delta_child_idx = 0
-#define CLEAR_DELTA_SIBLING(obj) (obj)->delta_sibling_idx = 0
-
-#define SET_DELTA(obj, val) (obj)->delta_idx = ((val) - to_pack.objects) + 1
-#define SET_DELTA_CHILD(obj, val) (obj)->delta_child_idx = ((val) - to_pack.objects) + 1
+#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define DELTA(obj) oe_delta(&to_pack, obj)
+#define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
+#define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
+#define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
+#define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -381,7 +375,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 				unsigned long limit, int usable_delta)
 {
-	struct packed_git *p = IN_PACK(&to_pack, entry);
+	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
@@ -492,7 +486,7 @@ static off_t write_object(struct hashfile *f,
 
 	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
-	else if (!IN_PACK(&to_pack, entry))
+	else if (!IN_PACK(entry))
 		to_reuse = 0;	/* can't reuse what we don't have */
 	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
@@ -557,7 +551,7 @@ static enum write_one_status write_one(struct hashfile *f,
 		switch (write_one(f, DELTA(e), offset)) {
 		case WRITE_ONE_RECURSIVE:
 			/* we cannot depend on this one */
-			CLEAR_DELTA(e);
+			SET_DELTA(e, NULL);
 			break;
 		default:
 			break;
@@ -672,8 +666,8 @@ static struct object_entry **compute_write_order(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
 		objects[i].filled = 0;
-		CLEAR_DELTA_CHILD(&objects[i]);
-		CLEAR_DELTA_SIBLING(&objects[i]);
+		SET_DELTA_CHILD(&objects[i], NULL);
+		SET_DELTA_SIBLING(&objects[i], NULL);
 	}
 
 	/*
@@ -1067,19 +1061,8 @@ static int want_object_in_pack(const struct object_id *oid,
 
 	want = 1;
 done:
-	if (want && *found_pack && !(*found_pack)->index) {
-		struct packed_git *p = *found_pack;
-
-		if (to_pack.in_pack_count >= (1 << OE_IN_PACK_BITS))
-			die(_("too many packs to handle in one go. "
-			      "Please add .keep files to exclude\n"
-			      "some pack files and keep the number "
-			      "of non-kept files below %d."),
-			    1 << OE_IN_PACK_BITS);
-
-		p->index = to_pack.in_pack_count++;
-		to_pack.in_pack[p->index] = p;
-	}
+	if (want && *found_pack && !(*found_pack)->index)
+		oe_add_pack(&to_pack, *found_pack);
 
 	return want;
 }
@@ -1104,9 +1087,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		if (found_pack->index <= 0)
-			die("BUG: found_pack should be NULL instead of having non-positive index");
-		entry->in_pack_idx = found_pack->index;
+		oe_set_in_pack(entry, found_pack);
 		entry->in_pack_offset = found_offset;
 	}
 
@@ -1431,8 +1412,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
-	if (IN_PACK(&to_pack, entry)) {
-		struct packed_git *p = IN_PACK(&to_pack, entry);
+	if (IN_PACK(entry)) {
+		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
@@ -1567,8 +1548,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
-	const struct packed_git *a_in_pack = IN_PACK(&to_pack, a);
-	const struct packed_git *b_in_pack = IN_PACK(&to_pack, b);
+	const struct packed_git *a_in_pack = IN_PACK(a);
+	const struct packed_git *b_in_pack = IN_PACK(b);
 
 	/* avoid filesystem trashing with loose objects */
 	if (!a_in_pack && !b_in_pack)
@@ -1609,12 +1590,12 @@ static void drop_reused_delta(struct object_entry *entry)
 		else
 			idx = &oe->delta_sibling_idx;
 	}
-	CLEAR_DELTA(entry);
+	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
 	oi.typep = &type;
-	if (packed_object_info(IN_PACK(&to_pack, entry), entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
@@ -1884,8 +1865,8 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * it, we will still save the transfer cost, as we already know
 	 * the other side has it and we won't send src_entry at all.
 	 */
-	if (reuse_delta && IN_PACK(&to_pack, trg_entry) &&
-	    IN_PACK(&to_pack, trg_entry) == IN_PACK(&to_pack, src_entry) &&
+	if (reuse_delta && IN_PACK(trg_entry) &&
+	    IN_PACK(trg_entry) == IN_PACK(src_entry) &&
 	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
@@ -2994,16 +2975,6 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
-static void init_in_pack_mapping(struct packing_data *to_pack)
-{
-	/* let IN_PACK() return NULL if in_pack_idx is zero */
-	to_pack->in_pack[to_pack->in_pack_count++] = NULL;
-	/*
-	 * the rest is lazily initialized only for packs that we want
-	 * in want_object_in_pack().
-	 */
-}
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3236,7 +3207,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			}
 		}
 	}
-	init_in_pack_mapping(&to_pack);
+
+	/* make sure IN_PACK(0) return NULL */
+	oe_add_pack(&to_pack, NULL);
 
 	if (progress)
 		progress_state = start_progress(_("Counting objects"), 0);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1360a93311..256a63f892 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -64,7 +64,7 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 		struct object_entry *entry = (struct object_entry *)index[i];
 		enum object_type real_type;
 
-		IN_PACK_POS(to_pack, entry) = i;
+		oe_set_in_pack_pos(to_pack, entry, i);
 
 		switch (entry->type) {
 		case OBJ_COMMIT:
@@ -149,7 +149,7 @@ static uint32_t find_object_pos(const unsigned char *sha1)
 			"(object %s is missing)", sha1_to_hex(sha1));
 	}
 
-	return IN_PACK_POS(writer.to_pack, entry);
+	return oe_in_pack_pos(writer.to_pack, entry);
 }
 
 static void show_object(struct object *object, const char *name, void *data)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f21479fe16..865d9ecc4e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1032,7 +1032,7 @@ int rebuild_existing_bitmaps(struct packing_data *mapping,
 		oe = packlist_find(mapping, sha1, NULL);
 
 		if (oe)
-			reposition[i] = IN_PACK_POS(mapping, oe) + 1;
+			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
 	}
 
 	rebuild = bitmap_new();
diff --git a/pack-objects.h b/pack-objects.h
index a57aca5f03..3c15cf7b23 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,15 +1,9 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
-#define OE_DFS_STATE_BITS 2
-#define OE_DEPTH_BITS 12
-#define OE_IN_PACK_BITS 14
-
-#define IN_PACK_POS(to_pack, obj) \
-	(to_pack)->in_pack_pos[(struct object_entry *)(obj) - (to_pack)->objects]
-
-#define IN_PACK(to_pack, obj) \
-	(to_pack)->in_pack[(obj)->in_pack_idx]
+#define OE_DFS_STATE_BITS	2
+#define OE_DEPTH_BITS		12
+#define OE_IN_PACK_BITS		14
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -28,6 +22,51 @@ enum dfs_state {
  * The size of struct nearly determines pack-objects's memory
  * consumption. This struct is packed tight for that reason. When you
  * add or reorder something in this struct, think a bit about this.
+ *
+ * basic object info
+ * -----------------
+ * idx.oid is filled up before delta searching starts. idx.crc32 and
+ * is only valid after the object is written down and will be used for
+ * generating the index. idx.offset will be both gradually set and
+ * used in writing phase (base objects get offset first, then deltas
+ * refer to them)
+ *
+ * "size" is the uncompressed object size. Compressed size is not
+ * cached (ie. raw data in a pack) but available via revindex.
+ *
+ * "hash" contains a path name hash which is used for sorting the
+ * delta list and also during delta searching. Once prepare_pack()
+ * returns it's no longer needed.
+ *
+ * source pack info
+ * ----------------
+ * The (in_pack, in_pack_offset, in_pack_header_size) tuple contains
+ * the location of the object in the source pack, with or without
+ * header.
+ *
+ * "type" and "in_pack_type" both describe object type. in_pack_type
+ * may contain a delta type, while type is always the canonical type.
+ *
+ * deltas
+ * ------
+ * Delta links (delta, delta_child and delta_sibling) are created
+ * reflect that delta graph from the source pack then updated or added
+ * during delta searching phase when we find better deltas.
+ *
+ * delta_child and delta_sibling are last needed in
+ * compute_write_order(). "delta" and "delta_size" must remain valid
+ * at object writing phase in case the delta is not cached.
+ *
+ * If a delta is cached in memory and is compressed, "delta" points to
+ * the data and z_delta_size contains the compressed size. If it's
+ * uncompressed [1], z_delta_size must be zero. delta_size is always
+ * the uncompressed size and must be valid even if the delta is not
+ * cached. Delta recreation technically only depends on "delta"
+ * pointer, but delta_size is still used to verify it's the same as
+ * before.
+ *
+ * [1] during try_delta phase we don't bother with compressing because
+ * the delta could be quickly replaced with a better one.
  */
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -103,4 +142,109 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline unsigned int oe_in_pack_pos(const struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	return pack->in_pack_pos[e - pack->objects];
+}
+
+static inline void oe_set_in_pack_pos(const struct packing_data *pack,
+				      const struct object_entry *e,
+				      unsigned int pos)
+{
+	pack->in_pack_pos[e - pack->objects] = pos;
+}
+
+static inline unsigned int oe_add_pack(struct packing_data *pack,
+				       struct packed_git *p)
+{
+	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
+		die(_("too many packs to handle in one go. "
+		      "Please add .keep files to exclude\n"
+		      "some pack files and keep the number "
+		      "of non-kept files below %d."),
+		    1 << OE_IN_PACK_BITS);
+	if (p) {
+		if (p->index > 0)
+			die("BUG: this packed is already indexed");
+		p->index = pack->in_pack_count;
+	}
+	pack->in_pack[pack->in_pack_count] = p;
+	return pack->in_pack_count++;
+}
+
+static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
+					    const struct object_entry *e)
+{
+	return pack->in_pack[e->in_pack_idx];
+
+}
+
+static inline void oe_set_in_pack(struct object_entry *e,
+				  struct packed_git *p)
+{
+	if (p->index <= 0)
+		die("BUG: found_pack should be NULL "
+		    "instead of having non-positive index");
+	e->in_pack_idx = p->index;
+
+}
+
+static inline struct object_entry *oe_delta(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_idx)
+		return &pack->objects[e->delta_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta(struct packing_data *pack,
+				struct object_entry *e,
+				struct object_entry *delta)
+{
+	if (delta)
+		e->delta_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_child(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_child_idx)
+		return &pack->objects[e->delta_child_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_child(struct packing_data *pack,
+				      struct object_entry *e,
+				      struct object_entry *delta)
+{
+	if (delta)
+		e->delta_child_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_child_idx = 0;
+}
+
+static inline struct object_entry *oe_delta_sibling(
+		const struct packing_data *pack,
+		const struct object_entry *e)
+{
+	if (e->delta_sibling_idx)
+		return &pack->objects[e->delta_sibling_idx - 1];
+	return NULL;
+}
+
+static inline void oe_set_delta_sibling(struct packing_data *pack,
+					struct object_entry *e,
+					struct object_entry *delta)
+{
+	if (delta)
+		e->delta_sibling_idx = (delta - pack->objects) + 1;
+	else
+		e->delta_sibling_idx = 0;
+}
+
 #endif

Nguyễn Thái Ngọc Duy (12):
  pack-objects: a bit of document about struct object_entry
  pack-objects: turn type and in_pack_type to bitfields
  pack-objects: use bitfield for object_entry::dfs_state
  pack-objects: use bitfield for object_entry::depth
  pack-objects: note about in_pack_header_size
  pack-objects: move in_pack_pos out of struct object_entry
  pack-objects: move in_pack out of struct object_entry
  pack-objects: refer to delta objects by index instead of pointer
  pack-objects: reorder 'hash' to pack struct object_entry
  pack-objects: shrink z_delta_size field in struct object_entry
  pack-objects: shrink size field in struct object_entry
  pack-objects: shrink delta_size field in struct object_entry

 Documentation/config.txt           |   4 +-
 Documentation/git-pack-objects.txt |  13 +-
 Documentation/git-repack.txt       |   4 +-
 builtin/pack-objects.c             | 269 +++++++++++++++++----------
 cache.h                            |   3 +
 object.h                           |   1 -
 pack-bitmap-write.c                |   8 +-
 pack-bitmap.c                      |   2 +-
 pack-bitmap.h                      |   4 +-
 pack-objects.h                     | 288 ++++++++++++++++++++++++++---
 10 files changed, 460 insertions(+), 136 deletions(-)

-- 
2.16.2.873.g32ff258c87

