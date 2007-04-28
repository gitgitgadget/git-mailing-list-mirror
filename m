From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/5] Call send-pack with --remote option
Date: Sat, 28 Apr 2007 13:05:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704281304430.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhqNP-0001U8-PK
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbXD1RFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbXD1RFl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:05:41 -0400
Received: from iabervon.org ([66.92.72.58]:4839 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161876AbXD1RFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:05:23 -0400
Received: (qmail 7657 invoked by uid 1000); 28 Apr 2007 17:05:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2007 17:05:22 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45786>

When calling send-pack from git-push, use the --remote option when
appropriate.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-push.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 2e944cd..d4734be 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -158,7 +158,7 @@ static int do_push(const char *repo)
 		refspec = remote->push_refspec;
 	}
 
-	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
 	argv[0] = "dummy-send-pack";
 	argc = 1;
 	if (all)
@@ -180,8 +180,13 @@ static int do_push(const char *repo)
 		if (!prefixcmp(dest, "http://") ||
 		    !prefixcmp(dest, "https://"))
 			sender = "http-push";
-		else if (thin)
-			argv[dest_argc++] = "--thin";
+		else {
+			char *rem = xmalloc(strlen(remote->name) + 10);
+			sprintf(rem, "--remote=%s", remote->name);
+			argv[dest_argc++] = rem;
+			if (thin)
+				argv[dest_argc++] = "--thin";
+		}
 		argv[0] = sender;
 		argv[dest_argc++] = dest;
 		while (dest_refspec_nr--)
-- 
1.5.1.2.255.g6ead4-dirty
