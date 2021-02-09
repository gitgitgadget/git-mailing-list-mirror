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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFE0C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C7E64E3B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 11:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBILps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 06:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBILfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 06:35:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3840C0617A7
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 03:32:09 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b3so21177376wrj.5
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=aD5sr0JegKEcPIqDrwQI916Z8EMdlSBwU9MrCaGJLdU=;
        b=XKpeFN8YZEfSFv5EO5tVIDpJ6VyNAnvOaZY/nxs+UFp5L7hHdccN+ctnGpxd4iNLOL
         5OCF/M7/wEO1YebrX8NJShzoHt+CGyUIXt4SCwTmz9I8wNQHH6WEUFwjz+kOkoKGD4F3
         RK80a3ir7uwzHQnqIme5rHOPwwWDKRZ++ruJSfmA1kLHfxLM0im6eBy37P23w8QF3UoP
         ITGLdfvCXon66RkA1ygw9tgrpkUc20OGtN/pMM0mWAEXwVPOXUyKCx2QYLOtvUkFQtKl
         v/sp9QEPYc1Jc7wbVi80mZNh2GsE5rJdAkMPjJO+1MJr0dz211Dnp6m4By57r9blL/at
         nc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=aD5sr0JegKEcPIqDrwQI916Z8EMdlSBwU9MrCaGJLdU=;
        b=hnJnYjG9QBTwPAXTvZ1lWnMvEk6d0inzaRRDmkF/WPT70YLQt9u0ocmo2kD+PdNs1N
         Vo/YXHKt82SjEp8luaD5LSJjeAC6NEE0FWWuGo6AoeQWTnvOSAyM0cIhY33A84gMxSV8
         O7vYpjYE9etEHxpVJfBPSwIQT3+OxmnKWYYlMJPaUcdNe6nlpD8+uhASusKnSJGQ+poQ
         qmxq2GZkqAGwrihmS95Jg6FvOHOITqEASK13yQU4Caolfxh57M4kpxdyAgHtflM6NQTr
         6D9o6wgOqH9LnfK6p2LHGd1Mvpn831LeXJp+wwQ3VN4soGwU5qLmzqD7r9/Npa1HWq+V
         oJWg==
X-Gm-Message-State: AOAM532qzO9JdSXp7zd/69SQljpAPT5Tm/oJBWsasCLrkipxPKyHI/bK
        gH9y0A/3/S2xrXVJrl1u+H5D/5L0Xbo=
X-Google-Smtp-Source: ABdhPJzxjXJ5osulnsQXJKY4c84SVvDzbZ9FTcMzN4o77vtquipjYBZld2ff7zEctW5ZHgVhRm5o3w==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr24616313wrd.329.1612870328075;
        Tue, 09 Feb 2021 03:32:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k205sm4295141wmf.23.2021.02.09.03.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:32:07 -0800 (PST)
Message-Id: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.git.1612651937.gitgitgadget@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 11:32:02 +0000
Subject: [PATCH v2 0/4] Optimization batch 7: use file basenames to guide rename detection
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-6[1].

This series uses file basenames in a basic fashion to guide rename
detection.

Changes since v1:

 * Significant edits to the commit messages to make them explain the basic
   idea better and (hopefully) prevent misunderstandings.
 * Add a commit at the end that updates the documentation and includes a new
   testcase
 * Modify the code to make it clearer that it can already handle using a
   different score for basename comparison similarity, even if we don't use
   that ability yet (see below)

Changes not yet included -- I need input about what is wanted:

 * Stolee suggested not creating a separate score for basename comparisons,
   at least not yet. Junio suggested it may be prudent to use a higher score
   for that than whatever -M option the user provided for normal
   comparisons...but didn't suggest whether it should be a separate
   user-specified option, or some kind of weighted average of the -M option
   and MAX_SCORE (e.g. use 60% if -M is 50%, or use 80% if -M is 75%). I
   tweaked the code to make it clearer that it already is able to handle
   such a score difference, but I'm not sure what whether we want an
   automatically computed higher value or a user-controlled possibly higher
   value.

[1] https://lore.kernel.org/git/xmqqlfc4byt6.fsf@gitster.c.googlers.com/ [2]
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf

Elijah Newren (4):
  diffcore-rename: compute basenames of all source and dest candidates
  diffcore-rename: complete find_basename_matches()
  diffcore-rename: guide inexact rename detection based on basenames
  gitdiffcore doc: mention new preliminary step for rename detection

 Documentation/gitdiffcore.txt |  15 +++
 diffcore-rename.c             | 185 +++++++++++++++++++++++++++++++++-
 t/t4001-diff-rename.sh        |  24 +++++
 3 files changed, 220 insertions(+), 4 deletions(-)


base-commit: 7ae9460d3dba84122c2674b46e4339b9d42bdedd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-843%2Fnewren%2Fort-perf-batch-7-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-843/newren/ort-perf-batch-7-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/843

