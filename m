Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87421F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfJUSqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:46:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:39485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUSqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571683590;
        bh=irULlh8BE4PcSsFHgkqFwYMf3TkT5IL6QAlMPWdddDM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BJ1B/UnnLhPDemK++icdhZoLR5TnsckErR4BYUcLWPm0K5f06s+UQXlEX74kjomIL
         fdYIEoCAWnDAbqNFDFzhjQrQhDiQGrTdGcdSscCNLDbBgWaRE/it3zTEtHnSbn1eV/
         uxUDicjYzO3qC7zAx+je3GhRdvQX7XoXRn+ITsKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1ig3GZ13kn-00OUvL; Mon, 21
 Oct 2019 20:46:30 +0200
Date:   Mon, 21 Oct 2019 20:46:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/7] autostash: extract read_one() from rebase
In-Reply-To: <49b1ed2e-b1b9-b593-2657-e59f61925e20@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910212045490.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com> <bbd46ad8d27ab547c8efa6b55c1777becbab7302.1571246693.git.liu.denton@gmail.com> <49b1ed2e-b1b9-b593-2657-e59f61925e20@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ec1hkuaBey71whVtnuK6Jlq9cobatfZnzLQr7EKfMJt8zAotOpQ
 ifQpLIWLrCidFp+difQH/vQp/TuZ5htKhUA2heTlPa3xWCX3prvIhIyOSeMMRHNieO4nT/J
 iVNisHG7z0fFYwRu+vFDyJmt+fS+gMg6mgkRi6NcU3I22rprOsLDvopSSKiXqH5S6L7lPTP
 IXYvkd3VOCsUMkfWF11BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7vJLV8bGBZA=:NRl6UYJzVPXJWLqpWrbNgm
 qSwxU2zFUADnpVgQcvlfA22SbUyvg+yzdcHVgkG7ScOW6wif9ac4EhJA0fBc17GggKMlZ6Fii
 wub1VMRCgCD77m8qsDuyIzn9lvtPor+sz60BLEVWgwfuWtyGnuvwviziqUVCS67LgZANS2v+r
 Si0yMg4Pi8aIanwNaP05kzaP8s0pRjXxOBPbjOTMuQAc6lo0+CWTZ2Ycu63IkxP3ETfAl7NQ8
 S0bSqVJI5SldyRSaUPEPKmxXa9dku35EEgqxRHQTFTnxdn5YYPpuX9cWkwWYoadWGGLHZaUj3
 /zIi0KhuehUrz9c0GsURueqA0Ba/Q5jGvwvpESfLkTD6YfWdHyMEtMesnEYQ0E4Df9oag0AkL
 RlKt15NtFed4ofSCuXQSeXYXdX3UFOQPz7qf4jLjPn/+5HcT89htdJy7ZOjPd5Npr8GrTwKcM
 VKYC8LDCFztY5tFANmVwC77VxhpyV27R4to7NAVXPqJcQJgQ1YkqSQZDQfx9zmHbMYiooKgBJ
 gjeEzWHbjwRaAk790dlhHrux4obCCE6wG66I8S2BYTrc/VSrAYHvtR4+Log3cG9a4hTf2ebIH
 oy3PrqA+dA9MgLAG8/5Vwrghytry1WIeegVSaOI6XiCR18mPME3YJ/2zWn1vrB6L0KQfZSyM8
 0E08QIJ7mOhHNNg0oUnprGjzq1a5F//Wfaj1zwmFA7b5FM0iZthYTkm7xCtnznKQmKkWPZ+Ys
 2tLeJTPPm5TZTjZ50y3lnwVeiP3sT+XpRDv93uQUbp3omUXT2h4S9rF4SlTtnCN0HiseVxEUC
 kN25LaRuyM77dIFBDpYk38uFwoHykVSMqwerPWzz/ZmGhmcIO0hzAfWpg4DfuYEwL7yzH2dvM
 LoR5ivL5rPJQ2ID1fVYhsnRZYsIEGwkr37sg+gxdPJSzR62glkWujnLSKVS+A3uz1GNJfSq30
 mVDr+6/Y6S9OVelvlR/h06MFaOrrQxl9ZT6z3owprAhTj0NYtANNCG6fPwryiY/I/Ipy5N0Uf
 crQDY8udiCqdv3rCgqNhR/XAHsTpfQcnI/PC+uH/TkRUjoW9CXbiTclRy+nmP8A7SQvIbv3M3
 oOvLWfv1MpONu/VccOMvjr4aQtskCnAWY/R0bjDRG/xKxv2S6pVWdVTTcJbDBtUaTZElHChh4
 BfjNkm06Sgokg3EyPwjk2a5qnBIB5oU3fX1mb/QQJs5zRdfSxf15rn4mY3Ixie7jBe7iM7zbF
 /JB+ABWftLb6nGWN4zBVrQ+Zfk5Y0+PfmIfsbP1mfa0A3O1nHymhH894d+DI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 18 Oct 2019, Phillip Wood wrote:

