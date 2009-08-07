From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to
 significantly speed up packing/walking
Date: Fri, 07 Aug 2009 11:00:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
References: <op.ux8i6hrbtdk399@sirnot.private>
 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
 <4A7AEFA8.5010001@drmicha.warpmail.net>
 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sam Vilain <sam@vilain.net>, Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 07 17:01:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZQwW-0001DF-37
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 17:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbZHGPBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 11:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbZHGPBF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 11:01:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9659 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417AbZHGPBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 11:01:04 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO000JE8HP6WCH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 Aug 2009 11:00:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125200>

On Fri, 7 Aug 2009, Johannes Schindelin wrote:

> On Fri, 7 Aug 2009, Sam Vilain wrote:
> 
> > Especially as in this case as Nick mentions, the domain is subtly 
> > different (ie pack vs dag). Unfortunately you just can't try to pretend 
> > that they will always be the same; you can't force a full repack on 
> > every ref change!
> 
> No, but you do not need that, either.  In the setting that is most likely 
> the most thankful one, i.e. a git:// server, you _want_ to keep the 
> repository "as packed as possible", otherwise the rev cache improvements 
> will be lost in the bad packing performance anyway.

Yes and no.

Currently, the number #1 latency in any initial git clone is the famous 
"counting objects" phase, even if the repo is perfectly packed.  And 
that's all this rev cache can and will improve.  The packing does play 
its performance role of course, but for a totally different reason.  
Hence the repository needs no be perfectly packed for a rev cache to 
speed up its own part of the game.

> > > Still, there is some redundancy between the pack index and your cache, 
> > > as you have to write out the whole list of SHA-1s all over again.  I 
> > > guess it is time to look at the code instead of asking stupid 
> > > questions.
> > >   
> > 
> > "Disk is cheap" :-)
> 
> Disk I/O ain't.
> 
> (Size of the I/O caches, yaddayadda, I'm sure you get my point).

I don't know about the size of the rev cache on disk yet (I asked Nick 
about that) nor do I really know how this cache is implemented.  But I 
know damn well about git packs and associated index and I for sure don't 
want to see a revision cache coupled with it.

And for a clone the disk IO will certainly be a magnitude larger than 
for the cache (or so I hope).  Maybe the IO for the rev cache might be a 
significant overhead for operations performed on a client (aka 
developer) repository, in which case it would be a good idea to have a 
config variable to control the cache size, or even to turn it off 
entirely.  We do it for delta depth and many other things already.


Nicolas
