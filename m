Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AC8C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3258E2481D
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X+hdKHu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbgJMOZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:25:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:37285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbgJMOZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602599114;
        bh=Nj++kSpdgXKd1tt9oprxSLUT6atjMqv2cxykUcoNJ1U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X+hdKHu7AGYx1Bk3exo+pi0LMOBXffPppQKx0FCxad9guZvvHNgMYwHuZP7UtJonE
         tYncCbHHF7hA88LC2Y/LN5y+eZROPcDb48zaF2Zaayjcic6rMXs7A7vaKNSbSxmH9o
         NRw8os2HfWqia8np1rUy+cFxN0dczMIkydBPyi7U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1kPjpj17zV-016iSa; Tue, 13
 Oct 2020 16:25:14 +0200
Date:   Tue, 13 Oct 2020 16:25:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        peff@peff.net, masayasuzuki@google.com
Subject: Re: [PATCH] remote-curl: add testing for intelligent retry for
 HTTP
In-Reply-To: <xmqqd01nm60u.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010131624060.50@tvgsbejvaqbjf.bet>
References: <20201012184806.166251-1-smcallis@google.com>        <20201012201940.229694-1-smcallis@google.com>        <xmqqy2kbmalb.fsf@gitster.c.googlers.com>        <CAM4o00e4wYOHkn38H8UwqboRMSzAs4QCvTN6Ef6PuUnYfwOoXg@mail.gmail.com>
 <xmqqd01nm60u.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FBn2+atPRHRywNa5h03VCckpzyhLx82wqZhgdVBZvYDkZ0xjeDf
 866Ik5JXTNmVZIYHTJ1e+KlAXXfXQ4Ql5lMwwkJrUssXtNfRgOMSE38LiZR3ZzQQXgpU/vO
 0FhuQ3wH1fAyHPXB4qAZAhelzOgM53WbWp1GHHvED6OTvhPsN4j6ut9oXo5P0jqHMFgNBSS
 C3zkiyxC+5GgpbCi70y9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wobkmgocroo=:hVots/Kf8VLPno/0g600hd
 d5tGwDTezoD6d+Euclo6EoslT45oWhPqfVmNR8DiBrqRqhijzgM2eEEbZxpp4nSMlZABVnSDb
 zBVtiCy1c2cATAw3wQD6y+qxMj0SgvO5bfGY11VNLOJN7RM2DMRw4a+BNlcfEZCxpCbpxo4aa
 TEQLhy3KYdTMIFGeQ1c7CmalPTRlI7ulRQpd53wIfxcekNBDDUqtSLqnvLOS1TcfuaSgwbpIO
 Lv39m1+Xrw7kqyl99cEWaIVph7Opw5BA+pRjX5mBBZEwl3UczGB85npeI994Eo6HVh4AjEoF6
 SdZoZQIeZKKM+2xJJmxYecZLxVZXIgNNpTtAujmkeQty/hF8w52RGjwSJwUDASMt2tqmR1Y19
 8qUaHL3WG22TmbTkBw1KIP2bPROq+bMGcXUIXndfTc9ZyemPlo6ihzDWJiwZ3OXcDgmaF12OC
 xnkDdcn2fHrjxuNKEtAGd2Mw/mWxWgjVzg7YHvXvbDAbVE7edzxbpOKXSkYAc+YCHHV1QlqY6
 DKO5Eb/waan6NUd4F5qNCVDV524FRnow2p91IHWuBbYtimsbqsHSaABx5bwZDtJs4BKP4yvNK
 AsmHzimcOP7ZfKjWLCH6+/Xbfu6nfIHGPqPjFXrWY8nfmErcaZylbO15wB7E5mDWk8ET6dDeS
 Wki7l+JHBJdj5GJtQ2hfUNdYq/YQ+sGZXUux82UcYk52ffVx8eHWSs5FDzwYpcskcSsBAA9i6
 WledWfDIg7J1XEOpmjjGApGniR1gWyHDMIsc/KCkcQENfsYmRzBAmk+GmfLAC7rafLB4mvMP4
 6C4XLVVfN02pnJjiHxpp91koVfvAX9VFGvrNqzl5agksUAaDhvcpqNeq2L8LQyheZKvsupCku
 F33bocwMHr6Ig4VR8Pv+XPpeFKEM9blznuP2/e3fc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Oct 2020, Junio C Hamano wrote:

> Sean McAllister <smcallis@google.com> writes:
>
> >> Sean McAllister <smcallis@google.com> writes:
> >>
> >> > +# generate a random 12 digit string
> >> > +gen_nonce() {
> >> > +    test_copy_bytes 12 < /dev/urandom | tr -dc A-Za-z0-9
> >> > +}
> >>
> >> What is the randomness requirement of this application?  IOW, what
> >> breaks if we just change this to "echo 0123456789ab"?
> >>
> >> Or "date | git hash-object --stdin" for that matter?
> >>
> >> We'd want to make our tests more predictiable, not less.
> >
> > The randomness requirement is just that I need nonces to be unique
> > during a single run of the HTTP server
> > as they uniquefy the files I put on disk to make the HTTP hack-ily
> > stateful.  I'd be fine with your date/hash-object
> > solution, but I don't know that it will help make the tests more predi=
ctable.
>
> If so, would something like this be
>
>     global_counter_for_nonce=3D0
>     gen_nonce () {
> 	global_counter_for_nonce=3D$(( global_counter_for_nonce + 1 )) &&
> 	echo "$global_counter_for_nonce"
>     }
>
> more appropriate?  It is utterly predictable and yields the same
> answer only once during a single run.

We should also consider using `test-tool genrandom <seed>` instead (where
`<seed>` would have to be predictable, but probably would have to change
between `gen_nonce()` calls).

Ciao,
Dscho
