From: Jeff King <peff@peff.net>
Subject: Re: Suggestion on hashing
Date: Sat, 3 Dec 2011 10:08:42 -0500
Message-ID: <20111203150842.GA4442@sigill.intra.peff.net>
References: <1322813319.4340.109.camel@yos>
 <20111202175444.GB24093@sigill.intra.peff.net>
 <1322877021.1729.118.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Bill Zaumen <bill.zaumen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 16:08:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWrCs-0000Tw-AZ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 16:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab1LCPIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 10:08:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39294
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab1LCPIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 10:08:44 -0500
Received: (qmail 14118 invoked by uid 107); 3 Dec 2011 15:15:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 03 Dec 2011 10:15:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2011 10:08:42 -0500
Content-Disposition: inline
In-Reply-To: <1322877021.1729.118.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186253>

On Fri, Dec 02, 2011 at 05:50:21PM -0800, Bill Zaumen wrote:

> On Fri, 2011-12-02 at 12:54 -0500, Jeff King wrote:
> > On Fri, Dec 02, 2011 at 12:08:39AM -0800, Bill Zaumen wrote:
> 
> > I think your code is solving the wrong problem (or solving the right
> > problem in a half-way manner). The only things that make sense to me
> > are:
> > 
> >   1. Do nothing. SHA-1 is probably not broken yet, even by the NSA, and
> >      even if it is, an attack is extremely expensive to mount. This may
> >      change in the future, of course, but it will probably stay
> >      expensive for a while.
> > 
> >   2. Decouple the object identifier and digest roles, but insert the
> >      digest into newly created objects, so it can be part of the
> >      signature chain. I described such a scheme in one of my replies to
> >      you. It has some complexities, but has the bonus that we can build
> >      directly on older history, preserving its sha1s.
> > 
> >   3. Replace SHA-1 with a more secure algorithm.
> 
> Suppose I make the digest pluggable, something I intended to do
> eventually anyway?  Then you just use the existing SHA-1 as an
> object identifier and the new digest in a signature chain?  What I
> did was essentially to compute the new digest (using a CRC as the
> trivial case) whenever an object's SHA-1 hash is computed, plus
> using the new digest for low-cost collision checks.

If you make the digest stronger (or pluggable) and include it in the
actual objects themselves, then you have a start on (2).

I'd drop all of the digest-exchange bits from the protocol, as the
actual signatures are the real, trustable verification. I don't think
you can drop the external storage of the digests, which is one of the
ugliest bits. You'll be asking for the digests all the time to create
new commit objects, so you need to have it at hand without rehashing.

And I wouldn't get my hopes up that this will go into git any time soon.
At this point, we're really guessing about how broken SHA-1 will be in
the future, and how much we are going to want to care.

Just my two cents.

-Peff
