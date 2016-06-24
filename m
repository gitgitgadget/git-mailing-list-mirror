Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8A12018A
	for <e@80x24.org>; Fri, 24 Jun 2016 18:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbcFXSOS (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 14:14:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:59840 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751585AbcFXSOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 14:14:18 -0400
Received: (qmail 27464 invoked by uid 102); 24 Jun 2016 18:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 14:14:17 -0400
Received: (qmail 21241 invoked by uid 107); 24 Jun 2016 18:14:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 14:14:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 14:14:15 -0400
Date:	Fri, 24 Jun 2016 14:14:15 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Refactor recv_sideband()
Message-ID: <20160624181414.GA25768@sigill.intra.peff.net>
References: <20160613195224.13398-1-lfleischer@lfos.de>
 <20160614210038.31465-1-lfleischer@lfos.de>
 <20160624153121.GA2494@sigill.intra.peff.net>
 <alpine.DEB.2.20.1606241942220.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1606241942220.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 07:45:04PM +0200, Johannes Schindelin wrote:

> >   $ git grep -A2 IMPORTANT color.h
> >   color.h: * IMPORTANT: Due to the way these color codes are emulated on Windows,
> >   color.h- * write them only using printf(), fprintf(), and fputs(). In particular,
> >   color.h- * do not use puts() or write().
> > 
> > Your patch converts some fprintf calls to write. What does this mean
> > on Windows for:
> > 
> >   1. Remote servers which send ANSI codes and expect them to look
> >      reasonable (this might be a losing proposition already, as the
> >      server won't know anything about the user's terminal, or whether
> >      output is going to a file).
> > 
> >   2. The use of ANSI_SUFFIX in this function, which uses a similar
> >      escape code.
> 
> Wow, I did not even think that a remote server would send color codes,
> what with the server being unable to query the local terminal via
> isatty().
> 
> Do we *actually* send color via the sideband, like, ever?

We don't, but remember that we forward arbitrary output from hooks.

If the consensus is "nah, it is probably crazy and nobody is doing it
today" then I am fine with that.

I do wonder about the ANSI_SUFFIX thing, though.

-Peff
