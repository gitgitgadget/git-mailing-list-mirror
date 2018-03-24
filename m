Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14421F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 06:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCXGeY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 02:34:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36408 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeCXGeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 02:34:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id z143-v6so21276981lff.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0SGpWiOaCfowEnJHj796rJSuWIaQmdMqwSxe3HbSv4=;
        b=mn4lE+DMdKMaiHC+RwxTKo1Ku8p0M0IQRYx7tiOvaX9cyLoEoz++xZGSq5EJzhzCld
         sBq7CRzrigu3hErxL338YJ53ygdiSFoP9olT7FjnFIxzCtj0FK0mI5UcFwDacHDsJpAL
         HyY/M6AOSoc5RZeKSd7S2uSvRby0s8hCEWRKbD4EQ7ZEcn7tz1eIqZUMo9pGxgbej+N4
         Uhn1UMo8vYrq8HxNnmxlUHZqy3ar0cxgcybyXlsoCsVNZe0tSMOsuVBIkM2pTodB01hA
         KPcsjqXKKAeboqNigT81YELpPIeNg08jvoLLmYEkNPDLQ7S4uj3Okac02dYrNg4/8r5R
         xssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0SGpWiOaCfowEnJHj796rJSuWIaQmdMqwSxe3HbSv4=;
        b=Vp/G+XYysGYXG7k/cMSoP+MqkWSl3UxRVRnSv4CzaGKVwacxSdF3Do9y2VVkwAsrpT
         MPsafZo5PIGdv4dM7NEUoCIgRKL4IpWDH845bkibgh62t1S5WEncvywMHwdf3VuSFvfj
         YW3bwKpamMUc6AtcE/F4/328UUSYNNX18mcwEITvvizSarCn2mpLzTa+qqPvkBJTIFmT
         wBL3F+9ZNwVd+tEFzDb/63V5K6CqfAhDpLX/girZJJsiUEAkF3oTvQYxoDFPCSlfLuDA
         0ZJS3YvF3A1QbMPmhpHaZr1RyTKfvNn1A59vLNfpt4iC4erzitNfRH0XPsNDaeStcA3C
         133Q==
X-Gm-Message-State: AElRT7EvT7bPAlvC2jfZzE/1lGKrDulHg9W5DUWYSnRUaVAdSOF/9zgx
        NlyJnbe5+s9HgdGisu8ln/c=
X-Google-Smtp-Source: AG47ELtcjZTs8Yt1j6jbke0sKvLIeDqSsmfxQPcn1OX7UaZlmC6tAdjZJjEi9hVt6FThFHs9+Lj1Iw==
X-Received: by 2002:a19:5317:: with SMTP id h23-v6mr19034576lfb.6.1521873260000;
        Fri, 23 Mar 2018 23:34:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h8sm2251703lja.41.2018.03.23.23.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:34:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v7 11/13] pack-objects: shrink size field in struct object_entry
Date:   Sat, 24 Mar 2018 07:33:51 +0100
Message-Id: <20180324063353.24722-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's very very rare that an uncompressed object is larger than 4GB
(partly because Git does not handle those large files very well to
begin with). Let's optimize it for the common case where object size
is smaller than this limit.

Shrink size field down to 32 bits [1] and one overflow bit. If the
size is too large, we read it back from disk. As noted in the previous
patch, we need to return the delta size instead of canonical size when
the to-be-reused object entry type is a delta instead of a canonical
one.

Add two compare helpers that can take advantage of the overflow
bit (e.g. if the file is 4GB+, chances are it's already larger than
core.bigFileThreshold and there's no point in comparing the actual
value).

Another note about oe_get_size_slow(). This function MUST be thread
safe because SIZE() macro is used inside try_delta() which may run in
parallel. Outside parallel code, no-contention locking should be dirt
cheap (or insignificant compared to i/o access anyway). To exercise
this code, it's best to run the test suite with something like

    make test GIT_TEST_OE_SIZE_BITS=2

which forces this code on all objects larger than 3 bytes.

[1] it's actually already 32 bits on Windows

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 100 +++++++++++++++++++++++++++++++----------
 pack-objects.c         |   9 +++-
 pack-objects.h         |  53 +++++++++++++++++++++-
 t/README               |   6 +++
 4 files changed, 142 insertions(+), 26 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f054ba9dfa..caeef086d3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -30,6 +30,8 @@
 #include "packfile.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
+#define SIZE(obj) oe_size(&to_pack, obj)
+#define SET_SIZE(obj,size) oe_set_size(&to_pack, obj, size)
 #define DELTA(obj) oe_delta(&to_pack, obj)
 #define DELTA_CHILD(obj) oe_delta_child(&to_pack, obj)
 #define DELTA_SIBLING(obj) oe_delta_sibling(&to_pack, obj)
