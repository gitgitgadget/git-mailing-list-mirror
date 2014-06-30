From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Mon, 30 Jun 2014 13:07:32 -0400
Message-ID: <20140630170732.GA16747@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625234000.GD23146@sigill.intra.peff.net>
 <CAPig+cSc=A=+PR7oF43yeLpcd4n=Bd1KU1AHPfMKXEu5wAF4Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 19:07:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1f3J-00060V-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 19:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbaF3RHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 13:07:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:53687 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753233AbaF3RHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 13:07:33 -0400
Received: (qmail 8329 invoked by uid 102); 30 Jun 2014 17:07:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 12:07:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 13:07:32 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSc=A=+PR7oF43yeLpcd4n=Bd1KU1AHPfMKXEu5wAF4Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252692>

On Sun, Jun 29, 2014 at 03:41:37AM -0400, Eric Sunshine wrote:

> > +static inline void bitset_set(unsigned char *bits, int n)
> > +{
> > +       bits[n / CHAR_BIT] |= 1 << (n % CHAR_BIT);
> > +}
> 
> Is it intentional or an oversight that there is no way to clear a bit
> in the set?

Intentional in the sense that I had no need for it in my series, and I
didn't think about it. I doubt many callers would want it, since commit
traversals tend to propagate bits through the graph, and then clean them
up all at once. And the right way to clean up slabbed data like this is
to just clear the slab.

Of course somebody may use the code for something besides commit
traversals. But I'd rather avoid adding dead code on the off chance that
somebody uses it later (and then gets to find out whether it even works
or not!).

-Peff
