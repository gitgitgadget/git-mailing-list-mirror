Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E70B1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965985AbeCHLnm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:42 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36056 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeCHLnl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:41 -0500
Received: by mail-pl0-f65.google.com with SMTP id 61-v6so3173269plf.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atVO7gs1CBxGA2gtZOEFov/gfadrNjvLzpeFpetZ0Jc=;
        b=n9Qr4spwDCFyeBLITtXwFQnh210fr0AfIFpB7wWLwdz5PkGQZyI+ngUZSxZG7gxfX1
         Mh5OhEyg5oPrW590ljmtRNJ8yrLxLK/FVUTdgVQp2dnW+eaHuLQmbV4R67nz7qQEQMGI
         y3NcWi14Gt2Xm0cfUMMqNok4KXq1MARAymaQhupLEd1nFZTZd6a6sw8IpWcZUp8xS5cW
         D0IfMyKMFw6qOs9Lf2Ig4JVzNyOKgCyS/ZdvyvKkweDb9DtNSsXk7fF4vcIjdlm93JPq
         BapUCrwwvtouzrLbBIDCVbLOmcRcP784FTuO3UjtvZb/nt3caag2DlSWdDMDuM8SjcsH
         BcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atVO7gs1CBxGA2gtZOEFov/gfadrNjvLzpeFpetZ0Jc=;
        b=dLv8ybNL3K6nuAx8Fnribitn63GWmTy8AJkyUKjwa50ZPkpz2+ghrTL1x/gFYb9YUv
         NKAS5gU5OfWbvvifoyByUzvs403qqhzU/QhblP3fZk1PdJRMh559BsusZqwNTiZBZsJT
         At5PvSLMMY3Vk2CG4dFI4PAEBIqYay0x3rTHELyyMU69f292hpmzL4YDjHlEc5x7NSDM
         C7L60IRkOxKyrvQaMqCNPrmlnIWtJDeYvfrQONv0+uAn+5yJIt8Jp6jyYO3P1eMcHAdA
         WcSzLd5fNlWuBcEwPAU3R5VQxtZETgVGypCtGdEb28A74JJExw2L++/yypF8QU/PAr+9
         1wrg==
X-Gm-Message-State: APf1xPDcGbr8N50qcQssIcQzgoOf5/CKsxf8e0g6hzrQnQpTFSpdPXP3
        jSDD64DM1HRXfp0lsQfFFNY=
X-Google-Smtp-Source: AG47ELvMBXEXD83eT/CkneBtDKE5E23fPxn9RYcAWkEYsqvqM5sIZVhXL2gFBeiScGSm75TW5gOLCw==
X-Received: by 2002:a17:902:28c3:: with SMTP id f61-v6mr24218142plb.346.1520509421032;
        Thu, 08 Mar 2018 03:43:41 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id a13sm34543277pgd.1.2018.03.08.03.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 11/12] pack-objects: shrink size field in struct object_entry
Date:   Thu,  8 Mar 2018 18:42:31 +0700
Message-Id: <20180308114232.10508-12-pclouds@gmail.com>
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

It's very very rare that an uncompressd object is larger than
4GB (partly because Git does not handle those large files very well to
begin with). Let's optimize it for the common case where object size is
smaller than this limit.

Shrink size field down to 32 bits [1] and one overflow bit. If the size
is too large, we read it back from disk.

Add two compare helpers that can take advantage of the overflow
bit (e.g. if the file is 4GB+, chances are it's already larger than
core.bigFileThreshold and there's no point in comparing the actual
value).

There's no actual saving from this due to holes. Which should be gone in
the next patch.

[1] it's actually already 32 bits on 64-bit Windows

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 49 ++++++++++++++++++++++++++----------------
 pack-objects.h         | 48 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39920061e9..db040e95db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -274,7 +274,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (entry->type == OBJ_BLOB &&
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
 			entry->type = entry->in_pack_type;
 			SET_DELTA(entry, base_entry);
-			entry->delta_size = entry->size;
+			entry->delta_size = oe_size(entry);
 			entry->delta_sibling_idx = base_entry->delta_child_idx;
 			SET_DELTA_CHILD(base_entry, entry);
 			unuse_pack(&w_curs);
@@ -1513,14 +1517,17 @@ static void check_object(struct object_entry *entry)
 		}
 
 		if (entry->type) {
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
@@ -1535,13 +1542,14 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
+	entry->type = sha1_object_info(entry->idx.oid.hash, &size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
 	 * as a preferred base.  Doing so can result in a larger
 	 * pack file, but the transfer will still take place.
 	 */
+	oe_set_size(entry, size);
 }
 
 static int pack_offset_sort(const void *_a, const void *_b)
@@ -1581,6 +1589,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
+	unsigned long size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -1593,7 +1602,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	SET_DELTA(entry, NULL);
 	entry->depth = 0;
 
-	oi.sizep = &entry->size;
+	oi.sizep = &size;
 	oi.typep = &type;
 	if (packed_object_info(IN_PACK(entry), entry->in_pack_offset, &oi) < 0) {
 		/*
@@ -1603,11 +1612,13 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * and dealt with in prepare_pack().
 		 */
 		entry->type = sha1_object_info(entry->idx.oid.hash,
-					       &entry->size);
+					       &size);
+		oe_set_size(entry, size);
 	} else {
 		if (type < 0)
 			die("BUG: invalid type %d", type);
 		entry->type = type;
+		oe_set_size(entry, size);
 	}
 }
 
@@ -1748,7 +1759,7 @@ static void get_object_details(void)
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
-		if (big_file_threshold < entry->size)
+		if (oe_size_greater_than(entry, big_file_threshold))
 			entry->no_try_delta = 1;
 	}
 
@@ -1775,6 +1786,8 @@ static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
+	unsigned long a_size = oe_size(a);
+	unsigned long b_size = oe_size(b);
 
 	if (a->type > b->type)
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
index cbb39ab568..0253df6cd4 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -71,7 +71,11 @@ enum dfs_state {
  */
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;	/* uncompressed size */
+	/* object uncompressed size _if_ size_valid is true */
+	uint32_t size_;
+
+	/* XXX 4 bytes hole, try to pack */
+
 	off_t in_pack_offset;
 	uint32_t delta_idx;	/* delta base object */
 	uint32_t delta_child_idx; /* deltified objects who bases me */
@@ -93,6 +97,7 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned size_valid:1;
 
 	/* XXX 8 bits hole, try to pack */
 
@@ -104,7 +109,7 @@ struct object_entry {
 	*/
 	unsigned z_delta_size:OE_Z_DELTA_BITS;
 
-	/* size: 88, bit_padding: 2 bits */
+	/* size: 88, bit_padding: 1 bits */
 };
 
 struct packing_data {
@@ -252,4 +257,43 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
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
2.16.2.873.g32ff258c87

