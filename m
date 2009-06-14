From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 3/3] am, rebase: teach quiet option
Date: Sun, 14 Jun 2009 16:16:14 -0700
Message-ID: <1245021374-8430-4-git-send-email-bebarino@gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
 <1245021374-8430-1-git-send-email-bebarino@gmail.com>
 <1245021374-8430-2-git-send-email-bebarino@gmail.com>
 <1245021374-8430-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 01:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFywR-0001KJ-Jb
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 01:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758097AbZFNXQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 19:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757924AbZFNXQ1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 19:16:27 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:40691 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbZFNXQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 19:16:26 -0400
Received: by mail-pz0-f187.google.com with SMTP id 17so1583525pzk.33
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=N3dSCyLg+BN5jw4vIzEdaqgHbRYuP++s0bfWB9kyQ/w=;
        b=TWXzkF+DbvTY2t4tUblO1+g6Bup0YN6pil7CmbL/FxcIkmz5DzfEgo4BJtoZlLQ7Zm
         CRKDTTvpXxMaa8eLsp39R8xVv7eLu8D6WT70f1/tlv1fzpIfdR0+XQteAeTgaSc3NKXl
         EwSuFtKNBKi2GxnN7uwGR/F1CS0GcBsshMgfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q11DgExidx0fWYUzboOK+wASXmuMK448N1sx1weKM5dfHhZ8XqscUgAwkGyAgoQCci
         LGiLsgNUtCAmY6UteVtpC8lnQsNaDjkZOAD0TCi+/8WB4rM9qVYBVfNIE8odFvzmlhjk
         5Sm3ODjknjRS3E6Awcl8XvHp4uJtrFPSUtFik=
Received: by 10.143.158.2 with SMTP id k2mr2804596wfo.53.1245021388746;
        Sun, 14 Jun 2009 16:16:28 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 32sm6542727wfa.33.2009.06.14.16.16.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 16:16:27 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 14 Jun 2009 16:16:25 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245021374-8430-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121570>

git-rebase and git-am are talkative scripts. This option will quiet
them and allow them to speak only when they fail or experience errors.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-am.txt     |    6 +++++-
 Documentation/git-rebase.txt |    4 ++++
 git-am.sh                    |   17 ++++++++++++-----
 git-rebase.sh                |   40 +++++++++++++++++++++++++++++-----------
 t/t3400-rebase.sh            |    7 +++++++
 t/t4150-am.sh                |    7 +++++++
 6 files changed, 64 insertions(+), 17 deletions(-)

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
index 578780b..899ab83 100755
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
@@ -498,7 +505,7 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying: %s\n' "$FIRSTLINE"
+	say "Applying: $FIRSTLINE"
 
 	case "$resolved" in
 	'')
@@ -534,7 +541,7 @@ do
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			echo No changes -- Patch already applied.
+			say No changes -- Patch already applied.
 			go_next
 			continue
 		    }
diff --git a/git-rebase.sh b/git-rebase.sh
index b83fd3f..e6d44ff 100755
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
@@ -72,9 +72,15 @@ continue_merge () {
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
 	fi
 	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
@@ -138,7 +144,7 @@ move_to_original_branch () {
 finish_rb_merge () {
 	move_to_original_branch
 	rm -r "$dotest"
-	echo "All done."
+	say "All done."
 }
 
 is_interactive () {
@@ -221,7 +227,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+		git am --resolved $GIT_QUIET --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -249,7 +255,7 @@ do
 		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
 		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
 		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
+		git am -3 --skip $GIT_QUIET --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
@@ -300,6 +306,12 @@ do
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
@@ -445,15 +457,18 @@ then
 	then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to"
-		echo >&2 "Current branch $branch_name is up to date."
+		if test -z "$GIT_QUIET"
+		then
+			echo >&2 "Current branch $branch_name is up to date."
+		fi
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
 
@@ -471,7 +486,10 @@ fi
 # we just fast forwarded.
 if test "$mb" = "$branch"
 then
-	echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	if test -z "$GIT_QUIET"
+	then
+		echo >&2 "Fast-forwarded $branch_name to $onto_name."
+	fi
 	move_to_original_branch
 	exit 0
 fi
@@ -487,7 +505,7 @@ if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
 		$root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
+	git am $git_am_opt $GIT_QUIET --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
 	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 7f62bfb..fe6445b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -126,4 +126,11 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
      grep "Untracked working tree file .B. would be overwritten" output.err
 '
 
+test_expect_success 'rebase -q is quiet' '
+     rm B &&
+     git checkout -b quiet topic &&
+     git rebase -q master > output.out &&
+     test ! -s output.out
+'
+
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d6ebbae..f8725a9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -305,4 +305,11 @@ test_expect_success 'am into an unborn branch' '
 	test "z$result" = "z$(git rev-parse first^{tree})"
 '
 
+test_expect_success 'am -q is quiet' '
+	git checkout first &&
+	test_tick &&
+	git am -q <patch1 > output.out &&
+	test ! -s output.out
+'
+
 test_done
-- 
1.6.3.2.306.g4f4fa
