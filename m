Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B5BC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EC261422
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbhDWTnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:40 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35312 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243902AbhDWTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:33 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 6863280590;
        Fri, 23 Apr 2021 15:42:56 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 17/30] subtree: use more explicit variable names for cmdline args
Date:   Fri, 23 Apr 2021 13:42:17 -0600
Message-Id: <20210423194230.1388945-18-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Make it painfully obvious when reading the code which variables are
direct parsings of command line arguments.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/git-subtree.sh | 132 ++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index bb4934dbc0..d7de4b0653 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -30,19 +30,19 @@ squash        merge subtree changes as a single commit
 
 PATH=$PATH:$(git --exec-path)
 
-branch=
-debug=
-command=
-onto=
-rejoin=
-ignore_joins=
-annotate=
-squash=
-message=
-prefix=
+arg_debug=
+arg_command=
+arg_prefix=
+arg_split_branch=
+arg_split_onto=
+arg_split_rejoin=
+arg_split_ignore_joins=
+arg_split_annotate=
+arg_addmerge_squash=
+arg_addmerge_message=
 
 debug () {
-	if test -n "$debug"
+	if test -n "$arg_debug"
 	then
 		printf "%s\n" "$*" >&2
 	fi
@@ -88,54 +88,54 @@ main () {
 			GIT_QUIET=1
 			;;
 		-d)
-			debug=1
+			arg_debug=1
 			;;
 		--annotate)
-			annotate="$1"
+			arg_split_annotate="$1"
 			shift
 			;;
 		--no-annotate)
-			annotate=
+			arg_split_annotate=
 			;;
 		-b)
-			branch="$1"
+			arg_split_branch="$1"
 			shift
 			;;
 		-P)
-			prefix="${1%/}"
+			arg_prefix="${1%/}"
 			shift
 			;;
 		-m)
-			message="$1"
+			arg_addmerge_message="$1"
 			shift
 			;;
 		--no-prefix)
-			prefix=
+			arg_prefix=
 			;;
 		--onto)
-			onto="$1"
+			arg_split_onto="$1"
 			shift
 			;;
 		--no-onto)
-			onto=
+			arg_split_onto=
 			;;
 		--rejoin)
-			rejoin=1
+			arg_split_rejoin=1
 			;;
 		--no-rejoin)
-			rejoin=
+			arg_split_rejoin=
 			;;
 		--ignore-joins)
-			ignore_joins=1
+			arg_split_ignore_joins=1
 			;;
 		--no-ignore-joins)
-			ignore_joins=
+			arg_split_ignore_joins=
 			;;
 		--squash)
-			squash=1
+			arg_addmerge_squash=1
 			;;
 		--no-squash)
-			squash=
+			arg_addmerge_squash=
 			;;
 		--)
 			break
@@ -146,10 +146,10 @@ main () {
 		esac
 	done
 
-	command="$1"
+	arg_command="$1"
 	shift
 
-	case "$command" in
+	case "$arg_command" in
 	add|merge|pull)
 		default=
 		;;
@@ -157,31 +157,31 @@ main () {
 		default="--default HEAD"
 		;;
 	*)
-		die "Unknown command '$command'"
+		die "Unknown command '$arg_command'"
 		;;
 	esac
 
-	if test -z "$prefix"
+	if test -z "$arg_prefix"
 	then
 		die "You must provide the --prefix option."
 	fi
 
-	case "$command" in
+	case "$arg_command" in
 	add)
-		test -e "$prefix" &&
-			die "prefix '$prefix' already exists."
+		test -e "$arg_prefix" &&
+			die "prefix '$arg_prefix' already exists."
 		;;
 	*)
-		test -e "$prefix" ||
-			die "'$prefix' does not exist; use 'git subtree add'"
+		test -e "$arg_prefix" ||
+			die "'$arg_prefix' does not exist; use 'git subtree add'"
 		;;
 	esac
 
-	dir="$(dirname "$prefix/.")"
+	dir="$(dirname "$arg_prefix/.")"
 
-	if test "$command" != "pull" &&
-			test "$command" != "add" &&
-			test "$command" != "push"
+	if test "$arg_command" != "pull" &&
+			test "$arg_command" != "add" &&
+			test "$arg_command" != "push"
 	then
 		revs=$(git rev-parse $default --revs-only "$@") || exit $?
 		dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
