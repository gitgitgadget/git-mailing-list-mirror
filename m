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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6FA1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 10:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJaK0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 06:26:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:36215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfJaK0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 06:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572517606;
        bh=VssekLhTToRrifuPRBnqEX0k/XBZlCXPs46rqZ+Qvnc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CjHj5iJ6NOh0Uxaw90cRya7zPcPSQGgXJw8Ow556FOQvY1pe3Q6oaU7i3Z2ojziQh
         AkyHJWV/PMLCYE2y3A8y68iqqMXGSFiIBZe9DFenJNol9jdWI1DbODyBKQJBT3qKXH
         k2SGlPNknBNSioEfwfibRFCtAklye4D2VIiU4hPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvmO-1hrKXg0BUM-00b43y; Thu, 31
 Oct 2019 11:26:46 +0100
Date:   Thu, 31 Oct 2019 11:26:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
In-Reply-To: <20191031062454.GB20830@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910311123010.46@tvgsbejvaqbjf.bet>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com> <pull.428.v3.git.1572379280.gitgitgadget@gmail.com> <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com> <20191029203259.GB12337@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet> <20191031062454.GB20830@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r08nIBv2+bNx5ctGMUKjxbzfWSwOlweF5yosT6N/gowsdU1Nmaw
 gajOGAop87zuLoV8XRXV4aGym5m49oQwi+LkF5WVHLNHLavxwfpRWJxXabW3+vUiWyFb8YY
 Axa4TFHkGJ/iv6d4uYuBbtVDGM2Hgw3q4QLOqm+St7aS8BFJIaX5aD7Ll4EwpfxCxfoGrv1
 DhPMSO2zYAW1AWjFM2Fhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mUTt4d3kNlE=:KsVfB66lPvegUbWx/gRCDd
 dPrOQ9tB2PTZKV+cwUw+4Y3F7iWPaQrnjv7DL4LORoqRhQicZfzqUArF5hOgWenZ759/IQo6+
 rXiHSzkPscZWRwDDPnRH206uVeE1j7dvdD5Ik9ZbDrn1488xgKz0v1HqHtti1fFp4xkAAnaM4
 GCKLDpz43AlTJ/VrshlJR8Hph4Z5WvFxGfR+1m9D5S7gIbeUU9GgyDUkpCHtRlrnXxSy6ifF9
 PYZSH0XBGKFrBHoT0crcgcFrPG//dx6CUExJv7StLf8Nsn+ivJOI/5jW4s+gNAQKSg/f0t+ha
 bAkBOd+vVhsFuzhImpT3tEYrNi4ZQ/RoUkEJg3emCHNwBAYaS9bbU30Sl9e4EUXe/H6FmYtWP
 9vKmrprDhAJJ0nYIav97Y9QlTQuvbdSBDoFICfqEhpKoZImCXNGd1OZXes+e/YBy0Z4MeWkCJ
 lvrx8zi1QOqzqYhzBcHcmBARCsPtvaqtIedGLS+tOO8w+uAL4HBOWU3mTVFAvM6+oZxYiOW+Y
 SBVHzylsc/fukAJu027xLqm20dy8CcrP0kk1+daxWLK2RYFZmNOgFFlR9JxL5/3v1Bk658Qrk
 hX6lCkm8Z/RHcGbIcPMxFNUwaNBPh3nd6/q59QlZ9OCUlgMq1fFakCh+pQg/DGD4YCSWbPrYK
 yGvGvaXZx/QoS8XOqBKrFOZQ6K4C18o0zHqbkOiXl8h+f0e9qlQZfK89hXEpiqcWxcbZdXjy+
 gtWQVhRvriGQ3pdFeI13yY2ffb50O8AMbPNpZIrpBvkc/rulntLJ+cIcvyfEH9j6T5rcYfNOH
 MiLjwkw9uKO1+slJopBCz6SxnS2CT0YAJkqKlTb4m11VfhFskE8/P3MxGCJjH+YT6fhFpF5Ok
 wILDPv3vO+CzxjgQHKopgsOsWy9Fb3hcAwShx2AP9NTjJrPTc2Lt0fSfO+ry1iodKRBvTSpb7
 yG7BFbXKc0G2KHufwTAisxypIsiZ/5fns3r5urZ/kzK5L4V4io0tb+jOiIyJ4DIc/6E0ULNP0
 vg5l3P4naBGBFlLyXW7byLydKM0eayUV4MLmTb6a75ryW6poX+9Mm2f43DMpRhtSNP0zcEsHf
 XOBKm9rjzV40TK7tTt43w6IgGgm/25UewyHBcO7/53a8hq6B7y527gPL1H0PhjnGC+19fwVHG
 DC1T5eRw4K+pmE/TPnbhJJXtRedVXSD/UAqiz3zpjeDYHhA+pvo1z+1mlCkLqR2EIA8LGPQnt
 kqvFZPNMOQ9I2MGbG14aA5aA4RbcMYGKhe5AFSQ1MkGe6fbtXzVZWqQRV5ok=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 31 Oct 2019, Jeff King wrote:

> On Wed, Oct 30, 2019 at 09:54:52AM +0100, Johannes Schindelin wrote:
>
> > > One non-bikeshed question: would fprintf() on some platforms have se=
nt
> > > "\r\n", which is no longer happening with our write()? Do we need to
> > > care about that?
> >
> > I am not aware of any platform where `fprintf()` would automatically
> > transform `\n` to `\r\n`. Not unless the `FILE *` in question has been
> > opened with the `t` flag. And I am rather certain that `stderr` is not
> > opened with that flag. And if it was, I would force it off in Git for
> > Windows.
>
> OK, thanks. You guessed the platform I was thinking of. :)
>
> Another more far-fetched one: IIRC our stdio wrappers on Windows do some
> magic to convert ANSI color codes into actual terminal codes. Could that
> be a problem here? I think we'd kill off any color codes in the actual
> message due to the control-code replacement. In theory the prefix could
> have them. I don't think any code does now, but the PUSH_COLOR_ERROR
> stuff in builtin/push.c is getting close. I wouldn't be surprised for
> that to eventually get folded into error().

A valid concern!

As per eac14f8909d (Win32: Thread-safe windows console output,
2012-01-14), `write()` _implicitly_ gets the ANSI emulation of
`winansi.c`.

So I think we're good.

Thanks for thinking of all kinds of angles,
Dscho
