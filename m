From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/6] worktree: add "lock" command
Date: Mon, 30 May 2016 17:49:38 +0700
Message-ID: <20160530104939.28407-6-pclouds@gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com>
 <20160530104939.28407-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KmO-0005Ob-L2
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbcE3Kuf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 06:50:35 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34555 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbcE3Kue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 06:50:34 -0400
Received: by mail-pa0-f67.google.com with SMTP id x1so4706720pav.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9vBKEcA7U6C2phvDFvuD4k3rMfjwtvO1YBZ27CTsFE=;
        b=hDQq38gvz4+KjKweaO2nO7jUAo8aEb63j86UiJXv5gTOFg4FEwrbDqfCOsmQi+Uk5I
         yIjK1MswPS+aYZsC8+RHLep1m3QNHt7Me3N0nMV5T9D+ZnHKa3ddu5aBDsYNv9qQdMIi
         T0zpP1vO43czrb0N+Cfiq1/39H0/dGlVVChct7MO/vm3XU8/hMH9a1zeI0vPdH4PDObC
         dNgTLWQxGmbkquq+Xv5Cu1tS7UvphMbfj2H0kDLUb34dMjlJgQJvUdDYlhFQkajRz1dG
         7Zc7KfUXuvIaAzZCzkz12ZvJDPnyfzGgF7d5H3GeLuz20OfTxSd7fwR7xMGSqtWsspCZ
         in+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9vBKEcA7U6C2phvDFvuD4k3rMfjwtvO1YBZ27CTsFE=;
        b=R9zbgefcFwkmrpjVVIqJ10G/3h9vXZa/SrxWY0aJpSulH+aqlOM4pUP14vnnMJtmj/
         4QMqjmtIISoOv4iA1ZUwPIUFuqe4QCdL7/d/oslIUuvuyIpnKXPV4mzpE9FuhkcC0Ucd
         m+TkK1DI2phU0K8Nr/XnqOBXxQzjNR5b41DoZQpXj3Jhrw38EtW0KBBO5cVv8YwBfPB6
         O7vVQqE9RzWSeuSOyPMIpNdPztWeZ8DM9hkHeZ/3lGvx1ue8TcefBG9nzCPrBDwLSxgD
         CV2s22orvxUdzpZOAHoCcuhJ4M/Uki7N3MA+Ecolu2IzdQTwfYdPLRQY3v5BLfDqEvK8
         eXew==
X-Gm-Message-State: ALyK8tIBZWW3Wl9cnYp27/4HpEGeDPvzLEg73oRf2Y2qkMhhoq+n8j1wAnHEWwwCAXodBA==
X-Received: by 10.66.25.48 with SMTP id z16mr45682019paf.65.1464605433811;
        Mon, 30 May 2016 03:50:33 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id f24sm16154360pfd.62.2016.05.30.03.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 03:50:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 30 May 2016 17:50:28 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160530104939.28407-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295885>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         | 28 +++++++++++++++-----
 builtin/worktree.c                     | 38 ++++++++++++++++++++++++++=
+
 contrib/completion/git-completion.bash |  5 +++-
 t/t2028-worktree-move.sh (new +x)      | 48 ++++++++++++++++++++++++++=
++++++++
 4 files changed, 112 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 27feff6..6fca6cf 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <pat=
h> [<branch>]
 'git worktree list' [--porcelain]
+'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
=20
 DESCRIPTION
@@ -38,9 +39,8 @@ section "DETAILS" for more information.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
-being pruned by creating a file named 'locked' alongside the other
-administrative files, optionally containing a plain text reason that
-pruning should be suppressed. See section "DETAILS" for more informati=
on.
+being pruned by issuing the `git worktree lock` command, optionally
+specifying `--reason` to explain why the working tree is locked.
=20
 COMMANDS
 --------
@@ -61,6 +61,14 @@ each of the linked worktrees.  The output details in=
clude if the worktree is
 bare, the revision currently checked out, and the branch currently che=
