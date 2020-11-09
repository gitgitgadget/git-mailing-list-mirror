Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE6C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06D220897
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 17:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlwqkw5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgKIRNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 12:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIRNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 12:13:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D48C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 09:13:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id g19so9632437otp.13
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcSeql6AGwnJHWur2KSGns88msxW149aXx9wLd3CVcs=;
        b=dlwqkw5dDUzXy6bvcCuFBBsTvwThpow8Mv7TD2Fr6plpBwYi5Wk4IefotllHkv5Mcs
         lv7l1RLdR4VVBMUu+FcMDTWZq41+VzCJx2cEIyx6gV2hi/cr5CYJwbor3prL7LQsD7Hp
         p614+de1lyXmWG5mQ4+CzVPMeTfofFholMvRR/IW/xzqRZt8gfNH75HNgUk2+FKAOSLR
         h18hRd+bsv8zP0nSyNr/C/g+6eZj4dG5m1hA49rUj2ca6DhC0ACJ4mhWecKjeWQ7F97g
         LZb32SClMSX9yJWOINw6uy0u0fn9NT65rQGJQ5gqlpUirznZeUH37+2Ex80VAI3MV/DR
         UPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcSeql6AGwnJHWur2KSGns88msxW149aXx9wLd3CVcs=;
        b=BiXT/Syj5nzcdRVuiAAXe/L1MyUdMfm9svOB8VOjC6T2rAXwkxVa6wyBvef9K9bsgP
         qB627dtYTeLMrG2LbbGZz4czfe2WvggSGab6BvgGZyl19/HpMYsS1mV4OZOOTXVKZXwP
         1okCh08jrN8sOZioqXKteY1Cy6dhjaomQ8gndyIVg6cNg4RIDsvCjqSfQJEToYdymQa0
         8H06KI3xrKz1TJyICBiPRBLQNF/cUqL3yabPBWb5rPC8ZMUfvFaBwXacB74rr1hmJy1u
         B1uZx0ubhoOtdfCb3PpFKUOxD4G8zsIjaIhl7POraDHQfCuIL3w53i/uTfc9fmIJg4rb
         XIrA==
X-Gm-Message-State: AOAM532I+hC6OilejriSDl9C8xsaaPKlKHyb8N0sZuInY3kWIKllPC4Q
        9YDzCWxLbpfGy/qKZItkOHNx30uohmHqPmImLy4=
X-Google-Smtp-Source: ABdhPJysmpz8KE0lPae+4qVlYn+5cR7Z2WaJpYUXZsxNfqQ4GrESE76DIprH26vQPBzi3bMtl3fg031rpmsU1FCt41c=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr11547243otp.316.1604942015544;
 Mon, 09 Nov 2020 09:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
 <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com> <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
 <ee5cb3fe-4983-deba-2dba-b11a74adfbde@gmail.com>
In-Reply-To: <ee5cb3fe-4983-deba-2dba-b11a74adfbde@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Nov 2020 09:13:24 -0800
Message-ID: <CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Mon, Nov 9, 2020 at 4:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/7/2020 2:39 PM, Elijah Newren wrote:

