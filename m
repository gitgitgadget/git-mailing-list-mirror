Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600CAC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E45520853
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="S7Jaak9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGAVUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:20:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:36527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGAVUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593638434;
        bh=x4RGqgOJcWgG9ih7p0qZyIQiVHdJ09Cu2K8AHPLOdtw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S7Jaak9fLz3hup7XfsPeo2EH55yjZgKqoYxQT1QAu+SffIbhS4BmFGUAa93EmvPHD
         dzWRHLj557F76hWfhe/VwaUL3IME211kfiyeBlvpM3T+aN2G1uwyFEGr5mN0LBq+rb
         PHAEyliTLCifGHy1CdueSTN5RWPES39/v0gY643Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1jjYtQ2Avu-008HuW; Wed, 01
 Jul 2020 23:20:34 +0200
Date:   Wed, 1 Jul 2020 23:20:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 2/2] difftool -d: ensure that intent-to-add files are
 handled correctly
In-Reply-To: <xmqqa70jc5hx.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007012319100.56@tvgsbejvaqbjf.bet>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>        <9bb8d84ea956dcddefbe7b62baa3a5ff23b6b1e2.1593107621.git.gitgitgadget@gmail.com>        <xmqqimff3tib.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007011153040.56@tvgsbejvaqbjf.bet> <xmqqa70jc5hx.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CdxuqgbgYkOAORVXB+R/fShjvEMhtj+bl8MGyWAKPgytcphPwvU
 2u6kpVWTPfxJjbXJst99y6WWxmAA/h3AnhKwGSTZH8Zi7CwO/03z25rX87fR4CjS+h7Pug4
 jWRnD1C1lEk694UrGKwpbfhGDPnEKqFkqqQ/VPn/S2zCJHwbQZkp7ZM+G4zey9oQnkFmlL2
 FnL6tWQmgIbf9slR5Aqqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pBwQwYoQXNM=:I+aJisz40KUxGOY43CBkJv
 R0oaX9kE6GOrDfShocxiCvMD7AQHyohUp5dwbyxeGbR+gw8DaO2KG5hnDJ94h+geBeMgIXoJV
 ld25wKBEQ+B4wU65zlbV2jd0hLTOQ8bownWBMqTiImIB6+r2RWndhaRRv0yqM0SxeJJTCaQ6q
 AvxdsFwMHgxOHUpmaECZ7Vv8j7eUZ7lIrEFaT6/39eMr5XuY3mWpDXROd7Aj5TN2kjkcfl2iS
 zR0UaaRoYHC9sajVhi2qJwU3jN1c9RW2f1J2Rn+ArGO9gR04pEgpCEARf6xplqIbYgpe89cNf
 fsTDSNYuHaXjr1cCNMKcw+ZgjXRO9/LyAnk10N2aWFvD8UNUhPaG1mRmI9gO6LIOWG8SoYocy
 IjnZT3qjccOIlQxx/Ek30c7Ol6GDYl4dv85qXyuj+glT2JdZ08seqlDqpPHk4AoHjcff/lRXa
 efNHlhXApHzORhJoL2ppmUh/zgtM6jTFwaIWMuyJBkGlLZ8FyuUmTmFGKrjdjgwyrVN+7Q+ys
 rClMw7mAcdKLB74K1baYnjWp6qWKb3C/udeVxkDsYTcw4AaUwBmY8g+2p2tr4+CVIaKDmpwrk
 ZoqxhRRVPqNh6vH1G/9RgLtMbONinWgg4v7jENCWCD41ffbCBhhwu1DXxppDnh5QAp0dGSGsP
 qs4PgvBhvLWepihLm3xlHYBlWfEnOBZp9yvKk5kRXvPVyOT5YxnLZ1F2GTzeqa+o+jmHe59pk
 tJflwQQiTQxw0Eq0HGOyIgMC0M155oW4cG1mekltmhDVfWa2iQavMKNATngkK5aukSCas6Wtq
 5zxlTWUlPA6AxP4WguM+jamWzze935kcPAcBzmkhT5hy3CSq4+9lXldp9n2oAPL4+OXrDCxqc
 9xPdtpkBlWvsRambvLn6/T298mshc6EQay8e3I+3INiXfPNPLrh6dpMuqE9+hzY2w/Oj3uIkS
 S/nE+yY7Gj8IVuU1iE+pw/dklPo/y9wchwyann99t4GzFzKVfSxYodJQ7p4qxD5MOURkEeWq1
 PZRIXjAGaxB6GeollsPFaTvE6+F0CZsSqtoGVLl5qfoIVxHaOfOk9Ugane2D0l9uZLRFyjYYc
 bhQFYyJduyzsfh9qxxLxD9CAnAwFbr3Dg8VJX5IFeQUSxPOc2uCwDnNprWBs729jNT57DdwBq
 sNYlkAt/VXzl0lY2MaEfhQFNtPODLROJSKaVZw3Kcev1Pr32z0wmokdaYfAXsPzgL/EGYCfVL
 whLDogigjbOBPShNP7lsTLbX02bsH475jSCNSjA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Jul 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Can we fill the gap by saying how seeing the object name of empty
> >> blob (or worse, tree) instead of 0{40} made "difftool -d" upset?
> >
> > Sorry about catching this only now, after the commit hit `next`.
> >
> > Filling the gap is a slightly more complicated.
> >
> > And now that I looked at the code again, to make sure that I don't say
> > anything stupid, I realize that I just provided incorrect information =
in
> > my reply elsewhere in this thread: Srinidhi's fix is _not_ enough to f=
ix
> > t7800 with this here patch.
> >
> > Your guess was almost spot on: the empty blob would have worked (as in=
:
> > not caused an error, but it would have shown incorrect information). T=
he
> > problem really is the attempt trying to read the empty tree as if it w=
as a
> > blob. That results in something like this:
> >
> > 	error: unable to read sha1 file of /tmp/git-difftool.O8CoK9/right/int=
ent-to-add (4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> > 	error: could not write 'intent-to-add'
> >
> > And yes, it would have been good to adjust the commit message as you
> > suggested. Sorry for not getting to it in time before it hit `next`.
> >
> > Do you want me to send out a v5 and drop v4 from `next` in favor of th=
e
> > new iteration?
>
> That would help the future "us" quite a lot.  Thanks for carefully
> thinking it through.

You're welcome. Here goes v5:
https://lore.kernel.org/git/pull.654.v5.git.1593638347.gitgitgadget@gmail.=
com/

Ciao,
Dscho
