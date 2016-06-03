From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 5/6] worktree: add "unlock" command
Date: Fri,  3 Jun 2016 19:19:43 +0700
Message-ID: <20160603121944.28980-6-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Jun 03 14:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8o5n-0003Eg-2C
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbcFCMUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 08:20:37 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33685 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbcFCMUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 08:20:35 -0400
Received: by mail-pa0-f67.google.com with SMTP id di3so5914721pab.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFmwzMtmBLqDi6B3x80BSYUWVqCMNCxkInWTAW/Q4Rk=;
        b=acdoOOoEVsV03S5JF6XHFkJ+XxaoieJw5F1Nia4COj53x1cgWn76zk8jkBJD+Hwqow
         +wA7Vn0WlkjyLzE9+R1v5E3ebHLYmKrr6iJfkZuyxxz6ksGV5RNuneimLNX5OB/UucwS
         twsoWpnKiFE1AFwf64dc2q8rzDqRJ8bOn9a6BLengcyVFi7dhbmYNBxYgn5BaUlp5c86
         DocMgge6zPLB+ZUiJN6rWcuoVTcHiZQ5s05SCuzY0tysZ/nwihXlfiFHWi6atdbaG2jo
         8lQumCV/4iiZvY+zlqvQPjaTpc0K585I/VZEH7syYPDdpjcQMITSY/dq3maUV+ZkM9IG
         KGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFmwzMtmBLqDi6B3x80BSYUWVqCMNCxkInWTAW/Q4Rk=;
        b=P16LJqf828juBp6br74fu2Z+gIYNg5TSrZClYvxSULaOKkJdX8/wvDmowEZ27deHhN
         qcM86k1uQCCEPKfjz1HqkkTGd9vL4DX/rVZ6UYUEJ9QU+NDEXtBE/DDyBaKE7c1QAObc
         sqCIS0W+6RVwVfdjftNxXIGZLDOniROicW0iyo0c7xSyufiWChUZKgPevOGVfrw3+bjs
         xQxu1jY3Byl8CozEyv4Y6AeAcciSzoqIsvFJ8u3a557bj3ss5tp0hmOQpFqbnCVDXtAP
         gAOegJQJ00sFycjqRkRkWPK5dR4cDcFAqyKvPRKCGXKxC7Jnoav7si4mEYOKeMEzO2JN
         OrOQ==
X-Gm-Message-State: ALyK8tKx5WZ9aUuH99cyU3KvQil3gjHNeP+fAAw/ILbHiw3uYnPqyjfa/aopsPtIlQHCiA==
X-Received: by 10.66.168.109 with SMTP id zv13mr4927045pab.10.1464956434619;
        Fri, 03 Jun 2016 05:20:34 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 74sm8235778pfv.8.2016.06.03.05.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 05:20:33 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 03 Jun 2016 19:20:29 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160603121944.28980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296312>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt         |  5 +++++
 builtin/worktree.c                     | 28 ++++++++++++++++++++++++++=
++
 contrib/completion/git-completion.bash |  2 +-
 t/t2028-worktree-move.sh               | 14 ++++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index d233d61..317c7d2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
+'git worktree unlock' <worktree>
=20
 DESCRIPTION
 -----------
@@ -74,6 +75,10 @@ prune::
=20
 Prune working tree information in $GIT_DIR/worktrees.
=20
+unlock::
+
+Unlock a working tree, allowing it to be pruned, moved or deleted.
+
 OPTIONS
 -------
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b686c7f..6d30c55 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,6 +16,7 @@ static const char * const worktree_usage[] =3D {
 	N_("git worktree list [<options>]"),
 	N_("git worktree lock [<options>] <path>"),
 	N_("git worktree prune [<options>]"),
+	N_("git worktree unlock <path>"),
 	NULL
 };
=20
@@ -498,6 +499,31 @@ static int lock_worktree(int ac, const char **av, =
const char *prefix)
 	return 0;
 }
=20
+static int unlock_worktree(int ac, const char **av, const char *prefix=
)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct worktree **worktrees, *wt;
+	int ret;
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
+	if (!is_worktree_locked(wt))
+		die(_("'%s' is not locked"), av[0]);
+	ret =3D unlink_or_warn(git_common_path("worktrees/%s/locked", wt->id)=
);
+	free_worktrees(worktrees);
+	return ret;
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] =3D {
@@ -516,5 +542,7 @@ int cmd_worktree(int ac, const char **av, const cha=
r *prefix)
 		return list(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "lock"))
 		return lock_worktree(ac - 1, av + 1, prefix);
+	if (!strcmp(av[1], "unlock"))
+		return unlock_worktree(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
 }
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 61ef18d..d90e571 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2598,7 +2598,7 @@ _git_whatchanged ()
=20
 _git_worktree ()
 {
-	local subcommands=3D"add list lock prune"
+	local subcommands=3D"add list lock prune unlock"
 	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 87afc2e..68d3fe8 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -45,4 +45,18 @@ test_expect_success 'lock worktree twice (from the l=
ocked worktree)' '
 	test_cmp expected .git/worktrees/source/locked
 '
=20
+test_expect_success 'unlock main worktree' '
+	test_must_fail git worktree unlock .
+'
+
+test_expect_success 'unlock linked worktree' '
+	git worktree unlock source &&
+	test_path_is_missing .git/worktrees/source/locked
+'
+
+test_expect_success 'unlock worktree twice' '
+	test_must_fail git worktree unlock source &&
+	test_path_is_missing .git/worktrees/source/locked
+'
+
 test_done
--=20
2.8.2.524.g6ff3d78
