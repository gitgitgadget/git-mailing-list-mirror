Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8AC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhLTA60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 19:58:26 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:44679 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhLTA60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 19:58:26 -0500
Received: by mail-pj1-f41.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso8545444pjl.3
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 16:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mk6+8SY9gkj7aqTKBUOiiA7H2ZhxdDclCWCcPIx6vHw=;
        b=DZi6gdSlZRreee32Ih5e4iVGtVZHFihC+0fjir0vapXmcR9FRLUbBekLfaTTeWEwuZ
         +l7MzkcyDgBoJ8EkShonupZj4+XekBf4AKG/iJvmqsRrqy2Zq0+w0kQu2KBwd5cmz+xt
         yo2Sfwy14IhIdzikKdCv2hBHm2znQmrEYq58c/YCfCVR1X0QHFnFMbCsD44L1eBBm/VZ
         hpQG2eLlWWYX+ixqICH5PcykqyZGas53L9hl6cxtswedTyAWzWCGVqe0yRSTDVIVRxWg
         ijS/LHi/1Fa4yFjOgzJHGS7j8euPybI7K+KYCFOxqYT9l+ho5zzVYyJJrmuFC7dBVNPm
         cM1Q==
X-Gm-Message-State: AOAM5331y9kwXZJwTlQ/+9FRk2mjMPLpcWkgmu9N1//cDAcapOeJ7UlW
        kH3VXKlv65gigpFQBE3mwkdLM5U/3huxDxb4F4g=
X-Google-Smtp-Source: ABdhPJz67fBRFglvhCVybWKGB1ijQH6Y78rg9btYiTT7cHb+zJU72kr4094rdZmZKxoJ/BtA2uu4nAoCdd1oAVBtbgY=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr14751204plh.35.1639961905768; Sun, 19
 Dec 2021 16:58:25 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
In-Reply-To: <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Dec 2021 19:58:14 -0500
Message-ID: <CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <ttaylorr@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 19, 2021 at 3:47 PM Sean Allred <allred.sean@gmail.com> wrote:
> > However, you missed the step (discussed in [1]) in which it is your
> > responsibility to move the `core.bare=true` setting from
> > git.git/config to git.git/worktree.config manually after setting
> > `extensions.worktreeconfig=true`.
>
> Ahh, that makes sense!  I did notice the `core.bare` setting being
> respected in source and figured this had a part to play (which is why
> I included git-config output).
>
> I think then that I was overzealous in trying to MWE-ify the issue: as
> I noted, I found this issue when I was trying to perform a
> sparse-checkout within the worktree.  To memory (I don't have my work
> system at the moment and don't have its `history`), I think it went
> something like this:
>
>     git worktree add --no-checkout ../next && cd ../next
>     git sparse-checkout init --cone # auto-created a worktree config
>     git sparse-checkout set t

Thanks for this information. I haven't followed sparse-checkout mode
at all and haven't used it, so I quickly scanned the man page for the
worktree-relevant information, and indeed I was able to reproduce the
problem using the recipe (with the prerequisite that the repository is
bare) which you present here.

> I think either the git-sparse-checkout-set command (or the
> git-checkout I ran after) would fail complaining that I was not in a
> worktree.

It is indeed the `git sparse-checkout set` command which fails.

> Based on the above, it sounds like `init` is creating the
> worktree-specific config, but is not overriding `core.bare` in that
> config.  Would a patch to take this step this automatically be
> well-received?

This looks like a legitimate oversight, so some sort of patch to
resolve it would likely be welcomed.

> I see two options for when to set `core.bare=false` in
> worktree-specific config:
>
>   1. At git-worktree-add: This is probably the earliest time which
>      makes sense, but may be over-reach.  I'm not up-to-speed on how
>      worktree-specific configs are generally considered on this list.
>      If I were implementing a workaround, though, this is probably
>      where I'd make it.

My knee-jerk reaction is that applying a "fix" to `git worktree add`
to assign `core.bare=false` in the worktree-specific config may be
misguided, or at least feels too much like a band-aid. Although it's
true that that would address the problem for worktrees created after
`extensions.worktreeconfig=true` is set, it won't help
already-existing worktrees. This reason alone makes me hesitant to
endorse this approach.

What I could see, perhaps, is a new git-worktree subcommand which does
all the necessary bookkeeping required when switching between
worktree-specific configuration and the legacy configuration model.
For the sake of example, calling this fictitious command "manage",
then we might have "git worktree manage --enable-worktree-config"
which both sets `extensions.worktreeconfig=true` _and_ moves
`core.bare` and `core.worktree` from .git/config to
.git/worktree.config if those config keys exist. The fictitious "git
worktree manage --disable-worktree-config" would reverse the operation
by moving all of .git/worktree.config into .git/config and disabling
`extensions.worktreeconfig`. However, there's a question of what to do
with the worktree-specific worktree.config files when disabling
`extensions.worktreeconfig`. Should they become orphaned or should
they somehow be incorporated into .git/config. Or, perhaps, there
shouldn't even be a --disable-worktree-config switch since a human
probably needs to make decisions about merging the worktree-specific
worktree.config files; or maybe --disable-worktree-config should exist
but error out if it can't figure out how to automatically deal with
the worktree-specific worktree.config files. Anyhow, this is not a
simple solution to the immediate problem and needs a lot more thought.

Another possibility is coming up with a migration plan to eventually
make worktree-specific configuration the default, and eventually drop
support for the legacy configuration model. I don't know if Duy had
any such migration plan in mind when he implemented worktree-specific
configuration, but it seems a reasonable end goal. However, although
that would solve this problem in the long run (since `core.bare` would
be local to the repository and not bleed into worktrees), it doesn't
help in the short term since any migration plan is likely to be
years-long.

>   2. At git-sparse-checkout-init: This is where the problem begins to
>      have an effect, so this might also make sense.

Yes, if I'm understanding everything correctly, this seems like the
best and most localized place to address the problem at this time. The
simple, but too minimal, approach would be for `git sparse-checkout
init` to simply add `core.bare=false` to the worktree-specific config,
however, this only addresses the immediate problem and still leaves
things broken in general for any non-sparse worktrees.

So, the better and more correct approach, while still being localized
to `git sparse-checkout init` is for it to respect the documented
requirement and automatically move `core.bare` and `core.worktree`
from .git/config to .git/worktree.config if those keys exist. That
should leave everything in a nice Kosher state for all worktrees,
existing and newly-created.

(I've cc:'d a few sparse checkout area experts, though I may have
forgotten some.)
