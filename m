From: Nicolas Pitre <nico@cam.org>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 10:50:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705171043070.24220@xanadu.home>
References: <20070515201006.GD3653@efreet.light.src>
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
 <Pine.LNX.4.64.0705170152470.6410@racer.site> <vpq8xbnlmdv.fsf@bauges.imag.fr>
 <46a038f90705170610mf9c9b0eu7b40af709469a601@mail.gmail.com>
 <Pine.LNX.4.64.0705171445100.6410@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 17 16:50:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HohJc-0000uT-Fd
	for gcvg-git@gmane.org; Thu, 17 May 2007 16:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXEQOuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 10:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbXEQOuq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 10:50:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbXEQOup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 10:50:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI600BJ3X8DMA70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 May 2007 10:50:38 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0705171445100.6410@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47528>

On Thu, 17 May 2007, Johannes Schindelin wrote:

> Hi,
> 
> [I missed this mail, because Matthieu culled the Cc list again]
> 
> On Fri, 18 May 2007, Martin Langhoff wrote:
> 
> > On 5/17/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> >
> > > FYI, bzr uses HTTP range requests, and the introduction of this
> > > feature lead to significant performance improvement for them (bzr is
> > > more dumb-protocol oriented than git is, so that's really important
> > > there). They have this "index file+data file" system too, so you
> > > download the full index file, and then send an HTTP range request to
> > > get only the relevant parts of the data file.
> > 
> > That's the kind of thing I was imagining. Between the index and an
> > additional "index-supplement-for-dumb-protocols" maintained by
> > update-server-info, http ranges can be bent to our evil purposes.
> > 
> > Of course it won't be as network-efficient as the git proto, or even
> > as the git-over-cgi proto, but it'll surely be server-cpu-and-memory
> > efficient. And people will benefit from it without having to do any
> > additional setup.
> 
> Of course, the problem is that only the server can know beforehand which 
> objects are needed.

But the whole idea is that we don't care.

> Imagine this:
> 
> X - Y - Z
>   \
>     A
> 
> 
> Client has "X", wants "Z", but not "A". Client needs "Y" and "Z". But 
> client cannot know that it needs "Y" before getting "Z", except if the 
> server says so.
> 
> If you have a solution for that problem, please enlighten me: I don't.

We're talking about a _dumb_ protocol here.  If you want something 
fancy, just use the Git daemon.

Otherwise, you'll simply get everything the remote has that you don't 
have, including A.

In practice this shouldn't be a problem because people tend to have 
clean repositories on machines they want their stuff to be published, 
meaning that those public repos are usually the result of pushes, hence 
they contain only the minimum set of needed objects.  Of course you get 
every branches and not only a particular one, but that's the price to 
pay with a dumb protocol.


Nicolas
