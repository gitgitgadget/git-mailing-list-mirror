Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04BA1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 01:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbeHSEyu (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 00:54:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41874 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHSEyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 00:54:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id h1-v6so7861185uao.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKrxUqsXh8F25YTvwMETc78zPz7hV/EYU61c0AY+nEI=;
        b=u6Shq5bXmZZAWnQowlR2/TLpw/1Coy7YGK79vi5BMJYztR3Fke8RtLfAyZvWDEO61+
         egfI154c2m1iw9U05frt3vJZl2EjfPgRfbaNhtJjXLi8lznbLO22v+JQtvMdOFEvRdCU
         d7VAcQ+TzZQqBYBBqaFXUmf1727C2PJkZ/kvoH7JwyYT7o/Of5pKYYDGa8D+Ga542Lwl
         X020dRUJAoBbqe66ACbRl8A1vuY4WIj1wTbdFeaJrxLFoVqSThYPiBcp2fVNYBS43hdc
         dMD9OcMuob9a1eApGPbYWnMTUUXIOtzNaBu83YT+b5tOfAmURRPskbHdNE6uXiZbc3iU
         n9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKrxUqsXh8F25YTvwMETc78zPz7hV/EYU61c0AY+nEI=;
        b=alCiWUgOwH9st09CXFdlHr1RUt/IHWlqFjbasb2RBPxEYM2iNTtEgcZyH3EpxUghoy
         mrdAr0rAFdbiK+OMoEqb+4AISMPVOlz/dRz/aGWvGEiHO3mCQU+ZT3JqcpnsW3FiTBZu
         f8FAru5Rnl/HyawNSTLaZsFDSDrrGi3EuQ4WPCyMwyK/KBafoHTO413MKQ6pE/Rn54aQ
         pWvj/P4sQ6AQ95k5EL5OE3Po1jyGdV/WmthdvNLuMw6ngLNHG+iFiqpufYQgW0xe0Pop
         hQ8gRyy6fmgVZeyqxDPHEQv3Uf92EfThC5YwUJDWx3gxU5pJkteCr/0V3htGRz+Y/ca4
         QlFg==
X-Gm-Message-State: AOUpUlEEwpkvmheOybtPpQP3Ugn4PwGamlFlvQ6DHIw3SFPgFNgUu2Zv
        2p7ivUcYiwcZPpWzRcdhbxJOIXEfnXij3Bwv4SI=
X-Google-Smtp-Source: AA+uWPwJ0q9ksA65mSnetR9GmGkdZzZARSfFQUIursyutifBqptUmD21Lj/5gF8KH1lg0c3qk7YhgHLm+fn1cH0QAls=
X-Received: by 2002:a9f:22ed:: with SMTP id 100-v6mr26817857uan.116.1534643105567;
 Sat, 18 Aug 2018 18:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180724180122.29212-1-benpeart@microsoft.com>
 <20180816182653.15580-1-benpeart@microsoft.com> <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
 <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com>
In-Reply-To: <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 18:44:54 -0700
Message-ID: <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 5:41 AM Ben Peart <peartben@gmail.com> wrote:
> On 8/16/2018 2:37 PM, Duy Nguyen wrote:
> > On Thu, Aug 16, 2018 at 8:27 PM Ben Peart <Ben.Peart@microsoft.com> wrote:
> >>
> >> From: Ben Peart <Ben.Peart@microsoft.com>
> >>
> >> Skip merging the commit, updating the index and working directory if and
> >> only if we are creating a new branch via "git checkout -b <new_branch>."
> >> Any other checkout options will still go through the former code path.
> >>
> >> If sparse_checkout is on, require the user to manually opt in to this
> >> optimzed behavior by setting the config setting checkout.optimizeNewBranch
> >> to true as we will no longer update the skip-worktree bit in the index, nor
> >> add/remove files in the working directory to reflect the current sparse
> >> checkout settings.
> >>
> >> For comparison, running "git checkout -b <new_branch>" on a large repo takes:
> >>
> >> 14.6 seconds - without this patch
> >> 0.3 seconds - with this patch
> >
> > I still don't think we should do this. If you want lightning fast
> > branch creation, just use 'git branch'. From the timing breakdown you
> > shown in the other thread it looks like sparse checkout still takes
> > seconds, which could be optimized (or even excluded, I mentioned this
> > too). And split index (or something similar if you can't use it) would
> > give you saving across the board. There is still one idea Elijah gave
> > me that should further lower traverse_trees()  cost.
> >
>
> We have investigated some of these already - split index ended up
> slowing things down more than it sped them up do to the higher compute
> costs.  Sparse checkout we've already optimized significantly - limiting
> the patterns we accept so that we can do the lookup via a hashmap
> instead of the robust pattern matching.  We will continue to look for
> other optimizations and appreciate any and all ideas!
>
> In the end, this optimization makes a huge performance improvement by
> avoiding doing a lot of work that isn't necessary.  Taking a command
> from 14+ seconds to sub-second is just too much of a win for us to ignore.
>
> > But anyway, it's not my call. I'll stop here.

It's even less of my call, but since things seem to be stuck in
what-should-we-do state (as per Junio's comments on this patch in the
last two "What's cooking" emails), and since Ben and Duy obviously
have opposite opinions on Ben's patch, let's see if I might be able to
help at all.  Here's my summary and my findings:

== The pain ==
- For repositories with a really large number of entries (500K as Ben
says), some operations are much slower than it feels like they should
be.
- This does not seem to be GFVS-specific in any way, I can duplicate
slowness with a simple git-bomb[1]-like repo that has a sparse
checkout pattern ignoring the "bomb" side.  (It has 1M+1 entries in
the index, and .git/info/sparse-checkout ignores the 1M so the working
copy only has 1 entry).  The timings on my repo for "git checkout -b
$NEWBRANCH" are almost exactly double what Ben reports he gets on
their repo.

[1] https://kate.io/blog/making-your-own-exploding-git-repos/

== Short term solutions ==
- Alternative git commands exist today to do a fast checkout of a new
branch in a huge repo.  I also get sub-second timings in my
even-bigger repo with this:
   git branch $NEWBRANCH && git symbolic-ref HEAD $NEWBRANCH
But I do understand that wrapping this into a script or executable
(git-fast-new-branch?) and asking users to use it is a usability
problem and an uphill battle.  (Sidenote: this isn't quite the same
operation; it's missing a reflog update.  The -m option to
symbolic-ref doesn't seem to help; I guess the fact that HEAD's
sha1sum is not changing is viewed as not an update?  However, that
could also be scripted around.)
- Ben's patch successfully drops the time for "git checkout -b
$NEWBRANCH" from 26+ seconds (in my cooked-up testcase) to sub-second
(in fact, under .1 seconds for me).  That's a _huge_ win.

== unpack_trees optimization notes ==
- Ben's patch is extremely focused.  It only affects "git checkout -b
$NEWBRANCH".  If someone runs "git branch $NEWBRANCH && git checkout
$NEWBRANCH", they get the old 26+ second timing.  They also suddenly
get the really long timing if they add any other flags or checkout a
commit that differs in only a single entry in the entire tree.  It
would be nice if we did general optimization for all issues rather
than just special casing such narrow cases.
- However, optimizing unpack_trees is hard.  It's really easy to get
lost trying to look at the code.  Time has been spent trying to
optimizing it.  Ben really likes the speedup factors of 2-3 that Duy
has produced.  But he's pessimistic we'll find enough to bridge the
gap for this case.  And he's worried about breaking unrelated stuff
due to the complexity of unpack_trees.
- Duy is pretty sure we can optimize unpack_trees in at least one more
way.  I've tried looking through the code and think there are others,
but then again I'm known to get lost and confused in unpack_trees.

== The patch ==
- Ben's patch only affects the "checkout -b $NEWBRANCH" case.  He
checks for it by looking for any other flag that would be a different
case, and using the old codepath if he finds any.
- This means there is a "giant list of checks" for this optimization,
and an ongoing maintenance burden because if anyone ever adds any
extra options, this optimization might suddenly break things if that
giant list of checks isn't updated.  Ben even added a comment to the
code hoping to help alert others who come along and add extra options:
+ /*
+ * If new checkout options are added, skip_merge_working_tree
+ * should be updated accordingly.
+ */

== Other notes ==
- In my cooked-up testcase, I also noticed that things like git add or
git status were slow in a repo with lots of index entries.  There may
be several other areas in need of performance boosts too.


== My opinions ==
- The performance wins are big enough that I can see why Ben is pushing this.
- I totally see Duy's point that more general optimizations would be
really nice.
- I really dislike the "giant list of checks" and the ongoing
maintenance burden it implies.

Overall, I have to side with Duy and say I don't think we should take
the patch as-is.  Since that'll be frustrating for Ben to hear, I've
tried to come up with some additional alternatives:

== Alternatives (both short and long term) ==
- Use the 'git branch $NEWBRANCH && git symbolic-ref HEAD $NEWBRANCH'
trick.  It's essentially just as fast (well, you exec git twice so
it's slightly slower, but it's close).  However, there's a difficult
get-it-to-the-users hurdle.
- Rewrite this patch so it instead does a very small set of checks at
the beginning of cmd_checkout(); e.g. check if argc == 3 and argv[1]
== "-b" and if so then perform the minimum operations needed to create
and checkout the new branch (maybe even calling in to cmd_branch() and
cmd_symbolic_ref() and calling some reflog update function).  Preface
it with a comment that it's a performance hack that might eventually
be able to go away.
- Look into the performance optimization(s) Duy mentioned.
- Other performance optimizations in unpack_trees(); it seems we have
an awful lot of loops over all cache entries, and it sure seems to me
like some of them could somehow be focused on just the things that are
changing instead of again checking everything.  Or maybe I'm wrong and
they're all needed.
- Possibly crazy idea for massive global performance win: modify how
the cache works so that it can have tree entries instead of just file
entries; make use of that with sparse checkouts (and partial clones?)
so that the cache only stores a tree when that entire tree is
"unwanted".  Suddenly, git status, git add, git checkout, etc., etc.
are all much faster.  merge needs some special work to operate,
though.


I'm potentially interested in eventually looking into and/or helping
with optimization work in this area.  I might even get more time to
work on git at $DAYJOB since sparse-checkouts/partial-clone/gvfs/etc.
all are looking more and more interesting as we have large repos that
are growing quickly (particularly as we consolidate many repos down to
fewer).  But they've said that such work won't take priority for
several months down the road for them, it's not yet clear how much
they'd sponsor vs. just want to see what existed and how we can use
it, and I'd kind of like to clear a few other things off my plate
first too (such as the merge-recursive rewrite).

Anyway, that's just my $0.02.  I hope something I said helps.

Elijah