@@ -192,14 +192,14 @@ main () {
 		fi
 	fi
 
-	debug "command: {$command}"
+	debug "command: {$arg_command}"
 	debug "quiet: {$GIT_QUIET}"
 	debug "revs: {$revs}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
 	debug
 
-	"cmd_$command" "$@"
+	"cmd_$arg_command" "$@"
 }
 
 cache_setup () {
@@ -333,7 +333,7 @@ find_existing_splits () {
 	main=
 	sub=
 	local grep_format="^git-subtree-dir: $dir/*\$"
-	if test -n "$ignore_joins"
+	if test -n "$arg_split_ignore_joins"
 	then
 		grep_format="^Add '$dir/' from commit '"
 	fi
@@ -394,7 +394,7 @@ copy_commit () {
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
 		(
-			printf "%s" "$annotate"
+			printf "%s" "$arg_split_annotate"
 			cat
 		) |
 		git commit-tree "$2" $3  # reads the rest of stdin
@@ -405,9 +405,9 @@ add_msg () {
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
-	if test -n "$message"
+	if test -n "$arg_addmerge_message"
 	then
-		commit_message="$message"
+		commit_message="$arg_addmerge_message"
 	else
 		commit_message="Add '$dir/' from commit '$latest_new'"
 	fi
@@ -421,9 +421,9 @@ add_msg () {
 }
 
 add_squashed_msg () {
-	if test -n "$message"
+	if test -n "$arg_addmerge_message"
 	then
-		echo "$message"
+		echo "$arg_addmerge_message"
 	else
 		echo "Merge commit '$1' as '$2'"
 	fi
@@ -433,9 +433,9 @@ rejoin_msg () {
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
-	if test -n "$message"
+	if test -n "$arg_addmerge_message"
 	then
-		commit_message="$message"
+		commit_message="$arg_addmerge_message"
 	else
 		commit_message="Split '$dir/' into commit '$latest_new'"
 	fi
@@ -722,7 +722,7 @@ cmd_add_commit () {
 		headp=
 	fi
 
-	if test -n "$squash"
+	if test -n "$arg_addmerge_squash"
 	then
 		rev=$(new_squash_commit "" "" "$rev") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
@@ -741,10 +741,10 @@ cmd_split () {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
 
-	if test -n "$onto"
+	if test -n "$arg_split_onto"
 	then
-		debug "Reading history for --onto=$onto..."
-		git rev-list $onto |
+		debug "Reading history for --onto=$arg_split_onto..."
+		git rev-list $arg_split_onto |
 		while read rev
 		do
 			# the 'onto' history is already just the subdir, so
@@ -776,7 +776,7 @@ cmd_split () {
 		die "No new revisions were found"
 	fi
 
-	if test -n "$rejoin"
+	if test -n "$arg_split_rejoin"
 	then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old) || exit $?
@@ -785,21 +785,21 @@ cmd_split () {
 			-m "$(rejoin_msg "$dir" "$latest_old" "$latest_new")" \
 			"$latest_new" >&2 || exit $?
 	fi
-	if test -n "$branch"
+	if test -n "$arg_split_branch"
 	then
-		if rev_exists "refs/heads/$branch"
+		if rev_exists "refs/heads/$arg_split_branch"
 		then
-			if ! git merge-base --is-ancestor "$branch" "$latest_new"
+			if ! git merge-base --is-ancestor "$arg_split_branch" "$latest_new"
 			then
-				die "Branch '$branch' is not an ancestor of commit '$latest_new'."
+				die "Branch '$arg_split_branch' is not an ancestor of commit '$latest_new'."
 			fi
 			action='Updated'
 		else
 			action='Created'
 		fi
 		git update-ref -m 'subtree split' \
-			"refs/heads/$branch" "$latest_new" || exit $?
-		say >&2 "$action branch '$branch'"
+			"refs/heads/$arg_split_branch" "$latest_new" || exit $?
+		say >&2 "$action branch '$arg_split_branch'"
 	fi
 	echo "$latest_new"
 	exit 0
@@ -810,7 +810,7 @@ cmd_merge () {
 	ensure_single_rev $rev
 	ensure_clean
 
-	if test -n "$squash"
+	if test -n "$arg_addmerge_squash"
 	then
 		first_split="$(find_latest_squash "$dir")" || exit $?
 		if test -z "$first_split"
@@ -830,12 +830,12 @@ cmd_merge () {
 		rev="$new"
 	fi
 
-	if test -n "$message"
+	if test -n "$arg_addmerge_message"
 	then
-		git merge -Xsubtree="$prefix" \
-		    --message="$message" "$rev"
+		git merge -Xsubtree="$arg_prefix" \
+			--message="$arg_addmerge_message" "$rev"
 	else
-		git merge -Xsubtree="$prefix" $rev
+		git merge -Xsubtree="$arg_prefix" $rev
 	fi
 }
 
@@ -863,7 +863,7 @@ cmd_push () {
 		repository=$1
 		refspec=$2
 		echo "git push using: " "$repository" "$refspec"
-		localrev=$(git subtree split --prefix="$prefix") || die
+		localrev=$(git subtree split --prefix="$arg_prefix") || die
 		git push "$repository" "$localrev":"refs/heads/$refspec"
 	else
 		die "'$dir' must already exist. Try 'git subtree add'."
-- 
2.31.1

