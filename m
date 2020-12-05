Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB066C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FE022D6E
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgLEA4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgLEA4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 19:56:53 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF8C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 16:56:27 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i6so977658otr.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 16:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJFvgcBlhYYBHWc8uE4NTidoJzo/BaT+zDORaAoM03o=;
        b=ZMV2kYzvy8XAewbQBqwJ8bG/erS9qsZKYzKR5fS2tPc0mtO1splTH0UBuTpBrPHO6f
         P9HRy9UF0hrVhFwYS3rOb9B1g+9Az3LPve5nN22I9D+q2omwTlIStGpFHPieYmh3idxu
         Yont/3t9HqDMPBFlp9ww/CYMYGzU/3gBOws8zWmtim4RJ2XUUWY7aDeEu888y3KOth5b
         WYL/ETJIIAHSXKm9TEt/zSMuJi4LnBIwz09x+x3KFpB5cBZauue1Zxjrd7osw8AgbFud
         9I5eA9ujuM7UVb66VOPEArxBFKNE5PtJdW+6r3aeZQQfHnhGVxsikHsKkOlPLitRlroA
         OaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJFvgcBlhYYBHWc8uE4NTidoJzo/BaT+zDORaAoM03o=;
        b=HgBAD6bwb6DjceMF7eW5JwACFrqKemJ9tW+3WIgjfFrhjTgoir12eJysN5Xfai96ku
         TsYHMLGP1HSKj6+3pBx2p7/B6PBpRsXcY2p7t3F5CLB+WL+WlxwspIMAXSqs54MCqU3z
         QK2H+NnaXkadAQGKz0ugrtyCg5bOQGN6CpeTQk4oa4JM5s26uYNhFs5gN/kSCEl2R5O0
         LNGAzUe1k+5+iW6Iv0sGOs77OKL9diHlNDrNmL8b0LP3g5l1PZe94s6w4pHSgT38bJFv
         NbtcAaF40nUWVQcIgnV/HZcpysH3sApuvBdRRTsquuHgZ414njzJnWam61duQ6S53tkt
         yUCw==
X-Gm-Message-State: AOAM533g1JJtPy+8hYtQyIZ2PJIsqxFTA+pyx095LvjZ1Pmx6WUCBqYQ
        4qlbrqsVLaxv7gbO/5Wk5pHDwSg+XQZbXoOJZoE=
X-Google-Smtp-Source: ABdhPJxhW40StQRyRPaefDQk6b33faDZsy+bx0/ZLxlkPtcfEMcGtK3/rJ0W0NsS2acmhb/oP+qxQomBlK4m3CsjTnw=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr5551053oti.345.1607129786543;
 Fri, 04 Dec 2020 16:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
In-Reply-To: <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 16:56:14 -0800
Message-ID: <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Fri, Dec 4, 2020 at 4:12 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 5:00 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > We want to:
> > >
> > > 1. Be clear about what "specifying" means; merge or rebase.
> > > 2. Mention a direct shortcut for people that just want to get on with
> > >    their lives: git pull --no-rebase.
> >
> > This is a shortcut for what?
>
>   git config --global pull.rebase false
>   git pull
>
> It's a shorter way of saying: "do a 'git pull' like you've always done
> but don't warn me".
>
> > > 3. Have a quick reference for users to understand what this
> > >    "fast-forward" business means.
> > >
> > > This patch does all three.
> > >
> > > Thanks to the previous patch now "git pull --help" explains what a
> > > fast-forward is, and a further patch changes --no-rebase to --merge so
> > > it's actually user friendly.
> > >
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > ---
> > >  builtin/pull.c | 23 ++++++++++++-----------
> > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/builtin/pull.c b/builtin/pull.c
> > > index 1034372f8b..22a9ffcade 100644
> > > --- a/builtin/pull.c
> > > +++ b/builtin/pull.c
> > > @@ -346,17 +346,18 @@ static enum rebase_type config_get_rebase(void)
> > >
> > >         if (opt_verbosity >= 0 && !opt_ff) {
> > >                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > > -                        "discouraged. You can squelch this message by running one of the following\n"
> > > -                        "commands sometime before your next pull:\n"
> > > -                        "\n"
> > > -                        "  git config pull.rebase false  # merge (the default strategy)\n"
> > > -                        "  git config pull.rebase true   # rebase\n"
> > > -                        "  git config pull.ff only       # fast-forward only\n"
> > > -                        "\n"
> > > -                        "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > > -                        "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > > -                        "or --ff-only on the command line to override the configured default per\n"
> > > -                        "invocation.\n"));
> > > +                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> >
> > ...want a merge, a rebase, or neither.
>
> There is no "git pull --no-merge". Years ago some people argued for a
> "pull.mode=none" (essentially making "git pull" the same as "git
> fetch"). But right now there's no option to do that.
>
> There's an option to do --ff-only, but that's still a merge.

I disagree.  I'm well aware that checkout_fast_forward() (which is
what is ultimately called to do the fast-forwarding) is in a file
called merge.c, but that doesn't make it a merge.  I don't believe it
was anything more than a convenient place to dump some extra code at
the time.

