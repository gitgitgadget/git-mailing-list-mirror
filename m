From: Jeff King <peff@peff.net>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 05:07:44 -0500
Message-ID: <20090219100743.GA16119@coredump.intra.peff.net>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5qE-0000G7-A9
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZBSKHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZBSKHr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:07:47 -0500
Received: from peff.net ([208.65.91.99]:37256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZBSKHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:07:46 -0500
Received: (qmail 21457 invoked by uid 107); 19 Feb 2009 10:08:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 05:08:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 05:07:44 -0500
Content-Disposition: inline
In-Reply-To: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110661>

On Thu, Feb 19, 2009 at 09:21:49AM +0000, John Tapsell wrote:

>   I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
> doesn't matter if you go back 'too far' I just always use HEAD~10 even
> if it's just for the last or so commit.

Here are some reasons not to go back too far:

  1. The commits are displayed in order, so the ones that are
     interesting to the user are at the bottom. And HEAD~10 may display
     more than 10 commits in the face of non-linear history.

  2. rebase -i does not preserve merges by default. Which means that if
     HEAD~10 is not a linear history, then you are flattening the graph
     structure.

>   Would there be any objections to making  'git rebase -i' default to
> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
> helps a bit with making it easier to use.

If you wanted to do something like this, a much more sensible cutoff
would be the location of an upstream tracking branch (e.g., as defined
by branch.*.rebase). Then you are literally asking for commits which
have not been published in your upstream, which means it is OK to
rewrite history (assuming they were not published elsewhere).

-Peff
