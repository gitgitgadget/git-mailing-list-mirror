From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Embedded Linux development with GIT
Date: Thu, 5 Jul 2007 13:00:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051253130.9789@racer.site>
References: <a2e879e50707042250w22fe570cp4dda316e6b0f4cea@mail.gmail.com>
 <468C996B.7FEFEB29@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 14:00:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Q0o-0005yN-0w
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 14:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308AbXGEMAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755857AbXGEMAj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 08:00:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:40175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754788AbXGEMAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 08:00:39 -0400
Received: (qmail invoked by alias); 05 Jul 2007 12:00:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 05 Jul 2007 14:00:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+D7dJoSNyDlaLY1LNmEGdm7hafV9zv2kbNiYsHZE
	UMr72EFdX+HRvD
X-X-Sender: gene099@racer.site
In-Reply-To: <468C996B.7FEFEB29@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51671>

Hi,

On Thu, 5 Jul 2007, Johannes Sixt wrote:

> Sean Kelley wrote:
> > 
> > I have a situation where we have a local GIT repository that is based
> > on v2.6.17.  We initially added the source tarball to an empty
> > repository and then started applying changes to it.  Looking back,
> > that might not have been the best idea 400 commits later.
> 
> That is possible using a graft:
> 
>   $ echo "$x $(git rev-parse v2.6.17^0)" >> .git/info/grafts
> 
> where $x is the SHA1 of the first commit you made on top of the imported
> tarball.

Yes, this is also how I would do it.

> This way you have spliced your history with Linus's history. (This is a 
> strictly _local_ matter! Every clone of your history must repeat the 
> game!)

Now, here I disagree slightly.  If you merge just once, subsequent merges 
will be possible even without that graft.

So if you merge with some newer Linux version, all your cloners get the 
benefit.

> Now, Linus will not be able to pull from your faked history because he
> doesn't know about the graft.

Except if you merge with a more recent version of Linux.

However, I doubt that such a distant (in terms of time!) merge would 
appeal to Linus.  I guess you have to rebase on top of Linus' version 
_anyway_.

> In order to fix that, you can run git-filter-branch from current git's 
> master branch to rewrite your history:
> 
>   $ git filter-branch new-master v2.6.17..master
> 
> Read the man page of git-filter-branch, and understand the implications
> before you publish the result.

This is a way to fix your history, yes.  Note that filter-branch is not 
yet in an official release of Git, and so you either have to wait for 
1.5.3, or you get filter-branch from git.git's "next" branch (just picking 
this one script should work fine, if you have at least 1.5.1 installed).

Note that this rewrites the history, so all the disadvantages of 
rebasing with pulling apply here, too.

But as stated above, I think you have to rebase eventually anyway, if you 
go for inclusion in Linus' tree.  In that case, the filter-branch is 
unnecessary.

Ciao,
Dscho
