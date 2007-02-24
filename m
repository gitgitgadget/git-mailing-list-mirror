From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 21:28:39 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702232123110.29426@xanadu.home>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
 <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmeS-0007dj-8s
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbXBXC2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933348AbXBXC2l
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:28:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64845 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347AbXBXC2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:28:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDY003C247RMI00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 23 Feb 2007 21:28:40 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40499>

On Sat, 24 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 23 Feb 2007, Nicolas Pitre wrote:
> 
> > On Sat, 24 Feb 2007, Johannes Schindelin wrote:
> > 
> > > Since most servers will not have a no-progress aware upload-pack, how 
> > > about this? (It is slightly ugly, but at least works...)
> > 
> > Just slightly.
> > 
> > Why not simply filtering any string that ends in '\r' ?
> 
> As I mentioned in another mail, I find this issue not so ugly as that the 
> patch touches a totally unrelated file, builtin-archive.c.

Actually that is not the part that bothered me at all.

What really bothered me is the implicit knowledge added to the sideband 
stuff about "done\r".

And since all progress strings ar likely to end in '\r' for easy 
redrawing then I think your patch would be so much cleaner if you'd only 
discard any remote string that ends in \r, or only contains a single \n.  
After all those are the strings you don't want to see in your log files.

And I would do that and _only_ that to supress progress.  No messing 
around with protocol extensions.  Just filter out the unwanted messages 
locally and be happy.


Nicolas
