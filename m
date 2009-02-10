From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 22:10:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
 <7vprhqnv0c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902101743180.10279@pacific.mpi-cbg.de> <20090210165610.GP30949@spearce.org> <7vocxam96s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:13:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzur-0006pR-Fe
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbZBJVKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbZBJVKM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:10:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:50764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751387AbZBJVKL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:10:11 -0500
Received: (qmail invoked by alias); 10 Feb 2009 21:09:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 10 Feb 2009 22:09:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oIBMQCP9oIPQX9eT/RD1mLzjG8qMSYDS9rDjLe9
	xLiVzMORb3j6Am
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocxam96s.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109308>

Hi,

On Tue, 10 Feb 2009, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> On Tue, 10 Feb 2009, Junio C Hamano wrote:
> >> > 
> >> > I could do a revert on 'master' if it is really needed, but I found that
> >> > the above reasoning is a bit troublesome.  The thing is, if a tree to hold
> >> > the notes would be huge to be unmanageable, then it would still be huge to
> >> > be unmanageable if you split it into 256 pieces.
> >> 
> >> The thing is, a tree object of 17 megabyte is unmanagably large if you 
> >> have to read it whenever you access even a single node.  Having 256 trees 
> >> instead, each of which is about 68 kilobyte is much nicer.
> >
> > See my other email on this thread; we'd probably need to unpack
> > all 256 subtrees *anyway* due to the distribution of SHA-1 names
> > for commits.
> 
> I wonder if we can solve this by introducing a local cache that is a flat
> file that looks like:
> 
>     magic number for /usr/bin/file
>     tree object SHA-1 the file caches
>     Number of entries in this file
>     256 fan-out offsets into this file
>     N entries of <SHA-1, SHA-1>, sorted
>     Checksum of the file itself
> 
> and use it when availble (otherwise optionally create it upon the first
> lookup).  The file can be used by mmaping it and then doing a newton
> raphson or binary search similar to the way patch-ids.c does.

Or we could use an on-disk hashmap.  Oh, wait...

Ciao,
Dscho
