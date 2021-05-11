Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E4DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8413B61261
	for <git@archiver.kernel.org>; Tue, 11 May 2021 14:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhEKOgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 10:36:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:49307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOgL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 10:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620743692;
        bh=FiH6uX8R9WCzOddl8bC/+wU2If5iwYI/4uQn8cn8ppA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g+7Fk25v/0gYz9stz2d0IuLFqSNgNmIoXWipdUebO67NdZBHaYT83Dve/lB3si1CM
         yIBQCEbbZpAI/FDanpib0YVG9CT/z4wNRtbMV180ticf75Dn0PV6iA+XqD1EhFiADJ
         3bhDkqI57Hq9+b7vV9PmnCU6gKzseXrIbL0OHNs8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.150.94] ([89.1.212.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1lqywb3bWU-00OriT; Tue, 11
 May 2021 16:34:51 +0200
Date:   Tue, 11 May 2021 16:34:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
In-Reply-To: <xmqqh7jfy3du.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
References: <20200404142131.GA679473@coredump.intra.peff.net> <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet> <xmqqv97w1wl1.fsf@gitster.g> <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
 <xmqqh7jfy3du.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JqiuMNrgZr3J3F0R7dO0kIouE9kVi2t/DjrpwF33N1mNfchqvNY
 /8AUyYpwbnu/JjHK7UmEGFC7Wg7sVczLAJq09AW6RaaD9OJOxGjSLx13BwKCQdHne+Wuq9a
 VWAiXK+XMtDq+SthQ9PCLy+3eTdqn4dAdeUe8xbcBEhmFBw+GpTln3BTEWOzS/RIIH9C7jX
 dBIR0tideFoxKdEwN/Urw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FybFCO2WFMc=:hjuNyN70Qo7LV75Qw+afvX
 0e8ZOrPK+4m9bDb2uCMLXfBVlWA9q9xhPyLOIMVuqvt1O79bfnai5Fv46VLRNJ1CRodTHrjIh
 4TC8o/bVr3sn38FeUtKglRSGfHT1ORJRJO8ODDCR/IJ1dhn0bNzQGdwmhY6dD0I0wWxQzqRdK
 T7i0p/JeWK3y3tkvG+uk4EkWxEt6D5DwbCjL4aobXHTdoQYPcgmxxO07ulJ782Et20ocsPbHR
 n5/vsDuO2Hy6ivsavZyU5opPUdMBHMtSV+xfYIIzCJCkgG3gwegVaK3gWR2alMP13x0g/d4Vq
 b0j9D2oujtps0diuEjRuVPXfWyarp0b2TtfeyU+BhvrZF4uWktWxraRoO4lMZ37xy5azBekSs
 DaMVjkHzEfcCCKUNe15eVSFlR+D4Gt9ivz46StJO2wrqR8xNmjSZ9fbLnnTGcwGO33iY60e7S
 zTcuH/lC8yZBjSEncz+dlfb39tKYANS2NUfltGQzxjrEkQ56WsUnQf/4uVkviNPwjGkvefFCt
 ufU2TE5nAcQs3tXs49GpqIl+9uS816t0DD1QAh6LaJVUwVLk+mRy/vPrOz/ratFTIK3kk6ZfS
 pf+jOQLiwD+LGcQgJusLOr3aSSqr+r+0SGdqPGBrFW+MKt2W9X2jKz+s3HBzayevMfildaxMP
 SLhA97gKaedvVs6wfwt14JSrG7d+xtKTL0njGHzHEs2g4XTbvEW7+D7PM8uJo84GDkDdV3kkT
 va3tU6IQST2vZMONPIJdLPupHLcOwYI9D7H2JEedlhvDIjJJLRWHez109OjOfNIUJOyqlsKLq
 Mt1WcwKS2mBQIdbXu6WKjsy1G3/RI2RNRBEoN8bHXuUjtTXw0PqiNbKMt/eFC66+t973TLCPz
 SQSP6ONApZsvSEqw+BLVAy+Rq50dk0QJb1AFAwpemff5nmLhibUyYBZ1PJd3CbAsIx72TcsG7
 Y8MoEKkJqajRYP0/gm4ORgALIEZlaqoOy4NDKFDaK7Cbh8dBIwRW93og7SMYj1eLCXUNRNsS7
 2Dr/Y1tsiZutqCB3Mm0fCKqMO9i7YM2yS5jPXiKkYeqeakJfLo6NKnZ1sukM2kb43ahE/Kmwn
 /xzwzPCeKoKfPwCo+QUGSSSScdLQAe7AnjWN5JoQoF2B81ULnV9xUUNo+KJOFOqnR29CWDi8D
 QAGsoL4nd6CW6eG1htKBe0AXFMKFT0dNHzScoCh8Z9RteBBruZD9Ksaz/Jc+Vs2h8hyssUUuX
 jYI/5QWrlmUb541T+
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 7 May 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Otherwise I'd strongly prefer to see a word that hints that this is
> >> an otherwise unneeded workaround for comiplers.  Your suggested
> >> title instead hints that it is wrong to assume that errno will be
> >> set to non-zero after a syscall.  I do not think that is the message
> >> we want to send to our readers.
> >
> > Right, the oneline I suggested was only for the original patch, with w=
hich
> > I disagreed.
>
> I actually do not know how your rewrite could be better, though.
>
> 		/* GCC thinks socket()/connect() might fail to set errno */
> 		return errno ? errno : EIO;
>
> If a compiler thinks errno may *not* be set, can 'errno' be reliably
> used to decide if it can be returned as-is or a fallback value EIO
> should be used, without triggering the same (incorrect) working in
> the first place?

Oh, I guess I mistook the problem for something else, then.

If the problem is that `errno` is not set in case of failure, the
resolution is easy (and even recommended in the manual page of `errno`):
simply set it to 0 before the syscall (or in the function that relies on
`errno =3D=3D 0` means success).

There is really no need to introduce a `saved_errno` variable (which to me
would suggest that we need to save the current value of `errno` and
reinstate it later, as we do sometimes e.g. when we call `close()` after
noticing an error whose `errno` we need to preserve for the caller).

Ciao,
Dscho
