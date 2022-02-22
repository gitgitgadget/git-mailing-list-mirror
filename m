Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD4C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiBVNGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiBVNGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:06:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F22139CDC
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645535133;
        bh=AL5QWyiFUdi+tDDBT7TwjTNesqpKYSgRzHI55urCIeU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WjU8HJ4zta9ivmHYod1qAvc6uB5ZlREG15/a0wVA4OS55UnH2nOs2IGqrvjsYB0eu
         78QnFreNumfSaDRlW+NoVeAPzeemVvStInUp9UP8s/FmWPCUHFyko3U/q3624GtEW/
         b2SDssPXYcD8ftLzRn+BgOEjVt7vOEpws8B1Qxmw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1nhL8D0T8G-00Vzjj; Tue, 22
 Feb 2022 14:05:33 +0100
Date:   Tue, 22 Feb 2022 14:05:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
In-Reply-To: <CABPp-BFCvOkC1KSVm3qKUcaBFV0pUg4MJf5h+shj=TFZzWscUA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221403590.11118@tvgsbejvaqbjf.bet>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com> <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
 <CABPp-BFCvOkC1KSVm3qKUcaBFV0pUg4MJf5h+shj=TFZzWscUA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:78IxmRyQnN7MdrWyQhAE8roObR/v1yycdEAgZdY5QmmKd6mkUyu
 oSpVcCZQF2owOSCwtjIXf3Tlwo90VIggeitOHFZI+eCX6GmGzRBXeXeYImetDzWUFp6sKKq
 76eP/2H72Uol1+AOxsGZIaim6afY2+yvfXndfgQ8vV6cfCqwCGsY315mSw7lH9EdzuLGgUy
 JMIswlCBSUlQyX5TqSJiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eCKt/yJ77rs=:7qS2vug6iFDyHhocF/LWMz
 LvQBJuKrJEmVs9UKp7aJsHWy26P4LYTgEpto4oiQxcAi5tjFc7n9eJbrE9psiWuFXdvkvqXzz
 iRwBkvNtSqwcb87w7i/3TObiQHJ+ZsVdbF0CDunAJcQN6yoww9luRYlPWslZHrE9uU2jCap0u
 T//BGZdWusnqhpacqLdULWkNEZ8/yozC2FcOmS2hZktwI+hrVTkzstxUwDpdlJyHpGDlOrOss
 s1LYopRJ+l1RGONT1SvIzS9NHUpgoVC+gzQnrarM/wAVtAcZS9wQ+URIwJ6rbm67u0erJLriI
 DdVtKhEIWo0u4RGbcTEcSj1xHgadpLszdfGctPgrWlEDWKfETLoO4nqMyqHdTB/XGEjrkc5jK
 nGUVeQSJWK5U38j+oEhm3QMiNCyMOkvAFIJbqLaRnRkIPltENYxqTPJkXXcJQ1YQYVAL0Zyzg
 NQa7fzcIipDYoAoR7e21+C+59SVzVPi4Vmr8B9xu8RqTgNTaxq1KnksdJZXRcqnDym30N8/UK
 jE7gz/yDU4JSMGLNUUpwLcKnT/L9hMWPPlFSUyU+yy1zuT9/n4aJCZ2dbWU78pp1XY0F9M96e
 Z95klb7phZmD62r2uvDehFFeWtNlKUMLGawiLZioZbB0S3wswiafRcetObsF7nQU7QSCYmqE7
 7SNHAJE5zd7vg4T6Thf8ntbuNDDVIFfGAykZ6wph89Yc0jea1F7BRtfTNTaa2II9oYByiaeIQ
 UUY19wdUQsb/7Dxk/7aaSMGh8A4ib09Kz8BGmOgFUpOfcJuhBIqQ/umJJ/+NuLwlnNX7c+Tiz
 BkJvnKEzPrqUhZC4EqTr+NUtA7rBAQp7+gUKGx/5AUkdvj1lOCP82l4FBhgSJjUIyVAppC0sS
 5/R0oscO8BXTwDP0lLx9/rPQ465czfMo1wvIegFv5lgahh4HvHDz5v0DLLjpW4c2DPwDBmxuW
 ram8RPTKP72PaoHBMOvqDJ8FoWIQdOLuE03+E+fWnfnrDy1dyN0vz5XQgOKXPW528UXyCYyTE
 4yZ7BekF+cb/o2QfXr/8T9cyygr/XrGr8odwvTpZ/0U/AMbBExe120czdB+wrPsMaIvnMjzJI
 bzKFSonZB3A0bs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 7 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 7, 2022 at 11:36 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> ...
> > Mind you, I did not even get to the point of analyzing things even mor=
e
> > deeply. My partner in crime and I only got to comparing the `merge-ort=
`
> > way to the libgit2-based way, trying to get them to compare as much
> > apples-to-apples as possible [*1*], and we found that even the time to
> > spawn the Git process (~1-3ms, with all overhead counted in) is _quite=
_
> > noticeable, at server-side scale.
> >
> > Of course, the `merge-ort` performance was _really_ nice when doing
> > anything remotely complex, then `merge-ort` really blew the libgit2-ba=
sed
> > merge out of the water. But that's not the common case. The common cas=
e
> > are merges that involve very few modified files, a single merge base, =
and
> > they don't conflict. And those can be processed by the libgit2-based
> > method within a fraction of the time it takes to even only so much as
> > spawn `git` (libgit2-based merges can complete in less than a fifth
> > millisecond, that's at most a fifth of the time it takes to merely run
> > `git merge-tree`).
>
> Out of curiosity, are you only doing merges, or are you also
> attempting server-side rebases in some fashion?

One step after another. For now, I am focusing on merges.

But yes, rebases are on my radar, too, and I am very grateful for the
head-start you provided in `t/helper/test-fast-rebase.c` (and for the pun
therein).

Ciao,
Dscho
