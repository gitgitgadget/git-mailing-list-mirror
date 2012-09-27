From: Jeff King <peff@peff.net>
Subject: Re: Showing all stashed changes in one go
Date: Thu, 27 Sep 2012 16:22:25 -0400
Message-ID: <20120927202225.GB11772@sigill.intra.peff.net>
References: <20120927200006.GD6493@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:22:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THKbV-0002y8-8C
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 22:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2I0UW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 16:22:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33121 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2I0UW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 16:22:27 -0400
Received: (qmail 5686 invoked by uid 107); 27 Sep 2012 20:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 16:22:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 16:22:25 -0400
Content-Disposition: inline
In-Reply-To: <20120927200006.GD6493@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206518>

On Thu, Sep 27, 2012 at 10:00:06PM +0200, Yann Dirson wrote:

> When I have a couple of stashed changes, it gets annoying to
> repeatedly call "git stash show -p stash@{N}" until finding the
> correct one.
> 
> Since "git reflog show stash" already does part of the job, I thought
> that adding "-p" there to see the patch would help (at least it would
> show the not-yet-staged parts, which would already be a good start).
> 
> But the output is then really strange: does it really print the delta
> between every two reflog entries ?  I can't think of a situation where
> it would be was we want - but then, my imagination is known to be
> deficient when I hit a situation that does not do what I was expecting
> at first :)

This is a known issue. The reflog walker rewrites the parents of each
commit to make them look like a chain, but it means that your diffs are
between reflog entries, not to the true parents.

> Is there another way I missed to get all those stash contents listed,
> besides scriptically iterating ?

You can do:

  git rev-list -g <ref> | git log --stdin --no-walk <other options>

to show the individual commits with their true parents. But note that
stash commits are a little confusing (they are merges representing the
index and working tree state).

-Peff
