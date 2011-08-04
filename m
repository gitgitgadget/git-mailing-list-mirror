From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/23] git-check-attr: Handle each error separately
Date: Thu,  4 Aug 2011 06:36:27 +0200
Message-ID: <1312432593-9841-18-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgp-0005WA-QA
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab1HDEhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39673 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351Ab1HDEhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHv029203;
	Thu, 4 Aug 2011 06:37:02 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178682>

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
