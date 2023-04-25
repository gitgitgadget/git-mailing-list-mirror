Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CB9C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjDYAAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDYAAb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:00:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B34527F
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8f72e5bd9bso7587419276.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682380828; x=1684972828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Arj09MzbCDDlzjFIuNVgt/nhPEZi/Jhm7brpTs9aMmc=;
        b=wfhltJ7kgavJ/MO+Q4xs5kqubHtiEpNzftr08go1baLY57dNA6X0UWTNSa0i0R4zIs
         fd9FetnsF8p1xd78kkzohWZFshUXKTggm9yU0BDSF+jAVhuLFC4GyP/9hCSBYHH5jNXs
         SLYGxmCd3bL7az39RE36GGoGFHEt82Wbpb+K2wjCllI+9XAdH5CHTj4i39G553/7fyDo
         2aT6K8/0zDCUSZNN5Sc4jUyWs1CELANIcH4wbemTr16q5qVEmZ14gislv3dMlt3cR0ti
         3wSeUzNRFfdu5GlOrp7iolfQbJoksh0LnUjfTgSW/R1IAG9LUeZ0t2TR29OEgr03IsjI
         APWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380828; x=1684972828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arj09MzbCDDlzjFIuNVgt/nhPEZi/Jhm7brpTs9aMmc=;
        b=UdqLIqWr3AryhjfiCmw31EL10i374lnPAo//VVgwkz/544VW/76VULv182KaHSbQaz
         Y3jGJvp2ioTGCYKM2QWcZQC9jT76rAR8rqw8pzn/Tmsgj5Vz8SaUZrUTrEYCHcWtP43N
         gagWSxHRhnGjjj8g2w2x58Km012i6ROap4VLpspjNwDEeVTDx3S8aNay9rwfLyMF7ZsS
         qKU9P5D14mGbheFKgLl+ek2fi2vm276Y/LQcjNyirF5iMsEIcPHgXdH+jq07jmvGOziM
         h7OCod2NSlikrxp/zhGEt8dygUo2jx459YUkkrGSmu3F2qEsR4DziTh/xvqx8zRWh0T7
         Lwew==
X-Gm-Message-State: AAQBX9cNOBXTO0d79LAWALHP7r8dvkxKpYt+FeCoKX4EWpYjZWjNyeCs
        aOaaMyf4zKPa5SU4o1GloY1Xf2oaPG+esAQ+xdqEYw==
X-Google-Smtp-Source: AKy350YnGyPfXyfUMnbUVE5v/2hQVtf0G66WSLm8mrUqH7y6IHjBAKprOjFg4bB1XM2naAqUQw53EA==
X-Received: by 2002:a25:d301:0:b0:b92:3f8b:d1aa with SMTP id e1-20020a25d301000000b00b923f8bd1aamr10055215ybf.61.1682380827997;
        Mon, 24 Apr 2023 17:00:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m132-20020a25588a000000b00b7767ca747bsm3190413ybb.24.2023.04.24.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:00:27 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:00:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <91ed8c70f22dd2c47c60d650323579fc42cc7f2d.1682380788.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reachability bitmap coverage exists in a repository, Git will use a
different (and hopefully faster) traversal to compute revision walks.

Consider a set of positive and negative tips (which we'll refer to with
their standard bitmap parlance by, "wants", and "haves"). In order to
figure out what objects exist between the tips, the existing traversal
in prepare_bitmap_walk() looks something like:

  1. Consider if we can even compute the set of objects with bitmaps,
     and fall back to the usual traversal if we cannot. For example,
     pathspec limiting traversals can't be computed using bitmaps (since
     they don't know which objects are at which paths). The same is true
     of certain kinds of non-trivial object filters.

  2. If we can compute the traversal with bitmaps, partition the
     (dereferenced) tips into two object lists, "haves", and "wants",
     based on whether or not the objects have the UNINTERESTING flag,
     respectively.

  3. Fall back to the ordinary object traversal if either (a) there are
     no haves, (b) none of the haves are in the bitmapped pack or MIDX,
     or (c) there are no wants.

  4. Construct a reachability bitmap for the "haves" side by walking
     from the revision tips down to any existing bitmaps, OR-ing in any
     bitmaps as they are found.

  5. Then do the same for the "wants" side, stopping at any objects that
     appear in the "haves" bitmap.

  6. Filter the results if any object filter (that can be easily
     computed with bitmaps alone) was given, and then return back to the
     caller.

