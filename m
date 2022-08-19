Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6CC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349073AbiHSOHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348481AbiHSOHX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 10:07:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DEE190B
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660918036;
        bh=BaWwYAZL7WQqnQ+HWJXh9pPCpDM3NAkC2F7VcmfYT80=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bnpehNNEUFqoTXi/58oIVxM5+QiTnPd5gbVTGMK3C7pHHf0XjRtO3eT+PsxXJXDhn
         KjNSeWUUcZ7uWG1HOD5POHP0Zkn8N3rdMes5sMDFFCZRYbES470otmFu9Yp6VWLAVv
         Lo7IlpA3MuUzQ6ipNccWYdUv2o2z9jeaDH5FwTiQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1nmx0z3j7y-00cD3d; Fri, 19
 Aug 2022 16:07:15 +0200
Date:   Fri, 19 Aug 2022 16:07:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
In-Reply-To: <9f8d808a-880c-fdd2-e915-d01c3f116cdc@gmail.com>
Message-ID: <407ns96p-2n7n-rs60-40oo-81s02531q5q1@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com> <ec8204d5-9d0d-9850-f930-6fc1a8efacc5@gmail.com> <p1nn7o5q-9r34-n27o-s8r6-50277p3rp604@tzk.qr>
 <9f8d808a-880c-fdd2-e915-d01c3f116cdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dGrQOW3txJxRuBPEeAaqFTBl1e4UUpuBEUX60Gqviv3dp//C90a
 LplIDeozoPMxiuHNSL0541C0aUT5ETQUNhg417oVyPYgCpiU4NU+kWM4ZYNbn2bSV9nPCKU
 e/t51B93E6T8gbgwyTD5YKoCGswWR0IjBjZDV99XJHdXOT8eYPlRI3RN6Arxlv3Z7dlq34D
 cpVS3g8j2LAizb/fNkeaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCVhzvb/fl4=:/9nB3nxmJ/qGYKWw+9JVfN
 IUdZiD5Sic3eDRes/ot9ZnMvIgyeu8zhk1p6HOf5cGkwyhD0Q5zSZoIiJixI4RriOILAU/K4k
 8kn7EG8FzKXdW/O8Lzf+qyedyMi1QDmRXSXYlT8SlWSrL77+0lPXgCpRUVd2n5bljBBLIw36/
 D9jV+Dg8oOcOH54angm/1ihX5KsMb3jcNnXH0ZsRnX8iheLm3/DBKXnIszgjjE/POCIayu9A9
 OFv1cTfrEg0Ya1gyFNMHdyCVFQEEAbs+HjO5jQQ6963CJQiKX+F/jfusOTSFIlH1gMKwkvvM0
 D8YhoctdowLEP27p33ZDJbWFTx4K+V2CzS0IdFKeOoXGtikDx1lXd66Yg9YlApFdB7pSSPCHV
 IJV5lCaQbqJfL6kpOyKV7sl4oveLKq3SeCsJ5eDVWww726BOext0LaZ5yEYgKmKSFE/5Dzbvk
 Xgrtkm3VX142mmeC9YJy4Vk3d44hx9wCZD/9omIVE78XwZRPFp9jttGyfbphhFXHcxYq4YB7Y
 vjM/UN/N3zSErA9xZN8SqbPLNKmFVkgUmhYVBalosGaiFSxkpTXKYNjPCraw580pg/+LoICMr
 vIUH0RlYV0Yvg7Lmj1pSWuKgOZFcgzuCIrVXCEzI917s19lsEOmzsRDd9aH2MaFRTo4G6Tn9m
 Ck0fFyg5WHv94aO/7AJmI0md1z13ZyJCEUNJqcZfZnb5GbTp1czMRrJf9W7xwk0lBMV6IRRug
 Y/09/jzXxGj/NUUXBu3N4HzuzaBN7sWCB285RE+M4y+YuSnHFHnrwKqNt59DXWtB79imVUiJ7
 k4QfZQxjT4kG4kKO7yoOR5DVAgpItJOUTkuZjyccfVN5faRSmk1M5+prWBC+vK9wDLRtQLFX5
 6P2tPocVtcA7rEqhBYfSEv3limuniN9SINbuafve39M473YTAnQrHdBrEzJ3v2T5d43YCB3y8
 NOOxy+FHmJHYg3i5r3urMm6BI/Flt1Vru5QT5IfAwn86HhKaQdq982P9z6C1sSzm+asXsICQH
 4lYwQN7EvVI5FydeqnLO3zPhasfwSKzWCgDYolC1UlNxYRkZxjrYO94lJ6LB5XIfakqn1JXTr
 +wR2kY5ktoOPIkxTwQzmRGcppZZwY9TvZbeCk45LDXC9Rc60T56mO9RRA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 16 Aug 2022, Phillip Wood wrote:

> On 16/08/2022 11:00, Johannes Schindelin wrote:
>
> > On Thu, 11 Aug 2022, Phillip Wood wrote:
> >
> > > On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
> > >
> > > > diff --git a/add-patch.c b/add-patch.c
> > > > index 509ca04456b..3524555e2b0 100644
> > > > --- a/add-patch.c
> > > > +++ b/add-patch.c
> > > > @@ -1547,7 +1547,7 @@ soft_increment:
> > > >       strbuf_remove(&s->answer, 0, 1);
> > > >       strbuf_trim(&s->answer);
> > >
> > > Unrelated to this change but why don't we just call strbuf_reset() h=
ere?
> >
> > This part of the code is used when the `g` command (to "go to hunk") w=
as
> > issued by the user. And that `g` command allows for a number to be
> > specified, e.g. `g1` to go to the first hunk.
> >
> > The `strbuf_remove(&s->answer, 0, 1)` removes the `g` from the command=
.
> >
> > The `strbuf_trim(&s->answer)` allows for whitespace between the `g` an=
d
> > the number, e.g. `g 1` should also go to the first hunk.
> >
> > If we called `strbuf_reset()` here, we would remove the number complet=
ely.
>
> Oh so if the user is not using interactive.singleKey then they can skip =
the
> prompt which displays the hunks and asks which one they want to jump to =
by
> guessing the number of the hunk they want and typing "g <n>".

Yes, precisely.

I forgot that you are using `interactive.singleKey` (I planned on opting
into that mode, but for some reason I never get around to flip the
switch). The default mode is not the single key mode, though.

Ciao,
Dscho
