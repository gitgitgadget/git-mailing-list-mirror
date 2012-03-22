From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] drop casts from users EMPTY_TREE_SHA1_BIN
Date: Thu, 22 Mar 2012 14:53:24 -0400
Message-ID: <20120322185324.GA32727@sigill.intra.peff.net>
References: <20120322185246.GA27037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn8i-0008EO-GA
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759186Ab2CVSx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:53:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56828
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757160Ab2CVSx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:53:26 -0400
Received: (qmail 3862 invoked by uid 107); 22 Mar 2012 18:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:53:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 14:53:24 -0400
Content-Disposition: inline
In-Reply-To: <20120322185246.GA27037@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193684>

This macro already evaluates to the correct type, as it
casts the string literal to "unsigned char *" itself
(and callers who want the literal can use the _LITERAL
form).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c    |    2 +-
 merge-recursive.c |    2 +-
 sequencer.c       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 424c815..9069dc4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -327,7 +327,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr) {
 					struct tree *tree;
-					tree = lookup_tree((const unsigned char*)EMPTY_TREE_SHA1_BIN);
+					tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
 					add_pending_object(&rev, &tree->object, "HEAD");
 				}
 				break;
diff --git a/merge-recursive.c b/merge-recursive.c
index 6479a60..318d32e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1914,7 +1914,7 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
+		tree = lookup_tree(EMPTY_TREE_SHA1_BIN);
 		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
 	}
 
diff --git a/sequencer.c b/sequencer.c
index a37846a..4307364 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -164,7 +164,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 
 static struct tree *empty_tree(void)
 {
-	return lookup_tree((const unsigned char *)EMPTY_TREE_SHA1_BIN);
+	return lookup_tree(EMPTY_TREE_SHA1_BIN);
 }
 
 static int error_dirty_index(struct replay_opts *opts)
-- 
1.7.10.rc0.9.gdcbe9
