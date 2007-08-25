From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 20:10:46 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708241951100.16727@xanadu.home>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
 <20070824062106.GV27913@spearce.org>
 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
 <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
 <9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 02:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOjF5-0007ab-MF
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 02:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbXHYAKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757169AbXHYAKu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 20:10:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44565 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbXHYAKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 20:10:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNA009ZZZ609313@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Aug 2007 20:10:48 -0400 (EDT)
In-reply-to: <9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56616>

On Fri, 24 Aug 2007, Jon Smirl wrote:

> On 8/24/07, Nicolas Pitre <nico@cam.org> wrote:
> > Try running "git repack -a" directly on the NSLU2.  You should have the
> > same performance problems as with a clone.
> 
> This is true, it would take over 24hrs to finish.
> 
> Is their a reason why initial clone hasn't been special cased? Why
> can't initial clone just blast over the pack file already sitting on
> the disk?

What is the gain?  You'll get back to the same performance problem 
eventually with some fetch operation, unless you intend to serve clients 
with the whole pack everytime just like the http protocol does.

Also you don't want people cloning from you getting stuff that sits in 
your reflog.  The native protocol makes sure that only the needed 
objects are sent over and no more.

> I also wonder if a little application of some sorting to in-memory
> data structures could help with the random IO patterns. I'm getting
> the same data out of a stupid HTTP server and it doesn't go all IO
> bound on me so a solution has to be possible.

The http application is, indeed, stupid.  It performs no reachability 
analysis, no repacking, no nothing except copying the bits over.

And yes I did add some sorting optimizations in this round, so if you 
try 2.5.3-* you should have them.  But there is a limit to what can be 
done.

Point is, if you want serious Git serving, and not only _dumb_ protocols 
(http is one of them) then you need more RAM.  The NSLU2 is cool, but 
maybe not appropriate for serving the Linux kernel natively with Git.


Nicolas
