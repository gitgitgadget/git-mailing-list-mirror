Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3946A1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966016AbeCHLnr (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:47 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38817 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeCHLnq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:46 -0500
Received: by mail-pf0-f196.google.com with SMTP id d26so2231352pfn.5
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsv7LIyEwk678v/j/ubQgnDnjkapRkIH76/cJmn79b4=;
        b=AxFshxV87SsQh1i8Qf0fHoBZWETCqxtfxOEq5GLnWJhNdmVc4TcR6CPsqPr5Vb7CA/
         SjrKBcScjXjYvUma/Q7VYI8tyetG3ihNkJNKpqvSoDTNcil1SpFGsIJnGWAYLYxn2q+n
         PWhFtslkh0cGx4QvTIHCynunFZwiykp2ZoEHgJt3OjItKoX4ZgukmSzvXquFUXJJutQr
         CMsKjWTICdwH4qWp7WWCWgQTYk2W0xYWmGj4ItWf+eOPpatPPFnDDXzDPOqxGI62oZxU
         5N9UkjJzBGLVsX76g7YYRfuoeLxQXjUiigy/R6P/erWWpQ1H26q7C2WEomtMCbgvNNvl
         jMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsv7LIyEwk678v/j/ubQgnDnjkapRkIH76/cJmn79b4=;
        b=dMocQHpPTg7pwXvqk8ZdRCzaIng9WGCene6nVmeLj9UjyM+QejzGvwlTgOsOgSUCKw
         T8jYg0J1S/R1X/uGNAE/440fnqNOW/uDVaItsO72/VRxBOjZu25GwK1uy+TBhH//lMsE
         Oa2g4A8reBupHnom4bLVe6OvFQQ3AueTwqOq/1BKNRuEkqeqdUJ6mpvHeLJCA7ZP2Ud+
         w8456j4YECwqaOK/HGRZc5a7aLge8PaNobTNGa2FRwtrdaymPem9bpXfvrHVKsYYa9h6
         mh+CrJozaGZ7sdFr7te6um5thsxn3xbTjKVxArEEperftel+Nlhxr9B4rHOLs7IZ/MPw
         mxlA==
X-Gm-Message-State: APf1xPDZYRZ/cwLW3qNg+RXvtXeOwE/0tgBIE8u1OCCMV9u8kzltiZ5M
        uL/Bj3RLcUoC078xwpog3QU=
X-Google-Smtp-Source: AG47ELvptKXn65Rk7WLiKOAygRXFbGSsbsbqxAQSnUctUMj5wAe0r8FbOC2qGkvyDDuTfey0SzvLrw==
X-Received: by 10.98.70.198 with SMTP id o67mr25814040pfi.173.1520509425914;
        Thu, 08 Mar 2018 03:43:45 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id p3sm3591076pga.45.2018.03.08.03.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 12/12] pack-objects: shrink delta_size field in struct object_entry
Date:   Thu,  8 Mar 2018 18:42:32 +0700
Message-Id: <20180308114232.10508-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing a delta size of 64 bits is crazy. Shrink this field down to
31 bits with one overflow bit.

If we encounter an existing delta larger than 2GB, we do not cache
delta_size at all and will get the value from oe_size(), potentially
from disk if it's larger than 4GB.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 24 ++++++++++++++----------
 pack-objects.h         | 30 +++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index db040e95db..0f65e0f243 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,10 +30,12 @@
 #include "packfile.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
 #define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
@@ -140,7 +142,7 @@ static void *get_delta(struct object_entry *entry)
 		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-	if (!delta_buf || delta_size != entry->delta_size)
+	if (!delta_buf || delta_size != DELTA_SIZE(entry))
 		die("delta size changed");
 	free(buf);
 	free(base_buf);
@@ -291,14 +293,14 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		FREE_AND_NULL(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
-		size = entry->delta_size;
+		size = DELTA_SIZE(entry);
 		buf = entry->delta_data;
 		entry->delta_data = NULL;
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	} else {
 		buf = get_delta(entry);
-		size = entry->delta_size;
+		size = DELTA_SIZE(entry);
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	}
@@ -1509,7 +1511,7 @@ static void check_object(struct object_entry *entry)
 			 */
 			entry->type = entry->in_pack_type;
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = oe_size(entry);
+			SET_DELTA_SIZE(entry, oe_size(entry));
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1895,7 +1897,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
-		max_size = trg_entry->delta_size;
+		max_size = DELTA_SIZE(trg_entry);
 		ref_depth = trg->depth;
 	}
 	max_size = (uint64_t)max_size * (max_depth - src->depth) /
@@ -1966,10 +1968,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
+	if (delta_size >= maximum_unsigned_value_of_type(uint32_t))
+		return 0;
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == trg_entry->delta_size &&
+		if (delta_size == DELTA_SIZE(trg_entry) &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
@@ -1984,7 +1988,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
-		delta_cache_size -= trg_entry->delta_size;
+		delta_cache_size -= DELTA_SIZE(trg_entry);
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
@@ -1997,7 +2001,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 
 	SET_DELTA(trg_entry, src_entry);
-	trg_entry->delta_size = delta_size;
+	SET_DELTA_SIZE(trg_entry, delta_size);
 	trg->depth = src->depth + 1;
 
 	return 1;
@@ -2120,11 +2124,11 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		if (entry->delta_data && !pack_to_stdout) {
 			unsigned long size;
 
-			size = do_compress(&entry->delta_data, entry->delta_size);
+			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
 			entry->z_delta_size = size;
 			if (entry->z_delta_size == size) {
 				cache_lock();
-				delta_cache_size -= entry->delta_size;
+				delta_cache_size -= DELTA_SIZE(entry);
 				delta_cache_size += entry->z_delta_size;
 				cache_unlock();
 			} else {
diff --git a/pack-objects.h b/pack-objects.h
index 0253df6cd4..f1a82bf9ac 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -5,6 +5,7 @@
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
 #define OE_Z_DELTA_BITS		16
+#define OE_DELTA_SIZE_BITS	31
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -73,9 +74,6 @@ struct object_entry {
 	struct pack_idx_entry idx;
 	/* object uncompressed size _if_ size_valid is true */
 	uint32_t size_;
-
-	/* XXX 4 bytes hole, try to pack */
-
 	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
@@ -84,7 +82,10 @@ struct object_entry {
 				     */
 	uint32_t hash;			/* name hint hash */
 	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
+	/* object uncompressed size _if_ size_valid is true */
+	uint32_t size;
+	uint32_t delta_size_:OE_DELTA_SIZE_BITS;	/* delta data size (uncompressed) */
+	uint32_t delta_size_valid:1;
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
@@ -109,7 +110,7 @@ struct object_entry {
 	*/
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 
-	/* size: 88, bit_padding: 1 bits */
+	/* size: 80, bit_padding: 1 bits */
 };
 
 struct packing_data {
@@ -296,4 +297,23 @@ static inline void oe_set_size(struct object_entry *e,
 	e->size_valid = e->size_ == size;
 }
 
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	if (e->delta_size_valid)
+		return e->delta_size_;
+	return oe_size(e);
+}
+
+static inline void oe_set_delta_size(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned long size)
+{
+	e->delta_size_ = size;
+	e->delta_size_valid =e->delta_size_ == size;
+	if (!e->delta_size_valid && size != oe_size(e))
+		die("BUG: this can only happen in check_object() "
+		    "where delta size is the same as entry size");
+}
+
 #endif
-- 
2.16.2.873.g32ff258c87

