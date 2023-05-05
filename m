Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D45BC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjEER1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjEER1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:27:40 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1131A1F9
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:27:39 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a10577911so29638767b3.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683307658; x=1685899658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/24RzrQUlfrlMRjIZ9qN6/Bav/jPt3qURpR7VJX8+0=;
        b=NuDj+TuKPXdWhV2oGIek01RBL9OPU+y3Xlf5PgGwomSpXuJ+gi/nc+ZCfLK1jwBRu/
         2bvtRWxHNVKVhnPGl8jhhM2ULaFEPxumjjV+ddi8pv6gsGPiZYH8LNzRK5ovMVda9UuU
         89p7xfUKE64EEM0NKfUl85QSg+64802Ey9ODUGSWoPb1FM2WIxDkwtDbFEjtThAl8ARH
         bm+DtgqnhktEwjBlNM9baGMN346wqDHgUfIooNAkXfLJ3idUEAX8Cd8Y7p4wrCRmcpdt
         WGzeqlOAhXRMYAjyz+A5jTA86z8rkiI9jw0O5ZFxG+JNlDPqL3G/U7BqpF1RhfGgWWgN
         QnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307658; x=1685899658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/24RzrQUlfrlMRjIZ9qN6/Bav/jPt3qURpR7VJX8+0=;
        b=EbB/yPusrDdF6LnheFh9cyNRbFyK35iIj1DPuCJlsZ6RINxlHD0EyX+/vcLyaYljJl
         ZTzveJgmuDVBX5WTK0h23C3/wYjdxIPwcuI/V8hgaobxZXBh7cAd3ucVaoaPYemELWSU
         ql1QHJRETnIUmKmMj+Tb49c2N/7CDP1OsDHSe+fmVXFWynam5ALF6//Y7NB/wE6OL8LS
         Vb8/OQf+bylFPH4zitjavO9uvdABD1m2FmggyAcyD+tBshuhIWpLvDRQl/6Mf9XVZy6k
         w4Xx6c2uUPFgggybyWgvYjEI4essIA4Ei1iCebtFuigT5g8ix4Guyy8duM+PZD5qdRFK
         ncNg==
X-Gm-Message-State: AC+VfDwpMlBNoJyBJOtGfAebJAxWTkhwVFTUFYyE6jItFzr8hdA0mvYj
        QkAsfIqP2QUNmZx3u927adw+cH9eKWkl7860cpz+zA==
X-Google-Smtp-Source: ACHHUZ5LyPfofY2gt39cJiEStIXroB1zn1jBb3WOuopAhTcQx7MfK6V3R74c0wmTrXv7WcT6RnPb3g==
X-Received: by 2002:a81:8348:0:b0:55b:f05b:d68 with SMTP id t69-20020a818348000000b0055bf05b0d68mr3041133ywf.20.1683307658070;
        Fri, 05 May 2023 10:27:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o185-20020a8173c2000000b00556b26dff6bsm579886ywc.64.2023.05.05.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:27:37 -0700 (PDT)
Date:   Fri, 5 May 2023 13:27:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <1993af00cba3af83755da557816c1c7a8b52c844.1683307620.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683307620.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683307620.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reachability bitmap coverage exists in a repository, Git will use a
different (and hopefully faster) traversal to compute revision walks.

Consider a set of positive and negative tips (which we'll refer to with
their standard bitmap parlance by "wants", and "haves"). In order to
figure out what objects exist between the tips, the existing traversal
in `prepare_bitmap_walk()` does something like:

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
     more than zero haves, none of which are in the bitmapped pack or
     MIDX, or (b) there are no wants.

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

    $ git rev-list --objects --use-bitmap-index $WANTS --not \
        $(git rev-list --objects --boundary $WANTS --not $HAVES |
          perl -lne 'print $1 if /^-(.*)/')

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
    43

    real	0m0.346s
    user	0m0.231s
    sys	0m0.115s

    # (Computing the same uniqueness query using the old bitmap
    # traversal algorithm.)
    $ time git rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    41

    real	0m20.007s
    user	0m19.045s
    sys	0m0.960s

    # (Computing the same uniqueness query using the new bitmap
    # traversal algorithm.)
    $ time git.compile rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    41

    real	0m1.748s
    user	0m1.428s
    sys	0m0.320s

The new algorithm is still slower than not using bitmaps at all, but it
is nearly a 11-fold improvement over the existing traversal.

