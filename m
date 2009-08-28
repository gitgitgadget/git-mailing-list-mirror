From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 01/15] sequencer: add "builtin-sequencer--helper.c"
Date: Fri, 28 Aug 2009 06:47:31 +0200
Message-ID: <20090828044746.4307.60033.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 06:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtYY-00060R-PC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 06:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZH1E7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZH1E7O
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49696 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbZH1E7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EE3238180CE;
	Fri, 28 Aug 2009 06:59:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AB4A4818094;
	Fri, 28 Aug 2009 06:58:58 +0200 (CEST)
X-git-sha1: 2dc1e74e8e55983a03d3913a2e494e2b7ec2f5de 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127254>

This a helper builtin that will be used to port some parts of
"git-rebase--interactive.sh" to C.

It currently does nothing except checking arguments it is passed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                  |    1 +
 Makefile                    |    1 +
 builtin-sequencer--helper.c |   27 +++++++++++++++++++++++++++
 builtin.h                   |    1 +
 git.c                       |    1 +
 5 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 builtin-sequencer--helper.c

diff --git a/.gitignore b/.gitignore
index c446290..adbe7cc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ git-revert
 git-rm
 git-send-email
 git-send-pack
+git-sequencer--helper
 git-sh-setup
 git-shell
 git-shortlog
diff --git a/Makefile b/Makefile
index 4190a5d..4aab6bc 100644
--- a/Makefile
+++ b/Makefile
@@ -628,6 +628,7 @@ BUILTIN_OBJS += builtin-rev-parse.o
 BUILTIN_OBJS += builtin-revert.o
 BUILTIN_OBJS += builtin-rm.o
 BUILTIN_OBJS += builtin-send-pack.o
+BUILTIN_OBJS += builtin-sequencer--helper.o
 BUILTIN_OBJS += builtin-shortlog.o
 BUILTIN_OBJS += builtin-show-branch.o
 BUILTIN_OBJS += builtin-show-ref.o
diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
new file mode 100644
index 0000000..721c0d8
--- /dev/null
+++ b/builtin-sequencer--helper.c
@@ -0,0 +1,27 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+
+static const char * const git_sequencer_helper_usage[] = {
+	"git sequencer--helper --make-patch <commit>",
+	NULL
+};
+
+int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
+{
+	char *commit = NULL;
+	struct option options[] = {
+		OPT_STRING(0, "make-patch", &commit, "commit",
+			   "create a patch from commit"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_sequencer_helper_usage, 0);
+
+	if (!commit)
+		usage_with_options(git_sequencer_helper_usage, options);
+
+	/* Nothing to do yet */
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 51e4ba7..0a60e81 100644
--- a/builtin.h
+++ b/builtin.h
@@ -91,6 +91,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_sequencer__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 0021a29..d510758 100644
--- a/git.c
+++ b/git.c
@@ -345,6 +345,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
+		{ "sequencer--helper", cmd_sequencer__helper, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
-- 
1.6.4.271.ge010d
