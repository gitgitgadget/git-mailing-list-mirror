Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95776C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A0860ED4
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbhHaUxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbhHaUxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93887C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:13 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i13so716206ilm.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/GeToTgrlnRlpxAA4v1x0rBIZOyzKeR/oh9triRL5M=;
        b=USuudZBS+OJtDF4MSyVG6xKbcU0IKYENkkLtnxD9T945vCFJn/i2MSbQ1Up9uNa9oW
         ZoUDeRhL13o6TJNPv7fXAXm0UWROww+lBNCMoYV0Hj+ontrXu0cjaGkLttNtqBkJicuA
         ocRJ4YoiinMT/wCcuOWwLa6s/Bsf1z3+dmWGqKsBz5ruPVOpwx/AdNUjv7qiwbwTxlhI
         Rb3tc6SNg0MpfpKVrES9D8tu2L+c1ifxFLV91DTYVHKraETP/VmKAWpSrZSIzuPeqD51
         InAITx5UFg7nMFQ0r7ijBD3Puo5r8EdlUi7kywVT/oc6vAIjYIzjLWdlsxcq3BtykA6F
         68PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/GeToTgrlnRlpxAA4v1x0rBIZOyzKeR/oh9triRL5M=;
        b=cOKFXUJEnNwO2afmL+FxgReACf6wnVAtCoqmXu2fsrYV6i6nLxdpra2qJhJDGCD9oi
         WJ/Ez/BbZSK/p4nyZVsVa4bH3HGGneiY8Eoq+OpwBJMoewDIzQJ6XXxX3ufuHQwyh6qm
         6/9QDRfD5dHE0p0QfwCz5F16Xu5Okrc+lXnTTry9+vpB2FlTHSg4G5vOSsidVIdO0F7/
         jgC2LT5n3eB8CoeHivRZXDyDgXOkNrBESCqe9fKgee+FVm3S5EpIRJLjNgjbAE3G6E6b
         2Yk2XQBYUkQLLigTmgOLdLwKJThfXErnMMF3uNEKjYs9s6+qHlo8rFevNZnrh+9JVh8v
         jThA==
X-Gm-Message-State: AOAM5320CR64aZU+4EX8qr1199xBbD+K6OHkK1oKhJdTqUc61qeTPS+D
        rcRIeuhzLoO/JqWtrxKjEVqzHIQhhOD9oQA7
X-Google-Smtp-Source: ABdhPJzGjfdGNSOOnVZzr2+8z8vyaWMiBJPZjwn1nXCpHbgae04djf/Xftqz4gzRrd86sBBIR2hxlQ==
X-Received: by 2002:a92:d20d:: with SMTP id y13mr21431449ily.294.1630443132889;
        Tue, 31 Aug 2021 13:52:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u16sm10140240iob.41.2021.08.31.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:12 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 12/27] pack-bitmap.c: introduce 'bitmap_num_objects()'
Message-ID: <4c793df9d13bfec35ca5dc10323a0a91c1ae7269.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch to support reading MIDX bitmaps will be less noisy
after extracting a generic function to return how many objects are
contained in a bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9b11af87aa..65356f9657 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -136,6 +136,11 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 	return b;
 }
 
+static uint32_t bitmap_num_objects(struct bitmap_index *index)
+{
+	return index->pack->num_objects;
+}
+
 static int load_bitmap_header(struct bitmap_index *index)
 {
 	struct bitmap_disk_header *header = (void *)index->map;
@@ -154,7 +159,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 	/* Parse known bitmap format options */
 	{
 		uint32_t flags = ntohs(header->options);
-		size_t cache_size = st_mult(index->pack->num_objects, sizeof(uint32_t));
+		size_t cache_size = st_mult(bitmap_num_objects(index), sizeof(uint32_t));
 		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
@@ -404,7 +409,7 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_git->pack->num_objects;
+		return bitmap_pos + bitmap_num_objects(bitmap_git);
 	}
 
 	return -1;
@@ -456,7 +461,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_git->pack->num_objects;
+	return bitmap_pos + bitmap_num_objects(bitmap_git);
 }
 
 struct bitmap_show_data {
@@ -673,7 +678,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_git->pack->num_objects + i))
+		if (!bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -832,7 +837,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -859,7 +864,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < pack->num_objects) {
+	if (pos < bitmap_num_objects(bitmap_git)) {
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
@@ -869,7 +874,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		}
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - pack->num_objects];
+		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
@@ -911,7 +916,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == OBJ_BLOB &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos) &&
@@ -1137,8 +1142,8 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_git->pack->num_objects)
-		return; /* not actually in the pack */
+	if (pos >= bitmap_num_objects(bitmap_git))
+		return; /* not actually in the pack or MIDX */
 
 	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
@@ -1204,6 +1209,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
+	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
 
 	assert(result);
 
@@ -1211,8 +1217,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		i++;
 
 	/* Don't mark objects not in the packfile */
-	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
-		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
+	if (i > objects_nr / BITS_IN_EWORD)
+		i = objects_nr / BITS_IN_EWORD;
 
 	reuse = bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
@@ -1296,7 +1302,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git->pack->num_objects + i))
+			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1517,7 +1523,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
-	num_objects = bitmap_git->pack->num_objects;
+	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -1600,7 +1606,6 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1612,7 +1617,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, pack->num_objects + i))
+		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-- 
2.33.0.96.g73915697e6