> Hi Denton
>
> On 16/10/2019 18:26, Denton Liu wrote:
> > Begin the process of lib-ifying the autostash code. In a future commit=
,
> > this will be used to implement `--autostash` in other builtins.
> >
> > This patch is best viewed with `--color-moved` and
> > `--color-moved-ws=3Dallow-indentation-change`.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >   autostash.c      | 12 ++++++++++++
> >   autostash.h      |  9 +++++++++
> >   builtin/rebase.c | 10 +---------
> >   3 files changed, 22 insertions(+), 9 deletions(-)
> >   create mode 100644 autostash.c
> >   create mode 100644 autostash.h
> >
> > diff --git a/autostash.c b/autostash.c
> > new file mode 100644
> > index 0000000000..a6898e0fda
> > --- /dev/null
> > +++ b/autostash.c
> > @@ -0,0 +1,12 @@
> > +#include "git-compat-util.h"
> > +#include "autostash.h"
> > +#include "gettext.h"
> > +#include "strbuf.h"
> > +
> > +int read_one(const char *path, struct strbuf *buf)
> > +{
> > +	if (strbuf_read_file(buf, path, 0) < 0)
> > +		return error_errno(_("could not read '%s'"), path);
> > +	strbuf_trim_trailing_newline(buf);
> > +	return 0;
> > +}
>
> This looks like it's doing a similar job to read_oneliner() in sequencer=
.c, is
> it possible to make that public and use it instead? (There may be a diff=
erence
> if the file is missing but that function already takes a flag so it coul=
d
> probably be modified easily enough.)

Oh, I would _love_ to see those two functions reconciled.

Thanks,
Dscho

>
> Best Wishes
>
> Phillip
>
>
> > diff --git a/autostash.h b/autostash.h
> > new file mode 100644
> > index 0000000000..4a8f504f12
> > --- /dev/null
> > +++ b/autostash.h
> > @@ -0,0 +1,9 @@
> > +#ifndef AUTOSTASH_H
> > +#define AUTOSTASH_H
> > +
> > +#include "strbuf.h"
> > +
> > +/* Read one file, then strip line endings */
> > +int read_one(const char *path, struct strbuf *buf);
> > +
> > +#endif
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 4a20582e72..9fd7de6b2f 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -27,6 +27,7 @@
> >   #include "branch.h"
> >   #include "sequencer.h"
> >   #include "rebase-interactive.h"
> > +#include "autostash.h"
> >
> >   static char const * const builtin_rebase_usage[] =3D {
> >   	N_("git rebase [-i] [options] [--exec <cmd>] "
> > @@ -561,15 +562,6 @@ static const char *state_dir_path(const char *fil=
ename,
> > struct rebase_options *o
> >   	return path.buf;
> >   }
> >
> > -/* Read one file, then strip line endings */
> > -static int read_one(const char *path, struct strbuf *buf)
> > -{
> > -	if (strbuf_read_file(buf, path, 0) < 0)
> > -		return error_errno(_("could not read '%s'"), path);
> > -	strbuf_trim_trailing_newline(buf);
> > -	return 0;
> > -}
> > -
> >   /* Initialize the rebase options from the state directory. */
> >   static int read_basic_state(struct rebase_options *opts)
> >   {
> >
>
