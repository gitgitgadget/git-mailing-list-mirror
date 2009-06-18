From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 6/5] stash: teach quiet option
Date: Wed, 17 Jun 2009 18:07:37 -0700
Message-ID: <1245287257-18186-1-git-send-email-bebarino@gmail.com>
References: <1245191581-11127-6-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 03:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH66a-0001Iw-HF
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 03:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZFRBHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 21:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZFRBHl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 21:07:41 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:63244 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZFRBHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 21:07:40 -0400
Received: by pxi27 with SMTP id 27so714140pxi.33
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=OcifdRmge87ErIjkLwJS0zr9m+UOX+cRrEzr/F3ELlY=;
        b=KtX8MoZTV4w+28kQpCUj0v2J5DN2IvMB+JqnkmZAcLGkl0RrH24TlFSIKPzJG10Ksz
         9jmz6QbCCQ+v1MEBh6sDaiwpu2wHXsLhzC6ZI8HEsohc/k9vH8CKiMZg3tDapxwEak7I
         OUVrMvuHAtdtHFW3r1JPmG8b8NnF2NtvQGZiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i6VQj05GcNzFz8dYpHBxquI8yRblCwvBl97a6m6204gCXPuM5wedT6PEOgJGeDa4ok
         BoI6LsmIui0ZeC6IN6S+xff+pbcTg80ptlz39BlzeSbgq5UWIwjK3tMURFDIHxmCLxGM
         MMQ+T1urDK+e20cEFCJKs7vDTzm0er30wE+Yg=
Received: by 10.114.255.12 with SMTP id c12mr1174190wai.11.1245287263331;
        Wed, 17 Jun 2009 18:07:43 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id m6sm2338636wag.14.2009.06.17.18.07.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Jun 2009 18:07:42 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 17 Jun 2009 18:07:37 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-6-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121789>

Teach stash pop, apply, save, and drop to be quiet when told. By using
the quiet option (-q), these actions will be silent unless errors are
encountered.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-stash.txt |   15 ++++----
 git-stash.sh                |   78 +++++++++++++++++++++++++++++++++---------
 t/t3903-stash.sh            |   23 +++++++++++++
 3 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a42d4c8..1c64a02 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,10 +9,11 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' ( show | drop ) [<stash>]
-'git stash' ( pop | apply ) [--index] [<stash>]
+'git stash' show [<stash>]
+'git stash' drop [-q|--quiet] [<stash>]
+'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--keep-index] [<message>]]
+'git stash' [save [--keep-index] [-q|--quiet] [<message>]]
 'git stash' clear
 'git stash' create
 
@@ -41,7 +42,7 @@ is also possible).
 OPTIONS
 -------
 
-save [--keep-index] [<message>]::
+save [--keep-index] [-q|--quiet] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  This is the default action when no
@@ -75,7 +76,7 @@ show [<stash>]::
 	it will accept any format known to 'git-diff' (e.g., `git stash show
 	-p stash@\{1}` to view the second most recent stash in patch form).
 
-pop [<stash>]::
+pop [--index] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
@@ -93,7 +94,7 @@ longer apply the changes as they were originally).
 +
 When no `<stash>` is given, `stash@\{0}` is assumed.
 
-apply [--index] [<stash>]::
+apply [--index] [-q|--quiet] [<stash>]::
 
 	Like `pop`, but do not remove the state from the stash list.
 
@@ -115,7 +116,7 @@ clear::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be difficult or impossible to recover.
 
