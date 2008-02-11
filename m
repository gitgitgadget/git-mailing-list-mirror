From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pack-objects: only throw away data during memory
 pressure
Date: Mon, 11 Feb 2008 16:08:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802111606440.3870@racer.site>
References: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LSU.1.00.0802111519300.3870@racer.site> <alpine.LFD.1.00.0802111054080.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:09:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JObDe-00067l-Je
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 17:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758435AbYBKQIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 11:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758269AbYBKQIG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 11:08:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:36577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757594AbYBKQIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 11:08:04 -0500
Received: (qmail invoked by alias); 11 Feb 2008 16:08:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 11 Feb 2008 17:08:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199b91eqVl9A7d+Zhgr68T6BotyFUHRbK68kPpgWd
	7Ze8X9wxoRWxxE
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802111054080.2732@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73548>

Hi,

On Mon, 11 Feb 2008, Nicolas Pitre wrote:

> On Mon, 11 Feb 2008, Johannes Schindelin wrote:
> 
> > On Mon, 11 Feb 2008, Martin Koegler wrote:
> > 
> > > What about this not really tested patch for dealing with memory 
> > > pressure in git-pack-objects?
> > > 
> > > It will slow down the repack in the case of memory pressure, but 
> > > missing memory will not affect the results.
> > 
> > It almost helped:
> > 
> > $ /usr/bin/time git repack -a -d -f --window=250 --depth=250
> > Counting objects: 2477715, done.
> > fatal: Out of memory, malloc failed411764)
> > Command exited with non-zero status 1
> > 10050.12user 240.63system 2:53:37elapsed 98%CPU (0avgtext+0avgdata 
> > 0maxresident)k
> > 0inputs+0outputs (29555major+94032945minor)pagefaults 0swaps
> > 
> > So, it ran longer until it ran out of memory.
> 
> What it can do for you is to limit the window memory usage much more 
> without affecting the end result, say to 128MB.  Of course the repack is 
> then going to progress much slower if active purging of the window 
> memory is involved.

Oh, well.  I did not think of setting a smaller windowMemory.  Will try 
that next.

> If you still run out of memory at that point then there is not much more 
> to do besides using a new memory allocator that doesn't suffer as much 
> from memory fragmentation, or find the possible memory leak that no one 
> else found so far.

Completely forgot to say: I am running with ememoa (that is the Google 
allocator, right?).

Ciao,
Dscho
