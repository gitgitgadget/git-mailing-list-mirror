Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E06CCA480
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiGKMou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiGKMo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A76111D
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so8186994pjo.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce/thzzPgRSp4IHk7tN5cZqHJOAmwVizorFgazv7hzE=;
        b=iupHRD+7ywKZRnCQ3EimQ6UL6wVkmV+bvNpysw46BLEZxKP+TRzgKtX6i6t55yuol5
         NHebWywhwmKh51DKxctjRMEWcsgwX6XDs54u5oegjYRZNH5TvEHT3xkE6x6a0vBKHDRv
         8NenRZyikwzW7s6JS8D0raRU6AQFhi+KaXhJ2n3m27ZLCypFksnO/C2xx4Dkucm8FPhS
         txP6mlwC7Jz7dR8LVA2h4rPIMob5r6gK1TfP2halcHEPktKy13jKaR4PuptV4Ryrbzsl
         eWtpMmlnTZ7L3UhTUde+8MfTjP3HsI6M7XoK5bq9b4oJ83cr4vUIvcT6jSRHP7Y8igJz
         oPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce/thzzPgRSp4IHk7tN5cZqHJOAmwVizorFgazv7hzE=;
        b=01e9axU5LXQ6Aa9KHKO7/V+qM30mitn8dNs/DgZY2v1BrgoPc0u92KdadS72cgfp43
         fgYLk83hikiSDpG9wOBLNs4a+sKCvm6zlQ46oUcqkVEBuuRqJo1zb/M/+gcC2E0vNPOR
         0Rj2Th4fy/3HSyIHHubBw6D/MkFjZZ3wODKGvqDZVO9NcCLBzRMEH1uffx1CgzQ4Zz00
         pt4g59Xfs8IU9NqeiouCYD8kksXzz+mFUVB9J6h0oEriF6tpX3FDDfnA1d33dhhAzMgX
         cZ5+rLYA8TTlFkvce8+6vNYRAQARVI1/uJRlYmDrIUKd0cgpYR4jS+K6KPLXrpa6A1/T
         ZXeg==
X-Gm-Message-State: AJIora9g/bVRZdUNyePBWqCUXQ0gEIXaw910Aq8KklTP3OfwrvVHpT4N
        h5liF6USJSLQyAskRJOajVg=
X-Google-Smtp-Source: AGRyM1vWU/COEtEkYmpjUxWSsVTf8eyWTaYnw4+bNrDfj09t+8pbeU/ENVlrsMwnPAsChPRPMIla4A==
X-Received: by 2002:a17:902:cec5:b0:16c:4108:d292 with SMTP id d5-20020a170902cec500b0016c4108d292mr7147866plg.137.1657543460174;
        Mon, 11 Jul 2022 05:44:20 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 1/7] clean: fixed issues related to text output format
Date:   Mon, 11 Jul 2022 20:43:57 +0800
Message-Id: <94a64ba895a8eb9eb7d502e94cf3d9fdfb9d2887.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some text output issues in 'pack-bitmap.c', they exist in
die(), error() etc. This includes issues with capitalization the
first letter, newlines, error() instead of BUG(), and substitution
that don't have quotes around them.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8b..0fdba5e8c5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "commit.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "diff.h"
 #include "revision.h"
@@ -138,7 +139,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		index->map_size - index->map_pos);
 
 	if (bitmap_size < 0) {
-		error("Failed to load bitmap index (corrupted?)");
+		error("failed to load bitmap index (corrupted?)");
 		ewah_pool_free(b);
 		return NULL;
 	}
@@ -160,14 +161,14 @@ static int load_bitmap_header(struct bitmap_index *index)
 	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
 
 	if (index->map_size < header_size + the_hash_algo->rawsz)
-		return error("Corrupted bitmap index (too small)");
+		return error("corrupted bitmap index (too small)");
 
 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
-		return error("Corrupted bitmap index file (wrong header)");
+		return error("corrupted bitmap index file (wrong header)");
 
 	index->version = ntohs(header->version);
 	if (index->version != 1)
