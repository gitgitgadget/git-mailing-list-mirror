Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B923C1B0D9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ED123A33
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgLHWF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbgLHWFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:22 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A49C0611C5
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:42 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id w3so206431otp.13
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LViEVk8iVCd/Fue2tk1lTGL+H9g9t3D0HHU/a47NVcM=;
        b=WJJc9T2dTmzJKUZTiFKZk/LaSvr4E5kCNTDb0tVr+wMGjLHjw+AvePsPHTAmHrsEKB
         3bcbiRQGNF1RQ7P1pSEoo+fVbLSykXJz+fRbSnl/4nhKxZwt8LF8yU70j4/921qMo6UO
         dU0gOFruEfXVMFCetodF6kHVHRpP2Mua4mlCsB+c7An+Lp4kbOejpoH2xdcS+PBaJdub
         zzppijdYF9UATQh9Mf9xFxkYTvbYpNTODp2TVXyPDXShkkOma/0EUjq1q3c3eebjyKrl
         NnKUsN3Xn/e0mfesBhgeAUQ9e2a8OgBmLV8cK/Of55cPUa0ungk5odoexw2MzMHmYQa1
         Z6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LViEVk8iVCd/Fue2tk1lTGL+H9g9t3D0HHU/a47NVcM=;
        b=Gz6sojtZ/0BzKGuvOaHZv0I+dSZh6xtC0pOqpy5ZzXsdg2xqaDPU6i9Hv2Y5fpmEt0
         DvywyoOHKgSJL4lDdBu9cXudllqg+ypxPpZDHLPlKGHU436sL70sY1xP2APMCUxCpB2H
         9M/W/oTl1hCr5Rlzl/SkmBU6HV5gtk4028oX6Z9+v/IlG1SZZ9+8muVCB/gxctFVamXi
         bT0JYuIeLje2BsnmSkIOgIkV4++Z7pE7608FmX2zX6EK24cO2T4w4YLUKZFhTTq7Kc1y
         92MHGKtP1qWB08ZjlWlQkdOulLAVCgQeYpUSFrh35rdpgtNLPCaRgACerTEmgcq+EzYD
         tuvA==
X-Gm-Message-State: AOAM5333fMmtICU7Adks29+5c4hyMdthViaKA9/oR01eUVRxhL8SS+dr
        QUiKVS7dJCYtGCmIzKcKJy/ERymbXrepdMcd
X-Google-Smtp-Source: ABdhPJxLLaCEEikBDGiWwi2+jlLiHghmxo+a4NmvpMI15l36VyiejiK2JRJlWc7R2GrOIeh4LXpweQ==
X-Received: by 2002:a9d:7e7:: with SMTP id 94mr141497oto.370.1607465081145;
        Tue, 08 Dec 2020 14:04:41 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v92sm10052otb.75.2020.12.08.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:40 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 20/24] pack-bitmap: factor out 'bitmap_for_commit()'
Message-ID: <4d7a4184ac141115ef2ede59d9af30ae47b3a387.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
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
2.29.2.533.g07db1f5344

