From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/6] worktree: add "lock" command
Date: Fri,  3 Jun 2016 19:19:42 +0700
Message-ID: <20160603121944.28980-5-pclouds@gmail.com>
References: <20160530104939.28407-1-pclouds@gmail.com>
 <20160603121944.28980-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5a-00034l-CH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbcFCMUc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:32 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33660 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbcFCMU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:29 -0400
Received: by mail-pa0-f68.google.com with SMTP id di3so5914556pab.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GasH5afcgHjG1b6Bx+h9WGvYhJ0ADTnAIpMSQ6QX6H8=;
        b=IWcqNlb5hxZghBUQNKSl1GLhFzptWZLHXj/DcWysbuB2Bs6yHZWyO/6ejG+bWU43Vx
         LL/38ZqkxBA8YS+sluO4JssXaAuW3g02rohDqq26HWjvMy2V9UwRWDITTxjxZ7Hwpnru
         pd5ubU6DAHjdcvMoY4vnQdl1JuTjX6FtPhrCZJl1SRJH5l5kPD67ZmufItjmfpCdg7hX
         tjiNXJqnQRMvb97n6MtWaqElwRJVjo0o7skkxxb+36ytqTIHw7NL+kYI9vSP+D+ldJ9Q
         OeNbSmaJ8ERPkUQYGbcPau7uTtVQo3zO8K11MO2qRYPUcOP4XdKB1CugAbT9goXJTy8G
         ptsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GasH5afcgHjG1b6Bx+h9WGvYhJ0ADTnAIpMSQ6QX6H8=;
        b=Uu6TigK+Je52dCbbmrrGUBBNLN3Cv9B/NSWmiqbWe7NM6LqgNiWYd3OtNA7ol3ygc8
         AiHywzJf/tvuSvWwxRYtIYWIOFNdAE/2b+ToEvcaLpk1Pp4io23ko6rcZi7shfWa9SOP
         MjlOxX80rOBQqh0makstIf1xB8st4K1FkEAjQhyugZpbIoGU9uRpODavciIKAnQshFQp
         ClxzbWddxFwxnZUPXLE52ZwQl6RTmAeToIIwwTHcpH0mdWC2US/+cVuCPzocKuK43ce0
         RmkE00tSsnHlh7LgZUeTLNotroEetOKri+4uL+l+3gVvCVwT9zR9guiji9rEzL+PIrgy
         xcjA==
X-Gm-Message-State: ALyK8tIPNympsvI6FIhLTA2bWEV/d1sbI3rxGpjB8CauNdNVQbOBjCuiYzS9X3D0W5kGoQ==
X-Received: by 10.66.197.202 with SMTP id iw10mr4970955pac.148.1464956428970;
        Fri, 03 Jun 2016 05:20:28 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id w23sm8178469pfa.38.2016.06.03.05.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:23 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296311>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         | 26 +++++++++++++-----
 builtin/worktree.c                     | 38 ++++++++++++++++++++++++++=
+
 contrib/completion/git-completion.bash |  5 +++-
 t/t2028-worktree-move.sh (new +x)      | 48 ++++++++++++++++++++++++++=
++++++++
 4 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 7c4cfb0..d233d61 100644
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
@@ -62,6 +62,14 @@ each of the linked worktrees.  The output details in=
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
@@ -111,6 +119,13 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
=20
+--reason <string>::
+	With `lock`, an explanation why the working tree is locked.
+
+<worktree>::
+	Working trees can be identified by path, either relative or
+	absolute.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository=
's
@@ -151,7 +166,8 @@ instead.
=20
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
+entry's working tree is stored on a portable device), use the
+`git worktree lock` command, which adds a file named
 'locked' to the entry's directory. The file contains the reason in
 plain text. For example, if a linked working tree's `.git` file points
 to `/path/main/.git/worktrees/test-next` then a file named
@@ -227,8 +243,6 @@ performed manually, such as:
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
index e866844..b686c7f 100644
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
@@ -462,6 +463,41 @@ static int list(int ac, const char **av, const cha=
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
+	old_reason =3D is_worktree_locked(wt);
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
@@ -478,5 +514,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index fb0f6e3..61ef18d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2598,7 +2598,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list prune"
+	local subcommands=3D"add list lock prune"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2610,6 +2610,9 @@ _git_worktree ()
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
