From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] merge-recur: fix thinko in unique_path()
Date: Sun, 30 Jul 2006 18:35:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607301835020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 18:35:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7EGE-0000em-Pf
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 18:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWG3QfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWG3QfX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 12:35:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:38098 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932354AbWG3QfX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 12:35:23 -0400
Received: (qmail invoked by alias); 30 Jul 2006 16:35:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 30 Jul 2006 18:35:21 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24462>


This could result in a nasty infinite loop, or in bogus names (it used
the strlen() of the newly allocated buffer instead of the original
buffer).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6a796f2..5375a1b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -477,9 +477,9 @@ static char *unique_path(const char *pat
 	char *newpath = xmalloc(strlen(path) + 1 + strlen(branch) + 8 + 1);
 	int suffix = 0;
 	struct stat st;
-	char *p = newpath + strlen(newpath);
+	char *p = newpath + strlen(path);
 	strcpy(newpath, path);
-	strcat(newpath, "~");
+	*(p++) = '~';
 	strcpy(p, branch);
 	for (; *p; ++p)
 		if ('/' == *p)
-- 
1.4.2.rc2.geb7f
