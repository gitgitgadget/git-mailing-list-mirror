From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/9] Discard "deleted" cache entries after using them to
 update the working tree
Date: Tue, 5 Feb 2008 15:38:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802042122400.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041335470.13593@iabervon.org> <alpine.LSU.1.00.0802050123330.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUa0-00046i-Tr
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbYBEUip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbYBEUip
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:38:45 -0500
Received: from iabervon.org ([66.92.72.58]:48619 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757756AbYBEUio (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:38:44 -0500
Received: (qmail 9448 invoked by uid 1000); 5 Feb 2008 20:38:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:38:40 -0000
In-Reply-To: <alpine.LSU.1.00.0802050123330.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72696>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> > Way back in read-tree.c, we used a mode 0 cache entry to indicate that 
> > an entry had been deleted, so that the update code would remove the 
> > working tree file, and we would just skip it when writing out the index 
> > file afterward.
> > 
> > These days, unpack_trees is a library function, and it is still leaving 
> > these entries in the active cache. Furthermore, unpack_trees doesn't 
> > correctly ignore those entries, and who knows what other code wouldn't 
> > expect them to be there, but just isn't yet called after a call to 
> > unpack_trees. To avoid having other code trip over these entries, have 
> > check_updates() remove them after it removes the working tree files.
> > 
> > While we're at it, make the loop more obvious and skip passing in 
> > globals to a static function with only one caller.
> 
> After reading the code I understand what you mean.  How about
> 
> 	While at it, make the loop removing those entries more obvious, 
> 	and avoid passing global variables as parameters to 
> 	check_updates(): there is only one call site anyway.

It's the loop's flow control that I'm making more obvious (using a normal 
for loop instead of a while loop that counts down the number of entries 
while counting up the pointer to the entry under consideration). I'll 
clarify the message for the next version.

	-Daniel
*This .sig left intentionally blank*
