From: Ferry Huberts <mailings@hupie.com>
Subject: [CGit] [PATCH 6/6] about_filter: also communicate the repo name to the filter
Date: Thu, 17 Feb 2011 22:11:09 +0100
Message-ID: <1297977069-21884-7-git-send-email-mailings@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Cc: hjemli@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 22:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqB8S-0007Wi-AW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab1BQVL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:11:28 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:57507 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757977Ab1BQVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:11:12 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id C63B058C99D;
	Thu, 17 Feb 2011 22:11:09 +0100 (CET)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167122>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 cgit.c        |    3 ---
 ui-repolist.c |    5 ++++-
 ui-summary.c  |    5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/cgit.c b/cgit.c
index 9e8c4c4..653b099 100644
--- a/cgit.c
+++ b/cgit.c
@@ -41,9 +41,6 @@ struct cgit_filter *new_filter(const char *cmd, filter_type filtertype)
 
 	switch (filtertype) {
 		case about:
-			extra_args = 0;
-			break;
-
 		case commit:
 			extra_args = 1;
 			break;
diff --git a/ui-repolist.c b/ui-repolist.c
index 2c98668..a0c2235 100644
--- a/ui-repolist.c
+++ b/ui-repolist.c
@@ -290,8 +290,11 @@ void cgit_print_site_readme()
 {
 	if (!ctx.cfg.root_readme)
 		return;
-	if (ctx.cfg.about_filter)
+	if (ctx.cfg.about_filter) {
+		if (!ctx.repo->about_filter->argv[1])
+			ctx.repo->about_filter->argv[1] = xstrdup(ctx.repo->name);
 		cgit_open_filter(ctx.cfg.about_filter);
+	}
 	html_include(ctx.cfg.root_readme);
 	if (ctx.cfg.about_filter)
 		cgit_close_filter(ctx.cfg.about_filter);
diff --git a/ui-summary.c b/ui-summary.c
index b203bcc..f8c85a2 100644
--- a/ui-summary.c
+++ b/ui-summary.c
@@ -112,8 +112,11 @@ void cgit_print_repo_readme(char *path)
 	 * filesystem, while applying the about-filter.
 	 */
 	html("<div id='summary'>");
-	if (ctx.repo->about_filter)
+	if (ctx.repo->about_filter) {
+		if (!ctx.repo->about_filter->argv[1])
+			ctx.repo->about_filter->argv[1] = xstrdup(ctx.repo->name);
 		cgit_open_filter(ctx.repo->about_filter);
+	}
 	if (ref)
 		cgit_print_file(tmp, ref);
 	else
-- 
1.7.4