> > *1*. Could you give me the accumulated times from the trace2_regions
> > so we can verify where the time is spent?  The 'summarize-perf' script
> > at the toplevel of the repo in my ort branch might be helpful for
> > this; just prefix any git command with that script and it accumulates
> > the trace2 region times and prints them out.  For example, I could run
> > 'summarize-perf git merge --no-edit B^0' or 'summarize-perf test-tool
> > fast-rebase --onto HEAD ca76bea9 myfeature'.  Here's an example:
> >
> > === BEGIN OUTPUT ===
> > $ /home/newren/floss/git/summarize-perf test-tool fast-rebase --onto
> > HEAD 4703d9119972bf586d2cca76ec6438f819ffa30e hwmon-updates
> > Rebasing fd8bdb23b91876ac1e624337bb88dc1dcc21d67e...
> > Done.
> > Accumulated times:
> >     0.031 : <unmeasured> ( 3.2%)
> >     0.837 : 35 : label:incore_nonrecursive
> >        0.003 : <unmeasured> ( 0.4%)
> >        0.476 : 41 : ..label:collect_merge_info
> >           0.001 : <unmeasured> ( 0.2%)
> >           0.475 : 41 : ....label:traverse_trees
> >        0.298 : 41 : ..label:renames
> >           0.015 : <unmeasured> ( 5.1%)
> >           0.280 : 41 : ....label:regular renames
> >              0.036 : <unmeasured> (12.7%)
> >              0.244 : 6 : ......label:diffcore_rename
> >                 0.001 : <unmeasured> ( 0.4%)
> >                 0.078 : 6 : ........label:dir rename setup
> >                 0.055 : 6 : ........label:basename matches
> >                 0.051 : 6 : ........label:exact renames
> >                 0.031 : 6 : ........label:write back to queue
> >                 0.017 : 6 : ........label:setup
> >                 0.009 : 6 : ........label:cull basename
> >                 0.003 : 6 : ........label:cull exact
> >           0.002 : 35 : ....label:directory renames
> >           0.001 : 35 : ....label:process renames
> >        0.052 : 35 : ..label:process_entries
> >           0.001 : <unmeasured> ( 1.7%)
> >           0.033 : 35 : ....label:processing
> >           0.017 : 35 : ....label:process_entries setup
> >              0.001 : <unmeasured> ( 5.8%)
> >              0.008 : 35 : ......label:plist copy
> >              0.008 : 35 : ......label:plist sort
> >              0.000 : 35 : ......label:plist grow
> >           0.001 : 35 : ....label:finalize
> >        0.005 : 35 : ..label:merge_start
> >           0.001 : <unmeasured> (18.8%)
> >           0.004 : 34 : ....label:reset_maps
> >           0.000 : 35 : ....label:sanity checks
> >           0.000 : 1 : ....label:allocate/init
> >        0.003 : 6 : ..label:reset_maps
> >     0.035 : 1 : label:do_write_index
> > /home/newren/floss/linux-stable/.git/index.lock
> >     0.034 : 1 : label:checkout
> >        0.034 : <unmeasured> (99.9%)
> >        0.000 : 1 : ..label:Filtering content
> >     0.009 : 1 : label:do_read_index .git/index
> >     0.000 : 1 : label:write_auto_merge
> >     0.000 : 1 : label:record_unmerged
> > Estimated measurement overhead (.010 ms/region-measure * 679):
> > 0.006790000000000001
> > Timing including forking:  0.960 (0.013 additional seconds)
> > === END OUTPUT ===
> > This was a run that took just under 1s (and was a hot-cache case; I
> > had just done the same rebase before to warm the caches), and the
> > combination of index/working tree bits (everything at and after
> > do_write_index in the output) was 0.035+0.034+0.009+0+0=0.078 seconds,
> > corresponding to just over 8.1% of overall time.  I'm curious where
> > that lands for your repository testcase; if the larger time ends up
> > somewhere under the indented label:incore_nonrecursive region, then
> > it's due to something other than index reading/updating/writing.
> >
> > *2*. If it really is due to index reading/updating/writing, then index
> > handling in merge-ort is confined to two functions: checkout() and
> > record_unmerged_index_entries().  Both functions aren't too long, and
> > neither one calls into any other function within merge-ort.c.
> > (Further, checkout() is a near copy of code from merge_working_tree()
> > in builtin/checkout.c, or at least a copy of that function from a year
> > or so ago.)  As such, it's possible you can go in and make whatever
> > special tweaks you have for partial index reading/writing to those
> > functions.
> >
> > I'm curious to hear back more on this.
>
> I don't have a lot of time to dig into this right now, but here are
> the stats for my rebases and merges with and without your option.

Actually, this was pretty enlightening.  I think I know about what's
happening...

First, a few years ago, Ben said that merges in the Microsoft repos
took about an hour[1]:
"For the repro that I have been using this drops the merge time from ~1 hour to
~5 minutes and the unmerged entries goes down from ~40,000 to 1."
The change he made to drop it that far was to turn off rename detection.

[1] https://lore.kernel.org/git/20180426205202.23056-1-benpeart@microsoft.com/

