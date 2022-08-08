Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96270C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiHHNG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243046AbiHHNG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:06:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF3D53
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659963979;
        bh=hHakqw61MtQgivObul3XrDkhszpzEg3DFh/4JAd46YU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kBUacSnl9o8sUp4LvXeu+WzQeACBa5Z+f+LxyQaF3FyEkiQb1fwqZftABNVUGEVHr
         suj+5s3xoync48NYL0WJKfKKSwt0wVrPK6AphVsJPdqdhHwRPQCsbiJoZNxyZrRF6/
         uFAbw+5VmR+rC0bKLERxSlqu6oSORpIr0m2MTd/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1oJg5G0AjF-0084qr; Mon, 08
 Aug 2022 15:06:19 +0200
Date:   Mon, 8 Aug 2022 15:06:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
In-Reply-To: <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
Message-ID: <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com> <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com> <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com> <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DC9TIdCW4yrvFi06+zJlj21gnET+D5parzIPrCl/LU7kx8J1Wnn
 nd9pQkDFmyT/KafUomEDroJx7/cixeqgfGm5iYHmnNamTgUt/0e3f+sgOGCmVPpj3TCrHK4
 KhrR4thPoD/YBSccLTfTNdvHqakwbk1bINpyZeu8lxswHmuyQII/k4MvqnHBm3PJpMDVyzN
 gbWsNhaKD6slZvSryvcWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4CXnMYvT2K8=:tQRWbYQv+TkszsxO6A5OKz
 weyfSzRF8tdf3UU4KluJGkHUFIQzarhrt0Zz5N86jODs1aC41707oIA7Ylfg3OASH/JQNc4wl
 dH0cehimG3bywB4GIvZCDKwRRpjVdyaaJXXhxNF8OLvbGNRtT+naENhSOENyh1nYFg+t2bR9O
 Q6yqSowVgv32qNSYD9yv6osrOQZrcn2suCh0s1muOYoU0wD+hwesAR3+7Whnd6jJaO1xXHTXm
 cZUXR+6eaQY5apk1PdCtwf0a3Z+1cgjVO0uW/VkvW52YSinx0cZcbt5FD/fEsMPOaaIgVs5aD
 5iGTAICH+Ah1f8YtVENYaDnL2ap6XdGpgOYVODAy90nFeW7dYcwxNNrVnQVZjcUjxHZ3c5Luc
 5Bqlni0A2P/rdviE9u/om3ZyKUkr8t5irbmLOXmFUHnJJuGmmF9JWA9dRCO+fxxPtq2efQ23+
 ZS8XVEbepr14kHn3oydo3RNkkFeuK6WvukhSmRab5YY4sol1Bd1VFly1Rj3PNwolfa/WVxzmr
 XPThCVaGdCiojyjZ016Fm3+WC8kMdPA41TwJNtHM2Yy9tDByvieFi/G7+ASU8GOWnEYPXnV13
 ScHN+a7wU/fDg+Ud1CoxDsyB1yLhDUXrweNM6p4UMuWuvOCF/H7Rcw035zM3cTckf2qEvuJEn
 T8nyH0//zNs+1PwUPyQadEoKNlPFAu/9nKcm9JeIgHY/bPNk4SP2PPL6V/OGJmmd1nGlcdI4r
 ppLUlhJlrjEV3m7UP5d+lSLuFjUo+s2nEEDPbV+Ur1e8OzlMjzDmo80kceATf9jBu2PMwKqaV
 dQ3U1I8a0BaU9O2wk3j3TwloF0XJAwNCZbNqWp+FFzjlFybcqEuaTX+ECGjV7pH83vKduJ/Ay
 lt5NWyzCiEmpEd+qGbA1xyfJCY+FVaFO+a0S2nJLjdk5c5+VqOlXgVK1J7G1G9tJBuaS1xRyu
 PSO0PzIhWgL8fZNXLjEjiertRa8qeyqolYW1Nd2ZYZRQZaXZNqI5lpbvVfpAmG35oYpZeTeHv
 KA6GokUulI1rOhjZZU0qhesMjzFl3xM66UZIMcgmmIcIjMGNLRLpGoztRmIFaeAZRL1fjwGfg
 +sKrzFz9rLSX+X8RdBkHbz8xdxRnRxH71tNkkB6zUBoM+Uz0qZ2CnK14Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Tue, 2 Aug 2022, Abhradeep Chakraborty wrote:

> On Tue, Aug 2, 2022 at 9:05 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Since you are very familiar with the details of bitmaps now, I would
> > like to encourage you to work on some kind of validator/inspector,
> > e.g. something along the lines of a `test-tool midx-bitmap dump` (and
> > later `... verify`) that would help future you (and future me)
> > investigate similar breakages. Ideally, that tool will not only parse
> > the `.bitmap` file but immediately print out everything in a
> > human-readable form.

Have you made progress on this? I am interested mostly because I am trying
very hard to maintain passing CI runs of Git for Windows' `shears/seen`
branch (which essentially tries to rebase all of Git for Windows' patches
on top of `seen`), and this failure is consistently causing said CI runs
to fail for a while already.

Ciao,
Dscho
