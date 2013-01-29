From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] status: show branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 19:10:50 +0700
Message-ID: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 13:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0A1V-00047M-8k
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab3A2MKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 07:10:23 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:49294 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab3A2MKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 07:10:21 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so247340pbc.39
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 04:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2Zp5ADjS6k2Clj/1Wquc+4hQJR3N8lF+9Xxf+duKq3E=;
        b=0ry6ZqOJN2ONbBC3GAesyqwLr0l52mzro/HVt3En7k3smL/gh3KiIPPKlmNCqZgYpB
         ertTIOE53elQKGtC/Pt29V73bgjSJdpHt8j7uxstQ7zclTU3PnWFJ+eXCaVc/elFmr8i
         tuCeOi+h1cpKUus+jFhfGthvf4bEVo/wT9q8wzoWsIPhpgExwGTDDHIRUBLf0BUXbpvR
         vhRlB/3bgif9hsA33jKg7jntGPmy3cv7fyV9hOAWN7RHVjCdUkAP68cSokxRkJFl/WnS
         3QBxVUUwRsnvhaa6X5sNvCMg/SLfVa1nOiG4rgTe6lcclexxQCnOfcKZdE3fcex6eC4K
         pCPw==
X-Received: by 10.68.189.35 with SMTP id gf3mr1817771pbc.69.1359461420620;
        Tue, 29 Jan 2013 04:10:20 -0800 (PST)
Received: from lanh ([115.74.36.51])
        by mx.google.com with ESMTPS id oi2sm8297852pbb.62.2013.01.29.04.10.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 04:10:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jan 2013 19:10:53 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214932>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Seems like a good thing to do.

 t/t7512-status-help.sh | 36 +++++++++++++++----------------
 wt-status.c            | 58 ++++++++++++++++++++++++++++++++++++++++++=
--------
 wt-status.h            |  1 +
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index b3f6eb9..096ba6f 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress b=
efore resolving conflicts'
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing '\''rebase_conflicts'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -102,7 +102,7 @@ test_expect_success 'status when rebase in progress=
 before rebase --continue' '
 	git add main.txt &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing '\''rebase_conflicts'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -133,7 +133,7 @@ test_expect_success 'status during rebase -i when c=
onflicts unresolved' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing '\''rebase_i_conflicts_second'\''.
 	#   (fix conflicts and then run "git rebase --continue")
 	#   (use "git rebase --skip" to skip this patch)
 	#   (use "git rebase --abort" to check out the original branch)
@@ -158,7 +158,7 @@ test_expect_success 'status during rebase -i after =
resolving conflicts' '
 	git add main.txt &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing '\''rebase_i_conflicts_second'\''.
 	#   (all conflicts fixed: run "git rebase --continue")
 	#
 	# Changes to be committed:
@@ -185,7 +185,7 @@ test_expect_success 'status when rebasing -i in edi=
t mode' '
 	git rebase -i HEAD~2 &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''rebase_i_edit=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -210,7 +210,7 @@ test_expect_success 'status when splitting a commit=
' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing '\''split_commi=
t'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -240,7 +240,7 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	git commit --amend -m "foo" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''amend_last'\'=
'.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -269,7 +269,7 @@ test_expect_success 'status: (continue first edit) =
second edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -290,7 +290,7 @@ test_expect_success 'status: (continue first edit) =
second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing '\''several_edi=
ts'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -316,7 +316,7 @@ test_expect_success 'status: (continue first edit) =
second edit and amend' '
 	git commit --amend -m "foo" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -337,7 +337,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -359,7 +359,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing '\''several_edi=
ts'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -386,7 +386,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	git commit --amend -m "d" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -409,7 +409,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	git rebase --continue &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -433,7 +433,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit during a rebase.
+	# You are currently splitting a commit while rebasing '\''several_edi=
ts'\''.
 	#   (Once your working directory is clean, run "git rebase --continue=
")
 	#
 	# Changes not staged for commit:
@@ -462,7 +462,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	git commit --amend -m "h" &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently editing a commit during a rebase.
+	# You are currently editing a commit while rebasing '\''several_edits=
'\''.
 	#   (use "git commit --amend" to amend the current commit)
 	#   (use "git rebase --continue" once you are satisfied with your cha=
nges)
 	#
@@ -558,7 +558,7 @@ test_expect_success 'status when bisecting' '
 	git bisect good one_bisect &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently bisecting.
+	# You are currently bisecting '\''bisect'\''.
 	#   (use "git bisect reset" to get back to the original branch)
 	#
 	nothing to commit (use -u to show untracked files)
