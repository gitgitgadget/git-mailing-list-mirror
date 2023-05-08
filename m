Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C1C77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjEHRiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjEHRiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:38:11 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA371BFE
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:38:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b996127ec71so6557349276.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683567485; x=1686159485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=chu7UAKwyvTIv7SJtZi6b3i3QkaguPyIE63nFL8aHLY=;
        b=NWITVbJ489dyLnchXBcXO7ywBL5WTYmxRPWBjltLl4NerFosrSm+DnwHboGpdJ+2YW
         hwXEI0YfGKlTVyJxYWpOqGBA293StRc6v1Vzig2eeHfDKk3/7AQ1caNwq0m5YYZ8JDxJ
         YLuTFJLLHZ9oy1g7x76PaskhfSAXz2cw8joVpXkyKPImaYQ4s2v7rCK8Fkd+9jryXL+C
         VWS0xt2Idessqi48rpGPixWzgfgZ3L5JGhM8xDbuwZG7ZFsgJMpkLYo2JNW7D/w/nMJq
         HwzoD9Y3wbwR4voGM9XhZJfdraPvDyC4blu27K0/zu4mlkk9bKfhUjpmq6i9uVym8aQR
         DoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567485; x=1686159485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chu7UAKwyvTIv7SJtZi6b3i3QkaguPyIE63nFL8aHLY=;
        b=UgDO8bUxcPFE6KDWor4O2moXaqRYdApPctIwCHG95tfa1c8CL8AvuxSv0mXNm3M1Uu
         zc521sUjTeWLrvw9KTT7vccSrqRFhV5UnlRh04QIJVlE52HXXnUZURMb1MwGeYdJNEuB
         gISqw4CQoCOEOD5Z77TOxt5o+2AxYXHV3rxpcgu+n3SQXJrHCLXA/0zAAG23sGCifvW2
         7ybMeM5mLxXVaGRw1UTOl6TsNoIJ+/ziEz0S8xbA7aXp7iS5qOhnxDsfF/dPZ2uCWTJC
         K1ITxVCiyERTBw1iWiDV/rsGQafCsbQOJXcnhI4GtD9k4gxUvTQGNuaYddBsf5Cc+d0B
         gfhg==
X-Gm-Message-State: AC+VfDyylp5haAOTai5cc/aK9Agc8C3hf4jUIEdGAY5u6gVHSPWU7Qya
        zQ8SNszBQ7ea66s3PDOx1wQYTmd6Laj+cVEGnH+KKA==
X-Google-Smtp-Source: ACHHUZ7xzuye60VkI7zOu/9xs5fldK5cxmq6GBD5sypM1nCTVoQEX0NXe0Yq9KNS3fqPsex6ruIMSA==
X-Received: by 2002:a25:cfd3:0:b0:b92:50ab:66cb with SMTP id f202-20020a25cfd3000000b00b9250ab66cbmr11165045ybg.21.1683567484483;
        Mon, 08 May 2023 10:38:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 144-20020a250596000000b00b8bfb4c4f1esm2453956ybf.62.2023.05.08.10.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:38:03 -0700 (PDT)
Date:   Mon, 8 May 2023 13:38:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <cover.1683567065.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another small reroll of my series to implement a boundary-based
bitmap traversal algorithm that I worked on towards the end of 2021 with
Peff.

The algorithm is the same as in the last round, though I cleaned up a
few things throughout thanks to another very helpful review from Stolee.

One significant change from last time is that the new algorithm is
opt-in behind feature.experimental, giving users a way to try out the
new implementation while still being able to switch back to the
known-good traversal in case anything goes wrong.

Hopefully after a version or two we can safely remove the conditional
and drop the existing algorithm.

Thanks in advance for your review.

Taylor Blau (3):
  object: add object_array initializer helper function
  pack-bitmap.c: extract `fill_in_bitmap()`
  pack-bitmap.c: use commit boundary during bitmap traversal

 Documentation/config/feature.txt |   3 +
 Documentation/config/pack.txt    |  17 +++
 ci/run-build-and-tests.sh        |   1 +
 object.c                         |   6 +
 object.h                         |   2 +
 pack-bitmap.c                    | 241 ++++++++++++++++++++++++++-----
 pack-bitmap.h                    |   4 +
 repo-settings.c                  |   7 +-
 repository.h                     |   1 +
 t/README                         |   4 +
 t/t5310-pack-bitmaps.sh          |  38 +++++
 11 files changed, 284 insertions(+), 40 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  c31508ac4a object: add object_array initializer helper function
