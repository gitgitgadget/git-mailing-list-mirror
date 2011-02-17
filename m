From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 5/6] commit_filter: also communicate the repo name to the filter
Date: Thu, 17 Feb 2011 22:11:08 +0100
Message-ID: <1297977069-21884-6-git-send-email-mailings@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8R-0007Wi-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab1BQVL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:26 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57508 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757979Ab1BQVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:12 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id C20FB58C99C;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167121>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c                  |    5 ++++-
 filters/commit-links.sh |    2 ++
 ui-commit.c             |    5 ++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/cgit.c b/cgit.c
index 65c892c..9e8c4c4 100644
--- a/cgit.c
+++ b/cgit.c
@@ -41,10 +41,13 @@ struct cgit_filter *new_filter(const char *cmd, filter_type filtertype)
 
 	switch (filtertype) {
 		case about:
-		case commit:
 			extra_args = 0;
 			break;
 
+		case commit:
+			extra_args = 1;
+			break;
+
 		case source:
 			extra_args = 2;
 			break;
diff --git a/filters/commit-links.sh b/filters/commit-links.sh
index 110c609..d098cd5 100755
--- a/filters/commit-links.sh
+++ b/filters/commit-links.sh
@@ -3,6 +3,8 @@
 #
 # To use this script, refer to this file with either the commit-filter or the
 # repo.commit-filter options in cgitrc.
+#
+# 1st argument is the repo name
 
 # This expression generates links to commits referenced by their SHA1.
 regex=$regex'
diff --git a/ui-commit.c b/ui-commit.c
index 2b4f677..b0607d0 100644
--- a/ui-commit.c
+++ b/ui-commit.c
@@ -109,8 +109,11 @@ void cgit_print_commit(char *hex, const char *prefix)
 	}
 	html("</table>\n");
 	html("<div class='commit-subject'>");
-	if (ctx.repo->commit_filter)
+	if (ctx.repo->commit_filter) {
+		if (!ctx.repo->commit_filter->argv[1])
+			ctx.repo->commit_filter->argv[1] = xstrdup(ctx.repo->name);
 		cgit_open_filter(ctx.repo->commit_filter);
+	}
 	html_txt(info->subject);
 	if (ctx.repo->commit_filter)
 		cgit_close_filter(ctx.repo->commit_filter);
-- 
1.7.4
