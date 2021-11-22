Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A259C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhKVWlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhKVWlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:41:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA3C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:38:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so39055153eds.10
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eML27hNnHMzVm0IC9c73QSx9lxGqKbmmUhP2RezBamg=;
        b=hAECvFicDpGaHWA12iHNuvservKDtjhtilnDL58GM1jFwMOhAXa38PYz8h193QLLWK
         L8UoG33Bnn3y3PwgRy5TMSqnravnRobbHKQHInFeeWYIcKmpr07rb0+CDMVXCUdBy5Zh
         sVJJ3Ja8jI9kB31bPUolb1n2In7TSRniTv7a648TKWIIRFX6WTIjxZ8bkfkkt7K6dLY+
         iSJDQexTYSciUxIHJG1vw91/YBidAnZniQsm7OpvBuNKs7iwIo75qSCYPmIvxicH3pP1
         zWPOZAbOiKrh6ERxaU+z9RMnPPz6bkVwCosgiJ0U9xklZx2QfP5XPaLwo4B0x2fu/Wax
         BgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eML27hNnHMzVm0IC9c73QSx9lxGqKbmmUhP2RezBamg=;
        b=cl6U9lSqnCyggE79Rw0HsYRwha9K24twNb+rzJQa5BNto76BRMaysKRgNcOXTgRvJk
         xlG/ibViH+zKTH86UjLy5TFDx5XcVI30Xg6zbFkSVOksU/s8YYjyb4OuQTOlasoJsKDz
         lwi4Q/2w9pbAEJ+bMNTfuDVswWYDXF3mHxX0uJx5ZVOHm5RS9yaTRbE3kr0S3bsDjzqb
         wY8QJMY/U0F8zA0NEk4QJ8kMRg40SlZvVM5rR1FpcG3o3vnMvxim7oEqcKGh/Y7q8W2K
         PnovFENaosS1uLiK6TpcBlIKBlEcCf0rv+aNWeWf91YTJzVvczJ7VWFoSrELYS9Ivdcy
         hskA==
X-Gm-Message-State: AOAM5326sx0tm18O47Pe3/NLa/4xeO4KZRTLck0SO7+8S8uW/s8JaYHU
        TqnE+pGykIacoDhYmEi+0nITgheHxGluA/rtUB5mSHXgCYo=
X-Google-Smtp-Source: ABdhPJxs5f6Iil/K9Kx+sDBLYV+/URlpvFXXQoJqaiwuSjO2QzxOA8EXUOOdcCSTSDH0YTuhz/nwFXarFIVRRv/T43A=
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr959494edw.241.1637620691761;
 Mon, 22 Nov 2021 14:38:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
 <xmqqv90mlyzt.fsf@gitster.g>
In-Reply-To: <xmqqv90mlyzt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 14:38:00 -0800
Message-ID: <CABPp-BHaGjoX3V6yfFLS=i0bH8AiN6Kpej43yPqgkbtF3FKNRQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] repository, setup: introduce the_cwd
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 12:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Removing the current working directory causes all subsequent git
> > commands (and likely a number of non-git commands) run from that
> > directory to get confused and fail with a message about being unable to
> > read the current working directory.  That confuses end users,
> > particularly since the command they get the error from is not the one
> > that caused the problem; the problem came from the side-effect of some
> > previous command.
> >
> > We would like to avoid removing the current working directory; towards
> > this end, introduce a new the_cwd variable that tracks the current
> > working directory.  Subsequent commits will make use of this new
> > variable.
>
> Maybe a stupid question, but how is this different from doing getcwd()
> and storing it away to the_cwd

The exact output of getcwd() is an absolute path, whereas it's easier
to perform later checks if we have a path that is relative to the
toplevel working directory.  Also, setup.c already calls getcwd() (via
strbuf_getcwd()) and then massages it, and I'd have to do the exact
same type of massaging.  So, instead of calling getcwd() again and
re-massaging its output into the format I want, I just reuse the
existing call of getcwd() and its massaged output.

> or adding a check to see if the
> directory we are about to rmdir() is the cwd, next to the existing
> check that we do to see if that directory has some untracked files?
>
> I am wondering how we are going to make sure that the_cwd is always
> set to, and maintained to be, the correct value, even in the future
> when these code paths change.  I also wonder if it might be safer to
> learn what the value of cwd is very near the place where it will
> become needed (i.e. the callsites of such rmdir() of a directory
> inside working tree), instead of caching.

I need to clean up my wording a bit, to clarify this.  Doing as you
suggest here would protect the wrong thing.  git has long done an
automatic chdir() at startup to the toplevel working tree, whereas
what we want to protect is the original current working directory as
of the time git started.  The original current working directory is
likely also still the current working directory of the parent process
that spawned us, and if that parent process is a shell, any subsequent
commands executed from there can be somewhat confusing when its
current working directory is removed.

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  repository.c | 1 +
> >  repository.h | 1 +
> >  setup.c      | 2 ++
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/repository.c b/repository.c
> > index c5b90ba93ea..69a106c553c 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -17,6 +17,7 @@
> >  static struct repository the_repo;
> >  struct repository *the_repository;
> >  struct index_state the_index;
> > +char *the_cwd;
> >
> >  void initialize_the_repository(void)
> >  {
> > diff --git a/repository.h b/repository.h
> > index a057653981c..45de85d18ef 100644
> > --- a/repository.h
> > +++ b/repository.h
> > @@ -147,6 +147,7 @@ struct repository {
> >  };
> >
> >  extern struct repository *the_repository;
> > +extern char *the_cwd;
> >
> >  /*
> >   * Define a custom repository layout. Any field can be NULL, which
> > diff --git a/setup.c b/setup.c
> > index 347d7181ae9..4466fa55af3 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -887,6 +887,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
> >               set_git_dir(gitdirenv, 1);
> >               if (chdir(worktree))
> >                       die_errno(_("cannot chdir to '%s'"), worktree);
> > +             the_cwd = xstrdup(cwd->buf + offset);
> >               strbuf_addch(cwd, '/');
> >               free(gitfile);
> >               return cwd->buf + offset;
> > @@ -940,6 +941,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
> >       /* Make "offset" point past the '/' (already the case for root dirs) */
> >       if (offset != offset_1st_component(cwd->buf))
> >               offset++;
> > +     the_cwd = xstrdup(cwd->buf + offset);
> >       /* Add a '/' at the end */
> >       strbuf_addch(cwd, '/');
> >       return cwd->buf + offset;
