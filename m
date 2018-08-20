Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDFC1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 13:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHTQz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 12:55:57 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34812 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeHTQz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 12:55:57 -0400
Received: by mail-qt0-f171.google.com with SMTP id m13-v6so16170093qth.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PrPIyPbaZY2IqRBvQ3bRo6KajtvmtIKoK4eQGCCrkuk=;
        b=kLDVjAzcfy4sLc66fbuUCWcTLe0MQ/B3L5AOwOTN5G9uB2Ot64YmPhLMYemCZ9e7Q0
         gZhgG2d1t/v1Wc1BWlQK7XUv7dwH7qgx3qhMHsYKq+JQ9lU9uk+1K7fFWTY4gFvkNF6o
         2vJe4ITZQUbC32tbfVm+V/Le2lTDDLZC1SqeqcSMFiqWHNHa8ppDQuunmKcJoRpSx6Fe
         BEvS0qIq9BoaIQbz5+9kZXCftNcBBAW0mj75SX7e7+3jSjqYzBbDnzdQRYGLCT7ML134
         i/RnCmHd+f4Ks0zdNu3XWlIXRe/K8cbu0NdGxT4E8hAmiHD1YGFXI5kdBQGS3c5NyiJi
         e/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PrPIyPbaZY2IqRBvQ3bRo6KajtvmtIKoK4eQGCCrkuk=;
        b=MH+U88lkTKHqPVk9+fw+/Qu/WLqc1xP2M4j/e9mm+ILprxheybJJxVJix/H7dRaC+A
         x39+F2f0XD9mbSDAyRPe+sIw9SFvEnnFxcJ2nT5ZJf0SDnQHcneejUF1D57L8GmaKKm+
         ccdIOWe3KtnpDO2ArmqytloevuRlyr7oQyNIa+a87KWldzX3XhpkgHGZh20HgdhMeh2O
         fB/YRZ8Z37kA1mqFeAOKRajquHQnfxiDSV7yWeoIFY2nel76ZYKXfJ7YfiJxS2vw2WZh
         0+rVpb1n03Xk5AVBk2/3MtKGTRCL8yeRgXP9eAox/R8Ym72oWJW/qio4gABrWANpwcho
         9ICQ==
X-Gm-Message-State: AOUpUlFdWodRdKztuEw0Lsbudp3M0bfhP7KU1+daHDyJcWTcNSvD2VdZ
        6rOr7/8nh1fzKL2580db1QQ=
X-Google-Smtp-Source: AA+uWPwa2kCSMsI4TLqYIm1uIPBSgOTqMQi7PscIEzj8FMB0UZ9co9j61WEVunTADwahjzS3xRoRTg==
X-Received: by 2002:a0c:87e5:: with SMTP id 34-v6mr40376505qvk.30.1534772414304;
        Mon, 20 Aug 2018 06:40:14 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m192-v6sm464759qke.71.2018.08.20.06.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 06:40:13 -0700 (PDT)
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com>
 <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com>
 <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f88299c5-1697-a7ef-87d6-69f5c19d5a68@gmail.com>