@@ -274,7 +276,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
-		    entry->size > big_file_threshold &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold) &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
@@ -384,12 +386,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
+	unsigned long entry_size = SIZE(entry);
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
-					      type, entry->size);
+					      type, entry_size);
 
 	offset = entry->in_pack_offset;
 	revidx = find_pack_revindex(p, offset);
@@ -406,7 +409,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
+	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
 		error("corrupt packed object for %s",
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
@@ -1407,6 +1410,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
+	unsigned long canonical_size;
+
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
@@ -1444,7 +1449,7 @@ static void check_object(struct object_entry *entry)
 		default:
 			/* Not a delta hence we've already got all we need. */
 			oe_set_type(entry, entry->in_pack_type);
-			entry->size = in_pack_size;
+			SET_SIZE(entry, in_pack_size);
 			entry->in_pack_header_size = used;
 			if (oe_type(entry) < OBJ_COMMIT || oe_type(entry) > OBJ_BLOB)
 				goto give_up;
@@ -1501,9 +1506,9 @@ static void check_object(struct object_entry *entry)
 			 * circular deltas.
 			 */
 			oe_set_type(entry, entry->in_pack_type);
-			entry->size = in_pack_size; /* delta size */
+			SET_SIZE(entry, in_pack_size); /* delta size */
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = entry->size;
+			entry->delta_size = in_pack_size;
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1519,9 +1524,10 @@ static void check_object(struct object_entry *entry)
 			 * object size from the delta header.
 			 */
 			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
-			entry->size = get_size_from_delta(p, &w_curs, delta_pos);
-			if (entry->size == 0)
+			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			if (canonical_size == 0)
 				goto give_up;
+			SET_SIZE(entry, canonical_size);
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1535,13 +1541,18 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &entry->size));
-	/*
-	 * The error condition is checked in prepare_pack().  This is
-	 * to permit a missing preferred base object to be ignored
-	 * as a preferred base.  Doing so can result in a larger
-	 * pack file, but the transfer will still take place.
-	 */
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
+					    &canonical_size));
+	if (entry->type_valid) {
+		SET_SIZE(entry, canonical_size);
+	} else {
+		/*
+		 * Bad object type is checked in prepare_pack().  This is
+		 * to permit a missing preferred base object to be ignored
+		 * as a preferred base.  Doing so can result in a larger
+		 * pack file, but the transfer will still take place.
+		 */
+	}
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1581,6 +1592,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
+	unsigned long size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -1593,7 +1605,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
-	oi.sizep = &entry->size;
+	oi.sizep = &size;
 	oi.typep = &type;
 	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
@@ -1603,10 +1615,11 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * and dealt with in prepare_pack().
 		 */
 		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
-						    &entry->size));
+						    &size));
 	} else {
 		oe_set_type(entry, type);
 	}
+	SET_SIZE(entry, size);
 }
 
 /*
@@ -1746,7 +1759,8 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (entry->type_valid && big_file_threshold < entry->size)
+		if (entry->type_valid &&
+		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
 			entry->no_try_delta = 1;
 	}
 
@@ -1775,6 +1789,8 @@ static int type_size_sort(const void *_a, const void *_b)
 	const struct object_entry *b = *(struct object_entry **)_b;
 	enum object_type a_type = oe_type(a);
 	enum object_type b_type = oe_type(b);
+	unsigned long a_size = SIZE(a);
+	unsigned long b_size = SIZE(b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1788,9 +1804,9 @@ static int type_size_sort(const void *_a, const void *_b)
 		return -1;
 	if (a->preferred_base < b->preferred_base)
 		return 1;
-	if (a->size > b->size)
+	if (a_size > b_size)
 		return -1;
-	if (a->size < b->size)
+	if (a_size < b_size)
 		return 1;
 	return a < b ? -1 : (a > b);  /* newest first */
 }
