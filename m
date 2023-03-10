Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C96C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCJQtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCJQr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 11:47:57 -0500
X-Greylist: delayed 614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 08:45:47 PST
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBE1912C
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1678465713;
        bh=nVJw3wMoyy08AxLVxJ1ewoL5sXfqOnnbeN+TkIOw1BA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rgf8bSIZNV50mDHi1h85DDOU/4jBYjlolg2/vbqufg9KcZ1tW53Iibv44DcrzPC90
         2y2TcgS7zHTt4AI69r7O1KSPOod5NjpGIVXDm7V5mmBufBeQEC9VjW1ymCecWRkCRs
         etFO+laC1rVPFk7bEQnFs6yVkaf/yVjiM5Ge0uUEF72WBe/OLfSxuBQVVLB03muU5s
         DxrtYbQMkYrsJlnTxaY3kv7LXcYMUnxDlVfUO9vGx/JZT5Xiept3+dYveIdRuSEHoB
         Q8xMh90jndzI5lqEVux8Ai4WT3p7bBKCvhy9b6mjd+47tfFxrkiyAqFSL8p5cRFrzH
         UYe2BAdLFJhHg==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id D948910E5DF; Fri, 10 Mar 2023 11:28:33 -0500 (EST)
Received: by angela.localdomain (Postfix, from userid 1000)
        id 5AD59DF90E; Fri, 10 Mar 2023 11:28:33 -0500 (EST)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] hooks--pre-push.sample: identify branch point
In-Reply-To: <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
Organization: Debian
References: <20230309220405.219212-1-anarcat@debian.org>
 <CAMP44s2=qzmF1Odc_auCaKQmTBYD53YYtaJv_LGwvoFDmTxPSA@mail.gmail.com>
Date:   Fri, 10 Mar 2023 11:28:33 -0500
Message-ID: <87356ctvta.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-03-09 17:22:55, Felipe Contreras wrote:
> Hi Antoine,
>
> On Thu, Mar 9, 2023 at 4:34=E2=80=AFPM Antoine Beaupr=C3=A9 <anarcat@debi=
an.org> wrote:
>
>> https://stackoverflow.com/a/71193866/1174784
>>
>> There are currently a whopping twenty-five answers to that question in
>> that thread, and I'm hoping the community here will have a more
>> definitive answer to this question. I have picked the answer that uses
>> the least possible external commands, but it still uses a `tail -1`
>> which I'm somewhat unhappy about. I have thought of using
>> `--max-count` for this instead, but I understand that probably does
>> the equivalent of a `head -n` *and* it's applied before `--reverse`,
>> so there's not other way to do this.
>
> I spent an inordinate amount of time trying to answer that question a
> decade ago, and my conclusion after trying every possible combination
> is that it's simply not possible. Every solution at the end of the day
> will be a hack that can be broken with a corner case. It has already
> been discussed in this mailing list [1], and nobody found a solution.

That's what I have gathered from reading through that Stack Overflow
thread as well.

> That's why I wrote a patch to implement a branch@{tail} helper to show
> an auxiliary ref to the beginning of the branch. I don't think I ever
> sent it to the mailing list, as my patches are rarely merged, but I'm
> sure I have it somewhere.

That would be interesting for the world to see, I bet, if only as a
future reference to avoid other people trying to bang their head on the
problem the same way. :)

> The other solution I thought of was adding an update-branch hook that
> could be run every time a branch is updated, and then the hook would
> update the branch tail reference [2]. As expected, that patch wasn't
> merged either.

That seems like a major change in workflow though, adding basically a
new ref for each branch, right?

> It's interesting how we keep coming back to the same problems; right
> now there's a discussion in the git-users mailing list precisely about
> the same topic: how to find the branch point, in particular so `git
> name-rev` shows the correct branch a commit belongs to (which is
> otherwise just a bad guess).

Well, it's a need people certainly seem to have. :)

I feel we are letting perfection be the enemy of good here. No, there
are no solutions that work for the general case, you always find a
corner case that breaks it. But what if we could have a simple solution
that works for *most* cases and then *fails* gracefully for the corner
cases?

In the case of the pre-push hook, specifically, we don't absolutely need
something completely rock solid; if your branches are a mess of merges
and cherry-picks and cross merges, yes, it might get confused but it's
not like it's going to lose a commit or something. The worse case is
that it's going to miss *checking* a commit and for this case it's not
satisfying, but it's also not data loss.

> FWIW my motivation at the time was to prove Mercurial users wrong
> regarding features that they have and Git doesn't, I contended that
> Mercurial named branches (aka commit labels) were not necessary, and
> everything they achieved could be achieved in Git through different
> means. That turned out to be untrue, as there is one thing Mercurial
> can do that Git can't: show the precise point a branch started from.

I have given up on Mercurial a long, long time ago. It's extremely rare
that I find myself in such a situation and typically, there various
hacks that answer the need without going into too much complexity.

The only reason I raise the issue here is because I wasn't satisfied
hardcoding "master" (or main, for that matter) in the hook because I
wanted a more generic answer. I suspect many people could be perfectly
fine with hardcoding that in their hook or, failing that, with the
incomplete heuristic I am proposing.

Or they could even have a per-branch .git/config entry to map the branch
to an upstream branch, and *that* could even "default" to "main" or
whatever that setting is called now. :)

A.
