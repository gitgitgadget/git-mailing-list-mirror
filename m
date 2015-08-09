From: Jeff King <peff@peff.net>
Subject: Re: Fetch and refs/remotes/<refname>/HEAD
Date: Sun, 9 Aug 2015 19:23:31 -0400
Message-ID: <20150809232330.GA25769@sigill.intra.peff.net>
References: <loom.20150803T151815-131@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dror Livne <dror.livne@mobileye.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 01:23:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOZwW-0002H8-78
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 01:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbbHIXXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 19:23:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:42727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbbHIXXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 19:23:36 -0400
Received: (qmail 22975 invoked by uid 102); 9 Aug 2015 23:23:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Aug 2015 18:23:35 -0500
Received: (qmail 32637 invoked by uid 107); 9 Aug 2015 23:23:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Aug 2015 19:23:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2015 19:23:31 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150803T151815-131@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275557>

On Mon, Aug 03, 2015 at 01:28:05PM +0000, Dror Livne wrote:

> I have noticed that when cloning a repository, I get a
> refs/remotes/origin/HEAD symbolic ref.
> 
> On the other hand, when fetching a new remote, the remote HEAD is not set by
> git-fetch (but can be added later by `git remote set-head ...')
> 
> I was under the impression that clone is equivalent to (at least) init+fetch.
> 
> Is there a rationale for that difference in behavior?

I have been annoyed by this in the past, too. There's no real reason,
except that setting up the symref is outside the scope of "fetch".
Fetching is just about updating refs, and we explicitly do not want
subsequent fetches to overwrite any changes you might make to
refs/remotes/.../HEAD.

Setting up the remote HEAD symref more rightly belongs to "git remote
add", but that program does not otherwise talk to the remote. And that's
why we end up with the separate set-head step.  It might make sense for
"git remote add -f" to automatically run "set-head", since it is
contacting the remote server already. And then:

  git init
  git remote add -f origin ...

would be similar to "git clone".

-Peff
