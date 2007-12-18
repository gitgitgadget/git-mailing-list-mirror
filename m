From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 13:53:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181351270.23902@racer.site>
References: <20071217192306.5da48540@pc09.procura.nl>
 <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org> <20071217232259.0b41a3bf@pc09.procura.nl>
 <7vbq8o370k.fsf@gitster.siamese.dyndns.org> <476781C6.6050507@viscovery.net>
 <Pine.LNX.4.64.0712181234520.23902@racer.site> <4767C105.8080607@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 14:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ctN-0007Jn-8Z
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 14:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbXLRNxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 08:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbXLRNxR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 08:53:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:51562 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755200AbXLRNxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 08:53:15 -0500
Received: (qmail invoked by alias); 18 Dec 2007 13:53:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 18 Dec 2007 14:53:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/j7nhU/GHj0meZAyCMGHnoml+wNioylkKZq1b99W
	1yLqr2GwuM5Meb
X-X-Sender: gene099@racer.site
In-Reply-To: <4767C105.8080607@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68747>

Hi,

On Tue, 18 Dec 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > 
> > On Tue, 18 Dec 2007, Johannes Sixt wrote:
> > 
> >> Junio C Hamano schrieb:
> >>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> >>>
> >>>> On Mon, 17 Dec 2007 13:00:22 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> >>>>
> >>>>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> >>>>>
> >>>>>> HP-UX does not have select.h, but it offers all select () 
> >>>>>> functionality. The defines are in <sys/types.h> and <X11/fd.h>
> >>>>> Will apply the patch as-is for now, only because I do not want 
> >>>>> major surgery during rc period, but I think is can be improved.
> >>>> ...
> >>>>> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test 
> >>>>> macros
> >>>> That is defined in GNU gcc. I did not pass it with -D...
> >>> Actually I changed my mind.  I won't be applying this as is.
> >>>
> >>> For the selective inclusion of <sys/select.h>, I would prefer it see 
> >>> it done like the attached.
> >> Is select() actually needed? The one instance in pager.c can easily 
> >> be replaced by poll(), which I've already done in my own tree. The 
> >> other one in http.c is only used as a timer, but I don't know how to 
> >> get rid of that. Maybe a setitimer()/pause() combo?
> > 
> > I'd be cautious about using poll().  AFAIK MacOSX 10.2.8 does not have 
> > poll(), and IIRC I had problems finding it in MinGW, too.  I know, we 
> > use it in daemon, upload-archive and upload-pack, but these are not 
> > typically functions performed by a client, so I would not know if it 
> > worked on my (now-dead) iBook, or on msysGit.
> 
> So what? If we use poll() already in daemon, upload-archive and 
> upload-pack, and no MacOSX 10.2.8 user has spoken up with a proposal for 
> replacement, then yet another use won't raise a complaint, either.

daemon, upload-archive and upload-pack are server-side functions, so they 
are substantially less well tested.

> And if it were a problem for msysGit, I wouldn't have suggested it ;) 
> The particular use in pager.c would be inside #ifndef __MINGW32__ #endif 
> anyway.

We still did not integrate the 'daemon' branch of 4msysgit, correct?

I'm just wary to replace a tried-and-tested select() with a poll() that I 
had plenty of problems with.

Ciao,
Dscho
