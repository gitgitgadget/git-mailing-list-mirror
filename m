From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
 significantly speed up packing/walking
Date: Fri, 7 Aug 2009 08:12:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
References: <op.ux8i6hrbtdk399@sirnot.private>  <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>  <4A7AEFA8.5010001@drmicha.warpmail.net> <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com> <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
 <4A7B95A8.2010000@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Edelen <sirnot@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 08:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZIgf-0006Kv-H9
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 08:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbZHGGML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 02:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754859AbZHGGMK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 02:12:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:43806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752786AbZHGGMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 02:12:07 -0400
Received: (qmail invoked by alias); 07 Aug 2009 06:12:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 07 Aug 2009 08:12:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+W70pbjZmWvx30LQ2zPLQqaSJxRhU/QbNhSwKMYT
	SLDmN3nbCLECxk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A7B95A8.2010000@vilain.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125185>

Hi,

On Fri, 7 Aug 2009, Sam Vilain wrote:

> Johannes Schindelin wrote:
> >> the short answer is that cache slices are totally independant of pack 
> >> files.
> >>     
> >
> > My idea with that was that you already have a SHA-1 map in the pack 
> > index, and if all you want to be able to accelerate the revision 
> > walker, you'd probably need something that adds yet another mapping, 
> > from commit to parents and tree, and from tree to sub-tree and blob 
> > (so you can avoid unpacking commit and tree objects).
> >   
> 
> Tying indexes together like that is not a good idea in the database
> world.

This is not the same index as in the database world.  It is more 
comparable with a cached view.  And there, it is generally a good idea to 
keep related things in the same cached view (with an outer join), rather 
than having two primary keys for almost every record.

> Especially as in this case as Nick mentions, the domain is subtly 
> different (ie pack vs dag). Unfortunately you just can't try to pretend 
> that they will always be the same; you can't force a full repack on 
> every ref change!

No, but you do not need that, either.  In the setting that is most likely 
the most thankful one, i.e. a git:// server, you _want_ to keep the 
repository "as packed as possible", otherwise the rev cache improvements 
will be lost in the bad packing performance anyway.

> > Still, there is some redundancy between the pack index and your cache, 
> > as you have to write out the whole list of SHA-1s all over again.  I 
> > guess it is time to look at the code instead of asking stupid 
> > questions.
> >   
> 
> "Disk is cheap" :-)

Disk I/O ain't.

(Size of the I/O caches, yaddayadda, I'm sure you get my point).

Ciao,
Dscho
