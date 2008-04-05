From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] merge, pull: introduce '--diffstat' option
Date: Sat,  5 Apr 2008 16:48:55 +0200
Message-ID: <1207406935-22144-1-git-send-email-szeder@ira.uka.de>
References: <20080403103056.GD6673@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 16:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji9id-0006HQ-3Y
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 16:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbYDEOtU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 10:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYDEOtT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 10:49:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64016 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYDEOtT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 10:49:19 -0400
Received: from elysium (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1Ji9hP2Cw4-00023a; Sat, 05 Apr 2008 16:48:59 +0200
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id 2280212419C;
	Sat,  5 Apr 2008 16:48:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.rc3.10.g79e34
In-Reply-To: <20080403103056.GD6673@coredump.intra.peff.net>
X-Provags-ID: V01U2FsdGVkX1+gBWMyFQzo0ObUaJItAmFPSW2XWcpfu61ggdY
 rKwOLF6NjlrQLYAkwE45LilBG7wz2puRoG1oE4DMtlRVHYZ7+c
 sD+dZPsDgg5s+IdupETBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78847>

At present, the 'merge --summary' command line option and
'merge.diffstat' config variable are controlling the same thing: whethe=
r
to show a diffstat at the end of the merge or not.  This is inconsisten=
t
and confusing.

This patch adds the '--diffstat' and '--no-diffstat' options to 'merge'
and 'pull', making the name of the command line option and the
config variable consistent.  Documentation, tests, and bash completion
are also updated accordingly.

The '--summary' and '--no-summary' options are still accepted, but are
not advertised.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
But there is still a conflict between the 'merge.summary' config
variable and the now not advertised '--summary' option, that should be
resolved.

 Documentation/git-merge.txt            |    2 +-
 Documentation/merge-options.txt        |    4 ++--
 contrib/completion/git-completion.bash |    2 +-
 git-merge.sh                           |    8 ++++----
 git-pull.sh                            |   16 +++++++---------
 t/t7600-merge.sh                       |    6 +++---
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index c136b10..d260ab1 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,7 +9,7 @@ git-merge - Join two or more development histories toge=
ther
 SYNOPSIS
 --------
 [verse]
-'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>].=
=2E.
+'git-merge' [-n] [--diffstat] [--no-commit] [--squash] [-s <strategy>]=
=2E..
 	[-m <msg>] <remote> <remote>...
 'git-merge' <msg> HEAD <remote>...
=20
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index 9f1fc82..edd13a5 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,8 +1,8 @@
---summary::
+--diffstat::
 	Show a diffstat at the end of the merge. The diffstat is also
 	controlled by the configuration option merge.diffstat.
=20
--n, \--no-summary::
+-n, \--no-diffstat::
 	Do not show diffstat at the end of the merge.
=20
 --no-commit::
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 791e30f..2e6cad7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -776,7 +776,7 @@ _git_merge ()
 		;;
 	--*)
 		__gitcomp "
-			--no-commit --no-summary --squash --strategy
+			--no-commit --no-diffstat --squash --strategy
 			"
 		return
 	esac
diff --git a/git-merge.sh b/git-merge.sh
index 7dbbb1d..b51eef8 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -8,8 +8,8 @@ OPTIONS_SPEC=3D"\
 git-merge [options] <remote>...
 git-merge [options] <msg> HEAD <remote>
 --
-summary              show a diffstat at the end of the merge
-n,no-summary         don't show a diffstat at the end of the merge
+diffstat             show a diffstat at the end of the merge
+n,no-diffstat        don't show a diffstat at the end of the merge
 squash               create a single commit instead of doing a merge
 commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
@@ -148,9 +148,9 @@ merge_name () {
 parse_config () {
 	while test $# !=3D 0; do
 		case "$1" in
-		-n|--no-summary)
+		-n|--no-diffstat|--no-summary)
 			show_diffstat=3Dfalse ;;
-		--summary)
+		--diffstat|--summary)
 			show_diffstat=3Dt ;;
 		--squash)
 			test "$allow_fast_forward" =3D t ||
diff --git a/git-pull.sh b/git-pull.sh
index 3ce32b5..20a2024 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -4,7 +4,7 @@
 #
 # Fetch one or more remote refs and merge it/them into the current HEA=
D.
=20
-USAGE=3D'[-n | --no-summary] [--[no-]commit] [--[no-]squash] [--[no-]f=
f] [-s strategy]... [<fetch-options>] <repo> <head>...'
+USAGE=3D'[-n | --no-diffstat] [--[no-]commit] [--[no-]squash] [--[no-]=
ff] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE=3D'Fetch one or more remote refs and merge it/them into the=
 current HEAD.'
 SUBDIRECTORY_OK=3DYes
 OPTIONS_SPEC=3D
@@ -16,19 +16,17 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
=20
-strategy_args=3D no_summary=3D no_commit=3D squash=3D no_ff=3D
+strategy_args=3D no_diffstat=3D no_commit=3D squash=3D no_ff=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
-	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
-		--no-summa|--no-summar|--no-summary)
-		no_summary=3D-n ;;
-	--summary)
-		no_summary=3D$1
-		;;
+	-n|--no-diffstat|--no-summary)
+		no_diffstat=3D-n ;;
+	--diffstat|--summary)
+		no_diffstat=3D$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=3D--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
@@ -176,5 +174,5 @@ merge_name=3D$(git fmt-merge-msg <"$GIT_DIR/FETCH_H=
EAD") || exit
 test true =3D "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
+exec git-merge $no_diffstat $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 56869ac..bbbd580 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -368,7 +368,7 @@ test_expect_success 'override config option -n' '
 	git reset --hard c1 &&
 	git config branch.master.mergeoptions "-n" &&
 	test_tick &&
-	git merge --summary c2 >diffstat.txt &&
+	git merge --diffstat c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
 	verify_parents $c1 $c2 &&
 	if ! grep "^ file |  *2 +-$" diffstat.txt
@@ -379,9 +379,9 @@ test_expect_success 'override config option -n' '
=20
 test_debug 'gitk --all'
=20
-test_expect_success 'override config option --summary' '
+test_expect_success 'override config option --diffstat' '
 	git reset --hard c1 &&
-	git config branch.master.mergeoptions "--summary" &&
+	git config branch.master.mergeoptions "--diffstat" &&
 	test_tick &&
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
--=20
1.5.5.rc3.10.g79e34
