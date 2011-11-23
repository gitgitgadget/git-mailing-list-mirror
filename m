From: Jeff King <peff@peff.net>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 16:45:17 -0500
Message-ID: <20111123214517.GC21835@sigill.intra.peff.net>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
 <20111123192329.GA21630@sigill.intra.peff.net>
 <20111123200920.GA21004@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
X-From: git-owner@vger.kernel.org Wed Nov 23 22:45:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKdB-0006jg-TI
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab1KWVpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:45:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49457
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab1KWVpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 16:45:20 -0500
Received: (qmail 6719 invoked by uid 107); 23 Nov 2011 21:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 16:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 16:45:17 -0500
Content-Disposition: inline
In-Reply-To: <20111123200920.GA21004@angband.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185879>

On Wed, Nov 23, 2011 at 09:09:20PM +0100, Adam Borowski wrote:

> > But from what directory would you expect:
> > 
> >   git bisect run make
> > 
> > to run from? If you use a GNU-ish layout with all of your code in
> > "src/",
> 
> In a vast majority of cases the layout remains constant during the whole
> bisection.

Agreed. But you need to think about what happens when it does not. I
think marking the commit as untestable is probably best, with bisect
barfing a reasonable second. Accidentally marking the commit as "bad" is
probably the worst thing we could do. That would produce a subtly wrong
bisection result.

> > Maybe that commit should be considered indeterminate then?
> 
> Why?  If you're running an automated command, then it will probably fail,
> yeah.  I guess most people bisect manually though, so even in repositories
> that do have this problem, there's someone who can test the given commit
> anyway.

If you're not doing "bisect run", then it is a non-issue, no?  If you
are bisecting by hand, then "git bisect good|bad" will delete your
working directory, and probably your shell will start complaining, and
an intelligent tester will see what happened. This is only a problem for
automated bisection, which does not have such a tester.

> > I dunno. I haven't thought that hard about it. But I don't think it's
> > quite as simple as just telling bisect it's OK to run from a subdir.
> 
> At the very least, generally working with a caveat in corner cases seems to
> be better than outright failing.

To be clear: I think this is a good feature that will help a lot of
people, and I don't think an uncommon corner case should prevent it from
going into git.  But I _do_ think we should consider what happens in the
corner cases and at least fail gracefully, rather than produce subtly
wrong results.

-Peff