-drop [<stash>]::
+drop [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list. When no `<stash>`
 	is given, it removes the latest one. i.e. `stash@\{0}`
diff --git a/git-stash.sh b/git-stash.sh
index e6a5867..531c7c3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -3,10 +3,11 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="list [<options>]
-   or: $dashless ( show | drop ) [<stash>]
-   or: $dashless ( pop | apply ) [--index] [<stash>]
+   or: $dashless show [<stash>]
+   or: $dashless drop [-q|--quiet] [<stash>]
+   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--keep-index] [<message>]]
+   or: $dashless [save [--keep-index] [-q|--quiet] [<message>]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -94,18 +95,28 @@ create_stash () {
 
 save_stash () {
 	keep_index=
-	case "$1" in
-	--keep-index)
-		keep_index=t
+	while test $# != 0
+	do
+		case "$1" in
+		--keep-index)
+			keep_index=t
+			;;
+		-q|--quiet)
+			GIT_QUIET=t
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-	esac
+	done
 
 	stash_msg="$*"
 
 	git update-index -q --refresh
 	if no_changes
 	then
-		echo 'No local changes to save'
+		say 'No local changes to save'
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -118,9 +129,9 @@ save_stash () {
 
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf 'Saved working directory and index state "%s"\n' "$stash_msg"
+	say Saved working directory and index state "$stash_msg"
 
-	git reset --hard
+	git reset --hard ${GIT_QUIET:+-q}
 
 	if test -n "$keep_index" && test -n $i_tree
 	then
@@ -156,11 +167,22 @@ apply_stash () {
 		die 'Cannot apply to a dirty working tree, please stage your changes'
 
 	unstash_index=
-	case "$1" in
-	--index)
-		unstash_index=t
+
+	while test $# != 0
+	do
+		case "$1" in
+		--index)
+			unstash_index=t
+			;;
+		-q|--quiet)
+			GIT_QUIET=t
+			;;
+		*)
+			break
+			;;
+		esac
 		shift
-	esac
+	done
 
 	# current index state
 	c_tree=$(git write-tree) ||
@@ -193,6 +215,10 @@ apply_stash () {
 		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
 	"
 
+	if test -n "$GIT_QUIET"
+	then
+		export GIT_MERGE_VERBOSITY=0
+	fi
 	if git-merge-recursive $b_tree -- $c_tree $w_tree
 	then
 		# No conflict
@@ -207,7 +233,12 @@ apply_stash () {
 				die "Cannot unstage modified files"
 			rm -f "$a"
 		fi
-		git status || :
+		squelch=
+		if test -n "$GIT_QUIET"
+		then
+			squelch='>/dev/null 2>&1'
+		fi
+		eval "git status $squelch" || :
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
@@ -222,6 +253,19 @@ apply_stash () {
 drop_stash () {
 	have_stash || die 'No stash entries to drop'
 
+	while test $# != 0
+	do
+		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=t
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
 	if test $# = 0
 	then
 		set x "$ref_stash@{0}"
@@ -235,7 +279,7 @@ drop_stash () {
 		die "$*: not a valid stashed state"
 
 	git reflog delete --updateref --rewrite "$@" &&
-		echo "Dropped $* ($s)" || die "$*: Could not drop stash entry"
+		say "Dropped $* ($s)" || die "$*: Could not drop stash entry"
 
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
@@ -312,7 +356,7 @@ branch)
 	if test $# -eq 0
 	then
 		save_stash &&
-		echo '(To restore them type "git stash apply")'
+		say '(To restore them type "git stash apply")'
 	else
 		usage
 	fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7484cbe..7a3fb67 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -177,4 +177,27 @@ test_expect_success 'stash branch' '
 	test 0 = $(git stash list | wc -l)
 '
 
+test_expect_success 'apply -q is quiet' '
+	echo foo > file &&
+	git stash &&
+	git stash apply -q > output.out 2>&1 &&
+	test ! -s output.out
+'
+
+test_expect_success 'save -q is quiet' '
+	git stash save --quiet > output.out 2>&1 &&
+	test ! -s output.out
+'
+
+test_expect_success 'pop -q is quiet' '
+	git stash pop -q > output.out 2>&1 &&
+	test ! -s output.out
+'
+
+test_expect_success 'drop -q is quiet' '
+	git stash &&
+	git stash drop -q > output.out 2>&1 &&
+	test ! -s output.out
+'
+
 test_done
-- 
1.6.3.2.306.g4f4fa
