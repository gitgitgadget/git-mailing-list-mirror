From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 15:19:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241509050.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 21:19:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCjPr-0005Ar-46
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWBXUTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBXUTl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:19:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15861 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932462AbWBXUTk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 15:19:40 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV7002L4KGRSM10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 15:19:39 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16735>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

> The other thing to look at is "max_size": right now it initializes that to 
> "size / 2 - 20", which just says that we don't ever want a delta that is 
> larger than about half the result (plus the 20 byte overhead for pointing 
> to the thing we delta against). Again, if you feel that normal compression 
> compresses better than half, you could try changing that to
> 
> 	..
> 	max_size = size / 4 - 20;
> 	..

Like I mentioned, max_size should also be caped with the deflated 
undeltified object 
size.  This value is easy to get since plain objects are already 
deflated.

> NOTE! Every SINGLE one of those heuristics are just totally made up by 
> yours truly, and have no testing behind them. They're more of the type 
> "that sounds about right" than "this is how it must be". As mentioned, 
> Nico has already been playing with the heuristics - but he wanted better 
> packs, not better CPU usage, so he went the other way from what you would 
> want to try..

Actually it's a good balance I'm after.

Using 30% more CPU for 10% smaller packs is OK I'd say.

Using 100 times the CPU for 50% saving on only one particular delta is 
not acceptable.

And using more than one hour for 200MB of data with the current window 
default is not acceptable either.


Nicolas
