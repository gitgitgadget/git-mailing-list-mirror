From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 17:30:44 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712061726240.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
 <9e4733910712052247x116cabb4q48ebafffb93f7e03@mail.gmail.com>
 <20071206071503.GA19504@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0712060915590.555@xanadu.home>
 <20071206173946.GA10845@sigill.intra.peff.net>
 <alpine.LFD.0.9999.0712061030560.13796@woody.linux-foundation.org>
 <9e4733910712061055p353775d8wd0321bc9c81297b7@mail.gmail.com>
 <alpine.LFD.0.99999.0712061403000.555@xanadu.home>
 <9e4733910712061339n3aef023r22e5b73aac120c8a@mail.gmail.com>
 <alpine.LFD.0.99999.0712061645120.555@xanadu.home>
 <9e4733910712061422w139273c0gf3cfb04c6ba8c509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Daniel Berlin <dberlin@dberlin.org>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 23:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0PFN-0006Ma-2h
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 23:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbXLFWar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 17:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbXLFWar
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 17:30:47 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56498 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbXLFWaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 17:30:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSN002A1FV8SC40@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 17:30:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712061422w139273c0gf3cfb04c6ba8c509@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67349>

On Thu, 6 Dec 2007, Jon Smirl wrote:

> On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 6 Dec 2007, Jon Smirl wrote:
> >
> > > On 12/6/07, Nicolas Pitre <nico@cam.org> wrote:
> > > > > When I lasted looked at the code, the problem was in evenly dividing
> > > > > the work. I was using a four core machine and most of the time one
> > > > > core would end up with 3-5x the work of the lightest loaded core.
> > > > > Setting pack.threads up to 20 fixed the problem. With a high number of
> > > > > threads I was able to get a 4hr pack to finished in something like
> > > > > 1:15.
> > > >
> > > > But as far as I know you didn't try my latest incarnation which has been
> > > > available in Git's master branch for a few months already.
> > >
> > > I've deleted all my giant packs. Using the kernel pack:
> > > 4GB Q6600
> > >
> > > Using the current thread pack code I get these results.
> > >
> > > The interesting case is the last one. I set it to 15 threads and
> > > monitored with 'top'.
> > > For 0-60% compression I was at 300% CPU, 60-74% was 200% CPU and
> > > 74-100% was 100% CPU. It never used all for cores. The only other
> > > things running were top and my desktop. This is the same load
> > > balancing problem I observed earlier.
> >
> > Well, that's possible with a window 25 times larger than the default.
> 
> Why did it never use more than three cores?

You have 648366 objects total, and only 647457 of them are subject to 
delta compression.

With a window size of 250 and a default thread segment of window * 1000 
that means only 3 segments will be distributed to threads, hence only 3 
threads with work to do.


Nicolas