cked out
 (or 'detached HEAD' if none).
=20
+lock::
+
+If a working tree is on a portable device or network share which
+is not always mounted, lock it to prevent its administrative
+files from being pruned automatically. This also prevents it from
+being moved or deleted. Optionally, specify a reason for the lock
+with `--reason`.
+
 prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
@@ -110,6 +118,15 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
=20
+--reason <string>:
+	With `lock`, an explanation why the worktree is locked.
+
+<worktree>::
+	Working trees can be identified by path, either relative or
+	absolute. Alternatively, if the last component in the
+	worktree's path is unique among working trees, it can be used
+	as well.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository=
's
@@ -150,7 +167,8 @@ instead.
=20
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
+entry's working tree is stored on a portable device), use the
+`git worktree lock` command, which adds a file named
 'locked' to the entry's directory. The file contains the reason in
 plain text. For example, if a linked working tree's `.git` file points
 to `/path/main/.git/worktrees/test-next` then a file named
@@ -226,8 +244,6 @@ performed manually, such as:
 - `remove` to remove a linked working tree and its administrative file=
s (and
   warn if the working tree is dirty)
 - `mv` to move or rename a working tree and update its administrative =
files
-- `lock` to prevent automatic pruning of administrative files (for ins=
tance,
-  for a working tree on a portable device)
=20
 GIT
 ---
diff --git a/builtin/worktree.c b/builtin/worktree.c
index f9dac37..84fe63b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -14,6 +14,7 @@
 static const char * const worktree_usage[] =3D {
 	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree list [<options>]"),
+	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
@@ -459,6 +460,41 @@ static int list(int ac, const char **av, const cha=
r *prefix)
 	return 0;
 }
=20
+static int lock_worktree(int ac, const char **av, const char *prefix)
+{
+	const char *reason =3D "", *old_reason;
+	struct option options[] =3D {
+		OPT_STRING(0, "reason", &reason, N_("string"),
+			   N_("reason for locking")),
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 1)
+		usage_with_options(worktree_usage, options);
+
+	worktrees =3D get_worktrees();
+	wt =3D find_worktree(worktrees, prefix, av[0]);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+
+	old_reason =3D wt->lock_reason;
+	if (old_reason) {
+		if (*old_reason)
+			die(_("'%s' is already locked, reason: %s"),
+			    av[0], old_reason);
+		die(_("'%s' is already locked"), av[0]);
+	}
+
+	write_file(git_common_path("worktrees/%s/locked", wt->id),
+		   "%s", reason);
+	free_worktrees(worktrees);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -475,5 +511,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return prune(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "list"))
 		return list(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "lock"))
+		return lock_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 951a186..f88727d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2597,7 +2597,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list prune"
+	local subcommands=3D"add list lock prune"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2609,6 +2609,9 @@ _git_worktree ()
 		list,--*)
 			__gitcomp "--porcelain"
 			;;
+		lock,--*)
+			__gitcomp "--reason"
+			;;
 		prune,--*)
 			__gitcomp "--dry-run --expire --verbose"
 			;;
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
new file mode 100755
index 0000000..87afc2e
--- /dev/null
+++ b/t/t2028-worktree-move.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description=3D'test git worktree move, remove, lock and unlock'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	git worktree add source &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/source
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'lock main worktree' '
+	test_must_fail git worktree lock .
+'
+
+test_expect_success 'lock linked worktree' '
+	git worktree lock --reason hahaha source &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
+test_expect_success 'lock linked worktree from another worktree' '
+	rm .git/worktrees/source/locked &&
+	git worktree add elsewhere &&
+	git -C elsewhere worktree lock --reason hahaha ../source &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
+test_expect_success 'lock worktree twice' '
+	test_must_fail git worktree lock source &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
+test_expect_success 'lock worktree twice (from the locked worktree)' '
+	test_must_fail git -C source worktree lock . &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
+test_done
--=20
2.8.2.524.g6ff3d78
