From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/26] worktree: add "lock" command
Date: Tue, 16 Feb 2016 20:29:23 +0700
Message-ID: <1455629367-26193-23-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfj9-0003yA-2i
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbcBPNb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:28 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36543 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbcBPNbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:25 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so103495976pab.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SVCjqDHQqYCSsdkNdNN1XB9RoNL1bSBh2I71TfFJ/Ag=;
        b=vtkK3C4mSZCzs2iX4uVU27Jp/ZC1VmbhCM2uwvwWSdo38lJ3/WWywHo1UX75kvZuDx
         wy5yuI110pYkHWAHLVYCYHqnJq5BH4in41J2H66H3lQ5lBjbH9j0RTeZdPQD221hODGh
         Iv5/eyE2dsPv6fex7sD4nHlXNpHHZmgfQz0lS0nXooLHCp3HohUhDfwUWAcr+iTFC59S
         FbJddAFOQuaY0jyfQQbDzYZpTBebXz5pgCjkyPjd5onHxstA5umHJw0ZCAQnKzdDiiHz
         X9RGHm8E1tgm5O2d4dc0xmk+lUvRVPreTOFK65EQ6/gT7oYLlLR2bEzRoqpcBUNklx2L
         TK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SVCjqDHQqYCSsdkNdNN1XB9RoNL1bSBh2I71TfFJ/Ag=;
        b=GaA4/ygdeglZgXyGkKoMBAOSC4tcwcbLS1eGfQha/mKygU+Urf6tnp5xJpj14XTxB/
         QHv81EE6j4z19f5ohS4unP0TGjl+FpVz8cXhjys4BDiynk8bPrkyTCbOlgOOGRPOiToc
         5nn3Lssx2S/UvrDsBusc5LAVhI0k5rZ8w/zQ536426WrsgDICzc1pYT4gRHOttRpTyvm
         lv5bSyESAbu+E13t2j2yauuT1vqcuolZxCawJL0VXr2vJSRKrrtmC63sHuJRTAIf9R2o
         sMO49CBgZGfQG0kdl5P3zC/wct8WxsWZ6j+W0Wj0+k7iyNvj4wrzjXRya5wWbfnjp8fO
         gMxQ==
X-Gm-Message-State: AG10YOQKL5Ev8xC7Qch5W/5TaHvZn2feILtKaNzqOFLkcaRGv0QApdBijbMrKxBG342Y6w==
X-Received: by 10.66.100.196 with SMTP id fa4mr31108144pab.37.1455629485503;
        Tue, 16 Feb 2016 05:31:25 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id yl1sm46048087pac.35.2016.02.16.05.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:31:49 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286390>

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
index b261e11..f45a425 100644
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
@@ -445,6 +446,44 @@ static int list(int ac, const char **av, const cha=
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
@@ -461,5 +500,7 @@ int cmd_worktree(int ac, const char **av, const cha=
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
index 099d52e..c9a8d04 100644
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
2.7.0.377.g4cd97dd
