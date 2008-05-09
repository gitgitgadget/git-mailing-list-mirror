From: Jeff King <peff@peff.net>
Subject: Re: git filter-branch --subdirectory-filter
Date: Thu, 8 May 2008 21:33:00 -0400
Message-ID: <20080509013300.GA7836@sigill.intra.peff.net>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Sadler <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 03:34:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuHUy-00084R-US
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 03:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYEIBdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 21:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355AbYEIBdB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 21:33:01 -0400
Received: from peff.net ([208.65.91.99]:2011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbYEIBc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 21:32:59 -0400
Received: (qmail 7858 invoked by uid 111); 9 May 2008 01:32:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 21:32:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 21:33:00 -0400
Content-Disposition: inline
In-Reply-To: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81583>

On Fri, May 09, 2008 at 11:01:47AM +1000, James Sadler wrote:

> I have a git repository that I wish to split into multiple seperate
> repositories for each logical module that it contains. Each logical
> module is already in its own directory at the root of the repo.

OK.

> To extract a module into its own repo, I first copied the original
> repo (this was a simple cp -r, as it seemed to be the simplest way as
> git clone doesn't get all the branches)

It does copy them, but they're just "remote tracking branches". If you
have many branches, you can recreate them via a loop with git-branch, or
by "git fetch . refs/remotes/origin/*:refs/heads/*". If you have only
one branch, you might just want to make a few copies of it with "for i
in repo1 repo2; do git branch $i master; done", and then filter-branch
those branches.

In either case, your cp is fine, if just a little less efficient.

> and ran filter-branch with a --commit-filter to skip commits that were
> irrelevant to th subdir.

But that's part of what subdirectory-filter does, so this step is
unnecessary.

> The next pass was to 'hoist' the contents of the subdir in the new
> repo into the root dir.

And that's the other part of what subdirectory-filter does.

> I thought I could do this with a --subdirectory-filter argument to
> filter-branch, except when I do this, I loose tons of commits.  (The
> working tree is correct, i.e. the same as the original repo working
> tree, but the history is screwed).

You'll have to be more specific about what's wrong with history. Of
course some commits will be gone after filtering the subdir (those that
didn't touch anything in the subdir); that's part of the point.

-Peff
