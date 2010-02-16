From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add `log.decorate' configuration variable.
Date: Wed, 17 Feb 2010 12:39:52 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX9B-0001tx-1O
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933613Ab0BPXrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:47:40 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:40123 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932771Ab0BPXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:47:39 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id 75DA5170CB4
	for <git@vger.kernel.org>; Wed, 17 Feb 2010 12:47:38 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140179>

This alows the 'git-log --decorate' to be enabled by default so that normal
log outout contains ant ref names of commits that are shown.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/config.txt |    7 +++++++
 builtin-log.c            |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1aead58..8359eb5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1217,6 +1217,13 @@ log.date::
 	following alternatives: {relative,local,default,iso,rfc,short}.
 	See linkgit:git-log[1].
 
+log.decorate::
+	Print out the ref names of any commits that are shown by the log
+	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
+	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
+	specified, the full ref name (including prefix) will be printed.
+	This is the same as the log commands '--decorate' option.
+
 log.showroot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/builtin-log.c b/builtin-log.c
index 89f8d60..cd6158c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,6 +24,7 @@
 static const char *default_date_mode = NULL;
 
 static int default_show_root = 1;
+static int decoration_style = 0;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -35,7 +36,6 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
 	int i;
-	int decoration_style = 0;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
@@ -249,6 +249,13 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
+	if (!strcmp(var, "log.decorate")) {
+		if (!strcmp(value, "full"))
+			decoration_style = DECORATE_FULL_REFS;
+		else if (!strcmp(value, "short"))
+			decoration_style = DECORATE_SHORT_REFS;
+		return 0;
+	}
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
-- 
1.6.6
