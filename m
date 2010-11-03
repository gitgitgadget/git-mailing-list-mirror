From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 1/5] rebase: clearer names for directory variables
Date: Wed,  3 Nov 2010 22:09:36 +0100
Message-ID: <1288818580-7576-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDS-0001u6-Df
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab0KDDKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:14 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57010 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880Ab0KDDKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:12 -0400
Received: by mail-qy0-f181.google.com with SMTP id 10so860265qyk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zBaLp3YB1ipTSZSxPN5uQRvW1rcmzRXHzrlhtjlh0qU=;
        b=ptxW9zicZbPaN53eWKRV1gZzNKf7gh3b3vw7TxytzBOCYO3QfMLq4beHa6/kqhCql6
         hAZ108JzybtRPO7aMQJRds1nFwlA7k8MNBipOERrfsmbSS7hqfGNiqWqyWpuMVEXY+5g
         r+PFE/tEDkcBRb+Si2VvdNE/7vopqH+aws0Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j9p+uuYAGSVMhsl+y1UYHqN7JlBybh9JAIraYFl2/P/zEQ6sIFj7qmrvS3mWzRhgN5
         wCMHiLhQBCgG2AnVbSw9uJhUVTXPfm9oezWWb8fMPMfiq4JXBEZBT61ZWyyX18Pm40cC
         cJIFzez4hxB2XVGzGO+P3rU4/0PyEo8gudWeM=
Received: by 10.229.70.130 with SMTP id d2mr115002qcj.53.1288840211889;
        Wed, 03 Nov 2010 20:10:11 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
In-Reply-To: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160683>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

Instead of using the old variable name 'dotest' for
"$GIT_DIR"/rebase-merge and no variable for "$GIT_DIR"/rebase-apply,
introduce two variables 'merge_dir' and 'apply_dir' for these paths.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |  145 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 73 insertions(+), 72 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e5df23b..8d5cf03 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -46,7 +46,8 @@ unset newbase
 strategy=recursive
 strategy_opts=
 do_merge=
-dotest="$GIT_DIR"/rebase-merge
+merge_dir="$GIT_DIR"/rebase-merge
+apply_dir="$GIT_DIR"/rebase-apply
 prec=4
 verbose=
 diffstat=$(git config --bool rebase.stat)
@@ -57,7 +58,7 @@ allow_rerere_autoupdate=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
-	test -d "$dotest" || die "$dotest directory does not exist"
+	test -d "$merge_dir" || die "$merge_dir directory does not exist"
 
 	unmerged=$(git ls-files -u)
 	if test -n "$unmerged"
