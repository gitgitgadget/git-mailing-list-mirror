Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3080C2BBD4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77ED523F36
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 09:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437389AbgLKJKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 04:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437181AbgLKJJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 04:09:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35CC0613CF
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r14so8235009wrn.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZwDR8nA8R8oAhih1VqGP/39PuftRCf3yimVfwegdP0=;
        b=YunuUc+zN+ulayFLlk2CvUqqe34T+1GwoheIc6lttkQtMwjm+Jl7zPwtiwEy7oIEWG
         mUypx9uXwJzZXSVGENqtdGQzZI6LeMm9TBIY6jjrINGA9xBk1WXr+CXavxw/ZQBtFm7h
         wuQit2gP59/hWF85qrC6PmTDIt94s82VOtSx6iXqKEiavmqq8KLCiyMuf0oNzgnIuRJz
         yIJJAjUZHPqOmdfCur/MZ3jYQ7JfRDqRsK11n2jjeUhbOPpijNkcyQ5jwXQD18N3GPjz
         EOqHfnEQmONCaDpm0PRZdb4KgdMXCKOoVcjMZ27Dwzqu2X4Vwp8n5/Wh275HHL/JioJK
         fejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rZwDR8nA8R8oAhih1VqGP/39PuftRCf3yimVfwegdP0=;
        b=VurbG9GRgcVFPgLOVc3G821C4HfD7rkqH0ptQkGIUQVoJUheUluZ5UjiSHMWfqI80o
         s4TBe6rQX5s2fzqJVTbNO1fEGw+yULdosTI96RpOeO3IsaKQ8AL8x2uhKydA1Py3O1TK
         1oMXKqoqIQ+pSGMaRbjQlHOcwduk5Zh6cIYGqWZBJHGPgWBP/+TOt9UoO839FqqFe09K
         tjCYal9W1Pjh+ZLJoDT5L/P6IuDNBE/SILh9W6ccs/ac28JDdXydoZgdtCkgHVfXltW/
         LGiZQ0JYCt2O/uYP7S7r62mCx8dm++fCbYEo3lVm9IXFdNRzf++nbQmrmHotq9/dQizX
         BwCA==
X-Gm-Message-State: AOAM532odIANcUPnluGUp4X4RdTUq2xlh4fgfnc+h7uxYbKwdYxxvcan
        NCm/KpFdtnKTM9Tb+C9tqT3psSw3j2Q=
X-Google-Smtp-Source: ABdhPJxdlxvGOyaxWG7GqzNKqGmnM37d/8Nvyz0+lV6WcBhOyaflqdNFul0I3w5Nxa9X7W6PnuXBRw==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr12771014wrs.227.1607677730360;
        Fri, 11 Dec 2020 01:08:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm15365629wma.41.2020.12.11.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 01:08:49 -0800 (PST)
