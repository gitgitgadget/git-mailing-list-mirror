From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 15:11:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301429010.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <20090130025546.GA18257@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSu6S-0007q6-88
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZA3OKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZA3OKv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:10:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:53745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753171AbZA3OKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:10:51 -0500
Received: (qmail invoked by alias); 30 Jan 2009 14:10:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 30 Jan 2009 15:10:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UQd0CHKCUcQnSjGYrMXX1LbH1Si5cW8FLE41Bs/
	4haEIRN/Uqku3r
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090130025546.GA18257@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107823>

Hi,

On Thu, 29 Jan 2009, Jeff King wrote:

> On Fri, Jan 30, 2009 at 01:34:28AM +0100, Johannes Schindelin wrote:
> 
> > 	Let's be honest here, I have not much respect for users who fail 
> > 	to read up enough to understand what they are doing.
> > 
> > 	But hearing from those users constantly is really unnerving.  And 
> > 	it would be a one-time cost to old-timers.
> 
> I am not personally opposed to changing this default. I seem to
> recall some opposition when this was brought up initially, but I don't
> recall any specific reason besides "change is bad". Maybe those who
> oppose want to summarize their arguments here.

We like to play it safe when changing behavior that does not meet 
expectations of old-timers.

For example, all those early adopters who have forks of the linux-2.6 
repository (and probably that repository itself, too) do not have 
core.bare set.

So whenever an old-timer would upgrade to a new Git _with_ my patch, they 
would need to change their setup.

A one-time cost.

And far easier to accomodate than the push for non-dashed commands (which 
people still seem to grumble about, even if they should have realized by 
now that calling Git through the wrapper exclusively brings so many 
advantages).

> I was hoping that introducing the warning would cause new users to "get 
> it". But since this warning was put in place, I think we have still 
> gotten a few questions on the list about this. I don't know if it simply 
> because they are on older versions, or if the warning is insufficient. 
> If the former, then perhaps that argues for leaving it a little longer.

I would argue it is because users cannot read :-)

> >  	case DENY_REFUSE:
> > -		if (!is_ref_checked_out(name))
> > +		if (is_bare_repository() || !is_ref_checked_out(name))
> 
> Now what is this change about?

I missed the fact that is_ref_checked_out() already checked for that.

> > --- a/t/t5701-clone-local.sh
> > +++ b/t/t5701-clone-local.sh
> > @@ -119,7 +119,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
> >  test_expect_success 'clone empty repository' '
> >  	cd "$D" &&
> >  	mkdir empty &&
> > -	(cd empty && git init) &&
> > +	(cd empty && git init && git config receive.denyCurrentBranch false) &&
> >  	git clone empty empty-clone &&
> >  	test_tick &&
> >  	(cd empty-clone
> 
> Perhaps some of these tests would do better to actually just use a bare
> repository.

Right.  I just ran out of time, but did not want to hide the patch from 
the community.

> That would better match the expected workflow for cloning empty, anyway.

Well, I did not want to mix up the two of them.  Besides, I have this 
patch in my personal tree for quite some time now, always wanting to clean 
it up enough to send it...)

Ciao,
Dscho
