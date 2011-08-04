From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/23] git-check-attr: Process command-line args more systematically
Date: Thu,  4 Aug 2011 06:36:28 +0200
Message-ID: <1312432593-9841-19-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgq-0005WA-C1
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab1HDEhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:34 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39679 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab1HDEhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHw029203;
	Thu, 4 Aug 2011 06:37:02 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178683>


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
