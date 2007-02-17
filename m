From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] name-rev: introduce the --ref-filter=<regex> option
Date: Sat, 17 Feb 2007 09:59:21 -0500
Message-ID: <20070217145921.GA16747@coredump.intra.peff.net>
References: <20070127040618.GA14205@fieldses.org> <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org> <20070127044246.GC14205@fieldses.org> <20070127045552.GB9966@spearce.org> <7vhcudoxfj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701271334410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 17 15:59:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIR27-00019g-9o
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 15:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbXBQO7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 09:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbXBQO7Y
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 09:59:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2892 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965283AbXBQO7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 09:59:24 -0500
Received: (qmail 30661 invoked from network); 17 Feb 2007 09:59:31 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 17 Feb 2007 09:59:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Feb 2007 09:59:21 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702171502040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39992>

On Sat, Feb 17, 2007 at 03:02:36PM +0100, Johannes Schindelin wrote:

> > Instead of (or, in addition to) --tags, to use only tags for naming,
> > you can now use --ref-filter=<regex> to specify which refs are
> > used for naming.
> > 
> > Example:
> > 
> > 	$ git name-rev --ref-filter='/v1' 33db5f4d
> > 	33db5f4d tags/v1.0rc1^0~1593
> 
> Likes, dislikes?

It's a neat idea, but I wonder if you could make it even more flexible
by simply accepting a list of possible refs, and then you could filter
using grep, or your own more complex selection algorithm.
Unfortunately, --stdin is already taken, but something like:

git show-ref | grep tags/v1.4 | git name-rev --stdin-refs 33db5f4d

If the stdin ref format includes both the refname and the hash, you
could even find 'fake' refs that don't exist in git (e.g., that you get
from a foreign SCM; though why you wouldn't just make git tags for them,
I don't know).

Or maybe this is just making the problem too complex, and nobody really
wants to do it. I certainly don't have a use at this point, but if
you're going to do ref filtering, it seems like making it as general as
(painlessly) possible is useful.

-Peff
