Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1113F2018F
	for <e@80x24.org>; Sat, 16 Jul 2016 16:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbcGPQrx (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 12:47:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:45998 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751666AbcGPQrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 12:47:51 -0400
Received: (qmail 30376 invoked by uid 102); 16 Jul 2016 16:47:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 12:47:51 -0400
Received: (qmail 26684 invoked by uid 107); 16 Jul 2016 16:48:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 16 Jul 2016 12:48:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Jul 2016 12:47:48 -0400
Date:	Sat, 16 Jul 2016 12:47:48 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
Message-ID: <20160716164747.GA24933@sigill.intra.peff.net>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox>
 <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
 <alpine.DEB.2.20.1607161507250.28832@virtualbox>
 <20160716150835.GA24374@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607161834420.28832@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607161834420.28832@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 06:36:03PM +0200, Johannes Schindelin wrote:

> > On Sat, Jul 16, 2016 at 03:30:45PM +0200, Johannes Schindelin wrote:
> > 
> > > As an alternative solution to your problem, you could of course avoid all
> > > conditional includes. Simply by adding the include.path settings
> > > explicitly to the configs that require them. Now, that would make reasoning
> > > and trouble-shooting simple, wouldn't it?
> > > 
> > > And the most beautiful aspect of it: no patch needed.
> > 
> > And you can just "cat" the included files directly into your
> > .git/config. We don't even need include.path. Or ~/.gitconfig, for that
> > matter. But sometimes dynamic things are convenient.
> 
> Well, apparently you are not convinced by my argument. I thought it was
> pretty sound, but if you disagree, it cannot have been...

Heh. Don't get me wrong, I do think there's room for digging ourselves a
deep hole with conditional includes, because anything dynamic opens up a
question of _when_ it is evaluated, and in what context. So any
condition should be something that we would consider static through the
whole run of the program. Looking at the "gitdir" is right on the
borderline of that, but I think it's OK, because we already have to
invalidate any cached config when we setup the gitdir, because
"$GIT_DIR/config" will have become a new source.

So I agree it's something we need to be thoughtful about, but I think
this particular instance is useful and probably not going to bite us.

-Peff
