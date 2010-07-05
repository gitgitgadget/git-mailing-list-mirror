From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Mon, 5 Jul 2010 10:10:12 -0400
Message-ID: <20100705141012.GA25518@thunk.org>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 16:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVmNN-0005SP-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 16:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981Ab0GEOKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 10:10:17 -0400
Received: from THUNK.ORG ([69.25.196.29]:56597 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755667Ab0GEOKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 10:10:16 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OVmNB-0003oD-SP; Mon, 05 Jul 2010 10:10:14 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OVmNA-0002fZ-Gd; Mon, 05 Jul 2010 10:10:12 -0400
Content-Disposition: inline
In-Reply-To: <20100705122723.GB21146@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150269>

On Mon, Jul 05, 2010 at 08:27:23AM -0400, Jeff King wrote:
> As you probably guessed from the specificity of the number, I wrote a
> short program to actually traverse and find the worst skew. It takes
> about 5 seconds to run (unsurprisingly, since it is doing the same full
> traversal that we end up doing in the above numbers). So we could
> "autoskew" by setting up the configuration on clone, and then
> periodically updating it as part of "git gc".
> 
> That is perhaps over-engineering (and would add a few seconds to a
> clone), but I like that it would Just Work without the user doing
> anything.

As time progresses, the clock skew breakage should be less likely to
be hit by a typical developer, right?  That is, unless you are
specifically referencing one of the commits which were skewed, two
years from now, the chances of someone (who isn't doing code
archeology) of getting hit by a problem should be small, right?  This
seems to be definitely the case with "git tag --contains"; would it be
true for git name-rev and the other places that depend on (roughly)
increasing commit times?

If so, I could imagine the automagic scheme choosing a default that
only finds the worst skew in the past N months.  This would speed up
things up for users who are using repositories that have skews in the
distant past, at the cost of introducing potentially confusuing edge
cases for people doing code archeology.

I'm not sure this is a good tradeoff, but given in practice how rarely
most developers go back in time more than say, 12-24 months, maybe
it's worth doing.  What do you think?

     	   	   				- Ted
