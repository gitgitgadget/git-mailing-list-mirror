Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C629AEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGUKEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 06:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjGUKEN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 06:04:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1FFC
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 03:04:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992af8b3b1bso282040066b.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fullthrottle.ro; s=google; t=1689933850; x=1690538650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANtNmhma7OF9YmwGoKNb3zj56TM/PMG27AA1MMfwwwk=;
        b=B4P0wazDEtksC5pIoK2Xkg32Ri1RVF56u/IoOAQeVdR0cwKEKpgWkXmi6OvoBpUKco
         mfIITnQveulXJNzXh2Nd9V3rW7f2onvygssW2VTSrvOwzXmic1CId9k7mtfLZHBVcrI9
         +9ul15TOvrVvr5HUXzLF1Rz5yVSGjP0ZGamqieUyf3euCi/KovsVnXaK72D1pV0DU1bx
         Jc8HJm7lXl0gVA3S01k1JWtr2lsMtF8e/OnDFfzEFb9lrgchUF9Vg3Awd9DU54PgVL6F
         4BVCUiXIFYDL1fK0krZKrMUZCpPdHgRKIiXP2CRGDVQ6YowQXlovavoyNYrbMO6o8UWn
         0LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933850; x=1690538650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANtNmhma7OF9YmwGoKNb3zj56TM/PMG27AA1MMfwwwk=;
        b=aG+ALDfKkcvg+Ty8jRg302VYP0oiwSEc7cqKwTn+roSnWmRfKT41IFcsYRwYOUoCVP
         UBrDLQphAR0ler9LkFHq9J9UDcycKbfS1EGNCxTF/Bi6PO4/2+oTwSUDr9up19PAli3t
         cw+6RQKXTVKBlMI3dllvLEZMcscPHV4nTDaQsMFgHJKQPxvJ4CI/0LPYlqAAqyVORlIh
         6uD8fD24mzt9/FP6TjtOITU0a4Cup0Td37UOAbve+VY5NStQ6rbBGB260AuyD68+mit5
         ogrSXElfYV+swOHvFHyShqed1ZZue7lEV1fS4c8qF3XxJckY/CPQxb2SQlJVlUvK/F8T
         RSBw==
X-Gm-Message-State: ABy/qLan45c52gDUC0D3FLaHrVvo6wAaQpFckrMGKTGODx1cBwM23r7X
        wnT8ko5SkQOq4PYe2l3NXGAahC5dbvJP5wOOynhmZyL5AosANMCrWqo=
X-Google-Smtp-Source: APBJJlHzdAyAq73x7jrW9abc1oayMKngndcF5ecszwIp7ZuOsaC3KX5g1V8LXuk7IfcDyqtHXrerzufccdE/6HLxcUw=
X-Received: by 2002:a17:906:289:b0:99b:237e:6ee with SMTP id
 9-20020a170906028900b0099b237e06eemr1576887ejf.30.1689933849616; Fri, 21 Jul
 2023 03:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAH3jj7fS3wziLfnAfKz49W+aZVPvF8Nm9UVBMWyeHLvYov7A-w@mail.gmail.com>
 <20230721065833.q2zshssu4clbzxq6@tb-raspi4>
In-Reply-To: <20230721065833.q2zshssu4clbzxq6@tb-raspi4>
From:   Radu Dan <radu@fullthrottle.ro>
Date:   Fri, 21 Jul 2023 13:03:58 +0300
Message-ID: <CAH3jj7dDazpYGdJsixQ9jpwdoJMSS+uXM-xkAZT2UR7h81enig@mail.gmail.com>
Subject: Re: [bug] lots of changes including .gitignore, many rebases, can't
 legally share the repo
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sadly aware of the difficulty in debugging this, so thank you for
caring! The code isn't super sensitive so I'll try to get approval to
share it (privately) but the client might insist on a background check
(commercial). I'll only do this with your consent, and after we have
exhausted all other options.

> Is the repo you are talking about public ?
The repo isn't public but it is hosted on github (private).
The main reason I reported it is that github was able to rebase the
two branches with no conflicts, so the problem seems to be related to
my local copy, which I made a backup of before cloning the merged one
so I could try to answer some of these questions.
Some weirdness (5xx errors) started happening to our deploy pipeline a
bit after CI picked up the new branch which might suggest that
something similar happened with those copies, but it seems to have
recovered so it was either an unrelated fluke, or this something that
only happens on certain versions of git.

