From: Nicolas Pitre <nico@cam.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 13:52:55 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711291333460.9605@xanadu.home>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
 <alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxoVk-0005PE-GE
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 19:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759161AbXK2Sw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 13:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761305AbXK2Sw6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 13:52:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26534 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759084AbXK2Sw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 13:52:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00CGB74893D0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 13:52:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66552>

On Thu, 29 Nov 2007, Linus Torvalds wrote:

> 
> 
> On Thu, 29 Nov 2007, Nicolas Pitre wrote:
> > 
> > Well, see below for the patch that actually split the pack data into 
> > objects of the same type.  Doing that "git checkout" on the kernel tree 
> > did improve things for me although not spectacularly.
> 
> Umm. See my earlier numbers. For "git checkout" with cold cache, the 
> *bulk* of the time is actually the ".gitignore" file lookups, so if you 
> see a three-second improvement out of 17s, it may not look spectacular, 
> but considering that probably 10s of those 17s were something *else* going 
> on, I suspect that if you really did just a plain "git checkout", you 
> actually *do* have a spectacular improvement of roughly 7s -> 4s!
> 
> Try with
> 
> 	time git read-tree -m -u HEAD HEAD > /dev/null
> 
> instead.

Oh!  OK then.

Current, cold cache:		5.248s
Current, warm cache:		0.185s

Patched, cold cache:		3.337s
Patched, warm cache:		0.183s

So yes, the improvement is more significant then, although the cold 
cache timings vary quite a lot between successive tries.


Nicolas
