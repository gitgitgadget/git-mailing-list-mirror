From: Matthias Kestenholz <mk@spinlock.ch>
Subject: [PATCH 2/4] git branch: Use color configuration infrastructure
Date: Sat,  5 Jan 2008 15:11:37 +0100
Message-ID: <1199542299-12082-2-git-send-email-mk@spinlock.ch>
References: <1199542226.6209.34.camel@futex>
 <1199542299-12082-1-git-send-email-mk@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 05 15:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBA1n-0001r9-Ql
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 15:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbYAEO3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 09:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbYAEO3K
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 09:29:10 -0500
Received: from mail16.bluewin.ch ([195.186.19.63]:36771 "EHLO
	mail16.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbYAEO3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 09:29:08 -0500
Received: from localhost.localdomain (83.78.66.175) by mail16.bluewin.ch (Bluewin 7.3.121)
        id 476BDE6F002BBBDD; Sat, 5 Jan 2008 14:11:40 +0000
X-Mailer: git-send-email 1.5.4.rc2.1104.gec8ae5-dirty
In-Reply-To: <1199542299-12082-1-git-send-email-mk@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69673>

From: Matthias Kestenholz <matthias@spinlock.ch>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 builtin-branch.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 089cae5..448144f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -31,7 +31,6 @@ static unsigned char head_sha1[20];
 
 static int branch_track = 1;
 
-static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
 	"",		/* PLAIN (normal) */
@@ -65,7 +64,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
 static int git_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "color.branch")) {
-		branch_use_color = git_config_colorbool(var, value, -1);
+		git_use_color = git_config_colorbool(var, value, -1);
 		return 0;
 	}
 	if (!prefixcmp(var, "color.branch.")) {
@@ -76,12 +75,12 @@ static int git_branch_config(const char *var, const char *value)
 	if (!strcmp(var, "branch.autosetupmerge"))
 			branch_track = git_config_bool(var, value);
 
-	return git_default_config(var, value);
+	return git_color_default_config(var, value);
 }
 
 static const char *branch_get_color(enum color_branch ix)
 {
-	if (branch_use_color)
+	if (git_use_color > 0)
 		return branch_colors[ix];
 	return "";
 }
@@ -559,7 +558,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose),
 		OPT_BOOLEAN( 0 , "track",  &track, "set up tracking mode (see git-pull(1))"),
-		OPT_BOOLEAN( 0 , "color",  &branch_use_color, "use colored output"),
+		OPT_BOOLEAN( 0 , "color",  &git_use_color, "use colored output"),
 		OPT_SET_INT('r', NULL,     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
 		OPT_CALLBACK(0, "contains", &with_commit, "commit",
@@ -585,6 +584,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_branch_config);
+	git_color_config();
+
 	track = branch_track;
 	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
 	if (!!delete + !!rename + !!force_create > 1)
-- 
1.5.4.rc2.1104.gec8ae5-dirty
