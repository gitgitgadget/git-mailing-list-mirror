From: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Mon, 28 May 2012 19:36:37 +0200
Message-ID: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 19:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ3sF-0006Rn-3E
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 19:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2E1Rgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 13:36:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60979 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab2E1Rgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 13:36:42 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4SHSL1M021541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 19:28:21 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4SHadW2010773;
	Mon, 28 May 2012 19:36:39 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4SHadLi016300;
	Mon, 28 May 2012 19:36:39 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4SHackf016299;
	Mon, 28 May 2012 19:36:38 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 May 2012 19:28:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4SHSL1M021541
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338830903.01617@AzmeB3eiB8aG1BAOTizg6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198711>

This patch provides new warning messages in the display of
'git status' (at the top) during conflicts, rebase, am
and bisect process. These messages can be shortened by setting
the new advice.* config key called advice.statushelp to false.

Thus, information about the new advice.* key are added in
Documentation/config.txt

Also, the test t7060-wt-status.sh is now working with the
new warning messages.

Signed-off-by: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Jonas Franck <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Nguyen Huynh Khoi Nguyen Lucien <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
---
The new messages are not shown when using options such as
-s or --porcelain.It figures the current state by finding 
the files generated in .git in each case (during an am, 
a rebase, a bisect etc.). The messages about the current
situation of the user are always displayed but the advices 
on what the user needs to do in order to resume a rebase/bisect
/am/ commit after resolving conflicts can be hidden by setting advice.statushelp to 'false' in the config file.

 Documentation/config.txt |    4 ++
 advice.c                 |    2 +
 advice.h                 |    1 +
 t/t7060-wtstatus.sh      |    2 +
 wt-status.c              |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h              |    1 +
 6 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..6504371 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -176,6 +176,10 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	statusHelp::
+		Directions on how to end the current process shown
+		in the output of linkgit:git-status[1].
+
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index a492eea..31deb31 100644
--- a/advice.c
+++ b/advice.c
@@ -9,6 +9,7 @@ int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
+int advice_status_help = 1;
 
 static struct {
 	const char *name;
@@ -23,6 +24,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "statushelp", &advice_status_help },
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index f3cdbbf..5fd3cce 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_status_help;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index b8cb490..d9a1e18 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -30,6 +30,8 @@ test_expect_success 'Report new path with conflict' '
 
 cat >expect <<EOF
 # On branch side
+# You have unmerged paths: fix conflicts and then commit the result.
+#
 # Unmerged paths:
 #   (use "git add/rm <file>..." as appropriate to mark resolution)
 #
diff --git a/wt-status.c b/wt-status.c
index dd6d8c4..093a352 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -23,6 +23,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
+	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -728,6 +729,109 @@ static void wt_status_print_tracking(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
 
+static void wt_status_print_in_progress(struct wt_status *s)
+{
+	int i;
+	const char *c = color(WT_STATUS_IN_PROGRESS, s);
+	struct stat st;
+	int merge_in_progress = 0;
+	int rebase_state = 0;
+	int rebase_interactive_state = 0;
+	int am_state = 0;
+	int am_wrong_format_state = 0;
+	int bisect_state = 0;
+	int unmerged_present = 0;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		d = s->change.items[i].util;
+		if (d->stagemask) {
+			unmerged_present = 1;
+			break;
+		}
+	}
+
+	if (!stat(git_path("MERGE_HEAD"), &st))
+		merge_in_progress = 1;
+	else {
+		if (!stat(git_path("rebase-apply"), &st)) {
+			if (!stat(git_path("rebase-apply/applying"), &st))
+				am_state = 1;
+				if (!stat(git_path("rebase-apply/patch"), &st) && !(st.st_size))
+					am_wrong_format_state = 1;
+			else
+				rebase_state = 1;
+		}
+		else {
+			if (!stat(git_path("rebase-merge"), &st)) {
+				if (!stat(git_path("rebase-merge/interactive"), &st))
+					rebase_interactive_state = 1;
+				else
+					rebase_state = 1;
+			}
+		}
+	}
+
+	if (!stat(git_path("BISECT_LOG"), &st))
+		bisect_state = 1;
+
+	if(merge_in_progress) {
+		if (unmerged_present)
+			status_printf_ln(s, c, _("You have unmerged paths: fix conflicts and then commit the result."));
+		else
+			status_printf_ln(s, c, _("You are still merging, run \"git commit\" to conclude merge."));
+		wt_status_print_trailer(s);
+	}
+	else {
+		if(am_state) {
+			status_printf_ln(s, c, _("You are currently in am progress:"));
+			if(am_wrong_format_state)
+				status_printf_ln(s, c, _("One of the patches is empty or corrupted !"));
+			if (advice_status_help) {
+				status_printf_ln(s, c, _("When you have resolved this problem run \"git am --resolved\"."));
+				status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git am --skip\"."));
+				status_printf_ln(s, c, _("To restore the original branch and stop patching run \"git am --abort\"."));
+			}
+			wt_status_print_trailer(s);
+		}
+
+		else if (rebase_state || rebase_interactive_state) {
+			if (unmerged_present) {
+				status_printf_ln(s, c, _("You are currently rebasing%s"),
+				advice_status_help
+				? _(": fix conflicts and then run \"git rebase -- continue\".") : ".");
+				if (advice_status_help) {
+					status_printf_ln(s, c, _("If you would prefer to skip this patch, instead run \"git rebase --skip\"."));
+					status_printf_ln(s, c, _("To check out  the original branch and stop rebasing run \"git rebase --abort\"."));
+				}
+			}
+			else {
+				if (rebase_state)
+					status_printf_ln(s, c, _("You are currently rebasing: all conflicts fixed%s"),
+					advice_status_help
+					? _(": run \"git rebase --continue\".") : ".");
+				else {
+					status_printf_ln(s, c, _("You are currently editing a commit during a rebase."));
+					if (advice_status_help) {
+						status_printf_ln(s, c, _("You can amend the commit with"));
+						status_printf_ln(s, c, _("	git commit --amend"));
+						status_printf_ln(s, c, _("Once you are satisfied with your changes, run"));
+						status_printf_ln(s, c, _("	git rebase --continue"));
+					}
+				}
+			}
+			wt_status_print_trailer(s);
+		}
+	}
+
+	if(bisect_state) {
+		status_printf_ln(s, c, _("You are currently bisecting."));
+		if (advice_status_help)
+		status_printf_ln(s, c, _("To get back to the original branch run \"git bisect reset\""));
+		wt_status_print_trailer(s);
+	}
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
@@ -750,6 +854,8 @@ void wt_status_print(struct wt_status *s)
 			wt_status_print_tracking(s);
 	}
 
+	wt_status_print_in_progress(s);
+
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
diff --git a/wt-status.h b/wt-status.h
index 14aa9f7..0556669 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,6 +15,7 @@ enum color_wt_status {
 	WT_STATUS_LOCAL_BRANCH,
 	WT_STATUS_REMOTE_BRANCH,
 	WT_STATUS_ONBRANCH,
+	WT_STATUS_IN_PROGRESS,
 	WT_STATUS_MAXSLOT
 };
 
-- 
1.7.8
