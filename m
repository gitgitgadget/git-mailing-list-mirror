Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A13C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 08:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FCF223FB
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 08:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ascnt5MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508667AbgJVIwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:52:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:39429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506699AbgJVIww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 04:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603356765;
        bh=vEyVg8ItLguNjR0chfWm7hFOKnInb3f9ILDzjEdSFWc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ascnt5MQpJjFoJrgXMn9chuYf+o9+g7uU0sXl604IDni9E8Lp7lmdkMbFLRA9QPLr
         zk+5uZ2FmzUaF7P6k+39CWHhpPo/dMekEdpRjzAR/OQaEV2Hpt5Y64+naY9B4xNOUm
         XkbVWwxRyOC/T53L1ZI8HPboj6yRAPuftaRyGXBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1kqcks2BHL-00LqMg; Thu, 22
 Oct 2020 10:52:45 +0200
Date:   Thu, 22 Oct 2020 10:52:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sangeeta <sangunb09@gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
In-Reply-To: <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com> <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com> <20201021162044.GB111581@nand.local> <xmqqr1pr73ve.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lvYVIJdoc2GbSzrp4cQnbKSnlsmw7psMirdIqHGVcjbIMTYJJSb
 SVg24DNLxxQUPDVkEagT6TJb2774V0meAuIAMsvjZI/AyyuRzxum1Bf7Zqf1a1QTXf6lH9q
 F02y50gQJZfs4KBD2aLW3Kas7UJ+OI3TrSsE/d9Bn67c7QuRZae5ngxEtvLwPbECpf9/yPA
 bP1f4A+HDwiPAzUnAjDTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZEkKDDu9y1U=:bAp1l0KR1Ie8vzCpNBdEFx
 UZmaP8X15ucBPQpPXqBwj8/vzEfXrgpVOZvS7wEIrUFIfvKZJ184fhyp5I6vJB4sC6dM1MpPe
 t3U8ozRNAlXKN0NtZZ6OVOT4sSUb/ZUJqOgUj9AqItrfgbFpdU9pomFQ8R8WIvSmJfhnGhRyW
 AOvEDFOSyvfcDIYmCAGb6loOvds3OHP+89kPFGvZ3aurVaCMjZ+akeTxDhnNYD23wEK+kp2+C
 SqxDhj1RRgTooEOsABGjjISolnodcxQgzIjC2ekbV9T1ni6EIg/nG0q+cLSMGIUZhk8X8gmPJ
 3MXy37xrdEgtGRImc3mRBqGn5chCc49V6xxl6MecgYKbHKm4XNXahS5mXcejFF5b+U2EBMHJ0
 1o5kLu9gjyEOWXxGv9gcbEXBez9RKz2QW3y+HwbYLc0S0JI3oUDg8TLIR50EGNQikSkROR/ig
 7F7u6mcb5Y2JHAL/maOspkOY50LsNrxVIU4md8GSbIfBdYG6B+/xg9EyfDjXwtCX/8344/dhF
 woCg74Kjvio/5ZJUmrq7Fhv4Jo1f2/66dmLtf2WBR/mQTeJPcO8JL0ljvoB9+U9UkrbkPzplg
 SBQlWTEvCIPHsTGKI8t+GrQ4WikBTzOdt/9pP4M8LHyp6zZqRehf6ua8m2jrQcYvyQK4l8wHe
 qJqQJ7iMiUxm128ubmTgfMFbvf3r7IvUK9UdC75V1ipswunQNUzjrcIIDvFonyjL+uYlo1uZk
 kEpXAUpfIG9F6RizSg/mmlk2h42ODNDrzRba0wax6yWxrsZR2gVXQ+aNYA0i3g+6RQCno6Bd3
 J/ILm6uQXcnJO9Eg5W8NX8DH4p6XID2TyT3e4DWKi++sN6X/QR2BGBJ2pqPPU2QoorR87MxaB
 bxxQp6MDGlH0KtaMehAaOwRx0RFNH4CuShrak6WZs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
> > I'm not sure that that's the case: Junio pointed out a while[1] ago th=
at
> > we'd have to answer the question of "what happens if I'm in a
> > subdirectory that goes away during some point of the bisection?". I
> > think that you could probably find an answer to that question, but the
> > fact that there isn't an obvious one seems to indicate that we're goin=
g
> > down the wrong path.
> >
> > I agree that it would be nice to run bisect from any directory, but it
> > may not be as easy as I'd hope.
>
> True.
>
> I would not mind all that much a single "git checkout ancient" that
> makes the $cwd go away and confuse the user.  But a bisect session
> would jump around versions randomly (eh, logarithmically?) and you'd
> end up switching out of a version in a non-existing $cwd to another
> version that has the directory (created internally by mkdir(2)), and
> I'm fairly certain that your phantom $cwd that is not connected to
> any other filesystem entity and the directory that should be at the
> same path in the newly checked-out version are different filesystem
> entities.  I'd rather not have to think about the interaction
> between git and the system after that point.

By that token, we should also prevent `git rebase` from running in a
subdirectory, but we don't.

Besides, this only becomes an issue when the directory becomes _empty_
(including untracked files) because we don't remove it otherwise.

I am actually more worried about bisecting between revisions that replace
the current subdirectory by a symlink or something.

But again, this is pretty much precisely the kind of scenario that we
_already_ allow running into with `git rebase`. So I see little point
refusing `git bisect` users to run in a subdirectory.

I know that _I_ often grumble after `git bisect start` fails, then try to
pull out the last remains of my patience and insert `-C ..` or `-C ../..`
between `git` and `bisect` and _still_ get what I want, all while shaking
my imaginary fist at `git bisect` for forcing me to type those extra
keystrokes.

Ciao,
Dscho
