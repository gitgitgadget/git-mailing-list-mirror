Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55608C388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16AE20657
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBTJ3AZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgKITvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKITvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 14:51:40 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F779C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 11:51:39 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n11so10167402ota.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 11:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+4ExQSympGjEJ0cQibich3UVC2Sb4TPGbnMTdjjt+pg=;
        b=jBTJ3AZwGilrFOeRHdIOGXoz0Wl5zgl6XErxiD7byzl3ouQS/86u+uiK2wtTiDGnhR
         VvIqCsxzDjbe6LkG0Vns5wNr2d3gWbo512PuKs8RVoKNK4VAT7opDbPvounjdIXPzt2x
         MaC46oCYsujeRZGMdopOTgexVbPuID3gBjKOx9WMZu0eGCjMj7tU+yYqVHagLolxlpcZ
         XN3w0TLYiZT/Cq0+R8RC5ephFoAsst2Fikb84rONTIAE3dZLdAaGwbnKdeum7llDj9v7
         18C8yZZKw5dbbiwORlD/MWys7QyezmedpGWqiXlwm6RUR0PU7cgcGk1nfvcYrghRjUVq
         hlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4ExQSympGjEJ0cQibich3UVC2Sb4TPGbnMTdjjt+pg=;
        b=HMl3hD5Qcp5aIKwVONfTtS9/QtOQ9+RBhNBlcSn9r7kqWaZSn75rVGv3mA/ind95+c
         RBvygZ7+yuh8eid0zAtQ/JEA+0aouCo3eBlpGzXIe29fbBcc0dN6C41Hc525fcuFRDpf
         +1O3HK3FpSbZX+BOhIHYeV7erA85x11bltN/ADZznZG5pDNJAwZl68/VJTnOUwJv7sLZ
         sVzjNmFpMXEVs2iHNXGCLgCJXwuGCQ1VN288AbTLo9j4dmHONkhf8mFNq6Ll1D3KDeg4
         zudm1kreUz0eG2XUsdqqXQyTEIzy3lU8uIlq+gputVlxhCBz8f4U8IxT0XkcwUNZBVlF
         qhzQ==
X-Gm-Message-State: AOAM532HzQMmUhViu9pwDbhWFXCeC7VW9BBvWhJy+FimWKGre5jv76cm
        uHAdvLl3aE37PXeT130yubg=
X-Google-Smtp-Source: ABdhPJxhRv5rB7CHwJ2NjA+Ho7XvOax95pJJzykRPFinLduB9xb7Ggc/SDfQdcn8uKRRuxb2ddWGRg==
X-Received: by 2002:a05:6830:615:: with SMTP id w21mr11168973oti.126.1604951498191;
        Mon, 09 Nov 2020 11:51:38 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:d10d:26c3:9580:8dbb])
        by smtp.gmail.com with ESMTPSA id m23sm2744041otk.10.2020.11.09.11.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:51:37 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, git@jeffhostetler.com
References: <20201102204344.342633-1-newren@gmail.com>
 <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
 <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com>
 <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
 <ee5cb3fe-4983-deba-2dba-b11a74adfbde@gmail.com>
 <CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b33b42f-2939-6fec-ef01-892ac5a0f581@gmail.com>
Date:   Mon, 9 Nov 2020 14:51:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/20 12:13 PM, Elijah Newren wrote:> Actually, this was pretty enlightening.  I think I know about what's
> happening...
> 
> First, a few years ago, Ben said that merges in the Microsoft repos
> took about an hour[1]:
> "For the repro that I have been using this drops the merge time from ~1 hour to
> ~5 minutes and the unmerged entries goes down from ~40,000 to 1."
> The change he made to drop it that far was to turn off rename detection.
> 
> [1] https://lore.kernel.org/git/20180426205202.23056-1-benpeart@microsoft.com/
> 
> Keep that in mind, especially since your times are actually
> significantly less than 5 minutes...

Yes, the other thing to keep in mind is that this is
a Scalar repo with the default cone-mode sparse-checkout
of only the files at root. For this repo, that means that
there are only ~10 files actually present.

I wanted to remove any working directory updates/checks
from the performance check as possible.

>> $ /_git/git/summarize-perf git rebase --onto to from test
>> Successfully rebased and updated refs/heads/test.
>> Accumulated times:
>>     8.511 : <unmeasured> (74.9%)
> 
> Wild guess: This is setup_git_directory() loading your ~3 million entry index.

I think there is also some commit walking happening, but
it shouldn't be too much. 'from' and 'to' are not very
far away.

> Did you include two runs of recursive and two runs of ort just to show
> that the timings were stable and thus there wasn't warm or cold disk
> cache issues affecting things?  If so, good plan.  (If there was
> another reason, let me know; I missed it.)

For the rebase, I did "--onto to from test" and "--onto from to test"
to show both directions of the rebase. The merge I did twice for the
cache issues ;)

> .004s on label:incore_nonrecursive -- that's the actual merge
> operation.  This was a trivial rebase, and the merging took just 4
> milliseconds.  But the overall run took 11.442 seconds because working
> with 3M+ entries in the index just takes forever, and my code didn't
> touch any on-disk formats, certainly not the index format.
> 
> _All_ of my optimization work was on the merging piece, not the stuff
> outside.  But for what you're testing here, it appears to be
> irrelevant compared to the overhead.

