From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 4/6] bisect: add the terms old/new
Date: Mon, 22 Jun 2015 23:00:34 +0200
Message-ID: <1435006836-18182-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 23:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78pu-0005xf-Lz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbFVVAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:51 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:55161 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766AbbFVVAk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:00:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 09D7188AD;
	Mon, 22 Jun 2015 23:00:38 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 616f1UnL0MqF; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E95912858;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id BD30120D2;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrMtI1Z6uTFS; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 588E020E4;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272413>

When not looking for a regression during a bisect but for a fix or a
change in another given property, it can be confusing to use 'good'
and 'bad'.

This patch introduce `git bisect new` and `git bisect old` as an
alternative to 'bad' and good': the commits which have a certain
property must be marked as `new` and the ones which do not as `old`.

The output will be the first commit after the change in the property.
During a new/old bisect session you cannot use bad/good commands and
vice-versa.

Some commands are still not available for old/new:
     * git rev-list --bisect does not treat the revs/bisect/new and
       revs/bisect/old-SHA1 files.

Old discussions:
	- http://thread.gmane.org/gmane.comp.version-control.git/86063
		introduced bisect fix unfixed to find fix.
	- http://thread.gmane.org/gmane.comp.version-control.git/182398
		discussion around bisect yes/no or old/new.
	- http://thread.gmane.org/gmane.comp.version-control.git/199758
		last discussion and reviews
New discussions:
	- http://thread.gmane.org/gmane.comp.version-control.git/271320
		( v2 1/7-4/7 )
	- http://comments.gmane.org/gmane.comp.version-control.git/271343
		( v2 5/7-7/7 )

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
 Documentation/git-bisect.txt |   48 ++++++++++++++++++++++++++++++++++++++++-
 bisect.c                     |   11 +++++++--
 git-bisect.sh                |   30 +++++++++++++++++--------
 t/t6030-bisect-porcelain.sh  |   38 +++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4cb52a7..3c3021a 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -18,8 +18,8 @@ on the subcommand:
 
  git bisect help
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
- git bisect bad [<rev>]
- git bisect good [<rev>...]
+ git bisect (bad|new) [<rev>]
+ git bisect (good|old) [<rev>...]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect visualize
@@ -104,6 +104,35 @@ For example, `git bisect reset HEAD` will leave you on the current
 bisection commit and avoid switching commits at all, while `git bisect
 reset bisect/bad` will check out the first bad revision.
 
+
+Alternative terms: bisect new and bisect old
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you are not at ease with the terms "bad" and "good", perhaps
+because you are looking for the commit that introduced a fix, you can
+alternatively use "new" and "old" instead.
+But note that you cannot mix "bad" and good" with "new" and "old".
+
+------------------------------------------------
+git bisect new [<rev>]
+------------------------------------------------
+
+Marks the commit as new, e.g. "the bug is no longer there", if you are looking
+for a commit that fixed a bug, or "the feature that used to work is now broken
+at this point", if you are looking for a commit that introduced a bug.
+It is the equivalent of "git bisect bad [<rev>]".
+
+------------------------------------------------
+git bisect old [<rev>...]
+------------------------------------------------
+
+Marks the commit as old, as the opposite of 'git bisect new'.
+It is the equivalent of "git bisect good [<rev>...]".
+
+You must run `git bisect start` without commits as argument and run
+`git bisect new <rev>`/`git bisect old <rev>...` after to add the
+commits.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
@@ -379,6 +408,21 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
 has at least one parent whose reachable graph is fully traversable in the sense
 required by 'git pack objects'.
 
+* Look for a fix instead of a regression in the code
++
+------------
+$ git bisect start
+$ git bisect new HEAD    # current commit is marked as new
+$ git bisect old HEAD~10 # the tenth commit from now is marked as old
+------------
++
+Let's consider the last commit has a given property, and that we are looking
+for the commit which introduced this property. For each commit the bisection
+guide us to, we will test if the property is present. If it is we will mark
+the commit as new with 'git bisect new', otherwise we will mark it as old.
+At the end of the bisect session, the result will be the first new commit (e.g
+the first one with the property).
+
 
 SEE ALSO
 --------
