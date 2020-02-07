Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6BC04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3AD21775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH2nUAl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGOQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:16:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40561 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGOQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 09:16:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so2872735wru.7
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tAIfDQxhHvtRjY77DLU+DfExlhO5a/yJNtyso3l4E78=;
        b=rH2nUAl651jksfJY/gpaLZvC8J5suCp2bLCcqJj1RjMpIMSfSnamTR11jiKwHLJrWe
         UYRrzjYGtSMOn3Nz2WMrQ4+/unOhXfcsGmPZbmzO2OX0qeP/rUioLIEvhd197wKHS/bM
         PTf6SO1SFqvXeWgHLnJzXHS72azbfnHIyx7YtFmnAc052tojj5CIkTvaJIyG/z3lF9iE
         EYVq74MYWjXhCaJqj3jpVcd/2p4jdNEmNxE6ejwzYr9ETli0e8SbGtHOPpDVY5/i9V4f
         QA3zkXkOD6Ol/nl2Tqn76Q5d7A0zfy/yyvlRQ8vBpdWe0IZlyzKySuoMEllQc3mjt7Ds
         bnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tAIfDQxhHvtRjY77DLU+DfExlhO5a/yJNtyso3l4E78=;
        b=Px2MwEw2qYpvOyN4EZveacQa5i3AdxkJV3o/gIuDAkUVKtHyQYPmOQbjl+5Kcl9pSp
         Lf2w7Q/JcfYp28NKRF4bd5Hn6YZcnSoCvJTX6MCYF9CFMTLhmz2FgHITKchQFA6UW95V
         e+pu53dYz9McNcyTbvhHotQPmsgNl/YON3auI09Xz4eiQs6Pf4wHFX/OvRV3h4cg4Y5O
         zUAOrvG4sKEBH2ttvTiJw0VD4MRm2z6M2Yc3R9+NMip7+DQHZcfJJ7gHctm/CaUFSsvU
         sjOIRD9aGFIA4wnQcwmvp4plH1cfC/BNaPoztfip+/1aBgLTuyA7z40TpbPyCyiwr2ni
         q0oA==
X-Gm-Message-State: APjAAAVGog6pfSgVhfyn/8HizX4rm2Fh5mvIJpMTU8U947GOEUOiHLbG
        JdAHEB01BfMV7QgPcu7HFJ+vLCw333WoKyNxpno=
X-Google-Smtp-Source: APXvYqzPTz1u9lpYFdIlIXu0EN3ZT+M7b8mLhzXOVln7fcsyffrVyZlFC7giwBPG7I/kwE5QGu8A2rDVnRmWpNGtsj0=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr5028971wrl.96.1581085005345;
 Fri, 07 Feb 2020 06:16:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev> <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev> <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
 <20200131161630.GG10482@szeder.dev> <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
 <20200207100247.GA1111@szeder.dev>
In-Reply-To: <20200207100247.GA1111@szeder.dev>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Fri, 7 Feb 2020 15:16:32 +0100
Message-ID: <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
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

On Fri, Feb 7, 2020 at 11:02 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Feb 06, 2020 at 11:26:56PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > > > > > > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine w=
rote:
> > > > > > > > > > Taking a deeper look at the code, I'm wondering it woul=
d make more
> > > > > > > > > > sense to call wt_status_get_state(), which handles 'reb=
ase' and
> > > > > > > > > > 'bisect'. Is there a reason that you limited this check=
 to only
> > > > > > > > > > 'rebase'?
> > > > > > > > >
> > > > > > > > > What branch name does wt_status_get_state() return while =
bisecting?
> > > > > > > > > The branch where I started from?  Because that's what 'gi=
t status'
> > > > > > > > > shows:
> > > > > > > > > But am I really on that branch?  Does it really makes sen=
se to edit
> > > > > > > > > the description of 'mybranch' by default while bisecting =
through an
> > > > > > > > > old revision range?  I do not think so.
> > > > > > > >
> > > > > > > > It's not clear what downside you are pointing out; i.e. why=
 would it
