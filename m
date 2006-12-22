From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff --check: fix off by one error
Date: Fri, 22 Dec 2006 03:20:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612220319440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Dec 22 03:20:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxa1C-0004Ux-VF
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 03:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbWLVCUP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 21:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbWLVCUO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 21:20:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:56595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945916AbWLVCUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 21:20:13 -0500
Received: (qmail invoked by alias); 22 Dec 2006 02:20:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 22 Dec 2006 03:20:12 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35119>


When parsing the diff line starting with '@@', the line number of the
'+' file is parsed. For the subsequent line parses, the line number
should therefore be incremented after the parse, not before it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 26916c3..ba6bd59 100644
--- a/diff.c
+++ b/diff.c
@@ -874,8 +874,6 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		int i, spaces = 0;
 
-		data->lineno++;
-
 		/* check space before tab */
 		for (i = 1; i < len && (line[i] == ' ' || line[i] == '\t'); i++)
 			if (line[i] == ' ')
@@ -890,6 +888,8 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		if (isspace(line[len - 1]))
 			printf("%s:%d: white space at end: %.*s\n",
 				data->filename, data->lineno, (int)len, line);
+
+		data->lineno++;
 	} else if (line[0] == ' ')
 		data->lineno++;
 	else if (line[0] == '@') {
-- 
1.4.4.2.ga854-dirty
