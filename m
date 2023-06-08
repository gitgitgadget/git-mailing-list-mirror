Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED707C7EE25
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjFHQZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjFHQZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D919D2717
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:25:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bbc0168b02bso516578276.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686241535; x=1688833535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+l7oU5h6l9hEaD4tD4lNPaBcpP+T10R2d56Ri+JgnY=;
        b=vTb4qepnCbYzG1NlL7iWPdx7nwYilY52Pal4YSnZY0LD++lUoblBWB43NdUHF/dXAz
         j3ozC3CFT68wc7uWECSo1j1G7xiT32hhoVWNKoJSJhPPl/vp/VQGUphCmXyRw3A/oO1u
         yko4NMhTOr/Uu1BS8jUEtOvbiJfVr1WBwK7oxHui757pRZcJf4jJWp+deaxOny94iRDA
         4OrcZwAYuq9PlgayD2qxGxkxWQBtrtYRmQu4f6yDog+8aIIwa7o9Eop1DcUVTc8s9EyR
         APGX2DOxp3FMWPJANuCq6p2MQlDGfTINldW4YqJa41jEmw+C0H+CQqlEJktVZItaker5
         99rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241535; x=1688833535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+l7oU5h6l9hEaD4tD4lNPaBcpP+T10R2d56Ri+JgnY=;
        b=QTYztolwDEIeFY/DRoj3kr5Su4tGd8WdytfiT8n85k09snJpq0b+/V3I26YKQR82mK
         yDpTOmAQG3BYbmS3VeeU7RiX5CPUDqHko2tzPQKpKkRhgt2laG2ZXSjd6hlmPQWj4KnO
         vLRosUWEWQuwZjvojctq+4WOrV3cryQYG3N5ddSefsm1IT2PqTafpt8u6iXEpMzy5qBM
         vwUik6OIu1LQauJx1ZyBJRc8L4HsYArsV+VKaWsocM4d9//c0WKHS+ZCoEgBraHCsHh+
         htlPRJJ+zACd9IvXWt9F73u2vJipV+5iM2xqT0GPteMRYihU6NygUzAC6kAZ0xp7zjvQ
         MVJA==
X-Gm-Message-State: AC+VfDx4yX/bqXm/1E6ViZDJIcALH0NJ8FKnRjVt1oqL93BVW9RIWl2s
        ioylfYc25IyTKc3j3FN0+YvoLsLxK9FtL5jEt+Yb34uq
X-Google-Smtp-Source: ACHHUZ6W87czyIUTGBLiaDMwJd825ylNIej56htdJ7Qsd/72EGfiQpmEeFHS6H0rHk/mEWtEt1imZw==
X-Received: by 2002:a0d:d68e:0:b0:568:be91:c2c0 with SMTP id y136-20020a0dd68e000000b00568be91c2c0mr242969ywd.6.1686241534404;
        Thu, 08 Jun 2023 09:25:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x1-20020a0dd501000000b0055a2cda24acsm21058ywd.35.2023.06.08.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:25:34 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:25:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
Message-ID: <b80d17c93886beebf14fcc9e1407973b80006b34.1686231639.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1686231639.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686231639.git.me@ttaylorr.com>
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

    # (Computing the number of tagged objects not on any branches
    # without bitmaps).
    $ time git rev-list --count --objects --tags --not --branches
    20

    real	0m1.388s
    user	0m1.092s
    sys	0m0.296s

    # (Computing the same query using the old bitmap traversal).
    $ time git rev-list --count --objects --tags --not --branches --use-bitmap-index
    19

    real	0m22.709s
    user	0m21.628s
    sys	0m1.076s

    # (this commit)
    $ time git.compile rev-list --count --objects --tags --not --branches --use-bitmap-index
    19

    real	0m1.518s
    user	0m1.234s
    sys	0m0.284s

The new algorithm is still slower than not using bitmaps at all, but it
is nearly a 15-fold improvement over the existing traversal.

In a more realistic setting (using my local copy of git.git), I can
observe a similar (if more modest) speed-up:

    $ argv="--count --objects --branches --not --tags"
    hyperfine \
      -n 'no bitmaps' "git.compile rev-list $argv" \
      -n 'existing traversal' "git.compile rev-list --use-bitmap-index $argv" \
      -n 'boundary traversal' "git.compile -c pack.useBitmapBoundaryTraversal=true rev-list --use-bitmap-index $argv"
    Benchmark 1: no bitmaps
      Time (mean ± σ):     124.6 ms ±   2.1 ms    [User: 103.7 ms, System: 20.8 ms]
      Range (min … max):   122.6 ms … 133.1 ms    22 runs

    Benchmark 2: existing traversal
      Time (mean ± σ):     368.6 ms ±   3.0 ms    [User: 325.3 ms, System: 43.1 ms]
      Range (min … max):   365.1 ms … 374.8 ms    10 runs

    Benchmark 3: boundary traversal
      Time (mean ± σ):     167.6 ms ±   0.9 ms    [User: 139.5 ms, System: 27.9 ms]
      Range (min … max):   166.1 ms … 169.2 ms    17 runs

    Summary
      'no bitmaps' ran
        1.34 ± 0.02 times faster than 'boundary traversal'
        2.96 ± 0.05 times faster than 'existing traversal'

