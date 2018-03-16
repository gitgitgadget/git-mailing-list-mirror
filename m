Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A211FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 18:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeCPSdQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:33:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36594 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeCPSc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:32:56 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so10488579lff.3
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1iqCftSnXvIDBbE9e8hHyGeMxz3g2HxfF84B+rZ1fI=;
        b=OKx68Fk7BlKqRMtEKFlbsQnBJQGh0Aj4NXCTdoNyDoVBobIfYYtpe00w0i9ipzOs9B
         UGLWv/NovmFF+s/xpiiSga3Osd6cBFKQXfEOl8Mqf8O+kRAPAPyOLFxqMQL5oIUCGnDH
         qaCCPQ/cBZ4D7+FSmnyLefi4BUZ2FQpUBfblSCO3SAFo46iJnhodqSO6lTNRVV3bIKf+
         pUncnjeKh1pr+47T9ETGJ3rUQcl08BrPVRYQIWadpJ8sjs9LwTp6EXm7V4ghJvgXPgyV
         YnHNm6m04QAA59s0a3JdTaGwLIt3exejJchI1fz8fhIuJVdp1eIxb8WbcMYXNknqqJyZ
         KvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1iqCftSnXvIDBbE9e8hHyGeMxz3g2HxfF84B+rZ1fI=;
        b=BSxsrITpyH6pmtJh7qLuxnVrIfeS4t1kL2eBvK6ovjK1H2QXgqiMCRu+AQpEAz3zX0
         /cJI5IlUHdU7zdpBER8nP+B+xYeexeeqIBcd5YuZdHg697jFPdSYc8+tcUTUEbhzm44z
         ckUPtM5u+AEogYwDy5pCoMrGIwec6U0JlzqUdfKs/G6KhUUjpBXMj83GLK0sqtm7sBTi
         TJwtJlX6593K4yBBzJTsUPjgFCtwqAXcG6lLRpaBMP7vbqbuvVB/YwYJZde2AzP8VtUG
         79Fx7IcfNHjicMe1BtHA6xxW3e+foAfhWNthgkkG6Pd04D/UhEBztYXHrxoSpWJnCEZu
         2Gng==
X-Gm-Message-State: AElRT7H1jwNvWqpAC9m6dO39EOgwYRY5QaDqYwX/fsMC7+efBM0BhYyp
        Ss7c5dWIwD+eLeZ+caN1nZU=
X-Google-Smtp-Source: AG47ELu/hRJn/bLpSBkaB9vxZm570p+DtttJ/vpKsdS/kKnSKkzdKFJ7bmHHcpbuHG1UeV2SBEzz1g==
X-Received: by 10.46.16.85 with SMTP id j82mr594882lje.139.1521225174464;
        Fri, 16 Mar 2018 11:32:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j199-v6sm1033275lfe.53.2018.03.16.11.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 11:32:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 09/11] pack-objects: shrink size field in struct object_entry
Date:   Fri, 16 Mar 2018 19:31:58 +0100
Message-Id: <20180316183200.31014-10-pclouds@gmail.com>
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

It's very very rare that an uncompressd object is larger than 4GB
(partly because Git does not handle those large files very well to
begin with). Let's optimize it for the common case where object size
is smaller than this limit.

Shrink size field down to 32 bits [1] and one overflow bit. If the size
is too large, we read it back from disk.

Add two compare helpers that can take advantage of the overflow
bit (e.g. if the file is 4GB+, chances are it's already larger than
core.bigFileThreshold and there's no point in comparing the actual
value).

A small note about the conditional oe_set_size() in
check_object(). Technically if we don't get a valid type, it's not
wrong if we set uninitialized value "size" (we don't pre-initialize
this and sha1_object_info will not assign anything when it fails to
get the info).

This how changes the writing code path slightly which emits different
error messages (either way we die). One of our tests in t5530 depends
on this specific error message. Let's just keep the test as-is and
play safe by not assigning random value. That might trigger valgrind
anyway.

[1] it's actually already 32 bits on Windows

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 49 ++++++++++++++++++++++++++----------------
 pack-objects.h         | 43 +++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9a0962cf31..14aa4acd50 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -274,7 +274,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
