From: Jeff King <peff@peff.net>
Subject: Re: Command-line interface thoughts
Date: Thu, 9 Jun 2011 18:38:25 -0400
Message-ID: <20110609223825.GA7771@sigill.intra.peff.net>
References: <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <4DF10ADA.5070206@alum.mit.edu>
 <7v8vtayhnm.fsf@alter.siamese.dyndns.org>
 <20110609200403.GA3955@sigill.intra.peff.net>
 <4DF13D00.2060000@alum.mit.edu>
 <BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Fri Jun 10 00:38:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUns1-0001Ws-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 00:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab1FIWi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 18:38:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab1FIWi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 18:38:28 -0400
Received: (qmail 20572 invoked by uid 107); 9 Jun 2011 22:38:36 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 18:38:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 18:38:25 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinAxWfAgBOOF0gkYDWmXDCRH+6zYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175584>

On Thu, Jun 09, 2011 at 06:27:11PM -0400, Michael Nahas wrote:

> I dunno Michael, your idea sounds dangerous.
> 
> You're saying that the user interface should be defined with concepts
> that have nothing to do with the plumbing.  That's crazy talk!  Next
> you'll be arguing that users don't need to know that the Index file
> has 4 stages!
> 
> ;)

I know you are being sarcastic, but it _is_ a dangerous thing. One of
the great things about git is that it exposes the details of its data
structures. So you rarely run into corner cases where the UI has given
you an inaccurate mental model, and you have to reconcile what is
actually happening with your mental model. The tradeoff, of course, is
that you get exposed to the full complexity of what is happening.

And note that I'm not saying it's impossible, or it's something we
definitely shouldn't do. Only that we should be aware of what
inaccuracies we might be feeding to the user, and asking questions about
how that might bite is. Like: how likely is the user to run into a
corner case where git does something unexpected? If it does happen, how
much worse will explaining the behavior be than simply having exposed
them to lower-level constructs in the first place?

Also note that I'm not even sure that this token proposal is in fact
introducing inaccuracies, and is not simply an alternate but equivalent
mental model. But these are the types of things I think people should be
thinking about in a proposal like this.

> Jakub: "it is unnecessary power"
> Yeah, like that an argument that anyone here will listen to.  "I can't
> let you have diff3.  It's too much power for you.  You might trash the
> repository with ... uh... diff3."

It's also wrong. Diff already does combined diff on arbitrary trees. So
unnecessary, perhaps, but already there.

> Peff: "... use tokens to describe non-treeish sources and destinations"
> What defines "tree-ish"ness?

I was using tree-ish there in the sense that it is used in the git
documentation, which is: a reference that can resolve to a git
tree object. So a tree sha1, a commit sha1 (which would resolve to its
tree), a tag that points to a tree or commit, a ref that points to any
of the above, and so on.

I think it is actually dying out from git documentation, though.  I was
writing to Junio there, who I know understands that term, but I should
have been more mindful that other readers of the thread wouldn't.

> What is non-treeish about NEXT/WTREE/etc.?

They don't resolve to git tree objects. :)

> Do you know of anything in the INDEX file that would not be visible
> from NEXT/WTREE/OURS/THEIRS?

The stat information, but that is usually ignored in porcelain, anyway
(we refresh the state information at the beginning of most porcelain
commands, so you can just assume everything is up to date with the
working tree and will be shown as such).

-Peff