Keep that in mind, especially since your times are actually
significantly less than 5 minutes...

> The first thing I notice for each is that there is a significant
> amount of "unmeasured" time at the beginning of each, and that
> could possibly be improved separately.
>
> First, try a rebase forward and backward.
>
> $ /_git/git/summarize-perf git rebase --onto to from test
> Successfully rebased and updated refs/heads/test.
> Accumulated times:
>     8.511 : <unmeasured> (74.9%)

Wild guess: This is setup_git_directory() loading your ~3 million entry index.

>     1.331 : 1 : ......label:unpack_trees
>        0.200 : <unmeasured> (15.1%)
>        0.580 : 1 : ........label:traverse_trees
>        0.403 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
>        0.126 : 1 : ........label:check_updates
>           0.126 : <unmeasured> (100.0%)
>           0.000 : 1 : ..........label:Filtering content
>        0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
>        0.000 : 1 : ........label:fully_valid
>     1.059 : 1 : ......label:do_write_index /_git/office/src/.git/index.lock
>        0.930 : <unmeasured> (87.9%)
>        0.128 : 1 : ........label:write/extension/cache_tree
>     0.455 : 2 : ......label:fully_valid
>     0.001 : 1 : ......label:traverse_trees
>     0.000 : 1 : ......label:check_updates
> Estimated measurement overhead (.010 ms/region-measure * 41): 0.00041000000000000005
> Timing including forking: 11.382 (0.026 additional seconds)
>
> $ /_git/git/summarize-perf git rebase --onto from to test
> Successfully rebased and updated refs/heads/test.
> Accumulated times:
>     8.556 : <unmeasured> (75.2%)
>     1.315 : 1 : ......label:unpack_trees
>        0.197 : <unmeasured> (15.0%)
>        0.580 : 1 : ........label:traverse_trees
>        0.391 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
>        0.126 : 1 : ........label:check_updates
>           0.126 : <unmeasured> (100.0%)
>           0.000 : 1 : ..........label:Filtering content
>        0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
>        0.000 : 1 : ........label:fully_valid
>     1.071 : 1 : ......label:do_write_index /_git/office/src/.git/index.lock
>        0.942 : <unmeasured> (88.0%)
>        0.129 : 1 : ........label:write/extension/cache_tree
>     0.431 : 2 : ......label:fully_valid
>     0.001 : 1 : ......label:traverse_trees
>     0.000 : 1 : ......label:check_updates
> Estimated measurement overhead (.010 ms/region-measure * 41): 0.00041000000000000005
> Timing including forking: 11.399 (0.026 additional seconds)

Did you include two runs of recursive and two runs of ort just to show
that the timings were stable and thus there wasn't warm or cold disk
cache issues affecting things?  If so, good plan.  (If there was
another reason, let me know; I missed it.)

