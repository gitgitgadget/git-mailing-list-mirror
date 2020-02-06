Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE160C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078021775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbWcGjyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgBFW1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:27:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39038 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBFW1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:27:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so579814wme.4
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZdeUHSObScLykUe4QoredSw0PfmK1HsKibX2Ml9PaU=;
        b=jbWcGjyqpeFK9uXN4IWAdhD/srL1uiTzcjEnVqo0i2wTrIflI4eZVOAaxvGvk31F51
         pC5PwOUuP2pi0SEqNFHJcc4fy6fSBtazyN4J72+ydGD9HHWuDi22agDQa3iL1kbdSBD+
         2IW6o9a6lSRDhN69cQrlDXEpUVrLTipW3BCaPH0Ksm5hexQQtbZiF5ierj8zgsT7zD/v
         X8xb2kfOoWIpuiwgPVh7aQlRtN2xdjB+ZjMSAEQ4sGpyNh92qsp4Chw6DGU/LF5IxEJo
         xWVDIAqgdh9Khdeo/dx72mBp0CbKjMSuPEXUfCl5gR/dzyrLdw3P8L4mA3FM5ZRZC70V
         l51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZdeUHSObScLykUe4QoredSw0PfmK1HsKibX2Ml9PaU=;
        b=TZBeEIr5P0a7ZI0n8joEnEg3JWri1q9oH3Gpj0EDlevjfp38Q8t/Z1jRFdk065F6vd
         OtKhipt5jLjppAZ6CqtblnLac2G6ZfB5ucByCokUP8xtj3vDDyOSVczNcX05I/r65NaU
         04LnMnuPVBk02cuES+OP0qv6sJXsiCOdO6DY/LUADY8UjAlrS2EJAm6GonYjN9pGXEQv
         qA8DNDFKg8eJZ9upfRDbn5i9lWZwPvKC2OrI8OVLBqQ4EXJFsr/swQunwWpms1fwUKfo
         liAJGfaTgNOuk8WrZBBC826QPsHzLo8p/Z1D+iXYLN/mjrroJ/iWFZ5OQHjdVmySJM3b
         ffyQ==
X-Gm-Message-State: APjAAAVLNOUw0Q1/KDD2xk23aFFJxOrHCUEr018vWTjSUthDLqiUboZG
        QMNRrEhBcLWRlup8o+RNIqCu2gS5V6PfItQl82c=
X-Google-Smtp-Source: APXvYqxpBxU30fU2zilZTxjfGRTWnUE32jmvZkTYL+MqnyfpQkabta1M5D5I1LzgJwuHYwBoMZRyv/D9XLlyYmpRmmg=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr867wmi.37.1581028028407; Thu,
 06 Feb 2020 14:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev> <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev> <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
 <20200131161630.GG10482@szeder.dev>
In-Reply-To: <20200131161630.GG10482@szeder.dev>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Thu, 6 Feb 2020 23:26:56 +0100
Message-ID: <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, Jan 31, 2020 at 5:16 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Jan 31, 2020 at 04:59:15PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jan 31, 2020 at 4:52 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
> > >
> > > On Thu, Jan 30, 2020 at 10:37:38PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Fri, Jan 24, 2020 at 11:41 PM SZEDER G=C3=A1bor <szeder.dev@gmai=
l.com> wrote:
> > > > >
> > > > > On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> > > > > > On Sun, Jan 12, 2020 at 7:14 AM SZEDER G=C3=A1bor <szeder.dev@g=
mail.com> wrote:
> > > > > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote=
:
> > > > > > > > Taking a deeper look at the code, I'm wondering it would ma=
ke more
> > > > > > > > sense to call wt_status_get_state(), which handles 'rebase'=
 and