OK, so since we already disable rename detection through config,
the machinery that you are changing is already fast with the old
algorithm in these trivial cases.

To actually show any benefits, we would need to disable rename
detection or use a larger change.
>> And here are timings for a simple merge. Two files at root were changed in the
>> commits I made, but there are also some larger changes from the commit history.
>> These should all be seen as "this tree updated in one of the two, so take that
>> tree".
> 
> Ahah!  That's a microsoft-specific optimization you guys made in the
> recursive strategy, yes? 

I'm not aware of any logic we have that's different from core Git.
The config we use [1] includes "merge.stat = false" and "merge.renames
= false" but otherwise seems to be using stock Git.

[1] https://github.com/microsoft/scalar/blob/1d7938d2df6921f7a3b4f3f1cce56a00929adc40/Scalar.Common/Maintenance/ConfigStep.cs#L100-L127

I'm CC'ing Jeff Hostetler to see if he knows anything about a custom
merge algorithm in microsoft/git.

> It does NOT exist in upstream git.  It's
> also one that is nearly incompatible with rename detection; it turns
> out you can only do that optimization in the face of rename detection
> if you do a HUGE amount of specialized work and tracking in order to
> determine when it's safe _despite_ needing to detect renames. 

Perhaps merge.renames=false is enough to trigger this logic already?

> I
> thought that optimization was totally incompatible with rename
> detection for a long time; I tried it a couple times while working on
> ort and watched it break all kinds of rename tests...but I eventually
> discovered some tricks involving a lot of work to be able to run that
> optimization.

I will try to keep this in mind.

> So, you aren't comparing upstream "recursive" to "ort", you're
> comparing a tweaked version of recursive, and one that is incompatible
> with how recursive's rename detection work.  In fact, just to be clear
> in case you go looking, I suspect that this tweak is to be found
> within unpack_trees.c (which recursive relies on heavily).
> 
> Further, you've set it up so there are only a few files changed after
> unpack_trees returns.
> 
> In total, you have: (1) turned off rename detection (most my
> optimizations are for improving this factor, meaning I can't show an
> advantage), (2) you took advantage of no rename detection to implement
> trivial-tree merges (thus killing the main second advantage my
> algorithm has), and (3) you are looking at a case with a tiny number
> of changes for the merge algorithm to process (thus killing a third
> optimization that removes quadratic performance).  Those are my three
> big optimizations, and you've made them all irrelevant.  In fact,
> you're in an area I would have been worried that ort would do _worse_
> than recursive.  I track an awful lot of things and there is overhead
> in checking and filling all that information in; if there are only a
> few entries to merge, then all that information was a waste to collect
> and ort might be slower than recursive.  But then again, that should
> be a case where both algorithms are "nearly instantaneous" (or would
> be if it weren't for your 3M+ index entry repo causing run_builtin()'s
> call to setup_git_directory() in git.c to take a huge amount of time
> before the builtin is even called.)

Thanks for your time isolating this case. I appreciate knowing exactly
which portions of the merge algorithm are being touched and which are
not.
> 5 seconds.  I do have to hand it to Ben and anyone else involved,
> though.  From 1 hour down to 5 seconds is pretty good, even if it was
> done by hacks (turning off rename detection, and then implementing
> trivial-tree merging that would have broken rename detection).  I
> suspect that whoever did that work might have found the unconditional
> discarding and re-reading of the index and fixed it as well?

As you can probably tell from my general confusion, I had nothing
to do with it. ;)

> Heh, yeah 0.002 seconds for ..label:incore_recursive.  Only 2
> milliseconds to create the actual merge tree.  That does suggest you
> might have fun with 'git log -p --remerge-diff'; if you can redo
> merges in 2 milliseconds, showing them in git log output is very
> reasonable.  :-)

Yeah, 'git merge-tree' is very fast for these cases, so I assumed
that something else was going on for that command.

> Could we have some fun, though?  What if you have some merge or rebase
> involving lots of changes, and you turn rename detection back on, and
> you disable that trivial-tree resolution optimization that breaks
> recursive's rename detection handling...and then compare recursive and
> ort?  (It might be easiest to just compare upstream recursive rather
> than the one with all the microsoft changes to make sure you undid
> whatever trivial tree handling work exists.)

I can try these kinds of cases, but it won't be today. I'm on kid duty
today, and answering emails in between running around with them.

> For example, my testcase in the linux kernel was finding a series of a
> few dozen patches I could rebase back to an older version, but
> tweaking the "older" version by renaming drivers/ -> pilots/ (with
> about 26K files under that directory, that meant about 26K renames).
> So, I got to see rebasing of dozens of real changes across a massive
> rename boundary -- and the massive rename boundary also guaranteed
> there were lots of entries for the merge algorithm to deal with.
> 
> In the end, though, 4 milliseconds for the rebase and 2 milliseconds
> for the merge, with the rest all being overhead of interfacing to the
> index and working tree actually seems pretty good to me.  I'm just
> curious if we can check how things work for more involved cases.

I'm definitely interested in identifying how your algorithm improves
over the previous cases, and perhaps re-enabling rename detection for
merges is enough of a benefit to justify the new one.

Eventually, I hope to actually engage with your patches in the form
of review. Just trying to build a mental model for what's going on
first.

Thanks,
-Stolee
