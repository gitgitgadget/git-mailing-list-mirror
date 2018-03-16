Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397811F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeCPScs (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:32:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37262 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCPScp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:45 -0400
Received: by mail-lf0-f65.google.com with SMTP id y19-v6so16759496lfd.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YM1oNpEJHrEfnPIVBDiZJcJxhVVc2MZ2Ou5ybHlIX+4=;
        b=QPpeV2bEdCes9uMX2DXVvJV3QLqzByXqGFeDxLSdeyw/CDjq2vvxQBWAHmPLIzGxMR
         TQ8F3BCO9Vjgux1+oxCypN2Lc272o1U54p1K8b710bo+HysrKzccNoJjMDjmYtEyoweq
         0qwh/nULNgkSXTWwi8v9ujDhQbgyalFiYDo00fHLsaO39NTMI//4RbZyDAv06mezU9xM
         v4Q8SJQwJRP5qdQ0FTFObvsVEHRUKiqZAt4LwXRxc9XrhYBe/I4VMXYlD9CsX66pC1xz
         TFBvuLXjBEwB3rsCPhtyKUNLx8FOe2wDB4VGb0l1arsYdJ2XWQa9qCnnM8ubuzNkAwMz
         RaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YM1oNpEJHrEfnPIVBDiZJcJxhVVc2MZ2Ou5ybHlIX+4=;
        b=mhfLMVFb5FX2xxDo4MONx1Ks/Bd5w73iUjOdM+/kGHayEc2NAubLgxcfys2WR/E6LN
         JdBvccmmb9uNM+St6UV57bw23QaeKl/zI785QNq4pJBa9S/GGTFszgX9cstuQTLO7Eub
         S1fJgGk82w5oy6zkT4M7bF1EMBk2CTCh1tY6i7Ufsl38ySOIHSfsmwlRm4LYtGeVW/Nk
         nfUE91mdQLXc6LZZD/peGs3JZD49iTPY14qnii8NLoJG4FQNQS348CvP5jhn9Vlbli/b
         VYTPS5leWAUWx7uEpQbfYOdG1wZdGhe0gqV1QUMjKewMlt/XjbeWpzFa2VOwodOKql8x
         2hQQ==
X-Gm-Message-State: AElRT7FqR3gdo00GuXYztT1soO/PI9+N/6akQ6I7MWkELrhF/IP4K2ly
        N1oruubdhl+J3MiMmdQRcX4=
X-Google-Smtp-Source: AG47ELtyj1jO8kIsGa0dy10UjlWqaqhfMfyGqG2yPD6kALubC+AlpVq7UjM8dmV6zr2s5TSFyApedQ==
X-Received: by 10.46.34.70 with SMTP id i67mr2034302lji.143.1521225163858;
        Fri, 16 Mar 2018 11:32:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 02/11] pack-objects: turn type and in_pack_type to bitfields
Date:   Fri, 16 Mar 2018 19:31:51 +0100
Message-Id: <20180316183200.31014-3-pclouds@gmail.com>
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
 builtin/pack-objects.c | 58 +++++++++++++++++++++++++-----------------
 cache.h                |  2 ++
 object.h               |  1 -
 pack-bitmap-write.c    |  6 ++---
 pack-objects.h         | 20 +++++++++++++--
 5 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..13f6a44fb2 100644
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
@@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
@@ -1578,8 +1584,10 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
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
index 85345a4af1..38d3ff167f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -58,8 +58,9 @@ struct object_entry {
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
@@ -122,4 +123,19 @@ static inline uint32_t pack_name_hash(const char *name)
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
2.16.2.903.gd04caf5039

