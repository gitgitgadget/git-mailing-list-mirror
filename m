Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD24E1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeCQOKy (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 10:10:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40399 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeCQOKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 10:10:50 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so15302525lfb.7
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cG+b3d8zEUBRwQrg4AeB4QLrmDGyypPBprz+Gu4/GkQ=;
        b=kAApEF8kJqSOnw3suRh4pD7njSEAUf/6RXsDRt6M9J6eC+9BPmt/kbUgcrje7iomM/
         TrbM5u0BhJxhjjbtWoOxDedUPOuBNvy+ExGe/LAoPYrE6I0pzEeUgSe/OC4wiSZ0y//x
         m0xnlnrKFr26HQEZr1mc60fKuyXscZRfyAcf4/C0cNpwdrOkG/a6NcYaNyW2s+f0aoAF
         xzuHHrxbKjl7jfqCzfNJ8ycfxG6vcv32ba+PtHmoeSA6ShC+QJR8MEePNVLyhrQ7aiTO
         fdXqXppp+WISGZAaTQZBc11/DIPdURasrzxw7z7ISZluCCrUB102CbmtlbCkdZYiH02i
         Z8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cG+b3d8zEUBRwQrg4AeB4QLrmDGyypPBprz+Gu4/GkQ=;
        b=Kq++kfP4QfMsN8lOkLzOGjeSYgt3jBvB0s8heS/sN98z6DdEbl2+1s5g+MqtnixrYf
         8ELbRWV+f2/I7K+Y1vAoc6FvBFWfOh3iAFW5lPps76CozOMdCTUI9k5fS1DZ7GULbcBV
         AyiwZef3bZDE63wzh3FQE4IWhcjBPtBfH4LiTkWLcQO0000mVdvzdcFJH4YCtBX6jgU/
         c60oeoLOZ4PR8CKR0LpWdIE+Q3d6cCfBAxI/YbnBKPeSEfJLodj1gQWddy6vaP+h8fvh
         JY9hs7rT7RzhzpfwR5owHwnprbNOpWJttm32LTldlqIVlSstB56THvCf8MBn5oUoovqe
         UW0Q==
X-Gm-Message-State: AElRT7GHCMRlI6zCstkoJ0mxa1PFENH50hgKuWSWtyOqeMzq+/hZe/S3
        cgM7mj0M7AQhl1ck4Q/l0Q9jcA==
X-Google-Smtp-Source: AG47ELt2D+MFwPMK6LNOEEeJBS0zuSeeszpaWfiWfK7UJPBHwgKJsEf0yC5nTfl8tjE5njjVlY1XHQ==
X-Received: by 10.46.51.6 with SMTP id d6mr3753443ljc.57.1521295848291;
        Sat, 17 Mar 2018 07:10:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f7-v6sm625648lfb.2.2018.03.17.07.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 07:10:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v5 02/11] pack-objects: turn type and in_pack_type to bitfields
Date:   Sat, 17 Mar 2018 15:10:24 +0100
Message-Id: <20180317141033.21545-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317141033.21545-1-pclouds@gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com>
 <20180317141033.21545-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An extra field type_valid is added to carry the equivalent of OBJ_BAD
in the original "type" field. in_pack_type always contains a valid
type so we only need 3 bits for it.

A note about accepting OBJ_NONE as "valid" type. The function
read_object_list_from_stdin() can pass this value [1] and it
eventually calls create_object_entry() where current code skip setting
"type" field if the incoming type is zero. This does not have any bad
side effects because "type" field should be memset()'d anyway.

But since we also need to set type_valid now, skipping oe_set_type()
leaves type_valid zero/false, which will make oe_type() return
OBJ_BAD, not OBJ_NONE anymore. Apparently we do care about OBJ_NONE in
prepare_pack(). This switch from OBJ_NONE to OBJ_BAD may trigger

    fatal: unable to get type of object ...