> Then do the same with the ort strategy.
>
> $ /_git/git/summarize-perf git -c pull.twohead=ort rebase --onto to from test
> Successfully rebased and updated refs/heads/test.
> Accumulated times:
>     8.350 : <unmeasured> (73.2%)
>     1.403 : 1 : ....label:checkout
>        0.000 : <unmeasured> ( 0.0%)
>        1.403 : 1 : ......label:unpack_trees
>           0.312 : <unmeasured> (22.3%)
>           0.539 : 1 : ........label:traverse_trees
>           0.401 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
>           0.128 : 1 : ........label:check_updates
>              0.128 : <unmeasured> (100.0%)
>              0.000 : 1 : ..........label:Filtering content
>           0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
>           0.000 : 1 : ........label:fully_valid
>     1.081 : 1 : ....label:do_write_index /_git/office/src/.git/index.lock
>        0.951 : <unmeasured> (88.1%)
>        0.129 : 1 : ......label:write/extension/cache_tree
>     0.432 : 2 : ....label:fully_valid
>     0.143 : 1 : ....label:do_read_index .git/index
>        0.019 : <unmeasured> (13.1%)
>        0.125 : 1 : label:read/extension/cache_tree
>     0.004 : 1 : ....label:incore_nonrecursive
>        0.001 : <unmeasured> (25.8%)
>        0.002 : 1 : ......label:process_entries
>           0.000 : <unmeasured> ( 2.6%)
>           0.001 : 1 : ........label:finalize
>           0.001 : 1 : ........label:process_entries setup
>              0.000 : <unmeasured> ( 6.7%)
>              0.001 : 1 : ..........label:plist sort
>              0.000 : 1 : ..........label:plist copy
>              0.000 : 1 : ..........label:plist grow
>           0.000 : 1 : ........label:processing
>        0.001 : 1 : ......label:collect_merge_info
>           0.000 : <unmeasured> (35.3%)
>           0.001 : 1 : ........label:traverse_trees
>        0.000 : 1 : ......label:merge_start
>           0.000 : <unmeasured> (42.3%)
>           0.000 : 1 : ........label:allocate/init
>           0.000 : 1 : ........label:sanity checks
>        0.000 : 1 : ......label:renames
>     0.001 : 1 : ....label:traverse_trees
>     0.000 : 1 : ....label:write_auto_merge
>     0.000 : 1 : ....label:check_updates
>     0.000 : 1 : ....label:record_unmerged
> Estimated measurement overhead (.010 ms/region-measure * 56): 0.0005600000000000001
> Timing including forking: 11.442 (0.027 additional seconds)

.004s on label:incore_nonrecursive -- that's the actual merge
operation.  This was a trivial rebase, and the merging took just 4
milliseconds.  But the overall run took 11.442 seconds because working
with 3M+ entries in the index just takes forever, and my code didn't
touch any on-disk formats, certainly not the index format.

_All_ of my optimization work was on the merging piece, not the stuff
outside.  But for what you're testing here, it appears to be
irrelevant compared to the overhead.

> $ /_git/git/summarize-perf git -c pull.twohead=ort rebase --onto from to test
> Successfully rebased and updated refs/heads/test.
> Accumulated times:
>     8.337 : <unmeasured> (73.2%)
>     1.395 : 1 : ....label:checkout
>        0.000 : <unmeasured> ( 0.0%)
>        1.395 : 1 : ......label:unpack_trees
>           0.309 : <unmeasured> (22.1%)
>           0.537 : 1 : ........label:traverse_trees
>           0.403 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
>           0.124 : 1 : ........label:check_updates
>              0.124 : <unmeasured> (100.0%)
>              0.000 : 1 : ..........label:Filtering content
>           0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
>           0.000 : 1 : ........label:fully_valid
>     1.084 : 1 : ....label:do_write_index /_git/office/src/.git/index.lock
>        0.955 : <unmeasured> (88.1%)
>        0.129 : 1 : ......label:write/extension/cache_tree
>     0.436 : 2 : ....label:fully_valid
>     0.137 : 1 : ....label:do_read_index .git/index
>        0.013 : <unmeasured> ( 9.3%)
>        0.125 : 1 : label:read/extension/cache_tree
>     0.004 : 1 : ....label:incore_nonrecursive
>        0.001 : <unmeasured> (24.5%)
>        0.002 : 1 : ......label:process_entries
>           0.000 : <unmeasured> ( 2.5%)
>           0.001 : 1 : ........label:finalize
>           0.001 : 1 : ........label:process_entries setup
>              0.000 : <unmeasured> ( 6.5%)
>              0.001 : 1 : ..........label:plist sort
>              0.000 : 1 : ..........label:plist copy
>              0.000 : 1 : ..........label:plist grow
>           0.000 : 1 : ........label:processing
>        0.001 : 1 : ......label:collect_merge_info
>           0.000 : <unmeasured> (26.5%)
>           0.001 : 1 : ........label:traverse_trees
>        0.000 : 1 : ......label:merge_start
>           0.000 : <unmeasured> (43.1%)
>           0.000 : 1 : ........label:allocate/init
>           0.000 : 1 : ........label:sanity checks
>        0.000 : 1 : ......label:renames
>     0.001 : 1 : ....label:traverse_trees
>     0.000 : 1 : ....label:write_auto_merge
>     0.000 : 1 : ....label:check_updates
>     0.000 : 1 : ....label:record_unmerged
> Estimated measurement overhead (.010 ms/region-measure * 56): 0.0005600000000000001
> Timing including forking: 11.418 (0.024 additional seconds)

