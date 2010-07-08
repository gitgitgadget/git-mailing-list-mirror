From: Jeff King <peff@peff.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 07:31:51 -0400
Message-ID: <20100708113151.GB2294@sigill.intra.peff.net>
References: <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
 <20100707174546.GA4979@coredump.intra.peff.net>
 <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nick Edelen <sirnot@gmail.com>, Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 08 13:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWpKh-0001ki-PE
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0GHLbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:31:53 -0400
Received: from peff.net ([208.65.91.99]:34082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987Ab0GHLbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 07:31:53 -0400
Received: (qmail 2465 invoked by uid 107); 8 Jul 2010 11:32:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 08 Jul 2010 07:32:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jul 2010 07:31:51 -0400
Content-Disposition: inline
In-Reply-To: <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150563>

On Thu, Jul 08, 2010 at 06:29:04AM -0400, Theodore Tso wrote:

> On Jul 7, 2010, at 1:45 PM, Jeff King wrote:
> 
> >     And of course it's just complex, and I tend to shy away from
> >     complexity when I can. The question to me comes back to (1) above.
> >     Is massive clock skew a breakage that should produce a few
> >     incorrect results, or is it something we should always handle?
> 
> Going back to the question that kicked off this thread, I wonder if there
> is some way that cacheing could be used to speed up the all cases,
> or at lest the edge cases, without imposing as much latency as tracking
> the max skew?   i.e., some thing like gitk's gitk.cache file.  For bonus
> points, it could be a cache file that is used by both gitk and git tag
> --contains, git branch --contains, and git name-rev.
> 
> Does that sound like reasonable idea?

It sounds reasonable to me. It just needs somebody to design and
implement it. :)

I don't know anything about how gitk.cache works. Caching tag refs is
not that hard, because the refs tend not to change. Doing arbitrary "X
contains Y" caching is much harder, and I think you would have to build
it on Nick's rev-cache work. Maybe he (cc'd) has some ideas.

-Peff
