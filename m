From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Sun, 25 May 2008 01:21:53 +0200
Message-ID: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sun May 25 01:22:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K034Z-0001o8-Es
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 01:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYEXXV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbYEXXV4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 19:21:56 -0400
Received: from smtp2.versatel.nl ([62.58.50.89]:34504 "EHLO smtp2.versatel.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbYEXXVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 19:21:55 -0400
Received: (qmail 16553 invoked by uid 0); 24 May 2008 23:21:54 -0000
Received: from ip63-33-210-87.adsl2.versatel.nl (HELO localhost.localdomain) ([87.210.33.63])
          (envelope-sender <pdebie@ai.rug.nl>)
          by smtp2.versatel.nl (qmail-ldap-1.03) with SMTP
          for < >; 24 May 2008 23:21:54 -0000
X-Mailer: git-send-email 1.5.5.1.541.g51dc4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82840>

According to the git-fast-import man-page, you can only put a single
committish per merge: line, like this:

  merge :10
  merge :11

However, git-fast-export puts all parents on a single line, like this:

  merge :10 :11

This may be fine with git-fast-import, but other importers based on it, like
bzr-fast-import, can't handle this.

This changes fast-export to also output a single parent per line.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

I'm not sure why this was done, but it messed up my import :)
 builtin-fast-export.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e1c5630..34acdf9 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -204,10 +204,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 			continue;
 		if (i == 0)
 			printf("from :%d\n", mark);
-		else if (i == 1)
-			printf("merge :%d", mark);
 		else
-			printf(" :%d", mark);
+			printf("merge :%d\n", mark);
 		i++;
 	}
 	if (i > 1)
-- 
1.5.5.1.541.g51dc4.dirty
