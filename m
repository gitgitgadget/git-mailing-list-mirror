From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Mon,  8 Jun 2015 22:22:08 +0200
Message-ID: <1433794930-5158-2-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 22:22:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23Ys-00079v-5K
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbbFHUWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:22:19 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54538 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753341AbbFHUWP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 16:22:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id BC1782817;
	Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HxMbB3ySfBBU; Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A7C1D2877;
	Mon,  8 Jun 2015 22:22:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 5808920E7;
	Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NH1YXGCltrc; Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 0609120E2;
	Mon,  8 Jun 2015 22:22:11 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271125>

To add new tags like old/new and have keywords less confusing, the
first step is to avoid hardcoding the keywords.

The default mode is still bad/good.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 git-bisect.sh | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)
 mode change 100755 => 100644 git-bisect.sh

diff --git a/git-bisect.sh b/git-bisect.sh
old mode 100755
new mode 100644
index ae3fec2..1f16aaf
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -32,6 +32,8 @@ OPTIONS_SPEC=
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+NAME_BAD="bad"
+NAME_GOOD="good"
 
 bisect_head()
 {
@@ -184,9 +186,12 @@ bisect_write() {
 	rev="$2"
 	nolog="$3"
 	case "$state" in
-		bad)		tag="$state" ;;
-		good|skip)	tag="$state"-"$rev" ;;
-		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
+		"$NAME_BAD")
+			tag="$state" ;;
+		"$NAME_GOOD"|skip)
+			tag="$state"-"$rev" ;;
+		*)
+			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -230,12 +235,12 @@ bisect_state() {
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
-	1,bad|1,good|1,skip)
+	1,"$NAME_BAD"|1,"$NAME_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
-	2,bad|*,good|*,skip)
+	2,"$NAME_BAD"|*,"$NAME_GOOD"|*,skip)
 		shift
 		hash_list=''
 		for rev in "$@"
@@ -249,8 +254,8 @@ bisect_state() {
 			bisect_write "$state" "$rev"
 		done
 		check_expected_revs $hash_list ;;
-	*,bad)
-		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
+	*,"$NAME_BAD")
+		die "$(gettext "'git bisect $NAME_BAD' can take only one argument.")" ;;
 	*)
 		usage ;;
 	esac
@@ -259,21 +264,21 @@ bisect_state() {
 
 bisect_next_check() {
 	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/bad || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
+	git show-ref -q --verify refs/bisect/$NAME_BAD || missing_bad=t
+	test -n "$(git for-each-ref "refs/bisect/$NAME_GOOD-*")" || missing_good=t
 
 	case "$missing_good,$missing_bad,$1" in
 	,,*)
-		: have both good and bad - ok
+		: have both $NAME_GOOD and $NAME_BAD - ok
 		;;
 	*,)
 		# do not have both but not asked to fail - just report.
 		false
 		;;
-	t,,good)
+	t,,"$NAME_GOOD")
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		gettextln "Warning: bisecting only with a bad commit." >&2
+		gettextln "Warning: bisecting only with a $NAME_BAD commit." >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -283,7 +288,7 @@ bisect_next_check() {
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
-		: bisect without good...
+		: bisect without $NAME_GOOD...
 		;;
 	*)
 
@@ -307,7 +312,7 @@ bisect_auto_next() {
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check good
+	bisect_next_check $NAME_GOOD
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -316,15 +321,15 @@ bisect_next() {
 	# Check if we should exit because bisection is finished
 	if test $res -eq 10
 	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
+		bad_rev=$(git show-ref --hash --verify refs/bisect/$NAME_BAD)
 		bad_commit=$(git show-branch $bad_rev)
 		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
 		exit 0
 	elif test $res -eq 2
 	then
 		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/good-*")
-		for skipped in $(git rev-list refs/bisect/bad --not $good_revs)
+		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$NAME_GOOD-*")
+		for skipped in $(git rev-list refs/bisect/$NAME_BAD --not $good_revs)
 		do
 			skipped_commit=$(git show-branch $skipped)
 			echo "# possible first bad commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
@@ -455,9 +460,9 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state='skip'
 		elif [ $res -gt 0 ]
 		then
-			state='bad'
+			state="$NAME_BAD"
 		else
-			state='good'
+			state="$NAME_GOOD"
 		fi
 
 		# We have to use a subshell because "bisect_state" can exit.
@@ -466,7 +471,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 
 		cat "$GIT_DIR/BISECT_RUN"
 
-		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+		if sane_grep "first $NAME_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
 			>/dev/null
 		then
 			gettextln "bisect run cannot continue any more" >&2
@@ -480,7 +485,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" >/dev/null
+		if sane_grep "is the first $NAME_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
 		then
 			gettextln "bisect run success"
 			exit 0;
-- 
2.4.1.414.ge7a9de3.dirty
