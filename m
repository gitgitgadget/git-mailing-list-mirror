Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB5C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4644207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0kWXM6Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKKToK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgKKToK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:44:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C2C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:10 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q22so2917213qkq.6
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ToHhIdnfjJW8cH7okZum7KMkq/HVPVbdlqyPU4zMAZI=;
        b=0kWXM6CfVHbGDGQdY89jllyPc8pAOhJwUXUBRuznyULQy3t5MP5ppmvmAlg+soYxQe
         vxuv4E8wP56FWuVeTnhxjxB8QhqltluU6FwY2bL2Q0niCwpZpqEmKDlVNzODtqG4Jh36
         R8LgsAoL0U8aLDi8qOdKjhFPmSgcLdUZV4hUETLdZkRpC/M6f7VDejeCdojFEkkl2Wwb
         dkYMI+i/wAANsO6bO7FXO/5chEBXPS3trDpT3WWGCip9xVyjFMXmYSWnPZjH24AnZzzl
         S03pixDjuTKzEw5AB4qkj8dZj1PA+6M/8qkjU7XZfBZstCQNHJpcs1KC/dd7/YBUsNre
         9UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ToHhIdnfjJW8cH7okZum7KMkq/HVPVbdlqyPU4zMAZI=;
        b=VxzgLtV01nqIK2TzeYEIcXF8geNuvIRtZC/p0LtbXBeebZyE+8GfQiCQXJTwBY9Avi
         YoCWPW0/KvtktNq6KI5nEyKgEppBEO7oeeKEHwRYWvllmFniBFcFxRXER2pHhN0YVaUH
         4LPZ5UJtb1HTv+jfNmpi0hLJyiNmW3QuQ+0xMDEDjypan1/RWhjsiPaGfHpj+Vw4Epb8
         sVpwZlzE1YJ1KKMYLCU1v+NoIktx8HnAcH1GEKwxncJOqMiWNZxzbucNr5DkDK4vwF/D
         odLFKR3pzc/hfAOrJsuJBLkdys9J0O7BPhwpCcA1MOlDFG1yIFgeWcvSkDYdTNGGI31d
         YVPA==
X-Gm-Message-State: AOAM533Tzes/RkWc7OZa7uR4abqT6oaVCZ+Lbn7uoDlnHonCtbU54cwu
        e8cHM0/kZDO41CCuzXbdSVnNjUrEbeHLtvpO
X-Google-Smtp-Source: ABdhPJwOXr05fsOOcseGD6hokZAvQ8RHsRKRzP1oLkebitJxtHavQCW14veIOYOZHaCq/zgT/xUSMA==
X-Received: by 2002:a37:8703:: with SMTP id j3mr22050441qkd.5.1605123849274;
        Wed, 11 Nov 2020 11:44:09 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id q20sm3126457qtl.69.2020.11.11.11.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:44:08 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:44:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 19/23] pack-bitmap: factor out 'bitmap_for_commit()'
Message-ID: <3aecb42215c31db61397edc9620f1e038753709e.1605123653.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605123652.git.me@ttaylorr.com>
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
index 682f4d19dd..99a0683f49 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -375,6 +375,16 @@ struct include_data {
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
@@ -460,10 +470,10 @@ static void show_commit(struct commit *commit, void *data)
 
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
@@ -471,10 +481,9 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
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
 
@@ -493,8 +502,7 @@ static int should_include(struct commit *commit, void *_data)
 						  (struct object *)commit,
 						  NULL);
 
-	if (!add_to_include_set(data->bitmap_git, data, &commit->object.oid,
-				bitmap_pos)) {
+	if (!add_to_include_set(data->bitmap_git, data, commit, bitmap_pos)) {
 		struct commit_list *parent = commit->parents;
 
 		while (parent) {
@@ -1277,10 +1285,10 @@ void test_bitmap_walk(struct rev_info *revs)
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
@@ -1292,12 +1300,9 @@ void test_bitmap_walk(struct rev_info *revs)
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
2.29.2.156.gc03786897f

