From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 5/6] merge, pull: add '--(no-)log' command line option
Date: Sun,  6 Apr 2008 03:23:46 +0200
Message-ID: <1207445027-3152-6-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
	<1207445027-3152-1-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-2-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-3-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-4-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJdA-0004kF-01
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbYDFBYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 21:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbYDFBYX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:53535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414AbYDFBYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:24:22 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JiJc223Vr-0003Wb; Sun, 06 Apr 2008 03:24:03 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <1207445027-3152-5-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX18UBcjCJ9EZWKlxTT8MzwEHDQjB3n2D7YPEdKg
 eV20Z3kYtGhdt514di5D62EiBizJ64UH1kUPvPk+EY6UjLHpfg
 m2Yvp8Yj9CiZpGO4gg7Vg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78881>

These are the command line option equivalents of the 'merge.log' config
variable.

The patch also updates documentation and bash completion accordingly, a=
nd
adds a test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-options.txt        |    9 +++++++++
 contrib/completion/git-completion.bash |    2 +-
 git-merge.sh                           |    8 ++++++--
 git-pull.sh                            |    8 +++++---
 t/t7600-merge.sh                       |   16 +++++++++++++++-
 5 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index b89ace8..0333913 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -5,6 +5,15 @@
 -n, \--no-stat::
 	Do not show diffstat at the end of the merge.
=20
+--log::
+	In addition to branch names, populate the log message with
+	one-line descriptions from the actual commits that are being
+	merged.
+
+--no-log::
+	Do not list one-line descriptions from the actual commits being
+	merged.
+
 --no-commit::
 	Perform the merge but pretend the merge failed and do
 	not autocommit, to give the user a chance to inspect and
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6f3b78c..5880dbe 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -776,7 +776,7 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-stat --squash --strategy
+			--no-commit --no-stat --log --no-log --squash --strategy
 			"
 		return
 	esac
diff --git a/git-merge.sh b/git-merge.sh
index 004e367..a903e2b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -10,6 +10,8 @@ git-merge [options] <msg> HEAD <remote>
 --
 stat                 show a diffstat at the end of the merge
 n,no-stat            don't show a diffstat at the end of the merge
+log                  add list of one-line log to merge commit message
+no-log               don't add list of one-line log to merge commit me=
ssage
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
@@ -37,7 +39,7 @@ use_strategies=3D
=20
 allow_fast_forward=3Dt
 allow_trivial_merge=3Dt
-squash=3D no_commit=3D
+squash=3D no_commit=3D log_arg=3D
=20
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -152,6 +154,8 @@ parse_config () {
 			show_diffstat=3Dfalse ;;
 		--stat|--summary)
 			show_diffstat=3Dt ;;
+		--log|--no-log)
+			log_arg=3D$1 ;;
 		--squash)
 			test "$allow_fast_forward" =3D t ||
 				die "You cannot combine --squash with --no-ff."
@@ -259,7 +263,7 @@ else
 	merge_name=3D$(for remote
 		do
 			merge_name "$remote"
-		done | git fmt-merge-msg
+		done | git fmt-merge-msg $log_arg
 	)
 	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
 fi
diff --git a/git-pull.sh b/git-pull.sh
index ed83ce1..bf0c298 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
=20
-strategy_args=3D no_stat=3D no_commit=3D squash=3D no_ff=3D
+strategy_args=3D no_stat=3D no_commit=3D squash=3D no_ff=3D log_arg=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
@@ -27,6 +27,8 @@ do
 		no_stat=3D-n ;;
 	--stat|--summary)
 		no_stat=3D$1 ;;
+	--log|--no-log)
+		log_arg=3D$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=3D--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
@@ -170,9 +172,9 @@ then
 	exit
 fi
=20
-merge_name=3D$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || e=
xit
 test true =3D "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $strategy_args \
+exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_a=
rgs \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1d323ec..dd1b2d7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -104,7 +104,11 @@ create_merge_msgs() {
 	git log --no-merges ^HEAD c2 >>squash.1-5 &&
 	echo "Squashed commit of the following:" >squash.1-5-9 &&
 	echo >>squash.1-5-9 &&
-	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9
+	git log --no-merges ^HEAD c2 c3 >>squash.1-5-9 &&
+	echo > msg.nolog &&
+	echo "* commit 'c3':" >msg.log &&
+	echo "  commit 3" >>msg.log &&
+	echo >>msg.log
 }
=20
 verify_diff() {
@@ -441,6 +445,16 @@ test_expect_success 'merge c0 with c1 (ff override=
s no-ff)' '
 	verify_head $c1
 '
=20
+test_expect_success 'merge log message' '
+	git reset --hard c0 &&
+	git merge --no-log c2 &&
+	git show -s --pretty=3Dformat:%b HEAD >msg.act &&
+	verify_diff msg.nolog msg.act "[OOPS] bad merge log message" &&
+	git merge --log c3 &&
+	git show -s --pretty=3Dformat:%b HEAD >msg.act &&
+	verify_diff msg.log msg.act "[OOPS] bad merge log message"
+'
+
 test_debug 'gitk --all'
=20
 test_done
--=20
1.5.5.rc3.9.gba703
