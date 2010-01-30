From: Jeff King <peff@peff.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 03:59:57 -0500
Message-ID: <20100130085957.GA20112@coredump.intra.peff.net>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291614550.1681@xanadu.home>
 <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com>
 <alpine.LFD.2.00.1001291628510.1681@xanadu.home>
 <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com>
 <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 10:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb9Bf-0001aH-1O
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 10:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab0A3JAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 04:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624Ab0A3JAE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 04:00:04 -0500
Received: from peff.net ([208.65.91.99]:57217 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065Ab0A3JAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 04:00:02 -0500
Received: (qmail 20590 invoked by uid 107); 30 Jan 2010 09:00:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 30 Jan 2010 04:00:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2010 03:59:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001291641200.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138469>

On Fri, Jan 29, 2010 at 04:51:18PM -0500, Nicolas Pitre wrote:

> > Using a detached head is a more advanced feature than wanting to
> > checkout a remote branch locally, creating a local tracking branch. As
> > such, 'git checkout origin/topic' now means the same as 'git checkout
> > -t origin/topic', and you can get the old behavior back by doing 'git
> > checkout origin/topic^0'.
> 
> What purpose does this "feature" serve?  Making sure people remain 
> stupid and get even more confused when the special dwimery doesn't work 
> because they don't know the difference between a local branch and a 
> remote tracking branch?
> 
> And now people will be left wondering why after a fetch they don't get 
> the latest stuff when they do "git checkout topic" again.  Is this any 
> better?

I am entering the discussion a bit late, and things have moved on from
this point, but I wanted to mention that I have in the past made the
same argument that you have in your second paragraph (that you leave
users _more_ confused after a fetch), but somebody (I think Jay) managed
to convince me otherwise.

The saving feature is that we now print out the symmetric difference
information between a branch and its upstream during checkout. So the
user experience looks like:

  $ git checkout topic
  Branch topic set up to track remote branch topic from origin.
  Switched to a new branch 'topic'

  ... time passes ...

  $ git fetch
  ...
     9f137a4..22ac6a6  topic      -> origin/topic

  $ git checkout topic
  Switched to branch 'topic'
  Your branch is behind 'origin/topic' by 6 commits, and can be fast-forwarded.

So I think it is not quite as bad as at least I had originally thought.
There are still a few rough edges, though:

  1. If I stay on the 'topic' branch and run "git fetch", then I don't
     see the checkout message. If I don't understand that a local branch
     has been created, I might expect the new changes to be present. But
     they're not. If I do a pull instead, it does "just work", even if I
     am clueless about the local branch.

     I wonder if a "fetch" which updates the upstream branch of the
     current HEAD should print something like the "Your branch is
     behind..." message.

  2. If I am clueless that the local branch exists, I can see that there
     are new changes that I can "fast forward". But if I am clueless
     about local branches, do I know that means I need to run "git merge
     origin/topic"?  However, I can't think of an improved message that
     would make the situation clear without adding a bunch of annoying
     text.

-Peff
