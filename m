From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH 4/4] diff and log: Use color configuration infrastructure
Date: Sat,  5 Jan 2008 15:11:39 +0100
Message-ID: <1199542299-12082-4-git-send-email-mk@spinlock.ch>
References: <1199542226.6209.34.camel@futex>
 <1199542299-12082-1-git-send-email-mk@spinlock.ch>
 <1199542299-12082-2-git-send-email-mk@spinlock.ch>
 <1199542299-12082-3-git-send-email-mk@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 05 15:19:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB9sG-0007dv-Qs
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 15:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbYAEOTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 09:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYAEOTJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 09:19:09 -0500
Received: from mail16.bluewin.ch ([195.186.19.63]:34960 "EHLO
	mail16.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbYAEOTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 09:19:06 -0500
Received: from localhost.localdomain (83.78.66.175) by mail16.bluewin.ch (Bluewin 7.3.121)
        id 476BDE6F002BBBE0; Sat, 5 Jan 2008 14:11:40 +0000
X-Mailer: git-send-email 1.5.4.rc2.1104.gec8ae5-dirty
In-Reply-To: <1199542299-12082-3-git-send-email-mk@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69670>

From: Matthias Kestenholz <matthias@spinlock.ch>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 builtin-diff.c |    2 ++
 builtin-log.c  |    9 ++++++++-
 diff.c         |    8 ++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 29365a0..66c5896 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "color.h"
 #include "commit.h"
 #include "blob.h"
 #include "tag.h"
@@ -229,6 +230,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
 
diff --git a/builtin-log.c b/builtin-log.c
index dcc9f81..c9a23fb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -5,6 +5,7 @@
  *		 2006 Junio Hamano
  */
 #include "cache.h"
+#include "color.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
@@ -235,6 +236,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.simplify_history = 0;
@@ -307,6 +309,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	int i, count, ret = 0;
 
 	git_config(git_log_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	rev.diff = 1;
 	rev.combine_merges = 1;
@@ -367,6 +370,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
 	rev.abbrev_commit = 1;
@@ -395,6 +399,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 
 	git_config(git_log_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
@@ -436,7 +441,8 @@ static int git_format_config(const char *var, const char *value)
 		fmt_patch_suffix = xstrdup(value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
+	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")
+			|| !strcmp(var, "color.ui")) {
 		return 0;
 	}
 	if (!strcmp(var, "format.numbered")) {
@@ -630,6 +636,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char ref_message_id[1024];
 
 	git_config(git_format_config);
+	git_color_config();
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
diff --git a/diff.c b/diff.c
index 5bdc111..ccc958e 100644
--- a/diff.c
+++ b/diff.c
@@ -19,7 +19,6 @@
 
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 100;
-static int diff_use_color_default;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 
@@ -64,6 +63,7 @@ static void read_config_if_needed(void)
 	if (!user_diff_tail) {
 		user_diff_tail = &user_diff;
 		git_config(git_diff_ui_config);
+		git_color_config();
 	}
 }
 
@@ -147,7 +147,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
-		diff_use_color_default = git_config_colorbool(var, value, -1);
+		git_use_color = git_config_colorbool(var, value, -1);
 		return 0;
 	}
 	if (!strcmp(var, "diff.renames")) {
@@ -184,7 +184,7 @@ int git_diff_ui_config(const char *var, const char *value)
 		return 0;
 	}
 
-	return git_default_config(var, value);
+	return git_color_default_config(var, value);
 }
 
 static char *quote_two(const char *one, const char *two)
@@ -2021,7 +2021,7 @@ void diff_setup(struct diff_options *options)
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
-	if (diff_use_color_default)
+	if (git_use_color > 0)
 		DIFF_OPT_SET(options, COLOR_DIFF);
 	else
 		DIFF_OPT_CLR(options, COLOR_DIFF);
-- 
1.5.4.rc2.1104.gec8ae5-dirty