Ah, you included two copies for merge-ort too.  I'm guessing you did
that just to show there wasn't some cold cache issues or something and
that the runs showed consistent timings?


> And here are timings for a simple merge. Two files at root were changed in the
> commits I made, but there are also some larger changes from the commit history.
> These should all be seen as "this tree updated in one of the two, so take that
> tree".

Ahah!  That's a microsoft-specific optimization you guys made in the
recursive strategy, yes?  It does NOT exist in upstream git.  It's
also one that is nearly incompatible with rename detection; it turns
out you can only do that optimization in the face of rename detection
if you do a HUGE amount of specialized work and tracking in order to
determine when it's safe _despite_ needing to detect renames.  I
thought that optimization was totally incompatible with rename
detection for a long time; I tried it a couple times while working on
ort and watched it break all kinds of rename tests...but I eventually
discovered some tricks involving a lot of work to be able to run that
optimization.

So, you aren't comparing upstream "recursive" to "ort", you're
comparing a tweaked version of recursive, and one that is incompatible
with how recursive's rename detection work.  In fact, just to be clear
in case you go looking, I suspect that this tweak is to be found
within unpack_trees.c (which recursive relies on heavily).

Further, you've set it up so there are only a few files changed after
unpack_trees returns.

In total, you have: (1) turned off rename detection (most my
optimizations are for improving this factor, meaning I can't show an
advantage), (2) you took advantage of no rename detection to implement
trivial-tree merges (thus killing the main second advantage my
algorithm has), and (3) you are looking at a case with a tiny number
of changes for the merge algorithm to process (thus killing a third
optimization that removes quadratic performance).  Those are my three
big optimizations, and you've made them all irrelevant.  In fact,
you're in an area I would have been worried that ort would do _worse_
than recursive.  I track an awful lot of things and there is overhead
in checking and filling all that information in; if there are only a
few entries to merge, then all that information was a waste to collect
and ort might be slower than recursive.  But then again, that should
be a case where both algorithms are "nearly instantaneous" (or would
be if it weren't for your 3M+ index entry repo causing run_builtin()'s
call to setup_git_directory() in git.c to take a huge amount of time
before the builtin is even called.)


> $ git reset --hard test2 && /_git/git/summarize-perf git merge test -m test
> Merge made by the 'recursive' strategy.
> Accumulated times:
>     2.647 : <unmeasured> (48.6%)
>     1.384 : 1 : ..label:unpack_trees
>        0.267 : <unmeasured> (19.3%)
>        0.582 : 1 : ....label:traverse_trees
>        0.391 : 1 : ....label:clear_ce_flags/0x00000000_0x02000000
>        0.124 : 1 : ....label:check_updates
>           0.124 : <unmeasured> (100.0%)
>           0.000 : 1 : ......label:Filtering content
>        0.021 : 1 : ....label:clear_ce_flags/0x00080000_0x42000000
>        0.000 : 1 : ....label:fully_valid
>     1.060 : 1 : ..label:do_write_index /_git/office/src/.git/index.lock
>        0.931 : <unmeasured> (87.9%)
>        0.128 : 1 : ....label:write/extension/cache_tree
>     0.226 : 1 : ..label:fully_valid
>     0.134 : 1 : ..label:do_read_index .git/index
>        0.008 : <unmeasured> ( 5.8%)
>        0.126 : 1 : label:read/extension/cache_tree
>     0.001 : 1 : ..label:traverse_trees
>     0.000 : 1 : ..label:check_updates
>     0.000 : 1 : ..label:setup
>     0.000 : 1 : ..label:write back to queue
> Estimated measurement overhead (.010 ms/region-measure * 20): 0.0002
> Timing including forking:  5.466 (0.015 additional seconds)

