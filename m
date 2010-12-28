From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 21/31] rebase -i: align variable names
Date: Tue, 28 Dec 2010 10:30:38 +0100
Message-ID: <1293528648-21873-22-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYo-0005Wr-IX
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0L1PdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:12 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0L1PdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:00 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tzlRDwxQ/hsPol9bl1OcsBxFFjtF3bysdTffnPzhINQ=;
        b=Fo41t3ESbqb0IjKYYC4/5LNgL0DCemm1t1pvcgnydbl6UQUfqi5iqW1D4tXvMBqLRr
         sjVjioOldzoxjruMTZnBi66MRhBkEMPsr+rEpaiDUFgqMLvWZok7ivR4TIChVj3NoBTS
         sREmaPNSCUhbMKF1M6mA5c4AlReu77pdu1YhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y7vnaYupoKLyv+QwrPpkEMsbY2wQPshMiGI+smfgbO+eRRAf7zekR7U6yZVZxFRyo6
         kiKfodMis5QSs0kg/d3+QhNifZYpcTwFVfVCnXBOnDHBTqOq2fyuXJeFW80WH+VfYUnL
         Or1eFS8EUOMUV7sw3YnzLu25YfVZBqerJqbsc=
Received: by 10.224.53.194 with SMTP id n2mr12856096qag.367.1293550380018;
        Tue, 28 Dec 2010 07:33:00 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164258>

Rename variables HEAD and OLDHEAD to orig_head and HEADNAME to
head_name, which are the names used in git-rebase.sh. This prepares
for factoring out of the code that persists these variables during the
entire rebase process. Using the same variable names to mean the same
thing in both files also makes the code easier to read.

While at it, also remove the DOTEST variable and use the state_dir
variable that was inherited from git-rebase.sh instead.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Squash this commit with earlier commit that also renamed variables in
git-rebase--interactive.sh?

 git-rebase--interactive.sh |  120 +++++++++++++++++++++----------------------
 1 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e848ea2..eace4e5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -12,22 +12,20 @@
 
 . git-sh-setup
 
-DOTEST="$GIT_DIR/rebase-merge"
-
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
 # file and written to the tail of $DONE.
-TODO="$DOTEST"/git-rebase-todo
+TODO="$state_dir"/git-rebase-todo
 
 # The rebase command lines that have already been processed.  A line
 # is moved here when it is first handled, before any associated user
 # actions.
-DONE="$DOTEST"/done
+DONE="$state_dir"/done
 
 # The commit message that is planned to be used for any changes that
 # need to be committed following a user interaction.
-MSG="$DOTEST"/message
+MSG="$state_dir"/message
 
 # The file into which is accumulated the suggested commit message for
 # squash/fixup commands.  When the first of a series of squash/fixups
@@ -42,14 +40,14 @@ MSG="$DOTEST"/message
 # written to the file so far (including the initial "pick" commit).
 # Each time that a commit message is processed, this line is read and
 # updated.  It is deleted just before the combined commit is made.
-SQUASH_MSG="$DOTEST"/message-squash
+SQUASH_MSG="$state_dir"/message-squash
 
 # If the current series of squash/fixups has not yet included a squash
 # command, then this file exists and holds the commit message of the
 # original "pick" commit.  (If the series ends without a "squash"
 # command, then this can be used as the commit message of the combined
 # commit without opening the editor.)
-FIXUP_MSG="$DOTEST"/message-fixup
+FIXUP_MSG="$state_dir"/message-fixup
 
 # $REWRITTEN is the name of a directory containing files for each
 # commit that is reachable by at least one merge base of $HEAD and
@@ -57,14 +55,14 @@ FIXUP_MSG="$DOTEST"/message-fixup
 # might be.  This ensures that commits on merged, but otherwise
 # unrelated side branches are left alone. (Think "X" in the man page's
 # example.)
-REWRITTEN="$DOTEST"/rewritten
+REWRITTEN="$state_dir"/rewritten
 
-DROPPED="$DOTEST"/dropped
+DROPPED="$state_dir"/dropped
 
 # A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE that will be used for the commit that is currently
 # being rebased.
-AUTHOR_SCRIPT="$DOTEST"/author-script
+AUTHOR_SCRIPT="$state_dir"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
 # commit to be edited is recorded in this file.  When "git rebase
@@ -72,14 +70,14 @@ AUTHOR_SCRIPT="$DOTEST"/author-script
 # will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
 # command is processed, this file is deleted.