-		return error("Unsupported version for bitmap index file (%d)", index->version);
+		return error("unsupported version '%d' for bitmap index file", index->version);
 
 	/* Parse known bitmap format options */
 	{
@@ -176,7 +177,7 @@ static int load_bitmap_header(struct bitmap_index *index)
 		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
 
 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
-			return error("Unsupported options for bitmap index file "
+			BUG("unsupported options for bitmap index file "
 				"(Git requires BITMAP_OPT_FULL_DAG)");
 
 		if (flags & BITMAP_OPT_HASH_CACHE) {
@@ -215,7 +216,7 @@ static struct stored_bitmap *store_bitmap(struct bitmap_index *index,
 	 * because the SHA1 already existed on the map. this is bad, there
 	 * shouldn't be duplicated commits in the index */
 	if (ret == 0) {
-		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
+		error("duplicate entry in bitmap index: '%s'", oid_to_hex(oid));
 		return NULL;
 	}
 
@@ -274,13 +275,13 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 			return -1;
 
 		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
-			return error("Corrupted bitmap pack index");
+			return error("corrupted bitmap pack index");
 
 		if (xor_offset > 0) {
 			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
 
 			if (xor_bitmap == NULL)
-				return error("Invalid XOR offset in bitmap pack index");
+				return error("invalid XOR offset in bitmap pack index");
 		}
 
 		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
@@ -330,7 +331,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		warning("ignoring extra bitmap file: '%s'", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -387,7 +388,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		warning("ignoring extra bitmap file: '%s'", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -1628,15 +1629,15 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	}
 
 	if (bitmap_type == OBJ_NONE)
-		die("object %s not found in type bitmaps",
+		die("object '%s' not found in type bitmaps",
 		    oid_to_hex(&obj->oid));
 
 	if (bitmaps_nr > 1)
-		die("object %s does not have a unique type",
+		die("object '%s' does not have a unique type",
 		    oid_to_hex(&obj->oid));
 
 	if (bitmap_type != obj->type)
-		die("object %s: real type %s, expected: %s",
+		die("object '%s': real type '%s', expected: '%s'",
 		    oid_to_hex(&obj->oid),
 		    type_name(obj->type),
 		    type_name(bitmap_type));
@@ -1650,7 +1651,7 @@ static void test_show_object(struct object *object, const char *name,
 
 	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
+		die("object not in bitmap: '%s'", oid_to_hex(&object->oid));
 	test_bitmap_type(tdata, object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1665,7 +1666,7 @@ static void test_show_commit(struct commit *commit, void *data)
 	bitmap_pos = bitmap_position(tdata->bitmap_git,
 				     &commit->object.oid);
 	if (bitmap_pos < 0)
-		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
+		die("object not in bitmap: '%s'", oid_to_hex(&commit->object.oid));
 	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
 	bitmap_set(tdata->base, bitmap_pos);
@@ -1687,21 +1688,21 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die("you must specify exactly one commit to test");
 
-	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
+	fprintf_ln(stderr, "Bitmap v%d test (%d entries loaded)",
 		bitmap_git->version, bitmap_git->entry_count);
 
 	root = revs->pending.objects[0].item;
 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
 
 	if (bm) {
-		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
+		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
 		result = ewah_to_bitmap(bm);
 	}
 
 	if (result == NULL)
-		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
+		die("commit '%s' doesn't have an indexed bitmap", oid_to_hex(&root->oid));
 
 	revs->tag_objects = 1;
 	revs->tree_objects = 1;
@@ -1726,7 +1727,7 @@ void test_bitmap_walk(struct rev_info *revs)
 	stop_progress(&tdata.prg);
 
 	if (bitmap_equals(result, tdata.base))
-		fprintf(stderr, "OK!\n");
+		fprintf_ln(stderr, "OK!");
 	else
 		die("mismatch in bitmap results");
 
@@ -1749,7 +1750,7 @@ int test_bitmap_commits(struct repository *r)
 		die("failed to load bitmap indexes");
 
 	kh_foreach(bitmap_git->bitmaps, oid, value, {
-		printf("%s\n", oid_to_hex(&oid));
+		printf_ln("%s", oid_to_hex(&oid));
 	});
 
 	free_bitmap_index(bitmap_git);
@@ -1774,7 +1775,7 @@ int test_bitmap_hashes(struct repository *r)
 
 		nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
 
-		printf("%s %"PRIu32"\n",
+		printf_ln("%s %"PRIu32"",
 		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + index_pos));
 	}
 
@@ -1936,7 +1937,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 					struct object_id oid;
 					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
 
-					die(_("could not find %s in pack %s at offset %"PRIuMAX),
+					die(_("could not find '%s' in pack '%s' at offset %"PRIuMAX),
 					    oid_to_hex(&oid),
 					    pack->pack_name,
 					    (uintmax_t)offset);
@@ -1972,7 +1973,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
-			die(_("unable to get disk usage of %s"),
+			die(_("unable to get disk usage of '%s'"),
 			    oid_to_hex(&obj->oid));
 
 		total += object_size;
-- 
2.35.0.rc0.676.g60105b7097.dirty