5 seconds.  I do have to hand it to Ben and anyone else involved,
though.  From 1 hour down to 5 seconds is pretty good, even if it was
done by hacks (turning off rename detection, and then implementing
trivial-tree merging that would have broken rename detection).  I
suspect that whoever did that work might have found the unconditional
discarding and re-reading of the index and fixed it as well?

> $ git reset --hard test2 && /_git/git/summarize-perf git -c pull.twohead=ort merge test -m test
> Merge made by the 'ort' strategy.
> Accumulated times:
>     2.531 : <unmeasured> (49.1%)
>     1.328 : 1 : ..label:checkout
>        0.000 : <unmeasured> ( 0.0%)
>        1.328 : 1 : ....label:unpack_trees
>           0.228 : <unmeasured> (17.2%)
>           0.566 : 1 : ......label:traverse_trees
>           0.388 : 1 : ......label:clear_ce_flags/0x00000000_0x02000000
>           0.125 : 1 : ......label:check_updates
>              0.125 : <unmeasured> (100.0%)
>              0.000 : 1 : ........label:Filtering content
>           0.021 : 1 : ......label:clear_ce_flags/0x00080000_0x42000000
>           0.000 : 1 : ......label:fully_valid
>     1.067 : 1 : ..label:do_write_index /_git/office/src/.git/index.lock
>        0.938 : <unmeasured> (87.9%)
>        0.129 : 1 : ....label:write/extension/cache_tree
>     0.230 : 1 : ..label:fully_valid
>     0.002 : 1 : ..label:incore_recursive
>        0.001 : <unmeasured> (22.3%)
>        0.001 : 1 : ....label:collect_merge_info
>           0.001 : <unmeasured> (60.2%)
>           0.000 : 1 : ......label:traverse_trees
>        0.001 : 1 : ....label:process_entries
>           0.000 : <unmeasured> ( 2.8%)
>           0.001 : 1 : ......label:finalize
>           0.000 : 1 : ......label:process_entries setup
>              0.000 : <unmeasured> ( 6.9%)
>              0.000 : 1 : ........label:plist sort
>              0.000 : 1 : ........label:plist copy
>              0.000 : 1 : ........label:plist grow
>           0.000 : 1 : ......label:processing
>        0.000 : 1 : ....label:merge_start
>           0.000 : <unmeasured> (50.0%)
>           0.000 : 1 : ......label:allocate/init
>           0.000 : 1 : ......label:sanity checks
>        0.000 : 1 : ....label:renames
>     0.001 : 1 : ..label:traverse_trees
>     0.000 : 1 : ..label:write_auto_merge
>     0.000 : 1 : ..label:check_updates
>     0.000 : 1 : ..label:setup
>     0.000 : 1 : ..label:display messages
>     0.000 : 1 : ..label:write back to queue
>     0.000 : 1 : ..label:record_unmerged
> Estimated measurement overhead (.010 ms/region-measure * 36): 0.00036
> Timing including forking:  5.174 (0.015 additional seconds)

Heh, yeah 0.002 seconds for ..label:incore_recursive.  Only 2
milliseconds to create the actual merge tree.  That does suggest you
might have fun with 'git log -p --remerge-diff'; if you can redo
merges in 2 milliseconds, showing them in git log output is very
reasonable.  :-)


Could we have some fun, though?  What if you have some merge or rebase
involving lots of changes, and you turn rename detection back on, and
you disable that trivial-tree resolution optimization that breaks
recursive's rename detection handling...and then compare recursive and
ort?  (It might be easiest to just compare upstream recursive rather
than the one with all the microsoft changes to make sure you undid
whatever trivial tree handling work exists.)

For example, my testcase in the linux kernel was finding a series of a
few dozen patches I could rebase back to an older version, but
tweaking the "older" version by renaming drivers/ -> pilots/ (with
about 26K files under that directory, that meant about 26K renames).
So, I got to see rebasing of dozens of real changes across a massive
rename boundary -- and the massive rename boundary also guaranteed
there were lots of entries for the merge algorithm to deal with.


In the end, though, 4 milliseconds for the rebase and 2 milliseconds
for the merge, with the rest all being overhead of interfacing to the
index and working tree actually seems pretty good to me.  I'm just
curious if we can check how things work for more involved cases.
