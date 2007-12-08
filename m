From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Fri, 07 Dec 2007 21:28:51 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712072124160.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
 <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 03:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0pRL-00049S-74
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbXLHC2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbXLHC2x
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:28:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61900 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbXLHC2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:28:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSP00GVELK4CY00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Dec 2007 21:28:52 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910712071804ja0a49e1m1eb209cb942bc36f@mail.gmail.com>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67499>

On Fri, 7 Dec 2007, Jon Smirl wrote:

> On 12/7/07, Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >
> > >  git repack -a -d -f  --depth=250 --window=250
> > >
> > > complete seconds RAM
> > > 10%  47 1GB
> > > 20%  29 1Gb
> > > 30%  24 1Gb
> > > 40%  18 1GB
> > > 50%  110 1.2GB
> > > 60%  85 1.4GB
> > > 70%  195 1.5GB
> > > 80%  186 2.5GB
> > > 90%  489 3.8GB
> > > 95%  800 4.8GB
> > > I killed it because it started swapping
> > >
> > > The mmaps are only about 400MB in this case.
> > > At the end the git process had 4.4GB of physical RAM allocated.
> >
> > That's really bad.
> >
> > > Starting from a highly compressed pack greatly aggravates the problem.
> >
> > That is really interesting though.
> >
> > > Starting with a 2GB pack of the same data my process size only grew to
> > > 3GB with 2GB of mmaps.
> >
> > Which is quite reasonable, even if the same issue might still be there.
> >
> > So the problem seems to be related to the pack access code and not the
> > repack code.  And it must have something to do with the number of deltas
> > being replayed.  And because the repack is attempting delta compression
> > roughly from newest to oldest, and because old objects are typically in
> > a deeper delta chain, then this might explain the logarithmic slowdown.
> >
> > So something must be wrong with the delta cache in sha1_file.c somehow.

Staring at the cache code I don't see anything wrong with it.

> I applied the delta accounting patch. It took about 200MB of from the
> memory use but that doesn't make a dent in 4GB of allocations.

Right.  I didn't expect much from that fix.


Nicolas