> > > > > > > > be a bad thing to be able to set the branch description eve=
n while
> > > > > > > > bisecting -- especially since `git status` affirms that it =
knows the
> > > > > > > > branch?
> > > > > > >
> > > > > > > No, during a bisect operation 'git status' knows the branch w=
here I
> > > > > > > _was_ when I started bisecting, and where a 'git bisect reset=
' will
> > > > > > > eventually bring me back when I'm finished, and that has no r=
elation
> > > > > > > whatsoever to the revision range that I'm bisecting.
> > > > > > >
> > > > > > > Consider this case:
> > > > > > >
> > > > > > >   $ git checkout --orphan unrelated-history
> > > > > > >   Switched to a new branch 'unrelated-history'
> > > > > > >   $ git commit -m "test"
> > > > > > >   [unrelated-history (root-commit) 639b9d1047] test
> > > > > > >   <...>
> > > > > > >   $ git bisect start v2.25.0 v2.24.0
> > > > > > >   Bisecting: 361 revisions left to test after this (roughly 9=
 steps)
> > > > > > >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.=
24.1
> > > > > > >   $ git status
> > > > > > >   HEAD detached at 7034cd094b
> > > > > > >   You are currently bisecting, started from branch 'unrelated=
-history'.
> > > > > > >     (use "git bisect reset" to get back to the original branc=
h)
> > > > > > >
> > > > > > >   nothing to commit, working tree clean
> > > > > > >
> > > > > > > I can't possible be on branch 'unrelated-history' during that
> > > > > > > bisection.
> > > > > > >
> > > > > > >
> > > > > > > OTOH, while during a rebase we are technically on a detached =
HEAD as
> > > > > > > well, that rebase operation is all about constructing the new=
 history
> > > > > > > of the rebased branch, and once finished that branch will be =
updated
> > > > > > > to point to the tip of the new history, thus it will include =
all the
> > > > > > > commits created while on the detached HEAD.  Therefore, it ma=
kes sense
> > > > > > > conceptually to treat it as if we were on the rebased branch.=
  That's
> > > > > > > why it makes sense to display the name of the rebased branch =
in the
> > > > > > > Bash prompt, and that's why I think it makes sense to default=
 to edit
> > > > > > > the description of the rebased branch without explicitly nami=
ng it.
> > > > > > >
> > > > > > > With bisect that just doesn't make sense.
> > > > > >
> > > > > > If the range you are bisecting belongs or lead to the current b=
ranch,
> > > > > > that still makes sense. And it's probably most of the time. So,=
 I am
> > > > > > not sure your objection is valid enough here.
> > > > >
> > > > > I'm not sure what you mean with "belongs or lead to" a branch.
> > > > >
> > > > > Do you mean that the range is reachable from the branch that just=
 so
> > > > > happened to be checked out when the bisection was started?  Well,=
 I
> > > > > have over 30 branches from where v2.25.0 is reachable, and all of=
 them
> > > > > are obviously bad candidates for editing their descriptions by de=
fault
> > > > > while bisecting a totally unrelated issue.
> > > > >
> > > >
> > > >
> > > > If we take that simple example:
> > > >
> > > > * (my-branch)
> > > > *
> > > > * bisect bad
> > > > *
> > > > * (HEAD)
> > > > * bisect good
> > > > *
> > > >
> > > > It makes a lot of sense to me to edit my-branch description by
> > > > default, even if the range good-bad happen to exist in other branch=
es.
> > >
> > > I still don't understand why it would make sense.
> > >
> > > Furthermore, how do you think you could avoid choosing an obviously
> > > bad branch to default to?
> >
> > It uses the same branch that git status displays. In your example:
> >
> > You are currently bisecting, started from branch 'unrelated-history'.
>
> Yes, that's the problem: it shows "started from branch", not "On
> branch".  Conceptually a huge difference.
>
> > So it's not completely off to pick that branch by default for
> > --edit-description.
> >
> > But again, I think you are focusing on a rather rare case, please
> > consider the most common case.
>
> I do focus on the most common case: I'm on branch 'foo' built on top
> of current master, when a bugreport comes in, and I start bisecting on
> the range v2.12.0..v2.16.0.  It can not possibly be considered that
> during the bisect I'm on the branch 'foo' during the bisection, they
> are totally unrelated.


And usually that bisection is ancestry of master, rarely unrelated.

Also, when doing --edit-description there are comments like:

# Please edit the description for the branch
#   unrelated-history

What else do you suggest?


--=20
Marc-Andr=C3=A9 Lureau
