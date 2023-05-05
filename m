Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C5C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEER1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEER1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:27:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0017FDC
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:27:32 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9daef8681fso1883542276.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683307652; x=1685899652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVaAmIAUo7cARfTrjsP2IvZGkjaz7RF9dv4Ua+WzE2Y=;
        b=RhzF6f1kUfrpiIKVd5GF09BDz3RlIXH06rAtbFc2T03rPBAgDsfk2wIq7ZYAFB01TZ
         SKdJjBDCteehIjdaQyzda+e8GdnhtNE3pYcB1TD1bt1P+NiUPOkoyX3EfLG0pz/11tDd
         oLRlmQ7qahFP6pLbD/Y2jaF0uteEMCRUJzVCo/heB36qJBe/ikCq5wAwKHLXXcBqsscY
         NwQPAquQjUXvP743KAUWFqjV7NOdZSbmTU28fSo8S1JDNd+ef9sQ4XUzLWdsupblFXTT
         sM7GHvnmleOeidHDDc+5hCVwitnfTH/c5vOPvtIGKkh3ZscHB74zIT97fcS8yjHKl3yV
         6UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307652; x=1685899652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVaAmIAUo7cARfTrjsP2IvZGkjaz7RF9dv4Ua+WzE2Y=;
        b=XT2omZvjN2xgAtkDahc3gFUnTfuKwmo5bEVqlmNSaFcHqV35p6d0JzVbUyVTGTgWLj
         sPI6TAdGE/qnOo3KGPVGVJcVO3C8+e91jPXlJ4BrBMQ6B/KWGEzwdjAcWUi94RXOf6hE
         f19QTuw6HjCvEJhpph6a9Yexcaquxfi/xYTUESLdbmx4AwGOeud1cZkO8+D+T9i4JwYm
         I5Oa1AuFftVNNzeEWEnh4O/B2yfKibWY1yKzYa8gFQsvY40PFMHmtrgoBlqPZfwQq04U
         3D8TSciBwIQGxCzoWOn0jgSninaNvXzSIkHO8U4NYvq1tf0WedeNrVuvUee9BgabQ2tK
         QmDw==
X-Gm-Message-State: AC+VfDzkYPCTZlD4IXLscuSyf561T1V1dZCc6RQ6dMVZOecsAeE9BVkb
        gk9F38IRqawxsWNZTn2Iv5pclGnaEqGhiGPXzsatxw==
X-Google-Smtp-Source: ACHHUZ59YRTBxJS9A75k3s0hmkZbBUeKmbWopXDLmmzaWIB40eumpUy0XE4GpfKRSs/JqG1vINXAWg==
X-Received: by 2002:a25:38c:0:b0:b8f:5340:b052 with SMTP id 134-20020a25038c000000b00b8f5340b052mr2535571ybd.15.1683307651884;
        Fri, 05 May 2023 10:27:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a81-20020a251a54000000b00b7767ca749esm591910yba.59.2023.05.05.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:27:31 -0700 (PDT)
Date:   Fri, 5 May 2023 13:27:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] pack-bitmap: boundary-based bitmap traversal
Message-ID: <cover.1683307620.git.me@ttaylorr.com>
References: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1682380788.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement a boundary-based bitmap
traversal algorithm that I worked on towards the end of 2021 with Peff.

The algorithm is unchanged from the last version, but the implementation
has been made much more straightforward, thanks to a very helpful
suggestion from Stolee.

Instead of hackily trying to write down all of the UNINTERESTING commits
between the tips and boundary within limit_list(), we can just perform a
commit-only walk, which will give us the set of commits that we need.

Thanks in advance for your review.

Taylor Blau (2):
  pack-bitmap.c: extract `fill_in_bitmap()`
  pack-bitmap.c: use commit boundary during bitmap traversal

 pack-bitmap.c | 249 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 188 insertions(+), 61 deletions(-)

