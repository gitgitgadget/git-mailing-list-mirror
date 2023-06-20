Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B34EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFTOVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTOVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73AB3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:20:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so4865058276.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270859; x=1689862859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KT2neUItBaaQ6qN2XNP2BQPcsOrpQJa8uduA4775dU=;
        b=yReCj/hHiZjs1aEurcLTKCnrolxPctcTDmV2QKDaXMlp8OgOew2XGfTKEAxduV7FjS
         XfKAo64U5l23T2mzzlz+rZhGtZnJx1dUqzLfhnpLBnRllwAkHDJcX1GZ5jKwaXDRTrsT
         OA6w612UM4XHHAcXRAREdHnj0z5QrPNhqdgggEnthj0sVEYWG09o7JHYOAS6ZTHieQYX
         EtGKTxIq/DQOefAhN1RNz1YEMOUcWNbV5GjyIxC416o9JEi2YmRBDNUWtVolQzp7vtgt
         8wLsEvIkfh6DZMhwYq18SULiG072JvxU08gLQtFNzWAUkTdRtRTsyH+3Bib1GcdL9yYb
         glWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270859; x=1689862859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KT2neUItBaaQ6qN2XNP2BQPcsOrpQJa8uduA4775dU=;
        b=hYVdzjWZ/RoYvHlPLNg/AQ4y2X6kBzfA1XINsfSVj98Q6xD0w3RVJIJrEDUQ3H+gnJ
         luIepPq1rjdT6zHQKHWQSIG+zdwBm0yOFMAWB1SPwQQ36WjwNd8kMn/7CnneQG5nw9jb
         /UAShY+Qd9VvC3nEZmUt2QCk71SBW9AhpmNTWg413GGsZw9Ge+3ZknIrobxdLRLK5kvG
         13240NphgBlTgAny157Vv67jXpowDBKsqrl4PTcz1eqhESS5AL/FBNATfGDB/D4k2J5E
         HncoqMrYYu62CnzUGKMaYQCiosSr+bCY63C3mwgyXI1i5i7Jd+IjSyt418g1BpZbjsxr
         D6ag==
X-Gm-Message-State: AC+VfDyCIJBcRyuh04LtI3boI46BmG2P3wzWnkWguB/PvwtyEcZ6O145
        gmDXvFPolHpq/+MqdL9udcVmnbSWTi0WP0kd06U0pG0H
X-Google-Smtp-Source: ACHHUZ7VjbqRAMUnzM84hqaAAdPjoJY/BltHqILntYG11uxCOxt0OoNjKhmPUy5QJkKHxZbzT5CgZg==
X-Received: by 2002:a5b:ccb:0:b0:bb3:b6b5:8c6 with SMTP id e11-20020a5b0ccb000000b00bb3b6b508c6mr9976937ybr.29.1687270858650;
        Tue, 20 Jun 2023 07:20:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i127-20020a256d85000000b00bca531ddce4sm386418ybc.31.2023.06.20.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:20:57 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:20:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/16] refs: implement jump lists for packed backend
Message-ID: <cover.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement jump (née skip) lists
for the packed refs backend, based on top of the current 'master'.

Most changes are minor, limited to changing variable names, moving
changes around between patches and tweaking commit messages for clarity.
I think that the first 9 or so patches are stable, but we may want some
more eyes on the remainder.

As usual, a range-diff is included below for convenience.

Thanks in advance for your review.

Jeff King (5):
  refs.c: rename `ref_filter`
  ref-filter.h: provide `REF_FILTER_INIT`
  ref-filter: clear reachable list pointers after freeing
  ref-filter: add `ref_filter_clear()`
  ref-filter.c: parameterize match functions over patterns

Taylor Blau (11):
  builtin/for-each-ref.c: add `--exclude` option
  refs: plumb `exclude_patterns` argument throughout
  refs/packed-backend.c: refactor `find_reference_location()`
  refs/packed-backend.c: implement jump lists to avoid excluded
    pattern(s)
  refs/packed-backend.c: add trace2 counters for jump list
  revision.h: store hidden refs in a `strvec`
  refs/packed-backend.c: ignore complicated hidden refs rules
  refs.h: let `for_each_namespaced_ref()` take excluded patterns
  builtin/receive-pack.c: avoid enumerating hidden references
  upload-pack.c: avoid enumerating hidden refs where possible
  ls-refs.c: avoid enumerating hidden refs where possible

 Documentation/git-for-each-ref.txt |   6 +
 builtin/branch.c                   |   4 +-
 builtin/for-each-ref.c             |   7 +-
 builtin/receive-pack.c             |   7 +-
 builtin/tag.c                      |   4 +-
 http-backend.c                     |   2 +-
 ls-refs.c                          |   8 +-
 ref-filter.c                       |  63 +++++++--
 ref-filter.h                       |  12 ++
 refs.c                             |  61 ++++----
 refs.h                             |  15 +-
 refs/debug.c                       |   5 +-
 refs/files-backend.c               |   5 +-
 refs/packed-backend.c              | 220 ++++++++++++++++++++++++++---
 refs/refs-internal.h               |   7 +-
 revision.c                         |   4 +-
 revision.h                         |   5 +-
 t/helper/test-reach.c              |   2 +-
 t/helper/test-ref-store.c          |  10 ++
 t/t0041-usage.sh                   |   1 +
 t/t1419-exclude-refs.sh            | 131 +++++++++++++++++
 t/t3402-rebase-merge.sh            |   1 +
 t/t6300-for-each-ref.sh            |  35 +++++
 trace2.h                           |   2 +
 trace2/tr2_ctr.c                   |   5 +
 upload-pack.c                      |  43 ++++--
 26 files changed, 559 insertions(+), 106 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

