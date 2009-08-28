From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 15:27:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908281516440.6044@xanadu.home>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
 <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828180158.GA6940@coredump.intra.peff.net>
 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
 <20090828183958.GA11488@coredump.intra.peff.net>
 <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
 <alpine.LFD.2.00.0908281458370.6044@xanadu.home>
 <81b0412b0908281208h20aa6e81od3d6567fdffa0dec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_lb+ID62xmPim8dGJbDlGTw)"
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh77K-0008Ly-Uz
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZH1T15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbZH1T15
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:27:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbZH1T15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:27:57 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KP300AU7Q2H9JK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Aug 2009 15:27:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <81b0412b0908281208h20aa6e81od3d6567fdffa0dec@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127341>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_lb+ID62xmPim8dGJbDlGTw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 28 Aug 2009, Alex Riesen wrote:

> On Fri, Aug 28, 2009 at 21:00, Nicolas Pitre<nico@cam.org> wrote:
> >> >> Microsoft's compiler and libraries? MacOSX?
> >> >
> >> > Are you saying you know those to be platforms with problems, or are you
> >> > asking whether those platforms will have problems?
> >>
> >> Both: MS never had weak/vague linkage, but I don't know about MacOSX.
> >
> > This is not about weak or vague linkage.  This is plain basic linker
> > feature where no library object needs to be linked if there is no symbol
> > to resolve.
> 
> Maybe I missed something, but wasn't the idea to overwrite gettimeofday
> with a public gettimeofday, defined in one of the object files?

Yes, in test-date.o.

> And shouldn't a linker complain regarding duplicated symbols, unless
> the other (library) symbol is defined as a weak symbol, allowing
> overriding it with another symbol of stronger linkage?

Normally a linker would search for new objects to link only when there 
are still symbols to resolve.  If the library is well architected (mind 
you I don't know if that is the case on Windows or OS X) you should find 
many small object files in a library, so to have only related functions 
together in a single object for only the needed code to be linked in the 
final binary. Hence the printf symbol should be in a separate object 
file than gettimeofday, etc.

Only if the library's object file containing gettimeofday also contains 
another symbol pulled by the linker will you see a duplicated symbol 
error.  But this is still a possibility.  So your proposal is probably 
cleaner.


Nicolas

--Boundary_(ID_lb+ID62xmPim8dGJbDlGTw)--
