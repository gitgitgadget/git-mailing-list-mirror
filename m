Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C29C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhKZSOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhKZSMy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 13:12:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4F9C0613F9
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 09:56:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y12so41864789eda.12
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jGBdyyg3wiQe9kRJYXTmzQhLn0xgMOs0eo0b4guXmPQ=;
        b=pmYUycWfIH/TEHv2LsvhYDUO8mdVGCWPrJGGsptCWc1fvhOIid2KM0tzjFsQome72M
         7Ujyxv5bMjsmdZ1D4T86qNazdQCSLJPs+B13LIQHbY/PQW353VEKWglLMrK/SfcyI6tl
         HMBI+Th/G/3aKRAAXdLxFR1zHeu0A0rnkOvIvUeUgnaCgnCDY2G2LhiE1LxakkJBAZSl
         pc0UoDPVgASdQH/WZI/O+mLXvG4kQHwNJdOKLDhvQBO1W9ap6kWHn9XhQM6BEQEgklPL
         VT6/xuEn/X0kfRGqo1WA11u1y4TiUnS/5UAd+9zj9Q6+yhA0PPOGE/1Slr2u/3HHvBuu
         U21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jGBdyyg3wiQe9kRJYXTmzQhLn0xgMOs0eo0b4guXmPQ=;
        b=Ju30hKpe5oV7wZwzqcKMZoKIgyBqPChwsLG00FbufuYpbRS+O3mQorYMik0NOZ89KV
         TxMUiAV83wpF7HcCmXzbym7ECR1twnvrEGscroSRa+ePdu96ee+q2FMGn0oyvbFmibSf
         xmbHPwtGNUKgZfxKtQLneU6KiU3ZO16QlU59MYuMKqx4/cHPnRgZzQJGZBu3/vIgVOn7
         wvYHVL7auXFJ2HxJ+pyGs9pQ9cqgmfJOvWdugOQV1vJW2/qNTVR6Wkt/za97QbVEOJdw
         SS36duRkgZ398Zs+e2JnEF8+z2ody0Eq2sj58HSJlUHGNXqTngApbb16jvt6w/0a9EOH
         gilw==
X-Gm-Message-State: AOAM531caTHZosjPcRXut/Vn+LqEICN2ybDqf7wtmmmLk+51hhuLLm6i
        fq6yFMhEOp1Y6YLd5yDze5wMjhe2nVE6bCJid9rU1VUX
X-Google-Smtp-Source: ABdhPJyiGQmSPLyogaNc9lIl8CRQy+4mQgD1bcQxk3RGNYYX0vIpx174+KL431ytSjF8WY2f1glYiUrvMZjT5g2Z9NA=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr50076370edx.279.1637949368169;
 Fri, 26 Nov 2021 09:56:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com> <f6129a8ac9c3d052fb7fb508a62d4eedb8d9ed57.1637829556.git.gitgitgadget@gmail.com>
 <211125.86bl28jyil.gmgdl@evledraar.gmail.com>
