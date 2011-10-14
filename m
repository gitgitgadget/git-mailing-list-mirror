From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 21:38:30 -0400
Message-ID: <20111014013830.GA7258@sigill.intra.peff.net>
References: <20111013145924.2113c142@ashu.dyn.rarus.ru>
 <loom.20111013T130924-792@post.gmane.org>
 <4E96D819.20905@op5.se>
 <loom.20111013T152144-60@post.gmane.org>
 <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
 <loom.20111013T171530-970@post.gmane.org>
 <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
 <loom.20111013T193054-868@post.gmane.org>
 <7vzkh44ug1.fsf@alter.siamese.dyndns.org>
 <loom.20111013T203610-130@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 03:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REWjP-0001cz-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 03:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab1JNBie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 21:38:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60090
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664Ab1JNBie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 21:38:34 -0400
Received: (qmail 32752 invoked by uid 107); 14 Oct 2011 01:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Oct 2011 21:38:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2011 21:38:30 -0400
Content-Disposition: inline
In-Reply-To: <loom.20111013T203610-130@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183532>

On Thu, Oct 13, 2011 at 06:56:14PM +0000, arQon wrote:

> I'll give a shot, though I don't know how good it'll be. Off the top of my
> head, I don't see any good way to explain the inconsistency with LOCAL CHANGES
> sometimes preventing switches and sometimes not, based on what is to the user
> an arbitrary set of rules that has nothing to do with the *current state* of
> the worktree, but rather the state of those files in prior commits.

The rules are fairly straightforward.  You are moving from branch A to
branch B. If path X is not changed going from A to B, git will not touch
it, whether or not you have local changes. If path X is changed going
from A to B, then git will refuse the checkout, and you have the option
of:

  1. checkout -f: overwrite your local changes with what's in B

  2. checkout -m: merge your changes with what's in B (using A as a
                  common ancestor)

> But sure, I'll see if I can come up with something. If nothing else,
> having the manpage at least explain what "M" means; that it can be
> potentially disastrous; and what you need to do to avoid it, would be
> a definite plus.

You keep saying things like "disastrous". Git's rules are specifically
designed to be as flexible as possible without allowing the checkout
command to cause data loss.

Do you actually have a case that causes irrecoverable data loss?

Note that I don't count "these changes were based on A, now they are
based on B" as data loss. Your file content is still completely intact,
and if you want to make them based on "A" again, you just need to
"git checkout A" again.

-Peff
