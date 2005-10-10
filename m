From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Seeing various mode changes on cygwin
Date: Mon, 10 Oct 2005 02:48:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 08:45:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOrNy-00068r-6B
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 08:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVJJGn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 02:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVJJGn2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 02:43:28 -0400
Received: from iabervon.org ([66.92.72.58]:20242 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932318AbVJJGn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 02:43:27 -0400
Received: (qmail 28350 invoked by uid 1000); 10 Oct 2005 02:48:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2005 02:48:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9875>

On Sat, 8 Oct 2005, Linus Torvalds wrote:

> I think we might want to have a flag that says "don't care about 
> filesystem modes". That should be pretty easy, I think we'd get most of 
> them by just adding some logic to "ce_match_stat()".
> 
> Then add a "git chmod" to set the mode in the index (which should end up 
> being just a wrapper around the regular "git-update-index" using the 
> "--cacheinfo" flag, I think).
> 
> Those parts should be trivial.
> 
> The more interesting issue is how to set the _flag_ that we should do 
> this. We may have to add a config file, and it should be per-repository 
> (ie something like ".git/config" or ".git/info/config"). Or do we just do 
> yet another environment variable?

Perhaps have a bit in the index mode for the file to say that the mode in 
the filesystem is unreliable, which gets set if a stat of the 
newly-written file doesn't match the mode it was supposed to have, or if 
git chmod is used to change it; then, if the bit is set, ignore the mode 
in the filesystem and just use the mode in the index.

This should prevent modes from magically changing, even if the user 
doesn't do anything special.

	-Daniel
*This .sig left intentionally blank*
