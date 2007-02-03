From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat,  3 Feb 2007 19:17:29 +0100
Message-ID: <11705266492308-git-send-email-hjemli@gmail.com>
References: <11705213662728-git-send-email-tutufan@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Michael Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 19:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDPRs-0004ZR-Sr
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 19:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbXBCSRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 13:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXBCSRO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 13:17:14 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:33965 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbXBCSRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 13:17:12 -0500
Received: from localhost.localdomain (ti231210a080-7438.bb.online.no [80.213.29.18])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l13IH750007538;
	Sat, 3 Feb 2007 19:17:08 +0100 (CET)
X-Mailer: git-send-email 1.5.0.rc2.ge4b0e
In-Reply-To: <11705213662728-git-send-email-tutufan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38583>

The test for reflog parameter to create_branch() should also have tested
for log_all_ref_updates. But there is no good reason not to prepare a
reflog message, so lets just do it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

If log_all_ref_updates==1 then the reflog will get an empty message with 
your patch. That is better than using an uninitialized message, but I think
it's still better to just prepare a proper message.


 builtin-branch.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d60690b..16b589e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -342,12 +342,7 @@ static void create_branch(const char *name, const char *start_name,
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
 
-	if (reflog) {
-		log_all_ref_updates = 1;
-		snprintf(msg, sizeof msg, "branch: Created from %s",
-			 start_name);
-	}
-
+	snprintf(msg, sizeof msg, "branch: Created from %s", start_name);
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
 }
-- 
1.5.0.rc2.ge4b0e
