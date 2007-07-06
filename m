From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Prefer EMAIL to username@hostname.
Date: Thu,  5 Jul 2007 17:29:41 -0700
Message-ID: <11836817811266-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 02:29:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6bhk-00048U-St
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 02:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758302AbXGFA3q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 20:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757929AbXGFA3q
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 20:29:46 -0400
Received: from neon.ftbfs.org ([83.168.236.214]:57295 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580AbXGFA3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 20:29:46 -0400
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=asturias.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6bqO-0005QS-P2; Thu, 05 Jul 2007 17:38:45 -0700
Received: from kraai by asturias.ftbfs.org with local (Exim 4.67)
	(envelope-from <kraai@ftbfs.org>)
	id 1I6bhd-0006UF-BK; Thu, 05 Jul 2007 17:29:41 -0700
X-Mailer: git-send-email 1.5.2.3
X-Spam-Score: -3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51707>

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 ident.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/ident.c b/ident.c
index 3d49608..6612d17 100644
--- a/ident.c
+++ b/ident.c
@@ -83,11 +83,18 @@ static void setup_ident(void)
 	}
 
 	if (!git_default_email[0]) {
-		if (!pw)
-			pw = getpwuid(getuid());
-		if (!pw)
-			die("You don't exist. Go away!");
-		copy_email(pw);
+		const char *email = getenv("EMAIL");
+
+		if (email && email[0])
+			strlcpy(git_default_email, email,
+				sizeof(git_default_email));
+		else {
+			if (!pw)
+				pw = getpwuid(getuid());
+			if (!pw)
+				die("You don't exist. Go away!");
+			copy_email(pw);
+		}
 	}
 
 	/* And set the default date */
@@ -197,8 +204,6 @@ const char *fmt_ident(const char *name, const char *email,
 		name = git_default_name;
 	if (!email)
 		email = git_default_email;
-	if (!email)
-		email = getenv("EMAIL");
 
 	if (!*name) {
 		struct passwd *pw;
-- 
1.5.2.3
