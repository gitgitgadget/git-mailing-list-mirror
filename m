Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6661FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 19:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbcFWTWz (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 15:22:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:59296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbcFWTWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 15:22:54 -0400
Received: (qmail 2164 invoked by uid 102); 23 Jun 2016 19:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:22:54 -0400
Received: (qmail 14087 invoked by uid 107); 23 Jun 2016 19:23:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 15:23:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 15:22:51 -0400
Date:	Thu, 23 Jun 2016 15:22:51 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] archive-tar: write extended headers for far-future
 mtime
Message-ID: <20160623192251.GB32745@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160616043758.GB18323@sigill.intra.peff.net>
 <57687417.4020009@web.de>
 <576A2631.2000608@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576A2631.2000608@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 07:46:25AM +0200, René Scharfe wrote:

> Am 21.06.2016 um 00:54 schrieb René Scharfe:
> > Am 16.06.2016 um 06:37 schrieb Jeff King:
> > >    2. System tars that cannot handle pax headers.
> > 
> > In t5000 there is a simple interpreter for path headers for systems
> > whose tar doesn't handle them.  Adding one for mtime headers may be
> > feasible.
> > 
> > It's just a bit complicated to link a pax header file to the file it
> > applies to when it doesn't also contain a path header.  But we know that
> > the mtime of all entries in tar files created by git archive are is the
> > same, so we could simply read one header and then adjust the mtime of
> > all files accordingly.
> 
> This brings me to the idea of using a single global pax header for mtime
> instead of one per entry.  It reduces the size of the archive and allows for
> slightly easier testing -- it just fits better since we know that all our
> mtimes are the same.

Yeah, I had a similar thought while writing it, but wasn't quite sure
how that was supposed to be formatted. I modeled my output after what
GNU tar writes, but of course they are expecting a different mtime for
each file.

I'll look into how global pax headers should look.

-Peff
