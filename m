From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] cherry-pick: refactor commit parsing code
Date: Thu, 11 Feb 2010 16:06:43 -0500
Message-ID: <20100211210642.GB9066@coredump.intra.peff.net>
References: <20100211210445.GA8819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgFL-0005RY-3y
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab0BKVGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:06:41 -0500
Received: from peff.net ([208.65.91.99]:51472 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757074Ab0BKVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:06:40 -0500
Received: (qmail 22027 invoked by uid 107); 11 Feb 2010 21:06:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:06:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:06:43 -0500
Content-Disposition: inline
In-Reply-To: <20100211210445.GA8819@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139626>

These lines are really just lookup_commit_reference
re-implemented.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this changes the exact text of the error messages, but I doubt
anybody cares too much.

 builtin-revert.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 83e5c0a..012c646 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -68,15 +68,9 @@ static void parse_args(int argc, const char **argv)
 
 	if (get_sha1(arg, sha1))
 		die ("Cannot find '%s'", arg);
-	commit = (struct commit *)parse_object(sha1);
+	commit = lookup_commit_reference(sha1);
 	if (!commit)
-		die ("Could not find %s", sha1_to_hex(sha1));
-	if (commit->object.type == OBJ_TAG) {
-		commit = (struct commit *)
-			deref_tag((struct object *)commit, arg, strlen(arg));
-	}
-	if (commit->object.type != OBJ_COMMIT)
-		die ("'%s' does not point to a commit", arg);
+		exit(1);
 }
 
 static char *get_oneline(const char *message)
-- 
1.7.0.rc2.40.g33ed2.dirty
