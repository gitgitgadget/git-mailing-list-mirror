Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0534DC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B549B221EB
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Px7bI10f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIXKBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:01:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:55115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXKBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600941684;
        bh=kUSPwlNDJrDS7uNr6QUCBIB/3sC1eyU4X18z6QgVJbY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Px7bI10fZk+/s5bpa/e1moGqRTU85zLL9MsQGvBKbKpB2S8RatUGUCwGI2LqfiqLY
         wc3b5daZ+RggIa8ZI15FSxB4/09S0a6dVKdLTGpETW2lqgvIA63CkPnWdpiXyWn20Z
         OiyzGgX6ddy0RiAZQtkeJXdqC6hzfMrwvfZXQLZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.214.175]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1kFaMZ3BH9-00GIBi; Thu, 24
 Sep 2020 12:01:24 +0200
Date:   Thu, 24 Sep 2020 09:51:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
In-Reply-To: <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009240950010.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet> <xmqqa6xgi363.fsf@gitster.c.googlers.com>
 <CAP8UFD3mfPgedqGk0ZFp3K3r1gDA3-stbSxoEomRh4T0_qH+tg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:va5rvjL4sbf6O1f0jtxjMgXeSowvYt/bHmSdsnudKFYeLnBePdz
 zCclM+ULMMKsY3Gt00O9yC8ByoyFEQdpXPbE1peWGRBm15qE/JvQCUBvlUtesouEfNpmXK8
 WEUJgC0lrxb2QK5czfdX+KvpD3WcFz1A/dxUBPPMPWq/lIvfn+WElepT9DuXCB0YYNIhvpi
 rixQXidEHpNg/IfBEUGCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCNtz4QaKYk=:NuUCNzaPViF/36R2vTefBR
 OJJzHKLq8ObpUUdBtu4T2ZN7xbo9LQ1xrPfndxIfy4wIv/dU1lKBK2Sn9XRnecxpKZhCYQx1+
 a7F7gEEOl5dwkEgc6T8I8pfFecTHww5p2eiM3i8l2Ql2bXIpL/OF3TiKyYIZX5raqisXR3dWG
 BBblf+tz72zTCOaDDxWVW2gs61FUsVfYCEw0NGaXbhumjIyCJQYMv04E+m5yClVRwQiP5D/Ir
 HKbVLVcOn1mZkXQS6SfAeBcdRXVwtwMJUTrFhy/shHlFuN5sJszy0J7O27kGQ55muWncoI64e
 35jhnrpNd07bSaL4i2f0EHc5VHy2SETI1RcZSuCuSMtYTWx6yWSrJdDcuaZ1/uJjHgbBaTup/
 3qybMGEXFqr6+XkB9GZkCczTC7hpqc1evk600LM9W0xXbvZSU8m1S0jjh8a1gvhq8TVOtSW9B
 cGsIcM8gyts5po6IHWv/Js+JyGuiCGoZY70kgH4PW43E6OnDXFQaJIK5RqoQOMretmedwncR0
 sA1ZGlRgzt/NxsgTRDTyA34gbvd0yS39EZGTQ8Eq/vYfwcVl5tljPej9mDmDO9zpJyYPNmw+m
 xzPJ7fszW9VuIF+B9j5nrhpErSNfwV6sxRxFbi1oviG22TjG3PpPCDVZdO/ZfBQutxgDXRiDo
 3FRIY2lAIAuH2W4WwSi9fhMizcAsXvPPe1pImqM+hNxpUCBUWXYuFX1JFl5spq+5283lXlhn/
 t6Ce9w4QI0s0NxHcqoSSKZwdIM0SacaVeW1UFWo2bmVholFp+0Uf4o2Q/1XsmYoMLEG0zM3rz
 wTsshFMhUsr7auLra731t+ehj6vQ/H7XkpFnbIVtcOaJfbKE8SnBAYDZ2YvFX+TOC9wMMV0dR
 7xqnhsKw0tnRI2ipafsss/yzXHfAWM1NeyP5rEyIHYEO0q3h8pAVI86n1BKuoyY4USYuDxxo0
 2iyo52yMy8GdC1Mh/rWw1bDfpa6yKvB4q5QgZrSr/LT1RJdklskioLcehudFhpblNIIWFZVXp
 +e+qX4Q2d3o2o8xsEZ1ZSnOHVz2dqk2LvO6KrlGajGGGDjZSEmW+85I59kqxyIAHmCnqcKCXZ
 IEvv0E7BlLTZC26fmH85XE5BWyzgZ/OA1SZhohmfDN5OHIH1GQWbQzofeuSOH3sVCOfwU56Lg
 GEFMW0g3yQINNwgWas5DNdlQ1xMQnNRYkL9kvtNyuZHwauE3fQLiMAaR9MF8VONEGZuA8Z2pL
 TahzkUDwnoLSQgI7iR/eTxmD7CUE/TBfoTjl/aw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian & Junio,

On Thu, 24 Sep 2020, Christian Couder wrote:

> On Wed, Sep 23, 2020 at 11:39 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > From f673cea53e046774847be918f4023430e56bf6cb Mon Sep 17 00:00:00 20=
01
> > > From: Christian Couder <christian.couder@gmail.com>
> > > Date: Wed, 23 Sep 2020 19:09:15 +0200
> > > Subject: [PATCH] bisect: don't use invalid oid as rev when starting
> > > ...
> > > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > > index 93e855271b9..d11d4c9bbb5 100644
> > > --- a/builtin/bisect--helper.c
> > > +++ b/builtin/bisect--helper.c
> >
> > Unfortunately this does not apply to the broken commit or 'master'
> > or anywhere else, it seems (no such blob as 93e855271b9 found at the
> > path).
> >
> > It is better to make it applicable at least to 'master'.  Making it
> > also apply to 'maint' is optional, I would say, as the bug it fixes
> > is not so critical.
>
> Sorry, I don't know what happened. It seemed to me that my branch was
> based on master, but maybe I did something wrong.
>
> Hopefully the V2 I just sent will be better anyway.

FWIW I was working off of Miriam's `git-bisect-work-part2-v8` branch at
https://gitlab.com/mirucam/git.git.

I'm happy with Christian's v2 (with or without the indentation fixes I
suggested).

Ciao,
Dscho