Range-diff vs v1:

 1:  377a4a39fa86 ! 1:  381a45d239bb diffcore-rename: compute basenames of all source and dest candidates
     @@ Commit message
          diffcore-rename: compute basenames of all source and dest candidates
      
          We want to make use of unique basenames to help inform rename detection,
     -    so that more likely pairings can be checked first.  Add a new function,
     +    so that more likely pairings can be checked first.  (src/moduleA/foo.txt
     +    and source/module/A/foo.txt are likely related if there are no other
     +    'foo.txt' files among the deleted and added files.)  Add a new function,
          not yet used, which creates a map of the unique basenames within
          rename_src and another within rename_dst, together with the indices
          within rename_src/rename_dst where those basenames show up.  Non-unique
          basenames still show up in the map, but have an invalid index (-1).
      
     +    This function was inspired by the fact that in real world repositories,
     +    most renames often do not involve a basename change.  Here are some
     +    sample repositories and the percentage of their historical renames (as of
     +    early 2020) that did not involve a basename change:
     +      * linux: 76%
     +      * gcc: 64%
     +      * gecko: 79%
     +      * webkit: 89%
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
 2:  5fb4493247ff ! 2:  dcd0175229aa diffcore-rename: complete find_basename_matches()
     @@ Commit message
          sufficiently similar, we record the rename; if not, we include those
          files in the more exhaustive matrix comparison.
      
     +    This means we are adding a set of preliminary additional comparisons,
     +    but for each file we only compare it with at most one other file.  For
     +    example, if there was a include/media/device.h that was deleted and a
     +    src/module/media/device.h that was added, and there were no other
     +    device.h files added or deleted between the commits being compared,
     +    then these two files would be compared in the preliminary step.
     +
     +    This commit does not yet actually employ this new optimization, it
     +    merely adds a function which can be used for this purpose.  The next
     +    commit will do the necessary plumbing to make use of it.
     +
          Note that this optimization might give us different results than without
          the optimization, because it's possible that despite files with the same
          basename being sufficiently similar to be considered a rename, there's
          an even better match between files without the same basename.  I think
     -    that is okay for four reasons: (1) That seems somewhat unlikely in
     -    practice, (2) it's easy to explain to the users what happened if it does
     -    ever occur (or even for them to intuitively figure out), and (3) as the
     -    next patch will show it provides such a large performance boost that
     -    it's worth the tradeoff.  Reason (4) takes a full paragraph to
     +    that is okay for four reasons: (1) it's easy to explain to the users
     +    what happened if it does ever occur (or even for them to intuitively
     +    figure out), (2) as the next patch will show it provides such a large
     +    performance boost that it's worth the tradeoff, and (3) it's somewhat
     +    unlikely that despite having unique matching basenames that other files
     +    serve as better matches.  Reason (4) takes a full paragraph to
          explain...
      
          If the previous three reasons aren't enough, consider what rename
     @@ Commit message
          basename and are sufficiently similar to be considered a rename, mark
          them as such without comparing the two to all other rename candidates.
      
     -    We do not use this heuristic together with either break or copy
     -    detection.  The point of break detection is to say that filename
     -    similarity does not imply file content similarity, and we only want to
     -    know about file content similarity.  The point of copy detection is to
     -    use more resources to check for additional similarities, while this is
     -    an optimization that uses far less resources but which might also result
     -    in finding slightly fewer similarities.  So the idea behind this
     -    optimization goes against both of those features, and will be turned off
     -    for both.
     -
     -    Note that this optimization is not yet effective in any situation, as
     -    the function is still unused.  The next commit will hook it into the
     -    code so that it is used when rename detection is wanted, but neither
     -    copy nor break detection are.
     -
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diffcore-rename.c ##
 3:  1d941c35076e ! 3:  ce2173aa1fb7 diffcore-rename: guide inexact rename detection based on basenames
     @@ Commit message
      
          Make use of the new find_basename_matches() function added in the last
          two patches, to find renames more rapidly in cases where we can match up
     -    files based on basenames.
     +    files based on basenames.  As a quick reminder (see the last two commit
     +    messages for more details), this means for example that
     +    docs/extensions.txt and docs/config/extensions.txt are considered likely
     +    renames if there are no 'extensions.txt' files elsewhere among the added
     +    and deleted files, and if a similarity check confirms they are similar,
     +    then they are marked as a rename without looking for a better similarity
     +    match among other files.  This is a behavioral change, as covered in
     +    more detail in the previous commit message.
     +
     +    We do not use this heuristic together with either break or copy
     +    detection.  The point of break detection is to say that filename
     +    similarity does not imply file content similarity, and we only want to
     +    know about file content similarity.  The point of copy detection is to
     +    use more resources to check for additional similarities, while this is
     +    an optimization that uses far less resources but which might also result
     +    in finding slightly fewer similarities.  So the idea behind this
     +    optimization goes against both of those features, and will be turned off
     +    for both.
      
          For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
          performance work; instrument with trace2_region_* calls", 2020-10-28),
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +		remove_unneeded_paths_from_src(want_copies);
      +		trace2_region_leave("diff", "cull after exact", options->repo);
      +	} else {
     ++		/* Determine minimum score to match basenames */
     ++		int min_basename_score = (int)(5*minimum_score + 0*MAX_SCORE)/5;
     ++
      +		/*
      +		 * Cull sources:
      +		 *   - remove ones involved in renames (found via exact match)
     @@ diffcore-rename.c: void diffcore_rename(struct diff_options *options)
      +
      +		/* Utilize file basenames to quickly find renames. */
      +		trace2_region_enter("diff", "basename matches", options->repo);
     -+		rename_count += find_basename_matches(options, minimum_score,
     ++		rename_count += find_basename_matches(options,
     ++						      min_basename_score,
      +						      rename_src_nr);
      +		trace2_region_leave("diff", "basename matches", options->repo);
      +
 -:  ------------ > 4:  a0e75d8cd6bd gitdiffcore doc: mention new preliminary step for rename detection

-- 
gitgitgadget
