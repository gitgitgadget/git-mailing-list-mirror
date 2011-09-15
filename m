From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/22] Inline function refname_format_print()
Date: Thu, 15 Sep 2011 23:10:29 +0200
Message-ID: <1316121043-29367-9-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDW-00066p-6G
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934976Ab1IOVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:09 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40099 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934960Ab1IOVLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:07 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8o-00019o-1d; Thu, 15 Sep 2011 23:06:38 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181499>

Soon we will make printing independent of collapsing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-ref-format.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 989ee5c..f5df9aa 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -48,17 +48,12 @@ static int check_ref_format_branch(const char *arg)
 	return 0;
 }
 
-static void refname_format_print(const char *arg)
-{
-	char *refname = collapse_slashes(arg);
-	printf("%s\n", refname);
-}
-
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int print = 0;
 	int flags = 0;
+	const char *refname;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -81,11 +76,14 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
 
-	if (check_refname_format(argv[i], flags))
+	refname = argv[i];
+	if (check_refname_format(refname, flags))
 		return 1;
 
-	if (print)
-		refname_format_print(argv[i]);
+	if (print) {
+		refname = collapse_slashes(refname);
+		printf("%s\n", refname);
+	}
 
 	return 0;
 }
-- 
1.7.6.8.gd2879