-AMEND="$DOTEST"/amend
+AMEND="$state_dir"/amend
 
 # For the post-rewrite hook, we make a list of rewritten commits and
 # their new sha1s.  The rewritten-pending list keeps the sha1s of
 # commits that have been processed, but not committed yet,
 # e.g. because they are waiting for a 'squash' command.
-REWRITTEN_LIST="$DOTEST"/rewritten-list
-REWRITTEN_PENDING="$DOTEST"/rewritten-pending
+REWRITTEN_LIST="$state_dir"/rewritten-list
+REWRITTEN_PENDING="$state_dir"/rewritten-pending
 
 GIT_CHERRY_PICK_HELP="$RESOLVEMSG"
 export GIT_CHERRY_PICK_HELP
@@ -145,7 +143,7 @@ make_patch () {
 	*)
 		echo "Root commit"
 		;;
-	esac > "$DOTEST"/patch
+	esac > "$state_dir"/patch
 	test -f "$MSG" ||
 		commit_message "$1" > "$MSG"
 	test -f "$AUTHOR_SCRIPT" ||
@@ -153,14 +151,14 @@ make_patch () {
 }
 
 die_with_patch () {
-	echo "$1" > "$DOTEST"/stopped-sha
+	echo "$1" > "$state_dir"/stopped-sha
 	make_patch "$1"
 	git rerere
 	die "$2"
 }
 
 die_abort () {
-	rm -rf "$DOTEST"
+	rm -rf "$state_dir"
 	die "$1"
 }
 
@@ -205,20 +203,20 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$DOTEST"/current-commit
+	if test -f "$state_dir"/current-commit
 	then
 		if test "$fast_forward" = t
 		then
 			while read current_commit
 			do
 				git rev-parse HEAD > "$REWRITTEN"/$current_commit
-			done <"$DOTEST"/current-commit
-			rm "$DOTEST"/current-commit ||
+			done <"$state_dir"/current-commit
+			rm "$state_dir"/current-commit ||
 			die "Cannot write current commit's replacement sha1"
 		fi
 	fi
 
