Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CBC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2B2077D
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KAXTkYiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbgFWVPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:15:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:52311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392204AbgFWVPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592946938;
        bh=SjtNsG+urZJnWaqaAq1mz10SqXDtUiPUPWmkESfbaxc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KAXTkYiI0GzV5KfR/gSzJL+juBjevvA5RN3Cte3W/bE1gB701zdDx+47BKjT6F5Fx
         Y9MyIT/uQDlHNs19fOurlDgD+fyMAu67xEIcswcUWbbQIyFvQh6GlGQ6o45e134Hjr
         VlOe8H5iZXwiVtkwrP1/UhK4DJZBsDMqgUbrgjj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1jZUF41dVs-00KxhO; Tue, 23
 Jun 2020 23:15:38 +0200
Date:   Tue, 23 Jun 2020 23:15:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/9] remote: respect `core.defaultBranchName`
In-Reply-To: <20200618115028.GB41345@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006232313540.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com> <20200616123559.GB666057@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2006181218270.54@tvgsbejvaqbjf.bet>
 <20200618115028.GB41345@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dIiLTb85FFjddnKIJE4bW2ZIUahbN/DWciQfyLDSZjkkC+gnZda
 Am2igaSRO6KkTYwddGOREzgTnu7kC2OmBL6edTaoOoR/usYAcQF7f6ItD0wWvmkorkkeB61
 ispuoRnHv5MaYjxskI9dbKcYuBiPUaP2WFx5Rs8NFRDVSF8cPlNnUnTX/3Cp4lTZtta0Czw
 bxg5brSsZlVfgZ0Azeqtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pnvam1onuoY=:Ho0ag0BQBRZql2rKKspyvZ
 AvBrbAf0PWGQ+y7wV+i14IhUMsquB/RswEQeUuwfqnE6QhZ+3To1ephJ3q+c2lFrlNlbSZVRD
 AkBy3I0uqPWEjGfCYKIKRAcWP9efApBS5QpN46/zEY33WtVbT97hePlf0xIUBA7KfLb3H/sa+
 hAr+dXPJ/fBu+jLkDQtq2FM0UxAh1HFwiXVz5g4r/oH5VT7I6wH8o0txYJYN2wqOdiIukVfI3
 5gMYqzT834D1oNVKPJ/BkvZfQ6UZObp8ZRNIsbumzYgMLRpFBrvMqtvJqUKV4P1K1fA/82qUZ
 cc1gDcbjbZHy/36HGt/PF8ww6O7eY3m3hHxz0zNqXoS9aOL3TO2qs2PFm8EZTf5NKHQ+c9S/E
 2QrMwF9RfMFLg6uD/tTZgYyH/rTCi+WpckqGP0LxZkQvDqLZ57qXWKk4Xwt8ZVelDtHjoUPU1
 P3JGBgxpSgSzkxFkiMwxZEduQXtpPiZ37xUW6+SZxeE+7gmPgHkDKGnTIWroLcaRHu/I/WY3r
 vJBYQRUBsIuLWnrBtW1k/5CHZyeClC9NCKno08/AcZy4VygcERitRGXAY40tgm6om3QGMd8Dm
 R8Hisp9DH5aHLNzH9MKiI33kgL/CM5Sj5TBWLzWmPvA7/A1baMT0WzgZ6j/z467CdbUvp7T/y
 vk8+rADhU/PmMlcbmNfmKJc7w3LqCa48LlwFQjTLLvw4nMQdclyq+t1tJJ1jIcZZftI0UuKAs
 K2RuXKfhA7qmtRNCc3Nrk4eJQjRtlyo0wwYvIqYwsjDCunxYweE/eONAtrR8yqWtdI3bsZZ4D
 FDrPcG84UF/pAW1mmAtQc625xdu9lvMGGvMOrz52NtHRN6uPRSC4uVO2Y4hrqs0EAMlTaLYW5
 QvKfPpE8/ctCgq9L1xaRz5j9+AQfGNR6+W0nImvi+95tmVrw/PVevMNS23GcS5uJMBSWL8HHu
 cenTevXr5CQ9D5ODpDSNL59FtEI6n/l1wl4eXoJ2WMRnny9xQ8u7R3I/KPERsgGju4Gyhw7oO
 VAAABMeJhYlMnH9VBm5ImnWfZ0O62gt6hJgik3vVgv978cYiruB4INsmt/cwihsdrzIuF5TYB
 +cXaOszEg7Di3Y3SC/1jYjM8AX7rpCk5odYe223HWXMO+tj8BR7MHfAkjzjJESY2QqYtPZSmj
 KI9RhqVL0NYzjjw2E+7sLVg/dVpns3hVFaNMBUonnjg2jQjDBiAYQy4aHpoyauW/wl2SHTxnO
 RmKILwfCezk3CJDYJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 18 Jun 2020, Jeff King wrote:

> On Thu, Jun 18, 2020 at 12:21:30PM +0200, Johannes Schindelin wrote:
>
> > > Hopefully this would not matter _too_ much either way, as most serve=
rs
> > > would support the symref extension these days. But I still think we
> > > should do our best to minimize spots where the user may see a
> > > regression.
> >
> > Sure, we could just leave this alone, or we can just ditch the
> > special-casing of `master` here.
> >
> > As you say, this does not affect any modern Git version, and IIRC the =
code
> > after that special-casing tries to find any remote ref that matches th=
e
> > remote `HEAD`.
>
> I think we need to be a little careful with "any modern Git", because a
> modern client against an old (or perhaps an alternative implementation)
> server might still use it. I have to imagine it's pretty rare, but I
> think it's still useful to return _some_ value.
>
> But as you note, even without a symref extension, we already try to
> guess based on a unique branch. Probably even choosing the first one
> alphabetically would be reasonable. But I'd rather err on the side of
> historical compatibility if we can do so easily. Looking for
> init.mainBranch, followed by master, accomplishes that and isn't many
> lines of code.

I ended up using `init.defaultBranch` as preference, falling back to
`master`, and then falling back to the first ref matching the given commit
hash.

That should be safe enough.

Ciao,
Dscho