Range-diff against v3:
 1:  afac948f04 =  1:  c12def5a30 refs.c: rename `ref_filter`
 2:  b9336e3b77 =  2:  7ce82b6a5a ref-filter.h: provide `REF_FILTER_INIT`
 3:  fc28b5caaa =  3:  7e6bf7766d ref-filter: clear reachable list pointers after freeing
 4:  bc5356fe4b =  4:  777e71004d ref-filter: add `ref_filter_clear()`
 5:  1988ca4c0a =  5:  39e9b0f50d ref-filter.c: parameterize match functions over patterns
 6:  60d85aa4ad =  6:  c4fd47fd75 builtin/for-each-ref.c: add `--exclude` option
 7:  c4fe9a1893 !  7:  e6b50c5021 refs: plumb `exclude_patterns` argument throughout
    @@ ls-refs.c: int ls_refs(struct repository *r, struct packet_reader *request)
      ## ref-filter.c ##
     @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      
    - 	if (!filter->name_patterns[0]) {
    - 		/* no patterns; we have to look at everything */
    --		return for_each_fullref_in("", cb, cb_data);
    -+		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
    -+						 "", NULL, cb, cb_data);
    - 	}
    - 
      	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
      						 NULL, filter->name_patterns,
     -						 cb, cb_data);
 8:  9cab5e0699 =  8:  a0990b2916 refs/packed-backend.c: refactor `find_reference_location()`
 9:  8066858bf5 !  9:  386ed468fa refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
    @@ Commit message
             matches.
     
           - Clean up the results from the previous step: discard empty regions,
    -        and combine adjacent regions.
    +        and combine adjacent regions. The set of regions which remains is
    +        referred to as the "jump list", and never contains any references
    +        which should be included in the result set.
     
         Then when iterating through the `packed-refs` file, if `iter->pos` is
         ever contained in one of the regions from the previous steps, advance
    @@ Commit message
         `jump_pos` is used to track the first next-possible region to jump
         through.
     
    -    Second, note that the exclusion list is best-effort, since we do not
    -    handle loose references, and because of the meta-character issue above.
    +    Second, note that the jump list is best-effort, since we do not handle
    +    loose references, and because of the meta-character issue above. The
    +    jump list may not skip past all references which won't appear in the
    +    results, but will never skip over a reference which does appear in the
    +    result set.
     
         In repositories with a large number of hidden references, the speed-up
         can be significant. Tests here are done with a copy of linux.git with a
    @@ Commit message
     
      ## ref-filter.c ##
     @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
    + 
      	if (!filter->name_patterns[0]) {
      		/* no patterns; we have to look at everything */
    - 		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
    --						 "", NULL, cb, cb_data);
    +-		return for_each_fullref_in("", cb, cb_data);
    ++		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
     +						 "", filter->exclude.v, cb, cb_data);
      	}
      
    @@ refs/packed-backend.c: struct packed_ref_iterator {
     +		const char *end;
     +	} *jump;
     +	size_t jump_nr, jump_alloc;
    -+	size_t jump_pos;
    ++	size_t jump_cur;
     +
      	/* Scratch space for current values: */
      	struct object_id oid, peeled;
    @@ refs/packed-backend.c: struct packed_ref_iterator {
     +	 * Note that each skipped region is considered at most once,
     +	 * since they are ordered based on their starting position.
     +	 */
    -+	while (iter->jump_pos < iter->jump_nr) {
    -+		struct jump_list_entry *curr = &iter->jump[iter->jump_pos];
    ++	while (iter->jump_cur < iter->jump_nr) {
    ++		struct jump_list_entry *curr = &iter->jump[iter->jump_cur];
     +		if (iter->pos < curr->start)
     +			break; /* not to the next jump yet */
     +
    -+		iter->jump_pos++;
    ++		iter->jump_cur++;
     +		if (iter->pos < curr->end) {
     +			iter->pos = curr->end;
     +			break;
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +	return 0;
     +}
     +
    -+static const char *ptr_max(const char *x, const char *y)
    -+{
    -+	if (x > y)
    -+		return x;
    -+	return y;
    -+}
    -+
     +static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
     +					struct snapshot *snapshot,
     +					const char **excluded_patterns)
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +			continue;
     +		} else if (ours->start <= last_disjoint->end) {
     +			/* overlapping regions extend the previous one */
    -+			last_disjoint->end = ptr_max(last_disjoint->end, ours->end);
    ++			last_disjoint->end = last_disjoint->end > ours->end
    ++				? last_disjoint->end : ours->end;
     +		} else {
     +			/* otherwise, insert a new region */
     +			iter->jump[j++] = *ours;
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +	}
     +
     +	iter->jump_nr = j;
    -+	iter->jump_pos = 0;
    ++	iter->jump_cur = 0;
     +}
     +
      static struct ref_iterator *packed_ref_iterator_begin(
10:  3c045076a9 ! 10:  49c8f5173a refs/packed-backend.c: add trace2 counters for jump list
    @@ refs/packed-backend.c
      enum mmap_strategy {
      	/*
     @@ refs/packed-backend.c: static int next_record(struct packed_ref_iterator *iter)
    - 		iter->jump_pos++;
    + 		iter->jump_cur++;
      		if (iter->pos < curr->end) {
      			iter->pos = curr->end;
     +			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
    @@ t/t1419-exclude-refs.sh: for_each_ref () {
     +	local nr="$1"
     +	local trace="$2"
     +
    -+	grep -q "name:jumps_made value:$nr" $trace
    ++	grep -q "name:jumps_made value:$nr$" $trace
     +}
     +
     +assert_no_jumps () {
    @@ t/t1419-exclude-refs.sh: test_expect_success 'setup' '
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_no_jumps
    ++	assert_no_jumps perf
      '
      
      test_expect_success 'meta-characters are discarded' '
    @@ t/t1419-exclude-refs.sh: test_expect_success 'setup' '
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_no_jumps
    ++	assert_no_jumps perf
      '
      
      test_done
11:  0ff542eaef = 11:  dd856a3982 revision.h: store hidden refs in a `strvec`
12:  ca006b2c3f ! 12:  845904853e refs/packed-backend.c: ignore complicated hidden refs rules
    @@ Commit message
         refs/packed-backend.c: ignore complicated hidden refs rules
     
         In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
    -    use the new skip-list feature in the packed-refs iterator by ignoring
    +    use the new jump list feature in the packed-refs iterator by ignoring
         references which are mentioned via its respective hideRefs lists.
     
    -    However, the packed-ref skip lists cannot handle un-hiding rules (that
    +    However, the packed-ref jump lists cannot handle un-hiding rules (that
         begin with '!'), or namespace comparisons (that begin with '^'). Detect
         and avoid these cases by falling back to the normal enumeration without
    -    a skip list when such patterns exist.
    +    a jump list when such patterns exist.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ refs/packed-backend.c: static void populate_excluded_jump_list(struct packed_ref
     
      ## t/t1419-exclude-refs.sh ##
     @@ t/t1419-exclude-refs.sh: test_expect_success 'meta-characters are discarded' '
    - 	assert_no_jumps
    + 	assert_no_jumps perf
      '
      
     +test_expect_success 'complex hidden ref rules are discarded' '
13:  cae703a425 ! 13:  8d4d7cc22e refs.h: let `for_each_namespaced_ref()` take excluded patterns
    @@ Metadata
      ## Commit message ##
         refs.h: let `for_each_namespaced_ref()` take excluded patterns
     
    -    The following commit will want to call `for_each_namespaced_ref()` with
    +    A future commit will want to call `for_each_namespaced_ref()` with
         a list of excluded patterns.
     
         We could introduce a variant of that function, say,
    @@ Commit message
         introducing a new function.
     
         For now, supply NULL for the list of excluded patterns at all callers to
    -    avoid changing behavior, which we will do in the subsequent commit.
    +    avoid changing behavior, which we will do in a future change.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
14:  1db10b76ea = 14:  49c665f9f8 builtin/receive-pack.c: avoid enumerating hidden references
15:  014243ebe6 = 15:  19bf4a52d6 upload-pack.c: avoid enumerating hidden refs where possible
16:  e02fe93379 = 16:  ea6cbaf292 ls-refs.c: avoid enumerating hidden refs where possible
-- 
2.41.0.44.gf2359540d2
