From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 21/31] rebase -i: align variable names
Date: Sun,  6 Feb 2011 13:43:50 -0500
Message-ID: <1297017841-20678-22-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eD-0005ZO-LN
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab1BFSq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:26 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab1BFSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:24 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zT8r7aGHI61RwfR/DL5hf9likMKsKTqbYfigj3hFBXY=;
        b=V5e4u3bB/oGr/gm8zuPEuG2BXUyVsX0XaYdlw//5KLI4jcHoWQ0/CcCqqUBz7OkBQs
         p3mNAEa8d3vAluyoxJRsluV7HyKwrP7GdaFc4u68rRTjOg//ZFHvUf3GsyQ2HmBNIj3c
         wLxQtWGwK5ZrYCaihuERWYMaGleuqA63+5MRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DxL3uw1u508ynXpei/1bF5vmolsevXeGk1mRFaV0jJL53lT/4YKfHHGG4rrUFBpMxD
         dQVeD3geD/TTTUOM5gCtu8fih6sIEPl+LGEoTzX76YZxkZZ4NC1+Y9lxlhAQmWs5uwRN
         xi53SfvtW8gWFxRJbBfJ9uaKoxIqRP4I4nUGk=
Received: by 10.224.47.84 with SMTP id m20mr13081576qaf.66.1297017984119;
        Sun, 06 Feb 2011 10:46:24 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:23 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166179>

Rename variables HEAD and OLDHEAD to orig_head and HEADNAME to
head_name, which are the names used in git-rebase.sh. This prepares
for factoring out of the code that persists these variables during the
entire rebase process. Using the same variable names to mean the same
thing in both files also makes the code easier to read.

While at it, also remove the DOTEST variable and use the state_dir
variable that was inherited from git-rebase.sh instead.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |  120 +++++++++++++++++++++----------------------
 1 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0499f9e..fa8bfda 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -12,22 +12,20 @@
 
 . git-sh-setup
 
-dotest="$GIT_DIR/rebase-merge"
-
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
 # file and written to the tail of $done.
-todo="$dotest"/git-rebase-todo
+todo="$state_dir"/git-rebase-todo
 
 # The rebase command lines that have already been processed.  A line
 # is moved here when it is first handled, before any associated user
 # actions.
-done="$dotest"/done
+done="$state_dir"/done
 
 # The commit message that is planned to be used for any changes that
 # need to be committed following a user interaction.
-msg="$dotest"/message
+msg="$state_dir"/message
 
 # The file into which is accumulated the suggested commit message for
 # squash/fixup commands.  When the first of a series of squash/fixups
@@ -42,14 +40,14 @@ msg="$dotest"/message
 # written to the file so far (including the initial "pick" commit).
 # Each time that a commit message is processed, this line is read and
 # updated.  It is deleted just before the combined commit is made.
-squash_msg="$dotest"/message-squash
+squash_msg="$state_dir"/message-squash
 
 # If the current series of squash/fixups has not yet included a squash
 # command, then this file exists and holds the commit message of the
 # original "pick" commit.  (If the series ends without a "squash"
 # command, then this can be used as the commit message of the combined
 # commit without opening the editor.)
-fixup_msg="$dotest"/message-fixup
+fixup_msg="$state_dir"/message-fixup
 
 # $rewritten is the name of a directory containing files for each
 # commit that is reachable by at least one merge base of $head and
@@ -57,14 +55,14 @@ fixup_msg="$dotest"/message-fixup
 # might be.  This ensures that commits on merged, but otherwise
 # unrelated side branches are left alone. (Think "X" in the man page's
 # example.)
-rewritten="$dotest"/rewritten
+rewritten="$state_dir"/rewritten
 
-dropped="$dotest"/dropped
+dropped="$state_dir"/dropped
 
 # A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE that will be used for the commit that is currently
 # being rebased.
-author_script="$dotest"/author-script
+author_script="$state_dir"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
 # commit to be edited is recorded in this file.  When "git rebase
@@ -72,14 +70,14 @@ author_script="$dotest"/author-script
 # will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
 # command is processed, this file is deleted.
-amend="$dotest"/amend
+amend="$state_dir"/amend
 
 # For the post-rewrite hook, we make a list of rewritten commits and
 # their new sha1s.  The rewritten-pending list keeps the sha1s of
 # commits that have been processed, but not committed yet,
 # e.g. because they are waiting for a 'squash' command.
