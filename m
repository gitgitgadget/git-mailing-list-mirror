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
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F891F424
	for <e@80x24.org>; Sat, 31 Mar 2018 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeCaKDv (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 06:03:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33266 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbeCaKDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 06:03:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id x70-v6so8292047lfa.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+jxmdwTcOsjRAH3pLr6IqI7vepoiIrJcEHopmFfU6Vo=;
        b=O/BVG4obtaAuz/tVvWgIKP4oTCQz7RZulN/nC1THmkS1ezDEE3OXmEW/VTpVAWe5Ox
         xN/mG/jPuTm+s+Ui8sqOmDRqs1uw1v6oGBAoc9xey0gCHvQxSyRl6M8gnuIATLAAfSXi
         UJpKknzvN9RTOIIyZM2m0ckxD7CQkDVmM1OZKEK/rer1Iy+n+jhC1xFIZKEMGTZyc6PC
         cvdklhLnLOx/EwYwXR/yCxpFxx5TGEDmJ1giSabo2v4XIMWOZX2vG2Z12u6RFHiMtcGd
         PHKJgM70Z7/iXU09i2UzY1oO5mhTl3UA3rSSnwQkG8dOWQOf92pqUOuin6D3cKxT6u1R
         FA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+jxmdwTcOsjRAH3pLr6IqI7vepoiIrJcEHopmFfU6Vo=;
        b=sPCGadM8J9Iu+MZ8oHUB0X0e2r53nAOeR3pQAOlJo+4bqlmqdnz3lSjA2MXH3c4KhP
         PfYi0Vy74iR/2n4RlohUEbcmAj2mBce01Bok52cRyOXsH548RjGr9rU5py6lmaZg8W0o
         NJA8SeU4C/JwEp19WPe265nMt1xICSIa3puEHrFeTc5/lXCPsidNLLpT2Wd8drJY0yeY
         Aq6ydjj3gmMMg428Z8Cz8Vl/1IEQzXLzDropuJ66qkaX9qDIIBwxJFaW8XuzcVZa5NbX
         zXvs+E2NJ+c5WDK7laVtbJvMEPZ7bFdneiqSFpoYPnwQOLshWh7tGhw45Zsu4IM7Vz9h
         gwfw==
X-Gm-Message-State: AElRT7GIugVDRbLyL9ts4M+l6z+K0VH6mlwWlwtNt7v1kTNOODYBgWAP
        ibzADwAQ54eWSN8X9Crev8w=
X-Google-Smtp-Source: AIpwx4+Guz09YW6I99pzeL/k26cDs7Ude57aohvSO/VHdiWYnV3f0y+JHOnAjmHnvXAnSjjRIj/Pog==
X-Received: by 10.46.154.213 with SMTP id p21mr1388853ljj.59.1522490617728;
        Sat, 31 Mar 2018 03:03:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a1sm1799175ljj.90.2018.03.31.03.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Mar 2018 03:03:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v8 13/15] pack-objects: shrink delta_size field in struct object_entry
Date:   Sat, 31 Mar 2018 12:03:09 +0200
Message-Id: <20180331100311.32373-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc2.515.g4feb9b7923
In-Reply-To: <20180331100311.32373-1-pclouds@gmail.com>
References: <20180324063353.24722-1-pclouds@gmail.com>
 <20180331100311.32373-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing a delta size of 64 bits is crazy. Shrink this field down to
20 bits with one overflow bit.

If we find an existing delta larger than 1MB, we do not cache
delta_size at all and will get the value from oe_size(), potentially
from disk if it's larger than 4GB.

Note, since DELTA_SIZE() is used in try_delta() code, it must be
thread-safe. Luckily oe_size() does guarantee this so we it is
thread-safe.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 26 ++++++++++++++++----------
 pack-objects.h         | 23 ++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b4ea6290f9..b5bba2c228 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,10 +32,12 @@
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
 #define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
+#define DELTA_SIZE(obj) oe_delta_size(&to_pack, obj)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
 #define SET_DELTA(obj, val) oe_set_delta(&to_pack, obj, val)