-	echo $sha1 >> "$DOTEST"/current-commit
+	echo $sha1 >> "$state_dir"/current-commit
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
@@ -425,7 +423,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$DOTEST"/stopped-sha
+		echo "$sha1" > "$state_dir"/stopped-sha
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
@@ -490,7 +488,7 @@ do_next () {
 		printf 'Executing: %s\n' "$rest"
 		# "exec" command doesn't take a sha1 in the todo-list.
 		# => can't just use $sha1 here.
-		git rev-parse --verify HEAD > "$DOTEST"/stopped-sha
+		git rev-parse --verify HEAD > "$state_dir"/stopped-sha
 		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
 		status=$?
 		if test "$status" -ne 0
@@ -525,19 +523,19 @@ do_next () {
 	test -s "$TODO" && return
 
 	comment_for_reflog finish &&
-	HEADNAME=$(cat "$DOTEST"/head-name) &&
-	OLDHEAD=$(cat "$DOTEST"/head) &&
-	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
+	head_name=$(cat "$state_dir"/head-name) &&
+	orig_head=$(cat "$state_dir"/head) &&
+	SHORTONTO=$(git rev-parse --short $(cat "$state_dir"/onto)) &&
 	NEWHEAD=$(git rev-parse HEAD) &&
-	case $HEADNAME in
+	case $head_name in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO" &&
-		git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
-		git symbolic-ref HEAD $HEADNAME
+		message="$GIT_REFLOG_ACTION: $head_name onto $SHORTONTO" &&
+		git update-ref -m "$message" $head_name $NEWHEAD $orig_head &&
+		git symbolic-ref HEAD $head_name
 		;;
 	esac && {
-		test ! -f "$DOTEST"/verbose ||
-			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
+		test ! -f "$state_dir"/verbose ||
+			git diff-tree --stat $(cat "$state_dir"/head)..HEAD
 	} &&
 	{
 		test -s "$REWRITTEN_LIST" &&
@@ -549,9 +547,9 @@ do_next () {
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$REWRITTEN_LIST"
 		true # we don't care if this hook failed
 	fi &&
-	rm -rf "$DOTEST" &&
+	rm -rf "$state_dir" &&
 	git gc --auto &&
-	warn "Successfully rebased and updated $HEADNAME."
+	warn "Successfully rebased and updated $head_name."
 
 	exit
 }
@@ -602,9 +600,9 @@ skip_unnecessary_picks () {
 
 get_saved_options () {
 	test -d "$REWRITTEN" && preserve_merges=t
-	test -f "$DOTEST"/strategy && strategy="$(cat "$DOTEST"/strategy)"
-	test -f "$DOTEST"/verbose && verbose=t
-	test -f "$DOTEST"/rebase-root && rebase_root=t
+	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
+	test -f "$state_dir"/verbose && verbose=t
+	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
@@ -704,7 +702,7 @@ first and then run 'git rebase --continue' again."
 		}
 	fi
 
-	record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
+	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
 
 	require_clean_work_tree "rebase"
 	do_rest
@@ -715,15 +713,15 @@ abort)
 
 	git rerere clear
 
-	HEADNAME=$(cat "$DOTEST"/head-name)
-	HEAD=$(cat "$DOTEST"/head)
-	case $HEADNAME in
+	head_name=$(cat "$state_dir"/head-name)
+	orig_head=$(cat "$state_dir"/head)
+	case $head_name in
 	refs/*)
-		git symbolic-ref HEAD $HEADNAME
+		git symbolic-ref HEAD $head_name
 		;;
 	esac &&
-	output git reset --hard $HEAD &&
-	rm -rf "$DOTEST"
+	output git reset --hard $orig_head &&
+	rm -rf "$state_dir"
 	exit
 	;;
 skip)
@@ -747,28 +745,28 @@ then
 		die "Could not checkout $switch_to"
 fi
 
-HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
+orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
+mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
-: > "$DOTEST"/interactive || die "Could not mark as interactive"
-echo "$head_name" > "$DOTEST"/head-name
+: > "$state_dir"/interactive || die "Could not mark as interactive"
+echo "$head_name" > "$state_dir"/head-name
 
-echo $HEAD > "$DOTEST"/head
+echo $orig_head > "$state_dir"/head
 case "$rebase_root" in
 '')
-	rm -f "$DOTEST"/rebase-root ;;
+	rm -f "$state_dir"/rebase-root ;;
 *)
-	: >"$DOTEST"/rebase-root ;;
+	: >"$state_dir"/rebase-root ;;
 esac
-echo $onto > "$DOTEST"/onto
-test -z "$strategy" || echo "$strategy" > "$DOTEST"/strategy
-test t = "$verbose" && : > "$DOTEST"/verbose
+echo $onto > "$state_dir"/onto
+test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
+test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
 	then
 		mkdir "$REWRITTEN" &&
-		for c in $(git merge-base --all $HEAD $upstream)
+		for c in $(git merge-base --all $orig_head $upstream)
 		do
 			echo $onto > "$REWRITTEN"/$c ||
 				die "Could not init rewritten commits"
@@ -782,21 +780,21 @@ then
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	MERGES_OPTION=
-	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$HEAD | head -n 1)"
+	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$orig_head | head -n 1)"
 else
 	MERGES_OPTION="--no-merges --cherry-pick"
 fi
 
-SHORTHEAD=$(git rev-parse --short $HEAD)
+SHORTHEAD=$(git rev-parse --short $orig_head)
 SHORTONTO=$(git rev-parse --short $onto)
 if test -z "$rebase_root"
 	# this is now equivalent to ! -z "$upstream"
 then
 	SHORTUPSTREAM=$(git rev-parse --short $upstream)
-	REVISIONS=$upstream...$HEAD
+	REVISIONS=$upstream...$orig_head
 	SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
 else
-	REVISIONS=$onto...$HEAD
+	REVISIONS=$onto...$orig_head
 	SHORTREVISIONS=$SHORTHEAD
 fi
 git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
@@ -837,13 +835,13 @@ then
 	mkdir "$DROPPED"
 	# Save all non-cherry-picked changes
 	git rev-list $REVISIONS --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
+		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
 	# Now all commits and note which ones are missing in
 	# not-cherry-picks and hence being dropped
 	git rev-list $REVISIONS |
 	while read rev
 	do
-		if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
+		if test -f "$REWRITTEN"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
@@ -889,5 +887,5 @@ has_action "$TODO" ||
 test -d "$REWRITTEN" || test -n "$force_rebase" || skip_unnecessary_picks
 
 output git checkout $onto || die_abort "could not detach HEAD"
-git update-ref ORIG_HEAD $HEAD
+git update-ref ORIG_HEAD $orig_head
 do_rest
-- 
1.7.3.2.864.gbbb96
