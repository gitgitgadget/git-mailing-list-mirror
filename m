From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 2/4] status: differentiate interactive from non-interactive rebases
Date: Tue, 30 Jun 2015 15:01:13 +0200
Message-ID: <1435669275-32102-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 15:01:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vAV-0005e9-3c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbbF3NBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 09:01:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56315 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbbF3NB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:01:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1KPA004205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 15:01:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1LMf024076;
	Tue, 30 Jun 2015 15:01:21 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9vA9-0000Bv-Px; Tue, 30 Jun 2015 15:01:21 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 15:01:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UD1KPA004205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436274082.80988@ZL3iEDDNEAu7V1jJaNXKJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273058>

=46rom: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-inp.fr>

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7512-status-help.sh | 28 ++++++++++++++--------------
 wt-status.c            |  5 ++++-
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 68ad2d7..190656d 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -136,7 +136,7 @@ test_expect_success 'status during rebase -i when c=
onflicts unresolved' '
 	ONTO=3D$(git rev-parse --short rebase_i_conflicts) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (fix conflicts and then run "git rebase --continue")
   (use "git rebase --skip" to skip this patch)
@@ -162,7 +162,7 @@ test_expect_success 'status during rebase -i after =
resolving conflicts' '
 	test_must_fail git rebase -i rebase_i_conflicts &&
 	git add main.txt &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on=
 '\''$ONTO'\''.
   (all conflicts fixed: run "git rebase --continue")
=20
@@ -190,7 +190,7 @@ test_expect_success 'status when rebasing -i in edi=
t mode' '
 	ONTO=3D$(git rev-parse --short HEAD~2) &&
 	git rebase -i HEAD~2 &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''rebase_i_=
edit'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -216,7 +216,7 @@ test_expect_success 'status when splitting a commit=
' '
 	git rebase -i HEAD~3 &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''split_c=
ommit'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -247,7 +247,7 @@ test_expect_success 'status after editing the last =
commit with --amend during a
 	git rebase -i HEAD~3 &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''amend_las=
t'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -277,7 +277,7 @@ test_expect_success 'status: (continue first edit) =
second edit' '
 	git rebase -i HEAD~3 &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -299,7 +299,7 @@ test_expect_success 'status: (continue first edit) =
second edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -326,7 +326,7 @@ test_expect_success 'status: (continue first edit) =
second edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "foo" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -348,7 +348,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit' '
 	git commit --amend -m "a" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -371,7 +371,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -399,7 +399,7 @@ test_expect_success 'status: (amend first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "d" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -423,7 +423,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit' '
 	git commit -m "e" &&
 	git rebase --continue &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
@@ -448,7 +448,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and split' '
 	git rebase --continue &&
 	git reset HEAD^ &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently splitting a commit while rebasing branch '\''several=
_edits'\'' on '\''$ONTO'\''.
   (Once your working directory is clean, run "git rebase --continue")
=20
@@ -478,7 +478,7 @@ test_expect_success 'status: (split first edit) sec=
ond edit and amend' '
 	git rebase --continue &&
 	git commit --amend -m "h" &&
 	cat >expected <<EOF &&
-rebase in progress; onto $ONTO
+interactive rebase in progress; onto $ONTO
 You are currently editing a commit while rebasing branch '\''several_e=
dits'\'' on '\''$ONTO'\''.
   (use "git commit --amend" to amend the current commit)
   (use "git rebase --continue" once you are satisfied with your change=
s)
diff --git a/wt-status.c b/wt-status.c
index 8c4b806..81610dc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1328,7 +1328,10 @@ void wt_status_print(struct wt_status *s)
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progres=
s) {
-				on_what =3D _("rebase in progress; onto ");
+				if (state.rebase_interactive_in_progress)
+					on_what =3D _("interactive rebase in progress; onto ");
+				else
+					on_what =3D _("rebase in progress; onto ");
 				branch_name =3D state.onto;
 			} else if (state.detached_from) {
 				branch_name =3D state.detached_from;
--=20
2.5.0.rc0.10.g7792c2a