When there is good bitmap coverage relative to the traversal tips, this
walk is often significantly faster than an ordinary object traversal
because it can visit far fewer objects.

But in certain cases, it can be significantly *slower* than the usual
object traversal. Why? Because we need to compute complete bitmaps on
either side of the walk. If either one (or both) of the sides require
walking many (or all!) objects before they get to an existing bitmap,
the extra bitmap machinery is mostly or all overhead.

One of the benefits, however, is that even if the walk is slower, bitmap
traversals are guaranteed to provide an *exact* answer. Unlike the
traditional object traversal algorithm, which can over-count the results
by not opening trees for older commits, the bitmap walk builds an exact
reachability bitmap for either side, meaning the results are never
over-counted.

But producing non-exact results is OK for our traversal here (both in
the bitmap case and not), as long as the results are over-counted, not
under.

Relaxing the bitmap traversal to allow it to produce over-counted
results gives us the opportunity to make some significant improvements.
Instead of the above, the new algorithm only has to walk from the
*boundary* down to the nearest bitmap, instead of from each of the
UNINTERESTING tips.

The boundary-based approach still has degenerate cases, but we'll show
in a moment that it is often a significant improvement.

The new algorithm works as follows:

  1. Build a (partial) bitmap of the haves side by first OR-ing any
     bitmap(s) that already exist for UNINTERESTING commits between the
     haves and the boundary.

  2. For each commit along the boundary, add it as a fill-in traversal
     tip (where the traversal terminates once an existing bitmap is
     found), and perform fill-in traversal.

  3. Build up a complete bitmap of the wants side as usual, stopping any
     time we intersect the (partial) haves side.

  4. Return the results.

And is more-or-less equivalent to using the *old* algorithm with this
invocation:

    $ git rev-list --objects --boundary $WANTS --not $HAVES |
        perl -lne 'print $1 if /^-(.*)/' |
        xargs git rev-list --objects --use-bitmap-index $WANTS --not

The new result performs significantly better in many cases, particularly
when the distance from the boundary commit(s) to an existing bitmap is
shorter than the distance from (all of) the have tips to the nearest
bitmapped commit.

Note that when using the old bitmap traversal algorithm, the results can
be *slower* than without bitmaps! Under the new algorithm, the result is
computed faster with bitmaps than without (at the cost of over-counting
the true number of objects in a similar fashion as the non-bitmap
traversal):

    # (Computing objects unique to 'master' among all branches, not
    # using bitmaps).
    $ time git rev-list --count --objects master --not --exclude=master --branches
    54

    real	0m1.012s
    user	0m0.796s
    sys	0m0.214s

    # (Computing the same uniqueness query using the old bitmap
    # traversal algorithm.)
    $ time git rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    42

    real	0m29.571s
    user	0m28.404s
    sys	0m1.164s

    # (Computing the same uniqueness query using the new bitmap
    # traversal algorithm.)
    $ time git.compile rev-list --count --objects --use-bitmap-index master --not --exclude=master --branches
    54

    real	0m2.279s
    user	0m2.023s
    sys	0m0.256s

The new algorithm is still slower than not using bitmaps at all, but it
is nearly a 13-fold improvement over the existing traversal.

