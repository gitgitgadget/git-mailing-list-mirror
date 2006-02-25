From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Sat, 25 Feb 2006 00:35:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 06:35:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCs5l-00074J-7r
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 06:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWBYFf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 00:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWBYFf2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 00:35:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18113 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964849AbWBYFf1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 00:35:27 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV8008FEA72SQD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 25 Feb 2006 00:35:27 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16755>


OOps.... Forgot to complete one paragraph.

On Sat, 25 Feb 2006, Nicolas Pitre wrote:

> I of course looked at the time to pack vs the size reduction in my 
> tests.  And really like I said above the cost is well balanced.  The 
> only issue is that smaller blocks are more likely to trap into 
> patological data sets.  But that problem does exist with larger blocks 
> too, to a lesser degree of course but still.  For example, using a 16 
> block size with adler32, computing a delta between two files 

... as provided by Carl takes up to _nine_ minutes for a _single_ delta !

So regardless of the block size used, the issue right now has more to do 
with that combinatorial explosion than the actual block size.  And 
preventing that patological case from expending out of bounds is pretty 
easy to do.

OK I just tested a tentative patch to trap that case and the time to 
delta those two 20MB files passed from over 9 minutes to only 36 seconds 
here, with less than 10% in delta size difference.  So I think I might 
be on the right track.  Further tuning might help even further.


Nicolas
