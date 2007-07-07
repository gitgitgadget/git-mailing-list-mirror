From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Change funcname_pattern_ident to diff_attr
Date: Sat, 7 Jul 2007 18:20:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071820270.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 07 19:28:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7E4p-0006In-Rj
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbXGGR2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbXGGR2J
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:28:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:44355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbXGGR2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:28:08 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:28:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 07 Jul 2007 19:28:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mMAFSvRvmUN48eYMFjHfCwM8QY8niqiJuqg2z2e
	vJNvP9xQqRjQ7S
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51828>


What we store in diff_filespec_check_attr() is really what is specified
in the diff attribute.  So better use the name "diff_attr".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	These two patches are on top of "Fix configuration syntax..."

 diff.c     |   13 ++++---------
 diffcore.h |    2 +-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index e92db5c..a5444df 100644
--- a/diff.c
+++ b/diff.c
@@ -1168,7 +1168,7 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 
 	setup_diff_attr_check(&attr_diff_check);
 	one->is_binary = 0;
-	one->funcname_pattern_ident = NULL;
+	one->diff_attr = NULL;
 
 	if (!one->data && DIFF_FILE_VALID(one))
 		diff_populate_filespec(one, 0);
@@ -1179,18 +1179,13 @@ static void diff_filespec_check_attr(struct diff_filespec *one)
 	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
 		const char *value;
 
-		/* binaryness */
 		value = attr_diff_check.value;
 		if (ATTR_TRUE(value))
 			one->is_binary = 0;
 		else if (ATTR_FALSE(value))
 			one->is_binary = 1;
-
-		/* funcname pattern ident */
-		if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
-			;
-		else
-			one->funcname_pattern_ident = value;
+		else if (!ATTR_UNSET(value))
+			one->diff_attr = value;
 	}
 }
 
@@ -1216,7 +1211,7 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	const char *ident, *pattern;
 
 	diff_filespec_check_attr(one);
-	ident = one->funcname_pattern_ident;
+	ident = one->diff_attr;
 
 	if (!ident)
 		/*
diff --git a/diffcore.h b/diffcore.h
index eef17c4..f905bf5 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -27,7 +27,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	const char *funcname_pattern_ident;
+	const char *diff_attr;
 	unsigned long size;
 	int xfrm_flags;		 /* for use by the xfrm */
 	unsigned short mode;	 /* file mode */
-- 
1.5.3.rc0.2712.g125b7f
