From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Sat, 15 Aug 2009 02:51:26 -0400
Message-ID: <20090815065125.GA23068@coredump.intra.peff.net>
References: <200908101136.34660.trast@student.ethz.ch>
 <cover.1250164190.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 15 08:54:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McD9t-0007u7-8W
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 08:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbZHOGv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 02:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZHOGv3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 02:51:29 -0400
Received: from peff.net ([208.65.91.99]:35052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbZHOGv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 02:51:28 -0400
Received: (qmail 17836 invoked by uid 107); 15 Aug 2009 06:51:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 15 Aug 2009 02:51:31 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Aug 2009 02:51:26 -0400
Content-Disposition: inline
In-Reply-To: <cover.1250164190.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125981>

On Thu, Aug 13, 2009 at 02:29:38PM +0200, Thomas Rast wrote:

> Those marked (**) are the only ones that changed semantics compared to
> v4.  However, I adjusted the messages to look different:

Thanks for following up on this. This is something I've wanted for a
while, and now my procrastination is paying off. ;)

> add -p			Stage this hunk?

Makes sense.

> reset -p [HEAD]		Reset this hunk? (**)

Actually, it says "Unstage this hunk", but I like that even better.

> reset -p other		Apply this hunk to index? (**)

This doesn't make sense to me. For example:

  $ git show HEAD^:file
  content
  $ git show :file
  content
  with some changes
  $ git reset -p HEAD^
  diff --git a/file b/file
  index d95f3ad..60a1a4e 100644
  --- a/file
  +++ b/file
  @@ -1 +1,2 @@
   content
  +with some changes
  Apply this hunk to index [y,n,q,a,d,/,e,?]?

The hunk is _already_ in the index. You are really asking to remove it
from the index. So shouldn't it say something like "Unstage this hunk"
or "Remove this hunk from the index"?

Or did you intend to reverse the diff, as with "checkout -p" below?

> checkout -p		Discard this hunk from worktree? (**)

Good, that addresses my earlier confusion.

> checkout -p HEAD	Discard this hunk from index and worktree? (**)

Good. I like how it clarifies what is being touched.

> checkout -p other	Apply this hunk to index and worktree? (**)

I really expected this to just be the same as the "HEAD" case. That is,
with "git checkout -p HEAD", you are saying "I'm not interested in these
bits, discard to return back to HEAD". So if I do "git checkout -p
HEAD^", that is conceptually the same thing, except going back further
in time.

But I guess you are thinking of it as "pull these changes out of
'other'", in which case showing the reverse diff makes sense.

I think this may be a situation where the user has one of two mental
models in issuing the command, and we don't necessarily know which. So I
guess what you have is fine, but I wanted to register my surprise.

> stash -p		Stash this hunk?

Getting greedy, is there a reason not to have "stash apply -p" as well?

-Peff
