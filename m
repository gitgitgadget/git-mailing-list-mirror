From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Thu, 18 Jan 2007 10:21:08 -0500
Message-ID: <20070118152107.GA15428@spearce.org>
References: <7vd55col04.fsf@assigned-by-dhcp.cox.net> <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com> <45AF8A86.7070101@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Z4n-0000jK-3d
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXARPVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbXARPVP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:21:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51946 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbXARPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:21:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7Z4b-0000fK-1k; Thu, 18 Jan 2007 10:21:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2CD9A20FBAE; Thu, 18 Jan 2007 10:21:08 -0500 (EST)
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Content-Disposition: inline
In-Reply-To: <45AF8A86.7070101@fs.ei.tum.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37106>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Morten Welinder wrote:
> >>-                       return ntohl(*((unsigned int *) ((char *) 
> >>index + (24 * mi))));
> >>+                       return ntohl(*((uint32_t *)((char *)index + 
> >>(24 * mi))));
> >
> >Is that pointer gymnastics guaranteed to work?  I.e., how do we know
> >that we can access an uint32_t (or unsigned) at such an address?
> 
> if index is always aligned to a 4-byte boundary, this is safe.  apart from 
> that, the problem already existed.

Its always 4-byte aligned here.  The index is mmap()'d as one huge
chunk so the first byte of the index is page aligned.  The index
starts out with 256 4-byte words, then is composed of 24 byte units
(20 byte SHA1, 4 byte offset).  So no worries with the current file
format, or code.

Yes, we're taking the leap of faith that any currently-used processor
will work on 32 bit unsigned integers if they are 4 byte aligned in
memory.  Maybe someone has a processor that this isn't true for, but
a lot of other software would probably break on that same system...

-- 
Shawn.
