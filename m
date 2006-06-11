From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Sun, 11 Jun 2006 18:00:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 00:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpXym-0004M8-EW
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWFKWAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWFKWAP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 18:00:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2291 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750748AbWFKWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 18:00:14 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0P00EQHUGDF9C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 11 Jun 2006 18:00:13 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21670>

On Fri, 9 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Sat, 10 Jun 2006, Martin Langhoff wrote:
> > 
> > Now I don't know how much memory or time this took, but it clearly
> > completed ok. And, it's now a single pack, weighting a grand total of
> > 617MB
> 
> Ok, that's more than reasonable. That should be fairly easily mapped on a 
> 32-bit architecture without any huge problems, even with some VM 
> fragmentation going on. It might be borderline (and you definitely want a 
> 3:1 VM user:kernel split), but considering that the original CVS archive 
> was apparently 3GB, having a single 617M pack-file is still pretty damn 
> good.  That's like 20% of the original, with all the obvious distribution 
> advantages.

I played a bit with git-repack on that repo.  the git-pack-objects 
memory usage grew to around 760MB (git-rev-list was less than that).  So 
LRU of partial pack mappings might bring that down significantly.

Then I used git-repack -a -f --window=20 --depth=20 which produced a 
nice 468MB pack file along with the invariant 45MB index file for a 
grand total of 535MB for the whole repo (the .git/refs/ directory alone 
still occupies 17MB on disk).

So it is probably worth having deeper delta chains for large historic 
repositories as the deep revisions are unlikely to be referenced that 
often while the saving is quite significant.


Nicolas
