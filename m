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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3941F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeCPSdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:33:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35052 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeCPSc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id t132-v6so16744976lfe.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pto4b1FvfKaVSM5tcEAmlgO6GSydoBZsJuPT9oRfmIU=;
        b=fk6STqRR0CmggxzxnG9bLKYLY2SrqP0FtXdp1je+WK5SmHIrSGodktlZjNR34I79Z3
         bycir0DdtEt7UmpTz6vCufxWTOOGdf2AVw1Zf5lEwOY3IxEVdUs3NEXSR/05D7teLmnX
         aNgplDPlMViGk+HgjeG1rcbvbDhVtm9KA3KbLKpaRk6WSXx+yQwEkeywxsP3KTqBb4m7
         sR8+3FSzcHQFoq5LZKLtetRCDGK5vbRyhwL3nd3Ikw+yIGNLWDzJAgloqF2Xp1xL7Zwr
         K71z2H2ZmNe7+s2aeSXswBIA0dFLnTn5lLlIM97IMYyRIKfqMg5rNqXz7CF6V9C3flCg
         IQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pto4b1FvfKaVSM5tcEAmlgO6GSydoBZsJuPT9oRfmIU=;
        b=eZCuaUab5tpbJbNNQAhrqT6zuJ0iXvj+o/dBuloUPzPwJpxsxubERzearp95MGka/a
         GfYuAO33GPjh4+44Pyq5KoPqVbgLEBgrinKh1nxZeLpS1X3xatCnkEI1bhpUOO8Rv8ts
         StEpbIktXyltAEdAvQB8SQlGRBR+BHdt/x9pCQDFWV0kAwRJHVJmi2MGdqEgqcY0CjXY
         WVPWoL1moZEKNKXSozYozdgB3rufpZcZend/WfF14JXq66X/ELlLhVhNT+asGbFJgGla
         7wNDlxknJqSsOlFn49YGRs3Irs6GZyAzJ/zpYPR21x2fJaYIMeEwhWsD53YM9MowuKQX
         /A+Q==
X-Gm-Message-State: AElRT7HJOaUba5Ie6/T8xYoo29A4i+jVfvs/lZkAi21gOPkHxhG7svb7
        65D8MFBSFoTdmv35acT9ALo=
X-Google-Smtp-Source: AG47ELtVA28/VedIhPlBVzFX0w2yACGC4lG8m6JVngIJ6rAhGbA5BkKTF4RGiMPuotuNy0T3VDhLbw==
X-Received: by 10.46.45.18 with SMTP id t18mr2131822ljt.48.1521225175867;
        Fri, 16 Mar 2018 11:32:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 10/11] pack-objects: shrink delta_size field in struct object_entry
Date:   Fri, 16 Mar 2018 19:31:59 +0100
Message-Id: <20180316183200.31014-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180316183200.31014-1-pclouds@gmail.com>
References: <20180308114232.10508-1-pclouds@gmail.com>
 <20180316183200.31014-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing a delta size of 64 bits is crazy. Shrink this field down to
31 bits with one overflow bit.

If we find an existing delta larger than 2GB, we do not cache
delta_size at all and will get the value from oe_size(), potentially
from disk if it's larger than 4GB.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 24 ++++++++++++++----------
 pack-objects.h         | 23 ++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 14aa4acd50..c388d87c3e 100644
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
 			oe_set_type(entry, entry->in_pack_type);
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
index 5c7e15ca92..f430d938c6 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -5,6 +5,7 @@
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		14
 #define OE_Z_DELTA_BITS		16
+#define OE_DELTA_SIZE_BITS	31
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -80,7 +81,8 @@ struct object_entry {
 				     * uses the same base as me
 				     */
 	void *delta_data;	/* cached delta (uncompressed) */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
+	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
+	uint32_t delta_size_valid:1;
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 	unsigned type_:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
@@ -298,4 +300,23 @@ static inline void oe_set_size(struct object_entry *e,
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
2.16.2.903.gd04caf5039

