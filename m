From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/23] replace "checkout --to" with "worktree add"
Date: Mon,  6 Jul 2015 13:30:37 -0400
Message-ID: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAEy-0007ZW-4I
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbbGFRba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:30 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35442 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbGFRb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:29 -0400
Received: by iecuq6 with SMTP id uq6so118016304iec.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=nl6ChuQjpDA4yZUm1fDpdhDIqts6SUkApTqDQ8Z+yws=;
        b=ePfXeQTgpjQzSr01Ggjjpf45b4iesT7lkqKPofCJBpEnfd8TxXxTaiEai97DsdStNX
         u+4QEuK88gJgexoh66Bph1yKt5uaOEEHU8w1ChMCmi23epZkEJ8aJo9Kn4kMQozwHXc9
         5+D5B33L6uIX/OlgKa+rQXN//t1aSQglYD9AGssyYCkmQThyPktFwfWT7vrBzgdKxDL7
         I3wvoIEip7dUnMZdntjJdjeFGE053Up5rulFSqahpweB9G0JS/uPNRCwokSZzvPi7yH7
         +BNzJJIucxGR5y8O+SA61m89Ly/gvgi3iWTyQtcTKuiBQJSeTCFr4SJKy2HaoONZ4CNQ
         clBg==
X-Received: by 10.50.50.204 with SMTP id e12mr67109592igo.0.1436203888342;
        Mon, 06 Jul 2015 10:31:28 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273415>

This is v3 of the series to replace "git checkout --to" with "git
worktree add". It's built atop Duy's df0b6cf (worktree: new place for
"git prune --worktrees", 2015-06-29). Thanks to Duy for his review
of v2[*1*].

A v2 to v3 interdiff is included below for ease of review.

Changes since v2:

* retire --to from git-checkout documentation (v1 did this, but v2
  forgot)

* add "git worktree list" to the enumeration of not-yet-implemented
  commands in the BUGS section of the documentation

* state only that "git worktree add" will create <path> rather than
  mentioning that a pre-existing <path> is valid as long as it is an
  empty directory[*2*]

* fix comment stating that "any valid value" is acceptable as temporary
  HEAD in the newly created worktree, as patch 8/23 proves this to be
  false

* use test_cmp_rev to simplify a couple new tests

* minor grammatical fixes to documentation and a few commit messages

[*1*]: http://thread.gmane.org/gmane.comp.version-control.git/273316
[*2*]: http://article.gmane.org/gmane.comp.version-control.git/273358

Eric Sunshine (23):
  Documentation/git-checkout: fix incorrect worktree prune command
  Documentation/git-worktree: associate options with commands
  Documentation: move linked worktree description from checkout to
    worktree
  Documentation/git-worktree: add BUGS section
  Documentation/git-worktree: split technical info from general
    description
  Documentation/git-worktree: add high-level 'lock' overview
  Documentation/git-worktree: add EXAMPLES section
  checkout: fix bug with --to and relative HEAD
  checkout: relocate --to's "no branch specified" check
  checkout: prepare_linked_checkout: drop now-unused 'new' argument
  checkout: make --to unconditionally verbose
  checkout: drop 'checkout_opts' dependency from prepare_linked_checkout
  worktree: introduce "add" command
  worktree: add --force option
  worktree: add --detach option
  worktree: add -b/-B options
  tests: worktree: retrofit "checkout --to" tests for "worktree add"
  checkout: retire --to option
  checkout: require worktree unconditionally
  worktree: extract basename computation to new function
  worktree: add: make -b/-B default to HEAD when <branch> is omitted
  worktree: add: auto-vivify new branch when <branch> is omitted
  checkout: retire --ignore-other-worktrees in favor of --force

 Documentation/git-checkout.txt                    |  81 +--------
 Documentation/git-worktree.txt                    | 141 ++++++++++++++-
 builtin/checkout.c                                | 161 +-----------------
 builtin/worktree.c                                | 198 ++++++++++++++++++++++
 git.c                                             |   2 +-
 t/{t2025-checkout-to.sh => t2025-worktree-add.sh} |  64 ++++---
 t/t2026-prune-linked-checkouts.sh                 |   2 +-
 t/t7410-submodule-checkout-to.sh                  |   4 +-
 8 files changed, 382 insertions(+), 271 deletions(-)
 rename t/{t2025-checkout-to.sh => t2025-worktree-add.sh} (54%)