Here, the new algorithm is also still slower than not using bitmaps, but
represents a more than 2-fold improvement over the existing traversal in
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
 Documentation/config/feature.txt |   3 +
 Documentation/config/pack.txt    |  17 +++
 ci/run-build-and-tests.sh        |   1 +
 pack-bitmap.c                    | 182 ++++++++++++++++++++++++++++---
 pack-bitmap.h                    |   4 +
 repo-settings.c                  |   7 +-
 repository.h                     |   1 +
 t/README                         |   4 +
 t/t5310-pack-bitmaps.sh          |  38 +++++++
 9 files changed, 243 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 17b4d39f89..bf9546fca4 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,6 +14,9 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
++
+* `pack.useBitmapBoundaryTraversal=true` may improve bitmap traversal times by
+walking fewer objects.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index d4c7c9d4e4..3748136d14 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -123,6 +123,23 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
+pack.useBitmapBoundaryTraversal::
+	When true, Git will use an experimental algorithm for computing
+	reachability queries with bitmaps. Instead of building up
+	complete bitmaps for all of the negated tips and then OR-ing
+	them together, consider negated tips with existing bitmaps as
+	additive (i.e. OR-ing them into the result if they exist,
+	ignoring them otherwise), and build up a bitmap at the boundary
+	instead.
++
+When using this algorithm, Git may include too many objects as a result
+of not opening up trees belonging to certain UNINTERESTING commits. This
+inexactness matches the non-bitmap traversal algorithm.
++
+In many cases, this can provide a speed-up over the exact algorithm,
+particularly when there is poor bitmap coverage of the negated side of
+the query.
+
 pack.useSparse::
 	When true, git will default to using the '--sparse' option in
 	'git pack-objects' when the '--revs' option is present. This
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index a18b13a41d..2528f25e31 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -29,6 +29,7 @@ linux-TEST-vars)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
+	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
diff --git a/pack-bitmap.c b/pack-bitmap.c
index c1a9c70061..894bff02c5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1077,6 +1077,126 @@ static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
 	return base;
 }
 
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
+		if (bitmap_walk_contains(data->bitmap_git, data->base,
+					 &commit->object.oid))
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
+	struct bitmap_boundary_cb cb;
+	struct object_list *root;
+	unsigned int i;
+	unsigned int tmp_blobs, tmp_trees, tmp_tags;
+	int any_missing = 0;
+
+	cb.bitmap_git = bitmap_git;
+	cb.base = bitmap_new();
+	object_array_init(&cb.boundary);
+
+	revs->ignore_missing_links = 1;
+
+	/*
+	 * OR in any existing reachability bitmaps among `roots` into
+	 * `cb.base`.
+	 */
+	for (root = roots; root; root = root->next) {
+		struct object *object = root->item;
+		if (object->type != OBJ_COMMIT ||
+		    bitmap_walk_contains(bitmap_git, cb.base, &object->oid))
+			continue;
+
+		if (add_commit_to_bitmap(bitmap_git, &cb.base,
+					 (struct commit *)object))
+			continue;
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
+	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
+
+	revs->blob_objects = tmp_blobs;
+	revs->tree_objects = tmp_trees;
+	revs->tag_objects = tmp_tags;
+
+	reset_revision_walk();
+	clear_object_flags(UNINTERESTING);
+
+	/*
+	 * Then add the boundary commit(s) as fill-in traversal tips.
+	 */
+	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
+	for (i = 0; i < cb.boundary.nr; i++) {
+		struct object *obj = cb.boundary.objects[i].item;
+		if (bitmap_walk_contains(bitmap_git, cb.base, &obj->oid))
+			obj->flags |= SEEN;
+		else
+			add_pending_object(revs, obj, "");
+	}
+	if (revs->pending.nr)
+		cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
+	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
+
+cleanup:
+	object_array_clear(&cb.boundary);
+	revs->ignore_missing_links = 0;
+
+	return cb.base;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -1142,8 +1262,21 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
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
@@ -1535,6 +1668,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects)
 {
 	unsigned int i;
+	int use_boundary_traversal;
 
 	struct object_list *wants = NULL;
 	struct object_list *haves = NULL;
@@ -1585,13 +1719,21 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			object_list_insert(object, &wants);
 	}
 
