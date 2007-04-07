From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Sat, 7 Apr 2007 12:16:08 -0400
Message-ID: <20070407161607.GB18972@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com> <20070405134954.GA18402@coredump.intra.peff.net> <17941.655.192938.792088@lisa.zopyra.com> <20070405204604.GA24779@coredump.intra.peff.net> <17941.25142.88657.766384@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 18:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaDaJ-0002Wa-CP
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966070AbXDGQQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966071AbXDGQQM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 12:16:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4248 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966070AbXDGQQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 12:16:11 -0400
Received: (qmail 10427 invoked from network); 7 Apr 2007 16:16:46 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Apr 2007 16:16:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2007 12:16:08 -0400
Content-Disposition: inline
In-Reply-To: <17941.25142.88657.766384@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43976>

On Thu, Apr 05, 2007 at 03:55:18PM -0500, Bill Lear wrote:

> No, just plain ol' git push.  One possibility is that in mediating
> between him and the list, there has been a loss of information.
> Perhaps he omitted details in his account of how things progressed ---
> who knows, perhaps he was on the wrong branch (though I doubt this, he
> only works on the master branch, and the other branch in question was
> someone else's entirely).

No, I think you gave the correct information. See the other part of the
thread between me and Junio. What's happening is that 'git-push' tries
to push every ref that both you and the remote have. Because he's
pushing into a non-bare repository, both sides have
refs/remotes/origin/flexify. But they're not necessarily at the same
point, since they're both fetched from whatever your origin is, thus the
problem. In this case, his flexify tracking branch for origin is
_behind_ the remote's, so the push doesn's work.

> Regardless, does my assumption --- a 'git pull' should rectify
> the 'you are not up to date' problem --- hold in general?

Generally, yes. But the remotes/ hierarchy is not something you pull
into. So in this case, it won't help. The real solution is that git-push
should not be pushing remotes/ at all: it should be purely a local
thing (the patch I posted elsewhere in the thread fixes this, but will
not be the final behavior -- however, it's enough to fix this problem).

As a temporary solution, fetching from origin should put him at the same
place (or ahead of) the remote, which should allow the push to go
through.

-Peff
