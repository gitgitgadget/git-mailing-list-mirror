Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B5C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C86B241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wDL3JinQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgKQVsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgKQVsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:48:19 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2FC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:18 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id u23so4175062qvf.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eid1orQflA5dQESKfzDY36urrmCU8GuKTyfyOBrz318=;
        b=wDL3JinQlj+o3czGxNiG0w85utgzdLuNcibAq0OuQ427aVT3Gsx9LUPWqrLmvafUJN
         R4zCCuvBhKJb3/hJw0XAkT97KJlRGdz20jZGEeDNGFcakGgROBB28G4OgomgXkyuTWWJ
         OufXuc6GuGm8Ak9oJlPM/LFulT4AVnyH0Gx7kCEv9+3JW0/zmbHENOeBAP9BOoVLkoVc
         3okmO/fAUhBmMupSWVtkupqInQspuIM2gsW3odZ1E6ct6NzlCGeZK3sBtGB57hH+6lFB
         y9A73XYnuB2HVkJF9+op+UIHiMNrOoIqiTdov2/4MsznQP0SFkPKjmwt9mTgnjlg5dFE
         besQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eid1orQflA5dQESKfzDY36urrmCU8GuKTyfyOBrz318=;
        b=MAv5LHASHR3qPyoVtT/x8rsRyGKzaIfiU7q+Ke/du5RAdkQtuloQ1MJoruHgkzlUJa
         UoqiXsmFuOatSbgx5AJeyTY3Ey5KfyremOD5+ah5ROvle3ySIcK/TvQ9JtptmpAHJRTq
         sYBR1/SM9ARXy7FiPPMvUjUbLsTJkRlhj0HSf7u9lhQUHzBerKQb5Y2PFzgTt7NpBp8j
         9DHEVIcyjFu2k/DpkK71lFEaSdiOysbsmdC1km1D0a16M5I3AQ8HueRQdsnvdeD5Eb3i
         6icQMaZe/XQZ3KllxSios5E2clVEKiD3JEdKhSRS7suLysuHgUdqGFz7hJtKHw6BPHwr
         7aEQ==
X-Gm-Message-State: AOAM53296GBzyqwaOI0w3p+2KfIjHPorRsPkY6DCIAW3KFHLB7fKv3td
        Zmy9jXh/DYL4IeMmbpLTQ2LNKfD/C+ZF6qhA
X-Google-Smtp-Source: ABdhPJwj8ireI1QBqWnuf/R+OWFamPYvtmncj0hIcUVSQRUaHzkwLmREkF73NT7FWc5gUQGpclkN5g==
X-Received: by 2002:a05:6214:247:: with SMTP id k7mr1482891qvt.32.1605649697636;
        Tue, 17 Nov 2020 13:48:17 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id p73sm15533051qka.79.2020.11.17.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:48:17 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:48:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 20/24] pack-bitmap: factor out 'bitmap_for_commit()'
Message-ID: <9928b3c7da33edd8d4beae006a74dd682daf5fa5.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of callers within pack-bitmap.c duplicate logic to lookup a
given object id in the bitamps khash. Factor this out into a new
function, 'bitmap_for_commit()' to reduce some code duplication.

Make this new function non-static, since it will be used in later
commits from outside of pack-bitmap.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 33 +++++++++++++++++++--------------
 pack-bitmap.h |  2 ++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d1368b69bb..5efb8af121 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -380,6 +380,16 @@ struct include_data {
 	struct bitmap *seen;
 };
 
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit)
+{
+	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
+					   commit->object.oid);
+	if (hash_pos >= kh_end(bitmap_git->bitmaps))
+		return NULL;
+	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
+}
+
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
@@ -465,10 +475,10 @@ static void show_commit(struct commit *commit, void *data)
 
 static int add_to_include_set(struct bitmap_index *bitmap_git,
 			      struct include_data *data,
-			      const struct object_id *oid,
+			      struct commit *commit,
 			      int bitmap_pos)
 {
-	khiter_t hash_pos;
+	struct ewah_bitmap *partial;
 
 	if (data->seen && bitmap_get(data->seen, bitmap_pos))
 		return 0;
@@ -476,10 +486,9 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 	if (bitmap_get(data->base, bitmap_pos))
 		return 0;
 
-	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, *oid);
-	if (hash_pos < kh_end(bitmap_git->bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, hash_pos);
-		bitmap_or_ewah(data->base, lookup_stored_bitmap(st));
+	partial = bitmap_for_commit(bitmap_git, commit);
+	if (partial) {
+		bitmap_or_ewah(data->base, partial);
 		return 0;
 	}
 
@@ -498,8 +507,7 @@ static int should_include(struct commit *commit, void *_data)
 						  (struct object *)commit,
 						  NULL);
 
-	if (!add_to_include_set(data->bitmap_git, data, &commit->object.oid,
-				bitmap_pos)) {
+	if (!add_to_include_set(data->bitmap_git, data, commit, bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
 		while (parent) {
@@ -1282,10 +1290,10 @@ void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
 	struct bitmap *result = NULL;
-	khiter_t pos;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
 	struct bitmap_index *bitmap_git;
+	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
 		die("failed to load bitmap indexes");
@@ -1297,12 +1305,9 @@ void test_bitmap_walk(struct rev_info *revs)
 		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
-	pos = kh_get_oid_map(bitmap_git->bitmaps, root->oid);
-
-	if (pos < kh_end(bitmap_git->bitmaps)) {
-		struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-		struct ewah_bitmap *bm = lookup_stored_bitmap(st);
+	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
+	if (bm) {
 		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index afa4115136..25dfcf5615 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -78,6 +78,8 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest);
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
 void bitmap_writer_build(struct packing_data *to_pack);
-- 
2.29.2.312.gabc4d358d8

