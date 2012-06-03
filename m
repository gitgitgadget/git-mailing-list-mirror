From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv6 1/4] wt-status.*: better advices for git status added
Date: Sun,  3 Jun 2012 20:30:14 +0200
Message-ID: <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 20:30:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbFZM-0007Ip-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 20:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab2FCSaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 14:30:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41266 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab2FCSaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 14:30:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q53ILdns012773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 20:21:39 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q53IUHVF013538;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q53IUHvW017049;
	Sun, 3 Jun 2012 20:30:17 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q53IUHJa017048;
	Sun, 3 Jun 2012 20:30:17 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 03 Jun 2012 20:21:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53ILdns012773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339352501.43692@yEkTEyXKBCPOPQ0nE23GzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199092>

This patch provides new informative help messages in the display of
'git status' (at the top) during conflicts, rebase, am, bisect or
cherry-pick process.

The new messages are not shown when using options such as -s or
--porcelain. The messages about the current situation of the user are
always displayed but the advices on what the user needs to do in order
to resume a rebase/bisect/am/commit after resolving conflicts can be
hidden by setting advice.statushints to 'false' in the config file.

Thus, information about the updated advice.statushints key are added
in Documentation/config.txt.

Also, the test t7060-wt-status.sh is now working with the new help
messages. Tests about suggestions of "git rm" are also added.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
---
The new advices that are protected by the key advice.statushints are
now stated the same way the other messages protected by the same config
key are.

 Documentation/config.txt |    4 +
 t/t7060-wtstatus.sh      |   67 +++++++++++++++++++
 wt-status.c              |  165 ++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h              |   11 +++
 4 files changed, 247 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..670945d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -162,6 +162,10 @@ advice.*::
 		Directions on how to stage/unstage/add shown in the
 		output of linkgit:git-status[1] and the template shown
 		when writing commit messages.
+		Show directions on how to proceed from the current
+		state in the output of linkgit:git-status[1] and in
+		the template shown when writing commit messages in
+		linkgit:git-commit[1].
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index b8cb490..61d1f38 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -30,6 +30,9 @@ test_expect_success 'Report new path with conflict' '
 
 cat >expect <<EOF
 # On branch side
+# You have unmerged paths.
+#   (fix conflicts and run "git commit")
+#
 # Unmerged paths:
 #   (use "git add/rm <file>..." as appropriate to mark resolution)
 #
@@ -118,4 +121,68 @@ test_expect_success 'git diff-index --cached -C shows 2 copies + 1 unmerged' '
 	test_cmp expected actual
 '
 
