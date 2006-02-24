From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 10:37:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241029360.23719@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 16:38:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCf0y-0003Rh-9b
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 16:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWBXPhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 10:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBXPhu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 10:37:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62786 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932274AbWBXPht
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 10:37:49 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV7003XC7EYK2I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 10:37:46 -0500 (EST)
In-reply-to: <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16709>

On Fri, 24 Feb 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Indexing based on adler32 has a match precision based on the block size 
> > (currently 16).  Lowering the block size would produce smaller deltas 
> > but the indexing memory and computing cost increases significantly.
> 
> Indeed.
> 
> I had this patch in my personal tree for a while.  I was
> wondring why sometimes progress indication during "Deltifying"
> stage stops for literally several seconds, or more.

Note that above I'm saying that _keeping_ adler32 for small blocks is 
even longer.  In other words, for small blocks, the version not using 
adler32 is about 3 times faster.  

I also noticed the significant slowdown after I made the 
improved progress patch. The idea now has to do with detecting 
patological cases and breaking out of them early.

> In Linux 2.6 repository, these object pairs take forever to
> delta.
> 
>         blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f -> 
>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>         size (491102 -> 496045)
>         58 seconds
> 
>         blob 4917ec509720a42846d513addc11cbd25e0e3c4f -> 
>         blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>         size (495831 -> 496045)
>         64 seconds

Thanks for this.  I'll see what I can do to tweak the code to better 
cope with those.  Just keep my fourth delta patch in the pu branch for 
now.


Nicolas
