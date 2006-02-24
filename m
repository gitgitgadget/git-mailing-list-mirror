From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 15:02:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241438521.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 21:02:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCj8o-0001DE-5T
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 21:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBXUCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWBXUCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 15:02:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:3510 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932186AbWBXUCI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 15:02:08 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV70030FJNJBJJ0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 15:02:07 -0500 (EST)
In-reply-to: <20060224192354.GC387@hpsvcnb.fc.hp.com>
X-X-Sender: nico@localhost.localdomain
To: Carl Baldwin <cnb@fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16732>

On Fri, 24 Feb 2006, Carl Baldwin wrote:

> I see what you're saying about this data reuse helping to speed up
> subsequent cloning operations.  However, if packing takes this long and
> doesn't give me any disk space savings then I don't want to pay the very
> heavy price of packing these files even the first time nor do I want to
> pay the price incrementally.

Of course.  There is admitedly a problem here.  I'm just abusing a bit 
of your time to properly identify its parameters.

> The most I would tolerate for the first pack is a few seconds.  The most
> I would tolerate for any incremental pack is about 1 second.

Well that is probably a bit tight.  Ideally it should be linear with the 
size of the data set to process.  If you have 10 files 10MB each it 
should take about the same time to pack than 10000 files of 10KB each.  
Of course incrementally packing one additional 10MB file might take more 
than a second although it is only one file.
 
> BTW, git repack has been going for 30 minutes and has packed 4/36
> objects.  :-)

Pathetic.

> I think the right answer would be for git to avoid trying to pack files
> like this.  Junio mentioned something like this in his message.

Yes.  First we could add an additional parameter to the repacking 
strategy which is the undeltified but deflated size of an object.  That 
would prevent any deltas to become bigger than the simply deflated 
version.

Remains the delta performance issue.  I think I know what the problem 
is.  I'm not sure I know what the best solution would be though.  The 
patological data set is easy to identify quickly and one strategy might 
simply to bail out early when it happens and therefore not attempt any 
delta.

However, if you could let me play with two samples of your big file I'd 
be grateful.  If so I'd like to make git work well with your data set 
too which is not that uncommon after all.


Nicolas