In a more realistic setting (using my local copy of git.git), I can
observe a similar speed-up:

    $ ours="$(git branch --show-current)"
      argv="--count --objects $ours --not --exclude=$ours --branches"
      hyperfine \
        -n 'no bitmaps' "git.compile rev-list $argv" \
        -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
        -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
    Benchmark 1: no bitmaps
      Time (mean ± σ):      15.1 ms ±   4.1 ms    [User: 8.1 ms, System: 6.9 ms]
      Range (min … max):     7.4 ms …  21.8 ms    131 runs

    Benchmark 2: existing bitmap traversal
      Time (mean ± σ):      82.6 ms ±   9.2 ms    [User: 63.6 ms, System: 19.0 ms]
      Range (min … max):    73.8 ms … 105.4 ms    28 runs

    Benchmark 3: this commit
      Time (mean ± σ):      19.8 ms ±   3.1 ms    [User: 13.0 ms, System: 6.8 ms]
      Range (min … max):    17.7 ms …  38.6 ms    158 runs

    Summary
      'no bitmaps' ran
        1.31 ± 0.41 times faster than 'this commit'
        5.49 ± 1.62 times faster than 'existing bitmap traversal'

Here, the new algorithm is also still slower than not using bitmaps, but
represents a 4-fold improvement over the existing traversal in a more
modest example.

Since this algorithm was originally written (nearly a year and a half
ago, at the time of writing), the bitmap lookup table shipped, making
the new algorithm's result more competitive. A few other future
directions for improving bitmap traversal times beyond not using bitmaps
at all:

  - Decrease the cost to decompress and OR together many bitmaps
    together (particularly when enumerating the uninteresting side of
    the walk). Here we could explore more efficient bitmap storage
    techniques, like Roaring+Run and/or use SIMD instructions to speed
    up ORing them together.

  - Store pseudo-merge bitmaps, which could allow us to OR together
    fewer "summary" bitmaps (which would also help with the above).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 194 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 158 insertions(+), 36 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 046240d072..c47c97f35b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1048,7 +1048,7 @@ static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
 	struct include_data incdata;
 	struct bitmap_show_data show_data;
 
-	if (base == NULL)
+	if (!base)
 		base = bitmap_new();
 
 	incdata.bitmap_git = bitmap_git;
@@ -1075,6 +1075,145 @@ static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
 	return base;
 }
 
+static int obj_in_bitmap(struct bitmap_index *bitmap_git,
+			 struct object *obj, struct bitmap *bitmap)
+{
+	int pos;
+
+	if (!bitmap)
+		return 0;
+	pos = bitmap_position(bitmap_git, &obj->oid);
+	if (pos < 0)
+		return 0;
+	return bitmap_get(bitmap, pos);
+}
+
+static void show_boundary_commit(struct commit *commit, void *data)
+{
+	struct object_array *boundary = data;
+	if (!(commit->object.flags & BOUNDARY))
+		return;
+
+	add_object_array(&commit->object, "", boundary);
+}
+
+static void show_boundary_object(struct object *object,
+				 const char *name, void *data)
+{
+	BUG("should not be called");
+}
+
+static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
+					    struct rev_info *revs,
+					    struct object_list *roots)
+{
+	struct bitmap *base = NULL;
+	struct object_array boundary = OBJECT_ARRAY_INIT;
+	int any_missing = 0;
+	unsigned int i;
+	int tmp_blobs, tmp_trees, tmp_tags;
+
+	revs->ignore_missing_links = 1;
+	revs->collect_uninteresting = 1;
+
+	/*
+	 * OR in any existing reachability bitmaps among `roots` into `base`.
+	 */
+	while (roots) {
+		struct object *object = roots->item;
+		roots = roots->next;
+
+		if (object->type == OBJ_COMMIT &&
+		    !obj_in_bitmap(bitmap_git, object, base) &&
+		    add_commit_to_bitmap(bitmap_git, &base,
+					 (struct commit *)object)) {
+			object->flags |= SEEN;
+			continue;
+		}
+
+		any_missing = 1;
+	}
+
+	if (!any_missing)
+		goto cleanup;
+
+	tmp_blobs = revs->blob_objects;
+	tmp_trees = revs->tree_objects;
+	tmp_tags = revs->blob_objects;
+	revs->blob_objects = 0;
+	revs->tree_objects = 0;
+	revs->tag_objects = 0;
+
+	/*
+	 * We didn't have complete coverage of the roots. First OR in any
+	 * bitmaps that are UNINTERESTING between the tips and boundary.
+	 */
+	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
+
+	trace2_region_enter("pack-bitmap", "boundary-load-bitmaps", the_repository);
+	for (i = 0; i < revs->uninteresting_commits.nr; i++) {
+		struct object *obj = revs->uninteresting_commits.objects[i].item;
+		if (obj->type != OBJ_COMMIT)
+			BUG("unexpected non-commit %s marked uninteresting",
+			    oid_to_hex(&obj->oid));
+
+		if (obj_in_bitmap(bitmap_git, obj, base))
+			continue;
+
+		add_commit_to_bitmap(bitmap_git, &base, (struct commit *)obj);
+	}
+	trace2_region_leave("pack-bitmap", "boundary-load-bitmaps", the_repository);
+
+	/*
+	 * Then add the boundary commit(s) as fill-in traversal tips.
+	 */
+	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
+	revs->boundary = 1;
+	traverse_commit_list_filtered(revs,
+				      show_boundary_commit,
+				      show_boundary_object,
+				      &boundary, NULL);
+	revs->boundary = 0;
+	revs->blob_objects = tmp_blobs;
+	revs->tree_objects = tmp_trees;
+	revs->tag_objects = tmp_tags;
+
+	reset_revision_walk();
+	clear_object_flags(UNINTERESTING);
+	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
+
+	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
+	if (boundary.nr) {
+		struct object *obj;
+		int needs_walk = 0;
+
+		for (i = 0; i < boundary.nr; i++) {
+			obj = boundary.objects[i].item;
+
+			if (obj_in_bitmap(bitmap_git, obj, base)) {
+				obj->flags |= SEEN;
+			} else {
+				add_pending_object(revs, obj, "");
+				needs_walk = 1;
+			}
+		}
+
+		if (needs_walk)
+			base = fill_in_bitmap(bitmap_git, revs, base, NULL);
+	}
+	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
+
+
+cleanup:
+	revs->ignore_missing_links = 0;
+	revs->collect_uninteresting = 0;
+
+	return base;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -1140,8 +1279,21 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		}
 	}
 
