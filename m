From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: [PATCH] Make commit help text more accurate for --verbose
Date: Sun, 5 Sep 2010 19:53:03 +1000
Message-ID: <1283680383-12495-1-git-send-email-ramana.kumar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramana Kumar <ramana.kumar@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 05 12:04:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsC54-0005t3-2i
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 12:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0IEKDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 06:03:55 -0400
Received: from atp-es2.it.nicta.com.au ([203.143.174.70]:42896 "EHLO
	atp-es2.it.nicta.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0IEKDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 06:03:54 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2010 06:03:54 EDT
Received: from atp-mbx1.it.nicta.com.au ([221.199.216.123] helo=atp-mbx1.in.nicta.com.au)
	by atp-es2.it.nicta.com.au with esmtp (Exim 4.69)
	(envelope-from <ramana.kumar@gmail.com>)
	id 1OsBvZ-00005Z-N9; Sun, 05 Sep 2010 19:54:39 +1000
Received: from localhost (221.199.216.124) by atp-mbx1.in.nicta.com.au
 (221.199.216.123) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 5 Sep
 2010 19:53:30 +1000
X-Mailer: git-send-email 1.7.2.2
X-TM-AS-Product-Ver: SMEX-8.0.0.4125-6.500.1024-17616.006
X-TM-AS-Result: No--4.748000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-SA-Exim-Connect-IP: 221.199.216.123
X-SA-Exim-Mail-From: ramana.kumar@gmail.com
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	atp-es2.it.nicta.com.au
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:20:07 +0000)
X-SA-Exim-Scanned: Yes (on atp-es2.it.nicta.com.au)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155450>

Commit message help text says lines starting with '#' will be ignored.
The diff lines added by --verbose are also ignored, although they don't
start with '#'s. Extend help text to describe behavior on diff lines
when relevant.

Signed-off-by: Ramana Kumar <ramana.kumar@gmail.com>
---
 builtin/commit.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..b49fd7a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -658,17 +658,28 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		fprintf(fp,
 			"\n"
 			"# Please enter the commit message for your changes.");
-		if (cleanup_mode == CLEANUP_ALL)
+		if (cleanup_mode == CLEANUP_ALL && !verbose)
 			fprintf(fp,
 				" Lines starting\n"
 				"# with '#' will be ignored, and an empty"
 				" message aborts the commit.\n");
-		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp,
-				" Lines starting\n"
-				"# with '#' will be kept; you may remove them"
-				" yourself if you want to.\n"
-				"# An empty message aborts the commit.\n");
+    else {
+      if (cleanup_mode == CLEANUP_ALL)
+        fprintf(fp,
+          " Lines starting\n"
+          "# with '#' will be ignored, as will"
+          " the diff and anything below it.\n");
+      else { /* CLEANUP_SPACE, that is. */
+        fprintf(fp,
+          " Lines starting\n"
+          "# with '#' will be kept; you may remove them"
+          " yourself if you want to.\n");
+        if (verbose)
+          fprintf(fp,
+            "# The diff and anything below it will be ignored.\n");
+      }
+      fprintf(fp, "# An empty message aborts the commit.\n");
+    }
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
 
-- 
1.7.2.2
