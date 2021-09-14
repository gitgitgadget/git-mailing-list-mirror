Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C64C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A74610D1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 10:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhINKUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 06:20:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:49265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhINKUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 06:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631614718;
        bh=0M0GXxKpceBRWW0gUzKLHiEXkNxTs3uoaLTj89ZTtts=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YAYlSL9GVcKlJjnT7Piq4pnMuCTHws+Nbxx2w0rXQsPbFTjTZx+xubhDt1xfclJiV
         bSIAyK4O5BQ0gvEZMS3TXopTKSPBKEFxbtF3rRqH6PBRtyoVJTu9FHlSDFrk94yvPJ
         U3hBuRO+fl9YkY2gat3XmAdSpScBJXIQamhfuvws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDysm-1mZwsM0Avk-00A0f8; Tue, 14
 Sep 2021 12:18:38 +0200
Date:   Tue, 14 Sep 2021 12:18:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
In-Reply-To: <YT+FzPT0RCP2PdNL@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2109141215140.55@tvgsbejvaqbjf.bet>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de> <YSvsQcGNpCMZwS8o@nand.local> <xmqqeeaa6fey.fsf@gitster.g> <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de> <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net> <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
 <nycvar.QRO.7.76.6.2109131335260.55@tvgsbejvaqbjf.bet> <YT+FzPT0RCP2PdNL@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A2CvK33b6HBFU+BY6p5MkwoEZd0WxUDJoEeXKCq2P8na5B1Uyve
 8UdyhQvuLdGmPQku7W63LKSjQoa3PmCUbcVWeXf7XZhjiPNrgY+mKVgDCtjwUuobw3dZ0oE
 efn1yuhSMimP3wSiZ+FpEs3d0cR23jRXcDhiEqOKyzql8eK9StYB0ewwGXpwKmr39QoNZI7
 b+Dnyjm8fIUue0qc5YqiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7xF2cGfDmpY=:U4KX1A2WsghUgkuCRNb08M
 l3V2Ef+GJy1vLv6+AGw5Wk//LI8U9+PJ+PM8SCd97yvp1qNxs8uHWv510NcUOl72hT5UhAUah
 4RnSv6BlnZZRRzY/ZrFkBEn3ZQTdbnGy8RUVgTc6ZzvE4kpTxk4e6SyIvju3YObMntpY7SQ6v
 b2kIxl7p+3STIFQvJOoLHmUsZciPLk65c5dHYRonOkO5HHQPSYAY3cHcO3ao/oJrDmPoVvyRI
 Gd9j/YcLcsyT+fllHu5ZiqLeTm6hri6GP1wChxgiZFP/8fsEjt8/GZ1Erkzk+eNrfgxZH7Wgn
 ekkevXytAO90Lo9k0+gQtf2AjVGpZ8n2r5iSrRoRGoQ71oej1lYMVH0TlZYE8IVSTlceUO0mo
 aH2840bzdLMaiWWY7OnJyNOXmKkEl74a6ILRxwBGpUWWf82zAdBGPjlIdArEer9HTLmNDcE1h
 Mm7xWIWqmxog5HLM7GAQ4GrzcI9wat4O+rXKJaEtZvnCRc/uZUo1GPX8/SGpLrX/Y6aOYLSLA
 MEwXoShQlwbkUsniPXBkDsqwgdigec3JGJtmYrJfginM8+JoN2Ce42CHxIZFaSAnssPTlIVJT
 8KtXMZq04sRkjmxirwYJTJqXbLDPYva92EwpPZ5T/+fpOjm0ifvoIH6oZBOuNum0Fw/6nVoNN
 OMu5anPVMdnq/aE9JZZUvpV25GmyWeBIql/rmnmhsq0NkCUSQcMvBfy04v9b9wG0NwPtInxuC
 3lX6EPdUdE9ayGuqngYzCpTLfiSdNDQ9NmLaYIlUaSLVOjqd1ehrPZOx7iMrYD9+EMRRxHyXE
 5sgfmT9tt2RjHBEShVQ/v32TGd67ASjzWonLXpR0A5MMCuUJYAdMaQSh9JBsZPTP6FoNLBEog
 20Bl6NheFHEzLBUP+wHtPztX9dyJ1+K5uYXP81ijOyU592qkFhDkhRRZamLGoJGHDI2ZSgN+1
 scPsNSnhNiDUsR2hCKhYpXrzAS7TETSkwAqS1Iwg/2iJj13Wa9GrJ7fm4Ee7m8qcTOsMomr1d
 jnlGyYpE8JGh9NSxHX1E8cZXvyuXKMlr3T/F+Hpxum9I8SykNNvkiMU68Xgp9ZIrYINgMyjv0
 B+zI8Kha0DsO+A=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 13 Sep 2021, Jeff King wrote:

> On Mon, Sep 13, 2021 at 01:37:48PM +0200, Johannes Schindelin wrote:
>
> > > Good point.  So fspathcmp() and friends would need a repo parameter.=
 :-|
> >
> > Yes, we will eventually have to pass `struct repository *r` into a _lo=
t_
> > of call chains. It'll be a disruptive change, yet if the submodule fol=
ks
> > truly want to aim for in-process recursive treatment of submodules, th=
ere
> > is no alternative.
> >
> > FWIW on Windows there are other potentially repository-specific settin=
gs
> > that are relevant in similar situations. For example, there is
> > `core.symlinks`.
>
> Another approach is to stuff the appropriate globals into the repository
> struct, and then "push" onto the global the_repository pointer, treating
> it like a stack. And then low-level code is free to use that global
> context, even if it wasn't passed in.
>
> That helps the primary use case of "now I need to do something in a
> sub-module, but I'd like to do it in-process". But it's not without
> challenges:
>
>   - code which acts at the boundary of a submodule and a superproject
>     may be more awkward (since only one of them can be "the current
>     repository" at a time).
>
>   - it's a challenge with threading (an obvious problem would be a
>     multi-threaded grep which wanted to descend into a submodule). Using
>     a thread-local global for the_repository might solve that.
>
> It's possible that this is a terrible direction to go, so I'm not
> necessarily endorsing it, but just offering it as a possibility to think
> about. The trickiest thing is that any devil would likely be in the
> details, and we wouldn't know until proceeding for a while along that
> path. Whereas passing around a context struct, while verbose and
> annoying, is a well-understood construct.

I would not so far as to call it a terrible direction. It is definitely
worth a thought or two.

At the end of the day, I fear that it is too tricky in practice, though.

Seeing as there seems to be some appetite for refactoring Git's code on
this list, I am thinking that the `struct repository *r` direction might
be the one to go for. And I mean like "move the globals into that struct"
as opposed to introducing that stack you talked about. It would even be a
refactoring where I would understand the motivation, and agree with it,
too.

Ciao,
Dscho
