From: Jeff King <peff@peff.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Fri, 2 Sep 2011 12:25:24 -0400
Message-ID: <20110902162524.GC19690@sigill.intra.peff.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
 <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 18:25:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzWYf-00020u-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 18:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab1IBQZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 12:25:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41177
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941Ab1IBQZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 12:25:26 -0400
Received: (qmail 32269 invoked by uid 107); 2 Sep 2011 16:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 12:26:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 12:25:24 -0400
Content-Disposition: inline
In-Reply-To: <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180620>

On Fri, Sep 02, 2011 at 09:14:15AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] My idea of "limited" would be an allow-known-good list of harmless
> > config keys which we would respect when they came from the remote, with
> > the option for the user to whitelist or blacklist more keys if they
> > wanted.
> 
> It coincides with my idea too, but it might be a very limited set. For
> example, there may be a good "suggested by upstream" default for LHS of
> fetch refspecs (e.g. somebody may have 47 topics published but majority of
> people are expected to follow only his "master" branch), but it is up to
> the user of that suggestion what the RHS would be.

Yeah. That leads to synthesizing local keys based on what remote keys
say. Which is pretty straightforward if you are just fetching the
remote's config during clone, and then copying or creating local keys
based on that in your own .git/config (e.g., by creating full refspecs
with upstream's idea of the LHS, and our idea of the RHS).

But it becomes hard to keep your local config in sync with updates on
the remote end. When the remote now adds "next" to the list of
interesting branches, by what mechanism do you fix up your local config?
Certainly we wouldn't want to rewrite the local config without
consulting the user, because they may have reviewed or modified it since
it was created.

One possible solution is that the local config could dynamically depend
on the remote config. E.g., the fetch refspec has something like a
wildcard that matches only the branches that the remote provides to us
via some "interesting branches" config key. Then it's OK for git to
update the "interesting branches" key from the remote. Either the user
is OK with respecting that (because they have left the wildcard in
place), or not (because they have changed the refspec not to use that
wildcard).

I do worry that could quickly get complex, and people would start
wanting a Turing-complete config language. :)

-Peff
