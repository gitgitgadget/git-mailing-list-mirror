Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A9C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 10:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379417AbiEMKV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 06:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379406AbiEMKVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 06:21:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BC1737D7
        for <git@vger.kernel.org>; Fri, 13 May 2022 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652437295;
        bh=yLzT2NGLVeD5graUNLHTPGo7YZVuFojGgAqk5WF4FMw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gUme7v9XZPSXTwM3YLEu75G16JzTpHAVNzNqteKni7iRbSH6WGpXBVt7rkJdI5uWq
         sj9wsJFS3VDptkerAz4mlR4mec/VIjs7fCVlccIGV4TYBIFxehkBlxwjhpLI6wNzbD
         dYH5R7kKTDgc3PziJ1wxc7G/3Qg8yTAOMKVMlw+k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.215.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MplXz-1o8Wt02SQH-00qDCD; Fri, 13
 May 2022 12:21:35 +0200
Date:   Fri, 13 May 2022 12:21:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com> <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com> <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aOxTa6XygmpAROLkyb6GxksNAuTO7Y9MF9q0Em9dkE55f7GSjPH
 VZIyB3EuTArEn4/W9awHHbY3keRc4PFRiAGWrE4vj01pvm0+vTCqwdjg3pS573pI5QO3Yoz
 Rr2vhoK3oMuO2nNk9U/zr9oONk7gwtySaxrhpT7X7yeoaTEwnhHvpjjp2A8pleVahICAJLR
 /+pzJ6kwOd65qFFgUJ/8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vSHvBPcFMh0=:WmNlpYicfWkWgBq1z0kP+J
 btY/6J18JvkCw8xGcGLCnJ4SJvGE0aqAS5cuOz1JDZfdiyNQwz3+kV446VShO4E2iLlzLJEF8
 Zmdmd7NKt3OFVNLGf5G4QYHCtczOuY02M+a027Z7VOVb6LUeWc5jc7AamtqEIPyoSRyKbhjBU
 sCXvp2HA517qPCf8ujafVpzzoV1IS8/QwEIekuLui9Sv2L2kgZN1CCAi0V26Pg1S/JJJXdkzs
 7e9rVYQwJF3OBjYqXfK7Loo4n5JSHoAj3XndVhenzPhmdh7yUCrV7HmX9ylFqbq/pr++Llre4
 hHpfEau2icBUnumAq/jDHlSTbnn4mhZp6WmPR2m9SebElVCCn6O3odFw0evi2t4pex2fbzK8l
 w/2S5iJ+8wCZbE3YKy47p/znbOR8HXjN5rd0noxHcsFjQocFfXmyMSbmMnVhyg/U0JVU6gzSI
 L4Kh10hBPpR39XLUCepaFiYkyyXF2I0vU6Y4zPWGGJWyZgXyUPY654Ulx/7549X5a4J/RoTi9
 1x9RA0uGD4xTLr63IFuN9N/HeDYAV+bqQ5M76WfULw+oc1n3dIzZcabgPPIiV7u30WsAVlygh
 +Vp8hkC6EJ0ETPuULvdYH4GBIH408N4VYU4C75o/WCXP0obphvVhz+oWPJBsRl35J+UTqzYCz
 Kyg9Pb16/FMMIvejwNGso4gNfjkQsoI8A2Y5AAjEUNilFSNIrRmWO2QSHnbkVwEt4q6SWXC7x
 WDqb4J+eo9ELndfGti3Ott60uNauX55lfeq64BL7XGqdliOcWLrkW52zUpRo6VO9kw0qmGL4B
 U+7BgEWzp6HVJ8i5eUJx9U5vguJbPhR0mY1wkMs5Y2uNtT2iiLRA6etA24mKM/3nMw+7J36Ww
 R2gdCwW321nIrH4BduXe5chCZHcnzdW0EBsVjlx6gjC9l/6z2YGDvhwtDCxB6B+KizwRHwydz
 Th95+gQsPvhAclxfA+ToQ9GxfM6XreXuyF2BlEwT8u76272+/R9DKKJDHb6KJwrw57mu1oQsI
 giBqXqbKcDamCFSHpFyHlqLAEGj8Al91NLT9kXMNNDQ+VYVITLJImyCZayPGL9Yt8TjjF8yeH
 EQnYRJZ3wuAzTo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 10 Mar 2022, Johannes Schindelin wrote:

> On Tue, 8 Mar 2022, Elijah Newren wrote:
>
> > So, this is one series where even if everyone else says to merge it
> > already, I'd like to wait a bit longer on it until I feel confident we
> > have a solution that handles at least the current usecases.
>
> Fair enough, you're in charge of this series, and I really like what you
> came up with.
>
> My thinking was driven more by the users' side, as I am relatively eager
> to integrate this into production, but am loathe to do that with an earl=
y
> iteration of `en/merge-tree` that might be substantially revamped, still=
.

I've been bogged down with things elsewhere, but should now have time to
help on this end.

Elijah, _is_ there anything I can help with?

Thanks,
Dscho
