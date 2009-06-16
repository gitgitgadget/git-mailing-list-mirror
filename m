From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 5/5] am, rebase: teach quiet option
Date: Tue, 16 Jun 2009 15:33:01 -0700
Message-ID: <1245191581-11127-6-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-2-git-send-email-bebarino@gmail.com>
 <1245191581-11127-3-git-send-email-bebarino@gmail.com>
 <1245191581-11127-4-git-send-email-bebarino@gmail.com>
 <1245191581-11127-5-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhEQ-0001yF-Il
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402AbZFPWdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbZFPWda
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:27231 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760681AbZFPWdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:15 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1945096wfd.4
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=oaXZO7KH0lIFeE9S0HBxQniWXNaIY4YvlvN3yGMfgtA=;
        b=Ph/1ftdJl5Op4HGjFXnqVwwucxL3FDzE9gunGpwnQLPNsXyA6JESpfOyVQ2lRVvc25
         glbAGuzdwwCeTIMFvOMAe+7GP8RyPKPrPrukR5dWq1K66KdMlZeoqbmqmxG+fpv+H2/c
         6fOAXrsvfaQyTonPLV+Xg2lYzymqVuZjHci8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KwZEEm92EM1tTgUzdGfmVP/s8depUW3gYiXi9kYiazChVePRE/bYZqp6zSYSMi659w
         mmBE6bwtI6to8dd4TyH5b/z/IplPAdepuoEYqhyV8YVWQnxcl5JXt/J7zlCuHgijB+bn
         Qg0mDyH+NSubYTfZmn+1b3Aue82wo71VMx7xQ=
Received: by 10.142.58.20 with SMTP id g20mr4843933wfa.20.1245191597519;
        Tue, 16 Jun 2009 15:33:17 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id 28sm837792wfd.23.2009.06.16.15.33.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:17 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:14 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-5-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121720>

git-am and git-rebase are talkative scripts. Teach them to be quiet when
told, allowing them to speak only when they fail or experience errors.

The quiet option is maintained when git-am or git-rebase fails to apply
a patch. This means subsequent --resolved, --continue, --skip, --abort
invocations will be quiet if the original invocation was quiet.

Drop a couple >&2 statements because Junio has deemed them unnecessary.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Copied from cover letter for convenience:
    - say "applying to an empty history" in am.sh
    - quiet merge in rebase.sh::call_merge()
    - drop >&2 in a couple places in rebase.sh
    - maintain GIT_QUIET when git-am or git-rebase fails
    - add to git_am_opt instead of hijacking GIT_QUIET in rebase.sh

I chose GIT_MERGE_VERBOSITY=1 in rebase because the resolvemsg
says "correct the above error", and GIT_MERGE_VERBOSITY=0 prints
nothing. I think this might be a bug, either in the documentation or
in merge-recursive. At least setting it to 1 prints
"CONFLICT (content): ..." 

This behavior was observed by passing -q to rebase in t3407.

 Documentation/git-am.txt     |    6 ++++-
 Documentation/git-rebase.txt |    4 +++
 git-am.sh                    |   26 ++++++++++++++++------
 git-rebase.sh                |   48 +++++++++++++++++++++++++++++++++--------
 t/t3400-rebase.sh            |   19 +++++++++++-----
 t/t4150-am.sh                |   18 +++++++++++++++
 6 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6d92cbe..32e689b 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject]
+	 [--reject] [-q | --quiet]
 	 [<mbox> | <Maildir>...]
 'git am' (--skip | --resolved | --abort)
 
@@ -39,6 +39,10 @@ OPTIONS
 --keep::
 	Pass `-k` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
 
+-q::
+--quiet::
+	Be quiet. Only print error messages.
+
 -u::
 --utf8::
 	Pass `-u` flag to 'git-mailinfo' (see linkgit:git-mailinfo[1]).
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 26f3b7b..db1b71d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -236,6 +236,10 @@ OPTIONS
 	is used instead ('git-merge-recursive' when merging a single
 	head, 'git-merge-octopus' otherwise).  This implies --merge.
 
+-q::
+--quiet::
+	Be quiet. Implies --no-stat.
+
 -v::
 --verbose::
 	Be verbose. Implies --stat.
diff --git a/git-am.sh b/git-am.sh
index e26c54a..58d4eb6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -11,6 +11,7 @@ git am [options] (--resolved | --skip | --abort)
 i,interactive   run interactively
 b,binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
