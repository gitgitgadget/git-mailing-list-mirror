From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Update mode-change strings in diff output.
Date: Fri, 13 May 2005 18:40:14 -0700
Message-ID: <7vhdh660w1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 03:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWley-0000nH-Uo
	for gcvg-git@gmane.org; Sat, 14 May 2005 03:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVENBlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 21:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVENBlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 21:41:09 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8159 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262669AbVENBkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 21:40:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514014016.IULN16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 21:40:16 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This updates the mode change strings to be a bit more machine
friendly.  Although this might go against the spirit of
readability for human consumption, these mode bits strings are
shown only when unusual things (mode change, file creation and
deletion) happens, output normalized for machine consumption
would be permissible.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   22 ++++++++++++----------
1 files changed, 12 insertions(+), 10 deletions(-)

--- a/diff.c
+++ b/diff.c
@@ -83,6 +83,7 @@
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
+	const char *git_prefix = "# mode: ";
 	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
@@ -123,17 +124,18 @@
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
 	if (!path1[0][0])
-		printf("Created: %s (mode:%s)\n", name, temp[1].mode);
+		printf("%s. %s %s\n", git_prefix, temp[1].mode, name);
 	else if (!path1[1][0])
-		printf("Deleted: %s\n", name);
-	else if (strcmp(temp[0].mode, temp[1].mode)) {
-		printf("Mode changed: %s (%s->%s)\n", name,
-		       temp[0].mode, temp[1].mode);
-		/* Be careful.  We do not want to diff between
-		 * symlink and a file.
-		 */
-		if (strncmp(temp[0].mode, "120", 3) !=
-		    strncmp(temp[1].mode, "120", 3))
+		printf("%s%s . %s\n", git_prefix, temp[0].mode, name);
+	else {
+		if (strcmp(temp[0].mode, temp[1].mode))
+			printf("%s%s %s %s\n", git_prefix,
+			       temp[0].mode, temp[1].mode, name);
+
+		if (strncmp(temp[0].mode, temp[1].mode, 3))
+			/* we do not run diff between different kind
+			 * of objects.
+			 */
 			exit(0);
 	}
 	fflush(NULL);

