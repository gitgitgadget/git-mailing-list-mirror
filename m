From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Thu, 18 Jan 2007 16:15:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181612440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd55col04.fsf@assigned-by-dhcp.cox.net>
 <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com>
 <45AF8A86.7070101@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7YzE-0007XI-FJ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbXARPPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbXARPPb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:15:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:36917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932423AbXARPPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:15:30 -0500
Received: (qmail invoked by alias); 18 Jan 2007 15:15:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 18 Jan 2007 16:15:29 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <45AF8A86.7070101@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37104>

Hi,

On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:

> Morten Welinder wrote:
> > > -                       return ntohl(*((unsigned int *) ((char *) index +
> > > (24 * mi))));
> > > +                       return ntohl(*((uint32_t *)((char *)index + (24 *
> > > mi))));
> > 
> > Is that pointer gymnastics guaranteed to work?  I.e., how do we know
> > that we can access an uint32_t (or unsigned) at such an address?
> 
> if index is always aligned to a 4-byte boundary, this is safe.  apart from
> that, the problem already existed.

index is assigned from p->index_base, which comes from 
check_packed_git_idx(), and there it comes from an xmmap(). AFAICT mmap() 
(and for NO_MMAP, malloc()) _always_ return aligned pointers, so there is 
no problem, as long as the alignment step divides 24.

Ciao,
Dscho
