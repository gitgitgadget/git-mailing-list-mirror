From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Delay pager setup in git blame
Date: Sat,  3 Nov 2007 13:22:53 +0100
Message-ID: <1194092575-7133-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 13:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoI2q-00075I-9v
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbXKCMXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbXKCMXu
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:23:50 -0400
Received: from vawad.err.no ([85.19.200.177]:55855 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbXKCMXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:23:49 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoI2T-00029l-K6; Sat, 03 Nov 2007 13:23:48 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoI1f-0001rM-RX; Sat, 03 Nov 2007 13:22:55 +0100
X-Mailer: git-send-email 1.5.3.5
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63252>

This avoids to launch the pager when git blame fails for any reason.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin-blame.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8432b82..aedc294 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2215,9 +2215,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[unk++] = arg;
 	}
 
-	if (!incremental)
-		setup_pager();
-
 	if (!blame_move_score)
 		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
 	if (!blame_copy_score)
@@ -2411,6 +2408,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	read_mailmap(&mailmap, ".mailmap", NULL);
 
+	if (!incremental)
+		setup_pager();
+
 	assign_blame(&sb, &revs, opt);
 
 	if (incremental)
-- 
1.5.3.5