+#define SET_DELTA_SIZE(obj, val) oe_set_delta_size(&to_pack, obj, val)
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, val)
 
@@ -142,7 +144,7 @@ static void *get_delta(struct object_entry *entry)
 		    oid_to_hex(&DELTA(entry)->idx.oid));
 	delta_buf = diff_delta(base_buf, base_size,
 			       buf, size, &delta_size, 0);
-	if (!delta_buf || delta_size != entry->delta_size)
+	if (!delta_buf || delta_size != DELTA_SIZE(entry))
 		die("delta size changed");
 	free(buf);
 	free(base_buf);
@@ -293,14 +295,14 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
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
@@ -1508,7 +1510,7 @@ static void check_object(struct object_entry *entry)
 			oe_set_type(entry, entry->in_pack_type);
 			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = in_pack_size;
+			SET_DELTA_SIZE(entry, in_pack_size);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1938,7 +1940,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
 	} else {
-		max_size = trg_entry->delta_size;
+		max_size = DELTA_SIZE(trg_entry);
 		ref_depth = trg->depth;
 	}
 	max_size = (uint64_t)max_size * (max_depth - src->depth) /
@@ -2009,10 +2011,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
 	if (!delta_buf)
 		return 0;
+	if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
+		free(delta_buf);
+		return 0;
+	}
 
 	if (DELTA(trg_entry)) {
 		/* Prefer only shallower same-sized deltas. */
-		if (delta_size == trg_entry->delta_size &&
+		if (delta_size == DELTA_SIZE(trg_entry) &&
 		    src->depth + 1 >= trg->depth) {
 			free(delta_buf);
 			return 0;
@@ -2027,7 +2033,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	free(trg_entry->delta_data);
 	cache_lock();
 	if (trg_entry->delta_data) {
-		delta_cache_size -= trg_entry->delta_size;
+		delta_cache_size -= DELTA_SIZE(trg_entry);
 		trg_entry->delta_data = NULL;
 	}
 	if (delta_cacheable(src_size, trg_size, delta_size)) {
@@ -2040,7 +2046,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 
 	SET_DELTA(trg_entry, src_entry);
-	trg_entry->delta_size = delta_size;
+	SET_DELTA_SIZE(trg_entry, delta_size);
 	trg->depth = src->depth + 1;
 
 	return 1;
@@ -2163,11 +2169,11 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		if (entry->delta_data && !pack_to_stdout) {
 			unsigned long size;
 
-			size = do_compress(&entry->delta_data, entry->delta_size);
+			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
 			if (size < (1U << OE_Z_DELTA_BITS)) {
 				entry->z_delta_size = size;
 				cache_lock();
-				delta_cache_size -= entry->delta_size;
+				delta_cache_size -= DELTA_SIZE(entry);
 				delta_cache_size += entry->z_delta_size;
 				cache_unlock();
 			} else {
diff --git a/pack-objects.h b/pack-objects.h
index 27697be5c9..b5114a70a7 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -10,6 +10,7 @@
  * above this limit. Don't lower it too much.
  */
 #define OE_SIZE_BITS		31
+#define OE_DELTA_SIZE_BITS	20
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -83,7 +84,8 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
+	unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
+	unsigned delta_size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -307,4 +309,23 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
+static inline unsigned long oe_delta_size(struct packing_data *pack,
+					  const struct object_entry *e)
+{
+	if (e->delta_size_valid)
+		return e->delta_size_;
+	return oe_size(pack, e);
+}
+
+static inline void oe_set_delta_size(struct packing_data *pack,
+				     struct object_entry *e,
+				     unsigned long size)
+{
+	e->delta_size_ = size;
+	e->delta_size_valid = e->delta_size_ == size;
+	if (!e->delta_size_valid && size != oe_size(pack, e))
+		BUG("this can only happen in check_object() "
+		    "where delta size is the same as entry size");
+}
+
 #endif
-- 
2.17.0.rc2.515.g4feb9b7923