In a more realistic setting (using my local copy of git.git), I can
observe a similar (if more modest) speed-up:

    $ ours="$(git branch --show-current)"
      argv="--count --objects $ours --not --exclude=$ours --branches"
      hyperfine \
        -n 'no bitmaps' "git.compile rev-list $argv" \
        -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
        -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
    Benchmark 1: no bitmaps
      Time (mean ± σ):       5.8 ms ±   0.2 ms    [User: 3.3 ms, System: 2.4 ms]
      Range (min … max):     5.4 ms …   7.0 ms    409 runs

    Benchmark 2: existing bitmap traversal
      Time (mean ± σ):      65.3 ms ±   0.6 ms    [User: 49.3 ms, System: 15.8 ms]
      Range (min … max):    64.1 ms …  66.9 ms    45 runs

    Benchmark 3: this commit
      Time (mean ± σ):      19.8 ms ±   0.3 ms    [User: 12.9 ms, System: 6.8 ms]
      Range (min … max):    19.1 ms …  20.8 ms    150 runs

    Summary
      'no bitmaps' ran
        3.43 ± 0.14 times faster than 'this commit'
       11.34 ± 0.45 times faster than 'existing bitmap traversal'

Here, the new algorithm is also still slower than not using bitmaps, but
represents a more than 3-fold improvement over the existing traversal in
a more modest example.

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
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 190 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 155 insertions(+), 35 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5d2cc6ac96..634fc10156 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1077,6 +1077,143 @@ static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
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
+struct bitmap_boundary_cb {
+	struct bitmap_index *bitmap_git;
+	struct bitmap *base;
+
+	struct object_array boundary;
+};
+
+static void show_boundary_commit(struct commit *commit, void *_data)
+{
+	struct bitmap_boundary_cb *data = _data;
+
+	if (commit->object.flags & BOUNDARY)
+		add_object_array(&commit->object, "", &data->boundary);
+
+	if (commit->object.flags & UNINTERESTING) {
+		if (obj_in_bitmap(data->bitmap_git, &commit->object,
+				  data->base))
+			return;
+
+		add_commit_to_bitmap(data->bitmap_git, &data->base, commit);
+	}
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
+	struct bitmap_boundary_cb cb = { .bitmap_git = bitmap_git };
+	unsigned int i;
+	unsigned int tmp_blobs, tmp_trees, tmp_tags;
+	int any_missing = 0;
+
+	revs->ignore_missing_links = 1;
+
+	/*
+	 * OR in any existing reachability bitmaps among `roots` into `base`.
+	 */
+	while (roots) {
+		struct object *object = roots->item;
+		roots = roots->next;
+
+		if (object->type == OBJ_COMMIT &&
+		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
+		    add_commit_to_bitmap(bitmap_git, &cb.base,
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
+	 * We didn't have complete coverage of the roots. First setup a
+	 * revision walk to (a) OR in any bitmaps that are UNINTERESTING
+	 * between the tips and boundary, and (b) record the boundary.
+	 */
+	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
+	if (prepare_revision_walk(revs))
+		die("revision walk setup failed");
+	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
+
+	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
+	revs->boundary = 1;
+	traverse_commit_list_filtered(revs,
+				      show_boundary_commit,
+				      show_boundary_object,
+				      &cb, NULL);
+	revs->boundary = 0;
+	revs->blob_objects = tmp_blobs;
+	revs->tree_objects = tmp_trees;
+	revs->tag_objects = tmp_tags;
+
+	reset_revision_walk();
+	clear_object_flags(UNINTERESTING);
+	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
+
+	/*
+	 * Then add the boundary commit(s) as fill-in traversal tips.
+	 */
+	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
+	if (cb.boundary.nr) {
+		struct object *obj;
+		int needs_walk = 0;
+
+		for (i = 0; i < cb.boundary.nr; i++) {
+			obj = cb.boundary.objects[i].item;
+
+			if (obj_in_bitmap(bitmap_git, obj, cb.base)) {
+				obj->flags |= SEEN;
+			} else {
+				add_pending_object(revs, obj, "");
+				needs_walk = 1;
+			}
+		}
+
+		if (needs_walk)
+			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
+	}
+	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
+
+
+cleanup:
+	revs->ignore_missing_links = 0;
+
+	return cb.base;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -1142,8 +1279,21 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
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
@@ -1259,25 +1409,6 @@ static void show_objects_for_type(
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
@@ -1585,14 +1716,6 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
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
@@ -1605,18 +1728,15 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (load_bitmap(revs->repo, bitmap_git) < 0)
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
2.40.1.478.gcab26587e8
