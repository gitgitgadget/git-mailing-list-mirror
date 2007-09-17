From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] git-gc --auto: move threshold check to need_to_gc() function.
Date: Mon, 17 Sep 2007 01:44:50 -0700
Message-ID: <1190018703643-git-send-email-gitster@pobox.com>
References: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCEQ-00089U-V3
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbXIQIpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbXIQIpL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:45:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756840AbXIQIpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:45:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8456C1368AD;
	Mon, 17 Sep 2007 04:45:27 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <11900186941912-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58402>

That is where we decide if we are going to run gc
automatically.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-gc.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 093b3dd..f046a2a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -80,6 +80,13 @@ static int need_to_gc(void)
 	int num_loose = 0;
 	int needed = 0;
 
+	/*
+	 * Setting gc.auto to 0 or negative can disable the
+	 * automatic gc
+	 */
+	if (gc_auto_threshold <= 0)
+		return 0;
+
 	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
 		warning("insanely long object directory %.*s", 50, objdir);
 		return 0;
@@ -129,8 +136,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--auto")) {
-			if (gc_auto_threshold <= 0)
-				return 0;
 			auto_gc = 1;
 			continue;
 		}
-- 
1.5.3.1.967.g6bb01
