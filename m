From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [WIP PATCH 1/3] git bisect old/new
Date: Thu,  4 Jun 2015 09:59:11 +0200
Message-ID: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: thomasxnguy@gmail.com, valentinduperray@gmail.com,
	remi.lespinet@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 09:59:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Q3o-0002nF-Un
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 09:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbFDH7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 03:59:22 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:37829 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485AbbFDH7T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 03:59:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B1F2F4885E;
	Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sXMpg2jG+yxJ; Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9337D4863D;
	Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 897E820DC;
	Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RclBLOH1h8YX; Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 7125C20D4;
	Thu,  4 Jun 2015 09:59:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270754>

From: Christian Couder <chriscool@tuxfamily.org>

When not looking for a regression during a bisect but for a fix or a
change in another given property, it can be confusing to use 'good'
and 'bad'.

This patch introduce `git bisect new` and `git bisect old` as an
alternative to 'bad' and good': the commits which have the most
recent version of the property must be marked as `new` and the ones
with the older version as `old`.

The output will be the first commit after the change in the property.
During a new/old bisect session you cannot use bad/good commands and
vice-versa.

`git bisect replay` works fine for old/new bisect sessions.

Some commands are still not available for old/new:

     * git bisect start [<new> [<old>...]] is not possible: the
       commits will be treated as bad and good.
     * git rev-list --bisect does not treat the revs/bisect/new and
       revs/bisect/old-SHA1 files.
     * git bisect visualize seem to work partially: the tags are
       displayed correctly but the tree is not limited to the bisect
       section.

Related discussions:

	- http://thread.gmane.org/gmane.comp.version-control.git/86063
		introduced bisect fix unfixed to find fix.
	- http://thread.gmane.org/gmane.comp.version-control.git/182398
		discussion around bisect yes/no or old/new.
	- http://thread.gmane.org/gmane.comp.version-control.git/199758
		last discussion and reviews

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
We took account of most of the "easy" reviews that were discuted two years ago.
We hope we didn't missed any.
http://thread.gmane.org/gmane.comp.version-control.git/199758

We corrected various issues that were not reported: 
-one that caused a "fatal ... not a valid ref" at the end of the bisection.
-the autostart was causing issues, the following lines were working :
git bisect new HEAD
git bisect bad HEAD
git bisect good aGoodCommit

The hard review which we were thinking on was the issue of the maintaining
of old/new and allow easy support of new "tags" like yes/no in the future.
I tried to remove the maximum of bad/good and old/new which were hard wrote in
the code but I'm not completly satisfied. This patch is clearly a v1.

We're currently working on:

* rebasing the history of the patch
* git rev-list --bisect does not treat the revs/bisect/new and
revs/bisect/old-SHA1 files.
* git bisect visualize seem to work partially: the tags are displayed
correctly but the tree is not limited to the bisect section.
* adding tests about old/new

Some other problems that might also be considerred later :
* change/add valid terms (e.g "unfixed/fixed" instead of "old/new")
*
* git bisect start [<new> [<old>...]] is not possible: the commits
will be treated as bad and good.


 Documentation/git-bisect.txt |  43 +++++++++++++-
 bisect.c                     |  83 ++++++++++++++++++++-------
 git-bisect.sh                | 132 ++++++++++++++++++++++++++++++++-----------
 t/t6030-bisect-porcelain.sh  |  40 +++++++++++++
 4 files changed, 243 insertions(+), 55 deletions(-)
 mode change 100755 => 100644 git-bisect.sh

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4cb52a7..12c7711 100644
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
@@ -104,6 +104,33 @@ For example, `git bisect reset HEAD` will leave you on the current
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
+Marks the commit as new, which means the version is fixed.
+It is the equivalent of "git bisect bad [<rev>]".
+
+------------------------------------------------
+git bisect old [<rev>...]
+------------------------------------------------
+
+Marks the commit as old, which means the bug is present.
+It is the equivalent of "git bisect good [<rev>...]".
+
+You must run `git bisect start` without commits as argument and run
+`git bisect new <rev>`/`git bisect old <rev>...` after to add the
+commits.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
@@ -379,6 +406,18 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
 has at least one parent whose reachable graph is fully traversable in the sense
 required by 'git pack objects'.
 
