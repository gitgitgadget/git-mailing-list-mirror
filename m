Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443121F404
	for <e@80x24.org>; Sun, 18 Mar 2018 14:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeCRO0M (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 10:26:12 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42930 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbeCROZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 10:25:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id a22-v6so21708521lfg.9
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7cxQCYB/gUls2mLByACS3X7DpiK12yhJ5FBqAOBp2o=;
        b=LtwuHsV5HysOSOffy2Ua04QqfAatf4d9B0WfmhgKekgvhGgysgW7G7LPfjMSWoQq19
         HykhKguriDgJP4YoJnc0Goxev7RetCtlgBa7QuLxWUlNZIBnGWKi9qjuJyjK+MU4D+9h
         ukAmtNmZe5PfETAsX058rD55pthQ8+oaNZVDWBtqF9AUeegpR4mMAwky9nadwn6Q7znz
         h/tR9B78uhR+CZwxCbhYIExXHod372lRuCh3ULmDy0Fz4fhK0bK6iTydmmgxY0ziufxq
         D7nMVkVFfXYIDfeIwzASdC7PDloF8rRSttqppuPGxQHdjyPyBrRqwO53PoTnJaweKyCP
         DV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7cxQCYB/gUls2mLByACS3X7DpiK12yhJ5FBqAOBp2o=;
        b=Wjvz6Uz3b5XqMHAs0++h4vXg/FdRveQtVVlOGxLzr+i+J7j9KBfYIgxyr33muzNcpP
         vI4tSutdw9LA+cA5Awo79QpTJl84CZNKIv7p0a6FziUrokMbD1J87MKe6wX0ruGclEAs
         b0Mxf3ohvtveNohbmKDbRWmfIn/4BSy06xB+DxClAZqiZGExvNG/MiLH9Ce0K/Y+cEH5
         M5w1G9rOTxDSpwkUjye1a+iT1vV+ZE3AxIPC2vblVEUe1PbUTsFAVi9r6sAhOBLGEmrC
         I0Vq9XED0v0Rq2RDcHNeOeogiAS+M38Kqvqa294V16rbnPVyqENjK9XzGaHleY+TtNM9
         MViQ==
X-Gm-Message-State: AElRT7ECsPhYbd0i/FHANSJ0AdXLVkp1tWXZ/Wx7hwVH7Z/0G+44OfcG
        TPrTsx7FcCgEUfdc8As6CNb3tQ==
X-Google-Smtp-Source: AG47ELvwYWqkEKvEhXN2JEWzw70MzeBKqs4cGBL9+zBMTh+GrVawSJQmDJp+ynUCjbs4r0YaeKra5w==
X-Received: by 2002:a19:9855:: with SMTP id a82-v6mr5724841lfe.49.1521383150742;
        Sun, 18 Mar 2018 07:25:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n24sm2551554ljg.22.2018.03.18.07.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 07:25:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 09/11] pack-objects: shrink size field in struct object_entry
Date:   Sun, 18 Mar 2018 15:25:24 +0100
Message-Id: <20180318142526.9378-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180318142526.9378-1-pclouds@gmail.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's very very rare that an uncompressedd object is larger than 4GB
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
 builtin/pack-objects.c | 49 ++++++++++++++++++++++-------------
 pack-objects.h         | 58 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 19 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 372afe48c4..89ed4b5125 100644
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
index c12219385a..0beedbc637 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -70,7 +70,9 @@ enum dfs_state {
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
@@ -258,4 +260,58 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
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
+static inline int oe_fits_in_32bits(unsigned long limit)
+{
+	uint32_t truncated_limit = (uint32_t)limit;
+
+	return limit == truncated_limit;
+}
+
+static inline int oe_size_less_than(const struct object_entry *e,
+				    unsigned long limit)
+{
+	if (e->size_valid)
+		return e->size_ < limit;
+	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+		return 0;
+	return oe_size(e) < limit;
+}
+
+static inline int oe_size_greater_than(const struct object_entry *e,
+				       unsigned long limit)
+{
+	if (e->size_valid)
+		return e->size_ > limit;
+	if (oe_fits_in_32bits(limit)) /* limit < 2^32 <= size ? */
+		return 1;
+	return oe_size(e) > limit;
+}
+
+static inline void oe_set_size(struct object_entry *e,
+			       unsigned long size)
+{
+	e->size_ = size;
+	e->size_valid = e->size_ == size;
+
+	if (!e->size_valid) {
+		unsigned long real_size;
+
+		if (sha1_object_info(e->idx.oid.hash, &real_size) < 0 ||
+		    size != real_size)
+			die("BUG: 'size' is supposed to be the object size!");
+	}
+}
+
 #endif
-- 
2.17.0.rc0.347.gf9cf61673a

