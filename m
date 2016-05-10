From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] worktree: add "lock" command
Date: Tue, 10 May 2016 21:17:28 +0700
Message-ID: <20160510141729.23063-4-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141729.23063-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:18:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08U9-0000Nv-CW
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbcEJOSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:18:00 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33745 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbcEJOR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:17:59 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so1007395pac.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Djj+JD/flzruTT7anCbA+pHqqP5ycUBZ52GcelMp+DU=;
        b=mBaD5xpq5mS5cEYelSOe+30R9sbyI1ZuCLC9skr2LDXLsmgqxwB1ZKXGpVu65RDiPU
         l1dBu6MuRfUYWkZlxkjIbXw4bi26RCs0rO7meq3BFs5PXvRFoTp26XC22CwLP8E452wk
         BEONriuOii0Z3nvjUJCQJfOxbXDT3PXmXRdnV5v13oyKbJ54dnC9YnvUQ6KVfPsuHom4
         YTXF8jwSLuTwZRnj6R2v+XbLUA1OBeAMgSikcWNuLJaVR1WbAOb6SgHA1cE7L/dL+E8/
         xCYDiUrQ9MRzj08YPyGDusge1Icxy9mgzsELU2ZUEo5Vh0+omJZLy82PLZN5BnN8NQh5
         VolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Djj+JD/flzruTT7anCbA+pHqqP5ycUBZ52GcelMp+DU=;
        b=BKFoCbstvAJMkqmvkKyG5W5FtJZJhMg80NVDaDCaYcwmr4bpYuPinHRW2B/2vnD6Zn
         BKUUrlb2s8Q6xjs3AkGHizGu20sRx/Fb92Kf2klGvtSHBNAXGqlts+mlgisHWfG4Jj0H
         NFIWniThg/xI4oxely4PeiSPqMkWzxB/Hse8CCfMY/w+v7Ny3IA6d4b+CC5rqNohDkUl
         8uaAmWfj9cuibXqU+qbmI97k/SzK5vsYcuxCuLSIL8+AnyRhglT7R1/QxLtJ1BLGD42j
         QRbl2NCB0rcnUSSGsOHj0cAtiGhyZURyJ74Is7F3WFQ+Ven6BhnN+LIvJckUoURtf27R
         u1bQ==
X-Gm-Message-State: AOPr4FXAzHlFfMqlcQlzLdgscc+bmaSBl3D6cyOCeEq+Rx2veURBP91vHeHCHbNytSEhBA==
X-Received: by 10.66.183.36 with SMTP id ej4mr58720068pac.53.1462889878211;
        Tue, 10 May 2016 07:17:58 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id u127sm4950597pfb.82.2016.05.10.07.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:17:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:17:59 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141729.23063-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294147>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         | 12 ++++++++--
 builtin/worktree.c                     | 41 ++++++++++++++++++++++++++=
++++++++
 contrib/completion/git-completion.bash |  5 ++++-
 t/t2028-worktree-move.sh (new +x)      | 34 ++++++++++++++++++++++++++=
++
 4 files changed, 89 insertions(+), 3 deletions(-)
 create mode 100755 t/t2028-worktree-move.sh

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 27feff6..74583c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <pat=
h> [<branch>]
 'git worktree list' [--porcelain]
+'git worktree lock' [--reason <string>] <path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
=20
 DESCRIPTION
@@ -61,6 +62,12 @@ each of the linked worktrees.  The output details in=
clude if the worktree is
 bare, the revision currently checked out, and the branch currently che=
cked out
 (or 'detached HEAD' if none).
=20
+lock::
+
+When a worktree is locked, it cannot be pruned, moved or deleted. For
+example, if the worktree is on portable device that is not available
+when "git worktree <command>" is executed.
+
 prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
@@ -110,6 +117,9 @@ OPTIONS
 --expire <time>::
 	With `prune`, only expire unused working trees older than <time>.
=20
+--reason <string>:
+	An explanation why the worktree is locked.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository=
's
@@ -226,8 +236,6 @@ performed manually, such as:
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
index f9dac37..51fa103 100644
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
@@ -459,6 +460,44 @@ static int list(int ac, const char **av, const cha=
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
+	struct strbuf dst =3D STRBUF_INIT;
+
+	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
+	if (ac !=3D 1)
+		usage_with_options(worktree_usage, options);
+
+	strbuf_addstr(&dst, prefix_filename(prefix,
+					    strlen(prefix),
+					    av[0]));
+
+	worktrees =3D get_worktrees();
+	wt =3D find_worktree_by_path(worktrees, dst.buf);
+	if (!wt)
+		die(_("'%s' is not a working directory"), av[0]);
+	if (is_main_worktree(wt))
+		die(_("'%s' is a main working directory"), av[0]);
+
+	old_reason =3D is_worktree_locked(wt);
+	if (old_reason) {
+		if (*old_reason)
+			die(_("already locked, reason: %s"), old_reason);
+		die(_("already locked, no reason"));
+	}
+
+	write_file(git_common_path("worktrees/%s/locked", wt->id),
+		   "%s", reason);
+	return 0;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -475,5 +514,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index d3ac391..6c321aa 100644
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
index 0000000..97434be
--- /dev/null
+++ b/t/t2028-worktree-move.sh
@@ -0,0 +1,34 @@
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
+test_expect_success 'lock worktree twice' '
+	test_must_fail git worktree lock source &&
+	echo hahaha >expected &&
+	test_cmp expected .git/worktrees/source/locked
+'
+
+test_done
--=20
2.8.2.524.g6ff3d78
