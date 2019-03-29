Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D1720248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfC2Pkt (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:40:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:51397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfC2Pkt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553874043;
        bh=zIJXs3GIhlzDzUcWA2Oad9N+tAmduN8mJuSeGFNxmAI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CfwVWYYLvcmwFeg/EJ2tGPYIBX8xyI8P3kM4Mb3pbYuneSCOLc/KBmitb3MgyMLBV
         9WwzRYg5/3hRut8s3aiOV2VernMOXRVpQNYYzup9TsoToimWwVLRPOrt8zX/ZQVMkJ
         MgZ0yVzzVI1G/OLyOHUoL6jptMiVHgvQQGL4GJfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwZtX-1gtGdA0T2F-018K5d; Fri, 29
 Mar 2019 16:40:43 +0100
Date:   Fri, 29 Mar 2019 16:40:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, kernel-usp@googlegroups.com,
        Benoit Pierre <benoit.pierre@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 2/7] clone: better handle symlinked files at
 .git/objects/
In-Reply-To: <20190328221049.GK32487@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1903291635050.41@tvgsbejvaqbjf.bet>
References: <20190226122829.19178-1-avarab@gmail.com> <20190322232237.13293-1-matheus.bernardino@usp.br> <20190322232237.13293-3-matheus.bernardino@usp.br> <20190328221049.GK32487@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bA/4SPWW/pKziSeMT8NGF/jbuk0wAA28VF3qRvwJDsUUNQApRyk
 hbjmCumXFTs2InibbnQnYDSMgMYH+ZzvGqUY4eTWYtkNdIioVy++L8pM8Wo/JGUh0ilrDU1
 BOLTr96xXwuJHdWLJz0mXMCt5KUdyXlCtjh15Lw2QbFfV1WuTD8ZL4ghJkNmvw4sk6sFzaL
 qltbf12+jzIG2woHneByw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:McO1vjGycz4=:VuPhKZn94U5NJ2pjFCT81a
 K8P0Up1sKbtQ5+f3fsnRx3RORggjhlTHD4ppaSolvGwbBEfcyYAgDmQbwyVlL2GERUxDqMgqn
 257ZUPRFed0IqvnPluzkk7QxrcrNCCouK8ROvG0/7r+CucnxjteWak5ri41zGp0M5jD4YlXAY
 sQgNTPAdgYomkrc17aI7MEK/wkbP3eEl2+WFuTWbB+1RRItBqEXo2OCIQ3vUSlnsZIk2tl2T6
 tIRzAx49FhwJbXU3QkVIPjC5bOtQN5s4sXzxzpr9j8FoWG+KUg9iB0MnU9tlaWamVvnP2Xe9H
 tQ0XdiKwt/Od4KTTKtG7gb/BDivU/kUuoGqrlIaNnljtJn+KuVYjmhYOFhHhIiSxXhgpTEpmI
 ie/00gvDbqe+Y5Wa/ApdKZK2ogiRPmZrtcJsSGXah9+MteNuocTKuUWQqeM04MygannLjSj7z
 ZvHtTNU+wp5zdY/fhtLX04YxLPmgxu8gNiA78x91mycjbuQgtbzkXCvhvNacWKbkYm5/GPAuN
 P2OtQihdgeiWCDnY2Exoco3qZGllA/hNAyzTMYD2pKkm/fsjItKt970kbPTejrmpWXouPAya0
 WjcrTIMmV6SE4r890JZiMxfyWerbr4wH81qRN833d1Y0ZAHOU9ktehIhhSfGAnRu4i0lul4j3
 NTsaTA0oPbZOez7ilr3Jl35rYD3vje4J6fmSNtreDtSUQeRb9JQH2EjQ+/allZVfyAWndgaZf
 2nWb9/it/fSPjAyjlIxx89ogEwsxTu++xezSbG42SQ4HRTytm5OgRlajjj/t+WLeaiZpFxD3d
 0ssbaBEFFEBxWivJI0UvKORzc5CTQ07PS99/EWWArUUpCe0jC7EyYqyYgHNDuErey0kcilBSB
 3Wja+EP9iPBWYpmvG8m4Fe2e/c0k029JN/anVt1IZlhSlQ9LIiUZ46goRQRH7DH4zIjFWJcRU
 GjZEA426FGw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Thu, 28 Mar 2019, Thomas Gummerer wrote:

> On 03/22, Matheus Tavares wrote:
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 50bde99618..b76f33c635 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -443,7 +443,7 @@ static void copy_or_link_directory(struct strbuf *=
src, struct strbuf *dest,
> >  		if (unlink(dest->buf) && errno !=3D ENOENT)
> >  			die_errno(_("failed to unlink '%s'"), dest->buf);
> >  		if (!option_no_hardlinks) {
> > -			if (!link(src->buf, dest->buf))
> > +			if (!linkat(AT_FDCWD, src->buf, AT_FDCWD, dest->buf, AT_SYMLINK_FO=
LLOW))
>
> [...]
>
> I notice that we are currently not using 'linkat()' anywhere else in
> our codebase.  It looks like it has been introduced in POSIX.1-2008,
> which sounds fairly recent by git's standards.  So I wonder if this is
> really supported on all platforms that git is being built on.

I bet you it isn't.

> I also wonder what would need to be done on Windows if we were to
> introduce this.  I see we define the 'link()' function in
> 'compat/mingw.c' for that currently, so I guess something similar
> would be needed for 'linkat()'.  I added Dscho to Cc for Windows
> expertise.

Indeed, `linkat()` would have to be implemented in `compat/mingw.c`. It
would be a bit involved because the last parameter of that function
changes behavior noticeably, but the main difficulty (to determine the
path from a file descriptor) should be overcome using
`HANDLE olddirhandle =3D _get_osfhandle(olddirfd);` and the calling
`GetFinalPathNameByHandleW(olddirhandle, wbuf, sizeof(wbuf));`.

So yes, this is *not* something I'd do lightly.

The bigger problem will be to continue to support older Unices such as
SunOS and AIX. I highly doubt that they have that function. You should
find out, Matheus.

Ciao,
Johannes