@@ -67,7 +68,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat "$dotest/current"`
+	cmt=`cat "$merge_dir/current"`
 	if ! git diff-index --quiet --ignore-submodules HEAD --
 	then
 		if ! git commit --no-verify -C "$cmt"
@@ -80,7 +81,7 @@ continue_merge () {
 		then
 			printf "Committed: %0${prec}d " $msgnum
 		fi
-		echo "$cmt $(git rev-parse HEAD^0)" >> "$dotest/rewritten"
+		echo "$cmt $(git rev-parse HEAD^0)" >> "$merge_dir/rewritten"
 	else
 		if test -z "$GIT_QUIET"
 		then
@@ -92,22 +93,22 @@ continue_merge () {
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$dotest/prev_head"
+	echo "$prev_head" > "$merge_dir/prev_head"
 
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
-	echo "$msgnum" >"$dotest/msgnum"
+	echo "$msgnum" >"$merge_dir/msgnum"
 }
 
 call_merge () {
-	cmt="$(cat "$dotest/cmt.$1")"
-	echo "$cmt" > "$dotest/current"
+	cmt="$(cat "$merge_dir/cmt.$1")"
+	echo "$cmt" > "$merge_dir/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=$(cat "$dotest/msgnum")
-	end=$(cat "$dotest/end")
+	msgnum=$(cat "$merge_dir/msgnum")
+	end=$(cat "$merge_dir/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'
+	eval GITHEAD_$hd='$(cat "$merge_dir/onto_name")'
 	export GITHEAD_$cmt GITHEAD_$hd
 	if test -n "$GIT_QUIET"
 	then
@@ -137,9 +138,9 @@ call_merge () {
 
 move_to_original_branch () {
 	test -z "$head_name" &&
-		head_name="$(cat "$dotest"/head-name)" &&
-		onto="$(cat "$dotest"/onto)" &&
-		orig_head="$(cat "$dotest"/orig-head)"
+		head_name="$(cat "$merge_dir"/head-name)" &&
+		onto="$(cat "$merge_dir"/onto)" &&
+		orig_head="$(cat "$merge_dir"/orig-head)"
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
@@ -153,12 +154,12 @@ move_to_original_branch () {
 
 finish_rb_merge () {
 	move_to_original_branch
-	git notes copy --for-rewrite=rebase < "$dotest"/rewritten
+	git notes copy --for-rewrite=rebase < "$merge_dir"/rewritten
 	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$dotest"/rewritten; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+		test -s "$merge_dir"/rewritten; then
+		"$GIT_DIR"/hooks/post-rewrite rebase < "$merge_dir"/rewritten
 	fi
-	rm -r "$dotest"
+	rm -r "$merge_dir"
 	say All done.
 }
 
@@ -182,7 +183,7 @@ is_interactive () {
 		export GIT_EDITOR
 	fi
 
-	test -n "$interactive_rebase" || test -f "$dotest"/interactive
+	test -n "$interactive_rebase" || test -f "$merge_dir"/interactive
 }
 
 run_pre_rebase_hook () {
@@ -194,7 +195,7 @@ run_pre_rebase_hook () {
 	fi
 }
 
-test -f "$GIT_DIR"/rebase-apply/applying &&
+test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
@@ -206,7 +207,7 @@ do
 		OK_TO_SKIP_PRE_REBASE=yes
 		;;
 	--continue)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git update-index --ignore-submodules --refresh &&
@@ -215,13 +216,13 @@ do
 			echo "mark them as resolved using git add"
 			exit 1
 		}
-		if test -d "$dotest"
+		if test -d "$merge_dir"
 		then
-			prev_head=$(cat "$dotest/prev_head")
-			end=$(cat "$dotest/end")
-			msgnum=$(cat "$dotest/msgnum")
-			onto=$(cat "$dotest/onto")
-			GIT_QUIET=$(cat "$dotest/quiet")
+			prev_head=$(cat "$merge_dir/prev_head")
+			end=$(cat "$merge_dir/end")
+			msgnum=$(cat "$merge_dir/msgnum")
+			onto=$(cat "$merge_dir/onto")
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			continue_merge
 			while test "$msgnum" -le "$end"
 			do
@@ -231,28 +232,28 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		head_name=$(cat "$apply_dir"/head-name) &&
+		onto=$(cat "$apply_dir"/onto) &&
+		orig_head=$(cat "$apply_dir"/orig-head) &&
+		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--skip)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git reset --hard HEAD || exit $?
-		if test -d "$dotest"
+		if test -d "$merge_dir"
 		then
 			git rerere clear
-			prev_head=$(cat "$dotest/prev_head")
-			end=$(cat "$dotest/end")
-			msgnum=$(cat "$dotest/msgnum")
+			prev_head=$(cat "$merge_dir/prev_head")
+			end=$(cat "$merge_dir/end")
+			msgnum=$(cat "$merge_dir/msgnum")
 			msgnum=$(($msgnum + 1))
-			onto=$(cat "$dotest/onto")
-			GIT_QUIET=$(cat "$dotest/quiet")
+			onto=$(cat "$merge_dir/onto")
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			while test "$msgnum" -le "$end"
 			do
 				call_merge "$msgnum"
@@ -261,30 +262,30 @@ do
 			finish_rb_merge
 			exit
 		fi
-		head_name=$(cat "$GIT_DIR"/rebase-apply/head-name) &&
-		onto=$(cat "$GIT_DIR"/rebase-apply/onto) &&
-		orig_head=$(cat "$GIT_DIR"/rebase-apply/orig-head) &&
-		GIT_QUIET=$(cat "$GIT_DIR"/rebase-apply/quiet)
+		head_name=$(cat "$apply_dir"/head-name) &&
+		onto=$(cat "$apply_dir"/onto) &&
+		orig_head=$(cat "$apply_dir"/orig-head) &&
+		GIT_QUIET=$(cat "$apply_dir"/quiet)
 		git am -3 --skip --resolvemsg="$RESOLVEMSG" &&
 		move_to_original_branch
 		exit
 		;;
 	--abort)
-		test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply ||
+		test -d "$merge_dir" -o -d "$apply_dir" ||
 			die "No rebase in progress?"
 
 		git rerere clear
-		if test -d "$dotest"
+		if test -d "$merge_dir"
 		then
-			GIT_QUIET=$(cat "$dotest/quiet")
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			move_to_original_branch
 		else
-			dotest="$GIT_DIR"/rebase-apply
-			GIT_QUIET=$(cat "$dotest/quiet")
+			merge_dir="$apply_dir"
+			GIT_QUIET=$(cat "$merge_dir/quiet")
 			move_to_original_branch
 		fi
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
+		git reset --hard $(cat "$merge_dir/orig-head")
+		rm -r "$merge_dir"
 		exit
 		;;
 	--onto)
@@ -387,31 +388,31 @@ test $# -gt 2 && usage
 
 if test $# -eq 0 && test -z "$rebase_root"
 then
-	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
-	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
+	test -d "$merge_dir" -o -d "$apply_dir" || usage
+	test -d "$merge_dir" -o -f "$apply_dir"/rebasing &&
 		die 'A rebase is in progress, try --continue, --skip or --abort.'
 fi
 
-# Make sure we do not have $GIT_DIR/rebase-apply
+# Make sure we do not have $apply_dir or $merge_dir
 if test -z "$do_merge"
 then
-	if mkdir "$GIT_DIR"/rebase-apply 2>/dev/null
+	if mkdir "$apply_dir" 2>/dev/null
 	then
-		rmdir "$GIT_DIR"/rebase-apply
+		rmdir "$apply_dir"
 	else
 		echo >&2 '
 It seems that I cannot create a rebase-apply directory, and
 I wonder if you are in the middle of patch application or another
 rebase.  If that is not the case, please
-	rm -fr '"$GIT_DIR"'/rebase-apply
+	rm -fr '"$apply_dir"'
 and run me again.  I am stopping in case you still have something
 valuable there.'
 		exit 1
 	fi
 else
-	if test -d "$dotest"
+	if test -d "$merge_dir"
 	then
-		die "previous rebase directory $dotest still exists." \
+		die "previous rebase directory $merge_dir still exists." \
 			'Try git rebase (--continue | --abort | --skip)'
 	fi
 fi
@@ -571,35 +572,35 @@ then
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
-	test 0 != $ret -a -d "$GIT_DIR"/rebase-apply &&
-		echo $head_name > "$GIT_DIR"/rebase-apply/head-name &&
-		echo $onto > "$GIT_DIR"/rebase-apply/onto &&
-		echo $orig_head > "$GIT_DIR"/rebase-apply/orig-head &&
-		echo "$GIT_QUIET" > "$GIT_DIR"/rebase-apply/quiet
+	test 0 != $ret -a -d "$apply_dir" &&
+		echo $head_name > "$apply_dir/head-name" &&
+		echo $onto > "$apply_dir/onto" &&
+		echo $orig_head > "$apply_dir/orig-head" &&
+		echo "$GIT_QUIET" > "$apply_dir/quiet"
 	exit $ret
 fi
 
 # start doing a rebase with git-merge
 # this is rename-aware if the recursive (default) strategy is used
 
-mkdir -p "$dotest"
-echo "$onto" > "$dotest/onto"
-echo "$onto_name" > "$dotest/onto_name"
+mkdir -p "$merge_dir"
+echo "$onto" > "$merge_dir/onto"
+echo "$onto_name" > "$merge_dir/onto_name"
 prev_head=$orig_head
-echo "$prev_head" > "$dotest/prev_head"
-echo "$orig_head" > "$dotest/orig-head"
-echo "$head_name" > "$dotest/head-name"
-echo "$GIT_QUIET" > "$dotest/quiet"
+echo "$prev_head" > "$merge_dir/prev_head"
+echo "$orig_head" > "$merge_dir/orig-head"
+echo "$head_name" > "$merge_dir/head-name"
+echo "$GIT_QUIET" > "$merge_dir/quiet"
 
 msgnum=0
 for cmt in `git rev-list --reverse --no-merges "$revisions"`
 do
 	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$dotest/cmt.$msgnum"
+	echo "$cmt" > "$merge_dir/cmt.$msgnum"
 done
 
-echo 1 >"$dotest/msgnum"
-echo $msgnum >"$dotest/end"
+echo 1 >"$merge_dir/msgnum"
+echo $msgnum >"$merge_dir/end"
 
 end=$msgnum
 msgnum=1
-- 
1.7.3.rc1.4.g5879b6
