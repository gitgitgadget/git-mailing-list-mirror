Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625FD1F744
	for <e@80x24.org>; Tue, 12 Jul 2016 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbcGLAIr (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 20:08:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:43176 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751365AbcGLAIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 20:08:46 -0400
Received: (qmail 31377 invoked by uid 102); 12 Jul 2016 00:08:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 20:08:46 -0400
Received: (qmail 3316 invoked by uid 107); 12 Jul 2016 00:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 20:09:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 20:08:42 -0400
Date:	Mon, 11 Jul 2016 20:08:42 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] doc/pretty-formats: describe index/time formats for
 %gd
Message-ID: <20160712000841.GB26163@sigill.intra.peff.net>
References: <20160711050201.GA18031@sigill.intra.peff.net>
 <20160711050513.GC32514@sigill.intra.peff.net>
 <20160711164834.GC3890@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160711164834.GC3890@thunk.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 12:48:34PM -0400, Theodore Ts'o wrote:

> On Mon, Jul 11, 2016 at 01:05:13AM -0400, Jeff King wrote:
> > The "reflog selector" format changes based on a series of
> > heuristics, and that applies equally to both stock "log -g"
> > output, as well as "--format=%gd". The documentation for
> > "%gd" doesn't cover this. Let's mention the multiple formats
> > and refer the user back to the "-g" section for the complete
> > rules.
> 
> Is it worth mentioning that the shortening only happens if the user
> specifies a selector with '/' in it in the first place?  I was
> confused when I was first playing with these selectors because %gd and
> %gD are identical if you run
> 
> 	git reflog --format=%gd -3 master
> 	git reflog --format=%gD -3 master
> 
> and are only different if you run:
> 
> 	git reflog --format=%gd -3 refs/heads/master
> 	git reflog --format=%gD -3 refs/heads/master

Yeah, I noticed that "shortened" is not really defined when I was
writing this.

Maybe this on top of the other documentation patches?

-- >8 --
Subject: [PATCH] doc/pretty-formats: explain shortening of %gd

The actual shortening rules aren't that interesting and
probably not worth getting into (I gloss over them here as
"shortened for human readability"). But the fact that %gD
shows whatever you gave on the command line is subtle and
worth mentioning. Since most people will feed a shortened
refname in the first place, it otherwise makes it hard to
understand the difference between the two.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 36a300a..b95d67e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -149,9 +149,12 @@ endif::git-rev-list[]
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
   `refs/stash@{2 minutes ago`}; the format follows the rules described
-  for the `-g` option
-- '%gd': shortened reflog selector, e.g., `stash@{1}` or
-  `stash@{2 minutes ago}`
+  for the `-g` option. The portion before the `@` is the refname as
+  given on the command line (so `git log -g refs/heads/master` would
+  yield `refs/heads/master@{0}`).
+- '%gd': shortened reflog selector; same as `%gD`, but the refname
+  portion is shortened for human readability (so `refs/heads/master`
+  becomes just `master`).
 - '%gn': reflog identity name
 - '%gN': reflog identity name (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- 
2.9.0.406.g77f030d