+q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
@@ -99,7 +100,7 @@ fall_back_3way () {
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "Repository lacks necessary blobs to fall back on 3-way merge."
 
-    echo Using index info to reconstruct a base tree...
+    say Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
 	git apply --cached <"$dotest/patch"
     then
@@ -115,7 +116,7 @@ It does not apply to blobs recorded in its index."
     orig_tree=$(cat "$dotest/patch-merge-base") &&
     rm -fr "$dotest"/patch-merge-* || exit 1
 
-    echo Falling back to patching base and 3-way merge...
+    say Falling back to patching base and 3-way merge...
 
     # This is not so wrong.  Depending on which base we picked,
     # orig_tree may be wildly different from ours, but his_tree
@@ -125,6 +126,10 @@ It does not apply to blobs recorded in its index."
 
     eval GITHEAD_$his_tree='"$FIRSTLINE"'
     export GITHEAD_$his_tree
+    if test -n "$GIT_QUIET"
+    then
+	    export GIT_MERGE_VERBOSITY=0
+    fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere
 	    echo Failed to merge in the changes.
@@ -181,6 +186,8 @@ do
 		committer_date_is_author_date=t ;;
 	--ignore-date)
 		ignore_date=t ;;
+	-q|--quiet)
+		GIT_QUIET=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -279,7 +286,7 @@ else
 		exit 1
 	}
 
-	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
+	# -s, -u, -k, --whitespace, -3, -C, -q and -p flags are kept
 	# for the resuming session after a patch failure.
 	# -i can and must be given when resuming.
 	echo " $git_apply_opt" >"$dotest/apply-opt"
@@ -287,6 +294,7 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$GIT_QUIET" >"$dotest/quiet"
 	echo 1 >"$dotest/next"
 	if test -n "$rebasing"
 	then
@@ -327,6 +335,10 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
+if test "$(cat "$dotest/quiet")" = t
+then
+	GIT_QUIET=t
+fi
 if test "$(cat "$dotest/threeway")" = t
 then
 	threeway=t
@@ -352,7 +364,7 @@ fi
 
 if test "$this" -gt "$last"
 then
-	echo Nothing to do.
+	say Nothing to do.
 	rm -fr "$dotest"
 	exit
 fi
@@ -498,7 +510,7 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying: %s\n' "$FIRSTLINE"
+	say "Applying: $FIRSTLINE"
 
 	case "$resolved" in
 	'')
@@ -541,7 +553,7 @@ do
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			echo No changes -- Patch already applied.
+			say No changes -- Patch already applied.
 			go_next
 			continue
 		    }
@@ -567,7 +579,7 @@ do
 			GIT_AUTHOR_DATE=
 		fi
 		parent=$(git rev-parse --verify -q HEAD) ||
