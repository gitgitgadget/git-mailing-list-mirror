From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Memory overrun in http-push.c
Date: Sun, 4 Mar 2007 04:18:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0703040335110.6485@iabervon.org>
References: <20070228151516.GC57456@codelabs.ru> <200703011931.32170.andyparkins@gmail.com>
 <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703021005.13620.andyparkins@gmail.com> <Pine.LNX.4.64.0703040234510.6485@iabervon.org>
 <7virdh76kh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 10:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNms3-0002EO-7K
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 10:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbXCDJS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 04:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbXCDJS4
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 04:18:56 -0500
Received: from iabervon.org ([66.92.72.58]:3279 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXCDJSy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 04:18:54 -0500
Received: (qmail 31445 invoked by uid 1000); 4 Mar 2007 04:18:52 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Mar 2007 04:18:52 -0500
In-Reply-To: <7virdh76kh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41351>

On Sun, 4 Mar 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Actually, how about doing keyword expansion just like the new CRLF
> > handling?
> 
> That part is true, but practically speaking the only thing you
> can honestly replace is $Id$ with blob object name, and nothing
> else.  Trying to put anything that is available via commit would
> at best telling a lie and at worst ending up denying the index
> (and denying the index is denying git as somebody said).  You
> could fake the values for $Author$ and $Date$ from HEAD commit,
> but your index may or may not match HEAD commit when you check
> out path from it.

I was somehow expecting the index to be on the "working directory" side of 
conversions, but that obviously doesn't work very well (since you'd get a 
ton of unreachable blobs all the time that way). Even so, I think the 
useful thing would the the "git-describe" for HEAD, if the index entry is 
actually from HEAD (otherwise, it's a state that nobody else has seen, 
right? No point in trying to specify further...). I don't think Author and 
Date from a commit really works, because they wouldn't actually reflect 
the last change to anything near the tag, necessarily. The commit hash, on 
the other hand, tends you what to run blame on.

But, in any case, $Id <blob hash>$ would put into the working directory 
file (and suitable installed derivates thereof) something that would lead 
people with the repository to the actual blob, with at least a possible 
context. $Id <commit hash>:<path>$, for <commit hash>=HEAD, if HEAD:<path> 
is <blob hash>, should be just right.

Is it common to check out files from the index which don't match HEAD? The 
only case I can think of is resetting to a state stored in the index with 
update-index. I think my personal workflow is always HEAD->index->working 
directory->index->new HEAD.

	-Daniel
*This .sig left intentionally blank*
