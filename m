From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 4/4] am, rebase: teach quiet option
Date: Mon, 15 Jun 2009 19:05:05 -0700
Message-ID: <1245117905-19351-5-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245117905-19351-2-git-send-email-bebarino@gmail.com>
 <1245117905-19351-3-git-send-email-bebarino@gmail.com>
 <1245117905-19351-4-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 04:05:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGO3P-0000LG-HF
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679AbZFPCFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759299AbZFPCFd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:05:33 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:55333 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbZFPCFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:05:19 -0400
Received: by mail-px0-f189.google.com with SMTP id 27so601057pxi.33
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=9WlyXWt8z2HajayepNuH0uqYf16MpURY/ttqxjVXZ4o=;
        b=MHS0MkPFMuFdIt4e1n81FBuk0VXbjLJzcOaWl8veetbxfXAHWkjNV0epB0YddA+6yM
         1IWhUyfgRy0oN5OuKota7MeMvK4U7SaniT+yvUsAL25j5wT2mIxoNgwJWKWU7u/HWpIY
         sl/WtqCzAqEVF9CFKH0JvsNL0Y8DjovepEiI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oU6cxw01YTlJFB1TNL6LqEVSXAKgBP4nRKiVbRuVHKEam+iFv7J1A71Lam1rNXsdcj
         Q5Ps2cX8QQ5A79FTUIHssyicGgfpG0umUTPmKIjQRaj6sjXA9JwLeiXHzQLjsy7kMgvk
         9LwlNAxZ22VsjokfM2ajQE6AiJa1TLO7EPLI8=
Received: by 10.115.58.1 with SMTP id l1mr12650262wak.106.1245117922552;
        Mon, 15 Jun 2009 19:05:22 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id n9sm19617wag.23.2009.06.15.19.05.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 19:05:21 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 15 Jun 2009 19:05:19 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245117905-19351-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121650>

git-rebase and git-am are talkative scripts. This option will quiet
them and allow them to speak only when they fail or experience errors.

Note that git-am with 3way will output errors when applying, even though
the 3way will usually be successfull. We suppress these errors from
git-apply because they are not "true" errors until the 3way has been
attempted.

Add a few tests for this new feature too.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt     |    6 +++++-
 Documentation/git-rebase.txt |    4 ++++
 git-am.sh                    |   26 ++++++++++++++++++++------
 git-rebase.sh                |   39 +++++++++++++++++++++++++++------------
 t/t3400-rebase.sh            |    7 +++++++
 t/t4150-am.sh                |   18 ++++++++++++++++++
 6 files changed, 81 insertions(+), 19 deletions(-)

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
index 578780b..42b1bae 100755
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
@@ -352,7 +359,7 @@ fi
 
 if test "$this" -gt "$last"
 then
-	echo Nothing to do.
+	say Nothing to do.
 	rm -fr "$dotest"
 	exit
 fi
@@ -498,11 +505,18 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying: %s\n' "$FIRSTLINE"
+	say "Applying: $FIRSTLINE"
 
 	case "$resolved" in
 	'')
-		eval 'git apply '"$git_apply_opt"' --index "$dotest/patch"'
+		if test "$threeway" = t && test -n "$GIT_QUIET"
+		then
+			eval 'git apply '"$git_apply_opt" \
+			' --index "$dotest/patch" > /dev/null 2>&1'
+		else
+			eval 'git apply '"$git_apply_opt" \
+			' --index "$dotest/patch"'
+		fi
 		apply_status=$?
 		;;
 	t)
@@ -534,7 +548,7 @@ do
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			echo No changes -- Patch already applied.
+			say No changes -- Patch already applied.
 			go_next
 			continue
 		    }
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..a518505 100755
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
@@ -138,7 +147,7 @@ move_to_original_branch () {
 finish_rb_merge () {
 	move_to_original_branch
 	rm -r "$dotest"
-	echo "All done."
+	say All done.
 }
 
 is_interactive () {
@@ -221,7 +230,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		git am --resolved $GIT_QUIET --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -249,7 +258,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+		git am -3 --skip $GIT_QUIET --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -300,6 +309,12 @@ do
 	-v|--verbose)
 		verbose=t
 		diffstat=t
+		GIT_QUIET=
+		;;
+	-q|--quiet)
+		GIT_QUIET="-q"
+		verbose=
+		diffstat=
 		;;
 	--whitespace=*)
 		git_am_opt="$git_am_opt $1"
@@ -445,15 +460,15 @@ then
 	then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to"
-		echo >&2 "Current branch $branch_name is up to date."
+		say >&2 "Current branch $branch_name is up to date."
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
 
@@ -471,7 +486,7 @@ fi
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	say >&2 "Fast-forwarded $branch_name to $onto_name."
 	move_to_original_branch
 	exit 0
 fi
@@ -487,7 +502,7 @@ if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		$root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+	git am $git_am_opt $GIT_QUIET --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7f62bfb..248944b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
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
