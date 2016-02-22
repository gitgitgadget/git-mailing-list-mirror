From: Jeff King <peff@peff.net>
Subject: Re: Question about pull-requests
Date: Mon, 22 Feb 2016 16:37:02 -0500
Message-ID: <20160222213702.GD15595@sigill.intra.peff.net>
References: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nagaraj Mandya <nmandya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyAL-0001D5-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbcBVVhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:37:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:46961 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754742AbcBVVhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:37:06 -0500
Received: (qmail 18481 invoked by uid 102); 22 Feb 2016 21:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:37:05 -0500
Received: (qmail 22276 invoked by uid 107); 22 Feb 2016 21:37:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:37:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 16:37:02 -0500
Content-Disposition: inline
In-Reply-To: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286954>

On Mon, Feb 22, 2016 at 05:24:15PM +0530, Nagaraj Mandya wrote:

>   In our GIT repository, all users are restricted from merging to
> master without a pull request. This works well and all developers are
> raising pull requests and merging. However, if there is a merge
> conflict during the merge, we have a problem.
> 
>   We follow the instructions provided by Bitbucket and the final step
> is to push the merged code to master to the "origin" repository.
> However, that steps always fails with the error that pushes can only
> be made with pull requests.
> 
>   How do we work around this problem? We want all pushes to happen
> through merge requests but still allow pull requests with merge
> conflicts to get pushed. Thanks.

The strategy we use at GitHub (for our internal work, I mean, but which
we also recommend to other projects on the site) is to back-merge master
to the pull request branch and resolve the conflicts there. Then you can
push that, and the merge of that result to master will always be trivial
(unless somebody updated master in the meantime, of course).

In fact, we use the "protected branches" feature[1] to disallow any
non-fast-forward merges of a pull request into the master branch. We do
our CI tests on the tip commit of each pull request, and they also must
pass to allow merging. So you would not want to do any real merging to
bring the PR into master; the merge result hasn't actually been tested!

I don't know offhand whether BitBucket has a similar feature to
protected branches, but certainly you can do use the back-merge-and-push
trick.

-Peff

[1] https://github.com/blog/2051-protected-branches-and-required-status-checks
