From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: rebase [-i --exec | -ix] <CMD>...
Date: Thu,  7 Jun 2012 18:46:22 +0200
Message-ID: <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <4FD0D375.9060902@web.de>
Cc: git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jun 07 18:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfrG-00038T-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980Ab2FGQq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 12:46:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58502 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757843Ab2FGQq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 12:46:26 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q57GbfYX002087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 18:37:41 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q57GkNIt027245;
	Thu, 7 Jun 2012 18:46:23 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q57GkMdS025082;
	Thu, 7 Jun 2012 18:46:22 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q57GkMaH025081;
	Thu, 7 Jun 2012 18:46:22 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <4FD0D375.9060902@web.de>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 18:37:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57GbfYX002087
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339691862.6397@EygAz4HegEO9S/Msxtm3bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199417>

The whitespaces before exec have been deleted. Does it
work now on MacOS ?

---
 Documentation/git-rebase.txt  |   54 +++++++++++++++--
 git-rebase--interactive.sh    |   18 ++++++
 git-rebase.sh                 |   20 ++++++-
 t/t3404-rebase-interactive.sh |  124 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 147fa1a..1dd95c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated upstream head
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
 	[<upstream>] [<branch>]
-'git rebase' [-i | --interactive] [options] --onto <newbase>
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <newbase>
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort
 
@@ -210,11 +210,29 @@ rebase.autosquash::
 
 OPTIONS
 -------
-<newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
-	existing branch name.
+-x <cmd>::
+--exec <cmd>::
+	Automatically add "exec" followed by <cmd> between each commit
+	applications. Using this option along with --autosquash adds
+	the exec line after the squash/fixeup series only. <cmd>
+	stands for shell commands. The --exec option has to be
+	specified. (see INTERACTIVE MODE below)
++
+This has to be used along with the `--interactive` option explicitly.
+You may execute several commands between each commit applications.
+For this, you can use one instance of exec:
+	git rebase -i --exec "cmd1; cmd2; ...".
+You can also insert several instances of exec, if you wish to
+only have one command per line for example:
+	git rebase -i --exec "cmd1" --exec "cmd2" ...
+
+--onto <newbase>::
+	With this option, git rebase takes all commits from <branch>,
+	that are not in <upstream>, and transplant them on top of
+	<newbase>. <newbase> is the starting point at which to create
+	the new commits. If the --onto option is not specified, the
+	starting point is <upstream>.  May be any valid commit, and
+	not just an existing branch name.
 +
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
@@ -521,6 +539,28 @@ in `$SHELL`, or the default shell if `$SHELL` is not set), so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
 
+----------------------------------
+$ git rebase -i --exec "make test"
+----------------------------------
+
+This command lets you check that intermediate commits are compilable.
+The todo list becomes like that:
+
+--------------------
+pick 5928aea one
+exec make test
+pick 04d0fda two
+exec make test
+pick ba46169 three
+exec make test
+pick f4593f9 four
+exec make test
+--------------------
+
+If the option '-i' is missing, The command will return a message
+error. If there is no <cmd> specified behind --exec, the command will
+return a message error and the usage page of 'git rebase'.
+
 SPLITTING COMMITS
 -----------------
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..dc9e7e9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,22 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+# Add commands after a pick or after a squash/fixup serie
+# in the todo list.
+add_exec_commands () {
+	OIFS=$IFS
+	IFS=$LF
+	for i in $cmd
+	do
+		tmp=$(sed "/^pick .*/i\exec $i" "$1")
+		echo "$tmp" >"$1"
+		tmp=$(sed '1d' "$1")
+		echo "$tmp" >"$1"
+		echo "exec $i" >>"$1"
+	done
+	IFS=$OIFS
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +873,8 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$cmd" && add_exec_commands "$todo"
+
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..19ead1a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase | -f]
+       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -30,8 +31,8 @@ Example:       git-rebase master~1 topic
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
+git rebase [-i] [options] [--exec <cmd>] --onto <newbase> --root [<branch>]
 git-rebase [-i] --continue | --abort | --skip
 --
  Available options are
@@ -43,6 +44,7 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
@@ -76,6 +78,7 @@ If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To check out the original branch and stop rebasing run \"git rebase --abort\".
 "
 unset onto
+cmd=
 strategy=
 strategy_opts=
 do_merge=
@@ -219,6 +222,11 @@ do
 		onto="$2"
 		shift
 		;;
+	-x)
+		test 2 -le "$#" || usage
+		cmd="${cmd:+"$cmd$LF"} $2"
+		shift
+		;;
 	-i)
 		interactive_rebase=explicit
 		;;
@@ -304,6 +312,12 @@ do
 done
 test $# -gt 2 && usage
 
+if test -n "$cmd" &&
+   test "$interactive_rebase" != explicit
+then
+	die "--exec option must be used with --interactive option\n"
+fi
+
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..4fe98d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,128 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'prepare for rebase -i --exec' '
+	git checkout master &&
+	git checkout -b execute &&
+	test_commit one_exec main.txt one_exec &&
+	test_commit two_exec main.txt two_exec &&
+	test_commit three_exec main.txt three_exec
+'
+
+
+test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase --exec git show HEAD -i"' '
+	git reset --hard execute &&
+	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several instances of --exec' '
+	git reset --hard execute &&
+	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
+				exec_git_show_HEAD exec_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,11d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with --autosquash' '
+	git reset --hard execute &&
+	git checkout -b autosquash &&
+	echo second >second.txt &&
+	git add second.txt &&
+	git commit -m "fixup! two_exec" &&
+	echo bis >bis.txt &&
+	git add bis.txt &&
+	git commit -m "fixup! two_exec" &&
+	(
+		git checkout -b autosquash_actual &&
+		git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
+	) &&
+	git checkout autosquash &&
+	(
+		git checkout -b autosquash_expected &&
+		FAKE_LINES="1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~4 >expected
+	) &&
+	sed '1,13d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase --exec without -i shows error message' '
+	git reset --hard execute &&
+	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
+	echo "--exec option must be used with --interactive option\n" >expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -i --exec without <CMD> shows error message and usage' '
+	git reset --hard execute &&
+	test_must_fail git rebase -i --exec 2>actual &&
+	sed '1d' actual >tmp &&
+	mv tmp actual &&
+	test_must_fail git rebase -h >expected &&
+	test_cmp expected actual &&
+	git checkout master
+'
+
 test_done
-- 
1.7.8