> Does settings/local.py exist is both branches, origin/test and main ?
I can't really tell you what `main` contains at the moment since I
don't know how to open it, but assuming it was up to date with
`origin/main` (high likelihood: it was stale for almost two years
prior to yesterday), then `settings/local.py` only exists on `test`.
The two branches have diverged significantly over time: CI picks up
`main` and deploys it to production (this would have been the first
such deploy), whereas `test` is deployed to staging and has been the
main merge target thus far.

What does git ls-files --eol setings/local.py give you ?
Nothing:
% git ls-files --eol setings/local.py
%

> Is there a .gitignore, which is different on both branches ?
Yes, this is what I too suspect is the root cause. A placeholder
`settings/local.py` file was added to `test`, and then gitignored so
that devs can override their own settings without pushing them back.
In this case, the error message makes a lot of sense since that is
exactly what would be happening: since `main` does not have a
corresponding file, all local changes would be lost.
The files are however bit for bit identical:

9b4988c3a70e41db3b5ef8eb2d9d1eb92fc08c68  settings/local.py <-- `test`
in bugged repo
9b4988c3a70e41db3b5ef8eb2d9d1eb92fc08c68  settings/local.py <-- `test`
after reset --hard

Weirdly enough, the error goes away after the hard reset and I am able
to checkout `main` even though the conflicting file wasn't changed
(other than maybe some internal flag)

> The error message as such is probably the best information that Git has,
Mentioning gitignore in this case might be a good idea though

> what does git add --renormalize . give you ? (Please do not omit the '.')
That also solves it!

git add --renormalize .
git status
On branch test

Your branch is up to date with 'origin/test'.

% git checkout main
branch 'main' set up to track 'origin/main'.
Switched to a new branch 'main'

So it seems like there's a dirty flag that's not updated to reflect the sha=
sum.
In my book, we can write this one off as random bit flip caused by a
cosmic ray but if you'd rather investigate it further, let me know how
I can help; I've kept an archive of the offending repo just in case.

Thanks and best wishes!

On Fri, Jul 21, 2023 at 9:58=E2=80=AFAM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> On Fri, Jul 21, 2023 at 12:52:30AM +0300, Radu Dan wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > > What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >
> > % git stash
> > No local changes to save
> >
> > % git commit -m wtf
> > On branch test
> > Your branch is up to date with 'origin/test'.
> >
> > nothing to commit, working tree clean
> >
> > % git checkout main
> > error: Your local changes to the following files would be overwritten
> > by checkout:
> > settings/local.py
> > Please commit your changes or stash them before you switch branches.
> > Aborting
>
> First of all: thanks for your feedback.
> However, the situation on your local disk is hard to debug from remote.
> Which could be frustrating on both sides, so to say.
>
> So we may come further by asking some questions:
> - Is the repo you are talking about public ?
> Does settings/local.py exist is both branches, origin/test and main ?
> - What does
>   git ls-files --eol setings/local.py
>   give you ?
>
> - Is there a .gitignore, which is different on both branches ?
> - What does
>   git ls-files | grep -i local.py
>   give you ?
>
>
>
> >
> > > What did you expect to happen? (Expected behavior)
> >
> > Switch to `main`
> >
> > > What happened instead? (Actual behavior)
> >
> > Still on current branch
> >
> > > What's different between what you expected and what actually happened=
?
> >
> > Better error message
>
> The error message as such is probably the best information that Git has,
> the question is, which changes does Git see ?
>
> Another question :
> what does
> git add --renormalize .
> give you ? (Please do not omit the '.')
>
>
>
> >
> > > Anything else you want to add:
> >
> > First bug in 10 years of usage, great work!
> >
> > > Please review the rest of the bug report below.
> > > You can delete any lines you don't wish to share.
> >
> > [System Info]
> > git version:
> > git version 2.39.2 (Apple Git-143)
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > feature: fsmonitor--daemon
> > uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Thu Jun  8 22:22:22
> > PDT 2023; root:xnu-8796.121.3~7/RELEASE_X86_64 x86_64
> > compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
> > libc info: no libc information available
> > $SHELL (typically, interactive shell): /bin/zsh
> >
> >
> > [Enabled Hooks]
