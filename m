Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32805C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbjEOTXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbjEOTXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:17 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36911624
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:10 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a2691637bso190821447b3.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178590; x=1686770590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zOrqZQpBGn4djiovN+9DKArc64ZrVrgIKQjiLWmyzCM=;
        b=QELFl6fub8+UEv8kAFh+hgXRZD3dZs2wYWUubAzG3UPiDFVdqUHMAugmnaL5wablel
         +1RzWLZ61QVj/aDu/xVhqben/e0r+LclFdUTPnRUuRFsWMyWfoSPbVCoQBgi3kVeFXaz
         gm58c+UkfKP3aDIrySIiG4pzNLfYZSytgcuV6KRv6OuafXWx1vEZVdUxd1sIjBM9pevw
         SB4w6Wbx3tidJcPN0ti/P1oimIYOGmZup3Ng9w/1/43czIpDDLcDSLBMWxIQlaQRgOKl
         b1cLEL6Xzj3CkJVlUR+r0C1n8oOiyDt1ynfXbQ04OYEVfqsbuCmCHljQIsu7Kel7l+Rh
         D/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178590; x=1686770590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOrqZQpBGn4djiovN+9DKArc64ZrVrgIKQjiLWmyzCM=;
        b=P+PZQwkDnaGdl/XTEluuDi1PGYuErtuIU+XjEenmaZSil8qWOz4yHVHQFUyb4Aw1yb
         c9LZiW06u6nJlocvUKPshemU1S7pRNRSXotI9rfQuDYD3DZkkjZ/+1sTI8TUkvWjGN9j
         /mOYMd2f3YmietPgpr0rdDIH/lsOEEtb3JVpXKgcJ3tj1OAI/zdXH2F0NESFllr5svEu
         axegpfdSzChLGEGhvAtzvnrMsZDbDlq/NTr4UR5vdPLh36dcGLCjo+/1MyWrRbWZBw7/
         xvX7b7ogRLJY/AE8MII0GcQyIt/R/gG3ipv10wYS2YTskRew5SBEdZOXE3mfd0RFLA9y
         QHRw==
X-Gm-Message-State: AC+VfDyLiAIvGW47R0P49YtnAlLHH/HnXM5vQodiVfPd013JOes84G+8
        omR6ccbIgqvqEZLYBltaZ/xlzLphbbykM0fOCHSMig==
X-Google-Smtp-Source: ACHHUZ6WE+2ohqb4lEimBdM7bveTzV6VMhByBSIJmqTLGTMyXL0n2cgdthoxbPSywt+Vx7FaDCtoEw==
X-Received: by 2002:a0d:ef41:0:b0:552:d36e:e6db with SMTP id y62-20020a0def41000000b00552d36ee6dbmr31553059ywe.6.1684178589122;
        Mon, 15 May 2023 12:23:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i185-20020a816dc2000000b00545a08184e9sm9375ywc.121.2023.05.15.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:08 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] refs: implement jump lists for packed backend
Message-ID: <cover.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement jump (née skip) lists for the
packed refs backend.

Not a ton has changed since last time, but some notable things that have
changed include:

  - Renaming "skip lists" to "jump lists" to clarify that this
    implementation does not use the skip list data structure.
  - Patch reorganization, splitting out `find_reference_location_end()`
    more sensibly, rewording patch messages, etc.
  - Addresses feedback from Junio and Patrick Steinhardt's helpful
    reviews.

As usual, a range-diff is included below for convenience.

Given that we are expecting -rc0 today, we should aim to not let review
of this topic direct our attention away from testing the release
candidates. We can get more serious about it on the other side of 2.41.

Thanks in advance for another look.

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
 ref-filter.c                       |  63 ++++++--
 ref-filter.h                       |  12 ++
 refs.c                             |  61 ++++----
 refs.h                             |  15 +-
 refs/debug.c                       |   5 +-
 refs/files-backend.c               |   5 +-
 refs/packed-backend.c              | 226 ++++++++++++++++++++++++++---
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
 26 files changed, 565 insertions(+), 106 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

