From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Tue, 26 May 2015 23:38:37 +0200
Message-ID: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 23:45:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMfP-0003HN-0D
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 23:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbbEZVpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 17:45:39 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:33136 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbbEZVpi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 17:45:38 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 17:45:37 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 82CA44882C;
	Tue, 26 May 2015 23:38:41 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nX4X+7X1xcus; Tue, 26 May 2015 23:38:41 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 661F848813;
	Tue, 26 May 2015 23:38:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 5EDFF20D8;
	Tue, 26 May 2015 23:38:41 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z9bgxvFkxgWO; Tue, 26 May 2015 23:38:41 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 3D4A420D4;
	Tue, 26 May 2015 23:38:41 +0200 (CEST)
X-Mailer: git-send-email 2.4.1.174.g28bfe8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269982>

Instead of removing a line to remove the commit, you can use the key
word "drop" (just like "pick" or "edit"). It has the same effect as
deleting the line (removing the commit) except that you keep a visual
trace of your actions, allowing a better control and reducing the
possibility of removing a commit by mistake.

Signed-off-by: Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp=
=2Efr>
---
 Documentation/git-rebase.txt  |  3 +++
 git-rebase--interactive.sh    |  4 ++++
 t/lib-rebase.sh               |  4 ++--
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 1d01baa..3cd2ef2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -514,6 +514,9 @@ rebasing.
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
=20
+If you want to remove a commit, replace the command "pick" by the
+command "drop".
+
 If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..cb749e8 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -152,6 +152,7 @@ Commands:
  s, squash =3D use commit, but meld into previous commit
  f, fixup =3D like "squash", but discard this commit's log message
  x, exec =3D run command (the rest of the line) using shell
+ d, drop =3D remove commit
=20
 These lines can be re-ordered; they are executed from top to bottom.
=20
@@ -515,6 +516,9 @@ do_next () {
 		do_pick $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
+	drop|d)
+		mark_action_done
+		;;
 	reword|r)
 		comment_for_reflog reword
=20
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6bd2522..fdbc900 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -14,7 +14,7 @@
 #       specified line.
 #
 #   "<cmd> <lineno>" -- add a line with the specified command
-#       ("squash", "fixup", "edit", or "reword") and the SHA1 taken
+#       ("squash", "fixup", "edit", "reword" or "drop") and the SHA1 t=
aken
 #       from the specified line.
 #
 #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
@@ -46,7 +46,7 @@ set_fake_editor () {
 	action=3Dpick
 	for line in $FAKE_LINES; do
 		case $line in
-		squash|fixup|edit|reword)
+		squash|fixup|edit|reword|drop)
 			action=3D"$line";;
 		exec*)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ac429a0..1bad068 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,4 +1102,15 @@ test_expect_success 'rebase -i commits that over=
write untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
 '
=20
+test_expect_success 'drop' '
+	git checkout master &&
+	test_when_finished "git checkout master" &&
+	git checkout -b dropBranchTest master &&
+	set_fake_editor &&
+	FAKE_LINES=3D"1 drop 2 3 drop 4 5" git rebase -i --root &&
+	test E =3D $(git cat-file commit HEAD | sed -ne \$p) &&
+	test C =3D $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test A =3D $(git cat-file commit HEAD^^ | sed -ne \$p)
+'
+
 test_done
--=20
2.4.1.174.g28bfe8e
