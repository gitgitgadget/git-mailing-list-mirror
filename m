Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CEC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37C864DEF
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhA1QQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:16:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:34519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhA1QOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611850385;
        bh=pJvFCCH+BlXlMbfCyEFOkbptymQR9zGKkTE+3hm+xjk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lL+MiHNdTg2MvR3zUZSZ54C2NJWfZzqkFSuNuZLWQEAxeXWcAVIEY1g1oCDzgh3HT
         QF7G660pR5xKpgR4O/z/7in6OT4kzIu7W3dlo2/Ba5iYYEja4Yan6dZoZS0eJD1WG2
         0y1vJhNTXeFARkQyAkYiHD+2B0h3sceIU/R4yI4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1lzr6o1XAB-0152Kx; Thu, 28
 Jan 2021 17:13:05 +0100
Date:   Thu, 28 Jan 2021 17:13:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] ci: do not cancel all jobs of a matrix if one fails
In-Reply-To: <YBJbJOLyh+ksolVB@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2101281712460.54@tvgsbejvaqbjf.bet>
References: <pull.851.git.1611806768911.gitgitgadget@gmail.com> <YBJbJOLyh+ksolVB@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A5a0Iqj+bhV4+cArzYbVbFx4lqGUtN3/A1yxutxP54DiV7S5dou
 lka2Rq54SFijUJLpVlM+BjnJDspEbFUovKvNc4/14jVhphCCWY5CZQ3lJ6Wd2PVdOubGvM0
 +UVg79UFsSgiQ8RG70nHrZPu4pvAipqOzmQYTslVcUOgOWuPQYX4Palf41TKUT7PbGPnV/n
 0SkD8uXqml/fJuKsvJWHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nrlL4GYzGMg=:qAkR6PwDjt8AnW8stvH53J
 w1HpGJJ82jzbahxUZXX+CeyTpXbMzKWDiwCfF4+DK+uXkuPI9EoK9u+fI2ucDBkflOZDTHNhm
 xvIh0bA06aXXkq/4v5+M7Cuhzyjaxd+xVmExYu1WAl7QIqSz/jT4/3KzDt89fC4Tu52RVnf1Q
 uVFgNddMeuNSmiAcCUa3DuIB2Qq13aFOIUMKEkkWppfjFaq+avZHdOuprpNg40rXmxbsU/mgO
 T8k++XlhvcwZghtMLwKLmU4EeIo3b/gaiyz2l67ND3Cn8Q9ScoiNtsvdvOFXb1Fi8FCraBEHv
 i0fo+35RTcxQYf94uHayuMoSymk04uf2VdktNjeV7CBhZ1AKVVOkKW2GWVjld4tsxwvrtWNlO
 mVuGzFLUWv2KJxCNHdtSu4cxana3LcGW4Ewey/aosqqqR1d5dGYiPZ3AIBNl/V0mCZZ/MB6jY
 XmnwhRlDs41gy5U1gbaWdI7UtWYBXBZGX6Jh8Tm9mY3tV9g/fkKdmjISHVU5zg6d5cHMGAyeI
 hwk/zmqw41LeTlpT6gzTCjEV+UYWyBaBbg011p0btoJ64GYb/eYCksyAbz9OXgOnYgSHXoiRS
 GRzg6ioOmgjqMqDiOWTo/26ZjXhYy9SDQSIEN/NecrH9oGoPnMyEKvRHopIvGWj070E3Ge4NA
 MRUffdMO+2C/GX2Coe0HMjjX1e0mCvoxZc8QfkU8ZRepLOf7d3gtSzSJ7uq48Q/uqg6bYs0u8
 rEvWXXvVpMFl6gXb4Qmmfupx9yvo4W3+ZgyTHSVKy/vXzMXJxbSp4BoOKXcmTjt5QO6DMu14x
 mnfX8DeRvDUT1DZihiOi3CnEiFPf0BkoWRipF0oz0xIM2PEYjtymJDbMhFbthdGYOxl/CIyIk
 WkwNDhpJsrk/Rw5rNrFg35BeHdBa58zJzd98AGRsY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jan 2021, Jeff King wrote:

> On Thu, Jan 28, 2021 at 04:06:08AM +0000, Philippe Blain via GitGitGadge=
t wrote:
>
> > From: Philippe Blain <levraiphilippeblain@gmail.com>
> >
> > The CI/PR GitHub Actions workflow uses the 'matrix' strategy for the
> > "windows-test", "vs-test", "regular" and "dockerized" jobs. The defaul=
t
> > behaviour of GitHub Actions is to cancel all in-progress jobs in a
> > matrix if one of the job of the matrix fails [1].
> >
> > This is not ideal as a failure early in a job, like during installatio=
n of
> > the build/test dependencies on a specific platform, leads to the
> > cancellation of all other jobs in the matrix.
> >
> > Set the 'fail-fast' variable to 'false' for all four matrix jobs in th=
e
> > workflow.
>
> I think this is worth doing.

Me, too. ACK!

Thanks,
Dscho