+* Look for a fix instead of a regression in the code
++
+------------
+$ git bisect start
+$ git bisect new		# Current version is fixed
+$ git bisect old bugged_version	# bugged_version was the last version
+				# known to be unfixed
+------------
++
+The "new" commits are the fixed ones and the "old" commits are the unfixed ones.
+At the end of the bisect session, you will have the first fixed commit.
+
 
 SEE ALSO
 --------
diff --git a/bisect.c b/bisect.c
index 10f5e57..d6c19fd 100644
--- a/bisect.c
+++ b/bisect.c
@@ -21,6 +21,9 @@ static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
+static const char *bisect_bad;
+static const char *bisect_good;
+
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
@@ -403,10 +406,11 @@ struct commit_list *find_bisection(struct commit_list *list,
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
-	if (!strcmp(refname, "bad")) {
+	if (!strcmp(refname, bisect_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		hashcpy(current_bad_oid->hash, sha1);
-	} else if (starts_with(refname, "good-")) {
+	} else if (starts_with(refname, "good-") ||
+		   starts_with(refname, "old-")) {
 		sha1_array_append(&good_revs, sha1);
 	} else if (starts_with(refname, "skip-")) {
 		sha1_array_append(&skipped_revs, sha1);
@@ -634,7 +638,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 		return;
 
 	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first bad commit could be any of:\n");
+	       "The first %s commit could be any of:\n", bisect_bad);
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
@@ -732,18 +736,25 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-
-		fprintf(stderr, "The merge base %s is bad.\n"
-			"This means the bug has been fixed "
-			"between %s and [%s].\n",
-			bad_hex, bad_hex, good_hex);
-
+		if (!strcmp(bisect_bad,"bad")) {
+			fprintf(stderr, "The merge base %s is bad.\n"
+				"This means the bug has been fixed "
+				"between %s and [%s].\n",
+				bad_hex, bad_hex, good_hex);
+		} else {
+			fprintf(stderr, "The merge base %s is new.\n"
+				"The property has changed "
+				"between %s and [%s].\n",
+				bad_hex, bad_hex, good_hex);
+		}
 		exit(3);
 	}
 
-	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
+	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistake good and bad revs?\n");
+		"Maybe you mistook %s and %s revs?\n",
+		bisect_good, bisect_bad, bisect_good,
+		bisect_bad);
 	exit(1);
 }
 
@@ -755,19 +766,19 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 
 	warning("the merge base between %s and [%s] "
 		"must be skipped.\n"
-		"So we cannot be sure the first bad commit is "
+		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
 		"We continue anyway.",
-		bad_hex, good_hex, mb_hex, bad_hex);
+		bad_hex, good_hex, bisect_bad, mb_hex, bad_hex);
 	free(good_hex);
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
@@ -839,7 +850,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a bad revision is needed");
+		die("a %s revision is needed", bisect_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -890,6 +901,31 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 }
 
 /*
+ * The terms used for this bisect session are stocked in
+ * BISECT_TERMS: it can be bad/good or new/old.
+ * We read them and stock them to adapt the messages
+ * accordingly. Default is bad/good.
+ */
+void read_bisect_terms(void)
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path("BISECT_TERMS");
+	FILE *fp = fopen(filename, "r");
+
+	if (!fp) {
+		bisect_bad = "bad";
+		bisect_good = "good";
+	} else {
+	strbuf_getline(&str, fp, '\n');
+	bisect_bad = strbuf_detach(&str, NULL);
+	strbuf_getline(&str, fp, '\n');
+	bisect_good = strbuf_detach(&str, NULL);
+	}
+	strbuf_release(&str);
+	fclose(fp);
+}
+
+/*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
@@ -905,6 +941,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	const unsigned char *bisect_rev;
 	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
+	read_bisect_terms();
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
@@ -926,8 +963,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		 */
 		exit_if_skipped_commits(tried, NULL);
 
-		printf("%s was both good and bad\n",
-		       oid_to_hex(current_bad_oid));
+		printf("%s was both %s and %s\n",
+		       oid_to_hex(current_bad_oid),
+		       bisect_good,
+		       bisect_bad);
 		exit(1);
 	}
 