Date:   Mon, 20 Aug 2018 09:40:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/18/2018 9:44 PM, Elijah Newren wrote:
> On Fri, Aug 17, 2018 at 5:41 AM Ben Peart <peartben@gmail.com> wrote:
>> On 8/16/2018 2:37 PM, Duy Nguyen wrote:
>>> On Thu, Aug 16, 2018 at 8:27 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
>>>>
>>>> From: Ben Peart <Ben.Peart@microsoft.com>
>>>>
>>>> Skip merging the commit, updating the index and working directory if and
>>>> only if we are creating a new branch via "git checkout -b <new_branch>."
>>>> Any other checkout options will still go through the former code path.
>>>>
>>>> If sparse_checkout is on, require the user to manually opt in to this
>>>> optimzed behavior by setting the config setting checkout.optimizeNewBranch
>>>> to true as we will no longer update the skip-worktree bit in the index, nor
>>>> add/remove files in the working directory to reflect the current sparse
>>>> checkout settings.
>>>>
>>>> For comparison, running "git checkout -b <new_branch>" on a large repo takes:
>>>>
>>>> 14.6 seconds - without this patch
>>>> 0.3 seconds - with this patch
>>>
>>> I still don't think we should do this. If you want lightning fast
>>> branch creation, just use 'git branch'. From the timing breakdown you
>>> shown in the other thread it looks like sparse checkout still takes
>>> seconds, which could be optimized (or even excluded, I mentioned this
>>> too). And split index (or something similar if you can't use it) would
>>> give you saving across the board. There is still one idea Elijah gave
>>> me that should further lower traverse_trees()  cost.
>>>
>>
>> We have investigated some of these already - split index ended up
>> slowing things down more than it sped them up do to the higher compute
>> costs.  Sparse checkout we've already optimized significantly - limiting
>> the patterns we accept so that we can do the lookup via a hashmap
>> instead of the robust pattern matching.  We will continue to look for
>> other optimizations and appreciate any and all ideas!
>>
>> In the end, this optimization makes a huge performance improvement by
>> avoiding doing a lot of work that isn't necessary.  Taking a command
>> from 14+ seconds to sub-second is just too much of a win for us to ignore.
>>
>>> But anyway, it's not my call. I'll stop here.
> 
> It's even less of my call, but since things seem to be stuck in
> what-should-we-do state (as per Junio's comments on this patch in the
> last two "What's cooking" emails), and since Ben and Duy obviously
> have opposite opinions on Ben's patch, let's see if I might be able to
> help at all.  Here's my summary and my findings:
> 
> == The pain ==
> - For repositories with a really large number of entries (500K as Ben
> says), some operations are much slower than it feels like they should
> be.
> - This does not seem to be GFVS-specific in any way, I can duplicate
> slowness with a simple git-bomb[1]-like repo that has a sparse
> checkout pattern ignoring the "bomb" side.  (It has 1M+1 entries in
> the index, and .git/info/sparse-checkout ignores the 1M so the working
> copy only has 1 entry).  The timings on my repo for "git checkout -b
> $NEWBRANCH" are almost exactly double what Ben reports he gets on
> their repo.
> 
> [1] https://kate.io/blog/making-your-own-exploding-git-repos/
> 
> == Short term solutions ==
> - Alternative git commands exist today to do a fast checkout of a new
> branch in a huge repo.  I also get sub-second timings in my
> even-bigger repo with this:
>     git branch $NEWBRANCH && git symbolic-ref HEAD $NEWBRANCH
> But I do understand that wrapping this into a script or executable
> (git-fast-new-branch?) and asking users to use it is a usability
> problem and an uphill battle.  (Sidenote: this isn't quite the same
> operation; it's missing a reflog update.  The -m option to
> symbolic-ref doesn't seem to help; I guess the fact that HEAD's
> sha1sum is not changing is viewed as not an update?  However, that
> could also be scripted around.)
> - Ben's patch successfully drops the time for "git checkout -b
> $NEWBRANCH" from 26+ seconds (in my cooked-up testcase) to sub-second
> (in fact, under .1 seconds for me).  That's a _huge_ win.
> 
> == unpack_trees optimization notes ==
> - Ben's patch is extremely focused.  It only affects "git checkout -b
> $NEWBRANCH".  If someone runs "git branch $NEWBRANCH && git checkout
> $NEWBRANCH", they get the old 26+ second timing.  They also suddenly
> get the really long timing if they add any other flags or checkout a
> commit that differs in only a single entry in the entire tree.  It
> would be nice if we did general optimization for all issues rather
> than just special casing such narrow cases.
> - However, optimizing unpack_trees is hard.  It's really easy to get
> lost trying to look at the code.  Time has been spent trying to
> optimizing it.  Ben really likes the speedup factors of 2-3 that Duy
> has produced.  But he's pessimistic we'll find enough to bridge the
> gap for this case.  And he's worried about breaking unrelated stuff
> due to the complexity of unpack_trees.
> - Duy is pretty sure we can optimize unpack_trees in at least one more
> way.  I've tried looking through the code and think there are others,
> but then again I'm known to get lost and confused in unpack_trees.
> 
> == The patch ==
> - Ben's patch only affects the "checkout -b $NEWBRANCH" case.  He
> checks for it by looking for any other flag that would be a different
> case, and using the old codepath if he finds any.
> - This means there is a "giant list of checks" for this optimization,
> and an ongoing maintenance burden because if anyone ever adds any
> extra options, this optimization might suddenly break things if that
> giant list of checks isn't updated.  Ben even added a comment to the
> code hoping to help alert others who come along and add extra options:
> + /*
> + * If new checkout options are added, skip_merge_working_tree
> + * should be updated accordingly.
> + */
> 
> == Other notes ==
> - In my cooked-up testcase, I also noticed that things like git add or
> git status were slow in a repo with lots of index entries.  There may
> be several other areas in need of performance boosts too.
> 
> 
> == My opinions ==
> - The performance wins are big enough that I can see why Ben is pushing this.
> - I totally see Duy's point that more general optimizations would be
> really nice.
> - I really dislike the "giant list of checks" and the ongoing
> maintenance burden it implies.
> 
> Overall, I have to side with Duy and say I don't think we should take
> the patch as-is.  Since that'll be frustrating for Ben to hear, I've
> tried to come up with some additional alternatives:

Thank you for the thorough review and summary.  From my perspective, it 
is both fair and accurate.

This is a performance improvement we've been using for nearly 2 years 
[1] because the win is so significant in our case, it makes living with 
the maintenance burden worth while.  That said, in the past 2 years, 
there haven't been any new options added to the checkout command that 
required any maintenance but the possibility clearly does exist.

My purpose in pushing this patch to the mailing list is to improve git 
in general and to let others benefit from the performance improvement 
we've been enjoying. If the community doesn't feel like the risk/reward 
is worth it, then it shouldn't be accepted and I'm perfectly fine with that.

[1] 
https://github.com/git-for-windows/git/commit/0a64b9ae6df02d4df3e41227c43c4217a1a90bfa

> 
> == Alternatives (both short and long term) ==
> - Use the 'git branch $NEWBRANCH && git symbolic-ref HEAD $NEWBRANCH'
> trick.  It's essentially just as fast (well, you exec git twice so
> it's slightly slower, but it's close).  However, there's a difficult
> get-it-to-the-users hurdle.
> - Rewrite this patch so it instead does a very small set of checks at
> the beginning of cmd_checkout(); e.g. check if argc == 3 and argv[1]
> == "-b" and if so then perform the minimum operations needed to create
> and checkout the new branch (maybe even calling in to cmd_branch() and
> cmd_symbolic_ref() and calling some reflog update function).  Preface
> it with a comment that it's a performance hack that might eventually
> be able to go away.

