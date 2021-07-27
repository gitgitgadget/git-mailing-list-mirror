Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751D6C4320E
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C4B6023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhG0VVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhG0VVV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA25C061A1A
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:50 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 185so386781iou.10
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=14VoMTqRstgjyVn8leZFzzcDtR0358hVMjUWCoofY0k=;
        b=XxOkzepAqpCkh9ofNpHkclLDx2bsWwexgu+aJYjy1UTtLmdqfNCZnVOIVHC9sxWIbt
         1hdlfv6+m2q55PqaGnQ2AdUGPkdknmWtE1K/0yVegfxo5XgBNWuhfIgcTffUv/iLT4tx
         p86fWXPavje8bhsRDSq/nlbDC6Fejwbfn4JoLt5x7FpSux4uHC7BiPVaHa5x2HlYVhpH
         kMElc5mmP7esLgmIB3tauREgmZ1QjwTvZ/h4xKJCANnfS82rzIBfUQjJ6ZlUXcJGEFno
         Qi28avyuYF4D0+qC9K0+S1LfvisvxKoWRsfppbIxsEG80NgvDualnZmHlb2y8mG6JWhS
         GnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=14VoMTqRstgjyVn8leZFzzcDtR0358hVMjUWCoofY0k=;
        b=rCIMha0m2juh1usLay3ItnpMHpaaxRwX2730n5Eydc8Yi0VlBfTSiEwXWpL7Y9pFpV
         xklNqqXS9u5gRQQ/cCqVFFJQM21nhvXJJV/VGtwB1ko/1YBlHuk3RFdKTxPof8iAb7P3
         nojdvrBWMTN3CBTtOUhMZ4ALLBQNBgtY+JEYXfL0S0cbFUgzAcrZ7kFLH+B23tMI4kFv
         Uxb/hZ8impB1coGt4XPDlz6GgokU4hzLtswwezp8U9Kr4X8z9vLD0uTamk55CSlDLLZp
         Ewn7EhJMvMdHxAfej2Fe+tC3LaK19Xk9Sqq/L4sfgKdYxqsniyf8f6NbNHPcOnHGkWmF
         N7Iw==
X-Gm-Message-State: AOAM530x9d4w1IMo4GYTNmmjoyGVv30FWPnToYC/ABsUMkbf8C6XBghk
        3z6/UnQa9j3ihNh4oDt19x2n4wcm+wQew2LX
X-Google-Smtp-Source: ABdhPJzprSGglQJ1j0t+F8UfN8Fha95NxJpgAVNb8R3reTY0TG+4GgawgAbAz7Fy7Se55ReI9s35Xg==
X-Received: by 2002:a02:bb12:: with SMTP id y18mr22768651jan.66.1627420790094;
        Tue, 27 Jul 2021 14:19:50 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id u16sm2997915iob.41.2021.07.27.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:49 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 10/25] pack-bitmap.c: introduce 'bitmap_num_objects()'
Message-ID: <ca7f726abf825c30105ae330a12e0c7d20684076.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
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
index a73960a55d..54dc4f7915 100644
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
@@ -399,7 +404,7 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_git->pack->num_objects;
+		return bitmap_pos + bitmap_num_objects(bitmap_git);
 	}
 
 	return -1;
@@ -451,7 +456,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_git->pack->num_objects;
+	return bitmap_pos + bitmap_num_objects(bitmap_git);
 }
 
 struct bitmap_show_data {
@@ -668,7 +673,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_git->pack->num_objects + i))
+		if (!bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -826,7 +831,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -853,7 +858,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < pack->num_objects) {
+	if (pos < bitmap_num_objects(bitmap_git)) {
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
@@ -863,7 +868,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		}
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - pack->num_objects];
+		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
@@ -905,7 +910,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == OBJ_BLOB &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos) &&
@@ -1131,8 +1136,8 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_git->pack->num_objects)
-		return; /* not actually in the pack */
+	if (pos >= bitmap_num_objects(bitmap_git))
+		return; /* not actually in the pack or MIDX */
 
 	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
@@ -1198,6 +1203,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
+	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
 
 	assert(result);
 
@@ -1205,8 +1211,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		i++;
 
 	/* Don't mark objects not in the packfile */
-	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
-		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
+	if (i > objects_nr / BITS_IN_EWORD)
+		i = objects_nr / BITS_IN_EWORD;
 
 	reuse = bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
@@ -1290,7 +1296,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git->pack->num_objects + i))
+			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1511,7 +1517,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
-	num_objects = bitmap_git->pack->num_objects;
+	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -1594,7 +1600,6 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1606,7 +1611,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, pack->num_objects + i))
+		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-- 
2.31.1.163.ga65ce7f831

