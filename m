Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2AC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A0A218AC
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CH8iHp/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIIIUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:20:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:35191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgIIITq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 04:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599639571;
        bh=PuKnpZaRXWkk4mYLc8Mn/mWvM3l0LexG043RzJPF0t8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CH8iHp/cQgRikI7pWszbp7gQh3OhgftIV/b4qrBKEkVmfKYNu2hQV91GX2VwfBxJ/
         /422VCa0qp/ygclvh2Uyh3AsyCkyOvE2k1nKTQhRoKhUdibDn5tss/oxQjaEtpax6i
         vEMnFOJcan4XqYTjSUvyME8B21j2+pYw4GMxYWXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.150]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1kmnEp0ZOi-00bb6s; Wed, 09
 Sep 2020 10:19:31 +0200
Date:   Wed, 9 Sep 2020 05:40:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <xmqqwo14z2de.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009090525120.54@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqwo14z2de.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a4qDd3qa+NZTeWz4fqRSV9EF0s9ioVrGD3WP6M5FhnLgU8omzSx
 0u7YuMrT6uH7c2Kt2BzPxwH63syUFyHa93x/TU2QW1laArnnmBj0xd1QtmXC1pxmJ5Ysv7Z
 BOmcujQurPpQvQLuQ1XNUKYOjAjVfaSFu6llCnHxo6fsBBlGwbFQNrtaCwT8DAvsfczWWJ5
 CurW+RdzFx7QBGY/u2X3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQl7UNSXGUM=:4+Ztq33QVAQzahwAP34+nF
 p/zQ9WPOzD3LbwuG8mlRz93hiVf4lquza83A6FMSskDu9byRAs83D1JnXYXZIktiXVB5h0aNh
 GbY2D54RP1LhiatgYEABlvWdktGSl5eL3h+3iI5AEHyRdqWYmtYKM+jXXU7tBQ+zwtALQLqjQ
 gyhstsGVltRLWGgMwvNisUfufqyQbDFKSpNmQcykuEd5cdOWaA+z1rQxgNQrbcpqjMT6mnHMU
 9oVFpmy8LbxPpUT5b9mOUmv4KZonw5biXsHvxPvP7c1jBfrwsX3QcPi3thlFj/THhf0GJSEDk
 Od2S4vZprZOIVQS+zZ/3m/Ndd5mfFlT7Y8CrLNYZq5gJIZqPCC3EdCwFOg6A9Yv8WNNWqGty6
 J3CPtekDjJJLECR8/QxAEtUUQBNMju3IwaGSi7pZE78mFZ1o0+HbG8zQxrcbhAXSuCjJt9KWa
 r6we8be6ZmQrq661tMHtDhk0uRrA1RYNUSOF62Vd0grCNPo66aPwhovqIkOKZHH0TECMBXc34
 R5naHEEs91Q4Lymp58Wi8IOExdKLMDb8NTa5L92o9G4vZATjhoFKOAC28+Hc7GM7A3pzVSP8f
 5BbFtpu35AKFc6tKZVlmQdcKzLSidUYqKmXieiy3SZ162TZaWMefkQNCApXdKKxZMn/u/FHlT
 fjrImGgK/1aqJq1c/zwHPaHw5VVgsDv/55UFOz8D4gQ5vS5Ww5jEjDrEaSZn6vQLoCDhcD4er
 mXGYrwmEo+y+tDgmjYYr8Bn+amQ9MsNMwIGJ63r1PRpTKwGZRK5veAsd/NUinkFY6Lwy+qEgI
 tq/mVKXfa3Mm7v9hPKvOuR9F1IIhNS6n4pDUN8D2rL6itsyEgtx2NcQNHevOUA13FJRY6sLjy
 j+YmvNa7LnxI2tHKyL2HYzLOKjafvsUsANkTVucwXqHxtZpNaox7rftUDghJ8HLFLg20DVfvY
 wPqtvVKCIeby3UAX7SeWasdMpvhT2COcdZIjnq9dRB0QBlO16TurxalZ2uSS129hlpbvNvD60
 1dsipr7vRfcxHTkh/goOqy/V+dxLZNWRns9lJmHpu+c5nTQ2Jz6VpTLBRCol/cMN4o2fw03Ox
 v1V3klAPK3F1ut8x/TPr+EoMlTKgKunU1ywwhfS/pGqNapzhXUhH7kgLDLMQ43+h4Eu3SrSzx
 I3l2sVodCErwBBKxeXsvQ/0Apw6B/rFCrsnNj+rRWluWzTOQlReEQcTxqSQh8vI0voLrj2VWp
 4C7wtnbMwlGv64rn2FqEuqmj5JLQyZcxMfEEM7g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Now, to be honest, I thought that this mode would merit a new option
> > rather than piggy-backing on top of `--force-with-lease`. The reason i=
s
> > that `--force-with-lease` targets a slightly different use case than m=
ine:
> > it makes sure that we do not overwrite remote refs unless we already h=
ad a
> > chance to inspect them.
> >
> > In contrast, my workflow uses `git pull --rebase` in two or more separ=
ate
> > worktrees, e.g. when developing a patch on two different Operating
> > Systems, I frequently forget to pull (to my public repository) on one
> > side, and I want to avoid force-pushing in that case, even if VS Code =
(or
> > I, via `git remote update`) fetched the ref (but failing to rebase the
> > local branch on top of it).
> >
> > So I think that the original `--force-with-lease` and the mode you
> > implemented target subtly different use cases that are both valid, and
> > therefore I would like to request a separate option for the latter.
>
> I tend to agree that that particular use case does not fit what the
> "force with lease" option is meant to solve.  It should be a different
> option, as you do not even want to be forcing.

Actually, I _do_ want to be forcing, but _only_ if the recorded remote tip
has been integrated into the local branch at some point (even if it has
been rebased or amended away).

And even then, I want to only force when the recorded remote tip still
matches the actual remote tip, i.e. I want to force "with lease".

> But probably I am not getting your use case well enough to give a
> good name suggestion.  "git push" without any form of "force" would
> safely fail in your "I rebased on one side, and the other one is now
> out of sync" situation already, so...

Yes, it would safely fail, but it would also fail in situations where I do
_not_ want it to fail.

Imagine that you and I work together on a patch series, and we actually
share the same public repository. Let's say that we also want to allow for
some crossing emails that might be missed by the other when pushing our
changes.

Since we are working on a patch series, there will be a lot of amending
and rewording and rebasing going on.

So let's assume that you just did another round of amending and rewording
and want to push the branch. What you will want to avoid is to overwrite
commits that I might have just pushed. `--force-with-lease` to the rescue!

Since you did not fetch in between pulling and amending, that is safe.

But what if, maybe even by mistake, you called `git fetch` in between? And
then you _did_ get my updates, but only in the remote-tracking branch (the
"lease"), yet those updates never made it into the local branch. And since
`git push --force-with-lease` did not fail, you failed to notice that I
had made some edits, didn't `range-diff` and took care of amending your
local changes accordingly, and therefore you overwrote my changes.

That is the scenario this new mode wants to address.

Note that a similar scenario can occur if you work on a patch series on
Linux, then push it to your public repository, then try to make it work
on, say, an HP/UX machine you happen to have access to (maybe because your
employer needs you to make sure that this particular patch series solves a
particular problem on that particular machine), and you need to amend the
changes there. If you're very disciplined, you will only work on one
machine until you're done, then push, then fetch on the other machine.
However, if you're less disciplined (or "just need to check out something
real quick on the other machine"), this new mode will come in quite handy.

Ciao,
Dscho
