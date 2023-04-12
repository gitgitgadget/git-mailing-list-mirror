Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79BC77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDLWUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDLWUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:33 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13896A60
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e10so4443241ybp.4
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338025; x=1683930025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LfGro+h1F09xBK4RMyYjrQBvNLcVwWdie470x5g0AQ=;
        b=a+0BfR823aze/kPSRwhA9YFIJWXULMt8JSrJDNoQd129OUYedQf9GJLyX6u3B4iliY
         dpuPKzmEsSrYf9j7R8UzYvEBcpK3QBsH8HF3PxD8EUT56KvbntUNqED+137P2tu52+S7
         diVpS0ovmyhbDId8zOIHd4aPoyiJ8+ff6NlbKyqriNNW0QMU2OoYLD8gXu4B+6RfXVI2
         J73Z4N0cmx5N14oPtVVCgNPkTmyR29CjcUA9lC/gtvNE3nIbUuc0NMzgmXx3Fjee4OE3
         4/+dWsBZw9oY3wOxYXRuhutdXoroyHQ3F13qidp2XrezEsJrLw9hb3ngCIzyRAr5cFnn
         qgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338025; x=1683930025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LfGro+h1F09xBK4RMyYjrQBvNLcVwWdie470x5g0AQ=;
        b=GJyGCeNdUxbIaDtRrjB0m7vkInPXupnbhQiSsjUYOilNWNwGw99DGLzSw5oq9iC6K+
         cHMzG2ZtAIiNJqhKBP7lkOZ9wCHy4eGI0yekxixw0203XUY12TKQ9Ue436xDFY/urAs/
         bwerXIS78wQD8l28wHMMfwhMtTOusb+1blSpi/E8RmOm+Gp9tRLuGgDrgeP4jjSikK3N
         MH/Ka5JcUCldX/9lwxfddVBEczk4SuCVAMvLTJb0sI1BWOIrYhqODQNlDQqC1jjgHIVJ
         l97pdP+QG1M2YzvsdUIYSS9E5UjWs7ddCwVlwGilD1Vg54OSsA06YnFKZ8uv5x+UYRB7
         f3iA==
X-Gm-Message-State: AAQBX9d+hBEY7SkZ/yk7ktJoniTXliBLVLJXZ0RHQckBV8ctkIu23P6o
        OfnCEsm9lkgq4FuGenuR3sAmUeBhoMfKjRVyh6Bogw==
X-Google-Smtp-Source: AKy350Z8vcQ9+JGV4IEcuf1B/Nq7ckF5Z2Bez1hkK3/53l7vEJXizlt18ZKmy7FFg+pGQNvFYWGzlw==
X-Received: by 2002:a25:65d7:0:b0:b8f:545e:3428 with SMTP id z206-20020a2565d7000000b00b8f545e3428mr130752ybb.16.1681338025427;
        Wed, 12 Apr 2023 15:20:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s5-20020a25ba85000000b00b8bf2d8a5c5sm1572879ybg.56.2023.04.12.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:25 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] pack-revindex: make `load_pack_revindex` take a
 repository
Message-ID: <687a9a589249a327251b90f558917aa0f4ae79a4.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will introduce a `pack.readReverseIndex`
configuration, which forces Git to generate the reverse index from
scratch instead of loading it from disk.

In order to avoid reading this configuration value more than once, we'll
use the `repo_settings` struct to lazily load this value.

In order to access the `struct repo_settings`, add a repository argument
to `load_pack_revindex`, and update all callers to pass the correct
instance (in all cases, `the_repository`).

In certain instances, a new function-local variable is introduced to
take the place of a `struct repository *` argument to the function
itself to avoid propagating the new parameter even further throughout
the tree.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c   | 23 +++++++++++++----------
 pack-revindex.c |  4 ++--
 pack-revindex.h |  3 ++-
 packfile.c      |  2 +-
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b2e7d06d604..38b35c48237 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -463,7 +463,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	return 0;
 }
 
-static int load_reverse_index(struct bitmap_index *bitmap_git)
+static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
 		uint32_t i;
@@ -477,23 +477,23 @@ static int load_reverse_index(struct bitmap_index *bitmap_git)
 		 * since we will need to make use of them in pack-objects.
 		 */
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
+			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
 			if (ret)
 				return ret;
 		}
 		return 0;
 	}
-	return load_pack_revindex(bitmap_git->pack);
+	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct bitmap_index *bitmap_git)
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	assert(bitmap_git->map);
 
 	bitmap_git->bitmaps = kh_init_oid_map();
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
-	if (load_reverse_index(bitmap_git))
+	if (load_reverse_index(r, bitmap_git))
 		goto failed;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
@@ -580,7 +580,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -589,9 +589,10 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
+	struct repository *r = the_repository;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -1592,7 +1593,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
 	object_array_clear(&revs->pending);
@@ -1742,6 +1743,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				       uint32_t *entries,
 				       struct bitmap **reuse_out)
 {
+	struct repository *r = the_repository;
 	struct packed_git *pack;
 	struct bitmap *result = bitmap_git->result;
 	struct bitmap *reuse;
@@ -1752,7 +1754,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 	assert(result);
 
-	load_reverse_index(bitmap_git);
+	load_reverse_index(r, bitmap_git);
 
 	if (bitmap_is_midx(bitmap_git))
 		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
@@ -2132,11 +2134,12 @@ int rebuild_bitmap(const uint32_t *reposition,
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping)
 {
+	struct repository *r = the_repository;
 	uint32_t i, num_objects;
 	uint32_t *reposition;
 
 	if (!bitmap_is_midx(bitmap_git))
-		load_reverse_index(bitmap_git);
+		load_reverse_index(r, bitmap_git);
 	else if (load_midx_revindex(bitmap_git->midx) < 0)
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
diff --git a/pack-revindex.c b/pack-revindex.c
index 03c7e81f9da..e3d69cc0f7a 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -283,7 +283,7 @@ static int load_pack_revindex_from_disk(struct packed_git *p)
 	return ret;
 }
 
-int load_pack_revindex(struct packed_git *p)
+int load_pack_revindex(struct repository *r, struct packed_git *p)
 {
 	if (p->revindex || p->revindex_data)
 		return 0;
@@ -356,7 +356,7 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
 
-	if (load_pack_revindex(p) < 0)
+	if (load_pack_revindex(the_repository, p) < 0)
 		return -1;
 
 	lo = 0;
diff --git a/pack-revindex.h b/pack-revindex.h
index 4974e75eb4d..3d1969ce8b9 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -39,6 +39,7 @@
 
 struct packed_git;
 struct multi_pack_index;
+struct repository;
 
 /*
  * load_pack_revindex populates the revindex's internal data-structures for the
@@ -47,7 +48,7 @@ struct multi_pack_index;
  * If a '.rev' file is present it is mmap'd, and pointers are assigned into it
  * (instead of using the in-memory variant).
  */
-int load_pack_revindex(struct packed_git *p);
+int load_pack_revindex(struct repository *r, struct packed_git *p);
 
 /*
  * load_midx_revindex loads the '.rev' file corresponding to the given
diff --git a/packfile.c b/packfile.c
index b120405ccc8..717fd685c97 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2151,7 +2151,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(p))
+		if (load_pack_revindex(the_repository, p))
 			return -1;
 	}
 
-- 
2.40.0.323.gedff6a80c63

