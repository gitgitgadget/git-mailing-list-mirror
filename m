From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/RFD] wt-status: take advice.statusHints seriously
Date: Wed, 21 Apr 2010 16:47:51 +0200
Message-ID: <b3168027365b78d47f5b95fc02f7853749075a33.1271861247.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 16:51:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4bGb-0002yb-Od
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0DUOu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 10:50:58 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56151 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752794Ab0DUOu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 10:50:57 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED57BEC02A
	for <git@vger.kernel.org>; Wed, 21 Apr 2010 10:50:56 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 21 Apr 2010 10:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=q3jrObhCc4SQCBUnl6SJxtCpVoI=; b=bshEN4ul6C24cFmQTp9d3P0dU+DK2C01BQRDU8Se2JS16280hL2mpPkjDfb6+t1rjYVbrcxZhhpJuHyWOi7KrU0knIZQiLskDp3low76YwQh8R2WuNkNyxjr+Ny+Rs+w6Sj4hF/wiGPXSXXN+c2tHYfHg/UEqAOk8rh1AywzuUk=
X-Sasl-enc: A2RFS8d5Z9pGYak6COmhcUQRmSrzH2QUN+qvn518oCB8 1271861456
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2D1774AB99B;
	Wed, 21 Apr 2010 10:50:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145435>

Currently, status gives a lot of hints even when advice.statusHints is
false. Change this so that all hints depend on the config varaible.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 wt-status.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..38076ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -625,7 +625,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->show_untracked_files)
 		wt_status_print_untracked(s);
 	else if (s->commitable)
-		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
+		 fprintf(s->fp, "# Untracked files not listed%s\n", advice_status_hints ? " (use -u option to show untracked files)" : "");
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
@@ -635,15 +635,15 @@ void wt_status_print(struct wt_status *s)
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-			printf("no changes added to commit (use \"git add\" and/or \"git commit -a\")\n");
+			printf("no changes added to commit%s\n", advice_status_hints ? " (use \"git add\" and/or \"git commit -a\")" : "");
 		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
+			printf("nothing added to commit but untracked files present%s\n", advice_status_hints ? " (use \"git add\" to track)" : "");
 		else if (s->is_initial)
-			printf("nothing to commit (create/copy files and use \"git add\" to track)\n");
+			printf("nothing to commit%s\n", advice_status_hints ? " (create/copy files and use \"git add\" to track)" : "");
 		else if (!s->show_untracked_files)
-			printf("nothing to commit (use -u to show untracked files)\n");
+			printf("nothing to commit%s\n", advice_status_hints ? " (use -u to show untracked files)" : "");
 		else
-			printf("nothing to commit (working directory clean)\n");
+			printf("nothing to commit%s\n", advice_status_hints ? " (working directory clean)" : "");
 	}
 }
 
-- 
1.7.1.rc1.248.gcefbb
