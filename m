From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 01/14] Add proper 'stage' command
Date: Sat, 12 Oct 2013 02:04:39 -0500
Message-ID: <1381561488-20294-6-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtM5-00043A-3Y
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591Ab3JLHLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:11 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35071 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3JLHLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:04 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so3408929obc.22
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmskeSuoFYI0trhb+bb7EBuO4FJbCYK9FrYGR51QPrI=;
        b=nB0TpoA1xbsjKX6IaDSKdc67/Ae7MV+EPVetjWpXJ7hAFhsuShkLWtIRBKbM9adzYZ
         GwRAbyGKLtiaQKg4czshFu8F/ZZ+YyGj3/w4e0eEfe/7EgNqI5n3HEP3k/QzVpNjobZ2
         CoR6IFa5RdXONQOjSHZvjGWsCnJIgbBW1N+AGle3hEVPgIpW4kVKpVk4qLkgpiLPTnzV
         x8aWppfJDJai9gFIZ/MSzcRzW7oqQT8W1GpBhViSD9h+21Jtn7kCWKU6XlBhNWI+7P6T
         hatwmJlShMt2uMYDqb1/QrEc4Vfv+xT+G/F5Q1k6aIFTKInyn3NUBpMhJcRj/VPzJOcC
         SNDw==
X-Received: by 10.182.130.131 with SMTP id oe3mr17756493obb.34.1381561864228;
        Sat, 12 Oct 2013 00:11:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id wd7sm28628937obc.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235967>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt            | 45 +++++++++++++++++++++++++----
 Makefile                               |  2 +-
 builtin.h                              |  1 +
 builtin/stage.c                        | 52 ++++++++++++++++++++++++++++++++++
 contrib/completion/git-completion.bash | 24 +++++++++++++++-
 git.c                                  |  2 +-
 6 files changed, 118 insertions(+), 8 deletions(-)
 create mode 100644 builtin/stage.c

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index ba3fe0d..318bf45 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -3,20 +3,55 @@ git-stage(1)
 
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
index 3588ca1..1f7ddf3 100644
--- a/Makefile
+++ b/Makefile
@@ -598,7 +598,6 @@ BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
 BUILT_INS += git-show$X
-BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
@@ -982,6 +981,7 @@ BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/stage.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
diff --git a/builtin.h b/builtin.h
index 8afa2de..baf3a0f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -113,6 +113,7 @@ extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_stage(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stage.c b/builtin/stage.c
new file mode 100644
index 0000000..3023d17
--- /dev/null
+++ b/builtin/stage.c
@@ -0,0 +1,52 @@
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
index 5da920e..8cf26e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1691,7 +1691,29 @@ _git_send_email ()
 
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
index 2025f77..0e639aa 100644
--- a/git.c
+++ b/git.c
@@ -409,7 +409,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "show", cmd_show, RUN_SETUP },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
-		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+		{ "stage", cmd_stage, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-- 
1.8.4-fc
