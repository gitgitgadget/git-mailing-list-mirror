From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Tue, 5 Jun 2012 12:28:24 -0400
Message-ID: <20120605162824.GB20915@sigill.intra.peff.net>
References: <4FC7EFB7.4090704@steadfast.net>
 <20120601083537.GA32340@sigill.intra.peff.net>
 <4FC8F590.2070308@steadfast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kevin Stange <kevin@steadfast.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 18:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbwcR-0003lH-BK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab2FEQ21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:28:27 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43931
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab2FEQ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:28:26 -0400
Received: (qmail 21109 invoked by uid 107); 5 Jun 2012 16:28:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 12:28:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 12:28:24 -0400
Content-Disposition: inline
In-Reply-To: <4FC8F590.2070308@steadfast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199257>

On Fri, Jun 01, 2012 at 12:02:08PM -0500, Kevin Stange wrote:

> > The dumb-http push code is the only thing that does not go through
> > http_request these days. So another option would be to refactor it to go
> > through that central point. I took a brief look at this when I was
> > updating the credential code a few months ago, but didn't consider it a
> > priority, as most people should be using smart http these days. Is there
> > a reason you can't use smart-http? It's significantly more efficient.
> 
> Smart HTTP didn't come up in any of my Google searches.  With that as an
> option, I might just drop this work now.  I'd rather see incomplete methods
> that aren't recommended go away than further facilitate their use, personally.

Me too. I would love it if dumb http push just went away. It's extremely
neglected, and has very few advantages over smart http (really, the only
advantage is that the server does not need to run git). However, we do
get bug reports on it occasionally, so I think people are still using
it.

So far our approach has mostly been to prevent any serious regressions,
and otherwise not worry too much about dragging it along with new
features.

> I made the change where I did because I wasn't sure if the push code was
> avoiding using http_request intentionally, and wasn't sure whether new code
> would be written that avoid it as well.
> 
> If that's not the case, then I gather http-push would be better rewritten to
> just use http_request, if anything.

Yes, I think so. It's purely historical and accidental that the
http-push code does not use it (and that the 401-handling happened to be
put at that layer).  The push and fetch sides grew up independently and
organically; I think if somebody were writing it now, they would
organize http.c quite differently.

> If I decide to continue working on this, I will keep these in mind.  I'm
> pretty sure that if I can get smart HTTP working, there's no reason to even
> bother with this from my perspective, unless you think there's substantial
> value in it.

No, I don't think there's substantial value. If you can move to smart
http, you are much better off.

-Peff
