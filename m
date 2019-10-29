Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59711F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfJ2ONt (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:13:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:40881 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbfJ2ONt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572358420;
        bh=1HB8flq81aVv5aV7jDZRDV44sR/JnFPjHo++qCStF6c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DvHemfXJdgHONhPqVLZCR3BN6ME0M/yiDbMEoTsI0d/kE2ZZZGzUsuND5MitSzG+u
         xZqoJPak6w7CKRhJSvRgMM/kVGz2GhWS4AyTzOROb0JwebkxpYlTm0b1qlC5xhdLn6
         nhs3EGw3Uv4fpDCXgf5E/3a/hmPe//srQHk5Tffk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1iKWIk1zoM-008Ni8; Tue, 29
 Oct 2019 15:13:40 +0100
Date:   Tue, 29 Oct 2019 15:13:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
In-Reply-To: <20191029134932.GA2843@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910291510330.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com> <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
 <20191029134932.GA2843@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FDlX1/Vxw6+jzmC6XEuHoHYLX2JZbnVX71IzIkqtWrdO2OFd2ja
 Y5Q0eTSROox2/zftR1VNWQVJac5+XDDMpARdCqwD4GcgyjmRrKw8f3oL5Etk4aYymWNIqz7
 /+fMdFnvezhkMizmFoNB+i7IfUWlrxQAflg+F2VQ8X74PNlj3qLsD3+aMXn7GGwv/+QPmUL
 1O9vyXU6PUippDmZJpHNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3zliA6Ag88=:pW5/wvHORFny62WhDs/hOI
 8E+uDu+etdmPjLj2N1ZsZRJx/SJQDfjTkWq0uuQKvdURmFzDnt7ytm8mz4IIgruGi6VDH2+DR
 +Qh49DgPEGORZ1SSZ/fedIAZRu4keYkV3NCaIDRQ+7nTC440gxutJMVeHuufJCb9rCCIHBwf4
 6Qf+jXRWSW7fLZOWW3uOXDpRu1CpW6PBUlL+FB42JD695s8eWo8JiToKksHSDVYr6gOfPPIlg
 aFYqHIeJnlG+LCIVJuXRIsnYKxfbNfEBne1VLp3H9yoMkWImREk2sR1AOLqmTtNT7y72xJHY2
 N8LTKYWmJtWTRxwkyrEpW91axSlpgf7+jqHfk4wIA86t36Elx1e6Xv5c/7aaCSHQCenXyrcMx
 qBdzb56DkBoTkRdYyUD4PMJVgD2BABDariys8GcY52zvJyJehCQikt1ak/NYSxJKCf0asFSON
 dIxvYtTrl3NcaLzCHOupLEX/6CWyVitxzLt2S4AiA2x9RcvuuNpTbMijPXYvbex+NHZS+fsoh
 KDuHcMWZk8kY0cwRtjPsYX2QdWRTGxwM9VMd3tObPOI1HdQLZ46TqIXt2tCr3R5kc+d5Ruu1E
 RQ2aZfepVtaHWthIKmkNvccOgT5eCPXQek3+XLpn72GS5fXIeY6kGtG5tq55CTOY+puYLCG5R
 LnKqtQrzQoy8Uwg88M8DNh9ednnzxfP7dzpSL+73FAZqgFmOEj5eMO24/lDZfYHaNqzRzrXFF
 tvfVTzp+jMnYB8Mad4lO/jUodyDI7rbMhCAiT/RpF0a1/2gp7RSwCTA4n9B+i5Yj0SPWnxgsq
 7tuEUTCYkUrsDj60uLlDV56W+5Ct3fe3TNFkS835rtywkDeByRR+BIXgmeo7+IiWtXSJ5EMQC
 88QGSdaP56KNH/LsJmNwLbn43XsIiTAMHQ3PNbQufAGGArP5UVXu4TG1f9pGglKWJtHEbrpkb
 jOuOVQ1ZRXmJszlwTCstc7aESEbzE1byYGf+OQKF9UKEkVAnzkoGtMvMO3SuSuqR2ANF4iIOw
 qgS/YBxHvIbqL1uRILomW8vTaWkrQXxC9YJh1aXWlHXrvqzuDUFuRli5zrNXjrvBCqlBouu6P
 CHYkSDfiHQualQaRUdZHEVIy3DUYX0UioHgBCJrN3RBZAqrbtBfIrVSxN2k1yamdCUfBcrpsw
 ++sZWgZMKaMMlhGXVehrHIEn1U2jOJsYwMTA3AD1Y8Ntf+hBpUX12/VhHgM2i2bx9WfNeY2tr
 5FLHWQWxDbGo0qyWhVr5yspa/rnnJKdf6AcBf2ZxBZJHAz/yTloioKVCRVAA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Oct 2019, Jeff King wrote:

> On Tue, Oct 29, 2019 at 01:30:51PM +0100, Johannes Schindelin wrote:
>
> > > Also, this is only to help output from us that goes via vreportf() a=
nd
> > > other codepaths in us that use stdio to write to the standard error
> > > stream can still get mixed on Windows (I think the answer is yes,
> > > because we wouldn't need fflush() in this patch if we are covering a=
ll
> > > writes to the standard error stream)?
> >
> > Yes, `write()` can get interrupted, so there is still a slight chance =
of
> > interleaving.
> >
> > However, with `fprintf()`, apparently the MSVC runtime essentially
> > writes and flushes one character at a time, which will make it _much_
> > more likely that two competing processes write interleaved messages to
> > `stderr`.
>
> Wow, they have truly taken "unbuffered" to a whole new level.
>
> I don't mind seeing this for all platforms, though. I can't think of any
> downside, and having one less moving part to contend with in our
> error-reporting code seems like a good thing.
>
> > > > -	vsnprintf(msg, sizeof(msg), err, params);
> > > > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> > >
> > > Like snprintf(3) the strlcpy() and strlcat() functions return the
> > > total length of the string they tried to create.  For strlcpy() that
> > > means the length of src.
> >
> > True (I misread `compat/strlcpy.c` and forgot to consult the
> > documentation). This length can be longer than `msg`, of course.
>
> I'd recommend xsnprintf() here. If we have a prefix longer than our
> vreportf() buffer, I think a BUG() is the right outcome.

But BUG_fl() calls vreportf(). I am worried about an infinite
recursion...

>
> > I `git grep`ed and saw that only very short `prefix`es are hard-coded.
> > So that is a hypothetical concern.
> >
> > However, Alex also indicated his discomfort with this, so I will chang=
e
> > the code to account for a `prefix` that is too long (the entire error
> > message will be clipped away in that case, which is unfortunate, but t=
o
> > be expected).
>
> I'd disagree here. Any caller sending an arbitrarily-large prefix is
> holding it wrong, and we'd probably want to know as soon as possible
> (and a BUG() is our best bet there).

How about truncating already inside the prefix, then? It would miss the
entire error message... but at least it would print _something_...

Ciao,
Dscho
