From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 11:44:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709281138270.5926@iabervon.org>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site>
 <Pine.LNX.4.64.0709280046241.5926@iabervon.org> <7vhclfqisq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709281259050.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 17:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbI19-0005rX-Tc
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 17:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbXI1PoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXI1PoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 11:44:25 -0400
Received: from iabervon.org ([66.92.72.58]:55235 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbXI1PoY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 11:44:24 -0400
Received: (qmail 6715 invoked by uid 1000); 28 Sep 2007 15:44:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 15:44:21 -0000
In-Reply-To: <Pine.LNX.4.64.0709281259050.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59406>

On Fri, 28 Sep 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 28 Sep 2007, Junio C Hamano wrote:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > > On Fri, 28 Sep 2007, Johannes Schindelin wrote:
> > >
> > >> The parameter name "namelen" suggests that you pass the equivalent of
> > >> strlen() to the function alloc_ref().  However, this function did not
> > >> allocate enough space to put a NUL after the name.
> > >> 
> > >> Since struct ref does not have any member to describe the length of the
> > >> string, this just does not make sense.
> > >> 
> > >> So make space for the NUL.
> > >
> > > Good point, but shouldn't you then fix call sites that use strlen(name) + 
> > > 1?
> > 
> > Good point.
> > 
> > I audited "git grep -A2 -B4 -e alloc_ref next master" output,
> > and it appears almost everybody knows alloc_ref() wants the
> > caller to count the terminating NUL.
> > 
> > There however are a few gotchas.
> > 
> >  * There is one overallocation in connect.c, which would not
> >    hurt but is wasteful;
> > 
> >  * next:transport.c has alloc_ref(strlen(e->name)) which is a
> >    no-no;
> > 
> > Discarding Johannes's patch, the following would fix it.
> 
> But should the signature of alloc_ref() not be changed, then, to read
> 
> 	struct ref *alloc_ref(unsigned name_alloc);
> 
> Hm?
> 
> Further, I am quite sure that the same mistake will happen again, until we 
> change the function to get the name length, not the number of bytes to 
> allocate.

I agree. But leaving the majority of cases using the old convention is 
just confusing.

	-Daniel
*This .sig left intentionally blank*