@@ -580,7 +580,7 @@ test_expect_success 'status when rebase conflicts w=
ith statushints disabled' '
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently rebasing.
+	# You are currently rebasing '\''statushints_disabled'\''.
 	#
 	# Unmerged paths:
 	#	both modified:      main.txt
diff --git a/wt-status.c b/wt-status.c
index d7cfe8f..cc7e2d7 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -872,7 +872,13 @@ static void show_rebase_in_progress(struct wt_stat=
us *s,
 	struct stat st;
=20
 	if (has_unmerged(s)) {
-		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently rebasing '%s'."),
+					 state->branch);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently rebasing."));
 		if (advice_status_hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
@@ -882,17 +888,35 @@ static void show_rebase_in_progress(struct wt_sta=
tus *s,
 				_("  (use \"git rebase --abort\" to check out the original branch)=
"));
 		}
 	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), =
&st)) {
-		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently rebasing '%s'."),
+					 state->branch);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently rebasing."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
-		status_printf_ln(s, color, _("You are currently splitting a commit d=
uring a rebase."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently splitting a commit while rebasing '%s'."),
+					 state->branch);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently splitting a commit during a rebase."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --con=
tinue\")"));
 	} else {
-		status_printf_ln(s, color, _("You are currently editing a commit dur=
ing a rebase."));
+		if (state->branch)
+			status_printf_ln(s, color,
+					 _("You are currently editing a commit while rebasing '%s'."),
+					 state->branch);
+		else
+			status_printf_ln(s, color,
+					 _("You are currently editing a commit during a rebase."));
 		if (advice_status_hints && !s->amend) {
 			status_printf_ln(s, color,
 				_("  (use \"git commit --amend\" to amend the current commit)"));
@@ -923,7 +947,7 @@ static void show_bisect_in_progress(struct wt_statu=
s *s,
 				struct wt_status_state *state,
 				const char *color)
 {
-	status_printf_ln(s, color, _("You are currently bisecting."));
+	status_printf_ln(s, color, _("You are currently bisecting '%s'."), st=
ate->branch);
 	if (advice_status_hints)
 		status_printf_ln(s, color,
 			_("  (use \"git bisect reset\" to get back to the original branch)"=
));
@@ -935,6 +959,7 @@ static void wt_status_print_state(struct wt_status =
*s)
 	const char *state_color =3D color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
 	struct stat st;
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	memset(&state, 0, sizeof(state));
=20
@@ -947,28 +972,43 @@ static void wt_status_print_state(struct wt_statu=
s *s)
 				state.am_empty_patch =3D 1;
 		} else {
 			state.rebase_in_progress =3D 1;
+			strbuf_read_file(&sb, git_path("rebase-apply/head-name"), 0);
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
 			state.rebase_interactive_in_progress =3D 1;
 		else
 			state.rebase_in_progress =3D 1;
+		strbuf_read_file(&sb, git_path("rebase-merge/head-name"), 0);
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
 		state.cherry_pick_in_progress =3D 1;
 	}
-	if (!stat(git_path("BISECT_LOG"), &st))
+	if (!stat(git_path("BISECT_LOG"), &st)) {
+		strbuf_read_file(&sb, git_path("BISECT_START"), 0);
 		state.bisect_in_progress =3D 1;
+	}
=20
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
 	else if (state.am_in_progress)
 		show_am_in_progress(s, &state, state_color);
-	else if (state.rebase_in_progress || state.rebase_interactive_in_prog=
ress)
+	else if (state.rebase_in_progress || state.rebase_interactive_in_prog=
ress) {
+		while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+			strbuf_setlen(&sb, sb.len - 1);
+		if (!prefixcmp(sb.buf, "refs/heads/"))
+			state.branch =3D sb.buf + strlen("refs/heads/");
+		else if (!prefixcmp(sb.buf, "refs/"))
+			state.branch =3D sb.buf;
 		show_rebase_in_progress(s, &state, state_color);
-	else if (state.cherry_pick_in_progress)
+	} else if (state.cherry_pick_in_progress)
 		show_cherry_pick_in_progress(s, &state, state_color);
-	if (state.bisect_in_progress)
+	if (state.bisect_in_progress) {
+		while (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
+			strbuf_setlen(&sb, sb.len - 1);
+		state.branch =3D sb.buf;
 		show_bisect_in_progress(s, &state, state_color);
+	}
+	strbuf_release(&sb);
 }
=20
 void wt_status_print(struct wt_status *s)
diff --git a/wt-status.h b/wt-status.h
index 236b41f..c5eae29 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -79,6 +79,7 @@ struct wt_status_state {
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
+	const char *branch;
 };
=20
 void wt_status_prepare(struct wt_status *s);
--=20
1.8.1.1.459.g5970e58
