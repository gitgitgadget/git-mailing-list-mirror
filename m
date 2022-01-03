Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C5C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 06:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiACGwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 01:52:00 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:38731 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiACGv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 01:51:59 -0500
Received: by mail-pj1-f47.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so31531493pjf.3
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 22:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvOgWdR6LemSIn2AEtqcAt6pH6aihDrORQ6SDKR18Pc=;
        b=4Vv1AMVUFNlf1aGj4krmwCfFDm8jNJa8rs9M0ISEZSqPlbHRwkIPIlE9a/7VToYtjd
         LkhxhWrKvjihT8PcWAhLzpYyv4I184ddTC/Oi6lvPix8aHjer/YLBEFAOkzXyeN8De76
         irkcZrsOPPWbHIEBS9vc1W8xz69BunBF3NukwhnJrJrYBvvvt5+aB+f65oRMq4/6Kx1c
         Df90DWD52iUMDem1UHIYHxCSfxRU43Ee6kdroDdNSq1406qhbluaJeVzA33EaXyPP1yZ
         LRA/MbWoYiDW1ZGi3FiJh2TrIOIkPlnWIrjgizAJNQ2v+PaYfkPbXKdq/268iG7UtiUi
         CHhQ==
X-Gm-Message-State: AOAM531aIuAzYV/uUTGs2Nl/FmrliUPBh/01bFMP01GSt2k2kvqA+49k
        upPWmOK7Aw1ERJVgU4KB/unodoe1mAmLBpL1YXKcnMPGxYI=
X-Google-Smtp-Source: ABdhPJzOjIczUkm+GzmsoNjpOtfqU0HiASfIOGLkc3/+TlhfZeeKtVnDLBrRlU7Lq/jzVpObG4OiZPuusrkp8p/lljU=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr18468856pls.145.1641192718899; Sun, 02
 Jan 2022 22:51:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
 <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com>
 <CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com>
 <CAPig+cRJj4Aa9Nm_yWD0=WGdn9tRmT2PpTwo5yeGZHg2Qz2rgA@mail.gmail.com> <CABPp-BH-oOUhTzcXMFWRfG=zjUw6C5h-oHSU=-juPTjpW92_vA@mail.gmail.com>
In-Reply-To: <CABPp-BH-oOUhTzcXMFWRfG=zjUw6C5h-oHSU=-juPTjpW92_vA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 01:51:47 -0500
Message-ID: <CAPig+cSayH9za9d4T6YdgjJRnS5jOoV7viWyZGw6qtA72cFEig@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 1:38 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 29, 2021 at 10:41 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Dec 28, 2021 at 1:16 PM Elijah Newren <newren@gmail.com> wrote:
> > > On Mon, Dec 27, 2021 at 11:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > A more general approach might be for the new worktree to copy all the
> > > > per-worktree configuration from the worktree in which the command was
> > > > invoked, thus sparsity would be inherited "for free" along with other
> > > > settings. This has the benefits of not requiring sparse-checkout
> > > > special-cases in the code and it's easy to document ("the new worktree
> > > > inherits/copies configuration settings from the worktree in which `git
> > > > worktree add` was invoked") and easy to understand.
> > >
> > > Ooh, this is a good point and I *really* like this simple solution.
> > > Thanks for pointing it out.
> >
> > I do wonder, though, if there are traps waiting for us with this
> > all-inclusive approach. I don't know what sort of worktree-specific
> > configuration people use, so I do worry a bit that this could be
> > casting a too-wide net, and that it might in fact be better to only
> > copy the sparse-checkout settings (as ugly as it is to special-case
> > that -- but we need to special-case `core.bare` and `core.worktree`
> > anyhow[1]).
>
> I could probably be persuaded either way (do users want to copy
> something and tweak it, or start with a clean slate?), and it might
> even make sense to have a flag for users to specify.

I also could probably be persuaded either way, and yes a flag is a
possibility, though it would be nice if we could get along without it.

> My hunch, at least with the developers I work with, is that they're
> more likely to think in terms of "I want another worktree like this
> one, except that I'm going to change..."
>
> Also, another reason to prefer copying all of core.worktree (minus the
> always worktree-specific value of core.worktree, and core.bare), is
> because it's easy to explain in the documentation, and I think we'd be
> much less likely to obsolete user's knowledge over time.  (I think
> additional sparse-checkout things, or new other features that also
> want to be copied over, are much more likely than the addition of keys
> that are always worktree-specific like core.worktree).

Another possible point in favor of copying all worktree-specific
config to the new worktree is that if the user really does want to do
some configuration specific to the new worktree, then that is going to
require a certain amount of manual setup after creating the new
worktree regardless of whether we copy all worktree-specific config or
only a select subset (such as the sparse-checkout settings).
