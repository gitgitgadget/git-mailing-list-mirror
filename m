From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 16:24:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:24:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw33Y-0003RZ-36
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWF2UYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWF2UYE
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:24:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28855 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932401AbWF2UYC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:24:02 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1N000AZ2014W20@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 16:24:01 -0400 (EDT)
In-reply-to: <20060629195201.GA10786@coredump.intra.peff.net>
X-X-Sender: nico@localhost.localdomain
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22902>

On Thu, 29 Jun 2006, Jeff King wrote:

> On Thu, Jun 29, 2006 at 03:04:15PM -0400, Nicolas Pitre wrote:
> 
> > Right.  Your use pattern is a special case that doesn't work well with 
> > the whole window hash approach.  I'd expect it to work beautifully with 
> > the kernel repository though.
> 
> I don't necessarily care about the kernel repository. It packs fine as
> it is, and you only waste 30 seconds on a repack checking deltas that
> could be avoided. I do care on my special repository where packing is
> virtually unusable and I can achieve a 45x speedup. Maybe my original
> caching is not worth it for the kernel and should be configurable,
> but obviously this window caching cannot REPLACE mine since it fails
> utterly for the one thing I wanted it for.

And I agreed with you already.

> That being said, I'm not sure that window caching is all that great for
> "normal" repos.
> 
> Same test as before, but instead of simulating the commits, I merely
> looked at the window hashes produced by 
>   git-rev-list --objects master~$x
> 
> For the git repo:
> x=0 tries 6698 windows
> x=0 and x=50 contain 5197 identical windows
> x=0 and x=100 contain 2484 identical windows
> x=0 and x=500 contain 455 identical windows
> 
> For linux-2.6 repo:
> x=0 tries 57208 windows
> x=0 and x=50 contain 53677 identical windows
> x=0 and x=100 contain 52886 identical windows
> x=0 and x=500 contain 41196 identical windows
> 
> Obviously the kernel repo is doing better, but x=500 is only 4 days ago.
> Trying with --before=2.weeks.ago yields only 31505 matches.

What does this prove?  I fail to see the relation between those results 
and a possible git-pack-objects improvement.

The negative delta cache concept is certainly attractive even for normal 
repositories, especially for public servers, since when used in 
conjonction with delta reuse it makes the creation of a pack basically 
free.  So I think this idea really has merits, as long as the cache 
remains small.


Nicolas
