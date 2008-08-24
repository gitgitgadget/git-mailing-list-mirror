From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 19:13:43 -0400
Message-ID: <20080824231343.GC27619@coredump.intra.peff.net>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu> <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXOoY-0000h5-5f
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 01:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYHXXNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYHXXNq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 19:13:46 -0400
Received: from peff.net ([208.65.91.99]:4371 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbYHXXNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 19:13:46 -0400
Received: (qmail 14964 invoked by uid 111); 24 Aug 2008 23:13:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 19:13:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 19:13:43 -0400
Content-Disposition: inline
In-Reply-To: <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93574>

On Sun, Aug 24, 2008 at 03:59:49PM -0700, Junio C Hamano wrote:

> > Couldn't the exact opposite argument be made for "suppose you want to
> > put the mail-alias file in a repo-specific directory that was not
> > tracked?" I.e., you are trading off "CONTRIBUTORS" against
> > ".git/CONTRIBUTORS".
> 
> No, I couldn't ;-)
> 
> Why would you write what you wrote in README?
> 
> Anything you store in .git is not propagated, so the instruction would not
> likely to be "store it in .git/CONTRIBUTORS and point at it".  There is no
> merit in forcing users to standardize on "in .git".  The instruction would
> be to "store it anywhere you want, and point at it".

Ah, right.

I still think there is a little bit of convenience when you are doing
something totally personal (i.e., not putting it in a README, but rather
just wanting to store the referenced file in .git for the sake of
simplicity). But in that case, it is only slightly less convenient to
just point to the full path. So your example trumps this, since you have
no sane way of knowing the full path in README instructions.

> Because we haven't deprecated core.worktree (or $GIT_WORK_TREE) yet, your
> suggestion has an obvious chicken-and-egg problem, even though otherwise I
> think it makes perfect sense and very much like it.

You might be able to get around that by lazily filling in the variable.
IOW, expand it at the point-of-use rather than while reading the config.
However, the point of use might easily have something to do with reading
config, so that re-creates the cycle.

In general, I think we treat config as order-independent. We could make
the use of such variables order-dependent (i.e., if you haven't set
core.worktree, then we give you the value without having set it, and we
recalculate later. Confusing results, but at least a simple rule to
understand).

I think there actually are a few other order-dependent things in the
config, like the order of multi-value keys like push and fetch refspecs.

Would you want this expansion only for specially marked variables, or
for all variables? I like the concept of general templates for config
values, but it will backwards compatibility, especially for alias.*.

> Perhaps we should rid of the worktree that is separate and floats
> unrelated to where $GIT_DIR is.

I assumed people were actually using it, which is why it was
implemented.

-Peff
