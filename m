From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Retain extra blank lines between the summary and the
 body
Date: Sun, 17 Feb 2008 13:35:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171335490.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 19:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQoNZ-00058u-3d
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 19:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbYBQSfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 13:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbYBQSfx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 13:35:53 -0500
Received: from iabervon.org ([66.92.72.58]:49985 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbYBQSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 13:35:52 -0500
Received: (qmail 6745 invoked by uid 1000); 17 Feb 2008 18:35:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 18:35:51 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74160>

This is so that it's possible to have a message that will generate an
email with the first line blank. If the email you're generating is
actually a template, you may have a single line filling in for a
~3-line paragraph, meaning that the space starts with a blank line,
which was impossible before as output from the message-splitting code.

Furthermore, extra blank lines that aren't at the beginning of the
body portion aren't stripped, so this is more consistant overall.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 pretty.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index f82380b..98efac2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -713,7 +713,6 @@ void pp_remainder(enum cmit_fmt fmt,
 		  struct strbuf *sb,
 		  int indent)
 {
-	int first = 1;
 	for (;;) {
 		const char *line = *msg_p;
 		int linelen = get_one_line(line);
@@ -723,12 +722,9 @@ void pp_remainder(enum cmit_fmt fmt,
 			break;
 
 		if (is_empty_line(line, &linelen)) {
-			if (first)
-				continue;
 			if (fmt == CMIT_FMT_SHORT)
 				break;
 		}
-		first = 0;
 
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
-- 
1.5.4.1.1350.g2b9ee
