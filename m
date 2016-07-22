Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342AC20195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbcGVQfW (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:35:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:48694 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752104AbcGVQfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:35:21 -0400
Received: (qmail 13384 invoked by uid 102); 22 Jul 2016 16:35:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:35:21 -0400
Received: (qmail 7383 invoked by uid 107); 22 Jul 2016 16:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:35:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 12:35:19 -0400
Date:	Fri, 22 Jul 2016 12:35:19 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH v2 2/3] contrib/git-jump: add whitespace-checking mode
Message-ID: <20160722163518.GA14600@sigill.intra.peff.net>
References: <20160722162707.GA13905@sigill.intra.peff.net>
 <20160722162945.GB14080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722162945.GB14080@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:29:45PM -0400, Jeff King wrote:

> If you have whitespace errors in lines you've introduced, it
> can be convenient to be able to jump directly to them for
> fixing.  You can't quite use "git jump diff" for this,
> because though it passes arbitrary options to "git diff", it
> expects to see an actual unified diff in the output.
> 
> Whereas "git diff --check" actually produces lines that look
> like compiler quickfix lines already, meaning we just need
> to run it and feed the output directly to the editor.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/git-jump/git-jump | 6 ++++++
>  1 file changed, 6 insertions(+)

Whoops. I updated the README, too, but forgot to actually commit it.
Here's an updated patch.

-- >8 --
Subject: contrib/git-jump: add whitespace-checking mode

If you have whitespace errors in lines you've introduced, it
can be convenient to be able to jump directly to them for
fixing.  You can't quite use "git jump diff" for this,
because though it passes arbitrary options to "git diff", it
expects to see an actual unified diff in the output.

Whereas "git diff --check" actually produces lines that look
like compiler quickfix lines already, meaning we just need
to run it and feed the output directly to the editor.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/README   | 4 +++-
 contrib/git-jump/git-jump | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 1cebc32..3e0b65b 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -29,7 +29,7 @@ Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
 
-Git-jump can generate three types of interesting lists:
+Git-jump can generate four types of interesting lists:
 
   1. The beginning of any diff hunks.
 
@@ -37,6 +37,8 @@ Git-jump can generate three types of interesting lists:
 
   3. Any grep matches.
 
+  4. Any whitespace errors detected by `git diff --check`.
+
 
 Using git-jump
 --------------
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 1f1b996..427f206 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -12,6 +12,8 @@ diff: elements are diff hunks. Arguments are given to diff.
 merge: elements are merge conflicts. Arguments are ignored.
 
 grep: elements are grep hits. Arguments are given to grep.
+
+ws: elements are whitespace errors. Arguments are given to diff --check.
 EOF
 }
 
@@ -55,6 +57,10 @@ mode_grep() {
 	'
 }
 
+mode_ws() {
+	git diff --check "$@"
+}
+
 if test $# -lt 1; then
 	usage >&2
 	exit 1
-- 
2.9.2.506.g8452fe7

