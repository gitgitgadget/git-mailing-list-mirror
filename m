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
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9361F454
	for <e@80x24.org>; Fri,  1 Nov 2019 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKASmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 14:42:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:50205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfKASmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 14:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572633717;
        bh=bPByqO3/ERordNgjG8BCHn33B3nALVL7jk5ntQ8ExEc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=idvxAF6RVx57YgzA7k8gRZFPoQ1CDuagmi3X4GPQBKag7N23FVo1mqbuy44lKwyCf
         q9jjDAZZuA9IvipnFeU62cf7oveZz1B3I890yQCmXMIsSiZAuKE2SLUJOm4UUxKIWp
         Kpx5Fhn5jpYvhV/7YerZGn4VOxoUz72nRlEoczW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1i4fAL1ekK-00vO8G; Fri, 01
 Nov 2019 19:41:57 +0100
Date:   Fri, 1 Nov 2019 19:41:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
In-Reply-To: <20191031154837.GB30187@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911011940590.46@tvgsbejvaqbjf.bet>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com> <pull.428.v3.git.1572379280.gitgitgadget@gmail.com> <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com> <20191029203259.GB12337@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet> <20191031062454.GB20830@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910311123010.46@tvgsbejvaqbjf.bet> <20191031154837.GB30187@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gAU3jdiG6qTH1ojfpYT2HoqxRU6lXJbHdoMbk/7fHXU8p3k5ftq
 tY+dsA6vt3rm3K7BGImeHFDilUVwY2XHQRPuvM/NHBqOGqTeeVI88AACVCZgmi0uoOzefpm
 nVxkDdLf/Knnphwe8s9Qn6BgpJsWqv4W3St8JesK4NyfEjKg0EJe97ouBEJEUXXpTuo2uRt
 37uwV162m0egGuEZhfDlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZLLiQlQ3TfY=:z2Pn2CrYHxJ/GgopfXLC0t
 PcwX4icQqU3biOn32YgX6e3RBMd4MtL8O4C1Cfr+2zsi35KJN4SUEy4L1zp6l3qaIOVXuhFm4
 aAaGIs5up52obmmcyplZiKar4et+rqc0RGqeES4bjvVzZ6Q3atfvxHnz0Bh1fGDp+OPnajUqV
 5x2S3fUpwRE69bz49lsCjqzPATDJFfiTDaQoyHirfTibSmDYicm60XJJ2WYhqxgG8hlPMy+7j
 njYr+rPhMKdqPEXZYbsgxuXAtEI+99mup/M9LgyekuYiNLZDQz/1oJuGmy0FItBpISZmwHy7+
 SMMt/cjuQG9M0WnS59Odf3xAiXGf9zZOrd8VcVo+wmYyFobfo4vxZAOqAZng+Ww/X9e263aVr
 MaWqRIo+B2o0+mGIS3hexaZ0YIgVZ+Gv159zJEPwm2MGrcHSAeZWCr7cQ9Wpv4m661skCNWyf
 d6p2tQjmGoQb5HaxsQqAgdIdxjWLHq09SMOjNg+bx3dG0PIY2jNgKe0lD18Mr25x8KddIq3kv
 jaJbBQsaUEV3qHvW6LDGbpkzBpwWMgXN/Zfty+JyqFAP85aCYSnc0AlRuAE+3Ni9xD2Hi0OPY
 O39J47zapQJiGzVnv8jhM5qQBUTMf40WjM5u34VlJUmpQA8+bnJtn2DjUb/D/ho2wRoVkwzrs
 3SgDpRuBRq4WWvlHAsp0p6YYiE6VSJZzsRDsrFw8aaO0+smB2T7NryPYqvrdGZqoeVMqYo8ko
 AcUb/O9kXuaeJ0PmrgW/ZTkPT9FFR+qy5+GlGWXFXSDXrSa0o9pAqbLl9npT8JSHUT08ia+7+
 gc541r0KIzqtT/9d/1g39styLcvqBxLk7QvagpTl+t7T2+N1AsMrjdKrdBlXSFw6sr0zVbsxM
 aGOdBTxlnZbhbhAYl1Kz079oy/1SghWxw7/YmaYgw1J4WiCMrqaENZg9PjieE/uFlc/T2800j
 YA8814DOPZbVx8faEwOj/Re5F0hhesijuFXUxHtN4jPSw60lGUdZ1PfPnwrQmXCN3syH10Jqh
 /+6vAXIlVs6heW6uhizBv38koQs61rojij/xn0R6xAZhyQ3FRQbwr5KUhL5qGoIhz6nZkUYXz
 l7Pnt/RErC3FtyRSx4Pu2ftUM5CaDej5s7XYoQ2LBRe0OkbGGiWcqehe1AJTfE9+jy+6LqCty
 f76/6CMUUTQSYfL30k/gDTyhDB63gAMhAOhUzA3vtoH/PWaryO6XAWPlXDEDhC3EuiJyRxtXw
 47v1SJWksgKMGUUGuF3pbTHebeb5M/HMuEnLSVtEUjD1GGm9BtA7U776m4ow=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 31 Oct 2019, Jeff King wrote:

> On Thu, Oct 31, 2019 at 11:26:30AM +0100, Johannes Schindelin wrote:
>
> > > Another more far-fetched one: IIRC our stdio wrappers on Windows do =
some
> > > magic to convert ANSI color codes into actual terminal codes. Could =
that
> > > be a problem here? I think we'd kill off any color codes in the actu=
al
> > > message due to the control-code replacement. In theory the prefix co=
uld
> > > have them. I don't think any code does now, but the PUSH_COLOR_ERROR
> > > stuff in builtin/push.c is getting close. I wouldn't be surprised fo=
r
> > > that to eventually get folded into error().
> >
> > A valid concern!
> >
> > As per eac14f8909d (Win32: Thread-safe windows console output,
> > 2012-01-14), `write()` _implicitly_ gets the ANSI emulation of
> > `winansi.c`.
> >
> > So I think we're good.
> >
> > Thanks for thinking of all kinds of angles,
>
> Good. Thanks for humoring my wild speculation. :)

Of course!

> I remember being confused by this not too long ago, so I did a quick dig
> in the archive. And indeed, there was a confusing comment which caught
> me in 2016, and which you removed back then (via 3d0a83382f26). I even
> reviewed the patch. Maybe this time I will remember the outcome!

Heh, I won't fault you because I totally forgot about it myself.

Ciao,
Dscho
