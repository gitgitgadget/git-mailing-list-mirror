From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 01/14] Add proper 'stage' command
Date: Fri, 25 Apr 2014 13:12:34 -0500
Message-ID: <1398449567-16314-2-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdkmW-00060E-VE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbaDYSXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:23 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58283 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbaDYSXV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:21 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so4591259oag.6
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLxXKZSG542/TPQQkdq6KlioNzGwsFncvKLnGZ2m6A8=;
        b=TwblXCfVECJOji5Op6Bb45B0wfr/bmVTYtliW2eZCnvL0Mx5zdoGeZKKFrXRbwTckE
         +ZzZf/ZETN2d+WYrcGwExBJMj8j1GQ/5KTNOhmqlythHXkC7w86dmzw0bVilTx5+kws8
         jTIo6ENzfVxnOVjnOl00HZ48gtNAoNEjGKnTNUvILbppd+LD96kwXnhDkXHTfnOLXJnk
         VvrfvQhsDQD8k+fVy51f9w1zifwRuuiKETsNdBSCBC3+cV6MhbMT3o9oqfHs+ZNSj7bD
         W9nQ6hXCTYY/NA+D5XhKlhSFzhhG+B/d6ibcnDRK+XiEbn4Id0Dfu1hQmBG1424vXPp2
         zw2Q==
X-Received: by 10.182.75.225 with SMTP id f1mr2669128obw.66.1398450200931;
        Fri, 25 Apr 2014 11:23:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id vh3sm17058810obb.9.2014.04.25.11.23.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247075>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt            | 46 +++++++++++++++++++++++++----
 Makefile                               |  2 +-
 builtin.h                              |  1 +
 builtin/stage.c                        | 53 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash | 24 ++++++++++++++-
 git.c                                  |  2 +-
 6 files changed, 120 insertions(+), 8 deletions(-)
 create mode 100644 builtin/stage.c

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index ba3fe0d..5b42b29 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -3,20 +3,56 @@ git-stage(1)
 
 NAME
 ----
-git-stage - Add file contents to the staging area
+git-stage - manage the staging area
 
 
 SYNOPSIS
 --------
 [verse]
-'git stage' args...
-
+'git stage' [options] [--] [<paths>...]
+'git stage add' [options] [--] [<paths>...]
+'git stage reset' [-q|--patch] [--] [<paths>...]
+'git stage diff' [options] [<commit>] [--] [<paths>...]
+'git stage rm' [options] [--] [<paths>...]
+'git stage apply' [options] [--] [<paths>...]
 
 DESCRIPTION
 -----------
 
-This is a synonym for linkgit:git-add[1].  Please refer to the
-documentation of that command.
+This command is useful to manage the staging area through other subcommands.
+
+COMMANDS
+--------
+
+With no arguments, it's a synonym for linkgit:git-add[1].
+
+'add'::
+
+Adds file contents to the staging area. See linkgit:git-add[1].
+
+'reset'::
+
+Resets the staging area. See linkgit:git-reset[1].
+
+'diff'::
+
+View the changes you staged for the next commit. See linkgit:git-diff[1] --staged.
+
+'rm'::
+
+Remove files from the staging area only. See linkgit:git-rm[1] --staged.
+
+'apply'::
+
+Apply a patch to the staging area. See linkgit:git-rm[1] --staged.
+
+SEE ALSO
+--------
+linkgit:git-add[1]
+linkgit:git-reset[1]
+linkgit:git-diff[1]
+linkgit:git-rm[1]
+linkgit:git-apply[1]
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index dddaf4f..059cd50 100644
--- a/Makefile
+++ b/Makefile
@@ -589,7 +589,6 @@ BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-show$X
-BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
@@ -977,6 +976,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stage.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index c47c110..76b0a48 100644
--- a/builtin.h
+++ b/builtin.h
@@ -115,6 +115,7 @@ extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_stage(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stage.c b/builtin/stage.c
new file mode 100644
index 0000000..7c4d442
--- /dev/null
+++ b/builtin/stage.c
@@ -0,0 +1,53 @@
+/*
+ * 'git stage' builtin command
+ *
+ * Copyright (C) 2013 Felipe Contreras
+ */
+
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char *const stage_usage[] = {
+	N_("git stage [options] [--] <paths>..."),
+	N_("git stage add [options] [--] <paths>..."),
+	N_("git stage apply [options] [<patch>...]"),
+	N_("git stage reset [-q|--patch] [--] <paths>..."),
+	N_("git stage diff [options] [<commit]> [--] <paths>..."),
+	N_("git stage rm [options] [--] <paths>..."),
+	NULL
+};
+
+int cmd_stage(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, prefix, options, stage_usage,
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc > 1) {
+		if (!strcmp(argv[1], "add"))
+			return cmd_add(argc - 1, argv + 1, prefix);
+		if (!strcmp(argv[1], "reset"))
+			return cmd_reset(argc - 1, argv + 1, prefix);
+		if (!strcmp(argv[1], "diff")) {
+			argv[0] = "diff";
+			argv[1] = "--staged";
+
+			return cmd_diff(argc, argv, prefix);
+		}
+		if (!strcmp(argv[1], "rm")) {
+			argv[0] = "rm";
+			argv[1] = "--cached";
+
+			return cmd_rm(argc, argv, prefix);
+		}
+		if (!strcmp(argv[1], "apply")) {
+			argv[0] = "apply";
+			argv[1] = "--cached";
+
+			return cmd_apply(argc, argv, prefix);
+		}
+	}
+
+	return cmd_add(argc, argv, prefix);
+}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9525343..0521d52 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1705,7 +1705,29 @@ _git_send_email ()
 
 _git_stage ()
 {
-	_git_add
+	__git_has_doubledash && return
+
+	local subcommands="add reset diff rm apply"
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+		return
+	fi
+
+	case "$subcommand" in
+	add)
+		_git_add;;
+	reset)
+		_git_reset;;
+	diff)
+		_git_diff;;
+	rm)
+		_git_rm;;
+	apply)
+		_git_apply;;
+	*)
+		_git_add;
+	esac
 }
 
 __git_config_get_set_variables ()
diff --git a/git.c b/git.c
index 7cf2953..844434c 100644
--- a/git.c
+++ b/git.c
@@ -428,7 +428,7 @@ static struct cmd_struct commands[] = {
 	{ "show", cmd_show, RUN_SETUP },
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
-	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "stage", cmd_stage, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
1.9.2+fc1.2.gfbaae8c