diff --git a/bisect.c b/bisect.c
index 2fc8a78..7492fdc 100644
--- a/bisect.c
+++ b/bisect.c
@@ -746,6 +746,11 @@ static void handle_bad_merge_base(void)
 				"This means the bug has been fixed "
 				"between %s and [%s].\n",
 				bad_hex, bad_hex, good_hex);
+		} else if (!strcmp(name_bad, "new")) {
+			fprintf(stderr, "The merge base %s is new.\n"
+				"The property has changed "
+				"between %s and [%s].\n",
+				bad_hex, bad_hex, good_hex);
 		} else {
 			fprintf(stderr, "The merge base %s is %s.\n"
 				"This means the first commit marked %s is "
@@ -778,11 +783,11 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 }
 
 /*
- * "check_merge_bases" checks that merge bases are not "bad".
+ * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
- * - If one is "bad", it means the user assumed something wrong
+ * - If one is "bad" (or "new"), it means the user assumed something wrong
  * and we must exit with a non 0 error code.
- * - If one is "good", that's good, we have nothing to do.
+ * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
diff --git a/git-bisect.sh b/git-bisect.sh
index 55b9ebd..a11ca06 100644
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,14 +1,16 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
 	reset bisect state and start bisection.
-git bisect bad [<rev>]
-	mark <rev> a known-bad revision.
-git bisect good [<rev>...]
-	mark <rev>... known-good revisions.
+git bisect (bad|new) [<rev>]
+	mark <rev> a known-bad revision/
+		a revision after change in a given property.
+git bisect (good|old) [<rev>...]
+	mark <rev>... known-good revisions/
+		revisions before change in a given property.
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -288,7 +290,7 @@ bisect_next_check() {
 		false
 		;;
 	t,,"$NAME_GOOD")
-		# have bad but not good.  we could bisect although
+		# have bad (or new) but not good (or old).  we could bisect although
 		# this is less optimum.
 		eval_gettextln "Warning: bisecting only with a \$NAME_BAD commit." >&2
 		if test -t 0
@@ -529,7 +531,7 @@ get_terms () {
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-	bad|good)
+	bad|good|new|old)
 		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
 		then
 			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
@@ -543,14 +545,22 @@ check_and_set_terms () {
 			fi
 			NAME_BAD="bad"
 			NAME_GOOD="good" ;;
+		new|old)
+			if ! test -s "$GIT_DIR/BISECT_TERMS"
+			then
+				echo "new" >"$GIT_DIR/BISECT_TERMS" &&
+				echo "old" >>"$GIT_DIR/BISECT_TERMS"
+			fi
+			NAME_BAD="new"
+			NAME_GOOD="old" ;;
 		esac ;;
 	esac
 }
 
 bisect_voc () {
 	case "$1" in
-	bad) echo "bad" ;;
-	good) echo "good" ;;
+	bad) echo "bad|old" ;;
+	good) echo "good|new" ;;
 	esac
 }
 
@@ -566,7 +576,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good)
+	bad|good|new|old)
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e2c203..2f2143b 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -759,4 +759,42 @@ test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
 	git bisect reset
 '
 
+test_expect_success 'bisect starts with only one new' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect new $HASH4 &&
+	git bisect next
+'
+
+test_expect_success 'bisect does not start with only one old' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect old $HASH1 &&
+	test_must_fail git bisect next
+'
+
+test_expect_success 'bisect start with one new and old' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect old $HASH1 &&
+	git bisect new $HASH4 &&
+	git bisect new &&
+	git bisect new >bisect_result &&
+	grep "$HASH2 is the first new commit" bisect_result &&
+	git bisect log > log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with old and new' '
+	git bisect replay log_to_replay.txt > bisect_result &&
+	grep "$HASH2 is the first new commit" bisect_result &&
+	git bisect reset
+'
+
+test_expect_success 'bisect cannot mix old/new and good/bad' '
+	git bisect start &&
+	git bisect bad $HASH4 &&
+	test_must_fail git bisect old $HASH1
+'
+
 test_done
-- 
1.7.1
