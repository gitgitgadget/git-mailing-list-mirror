Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9413C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B996F610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhDISLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhDISLp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C0C061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d2so5431942ilm.10
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQJpJBcl+ocwZEOaMQu2s4dVVytvNTme32SUj0y6IZI=;
        b=TG6QhqhSrV67ykvwg4X68+TSKQzALl06iumw5y+v38/fMsxtb5xQn5VPdg3twxodiL
         j/1LGRuA4q9++3Y9TR2Agsf/WDx6QW8cTw16FDM61xHcom98W/XmjfGFtzJUmzC2BH5Q
         awvdHD5aPBpQ54w8EJOSIdbu2LnGpb7DZUPXKKZP0/wgMQL7QQ9JHSBNp9G0n3FXS9aG
         HWmwaeuhnLqzhtmAi0RDbocS8RVGBF49tuznv0gDKSPjkvEOT4mgHs9p90AI/+tV/Wvo
         8XrWFEC+CvkU0JxeJ9ijCbDYr65XGkwmv1czrFESariL980QQhgMPwuYQubLWzLEjm9a
         7JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQJpJBcl+ocwZEOaMQu2s4dVVytvNTme32SUj0y6IZI=;
        b=WSO5jSWnP6drB0SNROt0X06CTKzHc/BfNL/OkbJW040s/Czv3fSZm+OtedWbymWjgB
         9uLOvP4x1iXRsZ3oi69rHZK7TvGApQQbcDn/MC55uYmi9T/ZBLXBedU8G1ct7zpaxa5p
         moBtCaLVf39D7qkkiCCgWvn60ROBiaieYL7nozfa4GkgtrBE6u8x0yOS64Q5y7kt3nCt
         ospO+Jhyf++YBLQpZC93hlJ/v9i9kFYB8cm8UGw3zJLjtAnEIGwipG22K1gYqetpl6TR
         qKmWiXmAHTFEdm+i+T2kPuLigMV7TYLbGMlwLm7x3KdncphbGmwXYAltY28j3eiSg/Ja
         GHMw==
X-Gm-Message-State: AOAM533rWy/v7sCItfe+RH7Qh3tFB1mC+kdQr7ce8LkyssGafkG0TN4D
        PzxzbY9j5kNryGcJ5W/9JG/EoHdkyAjtY+2z
X-Google-Smtp-Source: ABdhPJxIvqMvbd+rx/nG2gFcCBSnEO2z0xTT4vF2GfVr3yDWrK/bNPvDib6ItLXxYOz4Os9lSV8TaQ==
X-Received: by 2002:a92:c214:: with SMTP id j20mr7270761ilo.178.1617991891668;
        Fri, 09 Apr 2021 11:11:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id e6sm1565576ioq.13.2021.04.09.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:31 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 09/22] pack-bitmap.c: introduce 'bitmap_num_objects()'
Message-ID: <af507f4b29b6fcb79556dd8e6daea2fcc0d4b9bf.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
index d45e91db1e..a6c616aa3e 100644
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
@@ -647,7 +652,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
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
@@ -1075,8 +1080,8 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	enum object_type type;
 	unsigned long size;
 
-	if (pos >= bitmap_git->pack->num_objects)
-		return; /* not actually in the pack */
+	if (pos >= bitmap_num_objects(bitmap_git))
+		return; /* not actually in the pack or MIDX */
 
 	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
 	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
@@ -1142,6 +1147,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
 	uint32_t offset;
+	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
 
 	assert(result);
 
@@ -1149,8 +1155,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		i++;
 
 	/* Don't mark objects not in the packfile */
-	if (i > bitmap_git->pack->num_objects / BITS_IN_EWORD)
-		i = bitmap_git->pack->num_objects / BITS_IN_EWORD;
+	if (i > objects_nr / BITS_IN_EWORD)
+		i = objects_nr / BITS_IN_EWORD;
 
 	reuse = bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
@@ -1234,7 +1240,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_git->pack->num_objects + i))
+			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1455,7 +1461,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
-	num_objects = bitmap_git->pack->num_objects;
+	num_objects = bitmap_num_objects(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -1538,7 +1544,6 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 {
 	struct bitmap *result = bitmap_git->result;
-	struct packed_git *pack = bitmap_git->pack;
 	struct eindex *eindex = &bitmap_git->ext_index;
 	off_t total = 0;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1550,7 +1555,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, pack->num_objects + i))
+		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-- 
2.31.1.163.ga65ce7f831

