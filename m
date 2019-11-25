Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1DC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3862075C
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 22:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gYpQ7hJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKYWxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:53:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:54245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKYWxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 17:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574722381;
        bh=Cip9HOF2Gvyg0E7/2WQ2OEKayuWn1RshqMZPgMv+Pkc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gYpQ7hJ4rLaJIpXfADck/1NfxecICwOue/C1ztl6q0cR6lIxAraRWcOMJMnZIS5t0
         cJHGvAf7o5Cqwe1EI0lRRpYkw/9Q0AMgCTivdMZ/rzyzS9nDfWBktp4TWFXxiiRiii
         BP8vUPjSwt8gwTjey+8E/e2JjZe6GXJe9z9H4JEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1iOsYp2EPq-00TDjn; Mon, 25
 Nov 2019 23:53:01 +0100
Date:   Mon, 25 Nov 2019 23:52:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
In-Reply-To: <CAPig+cRg1WchC=-4qc51KQLgYewiYtEsu+RTf=_jbw3sZznjew@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911252343350.31080@tvgsbejvaqbjf.bet>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com> <pull.467.v2.git.1574451783.gitgitgadget@gmail.com> <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com> <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
 <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com> <94573071-556b-caae-b159-40c168a08f44@gmail.com> <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com> <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com> <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
 <CAPig+cRg1WchC=-4qc51KQLgYewiYtEsu+RTf=_jbw3sZznjew@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O7pTt71t0k9JvLW2HufiBS0p8QykmgkhNr7/Gl2cORtMaSFoxjs
 J8uPRMT0WghdLOU64E+h97A+OIzRSPtAIPe/KNaTprw17ZeF6KvnPZJX/z59gtHXomuVxvC
 4YeVtq5AThxXA7bZGoUOjKZbsq8uCZNybe5+aexxex611A/oSr5L3AUlVyJanuZh5BT+LOf
 I6rv92Fa6Fi2bqyMhg7gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:79HWZz+JukM=:k1mZfktpFajmZVTJwoWja4
 rYJLvmhDY3umnN94xvSxH3TQ6vHWbNIrr95TmzZLvYvZOkdibrWiNUzGa8KdT7QZ7iF7fUEcm
 QEd5IzbMm2IAiT51GRY/uh1UpzowImfCrCkbws+3V72jZQV9nrnoNzkjiUTKAescsTPikdFpJ
 LUqfEWUP0F/ur7p9yE9VZJ8XwAJnnWGELVEKleWq+mEYZV4ERVHehRiEp7sY+zkXu1qVmjQ4Y
 0+kzfIQAD8UMXLClLn4OR65pwuK3UzqY6fGrJ1mVIlUzd8A0osoy7dLEAnAc+855k2xWzgDB+
 EHf9WUTq0N5CJeBC+PUQ8e+vCAPTDp1XLuJ9EB+KasH1o3rZrPWbuskfuL+0+vNNlYpYCRe61
 UI3vtjXVjnF9O2UwlnIDjYIf9KUfLSyllh8yCc33MW3EPy2OVpFuhxkhSta0oMhTwrVrAdS+L
 MUrBxrE/GGfJJiZO8goqpOn2XUsvJUYdMHCYU4Vm+WLhFyYW5ate/83mrjnPjoxvymV0kc96B
 ANS/wZM4y1zFzMX6BH3/9pqsOB33S/AdqS73OXRmoZZ3W0rWJIRlex6JtC/I7SnWd3/QmhMAH
 GePzdbSOJwWKraOLW37+e659lyFfBLNOy57PQHilMWpBiJOoH5f8Tb7PbhlSs6/R3sy1tEAZe
 y44GSTIq5Jxu0W49U7Pd5JkZ4XGa2ygAs03DcK1M3wjzOp4cMNPkVDVSYAb2hecfggWNbZsnm
 uRM3dkLTx83rqpH66JmtbFf3Y5TjCu+U/gfYzQW6LgSJUylGa8qYK67M+p9n4y1bljou8woFc
 Vtyfeuc0rqeJ2AGS1RVIXgYNDG9YhoF6HcnMahFpcDWvI+Wm9cQrvmTmKeHm4k0aZb11b3yrl
 y/K5bY9f+HsU9IeHcjIGCi36qhOTf1pU/i3eWtvfmeYBmLbgRFjmOgMZgONIiVyGopYSsJh8U
 tyEBLRLrWU4hBVBwnUgigXuvrzvkHUFf00M+8Cz8MYkYyWgJ21Atw+rScyQcwr1cCvo9b89s2
 kE93cMIakDszY8WTWEpltvpFaYbGVqVDc5Ft+C9fDHQzOQqe8Su+s1okC+jGhX6etRgNSmQnu
 61w6IuVOEDQHXnFLzxcDWX/Ou4iWXfqBTgq5SFz5GFkmIimxGaktMBBOJRH0aO8BXzV7ghduv
 viZQzNFG964V/5a9jmA1jvQ0C9jwY26ZCmwgQ1qyz3julYLYZ2Lzvgh0wTeNBBhdt6+m/XjHz
 fcV18J3mgEY0p3vQ0I6OgmHuG4vKqk+bzH2ajPJglsfLNJKSs4KVBRwgYhRY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Mon, 25 Nov 2019, Eric Sunshine wrote:

> On Mon, Nov 25, 2019 at 10:54 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 25 Nov 2019, Phillip Wood wrote:
> > > On 25/11/2019 03:00, Junio C Hamano wrote:
> > > > That "git rm -rf ." scares me, though.
> > >
> > > I know I'm not too keen on it my self but we need to empty the workt=
ree and
> > > index if we're going to switch to an unborn branch
> >
> > How about `git worktree --orphan does-not-exist unborn`?
>
> git-worktree doesn't presently recognize --orphan, though it would be
> nice if it did. In fact, I clearly was thinking of --orphan (along
> with -b, -B, and --detach), when I wrote the implementation, as can be
> seen from the commentary in one of the original patches[1]. That
> --orphan never got added was either due to an oversight or it was one
> of those "we'll add it when someone actually needs it" deals.
>
> [1]: https://lore.kernel.org/git/1436573146-3893-11-git-send-email-sunsh=
ine@sunshineco.com/

You're absolutely correct, of course. I actually had looked at the output
of `git checkout -h` instead of `git worktree -h`... And `checkout` does
have that `--orphan` option.

But from the documentation at
https://git-scm.com/docs/git-checkout#Documentation/git-checkout.txt---orp=
hanltnewbranchgt
I see that the command I had in mind does not work as I expected it to:
`git checkout --orphan new-branch $EMPTY_TREE` will fail with
fatal: Cannot switch branch to a non-commit '4b825dc642cb6eb9a060e54bf8d69=
288fbee4904'
(and the documentation of the `--orphan` option also suggests to use `git
rm -rf` for the use case under discussion, so there...)

Sorry for the noise,
Dscho
