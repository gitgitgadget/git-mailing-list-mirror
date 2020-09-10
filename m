Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E903DC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 13:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCD920C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 13:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PA+vI6j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgIJNYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:24:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:57877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730674AbgIJNLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599743410;
        bh=NO5ip9xfjsAThbvXnmJ9bW5tm2vrRUeomD2espWIqiQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PA+vI6j6I3CFPyH+501NgrEqxiMYso/amiz98FHmOiwq0Iw8e+O8rs/q/omBEPxeM
         I/PrEvByOi9HPG5f4tUlW5j79ks9LfroOyQn5XkPzsfKGsXg/vYwK963ELqxoU1kSf
         Dp4OigEjC97XikQZJ1nnf+nXCSNZUVf4MY0iuqGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.191]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1kO1jU1Sqi-00C8EV; Thu, 10
 Sep 2020 15:03:32 +0200
Date:   Thu, 10 Sep 2020 12:22:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqr1rcxdsu.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RWzUcMcRrzuo7EkiNYQ9E6sjzZ7QEPD7e+2nlbFvOq29t0WGHnb
 Ab9i0Evfa/kfOeGO5UZxhyfpluXANhH747wQaG1TBXeNMTnVSf+Yusyzya6VhKeEK13DAZ3
 j7as/bx09xy8qlWr6xFUU6nkyJedUERzVrORDemC8sproqAbAN5aNKnvX1ltOLlJejq0hHJ
 NA1uFGUM6PyPWEsO9hw+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kf3r3GATg3U=:Z1gUQJq2RUIaUNnh2Kzhmi
 EfM0Io+dNmQT1ivY9ERMh0X0wBCVD2BCZx6Qi7T6aRxN2rcWoSESI/VoqZqIsHVAWBmVyc62F
 //gAEeM1BoSakiwgh8bbvw5303OnQT599KYdAXRkeHTJkpRGavehie4YXCzUymf2P3hdEnT06
 +kYw+4ZeHEEJMagOZmejhPB80z8sgkNZ7w5QU+maCt7oyst2B6Pf2Avgq1QoneTNfCOrQ7cx/
 RiUJYpJJC2xtr5TIoKjyi4pXnNvznPkSiPh1vqGj0MGUbGPgW6/z+Dgj0C+X68dlxpXE8Jm2e
 Gy7Wx2umgQKB9mTCPfNr11oSg6TJG4IOR6bpe2pDNE+aq92CMJgA0L9X2aJfkXIcQCr5ukwXB
 7GTweJhCgQsav3twEqRkkb90CJrIHxbJ0IynGfsmtSe/YWDN3dxwTIA/ij+umWnmcgEeUNVS7
 iuSUEYVMMZUztBl4ftEfoJM4DE41Iw5Hx9Qk8aTV0eePz/JkBRlITx5zAHpn3+zt5Ylwr5Z/I
 lBH8et8uDNVKndyuj2nYlfJw1gBfbw8XsaLmSIU/og62TaU2AE6qFLrNVzxJ6v7RttWjRP+YF
 5F0ECYRx9J+R3ezJMDmXW+gfCNfBmtffBUhQ/A9qG559ykOcqeZcYscngAN+qEJjF920yZarJ
 +l0J/lAOIzCNSj1YAi8fJ/F8g6pyrJSzie76p8yRdqK4h6UPSeALfo4mSybkSHffS3ysfA0Zj
 oS2eD2JhOwdssfCSU0ATdLYRApcMT7k+83fKVH+qvuMoqg5zno7dA0kDodXFp3VwS6YkQXIHG
 ETbQwxo2z5bLSU6GDrnX2YPmE2zgkS2HO5TY6VfWzXj2KGGHG8coQi9GOu6ZbacGDUi9XFA4x
 HlYoXwhn52cIczXE1bSc2gGUURshqXnBiffOJEUOOuGGDvucWw1meoxyt5BDs55/6jQCc1Fem
 9x0Apx5gi2P77qLxf6SKQx3VcyDHOwtyUbpHzphirUn61IIKo5i/mJ982bUgNSuDRVvcLwNMk
 PR+QgalzbMf2knFlaWuGUoCtcGhOhlx5kn/QIfdyi4n4U+Nfo1CczI7mwI5dHoHVW2TK4K4sY
 TFdUXCTaAMyt3zKlvAl+CqCL7N3eISt2oUnpvTKoSJbuGifJgozzwvSZeFmZT+H7YfobOaqT8
 /wf3v1QtA0W118vqKh9eXBNMpwcSHgUJ2FVnSfpClM83r018vRIQqIi1bka7oYVJegPQHsCaY
 bUTua5AkPJIIVt+4vrWVFIf4pPs2cvdrvs1+BuQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Sep 2020, Johannes Schindelin wrote:

> On Tue, 8 Sep 2020, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > Now, to be honest, I thought that this mode would merit a new option
> > > rather than piggy-backing on top of `--force-with-lease`. The reason=
 is
> > > that `--force-with-lease` targets a slightly different use case than=
 mine:
> > > it makes sure that we do not overwrite remote refs unless we already=
 had a
> > > chance to inspect them.
> > >
> > > In contrast, my workflow uses `git pull --rebase` in two or more sep=
arate
> > > worktrees, e.g. when developing a patch on two different Operating
> > > Systems, I frequently forget to pull (to my public repository) on on=
e
> > > side, and I want to avoid force-pushing in that case, even if VS Cod=
e (or
> > > I, via `git remote update`) fetched the ref (but failing to rebase t=
he
> > > local branch on top of it).
> > > ...
> > > So I think that the original `--force-with-lease` and the mode you
> > > implemented target subtly different use cases that are both valid, a=
nd
> > > therefore I would like to request a separate option for the latter.
> >
> > I agree that the use case in the second paragraph above does not fit
> > what the "force with lease" option is meant to solve.  You do not
> > even want to be forcing in the workflow so "--force-with-anything"
> > is a bad name for the mode of operation, if I am reading you right.
>
> No, you _have_ to force the push.
>
> If you don't have to force the push, i.e. if it is a fast-forward, there
> absolutely is no need for any of this.
>
> In contrast, when you want to make sure that you _actually_ incorporated
> the revision that is currently the remote tip, e.g. via `git pull
> --rebase` with a possible additional rebase on top that makes this _not_=
 a
> fast-forward, you totally have to force the push, otherwise it won't wor=
k.

Maybe `--force-if-incorporated`? Originally, I had in mind to call it
`--safe-force`, but that might be too vague.

BTW I think the patch needs to cover a bit more, still: after I run `git
pull --rebase`, the local branch will never have been at the same revision
as the fetched one: `git rebase` moves to an unnamed branch before
replaying the patches. So I think we need to see whether the remote tip
was _reachable_ from (not necessarily identical to) any of the reflog's
revisions.

Ciao,
Dscho
