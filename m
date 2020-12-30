Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD767C433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA61207A1
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL3V5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 16:57:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:34469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL3V5t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 16:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609365363;
        bh=ZGfi+OlNsC8mjFmwVkbQEdxAa94XRGuEjfpnNKZ3kkU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JW+UpG5IXELjkLHLTl2BbKhsPDeWNbTdc+dU5STvO0dyGFY6QFr+bRr+s2wvn6WKT
         e/lvPWdXlWvRxc6cCLtTYtHN0aFKoBBAWv55dm1Rdb3DiiG+a+Ty93LgNIlJb0XsCk
         oat3ZAdnXkD/1f0igczlavIfv3kBc1+7aR/hAFnA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MirjS-1kOfws3STs-00eriJ; Wed, 30
 Dec 2020 22:56:03 +0100
Date:   Wed, 30 Dec 2020 06:30:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
In-Reply-To: <xmqqblemlrv2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012300627240.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-4-gitster@pobox.com> <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2012201623490.56@tvgsbejvaqbjf.bet>
 <xmqqblemlrv2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rgOlbm7JnbtQPMBqX9g4fPn11tlIvch+NCx+/TwFZfYYpGITtk+
 Z5Bf4iSuVKys/48cnLWa/AwfGxB7A92Mw31D7rqtt3WwtpDD23/o8qMBzi4VL1OYs4mdrKY
 Mncg8KcHz9KajfzA2gOoHkdSyJixOx0R+TQukBwSO2bDOOccFV4gmfQMesG8F+1u07ZwsYh
 xADZnqBmTUWBQLeM0APqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hzEAVJvgs40=:7uNB7Oi2fdhIpB63WGYKa9
 vS4sZOr3OKfyWjFMqPniVuZ0wH2WEovCIkQAU2F8fxbsKIMAfytPy2uDUIm3bP8c5ScJ311dJ
 Kv7s/5mAKFnrNXqRE1vu1qM3fCBQ3xBArKvSXl3YVY4ncqUDtiiVHvlQDJY2QnqRGNeDZMXDy
 Xojo+hQ5BgkDgo2BcNSSzYgIi5Fq00JFf6mfalXja+PN/Fdr6tH2UKdzXzaEAE0Hw0hNSqf9x
 JpC7ZOz4w/p1vKLU2PsQ4RCNvQ8pRiLxLgCkzdYn2hwvRSYU7Oz1n6lT875zXvr13wLUk8JUl
 V+WSJEHrFbda3+nr4pqTX1BT5pka1oCzI6y1KazTjyQsJraxueM8isn32RY6X8N3lQNs2hxFt
 mejVuT85F4iIoXv8eMkvRFC/lK78gZiPi09iAAaibPFxAVIgUS4GVPV+LP92+Oi5Pb9BkgYGC
 U0+xmo9K2Hun3+44DUaHpYBJUczOclFlV8uVrE9s9Bb62hDprkmynOl+6n8MfoIAek+FK0o84
 8HQNM2VcmnjRpV4YKYlDd09KTns5AUNDbUUQmW7XcLof7urB8JW9vI81ixeKwmcQH5SfAMnV5
 ZhntMZL2Fwz2COS7QacgGU00gg60/8Js6jOEW5ujHO7h8K+WOGxebH81oIYKd/y/ybzLJMJ84
 wTiyig5hLjhcPHSNbjT/K4advlAeLlUnBCcvS3FVjWGZFmGTkOSFZQnaotb7DF6/0t+ad1du3
 Oi9EPtUYaI31YR+P5nqsG2eGhOVP9Jtd8vr1kXC5vx2epF7ns1dFpSYA42VSrd9qvjVqk5lTS
 O83Av2cXQS5P3lfatC56HyXDftnacz9enVKdMa/7EsA2A8kxkttkNmiyqckPBgVAdyRG6C0hl
 lhgOCaQ2dOCIkK0kZOZOy2VxpeHJFA5n5Nn0MMffo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Dec 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > -- snipsnap --
> > From e8ce19db04657b6ef1c73989695c97a773a9c001 Mon Sep 17 00:00:00 2001
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Date: Fri, 28 Aug 2020 14:50:25 +0200
> > Subject: [PATCH] fixup??? git: catch an attempt to run "git-foo"
> >
> > This is needed to handle the case where `argv[0]` contains the full pa=
th
> > (which is the case on Windows) and the suffix `.exe` (which is also th=
e
> > case on Windows).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/git.c b/git.c
> > index 7544d2187306..c924c53ea76f 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -854,6 +854,7 @@ int cmd_main(int argc, const char **argv)
> >  	const char *cmd;
> >  	int done_help =3D 0;
> >
> > +	strip_extension(argv);
> >  	cmd =3D argv[0];
>
> Hph, would this make strip_extension() at the beginning of
> handle_builtin() redundant and unneeded, I wonder?

I poured over this for a couple minutes, and I think you're right.

> Yes, I know stripping .exe twice would be fine most of the time, so
> I'll queue the patch on top just to make 'seen' pass the tests, but
> it is just as easy to discard jc/war-on-dashed-git topic, so...

I dunno. There is probably value in starting the deprecation for realz. I
mean, we deprecated dashed commands, like, an age ago (2020 alone felt
like a century, didn't it?). Maybe it is time to warn about using dashed
commands now. We could even consider "brown-outs" at some stage, via a
pseudo-random condition that triggers rarely in spring 2021 but
incrementally frequently over time?

Ciao,
Dscho
