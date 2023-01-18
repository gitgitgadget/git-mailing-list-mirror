Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4290C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 22:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjARWS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjARWSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 17:18:17 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58164682
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 14:18:14 -0800 (PST)
Date:   Wed, 18 Jan 2023 22:18:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1674080292; x=1674339492;
        bh=J7PNWhwdmtbMiwEKln2mlUKPxon1devTn4BFXD0EcVs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CDc/ew5+5JTMWdDcTAv4PWGkYfDg4Buw2lh++bF/OkiICI0lr/MRxPcIch0Qd/6hk
         ADLNBDwf4phjZa4UMA6GYokKlzXVJJoYd6S72wXwM2uxLZdrYcTN7TPf0Pt+PyBNrN
         p1aSrm1GYCX9T5fnDUQKuH1BX1KL9DLvHIXVVW0UBWksSu2+WqL85AQQP6Pll8kpOk
         mPpvkUVJwd8IQonWESzpxN4B9s9nDaEywh0QjJX2sHJsPlmzVPjVKnvcYsn58cEEGg
         xVuVBDiHYZH6OTBghQhkKQsS5grjqb0xqfL5Aad4Em48SGJ2Z2PhVFh7hcQeYUHhUh
         N1IMEnptHH2hA==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Message-ID: <20230118221745.wovefwx6vhcm3zzk@phi>
In-Reply-To: <xmqqo7r0ijdv.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <20230109173227.29264-1-jacobabel@nullpo.dev> <20230109173227.29264-4-jacobabel@nullpo.dev> <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk> <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/14 07:09PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> >> =09git worktree add --orphan -b topic main
> >> =09git worktree add --orphan -B topic main
> >
> > I am hesitant to add these as they break away from the syntax used in
> > `git switch` and `git checkout`.
>
> Not that I care too deeply, but doesn't it introduce end-user
> confusion if we try to be compatible with "git checkout --orphan
> <branch>", while allowing this to be compatible with the default
> choice of the branch name done by "git worktree add"?  "--orphan" in
> "git checkout" behaves similar to "-b|-B" in that it always wants a
> name, but "git worktree add" wants to make it optional.

Yes. I think it's a fairly minor degree of confusion but I agree that it ad=
ds
potentially unneeded confusion.

>
> By the way "--orphan" in checkout|switch wants to take a name for
> itself, e.g.
>
> =09git checkout --orphan $name [$commit]
> =09git checkout -b $name [$commit]
> =09git checkout -B $name [$commit]
>
> so it is impossible to force their "--orphan" to rename an existing
> branch, which is probalby a design mistake we may want to fix.

Can you elaborate on what you mean by "rename an existing branch" here?

Do you mean like `git checkout --orphan $branchname` being able to convert =
an
existing branch into an orphan/unborn branch?

Also a small point but in an earlier thread [1], we made the decision to mo=
del
functionality on `git switch --orphan $branch` instead of
`git checkout --orphan $branch [$commit]`.

>
> In any case, as I said, I do not care too deeply which way you guys
> decide to go, because I think the whole "orphan" UI is a design
> mistake that instills a broken mental model to its users [*].

Understood.

>
> But let's wait a bit more to see which among
>
> (1) git worktree add [[--orphan] -b $branch] $path
>     This allows --orphan to act as a modifier to existing -b,
>
> (2) git worktree add [(--orphan|-b) $branch] $path
>     This allows --orphan to be another mode of -b, or
>
> (3) git worktree add [--orphan [$branch]|(-b $branch)] $path
>     This allows --orphan to default to $(basename $path)
>
> people prefer.
>

I'd personally argue that option 2 (the current behavior) is probably the
cleanest path forward as option 3 requires a bit of awkward code [2] and
`--orphan` is such an esoteric option that the user may only use it once or
twice in the life of a given repository, if that.

And eventually I'd like `git worktree add $path` to "just work" on a new/em=
pty
repository. However as things stand, there wasn't an easy way to do this wi=
thout
leading to potentially confusing behavior. It can be done, I just haven't t=
aken
the time to figure it out yet.

Once `git worktree add $path` "just works" (when creating the first branch =
in a
repo), I highly doubt anyone would use `--orphan` often enough to justify t=
he
use of shorthand options 1 or 3.

>
> [Footnote]
>
> * I am not saying that it is wrong or useless to keep an unrelated
>   history, especially one that records trees that have no relevance
>   to the main history like created with "switch --orphan", in the
>   same repository.  Allowing "git switch --orphan" to create such a
>   separate history in the same repository blurs the distinction.  It
>   would help newbies to form the right mental model if they start a
>   separate repository that the separate history originates in, and
>   pull from it to bootstrap the unrelated history in the local
>   repository.

Definitely agreed that `--orphan` is esoteric and probably should be avoide=
d by
most users where possible.

1. https://lore.kernel.org/git/CAPig+cSVzewXpk+eDSC-W-+Q8X_7ikZXXeSQbmpHBcd=
LCU5svw@mail.gmail.com/
2. https://lore.kernel.org/git/20230114224956.24801-1-jacobabel@nullpo.dev/

