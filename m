Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE0C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiGKMop (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiGKMoU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE31CB17
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 70so4679031pfx.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWW3KrH1GztecIbVYnh/OhfsaeexiuyFNXQgZ6p0aHg=;
        b=qd3J8eQCBwpFRZsOiiX030XscQEPTtyr2w2TEcDrN/DtUZHNwZJtgxSYzUprbLBSjK
         wTyAvy+18TsQyIpwM/u+sZlAGWmN3jOqRoKhUc0+PiJUK2SAPJPvA5WcZsQwbqwjH1IJ
         sVFvMIyhUPGIbmfZLmcejULjoB3ZixhK6BLEWu9HOlNNSUXaCfEDQ6iE6c7b4W596aMB
         XhCO+bDFBTn+bbbzp0aJb4a17prh+iP2eun6zo15bdqYP8W0tZzWBi5Vx1HihDoWRcZh
         QX36Ts2w7VEkPokcsrT0SoxLNQDL6+IysKKBCKW6Zqpy24aIonuzZy1lMAR4r3bi/30a
         2hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWW3KrH1GztecIbVYnh/OhfsaeexiuyFNXQgZ6p0aHg=;
        b=51MC1Paj23jyReCyMdlZrVRqyZdlEhFFd3OZmeChLv/0RCHIX4XxtBp8NLb3nBKQIj
         gMiEt9d0I8jmmfUyn451mfzYcnAGkYjXWfoWRaTnMjfkOZx3FZOVNO5HNkDu1XxsFQV0
         rvak8wYuoamHPLvrU12rfVdnTeDKgvV94nqfsSRSs6PNooHQxRg2AyJE2rVdtuKdWqZd
         YgMW3H/OaKIeOqUCO7EtV9SO8nIRVcpP/LWr/UI4u2xANHqE/E3mtz0hB8FwGQm9gamB
         K898PFvxdbW2ouulJ0hdoGurN8ba5MQADAZOLGTziSRx+yl2vMHbVWZ5kFdJDUSaBaTZ
         ZfzQ==
X-Gm-Message-State: AJIora+JO2hG2g8V4RISe11dlBohtf8hTQmAL34WDZTBP6aRJ6qx0zxx
        iMbEYfqHf8uRlWvhpr2GJkkJr4tO7Ww=
X-Google-Smtp-Source: AGRyM1tZgU57W7gUXIPNtKNaQzuWWvvgTbq17RWLe2KPIC9ti7uvlSoTv0X9l2Nvd+LqhujJT30Qww==
X-Received: by 2002:a63:135e:0:b0:412:6eaf:f1e3 with SMTP id 30-20020a63135e000000b004126eaff1e3mr15384255pgt.481.1657543457632;
        Mon, 11 Jul 2022 05:44:17 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:17 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 0/7] trace2: dump scope when print "interesting" config  
Date:   Mon, 11 Jul 2022 20:43:56 +0800
Message-Id: <cover.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v5:

1. [1/7] New commit, pre-clean the issues of the strings.
2. [2/7] Optimize commit subject (the word "retrieve").
3. [4/7] New commit, do not ignore ENOENT silently when fail to open file. 
4. [5/7] Replace "stat" to "fstat" in output string and let "cleanup" to
   return -1 instead of an unaccurate error tip as "cannot open".
5. [7/7] dump corresponding scope-name when "interesting" config is print to
   trace2 log.

Thanks.

Teng Long (7):
  clean: fixed issues related to text output format
  pack-bitmap.c: mark more strings for translations
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: don't ignore ENOENT silently
  pack-bitmap.c: using error() instead of silently returning -1
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  tr2: dump names if config exist in multiple scopes

 pack-bitmap.c           | 105 ++++++++++++++++++++++------------------
 trace2/tr2_tgt_event.c  |   3 ++
 trace2/tr2_tgt_normal.c |   5 +-
 trace2/tr2_tgt_perf.c   |   9 +++-
 4 files changed, 72 insertions(+), 50 deletions(-)