I'm happy to do this if it would make the patch better/more acceptable 
to the community.

One other change I could do would be to address Duy's concern about the 
config option would be to remove that entirely.  That means those using 
sparse-checkout don't have the option of getting the performance win but 
the benefit is that there isn't any documentation or behavior changes 
that need to be made - things just get a lot faster if you happen to use 
the (rather common) "checkout -b" option.

If making these two changes would resolve the remaining concerns, I'm 
happy to make them and send another patch series.  If it will just 
result in another round of "I'm still not comfortable with this" then 
I'd rather spend my time elsewhere. :)

> - Look into the performance optimization(s) Duy mentioned.
> - Other performance optimizations in unpack_trees(); it seems we have
> an awful lot of loops over all cache entries, and it sure seems to me
> like some of them could somehow be focused on just the things that are
> changing instead of again checking everything.  Or maybe I'm wrong and
> they're all needed.

I am absolutely in favor of any performance optimizations that can be 
made in unpack_trees().  I am not very familiar with that code and only 
recently started digging in when I started my recent RFC/patch series to 
multi-thread it [2].  I'm extremely grateful for all the ideas and work 
that thread has triggered - to me, it's an example of open source 
software development at it's finest.

I'd never even thought of using the cache-tree to simplify the traversal 
in that way and am grateful others have and especially to Duy who backed 
it up with a great patch series (I started the work but he was a lot 
faster at getting working patches than I was!).  In my opinion, this was 
a much better solution than the complexity of multi-threading this 
complex piece of code (though that remains an option if it is still needed).

[2] 
https://public-inbox.org/git/20180718204458.20936-1-benpeart@microsoft.com/

> - Possibly crazy idea for massive global performance win: modify how
> the cache works so that it can have tree entries instead of just file
> entries; make use of that with sparse checkouts (and partial clones?)
> so that the cache only stores a tree when that entire tree is
> "unwanted".  Suddenly, git status, git add, git checkout, etc., etc.
> are all much faster.  merge needs some special work to operate,
> though.
> 

Not crazy at all!  It's something we've investigated and discussed 
several times over the past couple of years.  This is the largest 
potential optimization that I am aware of as it has the potential to 
dramatically speed up most git operations as they become O(what I care 
about) vs O(size of repo/tree) - especially when paired with partial clone.

The downside is pretty obvious, pulling this off means rewriting an 
awful lot of the code!  The index is central to so much of git and the 
assumption is everywhere that the index is simply a (global) array of 
cache entries to be looped through and manipulated at will.

There would be a lot of refactoring work, creating a new index 
abstraction API, updating the code to utilize it, then updating the 
internal representation of the index to optimize it around the concept 
of being sparse/partial.  Likely, we'd want/need a new on disk format 
that would support the new structures in an optimal way.  Finally, the 
various algorithms (like unpack_trees()) could be rewritten to take 
advantage of the sparseness.

Not something that can be taken on lightly - but certainly something 
that has huge potential to enable git to scale to much larger repos.

> 
> I'm potentially interested in eventually looking into and/or helping
> with optimization work in this area.  I might even get more time to
> work on git at $DAYJOB since sparse-checkouts/partial-clone/gvfs/etc.
> all are looking more and more interesting as we have large repos that
> are growing quickly (particularly as we consolidate many repos down to
> fewer).  But they've said that such work won't take priority for
> several months down the road for them, it's not yet clear how much
> they'd sponsor vs. just want to see what existed and how we can use
> it, and I'd kind of like to clear a few other things off my plate
> first too (such as the merge-recursive rewrite).
> 
> Anyway, that's just my $0.02.  I hope something I said helps.
> 
> Elijah
> 