@@ -942,7 +981,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first bad commit\n", bisect_rev_hex);
+		printf("%s is the first %s commit\n", bisect_rev_hex,
+			bisect_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
@@ -954,6 +994,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
+	free((char*)bisect_bad);
+	free((char*)bisect_good);
+
 	return bisect_checkout(bisect_rev_hex, no_checkout);
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
old mode 100755
new mode 100644
index ae3fec2..109bd65
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,14 +1,16 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run|new|old]'
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
@@ -32,6 +34,8 @@ OPTIONS_SPEC=
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+BISECT_BAD="bad"
+BISECT_GOOD="good"
 
 bisect_head()
 {
@@ -75,6 +79,7 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
+	start_bad_good=0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -99,6 +104,10 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
+
+			# by default, if the user didnt type --fix
+			start_bad_good=1
+
 			case $bad_seen in
 			0) state='bad' ; bad_seen=1 ;;
 			*) state='good' ;;
@@ -170,6 +179,11 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
+	if test $start_bad_good -eq 1 -a ! -s "$GIT_DIR/BISECT_TERMS"
+	then
+		echo "$BISECT_BAD" >"$GIT_DIR/BISECT_TERMS" &&
+		echo "$BISECT_GOOD" >>"$GIT_DIR/BISECT_TERMS"
+	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
@@ -184,9 +198,12 @@ bisect_write() {
 	rev="$2"
 	nolog="$3"
 	case "$state" in
-		bad)		tag="$state" ;;
-		good|skip)	tag="$state"-"$rev" ;;
-		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
+		"$BISECT_BAD")
+			tag="$state" ;;
+		"$BISECT_GOOD"|skip)
+			tag="$state"-"$rev" ;;
+		*)
+			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -227,15 +244,16 @@ bisect_skip() {
 bisect_state() {
 	bisect_autostart
 	state=$1
+	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
-	1,bad|1,good|1,skip)
+	1,"$BISECT_BAD"|1,"$BISECT_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
-	2,bad|*,good|*,skip)
+	2,"$BISECT_BAD"|*,"$BISECT_GOOD"|*,skip)
 		shift
 		hash_list=''
 		for rev in "$@"
@@ -249,8 +267,8 @@ bisect_state() {
 			bisect_write "$state" "$rev"
 		done
 		check_expected_revs $hash_list ;;
-	*,bad)
-		die "$(gettext "'git bisect bad' can take only one argument.")" ;;
+	*,"$BISECT_BAD")
+		die "$(gettext "'git bisect $BISECT_BAD' can take only one argument.")" ;;
 	*)
 		usage ;;
 	esac
@@ -259,21 +277,21 @@ bisect_state() {
 
 bisect_next_check() {
 	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/bad || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
+	git show-ref -q --verify refs/bisect/$BISECT_BAD || missing_bad=t
+	test -n "$(git for-each-ref "refs/bisect/$BISECT_GOOD-*")" || missing_good=t
 
 	case "$missing_good,$missing_bad,$1" in
 	,,*)
-		: have both good and bad - ok
+		: have both $BISECT_GOOD and $BISECT_BAD - ok
 		;;
 	*,)
 		# do not have both but not asked to fail - just report.
 		false
 		;;
-	t,,good)
-		# have bad but not good.  we could bisect although
+	t,,"$BISECT_GOOD")
+		# have bad (or new) but not good (or old).  we could bisect although
 		# this is less optimum.
-		gettextln "Warning: bisecting only with a bad commit." >&2
+		gettextln "Warning: bisecting only with a $BISECT_BAD commit." >&2
 		if test -t 0
 		then
 			# TRANSLATORS: Make sure to include [Y] and [n] in your
@@ -283,18 +301,18 @@ bisect_next_check() {
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
-		: bisect without good...
+		: bisect without $BISECT_GOOD...
 		;;
 	*)
 
 		if test -s "$GIT_DIR/BISECT_START"
 		then
