From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/19] git-check-attr: Introduce a new variable
Date: Thu, 28 Jul 2011 06:46:50 +0200
Message-ID: <1311828418-2676-12-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIct-0007mB-P2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab1G1EzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:55:05 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57328 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab1G1EzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:55:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-HS; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178028>

Avoid reusing variable "doubledash" to mean something other than the
expected "position of a double-dash, if any".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 384c5a6..c527078 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -71,7 +71,7 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
-	int cnt, i, doubledash;
+	int cnt, i, doubledash, filei;
 	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
@@ -92,14 +92,15 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	/* If there is no double dash, we handle only one attribute */
 	if (doubledash < 0) {
 		cnt = 1;
-		doubledash = 0;
-	} else
+		filei = 1;
+	} else {
 		cnt = doubledash;
-	doubledash++;
+		filei = doubledash + 1;
+	}
 
 	if (cnt <= 0)
 		errstr = "No attribute specified";
-	else if (stdin_paths && doubledash < argc)
+	else if (stdin_paths && filei < argc)
 		errstr = "Can't specify files with --stdin";
 	if (errstr) {
 		error("%s", errstr);
@@ -120,7 +121,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (stdin_paths)
 		check_attr_stdin_paths(cnt, check);
 	else {
-		for (i = doubledash; i < argc; i++)
+		for (i = filei; i < argc; i++)
 			check_attr(cnt, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
-- 
1.7.6.8.gd2879
