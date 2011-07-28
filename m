From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/19] git-check-attr: Process command-line args more systematically
Date: Thu, 28 Jul 2011 06:46:53 +0200
Message-ID: <1311828418-2676-15-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:55:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIce-0007hD-SA
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1G1Ey5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:54:57 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57320 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1G1Ey4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:54:56 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-Jr; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178025>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index de3fef7..e9b827f 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -81,8 +81,6 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
-	if (!argc)
-		usage_with_options(check_attr_usage, check_attr_options);
 
 	if (read_cache() < 0) {
 		die("invalid cache");
@@ -94,8 +92,17 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			doubledash = i;
 	}
 
-	/* If there is no double dash, we handle only one attribute */
-	if (doubledash < 0) {
+	/* Check attribute argument(s): */
+	if (doubledash == 0) {
+		error_with_usage("No attribute specified");
+	} else if (doubledash < 0) {
+		/*
+		 * There is no double dash; treat the first
+		 * argument as an attribute.
+		 */
+		if (!argc)
+			error_with_usage("No attribute specified");
+
 		cnt = 1;
 		filei = 1;
 	} else {
@@ -103,9 +110,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		filei = doubledash + 1;
 	}
 
-	if (cnt <= 0)
-		error_with_usage("No attribute specified");
-
+	/* Check file argument(s): */
 	if (stdin_paths && filei < argc)
 		error_with_usage("Can't specify files with --stdin");
 
-- 
1.7.6.8.gd2879
