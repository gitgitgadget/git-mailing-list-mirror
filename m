From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat,  3 Feb 2007 19:35:47 +0100
Message-ID: <11705277471962-git-send-email-hjemli@gmail.com>
References: <11705213662728-git-send-email-tutufan@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Michael Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 19:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDPjd-0005AY-BW
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 19:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbXBCSfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 13:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXBCSfb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 13:35:31 -0500
Received: from mail47.e.nsc.no ([193.213.115.47]:58883 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbXBCSfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 13:35:31 -0500
Received: from localhost.localdomain (ti231210a080-7438.bb.online.no [80.213.29.18])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l13IZQ75000774;
	Sat, 3 Feb 2007 19:35:26 +0100 (CET)
X-Mailer: git-send-email 1.5.0.rc2.ge4b0e
In-Reply-To: <11705213662728-git-send-email-tutufan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38585>

The test for reflog parameter to create_branch() should also have tested
for log_all_ref_updates. But there is no good reason not to prepare a
reflog message, so lets just do it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

Sorry, the previous patch was obviously no good, since it didn't honour
the case where (reflog==1 && log_all_ref_updates==0)

This one should be better.


 builtin-branch.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d60690b..a8c8c98 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -342,12 +342,10 @@ static void create_branch(const char *name, const char *start_name,
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
 
-	if (reflog) {
+	if (reflog)
 		log_all_ref_updates = 1;
-		snprintf(msg, sizeof msg, "branch: Created from %s",
-			 start_name);
-	}
 
+	snprintf(msg, sizeof msg, "branch: Created from %s", start_name);
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
 }
-- 
1.5.0.rc2.ge4b0e
