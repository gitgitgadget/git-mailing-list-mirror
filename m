Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A5C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67516192B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhEKGO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:14:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:50194 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEKGO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:14:58 -0400
Received: (qmail 21198 invoked by uid 109); 11 May 2021 06:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 06:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20602 invoked by uid 111); 11 May 2021 06:13:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 02:13:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 02:13:51 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <609a07ca6a51c_5afe12088b@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 11:27:54PM -0500, Felipe Contreras wrote:

> Jeff King wrote:
> > On Sun, May 09, 2021 at 10:20:37AM +0200, Martin Ågren wrote:
> > > In general, I agree. I do think it's important that "most people
> > > contributing to Git", whatever that means, can build the documentation
> > > to check the part they're adding/modifying and not find it broken left
> > > and right. They would then (quite rightly) not even bother building it.
> > 
> > Agreed. But I think that is mostly the case (asciidoctor seems no harder
> > to acquire on most modern systems than asciidoc; there are system
> > packages in most cases, and decent binary-package systems for both ruby
> > and python if you really need it).
> > 
> > It does create a situation where people like Randall on NonStop might
> > need to do part of their dev work on another, more mainstream platform.
> > But I suspect that is already the case.
> 
> Or use distributed tarballs with already built documentation.

For users, yes. But the context above is about people who are
contributing to Git, and writing their own new documentation. Presumably
they'd like to build it to see the output.

> > That does make things a little less convenient; Debian stable, for
> > instance, still has 1.5.8.
> 
> And it has git 2.20.1, released at the end of 2018.
> 
> I've never understood developers worried about how the bleeding edge
> would build in ancient platforms, when ancient platforms don't care
> about the bleeding edge.

Again, this is about developers. Are there people contributing new
documentation to Git who are doing so on Debian stable, and would be
inconvenienced by needing to upgrade their toolchain?

> > > I think what I'm arguing for is
> > > 
> > >   1) switch the default to asciidoctor,
> > >   2) enable optionally using it without xmlto,
> > >   3) figure out what broke and fix it, and document which is the minimum
> > >      asciidoctor version we're going to bother with for (2),
> > >   4) lather, rinse, repeat (3),
> > >   5) switch the default to not using xmlto,
> > >   6) drop the xmlto way of generating the manpages(?).
> > 
> > I'm unclear when support for python asciidoc goes away here. Is it part
> > of step 6 (because it does not have another way of generating them)? Or
> > does it live on forever as a non-default legacy system? I'd prefer not,
> > but as long as we are clear about the primary target and leave it up to
> > people interested in the legacy to do the compat fixes, that might be
> > OK.
> 
> How about we leave the legacy system in place as an alternative, and
> decide later what to do with it?

That's what I was asking.

Leaving it forever does mean supporting xmlto forever, which complicates
the Makefile (and that support will bitrot if people are not actually
building it).

-Peff
