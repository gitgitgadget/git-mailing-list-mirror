From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH] Add 'git commit --no-signoff' option.
Date: Wed, 13 Jan 2010 16:36:54 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001131636460.16395@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 04:43:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUu8i-0003ns-E1
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 04:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0AMDnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 22:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414Ab0AMDnQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 22:43:16 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:58940 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab0AMDnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 22:43:16 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 520AE400BB
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 16:43:14 +1300 (NZDT)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136765>

Do not add a signed-off-by line. This overrides both the `--signoff`
option and the `commit.signoff` configuration variable.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/git-commit.txt |    4 ++++
 builtin-commit.c             |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5a977b6..2dfc989 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -116,6 +116,10 @@ OPTIONS
 	Add Signed-off-by line by the committer at the end of the commit
 	log message. This overrides the `commit.signoff` configuration variable.
 
+--no-signoff::
+	Do not add igned-off-by line. This overrides both the `--signoff`
+	option and the `commit.signoff` configuration variable.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin-commit.c b/builtin-commit.c
index db90e7a..f236068 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, only, amend, signoff, no_signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static char *untracked_files_arg;
 /*
@@ -103,6 +103,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+	OPT_BOOLEAN(0, "no-signoff", &no_signoff, "Do not add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
@@ -797,6 +798,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die("Using both --reset-author and --author does not make sense");
 
+	signoff = no_signoff ? 0 : signoff;
+
 	if (logfile || message.len || use_message)
 		use_editor = 0;
 	if (edit_flag)
-- 
1.6.4
