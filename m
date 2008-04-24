From: Jeff King <peff@peff.net>
Subject: Re: git-gc doesn't clean up leftover objects after
	git-filter-branch unless you clone first
Date: Wed, 23 Apr 2008 21:28:36 -0400
Message-ID: <20080424012836.GA30812@sigill.intra.peff.net>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com> <7vve28sdys.fsf@gitster.siamese.dyndns.org> <20080423221316.GE30057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:29:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoqH3-000069-Qk
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbYDXB2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 21:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYDXB2f
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:28:35 -0400
Received: from peff.net ([208.65.91.99]:3714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbYDXB2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 21:28:34 -0400
Received: (qmail 11741 invoked by uid 111); 24 Apr 2008 01:28:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 21:28:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 21:28:36 -0400
Content-Disposition: inline
In-Reply-To: <20080423221316.GE30057@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80281>

On Wed, Apr 23, 2008 at 06:13:16PM -0400, Jeff King wrote:

> > - Teach people that leftover cruft is nothing to worry about.
> 
> But it _is_ something to worry about in some particular situations. For
> run-of-the-mill rebasing, sure, ignore it. But this question usually
> comes up because the user did something like:

OK, maybe I am wrong. Within a few hours of me posting this, somebody
starts a new thread with a toy example wondering why git-gc didn't clean
up an --amended commit.

I don't know the best way to teach people about this (short of using a
big stick, of course), but maybe something like this would help a
little:

-- >8 --
doc/git-gc: add a note about what is collected

It seems to be a FAQ that people try running git-gc, and
then get puzzled about why the size of their .git directory
didn't change. This note mentions the reasons why things
might unexpectedly get kept.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-gc.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index d424a4e..9a4b62e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -104,6 +104,21 @@ The optional configuration variable 'gc.pruneExpire' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
+
+Notes
+-----
+
+git-gc tries very hard to be safe about the garbage it collects. In
+particular, it will keep not only objects referenced by your current set
+of branches and tags, but also objects referenced by the index, remote
+tracking branches, refs saved by linkgit:git-filter-branch[1] in
+refs/original/, or reflogs (which may references commits in branches
+that were later amended or rewound).
+
+If you are expecting some objects to be collected and it isn't, check
+all of those locations and decide whether it makes sense in your case to
+remove those references.
+
 See Also
 --------
 linkgit:git-prune[1]
-- 
1.5.5.1.143.ge2bb9