-		echo >&2 "applying to an empty history"
+		say >&2 "applying to an empty history"
 
 		if test -n "$committer_date_is_author_date"
 		then
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..84b5173 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -72,11 +72,20 @@ continue_merge () {
 			echo "directly, but instead do one of the following: "
 			die "$RESOLVEMSG"
 		fi
-		printf "Committed: %0${prec}d " $msgnum
+		if test -z "$GIT_QUIET"
+		then
+			printf "Committed: %0${prec}d " $msgnum
+		fi
 	else
-		printf "Already applied: %0${prec}d " $msgnum
+		if test -z "$GIT_QUIET"
+		then
+			printf "Already applied: %0${prec}d " $msgnum
+		fi
+	fi
+	if test -z "$GIT_QUIET"
+	then
+		git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 	fi
-	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
@@ -97,6 +106,10 @@ call_merge () {
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
 	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
 	export GITHEAD_$cmt GITHEAD_$hd
+	if test -n "$GIT_QUIET"
+	then
+		export GIT_MERGE_VERBOSITY=1
+	fi
 	git-merge-$strategy "$cmt^" -- "$hd" "$cmt"
 	rv=$?
 	case "$rv" in
@@ -138,7 +151,7 @@ move_to_original_branch () {
 finish_rb_merge () {
 	move_to_original_branch
 	rm -r "$dotest"
-	echo "All done."
+	say All done.
 }
 
 is_interactive () {
@@ -209,6 +222,7 @@ do
 			end=$(cat "$dotest/end")
 			msgnum=$(cat "$dotest/msgnum")
 			onto=$(cat "$dotest/onto")
+			GIT_QUIET=$(cat "$dotest/quiet")
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -221,6 +235,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
+		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -238,6 +253,7 @@ do
 			msgnum=$(cat "$dotest/msgnum")
 			msgnum=$(($msgnum + 1))
 			onto=$(cat "$dotest/onto")
+			GIT_QUIET=$(cat "$dotest/quiet")
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
@@ -249,6 +265,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
+		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
@@ -260,9 +277,11 @@ do
 		git rerere clear
 		if test -d "$dotest"
 		then
+			GIT_QUIET=$(cat "$dotest/quiet")
 			move_to_original_branch
 		else
 			dotest="$GIT_DIR"/rebase-apply
+			GIT_QUIET=$(cat "$dotest/quiet")
 			move_to_original_branch
 		fi
 		git reset --hard $(cat "$dotest/orig-head")
@@ -300,6 +319,13 @@ do
 	-v|--verbose)
 		verbose=t
 		diffstat=t
+		GIT_QUIET=
+		;;
+	-q|--quiet)
+		GIT_QUIET=t
+		git_am_opt="$git_am_opt -q"
+		verbose=
+		diffstat=
 		;;
 	--whitespace=*)
 		git_am_opt="$git_am_opt $1"
@@ -445,15 +471,15 @@ then
 	then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to"
-		echo >&2 "Current branch $branch_name is up to date."
+		say "Current branch $branch_name is up to date."
 		exit 0
 	else
-		echo "Current branch $branch_name is up to date, rebase forced."
+		say "Current branch $branch_name is up to date, rebase forced."
 	fi
 fi
 
 # Detach HEAD and reset the tree
-echo "First, rewinding head to replay your work on top of it..."
+say "First, rewinding head to replay your work on top of it..."
 git checkout -q "$onto^0" || die "could not detach HEAD"
 git update-ref ORIG_HEAD $branch
 
@@ -471,7 +497,7 @@ fi
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	say "Fast-forwarded $branch_name to $onto_name."
 	move_to_original_branch
 	exit 0
 fi
@@ -493,7 +519,8 @@ then
 	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
 		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
 		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head
+		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head &&
+		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
 	exit $ret
 fi
 
@@ -507,6 +534,7 @@ prev_head=$orig_head
 echo "$prev_head" > "$dotest/prev_head"
 echo "$orig_head" > "$dotest/orig-head"
 echo "$head_name" > "$dotest/head-name"
+echo "$GIT_QUIET" > "$dotest/quiet"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7f62bfb..c5c29cc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -54,8 +54,8 @@ test_expect_success 'rebase against master' '
      git rebase master'
 
 test_expect_success 'rebase against master twice' '
-     git rebase master 2>err &&
-     grep "Current branch my-topic-branch is up to date" err
+     git rebase master >out &&
+     grep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase against master twice with --force' '
@@ -65,14 +65,14 @@ test_expect_success 'rebase against master twice with --force' '
 
 test_expect_success 'rebase against master twice from another branch' '
      git checkout my-topic-branch^ &&
-     git rebase master my-topic-branch 2>err &&
-     grep "Current branch my-topic-branch is up to date" err
+     git rebase master my-topic-branch >out &&
+     grep "Current branch my-topic-branch is up to date" out
 '
 
 test_expect_success 'rebase fast-forward to master' '
      git checkout my-topic-branch^ &&
-     git rebase my-topic-branch 2>err &&
-     grep "Fast-forwarded HEAD to my-topic-branch" err
+     git rebase my-topic-branch >out &&
+     grep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
 test_expect_success \
@@ -126,4 +126,11 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
      grep "Untracked working tree file .B. would be overwritten" output.err
 '
 
+test_expect_success 'rebase -q is quiet' '
+     rm B &&
+     git checkout -b quiet topic &&
+     git rebase -q master > output.out 2>&1 &&
+     test ! -s output.out
+'
+
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 51c369a..a12bf84 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -180,6 +180,17 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 	test -z "$(git diff lorem)"
 '
 
+test_expect_success 'am -3 -q is quiet' '
+	git reset master2 --hard &&
+	sed -n -e "3,\$p" msg >file &&
+	head -n 9 msg >>file &&
+	git add file &&
+	test_tick &&
+	git commit -m "copied stuff" &&
+	git am -3 -q lorem-move.patch > output.out 2>&1 &&
+	! test -s output.out
+'
+
 test_expect_success 'am pauses on conflict' '
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
@@ -313,4 +324,11 @@ test_expect_success 'am newline in subject' '
 	grep "^Applying: second \\\n foo$" output.out
 '
 
+test_expect_success 'am -q is quiet' '
+	git checkout first &&
+	test_tick &&
+	git am -q < patch1 > output.out 2>&1 &&
+	! test -s output.out
+'
+
 test_done
-- 
1.6.3.2.306.g4f4fa
