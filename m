Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF1C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2D92076C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 08:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aNOGqIKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgIIIYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:24:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:39017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgIIIX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 04:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599639834;
        bh=ffGvvfyavPTjlzu6KGINHoikMNsXfnzI/eqYtxB3BtQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aNOGqIKQKXLDTofCLdBc6yx9QbYOLRVp5S5aAVkALEGLkIvgi5jhV2kccJzrdefO3
         nZbVPjWyCv9gVepwT2qiFqwP3FuQWHDeJAaLVlIuBrOoCfwplki/kFcfvdV5uXVAI/
         UvHyIgvpf9GmNh/7b5y0xvLZzBFot9jcLVmuEPAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.150]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1k5rbF1Wvb-00TWBc; Wed, 09
 Sep 2020 10:23:54 +0200
Date:   Wed, 9 Sep 2020 05:44:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SAgwvwTXLP9+opZrpHWHHHE4TX302SDt87rYHXudsOQATU55Ly2
 q7OzbCNSN9EJQykmd93zMKyF/IyBB4JQ9wrmlGbGtb221lRMCE2mS//IgMfDW6YSldWCrAy
 paoG/4iTHj+MwhwVZtPem8bbTjRHRFQPssqkkR8mDipZPUEO7nggQsol6mP/ZyCjpczKa4G
 fmu87ESDjrLUNPxE7gv3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QF0RsNpcPn4=:GVlGSDVpae/G1SUjoFToav
 uz7VZq3kfCZ9GRZCVjgcb0U9VPb1mklYwnUlGdNHna0+zeRwJf+dBRB4Ugb1HjCpogYK/de6F
 T3dozMssHfiL/IkZT0pu+5woNULf62ixte03xnLo+dIXfIoZb1+DHV4i050EnmoRsBS/4xHAm
 E1VT282S7ZdNWjtRIaZek4MzyiLH2hyE7pgAMb24zXL6QwdU+3SrHv2MBRxX8xNunllrTl9Qv
 1J3ynMNFVfKrbsLVonsAB9ztLYQzvFm0YXQ6bQt6XnaZ5oBBW66jB1M90CTqAbe4sujtkyp1q
 8u2JuvRp6N3/rAVHpZwA4R9dUmXubU1A6jBE6JVTziPU9uXzR0HsaQs2Q1N6vHGEZx9j+eWmr
 mUmwoIopDgLntdURwha2/whc6QR7A8m+zRDykagS5w4tWQdw6LQVaWnknAqak4oBe+KPu2421
 l/ZHEaf9Yle5pBFVi8VH2jQJ9WsVr4KkzTUeR5ZynhyxCFadWeFAQgy0vRecY8JkF7gP2VEbn
 Ucs0oze4Eh2+x2O4bVrGha4m0exy/Fq9eVQw2eE+bvDUuY3Lr96DcUxEZ+qkpsd5OB9/oX3fh
 xTKmGHBHvj4JVp7V6E9IwWbyElssszGJiHkAbqeu+zP9DDXLKh1RqQuHd6rZblN5DjHL3TZEQ
 q+jvpqDzwTJyPYXaPR1xMgN92sCdhBw0smpxJq5atOUyHgkfWRagdpYkDbJD3Cs1s2HQSTkEO
 6mq+yN0a+oCq2MM3k0oDoWPmPuhbUnTg2u7qMe3ZC8gVSuHELWQDIPlf75dyafudIY5z2Cha8
 3MSpRdMc7nelPY1A0Fug5YZHKWRupsUyd7mRFDybqbVQpgJJOZv1R5XoQyRkUhcO+UU9zLOJo
 AF2b11llg0xFn35QHbAe9885e/j9afRkusYWmExlNasodbtPiqoUY/MsK+dvbTrWrxgErF2YV
 oedI9c/Vuz2gXhWqlgIDcgzPvUlTFVxMijv+Lo/NcrKIPs+F2x9qPs31viNE4RXCCK47lV5wP
 GBt2humKhyBemUEa1X+O6ehvZDylQJwW1fLDYyNnawE1pOYIb0kPsIc9xwQgDZ5csfkoJsKoQ
 CtvpEC3m6+jwIL3MYhZsi4hHIGz/wnUb1EVJ1DLvHvhYZHFY2Fmn9mBBzyT1NT7cfVz1cCjJI
 AjaY/ZzgLLSpFSHR/nSdDxY0hTYd88AkdvV/s9E3jejB9oLXyBFVDsxxXwV6/bM7u10xITzua
 Ejn22SmrqfbEJWv/8zF9K2D8TdMfAi6txR5erlg==
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
> > ...
> > So I think that the original `--force-with-lease` and the mode you
> > implemented target subtly different use cases that are both valid, and
> > therefore I would like to request a separate option for the latter.
>
> I agree that the use case in the second paragraph above does not fit
> what the "force with lease" option is meant to solve.  You do not
> even want to be forcing in the workflow so "--force-with-anything"
> is a bad name for the mode of operation, if I am reading you right.

No, you _have_ to force the push.

If you don't have to force the push, i.e. if it is a fast-forward, there
absolutely is no need for any of this.

In contrast, when you want to make sure that you _actually_ incorporated
the revision that is currently the remote tip, e.g. via `git pull
=2D-rebase` with a possible additional rebase on top that makes this _not_=
 a
fast-forward, you totally have to force the push, otherwise it won't work.

Ciao,
Dscho
