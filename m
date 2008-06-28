From: Jeff King <peff@peff.net>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 04:53:59 -0400
Message-ID: <20080628085359.GA29619@sigill.intra.peff.net>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <7vprq2rbfz.fsf@gitster.siamese.dyndns.org> <20080628050317.GE9451@sigill.intra.peff.net> <9af502e50806280003p59d00444hd1914a28a3a71d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 10:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCWD0-0006m6-QP
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 10:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbYF1IyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 04:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbYF1IyF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 04:54:05 -0400
Received: from peff.net ([208.65.91.99]:1873 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbYF1IyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 04:54:03 -0400
Received: (qmail 9364 invoked by uid 111); 28 Jun 2008 08:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 04:54:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 04:53:59 -0400
Content-Disposition: inline
In-Reply-To: <9af502e50806280003p59d00444hd1914a28a3a71d7e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86709>

On Sat, Jun 28, 2008 at 12:03:54AM -0700, Robert Anderson wrote:

> > Here's a somewhat hackish implementation of "git stash -i" that just relies
> > on "add -i":
> 
> Are all features for moving changes to stash bi-directional in your
> implementation?  Can we move a hunk out of stash, just as easily as we
> can move one in?  I think this is an essential property of a good
> implementation of this workflow.

No, they're not bi-directional. You get the full power of "add -i" when
moving things into the stash, but not out. It is the reverse of the
situation with the index; we have good tools for staging things, but not
for unstaging them.

But I agree that they _should_ be. Given the patch I posted already,
probably the simplest way to do both at once would be to give "add -i"
an "unstage" mode.

> It does seem to me at this point that extending stash functionality is
> a reasonable way to approach supporting this type of workflow.

Actually, I oversimplified a little bit in my "buckets" description.
Stash actually stashes two things: the current index and the current
worktree. So in that sense, it is not just another bucket as I
described. For the purposes of the workflow we're discussing, I think
that is how we want it to function. But the implementation will be a bit
trickier than it might otherwise be because of this. I just didn't want
to have to introduce another, slightly different type of stash.

-Peff
