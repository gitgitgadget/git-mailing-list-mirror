From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 06/12] merge, pull: add '--(no-)log' command line option
Date: Wed, 16 Apr 2008 02:39:05 +0200
Message-ID: <1208306351-20922-7-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:28:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhq-0007aE-B7
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbYDPAjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbYDPAjY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60333 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbYDPAjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:19 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1JlvgD30Pt-0002pa; Wed, 16 Apr 2008 02:39:18 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-6-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1/G/pkHKMZn/80oa5++T8i/jfKIrsL7SJQL2IJ
 4iWu+f5uIym4MfGefM7ZNT+YTcupZyrEacDE17rRSMLmSE8Kvu
 Fi4ZTaew4Z+t+i3+V1vbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79646>

These are the command line option equivalents of the 'merge.log' config
variable.

The patch also updates documentation and bash completion accordingly, a=
nd
adds a test.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-options.txt        |    9 +++++++++
 contrib/completion/git-completion.bash |    3 ++-
 git-merge.sh                           |    8 ++++++--
 git-pull.sh                            |    8 +++++---
 t/t7600-merge.sh                       |   16 +++++++++++++++-
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 9c46dcb..41ef152 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -6,6 +6,15 @@
 -n, \--no-stat, \--no-summary::
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
index 276a984..ef7bf44 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -779,7 +779,8 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-stat --no-summary --squash --strategy
+			--no-commit --no-stat --no-summary --log --no-log
+			--squash --strategy
 			"
 		return
 	esac
diff --git a/git-merge.sh b/git-merge.sh
index a29a7ec..4cda3ec 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -12,6 +12,8 @@ stat                 show a diffstat at the end of th=
e merge
 n,no-stat            don't show a diffstat at the end of the merge
 summary              equivalent to --stat
 no-summary           equivalent to --no-stat
+log                  add list of one-line log to merge commit message
+no-log               don't add list of one-line log to merge commit me=
ssage
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
@@ -39,7 +41,7 @@ use_strategies=3D
=20
 allow_fast_forward=3Dt
 allow_trivial_merge=3Dt
-squash=3D no_commit=3D
+squash=3D no_commit=3D log_arg=3D
=20
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -154,6 +156,8 @@ parse_config () {
 			show_diffstat=3Dfalse ;;
 		--stat|--summary)
 			show_diffstat=3Dt ;;
+		--log|--no-log)
+			log_arg=3D$1 ;;
 		--squash)
 			test "$allow_fast_forward" =3D t ||
 				die "You cannot combine --squash with --no-ff."
@@ -261,7 +265,7 @@ else
 	merge_name=3D$(for remote
 		do
 			merge_name "$remote"
-		done | git fmt-merge-msg
+		done | git fmt-merge-msg $log_arg
 	)
 	merge_msg=3D"${merge_msg:+$merge_msg$LF$LF}$merge_name"
 fi
diff --git a/git-pull.sh b/git-pull.sh
index 0bac8ae..e344afb 100755
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
index e5b48fb..6680321 100755
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
@@ -456,6 +460,16 @@ test_expect_success 'merge c0 with c1 (ff override=
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
1.5.5.76.g546c
