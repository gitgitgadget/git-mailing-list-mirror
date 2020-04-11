Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B93C2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFE52083E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 00:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLpeKQw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDKAGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:06:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47069 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKAGg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 20:06:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id w12so2481005otm.13
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fresn4Wm85Kiva/Nx4XPrHhzsIF+OSuqRQhk+EynJLc=;
        b=MLpeKQw9cDIEoQ4NWNrGo6GBsYbyvtqNI5CXHS6n5Q7wyit4J6yCwiQFkV3GoZIgs1
         MJ807yxAUYyOkP44GvvXCApxyC/a+bupf/HTJkPviCcKegjEI7GYI6NYSqOm/bNh7qxT
         2N2ySiENjKCwDaBScilvTba3nQrEfjZKfMFj75++1DDvmC/p/hSYSePYlZrefa6rof8i
         9V7p4hUnIF0TEtJOJu690wvhPBCIQZe/evzusxlfs4ZzbOkvup1SlPSeGag3EO1V/yUy
         N5uFLF4QL/d1J5CvCSllp3dF3IcM+Xp5T+3J04MVFUI2ktp5ne7ZQOLzW1ZgLlL+d7nS
         1Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fresn4Wm85Kiva/Nx4XPrHhzsIF+OSuqRQhk+EynJLc=;
        b=twT4Lfwad3E/zLAnzffLPNQpHtN902/FrX9YP9ZDVTIW7VbX38YOK70miIlTDYS0Z2
         y7vMH18/CwgwHw6fE0LABA1xp5lhwZvMq3HG4WiE+k5BqNPnZd9q0i8YSzZfw5uoBmNt
         MlT49jsOOrYfW0S61OFkwPfb8uyi1chi4XRToIOiPyE9hwHmGmr8ghXqTFv//cNoU9SR
         51pwGbD8k3GY60YyUbmWoaru1lQVSOmrKfufBYfZowoMyjvjdpPrgGJ9B89FmzeCETbg
         O3VUOZQ/OsyX2WBz724dGZ99bt1/hgaov7sekqDUFqL+Nql5z3WYF/bDJcLvdB4NM4wv
         KlyA==
X-Gm-Message-State: AGi0PuZvGH/6sevcMeb/BAESx7iYDS/dNc2BuaOOtczcqmXZtMJmY7hm
        bVR33ehS6kr0h66b6OQW/QRUFqzsvH45QePBP/4=
X-Google-Smtp-Source: APiQypKS3OsnH5ssIH8xb8Gt/xNg1eo2TLgZt1qzRQOi2XccF3G7Yw5bqzGq18NYOH39vhnlFL+6kIMnT2hGt9zzEp0=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr4238400otq.345.1586563594262;
 Fri, 10 Apr 2020 17:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
 <20200410222722.95611-1-jonathantanmy@google.com>
In-Reply-To: <20200410222722.95611-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 17:06:23 -0700
Message-ID: <CABPp-BFEtd9X1XJwwpJ2YP6a4Zyc_yevwnMfNA+Dr45p4-7YEA@mail.gmail.com>
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, congdanhqx@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 3:27 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > +If `--keep-cherry-pick is given`, all commits (including these) will be
> > > +re-applied. This allows rebase to forgo reading all upstream commits,
> > > +potentially improving performance.
> >
> > I'm slightly worried that "keep" is setting up an incorrect
> > expectation for users; in most cases, a reapplied cherry-pick will
> > result in the merge machinery applying no new changes (they were
> > already applied) and then rebase's default of dropping commits which
> > become empty will kick in and drop the commit.
> >
> > Maybe the name is fine and we just need to be more clear in the text
> > on the expected behavior and advantages and disadvantages of this
> > option:
> >
> > If `--keep-cherry-picks` is given, all commits (including these) will be
> > re-applied.  Note that cherry picks are likely to result in no changes
> > when being reapplied and thus are likely to be dropped anyway (assuming
> > the default --empty=drop behavior).  The advantage of this option, is it
> > allows rebase to forgo reading all upstream commits, potentially
> > improving performance.  The disadvantage of this option is that in some
> > cases, the code has drifted such that reapplying a cherry-pick is not
> > detectable as a no-op, and instead results in conflicts for the user to
> > manually resolve (usually via `git rebase --skip`).
> >
> > It may also be helpful to prevent users from making a false inference
> > by renaming these options to --[no-]reapply-cherry-pick[s].  Sorry to
> > bring this up so late after earlier saying --[no-]keep-cherry-pick[s]
> > was fine; didn't occur to me then.  If you want to keep the name, the
> > extended paragraph should be good enough.
>
> Sorry for getting back to this so late. After some thought, I'm liking
> --reapply-cherry-picks too. Perhaps documented like this:
>
>   Reapply all clean cherry-picks of any upstream commit instead of
>   dropping them. (If these commits then become empty after rebasing,
>   because they contain a subset of already upstream changes, the
>   behavior towards them is controlled by the `--empty` flag.)

