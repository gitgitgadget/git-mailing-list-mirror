Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB0C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D94F64F68
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBDD75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 22:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhBDD7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:59:30 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F82C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:58:50 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id k193so2132034qke.6
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VL4X0hq99qdkm2+jRkQqDJtD5q/frOvEustxdAQzwys=;
        b=ntvwn4oi9vpCnTiqqoN5xH+REuTMjual+vJvz22Y7AjSK2zFTTKqc3Dz9vmSrxe3wy
         O/mjBmZc3BJN7AhoK24me46ohIy1pZxDKmn9zmdOYXLQNCoynlgXI8AqAoTzri2wcI7/
         p/sbkDcXAIcxgBAbsuJv8HFygV1GIHGq9O02TYDuBpAkWygzJRf8y4QLCHRzqG7p+4o3
         JOxYuaz23QcqVNdi33YT6u24YjdJX4szMN8GpqQnkMbOLPJGeTWUv0P9eTzvJQ+Sat/G
         47d/Voq7AekEMb3W24OxanGNFaCgFEUwzLgxC7mFX6N5GxTf7dSLULrxneoJtbhsm51j
         /+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VL4X0hq99qdkm2+jRkQqDJtD5q/frOvEustxdAQzwys=;
        b=k2yF8Q2joxAXgtqroG+KRI7Mi31pq1QYCRbjL0sGr5O6IU3ZI0ufVNTrjT6ZvdUwjl
         XlyN40NyjtXuxaSdm/pBWBYYA9Nvuaxix7Q3QbSxzdA85EndGV37iNdw1yG+BsjJKeo1
         7RiJNGp3JnEw8TcWN5uvJpxtiCf9yiBeIG8PSLHl8E0Lnswv4T9Apwa2caa6loU/gRVO
         hnjOeuQTKrKxcQlzbXl0VBaLapHvnRJ50dI52wSo1Ev6EXkF3cWPnvcmP+vlMz6nMwmY
         dYXM/G8Mw4cU88zl7w+ynkTrHKfXuRbkB+q/6HNf/2jJFnpDPeyot3cuPM/JOwZW5CYd
         6gKA==
X-Gm-Message-State: AOAM530dxwyXV3x36l7Kky2Dd34yUEKI+N8KVfQBX166dh5xTUVUl2x1
        A4fOSpPEb05K6xQvuK3Jq5UOXzKfgs1zfQ==
X-Google-Smtp-Source: ABdhPJw9XWBUuBv/0quLuL9jgR1GKhqFvr4hMKV9FeGbBItz8bXMSn9itYYr/0INf6ahOwBr6Gz9Ig==
X-Received: by 2002:a05:620a:149b:: with SMTP id w27mr5985754qkj.64.1612411128795;
        Wed, 03 Feb 2021 19:58:48 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id g11sm3515150qto.89.2021.02.03.19.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:58:47 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:58:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 0/8] repack: support repacking into a geometric sequence
Message-ID: <cover.1612411123.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an updated version of mine and Peff's series to add a new 'git repack
--geometric' mode which supports repacking a repository into a geometric
progression of packs by object count.

This version depends on jk/p5303-sed-portability-fix, but it could be applied
onto 'master' after resolving a trivial conflict.

As a reminder, here is a description from the original cover letter [1] which
outlines what the geometric mode entails:

  Roughly speaking, for a given factor, say "d", each pack has at least "d"
  times the number of objects as the next largest pack. So, if there are "N"
  packs, "P1", "P2", ..., "PN" ordered by object count (where "PN" has the most
  objects, and "P1" the fewest), then:

    objects(Pi) > d * objects(P(i-1))

  for all 1 < i <= N.

  This is done by first ordering packs by object count, and then determining the
  longest sequence of large packs which already form a geometric progression.
  All packs on the small side of that cut must be repacked together, and so we
  check that the existing progression can be maintained with the new pack, and
  adjust as necessary.

