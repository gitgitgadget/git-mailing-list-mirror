From: Jeff King <peff@peff.net>
Subject: Re: rewrite history
Date: Thu, 16 Jun 2011 15:49:11 -0400
Message-ID: <20110616194911.GA14355@sigill.intra.peff.net>
References: <362053118.20110616231758@gmail.com>
 <20110616192644.GB13466@sigill.intra.peff.net>
 <7vhb7ph8aj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 21:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIZ6-0004fg-In
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240Ab1FPTtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:49:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34198
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab1FPTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:49:14 -0400
Received: (qmail 17213 invoked by uid 107); 16 Jun 2011 19:49:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jun 2011 15:49:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2011 15:49:11 -0400
Content-Disposition: inline
In-Reply-To: <7vhb7ph8aj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175922>

On Thu, Jun 16, 2011 at 12:43:00PM -0700, Junio C Hamano wrote:

> >> Hi list. There were 2 branches. One's HEAD was modified to match a
> >> specific commit at another branch. Now, how to merge them according to
> >> this scheme?
> >> 
> >> A---B---X---E---F
> >>                      =>  C---D---X---E---F
> >> C---D---X'
> >> 
> >> X and X' have no difference. I tried to write a script to cherry-pick
> >> E and F, but some of commits are merges and cherry-pick fails.
> >
> > I think you just want to rebase using the "-p" option to preserve
> > merges. Something like:
> >
> >   $ git checkout -b rebased-branch F
> >   $ git rebase -p --onto D B
> >
> > that will pick X, E, and F, and replay them on top of D, resulting in
> > the graph you showed above.
> 
> Eh, careful. Nobody said the change between B and X is any similar to the
> change between D and X'. Replaying the changes E and F introduce on top of
> X' to arrive at C--D--X'-E--F is the best you could do, i.e.

I thought that was exactly what Ilya said with "X and X' have no
difference". I assumed that meant "they are semantically similar commits
on different bases" (i.e., a cherry-pick) and not "they have the exact
same tree state" (i.e., "git diff X X'" is empty).

> But wouldn't filter-branch a better tool for this?  Graft to pretend that
> the parent of X is D instead of B, and filter the branch with F at its
> tip, that is.

If my assumption on the meanings is reversed (i.e., X and X' really are
the same tree state, not introducing equivalent commits), then yeah,
that would be better.

-Peff
