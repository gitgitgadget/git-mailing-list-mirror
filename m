From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Expose the has_non_ascii() function
Date: Mon, 10 Aug 2009 18:22:18 +0200 (CEST)
Message-ID: <7388ff3756d6a431fc9a640a4fa02a70d1e54106.1249921206u.git.johannes.schindelin@gmx.de>
References: <cover.1249921206u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 10 18:22:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXds-0005S5-0M
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbZHJQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbZHJQWU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:22:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:58941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755619AbZHJQWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:22:19 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:22:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 10 Aug 2009 18:22:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Odx9ZlkJOy63H2Ab6GgOz/mJQrpsQJmydrLYcnf
	L+UK5pqQyntAn0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1249921206u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125480>

This function is useful outside of log-tree.c, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.h   |    1 +
 log-tree.c |   12 ------------
 pretty.c   |   12 ++++++++++++
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/commit.h b/commit.h
index 8bfdf0e..d1674d7 100644
--- a/commit.h
+++ b/commit.h
@@ -64,6 +64,7 @@ enum cmit_fmt {
 };
 
 extern int non_ascii(int);
+extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
diff --git a/log-tree.c b/log-tree.c
index 6f73c17..a3b4c06 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -168,18 +168,6 @@ static unsigned int digits_in_number(unsigned int number)
 	return result;
 }
 
-static int has_non_ascii(const char *s)
-{
-	int ch;
-	if (!s)
-		return 0;
-	while ((ch = *s++) != '\0') {
-		if (non_ascii(ch))
-			return 1;
-	}
-	return 0;
-}
-
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 			struct strbuf *buf)
 {
diff --git a/pretty.c b/pretty.c
index 1aa9c3f..ec0affe 100644
--- a/pretty.c
+++ b/pretty.c
@@ -86,6 +86,18 @@ int non_ascii(int ch)
 	return !isascii(ch) || ch == '\033';
 }
 
+int has_non_ascii(const char *s)
+{
+	int ch;
+	if (!s)
+		return 0;
+	while ((ch = *s++) != '\0') {
+		if (non_ascii(ch))
+			return 1;
+	}
+	return 0;
+}
+
 static int is_rfc2047_special(char ch)
 {
 	return (non_ascii(ch) || (ch == '=') || (ch == '?') || (ch == '_'));
-- 
1.6.3.2.734.g770e