-	if (needs_walk)
+	if (needs_walk) {
+		/*
+		 * This fill-in traversal may walk over some objects
+		 * again, since we have already traversed in order to
+		 * find the boundary.
+		 *
+		 * But this extra walk should be extremely cheap, since
+		 * all commit objects are loaded into memory, and
+		 * because we skip walking to parents that are
+		 * UNINTERESTING, since it will be marked in the haves
+		 * bitmap already (or it has an on-disk bitmap, since
+		 * OR-ing it in covers all of its ancestors).
+		 */
 		base = fill_in_bitmap(bitmap_git, revs, base, seen);
+	}
 
 	return base;
 }
@@ -1257,25 +1409,6 @@ static void show_objects_for_type(
 	}
 }
 
-static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
-			     struct object_list *roots)
-{
-	while (roots) {
-		struct object *object = roots->item;
-		roots = roots->next;
-
-		if (bitmap_is_midx(bitmap_git)) {
-			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
-				return 1;
-		} else {
-			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
-				return 1;
-		}
-	}
-
-	return 0;
-}
-
 static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 				       struct object_list *tip_objects,
 				       enum object_type type)
@@ -1583,14 +1716,6 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			object_list_insert(object, &wants);
 	}
 
-	/*
-	 * if we have a HAVES list, but none of those haves is contained
-	 * in the packfile that has a bitmap, we don't have anything to
-	 * optimize here
-	 */
-	if (haves && !in_bitmapped_pack(bitmap_git, haves))
-		goto cleanup;
-
 	/* if we don't want anything, we're done here */
 	if (!wants)
 		goto cleanup;
@@ -1603,18 +1728,15 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (load_bitmap(bitmap_git) < 0)
 		goto cleanup;
 
-	object_array_clear(&revs->pending);
-
 	if (haves) {
-		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
-		reset_revision_walk();
-		revs->ignore_missing_links = 0;
-
+		haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
 		if (!haves_bitmap)
 			BUG("failed to perform bitmap walk");
 	}
 
+	object_array_clear(&revs->pending);
+	reset_revision_walk();
+
 	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
-- 
2.40.0.380.gda896aa358.dirty
