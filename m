Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAA0C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A928A60FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhFUW1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhFUW1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1025C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:25 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s19so10009877ilj.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1SYv7+wUvvYTf/8JQBOtwl3b13isRISBnBtPBogQU0=;
        b=mEk68v22ZjkJU6vh0mznXf7JM8Ka7shlzBlOjPe30HXk6whoswZDAMg2zu1NNg2134
         7vxMOOBldtubTV+/Jjs0xebeJ86tdoBVxf88QGstmVhNL3JOkY96uD094jLCpMPLW0Os
         WxM6BSX1X24J8/O+GV4lPzEaP+z++qjvOiCyK8OVslAUW8Xf5BVSZqcUFbdv5tRPg6qE
         uF0FE7kFStF5M46O3B9OdnKT1z5ciGmGcDYssacF3obH1lOgleDctFO1iQDpSubZk8op
         UUmAENy/2+YQJBPDiW0U1lqCWwW5Bw+sE0nS9ojDVY3mk6v0D/OO7JD9jKMnrEZZ/Ct+
         27Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1SYv7+wUvvYTf/8JQBOtwl3b13isRISBnBtPBogQU0=;
        b=sx5OL86bX26yYXoeob+G2irRNpN5gmohQCjOdc5uLIdYKtuMnX9MNnqAcFRb2Rrr5P
         bnZzYynfx/Z9ku97MOMgJCDjfXkIhua9C49n5m47f+pfpCsMgr7lNHysharE7ytvsDYl
         6uWVlKEqn9hp/U+Fag6c6QvB9f3mUbMglfWM6L+TMucoZG5E6NiOgO92QfWWB7qXv/oR
         I52FOpRIasHPfa4uzO59z4vzZIUvJz+s64XrgOvnBW0l7/HrHKWsmgVz0fhd/HsiRmoS
         MRFM0H8UApb7VMaD2XslNWHtFtu7fHVE8V3W7sxezlLofYAmx8YG+R8htqQJFEsvLI7u
         KiHg==
X-Gm-Message-State: AOAM531+68SY82SSp9ZjFXp/Dt3EkHL9FjGzqHVp3YjfO5v1DOg9j66B
        pJovs5j2WevsCVSIgf1l+1Xz4+Vw/gWOkbsy
X-Google-Smtp-Source: ABdhPJzkPhBufgqp3qZ/hjbJsb8wiwu/+U2LnimS/lTgisidspykSFEqKaZFr3EEtb/fQWMC3FyGTg==
X-Received: by 2002:a05:6e02:66e:: with SMTP id l14mr336004ilt.211.1624314324866;
        Mon, 21 Jun 2021 15:25:24 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id w1sm6499287ill.3.2021.06.21.15.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:24 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 10/24] pack-bitmap.c: introduce 'bitmap_num_objects()'
Message-ID: <373aa47528ce8bd4bb044a82a7e80312476f1b5f.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
index 368fa59a42..2dc135d34a 100644
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
@@ -650,7 +655,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_git->pack->num_objects + i))
+		if (!bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -808,7 +813,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -835,7 +840,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < pack->num_objects) {
+	if (pos < bitmap_num_objects(bitmap_git)) {
 		off_t ofs = pack_pos_to_offset(pack, pos);
 		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
 			struct object_id oid;
@@ -845,7 +850,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		}
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - pack->num_objects];
+		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
@@ -887,7 +892,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 	}
 
 	for (i = 0; i < eindex->count; i++) {
-		uint32_t pos = i + bitmap_git->pack->num_objects;
+		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == OBJ_BLOB &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos) &&
@@ -1113,8 +1118,8 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_git->pack->num_objects)
-		return; /* not actually in the pack */
+	if (pos >= bitmap_num_objects(bitmap_git))
+		return; /* not actually in the pack or MIDX */
 
 	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
@@ -1180,6 +1185,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
+	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
 
 	assert(result);
 
@@ -1187,8 +1193,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		i++;
 
 	/* Don't mark objects not in the packfile */
-	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
-		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
+	if (i > objects_nr / BITS_IN_EWORD)
+		i = objects_nr / BITS_IN_EWORD;
 
 	reuse = bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
@@ -1272,7 +1278,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git->pack->num_objects + i))
+			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1493,7 +1499,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
-	num_objects = bitmap_git->pack->num_objects;
+	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -1576,7 +1582,6 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1588,7 +1593,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, pack->num_objects + i))
+		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-- 
2.31.1.163.ga65ce7f831