In-Reply-To: <211125.86bl28jyil.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Nov 2021 09:55:56 -0800
Message-ID: <CABPp-BFN9y_nX1pEYAOyJKBhTXHWOGxb66bBs6=eJABKophSBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] setup: introduce startup_info->original_cwd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 2:55 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:
>
> > Removing the current working directory causes all subsequent git
> > commands run from that directory to get confused and fail with a messag=
e
> > about being unable to read the current working directory:
> >
> >     $ git status
> >     fatal: Unable to read current working directory: No such file or di=
rectory
> >
> > Non-git commands likely have similar warnings or even errors, e.g.
> >
> >     $ bash -c 'echo hello'
> >     shell-init: error retrieving current directory: getcwd: cannot acce=
ss parent directories: No such file or directory
> >     hello
>
> Okey, but...
>
> > diff --git a/git.c b/git.c
> > index 5ff21be21f3..2c98ab48936 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -866,6 +866,8 @@ int cmd_main(int argc, const char **argv)
> >
> >       trace_command_performance(argv);
> >
> > +     startup_info->original_cwd =3D xgetcwd();
> > +
> >       /*
> >        * "git-xxxx" is the same as "git xxxx", but we obviously:
> >        *
> > diff --git a/setup.c b/setup.c
> > index 347d7181ae9..f30657723ea 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -432,6 +432,54 @@ void setup_work_tree(void)
> >       initialized =3D 1;
> >  }
> >
> > +static void setup_original_cwd(void)
> > +{
> > +     struct strbuf tmp =3D STRBUF_INIT;
> > +     const char *worktree =3D NULL;
> > +     int offset =3D -1;
> > +
> > +     /*
> > +      * startup_info->original_cwd wass set early on in cmd_main(), un=
less
> > +      * we're an auxiliary tool like git-remote-http or test-tool.
> > +      */
> > +     if (!startup_info->original_cwd)
> > +             return;
>
> This really doesn't belong in those places, by calling xgetcwd() so
> early you'll be making commands that don't care about RUN_SETUP at all
> die. E.g. with this change:
>
>     mkdir x &&
>     cd x &&
>     rm -rf ../x &&
>     git version
>
> Will die.

Whoops!  Yeah, I should have used strbuf_getcwd() there.  Thanks for
the careful reading.

> So as a follow-up to my comment on this v2's 01/09 I think what's also
> missing here is something that does that, but instead of "git version"
> does it for all of the "while read builtin" list in t0012-help.sh.

If I had to do some kind of special casing, or if I did potentially
call a path that could die() in the final version, then yes I'd need
to test all of these.  But by using strbuf_getcwd(), I remove the
possibility of die()'ing, so I think testing one of these is good
enough.

> There's other cans of worms to be had here, the discussion downthread of
> the not-integrated[1] points to some of that.
>
> I.e. how should the various commands like "ls-remote" that can work
> with/without a repo behave here? That one happens to die before/after,
> but as noted in that thread that's also a bug.
>
> So anything that adds more really early dying in this area should also
> think about the greater goals of what we're doing with RUN_SETUP &
> related flags. I.e. does the direction make sense?
>
> If this is moved to some soft recording of the getcwd() (and maybe the
> $PWD, as in my WIP change?) shouldn't this go into common-main.c? With
> git.c's cmd_main() we're excluding the test helpers and things like
> git-daemon. Is that intentional?

I didn't think e.g. git-remote-http, git-daemon, etc. mattered.
test-tool is supposed to only be used in the testsuite to my
knowledge.  But fair point, I'll move it to common-main.c.  And, as
per Junio's suggestion in this thread, I'll make it only affect
worktrees.

> I'd also think we'd want to do this much earlier if e.g.  thing like the
> trace2 setup wanted to call the remove_directory() call.

Nah, I'll just put the original_cwd in a temporary, and then if setup
is never called, it won't affect anything else.  And setup will only
make it affect the worktree (and thus won't affect bare repos, nor
affect paths outside the worktree if the user is running from outside
the worktree).

> Per what Glen & mentioned I'm still not sure if I'm on board with that
> idea at all, just running with the ball you put in play :) I.e. if we're
> modifying all callers, let's make sure we catch all callers.
>
> Perhaps a better approach is to intercept chdir() instead? And anything
> that calls chdir() sets some GIT_* variable so we'll pass "here's our
> original cwd" down to sub-processes, like we do with "git -c" for
> config.
>
> That would presumably save you the effort of in-advance whitelisting
> everything like "git version", we can just move to doing this lazily. If
> you're a command that does a RUN_SETUP or otherwise needs chdir() we'll
> record the original getcwd(), otherwise...

There is a chdir_notify(), but of course it isn't called by the
codepath that handles the -C argument.  I believe the above solution
of a temporary handles things just fine, though.

Thanks for the thoughtful and careful review!
