From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv10 3/4] status: don't suggest "git rm" or "git add" if not appropriate
Date: Sun, 10 Jun 2012 13:17:37 +0200
Message-ID: <1339327058-29371-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339327058-29371-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 13:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdgAA-0005O2-Sh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 13:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab2FJLSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 07:18:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60594 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab2FJLRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 07:17:42 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5AB8dqF022370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 13:08:39 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5ABHd2p012115;
	Sun, 10 Jun 2012 13:17:39 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5ABHd6i029463;
	Sun, 10 Jun 2012 13:17:39 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5ABHd3Q029458;
	Sun, 10 Jun 2012 13:17:39 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339327058-29371-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 13:08:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5AB8dqF022370
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339931319.66156@RFP4qPSA4L8OJ7wCGVfxbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199589>

The display of the advice '(use git add/rm [...])' (when there are
unmerged files) after running 'git status' is now depending of the
mark, whether it's 'both deleted', 'deleted by us/them' or others. For
instance, when there is just one file that's marked as 'both deleted',
'git status' shows '(use git rm [...])' and if there are two files,
one as 'both deleted' and the other as 'added by them', the advice is
'(use git add/rm [...])'.

The previous tests in t7512-status-help.sh are updated.

Test about the case of only 'both deleted' is added in
t7060-wtstatus.sh

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
part 3/4 unchanged since v9.

 t/t7060-wtstatus.sh    |   36 ++++++++++++++++++++++++++++++++++--
 t/t7512-status-help.sh |    8 ++++----
 wt-status.c            |   37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index e8c3690..f4f38a5 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -152,7 +152,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
 '
 
 
-test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
+test_expect_success 'prepare for conflicts' '
 	git reset --hard &&
 	git checkout -b conflict &&
 	test_commit one main.txt one &&
@@ -161,7 +161,11 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 	git commit -m "main.txt renamed in sub_master.txt" &&
 	git checkout conflict_second &&
 	git mv main.txt sub_second.txt &&
-	git commit -m "main.txt renamed in sub_second.txt" &&
+	git commit -m "main.txt renamed in sub_second.txt"
+'
+
+
+test_expect_success 'status when conflicts with add and rm advice (both deleted)' '
 	test_must_fail git merge conflict &&
 	cat >expected <<-\EOF &&
 	# On branch conflict_second
@@ -182,4 +186,32 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
 '
 
 
+test_expect_success 'status when conflicts with only rm advice (both deleted)' '
+	git reset --hard conflict_second &&
+	test_must_fail git merge conflict &&
+	git add sub_master.txt &&
+	git add sub_second.txt &&
+	cat >expected <<-\EOF &&
+	# On branch conflict_second
+	# You have unmerged paths.
+	#   (fix conflicts and run "git commit")
+	#
+	# Changes to be committed:
+	#
+	#	new file:   sub_master.txt
+	#
+	# Unmerged paths:
+	#   (use "git rm <file>..." to mark resolution)
+	#
+	#	both deleted:       main.txt
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual &&
+	git reset --hard &&
+	git checkout master
+'
+
+
 test_done
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 3714e8e..bdce192 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -30,7 +30,7 @@ test_expect_success 'status when conflicts unresolved' '
 	#   (fix conflicts and run "git commit")
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -83,7 +83,7 @@ test_expect_success 'status when rebase in progress before resolving conflicts'
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -140,7 +140,7 @@ test_expect_success 'status during rebase -i when conflicts unresolved' '
 	#
 	# Unmerged paths:
 	#   (use "git reset HEAD <file>..." to unstage)
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
@@ -336,7 +336,7 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
 	#   (fix conflicts and run "git commit")
 	#
 	# Unmerged paths:
-	#   (use "git add/rm <file>..." as appropriate to mark resolution)
+	#   (use "git add <file>..." to mark resolution)
 	#
 	#	both modified:      main.txt
 	#
diff --git a/wt-status.c b/wt-status.c
index 7548509..fcde045 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -131,9 +131,34 @@ void wt_status_prepare(struct wt_status *s)
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
 {
+	int i;
+	int del_mod_conflict = 0;
+	int both_deleted = 0;
+	int not_deleted = 0;
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	status_printf_ln(s, c, _("Unmerged paths:"));
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct string_list_item *it = &(s->change.items[i]);
+		struct wt_status_change_data *d = it->util;
+
+		switch (d->stagemask) {
+		case 0:
+			break;
+		case 1:
+			both_deleted = 1;
+			break;
+		case 3:
+		case 5:
+			del_mod_conflict = 1;
+			break;
+		default:
+			not_deleted = 1;
+			break;
+		}
+	}
+
 	if (!advice_status_hints)
 		return;
 	if (s->whence != FROM_COMMIT)
@@ -142,7 +167,17 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+
+	if (!both_deleted) {
+		if (!del_mod_conflict)
+			status_printf_ln(s, c, _("  (use \"git add <file>...\" to mark resolution)"));
+		else
+			status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+	} else if (!del_mod_conflict && !not_deleted) {
+		status_printf_ln(s, c, _("  (use \"git rm <file>...\" to mark resolution)"));
+	} else {
+		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
+	}
 	status_printf_ln(s, c, "");
 }
 
-- 
1.7.8
