From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/25] worktree: add "lock" command
Date: Wed, 13 Apr 2016 20:15:42 +0700
Message-ID: <1460553346-12985-22-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKg1-0004jl-8S
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760684AbcDMNRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:17:44 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35457 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760672AbcDMNRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:17:43 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so3962291pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vshG9sk4zFC1OGZ6LcawmWX7l70UOxFEk23k92tBDWM=;
        b=UDfOPForUSHFQsx6l5DntQzeZcaRzB6fVX+WpEpffqd3LfJBB1E7i3Rv2fdMbbe3rs
         vKIziyCWqL442VgTALUECPcyjPM/Du0v8ZXamaKkxBPfv4LPKPjGACA0V6yx5NrKwyHr
         JzQeGVGv780+2mk8w2Nq85h6dQgc7fKUo6QwcmK300sPesqJ3sIye7vFzgEhcgk0m1pP
         knyubeX6Go78Oa62fDapi6f9p8BpdIkk4QWY30LcytQsAgOVkJ5AFLYFF+fv7UwkB+Wx
         Nw94WozTt+txPWPvxm3Z1gYEZDmQCgN7P/d3U8Q76JaSb2CxnDvb546wz7Tu9dOgvs93
         klFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vshG9sk4zFC1OGZ6LcawmWX7l70UOxFEk23k92tBDWM=;
        b=Mp5C8UlcrPMsmZpso/yyO6XFEguxji7AuVJCVnM72sEjNuyJYVUhMCvl0eK2CeCC4z
         f21g+t6aOnetghrqhmLLA4W9IW3KGlF5pNFXKaNrP+6FnzlFcz4TI0lOLHJBxxpNZFqL
         JcBIJC1KlsRbSqk49u+WcPjuFOUygBwDxJoknj6Fp5nHZQJ+FB8tJKXCn5U1pCNWJ10H
         NNqSM4dV+a4e2MY2imzmItLBehrVs53HRvHcdPikgDuD48iQja0iI7/ID7tH34yKDRxo
         Xr2Np2wsGO/vh/HvxDrCwzW60vg48iZQypU201uEa37JuLvjnKh+2h1UwHV2iUZVPKSn
         CViw==
X-Gm-Message-State: AOPr4FUWt7cBNLaoAQ9HGRaQXqI9XqVqFOGdsojvyKTh0oA63QV07xf6Trt8BDd+McTLKQ==
X-Received: by 10.67.1.65 with SMTP id be1mr12848675pad.46.1460553463033;
        Wed, 13 Apr 2016 06:17:43 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id p75sm51182503pfi.29.2016.04.13.06.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:17:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:17:49 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291442>

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
index 1c9d7c1..9f0c9f0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
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
@@ -104,6 +111,9 @@ OPTIONS
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
@@ -220,8 +230,6 @@ performed manually, such as:
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
index a9e91ab..736caff 100644
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
@@ -452,6 +453,44 @@ static int list(int ac, const char **av, const cha=
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
@@ -468,5 +507,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index f66db2d..cdae408 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,7 +2596,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list prune"
+	local subcommands=3D"add list lock prune"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
@@ -2608,6 +2608,9 @@ _git_worktree ()
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
2.8.0.rc0.210.gd302cd2
