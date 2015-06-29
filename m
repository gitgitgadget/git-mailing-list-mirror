From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 08/10] bisect: add the terms old/new
Date: Mon, 29 Jun 2015 17:40:33 +0200
Message-ID: <1435592435-27914-9-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBe-0003OX-AS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbF2PlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33121 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbbF2Pk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefTk018378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFeh4P031687;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008Dz-EE; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Jun 2015 17:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefTk018378
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197244.11724@MylPUU8+Ea+Z+N0oSQfuiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272966>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

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
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 58 ++++++++++++++++++++++++++++++++++++++++++--
 bisect.c                     | 11 ++++++---
 git-bisect.sh                | 26 +++++++++++++-------
 t/t6030-bisect-porcelain.sh  | 38 +++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index e97f2de..abaf462 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,8 +17,8 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
- git bisect bad [<rev>]
- git bisect good [<rev>...]
+ git bisect (bad|new) [<rev>]
+ git bisect (good|old) [<rev>...]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect visualize
@@ -36,6 +36,13 @@ whether the selected commit is "good" or "bad". It continues narrowing
 down the range until it finds the exact commit that introduced the
 change.
 
+In fact, `git bisect` can be used to find the commit that changed
+*any* property of your project; e.g., the commit that fixed a bug, or
+the commit that caused a benchmark's performance to improve. To
+support this more general usage, the terms "old" and "new" can be used
+in place of "good" and "bad". See
+section "Alternate terms" below for more information.
+
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -111,6 +118,45 @@ bad revision, while `git bisect reset HEAD` will leave you on the
 current bisection commit and avoid switching commits at all.
 
 
+Alternate terms
+~~~~~~~~~~~~~~~
+
+Sometimes you are not looking for the commit that introduced a
+breakage, but rather for a commit that caused a change between some
+other "old" state and "new" state. For example, you might be looking
+for the commit that introduced a particular fix. Or you might be
+looking for the first commit in which the source-code filenames were
+finally all converted to your company's naming standard. Or whatever.
+
+In such cases it can be very confusing to use the terms "good" and
+"bad" to refer to "the state before the change" and "the state after
+the change". So instead, you can use the terms "old" and "new",
+respectively, in place of "good" and "bad". (But note that you cannot
+mix "good" and "bad" with "old" and "new" in a single session.)
+
+In this more general usage, you provide `git bisect` with a "new"
+commit has some property and an "old" commit that doesn't have that
+property. Each time `git bisect` checks out a commit, you test if that
+commit has the property. If it does, mark the commit as "new";
+otherwise, mark it as "old". When the bisection is done, `git bisect`
+will report which commit introduced the property.
+
+To use "old" and "new" instead of "good" and bad, you must run `git
+bisect start` without commits as argument and then run the following
+commands to add the commits:
+
+------------------------------------------------
+git bisect old [<rev>]
+------------------------------------------------
+
+to indicate that a commit was before the sought change, or
+
+------------------------------------------------
+git bisect new [<rev>...]
+------------------------------------------------
+
+to indicate that it was after.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
@@ -387,6 +433,14 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
 has at least one parent whose reachable graph is fully traversable in the sense
 required by 'git pack objects'.
 
+* Look for a fix instead of a regression in the code
++
+------------
+$ git bisect start
+$ git bisect new HEAD    # current commit is marked as new
+$ git bisect old HEAD~10 # the tenth commit from now is marked as old
+------------
+
 Getting help
 ~~~~~~~~~~~~
 
diff --git a/bisect.c b/bisect.c
index 857cf59..f7292cb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -746,6 +746,11 @@ static void handle_bad_merge_base(void)
 				"This means the bug has been fixed "
 				"between %s and [%s].\n",
 				bad_hex, bad_hex, good_hex);
+		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
+			fprintf(stderr, "The merge base %s is new.\n"
+				"The property has changed "
+				"between %s and [%s].\n",
+				bad_hex, bad_hex, good_hex);
 		} else {
 			fprintf(stderr, "The merge base %s is %s.\n"
 				"This means the first '%s' commit is "
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
index 0b3c820..42e1cee 100755
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
@@ -294,7 +296,7 @@ bisect_next_check() {
 		false
 		;;
 	t,,"$TERM_GOOD")
-		# have bad but not good.  we could bisect although
+		# have bad (or new) but not good (or old).  we could bisect although
 		# this is less optimum.
 		eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2
 		if test -t 0
@@ -587,14 +589,20 @@ check_and_set_terms () {
 				write_terms bad good
 			fi
 			;;
+		new|old)
+			if ! test -s "$GIT_DIR/BISECT_TERMS"
+			then
+				write_terms new old
+			fi
+			;;
 		esac ;;
 	esac
 }
 
 bisect_voc () {
 	case "$1" in
-	bad) echo "bad" ;;
-	good) echo "good" ;;
+	bad) echo "bad|new" ;;
+	good) echo "good|old" ;;
 	esac
 }
 
@@ -610,7 +618,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good|"$TERM_BAD"|"$TERM_GOOD")
+	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e2c203..983c503 100755
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
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with old and new' '
+	git bisect replay log_to_replay.txt >bisect_result &&
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
2.5.0.rc0.10.gd2bff5d