-rewritten_list="$dotest"/rewritten-list
-rewritten_pending="$dotest"/rewritten-pending
+rewritten_list="$state_dir"/rewritten-list
+rewritten_pending="$state_dir"/rewritten-pending
 
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
@@ -145,7 +143,7 @@ make_patch () {
 	*)
 		echo "Root commit"
 		;;
-	esac > "$dotest"/patch
+	esac > "$state_dir"/patch
 	test -f "$msg" ||
 		commit_message "$1" > "$msg"
 	test -f "$author_script" ||
@@ -153,14 +151,14 @@ make_patch () {
 }
 
 die_with_patch () {
-	echo "$1" > "$dotest"/stopped-sha
+	echo "$1" > "$state_dir"/stopped-sha
 	make_patch "$1"
 	git rerere
 	die "$2"
 }
 
 die_abort () {
-	rm -rf "$dotest"
+	rm -rf "$state_dir"
 	die "$1"
 }
 
@@ -205,20 +203,20 @@ pick_one_preserving_merges () {
 	esac
 	sha1=$(git rev-parse $sha1)
 
-	if test -f "$dotest"/current-commit
+	if test -f "$state_dir"/current-commit
 	then
 		if test "$fast_forward" = t
 		then
 			while read current_commit
 			do
 				git rev-parse HEAD > "$rewritten"/$current_commit
-			done <"$dotest"/current-commit
-			rm "$dotest"/current-commit ||
+			done <"$state_dir"/current-commit
+			rm "$state_dir"/current-commit ||
 			die "Cannot write current commit's replacement sha1"
 		fi
 	fi
 
-	echo $sha1 >> "$dotest"/current-commit
+	echo $sha1 >> "$state_dir"/current-commit
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
@@ -425,7 +423,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$sha1" > "$dotest"/stopped-sha
+		echo "$sha1" > "$state_dir"/stopped-sha
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$amend"
 		warn "Stopped at $sha1... $rest"
@@ -490,7 +488,7 @@ do_next () {
 		printf 'Executing: %s\n' "$rest"
 		# "exec" command doesn't take a sha1 in the todo-list.
 		# => can't just use $sha1 here.
-		git rev-parse --verify HEAD > "$dotest"/stopped-sha
+		git rev-parse --verify HEAD > "$state_dir"/stopped-sha
 		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
 		status=$?
 		if test "$status" -ne 0
@@ -525,19 +523,19 @@ do_next () {
 	test -s "$todo" && return
 
 	comment_for_reflog finish &&
-	headname=$(cat "$dotest"/head-name) &&
-	oldhead=$(cat "$dotest"/head) &&
-	shortonto=$(git rev-parse --short $(cat "$dotest"/onto)) &&
+	head_name=$(cat "$state_dir"/head-name) &&
+	orig_head=$(cat "$state_dir"/head) &&
+	shortonto=$(git rev-parse --short $(cat "$state_dir"/onto)) &&
 	newhead=$(git rev-parse HEAD) &&
-	case $headname in
+	case $head_name in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $headname onto $shortonto" &&
-		git update-ref -m "$message" $headname $newhead $oldhead &&
-		git symbolic-ref HEAD $headname
+		message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
+		git update-ref -m "$message" $head_name $newhead $orig_head &&
+		git symbolic-ref HEAD $head_name
 		;;
 	esac && {
-		test ! -f "$dotest"/verbose ||
-			git diff-tree --stat $(cat "$dotest"/head)..HEAD
+		test ! -f "$state_dir"/verbose ||
+			git diff-tree --stat $(cat "$state_dir"/head)..HEAD
 	} &&
 	{
 		test -s "$rewritten_list" &&
@@ -549,9 +547,9 @@ do_next () {
 		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
-	rm -rf "$dotest" &&
+	rm -rf "$state_dir" &&
 	git gc --auto &&
-	warn "Successfully rebased and updated $headname."
+	warn "Successfully rebased and updated $head_name."
 
 	exit
 }
@@ -602,9 +600,9 @@ skip_unnecessary_picks () {
 
 get_saved_options () {
 	test -d "$rewritten" && preserve_merges=t
-	test -f "$dotest"/strategy && strategy="$(cat "$dotest"/strategy)"
-	test -f "$dotest"/verbose && verbose=t
-	test -f "$dotest"/rebase-root && rebase_root=t
+	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
+	test -f "$state_dir"/verbose && verbose=t
+	test -f "$state_dir"/rebase-root && rebase_root=t
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
@@ -704,7 +702,7 @@ first and then run 'git rebase --continue' again."
 		}
 	fi
 
-	record_in_rewritten "$(cat "$dotest"/stopped-sha)"
+	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
 
 	require_clean_work_tree "rebase"
 	do_rest
@@ -715,15 +713,15 @@ abort)
 
 	git rerere clear
 
-	headname=$(cat "$dotest"/head-name)
-	head=$(cat "$dotest"/head)
-	case $headname in
+	head_name=$(cat "$state_dir"/head-name)
+	orig_head=$(cat "$state_dir"/head)
+	case $head_name in
 	refs/*)
-		git symbolic-ref HEAD $headname
+		git symbolic-ref HEAD $head_name
 		;;
 	esac &&
-	output git reset --hard $head &&
-	rm -rf "$dotest"
+	output git reset --hard $orig_head &&
+	rm -rf "$state_dir"
 	exit
 	;;
 skip)
@@ -747,28 +745,28 @@ then
 		die "Could not checkout $switch_to"
 fi
 
-head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$dotest" || die "Could not create temporary $dotest"
+orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
+mkdir "$state_dir" || die "Could not create temporary $state_dir"
 
-: > "$dotest"/interactive || die "Could not mark as interactive"
-echo "$head_name" > "$dotest"/head-name
+: > "$state_dir"/interactive || die "Could not mark as interactive"
+echo "$head_name" > "$state_dir"/head-name
 
-echo $head > "$dotest"/head
+echo $orig_head > "$state_dir"/head
 case "$rebase_root" in
 '')
-	rm -f "$dotest"/rebase-root ;;
+	rm -f "$state_dir"/rebase-root ;;
 *)
-	: >"$dotest"/rebase-root ;;
+	: >"$state_dir"/rebase-root ;;
 esac
-echo $onto > "$dotest"/onto
-test -z "$strategy" || echo "$strategy" > "$dotest"/strategy
-test t = "$verbose" && : > "$dotest"/verbose
+echo $onto > "$state_dir"/onto
+test -z "$strategy" || echo "$strategy" > "$state_dir"/strategy
+test t = "$verbose" && : > "$state_dir"/verbose
 if test t = "$preserve_merges"
 then
 	if test -z "$rebase_root"
 	then
 		mkdir "$rewritten" &&
-		for c in $(git merge-base --all $head $upstream)
+		for c in $(git merge-base --all $orig_head $upstream)
 		do
 			echo $onto > "$rewritten"/$c ||
 				die "Could not init rewritten commits"
@@ -782,21 +780,21 @@ then
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	merges_option=
-	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$head | head -n 1)"
+	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$orig_head | head -n 1)"
 else
 	merges_option="--no-merges --cherry-pick"
 fi
 
-shorthead=$(git rev-parse --short $head)
+shorthead=$(git rev-parse --short $orig_head)
 shortonto=$(git rev-parse --short $onto)
 if test -z "$rebase_root"
 	# this is now equivalent to ! -z "$upstream"
 then
 	shortupstream=$(git rev-parse --short $upstream)
-	revisions=$upstream...$head
+	revisions=$upstream...$orig_head
 	shortrevisions=$shortupstream..$shorthead
 else
-	revisions=$onto...$head
+	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
 git rev-list $merges_option --pretty=oneline --abbrev-commit \
@@ -837,13 +835,13 @@ then
 	mkdir "$dropped"
 	# Save all non-cherry-picked changes
 	git rev-list $revisions --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$dotest"/not-cherry-picks
+		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
 	# Now all commits and note which ones are missing in
 	# not-cherry-picks and hence being dropped
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$dotest"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
@@ -889,5 +887,5 @@ has_action "$todo" ||
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
 output git checkout $onto || die_abort "could not detach HEAD"
-git update-ref ORIG_HEAD $head
+git update-ref ORIG_HEAD $orig_head
 do_rest
-- 
1.7.4.rc2.33.g8a14f
