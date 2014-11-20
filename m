From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] parse_color: support 24-bit RGB values
Date: Thu, 20 Nov 2014 15:10:27 -0500
Message-ID: <20141120201026.GA4779@peff.net>
References: <20141120151418.GA23607@peff.net>
 <20141120152539.GE23680@peff.net>
 <xmqqh9xt3bdx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Baker <bakers@canbytel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 21:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrY3m-000238-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 21:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbaKTUKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 15:10:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:42959 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbaKTUK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 15:10:29 -0500
Received: (qmail 24675 invoked by uid 102); 20 Nov 2014 20:10:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 14:10:29 -0600
Received: (qmail 15701 invoked by uid 107); 20 Nov 2014 20:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 15:10:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 15:10:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9xt3bdx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 11:44:26AM -0800, Junio C Hamano wrote:

> > @@ -32,10 +32,13 @@ struct color {
> >  		COLOR_UNSPECIFIED = 0,
> >  		COLOR_NORMAL,
> >  		COLOR_ANSI, /* basic 0-7 ANSI colors */
> > -		COLOR_256
> > +		COLOR_256,
> > +		COLOR_RGB
> >  	} state;
> >  	/* The numeric value for ANSI and 256-color modes */
> >  	unsigned char value;
> > +	/* 24-bit RGB color values */
> > +	unsigned char red, green, blue;
> 
> Do value and rgb have to be both valid at the same time, or is this
> "we are not wasting a byte by not using a union because it will be
> in the padding of the outer struct anyway"?

The latter. I started with a union, and then realized that COLOR_ANSI
and COLOR_256 shared the value, so the union was not saving space and
just getting in the way (mostly because I had to think of useful names
for each of the members).

I'd be happy to do it as a union if you think that makes it clearer.

Also, the name "state" should perhaps be "type". It originally started
as "unspecified or an actual value", which is a state, but as I worked,
it grew into something more.

-Peff
