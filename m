From: Jeff King <peff@peff.net>
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 14:22:05 -0400
Message-ID: <20080601182205.GA742@sigill.intra.peff.net>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jun 01 20:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sCt-0003W3-J5
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbYFASWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYFASWJ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:22:09 -0400
Received: from peff.net ([208.65.91.99]:1787 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbYFASWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:22:08 -0400
Received: (qmail 32460 invoked by uid 111); 1 Jun 2008 18:22:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 01 Jun 2008 14:22:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jun 2008 14:22:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83456>

On Sat, May 31, 2008 at 09:10:26AM -0700, david@lang.hm wrote:

> I created localmaster in an attempt to get things working again. I'll try  
> creating a new master branch... that does make it work again, thanks.
>
> what I'm not understanding completely is how I broke things in the first  
> place.

I'm not understanding that, either. You not only created localmaster,
but you deleted master. Did you maybe do a "git branch -m"?

> going back through .git/logs/HEAD it looks like I did a checkout HEAD^^^  
> and never properly recovered. should I have done a checkout master to get  
> things back on track? I had thought that I could do a checkout of an old  
> version, modify it, do a commit, and the commit would go on top of the old 
> HEAD and I could just keep going (the reason for doing this instead of a  
> reset is that I had already published the intermediate commits to the  
> public repo, so I didn't want to roll back the history, just get the old  
> version of one of the files)

I think you did eventually "recover" which is to say you ended up on the
localmaster branch. When you did a checkout of HEAD^^^, your HEAD became
"detached", meaning that you were no longer on any branch, but at a
specific commit (and there should have been a warning message mentioning
that).

When you make commits on a detached HEAD, your HEAD remains detached,
meaning that those commits are not on any branch. So when you did a
checkout back to some actual branch, those commits were "lost" (meaning
that no branch contains them, but they are still available by peeking
through the reflog).

But that shouldn't have had anything to do with the state of the master
branch; once you detached, you were purely operating on the detached
HEAD.

-Peff
