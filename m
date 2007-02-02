From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 10:13:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702020955540.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
 <200702021302.10567.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 16:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD06k-0003rE-4M
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 16:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbXBBPNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 10:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945929AbXBBPNN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 10:13:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56698 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945915AbXBBPNM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 10:13:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCU0080GCXZXL00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 10:13:12 -0500 (EST)
In-reply-to: <200702021302.10567.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38504>

On Fri, 2 Feb 2007, Andy Parkins wrote:

> Forgetting about detached heads for the moment,

That is not the way to go about it.  You cannot start forgetting about 
detached heads and come back to it afterwards like an afterthought.

> imagine that yesterday I did 
> lots of bouncing around on branches, around 1300 (although I wouldn't 
> remember the exact time).  Oh look, it's about 1300 now.  What then is
> HEAD@{yesterday} going to tell me?  What will it tell me one minute from now?  
> It would be the most confusing operation in the world; I'd have to remember 
> which branch I had checked out and what time I checked it out.

The exact same argument could be said if you did 1300 operations on a 
single branch, say master.  What would master@{yesterday} tell you?  
What will it tell you one minute from now?  Now suppose that you have 
only one branch and therefore HEAD reflog would be a duplicate of master 
reflog.

Answer: it would carry the same kind of confusion as your example above.

> I really don't want to be able to answer the question what branch did I have 
> checked out 15 minutes ago.  I do want to ask where was my current branch 15 
> minutes ago.

Then simply use @{15 minutes ago}.  You'll even save yourself some 
typing!  It is not like if you have to type HEAD for most operations 
anyway since HEAD is the likely default in most cases.  So you may even 
forget that the HEAD entity exists and be just fine.

But HEAD is still a moving pointer and we might want to know that it 
switched from one branch to another at some point.  And the only way for 
that to be sensible is by having a separate reflog for HEAD that is the 
exact log of every operations you perform regardless of the actual 
branch you might be on.

> Then of course, it's perfectly reasonable to treat the detached HEAD as 
> meaning that the symref HEAD was pointing at a kind of virtual branch - this 
> is a branch that isn't in the refs directory but is reflogged.  Other than 
> that it's no different from any other branch.
> 
> Any notation would do I think, @{} is as good as any other.  In fact, if we 
> used the name "unnamed branch" instead of "detached head", the notation @{} 
> is perfect.  (Actually I think unnamed branch is a much better term than 
> detached HEAD, because HEAD is never detached - it must point at something)

HEAD _does_ get detached.  It becomes loose in the air.  It doesn't drag 
any 
branch 
pointer with it.  And everything you do on top of a detached HEAD will 
be forgotten as soon as you leave it (and the eventual reflog for HEAD 
expires) if you don't attach it somehow with a tag or a new branch.  
There is no notion of a virtual branch at all, not technically, not 
conceptually either.


Nicolas