+
+test_expect_success 'status when conflicts with add and rm advice (deleted by them)' '
+	git init git &&
+	(
+		cd git &&
+		test_commit init main.txt init &&
+		git checkout -b second_branch &&
+		git rm main.txt &&
+		git commit -m "main.txt deleted on second_branch" &&
+		test_commit second conflict.txt second &&
+		git checkout master &&
+		test_commit on_second main.txt on_second &&
+		test_commit master conflict.txt master &&
+		test_must_fail git merge second_branch &&
+		cat >expected <<-\EOF &&
+		# On branch master
+		# You have unmerged paths.
+		#   (fix conflicts and run "git commit")
+		#
+		# Unmerged paths:
+		#   (use "git add/rm <file>..." as appropriate to mark resolution)
+		#
+		#	both added:         conflict.txt
+		#	deleted by them:    main.txt
+		#
+		no changes added to commit (use "git add" and/or "git commit -a")
+		EOF
+		git status --untracked-files=no >actual &&
+		test_cmp expected actual
+	) &&
+	rm -rf git
+'
+
+
+test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
+	git init git &&
+	cd git &&
+	test_commit init main.txt init &&
+	git branch second_branch &&
+	git mv main.txt sub_master.txt &&
+	git commit -m "main.txt renamed in sub_master.txt" &&
+	git checkout second_branch &&
+	git mv main.txt sub_second.txt &&
+	git commit -m "main.txt renamed in sub_second.txt" &&
+	test_must_fail git merge master &&
+	cat >expected <<-\EOF &&
+	# On branch second_branch
+	# You have unmerged paths.
+	#   (fix conflicts and run "git commit")
+	#
+	# Unmerged paths:
+	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#
+	#	both deleted:       main.txt
+	#	added by them:      sub_master.txt
+	#	added by us:        sub_second.txt
+	#
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git status --untracked-files=no >actual &&
+	test_cmp expected actual
+'
+
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index dd6d8c4..2460e20 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -23,6 +23,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
+	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -728,6 +729,169 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
+static int has_unmerged(struct wt_status *s)
+{
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (d->stagemask)
+			return 1;
+	}
+	return 0;
+}
+
+static void show_merge_in_progress(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+	if (has_unmerged(s)) {
+		status_printf_ln(s, color, _("You have unmerged paths."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git commit\")"));
+	} else {
+		status_printf_ln(s, color,
+			_("All conflicts fixed but you are still merging."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (use \"git commit\" to conclude merge)"));
+	}
+	wt_status_print_trailer(s);
+}
+
+static void show_am_in_progress(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+	status_printf_ln(s, color,
+		_("You are in the middle of an am session."));
+	if (state->am_empty_patch) {
+		status_printf_ln(s, color,
+			_("The current patch is empty; run \"git am --skip\" to skip it."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (use \"git am --abort\" to restore the original branch)"));
+	} else if (advice_status_hints) {
+		status_printf_ln(s, color,
+			_("  (when you have fixed this problem run \"git am --resolved\")"));
+		status_printf_ln(s, color,
+			_("  (use \"git am --skip\" to skip this patch)"));
+		status_printf_ln(s, color,
+			_("  (use \"git am --abort\" to restore the original branch)"));
+	}
+	wt_status_print_trailer(s);
+}
+
+static void show_rebase_in_progress(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+	if (has_unmerged(s)) {
+		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (advice_status_hints) {
+			status_printf_ln(s, color,
+				_("  (fix conflicts and then run \"git rebase --continue\")"));
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --skip\" to skip this patch)"));
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --abort\" to check out the original branch)"));
+		}
+	} else if (state->rebase_in_progress) {
+		status_printf_ln(s, color, _("You are currently rebasing."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git rebase --continue\")"));
+	} else {
+		status_printf_ln(s, color, _("You are currently editing a commit during a rebase."));
+		if (advice_status_hints && !s->amend) {
+			status_printf_ln(s, color,
+				_("  (use \"git commit --amend\" to amend the current commit)"));
+			status_printf_ln(s, color,
+				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
+		}
+	}
+	wt_status_print_trailer(s);
+}
+
+static void show_cherry_pick_in_progress(struct wt_status *s,
+					struct wt_status_state *state,
+					const char *color)
+{
+	if (has_unmerged(s)) {
+		status_printf_ln(s, color, _("You are currently cherry-picking."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (fix conflicts and run \"git commit\")"));
+	} else {
+		status_printf_ln(s, color, _("You are currently cherry-picking."));
+		if (advice_status_hints)
+			status_printf_ln(s, color,
+				_("  (all conflicts fixed: run \"git commit\")"));
+	}
+	wt_status_print_trailer(s);
+}
+
+static void show_bisect_in_progress(struct wt_status *s,
+				struct wt_status_state *state,
+				const char *color)
+{
+	status_printf_ln(s, color, _("You are currently bisecting."));
+	if (advice_status_hints)
+		status_printf_ln(s, color,
+			_("  (use \"git bisect reset\" to get back to the original branch)"));
+	wt_status_print_trailer(s);
+}
+
+static void wt_status_print_state(struct wt_status *s)
+{
+	const char *state_color = color(WT_STATUS_IN_PROGRESS, s);
+	struct wt_status_state *state = calloc(1, sizeof(*state));
+	struct stat st;
+
+	state->merge_in_progress = 0;
+	state->am_in_progress = 0;
+	state->am_empty_patch = 0;
+	state->rebase_in_progress = 0;
+	state->rebase_interactive_in_progress = 0;
+	state->cherry_pick_in_progress = 0;
+	state->bisect_in_progress = 0;
+
+	if (!stat(git_path("MERGE_HEAD"), &st)) {
+		state->merge_in_progress = 1;
+	} else if (!stat(git_path("rebase-apply"), &st)) {
+		if (!stat(git_path("rebase-apply/applying"), &st)) {
+			state->am_in_progress = 1;
+			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
+				state->am_empty_patch = 1;
+		} else {
+			state->rebase_in_progress = 1;
+		}
+	} else if (!stat(git_path("rebase-merge"), &st)) {
+		if (!stat(git_path("rebase-merge/interactive"), &st))
+			state->rebase_interactive_in_progress = 1;
+		else
+			state->rebase_in_progress = 1;
+	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
+		state->cherry_pick_in_progress = 1;
+	}
+	if (!stat(git_path("BISECT_LOG"), &st))
+		state->bisect_in_progress = 1;
+
+	if (state->merge_in_progress)
+		show_merge_in_progress(s, state, state_color);
+	else if (state->am_in_progress)
+		show_am_in_progress(s, state, state_color);
+	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
+		show_rebase_in_progress(s, state, state_color);
+	else if (state->cherry_pick_in_progress)
+		show_cherry_pick_in_progress(s, state, state_color);
+	if (state->bisect_in_progress)
+		show_bisect_in_progress(s, state, state_color);
+	free(state);
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
@@ -750,6 +914,7 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_print_state(s);
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
diff --git a/wt-status.h b/wt-status.h
index 14aa9f7..c1066a0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ enum color_wt_status {
 	WT_STATUS_LOCAL_BRANCH,
 	WT_STATUS_REMOTE_BRANCH,
 	WT_STATUS_ONBRANCH,
+	WT_STATUS_IN_PROGRESS,
 	WT_STATUS_MAXSLOT
 };
 
@@ -71,6 +72,16 @@ struct wt_status {
 	struct string_list ignored;
 };
 
+struct wt_status_state {
+	int merge_in_progress;
+	int am_in_progress;
+	int am_empty_patch;
+	int rebase_in_progress;
+	int rebase_interactive_in_progress;
+	int cherry_pick_in_progress;
+	int bisect_in_progress;
+};
+
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
-- 
1.7.8