Message-Id: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 09:08:39 +0000
Subject: [PATCH v2 0/9] diffcore-rename improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes 3 small code cleanups, 1 small bug fix (or
perhaps just a UI improvement -- it's a very minor issue either way), more
testcases, and 3 performance improvements. The first 7 patches are
relatively easy to review, while the second to last one...is a bit more
involved (but provided the biggest performance boost).

Changes since v1:

 * Inserted a patch at the beginning to rename num_create to
   num_destinations, as suggested by Junio. Also simplifies patch 2.
 * Used st_mult() to simplify the limit check
 * Dropped a patch Junio didn't care for
 * Inserted two new patches, 5 & 6, to add new testcases motivated by
   Junio's comments about register_rename_src() and correctness in the face
   of duplicate tree entries.
 * Modified patch 7 so that register_rename_src() behaves identically to
   current code, even when trees have duplicate entries
 * Added a new patch 9 which rips out the unnecessary duplicate entry checks
   for BOTH rename_src and rename_dst, and documents why they are safe to
   remove. This is also supported by the new testcases in patches 5 and 6. I
   also ran t4058 (which patches 5 and 6 add to) under valgrind afterwards
   and verified that no errors from diffcore-rename were reported (valgrind
   did report problems from cache-tree and unpack-trees, as documented in
   patch 6, but that was true before this patch series and probably has been
   that way for years or decades).
 * Miscellaneous small cleanups highlighted by Taylor and Junio

Elijah Newren (9):
  diffcore-rename: rename num_create to num_destinations
  diffcore-rename: avoid usage of global in too_many_rename_candidates()
  diffcore-rename: simplify limit check
  diffcore-rename: reduce jumpiness in progress counters
  t4058: add more tests and documentation for duplicate tree entry
    handling
  t4058: explore duplicate tree entry handling in a bit more detail
  diffcore-rename: simplify and accelerate register_rename_src()
  diffcore-rename: accelerate rename_dst setup
  diffcore-rename: remove unneccessary duplicate entry checks

 diffcore-rename.c          | 209 ++++++++++++++-----------------------
 t/t4058-diff-duplicates.sh | 114 +++++++++++++++++++-
 2 files changed, 192 insertions(+), 131 deletions(-)


base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-929%2Fnewren%2Fdiffcore-rename-improvements-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-929/newren/diffcore-rename-improvements-v2
Pull-Request: https://github.com/git/git/pull/929

Range-diff vs v1:

  3:  30381addc5c !  1:  428d8204894 diffcore-rename: rename num_create to num_targets
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: rename num_create to num_targets
     +    diffcore-rename: rename num_create to num_destinations
      
     -    Files added since the base commit serve as targets for rename detection.
     -    While it is true that added files can be thought of as being "created"
     -    when they are added IF they have no pairing file that they were renamed
     -    from, and it is true we start out not knowing what the pairings are, it
     -    seems a little odd to think in terms of "file creation" when we are
     -    looking for "file renames".  Rename the variable to avoid this minor
     -    point of confusion.
     +    Our main data structures are rename_src and rename_dst.  For counters of
     +    these data structures, num_sources and num_destinations seem natural;
     +    definitely more so than using num_create for the latter.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     +@@ diffcore-rename.c: static void record_if_better(struct diff_score m[], struct diff_score *o)
     +  * 1 if we need to disable inexact rename detection;
     +  * 2 if we would be under the limit if we were given -C instead of -C -C.
     +  */
     +-static int too_many_rename_candidates(int num_create,
     ++static int too_many_rename_candidates(int num_destinations,
     + 				      struct diff_options *options)
     + {
     + 	int rename_limit = options->rename_limit;
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_create,
     + 	 * This basically does a test for the rename matrix not
     + 	 * growing larger than a "rename_limit" square matrix, ie:
     + 	 *
     +-	 *    num_create * num_src > rename_limit * rename_limit
     ++	 *    num_destinations * num_src > rename_limit * rename_limit
     + 	 */
     + 	if (rename_limit <= 0)
     + 		rename_limit = 32767;
     +-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
     +-	    ((uint64_t)num_create * (uint64_t)num_src
     ++	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
     ++	    ((uint64_t)num_destinations * (uint64_t)num_src
     + 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
     + 		return 0;
     + 
     + 	options->needed_rename_limit =
     +-		num_src > num_create ? num_src : num_create;
     ++		num_src > num_destinations ? num_src : num_destinations;
     + 
     + 	/* Are we running under -C -C? */
     + 	if (!options->flags.find_copies_harder)
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_create,
     + 			continue;
     + 		num_src++;
     + 	}
     +-	if ((num_create <= rename_limit || num_src <= rename_limit) &&
     +-	    ((uint64_t)num_create * (uint64_t)num_src
     ++	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
     ++	    ((uint64_t)num_destinations * (uint64_t)num_src
     + 	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
     + 		return 2;
     + 	return 1;
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	struct diff_queue_struct outq;
       	struct diff_score *mx;
       	int i, j, rename_count, skip_unmodified = 0;
      -	int num_create, dst_cnt;
     -+	int num_targets, dst_cnt;
     ++	int num_destinations, dst_cnt;
       	struct progress *progress = NULL;
       
       	if (!minimum_score)
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	 * files still remain as options for rename/copies!)
       	 */
      -	num_create = (rename_dst_nr - rename_count);
     -+	num_targets = (rename_dst_nr - rename_count);
     ++	num_destinations = (rename_dst_nr - rename_count);
       
       	/* All done? */
      -	if (!num_create)
     -+	if (!num_targets)
     ++	if (!num_destinations)
       		goto cleanup;
       
     --	switch (too_many_rename_candidates(num_create, rename_src_nr, options)) {
     -+	switch (too_many_rename_candidates(num_targets, rename_src_nr, options)) {
     +-	switch (too_many_rename_candidates(num_create, options)) {
     ++	switch (too_many_rename_candidates(num_destinations, options)) {
       	case 1:
       		goto cleanup;
       	case 2:
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       	}
       
      -	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
     -+	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
     ++	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
     ++		     sizeof(*mx));
       	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
       		struct diff_filespec *two = rename_dst[i].two;
       		struct diff_score *m;
  1:  95a3fcb8be0 !  2:  fc62f4c4f89 diffcore-rename: avoid usage of global in too_many_rename_candidates()
     @@ Metadata
       ## Commit message ##
          diffcore-rename: avoid usage of global in too_many_rename_candidates()
      
     -    too_many_rename_candidates() got the number of rename targets via an
     -    argument to the function, but the number of rename sources via a global
     -    variable.  That felt rather inconsistent.  Pass in the number of rename
     -    sources as an argument as well.
     +    too_many_rename_candidates() got the number of rename destinations via
     +    an argument to the function, but the number of rename sources via a
     +    global variable.  That felt rather inconsistent.  Pass in the number of
     +    rename sources as an argument as well.
      
          While we are at it... We had a local variable, num_src, that served two
     -    purposes.  Initially it was set to this global value, but later was used
     +    purposes.  Initially it was set to the global value, but later was used
          for counting a subset of the number of sources.  Since we now have a
          function argument for the former usage, introduce a clearer variable
          name for the latter usage.
     @@ diffcore-rename.c: static void record_if_better(struct diff_score m[], struct di
        * 1 if we need to disable inexact rename detection;
        * 2 if we would be under the limit if we were given -C instead of -C -C.
        */
     --static int too_many_rename_candidates(int num_create,
     -+static int too_many_rename_candidates(int num_targets, int num_sources,
     +-static int too_many_rename_candidates(int num_destinations,
     ++static int too_many_rename_candidates(int num_destinations, int num_sources,
       				      struct diff_options *options)
       {
       	int rename_limit = options->rename_limit;
     @@ diffcore-rename.c: static void record_if_better(struct diff_score m[], struct di
       
       	options->needed_rename_limit = 0;
       
     -@@ diffcore-rename.c: static int too_many_rename_candidates(int num_create,
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_destinations,
       	 * This basically does a test for the rename matrix not
       	 * growing larger than a "rename_limit" square matrix, ie:
       	 *
     --	 *    num_create * num_src > rename_limit * rename_limit
     -+	 *    num_targets * num_sources > rename_limit * rename_limit
     +-	 *    num_destinations * num_src > rename_limit * rename_limit
     ++	 *    num_destinations * num_sources > rename_limit * rename_limit
       	 */
       	if (rename_limit <= 0)
       		rename_limit = 32767;
     --	if ((num_create <= rename_limit || num_src <= rename_limit) &&
     --	    ((uint64_t)num_create * (uint64_t)num_src
     -+	if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
     -+	    ((uint64_t)num_targets * (uint64_t)num_sources
     +-	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
     +-	    ((uint64_t)num_destinations * (uint64_t)num_src
     ++	if ((num_destinations <= rename_limit || num_sources <= rename_limit) &&
     ++	    ((uint64_t)num_destinations * (uint64_t)num_sources
       	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
       		return 0;
       
       	options->needed_rename_limit =
     --		num_src > num_create ? num_src : num_create;
     -+		num_sources > num_targets ? num_sources : num_targets;
     +-		num_src > num_destinations ? num_src : num_destinations;
     ++		num_sources > num_destinations ? num_sources : num_destinations;
       
       	/* Are we running under -C -C? */
       	if (!options->flags.find_copies_harder)
     @@ diffcore-rename.c: static int too_many_rename_candidates(int num_create,
      -		num_src++;
      +		limited_sources++;
       	}
     --	if ((num_create <= rename_limit || num_src <= rename_limit) &&
     --	    ((uint64_t)num_create * (uint64_t)num_src
     -+	if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
     -+	    ((uint64_t)num_targets * (uint64_t)limited_sources
     +-	if ((num_destinations <= rename_limit || num_src <= rename_limit) &&
     +-	    ((uint64_t)num_destinations * (uint64_t)num_src
     ++	if ((num_destinations <= rename_limit || limited_sources <= rename_limit) &&
     ++	    ((uint64_t)num_destinations * (uint64_t)limited_sources
       	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
       		return 2;
       	return 1;
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     - 	if (!num_create)
     + 	if (!num_destinations)
       		goto cleanup;
       
     --	switch (too_many_rename_candidates(num_create, options)) {
     -+	switch (too_many_rename_candidates(num_create, rename_src_nr, options)) {
     +-	switch (too_many_rename_candidates(num_destinations, options)) {
     ++	switch (too_many_rename_candidates(num_destinations, rename_src_nr,
     ++					   options)) {
       	case 1:
       		goto cleanup;
       	case 2:
  2:  f96bb36930a !  3:  7214fa73fdd diffcore-rename: remove unnecessary if-clause
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    diffcore-rename: remove unnecessary if-clause
     +    diffcore-rename: simplify limit check
      
          diffcore-rename had two different checks of the form
      
              if ((a < limit || b < limit) &&
                  a * b <= limit * limit)
      
     -    Since these are all non-negative integers, this can be simplified to
     +    This can be simplified to
      
     -        if (a * b <= limit * limit)
     +        if (st_mult(a, b) <= st_mult(limit, limit))
      
     -    The only advantage of the former would be in avoiding a couple
     -    multiplications in the rare case that both a and b are BOTH very large.
     -    I see no reason for such an optimization given that this code is not in
     -    any kind of loop.  Prefer code simplicity here and change to the latter
     -    form.
     +    which makes it clearer how we are checking for overflow, and makes it
     +    much easier to parse given the drop from 8 to 4 variable appearances.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
     -@@ diffcore-rename.c: static int too_many_rename_candidates(int num_targets, int num_sources,
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_destinations, int num_sources,
     + 	 * growing larger than a "rename_limit" square matrix, ie:
     + 	 *
     + 	 *    num_destinations * num_sources > rename_limit * rename_limit
     ++	 *
     ++	 * We use st_mult() to check overflow conditions; in the
     ++	 * exceptional circumstance that size_t isn't large enough to hold
     ++	 * the multiplication, the system won't be able to allocate enough
     ++	 * memory for the matrix anyway.
       	 */
       	if (rename_limit <= 0)
       		rename_limit = 32767;
     --	if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
     --	    ((uint64_t)num_targets * (uint64_t)num_sources
     +-	if ((num_destinations <= rename_limit || num_sources <= rename_limit) &&
     +-	    ((uint64_t)num_destinations * (uint64_t)num_sources
      -	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
     -+	if ((uint64_t)num_targets * (uint64_t)num_sources
     -+	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)
     ++	if (st_mult(num_destinations, num_sources)
     ++	    <= st_mult(rename_limit, rename_limit))
       		return 0;
       
       	options->needed_rename_limit =
     -@@ diffcore-rename.c: static int too_many_rename_candidates(int num_targets, int num_sources,
     +@@ diffcore-rename.c: static int too_many_rename_candidates(int num_destinations, int num_sources,
       			continue;
       		limited_sources++;
       	}
     --	if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
     --	    ((uint64_t)num_targets * (uint64_t)limited_sources
     +-	if ((num_destinations <= rename_limit || limited_sources <= rename_limit) &&
     +-	    ((uint64_t)num_destinations * (uint64_t)limited_sources
      -	     <= (uint64_t)rename_limit * (uint64_t)rename_limit))
     -+	if ((uint64_t)num_targets * (uint64_t)limited_sources
     -+	    <= (uint64_t)rename_limit * (uint64_t)rename_limit)
     ++	if (st_mult(num_destinations, limited_sources)
     ++	    <= st_mult(rename_limit, rename_limit))
       		return 2;
       	return 1;
       }
  4:  77ca4656ed4 <  -:  ----------- diffcore-rename: change a few comments to use 'add' instead of 'create'
  5:  e8257516c1f !  4:  bf3581b1ac1 diffcore-rename: reduce jumpiness in progress counters
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       		progress = start_delayed_progress(
       				_("Performing inexact rename detection"),
      -				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
     -+				(uint64_t)num_targets * (uint64_t)rename_src_nr);
     ++				(uint64_t)num_destinations * (uint64_t)rename_src_nr);
       	}
       
     - 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
     + 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       			diff_free_filespec_blob(two);
       		}
  -:  ----------- >  5:  9a4a3159acf t4058: add more tests and documentation for duplicate tree entry handling
  -:  ----------- >  6:  8db27892c59 t4058: explore duplicate tree entry handling in a bit more detail
  6:  306a48820dd !  7:  a58639b2927 diffcore-rename: simplify and accelerate register_rename_src()
     @@ Metadata
       ## Commit message ##
          diffcore-rename: simplify and accelerate register_rename_src()
      
     -    reigster_rename_src() took pains to create an array in rename_src which
     -    was sorted by pathname of the contained diff_filepair.  However, the
     -    fact that this array was sorted was not needed anywhere, and thus
     -    represented wasted time.  Simply append to the end of the array, which
     -    in a usecase of note saved 45% of diffcore_rename() setup time for me.
     -
     -    Technically, there is one difference in the end result for the code.  IF
     -    the caller of diffcore-rename provides a set of pairs with a duplicate
     -    filename in the sources (an erroneous input condition), the old code
     -    would simply ignore the duplicate (without warning or error).  The new
     -    code will simply swallow it and thus allow multiple pairings for the
     -    "same" source file.  Checking for this error condition is expensive
     -    (basically undoing the optimization) and the only existing callers
     -    already avoid passing such an invalid input.  If someone really wants to
     -    add some error checking here on this input condition, I believe they
     -    should add a separate function which can be called before
     -    diffcore_rename(), and then other callers that don't need additional
     -    checks because of their design (such as merge-ort) can avoid the extra
     -    overhead.
     +    register_rename_src() took pains to create an array in rename_src which
     +    was sorted by pathname of the contained diff_filepair.  The sorting was
     +    entirely unnecessary since callers pass filepairs to us in sorted
     +    order.  We can simply append to the end of the rename_src array,
     +    speeding up diffcore_rename() setup time.
      
          Also, note that I dropped the return type on the function since it was
          unconditionally discarded anyway.
     @@ diffcore-rename.c: static struct diff_rename_src {
      -		}
      -		first = next+1;
      -	}
     --
     ++	/*
     ++	 * If we have multiple entries at the same path in the source tree
     ++	 * (an invalid tree, to be sure), avoid using more more than one
     ++	 * such entry in rename detection.  Once upon a time, doing so
     ++	 * caused segfaults; see commit 25d5ea410f ("[PATCH] Redo
     ++	 * rename/copy detection logic.", 2005-05-24).
     ++	 */
     ++	if (rename_src_nr > 0 &&
     ++	    !strcmp(rename_src[rename_src_nr-1].p->one->path, p->one->path))
     ++		return;
     + 
      -	/* insert to make it at "first" */
       	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
      +	rename_src[rename_src_nr].p = p;
  7:  3e83b51628b !  8:  85714e1583d Accelerate rename_dst setup
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    Accelerate rename_dst setup
     +    diffcore-rename: accelerate rename_dst setup
      
          register_rename_src() simply references the passed pair inside
          rename_src.  In contrast, add_rename_dst() did something entirely
     @@ Commit message
          been done in a weakly quadratic manner, when many renames are involved
          this time could add up.
      
     -    There is still a strcmp() in add_rename_dst() that I feel is
     -    unnecessary, because I disagree with a regression test in t4058.
     -    However, I'm trying to increase performance without changing behavior,
     -    so I'll leave that fight for a different day (a TODO has been left in
     -    the code about it).
     +    There is still a strcmp() in add_rename_dst() that I have left in place
     +    to make it easier to verify that the algorithm has the same results.
     +    This strcmp() is there to check for duplicate destination entries (which
     +    was the easiest way at the time to avoid segfaults in the
     +    diffcore-rename code when trees had multiple entries at a given path).
     +    The underlying double free()s are no longer an issue with the new
     +    algorithm, but that can be addressed in a subsequent commit.
      
          This patch is being submitted in a different order than its original
          development, but in a large rebase of many commits with lots of renames
     @@ Commit message
      
       ## diffcore-rename.c ##
      @@
     - #include "cache.h"
     - #include "diff.h"
     - #include "diffcore.h"
     --#include "object-store.h"
       #include "hashmap.h"
     -+#include "object-store.h"
       #include "progress.h"
       #include "promisor-remote.h"
      +#include "strmap.h"
     @@ diffcore-rename.c
      -
      -	if (first >= 0)
      +	/*
     -+	 * See t4058; trees might have duplicate entries.  I think
     -+	 * trees with duplicate entries should be ignored and we
     -+	 * should just leave rename detection on; while the results
     -+	 * may be slightly harder to understand, that's merely a
     -+	 * result of the underlying tree making no sense.  But I
     -+	 * believe everything still works fine, the results do still
     -+	 * make sense, and the extra overhead of doing this checking
     -+	 * for a few historical weird trees from long ago seems like
     -+	 * the dog wagging the tail to me.
     -+	 *
     -+	 * However: I don't feel like fighting that battle right now.
     -+	 * For now, to keep the regression test passing, we have to
     -+	 * detect it.  Since the diff machinery passes these to us in
     -+	 * adjacent pairs, we just need to check to see if our name
     -+	 * matches the previous one.
     -+	 *
     -+	 * TODO: Dispense with this test, rip out the test in t4058, and
     -+	 * lobby folks for the change.
     ++	 * If we have multiple entries at the same path in the destination
     ++	 * tree (an invalid tree, to be sure), turn off rename detection
     ++	 * entirely.  Once upon a time, diffcore-rename had double free()
     ++	 * issues due to such duplicate paths, resulting in segfaults.  See
     ++	 * commit 4d6be03b95 ("diffcore-rename: avoid processing duplicate
     ++	 * destinations", 2015-02-26).
      +	 */
      +	if (rename_dst_nr > 0 &&
      +	    !strcmp(rename_dst[rename_dst_nr-1].p->two->path, p->two->path))
     @@ diffcore-rename.c
       	return 0;
       }
       
     -@@ diffcore-rename.c: static int rename_src_nr, rename_src_alloc;
     +@@ diffcore-rename.c: static void register_rename_src(struct diff_filepair *p)
     + 	    !strcmp(rename_src[rename_src_nr-1].p->one->path, p->one->path))
     + 		return;
       
     - static void register_rename_src(struct diff_filepair *p)
     - {
      +	if (p->broken_pair) {
      +		if (!break_idx) {
      +			break_idx = xmalloc(sizeof(*break_idx));
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       					" duplicate destination '%s'",
       					p->two->path);
      @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
     - 
     - 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_targets), sizeof(*mx));
     + 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
     + 		     sizeof(*mx));
       	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
      -		struct diff_filespec *two = rename_dst[i].two;
      +		struct diff_filespec *two = rename_dst[i].p->two;
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
       		}
       		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
      -			/*
     --			 * Addition
     +-			 * Creation
      -			 *
     --			 * We would output this add record if it has
     +-			 * We would output this create record if it has
      -			 * not been turned into a rename/copy already.
      -			 */
      -			struct diff_rename_dst *dst = locate_rename_dst(p->two);
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      -			}
      -			else
      -				/* no matching rename/copy source, so
     --				 * record this as an addition.
     +-				 * record this as a creation.
      -				 */
      -				diff_q(&outq, p);
     -+			/* Addition */
     ++			/* Creation */
      +			diff_q(&outq, p);
       		}
       		else if (DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two)) {
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      -				struct diff_rename_dst *dst = locate_rename_dst(p->one);
      -				if (dst && dst->pair)
      +				struct diff_rename_dst *dst = locate_rename_dst(p);
     -+				assert(dst);
     ++				if (!dst)
     ++					BUG("tracking failed somehow; failed to find associated dst for broken pair");
      +				if (dst->is_rename)
       					/* counterpart is now rename/copy */
       					pair_to_free = p;
  -:  ----------- >  9:  af256b1c534 diffcore-rename: remove unneccessary duplicate entry checks

-- 
gitgitgadget
