From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix memory leak in transport-helper
Date: Tue, 27 Oct 2009 19:54:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271954020.11562@felix-maschine>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net> <20091015154142.GL10505@spearce.org> <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
 <20091015204543.GP10505@spearce.org> <alpine.LNX.2.00.0910270032170.14365@iabervon.org> <alpine.DEB.1.00.0910271510430.4985@pacific.mpi-cbg.de> <alpine.LNX.2.00.0910271329510.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rCE-0006rg-25
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 19:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbZJ0Syu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 14:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbZJ0Sys
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 14:54:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:44649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756601AbZJ0Syq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 14:54:46 -0400
Received: (qmail invoked by alias); 27 Oct 2009 18:54:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 27 Oct 2009 19:54:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oYbFNcNCoIV+UwsKN3KxR0hPrjiswpMIuuQqabI
	R9CD36NnoEz9CJ
X-X-Sender: johannes@felix-maschine
In-Reply-To: <alpine.LNX.2.00.0910271329510.14365@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131370>

Hi,

On Tue, 27 Oct 2009, Daniel Barkalow wrote:

> On Tue, 27 Oct 2009, Johannes Schindelin wrote:
> 
> > Hi,
> > 
> > On Tue, 27 Oct 2009, Daniel Barkalow wrote:
> > 
> > > diff --git a/transport-helper.c b/transport-helper.c
> > > index f57e84c..479539d 100644
> > > --- a/transport-helper.c
> > > +++ b/transport-helper.c
> > > @@ -67,6 +67,13 @@ static int disconnect_helper(struct transport *transport)
> > >  	return 0;
> > >  }
> > >  
> > > +static int close_helper(struct transport *transport)
> > > +{
> > > +	disconnect_helper(transport);
> > > +	free(transport->data);
> > > +	return 0;
> > > +}
> > 
> > Why did you not leech the transport->data = NULL; part from Peff/Sverre's 
> > patch?
> 
> Because this code is only called just before transport itself is freed by 
> the caller, and, in general, a transport with these methods is invalid 
> without a valid transport->data. I expect that's also why Peff called it a 
> hack not appropriate for actual application.

So you mean to imply that this method is not about closing, but about 
releasing the structure.  Right?

Ciao,
Dscho
