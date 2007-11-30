From: Nicolas Pitre <nico@cam.org>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 21:40:13 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
 <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
 <finmvm$da8$1@ger.gmane.org>
 <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixvo4-0007dk-V3
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbXK3CkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759485AbXK3CkZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:40:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114AbXK3CkY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:40:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSA00L8SSR11ID0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Nov 2007 21:40:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66609>

On Thu, 29 Nov 2007, Linus Torvalds wrote:

> On Fri, 30 Nov 2007, Jakub Narebski wrote:
> > 
> > Isn't there a better way to do this sorting? What is needed here is
> > (stable) _bucket_ sort / _pigeonhole_ sort (or counting sort), which
> > is O(n); quicksort is perhaps simpler to use, but I'm not sure if
> > faster in this situation.

That particular sort takes under a second here with the Linux repo.
Pretty insignificant compared to the time required to repack.

> Actually, I doubt you need to do any sorting at all: what would be easiest 
> would be to simply change "traverse_commit_list()" to use different lists 
> for different object types, and just output them in type order (semi-sane 
> order choice: commits first, then tags, then trees, and finally blobs).

Yes!  That's what I thought initially, but since list-objects.c is 
completely unknown territory to me, I sorted them in pack-object.c 
instead, out of pure laziness.


Nicolas