Perhaps add "preemptively" in there, so that it reads "...instead of
preemptively dropping them..."?

>   By default (or if `--noreapply-cherry-picks` is given), these commits
>   will be automatically dropped. Because this necessitates reading all
>   upstream commits, this can be expensive in repos with a large number
>   of upstream commits that need to be read.
>
>   `--reapply-cherry-picks` allows rebase to forgo reading all upstream
>   commits, potentially improving performance.
>
>   See also INCOMPATIBLE OPTIONS below.

Otherwise, this description looks good to me.

> This also makes me realize that we probably need to change the "--empty"
> documentation too. Maybe:
>
>    --empty={drop,keep,ask}::
>   -       How to handle commits that are not empty to start and are not
>   -       clean cherry-picks of any upstream commit, but which become
>   +       How to handle commits that become
>           empty after rebasing (because they contain a subset of already
>           upstream changes).  With drop (the default), commits that
>           become empty are dropped.  With keep, such commits are kept.
>           With ask (implied by --interactive), the rebase will halt when
>           an empty commit is applied allowing you to choose whether to
>           drop it, edit files more, or just commit the empty changes.
>           Other options, like --exec, will use the default of drop unless
>           -i/--interactive is explicitly specified.
>    +
>   -Note that commits which start empty are kept, and commits which are
>   -clean cherry-picks (as determined by `git log --cherry-mark ...`) are
>   -always dropped.
>   +Commits that start empty are always kept.
>   ++
>   +Commits that are clean cherry-picks of any upstream commit (as determined by
>   +`git log --cherry-mark ...`) are always dropped, unless
>   +`--reapply-cherry-picks`, is set, in which case they are reapplied. If they
>   +become empty after rebasing, `--empty` determines what happens to them.
>    +
>    See also INCOMPATIBLE OPTIONS below.
>
> If this works, I'll send out a new version containing Elijah's patches
> and mine in whatever branch my patch shows up in [1].
>
> [1] https://lore.kernel.org/git/xmqqd08fhvx5.fsf@gitster.c.googlers.com/

Yeah, I was making changes to this exact same area in my series to
reference your flags.[2]

[2] https://lore.kernel.org/git/e15c599c874956f1a297424c68fe28e04c71807b.1586541094.git.gitgitgadget@gmail.com/

Would you mind if I took your proposed changes, put them in your
patch, and then rebased your patch on top of my series and touched up
the wording in the manpage to have the options reference each other?

> > > @@ -568,6 +583,9 @@ In addition, the following pairs of options are incompatible:
> > >   * --keep-base and --onto
> > >   * --keep-base and --root
> > >
> > > +Also, the --keep-cherry-pick option requires the use of the merge backend
> > > +(e.g., through --merge).
> >
> > Why not just list --keep-cherry-pick[s] in the list of options that
> > require use of the merge backend (i.e. the list containing '--merge')
> > instead of adding another sentence here?
>
> My reading of the list containing "--merge" is that they *trigger* the
> merge backend, not require the merge backend. My new option requires but
> does not trigger it (unless we want to change it to do so, which I'm
> fine with).

Interesting; what part of the man page comes across that way?  That
may just be poor wording.

However, if an option requires a certain backend, is there a reason
why we would want to require the user to manually specify that backend
for their chosen option to work?  We know exactly which backend they
need, so we could just trigger it.  For every other case in rebase I
can think of, whenever a certain backend was required for an option we
always made the option trigger that backend (or throw an error if a
different backend had already been requested).
