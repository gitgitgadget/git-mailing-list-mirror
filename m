From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/19] git-check-attr: Use git_attr_name()
Date: Tue, 26 Jul 2011 16:12:51 +0200
Message-ID: <1311689582-3116-9-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:33:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlihB-0005lg-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab1GZOdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:33:13 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40227 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab1GZOdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:33:10 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Oa; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177877>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 3016d29..5f04126 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -21,7 +21,7 @@ static const struct option check_attr_options[] = {
 };
 
 static void check_attr(int cnt, struct git_attr_check *check,
-	const char** name, const char *file)
+	const char *file)
 {
 	int j;
 	if (git_checkattr(file, cnt, check))
@@ -37,12 +37,11 @@ static void check_attr(int cnt, struct git_attr_check *check,
 			value = "unspecified";
 
 		quote_c_style(file, NULL, stdout, 0);
-		printf(": %s: %s\n", name[j], value);
+		printf(": %s: %s\n", git_attr_name(check[j].attr), value);
 	}
 }
 
-static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
-	const char** name)
+static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
 	int line_termination = null_term_line ? 0 : '\n';
@@ -56,7 +55,7 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		check_attr(cnt, check, name, buf.buf);
+		check_attr(cnt, check, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -113,10 +112,10 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(cnt, check, argv);
+		check_attr_stdin_paths(cnt, check);
 	else {
 		for (i = doubledash; i < argc; i++)
-			check_attr(cnt, check, argv, argv[i]);
+			check_attr(cnt, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	return 0;
-- 
1.7.6.8.gd2879
