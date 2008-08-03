From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Sun, 3 Aug 2008 15:48:52 -0700
Message-ID: <20080803224852.GC3006@untitled>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 00:50:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmOl-0006yj-Nz
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 00:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbYHCWs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757662AbYHCWs4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 18:48:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50021 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128AbYHCWsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 18:48:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7ABAD2DC01B;
	Sun,  3 Aug 2008 15:48:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91283>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 29 Jul 2008, Jakub Narebski wrote:
> 
> >  * handling of svn:externals using submodules
> 
> I doubt that this is easy.  Otherwise, Eric would have done it a long time 
> ago.

I started working on externals support a long time ago, but got hung up
on corner-cases (with .gitmodules and .gitignore being in the tree) and
backward-compatibility issues with commiting back to SVN.

The more I think about it, the more I think the worse-is-better approach
I used for "git svn show-ignore" is the way to go (using the unversioned
.git/info/exclude).  That would mean ignoring submodules as implemented
by git and just shotgunning another git-svn-created subdirectory into
where the external would've been...

> The main concern I have is to get the semantics right: AFAICT 
> svn:externals has _no notion_ of "what is current".  It just _always_ 
> fetches the HEAD.  Even if you check out an ancient revision in the 
> "superproject".

Based on my limited understanding, peg revisions are only needed in SVN
because of the cost of traversing history to DTRT.  git-svn should be
able to just use the -r<rev> syntax that has always been supported
without needing peg revisions.  On the other hand, implicit rename/copy
detection in git may not pick up drastic changes...

-- 
Eric Wong
