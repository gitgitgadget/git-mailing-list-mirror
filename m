From: Jeff King <peff@peff.net>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 10:21:30 -0500
Message-ID: <20070216152130.GA7086@coredump.intra.peff.net>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com> <er333i$787$1@sea.gmane.org> <17877.51730.418633.750922@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 16:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI4u0-0006IL-Va
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbXBPPVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbXBPPVd
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:21:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4107 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945898AbXBPPVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:21:33 -0500
Received: (qmail 31065 invoked from network); 16 Feb 2007 10:21:39 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 16 Feb 2007 10:21:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2007 10:21:30 -0500
Content-Disposition: inline
In-Reply-To: <17877.51730.418633.750922@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39920>

On Fri, Feb 16, 2007 at 09:13:22AM -0600, Bill Lear wrote:

> % git pull ../peer_repo topic:topic
> [...]
> * refs/heads/topic: not updating to non-fast forward branch 'topic' of ../peer_repo
> [...]
> So, why does it say "not updating to non-fast forward branch", yet
> it does the merge and gets the changes anyway?

Because your pull command really means "merge in the topic branch from
peer_repo, and while you're at it, store it in my local tracking branch
topic". Remember that pull is really a fetch+merge. But the fetch is
actually doing _two_ things: putting the fetched branch into FETCH_HEAD,
and putting it in into refs/heads/topic. The latter fails (because of a
non-fastforward), but pull actually uses the FETCH_HEAD results to
do the merge.

Yes, this seems overly complex for what you're doing, but the reason for
FETCH_HEAD is to support pulls when you _don't_ have a tracking branch
at all (i.e., 'git pull ../peer_repo topic').

-Peff