Range-diff against v5:
-:  ---------- > 1:  94a64ba895 clean: fixed issues related to text output format
4:  065b7c9ccb ! 2:  cadecd6b84 pack-bitmap.c: retrieve missing i18n translations
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap.c: retrieve missing i18n translations
    +    pack-bitmap.c: mark more strings for translations
     
    -    In pack-bitmap.c, some printed texts are translated,some are not.
    +    In pack-bitmap.c, some printed texts are translated, some are not.
         Let's support the translations of the bitmap related output.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
    @@ pack-bitmap.c: static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *ind
      		index->map_size - index->map_pos);
      
      	if (bitmap_size < 0) {
    --		error("Failed to load bitmap index (corrupted?)");
    -+		error(_("Failed to load bitmap index (corrupted?)"));
    +-		error("failed to load bitmap index (corrupted?)");
    ++		error(_("failed to load bitmap index (corrupted?)"));
      		ewah_pool_free(b);
      		return NULL;
      	}
    @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
      
      	if (index->map_size < header_size + the_hash_algo->rawsz)
    --		return error("Corrupted bitmap index (too small)");
    -+		return error(_("Corrupted bitmap index (too small)"));
    +-		return error("corrupted bitmap index (too small)");
    ++		return error(_("corrupted bitmap index (too small)"));
      
      	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
    --		return error("Corrupted bitmap index file (wrong header)");
    -+		return error(_("Corrupted bitmap index file (wrong header)"));
    +-		return error("corrupted bitmap index file (wrong header)");
    ++		return error(_("corrupted bitmap index file (wrong header)"));
      
      	index->version = ntohs(header->version);
      	if (index->version != 1)
    --		return error("Unsupported version for bitmap index file (%d)", index->version);
    -+		return error(_("Unsupported version for bitmap index file (%d)"), index->version);
    +-		return error("unsupported version '%d' for bitmap index file", index->version);
    ++		return error(_("unsupported version '%d' for bitmap index file"), index->version);
      
      	/* Parse known bitmap format options */
      	{
     @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
    - 		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
    - 
    - 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
    --			return error("Unsupported options for bitmap index file "
    --				"(Git requires BITMAP_OPT_FULL_DAG)");
    -+			return error(_("Unsupported options for bitmap index file "
    -+				"(Git requires BITMAP_OPT_FULL_DAG)"));
      
      		if (flags & BITMAP_OPT_HASH_CACHE) {
      			if (cache_size > index_end - index->map - header_size)
    @@ pack-bitmap.c: static struct stored_bitmap *store_bitmap(struct bitmap_index *in
      	 * because the SHA1 already existed on the map. this is bad, there
      	 * shouldn't be duplicated commits in the index */
      	if (ret == 0) {
    --		error("Duplicate entry in bitmap index: %s", oid_to_hex(oid));
    -+		error(_("Duplicate entry in bitmap index: %s"), oid_to_hex(oid));
    +-		error("duplicate entry in bitmap index: '%s'", oid_to_hex(oid));
    ++		error(_("duplicate entry in bitmap index: '%s'"), oid_to_hex(oid));
      		return NULL;
      	}
      
    @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
      
      		if (index->map_size - index->map_pos < 6)
     -			return error("corrupt ewah bitmap: truncated header for entry %d", i);
    -+			return error(_("corrupt ewah bitmap: truncated header for entry %d)"), i);
    ++			return error(_("corrupt ewah bitmap: truncated header for entry %d"), i);
      
      		commit_idx_pos = read_be32(index->map, &index->map_pos);
      		xor_offset = read_u8(index->map, &index->map_pos);
    @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
      			return -1;
      
      		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
    --			return error("Corrupted bitmap pack index");
    -+			return error(_("Corrupted bitmap pack index"));
    +-			return error("corrupted bitmap pack index");
    ++			return error(_("corrupted bitmap pack index"));
      
      		if (xor_offset > 0) {
      			xor_bitmap = recent_bitmaps[(i - xor_offset) % MAX_XOR_OFFSET];
      
      			if (xor_bitmap == NULL)
    --				return error("Invalid XOR offset in bitmap pack index");
    -+				return error(_("Invalid XOR offset in bitmap pack index"));
    +-				return error("invalid XOR offset in bitmap pack index");
    ++				return error(_("invalid XOR offset in bitmap pack index"));
      		}
      
      		recent_bitmaps[i % MAX_XOR_OFFSET] = store_bitmap(
    -@@ pack-bitmap.c: char *pack_bitmap_filename(struct packed_git *p)
    - 	size_t len;
    - 
    - 	if (!strip_suffix(p->pack_name, ".pack", &len))
    --		BUG("pack_name does not end in .pack");
    -+		BUG(_("pack_name does not end in .pack"));
    - 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
    - }
    - 
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		struct strbuf buf = STRBUF_INIT;
      		get_midx_filename(&buf, midx->object_dir);
      		/* ignore extra bitmap file; we can only handle one */
    --		warning("ignoring extra bitmap file: %s", buf.buf);
    -+		warning(_("ignoring extra bitmap file: %s"), buf.buf);
    +-		warning("ignoring extra bitmap file: '%s'", buf.buf);
    ++		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
      		close(fd);
      		strbuf_release(&buf);
      		return -1;
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      
      	if (bitmap_git->pack || bitmap_git->midx) {
      		/* ignore extra bitmap file; we can only handle one */
    --		warning("ignoring extra bitmap file: %s", packfile->pack_name);
    -+		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
    +-		warning("ignoring extra bitmap file: '%s'", packfile->pack_name);
    ++		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
      		close(fd);
      		return -1;
      	}
    @@ pack-bitmap.c: static struct bitmap *find_objects(struct bitmap_index *bitmap_gi
      
      		show_data.bitmap_git = bitmap_git;
      		show_data.base = base;
    -@@ pack-bitmap.c: static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
    - 				     unsigned long limit)
    - {
    - 	if (limit)
    --		BUG("filter_bitmap_tree_depth given non-zero limit");
    -+		BUG(_("filter_bitmap_tree_depth given non-zero limit"));
    - 
    - 	filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter,
    - 				   OBJ_TREE);
    -@@ pack-bitmap.c: static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
    - 				      enum object_type object_type)
    - {
    - 	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
    --		BUG("filter_bitmap_object_type given invalid object");
    -+		BUG(_("filter_bitmap_object_type given invalid object"));
    - 
    - 	if (object_type != OBJ_TAG)
    - 		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TAG);
    -@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    - 		revs->ignore_missing_links = 0;
    - 
    - 		if (haves_bitmap == NULL)
    --			BUG("failed to perform bitmap walk");
    -+			BUG(_("failed to perform bitmap walk"));
    - 	}
    - 
    - 	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap,
    - 				    filter);
    - 
    - 	if (!wants_bitmap)
    --		BUG("failed to perform bitmap walk");
    -+		BUG(_("failed to perform bitmap walk"));
    - 
    - 	if (haves_bitmap)
    - 		bitmap_and_not(wants_bitmap, haves_bitmap);
    -@@ pack-bitmap.c: uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
    - {
    - 	struct multi_pack_index *m = bitmap_git->midx;
    - 	if (!m)
    --		BUG("midx_preferred_pack: requires non-empty MIDX");
    -+		BUG(_("midx_preferred_pack: requires non-empty MIDX"));
    - 	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
    - }
    - 
     @@ pack-bitmap.c: static void test_bitmap_type(struct bitmap_test_data *tdata,
      	}
      
      	if (bitmap_type == OBJ_NONE)
    --		die("object %s not found in type bitmaps",
    -+		die(_("object %s not found in type bitmaps"),
    +-		die("object '%s' not found in type bitmaps",
    ++		die(_("object '%s' not found in type bitmaps"),
      		    oid_to_hex(&obj->oid));
      
      	if (bitmaps_nr > 1)
    --		die("object %s does not have a unique type",
    -+		die(_("object %s does not have a unique type"),
    +-		die("object '%s' does not have a unique type",
    ++		die(_("object '%s' does not have a unique type"),
      		    oid_to_hex(&obj->oid));
      
      	if (bitmap_type != obj->type)
    --		die("object %s: real type %s, expected: %s",
    -+		die(_("object %s: real type %s, expected: %s"),
    +-		die("object '%s': real type '%s', expected: '%s'",
    ++		die(_("object '%s': real type '%s', expected: '%s'"),
      		    oid_to_hex(&obj->oid),
      		    type_name(obj->type),
      		    type_name(bitmap_type));
    @@ pack-bitmap.c: static void test_show_object(struct object *object, const char *n
      
      	bitmap_pos = bitmap_position(tdata->bitmap_git, &object->oid);
      	if (bitmap_pos < 0)
    --		die("Object not in bitmap: %s\n", oid_to_hex(&object->oid));
    -+		die(_("Object not in bitmap: %s\n"), oid_to_hex(&object->oid));
    +-		die("object not in bitmap: '%s'", oid_to_hex(&object->oid));
    ++		die(_("object not in bitmap: '%s'"), oid_to_hex(&object->oid));
      	test_bitmap_type(tdata, object, bitmap_pos);
      
      	bitmap_set(tdata->base, bitmap_pos);
    @@ pack-bitmap.c: static void test_show_commit(struct commit *commit, void *data)
      	bitmap_pos = bitmap_position(tdata->bitmap_git,
      				     &commit->object.oid);
      	if (bitmap_pos < 0)
    --		die("Object not in bitmap: %s\n", oid_to_hex(&commit->object.oid));
    -+		die(_("Object not in bitmap: %s\n"), oid_to_hex(&commit->object.oid));
    +-		die("object not in bitmap: '%s'", oid_to_hex(&commit->object.oid));
    ++		die(_("object not in bitmap: '%s'"), oid_to_hex(&commit->object.oid));
      	test_bitmap_type(tdata, &commit->object, bitmap_pos);
      
      	bitmap_set(tdata->base, bitmap_pos);
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
     -		die("you must specify exactly one commit to test");
     +		die(_("you must specify exactly one commit to test"));
      
    --	fprintf(stderr, "Bitmap v%d test (%d entries loaded)\n",
    -+	fprintf(stderr, _("Bitmap v%d test (%d entries loaded)\n"),
    + 	fprintf_ln(stderr, "Bitmap v%d test (%d entries loaded)",
      		bitmap_git->version, bitmap_git->entry_count);
    - 
    - 	root = revs->pending.objects[0].item;
    - 	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
    - 
    - 	if (bm) {
    --		fprintf(stderr, "Found bitmap for %s. %d bits / %08x checksum\n",
    -+		fprintf(stderr, _("Found bitmap for %s. %d bits / %08x checksum\n"),
    - 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
    - 
    - 		result = ewah_to_bitmap(bm);
    +@@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
      	}
      
      	if (result == NULL)
    --		die("Commit %s doesn't have an indexed bitmap", oid_to_hex(&root->oid));
    -+		die(_("Commit %s doesn't have an indexed bitmap"), oid_to_hex(&root->oid));
    +-		die("commit '%s' doesn't have an indexed bitmap", oid_to_hex(&root->oid));
    ++		die(_("commit '%s' doesn't have an indexed bitmap"), oid_to_hex(&root->oid));
      
      	revs->tag_objects = 1;
      	revs->tree_objects = 1;
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
      	tdata.bitmap_git = bitmap_git;
      	tdata.base = bitmap_new();
     @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
    - 	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
    - 	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
    - 	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
    --	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
    -+	tdata.prg = start_progress(_("Verifying bitmap entries"), result_popcnt);
    - 	tdata.seen = 0;
    - 
    - 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
    -@@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
    - 	stop_progress(&tdata.prg);
    - 
      	if (bitmap_equals(result, tdata.base))
    --		fprintf(stderr, "OK!\n");
    -+		fprintf(stderr, _("OK!\n"));
    + 		fprintf_ln(stderr, "OK!");
      	else
     -		die("mismatch in bitmap results");
     +		die(_("mismatch in bitmap results"));
    @@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
     +		die(_("failed to load bitmap indexes"));
      
      	kh_foreach(bitmap_git->bitmaps, oid, value, {
    - 		printf("%s\n", oid_to_hex(&oid));
    -@@ pack-bitmap.c: uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
    - 	if (!bitmap_is_midx(bitmap_git))
    - 		load_reverse_index(bitmap_git);
    - 	else if (load_midx_revindex(bitmap_git->midx) < 0)
    --		BUG("rebuild_existing_bitmaps: missing required rev-cache "
    --		    "extension");
    -+		BUG(_("rebuild_existing_bitmaps: missing required rev-cache "
    -+		    "extension"));
    - 
    - 	num_objects = bitmap_num_objects(bitmap_git);
    - 	CALLOC_ARRAY(reposition, num_objects);
    + 		printf_ln("%s", oid_to_hex(&oid));
2:  b6b30047fc = 3:  d8a2235cb0 pack-bitmap.c: rename "idx_name" to "bitmap_name"
-:  ---------- > 4:  009cc49a18 pack-bitmap.c: don't ignore ENOENT silently
-:  ---------- > 5:  52783555e2 pack-bitmap.c: using error() instead of silently returning -1
1:  589e3f4075 = 6:  95832190b8 pack-bitmap.c: continue looping when first MIDX bitmap is found
3:  82d4493a6e < -:  ---------- pack-bitmap.c: using error() instead of silently returning -1
5:  f3b87a33da < -:  ---------- tr2: avoid to print "interesting" config repeatedly
-:  ---------- > 7:  c45ead51ff tr2: dump names if config exist in multiple scopes
-- 
2.35.0.rc0.676.g60105b7097.dirty

