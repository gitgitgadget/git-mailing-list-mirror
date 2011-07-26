From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/19] git-check-attr: Introduce a new variable
Date: Tue, 26 Jul 2011 16:12:54 +0200
Message-ID: <1311689582-3116-12-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlihQ-0005rA-Jk
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab1GZOd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:33:27 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40248 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1GZOd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:33:26 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-QN; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177880>

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
