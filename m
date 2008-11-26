From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] xdiff-interface.c: remove 10 duplicated lines
Date: Wed, 26 Nov 2008 14:27:10 +0100
Message-ID: <87vduazkgh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5KRR-00043x-1K
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYKZN1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 08:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYKZN1N
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:27:13 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44522 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbYKZN1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:27:12 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id F3F7E17B557
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 14:27:10 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A541117B5A9
	for <git@vger.kernel.org>; Wed, 26 Nov 2008 14:27:10 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 5B3B94EFD4; Wed, 26 Nov 2008 14:27:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101733>


Remove an accidentally duplicated sequence of 10 lines.
This happens to plug a leak, too.

---
This is relative to the tip of "next".

 xdiff-interface.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index e8ef46d..d782f06 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -247,30 +247,20 @@ static long ff_regexp(const char *line, long len,
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
 		if (len > 1 && line[len-2] == '\r')
 			len -= 2;
 		else
 			len--;
 	}

 	line_buffer = xstrndup(line, len); /* make NUL terminated */

-	/* Exclude terminating newline (and cr) from matching */
-	if (len > 0 && line[len-1] == '\n') {
-		if (len > 1 && line[len-2] == '\r')
-			len -= 2;
-		else
-			len--;
-	}
-
-	line_buffer = xstrndup(line, len); /* make NUL terminated */
-
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
 		if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
 			if (reg->negate)
 				goto fail;
 			break;
 		}
 	}
 	if (regs->nr <= i)
 		goto fail;
@@ -331,11 +321,10 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			git_xmerge_style = XDL_MERGE_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		else
 			die("unknown style '%s' given for '%s'",
 			    value, var);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
 }
-
--
1.6.0.4.1044.g77718