-	/*
-	 * if we have a HAVES list, but none of those haves is contained
-	 * in the packfile that has a bitmap, we don't have anything to
-	 * optimize here
-	 */
-	if (haves && !in_bitmapped_pack(bitmap_git, haves))
-		goto cleanup;
+	use_boundary_traversal = git_env_bool(GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL, -1);
+	if (use_boundary_traversal < 0) {
+		prepare_repo_settings(revs->repo);
+		use_boundary_traversal = revs->repo->settings.pack_use_bitmap_boundary_traversal;
+	}
+
+	if (!use_boundary_traversal) {
+		/*
+		 * if we have a HAVES list, but none of those haves is contained
+		 * in the packfile that has a bitmap, we don't have anything to
+		 * optimize here
+		 */
+		if (haves && !in_bitmapped_pack(bitmap_git, haves))
+			goto cleanup;
+	}
 
 	/* if we don't want anything, we're done here */
 	if (!wants)
@@ -1605,18 +1747,32 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	if (load_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
-	object_array_clear(&revs->pending);
+	if (!use_boundary_traversal)
+		object_array_clear(&revs->pending);
 
 	if (haves) {
-		revs->ignore_missing_links = 1;
-		haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
-		reset_revision_walk();
-		revs->ignore_missing_links = 0;
+		if (use_boundary_traversal) {
+			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
+			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
+			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
+		} else {
+			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
+			revs->ignore_missing_links = 1;
+			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
+			reset_revision_walk();
+			revs->ignore_missing_links = 0;
+			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
+		}
 
 		if (!haves_bitmap)
 			BUG("failed to perform bitmap walk");
 	}
 
+	if (use_boundary_traversal) {
+		object_array_clear(&revs->pending);
+		reset_revision_walk();
+	}
+
 	wants_bitmap = find_objects(bitmap_git, revs, wants, haves_bitmap);
 
 	if (!wants_bitmap)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 84591f041b..5273a6a019 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -62,6 +62,10 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
+
+#define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
+	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
+
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
diff --git a/repo-settings.c b/repo-settings.c
index d220c5dd9f..7b566d729d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -41,8 +41,10 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
 
 	/* Defaults modified by feature.* */
-	if (experimental)
+	if (experimental) {
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		r->settings.pack_use_bitmap_boundary_traversal = 1;
+	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
 		r->settings.index_skip_hash = 1;
@@ -62,6 +64,9 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
 	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
 	repo_cfg_bool(r, "pack.readreverseindex", &r->settings.pack_read_reverse_index, 1);
+	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
+		      &r->settings.pack_use_bitmap_boundary_traversal,
+		      r->settings.pack_use_bitmap_boundary_traversal);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index 1a13ff2867..c42f7ab6bd 100644
--- a/repository.h
+++ b/repository.h
@@ -37,6 +37,7 @@ struct repo_settings {
 	int command_requires_full_index;
 	int sparse_index;
 	int pack_read_reverse_index;
+	int pack_use_bitmap_boundary_traversal;
 
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
diff --git a/t/README b/t/README
index bdfac4cceb..b71a065e4a 100644
--- a/t/README
+++ b/t/README
@@ -442,6 +442,10 @@ GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
 
+GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=<boolean> if enabled will
+use the boundary-based bitmap traversal algorithm. See the documentation
+of `pack.useBitmapBoundaryTraversal` for more details.
+
 GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
 builtin to use the non-sparse object walk. This can still be overridden by
 the --sparse command-line argument.
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 526a5a506e..78c1c6c923 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -9,6 +9,10 @@ test_description='exercise basic bitmap functionality'
 # their place.
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
+# Likewise, allow individual tests to control whether or not they use
+# the boundary-based traversal.
+sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
+
 objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
@@ -457,6 +461,13 @@ test_bitmap_cases () {
 
 test_bitmap_cases
 
+GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
+
+test_bitmap_cases
+
+sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
+
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
@@ -468,6 +479,33 @@ test_expect_success 'incremental repack can disable bitmaps' '
 	git repack -d --no-write-bitmap-index
 '
 
+test_expect_success 'boundary-based traversal is used when requested' '
+	git repack -a -d --write-bitmap-index &&
+
+	for argv in \
+		"git -c pack.useBitmapBoundaryTraversal=true" \
+		"git -c feature.experimental=true" \
+		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 git"
+	do
+		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
+			--use-bitmap-index second..other 2>perf" &&
+		grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
+			return 1
+	done &&
+
+	for argv in \
+		"git -c pack.useBitmapBoundaryTraversal=false" \
+		"git -c feature.experimental=true -c pack.useBitmapBoundaryTraversal=false" \
+		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c pack.useBitmapBoundaryTraversal=true" \
+		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c feature.experimental=true"
+	do
+		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
+			--use-bitmap-index second..other 2>perf" &&
+		grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
+			return 1
+	done
+'
+
 test_bitmap_cases "pack.writeBitmapLookupTable"
 
 test_expect_success 'verify writing bitmap lookup table when enabled' '
-- 
2.41.0.3.gb80d17c938
