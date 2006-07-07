From: Stephan Feder <sf@b-i-t.de>
Subject: [PATCH] Do not drop data from '\0' until eol in patch output
Date: Fri, 07 Jul 2006 12:33:44 +0200
Message-ID: <1152268424350-git-send-email-sf@b-i-t.de>
Reply-To: Stephan Feder <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:33:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fynek-0006Ng-VO
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWGGKdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGGKdw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:33:52 -0400
Received: from mail.medianet-world.de ([213.157.0.167]:403 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S1750980AbWGGKdv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:33:51 -0400
Received: (qmail 8301 invoked by uid 1011); 7 Jul 2006 10:33:49 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(-2.5/5.0):. 
 Processed in 0.280655 secs); 07 Jul 2006 10:33:49 -0000
X-Spam-Status: No, hits=-2.5 required=5.0
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 7 Jul 2006 10:33:49 -0000
Received: from localhost.localdomain (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id F229A713B;
	Fri,  7 Jul 2006 12:33:44 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbc483
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23421>

The binary file detection is just a heuristic which can well fail.
Do not produce garbage patches in these cases.

Signed-off-by: Stephan Feder <sf@b-i-t.de>
---
 diff.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 507e401..f0450a8 100644
--- a/diff.c
+++ b/diff.c
@@ -329,7 +329,9 @@ static void fn_out_consume(void *priv, c
 	}
 	if (len > 0 && line[len-1] == '\n')
 		len--;
-	printf("%s%.*s%s\n", set, (int) len, line, reset);
+	fputs (set, stdout);
+	fwrite (line, len, 1, stdout);
+	puts (reset);
 }
 
 static char *pprint_rename(const char *a, const char *b)
-- 
1.4.1.gbc483
