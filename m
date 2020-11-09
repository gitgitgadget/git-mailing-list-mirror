Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57636C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 12:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C911A206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 12:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPhrYPs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKIMag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgKIMag (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 07:30:36 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B077C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 04:30:36 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i18so8744423ots.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aOaynRuB9zDx05pQ7G9dI3ldf16xRu26HrEIZI5UZIY=;
        b=uPhrYPs4iBTius4IRhFGXV9J5klAQsdeltvSLllnl+oB+Gk0wvrXzHUHGtMWYgdir/
         toOPoB/gpvw8IAt+0jtd4j50EJFjsglZdxv6ilG5OVA3RYVS5h6Ewv3OKGPdlaoPPokD
         sPql/2fKHhJqzRuS5iidIzTZjIR4QoTJsOe0HE7DWw25j/1XZop6RjgEUGZgkqayPKeP
         nl7Y2J0W58QU8QM522nZBiw7CFA9jPjd5AVE3SYsn0EGxDkpy6kH4Y1/WspxHZzL7u00
         tpQtaZALOboko5kSTlzGbWqx9oXOfYRaWeLVPKCeSvlAPNnI37DKojTxNhAxWtJHHPmJ
         dg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aOaynRuB9zDx05pQ7G9dI3ldf16xRu26HrEIZI5UZIY=;
        b=MBB65K06+YVsxsSZ8eLe/1cjBT9W+JEV/BtksHLu7LLTSyYB9sZYW2jhcwO246rqMt
         ck1OxNHb2fdAh9cXzbnWWlUfMBpGG1SqpHN9GdoMcqGlMWIwmc21DtaASVUuwCQOflwv
         819rxx4950psInKg2rS1Cs3UlL3U51cRMJqjWxxDJP6MIbvnP1oOirqEvP3ZCB6QSNlc
         JKx90SbloQrg0kfjVuBH8rDvUjFpY3Q1j32cVQAlPcLWMRQJAKaKw+b+9AYc9Q00Qtjw
         p9I3SF0VsSawdO/kJDxked8yY2IMLdi+4fSzfMNlmcUNvLKo7PlpSrysJ4XLqjCKz/Ba
         QlAA==
X-Gm-Message-State: AOAM530N5AwXu4gn1ti53XzeJ6Daw9j74YvRowHnln5UvY0rhp38WVsw
        kJaJaV4qHsG45GF5VBO2CoJlleLGmLjmsA==
X-Google-Smtp-Source: ABdhPJwAKzOPLeg0yCqNCQSZVDYe7H6fzjyof1klsZdWKezE8iCY+TYvslPbvTJnt+e7j2yJn0qpTw==
X-Received: by 2002:a9d:1a6:: with SMTP id e35mr7466458ote.238.1604925034930;
        Mon, 09 Nov 2020 04:30:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4c4d:e1b4:c68c:c766? ([2600:1700:e72:80a0:4c4d:e1b4:c68c:c766])
        by smtp.gmail.com with UTF8SMTPSA id f124sm2423159oia.27.2020.11.09.04.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 04:30:33 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
 <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com>
 <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee5cb3fe-4983-deba-2dba-b11a74adfbde@gmail.com>
Date:   Mon, 9 Nov 2020 07:30:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2020 2:39 PM, Elijah Newren wrote:
> On Sat, Nov 7, 2020 at 7:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/7/20 1:06 AM, Elijah Newren wrote:
>>> Hi Derrick,
>>>
>>> On Tue, Nov 3, 2020 at 8:36 AM Elijah Newren <newren@gmail.com> wrote:
>>>> All that said, for testing either branch you just need to first set
>>>> pull.twohead=ort in your git config (see
>>>> https://lore.kernel.org/git/61217a83bd7ff0ce9016eb4df9ded4fdf29a506c.1604360734.git.gitgitgadget@gmail.com/),
>>>> or, if running regression tests, set GIT_TEST_MERGE_ALGORITHM=ort.
>>>
>>> I probably also should have mentioned that merge-ort does not (yet?)
>>> heed merge.renames configuration setting; it always detects renames.
>>> I know you run with merge.renames=false, so you won't quite get an
>>> apples-to-apples comparison.  However, part of my point was I wanted
>>> to make renames fast enough that they could be left turned on, even
>>> for the large scale repos, so I'm very interested in your experience.
>>> If you need an escape hatch, though, just put a "return 1" at the top
>>> of detect_and_process_renames() to turn it off.
>>>
>>> Oh, and I went through and re-merged all the merge commits in the
>>> linux kernel and found a bug in merge-ort while doing that (causing it
>>> to die, not to merge badly).  I'm kind of surprised that none of my
>>> testcases triggered that failure earlier; if you're testing it out,
>>> you might want to update to get the fix (commit 067e5c1a38,
>>> "merge-ort: fix bug with cached_target_names not being initialized in
>>> redos", 2020-11-06).
>>
>> I did manage to do some testing to see what happens with
>> a large repo under a small sparse-checkout. And using
>> trace2, I was able to see that your code is being exercised.
>> Unfortunately, I didn't see any performance improvement, and
>> that is likely due to needing to expand the index entirely
>> when checking out the merge commit.
>>
>> Is there a command to construct a merge commit without
>> actually checking it out? That would reduce the time spent
>> expanding the index, which would allow your algorithm to
>> really show its benefits!
> 
> Wow, very interesting.  I am working on a --remerge-diff option for
> log, which implies -p and is similar to -c or --cc in that it makes
> merge commits show a diff, but which in particular remerges the two
> parent commits complete with conflict markers and such and then diffs
> the merge commit against that intermediate remerge.  That's a case
> that constructs a merge commit without ever touching the index (or
> working tree)...but there's no equivalent comparison point for
> merge-recursive.  So, it doesn't provide something to compare against
> (and while the code can be used I don't actually have a --remerge-diff
> option yet -- it just hardcodes the behavior on if wanted or not), so
> I'm not sure if you'd be interested in it.  If you are, let me know
> though, and I'll send details.
> 
> However, I'm really surprised here, because merge-recursive always
> reads and writes the index too (the index is the basis for its whole
> algorithm).  In fact, merge-recursive always reads the index at least
> *twice* (it unconditionally discards and re-reads the index), so you
> must have some kind of specialized tweaking of merge-recursive if it
> somehow avoids a full index read/write.  In order to do an
> apples-to-apples comparison, we'd need to make those same tweaks to
> merge-ort, but I don't have a clue what kind of tweaks you've made
> here.  So, some investigation points:
> 
> *1*. Could you give me the accumulated times from the trace2_regions
> so we can verify where the time is spent?  The 'summarize-perf' script
> at the toplevel of the repo in my ort branch might be helpful for
> this; just prefix any git command with that script and it accumulates
> the trace2 region times and prints them out.  For example, I could run
> 'summarize-perf git merge --no-edit B^0' or 'summarize-perf test-tool
> fast-rebase --onto HEAD ca76bea9 myfeature'.  Here's an example:
> 
> === BEGIN OUTPUT ===
> $ /home/newren/floss/git/summarize-perf test-tool fast-rebase --onto
> HEAD 4703d9119972bf586d2cca76ec6438f819ffa30e hwmon-updates
> Rebasing fd8bdb23b91876ac1e624337bb88dc1dcc21d67e...
> Done.
> Accumulated times:
>     0.031 : <unmeasured> ( 3.2%)
>     0.837 : 35 : label:incore_nonrecursive
>        0.003 : <unmeasured> ( 0.4%)
>        0.476 : 41 : ..label:collect_merge_info
>           0.001 : <unmeasured> ( 0.2%)
>           0.475 : 41 : ....label:traverse_trees
>        0.298 : 41 : ..label:renames
>           0.015 : <unmeasured> ( 5.1%)
>           0.280 : 41 : ....label:regular renames
>              0.036 : <unmeasured> (12.7%)
>              0.244 : 6 : ......label:diffcore_rename
>                 0.001 : <unmeasured> ( 0.4%)
>                 0.078 : 6 : ........label:dir rename setup
>                 0.055 : 6 : ........label:basename matches
>                 0.051 : 6 : ........label:exact renames
>                 0.031 : 6 : ........label:write back to queue
>                 0.017 : 6 : ........label:setup
>                 0.009 : 6 : ........label:cull basename
>                 0.003 : 6 : ........label:cull exact
>           0.002 : 35 : ....label:directory renames
>           0.001 : 35 : ....label:process renames
>        0.052 : 35 : ..label:process_entries
>           0.001 : <unmeasured> ( 1.7%)
>           0.033 : 35 : ....label:processing
>           0.017 : 35 : ....label:process_entries setup
>              0.001 : <unmeasured> ( 5.8%)
>              0.008 : 35 : ......label:plist copy
>              0.008 : 35 : ......label:plist sort
>              0.000 : 35 : ......label:plist grow
>           0.001 : 35 : ....label:finalize
>        0.005 : 35 : ..label:merge_start
>           0.001 : <unmeasured> (18.8%)
>           0.004 : 34 : ....label:reset_maps
>           0.000 : 35 : ....label:sanity checks
>           0.000 : 1 : ....label:allocate/init
>        0.003 : 6 : ..label:reset_maps
>     0.035 : 1 : label:do_write_index
> /home/newren/floss/linux-stable/.git/index.lock
>     0.034 : 1 : label:checkout
>        0.034 : <unmeasured> (99.9%)
>        0.000 : 1 : ..label:Filtering content
>     0.009 : 1 : label:do_read_index .git/index
>     0.000 : 1 : label:write_auto_merge
>     0.000 : 1 : label:record_unmerged
> Estimated measurement overhead (.010 ms/region-measure * 679):
> 0.006790000000000001
> Timing including forking:  0.960 (0.013 additional seconds)
> === END OUTPUT ===
> This was a run that took just under 1s (and was a hot-cache case; I
> had just done the same rebase before to warm the caches), and the
> combination of index/working tree bits (everything at and after
> do_write_index in the output) was 0.035+0.034+0.009+0+0=0.078 seconds,
> corresponding to just over 8.1% of overall time.  I'm curious where
> that lands for your repository testcase; if the larger time ends up
> somewhere under the indented label:incore_nonrecursive region, then
> it's due to something other than index reading/updating/writing.
> 
> *2*. If it really is due to index reading/updating/writing, then index
> handling in merge-ort is confined to two functions: checkout() and
> record_unmerged_index_entries().  Both functions aren't too long, and
> neither one calls into any other function within merge-ort.c.
> (Further, checkout() is a near copy of code from merge_working_tree()
> in builtin/checkout.c, or at least a copy of that function from a year
> or so ago.)  As such, it's possible you can go in and make whatever
> special tweaks you have for partial index reading/writing to those
> functions.
> 
> I'm curious to hear back more on this.

I don't have a lot of time to dig into this right now, but here are
the stats for my rebases and merges with and without your option.

The first thing I notice for each is that there is a significant
amount of "unmeasured" time at the beginning of each, and that
could possibly be improved separately.

First, try a rebase forward and backward.

$ /_git/git/summarize-perf git rebase --onto to from test
Successfully rebased and updated refs/heads/test.
Accumulated times:
    8.511 : <unmeasured> (74.9%)
    1.331 : 1 : ......label:unpack_trees
       0.200 : <unmeasured> (15.1%)
       0.580 : 1 : ........label:traverse_trees
       0.403 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
       0.126 : 1 : ........label:check_updates
          0.126 : <unmeasured> (100.0%)
          0.000 : 1 : ..........label:Filtering content
       0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
       0.000 : 1 : ........label:fully_valid
    1.059 : 1 : ......label:do_write_index /_git/office/src/.git/index.lock
       0.930 : <unmeasured> (87.9%)
       0.128 : 1 : ........label:write/extension/cache_tree
    0.455 : 2 : ......label:fully_valid
    0.001 : 1 : ......label:traverse_trees
    0.000 : 1 : ......label:check_updates
Estimated measurement overhead (.010 ms/region-measure * 41): 0.00041000000000000005
Timing including forking: 11.382 (0.026 additional seconds)

$ /_git/git/summarize-perf git rebase --onto from to test
Successfully rebased and updated refs/heads/test.
Accumulated times:
    8.556 : <unmeasured> (75.2%)
    1.315 : 1 : ......label:unpack_trees
       0.197 : <unmeasured> (15.0%)
       0.580 : 1 : ........label:traverse_trees
       0.391 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
       0.126 : 1 : ........label:check_updates
          0.126 : <unmeasured> (100.0%)
          0.000 : 1 : ..........label:Filtering content
       0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
       0.000 : 1 : ........label:fully_valid
    1.071 : 1 : ......label:do_write_index /_git/office/src/.git/index.lock
       0.942 : <unmeasured> (88.0%)
       0.129 : 1 : ........label:write/extension/cache_tree
    0.431 : 2 : ......label:fully_valid
    0.001 : 1 : ......label:traverse_trees
    0.000 : 1 : ......label:check_updates
Estimated measurement overhead (.010 ms/region-measure * 41): 0.00041000000000000005
Timing including forking: 11.399 (0.026 additional seconds)

Then do the same with the ort strategy.

$ /_git/git/summarize-perf git -c pull.twohead=ort rebase --onto to from test
Successfully rebased and updated refs/heads/test.
Accumulated times:
    8.350 : <unmeasured> (73.2%)
    1.403 : 1 : ....label:checkout  
       0.000 : <unmeasured> ( 0.0%)
       1.403 : 1 : ......label:unpack_trees
          0.312 : <unmeasured> (22.3%)
          0.539 : 1 : ........label:traverse_trees
          0.401 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
          0.128 : 1 : ........label:check_updates
             0.128 : <unmeasured> (100.0%)
             0.000 : 1 : ..........label:Filtering content
          0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
          0.000 : 1 : ........label:fully_valid
    1.081 : 1 : ....label:do_write_index /_git/office/src/.git/index.lock
       0.951 : <unmeasured> (88.1%)
       0.129 : 1 : ......label:write/extension/cache_tree
    0.432 : 2 : ....label:fully_valid
    0.143 : 1 : ....label:do_read_index .git/index
       0.019 : <unmeasured> (13.1%)
       0.125 : 1 : label:read/extension/cache_tree
    0.004 : 1 : ....label:incore_nonrecursive
       0.001 : <unmeasured> (25.8%)
       0.002 : 1 : ......label:process_entries
          0.000 : <unmeasured> ( 2.6%)
          0.001 : 1 : ........label:finalize
          0.001 : 1 : ........label:process_entries setup
             0.000 : <unmeasured> ( 6.7%)
             0.001 : 1 : ..........label:plist sort
             0.000 : 1 : ..........label:plist copy
             0.000 : 1 : ..........label:plist grow
          0.000 : 1 : ........label:processing
       0.001 : 1 : ......label:collect_merge_info
          0.000 : <unmeasured> (35.3%)
          0.001 : 1 : ........label:traverse_trees
       0.000 : 1 : ......label:merge_start
          0.000 : <unmeasured> (42.3%)
          0.000 : 1 : ........label:allocate/init
          0.000 : 1 : ........label:sanity checks
       0.000 : 1 : ......label:renames 
    0.001 : 1 : ....label:traverse_trees
    0.000 : 1 : ....label:write_auto_merge
    0.000 : 1 : ....label:check_updates
    0.000 : 1 : ....label:record_unmerged
Estimated measurement overhead (.010 ms/region-measure * 56): 0.0005600000000000001
Timing including forking: 11.442 (0.027 additional seconds)

$ /_git/git/summarize-perf git -c pull.twohead=ort rebase --onto from to test
Successfully rebased and updated refs/heads/test.
Accumulated times:
    8.337 : <unmeasured> (73.2%)
    1.395 : 1 : ....label:checkout  
       0.000 : <unmeasured> ( 0.0%)
       1.395 : 1 : ......label:unpack_trees
          0.309 : <unmeasured> (22.1%)
          0.537 : 1 : ........label:traverse_trees
          0.403 : 1 : ........label:clear_ce_flags/0x00000000_0x02000000
          0.124 : 1 : ........label:check_updates
             0.124 : <unmeasured> (100.0%)
             0.000 : 1 : ..........label:Filtering content
          0.021 : 1 : ........label:clear_ce_flags/0x00080000_0x42000000
          0.000 : 1 : ........label:fully_valid
    1.084 : 1 : ....label:do_write_index /_git/office/src/.git/index.lock
       0.955 : <unmeasured> (88.1%)
       0.129 : 1 : ......label:write/extension/cache_tree
    0.436 : 2 : ....label:fully_valid
    0.137 : 1 : ....label:do_read_index .git/index
       0.013 : <unmeasured> ( 9.3%)
       0.125 : 1 : label:read/extension/cache_tree
    0.004 : 1 : ....label:incore_nonrecursive
       0.001 : <unmeasured> (24.5%)
       0.002 : 1 : ......label:process_entries
          0.000 : <unmeasured> ( 2.5%)
          0.001 : 1 : ........label:finalize
          0.001 : 1 : ........label:process_entries setup
             0.000 : <unmeasured> ( 6.5%)
             0.001 : 1 : ..........label:plist sort
             0.000 : 1 : ..........label:plist copy
             0.000 : 1 : ..........label:plist grow
          0.000 : 1 : ........label:processing
       0.001 : 1 : ......label:collect_merge_info
          0.000 : <unmeasured> (26.5%)
          0.001 : 1 : ........label:traverse_trees
       0.000 : 1 : ......label:merge_start
          0.000 : <unmeasured> (43.1%)
          0.000 : 1 : ........label:allocate/init
          0.000 : 1 : ........label:sanity checks
       0.000 : 1 : ......label:renames 
    0.001 : 1 : ....label:traverse_trees
    0.000 : 1 : ....label:write_auto_merge
    0.000 : 1 : ....label:check_updates
    0.000 : 1 : ....label:record_unmerged
Estimated measurement overhead (.010 ms/region-measure * 56): 0.0005600000000000001
Timing including forking: 11.418 (0.024 additional seconds)

And here are timings for a simple merge. Two files at root were changed in the
commits I made, but there are also some larger changes from the commit history.
These should all be seen as "this tree updated in one of the two, so take that
tree".

$ git reset --hard test2 && /_git/git/summarize-perf git merge test -m test
Merge made by the 'recursive' strategy.
Accumulated times:
    2.647 : <unmeasured> (48.6%)
    1.384 : 1 : ..label:unpack_trees
       0.267 : <unmeasured> (19.3%)
       0.582 : 1 : ....label:traverse_trees
       0.391 : 1 : ....label:clear_ce_flags/0x00000000_0x02000000
       0.124 : 1 : ....label:check_updates
          0.124 : <unmeasured> (100.0%)
          0.000 : 1 : ......label:Filtering content
       0.021 : 1 : ....label:clear_ce_flags/0x00080000_0x42000000
       0.000 : 1 : ....label:fully_valid
    1.060 : 1 : ..label:do_write_index /_git/office/src/.git/index.lock
       0.931 : <unmeasured> (87.9%)
       0.128 : 1 : ....label:write/extension/cache_tree
    0.226 : 1 : ..label:fully_valid 
    0.134 : 1 : ..label:do_read_index .git/index
       0.008 : <unmeasured> ( 5.8%)
       0.126 : 1 : label:read/extension/cache_tree
    0.001 : 1 : ..label:traverse_trees
    0.000 : 1 : ..label:check_updates
    0.000 : 1 : ..label:setup       
    0.000 : 1 : ..label:write back to queue
Estimated measurement overhead (.010 ms/region-measure * 20): 0.0002
Timing including forking:  5.466 (0.015 additional seconds)

$ git reset --hard test2 && /_git/git/summarize-perf git -c pull.twohead=ort merge test -m test
Merge made by the 'ort' strategy.
Accumulated times:
    2.531 : <unmeasured> (49.1%)
    1.328 : 1 : ..label:checkout    
       0.000 : <unmeasured> ( 0.0%)
       1.328 : 1 : ....label:unpack_trees
          0.228 : <unmeasured> (17.2%)
          0.566 : 1 : ......label:traverse_trees
          0.388 : 1 : ......label:clear_ce_flags/0x00000000_0x02000000
          0.125 : 1 : ......label:check_updates
             0.125 : <unmeasured> (100.0%)
             0.000 : 1 : ........label:Filtering content
          0.021 : 1 : ......label:clear_ce_flags/0x00080000_0x42000000
          0.000 : 1 : ......label:fully_valid
    1.067 : 1 : ..label:do_write_index /_git/office/src/.git/index.lock
       0.938 : <unmeasured> (87.9%)
       0.129 : 1 : ....label:write/extension/cache_tree
    0.230 : 1 : ..label:fully_valid 
    0.002 : 1 : ..label:incore_recursive
       0.001 : <unmeasured> (22.3%)
       0.001 : 1 : ....label:collect_merge_info
          0.001 : <unmeasured> (60.2%)
          0.000 : 1 : ......label:traverse_trees
       0.001 : 1 : ....label:process_entries
          0.000 : <unmeasured> ( 2.8%)
          0.001 : 1 : ......label:finalize
          0.000 : 1 : ......label:process_entries setup
             0.000 : <unmeasured> ( 6.9%)
             0.000 : 1 : ........label:plist sort
             0.000 : 1 : ........label:plist copy
             0.000 : 1 : ........label:plist grow
          0.000 : 1 : ......label:processing
       0.000 : 1 : ....label:merge_start
          0.000 : <unmeasured> (50.0%)
          0.000 : 1 : ......label:allocate/init
          0.000 : 1 : ......label:sanity checks
       0.000 : 1 : ....label:renames   
    0.001 : 1 : ..label:traverse_trees
    0.000 : 1 : ..label:write_auto_merge
    0.000 : 1 : ..label:check_updates
    0.000 : 1 : ..label:setup       
    0.000 : 1 : ..label:display messages
    0.000 : 1 : ..label:write back to queue
    0.000 : 1 : ..label:record_unmerged
Estimated measurement overhead (.010 ms/region-measure * 36): 0.00036
Timing including forking:  5.174 (0.015 additional seconds)

Thanks,
-Stolee