> > > > > > > > 'bisect'. Is there a reason that you limited this check to =
only
> > > > > > > > 'rebase'?
> > > > > > >
> > > > > > > What branch name does wt_status_get_state() return while bise=
cting?
> > > > > > > The branch where I started from?  Because that's what 'git st=
atus'
> > > > > > > shows:
> > > > > > > But am I really on that branch?  Does it really makes sense t=
o edit
> > > > > > > the description of 'mybranch' by default while bisecting thro=
ugh an
> > > > > > > old revision range?  I do not think so.
> > > > > >
> > > > > > It's not clear what downside you are pointing out; i.e. why wou=
ld it
> > > > > > be a bad thing to be able to set the branch description even wh=
ile
> > > > > > bisecting -- especially since `git status` affirms that it know=
s the
> > > > > > branch?
> > > > >
> > > > > No, during a bisect operation 'git status' knows the branch where=
 I
> > > > > _was_ when I started bisecting, and where a 'git bisect reset' wi=
ll
> > > > > eventually bring me back when I'm finished, and that has no relat=
ion
> > > > > whatsoever to the revision range that I'm bisecting.
> > > > >
> > > > > Consider this case:
> > > > >
> > > > >   $ git checkout --orphan unrelated-history
> > > > >   Switched to a new branch 'unrelated-history'
> > > > >   $ git commit -m "test"
> > > > >   [unrelated-history (root-commit) 639b9d1047] test
> > > > >   <...>
> > > > >   $ git bisect start v2.25.0 v2.24.0
> > > > >   Bisecting: 361 revisions left to test after this (roughly 9 ste=
ps)
> > > > >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
> > > > >   $ git status
> > > > >   HEAD detached at 7034cd094b
> > > > >   You are currently bisecting, started from branch 'unrelated-his=
tory'.
> > > > >     (use "git bisect reset" to get back to the original branch)
> > > > >
> > > > >   nothing to commit, working tree clean
> > > > >
> > > > > I can't possible be on branch 'unrelated-history' during that
> > > > > bisection.
> > > > >
> > > > >
> > > > > OTOH, while during a rebase we are technically on a detached HEAD=
 as
> > > > > well, that rebase operation is all about constructing the new his=
tory
> > > > > of the rebased branch, and once finished that branch will be upda=
ted
> > > > > to point to the tip of the new history, thus it will include all =
the
> > > > > commits created while on the detached HEAD.  Therefore, it makes =
sense
> > > > > conceptually to treat it as if we were on the rebased branch.  Th=
at's
> > > > > why it makes sense to display the name of the rebased branch in t=
he
> > > > > Bash prompt, and that's why I think it makes sense to default to =
edit
> > > > > the description of the rebased branch without explicitly naming i=
t.
> > > > >
> > > > > With bisect that just doesn't make sense.
> > > >
> > > > If the range you are bisecting belongs or lead to the current branc=
h,
> > > > that still makes sense. And it's probably most of the time. So, I a=
m
> > > > not sure your objection is valid enough here.
> > >
> > > I'm not sure what you mean with "belongs or lead to" a branch.
> > >
> > > Do you mean that the range is reachable from the branch that just so
> > > happened to be checked out when the bisection was started?  Well, I
> > > have over 30 branches from where v2.25.0 is reachable, and all of the=
m
> > > are obviously bad candidates for editing their descriptions by defaul=
t
> > > while bisecting a totally unrelated issue.
> > >
> >
> >
> > If we take that simple example:
> >
> > * (my-branch)
> > *
> > * bisect bad
> > *
> > * (HEAD)
> > * bisect good
> > *
> >
> > It makes a lot of sense to me to edit my-branch description by
> > default, even if the range good-bad happen to exist in other branches.
>
> I still don't understand why it would make sense.
>
> Furthermore, how do you think you could avoid choosing an obviously
> bad branch to default to?

It uses the same branch that git status displays. In your example:

You are currently bisecting, started from branch 'unrelated-history'.

So it's not completely off to pick that branch by default for
--edit-description.

But again, I think you are focusing on a rather rare case, please
consider the most common case.

--=20
Marc-Andr=C3=A9 Lureau