-- 
2.5.0.rc1.197.g417e668


--- 8< ---
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 41148ce..6c3085d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -228,13 +228,6 @@ This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
---to=<path>::
-	Check out a branch in a separate working directory at
-	`<path>`. A new working directory is linked to the current
-	repository, sharing everything except working directory
-	specific files such as HEAD, index, etc. See
-	linkgit:git-worktree[1] for a description of linked worktrees.
-
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 938bdab..da71f50 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -47,13 +47,12 @@ COMMANDS
 --------
 add <path> [<branch>]::
 
-Check out `<branch>` into a separate working directory, `<path>`, creating
-`<path>` if necessary. The new working directory is linked to the current
-repository, sharing everything except working directory specific files
-such as HEAD, index, etc. If `<path>` already exists, it must be empty.
+Create `<path>` and checkout `<branch>` into it. The new working directory
+is linked to the current repository, sharing everything except working
+directory specific files such as HEAD, index, etc.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` used, then, as a
-convenience, a new branch rooted at HEAD is created automatically, as if
+If `<branch>` is omitted and neither `-b` nor `-B` is used, then, as a
+convenience, a new branch based at HEAD is created automatically, as if
 `-b $(basename <path>)` was specified.
 
 prune::
@@ -137,10 +136,10 @@ linkgit:gitrepository-layout[5] for details.
 
 EXAMPLES
 --------
-You are middle of a refactoring session and your boss comes in and demands
-that you fix something immediately. You might typically use
+You are in the middle of a refactoring session and your boss comes in and
+demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
-worktree is in such a state of disarray (with new, removed, moved files,
+worktree is in such a state of disarray (with new, moved, and removed files,
 and other bits and pieces strewn around) that you don't want to risk
 disturbing any of it. Instead, you create a temporary linked worktree to
 make the emergency fix, remove it when done, and then resume your earlier
@@ -167,6 +166,7 @@ performed manually, such as:
 - `remove` to remove a linked worktree and its administrative files (and
   warn if the worktree is dirty)
 - `mv` to move or rename a worktree and update its administrative files
+- `list` to list linked worktrees
 - `lock` to prevent automatic pruning of administrative files (for instance,
   for a worktree on a portable device)
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8a6c7fa..050b443 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -227,9 +227,14 @@ static int add_worktree(const char *path, const char **child_argv)
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Any valid
-	 * value would do because this value will be ignored and
-	 * replaced at the next (real) checkout.
+	 * or is_git_directory() will reject the directory. Moreover, HEAD
+	 * in the new worktree must resolve to the same value as HEAD in
+	 * the current tree since the command invoked to populate the new
+	 * worktree will be handed the branch/ref specified by the user.
+	 * For instance, if the user asks for the new worktree to be based
+	 * at HEAD~5, then the resolved HEAD~5 in the new worktree must
+	 * match the resolved HEAD~5 in the current tree in order to match
+	 * the user's expectation.
 	 */
 	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
 		die(_("unable to resolve HEAD"));
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 59d73ff..8fe242f 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -141,17 +141,13 @@ test_expect_success '"add" from relative HEAD' '
 '
 
 test_expect_success '"add -b" with <branch> omitted' '
-	git rev-parse HEAD >expected &&
 	git worktree add -b burble flornk &&
-	git rev-parse burble >actual &&
-	test_cmp expected actual
+	test_cmp_rev HEAD burble
 '
 
 test_expect_success '"add" with <branch> omitted' '
-	git rev-parse HEAD >expected &&
 	git worktree add wiffle/bat &&
-	git rev-parse bat >actual &&
-	test_cmp expected actual
+	test_cmp_rev HEAD bat
 '
 
 test_done
--- 8< ---