-			gettextln "You need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+			gettextln "You need to give me at least one $(bisect_voc bad) and one $(bisect_voc good) revision.
+(You can use \"git bisect $(bisect_voc bad)\" and \"git bisect $(bisect_voc good)\" for that.)" >&2
 		else
 			gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one good and one bad revision.
-(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
+You then need to give me at least one $(bisect_voc good) and one $(bisect_voc bad) revision.
+(You can use \"git bisect $(bisect_voc bad)\" and \"git bisect $(bisect_voc good)\" for that.)" >&2
 		fi
 		exit 1 ;;
 	esac
@@ -307,7 +325,7 @@ bisect_auto_next() {
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check good
+	bisect_next_check $BISECT_GOOD
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -316,15 +334,15 @@ bisect_next() {
 	# Check if we should exit because bisection is finished
 	if test $res -eq 10
 	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
+		bad_rev=$(git show-ref --hash --verify refs/bisect/$BISECT_BAD)
 		bad_commit=$(git show-branch $bad_rev)
 		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
 		exit 0
 	elif test $res -eq 2
 	then
 		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/good-*")
-		for skipped in $(git rev-list refs/bisect/bad --not $good_revs)
+		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$BISECT_GOOD-*")
+		for skipped in $(git rev-list refs/bisect/$BISECT_BAD --not $good_revs)
 		do
 			skipped_commit=$(git show-branch $skipped)
 			echo "# possible first bad commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
@@ -397,6 +415,7 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_LOG" &&
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
+	rm -f "$GIT_DIR/BISECT_TERMS" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -417,11 +436,13 @@ bisect_replay () {
 			rev="$command"
 			command="$bisect"
 		fi
+		get_terms
+		check_and_set_terms "$command"
 		case "$command" in
 		start)
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
-		good|bad|skip)
+		good|bad|skip|old|new)
 			bisect_write "$command" "$rev" ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
@@ -455,9 +476,9 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state='skip'
 		elif [ $res -gt 0 ]
 		then
-			state='bad'
+			state="$BISECT_BAD"
 		else
-			state='good'
+			state="$BISECT_GOOD"
 		fi
 
 		# We have to use a subshell because "bisect_state" can exit.
@@ -466,7 +487,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 
 		cat "$GIT_DIR/BISECT_RUN"
 
-		if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+		if sane_grep "first $BISECT_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
 			>/dev/null
 		then
 			gettextln "bisect run cannot continue any more" >&2
@@ -480,7 +501,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			exit $res
 		fi
 
-		if sane_grep "is the first bad commit" "$GIT_DIR/BISECT_RUN" >/dev/null
+		if sane_grep "is the first $BISECT_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
 		then
 			gettextln "bisect run success"
 			exit 0;
@@ -494,18 +515,63 @@ bisect_log () {
 	cat "$GIT_DIR/BISECT_LOG"
 }
 
+get_terms () {
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		BISECT_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
+		BISECT_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"
+	fi
+}
+
+check_and_set_terms () {
+	cmd="$1"
+	case "$cmd" in
+	bad|good|new|old)
+		if test -s "$GIT_DIR/BISECT_TERMS" -a "$cmd" != "$BISECT_BAD" -a "$cmd" != "$BISECT_GOOD"
+		then
+			die "$(eval_gettext "Invalid command : you're currently in a \$BISECT_BAD/\$BISECT_GOOD bisect.")"
+		fi
+		case "$cmd" in
+		bad|good)
+			if test ! -s "$GIT_DIR/BISECT_TERMS"
+			then
+				echo "bad" >"$GIT_DIR/BISECT_TERMS" &&
+				echo "good" >>"$GIT_DIR/BISECT_TERMS"
+			fi
+			BISECT_BAD="bad"
+			BISECT_GOOD="good" ;;
+		new|old)
+			if test ! -s "$GIT_DIR/BISECT_TERMS"
+			then
+				echo "new" >"$GIT_DIR/BISECT_TERMS" &&
+				echo "old" >>"$GIT_DIR/BISECT_TERMS"
+			fi
+			BISECT_BAD="new"
+			BISECT_GOOD="old" ;;
+		esac ;;
+	esac
+}
+
+bisect_voc () {
+	case "$1" in
+	bad) echo "bad|old" ;;
+	good) echo "good|new" ;;
+	esac
+}
+
 case "$#" in
 0)
 	usage ;;
 *)
 	cmd="$1"
+	get_terms
 	shift
 	case "$cmd" in
 	help)
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good)
+	bad|good|new|old)
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 06b4868..2163010 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -710,6 +710,8 @@ test_expect_success 'bisect: demonstrate identification of damage boundary' "
 		test \$rc = 0' &&
 	check_same BROKEN_HASH6 bisect/bad &&
 	git bisect reset
+	git checkout master
+
 "
 
 cat > expected.bisect-log <<EOF
@@ -759,4 +761,42 @@ test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
 	git bisect reset
 '
 
+test_expect_success 'bisect starts with only one new' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect new $HASH4 &&
+	git bisect next
+'
+test_expect_success 'bisect does not start with only one old' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect old $HASH1 || return 1
+	test_must_fail git bisect next
+
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
2.4.1.173.gd47f443.dirty
