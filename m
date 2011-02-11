From: Jeff King <peff@peff.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Thu, 10 Feb 2011 23:45:40 -0500
Message-ID: <20110211044539.GA2071@sigill.intra.peff.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
 <20110210225428.GA21335@sigill.intra.peff.net>
 <m2oc6jtg8o.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Wiegley <johnw@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 05:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnktE-0001se-7X
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 05:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab1BKEpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 23:45:47 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46903 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab1BKEpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 23:45:46 -0500
Received: (qmail 23831 invoked by uid 111); 11 Feb 2011 04:45:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 11 Feb 2011 04:45:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Feb 2011 23:45:40 -0500
Content-Disposition: inline
In-Reply-To: <m2oc6jtg8o.fsf@hermes.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166537>

On Thu, Feb 10, 2011 at 10:14:15PM -0500, John Wiegley wrote:

> > And there are lots of other cases. What about "git cherry-pick -n"? What
> > about rebasing? If there are no conflicts, is it OK to copy the origin
> > field? How about if there are conflicts? How about in a "git rebase -i",
> > where we may stop and the user can arbitrarily split, amend, or add new
> > commits. How do the old commits map to the new ones with respect to
> > origin fields?
> 
> During rebasing, any commits which can be rebased without conflict have their
> origin transferred (and each time it would cause the origin id list to grow by
> one), but any commits which are squashed or edited would not transfer.

OK. That's certainly the conservative answer, and where we should start.
But I wonder in practice how many times we'll hit all the criteria just
right for this feature to kick in (i.e., a cherry pick or rebase with no
conflicts, followed by one that would cause a conflict). But I think
there's nothing to do but implement and see how it works.

After thinking about this a bit more, the whole idea of "is this
cherry-picked/rebased/whatever commit the same as the one before" is
really the same as the notes-rewriting case (i.e., copying notes on
commit A when it is rebased into A'). Which makes me excited about using
notes for this, because the rules that you do figure out to work in
practice will be good rules for notes rewriting in general.

> The problem with an external annotation is that if developers are sharing
> feature branches, as a branch maintainer I want to know whether commits coming
> from those feature branches are already in the branch I'm maintaining.

In that case, I would suggest putting it in git-notes and sharing the
notes with each other. The notes code should happily merge them all
together, and then everyone gets to see everybody else's
cherry-pick/rebase annotations.

-Peff
