Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967DC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240534AbiCJNM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiCJNM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:12:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737F4D629
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646917888;
        bh=8kOJWXFP/As94CuZKbAur9QJB6vcIGjdEyCIARK9UuQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MO8F6yanfyqXOvaFPDAzZSFfHkKEyN3q3PoZFPcOgb3/4nBNlyuslMY4oSSd9L0aM
         Ot6wrFkUoBmRACmrHgm7VRx+1IfVejGxKQsIYBN/KJUGVTEqaNBKdr4Uvrvl6chFtT
         0al7/9TRuyJQ6deEmDZOCooS/gOlBHFTffjZ7nQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1nLuuC42ot-00GGYp; Thu, 10
 Mar 2022 14:11:28 +0100
Date:   Thu, 10 Mar 2022 14:11:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Neeraj Singh <nksingh85@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
In-Reply-To: <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203101406000.357@tvgsbejvaqbjf.bet>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com> <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com> <xmqqo82eirnv.fsf@gitster.g>
 <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NCw0sLr/hRwLfHbANugxVhrkMSDYM2abILMg6ugcRCPBcPOW8dB
 YM35eXEipyGQ1qCQjZLLBWz5VIC2jkwANZdtHeM8YL6ZyEAZrxHCCn5pPzfBaiEGLUohF6o
 3P+Qg6VhzcRqTvNCpW6eQMeZw7SpLypMW/gj8Q88hYGL/BJiIhZS8He18M1vOcPAKgKatcY
 jc7aXWe9wHLf1wotz7GjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mtr5Ut8VFqQ=:cOPnR8w+zCkIFd1dS8UC2X
 bDlH0/Add1hUmrBwAKXFzf9RZcT5j/WRcyw+7t70VCyAHqAiiPOrtepjhrZm0yS9sAaFcPwDD
 p+S2Xh7fgx0qeWwstY6SOJ93gChuclvj+PTpqcOy4y20qW1hmJIxqhTWv3LRyljinE0fe6obw
 fS0jr1iT3wVlKymUZJSHb+at0dnkJxPmgukqazxTeP24qvD8G3QqfnxcMAcFDo9onq2VUNTm/
 IJET/e+X5UPhl1fSCn0oea+qT4H9OtJ6R4O2NZEVKL8Ef3o7E89C6CogNhTfXzR6r6i56jKfe
 5dpbWZ83sTY2XoiHnXrnRljtYjspSfn2Yfe7HJkUMWRF3T/kkkk0jTn6GWW070YXLVjIImNx/
 +5RbJPtRAG5oo4qOTY2g36mCVjW9UVyGYjCftPk33Ldhrr9PzMWf7ucV39kPGhHpZekw1gJ3i
 wgWJGaQB0FNFouQN1BvQxydxE5guEx2DkUUqrLsa5QVHbt2IGbheM62dOYWpq8XNHbzhcAq35
 XhVYYGItStk/snsXh2NEOnL/kluHQUN4hUIwKsv4A8SNwyDfpmrgyWZ7QaizO0Z19xO7tStIR
 TbW78e90sDpU+S6ZxUs18+NH/kmgDJ+iFmpoYpYMEPWQkQGh7eBl2o/rWjWyBoJrTvBBT9hY5
 7B49+dmzHynaho0u50dAn5Ar/8wwnigzbZXv9LUlJenz4kKM3zH3Bd3/hEgkgQabm43CL4+Lz
 uFPbc8v+Di554O3bDvVPT/YeOf8Ud4it22lpMSXZnB2UNAUMXZEVSWyoDVwRpD03COd82ygs6
 jCJumS9qcbHwUyNkIZLzTsU+4xX0mG5vjsJyBgjxue4QEsswa4qGXCiHdHA9PGKeJ4CFRfREd
 YdqCHnJGw6ZuM6Kc+UPlJXaLGULK60iHGhVNWRbmh/O2m8Fjvl4hj6ujwqtKgped57OX+R/dF
 GnKVtb8cOoSKqZw8bcs6vvoU6fGUp8X2q9X3Vis9kqphM5lmRp+HHqgycBmIMDcdok6obvdd6
 WdQpnvE2PQU+xLDRCFZZkWHbpOCvNTZJX5vkjV19falTDw0QPIu9EaMz4e1rXUhPIrc5nucjJ
 T1FpwAiHuJv8wY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Neeraj,

On Wed, 9 Mar 2022, Neeraj Singh wrote:

> On Wed, Mar 9, 2022 at 4:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > I am wondering if fsync_or_die() interface is abstracted well enough,
> > or we need things like "the fd is inside this directory; in addition
> > to doing the fsync of the fd, please sync the parent directory as
> > well" support before we start adding more components (if there is such
> > a need, perhaps it comes before this step).
> >
>
> I think syncing the parent directory is a separate fsyncMethod that
> would require changes across the codebase to obtain an appropriate
> directory fd. I'd prefer to treat that as a separable concern.

That makes sense to me because I expect further abstraction to be
necessary here because Unix/Linux semantics differ quite a bit more from
Windows semantics when it comes to directory "file" descriptors than when
talking about files' file descriptors.

> > > +#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
> > > +                               FSYNC_COMPONENT_PACK_METADATA | \
> > > +                               FSYNC_COMPONENT_COMMIT_GRAPH)
> >
> > IOW, everything other than loose object, which already has a
> > separate core.fsyncObjectFiles knob to loosen.  Everything else we
> > currently sync unconditionally and the default keeps that
> > arrangement?
> >
>
> Yes, trying to keep default behavior identical on non-Windows
> platforms.  Windows will be expected to adopt batch mode, and have
> loose objects in this set.

We already adopted an early version of this patch series:
https://github.com/git-for-windows/git/commit/98209a5f6e4

And yes, I will gladly adapt that to whatever lands in core Git.

Thank you _so_ much for working on this!
Dscho
