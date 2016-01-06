From: Jeff King <peff@peff.net>
Subject: Re: Advice regarding inherited git repository
Date: Wed, 6 Jan 2016 03:20:22 -0500
Message-ID: <20160106082022.GA19117@sigill.intra.peff.net>
References: <loom.20160105T183516-607@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Danielle <dsavir.h@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGjKb-0001Kz-VT
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 09:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbcAFIU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 03:20:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:49344 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752199AbcAFIUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 03:20:25 -0500
Received: (qmail 26017 invoked by uid 102); 6 Jan 2016 08:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 03:20:25 -0500
Received: (qmail 25248 invoked by uid 107); 6 Jan 2016 08:20:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 03:20:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2016 03:20:22 -0500
Content-Disposition: inline
In-Reply-To: <loom.20160105T183516-607@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283420>

On Tue, Jan 05, 2016 at 05:42:15PM +0000, Danielle wrote:

> I inherited a web site and a git repository. the git repository is cloned 
> to the website and a sandbox website (two clones). No commits have been 
> done in more than 6 months. The main site has been updated a lot of times, 
> the sandbox has lots of test and exploratory code. To bring things up to 
> date, I thought of staging and committing all the files in the main site 
> and pushing to the remote repository, and then fetching into the sandbox 
> clone and merging what is needed (which will be sooo not trivial). Does 
> this make sense? Or would it be better to create a sandbox branch somehow? 
> I'm used to working with SVN, no real git experience, so I would 
> appreciate any advice on how to manage this.

You probably should create a sandbox branch, for your own sanity.
Because git is distributed, each separate repository is implicitly a
branch. So if you did something like:

  1. Commit all the changes on the main site to "master". Push the
     result to some common remote.

  2. Commit all the changes in the sandbox to its "master". Do _not_
     push to the remote.

  3. Pull the changes from the remote into the sandbox. If they're worth
     adding to the main site, push them up. If not, leave them there.

That works; "master" in the sandbox has the experimental changes, but
you don't have to push them anywhere.  However, you are one accidental
"git push" away from sending all of those experimental features to your
remote "master". So it's easy enough to make step 1.5 "git checkout -b
sandbox-cruft" in the sandbox repository, so git knows not to ever push
it to "master".

In general, I'd also say you may benefit from splitting the changes in
each repository into as many separate logical commits as you can (and
possibly even to separate topic branches that you can merge
independently). Given that you inherited this, that's _probably_ too
much work. But if you do want to try it, I recommend "git add -p" for
picking out individual hunks.

-Peff
