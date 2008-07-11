From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Fri, 11 Jul 2008 13:21:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807111316450.3640@eeepc-johanness>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807102126.37567.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> <200807110036.17504.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
 <7v7ibtnx09.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807110155040.3279@eeepc-johanness> <7vabgolxqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 13:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHGhJ-0004dh-Mb
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 13:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbYGKLU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 07:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbYGKLU6
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 07:20:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:39696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751616AbYGKLU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 07:20:57 -0400
Received: (qmail invoked by alias); 11 Jul 2008 11:20:55 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp044) with SMTP; 11 Jul 2008 13:20:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZWUxbIsYZPTdi+yVcy7lb0w2GjRD6PtFe+VH+by
	BBPY+z0Dg0s2tw
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vabgolxqa.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88107>

Hi,

On Thu, 10 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 10 Jul 2008, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> > Of course it can be that the user commits a pilot error and says "but 
> > that unrelated version was good", while the fork point(s) between good 
> > and bad was bad (and this might be even the intention of the user, to 
> > find _one_ commit that introduced the bug).
> >
> > Speaking of plural, what if some of the merge bases are good, some are 
> > bad?
> >
> > Without carefully thinking it through, you might even _break_ the tool.
> 
> And you think it is better to make all of your _users_ think it through
> every time?  Isn't it more error prone?

Maybe I am alone here, but except for that occasion that triggered my 
"fixed/unfixed" patch, I did have to think, in order to use git-bisect.  I 
said "git bisect start && git bisect bad HEAD && git bisect good 
HEAD@{1.day.ago}", and then follow the instructions.

> > All I was proposing is keeping the current semantics, keeping the 
> > mechanism simple, and therefore reliable.
> 
> What I suggested to Christian (sorry, I've been busy and I still haven't 
> checked if that is what was implemented in the patch -- that is why I 
> suggested you to read the original thread) was:
> 
> 	- check good and bad to see if they are forked
> 
>         - iff they are,
> 
>           - have the user check merge bases and make sure they are all
>             good.  otherwise, the initial good/bad pair is unsuitable for
>             bisection, so explain the situation and quit [*1*];
> 
> 	  - otherwise, keep these good markers.
> 
> 	- do the usual bisection --- from this point on it is "simple and
>           reliable as it has always been".

Okay, that seems like a trivial and good patch.

> *1* We _could_ make things more complex by offering to swap good and bad
> at this point and then continue bisecting to find a commit to cherry-pick
> to forward port the fix.  Arguably, that step would be a new code and
> could start out to be buggy --- it _could_ be called destabilizing what
> has been reliable, but even then, it would be a separate codepath and a
> new bug will be something that triggers only when the user accepts that
> offer.  I do not see what the big deal is that you seem to be worried
> about.

That is what I am actually scared off.  That in the wake of a nice and 
trivial patch, things get muddied and complicated like back when "rebase 
-i -m" was made unusable for the layman.

Ciao,
Dscho
