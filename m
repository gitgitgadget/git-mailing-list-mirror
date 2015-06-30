From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 13:58:53 -0400
Message-ID: <20150630175852.GB5349@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630102055.GA11928@peff.net>
 <CAPig+cTXc_RXbOAOaF2MFjrg+DSet=g0XQMZY0ErMYAmNVSV+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:59:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9zoE-00016Q-3z
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbbF3R66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:58:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:53874 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751767AbbF3R64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:58:56 -0400
Received: (qmail 4940 invoked by uid 102); 30 Jun 2015 17:58:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 12:58:56 -0500
Received: (qmail 17250 invoked by uid 107); 30 Jun 2015 17:59:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 13:59:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 13:58:53 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTXc_RXbOAOaF2MFjrg+DSet=g0XQMZY0ErMYAmNVSV+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273091>

On Tue, Jun 30, 2015 at 12:58:33PM -0400, Eric Sunshine wrote:

> > Basically I was trying to avoid making any assumptions about exactly how
> > strftime works. But presumably "stick a space in the format" is a
> > universally reasonable thing to do. It's a hack, but it's contained to
> > the function.
> 
> I don't think we're making any assumptions about strftime(). POSIX states:
> 
>     The format string consists of zero or more conversion
>     specifications and ordinary characters. [...] All ordinary
>     characters (including the terminating NUL character) are copied
>     unchanged into the array.
> 
> So, we seem to be on solid footing with this approach (even though
> it's a localized hack).

Yeah, sorry I wasn't more clear. I had originally been thinking of
making assumptions like "well, %c cannot ever be blank". But your
solution does not suffer from that level of knowledge. I think it is
reasonably clever.

> Yeah, I toyed with the idea of increasing the requested amount each
> iteration but wanted to keep the example simple, thus left it out.
> However, for some reason, I was thinking that strbuf_grow() was
> unconditionally expanding the buffer by the requested amount rather
> than merely ensuring that that amount was availabile, so the amount
> clearly needs to be increased on each iteration. Thanks for pointing
> that out.

FWIW, I had to look at it to double-check. I've often made the same
mistake.

> Beyond the extra allocation, I was also concerned about the
> sledgehammer approach of "%s " to append a single character when there
> are much less expensive ways to do so.

I don't think there's any other way. We have to feed a contiguous buffer
to strftime, and we don't own the buffer, so we have to make a new copy.

-Peff