> Perhaps: a merge, a rebase, or a fast-forward?

Sure, that works; in fact, that's much better than my suggestion.  I like it.

> > > +                       "You can squelch this message by running one of the following commands:\n"
> > > +                       "\n"
> > > +                       "  git config pull.rebase false  # merge (the default strategy)\n"
> >
> > Should this be labelled as the default given the desire to make
> > --ff-only the default?  Perhaps I'm jumping ahead and you plan to
> > change that later in this series.
>
> That's right.
>
> In the previous series which does indeed make "pull.mode=ff-only" the
> default [1], I do change the warning to specify the future default
> [2], but in that series the warnings is changed to:
>
>   The pull was not fast-forward, in the future you will have to choose
> a merge, or a rebase.
>   To squelch this message and maintain the current behavior, use:
>
>     git config --global pull.mode merge
>
>   To squelch this message and adopt the new behavior now, use:
>
>     git config --global push.mode ff-only
>
>   Falling back to old style for now (merge).
>   Read "git pull --help" for more information.
>
> Since that series didn't get any traction, I decided to only implement
> step 1: fix the current situation. And later on another series would
> do step 2: introduce "pull.mode=ff-only" and do the preparations to
> make it the default.

I like this longer plan.  However, on the shorter scale plan...I think
the suggestion to use "git pull --no-rebase" makes the current
situation worse rather than fixing it.

> > > +                       "  git config pull.rebase true   # rebase\n"
> > > +                       "  git config pull.ff only       # fast-forward only\n"
> > > +                       "\n"
> > > +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > > +                       "preference for all repositories.\n"
> >
> > Good up to here.
> >
> > > +                       "If unsure, run \"git pull --no-rebase\".\n"
> >
> > Why is that safe to suggest?  The original text may not have been the
> > easiest to parse, but this seems more problematic to me.
>
> Because "git pull" has been doing the same as "git pull --no-rebase"
> for more than a decade. It's safe for people to continue with this
> behavior for a few more months.
>
> Some people need to get things done today, and they are not interested
> in future changes, nor changing their default configuration, or what
> the warning has to say.
>
> They just want "git pull" to do the same as yesterday, and the year
> before, without being bothered with an annoying warning.
>
> Those people can start training their fingers to do "git pull
> --merge", and learn the problems with "git pull" later.
>
> We want to respect the user's time, and not force them to read the
> warning today.

The warning was added because sending users down paths that break
things badly is a waste of user's time, and often a much bigger waste
of user's time than making them read up on the meaning behind the two
different choices of what kind of changes they can make.  I agree the
warning went too far, but I fully agree with the original folks who
put this warning here that we need to have it for at least some cases
and that there is a decision to be made.  Though I am just one voice,
and perhaps others will agree with you on your point here, I'll
continue to disagree with blindly suggesting "git pull --no-rebase".

> > > +                       "Read \"git pull --help\" for more information."
> >
> > Nice addition.
>
> Especially since now it explains what a fast-forward is.

Indeed.  :-)