1:  a3a1522439 = 2:  e7b30490da pack-bitmap.c: extract `fill_in_bitmap()`
2:  1993af00cb ! 3:  8a8f41e0c4 pack-bitmap.c: use commit boundary during bitmap traversal
    @@ Commit message
         the true number of objects in a similar fashion as the non-bitmap
         traversal):
     
    -        # (Computing objects unique to 'master' among all branches, not
    -        # using bitmaps).
    -        $ time git rev-list --count --objects master --not --exclude=master --branches
    -        43
    +        # (Computing the number of tagged objects not on any branches
    +        # without bitmaps).
    +        $ time git rev-list --count --objects --tags --not --branches
    +        20
     
    -        real        0m0.346s
    -        user        0m0.231s
    -        sys 0m0.115s
    +        real        0m1.388s
    +        user        0m1.092s
    +        sys 0m0.296s
     
    -        # (Computing the same uniqueness query using the old bitmap
    -        # traversal algorithm.)
    -        $ time git rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    -        41
    +        # (Computing the same query using the old bitmap traversal).
    +        $ time git rev-list --count --objects --tags --not --branches --use-bitmap-index
    +        19
     
    -        real        0m20.007s
    -        user        0m19.045s
    -        sys 0m0.960s
    +        real        0m22.709s
    +        user        0m21.628s
    +        sys 0m1.076s
     
    -        # (Computing the same uniqueness query using the new bitmap
    -        # traversal algorithm.)
    -        $ time git.compile rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    -        41
    +        # (this commit)
    +        $ time git.compile rev-list --count --objects --tags --not --branches --use-bitmap-index
    +        19
     
    -        real        0m1.748s
    -        user        0m1.428s
    -        sys 0m0.320s
    +        real        0m1.518s
    +        user        0m1.234s
    +        sys 0m0.284s
     
         The new algorithm is still slower than not using bitmaps at all, but it
    -    is nearly a 11-fold improvement over the existing traversal.
    +    is nearly a 15-fold improvement over the existing traversal.
     
         In a more realistic setting (using my local copy of git.git), I can
         observe a similar (if more modest) speed-up:
     
    -        $ ours="$(git branch --show-current)"
    -          argv="--count --objects $ours --not --exclude=$ours --branches"
    -          hyperfine \
    -            -n 'no bitmaps' "git.compile rev-list $argv" \
    -            -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
    -            -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
    +        $ argv="--count --objects --branches --not --tags"
    +        hyperfine \
    +          -n 'no bitmaps' "git.compile rev-list $argv" \
    +          -n 'existing traversal' "git.compile rev-list --use-bitmap-index $argv" \
    +          -n 'boundary traversal' "git.compile -c pack.useBitmapBoundaryTraversal=true rev-list --use-bitmap-index $argv"
             Benchmark 1: no bitmaps
    -          Time (mean ± σ):       5.8 ms ±   0.2 ms    [User: 3.3 ms, System: 2.4 ms]
    -          Range (min … max):     5.4 ms …   7.0 ms    409 runs
    +          Time (mean ± σ):     124.6 ms ±   2.1 ms    [User: 103.7 ms, System: 20.8 ms]
    +          Range (min … max):   122.6 ms … 133.1 ms    22 runs
     
    -        Benchmark 2: existing bitmap traversal
    -          Time (mean ± σ):      65.3 ms ±   0.6 ms    [User: 49.3 ms, System: 15.8 ms]
    -          Range (min … max):    64.1 ms …  66.9 ms    45 runs
    +        Benchmark 2: existing traversal
    +          Time (mean ± σ):     368.6 ms ±   3.0 ms    [User: 325.3 ms, System: 43.1 ms]
    +          Range (min … max):   365.1 ms … 374.8 ms    10 runs
     
    -        Benchmark 3: this commit
    -          Time (mean ± σ):      19.8 ms ±   0.3 ms    [User: 12.9 ms, System: 6.8 ms]
    -          Range (min … max):    19.1 ms …  20.8 ms    150 runs
    +        Benchmark 3: boundary traversal
    +          Time (mean ± σ):     167.6 ms ±   0.9 ms    [User: 139.5 ms, System: 27.9 ms]
    +          Range (min … max):   166.1 ms … 169.2 ms    17 runs
     
             Summary
               'no bitmaps' ran
    -            3.43 ± 0.14 times faster than 'this commit'
    -           11.34 ± 0.45 times faster than 'existing bitmap traversal'
    +            1.34 ± 0.02 times faster than 'boundary traversal'
    +            2.96 ± 0.05 times faster than 'existing traversal'
     
         Here, the new algorithm is also still slower than not using bitmaps, but
    -    represents a more than 3-fold improvement over the existing traversal in
    +    represents a more than 2-fold improvement over the existing traversal in
         a more modest example.
     
         Since this algorithm was originally written (nearly a year and a half
    @@ Commit message
         Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/config/feature.txt ##
    +@@ Documentation/config/feature.txt: feature.experimental::
    + +
    + * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
    + skipping more commits at a time, reducing the number of round trips.
    +++
    ++* `pack.useBitmapBoundaryTraversal=true` may improve bitmap traversal times by
    ++walking fewer objects.
    + 
    + feature.manyFiles::
    + 	Enable config options that optimize for repos with many files in the
    +
    + ## Documentation/config/pack.txt ##
    +@@ Documentation/config/pack.txt: pack.useBitmaps::
    + 	true. You should not generally need to turn this off unless
    + 	you are debugging pack bitmaps.
    + 
    ++pack.useBitmapBoundaryTraversal::
    ++	When true, Git will use an experimental algorithm for computing
    ++	reachability queries with bitmaps. Instead of building up
    ++	complete bitmaps for all of the negated tips and then OR-ing
    ++	them together, consider negated tips with existing bitmaps as
    ++	additive (i.e. OR-ing them into the result if they exist,
    ++	ignoring them otherwise), and build up a bitmap at the boundary
    ++	instead.
    +++
    ++When using this algorithm, Git may include too many objects as a result
    ++of not opening up trees belonging to certain UNINTERESTING commits. This
    ++inexactness matches the non-bitmap traversal algorithm.
    +++
    ++In many cases, this can provide a speed-up over the exact algorithm,
    ++particularly when there is poor bitmap coverage of the negated side of
    ++the query.
    ++
    + pack.useSparse::
    + 	When true, git will default to using the '--sparse' option in
    + 	'git pack-objects' when the '--revs' option is present. This
    +
    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: linux-TEST-vars)
    + 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    + 	export GIT_TEST_NO_WRITE_REV_INDEX=1
    + 	export GIT_TEST_CHECKOUT_WORKERS=2
    ++	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
    + 	;;
    + linux-clang)
    + 	export GIT_TEST_DEFAULT_HASH=sha1
    +
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
      	return base;
      }
      
    -+static int obj_in_bitmap(struct bitmap_index *bitmap_git,
    -+			 struct object *obj, struct bitmap *bitmap)
    -+{
    -+	int pos;
    -+
    -+	if (!bitmap)
    -+		return 0;
    -+	pos = bitmap_position(bitmap_git, &obj->oid);
    -+	if (pos < 0)
    -+		return 0;
    -+	return bitmap_get(bitmap, pos);
    -+}
    -+
     +struct bitmap_boundary_cb {
     +	struct bitmap_index *bitmap_git;
     +	struct bitmap *base;
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +		add_object_array(&commit->object, "", &data->boundary);
     +
     +	if (commit->object.flags & UNINTERESTING) {
    -+		if (obj_in_bitmap(data->bitmap_git, &commit->object,
    -+				  data->base))
    ++		if (bitmap_walk_contains(data->bitmap_git, data->base,
    ++					 &commit->object.oid))
     +			return;
     +
     +		add_commit_to_bitmap(data->bitmap_git, &data->base, commit);
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +					    struct rev_info *revs,
     +					    struct object_list *roots)
     +{
    -+	struct bitmap_boundary_cb cb = { .bitmap_git = bitmap_git };
    ++	struct bitmap_boundary_cb cb;
    ++	struct object_list *root;
     +	unsigned int i;
     +	unsigned int tmp_blobs, tmp_trees, tmp_tags;
     +	int any_missing = 0;
     +
    ++	cb.bitmap_git = bitmap_git;
    ++	cb.base = bitmap_new();
    ++	object_array_init(&cb.boundary);
    ++
     +	revs->ignore_missing_links = 1;
     +
     +	/*
    -+	 * OR in any existing reachability bitmaps among `roots` into `base`.
    ++	 * OR in any existing reachability bitmaps among `roots` into
    ++	 * `cb.base`.
     +	 */
    -+	while (roots) {
    -+		struct object *object = roots->item;
    -+		roots = roots->next;
    ++	for (root = roots; root; root = root->next) {
    ++		struct object *object = root->item;
    ++		if (object->type != OBJ_COMMIT ||
    ++		    bitmap_walk_contains(bitmap_git, cb.base, &object->oid))
    ++			continue;
     +
    -+		if (object->type == OBJ_COMMIT &&
    -+		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
    -+		    add_commit_to_bitmap(bitmap_git, &cb.base,
    -+					 (struct commit *)object)) {
    -+			object->flags |= SEEN;
    ++		if (add_commit_to_bitmap(bitmap_git, &cb.base,
    ++					 (struct commit *)object))
     +			continue;
    -+		}
     +
     +		any_missing = 1;
     +	}
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +				      show_boundary_object,
     +				      &cb, NULL);
     +	revs->boundary = 0;
    ++	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
    ++
     +	revs->blob_objects = tmp_blobs;
     +	revs->tree_objects = tmp_trees;
     +	revs->tag_objects = tmp_tags;
     +
     +	reset_revision_walk();
     +	clear_object_flags(UNINTERESTING);
    -+	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
     +
     +	/*
     +	 * Then add the boundary commit(s) as fill-in traversal tips.
     +	 */
     +	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
    -+	if (cb.boundary.nr) {
    -+		struct object *obj;
    -+		int needs_walk = 0;
    -+
    -+		for (i = 0; i < cb.boundary.nr; i++) {
    -+			obj = cb.boundary.objects[i].item;
    -+
    -+			if (obj_in_bitmap(bitmap_git, obj, cb.base)) {
    -+				obj->flags |= SEEN;
    -+			} else {
    -+				add_pending_object(revs, obj, "");
    -+				needs_walk = 1;
    -+			}
    -+		}
    -+
    -+		if (needs_walk)
    -+			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
    ++	for (i = 0; i < cb.boundary.nr; i++) {
    ++		struct object *obj = cb.boundary.objects[i].item;
    ++		if (bitmap_walk_contains(bitmap_git, cb.base, &obj->oid))
    ++			obj->flags |= SEEN;
    ++		else
    ++			add_pending_object(revs, obj, "");
     +	}
    ++	if (revs->pending.nr)
    ++		cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
     +	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
     +
    -+
     +cleanup:
    ++	object_array_clear(&cb.boundary);
     +	revs->ignore_missing_links = 0;
     +
     +	return cb.base;
    @@ pack-bitmap.c: static struct bitmap *find_objects(struct bitmap_index *bitmap_gi
      
      	return base;
      }
    -@@ pack-bitmap.c: static void show_objects_for_type(
    - 	}
    - }
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 					 int filter_provided_objects)
    + {
    + 	unsigned int i;
    ++	int use_boundary_traversal;
      
    --static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
    --			     struct object_list *roots)
    --{
    --	while (roots) {
    --		struct object *object = roots->item;
    --		roots = roots->next;
    --
    --		if (bitmap_is_midx(bitmap_git)) {
    --			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
    --				return 1;
    --		} else {
    --			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
    --				return 1;
    --		}
    --	}
    --
    --	return 0;
    --}
    --
    - static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
    - 				       struct object_list *tip_objects,
    - 				       enum object_type type)
    + 	struct object_list *wants = NULL;
    + 	struct object_list *haves = NULL;
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      			object_list_insert(object, &wants);
      	}
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     -	 */
     -	if (haves && !in_bitmapped_pack(bitmap_git, haves))
     -		goto cleanup;
    --
    ++	use_boundary_traversal = git_env_bool(GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL, -1);
    ++	if (use_boundary_traversal < 0) {
    ++		prepare_repo_settings(revs->repo);
    ++		use_boundary_traversal = revs->repo->settings.pack_use_bitmap_boundary_traversal;
    ++	}
    ++
    ++	if (!use_boundary_traversal) {
    ++		/*
    ++		 * if we have a HAVES list, but none of those haves is contained
    ++		 * in the packfile that has a bitmap, we don't have anything to
    ++		 * optimize here
    ++		 */
    ++		if (haves && !in_bitmapped_pack(bitmap_git, haves))
    ++			goto cleanup;
    ++	}
    + 
      	/* if we don't want anything, we're done here */
      	if (!wants)
    - 		goto cleanup;
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      	if (load_bitmap(revs->repo, bitmap_git) < 0)
      		goto cleanup;
      
     -	object_array_clear(&revs->pending);
    --
    ++	if (!use_boundary_traversal)
    ++		object_array_clear(&revs->pending);
    + 
      	if (haves) {
     -		revs->ignore_missing_links = 1;
     -		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
     -		reset_revision_walk();
     -		revs->ignore_missing_links = 0;
    --
    -+		haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
    ++		if (use_boundary_traversal) {
    ++			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
    ++			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
    ++			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
    ++		} else {
    ++			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
    ++			revs->ignore_missing_links = 1;
    ++			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
    ++			reset_revision_walk();
    ++			revs->ignore_missing_links = 0;
    ++			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
    ++		}
    + 
      		if (!haves_bitmap)
      			BUG("failed to perform bitmap walk");
      	}
      
    -+	object_array_clear(&revs->pending);
    -+	reset_revision_walk();
    ++	if (use_boundary_traversal) {
    ++		object_array_clear(&revs->pending);
    ++		reset_revision_walk();
    ++	}
     +
      	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
      
      	if (!wants_bitmap)
    +
    + ## pack-bitmap.h ##
    +@@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index *,
    + void test_bitmap_walk(struct rev_info *revs);
    + int test_bitmap_commits(struct repository *r);
    + int test_bitmap_hashes(struct repository *r);
    ++
    ++#define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
    ++	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
    ++
    + struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 					 int filter_provided_objects);
    + uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
    +
    + ## repo-settings.c ##
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
    + 
    + 	/* Defaults modified by feature.* */
    +-	if (experimental)
    ++	if (experimental) {
    + 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
    ++		r->settings.pack_use_bitmap_boundary_traversal = 1;
    ++	}
    + 	if (manyfiles) {
    + 		r->settings.index_version = 4;
    + 		r->settings.index_skip_hash = 1;
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
    + 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
    + 	repo_cfg_bool(r, "pack.readreverseindex", &r->settings.pack_read_reverse_index, 1);
    ++	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
    ++		      &r->settings.pack_use_bitmap_boundary_traversal,
    ++		      r->settings.pack_use_bitmap_boundary_traversal);
    + 
    + 	/*
    + 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
    +
    + ## repository.h ##
    +@@ repository.h: struct repo_settings {
    + 	int command_requires_full_index;
    + 	int sparse_index;
    + 	int pack_read_reverse_index;
    ++	int pack_use_bitmap_boundary_traversal;
    + 
    + 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
    + 
    +
    + ## t/README ##
    +@@ t/README: GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
    + for the index version specified.  Can be set to any valid version
    + (currently 2, 3, or 4).
    + 
    ++GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=<boolean> if enabled will
    ++use the boundary-based bitmap traversal algorithm. See the documentation
    ++of `pack.useBitmapBoundaryTraversal` for more details.
    ++
    + GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
    + builtin to use the non-sparse object walk. This can still be overridden by
    + the --sparse command-line argument.
    +
    + ## t/t5310-pack-bitmaps.sh ##
    +@@ t/t5310-pack-bitmaps.sh: test_description='exercise basic bitmap functionality'
    + # their place.
    + GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
    + 
    ++# Likewise, allow individual tests to control whether or not they use
    ++# the boundary-based traversal.
    ++sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
    ++
    + objpath () {
    + 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
    + }
    +@@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
    + 
    + test_bitmap_cases
    + 
    ++GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
    ++export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
    ++
    ++test_bitmap_cases
    ++
    ++sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
    ++
    + test_expect_success 'incremental repack fails when bitmaps are requested' '
    + 	test_commit more-1 &&
    + 	test_must_fail git repack -d 2>err &&
    +@@ t/t5310-pack-bitmaps.sh: test_expect_success 'incremental repack can disable bitmaps' '
    + 	git repack -d --no-write-bitmap-index
    + '
    + 
    ++test_expect_success 'boundary-based traversal is used when requested' '
    ++	git repack -a -d --write-bitmap-index &&
    ++
    ++	for argv in \
    ++		"git -c pack.useBitmapBoundaryTraversal=true" \
    ++		"git -c feature.experimental=true" \
    ++		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 git"
    ++	do
    ++		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
    ++			--use-bitmap-index second..other 2>perf" &&
    ++		grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
    ++			return 1
    ++	done &&
    ++
    ++	for argv in \
    ++		"git -c pack.useBitmapBoundaryTraversal=false" \
    ++		"git -c feature.experimental=true -c pack.useBitmapBoundaryTraversal=false" \
    ++		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c pack.useBitmapBoundaryTraversal=true" \
    ++		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c feature.experimental=true"
    ++	do
    ++		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
    ++			--use-bitmap-index second..other 2>perf" &&
    ++		grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
    ++			return 1
    ++	done
    ++'
    ++
    + test_bitmap_cases "pack.writeBitmapLookupTable"
    + 
    + test_expect_success 'verify writing bitmap lookup table when enabled' '
-- 
2.40.1.479.g8f2b93ade7
