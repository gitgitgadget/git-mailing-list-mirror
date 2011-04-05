From: Jeff King <peff@github.com>
Subject: Re: [RFC/PATCH 2/2] stash: drop dirty worktree check on apply
Date: Tue, 5 Apr 2011 18:18:28 -0400
Message-ID: <20110405221827.GA4123@sigill.intra.peff.net>
References: <20110405212025.GA3579@sigill.intra.peff.net>
 <20110405212314.GA3613@sigill.intra.peff.net>
 <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brian Lopez <brian@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:18:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ea4-0003oo-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab1DEWSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:18:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40394
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329Ab1DEWSb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:18:31 -0400
Received: (qmail 29595 invoked by uid 107); 5 Apr 2011 22:19:17 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 18:19:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 18:18:28 -0400
Content-Disposition: inline
In-Reply-To: <7vvcysl5pz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170928>

On Tue, Apr 05, 2011 at 02:59:36PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, this check has two problems:
> >
> >   1. It is overly restrictive. If my stash changes only file
> >      "foo", but "bar" is dirty in the working tree, it will
> >      prevent us from applying the stash.
> >
> >   2. It is redundant. We don't touch the working tree at all
> >      until we actually call merge-recursive. But it has its
> >      own (much more accurate) checks to avoid losing working
> >      tree data, and will abort the merge with a nicer
> >      message telling us which paths were problems.
> 
> I _think_ the reason we originally insisted on clean working tree was that
> while merge-resolve has always had an acurate check, merge-recursive's
> check was not very good, especially when renames are involved.  So
> probably this part of your comment ...
> 
> > I'm not sure if the check was perhaps even required when git-stash was
> > written, and has simply since become useless as merge-recursive became
> > more careful.
> 
> ... may need to be used to rewrite bullet 2. above.

That makes sense to me. I'd be a lot more comfortable if I could find
the actual place where merge-recursive got more accurate. I'll see if
it's simple to bisect.

> This is a tangent, but I notice that the additional bolted-on codepath for
> the --index option has this:
> 
>     git diff-tree --binary $s^2^..$s^2 | git apply --cached
> 
> It might want to do -B -M to match what "git merge-recursive" does.

Yeah, that sounds sensible to me.

-Peff
