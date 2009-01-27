From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 10:31:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271030000.14855@racer>
References: <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain>
 <20090127044838.GA735@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 10:32:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkIw-0003H3-Hi
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbZA0Jai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZA0Jai
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:30:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:55025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753701AbZA0Jah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:30:37 -0500
Received: (qmail invoked by alias); 27 Jan 2009 09:30:35 -0000
Received: from pD9EB30BF.dip0.t-ipconnect.de (EHLO noname) [217.235.48.191]
  by mail.gmx.net (mp062) with SMTP; 27 Jan 2009 10:30:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ais8Elola4jqcA3ogY17nSEfbdG1S09ZAcEcYYf
	lqh20LyvpBf/uy
X-X-Sender: gene099@racer
In-Reply-To: <20090127044838.GA735@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107326>

Hi,

On Mon, 26 Jan 2009, Jeff King wrote:

> On Mon, Jan 26, 2009 at 07:38:56PM -0800, Linus Torvalds wrote:
> 
> > > ==valgrind== Syscall param write(buf) points to uninitialised byte(s)
> > > ==valgrind==    at 0x5609E40: __write_nocancel (in /lib/libpthread-2.6.1.so)
> > > ==valgrind==    by 0x4D0380: xwrite (wrapper.c:129)
> > > ==valgrind==    by 0x4D046E: write_in_full (wrapper.c:159)
> > > ==valgrind==    by 0x4C0697: write_buffer (sha1_file.c:2275)
> > > ==valgrind==    by 0x4C0B1C: write_loose_object (sha1_file.c:2387)
> > 
> > Looks entirely bogus.
> > 
> > I suspect that valgrind for some reason doesn't see the writes made by 
> > zlib as being initialization, possibly due to some incorrect valgrind 
> > annotations on deflate().  We've just totally initialized that whole 
> > buffer with deflate().
> > 
> > It definitely does not look like a git bug, but a valgrind run issue.
> 
> Yes, this is exactly the issue I ran into when doing the valgrind stuff
> a few months ago. I spent several hours looking carefully at the code
> and came to the same conclusion. Anything zlib touches needs to be
> manually suppressed for uninitialized writes (which I _thought_ was
> covered in the suppressions I sent out originally, but maybe they need
> to be tweaked for Dscho's system).

Indeed.  I used the "..." wildcard to account for slight differences in 
Git's code calling path.

Sorry for the noise,
Dscho