Range-diff against v1:
1:  a643678c0f < -:  ---------- revision: support tracking uninteresting commits
2:  7624d3b5ba ! 1:  a3a1522439 pack-bitmap.c: extract `fill_in_bitmap()`
    @@ pack-bitmap.c: static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
     +	struct include_data incdata;
     +	struct bitmap_show_data show_data;
     +
    -+	if (base == NULL)
    ++	if (!base)
     +		base = bitmap_new();
     +
     +	incdata.bitmap_git = bitmap_git;
    @@ pack-bitmap.c: static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
     +	revs->include_check_data = &incdata;
     +
     +	if (prepare_revision_walk(revs))
    -+		die("revision walk setup failed");
    ++		die(_("revision walk setup failed"));
     +
     +	show_data.bitmap_git = bitmap_git;
     +	show_data.base = base;
     +
    -+	traverse_commit_list_filtered(revs, show_commit, show_object,
    -+				      &show_data, NULL);
    ++	traverse_commit_list(revs, show_commit, show_object, &show_data);
     +
     +	revs->include_check = NULL;
     +	revs->include_check_obj = NULL;
3:  91ed8c70f2 ! 2:  1993af00cb pack-bitmap.c: use commit boundary during bitmap traversal
    @@ Commit message
         different (and hopefully faster) traversal to compute revision walks.
     
         Consider a set of positive and negative tips (which we'll refer to with
    -    their standard bitmap parlance by, "wants", and "haves"). In order to
    +    their standard bitmap parlance by "wants", and "haves"). In order to
         figure out what objects exist between the tips, the existing traversal
    -    in prepare_bitmap_walk() looks something like:
    +    in `prepare_bitmap_walk()` does something like:
     
           1. Consider if we can even compute the set of objects with bitmaps,
              and fall back to the usual traversal if we cannot. For example,
    @@ Commit message
              respectively.
     
           3. Fall back to the ordinary object traversal if either (a) there are
    -         no haves, (b) none of the haves are in the bitmapped pack or MIDX,
    -         or (c) there are no wants.
    +         more than zero haves, none of which are in the bitmapped pack or
    +         MIDX, or (b) there are no wants.
     
           4. Construct a reachability bitmap for the "haves" side by walking
              from the revision tips down to any existing bitmaps, OR-ing in any
    @@ Commit message
         And is more-or-less equivalent to using the *old* algorithm with this
         invocation:
     
    -        $ git rev-list --objects --boundary $WANTS --not $HAVES |
    -            perl -lne 'print $1 if /^-(.*)/' |
    -            xargs git rev-list --objects --use-bitmap-index $WANTS --not
    +        $ git rev-list --objects --use-bitmap-index $WANTS --not \
    +            $(git rev-list --objects --boundary $WANTS --not $HAVES |
    +              perl -lne 'print $1 if /^-(.*)/')
     
         The new result performs significantly better in many cases, particularly
         when the distance from the boundary commit(s) to an existing bitmap is
    @@ Commit message
             # (Computing objects unique to 'master' among all branches, not
             # using bitmaps).
             $ time git rev-list --count --objects master --not --exclude=master --branches
    -        54
    +        43
     
    -        real        0m1.012s
    -        user        0m0.796s
    -        sys 0m0.214s
    +        real        0m0.346s
    +        user        0m0.231s
    +        sys 0m0.115s
     
             # (Computing the same uniqueness query using the old bitmap
             # traversal algorithm.)
             $ time git rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    -        42
    +        41
     
    -        real        0m29.571s
    -        user        0m28.404s
    -        sys 0m1.164s
    +        real        0m20.007s
    +        user        0m19.045s
    +        sys 0m0.960s
     
             # (Computing the same uniqueness query using the new bitmap
             # traversal algorithm.)
    -        $ time git.compile rev-list --count --objects --use-bitmap-index master --not --exclude=master --branches
    -        54
    +        $ time git.compile rev-list --use-bitmap-index --count --objects master --not --exclude=master --branches
    +        41
     
    -        real        0m2.279s
    -        user        0m2.023s
    -        sys 0m0.256s
    +        real        0m1.748s
    +        user        0m1.428s
    +        sys 0m0.320s
     
         The new algorithm is still slower than not using bitmaps at all, but it
    -    is nearly a 13-fold improvement over the existing traversal.
    +    is nearly a 11-fold improvement over the existing traversal.
     
         In a more realistic setting (using my local copy of git.git), I can
    -    observe a similar speed-up:
    +    observe a similar (if more modest) speed-up:
     
             $ ours="$(git branch --show-current)"
               argv="--count --objects $ours --not --exclude=$ours --branches"
    @@ Commit message
                 -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
                 -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
             Benchmark 1: no bitmaps
    -          Time (mean ± σ):      15.1 ms ±   4.1 ms    [User: 8.1 ms, System: 6.9 ms]
    -          Range (min … max):     7.4 ms …  21.8 ms    131 runs
    +          Time (mean ± σ):       5.8 ms ±   0.2 ms    [User: 3.3 ms, System: 2.4 ms]
    +          Range (min … max):     5.4 ms …   7.0 ms    409 runs
     
             Benchmark 2: existing bitmap traversal
    -          Time (mean ± σ):      82.6 ms ±   9.2 ms    [User: 63.6 ms, System: 19.0 ms]
    -          Range (min … max):    73.8 ms … 105.4 ms    28 runs
    +          Time (mean ± σ):      65.3 ms ±   0.6 ms    [User: 49.3 ms, System: 15.8 ms]
    +          Range (min … max):    64.1 ms …  66.9 ms    45 runs
     
             Benchmark 3: this commit
    -          Time (mean ± σ):      19.8 ms ±   3.1 ms    [User: 13.0 ms, System: 6.8 ms]
    -          Range (min … max):    17.7 ms …  38.6 ms    158 runs
    +          Time (mean ± σ):      19.8 ms ±   0.3 ms    [User: 12.9 ms, System: 6.8 ms]
    +          Range (min … max):    19.1 ms …  20.8 ms    150 runs
     
             Summary
               'no bitmaps' ran
    -            1.31 ± 0.41 times faster than 'this commit'
    -            5.49 ± 1.62 times faster than 'existing bitmap traversal'
    +            3.43 ± 0.14 times faster than 'this commit'
    +           11.34 ± 0.45 times faster than 'existing bitmap traversal'
     
         Here, the new algorithm is also still slower than not using bitmaps, but
    -    represents a 4-fold improvement over the existing traversal in a more
    -    modest example.
    +    represents a more than 3-fold improvement over the existing traversal in
    +    a more modest example.
     
         Since this algorithm was originally written (nearly a year and a half
         ago, at the time of writing), the bitmap lookup table shipped, making
    @@ Commit message
             fewer "summary" bitmaps (which would also help with the above).
     
         Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-bitmap.c ##
    -@@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
    - 	struct include_data incdata;
    - 	struct bitmap_show_data show_data;
    - 
    --	if (base == NULL)
    -+	if (!base)
    - 		base = bitmap_new();
    - 
    - 	incdata.bitmap_git = bitmap_git;
     @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_git,
      	return base;
      }
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +	return bitmap_get(bitmap, pos);
     +}
     +
    -+static void show_boundary_commit(struct commit *commit, void *data)
    ++struct bitmap_boundary_cb {
    ++	struct bitmap_index *bitmap_git;
    ++	struct bitmap *base;
    ++
    ++	struct object_array boundary;
    ++};
    ++
    ++static void show_boundary_commit(struct commit *commit, void *_data)
     +{
    -+	struct object_array *boundary = data;
    -+	if (!(commit->object.flags & BOUNDARY))
    -+		return;
    ++	struct bitmap_boundary_cb *data = _data;
     +
    -+	add_object_array(&commit->object, "", boundary);
    ++	if (commit->object.flags & BOUNDARY)
    ++		add_object_array(&commit->object, "", &data->boundary);
    ++
    ++	if (commit->object.flags & UNINTERESTING) {
    ++		if (obj_in_bitmap(data->bitmap_git, &commit->object,
    ++				  data->base))
    ++			return;
    ++
    ++		add_commit_to_bitmap(data->bitmap_git, &data->base, commit);
    ++	}
     +}
     +
     +static void show_boundary_object(struct object *object,
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +					    struct rev_info *revs,
     +					    struct object_list *roots)
     +{
    -+	struct bitmap *base = NULL;
    -+	struct object_array boundary = OBJECT_ARRAY_INIT;
    -+	int any_missing = 0;
    ++	struct bitmap_boundary_cb cb = { .bitmap_git = bitmap_git };
     +	unsigned int i;
    -+	int tmp_blobs, tmp_trees, tmp_tags;
    ++	unsigned int tmp_blobs, tmp_trees, tmp_tags;
    ++	int any_missing = 0;
     +
     +	revs->ignore_missing_links = 1;
    -+	revs->collect_uninteresting = 1;
     +
     +	/*
     +	 * OR in any existing reachability bitmaps among `roots` into `base`.
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +		roots = roots->next;
     +
     +		if (object->type == OBJ_COMMIT &&
    -+		    !obj_in_bitmap(bitmap_git, object, base) &&
    -+		    add_commit_to_bitmap(bitmap_git, &base,
    ++		    !obj_in_bitmap(bitmap_git, object, cb.base) &&
    ++		    add_commit_to_bitmap(bitmap_git, &cb.base,
     +					 (struct commit *)object)) {
     +			object->flags |= SEEN;
     +			continue;
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +	revs->tag_objects = 0;
     +
     +	/*
    -+	 * We didn't have complete coverage of the roots. First OR in any
    -+	 * bitmaps that are UNINTERESTING between the tips and boundary.
    ++	 * We didn't have complete coverage of the roots. First setup a
    ++	 * revision walk to (a) OR in any bitmaps that are UNINTERESTING
    ++	 * between the tips and boundary, and (b) record the boundary.
     +	 */
     +	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
     +	if (prepare_revision_walk(revs))
     +		die("revision walk setup failed");
     +	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
     +
    -+	trace2_region_enter("pack-bitmap", "boundary-load-bitmaps", the_repository);
    -+	for (i = 0; i < revs->uninteresting_commits.nr; i++) {
    -+		struct object *obj = revs->uninteresting_commits.objects[i].item;
    -+		if (obj->type != OBJ_COMMIT)
    -+			BUG("unexpected non-commit %s marked uninteresting",
    -+			    oid_to_hex(&obj->oid));
    -+
    -+		if (obj_in_bitmap(bitmap_git, obj, base))
    -+			continue;
    -+
    -+		add_commit_to_bitmap(bitmap_git, &base, (struct commit *)obj);
    -+	}
    -+	trace2_region_leave("pack-bitmap", "boundary-load-bitmaps", the_repository);
    -+
    -+	/*
    -+	 * Then add the boundary commit(s) as fill-in traversal tips.
    -+	 */
     +	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
     +	revs->boundary = 1;
     +	traverse_commit_list_filtered(revs,
     +				      show_boundary_commit,
     +				      show_boundary_object,
    -+				      &boundary, NULL);
    ++				      &cb, NULL);
     +	revs->boundary = 0;
     +	revs->blob_objects = tmp_blobs;
     +	revs->tree_objects = tmp_trees;
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +	clear_object_flags(UNINTERESTING);
     +	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
     +
    ++	/*
    ++	 * Then add the boundary commit(s) as fill-in traversal tips.
    ++	 */
     +	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
    -+	if (boundary.nr) {
    ++	if (cb.boundary.nr) {
     +		struct object *obj;
     +		int needs_walk = 0;
     +
    -+		for (i = 0; i < boundary.nr; i++) {
    -+			obj = boundary.objects[i].item;
    ++		for (i = 0; i < cb.boundary.nr; i++) {
    ++			obj = cb.boundary.objects[i].item;
     +
    -+			if (obj_in_bitmap(bitmap_git, obj, base)) {
    ++			if (obj_in_bitmap(bitmap_git, obj, cb.base)) {
     +				obj->flags |= SEEN;
     +			} else {
     +				add_pending_object(revs, obj, "");
    @@ pack-bitmap.c: static struct bitmap *fill_in_bitmap(struct bitmap_index *bitmap_
     +		}
     +
     +		if (needs_walk)
    -+			base = fill_in_bitmap(bitmap_git, revs, base, NULL);
    ++			cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
     +	}
     +	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
     +
     +
     +cleanup:
     +	revs->ignore_missing_links = 0;
    -+	revs->collect_uninteresting = 0;
     +
    -+	return base;
    ++	return cb.base;
     +}
     +
      static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      	if (!wants)
      		goto cleanup;
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    - 	if (load_bitmap(bitmap_git) < 0)
    + 	if (load_bitmap(revs->repo, bitmap_git) < 0)
      		goto cleanup;
      
     -	object_array_clear(&revs->pending);
-- 
2.40.1.478.gcab26587e8