Accepting OBJ_NONE [2] does sound wrong, but this is how it is has
been for a very long time and I haven't time to dig in further.

[1] See 5c49c11686 (pack-objects: better check_object() performances -
    2007-04-16)

[2] 21666f1aae (convert object type handling from a string to a number
    - 2007-02-26)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 60 ++++++++++++++++++++++++------------------
 cache.h                |  2 ++
 object.h               |  1 -
 pack-bitmap-write.c    |  6 ++---
 pack-objects.h         | 20 ++++++++++++--
 5 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..647c01ea34 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -265,7 +265,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	struct git_istream *st = NULL;
 
 	if (!usable_delta) {
-		if (entry->type == OBJ_BLOB &&
+		if (oe_type(entry) == OBJ_BLOB &&
 		    entry->size > big_file_threshold &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
@@ -371,7 +371,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct pack_window *w_curs = NULL;
 	struct revindex_entry *revidx;
 	off_t offset;
-	enum object_type type = entry->type;
+	enum object_type type = oe_type(entry);
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
@@ -480,11 +480,12 @@ static off_t write_object(struct hashfile *f,
 		to_reuse = 0;	/* explicit */
 	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
+	else if (oe_type(entry) == OBJ_REF_DELTA ||
+		 oe_type(entry) == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
 		to_reuse = usable_delta;
 				/* ... but pack split may override that */
-	else if (entry->type != entry->in_pack_type)
+	else if (oe_type(entry) != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
 		to_reuse = 0;	/* we want to pack afresh */
@@ -705,8 +706,8 @@ static struct object_entry **compute_write_order(void)
 	 * And then all remaining commits and tags.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_COMMIT &&
-		    objects[i].type != OBJ_TAG)
+		if (oe_type(&objects[i]) != OBJ_COMMIT &&
+		    oe_type(&objects[i]) != OBJ_TAG)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -715,7 +716,7 @@ static struct object_entry **compute_write_order(void)
 	 * And then all the trees.
 	 */
 	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (objects[i].type != OBJ_TREE)
+		if (oe_type(&objects[i]) != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
@@ -1066,8 +1067,7 @@ static void create_object_entry(const struct object_id *oid,
 
 	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
 	entry->hash = hash;
-	if (type)
-		entry->type = type;
+	oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
 	else
@@ -1407,6 +1407,7 @@ static void check_object(struct object_entry *entry)
 		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type type;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1415,11 +1416,15 @@ static void check_object(struct object_entry *entry)
 		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &type,
 						   &entry->size);
 		if (used == 0)
 			goto give_up;
 
+		if (type < 0)
+			die("BUG: invalid type %d", type);
+		entry->in_pack_type = type;
+
 		/*
 		 * Determine if this is a delta and if so whether we can
 		 * reuse it or not.  Otherwise let's find out as cheaply as
@@ -1428,9 +1433,9 @@ static void check_object(struct object_entry *entry)
 		switch (entry->in_pack_type) {
 		default:
 			/* Not a delta hence we've already got all we need. */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->in_pack_header_size = used;
-			if (entry->type < OBJ_COMMIT || entry->type > OBJ_BLOB)
+			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
@@ -1484,7 +1489,7 @@ static void check_object(struct object_entry *entry)
 			 * deltify other objects against, in order to avoid
 			 * circular deltas.
 			 */
-			entry->type = entry->in_pack_type;
+			oe_set_type(entry, entry->in_pack_type);
 			entry->delta = base_entry;
 			entry->delta_size = entry->size;
 			entry->delta_sibling = base_entry->delta_child;
@@ -1493,7 +1498,7 @@ static void check_object(struct object_entry *entry)
 			return;
 		}
 
-		if (entry->type) {
+		if (oe_type(entry)) {
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
@@ -1516,7 +1521,7 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &entry->size));
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1559,6 +1564,7 @@ static void drop_reused_delta(struct object_entry *entry)
 {
 	struct object_entry **p = &entry->delta->delta_child;
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
 
 	while (*p) {
 		if (*p == entry)
@@ -1570,16 +1576,18 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
-		 * And if that fails, the error will be recorded in entry->type
+		 * And if that fails, the error will be recorded in oe_type(entry)
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.oid.hash,
-					       &entry->size);
+		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
+						    &entry->size));
+	} else {
+		oe_set_type(entry, type);
 	}
 }
 
@@ -1747,10 +1755,12 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	enum object_type a_type = oe_type(a);
+	enum object_type b_type = oe_type(b);
 
-	if (a->type > b->type)
+	if (a_type > b_type)
 		return -1;
-	if (a->type < b->type)
+	if (a_type < b_type)
 		return 1;
 	if (a->hash > b->hash)
 		return -1;
@@ -1826,7 +1836,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	void *delta_buf;
 
 	/* Don't bother doing diffs between different types */
-	if (trg_entry->type != src_entry->type)
+	if (oe_type(trg_entry) != oe_type(src_entry))
 		return -1;
 
 	/*
@@ -2432,11 +2442,11 @@ static void prepare_pack(int window, int depth)
 
 		if (!entry->preferred_base) {
 			nr_deltas++;
-			if (entry->type < 0)
+			if (oe_type(entry) < 0)
 				die("unable to get type of object %s",
 				    oid_to_hex(&entry->idx.oid));
 		} else {
-			if (entry->type < 0) {
+			if (oe_type(entry) < 0) {
 				/*
 				 * This object is not found, but we
 				 * don't have to include it anyway.
@@ -2545,7 +2555,7 @@ static void read_object_list_from_stdin(void)
 			die("expected object ID, got garbage:\n %s", line);
 
 		add_preferred_base_object(p + 1);
-		add_object_entry(&oid, 0, p + 1, 0);
+		add_object_entry(&oid, OBJ_NONE, p + 1, 0);
 	}
 }
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..862bdff83a 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,8 @@ extern void free_name_hash(struct index_state *istate);
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
+#define TYPE_BITS 3
+
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
diff --git a/object.h b/object.h
index 87563d9056..8ce294d6ec 100644
--- a/object.h
+++ b/object.h
@@ -25,7 +25,6 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
-#define TYPE_BITS   3
 /*
  * object flag allocation:
  * revision.h:      0---------10                                26
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..fd11f08940 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -64,12 +64,12 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 
 		entry->in_pack_pos = i;
 
-		switch (entry->type) {
+		switch (oe_type(entry)) {
 		case OBJ_COMMIT:
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			real_type = entry->type;
+			real_type = oe_type(entry);
 			break;
 
 		default:
@@ -98,7 +98,7 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 		default:
 			die("Missing type information for %s (%d/%d)",
 			    oid_to_hex(&entry->idx.oid), real_type,
-			    entry->type);
+			    oe_type(entry));
 		}
 	}
 }
diff --git a/pack-objects.h b/pack-objects.h
index de91edd264..5f568b609c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -59,8 +59,9 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
+	unsigned type_:TYPE_BITS;
+	unsigned in_pack_type:TYPE_BITS; /* could be delta */
+	unsigned type_valid:1;
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
@@ -123,4 +124,19 @@ static inline uint32_t pack_name_hash(const char *name)
 	return hash;
 }
 
+static inline enum object_type oe_type(const struct object_entry *e)
+{
+	return e->type_valid ? e->type_ : OBJ_BAD;
+}
+
+static inline void oe_set_type(struct object_entry *e,
+			       enum object_type type)
+{
+	if (type >= OBJ_ANY)
+		die("BUG: OBJ_ANY cannot be set in pack-objects code");
+
+	e->type_valid = type >= OBJ_NONE;
+	e->type_ = (unsigned)type;
+}
+
 #endif
-- 
2.17.0.rc0.347.gf9cf61673a

