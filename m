From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Sun, 20 May 2007 22:54:44 +0200
Message-ID: <20070520205444.GC25462@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun May 20 22:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsQX-0000ec-Rv
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbXETUyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756279AbXETUyr
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:54:47 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:17170 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbXETUyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:54:46 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (klopstock mo43) (RZmta 6.5)
	with ESMTP id D04749j4KIa3Vn ; Sun, 20 May 2007 22:54:44 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C4CC3277BD;
	Sun, 20 May 2007 22:54:44 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A59A0D195; Sun, 20 May 2007 22:54:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520195930.GX942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47914>

Sven Verdoolaege, Sun, May 20, 2007 21:59:30 +0200:
> > I am very worried about this big red switch that says "all
> > subprojects to be cloned and checked out, or nothing".  I think
> > this would not work well with projects that truly need
> > superproject support (i.e. very large ones, where most people
> > would not want to clone and check out every single subproject).
> 
> It's pretty easy to add a "submodule.*.skip" or "submodule.*.ignore".
> Since the subcloning only happens at checkout, you could set these
> before doing a checkout.

And set them back after doing the checkout? And so for each and every
checkout operation? I suggest you try checkout something like KDE a
few times (well, assuming KDE is split in submodules. It isn't yet).
The point is - it is annoying. And if it is annoying, it wont be used
(as branches in CVS and merging in SVN).

> > The more important issue I think is at what point in the
> > superproject operation does a recursive checkout in a subproject
> > should happen, and how we should do the checkout.  Issues I can
> > think of offhand are (no way exhaustive):
> > 
> >  - Do we checkout a branch? if so which one?
> > 
> >  - Do we detach HEAD if the commit named by the superproject
> >    tree is not at the tip of the current branch of subproject?
> >    do we detach always even if the commit is at the tip?
> 
> I thought there was a consensus to detach the HEAD.
> I don't have a strong opinion on this issue, but a detached
> HEAD seems the most appropriate to me.

Me too. I actually believe it is the only way to do it. How can you
checkout a subproject to something else (to what a branch may point)
and to what the tree of superproject has? On the other side (in
subproject) - why are you, the superproject, allowed to screw the
references of the subproject?! It is independent, isn't it?!

> >  - What would we do when the subproject working tree is not
> >    clean?
> 
> I was planning on adding a --dry-run to git-checkout.
> The superproject would run this in each subproject before
> doing the actual checkout of the superproject.

Why not do exactly what we do now? Pass "-m" down to it, if it was
given to the top-level git-checkout.