Since last time, the series has been reworked substantially. In the previous
version, a single reachability traversal was performed to determine the set of
objects to pack. That traversal halted upon encountering any objects found in a
kept pack, but this led to serious correctness problems (if, for e.g., an object
we would like to pack is an ancestor of some other object in a kept pack, and
thus isn't picked up).

The details of the new approach can be found in the third patch, but the gist is
as follows:

  - 'git repack --geometric' calls 'git pack-objects --stdin-packs', which
    expects input like:

        pack-xyz.pack
        pack-abc.pack
        ^pack-exclude.pack

    'git pack-objects' determines the set of objects to pack by iterating all of
    the objects in the listed packs, and then removing any objects found in the
    packs which are prefixed with '^'.

  - To improve the delta selection process, the same reachability traversal from
    the original version of this series is performed. But, the set of objects to
    pack is already known, so we don't run the risk of the correctness bugs from
    before.

  - In this reachability traversal, visited objects get their namehash field
    set, which helps drive the heuristics that power delta selection. It's
    possible that we may not visit all of the objects to pack, but that's OK
    since this process is only additive (again, the set of objects to pack is
    known up-front independent of the reachability traversal).

So, this strikes a happy medium between not relying on reachability so much that
we run the risk of corrupting the repository, but relying on it enough that we
can aid in the delta selection process.

Because we reuse the same "halt the traversal when encountering objects in kept
packs" mechanism, a lot of the patches are able to be reused. The structure of
the series is as follows:

  - The first three patches introduce new infrastructure, and implement 'git
    pack-objects --stdin-packs'.

  - The next four patches introduce and use a kept-pack cache, which improves
    the performance of 'git pack-objects --stdin-packs' substantially.

  - The final patch implements 'git repack --geometric'.

Let me know what you think of this new approach, and thanks in advance for your
review.

[1]: https://lore.kernel.org/git/cover.1611098616.git.me@ttaylorr.com/

Thanks in advance for your review.

Jeff King (4):
  p5303: add missing &&-chains
  p5303: measure time to repack with keep
  builtin/pack-objects.c: rewrite honor-pack-keep logic
  packfile: add kept-pack cache for find_kept_pack_entry()

Taylor Blau (4):
  packfile: introduce 'find_kept_pack_entry()'
  revision: learn '--no-kept-objects'
  builtin/pack-objects.c: add '--stdin-packs' option
  builtin/repack.c: add '--geometric' option

 Documentation/git-pack-objects.txt |  10 +
 Documentation/git-repack.txt       |  11 ++
 Documentation/rev-list-options.txt |   7 +
 builtin/pack-objects.c             | 301 +++++++++++++++++++++++------
 builtin/repack.c                   | 187 +++++++++++++++++-
 list-objects.c                     |   7 +
 object-store.h                     |  10 +
 packfile.c                         |  69 +++++++
 packfile.h                         |   2 +
 revision.c                         |  15 ++
 revision.h                         |   4 +
 t/perf/p5303-many-packs.sh         |  24 ++-
 t/t5300-pack-object.sh             |  97 ++++++++++
 t/t6114-keep-packs.sh              |  69 +++++++
 t/t7703-repack-geometric.sh        | 137 +++++++++++++
 15 files changed, 889 insertions(+), 61 deletions(-)
 create mode 100755 t/t6114-keep-packs.sh
 create mode 100755 t/t7703-repack-geometric.sh

Range-diff against v1:
 1:  dc7fa4c7a6 !  1:  f7186147eb packfile: introduce 'find_kept_pack_entry()'
    @@ Commit message
         packfile: introduce 'find_kept_pack_entry()'
     
         Future callers will want a function to fill a 'struct pack_entry' for a
    -    given object id but _only_ from its position in any kept pack(s). They
    -    could accomplish this by calling 'find_pack_entry()' and checking
    -    whether the found pack is kept or not, but this is insufficient, since
    -    there may be duplicate objects (and the mru cache makes it unpredictable
    -    which variant we'll get).
    -
    -    Teach this new function to treat the two different kinds of kept packs
    -    (on disk ones with .keep files, as well as in-core ones which are set by
    -    manually poking the 'pack_keep_in_core' bit) separately. This will
    -    become important for callers that only want to respect a certain kind of
    -    kept pack.
    -
    -    Introduce 'find_kept_pack_entry()' which behaves like
    -    'find_pack_entry()', except that it skips over packs which are not
    -    marked kept. Callers will be added in subsequent patches.
    +    given object id but _only_ from its position in any kept pack(s).
    +
    +    In particular, an new 'git repack' mode which ensures the resulting
    +    packs form a geometric progress by object count will mark packs that it
    +    does not want to repack as "kept in-core", and it will want to halt a
    +    reachability traversal as soon as it visits an object in any of the kept
    +    packs. But, it does not want to halt the traversal at non-kept, or
    +    .keep packs.
    +
    +    The obvious alternative is 'find_pack_entry()', but this doesn't quite
    +    suffice since it only returns the first pack it finds, which may or may
    +    not be kept (and the mru cache makes it unpredictable which one you'll
    +    get if there are options).
    +
    +    Short of that, you could walk over all packs looking for the object in
    +    each one, but it scales with the number of packs, which may be
    +    prohibitive.
    +
    +    Introduce 'find_kept_pack_entry()', a function which is like
    +    'find_pack_entry()', but only fills in objects in the kept packs.
    +
    +    Handle packs which have .keep files, as well as in-core kept packs
    +    separately, since certain callers will want to distinguish one from the
    +    other. (Though on-disk and in-core kept packs share the adjective
    +    "kept", it is best to think of the two sets as independent.)
    +
    +    There is a gotcha when looking up objects that are duplicated in kept
    +    and non-kept packs, particularly when the MIDX stores the non-kept
    +    version and the caller asked for kept objects only. This could be
    +    resolved by teaching the MIDX to resolve duplicates by always favoring
    +    the kept pack (if one exists), but this breaks an assumption in existing
    +    MIDXs, and so it would require a format change.
    +
    +    The benefit to changing the MIDX in this way is marginal, so we instead
    +    have a more thorough check here which is explained with a comment.
    +
    +    Callers will be added in subsequent patches.
     
         Co-authored-by: Jeff King <peff@peff.net>
         Signed-off-by: Jeff King <peff@peff.net>
    @@ packfile.c: int find_pack_entry(struct repository *r, const struct object_id *oi
      
      	for (m = r->objects->multi_pack_index; m; m = m->next) {
     -		if (fill_midx_entry(r, oid, e, m))
    -+		if (!(fill_midx_entry(r, oid, e, m)))
    ++		if (!fill_midx_entry(r, oid, e, m))
     +			continue;
     +
     +		if (!kept_only)
 2:  4184529648 !  2:  ddc2896caa revision: learn '--no-kept-objects'
    @@ Metadata
      ## Commit message ##
         revision: learn '--no-kept-objects'
     
    -    Some callers want to perform a reachability traversal that terminates
    -    when an object is found in a kept pack. The closest existing option is
    -    '--honor-pack-keep', but this isn't quite what we want. Instead of
    -    halting the traversal midway through, a full traversal is always
    -    performed, and the results are only trimmed afterwords.
    +    A future caller will want to be able to perform a reachability traversal
    +    which terminates when visiting an object found in a kept pack. The
    +    closest existing option is '--honor-pack-keep', but this isn't quite
    +    what we want. Instead of halting the traversal midway through, a full
    +    traversal is always performed, and the results are only trimmed
    +    afterwords.
     
         Besides needing to introduce a new flag (since culling results
         post-facto can be different than halting the traversal as it's
    @@ Commit message
         of kept packs, if any, should stop a traversal. This can be useful for
         callers that want to perform a reachability analysis, but want to leave
         certain packs alone (for e.g., when doing a geometric repack that has
    -    some "large" packs it wants to leave alone).
    +    some "large" packs which are kept in-core that it wants to leave alone).
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 3:  2da42e9ca2 <  -:  ---------- builtin/pack-objects.c: learn '--assume-kept-packs-closed'
 -:  ---------- >  3:  c96b1bf995 builtin/pack-objects.c: add '--stdin-packs' option
 4:  26b46dff15 !  4:  a46b7002b4 p5303: add missing &&-chains
    @@ Commit message
     
      ## t/perf/p5303-many-packs.sh ##
     @@ t/perf/p5303-many-packs.sh: repack_into_n () {
    - 	sed -n '1~5p' |
    - 	head -n "$1" |
    - 	perl -e 'print reverse <>' \
    --	>pushes
    -+	>pushes &&
    + 			push @commits, $_ if $. % 5 == 1;
    + 		}
    + 		print reverse @commits;
    +-	' "$1" >pushes
    ++	' "$1" >pushes &&
      
      	# create base packfile
      	head -n 1 pushes |
 5:  b3b2574d4d <  -:  ---------- p5303: measure time to repack with keep
 -:  ---------- >  5:  b5081c01b5 p5303: measure time to repack with keep
 6:  4dd5076fcc !  6:  c3868c7df9 pack-objects: rewrite honor-pack-keep logic
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    pack-objects: rewrite honor-pack-keep logic
    +    builtin/pack-objects.c: rewrite honor-pack-keep logic
     
         Now that we have find_kept_pack_entry(), we don't have to manually keep
         hunting through every pack to find a possible "kept" duplicate of the
    @@ Commit message
         question. It might be worth having a similar optimized function to look
         at only local packs.
     
    -    Here are the results from p5303 (measurements taken on git.git):
    +    Here are the results from p5303 (measurements again taken on the
    +    kernel):
     
    -      Test                               HEAD^                  HEAD
    -      ------------------------------------------------------------------------------------
    -      5303.5: repack (1)                 57.29(54.88+10.39)     56.87(54.63+10.48) -0.7%
    -      5303.6: repack with keep (1)       1.25(1.19+0.05)        1.26(1.19+0.06) +0.8%
    -      5303.10: repack (50)               89.71(132.78+6.14)     89.35(132.42+6.25) -0.4%
    -      5303.11: repack with keep (50)     6.92(26.93+0.58)       6.73(26.61+0.59) -2.7%
    -      5303.15: repack (1000)             217.14(493.76+15.29)   217.25(494.38+15.24) +0.1%
    -      5303.16: repack with keep (1000)   209.46(387.83+8.42)    133.12(311.80+8.44) -36.4%
    +      Test                                        HEAD^                    HEAD
    +      -----------------------------------------------------------------------------------------------
    +      5303.5: repack (1)                          57.42(54.88+10.64)       57.44(54.71+10.78) +0.0%
    +      5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)          0.01(0.00+0.01) +0.0%
    +      5303.10: repack (50)                        71.26(88.24+4.96)        71.32(88.38+4.90) +0.1%
    +      5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)         3.43(11.81+0.22) -1.7%
    +      5303.15: repack (1000)                      215.64(491.33+14.80)     215.59(493.75+14.62) -0.0%
    +      5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)      131.44(314.24+8.11) -33.9%
     
    -    So our case with many packs and a .keep is finally now faster than the
    +    So our --stdin-packs case with many packs is now finally faster than the
         non-keep case (because it gets the speed benefit of looking at fewer
         objects, but not as big a penalty for looking at many packs).
     
 7:  182664e1a9 !  7:  f1c07324f6 packfile: add kept-pack cache for find_kept_pack_entry()
    @@ Commit message
     
         Here are p5303 results (as always, measured against the kernel):
     
    -      Test                               HEAD^                  HEAD
    -      ------------------------------------------------------------------------------------
    -      5303.5: repack (1)                 56.87(54.63+10.48)     56.63(54.41+10.36) -0.4%
    -      5303.6: repack with keep (1)       1.26(1.19+0.06)        1.25(1.19+0.05) -0.8%
    -      5303.10: repack (50)               89.35(132.42+6.25)     89.49(132.31+6.31) +0.2%
    -      5303.11: repack with keep (50)     6.73(26.61+0.59)       6.72(26.70+0.53) -0.1%
    -      5303.15: repack (1000)             217.25(494.38+15.24)   218.69(495.62+14.99) +0.7%
    -      5303.16: repack with keep (1000)   133.12(311.80+8.44)    128.79(306.96+8.55) -3.3%
    +      Test                                        HEAD^                   HEAD
    +      ----------------------------------------------------------------------------------------------
    +      5303.5: repack (1)                          57.44(54.71+10.78)      57.06(54.29+10.96) -0.7%
    +      5303.6: repack with --stdin-packs (1)       0.01(0.00+0.01)         0.01(0.01+0.00) +0.0%
    +      5303.10: repack (50)                        71.32(88.38+4.90)       71.47(88.60+5.04) +0.2%
    +      5303.11: repack with --stdin-packs (50)     3.43(11.81+0.22)        3.49(12.21+0.26) +1.7%
    +      5303.15: repack (1000)                      215.59(493.75+14.62)    217.41(495.36+14.85) +0.8%
    +      5303.16: repack with --stdin-packs (1000)   131.44(314.24+8.11)     126.75(309.88+8.09) -3.6%
     
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ builtin/pack-objects.c: static int want_found_object(const struct object_id *oid
      
      		if (ignore_packed_keep_on_disk && p->pack_keep)
      			return 0;
    +@@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
    + 	 * an optimization during delta selection.
    + 	 */
    + 	revs.no_kept_objects = 1;
    +-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
    ++	revs.keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
    + 	revs.blob_objects = 1;
    + 	revs.tree_objects = 1;
    + 	revs.tag_objects = 1;
     
      ## object-store.h ##
     @@ object-store.h: static inline int pack_map_entry_cmp(const void *unused_cmp_data,
    @@ packfile.c: static int find_one_pack_entry(struct repository *r,
      		return 0;
      
      	for (m = r->objects->multi_pack_index; m; m = m->next) {
    --		if (!(fill_midx_entry(r, oid, e, m)))
    +-		if (!fill_midx_entry(r, oid, e, m))
     -			continue;
     -
     -		if (!kept_only)
 8:  6547c082f8 <  -:  ---------- builtin/pack-objects.c: teach '--keep-pack-stdin'
 9:  a808fbdf31 <  -:  ---------- builtin/repack.c: extract loose object handling
10:  f853087216 !  8:  d5561585c2 builtin/repack.c: add '--geometric' option
    @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_
     +	geometry = *geometry_p;
     +
     +	for (p = get_all_packs(the_repository); p; p = p->next) {
    ++		if (!pack_kept_objects && p->pack_keep)
    ++			continue;
    ++
     +		ALLOC_GROW(geometry->pack,
     +			   geometry->pack_nr + 1,
     +			   geometry->pack_alloc);
    @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_
     +	uint32_t split;
     +	off_t total_size = 0;
     +
    ++	if (geometry->pack_nr <= 1) {
    ++		geometry->split = geometry->pack_nr;
    ++		return;
    ++	}
    ++
     +	split = geometry->pack_nr - 1;
     +
     +	/*
    @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_
     +	geometry->split = 0;
     +}
     +
    - static void handle_loose_and_reachable(struct child_process *cmd,
    - 				       const char *unpack_unreachable,
    - 				       int pack_everything,
    + int cmd_repack(int argc, const char **argv, const char *prefix)
    + {
    + 	struct child_process cmd = CHILD_PROCESS_INIT;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      	struct string_list names = STRING_LIST_INIT_DUP;
      	struct string_list rollback = STRING_LIST_INIT_NODUP;
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      		die(_(incremental_bitmap_conflict_error));
      
     +	if (geometric_factor) {
    ++		if (pack_everything)
    ++			die(_("--geometric is incompatible with -A, -a"));
     +		init_pack_geometry(&geometry);
     +		split_pack_geometry(geometry, geometric_factor);
     +	}
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
      
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 			handle_loose_and_reachable(&cmd, unpack_unreachable,
    - 						   pack_everything,
    - 						   keep_unreachable);
    + 		strvec_pushf(&cmd.args, "--keep-pack=%s",
    + 			     keep_pack_list.items[i].string);
    + 	strvec_push(&cmd.args, "--non-empty");
    +-	strvec_push(&cmd.args, "--all");
    +-	strvec_push(&cmd.args, "--reflog");
    +-	strvec_push(&cmd.args, "--indexed-objects");
    ++	if (!geometry) {
    ++		/*
    ++		 * 'git pack-objects' will up all objects loose or packed
    ++		 * (either rolling them up or leaving them alone), so don't pass
    ++		 * these options.
    ++		 *
    ++		 * The implementation of 'git pack-objects --stdin-packs'
    ++		 * makes them redundant (and the two are incompatible).
    ++		 */
    ++		strvec_push(&cmd.args, "--all");
    ++		strvec_push(&cmd.args, "--reflog");
    ++		strvec_push(&cmd.args, "--indexed-objects");
    ++	}
    + 	if (has_promisor_remote())
    + 		strvec_push(&cmd.args, "--exclude-promisor-objects");
    + 	if (write_bitmaps > 0)
    +@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    + 				strvec_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
    + 			}
    + 		}
     +	} else if (geometry) {
    -+		strvec_push(&cmd.args, "--keep-pack-stdin");
    -+		strvec_push(&cmd.args, "--honor-pack-keep");
    -+		strvec_push(&cmd.args, "--assume-kept-packs-closed");
    -+		if (delete_redundant)
    -+			handle_loose_and_reachable(&cmd, unpack_unreachable,
    -+						   pack_everything,
    -+						   keep_unreachable);
    ++		strvec_push(&cmd.args, "--stdin-packs");
    ++		strvec_push(&cmd.args, "--unpacked");
      	} else {
      		strvec_push(&cmd.args, "--unpacked");
      		strvec_push(&cmd.args, "--incremental");
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +	if (geometry) {
     +		FILE *in = xfdopen(cmd.in, "w");
     +		/*
    -+		 * Tell 'git pack-objects' to avoid tampering with the structure
    -+		 * with the packs that already form a geometric progression.
    -+		 *
    -+		 * Everything else will get picked up by the reachability walk.
    ++		 * The resulting pack should contain all objects in packs that
    ++		 * are going to be rolled up, but exclude objects in packs which
    ++		 * are being left alone.
     +		 */
    -+		for (i = geometry->split; i < geometry->pack_nr; i++)
    ++		for (i = 0; i < geometry->split; i++)
     +			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
    ++		for (i = geometry->split; i < geometry->pack_nr; i++)
    ++			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
     +		fclose(in);
     +	}
     +
    @@ t/t7703-repack-geometric.sh (new)
     +objdir=.git/objects
     +midx=$objdir/pack/multi-pack-index
     +
    ++test_expect_success '--geometric with no packs' '
    ++	git init geometric &&
    ++	test_when_finished "rm -fr geometric" &&
    ++	(
    ++		cd geometric &&
    ++
    ++		git repack --geometric 2 >out &&
    ++		test_i18ngrep "Nothing new to pack" out
    ++	)
    ++'
    ++
     +test_expect_success '--geometric with an intact progression' '
     +	git init geometric &&
     +	test_when_finished "rm -fr geometric" &&
    @@ t/t7703-repack-geometric.sh (new)
     +		test_commit_bulk --start=4 4 && # 12 objects
     +
     +		find $objdir/pack -name "*.pack" | sort >expect &&
    -+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
    ++		git repack --geometric 2 -d &&
     +		find $objdir/pack -name "*.pack" | sort >actual &&
     +
     +		test_cmp expect actual
    @@ t/t7703-repack-geometric.sh (new)
     +		test_commit_bulk --start=7 8 && # 24 objects
     +		find $objdir/pack -name "*.pack" | sort >before &&
     +
    -+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
    ++		git repack --geometric 2 -d &&
     +
     +		# Three packs in total; two of the existing large ones, and one
     +		# new one.
    @@ t/t7703-repack-geometric.sh (new)
     +
     +		find $objdir/pack -name "*.pack" | sort >before &&
     +
    -+		GIT_TEST_MULTI_PACK_BITMAP=0 git repack --geometric 2 -d &&
    ++		git repack --geometric 2 -d &&
     +
     +		find $objdir/pack -name "*.pack" | sort >after &&
     +		comm -12 before after >untouched &&
    @@ t/t7703-repack-geometric.sh (new)
     +	)
     +'
     +
    ++test_expect_success '--geometric ignores kept packs' '
    ++	git init geometric &&
    ++	test_when_finished "rm -fr geometric" &&
    ++	(
    ++		cd geometric &&
    ++
    ++		test_commit kept && # 3 objects
    ++		test_commit pack && # 3 objects
    ++
    ++		KEPT=$(git pack-objects --revs $objdir/pack/pack <<-EOF
    ++		refs/tags/kept
    ++		EOF
    ++		) &&
    ++		PACK=$(git pack-objects --revs $objdir/pack/pack <<-EOF
    ++		refs/tags/pack
    ++		^refs/tags/kept
    ++		EOF
    ++		) &&
    ++
    ++		# neither pack contains more than twice the number of objects in
    ++		# the other, so they should be combined. but, marking one as
    ++		# .kept on disk will "freeze" it, so the pack structure should
    ++		# remain unchanged.
    ++		touch $objdir/pack/pack-$KEPT.keep &&
    ++
    ++		find $objdir/pack -name "*.pack" | sort >before &&
    ++		git repack --geometric 2 -d &&
    ++		find $objdir/pack -name "*.pack" | sort >after &&
    ++
    ++		# both packs should still exist
    ++		test_path_is_file $objdir/pack/pack-$KEPT.pack &&
    ++		test_path_is_file $objdir/pack/pack-$PACK.pack &&
    ++
    ++		# and no new packs should be created
    ++		test_cmp before after &&
    ++
    ++		# Passing --pack-kept-objects causes packs with a .keep file to
    ++		# be repacked, too.
    ++		git repack --geometric 2 -d --pack-kept-objects &&
    ++
    ++		find $objdir/pack -name "*.pack" >after &&
    ++		test_line_count = 1 after
    ++	)
    ++'
    ++
     +test_done
-- 
2.30.0.533.g2f8b6b552f.dirty
