From: Jeff King <peff@peff.net>
Subject: Re: Odd rev-list behaviour
Date: Thu, 23 Apr 2015 21:52:34 -0400
Message-ID: <20150424015234.GA2001@peff.net>
References: <CAPR6cbD5uFoCDg73wqSQEPOuUEjsy6963QQsePwofxVTuBW8Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: B M Corser <bmcorser@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 03:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlSnL-0007XJ-52
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 03:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbbDXBwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 21:52:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:49473 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753102AbbDXBwh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 21:52:37 -0400
Received: (qmail 17504 invoked by uid 102); 24 Apr 2015 01:52:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 20:52:37 -0500
Received: (qmail 10723 invoked by uid 107); 24 Apr 2015 01:53:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Apr 2015 21:53:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Apr 2015 21:52:34 -0400
Content-Disposition: inline
In-Reply-To: <CAPR6cbD5uFoCDg73wqSQEPOuUEjsy6963QQsePwofxVTuBW8Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267719>

On Fri, Apr 24, 2015 at 12:48:43AM +0100, B M Corser wrote:

> Seeing some weird results out of rev-list, see my demo repo:
> https://github.com/bmcorser/rev-list-fail

That repo has a whole bunch of commits with identical committer
timestamps. The default order that git displays those in is going to
depend on the order you provide them in.

> I was after a one-liner to sort a bunch of commit hashes into
> topological (or date) order. The commits were made by a script that
> forges the commit time with --date in the hope of seeing stable
> results.

Using "--date" will just set the author date. You probably want to set
GIT_COMMITTER_DATE in the environment if you are scripting imported
commits from somewhere else (or better yet, consider using
git-fast-import if you have a lot of commits).

Even with identical commit timestamps, we should be able to show the
commits in topo-order. Your README.md shows you trying:

  git rev-list --no-walk $(git log --format=%H | shuf)

That is missing any mention of --topo-order, of course. But even adding
that in, it does not seem to work, which is perhaps what you are getting
at. I am not sure whether "--no-walk" plays well with other sorting
options, and that may be the problem.

Is there a reason that just:

  git rev-list --topo-order HEAD

does not serve your purpose? It's hard to tell what you're trying to
achieve from this obviously toy repository.

In the meantime, you can also pipe the output of "rev-list" into your
own sort routine, using --format to get whatever information you need
(you can topo-sort with the information from --parents).

-Peff
