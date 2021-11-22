Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA5C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKVXMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhKVXMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:12:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D24C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:09:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so83608984edd.13
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LjHVNQa7nBdfUaEgUfoHUmxqzY3gsltUy2al1Cml3Nk=;
        b=Ia7h5a39vgZIMoIoXZCYiN8A4i9gw6LC2JB0kT05cW22TcHtYIRVi+MER0NnmGZ+sJ
         pJLzA/MlTZ5MZtY1mUHC+YywJTL30ta6J8Rfm3zjUqFz8t11C7392/0Ux48O5EgW0CbT
         BVcUp2qMVnE3NFZHb6vRskZyIg3josvEKjlZybtrxDNp3IRszQCL/wZ17xofndl8M64e
         oqMtu79/LB9gZxgcAd/IPXu/2ODZ7rngZmXH08zx4wfagaXU3LdImpOldS2t/0RQzlGu
         INeb6LngUo/4+VwZV33LjOKISZ9fxtozvmYDaBLRGPc0yqaQ77dDCTOds3DxB1fJVEaH
         7Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LjHVNQa7nBdfUaEgUfoHUmxqzY3gsltUy2al1Cml3Nk=;
        b=j+Xm0RcV4zKKlJ7vqGkExOWb5OVvq3d7YbNatD7Xk3YyJyypHqEEgIn+7DS3AS6Hjc
         4vwnB1bi6i9k3GXD5UCNOG0O7fwB7gYZALB5MDS7mDREy/8yeaLtwmr1z4LubRthRRDC
         fjFuF5ULYCj9foT5m41m+vw4WSc2dVtSaZQla+XMQWhXe7pN6ddieHa6njsHRrmpIvJ/
         X4XJKZXY72jOC9adnuk/21+vHTNmDww97LlLRt2sWpzvBDj62Z2Nj1aVXgMJsqO7yK7w
         Dyi2vklXBFBWOCglhVp+e2XKH7NqIEvkyH5GFVEDB/sg2n3xPLp0J1jEMa3vz5bkanC6
         iYlw==
X-Gm-Message-State: AOAM531Prt0w2mWp9B+gEDdov9kvsJpOshQtPIiLUlOD8U/BJB3J/Q5B
        BvLd69ku16fJ5M/eAliZ3Ex+dCsf6BOmTCcjbGY=
X-Google-Smtp-Source: ABdhPJynhmNn0Ph2jRdb1n3aKUZs0eI2YhPvAFLRvxagK4NRh3r1KvU57wTbmG9zEkKt/WaLC7Fc1LVu+T+wm3Uid0I=
X-Received: by 2002:a05:6402:134a:: with SMTP id y10mr1273007edw.241.1637622573581;
 Mon, 22 Nov 2021 15:09:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
 <776abd16-53d5-46c0-8008-c518a4415f7d@web.de>
In-Reply-To: <776abd16-53d5-46c0-8008-c518a4415f7d@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 15:09:22 -0800
Message-ID: <CABPp-BH2C1J9AAYnxcptoqgE5WeUCV=4W7qdW0P9KyMi2L3Abw@mail.gmail.com>
Subject: Re: [PATCH 2/8] repository, setup: introduce the_cwd
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 12:56 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 21.11.21 um 01:46 schrieb Elijah Newren via GitGitGadget:
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
> > We would like to avoid removing the current working directory;
>
> A worthy goal.
>
> > towards
> > this end, introduce a new the_cwd variable that tracks the current
> > working directory.  Subsequent commits will make use of this new
> > variable.
>
> Why make it a global variable instead of getting the working directory
> in the places that try to delete directories?  (Honest question, not a
> suggestion.)

As I mentioned in my response to Junio, I need to be clearer that what
I want to protect is the current working directory as of the startup
of the git process, as a proxy for the current working directory of
the parent process, so that subsequent commands started from the
parent process don't get confused.

As such, we don't want to get the working directory again later,
because that'd give us the wrong thing.  Also, setup.c has some nice
massaging of getcwd() from an absolute path into a relative path that
is much more convenient for us to do our later comparisons, and we'd
rather not do those additional tweaks with every check.  Since the
relative path from the project root to the _original_ current working
directory is a single value, a global seemed to make sense for saving
it.  Perhaps I should tweak it to be const as well.

>
> >
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
> > @@ -887,6 +887,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
> >               set_git_dir(gitdirenv, 1);
> >               if (chdir(worktree))
> >                       die_errno(_("cannot chdir to '%s'"), worktree);
> > +             the_cwd =3D xstrdup(cwd->buf + offset);
> >               strbuf_addch(cwd, '/');
> >               free(gitfile);
> >               return cwd->buf + offset;
> > @@ -940,6 +941,7 @@ static const char *setup_discovered_git_dir(const c=
har *gitdir,
> >       /* Make "offset" point past the '/' (already the case for root di=
rs) */
> >       if (offset !=3D offset_1st_component(cwd->buf))
> >               offset++;
> > +     the_cwd =3D xstrdup(cwd->buf + offset);
> >       /* Add a '/' at the end */
> >       strbuf_addch(cwd, '/');
> >       return cwd->buf + offset;
> >
>
