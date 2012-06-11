From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv2] Warnings before rebasing -i published history
Date: Mon, 11 Jun 2012 12:04:51 +0200
Message-ID: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 12:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se1UZ-0000OD-Sr
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab2FKKEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 06:04:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59661 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812Ab2FKKEy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 06:04:54 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5B9tmCY014636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 11:55:48 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BA4quh010942;
	Mon, 11 Jun 2012 12:04:52 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5BA4pY3028836;
	Mon, 11 Jun 2012 12:04:51 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5BA4pbv028835;
	Mon, 11 Jun 2012 12:04:51 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 11:55:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5B9tmCY014636
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1340013348.49099@ZwsQALoOViddexpXDAjALw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199638>

"git rebase -i" can be very dangerous if used on an already published
history. This code detects that one is rewriting a commit that is an
ancestor of a remote-tracking branch, and warns the user through the
editor. This feature is controlled by a new config key
rebase.checkremoterefs.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/config.txt      |    5 +++++
 Documentation/git-rebase.txt  |    5 +++++
 git-rebase--interactive.sh    |   22 ++++++++++++++++++++++
 git-rebase.sh                 |    2 ++
 t/lib-rebase.sh               |   11 +++++++++++
 t/t3404-rebase-interactive.sh |   29 +++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..e47f6e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1753,6 +1753,11 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.checkremoterefs::
+	If it is set to 'true', git rebase -i will show after each
+	commit ancestor of a remote-tracking branch the name of these
+	branches through the editor.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..b68a80b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -208,6 +208,11 @@ rebase.stat::
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
+rebase.checkremoterefs::
+	If it is set to 'true', git rebase -i will show after each
+	commit ancestor of a remote-tracking branch the name of these
+	branches through the editor.
+
 OPTIONS
 -------
 <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..ad6f8a7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,27 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+# Add the name the branches after each pick, fixup or squash commit that
+# is an ancestor of a remote-tracking branch.
+add_remoterefs () {
+	while read -r command sha1 message
+	do
+		printf '%s\n' "$command $sha1 $message"
+		git branch -r --contains "$sha1" >"$1.branch"
+		if test -s "$1.branch"
+		then
+			printf "# Commit above this line appear in:"
+			while read -r branch
+			do
+				printf " $branch"
+			done <"$1.branch"
+			printf '\n'
+		fi
+	done >"$1.published" <"$1"
+	cat "$1.published" >"$1"
+	rm -f "$1.published" "$1.branch"
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +878,7 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$checkremoterefs" && add_remoterefs "$todo"
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index e616737..f8675b5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -99,7 +99,9 @@ action=
 preserve_merges=
 autosquash=
 keep_empty=
+checkremoterefs=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+test "$(git config --bool rebase.checkremoterefs)" = "true" && checkremoterefs=t
 
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6ccf797..4906867 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -65,3 +65,14 @@ EOF
 	test_set_editor "$(pwd)/fake-editor.sh"
 	chmod a+x fake-editor.sh
 }
+
+
+set_copy_editor () {
+	echo "#!$SHELL_PATH" >editor.sh
+	cat >> editor.sh <<\EOF
+cat "$1" >"$TODO_DUMP"
+EOF
+
+	test_set_editor "$(pwd)/editor.sh"
+	chmod a+x editor.sh
+}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..f99c0c2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,33 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn before rewriting published history' '
+	test_when_finished "rm -rf git.git git" &&
+	git init git.git &&
+	git clone git &&
+	(
+		cd git &&
+		git config rebase.checkremoterefs true &&
+		test_commit one_commit main.txt one_commit &&
+		test_commit two_commit main.txt two_commit &&
+		test_commit three_commit main.txt three_commit &&
+		git push --all &&
+		test_commit four_commit main.txt four_commit &&
+		set_copy_editor &&
+		TODO_DUMP=actual EDITOR=./editor.sh git rebase -i HEAD~3 &&
+		tmp=$(cat actual | sed -n 1,5p) &&
+		echo "$tmp" >actual &&
+		tmp=$(git cherry --abbrev=7 HEAD~3 | sed -e 's/+[[:space:]]//g') &&
+		two_sha1=$(echo "$tmp" | sed -n 1p) &&
+		three_sha1=$(echo "$tmp" | sed -n 2p) &&
+		four_sha1=$(echo "$tmp" | sed -n 3p) &&
+		echo "pick $two_sha1 two_commit" >expected &&
+		echo "# Commit above this line appear in: origin/master" >>expected &&
+		echo "pick $three_sha1 three_commit" >>expected &&
+		echo "# Commit above this line appear in: origin/master" >>expected &&
+		echo "pick $four_sha1 four_commit" >>expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
1.7.8
