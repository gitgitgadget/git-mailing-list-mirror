From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/19] git-check-attr: Handle each error separately
Date: Tue, 26 Jul 2011 16:12:56 +0200
Message-ID: <1311689582-3116-14-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlihx-00063D-FE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1GZOeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:34:01 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40273 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab1GZOeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:34:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Re; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177882>

This will make the code easier to refactor.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index d004222..de3fef7 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -78,7 +78,6 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
-	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
@@ -105,12 +104,10 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cnt <= 0)
-		errstr = "No attribute specified";
-	else if (stdin_paths && filei < argc)
-		errstr = "Can't specify files with --stdin";
-	if (errstr) {
-		error_with_usage(errstr);
-	}
+		error_with_usage("No attribute specified");
+
+	if (stdin_paths && filei < argc)
+		error_with_usage("Can't specify files with --stdin");
 
 	check = xcalloc(cnt, sizeof(*check));
 	for (i = 0; i < cnt; i++) {
-- 
1.7.6.8.gd2879
