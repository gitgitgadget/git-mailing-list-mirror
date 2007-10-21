From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git-format-patch: Don't number patches when there's only one
Date: Sun, 21 Oct 2007 10:13:07 +0200
Message-ID: <20071021144637.762085BB92@nox.op5.se>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 09:55:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijs8L-0002y5-44
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbXJVHzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbXJVHzS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:55:18 -0400
Received: from static-213.88.215.14.addr.se.sn.net ([213.88.215.14]:50472 "EHLO
	nox.op5.se" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbXJVHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:55:17 -0400
X-Greylist: delayed 4198 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2007 03:55:16 EDT
Received: by nox.op5.se (Postfix, from userid 500)
	id 762085BB92; Sun, 21 Oct 2007 16:46:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61966>

[PATCH 1/1] looks a bit silly, and automagically handling
this in git-format-patch makes some scripting around it a
lot more pleasant.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/git-format-patch.txt |    3 ++-
 builtin-log.c                      |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c9857a2..9f16951 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -56,7 +56,8 @@ If -o is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
 If -n is specified, instead of "[PATCH] Subject", the first line
-is formatted as "[PATCH n/m] Subject".
+is formatted as "[PATCH n/m] Subject" if the revision range to
+format contains more than one commit.
 
 If given --thread, git-format-patch will generate In-Reply-To and
 References headers to make the second and subsequent patch mails appear
diff --git a/builtin-log.c b/builtin-log.c
index e8b982d..5c48f4d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -642,6 +642,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list[nr - 1] = commit;
 	}
 	total = nr;
+
+	/* don't number patches when there's only one */
+	if (total == 1)
+		numbered = 0;
 	if (numbered)
 		rev.total = total + start_number - 1;
 	rev.add_signoff = add_signoff;
-- 
1.5.3.4.1273.g725c19