Range-diff against v1:
 1:  2225f79941 =  1:  6cac42e70e refs.c: rename `ref_filter`
 2:  ea1c7834db =  2:  8dda7db738 ref-filter.h: provide `REF_FILTER_INIT`
 3:  7fe8623f60 =  3:  bf21df783d ref-filter: clear reachable list pointers after freeing
 4:  c804ba3620 !  4:  85ecb70957 ref-filter: add ref_filter_clear()
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    ref-filter: add ref_filter_clear()
    +    ref-filter: add `ref_filter_clear()`
     
    -    We did not bother to clean up at all in branch/tag, and for-each-ref
    -    only hit a few elements. So this is probably cleaning up leaks, but I
    -    didn't check yet.
    +    We did not bother to clean up at all in `git branch` or `git tag`, and
    +    `git for-each-ref` only cleans up a couple of members.
     
    -    Note that the reachable_from and unreachable_from lists should be
    +    Add and call `ref_filter_clear()` when cleaning up a `struct
    +    ref_filter`. Running this patch (without any test changes) indicates a
    +    couple of now leak-free tests. This was found by running:
    +
    +        $ make SANITIZE=leak
    +        $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate
    +
    +    (Note that the `reachable_from` and `unreachable_from` lists should be
         cleaned as they are used. So this is just covering any case where we
    -    might bail before running the reachability check.
    +    might bail before running the reachability check.)
    +
    +    Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/branch.c ##
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    @@ ref-filter.h: void filter_ahead_behind(struct repository *r,
     +void ref_filter_clear(struct ref_filter *filter);
     +
      #endif /*  REF_FILTER_H  */
    +
    + ## t/t0041-usage.sh ##
    +@@ t/t0041-usage.sh: test_description='Test commands behavior when given invalid argument value'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup ' '
    +
    + ## t/t3402-rebase-merge.sh ##
    +@@ t/t3402-rebase-merge.sh: test_description='git rebase --merge test'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + T="A quick brown fox
 5:  c54000f5f5 !  5:  385890b459 ref-filter.c: parameterize match functions over patterns
    @@ Commit message
         Tweak `match_pattern()` and `match_name_as_path()` to take an array of
         patterns to prepare for passing either in.
     
    +    Once we start passing either in, `match_pattern()` will have little to
    +    do with a particular `struct ref_filter *` instance. To clarify this,
    +    drop it from the argument list, and replace it with the only bit of the
    +    `ref_filter` that we care about (`filter->ignore_case`).
    +
         Co-authored-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
    @@ ref-filter.c: static int get_ref_atom_value(struct ref_array_item *ref, int atom
       * matches "refs/heads/mas*", too).
       */
     -static int match_pattern(const struct ref_filter *filter, const char *refname)
    -+static int match_pattern(const struct ref_filter *filter,
    -+			 const char **patterns,
    -+			 const char *refname)
    ++static int match_pattern(const char **patterns, const char *refname,
    ++			 const int ignore_case)
      {
     -	const char **patterns = filter->name_patterns;
      	unsigned flags = 0;
      
    - 	if (filter->ignore_case)
    +-	if (filter->ignore_case)
    ++	if (ignore_case)
    + 		flags |= WM_CASEFOLD;
    + 
    + 	/*
     @@ ref-filter.c: static int match_pattern(const struct ref_filter *filter, const char *refname)
       * matches a pattern "refs/heads/" but not "refs/heads/m") or a
       * wildcard (e.g. the same ref matches "refs/heads/m*", too).
    @@ ref-filter.c: static int filter_pattern_match(struct ref_filter *filter, const c
     -		return match_name_as_path(filter, refname);
     -	return match_pattern(filter, refname);
     +		return match_name_as_path(filter, filter->name_patterns, refname);
    -+	return match_pattern(filter, filter->name_patterns, refname);
    ++	return match_pattern(filter->name_patterns, refname,
    ++			     filter->ignore_case);
      }
      
      /*
 6:  ea5c0ddc10 !  6:  1a3371a0a7 builtin/for-each-ref.c: add `--exclude` option
    @@ Documentation/git-for-each-ref.txt: OPTIONS
      
     
      ## builtin/for-each-ref.c ##
    -@@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
    - 	N_("git for-each-ref [--points-at <object>]"),
    - 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
    - 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
    -+	N_("git for-each-ref [--exclude=<pattern> ...]"),
    - 	NULL
    - };
    - 
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
      		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
      		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
    @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc, const char **argv, const
     
      ## ref-filter.c ##
     @@ ref-filter.c: static int filter_pattern_match(struct ref_filter *filter, const char *refname)
    - 	return match_pattern(filter, filter->name_patterns, refname);
    + 			     filter->ignore_case);
      }
      
     +static int filter_exclude_match(struct ref_filter *filter, const char *refname)
    @@ ref-filter.c: static int filter_pattern_match(struct ref_filter *filter, const c
     +		return 0;
     +	if (filter->match_as_path)
     +		return match_name_as_path(filter, filter->exclude.v, refname);
    -+	return match_pattern(filter, filter->exclude.v, refname);
    ++	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
     +}
     +
      /*
 7:  f437cd83e2 !  7:  aa05549b6e refs: plumb `exclude_patterns` argument throughout
    @@ Commit message
         refs: plumb `exclude_patterns` argument throughout
     
         The subsequent patch will want to access an optional `excluded_patterns`
    -    array within refs/packed-backend.c. To do so, the refs subsystem needs
    -    to be updated to pass this value across a number of different locations.
    +    array within `refs/packed-backend.c` that will cull out certain
    +    references matching any of the given patterns on a best-effort basis.
    +
    +    To do so, the refs subsystem needs to be updated to pass this value
    +    across a number of different locations.
     
         Prepare for a future patch by introducing this plumbing now, passing
         NULLs at top-level APIs in order to make that patch less noisy and more
 8:  836a5665b7 !  8:  6002c568b5 refs/packed-backend.c: refactor `find_reference_location()`
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static int cmp_packed_ref_records(const void *v1, const void *v2)
    -  * Compare a snapshot record at `rec` to the specified NUL-terminated
    -  * refname.
    -  */
    --static int cmp_record_to_refname(const char *rec, const char *refname)
    -+static int cmp_record_to_refname(const char *rec, const char *refname,
    -+				 int start)
    - {
    - 	const char *r1 = rec + the_hash_algo->hexsz + 1;
    - 	const char *r2 = refname;
    -@@ refs/packed-backend.c: static int cmp_record_to_refname(const char *rec, const char *refname)
    - 		if (*r1 == '\n')
    - 			return *r2 ? -1 : 0;
    - 		if (!*r2)
    --			return 1;
    -+			return start ? 1 : -1;
    - 		if (*r1 != *r2)
    - 			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
    - 		r1++;
     @@ refs/packed-backend.c: static int load_contents(struct snapshot *snapshot)
      	return 1;
      }
    @@ refs/packed-backend.c: static int load_contents(struct snapshot *snapshot)
     -static const char *find_reference_location(struct snapshot *snapshot,
     -					   const char *refname, int mustexist)
     +static const char *find_reference_location_1(struct snapshot *snapshot,
    -+					     const char *refname, int mustexist,
    -+					     int start)
    ++					     const char *refname, int mustexist)
      {
      	/*
      	 * This is not *quite* a garden-variety binary search, because
     @@ refs/packed-backend.c: static const char *find_reference_location(struct snapshot *snapshot,
    - 
    - 		mid = lo + (hi - lo) / 2;
    - 		rec = find_start_of_record(lo, mid);
    --		cmp = cmp_record_to_refname(rec, refname);
    -+		cmp = cmp_record_to_refname(rec, refname, start);
    - 		if (cmp < 0) {
    - 			lo = find_end_of_record(mid, hi);
    - 		} else if (cmp > 0) {
    -@@ refs/packed-backend.c: static const char *find_reference_location(struct snapshot *snapshot,
      		return lo;
      }
      
    @@ refs/packed-backend.c: static const char *find_reference_location(struct snapsho
     +static const char *find_reference_location(struct snapshot *snapshot,
     +					   const char *refname, int mustexist)
     +{
    -+	return find_reference_location_1(snapshot, refname, mustexist, 1);
    ++	return find_reference_location_1(snapshot, refname, mustexist);
     +}
     +
      /*
 9:  a39d1107c1 !  9:  8c78f49a8d refs/packed-backend.c: implement skip lists to avoid excluded pattern(s)
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    refs/packed-backend.c: implement skip lists to avoid excluded pattern(s)
    +    refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
     
         When iterating through the `packed-refs` file in order to answer a query
         like:
    @@ Commit message
         so is as follows:
     
           - For each excluded pattern, find the first record that matches it,
    -        and the first pattern that *doesn't* match it (i.e. the location
    +        and the first record that *doesn't* match it (i.e. the location
             you'd next want to consider when excluding that pattern).
     
    -      - Sort the patterns by their starting location within the
    -        `packed-refs` file.
    +      - Sort the set of excluded regions from the previous step in ascending
    +        order of the first location within the `packed-refs` file that
    +        matches.
     
    -      - Construct a skip list of regions by combining adjacent and
    -        overlapping regions from the previous step.
    +      - Clean up the results from the previous step: discard empty regions,
    +        and combine adjacent regions.
     
    -      - When iterating through the `packed-refs` file, if `iter->pos` is
    -        ever contained in one of the regions from the previous steps,
    -        advance `iter->pos` past the end of that region, and continue
    -        enumeration.
    +    Then when iterating through the `packed-refs` file, if `iter->pos` is
    +    ever contained in one of the regions from the previous steps, advance
    +    `iter->pos` past the end of that region, and continue enumeration.
     
    -    Note that this optimization is only possible when none of the excluded
    -    pattern(s) have special meta-characters in them. To see why this is the
    -    case, consider the exclusion pattern "refs/foo[a]". In general, in order
    -    to find the location of the first record that matches this pattern, we
    -    could only consider up to the first meta-character, "refs/foo". But this
    -    doesn't work, since the excluded region we'd come up with would include
    -    "refs/foobar", even though it is not excluded.
    +    Note that we only perform this optimization when none of the excluded
    +    pattern(s) have special meta-characters in them. For a pattern like
    +    "refs/foo[ac]", the excluded regions ("refs/fooa", "refs/fooc", and
    +    everything underneath them) are not connected. A future implementation
    +    that handles this case may split the character class (pretending as if
    +    two patterns were excluded: "refs/fooa", and "refs/fooc").
     
         There are a few other gotchas worth considering. First, note that the
    -    skip list is sorted, so once we skip past a region, we can avoid
    +    jump list is sorted, so once we jump past a region, we can avoid
         considering it (or any regions preceding it) again. The member
    -    `skip_pos` is used to track the first next-possible region to jump
    +    `jump_pos` is used to track the first next-possible region to jump
         through.
     
         Second, note that the exclusion list is best-effort, since we do not
    @@ Commit message
                 git update-ref --stdin
             $ git pack-refs --all
     
    -    , it is significantly faster to have `for-each-ref` skip over the
    +    , it is significantly faster to have `for-each-ref` jump over the
         excluded references, as opposed to filtering them out after the fact:
     
             $ hyperfine \
    @@ Commit message
               'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' ran
               172.03 ± 9.60 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'
     
    -    Using the skip list is fairly straightforward (see the changes to
    +    Using the jump list is fairly straightforward (see the changes to
         `refs/packed-backend.c::next_record()`), but constructing the list is
         not. To ensure that the construction is correct, add a new suite of
         tests in t1419 covering various corner cases (overlapping regions,
    @@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
      /*
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static const char *find_reference_location(struct snapshot *snapshot,
    - 	return find_reference_location_1(snapshot, refname, mustexist, 1);
    +@@ refs/packed-backend.c: static int cmp_packed_ref_records(const void *v1, const void *v2)
    +  * Compare a snapshot record at `rec` to the specified NUL-terminated
    +  * refname.
    +  */
    +-static int cmp_record_to_refname(const char *rec, const char *refname)
    ++static int cmp_record_to_refname(const char *rec, const char *refname,
    ++				 int start)
    + {
    + 	const char *r1 = rec + the_hash_algo->hexsz + 1;
    + 	const char *r2 = refname;
    +@@ refs/packed-backend.c: static int cmp_record_to_refname(const char *rec, const char *refname)
    + 		if (*r1 == '\n')
    + 			return *r2 ? -1 : 0;
    + 		if (!*r2)
    +-			return 1;
    ++			return start ? 1 : -1;
    + 		if (*r1 != *r2)
    + 			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
    + 		r1++;
    +@@ refs/packed-backend.c: static int load_contents(struct snapshot *snapshot)
      }
      
    + static const char *find_reference_location_1(struct snapshot *snapshot,
    +-					     const char *refname, int mustexist)
    ++					     const char *refname, int mustexist,
    ++					     int start)
    + {
    + 	/*
    + 	 * This is not *quite* a garden-variety binary search, because
    +@@ refs/packed-backend.c: static const char *find_reference_location_1(struct snapshot *snapshot,
    + 
    + 		mid = lo + (hi - lo) / 2;
    + 		rec = find_start_of_record(lo, mid);
    +-		cmp = cmp_record_to_refname(rec, refname);
    ++		cmp = cmp_record_to_refname(rec, refname, start);
    + 		if (cmp < 0) {
    + 			lo = find_end_of_record(mid, hi);
    + 		} else if (cmp > 0) {
    +@@ refs/packed-backend.c: static const char *find_reference_location_1(struct snapshot *snapshot,
    + static const char *find_reference_location(struct snapshot *snapshot,
    + 					   const char *refname, int mustexist)
    + {
    +-	return find_reference_location_1(snapshot, refname, mustexist);
    ++	return find_reference_location_1(snapshot, refname, mustexist, 1);
    ++}
    ++
     +/*
     + * Find the place in `snapshot->buf` after the end of the record for
     + * `refname`. In other words, find the location of first thing *after*
    @@ refs/packed-backend.c: static const char *find_reference_location(struct snapsho
     +					       int mustexist)
     +{
     +	return find_reference_location_1(snapshot, refname, mustexist, 0);
    -+}
    -+
    + }
    + 
      /*
    -  * Create a newly-allocated `snapshot` of the `packed-refs` file in
    -  * its current state and return it. The return value will already have
     @@ refs/packed-backend.c: struct packed_ref_iterator {
      	/* The end of the part of the buffer that will be iterated over: */
      	const char *eof;
      
    -+	struct skip_list_entry {
    ++	struct jump_list_entry {
     +		const char *start;
     +		const char *end;
    -+	} *skip;
    -+	size_t skip_nr, skip_alloc;
    -+	size_t skip_pos;
    ++	} *jump;
    ++	size_t jump_nr, jump_alloc;
    ++	size_t jump_pos;
     +
      	/* Scratch space for current values: */
      	struct object_id oid, peeled;
    @@ refs/packed-backend.c: struct packed_ref_iterator {
     +	 * Note that each skipped region is considered at most once,
     +	 * since they are ordered based on their starting position.
     +	 */
    -+	while (iter->skip_pos < iter->skip_nr) {
    -+		struct skip_list_entry *curr = &iter->skip[iter->skip_pos];
    ++	while (iter->jump_pos < iter->jump_nr) {
    ++		struct jump_list_entry *curr = &iter->jump[iter->jump_pos];
     +		if (iter->pos < curr->start)
     +			break; /* not to the next jump yet */
     +
    -+		iter->skip_pos++;
    ++		iter->jump_pos++;
     +		if (iter->pos < curr->end) {
     +			iter->pos = curr->end;
     +			break;
    @@ refs/packed-backend.c: static int packed_ref_iterator_abort(struct ref_iterator
      	int ok = ITER_DONE;
      
      	strbuf_release(&iter->refname_buf);
    -+	free(iter->skip);
    ++	free(iter->jump);
      	release_snapshot(iter->snapshot);
      	base_ref_iterator_free(ref_iterator);
      	return ok;
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
      	.abort = packed_ref_iterator_abort
      };
      
    -+static int skip_list_entry_cmp(const void *va, const void *vb)
    ++static int jump_list_entry_cmp(const void *va, const void *vb)
     +{
    -+	const struct skip_list_entry *a = va;
    -+	const struct skip_list_entry *b = vb;
    ++	const struct jump_list_entry *a = va;
    ++	const struct jump_list_entry *b = vb;
     +
     +	if (a->start < b->start)
     +		return -1;
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +	return y;
     +}
     +
    -+static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
    ++static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
     +					struct snapshot *snapshot,
     +					const char **excluded_patterns)
     +{
     +	size_t i, j;
     +	const char **pattern;
    ++	struct jump_list_entry *last_disjoint;
     +
     +	if (!excluded_patterns)
     +		return;
     +
     +	for (pattern = excluded_patterns; *pattern; pattern++) {
    -+		struct skip_list_entry *e;
    ++		struct jump_list_entry *e;
     +
     +		/*
     +		 * We can't feed any excludes with globs in them to the
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +		if (has_glob_special(*pattern))
     +			continue;
     +
    -+		ALLOC_GROW(iter->skip, iter->skip_nr + 1, iter->skip_alloc);
    ++		ALLOC_GROW(iter->jump, iter->jump_nr + 1, iter->jump_alloc);
     +
    -+		e = &iter->skip[iter->skip_nr++];
    ++		e = &iter->jump[iter->jump_nr++];
     +		e->start = find_reference_location(snapshot, *pattern, 0);
     +		e->end = find_reference_location_end(snapshot, *pattern, 0);
     +	}
     +
    -+	if (!iter->skip_nr) {
    ++	if (!iter->jump_nr) {
     +		/*
     +		 * Every entry in exclude_patterns has a meta-character,
     +		 * nothing to do here.
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +		return;
     +	}
     +
    -+	QSORT(iter->skip, iter->skip_nr, skip_list_entry_cmp);
    ++	QSORT(iter->jump, iter->jump_nr, jump_list_entry_cmp);
     +
     +	/*
    -+	 * As an optimization, merge adjacent entries in the skip list
    ++	 * As an optimization, merge adjacent entries in the jump list
     +	 * to jump forwards as far as possible when entering a skipped
     +	 * region.
     +	 *
    @@ refs/packed-backend.c: static struct ref_iterator_vtable packed_ref_iterator_vta
     +	 * we want to combine that into a single entry jumping from A to
     +	 * C.
     +	 */
    -+	for (i = 1, j = 1; i < iter->skip_nr; i++) {
    -+		struct skip_list_entry *ours = &iter->skip[i];
    -+		struct skip_list_entry *prev = &iter->skip[i - 1];
    ++	last_disjoint = iter->jump;
    ++
    ++	for (i = 1, j = 1; i < iter->jump_nr; i++) {
    ++		struct jump_list_entry *ours = &iter->jump[i];
     +
     +		if (ours->start == ours->end) {
     +			/* ignore empty regions (no matching entries) */
     +			continue;
    -+		} else if (prev->end >= ours->start) {
    ++		} else if (ours->start <= last_disjoint->end) {
     +			/* overlapping regions extend the previous one */
    -+			prev->end = ptr_max(prev->end, ours->end);
    ++			last_disjoint->end = ptr_max(last_disjoint->end, ours->end);
     +		} else {
     +			/* otherwise, insert a new region */
    -+			iter->skip[j++] = *ours;
    ++			iter->jump[j++] = *ours;
    ++			last_disjoint = ours;
    ++
     +		}
     +	}
     +
    -+	iter->skip_nr = j;
    -+	iter->skip_pos = 0;
    ++	iter->jump_nr = j;
    ++	iter->jump_pos = 0;
     +}
     +
      static struct ref_iterator *packed_ref_iterator_begin(
    @@ refs/packed-backend.c: static struct ref_iterator *packed_ref_iterator_begin(
      	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);
      
     +	if (exclude_patterns)
    -+		populate_excluded_skip_list(iter, snapshot, exclude_patterns);
    ++		populate_excluded_jump_list(iter, snapshot, exclude_patterns);
     +
      	iter->snapshot = snapshot;
      	acquire_snapshot(snapshot);
    @@ t/t1419-exclude-refs.sh (new)
     +	git pack-refs --all
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
    -+	# region in middle
    ++test_expect_success 'excluded region in middle' '
     +	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
     +	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/bar/)' '
    -+	# region at beginning
    ++test_expect_success 'excluded region at beginning' '
     +	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
     +	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/quux/)' '
    -+	# region at end
    ++test_expect_success 'excluded region at end' '
     +	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
     +	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/quux/)' '
    -+	# disjoint regions
    ++test_expect_success 'disjoint excluded regions' '
     +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
     +	for_each_ref refs/heads/baz refs/heads/foo >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/baz/)' '
    -+	# adjacent, non-overlapping regions
    ++test_expect_success 'adjacent, non-overlapping excluded regions' '
     +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
     +	for_each_ref refs/heads/foo refs/heads/quux >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/ba refs/heads/baz/)' '
    -+	# overlapping region
    ++test_expect_success 'overlapping excluded regions' '
     +	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
     +	for_each_ref refs/heads/foo refs/heads/quux >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/does/not/exist)' '
    -+	# empty region
    ++test_expect_success 'several overlapping excluded regions' '
    ++	for_each_ref__exclude refs/heads \
    ++		refs/heads/bar refs/heads/baz refs/heads/foo >actual &&
    ++	for_each_ref refs/heads/quux >expect &&
    ++
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'non-matching excluded section' '
     +	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
     +	for_each_ref >expect &&
     +
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
    -+	# discards meta-characters
    ++test_expect_success 'meta-characters are discarded' '
     +	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
     +	for_each_ref >expect &&
     +
10:  5698c2794f ! 10:  5059f5dd42 refs/packed-backend.c: add trace2 counters for skip list
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    refs/packed-backend.c: add trace2 counters for skip list
    +    refs/packed-backend.c: add trace2 counters for jump list
     
         The previous commit added low-level tests to ensure that the packed-refs
         iterator did not enumerate excluded sections of the refspace.
    @@ refs/packed-backend.c
      enum mmap_strategy {
      	/*
     @@ refs/packed-backend.c: static int next_record(struct packed_ref_iterator *iter)
    - 		iter->skip_pos++;
    + 		iter->jump_pos++;
      		if (iter->pos < curr->end) {
      			iter->pos = curr->end;
    -+			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_SKIPS, 1);
    ++			trace2_counter_add(TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, 1);
      			break;
      		}
      	}
    @@ t/t1419-exclude-refs.sh: for_each_ref () {
      	git for-each-ref --format='%(refname)' "$@"
      }
      
    -+assert_skips () {
    ++assert_jumps () {
     +	local nr="$1"
     +	local trace="$2"
     +
    -+	grep -q "name:skips_made value:$nr" $trace
    ++	grep -q "name:jumps_made value:$nr" $trace
     +}
     +
    -+assert_no_skips () {
    -+	! assert_skips ".*" "$1"
    ++assert_no_jumps () {
    ++	! assert_jumps ".*" "$1"
     +}
     +
      test_expect_success 'setup' '
      	test_commit --no-tag base &&
      	base="$(git rev-parse HEAD)" &&
     @@ t/t1419-exclude-refs.sh: test_expect_success 'setup' '
    + '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
    - 	# region in middle
    + test_expect_success 'excluded region in middle' '
     -	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/foo >actual 2>perf &&
      	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 1 perf
    ++	assert_jumps 1 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/bar/)' '
    - 	# region at beginning
    + test_expect_success 'excluded region at beginning' '
     -	for_each_ref__exclude refs/heads refs/heads/bar >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/bar >actual 2>perf &&
      	for_each_ref refs/heads/baz refs/heads/foo refs/heads/quux >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 1 perf
    ++	assert_jumps 1 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/quux/)' '
    - 	# region at end
    + test_expect_success 'excluded region at end' '
     -	for_each_ref__exclude refs/heads refs/heads/quux >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/quux >actual 2>perf &&
      	for_each_ref refs/heads/foo refs/heads/bar refs/heads/baz >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 1 perf
    ++	assert_jumps 1 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/quux/)' '
    - 	# disjoint regions
    + test_expect_success 'disjoint excluded regions' '
     -	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/quux >actual 2>perf &&
      	for_each_ref refs/heads/baz refs/heads/foo >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 2 perf
    ++	assert_jumps 2 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/bar/, refs/heads/baz/)' '
    - 	# adjacent, non-overlapping regions
    + test_expect_success 'adjacent, non-overlapping excluded regions' '
     -	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/bar refs/heads/baz >actual 2>perf &&
      	for_each_ref refs/heads/foo refs/heads/quux >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 1 perf
    ++	assert_jumps 1 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/ba refs/heads/baz/)' '
    - 	# overlapping region
    + test_expect_success 'overlapping excluded regions' '
     -	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/ba refs/heads/baz >actual 2>perf &&
      	for_each_ref refs/heads/foo refs/heads/quux >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_skips 1 perf
    ++	assert_jumps 1 perf
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/does/not/exist)' '
    - 	# empty region
    + test_expect_success 'several overlapping excluded regions' '
    + 	for_each_ref__exclude refs/heads \
    +-		refs/heads/bar refs/heads/baz refs/heads/foo >actual &&
    ++		refs/heads/bar refs/heads/baz refs/heads/foo >actual 2>perf &&
    + 	for_each_ref refs/heads/quux >expect &&
    + 
    +-	test_cmp expect actual
    ++	test_cmp expect actual &&
    ++	assert_jumps 1 perf
    + '
    + 
    + test_expect_success 'non-matching excluded section' '
     -	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual &&
     +	for_each_ref__exclude refs/heads refs/heads/does/not/exist >actual 2>perf &&
      	for_each_ref >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_no_skips
    ++	assert_no_jumps
      '
      
    - test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
    - 	# discards meta-characters
    + test_expect_success 'meta-characters are discarded' '
     -	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual &&
     +	for_each_ref__exclude refs/heads "refs/heads/ba*" >actual 2>perf &&
      	for_each_ref >expect &&
      
     -	test_cmp expect actual
     +	test_cmp expect actual &&
    -+	assert_no_skips
    ++	assert_no_jumps
      '
      
      test_done
    @@ trace2.h: enum trace2_counter_id {
      	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
      	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
      
    -+	TRACE2_COUNTER_ID_PACKED_REFS_SKIPS, /* counts number of skips */
    ++	TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, /* counts number of jumps */
     +
      	/* Add additional counter definitions before here. */
      	TRACE2_NUMBER_OF_COUNTERS
    @@ trace2/tr2_ctr.c: static struct tr2_counter_metadata tr2_counter_metadata[TRACE2
      		.name = "test2",
      		.want_per_thread_events = 1,
      	},
    -+	[TRACE2_COUNTER_ID_PACKED_REFS_SKIPS] = {
    ++	[TRACE2_COUNTER_ID_PACKED_REFS_JUMPS] = {
     +		.category = "packed-refs",
    -+		.name = "skips_made",
    ++		.name = "jumps_made",
     +		.want_per_thread_events = 0,
     +	},
      
11:  5b9814ad8c ! 11:  f765b50a84 revision.h: store hidden refs in a `strvec`
    @@ revision.c: void init_ref_exclusions(struct ref_exclusions *exclusions)
     
      ## revision.h ##
     @@
    - #include "commit-slab-decl.h"
    + #include "decorate.h"
      #include "ident.h"
      #include "list-objects-filter-options.h"
     +#include "strvec.h"
12:  dd5b34185c ! 12:  254bcc4361 refs/packed-backend.c: ignore complicated hidden refs rules
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## refs/packed-backend.c ##
    -@@ refs/packed-backend.c: static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
    +@@ refs/packed-backend.c: static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
      	if (!excluded_patterns)
      		return;
      
    @@ refs/packed-backend.c: static void populate_excluded_skip_list(struct packed_ref
     +		 * '^' rules.
     +		 *
     +		 * Both are possible to do, but complicated, so avoid
    -+		 * populating the skip list at all if we see either of
    ++		 * populating the jump list at all if we see either of
     +		 * these patterns.
     +		 */
     +		if (**pattern == '!' || **pattern == '^')
    @@ refs/packed-backend.c: static void populate_excluded_skip_list(struct packed_ref
     +	}
     +
      	for (pattern = excluded_patterns; *pattern; pattern++) {
    - 		struct skip_list_entry *e;
    + 		struct jump_list_entry *e;
      
     
      ## t/t1419-exclude-refs.sh ##
    -@@ t/t1419-exclude-refs.sh: test_expect_success 'for_each_ref__exclude(refs/heads/ba*)' '
    - 	assert_no_skips
    +@@ t/t1419-exclude-refs.sh: test_expect_success 'meta-characters are discarded' '
    + 	assert_no_jumps
      '
      
    -+test_expect_success 'for_each_ref__exclude(refs/heads/foo, !refs/heads/foo/1)' '
    -+	# discards complex hidden ref rules
    ++test_expect_success 'complex hidden ref rules are discarded' '
     +	for_each_ref__exclude refs/heads refs/heads/foo "!refs/heads/foo/1" \
     +		>actual 2>perf &&
     +	for_each_ref >expect &&
     +
     +	test_cmp expect actual &&
    -+	assert_no_skips
    ++	assert_no_jumps
     +'
     +
      test_done
13:  c65b3dea81 = 13:  50e7df7dc0 refs.h: let `for_each_namespaced_ref()` take excluded patterns
15:  7d3383083d = 14:  f6a3a5a6ba builtin/receive-pack.c: avoid enumerating hidden references
14:  44bbf85e73 ! 15:  2331fa7a4d upload-pack.c: avoid enumerating hidden refs where possible
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
     +				      struct upload_pack_data *data)
     +{
     +	/*
    -+	 * If `data->allow_uor` allows updating hidden refs, we need to
    ++	 * If `data->allow_uor` allows fetching hidden refs, we need to
     +	 * mark all references (including hidden ones), to check in
     +	 * `is_our_ref()` below.
     +	 *
 -:  ---------- > 16:  2c6b89d64a ls-refs.c: avoid enumerating hidden refs where possible
-- 
2.40.1.572.g5c4ab523ef
