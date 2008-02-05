From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/9] Add "skip_unmerged" option to unpack_trees.
Date: Tue, 5 Feb 2008 22:50:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052249270.8543@racer.site>
References: <alpine.LNX.1.00.0802041335530.13593@iabervon.org> <alpine.LSU.1.00.0802050129570.8543@racer.site> <alpine.LNX.1.00.0802042127210.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWdZ-00043j-4U
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558AbYBEWvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760557AbYBEWvA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:51:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:48523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758558AbYBEWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:50:59 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:50:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 05 Feb 2008 23:50:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ym5QVJOWYS8pp98XsgTIa4QDXBpTbBUDLXF/XMs
	yhzV6Ys9QYcPjD
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802042127210.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72715>

Hi,

On Tue, 5 Feb 2008, Daniel Barkalow wrote:

> On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> 
> > On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> > 
> > 
> > >  		if (any_files) {
> > > -			if (o->merge) {
> > > +			if (skip_entry) {
> > > +				do
> > > +					o->pos++;
> > > +				while (o->pos < active_nr &&
> > > +				       !strcmp(active_cache[o->pos]->name,
> > > +					       src[0]->name));
> > > +			} else if (o->merge) {
> > 
> > Maybe it is just me, but I would have thought
> > 
> > 				while (++o->pos < active_nr)
> > 					if (strcmp(active_cache[o->pos]->name,
> > 							src[0]->name))
> > 						break;
> > 
> > more readable.  But that's maybe because I have trouble with do ... 
> > while constructs logically (I like to see the loop condition first, 
> > then the loop body).
> 
> I find yours less readable, because the loop condition is an exceptional 
> case (this is the last entry, so we run out of active_cache before 
> finding anything else), and you've got the actual effect of the loop in 
> the condition instead of the body, and I find using the value of ++x or 
> x++ a bit confusing outside of regular idioms. I'd go for:
> 
> 				o->pos++;
> 				while (o->pos < active_nr &&
> 				       !strcmp(active_cache[o->pos]->name,
> 					       src[0]->name))
> 					o->pos++;
> 
> if you care, though; it's not bad to make it clear we're skipping the 
> first of these entries based on a different consideration from the rest 
> (the first is the entry we decided to skip, and the rest are ones that 
> match it in filename).

Well, I still find mine more readable (because it reflects how I think, I 
guess), but I do not care deeply enough.  Let's take your original.

Ciao,
Dscho
