From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 4/6] transport: add refspec list parameters to
 functions
Date: Wed, 27 Apr 2016 00:11:38 -0400
Message-ID: <20160427041138.GA22920@sigill.intra.peff.net>
References: <20160419071403.GA22577@sigill.intra.peff.net>
 <1461102001.5540.125.camel@twopensource.com>
 <20160419232243.GF18255@sigill.intra.peff.net>
 <1461109391.5540.138.camel@twopensource.com>
 <20160420011740.GA29839@sigill.intra.peff.net>
 <1461185215.5540.180.camel@twopensource.com>
 <20160420205726.GA17876@sigill.intra.peff.net>
 <1461602647.25914.2.camel@twopensource.com>
 <CAGZ79kYc+uMCJq5tTHujp1YYG5OcNSPiyWuGvVzipuBcwtLNYA@mail.gmail.com>
 <CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:11:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avGpG-0004Dg-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 06:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbcD0ELn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 00:11:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:57025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750777AbcD0ELm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 00:11:42 -0400
Received: (qmail 8148 invoked by uid 102); 27 Apr 2016 04:11:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 00:11:41 -0400
Received: (qmail 22007 invoked by uid 107); 27 Apr 2016 04:11:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Apr 2016 00:11:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Apr 2016 00:11:38 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYGi9bhRfGype7te4cGkxvnKww269kYoykB+76HNnTarg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292703>

On Tue, Apr 26, 2016 at 08:59:22PM -0700, Stefan Beller wrote:

> > Maybe we can do a mix of 2 and 4:
> >
> >    1) HTTP grows more extensions; other protocols stagnate for now.
> >    2) Come up with a backwards-incompatible protocol v2, foccussed on
> >        capabilities negotiation phase, hitting alternative end points
> >        (non http only, or rather a subset of protocols only)
> >     3) if HTTP sees the benefits of the native protocol v2, we may switch
> >         HTTP, too
> >
> > (in time order of execution. Each point is decoupled from the others and may
> > be done by different people at different times.)
> >
> 
> Today I rebased protocol-v2[1] and it was fewer conflicts than expected.
> I am surprised by myself that there is even a test case for v2 already,
> so I think it is more progressed that I had in mind. Maybe we can do 1)
> for now and hope that the non http catches up eventually?

If the plan is something like:

  1. v2 exists, but client/server don't know when they should use it.

  2. smart-http grows an extra parameter for the client to say "hey, I
     know v2"

  3. Other protocols get some manual v2 support (e.g., client asks for
     "upload-pack2" if instructed by the user, server either speaks v2
     then or says "eh, what?").

I like that very much. It lets us "cheat" on the hard part of the
problem for http, which is what David's series is doing, but it provides
a clear path forward for the protocols eventually reaching feature
parity (namely that eventually all servers speak v2, and the client can
start asking for v2 by default).

-Peff
