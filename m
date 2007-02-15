From: Jeff King <peff@peff.net>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 16:43:52 -0500
Message-ID: <20070215214352.GA2980@coredump.intra.peff.net>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com> <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 22:44:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHoOb-0001AY-K3
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 22:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbXBOVn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 16:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbXBOVn5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 16:43:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4382 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161440AbXBOVnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 16:43:55 -0500
Received: (qmail 3962 invoked from network); 15 Feb 2007 16:44:01 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 15 Feb 2007 16:44:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2007 16:43:52 -0500
Content-Disposition: inline
In-Reply-To: <17876.53654.426022.454712@lisa.zopyra.com> <17876.52962.662946.582507@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39852>

On Thu, Feb 15, 2007 at 03:21:38PM -0600, Bill Lear wrote:

> Ok, so I break the model, what is the harm in that?  Can I no longer
> pull from or push to the remote branch?  Do I corrupt something
> locally?  Does something else break?  I'm trying to formulate an
> explanation to our users why the 1.5 way is superior and I can't just
> say "if you do that you break the model".

The commits you make will not actually go onto that tracking branch;
they will be part of a "detached HEAD" (that is, your HEAD doesn't point
to _any_ branch). Once you check out a different branch, you will
potentially lose those commits (actually, they will still be available
through your reflog, but you will have to know to look for them there).

> BTW, my ignorant assumption is that for merging to take place, git
> requires two branches, so 'git pull' will fetch into the tracking
> branch and then merge onto your ... uh ... whatever the name of the
> working version of your tracking branch is.

That's more or less correct. You don't really have to have two branches;
doing a 'git pull /path/to/repo branch' will fetch the branch into the
temporary FETCH_HEAD name, and merge from that. But yes, the way a raw
'git pull' will work is to first fetch all tracking branches into
refs/remotes/origin/*, and then merge from whichever is defined by your
config.

And they're usually called "local branches" if you differentiating them
from remote tracking branches, or just "branches" otherwise.

> BTW, again, why does git clone not have an option to just create all
> of the "working versions" (better name needed) of tracking branches?

I don't recall anybody asking for it, yet. I think the idea is that
those branches would just be clutter. If you want to work on something,
it's easy enough to just start a local version of the branch:

  git checkout -b topic origin/topic

-Peff
