From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: rebase -i -p will be made sane again
Date: Tue, 27 Jan 2009 18:59:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271855240.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:02:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsFb-0005Vk-8D
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbZA0R7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZA0R7p
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:59:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:32772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753934AbZA0R7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:59:44 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:59:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 27 Jan 2009 18:59:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fXzcvcejf+yoskdJPl7pFQ/SSY5VMpqcqdWApdn
	o4obDQ3WkQJmYp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127085418.e113ad5a.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107373>

Hi,

On Tue, 27 Jan 2009, Stephen Haberman wrote:

> > As for the design bug I want to fix: imagine this history:
> > 
> >   ------A
> >  /     /
> > /     /
> > ---- B
> > \     \
> >  \     \
> >   C-----D-----E = HEAD
> > 
> > A, C and D touch the same file, and A and D agree on the contents.
> > 
> > Now, rebase -p A does the following at the moment:
> > 
> >   ------A-----E' = HEAD
> >  /     /
> > /     /
> > ---- B
> > 
> > In other words, C is truly forgotten, and it is pretended that D never 
> > happened, either.  That is exactly what test case 2 in t3410 tests for 
> > [*1*].
> > 
> > This is insane.
> 
> Agreed.

Good!  I already feared that you would be disagreeing with me.

> Does this mean you're just getting rid of the code that calls "rev list 
> --cherry-pick"?

Not exactly.  The idea of rebasing is to stay on top of an upstream.  If 
that upstream has your changes already, you do not want to reapply them -- 
even with --preserve-merges.

Now, a merge cannot be sent as a patch mail, for good reasons.  So 
whatever merge might look like yours, it is not.  So it is your 
responsibility to say that yours is obsolete, and delete it from the 
rebase script.

If your merge is in upstream (because a pull-request was heeded, for 
example), then you will not see the commits anyway.

> A few times I've pondered just removing the --cherry-pick/drop commit 
> part of rebase-p, but assumed it was there for a reason.

I will find the "dropped" commits using git log -p | git patch-id.

It is still nice to tell the user if she wants to merge a parent that is 
already in upstream, so I would not like to miss out on that information.

> > [*1*] The code in t3410 was not really easy to read, even if there was 
> > an explanation what it tried to do, but the test code was inconsitent, 
> > sometimes tagging, sometimes not, sometimes committing with -a, 
> > sometimes "git add"ing first, yet almost repetitive.
> > 
> > In my endeavor not only to understand it, and either fix my code or 
> > the code in t3410, I refactored it so that others should have a much 
> > easier time to understand what it actually does.
> 
> Thanks for cleaning it up.
> 
> I recently saw a test of yours use a `test_commit` bash function that I 
> really like. My last patch submission debacle had a patch cleaning up 
> t3411 by introducing `test_commit`--I can brave `git send-email` again 
> if you have any interest in me resending it.

Heh... so I sent that part of the patches.  Hopefully they will get in 
soon, as they should be rather obvious, and I have a lot more to come...

Ciao,
Dscho
