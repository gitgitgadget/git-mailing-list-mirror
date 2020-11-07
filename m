Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D7C388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92D02087E
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXiHcizZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgKGTjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 14:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGTjw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 14:39:52 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F49C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 11:39:51 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id n2so1176596ooo.8
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 11:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWOIrMvfOLcS8QFibG6LhIfY9K2/lkJp9oA9sYd/BAM=;
        b=eXiHcizZfmjuJ0LNKOtySz3hEDtEQj5QDfBzUHqJ0Z3VfsCoE2EHUXIwvtRkeurbL0
         x8sYqOzgcfIkfkXC2Lx/x9VIdZuSw+BVKvsOf2hXtBfqNvVr909fuQycwXIG8v2UsQRe
         lbidj1RUzIrFnOF06ZK0mqWqQaWI4Gm5GprZZQDYB/yjkoSzP+94YB+lXvFJ/3cYW4Zw
         0kI4LW5A0RMV5nwqBHPCUlljQ29S1LnxowkhEiZXhKwQkHYQeqc3PVLbwPBR0hWhrF/2
         swIg3Kh/cABOxGwOxwR+pfNxL/nhAm2C0oWBWtiWc2DbEvY/0WBo4ZCNOACeHdiG9mbC
         bwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWOIrMvfOLcS8QFibG6LhIfY9K2/lkJp9oA9sYd/BAM=;
        b=AJOIEzrzXrB+GBHHFuypSh3SjFD9b5WxMHeJApJ59PkLdNkM0MPnmgBXW6mbAbVww5
         8qFrgh/NJxSPJ9AE1B+UlOkLTE68Bbc/DgOoqr4pZZozqySndk4JAX4EdSbiSLKyVGQL
         LyJNU1azrPPaMZ9Tv+hJ546+b73j6cyd2BmGonLWPMtoL6meeZ8FjdBpOmpqfavvo6kG
         mxEGxnAJNppN3GNa4MPozjqNLEh77PvdiTYqIDcFBRflrIYOBqSMeC3llC14YbXsEEwz
         B/FPQsViphCftam+5n4FewSMRmh80u4QA0Gx5eEriYZd75eqW9ta38OmtQAYe09u9kQ9
         YuRA==
X-Gm-Message-State: AOAM5305A2ZHlttZfLkY8Nuc41xkPiy7jMPCbFMr3pM48kNtBp8EIUoi
        1xJOtl+XG5KiXqi1YrklIjh3nxIOVIUVPdvZSxs=
X-Google-Smtp-Source: ABdhPJwsfPEW8CmkVxw0rJxRrtTZ8eqy+cxWhm2qOQTd8OJxpnlmEeDW0/TBAwBJu8hWspTxqMquFN+RJBGmT9BJdXw=
X-Received: by 2002:a4a:b308:: with SMTP id m8mr5279567ooo.7.1604777990437;
 Sat, 07 Nov 2020 11:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com> <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com>
