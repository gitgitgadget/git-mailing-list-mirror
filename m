From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] alloc_ref(): allow for trailing NUL
Date: Fri, 28 Sep 2007 17:11:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281711010.28395@racer.site>
References: <Pine.LNX.4.64.0709280356550.28395@racer.site>
 <Pine.LNX.4.64.0709280046241.5926@iabervon.org> <7vhclfqisq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709281259050.28395@racer.site> <Pine.LNX.4.64.0709281138270.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 18:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbISe-0001Ci-R0
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 18:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXI1QM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbXI1QM4
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 12:12:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:47007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751670AbXI1QM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 12:12:56 -0400
Received: (qmail invoked by alias); 28 Sep 2007 16:12:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 28 Sep 2007 18:12:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TRA5qHdxTTLO2yzl1cXpRKDUBRmawcNWOCDxOy2
	ZhV8DwGrcj7v0b
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709281138270.5926@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59407>

Hi,

On Fri, 28 Sep 2007, Daniel Barkalow wrote:

> On Fri, 28 Sep 2007, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Fri, 28 Sep 2007, Junio C Hamano wrote:
> > 
> > > Daniel Barkalow <barkalow@iabervon.org> writes:
> > > 
> > > > On Fri, 28 Sep 2007, Johannes Schindelin wrote:
> > > >
> > > >> The parameter name "namelen" suggests that you pass the equivalent of
> > > >> strlen() to the function alloc_ref().  However, this function did not
> > > >> allocate enough space to put a NUL after the name.
> > > >> 
> > > >> Since struct ref does not have any member to describe the length of the
> > > >> string, this just does not make sense.
> > > >> 
> > > >> So make space for the NUL.
> > > >
> > > > Good point, but shouldn't you then fix call sites that use strlen(name) + 
> > > > 1?
> > > 
> > > Good point.
> > > 
> > > I audited "git grep -A2 -B4 -e alloc_ref next master" output,
> > > and it appears almost everybody knows alloc_ref() wants the
> > > caller to count the terminating NUL.
> > > 
> > > There however are a few gotchas.
> > > 
> > >  * There is one overallocation in connect.c, which would not
> > >    hurt but is wasteful;
> > > 
> > >  * next:transport.c has alloc_ref(strlen(e->name)) which is a
> > >    no-no;
> > > 
> > > Discarding Johannes's patch, the following would fix it.
> > 
> > But should the signature of alloc_ref() not be changed, then, to read
> > 
> > 	struct ref *alloc_ref(unsigned name_alloc);
> > 
> > Hm?
> > 
> > Further, I am quite sure that the same mistake will happen again, until we 
> > change the function to get the name length, not the number of bytes to 
> > allocate.
> 
> I agree. But leaving the majority of cases using the old convention is 
> just confusing.

Yeah, sorry, that patch was only half-cooked.

If people agree with me, I'll redo the patch (fixing all calling sites, 
too).

Ciao,
Dscho