-		    entry->size > big_file_threshold &&
+		    oe_size_greater_than(entry, big_file_threshold) &&
 		    (st = open_istream(entry->idx.oid.hash, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
@@ -384,12 +384,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
+	unsigned long entry_size = oe_size(entry);
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
 	hdrlen = encode_in_pack_object_header(header, sizeof(header),
-					      type, entry->size);
+					      type, entry_size);
 
 	offset = entry->in_pack_offset;
 	revidx = find_pack_revindex(p, offset);
@@ -406,7 +407,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	datalen -= entry->in_pack_header_size;
 
 	if (!pack_to_stdout && p->index_version == 1 &&
-	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
+	    check_pack_inflate(p, &w_curs, offset, datalen, entry_size)) {
 		error("corrupt packed object for %s",
 		      oid_to_hex(&entry->idx.oid));
 		unuse_pack(&w_curs);
@@ -1412,6 +1413,8 @@ static void cleanup_preferred_base(void)
 
 static void check_object(struct object_entry *entry)
 {
+	unsigned long size;
+
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
 		struct pack_window *w_curs = NULL;
@@ -1431,13 +1434,14 @@ static void check_object(struct object_entry *entry)
 		 */
 		used = unpack_object_header_buffer(buf, avail,
 						   &type,
-						   &entry->size);
+						   &size);
 		if (used == 0)
 			goto give_up;
 
 		if (type < 0)
 			die("BUG: invalid type %d", type);
 		entry->in_pack_type = type;
+		oe_set_size(entry, size);
 
 		/*
 		 * Determine if this is a delta and if so whether we can
@@ -1505,7 +1509,7 @@ static void check_object(struct object_entry *entry)
 			 */
 			oe_set_type(entry, entry->in_pack_type);
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = entry->size;
+			entry->delta_size = oe_size(entry);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1513,14 +1517,17 @@ static void check_object(struct object_entry *entry)
 		}
 
 		if (oe_type(entry)) {
+			unsigned long size;
+
+			size = get_size_from_delta(p, &w_curs,
+				entry->in_pack_offset + entry->in_pack_header_size);
 			/*
 			 * This must be a delta and we already know what the
 			 * final object type is.  Let's extract the actual
 			 * object size from the delta header.
 			 */
-			entry->size = get_size_from_delta(p, &w_curs,
-					entry->in_pack_offset + entry->in_pack_header_size);
-			if (entry->size == 0)
+			oe_set_size(entry, size);
+			if (oe_size_less_than(entry, 1))
 				goto give_up;
 			unuse_pack(&w_curs);
 			return;
@@ -1535,13 +1542,15 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &entry->size));
+	oe_set_type(entry, sha1_object_info(entry->idx.oid.hash, &size));
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
 	 * as a preferred base.  Doing so can result in a larger
 	 * pack file, but the transfer will still take place.
 	 */
+	if (entry->type_valid)
+		oe_set_size(entry, size);
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1581,6 +1590,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
+	unsigned long size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -1593,7 +1603,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
-	oi.sizep = &entry->size;
+	oi.sizep = &size;
 	oi.typep = &type;
 	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
@@ -1603,10 +1613,11 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * and dealt with in prepare_pack().
 		 */
 		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
-						    &entry->size));
+						    &size));
 	} else {
 		oe_set_type(entry, type);
 	}
+	oe_set_size(entry, size);
 }
 
 /*
@@ -1746,7 +1757,7 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (big_file_threshold < entry->size)
+		if (oe_size_greater_than(entry, big_file_threshold))
 			entry->no_try_delta = 1;
 	}
 
@@ -1775,6 +1786,8 @@ static int type_size_sort(const void *_a, const void *_b)
 	const struct object_entry *b = *(struct object_entry **)_b;
 	enum object_type a_type = oe_type(a);
 	enum object_type b_type = oe_type(b);
+	unsigned long a_size = oe_size(a);
+	unsigned long b_size = oe_size(b);
 
 	if (a_type > b_type)
 		return -1;
@@ -1788,9 +1801,9 @@ static int type_size_sort(const void *_a, const void *_b)
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
@@ -1877,7 +1890,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return 0;
 
 	/* Now some size filtering heuristics. */
-	trg_size = trg_entry->size;
+	trg_size = oe_size(trg_entry);
 	if (!DELTA(trg_entry)) {
 		max_size = trg_size/2 - 20;
 		ref_depth = 1;
@@ -1889,7 +1902,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 						(max_depth - ref_depth + 1);
 	if (max_size == 0)
 		return 0;
-	src_size = src_entry->size;
+	src_size = oe_size(src_entry);
 	sizediff = src_size < trg_size ? trg_size - src_size : 0;
 	if (sizediff >= max_size)
 		return 0;
@@ -2009,7 +2022,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-		freed_mem += n->entry->size;
+		freed_mem += oe_size(n->entry);
 		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
@@ -2459,7 +2472,7 @@ static void prepare_pack(int window, int depth)
 			 */
 			continue;
 
-		if (entry->size < 50)
+		if (oe_size_less_than(entry, 50))
 			continue;
 
 		if (entry->no_try_delta)
diff --git a/pack-objects.h b/pack-objects.h
index a66c37e35a..5c7e15ca92 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -69,7 +69,9 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
+	/* object uncompressed size _if_ size_valid is true */
+	uint32_t size_;
+	unsigned size_valid:1;
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
@@ -257,4 +259,43 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 		e->delta_sibling_idx = 0;
 }
 
+static inline unsigned long oe_size(const struct object_entry *e)
+{
+	if (e->size_valid) {
+		return e->size_;
+	} else {
+		unsigned long size;
+
+		sha1_object_info(e->idx.oid.hash, &size);
+		return size;
+	}
+}
+
+static inline int oe_size_less_than(const struct object_entry *e,
+				    unsigned long limit)
+{
+	if (e->size_valid)
+		return e->size_ < limit;
+	if (limit > maximum_unsigned_value_of_type(uint32_t))
+		return 1;
+	return oe_size(e) < limit;
+}
+
+static inline int oe_size_greater_than(const struct object_entry *e,
+				       unsigned long limit)
+{
+	if (e->size_valid)
+		return e->size_ > limit;
+	if (limit <= maximum_unsigned_value_of_type(uint32_t))
+		return 1;
+	return oe_size(e) > limit;
+}
+
+static inline void oe_set_size(struct object_entry *e,
+			       unsigned long size)
+{
+	e->size_ = size;
+	e->size_valid = e->size_ == size;
+}
+
 #endif
-- 
2.16.2.903.gd04caf5039