In-Reply-To: <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Nov 2020 11:39:39 -0800
Message-ID: <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 7, 2020 at 7:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/7/20 1:06 AM, Elijah Newren wrote:
> > Hi Derrick,
> >
> > On Tue, Nov 3, 2020 at 8:36 AM Elijah Newren <newren@gmail.com> wrote:
> >> All that said, for testing either branch you just need to first set
> >> pull.twohead=ort in your git config (see
> >> https://lore.kernel.org/git/61217a83bd7ff0ce9016eb4df9ded4fdf29a506c.1604360734.git.gitgitgadget@gmail.com/),
> >> or, if running regression tests, set GIT_TEST_MERGE_ALGORITHM=ort.
> >
> > I probably also should have mentioned that merge-ort does not (yet?)
> > heed merge.renames configuration setting; it always detects renames.
> > I know you run with merge.renames=false, so you won't quite get an
> > apples-to-apples comparison.  However, part of my point was I wanted
> > to make renames fast enough that they could be left turned on, even
> > for the large scale repos, so I'm very interested in your experience.
> > If you need an escape hatch, though, just put a "return 1" at the top
> > of detect_and_process_renames() to turn it off.
> >
> > Oh, and I went through and re-merged all the merge commits in the
> > linux kernel and found a bug in merge-ort while doing that (causing it
> > to die, not to merge badly).  I'm kind of surprised that none of my
> > testcases triggered that failure earlier; if you're testing it out,
> > you might want to update to get the fix (commit 067e5c1a38,
> > "merge-ort: fix bug with cached_target_names not being initialized in
> > redos", 2020-11-06).
>
> I did manage to do some testing to see what happens with
> a large repo under a small sparse-checkout. And using
> trace2, I was able to see that your code is being exercised.
> Unfortunately, I didn't see any performance improvement, and
> that is likely due to needing to expand the index entirely
> when checking out the merge commit.
>
> Is there a command to construct a merge commit without
> actually checking it out? That would reduce the time spent
> expanding the index, which would allow your algorithm to
> really show its benefits!

Wow, very interesting.  I am working on a --remerge-diff option for
log, which implies -p and is similar to -c or --cc in that it makes
merge commits show a diff, but which in particular remerges the two
parent commits complete with conflict markers and such and then diffs
the merge commit against that intermediate remerge.  That's a case
that constructs a merge commit without ever touching the index (or
working tree)...but there's no equivalent comparison point for
merge-recursive.  So, it doesn't provide something to compare against
(and while the code can be used I don't actually have a --remerge-diff
option yet -- it just hardcodes the behavior on if wanted or not), so
I'm not sure if you'd be interested in it.  If you are, let me know
though, and I'll send details.

However, I'm really surprised here, because merge-recursive always
reads and writes the index too (the index is the basis for its whole
algorithm).  In fact, merge-recursive always reads the index at least
*twice* (it unconditionally discards and re-reads the index), so you
must have some kind of specialized tweaking of merge-recursive if it
somehow avoids a full index read/write.  In order to do an
apples-to-apples comparison, we'd need to make those same tweaks to
merge-ort, but I don't have a clue what kind of tweaks you've made
here.  So, some investigation points:

*1*. Could you give me the accumulated times from the trace2_regions
so we can verify where the time is spent?  The 'summarize-perf' script
at the toplevel of the repo in my ort branch might be helpful for
this; just prefix any git command with that script and it accumulates
the trace2 region times and prints them out.  For example, I could run
'summarize-perf git merge --no-edit B^0' or 'summarize-perf test-tool
fast-rebase --onto HEAD ca76bea9 myfeature'.  Here's an example:

=== BEGIN OUTPUT ===
$ /home/newren/floss/git/summarize-perf test-tool fast-rebase --onto
HEAD 4703d9119972bf586d2cca76ec6438f819ffa30e hwmon-updates
Rebasing fd8bdb23b91876ac1e624337bb88dc1dcc21d67e...
Done.
Accumulated times:
    0.031 : <unmeasured> ( 3.2%)
    0.837 : 35 : label:incore_nonrecursive
       0.003 : <unmeasured> ( 0.4%)
       0.476 : 41 : ..label:collect_merge_info
          0.001 : <unmeasured> ( 0.2%)
          0.475 : 41 : ....label:traverse_trees
       0.298 : 41 : ..label:renames
          0.015 : <unmeasured> ( 5.1%)
          0.280 : 41 : ....label:regular renames
             0.036 : <unmeasured> (12.7%)
             0.244 : 6 : ......label:diffcore_rename
                0.001 : <unmeasured> ( 0.4%)
                0.078 : 6 : ........label:dir rename setup
                0.055 : 6 : ........label:basename matches
                0.051 : 6 : ........label:exact renames
                0.031 : 6 : ........label:write back to queue
                0.017 : 6 : ........label:setup
                0.009 : 6 : ........label:cull basename
                0.003 : 6 : ........label:cull exact
          0.002 : 35 : ....label:directory renames
          0.001 : 35 : ....label:process renames
       0.052 : 35 : ..label:process_entries
          0.001 : <unmeasured> ( 1.7%)
          0.033 : 35 : ....label:processing
          0.017 : 35 : ....label:process_entries setup
             0.001 : <unmeasured> ( 5.8%)
             0.008 : 35 : ......label:plist copy
             0.008 : 35 : ......label:plist sort
             0.000 : 35 : ......label:plist grow
          0.001 : 35 : ....label:finalize
       0.005 : 35 : ..label:merge_start
          0.001 : <unmeasured> (18.8%)
          0.004 : 34 : ....label:reset_maps
          0.000 : 35 : ....label:sanity checks
          0.000 : 1 : ....label:allocate/init
       0.003 : 6 : ..label:reset_maps
    0.035 : 1 : label:do_write_index
/home/newren/floss/linux-stable/.git/index.lock
    0.034 : 1 : label:checkout
       0.034 : <unmeasured> (99.9%)
       0.000 : 1 : ..label:Filtering content
    0.009 : 1 : label:do_read_index .git/index
    0.000 : 1 : label:write_auto_merge
    0.000 : 1 : label:record_unmerged
Estimated measurement overhead (.010 ms/region-measure * 679):
0.006790000000000001
Timing including forking:  0.960 (0.013 additional seconds)
=== END OUTPUT ===
This was a run that took just under 1s (and was a hot-cache case; I
had just done the same rebase before to warm the caches), and the
combination of index/working tree bits (everything at and after
do_write_index in the output) was 0.035+0.034+0.009+0+0=0.078 seconds,
corresponding to just over 8.1% of overall time.  I'm curious where
that lands for your repository testcase; if the larger time ends up
somewhere under the indented label:incore_nonrecursive region, then
it's due to something other than index reading/updating/writing.

*2*. If it really is due to index reading/updating/writing, then index
handling in merge-ort is confined to two functions: checkout() and
record_unmerged_index_entries().  Both functions aren't too long, and
neither one calls into any other function within merge-ort.c.
(Further, checkout() is a near copy of code from merge_working_tree()
in builtin/checkout.c, or at least a copy of that function from a year
or so ago.)  As such, it's possible you can go in and make whatever
special tweaks you have for partial index reading/writing to those
functions.

I'm curious to hear back more on this.

Elijah
