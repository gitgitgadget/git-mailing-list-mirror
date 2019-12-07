Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E6C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB2C206DB
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GkeAmdcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLGUro (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:47:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:48477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfLGUro (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 15:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575751642;
        bh=gicgc3+3P72cbQocnt4rVIbL+EIXp9IwncH+rtniUJM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GkeAmdcrlLrqlv1VzsrowEEQ9vtN/leU/Itue+1TbaE12RfzglrcfF3lbJ5Y4lG6G
         oVX7eEnkSLRzE/N/nIBxEOpe5ZYDDERbb+b6wMkTYB/1Ftib7P7lAdZBGfH8UBeflm
         c2RMR4fN7IxlfzuTuNyThfEz77LiDyFzhVxMnsYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1iFsZf0VjN-00XKSN; Sat, 07
 Dec 2019 21:47:22 +0100
Date:   Sat, 7 Dec 2019 21:47:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
In-Reply-To: <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet>
References: <20191115141541.11149-1-chriscool@tuxfamily.org> <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com> <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wLu6ZMz+V8drOlCgi8Kyn7Af923jNHK34fNNdBGefhm06LUh2yO
 +E0SGndeBrnXQHz9aBqcSzJ1e3eu+g3tfQp85qvPpoftOlf+meBX0Y94xjip8gU5h5gaVwn
 8n0sdhk4DGTMW2u9sFUE53ZohZSiqXLF4x1qV7WJS0oco0iweaMh1yuUmeas3eYhUq4/WIb
 iD8cJ894xzfTPPbOvXMhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7uAWbqdLt8=:M3FcGllcyfsLrXDSeIVKJ9
 0BrjnJ6/HHxzunYxyXGT/Z1YCWPaa9lUc/+oufHBJWQeDNPCKQ//nr6eL144+Om08/dpDCPEW
 L1LhXWtRrHybr2ZhxYagjMx/bFQcNo/BFNQanAWncX2xD63d6FdkREyX7tPOaLPwr0kACvZq3
 LkldL9JhOCwXS35I4rU8TZGDwxL1gToqAlqF2NyZD7uWCU+0OtW0xTMkt4qw0qApH3af1Dc1l
 Uwa7vT7u+fJq3znHLLmOclk7AupV1VVe6i2x0GfRj8WY7kuAXbASWeV92zbs/4uYg4Lodokai
 F9kNFvr1UckP3ObI+BLU17D9euJk5sylLVuOjhMUMHPikPbMs/fw+0n3e2n4t2jOMmyFZGhSP
 lh+VLYMWSv/18oiXpuLAmc0QJbbIezZAE7udW7XaGtuFcF2+HeQagnWqLYMiSVGhbYrcO0coP
 2w37sS6Usvw4iUDrideEl4GXocvM6EMbzgfiTwW5bwCdWgiv40OoY2JClqBj7bPvfXpGX5/+3
 X2zHm8sCFxkpAfzcmWOEVqjA69dW4UfypITNXGzMWSoLtQnpxS9jNQf2/NrLmU5g2PtyLSJzW
 VRv86WhP0T/AQcgCR1LatsEgGE0D/85kgn5gd/3MtiiNhnWMNRjBCEUEFIPZsDkTsJMJS+rzM
 J6RpBUrbNKszd6IXy3oU+85PiSEvbHk0Bvk3D7Ub5YGuJDq7AShtj30+M3X0Rqc9++kxJ6uCL
 ks57nUhbfKCo6OE+pJxL+AT4D+f6Gf2A9ZCS6WUDX8i5dv0sswbqnoVC79+BK/NPs8jK2nQqf
 fi7YzMllLh5k0LW1FkZWH0lHxFbchjojiNjp4Bgn870ePdYqSxQ6IawWqJoI5jR7PGsakiTO4
 37JMmw/01oTgCUhV1Vz6Rb8Su0w/fP2tzZIsbQt6UU6mldmkGA/KEf75k1UyDENOwW2jgnR4u
 Ox04u0w4YXoBTRVr/L411t0hyOKtfxb47ecGMYbaAId+5XyvnsMbTENCQXmpcqxoSypDtWhcN
 4gwcU7z3uKFp5trmiyPkbyMPXkWoXTwbpSz/Sh9EzEOnFcyi3bIpAaj8/90RxrAUU/zn4liGi
 P1vPU5fmlLHY5KsDU7PyLNVO1ycSn89iwTK9Rdyti3DK8tMxJt2y8I8ngyiJqGyVGqNG2Bptk
 oajwbrKberYOMGrDCidmY48pdszqhMYfbIZVMeAzDfWRTP1JULwmkt4UvN34NFdKdD05DKhuG
 UF23WhHNNbf0z9b754p1vfZ0uT9a71Fp1IdNVvX2SumoXL1v3AcnlFasOiOU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Sat, 7 Dec 2019, Christian Couder wrote:

> On Fri, Dec 6, 2019 at 10:42 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Junio C Hamano <gitster@pobox.com> writes:
> > >
> > >> Jonathan Tan <jonathantanmy@google.com> writes:
> > >>
> > >>>> It could be a good idea if Peff could answer some of the comments=
 made
> > >>>> by Jonathan Tan about patch 9/9.
> > >>>>
> > >>>> I have put Peff as the author of all the commits.
> > >>>
> > >>> Thanks. I think the series looks mostly good except for the questi=
ons I
> > >>> raised in patch 9/9, so I'll wait for Peff to respond too.
> > >>
> > >> Hmph, the round before this one has been in 'next' for quite a
> > >> while, so should I eject it before waiting for Peff to respond
> > >> before queuing this one?
> > >
> > > After rebasing these v3 patches on top of the base of the one in
> > > 'next', the only difference seems to be the log message of 3/9 and
> > > the contents of 9/9.  I guess I'll mark the topic as "on hold" for
> > > now before doing anything, as I am officially taking a time-off most
> > > of this week ;-)
> >
> > So..., that week has passed---anything new?
>
> Unfortunately, no.
>
> If you want I can send an incremental change on the content of 9/9 on
> top of what's in next. Otherwise I can't see what I could do on this.
>
> Peff, could you tell us if you might have time to take a look at this so=
on?

Chris, correct me if I am wrong, but was it not your decision to
contribute these patches? Are you saying that you do not understand them
well enough to drive this patch series forward (e.g. address all reviews
and questions) and are basically trying to force Peff to contribute them
instead?

Ciao,
Johannes