@@ -1843,6 +1859,41 @@ static pthread_mutex_t progress_mutex;
 
 #endif
 
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e)
+{
+	struct packed_git *p;
+	struct pack_window *w_curs;
+	unsigned char *buf;
+	enum object_type type;
+	unsigned long used, avail, size;
+
+	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
+		read_lock();
+		if (sha1_object_info(e->idx.oid.hash, &size) < 0)
+			die(_("unable to get size of %s"),
+			    oid_to_hex(&e->idx.oid));
+		read_unlock();
+		return size;
+	}
+
+	p = oe_in_pack(pack, e);
+	if (!p)
+		die("BUG: when e->type is a delta, it must belong to a pack");
+
+	read_lock();
+	w_curs = NULL;
+	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
+	used = unpack_object_header_buffer(buf, avail, &type, &size);
+	if (used == 0)
+		die(_("unable to parse object header of %s"),
+		    oid_to_hex(&e->idx.oid));
+
+	unuse_pack(&w_curs);
+	read_unlock();
+	return size;
+}
+
 static int try_delta(struct unpacked *trg, struct unpacked *src,
 		     unsigned max_depth, unsigned long *mem_usage)
 {
@@ -1877,7 +1928,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	trg_size = trg_entry->size;
+	trg_size = SIZE(trg_entry);
 	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
@@ -1889,7 +1940,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	src_size = src_entry->size;
+	src_size = SIZE(src_entry);
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -2009,7 +2060,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-		freed_mem += n->entry->size;
+		freed_mem += SIZE(n->entry);
 		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
@@ -2459,7 +2510,8 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (!entry->type_valid || entry->size < 50)
+		if (!entry->type_valid ||
+		    oe_size_less_than(&to_pack, entry, 50))
 			continue;
 
 		if (entry->no_try_delta)
diff --git a/pack-objects.c b/pack-objects.c
index 13f2b2bff2..59c6e40a02 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -120,8 +120,15 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 {
 	struct object_entry *new_entry;
 
-	if (!pdata->nr_objects)
+	if (!pdata->nr_objects) {
 		prepare_in_pack_by_idx(pdata);
+		if (getenv("GIT_TEST_OE_SIZE_BITS")) {
+			int bits = atoi(getenv("GIT_TEST_OE_SIZE_BITS"));;
+			pdata->oe_size_limit = 1 << bits;
+		}
+		if (!pdata->oe_size_limit)
+			pdata->oe_size_limit = 1 << OE_SIZE_BITS;
+	}
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
 		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
diff --git a/pack-objects.h b/pack-objects.h
index d23e17050c..8bb082f22f 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -5,6 +5,7 @@
 #define OE_DEPTH_BITS		12
 #define OE_IN_PACK_BITS		10
 #define OE_Z_DELTA_BITS		16
+#define OE_SIZE_BITS		31
 
 /*
  * State flags for depth-first search used for analyzing delta cycles.
@@ -72,7 +73,8 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
+	uint32_t size_:OE_SIZE_BITS;
+	uint32_t size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
@@ -117,6 +119,8 @@ struct packing_data {
 	 */
 	struct packed_git **in_pack_by_idx;
 	struct packed_git **in_pack;
+
+	uintmax_t oe_size_limit;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -256,4 +260,51 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 		e->delta_sibling_idx = 0;
 }
 
+unsigned long oe_get_size_slow(struct packing_data *pack,
+			       const struct object_entry *e);
+static inline unsigned long oe_size(struct packing_data *pack,
+				    const struct object_entry *e)
+{
+	if (e->size_valid)
+		return e->size_;
+
+	return oe_get_size_slow(pack, e);
+}
+
+static inline int oe_size_less_than(struct packing_data *pack,
+				    const struct object_entry *lhs,
+				    unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ < rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 0;
+	return oe_get_size_slow(pack, lhs) < rhs;
+}
+
+static inline int oe_size_greater_than(struct packing_data *pack,
+				       const struct object_entry *lhs,
+				       unsigned long rhs)
+{
+	if (lhs->size_valid)
+		return lhs->size_ > rhs;
+	if (rhs < pack->oe_size_limit) /* rhs < 2^x <= lhs ? */
+		return 1;
+	return oe_get_size_slow(pack, lhs) > rhs;
+}
+
+static inline void oe_set_size(struct packing_data *pack,
+			       struct object_entry *e,
+			       unsigned long size)
+{
+	if (size < pack->oe_size_limit) {
+		e->size_ = size;
+		e->size_valid = 1;
+	} else {
+		e->size_valid = 0;
+		if (oe_get_size_slow(pack, e) != size)
+			die("BUG: 'size' is supposed to be the object size!");
+	}
+}
+
 #endif
diff --git a/t/README b/t/README
index c6130ff16d..da117ca734 100644
--- a/t/README
+++ b/t/README
@@ -306,6 +306,12 @@ GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
 path where there are more than 1024 packs even if the actual number of
 packs in repository is below this limit.
 
+GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
+code path where we do not cache objecct size in memory and read it
+from existing packs on demand. This normally only happens when the
+object size is over 2GB. This variable forces the code path on any
+object larger than 2^<bits> bytes.
+
 Naming Tests
 ------------
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

