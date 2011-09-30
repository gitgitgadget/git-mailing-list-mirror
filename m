From: Jeff King <peff@peff.net>
Subject: Re: RFC: reverse bisect
Date: Fri, 30 Sep 2011 00:09:24 -0400
Message-ID: <20110930040924.GA28724@sigill.intra.peff.net>
References: <20110929142027.GA4936@zelva.suse.cz>
 <4E849C5B.7050201@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 06:09:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9UPk-0001RR-27
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 06:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab1I3EJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 00:09:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48848
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1I3EJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 00:09:26 -0400
Received: (qmail 29514 invoked by uid 107); 30 Sep 2011 04:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 00:14:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 00:09:24 -0400
Content-Disposition: inline
In-Reply-To: <4E849C5B.7050201@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182464>

On Thu, Sep 29, 2011 at 06:27:07PM +0200, Johannes Sixt wrote:

> > git bisect good/bad/skip/run
> 
> Last time this came up on the list I suggested to add the following
> commands:
> 
>    git bisect regression  # a synonym for git bisect start
>    git bisect improvement # your --reverse

That makes some sense to me. But I do wonder if you could simply get rid
of the connotations of "good" and "bad" entirely, by thinking of it as
simply looking for a commit that introduced some property. Like:

  # find a bug
  git bisect start
  git bisect yes ;# has the bug
  git bisect no ;# does not have the bug
  git bisect skip ;# no idea

  # find a feature being implemented
  git bisect start
  git bisect yes ;# has the feature
  git bisect no ;# does not have the feature
  git bisect skip ;# no idea

IOW, I feel like we are having to handle this weird negation only
because we have assigned a value judgement to the tests. That instead of
saying "yes, we have this bug", we say "bad", which only makes sense if
you are looking for a bad thing.

You can still produce a negation in your mind, of course, by asking
"when did this property go away".  But that is usually about a bug being
fixed, so the right answer is generally not a set of command line
options, but to stop asking "when did bug X go away", and instead ask
"when did the fix for bug X appear".

One catch is that the run command assumes a successful exit is "good",
and anything else is "bad". Which makes:

  git bisect run make test

good for finding regressions, but is a little counterintuitive for the
yes/no thing (a successful exit means "no").

-Peff
