From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 23:20:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
References: <0016e68fd0123a175304754694b4@google.com> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <200910131051.47117.trast@student.ethz.ch> <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:26:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxotD-0004Lb-Ne
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934370AbZJMVSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761302AbZJMVSi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:18:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:49161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752600AbZJMVSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:18:37 -0400
Received: (qmail invoked by alias); 13 Oct 2009 21:17:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 13 Oct 2009 23:17:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187loEM9U47Yk73GFwjcrH0sqwHekSJ5jjQhIJu31
	I/5Wy28srEx75p
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130214>

Hi,

On Tue, 13 Oct 2009, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> [this was probably quoted from Junio, Dscho doesn't have time to go back 
>  and check, but then, this was not specified in the quoted mail]
>
> >> #2. These are allowed only when unambiguous and there is no local branch yet.
> >> 
> >>  $ git checkout next               ;# ok
> >>  $ git checkout frotz              ;# ok (origin is not special)
> >>  $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)
> >
> > I'm weakly leaning towards refusing all three, as the user should be
> > required to explicitly say a remote branch should be involved.
> >
> > (Weakly because there's also a certain DWIM advantage to 'git checkout
> > sometopic'...)
> 
> I thought this was the primary point of what Dscho has been advocating.

To be honest, I was not advocating anything except being more open to 
users' problems, because we _did_ grow a large user base, way beyond the 
Linux developers (whom we can always harrass and tell to RTFM).

Just to re-add my well-known stance: consistency is a good thing.  So if 
things are ambiguous, we can be consistent in saying so and refusing to 
DWIM.  And if things are _not_ ambiguous, we can be consistent in just 
DWIMming what the user most probably meant.

If the user just typed random things in the hope that it works, we cannot 
do anything about it anyway.

So in my opinion, we should DWIM "git checkout $X" to mean "git checkout 
-b $X refs/remotes/$REMOTE/$X" when there is no ref $X, refs/heads/$X and 
no other refs/remotes/$OTHER/$X.

Likewise "git checkout $REMOTE/$X".

But, in my opinion, if there is refs/heads/$X and refs/remotes/origin/$X, 
and the user says "git checkout origin/$X", we should tell the user that 
there are the options to checkout $X and origin/$X^0 (the latter only if 
the user really intended to detach her HEAD), but not try to DWIM 
anything.

IMHO it is obvious that Hannes' suggestion to fast-forward $X and check it 
out in said scenario has some benefits in certain situations, but dramatic 
downsides in others.

But I need to drive some very important point home in this thread: 1.7.0 
was announced to break some old-time habits in favor of a better 
user-interface.  We _need_ to use this opportunity fully.

Even if that means that a few fingers have to be retrained.  Because 
retraining a few for the benefit of an easier time with the many others 
is Just Worth It.

Or in other words: logic clearly dictates that the needs of the many 
outweigh the needs of the few.

Ciao,
Dscho

P.S.: In case certain persons, ahem, think that I am applying the "Many 
Outweigh Few" principle to the time involved in top-posting and 
"forgetting" to cut quoted text to what is actually addressed: yes, you 
could not be more correct.  And I no longer believe that this goes without 
saying.
