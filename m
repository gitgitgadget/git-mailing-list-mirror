From: Nicolas Pitre <nico@cam.org>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 15:34:45 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241524480.2979@xanadu.home>
References: <20080624130457.GB13696@mithlond.arda.local>
 <20080624164034.GB4654@sigill.intra.peff.net>
 <20080624185723.GA3368@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEIs-0003ji-6X
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYFXTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYFXTer
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:34:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44865 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYFXTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:34:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Z0011QFPX3P00@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 15:34:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080624185723.GA3368@mithlond.arda.local>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86124>

On Tue, 24 Jun 2008, Teemu Likonen wrote:

> Jeff King wrote (2008-06-24 12:40 -0400):
> 
> > On Tue, Jun 24, 2008 at 04:04:57PM +0300, Teemu Likonen wrote:
> > 
> > > With the current "master" branch version (29b0d0191) I get
> > > segmentation fault when trying to clone a git repo with http
> > > protocol. Tried a couple of times and it's always reproducible. You
> > > can test with the following repository (about 5.5 MB):
> > > 
> > >   git clone http://www.iki.fi/tlikonen/voikko.git
> > 
> > I can't reproduce the segfault here.
> > 
> > > I also build git from the tag v1.5.6 and it seems to work fine, so
> > > I guess the bug was introduced after 1.5.6.
> > 
> > That sounds like an excellent opportunity to learn about git-bisect.
> > Can you try bisecting the bug and reporting back the problematic
> > commit?
> 
> Indeed. I have now officially bisected the problem and the first bad or
> problematic commit is 8eca0b47 "implement some resilience against pack
> corruptions" (hence Cc to Nicolas, the author). This is always
> reproducible in my Debian 4.0 box.

I'm trying to reproduce your segfault with current master 
(v1.5.6-56-g29b0d01) but I just can't.

Can you provide a gdb backtrace of the segfault?  What my patch does is 
to return NULL in all cases when an object exists but can't be read 
instead of dying.  So if some user of read_sha1_file() is not checking 
for a returned null pointer then a null pointer dereference is most 
likely.

Note that read_sha1_file() could have returned NULL even before my 
patch, but not necessarily in all cases.


Nicolas
