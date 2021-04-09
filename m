Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6672BC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3570D61168
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhDIEGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhDIEF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95839C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s7so4080565wru.6
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3PlT+z7/8luHDMWQF6XKws730eXPYaB+8e/ORmdUD4=;
        b=nO6onwErgF12dut+e93gl/akuiJEUopXdKw1q4z+VqTs2FSsrwHuUfJJBRJEaqIodi
         Ee/X0ZfutlJvNWyXawjO1tCOfNyG2YQVaIDI6TzrvA+wuboQtnGOVyjC/vS145VbFyqE
         EVl/2xgvy+YQQxxbldoFDckvO8H/YbrDV9XTU0vNM+y6LemRJxLVRNqu4RtIwMK1TgUP
         Ybddz77XFNNfbG+vU9GO+hsT38OG30JNrI2c32c9e/BkV92Nahn18TanKSlv7rxn77eo
         o9XX4J7LjCBC8XY296M3UogVsCCd/bI6TRzoDxhCCxdtPHuMioePVy7g7pRHO534RyGz
         uLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3PlT+z7/8luHDMWQF6XKws730eXPYaB+8e/ORmdUD4=;
        b=SfIV+7pdzVJ5Vlb35ydjemOTZR2yhoLvW7pWiio7G6375q2x2NhuYkOV2mmkBKgNMQ
         WlyLcjVfhhW9HPAFzqrC7NrcgO9cHJjGNjtq8svJ/jzfYpp+BndYT4A4yEbR9O1wDWaa
         A2vUgp4NcKhEL3utsGUCO1JYNLH2j4LQcMfYUNU9u3pU5HM5lL7tu/+ICo2BNfCbHHKG
         SOV/OMxJbB71QUzCgUaPEjdtq06I8RJHHtjeZp64qTcYh8U/0ZRCfSFPARmAXE9gNhor
         +VYqdZFZTDyyBFd3Y1vFdgAOX0244C2jspEe2ZSjvHJddg2PZuKdrMAKvVY4jgUCRGze
         bJ0A==
X-Gm-Message-State: AOAM531MSPw4jqKJx9ytsR81zDOmc6nZZnUM8rdfagFtcFNOxwob9+fC
        LHs+E1gOyi5b9bLZ7zRYB75/G1/hh1buWw==
X-Google-Smtp-Source: ABdhPJwMr3bD/fW33IZCL4mPhaTe+QSG0IqQTXHKyp61nttSjwli5WXD/fphDAD2CG+JxFXzpeGWVg==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr15735552wrs.71.1617941139557;
        Thu, 08 Apr 2021 21:05:39 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:38 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 02/13] doc: typeset branches and remotes in monospace
Date:   Fri,  9 Apr 2021 06:02:50 +0200
Message-Id: <20210409040301.3260358-3-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap branch and remote names with backticks as indicated in the
CodingGuidelines.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/diff-options.txt         |  2 +-
 Documentation/git-add.txt              | 10 +--
 Documentation/git-am.txt               |  4 +-
 Documentation/git-archimport.txt       |  2 +-
 Documentation/git-bisect-lk2009.txt    | 10 +--
 Documentation/git-bisect.txt           |  6 +-
 Documentation/git-branch.txt           | 22 +++---
 Documentation/git-bundle.txt           |  6 +-
 Documentation/git-check-ref-format.txt |  2 +-
 Documentation/git-checkout.txt         |  2 +-
 Documentation/git-cherry-pick.txt      | 22 +++---
 Documentation/git-cherry.txt           |  4 +-
 Documentation/git-clone.txt            | 16 ++---
 Documentation/git-commit-tree.txt      |  2 +-
 Documentation/git-commit.txt           |  6 +-
 Documentation/git-config.txt           |  2 +-
 Documentation/git-cvsimport.txt        |  8 +--
 Documentation/git-cvsserver.txt        |  2 +-
 Documentation/git-describe.txt         |  6 +-
 Documentation/git-diff-index.txt       |  6 +-
 Documentation/git-diff.txt             | 20 +++---
 Documentation/git-fast-export.txt      | 16 ++---
 Documentation/git-fetch-pack.txt       |  2 +-
 Documentation/git-fetch.txt            |  4 +-
 Documentation/git-filter-branch.txt    |  2 +-
 Documentation/git-fmt-merge-msg.txt    |  4 +-
 Documentation/git-for-each-ref.txt     | 12 ++--
 Documentation/git-format-patch.txt     |  4 +-
 Documentation/git-http-push.txt        |  6 +-
 Documentation/git-log.txt              |  8 +--
 Documentation/git-ls-remote.txt        |  2 +-
 Documentation/git-merge.txt            |  2 +-
 Documentation/git-notes.txt            | 12 ++--
 Documentation/git-p4.txt               |  4 +-
 Documentation/git-pull.txt             |  4 +-
 Documentation/git-push.txt             |  8 +--
 Documentation/git-read-tree.txt        |  4 +-
 Documentation/git-rebase.txt           | 92 +++++++++++++-------------
 Documentation/git-reflog.txt           |  4 +-
 Documentation/git-request-pull.txt     |  2 +-
 Documentation/git-rerere.txt           | 34 +++++-----
 Documentation/git-reset.txt            |  6 +-
 Documentation/git-rev-parse.txt        |  4 +-
 Documentation/git-revert.txt           |  8 +--
 Documentation/git-rm.txt               |  2 +-
 Documentation/git-show-ref.txt         |  2 +-
 Documentation/git-show.txt             |  2 +-
 Documentation/git-stash.txt            |  8 +--
 Documentation/git-status.txt           | 12 ++--
 Documentation/git-submodule.txt        | 28 ++++----
 Documentation/git-svn.txt              | 20 +++---
 Documentation/git-switch.txt           | 10 +--
 Documentation/git-symbolic-ref.txt     |  2 +-
 Documentation/git-tag.txt              |  2 +-
 Documentation/git-update-ref.txt       |  4 +-
 Documentation/git-worktree.txt         |  2 +-
 Documentation/git.txt                  |  4 +-
 Documentation/gitcli.txt               |  2 +-
 Documentation/gitcore-tutorial.txt     | 36 +++++-----
 Documentation/giteveryday.txt          | 16 ++---
 Documentation/githooks.txt             |  8 +--
 Documentation/gitk.txt                 |  2 +-
 Documentation/gitnamespaces.txt        |  2 +-
 Documentation/gitremote-helpers.txt    |  6 +-
 Documentation/gitrepository-layout.txt |  4 +-
 Documentation/gittutorial-2.txt        |  2 +-
 Documentation/gittutorial.txt          | 44 ++++++------
 Documentation/gitweb.txt               |  4 +-
 Documentation/gitworkflows.txt         | 70 ++++++++++----------
 Documentation/glossary-content.txt     | 12 ++--
 Documentation/rev-list-options.txt     |  2 +-
 Documentation/revisions.txt            | 52 +++++++--------
 Documentation/user-manual.txt          | 78 +++++++++++-----------
 73 files changed, 421 insertions(+), 421 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13e0753862..e4ac746428 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -803,7 +803,7 @@ endif::git-format-patch[]
 	Ignore changes to submodules in the diff generation. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default.
 	Using "none" will consider the submodule modified when it either contains
-	untracked or modified files or its HEAD differs from the commit recorded
+	untracked or modified files or its `HEAD` differs from the commit recorded
 	in the superproject and can be used to override any settings of the
 	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	"untracked" is used submodules are not considered dirty when they only
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 6a7cb07a8a..8ec99c5c12 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -256,7 +256,7 @@ The main command loop has 6 subcommands (plus help and quit).
 
 status::
 
-   This shows the change between HEAD and index (i.e. what will be
+   This shows the change between `HEAD` and index (i.e. what will be
    committed if you say `git commit`), and between index and
    working tree files (i.e. what you could stage further before
    `git commit` using `git add`) for each path.  A sample output
@@ -268,7 +268,7 @@ status::
      2:     +403/-35        +1/-1 git-add--interactive.perl
 ------------
 +
-It shows that foo.png has differences from HEAD (but that is
+It shows that foo.png has differences from `HEAD` (but that is
 binary so line count cannot be shown) and there is no
 difference between indexed copy and the working tree
 version (if the working tree version were also different,
@@ -311,7 +311,7 @@ revert::
 
   This has a very similar UI to 'update', and the staged
   information for selected paths are reverted to that of the
-  HEAD version.  Reverting new paths makes them untracked.
+  `HEAD` version.  Reverting new paths makes them untracked.
 
 add untracked::
 
@@ -350,7 +350,7 @@ variable `interactive.singleKey` to `true`.
 diff::
 
   This lets you review what will be committed (i.e. between
-  HEAD and index).
+  `HEAD` and index).
 
 
 EDITING PATCHES
@@ -389,7 +389,7 @@ There are also more complex operations that can be performed. But beware
 that because the patch is applied only to the index and not the working
 tree, the working tree will appear to "undo" the change in the index.
 For example, introducing a new line into the index that is in neither
-the HEAD nor the working tree will stage the new line for commit, but
+the `HEAD` nor the working tree will stage the new line for commit, but
 the line will appear to be reverted in the working tree.
 
 Avoid using these constructs, or do so with extreme caution.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index decd8ae122..cd56054be0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -176,7 +176,7 @@ default.   You can use `--no-utf8` to override this.
 	Restore the original branch and abort the patching operation.
 
 --quit::
-	Abort the patching operation but keep HEAD and the index
+	Abort the patching operation but keep `HEAD` and the index
 	untouched.
 
 --show-current-patch[=(diff|raw)]::
@@ -229,7 +229,7 @@ operation is finished, so if you decide to start over from scratch,
 run `git am --abort` before running the command with mailbox
 names.
 
-Before any patches are applied, ORIG_HEAD is set to the tip of the
+Before any patches are applied, `ORIG_HEAD` is set to the tip of the
 current branch.  This is useful if you have problems with multiple
 commits, like running 'git am' on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index b477e3c495..6e2dec5ef1 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -45,7 +45,7 @@ archives that it imports, it is also possible to specify Git branch names
 manually.  To do so, write a Git branch name after each <archive/branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
 branch names and convert Arch jargon to Git jargon, for example mapping a
-"PROJECT{litdd}devo{litdd}VERSION" branch to "master".
+"PROJECT{litdd}devo{litdd}VERSION" branch to `master`.
 
 Associating multiple Arch branches to one Git branch is possible; the
 result will make the most sense only if no commits are made to the first
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index f3d9566c89..1276424d65 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -767,8 +767,8 @@ They cannot be on a branch that has no link with the branch of the
 bad commit and yet not be neither one of its ancestor nor one of its
 descendants.
 
-For example, there can be a "main" branch, and a "dev" branch that was
-forked of the main branch at a commit named "D" like this:
+For example, there can be a `main` branch, and a `dev` branch that was
+forked of the `main` branch at a commit named "D" like this:
 
 -------------
 A-B-C-D-E-F-G  <--main
@@ -776,7 +776,7 @@ A-B-C-D-E-F-G  <--main
         H-I-J  <--dev
 -------------
 
-The commit "D" is called a "merge base" for branch "main" and "dev"
+The commit "D" is called a "merge base" for branch `main` and `dev`
 because it's the best common ancestor for these branches for a merge.
 
 Now let's suppose that commit J is bad and commit G is good and that
@@ -794,7 +794,7 @@ H-I-J
 -------------
 
 But what happens if the first bad commit is "B" and if it has been
-fixed in the "main" branch by commit "F"?
+fixed in the `main` branch by commit "F"?
 
 The result of such a bisection would be that we would find that H is
 the first bad commit, when in fact it's B. So that would be wrong!
@@ -1229,7 +1229,7 @@ message or the author. And it can also be used instead of git "grafts"
 to link a repository with another old repository.
 
 In fact it's this last feature that "sold" it to the Git community, so
-it is now in the "master" branch of Git's Git repository and it should
+it is now in the `master` branch of Git's Git repository and it should
 be released in Git 1.6.5 in October or November 2009.
 
 One problem with "git replace" is that currently it stores all the
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index fbb39fbdf5..ff50c66e29 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -98,7 +98,7 @@ Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD, issue the following command:
+the original `HEAD`, issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -379,7 +379,7 @@ branch contained broken or non-buildable commits, but the merge itself was OK.
 EXAMPLES
 --------
 
-* Automatically bisect a broken build between v1.2 and HEAD:
+* Automatically bisect a broken build between v1.2 and `HEAD`:
 +
 ------------
 $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
@@ -387,7 +387,7 @@ $ git bisect run make                # "make" builds the app
 $ git bisect reset                   # quit the bisect session
 ------------
 
-* Automatically bisect a test failure between origin and HEAD:
+* Automatically bisect a test failure between `origin` and `HEAD`:
 +
 ------------
 $ git bisect start HEAD origin --    # HEAD is bad, origin is good
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 271b4ee34e..fa38fa4dc1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -175,7 +175,7 @@ This option is only applicable in non-verbose mode.
 	the pattern(s).
 
 --show-current::
-	Print the name of the current branch. In detached HEAD state,
+	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
 -v::
@@ -186,7 +186,7 @@ This option is only applicable in non-verbose mode.
 	relationship to upstream branch (if any). If given twice, print
 	the path of the linked worktree (if any) and the name of the upstream
 	branch, as well (see also `git remote show <remote>`).  Note that the
-	current worktree's HEAD will not have its path printed (it will always
+	current worktree's `HEAD` will not have its path printed (it will always
 	be your current directory).
 
 -q::
@@ -250,15 +250,15 @@ start-point is either a local or remote-tracking branch.
 
 --no-contains [<commit>]::
 	Only list branches which don't contain the specified commit
-	(HEAD if not specified). Implies `--list`.
+	(`HEAD` if not specified). Implies `--list`.
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+	specified commit (`HEAD` if not specified). Implies `--list`.
 
 --no-merged [<commit>]::
 	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+	specified commit (`HEAD` if not specified). Implies `--list`.
 
 <branchname>::
 	The name of the branch to create or delete.
@@ -269,7 +269,7 @@ start-point is either a local or remote-tracking branch.
 <start-point>::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
-	option is omitted, the current HEAD will be used instead.
+	option is omitted, the current `HEAD` will be used instead.
 
 <oldbranch>::
 	The name of an existing branch to rename.
@@ -286,7 +286,7 @@ start-point is either a local or remote-tracking branch.
 	for-each-ref`. Sort order defaults to the value configured for the
 	`branch.sort` variable if exists, or to sorting based on the
 	full refname (including `refs/...` prefix). This lists
-	detached HEAD (if present) first, then local branches and
+	detached `HEAD` (if present) first, then local branches and
 	finally remote-tracking branches. See linkgit:git-config[1].
 
 
@@ -328,10 +328,10 @@ $ git branch -d -r origin/todo origin/html origin/man   <1>
 $ git branch -D test                                    <2>
 ------------
 +
-<1> Delete the remote-tracking branches "todo", "html" and "man". The next
+<1> Delete the remote-tracking branches `todo`, `html` and `man`. The next
     'fetch' or 'pull' will create them again unless you configure them not to.
     See linkgit:git-fetch[1].
-<2> Delete the "test" branch even if the "master" branch (or whichever branch
+<2> Delete the `test` branch even if the `master` branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
 
 Listing branches from a specific remote::
@@ -365,10 +365,10 @@ serve four related but different purposes:
   contain the specified <commit>.
 
 - `--merged` is used to find all branches which can be safely deleted,
-  since those branches are fully contained by HEAD.
+  since those branches are fully contained by `HEAD`.
 
 - `--no-merged` is used to find branches which are candidates for merging
-  into HEAD, since those branches are not fully contained by HEAD.
+  into `HEAD`, since those branches are not fully contained by `HEAD`.
 
 include::ref-reachability-filters.txt[]
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 4f1e59a3b2..20da47cbd6 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -68,7 +68,7 @@ unbundle <file>::
 	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
 	below), that specifies the specific objects and references
 	to transport.  For example, `master~10..master` causes the
-	current master reference to be packaged along with all objects
+	current `master` reference to be packaged along with all objects
 	added since its 10th ancestor commit.  There is no explicit
 	limit to the number of references and objects that may be
 	packaged.
@@ -146,7 +146,7 @@ Assume you want to transfer the history from a repository R1 on machine A
 to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc.).
-We want to update R2 with development made on the branch master in R1.
+We want to update R2 with development made on the branch `master` in R1.
 
 To bootstrap the process, you can first create a bundle that does not have
 any basis. You can use a tag to remember up to what commit you last
@@ -167,7 +167,7 @@ create a new repository on machine B by cloning from it:
 machineB$ git clone -b master /home/me/tmp/file.bundle R2
 ----------------
 
-This will define a remote called "origin" in the resulting repository that
+This will define a remote called `origin` in the resulting repository that
 lets you fetch and pull from the bundle. The $GIT_DIR/config file in R2 will
 have an entry like this:
 
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ee6a4144fb..f39622c0da 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -80,7 +80,7 @@ reference name expressions (see linkgit:gitrevisions[7]):
 With the `--branch` option, the command takes a name and checks if
 it can be used as a valid branch name (e.g. when creating a new
 branch). But be cautious when using the
-previous checkout syntax that may refer to a detached HEAD state.
+previous checkout syntax that may refer to a detached `HEAD` state.
 The rule `git check-ref-format --branch $name` implements
 may be stricter than what `git check-ref-format refs/heads/$name`
 says (e.g. a dash may appear at the beginning of a ref component,
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 3336b8dace..192dbfe9b0 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -189,7 +189,7 @@ one for the purposes of disambiguation, even if the `<branch>` isn't
 unique across all remotes. Set it to
 e.g. `checkout.defaultRemote=origin` to always checkout remote
 branches from there if `<branch>` is ambiguous but exists on the
-'origin' remote. See also `checkout.defaultRemote` in
+`origin` remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
 `--guess` is the default behavior. Use `--no-guess` to disable it.
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 0127f56204..6069cc77a0 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -17,7 +17,7 @@ DESCRIPTION
 
 Given one or more existing commits, apply the change each one
 introduces, recording a new commit for each.  This requires your
-working tree to be clean (no modifications from the HEAD commit).
+working tree to be clean (no modifications from the `HEAD` commit).
 
 When it is not obvious how to apply a change, the following
 happens:
@@ -96,7 +96,7 @@ OPTIONS
 	each named commit to your working tree and the index,
 	without making any commit.  In addition, when this
 	option is used, your index does not have to match the
-	HEAD commit.  The cherry-pick is done against the
+	`HEAD` commit.  The cherry-pick is done against the
 	beginning state of your index.
 +
 This is useful when cherry-picking more than one commits'
@@ -117,7 +117,7 @@ effect to your index in a row.
 	earlier `--gpg-sign`.
 
 --ff::
-	If the current HEAD is the same as the parent of the
+	If the current `HEAD` is the same as the parent of the
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
@@ -176,13 +176,13 @@ EXAMPLES
 `git cherry-pick ^HEAD master`::
 
 	Apply the changes introduced by all commits that are ancestors
-	of master but not of HEAD to produce new commits.
+	of `master` but not of `HEAD` to produce new commits.
 
 `git cherry-pick maint next ^master`::
 `git cherry-pick maint master..next`::
 
 	Apply the changes introduced by all commits that are
-	ancestors of maint or next, but not master or any of its
+	ancestors of `maint` or `next`, but not `master` or any of its
 	ancestors.  Note that the latter does not mean `maint` and
 	everything between `master` and `next`; specifically,
 	`maint` will not be used if it is included in `master`.
@@ -190,27 +190,27 @@ EXAMPLES
 `git cherry-pick master~4 master~2`::
 
 	Apply the changes introduced by the fifth and third last
-	commits pointed to by master and create 2 new commits with
+	commits pointed to by `master` and create 2 new commits with
 	these changes.
 
 `git cherry-pick -n master~1 next`::
 
 	Apply to the working tree and the index the changes introduced
-	by the second last commit pointed to by master and by the last
+	by the second last commit pointed to by `master` and by the last
 	commit pointed to by next, but do not create any commit with
 	these changes.
 
 `git cherry-pick --ff ..next`::
 
-	If history is linear and HEAD is an ancestor of next, update
-	the working tree and advance the HEAD pointer to match next.
+	If history is linear and `HEAD` is an ancestor of next, update
+	the working tree and advance the `HEAD` pointer to match next.
 	Otherwise, apply the changes introduced by those commits that
-	are in next but not HEAD to the current branch, creating a new
+	are in next but not `HEAD` to the current branch, creating a new
 	commit for each new change.
 
 `git rev-list --reverse master -- README | git cherry-pick -n --stdin`::
 
-	Apply the changes introduced by all commits on the master
+	Apply the changes introduced by all commits on the `master`
 	branch that touched README to the working tree and index,
 	so the result can be inspected and made into a single new
 	commit if suitable.
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 0ea921a593..4374f398fa 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -31,10 +31,10 @@ OPTIONS
 
 <upstream>::
 	Upstream branch to search for equivalent commits.
-	Defaults to the upstream branch of HEAD.
+	Defaults to the upstream branch of `HEAD`.
 
 <head>::
-	Working branch; defaults to HEAD.
+	Working branch; defaults to `HEAD`.
 
 <limit>::
 	Do not report commits up to (and including) limit.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 22334771d1..8cd602a852 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -30,8 +30,8 @@ currently active branch.
 
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
-arguments will in addition merge the remote master branch into the
-current master branch, if any (this is untrue when `--single-branch`
+arguments will in addition merge the remote `master` branch into the
+current `master` branch, if any (this is untrue when `--single-branch`
 is given; see below).
 
 This default configuration is achieved by creating references to
@@ -147,7 +147,7 @@ objects from the source repository into a pack in the cloned repository.
 
 -n::
 --no-checkout::
-	No checkout of HEAD is performed after the clone is complete.
+	No checkout of `HEAD` is performed after the clone is complete.
 
 --[no-]reject-shallow::
 	Fail if the source repository is a shallow repository.
@@ -198,11 +198,11 @@ objects from the source repository into a pack in the cloned repository.
 
 -b <name>::
 --branch <name>::
-	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repository's HEAD, point to `<name>` branch
+	Instead of pointing the newly created `HEAD` to the branch pointed
+	to by the cloned repository's `HEAD`, point to `<name>` branch
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
-	`--branch` can also take tags and detaches the HEAD at that commit
+	`--branch` can also take tags and detaches the `HEAD` at that commit
 	in the resulting repository.
 
 -u <upload-pack>::
@@ -224,7 +224,7 @@ objects from the source repository into a pack in the cloned repository.
 	linkgit:git-config[1] (e.g., `core.eol=true`). If multiple
 	values are given for the same key, each value will be written to
 	the config file. This makes it safe, for example, to add
-	additional fetch refspecs to the origin remote.
+	additional fetch refspecs to the `origin` remote.
 +
 Due to limitations of the current implementation, some configuration
 variables do not take effect until after the initial fetch and checkout.
@@ -253,7 +253,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch remote's `HEAD` points at.
 	Further fetches into the resulting repository will only update the
 	remote-tracking branch for the branch this option was used for the
-	initial cloning.  If the HEAD at the remote did not point at any
+	initial cloning.  If the `HEAD` at the remote did not point at any
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 2e2c581098..b76a825c94 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -36,7 +36,7 @@ While a tree represents a particular directory state of a working
 directory, a commit represents that state in "time", and explains how
 to get there.
 
-Normally a commit would identify a new "HEAD" state, and while Git
+Normally a commit would identify a new `HEAD` state, and while Git
 doesn't care where you save the note about that state, in practice we
 tend to just write the result to the file that is pointed at by
 `.git/HEAD`, so that we can always see what the last committed
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6d0d663b50..f507ae00a1 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -21,9 +21,9 @@ DESCRIPTION
 -----------
 Create a new commit containing the current contents of the index and
 the given log message describing the changes. The new commit is a
-direct child of HEAD, usually the tip of the current branch, and the
+direct child of `HEAD`, usually the tip of the current branch, and the
 branch is updated to point to it (unless no branch is associated with
-the working tree, in which case HEAD is "detached" as described in
+the working tree, in which case `HEAD` is "detached" as described in
 linkgit:git-checkout[1]).
 
 The content to be committed can be specified in several ways:
@@ -352,7 +352,7 @@ configuration variable documented in linkgit:git-config[1].
 
 -v::
 --verbose::
-	Show unified diff between the HEAD commit and what
+	Show unified diff between the `HEAD` commit and what
 	would be committed at the bottom of the commit message
 	template to help the user describe the commit by reminding
 	what changes the commit has.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b93394ea45..e6d70ffda1 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -148,7 +148,7 @@ See also <<FILES>>.
 --blob blob::
 	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
-	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
+	'.gitmodules' in the `master` branch. See "SPECIFYING REVISIONS"
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
 
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 143c726511..95fa94de74 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -35,7 +35,7 @@ Please see the section <<issues,ISSUES>> for further reference.
 
 You should *never* do any work of your own on the branches that are
 created by 'git cvsimport'.  By default initial import will create and populate a
-"master" branch from the CVS repository's main branch which you're free
+`master` branch from the CVS repository's main branch which you're free
 to work with; after that, you need to 'git merge' incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
 `-r` to separate and protect the incoming branches.
@@ -71,11 +71,11 @@ OPTIONS
 -r <remote>::
 	The Git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
-	akin to the way 'git clone' uses 'origin' by default.
+	akin to the way 'git clone' uses `origin` by default.
 
 -o <branch-for-HEAD>::
 	When no remote is specified (via `-r`) the `HEAD` branch
-	from CVS is imported to the 'origin' branch within the Git
+	from CVS is imported to the `origin` branch within the Git
 	repository, as `HEAD` already has a special meaning for Git.
 	When a remote is specified the `HEAD` branch is named
 	remotes/<remote>/master mirroring 'git clone' behaviour.
@@ -200,7 +200,7 @@ Problems related to timestamps:
    to be used for ordering commits changes may show up in the wrong
    order.
  * If any files were ever "cvs import"ed more than once (e.g., import of
-   more than one vendor release) the HEAD contains the wrong content.
+   more than one vendor release) the `HEAD` contains the wrong content.
  * If the timestamp order of different files cross the revision order
    within the commit matching time window the order of commits may be
    wrong.
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 955bae46c9..c6a926d8d2 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -199,7 +199,7 @@ allowing access over SSH.
 5. Clients should now be able to check out the project. Use the CVS 'module'
    name to indicate what Git 'head' you want to check out.  This also sets the
    name of your newly checked-out directory, unless you tell it otherwise with
-   `-d <dir_name>`.  For example, this checks out 'master' branch to the
+   `-d <dir_name>`.  For example, this checks out `master` branch to the
    `project-master` directory:
 +
 ------
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a3f015743b..7d2649c477 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -30,17 +30,17 @@ If the given object refers to a blob, it will be described
 as `<commit-ish>:<path>`, such that the blob can be found
 at `<path>` in the `<commit-ish>`, which itself describes the
 first commit in which this blob occurs in a reverse revision walk
-from HEAD.
+from `HEAD`.
 
 OPTIONS
 -------
 <commit-ish>...::
-	Commit-ish object names to describe.  Defaults to HEAD if omitted.
+	Commit-ish object names to describe.  Defaults to `HEAD` if omitted.
 
 --dirty[=<mark>]::
 --broken[=<mark>]::
 	Describe the state of the working tree.  When the working
-	tree matches HEAD, the output is the same as "git describe
+	tree matches `HEAD`, the output is the same as "git describe
 	HEAD".  If the working tree has local modification "-dirty"
 	is appended to it.  If a repository is corrupt and Git
 	cannot determine if there is local modification, Git will
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 27acb31cbf..10e79a29aa 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -31,7 +31,7 @@ include::diff-options.txt[]
 
 --merge-base::
 	Instead of comparing <tree-ish> directly, use the merge base
-	between <tree-ish> and HEAD instead.  <tree-ish> must be a
+	between <tree-ish> and `HEAD` instead.  <tree-ish> must be a
 	commit.
 
 -m::
@@ -53,7 +53,7 @@ CACHED MODE
 -----------
 If `--cached` is specified, it allows you to ask:
 
-	show me the differences between HEAD and the current index
+	show me the differences between `HEAD` and the current index
 	contents (the ones I'd write using 'git write-tree')
 
 For example, let's say that you have worked on your working directory, updated
@@ -89,7 +89,7 @@ the more useful of the two in that what it does can't be emulated with
 a 'git write-tree' + 'git diff-tree'. Thus that's the default mode.
 The non-cached version asks the question:
 
-  show me the differences between HEAD and the currently checked out
+  show me the differences between `HEAD` and the currently checked out
   tree - index contents _and_ files that aren't up to date
 
 which is obviously a very useful question too, since that tells you what
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 9f4b46c910..33a47958bc 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -45,20 +45,20 @@ files on disk.
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
 	would want comparison with the latest commit, so if you
-	do not give <commit>, it defaults to HEAD.
-	If HEAD does not exist (e.g. unborn branches) and
+	do not give <commit>, it defaults to `HEAD`.
+	If `HEAD` does not exist (e.g. unborn branches) and
 	<commit> is not given, it shows all staged changes.
 	`--staged` is a synonym of `--cached`.
 +
 If `--merge-base` is given, instead of using <commit>, use the merge base
-of <commit> and HEAD.  `git diff --merge-base A` is equivalent to
+of <commit> and `HEAD`.  `git diff --merge-base A` is equivalent to
 `git diff $(git merge-base A HEAD)`.
 
 'git diff' [<options>] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
-	use HEAD to compare it with the latest commit, or a
+	use `HEAD` to compare it with the latest commit, or a
 	branch name to compare with the tip of a different
 	branch.
 
@@ -85,7 +85,7 @@ If `--merge-base` is given, use the merge base of the two commits for the
 	This is synonymous to the earlier form (without the `..`) for
 	viewing the changes between two arbitrary <commit>.  If <commit> on
 	one side is omitted, it will have the same effect as
-	using HEAD instead.
+	using `HEAD` instead.
 
 'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
 
@@ -93,7 +93,7 @@ If `--merge-base` is given, use the merge base of the two commits for the
 	and up to the second <commit>, starting at a common ancestor
 	of both <commit>.  `git diff A...B` is equivalent to
 	`git diff $(git merge-base A B) B`.  You can omit any one
-	of <commit>, which has the same effect as using HEAD instead.
+	of <commit>, which has the same effect as using `HEAD` instead.
 
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
@@ -165,8 +165,8 @@ $ git diff HEAD^ HEAD      <3>
 ------------
 +
 <1> Instead of using the tip of the current branch, compare with the
-    tip of "test" branch.
-<2> Instead of comparing with the tip of "test" branch, compare with
+    tip of `test` branch.
+<2> Instead of comparing with the tip of `test` branch, compare with
     the tip of the current branch, but limit the comparison to the
     file "test".
 <3> Compare the version before the last commit and the last commit.
@@ -179,9 +179,9 @@ $ git diff topic..master   <2>
 $ git diff topic...master  <3>
 ------------
 +
-<1> Changes between the tips of the topic and the master branches.
+<1> Changes between the tips of the `topic` and the `master` branches.
 <2> Same as above.
-<3> Changes that occurred on the master branch since when the topic
+<3> Changes that occurred on the `master` branch since when the `topic`
     branch was started off it.
 
 Limiting the diff output::
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index a1c02918f9..3a6a77abac 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -126,10 +126,10 @@ by keeping the marks the same across runs.
 
 --reference-excluded-parents::
 	By default, running a command such as `git fast-export
-	master~5..master` will not include the commit master{tilde}5
-	and will make master{tilde}4 no longer have master{tilde}5 as
-	a parent (though both the old master{tilde}4 and new
-	master{tilde}4 will have all the same files).  Use
+	master~5..master` will not include the commit `master~5`
+	and will make `master~4` no longer have `master~5` as
+	a parent (though both the old `master~4` and new
+	`master~4` will have all the same files).  Use
 	`--reference-excluded-parents` to instead have the stream
 	refer to commits in the excluded range of history by their
 	sha1sum.  Note that the resulting stream can only be used by a
@@ -158,10 +158,10 @@ by keeping the marks the same across runs.
 	A list of arguments, acceptable to 'git rev-parse' and
 	'git rev-list', that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
-	current master reference to be exported along with all objects
+	current `master` reference to be exported along with all objects
 	added since its 10th ancestor commit and (unless the
 	`--reference-excluded-parents` option is specified) all files
-	common to master{tilde}9 and master{tilde}10.
+	common to `master~9` and `master~10`.
 
 EXAMPLES
 --------
@@ -180,8 +180,8 @@ $ git fast-export master~5..master |
 	git fast-import
 -----------------------------------------------------
 
-This makes a new branch called 'other' from 'master~5..master'
-(i.e. if 'master' has linear history, it will take the last 5 commits).
+This makes a new branch called `other` from `master~5`..`master`
+(i.e. if `master` has linear history, it will take the last 5 commits).
 
 Note that this assumes that none of the blobs and commit messages
 referenced by that revision range contains the string
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 88c2b9d426..1f48f89e3e 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -116,7 +116,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 <refs>...::
 	The remote heads to update from. This is relative to
-	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
+	$GIT_DIR (e.g. `HEAD`, "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
 +
 If the remote has enabled the options `uploadpack.allowTipSHA1InWant`,
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 85b073a61a..a5ecf00db3 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -87,10 +87,10 @@ This configuration is used in two ways:
   <refspec>s given on the command line determine what are to be
   fetched (e.g. `master` in the example,
   which is a short-hand for `master:`, which in turn means
-  "fetch the 'master' branch but I do not explicitly say what
+  "fetch the `master` branch but I do not explicitly say what
   remote-tracking branch to update with it from the command line"),
   and the example command will
-  fetch _only_ the 'master' branch.  The `remote.<repository>.fetch`
+  fetch _only_ the `master` branch.  The `remote.<repository>.fetch`
   values determine which
   remote-tracking branch, if any, is updated.  When used in this
   way, the `remote.<repository>.fetch` values do not have any
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2de3511459..e2955bc648 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -267,7 +267,7 @@ history, so we also add `--ignore-unmatch`:
 git filter-branch --index-filter 'git rm --cached --ignore-unmatch filename' HEAD
 --------------------------------------------------------------------------
 
-Now, you will get the rewritten history saved in HEAD.
+Now, you will get the rewritten history saved in `HEAD`.
 
 To rewrite the repository to look as if `foodir/` had been its project
 root, and discard all other history:
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 9004861eae..86fb26dcea 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -65,8 +65,8 @@ $ git fetch origin master
 $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
 ---------
 
-Print a log message describing a merge of the "master" branch from
-the "origin" remote.
+Print a log message describing a merge of the `master` branch from
+the `origin` remote.
 
 
 SEE ALSO
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e035edf11d..4bde4f9d05 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -76,18 +76,18 @@ OPTIONS
 
 --merged[=<object>]::
 	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (`HEAD` if not specified).
 
 --no-merged[=<object>]::
 	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (`HEAD` if not specified).
 
 --contains[=<object>]::
-	Only list refs which contain the specified commit (HEAD if not
+	Only list refs which contain the specified commit (`HEAD` if not
 	specified).
 
 --no-contains[=<object>]::
-	Only list refs which don't contain the specified commit (HEAD
+	Only list refs which don't contain the specified commit (`HEAD`
 	if not specified).
 
 --ignore-case::
@@ -169,7 +169,7 @@ push::
 	ref is configured.
 
 HEAD::
-	'*' if HEAD matches current ref (the checked out branch), ' '
+	'*' if `HEAD` matches current ref (the checked out branch), ' '
 	otherwise.
 
 color::
@@ -201,7 +201,7 @@ if::
 	everything after %(else) is printed. We ignore space when
 	evaluating the string before %(then), this is useful when we
 	use the %(HEAD) atom which prints either "*" or " " and we
-	want to apply the 'if' condition only on the 'HEAD' ref.
+	want to apply the 'if' condition only on the `HEAD` ref.
 	Append ":equals=<string>" or ":notequals=<string>" to compare
 	the value between the %(if:...) and %(then) atoms with the
 	given string.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index ca500ba72c..fd7c6c705b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -706,7 +706,7 @@ $ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
 
 * Extract all commits which are in the current branch but not in the
-  origin branch:
+  `origin` branch:
 +
 ------------
 $ git format-patch origin
@@ -714,7 +714,7 @@ $ git format-patch origin
 +
 For each commit a separate file is created in the current directory.
 
-* Extract all commits that lead to 'origin' since the inception of the
+* Extract all commits that lead to `origin` since the inception of the
   project:
 +
 ------------
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 5dd4d2b63a..7ba8ea2383 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -44,12 +44,12 @@ OPTIONS
 -d::
 -D::
 	Remove <ref> from remote repository.  The specified branch
-	cannot be the remote HEAD.  If `-d` is specified the following
+	cannot be the remote `HEAD`.  If `-d` is specified the following
 	other conditions must also be met:
 
-	- Remote HEAD must resolve to an object that exists locally
+	- Remote `HEAD` must resolve to an object that exists locally
 	- Specified branch resolves to an object that exists locally
-	- Specified branch is an ancestor of the remote HEAD
+	- Specified branch is an ancestor of the remote `HEAD`
 
 <ref>...::
 	The remote refs to update.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1bbf865a1b..b306dced1c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -152,13 +152,13 @@ EXAMPLES
 `git log --branches --not --remotes=origin`::
 
 	Shows all commits that are in any of local branches but not in
-	any of remote-tracking branches for 'origin' (what you have that
-	origin doesn't).
+	any of remote-tracking branches for `origin` (what you have that
+	`origin` doesn't).
 
 `git log master --not --remotes=*/master`::
 
-	Shows all commits that are in local master but not in any remote
-	repository master branches.
+	Shows all commits that are in local `master` but not in any remote
+	repository `master` branches.
 
 `git log -p -m --first-parent`::
 
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 4cb4e2fd5d..af005ece9a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -59,7 +59,7 @@ OPTIONS
 --symref::
 	In addition to the object pointed by it, show the underlying
 	ref pointed by it when showing a symbolic ref.  Currently,
-	upload-pack only shows the symref HEAD, so it will be the only
+	upload-pack only shows the symref `HEAD`, so it will be the only
 	one shown by ls-remote.
 
 --sort=<key>::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3819fadac1..58fd091d73 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -146,7 +146,7 @@ To avoid recording unrelated changes in the merge commit,
 'git pull' and 'git merge' will also abort if there are any changes
 registered in the index relative to the `HEAD` commit.  (Special
 narrow exceptions to this rule may exist depending on which merge
-strategy is in use, but generally, the index must match HEAD.)
+strategy is in use, but generally, the index must match `HEAD`.)
 
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up to date."
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index b0a5ab9a72..ef04e3a8ff 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -60,7 +60,7 @@ list::
 	This is the default subcommand if no subcommand is given.
 
 add::
-	Add notes for a given object (defaults to HEAD). Abort if the
+	Add notes for a given object (defaults to `HEAD`). Abort if the
 	object already has notes (use `-f` to overwrite existing notes).
 	However, if you're using `add` interactively (using an editor
 	to supply the notes contents), then - instead of aborting -
@@ -69,7 +69,7 @@ add::
 
 copy::
 	Copy the notes for the first object onto the second object (defaults to
-	HEAD). Abort if the second object already has notes, or if the first
+	`HEAD`). Abort if the second object already has notes, or if the first
 	object has none (use -f to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
@@ -85,14 +85,14 @@ corresponding <to-object>.  (The optional `<rest>` is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
 
 append::
-	Append to the notes of an existing object (defaults to HEAD).
+	Append to the notes of an existing object (defaults to `HEAD`).
 	Creates a new notes object if needed.
 
 edit::
-	Edit the notes for a given object (defaults to HEAD).
+	Edit the notes for a given object (defaults to `HEAD`).
 
 show::
-	Show the notes for a given object (defaults to HEAD).
+	Show the notes for a given object (defaults to `HEAD`).
 
 merge::
 	Merge the given notes ref into the current notes ref.
@@ -110,7 +110,7 @@ When done, the user can either finalize the merge with
 'git notes merge --abort'.
 
 remove::
-	Remove the notes for given objects (defaults to HEAD). When
+	Remove the notes for given objects (defaults to `HEAD`). When
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index d9d29a5efa..ec23ab7d96 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -76,7 +76,7 @@ This:
 2. Imports the full contents of the head revision from the given p4
    depot path into a single commit in the Git branch 'refs/remotes/p4/master'.
 +
-3. Creates a local branch, 'master' from this remote and checks it out.
+3. Creates a local branch, `master` from this remote and checks it out.
 
 To reproduce the entire p4 history in Git, use the '@all' modifier on
 the depot path:
@@ -176,7 +176,7 @@ Unshelve
 Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
 in the branch refs/remotes/p4-unshelved/<changelist>.
 
-The git commit is created relative to the current origin revision (HEAD by default).
+The git commit is created relative to the current origin revision (`HEAD` by default).
 A parent commit is created based on the origin, and then the unshelve commit is
 created based on that.
 
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index edecf393d3..d9a5507195 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -211,7 +211,7 @@ $ git pull
 $ git pull origin
 ------------------------------------------------
 +
-Normally the branch merged in is the HEAD of the remote repository,
+Normally the branch merged in is the `HEAD` of the remote repository,
 but the choice is determined by the branch.<name>.remote and
 branch.<name>.merge options; see linkgit:git-config[1] for details.
 
@@ -221,7 +221,7 @@ branch.<name>.merge options; see linkgit:git-config[1] for details.
 $ git pull origin next
 ------------------------------------------------
 +
-This leaves a copy of `next` temporarily in FETCH_HEAD, and
+This leaves a copy of `next` temporarily in `FETCH_HEAD`, and
 updates the remote-tracking branch `origin/next`.
 The same can be done by invoking fetch and merge:
 +
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fc91d41ce0..91dcaa108c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -667,9 +667,9 @@ made on `satellite`.
 	(e.g. `refs/heads/experimental`), and delete it.
 
 `git push origin +dev:master`::
-	Update the origin repository's master branch with the dev branch,
+	Update the `origin` repository's `master` branch with the `dev` branch,
 	allowing non-fast-forward updates.  *This can leave unreferenced
-	commits dangling in the origin repository.*  Consider the
+	commits dangling in the `origin` repository.*  Consider the
 	following situation, where a fast-forward is not possible:
 +
 ----
@@ -678,7 +678,7 @@ made on `satellite`.
 		      X---Y---Z  dev
 ----
 +
-The above command would change the origin repository to
+The above command would change the `origin` repository to
 +
 ----
 		      A---B  (unnamed branch)
@@ -688,7 +688,7 @@ The above command would change the origin repository to
 +
 Commits A and B would no longer belong to a branch with a symbolic name,
 and so would be unreachable.  As such, these commits would be removed by
-a `git gc` command on the origin repository.
+a `git gc` command on the `origin` repository.
 
 include::transfer-data-leaks.txt[]
 
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 3f53688170..d22d3855d1 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -118,7 +118,7 @@ OPTIONS
 --[no-]recurse-submodules::
 	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject by
-	calling read-tree recursively, also setting the submodules' HEAD to be
+	calling read-tree recursively, also setting the submodules' `HEAD` to be
 	detached at that commit.
 
 --no-sparse-checkout::
@@ -356,7 +356,7 @@ $ git fetch git://.... linus
 $ LT=`git rev-parse FETCH_HEAD`
 ----------------
 
-Your work tree is still based on your HEAD ($JC), but you have
+Your work tree is still based on your `HEAD` ($JC), but you have
 some edits since.  Three-way merge makes sure that you have not
 added or modified index entries since $JC, and if you haven't,
 then does the right thing.  So with the following sequence:
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f063d54623..bd9f15ea26 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -35,13 +35,13 @@ description on `--fork-point` below); or by `git log HEAD`, if the
 
 The current branch is reset to <upstream>, or <newbase> if the
 `--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
+`git reset --hard <upstream>` (or <newbase>).  `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
 The commits that were previously saved into the temporary area are
 then reapplied to the current branch, one by one, in order. Note that
-any commits in HEAD which introduce the same textual changes as a commit
-in HEAD..<upstream> are omitted (i.e., a patch already accepted upstream
+any commits in `HEAD` which introduce the same textual changes as a commit
+in `HEAD`..<upstream> are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
 It is possible that a merge failure will prevent this process from being
@@ -51,7 +51,7 @@ that caused the merge failure with `git rebase --skip`.  To check out the
 original <branch> and remove the .git/rebase-apply working files, use the
 command `git rebase --abort` instead.
 
-Assume the following history exists and the current branch is "topic":
+Assume the following history exists and the current branch is `topic`:
 
 ------------
           A---B---C topic
@@ -101,9 +101,9 @@ Here is how you would transplant a topic branch based on one
 branch to another, to pretend that you forked the topic branch
 from the latter branch, using `rebase --onto`.
 
-First let's assume your 'topic' is based on branch 'next'.
-For example, a feature developed in 'topic' depends on some
-functionality which is found in 'next'.
+First let's assume your `topic` is based on branch `next`.
+For example, a feature developed in `topic` depends on some
+functionality which is found in `next'.
 
 ------------
     o---o---o---o---o  master
@@ -113,9 +113,9 @@ functionality which is found in 'next'.
                             o---o---o  topic
 ------------
 
-We want to make 'topic' forked from branch 'master'; for example,
-because the functionality on which 'topic' depends was merged into the
-more stable 'master' branch. We want our tree to look like this:
+We want to make `topic` forked from branch `master`; for example,
+because the functionality on which `topic` depends was merged into the
+more stable `master` branch. We want our tree to look like this:
 
 ------------
     o---o---o---o---o  master
@@ -216,7 +216,7 @@ OPTIONS
 +
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
-leave out at most one of A and B, in which case it defaults to HEAD.
+leave out at most one of A and B, in which case it defaults to `HEAD`.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
@@ -242,20 +242,20 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream for the current branch.
 
 <branch>::
-	Working branch; defaults to HEAD.
+	Working branch; defaults to `HEAD`.
 
 --continue::
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
-	Abort the rebase operation and reset HEAD to the original
+	Abort the rebase operation and reset `HEAD` to the original
 	branch. If <branch> was provided when the rebase operation was
-	started, then HEAD will be reset to <branch>. Otherwise HEAD
+	started, then `HEAD` will be reset to <branch>. Otherwise `HEAD`
 	will be reset to where it was when the rebase operation was
 	started.
 
 --quit::
-	Abort the rebase operation but HEAD is not reset back to the
+	Abort the rebase operation but `HEAD` is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result. If a temporary stash entry was created
 	using `--autostash`, it will be saved to the stash list.
@@ -905,7 +905,7 @@ when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
 
 For example, if you want to reorder the last 5 commits, such that what
-was HEAD~4 becomes the new HEAD. To achieve that, you would call
+was `HEAD~4` becomes the new `HEAD`. To achieve that, you would call
 'git rebase' like this:
 
 ----------------------
@@ -925,8 +925,8 @@ like this:
 ---o---O---P---Q
 ------------------
 
-Suppose you want to rebase the side branch starting at "A" to "Q". Make
-sure that the current HEAD is "B", and call
+Suppose you want to rebase the side branch starting at `A` to `Q`. Make
+sure that the current `HEAD` is `B`, and call
 
 -----------------------------
 $ git rebase -i -r --onto Q O
@@ -990,7 +990,7 @@ add other commits.  This can be used to split a commit into two:
 - Mark the commit you want to split with the action "edit".
 
 - When it comes to editing that commit, execute `git reset HEAD^`.  The
-  effect is that the HEAD is rewound by one, and the index follows suit.
+  effect is that the `HEAD` is rewound by one, and the index follows suit.
   However, the working tree stays the same.
 
 - Now add the changes to the index that you want to have in the first
@@ -1020,8 +1020,8 @@ from the downstream's point of view.  The real fix, however, would be
 to avoid rebasing the upstream in the first place.
 
 To illustrate, suppose you are in a situation where someone develops a
-'subsystem' branch, and you are working on a 'topic' that is dependent
-on this 'subsystem'.  You might end up with a history like the
+`subsystem` branch, and you are working on a `topic` that is dependent
+on this `subsystem`.  You might end up with a history like the
 following:
 
 ------------
@@ -1032,7 +1032,7 @@ following:
 			    *---*---*  topic
 ------------
 
-If 'subsystem' is rebased against 'master', the following happens:
+If `subsystem` is rebased against `master`, the following happens:
 
 ------------
     o---o---o---o---o---o---o---o  master
@@ -1042,8 +1042,8 @@ If 'subsystem' is rebased against 'master', the following happens:
 			    *---*---*  topic
 ------------
 
-If you now continue development as usual, and eventually merge 'topic'
-to 'subsystem', the commits from 'subsystem' will remain duplicated forever:
+If you now continue development as usual, and eventually merge `topic`
+to `subsystem`, the commits from `subsystem` will remain duplicated forever:
 
 ------------
     o---o---o---o---o---o---o---o  master
@@ -1055,20 +1055,20 @@ to 'subsystem', the commits from 'subsystem' will remain duplicated forever:
 
 Such duplicates are generally frowned upon because they clutter up
 history, making it harder to follow.  To clean things up, you need to
-transplant the commits on 'topic' to the new 'subsystem' tip, i.e.,
-rebase 'topic'.  This becomes a ripple effect: anyone downstream from
-'topic' is forced to rebase too, and so on!
+transplant the commits on `topic` to the new `subsystem` tip, i.e.,
+rebase `topic`.  This becomes a ripple effect: anyone downstream from
+`topic` is forced to rebase too, and so on!
 
 There are two kinds of fixes, discussed in the following subsections:
 
 Easy case: The changes are literally the same.::
 
-	This happens if the 'subsystem' rebase was a simple rebase and
+	This happens if the `subsystem` rebase was a simple rebase and
 	had no conflicts.
 
 Hard case: The changes are not the same.::
 
-	This happens if the 'subsystem' rebase had conflicts, or used
+	This happens if the `subsystem` rebase had conflicts, or used
 	`--interactive` to omit, edit, squash, or fixup commits; or
 	if the upstream used one of `commit --amend`, `reset`, or
 	a full history rewriting command like
@@ -1079,13 +1079,13 @@ The easy case
 ~~~~~~~~~~~~~
 
 Only works if the changes (patch IDs based on the diff contents) on
-'subsystem' are literally the same before and after the rebase
-'subsystem' did.
+`subsystem` are literally the same before and after the rebase
+`subsystem` did.
 
 In that case, the fix is easy because 'git rebase' knows to skip
 changes that are already present in the new upstream (unless
 `--reapply-cherry-picks` is given). So if you say
-(assuming you're on 'topic')
+(assuming you're on `topic`)
 ------------
     $ git rebase subsystem
 ------------
@@ -1102,7 +1102,7 @@ you will end up with the fixed history
 The hard case
 ~~~~~~~~~~~~~
 
-Things get more complicated if the 'subsystem' changes do not exactly
+Things get more complicated if the `subsystem` changes do not exactly
 correspond to the ones before the rebase.
 
 NOTE: While an "easy case recovery" sometimes appears to be successful
@@ -1110,26 +1110,26 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       example, a commit that was removed via `git rebase
       --interactive` will be **resurrected**!
 
-The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge base
+The idea is to manually tell 'git rebase' "where the old `subsystem`
+ended and your `topic` began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
-of the old 'subsystem', for example:
+of the old `subsystem`, for example:
 
-* With the 'subsystem' reflog: after 'git fetch', the old tip of
-  'subsystem' is at `subsystem@{1}`.  Subsequent fetches will
+* With the `subsystem` reflog: after 'git fetch', the old tip of
+  `subsystem` is at `subsystem@{1}`.  Subsequent fetches will
   increase the number.  (See linkgit:git-reflog[1].)
 
-* Relative to the tip of 'topic': knowing that your 'topic' has three
-  commits, the old tip of 'subsystem' must be `topic~3`.
+* Relative to the tip of `topic`: knowing that your `topic` has three
+  commits, the old tip of `subsystem` must be `topic~3`.
 
-You can then transplant the old `subsystem..topic` to the new tip by
-saying (for the reflog case, and assuming you are on 'topic' already):
+You can then transplant the old `subsystem`..`topic` to the new tip by
+saying (for the reflog case, and assuming you are on `topic` already):
 ------------
     $ git rebase --onto subsystem subsystem@{1}
 ------------
 
 The ripple effect of a "hard case" recovery is especially bad:
-'everyone' downstream from 'topic' will now have to perform a "hard
+'everyone' downstream from `topic` will now have to perform a "hard
 case" recovery too!
 
 REBASING MERGES
@@ -1193,7 +1193,7 @@ merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
 In contrast to a regular interactive rebase, there are `label`, `reset`
 and `merge` commands in addition to `pick` ones.
 
-The `label` command associates a label with the current HEAD when that
+The `label` command associates a label with the current `HEAD` when that
 command is executed. These labels are created as worktree-local refs
 (`refs/rewritten/<label>`) that will be deleted when the rebase
 finishes. That way, rebase operations in multiple worktrees linked to
@@ -1201,7 +1201,7 @@ the same repository do not interfere with one another. If the `label`
 command fails, it is rescheduled immediately, with a helpful message how
 to proceed.
 
-The `reset` command resets the HEAD, index and worktree to the specified
+The `reset` command resets the `HEAD`, index and worktree to the specified
 revision. It is similar to an `exec git reset --hard <label>`, but
 refuses to overwrite untracked files. If the `reset` command fails, it is
 rescheduled immediately, with a helpful message how to edit the todo list
@@ -1209,7 +1209,7 @@ rescheduled immediately, with a helpful message how to edit the todo list
 list manually and contains a typo).
 
 The `merge` command will merge the specified revision(s) into whatever
-is HEAD at that time. With `-C <original-commit>`, the commit message of
+is `HEAD` at that time. With `-C <original-commit>`, the commit message of
 the specified merge commit will be used. When the `-C` is changed to
 a lower-case `-c`, the message will be opened in an editor after a
 successful merge so that the user can edit the message.
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77d..cf1d7e0810 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -28,8 +28,8 @@ depending on the subcommand:
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
 useful in various Git commands, to specify the old value of a
-reference. For example, `HEAD@{2}` means "where HEAD used to be two
-moves ago", `master@{one.week.ago}` means "where master used to point
+reference. For example, `HEAD@{2}` means "where `HEAD` used to be two
+moves ago", `master@{one.week.ago}` means "where `master` used to point
 to one week ago in this local repository", and so on. See
 linkgit:gitrevisions[7] for more details.
 
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 4d4392d0f8..f58164aee1 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -37,7 +37,7 @@ OPTIONS
 	The repository URL to be pulled from.
 
 <end>::
-	Commit to end at (defaults to HEAD).  This names the commit
+	Commit to end at (defaults to `HEAD`).  This names the commit
 	at the tip of the history you are asking to be pulled.
 +
 When the repository named by `<url>` has the commit at a tip of a
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc883378..c5c6be5202 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -76,10 +76,10 @@ variables respectively.
 DISCUSSION
 ----------
 
-When your topic branch modifies an overlapping area that your
-master branch (or upstream) touched since your topic branch
-forked from it, you may want to test it with the latest master,
-even before your topic branch is ready to be pushed upstream:
+When your `topic` branch modifies an overlapping area that your
+`master` branch (or upstream) touched since your `topic` branch
+forked from it, you may want to test it with the latest `master`,
+even before your `topic` branch is ready to be pushed upstream:
 
 ------------
               o---*---o topic
@@ -87,8 +87,8 @@ even before your topic branch is ready to be pushed upstream:
     o---o---o---*---o---o master
 ------------
 
-For such a test, you need to merge master and topic somehow.
-One way to do it is to pull master into the topic branch:
+For such a test, you need to merge `master` and `topic` somehow.
+One way to do it is to pull `master` into the `topic` branch:
 
 ------------
 	$ git switch topic
@@ -106,9 +106,9 @@ work-in-progress still works with what is in the latest master.
 
 After this test merge, there are two ways to continue your work
 on the topic.  The easiest is to build on top of the test merge
-commit `+`, and when your work in the topic branch is finally
-ready, pull the topic branch into master, and/or ask the
-upstream to pull from you.  By that time, however, the master or
+commit `+`, and when your work in the `topic` branch is finally
+ready, pull the `topic` branch into `master`, and/or ask the
+upstream to pull from you.  By that time, however, the `master` or
 the upstream might have been advanced since the test merge `+`,
 in which case the final commit graph would look like this:
 
@@ -124,14 +124,14 @@ in which case the final commit graph would look like this:
     o---o---o---*---o---o---o---o---+ master
 ------------
 
-When your topic branch is long-lived, however, your topic branch
-would end up having many such "Merge from master" commits on it,
+When your `topic` branch is long-lived, however, your `topic` branch
+would end up having many such "Merge from `master`" commits on it,
 which would unnecessarily clutter the development history.
 Readers of the Linux kernel mailing list may remember that Linus
 complained about such too frequent test merges when a subsystem
 maintainer asked to pull from a branch full of "useless merges".
 
-As an alternative, to keep the topic branch clean of test
+As an alternative, to keep the `topic` branch clean of test
 merges, you could blow away the test merge, and keep building on
 top of the tip before the test merge:
 
@@ -148,8 +148,8 @@ top of the tip before the test merge:
     o---o---o---*---o---o---o---o---+ master
 ------------
 
-This would leave only one merge commit when your topic branch is
-finally ready and merged into the master branch.  This merge
+This would leave only one merge commit when your `topic` branch is
+finally ready and merged into the `master` branch.  This merge
 would require you to resolve the conflict, introduced by the
 commits marked with `*`.  However, this conflict is often the
 same conflict you resolved when you created the test merge you
@@ -163,7 +163,7 @@ usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
 them.  Later, after you are done resolving the conflicts,
 running 'git rerere' again will record the resolved state of these
 files.  Suppose you did this when you created the test merge of
-master into the topic branch.
+`master` into the `topic` branch.
 
 Next time, after seeing the same conflicted automerge,
 running 'git rerere' will perform a three-way merge between the
@@ -185,12 +185,12 @@ the rerere.enabled config variable).
 
 In our example, when you do the test merge, the manual
 resolution is recorded, and it will be reused when you do the
-actual merge later with the updated master and topic branch, as long
+actual merge later with the updated `master` and `topic` branch, as long
 as the recorded resolution is still applicable.
 
 The information 'git rerere' records is also used when running
 'git rebase'.  After blowing away the test merge and continuing
-development on the topic branch:
+development on the `topic` branch:
 
 ------------
               o---*---o-------o---o topic
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index e9e816a986..4a55d1f1ac 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Reset current `HEAD` to the specified state
 
 SYNOPSIS
 --------
@@ -92,7 +92,7 @@ but carries forward unmerged index entries.
 	When the working tree is updated, using `--recurse-submodules` will
 	also recursively reset the working tree of all active submodules
 	according to the commit recorded in the superproject, also setting
-	the submodules' HEAD to be detached at that commit.
+	the submodules' `HEAD` to be detached at that commit.
 --
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
@@ -187,7 +187,7 @@ $ git switch topic/wip          <3>
     to be in the `master` branch.  You want to continue polishing
     them in a topic branch, so create `topic/wip` branch off of the
     current `HEAD`.
-<2> Rewind the master branch to get rid of those three commits.
+<2> Rewind the `master` branch to get rid of those three commits.
 <3> Switch to `topic/wip` branch and keep working.
 
 Undo commits permanently::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 4b1af8c5a6..7c3c0e0007 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -155,7 +155,7 @@ for another option.
 	This is similar to `--symbolic`, but it omits input that
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
-	want to name the "master" branch when there is an
+	want to name the `master` branch when there is an
 	unfortunately named tag "master"), and show them as full
 	refnames (e.g. "refs/heads/master").
 
@@ -475,7 +475,7 @@ This will error out if $REV is empty or not a valid revision.
 $ git rev-parse --default master --verify --end-of-options $REV
 ------------
 +
-but if $REV is empty, the commit object name from master will be printed.
+but if $REV is empty, the commit object name from `master` will be printed.
 
 GIT
 ---
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index bb92a4a451..a232db1d98 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -17,7 +17,7 @@ DESCRIPTION
 Given one or more existing commits, revert the changes that the
 related patches introduce, and record some new commits that record
 them.  This requires your working tree to be clean (no modifications
-from the HEAD commit).
+from the `HEAD` commit).
 
 Note: 'git revert' is used to record some new commits to reverse the
 effect of some earlier commits (often only a faulty one).  If you want to
@@ -82,7 +82,7 @@ more details.
 	to revert the named commits to your working tree
 	and the index, but does not make the commits.  In addition,
 	when this option is used, your index does not have to match
-	the HEAD commit.  The revert is done against the
+	the `HEAD` commit.  The revert is done against the
 	beginning state of your index.
 +
 This is useful when reverting more than one commits'
@@ -125,13 +125,13 @@ EXAMPLES
 --------
 `git revert HEAD~3`::
 
-	Revert the changes specified by the fourth last commit in HEAD
+	Revert the changes specified by the fourth last commit in `HEAD`
 	and create a new commit with the reverted changes.
 
 `git revert -n master~5..master~2`::
 
 	Revert the changes done by commits from the fifth last commit
-	in master (included) to the third last commit in master
+	in `master` (included) to the third last commit in `master`
 	(included), but do not create any commit with the reverted
 	changes. The revert only modifies the working tree and the
 	index.
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index e7ff1b5fbd..ea1f349a87 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -153,7 +153,7 @@ the submodule's history. If it exists the submodule.<name> section
 in the linkgit:gitmodules[5] file will also be removed and that file
 will be staged (unless `--cached` or `-n` are used).
 
-A submodule is considered up to date when the HEAD is the same as
+A submodule is considered up to date when the `HEAD` is the same as
 recorded in the index, no tracked files are modified and no untracked
 files that aren't ignored are present in the submodules work tree.
 Ignored files are deemed expendable and won't stop a submodule's work
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 8c739adc70..9d7ba22603 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -35,7 +35,7 @@ OPTIONS
 
 --head::
 
-	Show the HEAD reference, even if it would normally be filtered out.
+	Show the `HEAD` reference, even if it would normally be filtered out.
 
 --heads::
 --tags::
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b1bc7288d..b7a6f9b544 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -35,7 +35,7 @@ This manual page describes only the most frequently used options.
 OPTIONS
 -------
 <object>...::
-	The names of objects to show (defaults to 'HEAD').
+	The names of objects to show (defaults to `HEAD`).
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a8c8c32f1e..a2b69ae00f 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -50,7 +50,7 @@ COMMANDS
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
-	back to HEAD (in the working tree and in the index).
+	back to `HEAD` (in the working tree and in the index).
 	The <message> part is optional and gives
 	the description along with the stashed state.
 +
@@ -121,7 +121,7 @@ branch <branchname> [<stash>]::
 +
 This is useful if the branch on which you ran `git stash push` has
 changed enough that `git stash apply` fails due to conflicts. Since
-the stash entry is applied on top of the commit that was HEAD at the
+the stash entry is applied on top of the commit that was `HEAD` at the
 time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
@@ -192,7 +192,7 @@ All changes already added to the index are left intact.
 --patch::
 	This option is only valid for `push` and `save` commands.
 +
-Interactively select hunks from the diff between HEAD and the
+Interactively select hunks from the diff between `HEAD` and the
 working tree to be stashed.  The stash entry is constructed such
 that its index state is the same as the index state of your
 repository, and its worktree contains only the changes you selected
@@ -237,7 +237,7 @@ Separates pathspec from options for disambiguation purposes.
 +
 The new stash entry records the modified states only for the files
 that match the pathspec.  The index entries and working tree files
-are then rolled back to the state in HEAD only for these files,
+are then rolled back to the state in `HEAD` only for these files,
 too, leaving files that do not match the pathspec intact.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2fa3bc58f7..4b1951c5ce 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Displays paths that have differences between the index file and the
-current HEAD commit, paths that have differences between the working
+current `HEAD` commit, paths that have differences between the working
 tree and the index file, and paths in the working tree that are not
 tracked by Git (and are not ignored by linkgit:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
@@ -88,7 +88,7 @@ configuration variable documented in linkgit:git-config[1].
 	Ignore changes to submodules when looking for changes. <when> can be
 	either "none", "untracked", "dirty" or "all", which is the default.
 	Using "none" will consider the submodule modified when it either contains
-	untracked or modified files or its HEAD differs from the commit recorded
+	untracked or modified files or its `HEAD` differs from the commit recorded
 	in the superproject and can be used to override any settings of the
 	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	"untracked" is used submodules are not considered dirty when they only
@@ -242,7 +242,7 @@ U           U    unmerged, both modified
 ....
 
 Submodules have more state and instead report
-		M    the submodule has a different HEAD than
+		M    the submodule has a different `HEAD` than
 		     recorded in the index
 		m    the submodule has modified content
 		?    the submodule has untracked files
@@ -341,10 +341,10 @@ Field       Meaning
 	    <c> is "C" if the commit changed; otherwise ".".
 	    <m> is "M" if it has tracked changes; otherwise ".".
 	    <u> is "U" if there are untracked changes; otherwise ".".
-<mH>        The octal file mode in HEAD.
+<mH>        The octal file mode in `HEAD`.
 <mI>        The octal file mode in the index.
 <mW>        The octal file mode in the worktree.
-<hH>        The object name in HEAD.
+<hH>        The object name in `HEAD`.
 <hI>        The object name in the index.
 <X><score>  The rename or copy score (denoting the percentage
 	    of similarity between the source and target of the
@@ -354,7 +354,7 @@ Field       Meaning
 <sep>       When the `-z` option is used, the 2 pathnames are separated
 	    with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
 	    byte separates them.
-<origPath>  The pathname in the commit at HEAD or in the index.
+<origPath>  The pathname in the commit at `HEAD` or in the index.
 	    This is only present in a renamed/copied entry, and
 	    tells where the renamed/copied contents came from.
 --------------------------------------------------------
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1bcde161ca..891c9e48e5 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -39,7 +39,7 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
 	to the changeset to be committed next to the current
 	project: the current project is termed the "superproject".
 +
-<repository> is the URL of the new submodule's origin repository.
+<repository> is the URL of the new submodule's `origin` repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's default remote
 repository (Please note that to specify a repository 'foo.git'
@@ -50,7 +50,7 @@ of relative URLs in Git is identical to that of relative directories).
 +
 The default remote is the remote of the remote-tracking branch
 of the current branch. If no such remote-tracking branch exists or
-the HEAD is detached, "origin" is assumed to be the default remote.
+the `HEAD` is detached, `origin` is assumed to be the default remote.
 If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
@@ -88,7 +88,7 @@ If `--recursive` is specified, this command will recurse into nested
 submodules, and show their status as well.
 +
 If you are only interested in changes of the currently initialized
-submodules with respect to the commit recorded in the index or the HEAD,
+submodules with respect to the commit recorded in the index or the `HEAD`,
 linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
 too (and can also report changes to a submodule's work tree).
 
@@ -147,7 +147,7 @@ The 'update' procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
 	checkout;; the commit recorded in the superproject will be
-	    checked out in the submodule on a detached HEAD.
+	    checked out in the submodule on a detached `HEAD`.
 +
 If `--force` is specified, the submodule will be checked out (using
 `git checkout --force`), even if the commit specified
@@ -183,7 +183,7 @@ set-branch (-d|--default) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
 	`--branch` option allows the remote branch to be specified. The
 	`--default` option removes the submodule.<name>.branch configuration
-	key, which causes the tracking branch to default to the remote 'HEAD'.
+	key, which causes the tracking branch to default to the remote `HEAD`.
 
 set-url [--] <path> <newurl>::
 	Sets the URL of the specified submodule to <newurl>. Then, it will
@@ -191,7 +191,7 @@ set-url [--] <path> <newurl>::
 	configuration.
 
 summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
-	Show commit summary between the given commit (defaults to HEAD) and
+	Show commit summary between the given commit (defaults to `HEAD`) and
 	working tree/index. For a submodule in question, a series of commits
 	in the submodule between the given super project commit and the
 	index or working tree (switched by `--cached`) are shown. If the option
@@ -284,7 +284,7 @@ OPTIONS
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
 	same name as the current branch in the current repository.  If the
-	option is not specified, it defaults to the remote 'HEAD'.
+	option is not specified, it defaults to the remote `HEAD`.
 
 -f::
 --force::
@@ -301,12 +301,12 @@ OPTIONS
 
 --cached::
 	This option is only valid for status and summary commands.  These
-	commands typically use the commit found in the submodule HEAD, but
+	commands typically use the commit found in the submodule `HEAD`, but
 	with this option, the commit stored in the index is used instead.
 
 --files::
 	This option is only valid for the summary command. This command
-	compares the commit in the index with that in the submodule HEAD
+	compares the commit in the index with that in the submodule `HEAD`
 	when this option is used.
 
 -n::
@@ -339,7 +339,7 @@ SHA-1.  If you don't want to fetch, you should use `submodule update
 --remote --no-fetch`.
 +
 Use this option to integrate changes from the upstream subproject with
-your submodule's current HEAD.  Alternatively, you can run `git pull`
+your submodule's current `HEAD`.  Alternatively, you can run `git pull`
 from the submodule, which is equivalent except for the remote branch
 name: `update --remote` uses the default upstream repository and
 `submodule.<name>.branch`, while `git pull` uses the submodule's
@@ -355,7 +355,7 @@ the submodule itself.
 
 --checkout::
 	This option is only valid for the update command.
-	Checkout the commit recorded in the superproject on a detached HEAD
+	Checkout the commit recorded in the superproject on a detached `HEAD`
 	in the submodule. This is the default behavior, the main use of
 	this option is to override `submodule.$name.update` when set to
 	a value other than `checkout`.
@@ -365,7 +365,7 @@ the submodule itself.
 --merge::
 	This option is only valid for the update command.
 	Merge the commit recorded in the superproject into the current branch
-	of the submodule. If this option is given, the submodule's HEAD will
+	of the submodule. If this option is given, the submodule's `HEAD` will
 	not be detached. If a merge failure prevents this process, you will
 	have to resolve the resulting conflicts within the submodule with the
 	usual conflict resolution tools.
@@ -375,7 +375,7 @@ the submodule itself.
 --rebase::
 	This option is only valid for the update command.
 	Rebase the current branch onto the commit recorded in the
-	superproject. If this option is given, the submodule's HEAD will not
+	superproject. If this option is given, the submodule's `HEAD` will not
 	be detached. If a merge failure prevents this process, you will have
 	to resolve these failures with linkgit:git-rebase[1].
 	If the key `submodule.$name.update` is set to `rebase`, this option is
@@ -432,7 +432,7 @@ options carefully.
 
 --[no-]single-branch::
 	This option is only valid for the update command.
-	Clone only one branch during update: HEAD or one specified by `--branch`.
+	Clone only one branch during update: `HEAD` or one specified by `--branch`.
 
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 3f55e9c419..f316b7dfc4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -140,7 +140,7 @@ repository, either don't use this option or you should both use it in
 the same local time zone.
 
 --parent;;
-	Fetch only from the SVN parent of the current HEAD.
+	Fetch only from the SVN parent of the current `HEAD`.
 
 --ignore-refs=<regex>;;
 	Ignore refs for branches or tags matching the Perl regular
@@ -224,7 +224,7 @@ config key: svn-remote.<name>.include-paths
 	Default: ".gitignore"
 
 'rebase'::
-	This fetches revisions from the SVN parent of the current HEAD
+	This fetches revisions from the SVN parent of the current `HEAD`
 	and rebases the current (uncommitted to SVN) work against it.
 +
 This works similarly to `svn update` or 'git pull' except that
@@ -394,7 +394,7 @@ Any other arguments are passed directly to 'git log'
 	output of this mode is format-compatible with the output of
 	`svn blame' by default. Like the SVN blame command,
 	local uncommitted changes in the working tree are ignored;
-	the version of the file in the HEAD revision is annotated. Unknown
+	the version of the file in the `HEAD` revision is annotated. Unknown
 	arguments are passed directly to 'git blame'.
 +
 --git-format;;
@@ -558,7 +558,7 @@ git svn fetch
        r2---r3---A---B master
 ------------
 +
-Then fixup "master" with 'git rebase'.
+Then fixup `master` with 'git rebase'.
 Do NOT use 'git merge' or your history will not be compatible with a
 future 'dcommit'!
 +
@@ -954,7 +954,7 @@ HANDLING OF SVN BRANCHES
 If 'git svn' is configured to fetch branches (and `--follow-branches`
 is in effect), it sometimes creates multiple Git branches for one
 SVN branch, where the additional branches have names of the form
-'branchname@nnn' (with nnn an SVN revision number).  These additional
+`branchname@nnn` (with nnn an SVN revision number).  These additional
 branches are created if 'git svn' cannot find a parent commit for the
 first commit in an SVN branch, to connect the branch to the history of
 the other branches.
@@ -976,7 +976,7 @@ branch was copied from and create appropriate Git commits.  This is
 indicated by the message "Initializing parent: <branchname>".
 
 Additionally, it will create a special branch named
-'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
+`<branchname>@<SVN-Revision>`, where <SVN-Revision> is the SVN revision
 number the branch was copied from.  This branch will point to the newly
 created parent commit of the branch.  If in SVN the branch was deleted
 and later recreated from a different version, there will be multiple
@@ -988,12 +988,12 @@ single SVN revision.
 An example: in an SVN repository with a standard
 trunk/tags/branches layout, a directory trunk/sub is created in r.100.
 In r.200, trunk/sub is branched by copying it to branches/. 'git svn
-clone -s' will then create a branch 'sub'. It will also create new Git
+clone -s' will then create a branch `sub`. It will also create new Git
 commits for r.100 through r.199 and use these as the history of branch
-'sub'. Thus there will be two Git commits for each revision from r.100
+`sub`. Thus there will be two Git commits for each revision from r.100
 to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
-it will create a branch 'sub@200' pointing to the new parent commit of
-branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
+it will create a branch `sub@200` pointing to the new parent commit of
+branch `sub` (i.e. the commit for r.200 and trunk/sub/).
 
 CAVEATS
 -------
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd505..5737f25cf6 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -42,7 +42,7 @@ OPTIONS
 <start-point>::
 	The starting point for the new branch. Specifying a
 	`<start-point>` allows you to create a branch based on some
-	other point in history than where HEAD currently points. (Or,
+	other point in history than where `HEAD` currently points. (Or,
 	in the case of `--detach`, allows you to inspect and detach
 	from some other point.)
 +
@@ -99,7 +99,7 @@ the `checkout.defaultRemote` configuration variable, we'll use that
 one for the purposes of disambiguation, even if the `<branch>` isn't
 unique across all remotes. Set it to e.g. `checkout.defaultRemote=origin`
 to always checkout remote branches from there if `<branch>` is
-ambiguous but exists on the 'origin' remote. See also
+ambiguous but exists on the `origin` remote. See also
 `checkout.defaultRemote` in linkgit:git-config[1].
 +
 `--guess` is the default behavior. Use `--no-guess` to disable it.
@@ -193,7 +193,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 EXAMPLES
 --------
 
-The following command switches to the "master" branch:
+The following command switches to the `master` branch:
 
 ------------
 $ git switch master
@@ -228,14 +228,14 @@ registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 To switch back to the previous branch before we switched to mytopic
-(i.e. "master" branch):
+(i.e. `master` branch):
 
 ------------
 $ git switch -
 ------------
 
 You can grow a new branch from any commit. For example, switch to
-"HEAD~3" and create branch "fixup":
+`HEAD~3` and create branch `fixup`:
 
 ------------
 $ git switch -c fixup HEAD~3
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index ef68ad2b71..2cbec2d033 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -39,7 +39,7 @@ OPTIONS
 -q::
 --quiet::
 	Do not issue an error message if the <name> is not a
-	symbolic ref but a detached HEAD; instead exit with
+	symbolic ref but a detached `HEAD`; instead exit with
 	non-zero status silently.
 
 --short::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index b802972bb2..13a0d2abbb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -209,7 +209,7 @@ This option is only applicable when listing tags without annotation lines.
 <commit>::
 <object>::
 	The object that the new tag will refer to, usually a commit.
-	Defaults to HEAD.
+	Defaults to `HEAD`.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 3c3da97c29..be48daa825 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -20,7 +20,7 @@ Given three arguments, stores the <newvalue> in the <ref>,
 possibly dereferencing the symbolic refs, after verifying that
 the current value of the <ref> matches <oldvalue>.
 E.g. `git update-ref refs/heads/master <newvalue> <oldvalue>`
-updates the master branch head to <newvalue> only if its current
+updates the `master` branch head to <newvalue> only if its current
 value is <oldvalue>.  You can specify 40 "0" or an empty string
 as <oldvalue> to make sure that the ref you are creating does
 not exist.
@@ -151,7 +151,7 @@ LOGGING UPDATES
 ---------------
 If config parameter "core.logAllRefUpdates" is true and the ref is one
 under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
-like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
+like `HEAD` or `ORIG_HEAD`; or the file "$GIT_DIR/logs/<ref>" exists then
 `git update-ref` will append a line to the log file
 "$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
 the log name) describing the change in ref value.  Log lines are
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index f1bb1fa5f5..35bb1bb120 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -97,7 +97,7 @@ list::
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, the
-branch currently checked out (or "detached HEAD" if none), "locked" if
+branch currently checked out (or "detached `HEAD`" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by `prune`
 command.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index fc49a4fd42..dcc52adff6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -516,7 +516,7 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_COMMON_DIR`::
 	If this variable is set to a path, non-worktree files that are
 	normally in $GIT_DIR will be taken from this path
-	instead. Worktree-specific files such as HEAD or index are
+	instead. Worktree-specific files such as `HEAD` or index are
 	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
 	linkgit:git-worktree[1] for
 	details. This variable has lower precedence than other path
@@ -914,7 +914,7 @@ standard output.
 `GIT_PRINT_SHA1_ELLIPSIS` (deprecated)::
 	If set to `yes`, print an ellipsis following an
 	(abbreviated) SHA-1 value.  This affects indications of
-	detached HEADs (linkgit:git-checkout[1]) and the raw
+	detached `HEAD`s (linkgit:git-checkout[1]) and the raw
 	diff output (linkgit:git-diff[1]).  Printing an
 	ellipsis in the cases mentioned is no longer considered
 	adequate and support for it is likely to be removed in the
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 92e4ba6a2f..0fb18e3f35 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -29,7 +29,7 @@ arguments.  Here are the rules:
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
    and what I have in the work tree for that file", not "show difference
-   between the HEAD commit and the work tree as a whole".  You can say
+   between the `HEAD` commit and the work tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.
 
  * Without disambiguating `--`, Git makes a reasonable guess, but errors
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 633439702f..77573c813c 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -330,7 +330,7 @@ object name for the commit to its standard output.
 
 And this is where we create the `.git/refs/heads/master` file
 which is pointed at by `HEAD`. This file is supposed to contain
-the reference to the top-of-tree of the master branch, and since
+the reference to the top-of-tree of the `master` branch, and since
 that's exactly what 'git commit-tree' spits out, we can do this
 all with a sequence of simple shell commands:
 
@@ -402,7 +402,7 @@ In other words, 'git diff-index' normally compares a tree against the
 working tree, but when given the `--cached` flag, it is told to
 instead compare against just the index cache contents, and ignore the
 current working tree state entirely. Since we just wrote the index
-file to HEAD, doing `git diff-index --cached -p HEAD` should thus return
+file to `HEAD`, doing `git diff-index --cached -p HEAD` should thus return
 an empty set of differences, and that's exactly what it does.
 
 [NOTE]
@@ -446,7 +446,7 @@ flag or not, since now the index is coherent with the working tree.
 Now, since we've updated `hello` in the index, we can commit the new
 version. We could do it by writing the tree by hand again, and
 committing the tree (this time we'd have to use the `-p HEAD` flag to
-tell commit that the HEAD was the *parent* of the new commit, and that
+tell commit that the `HEAD` was the *parent* of the new commit, and that
 this wasn't an initial commit any more), but you've done that once
 already, so let's just use the helpful script this time:
 
@@ -822,7 +822,7 @@ commit log message from the command line.
 
 Now, to make it a bit more interesting, let's assume that somebody else
 does some work in the original branch, and simulate that by going back
-to the master branch, and editing the same file differently there:
+to the `master` branch, and editing the same file differently there:
 
 ------------
 $ git switch master
@@ -838,7 +838,7 @@ $ echo "Lots of fun" >>example
 $ git commit -m "Some fun." -i hello example
 ------------
 
-since the master branch is obviously in a much better mood.
+since the `master` branch is obviously in a much better mood.
 
 Now, you've got two branches, and you decide that you want to merge the
 work done. Before we do that, let's introduce a cool graphical tool that
@@ -933,21 +933,21 @@ shows an ordinary commit on the current branch, `-` is a merge commit), which
 means they are now part of the `master` branch. Only the "Some
 work" commit has the plus `+` character in the second column,
 because `mybranch` has not been merged to incorporate these
-commits from the master branch.  The string inside brackets
+commits from the `master` branch.  The string inside brackets
 before the commit log message is a short name you can use to
-name the commit.  In the above example, 'master' and 'mybranch'
-are branch heads.  'master^' is the first parent of 'master'
+name the commit.  In the above example, `master` and `mybranch`
+are branch heads.  `master^` is the first parent of `master`
 branch head.  Please see linkgit:gitrevisions[7] if you want to
 see more complex cases.
 
 [NOTE]
 Without the `--more=1` option, 'git show-branch' would not output the
 '[master^]' commit, as '[mybranch]' commit is a common ancestor of
-both 'master' and 'mybranch' tips.  Please see linkgit:git-show-branch[1]
+both `master` and `mybranch` tips.  Please see linkgit:git-show-branch[1]
 for details.
 
 [NOTE]
-If there were more commits on the 'master' branch after the merge, the
+If there were more commits on the `master` branch after the merge, the
 merge commit itself would not be shown by 'git show-branch' by
 default.  You would need to provide `--sparse` option to make the
 merge commit visible in this case.
@@ -1523,7 +1523,7 @@ like this:
    the initial cloning is stored in the remote.origin.url
    configuration variable.
 
-2. Do your work in your repository on 'master' branch.
+2. Do your work in your repository on `master` branch.
 
 3. Run `git fetch origin` from the public repository of your
    upstream every once in a while. This does only the first
@@ -1559,9 +1559,9 @@ using branches with Git.
 We have already seen how branches work previously,
 with "fun and work" example using two branches.  The idea is the
 same if there are more than two branches.  Let's say you started
-out from "master" head, and have some new code in the "master"
-branch, and two independent fixes in the "commit-fix" and
-"diff-fix" branches:
+out from `master` head, and have some new code in the `master`
+branch, and two independent fixes in the `commit-fix` and
+`diff-fix` branches:
 
 ------------
 $ git show-branch
@@ -1577,8 +1577,8 @@ $ git show-branch
 ------------
 
 Both fixes are tested well, and at this point, you want to merge
-in both of them.  You could merge in 'diff-fix' first and then
-'commit-fix' next, like this:
+in both of them.  You could merge in `diff-fix` first and then
+`commit-fix` next, like this:
 
 ------------
 $ git merge -m "Merge fix in diff-fix" diff-fix
@@ -1607,8 +1607,8 @@ first and the other next, when what you have are a set of truly
 independent changes (if the order mattered, then they are not
 independent by definition).  You could instead merge those two
 branches into the current branch at once.  First let's undo what
-we just did and start over.  We would want to get the master
-branch before these two merges by resetting it to 'master~2':
+we just did and start over.  We would want to get the `master`
+branch before these two merges by resetting it to `master~2`:
 
 ------------
 $ git reset --hard master~2
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index faba2ef088..03c9e5e8d5 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -104,8 +104,8 @@ modification will be caught if you do `git commit -a` later.
 <6> look at all your changes including the previous commit.
 <7> amend the previous commit, adding all your new changes,
 using your original message.
-<8> switch to the master branch.
-<9> merge a topic branch into your master branch.
+<8> switch to the `master` branch.
+<9> merge a topic branch into your `master` branch.
 <10> review commit logs; other forms to limit output can be
 combined and include `-10` (to show up to 10 commits),
 `--until=2005-12-10`, etc.
@@ -123,7 +123,7 @@ addition to the ones needed by a standalone developer.
   * linkgit:git-clone[1] from the upstream to prime your local
     repository.
 
-  * linkgit:git-pull[1] and linkgit:git-fetch[1] from "origin"
+  * linkgit:git-pull[1] and linkgit:git-fetch[1] from `origin`
     to keep up-to-date with the upstream.
 
   * linkgit:git-push[1] to shared repository, if you adopt CVS
@@ -160,9 +160,9 @@ $ git reset --hard ORIG_HEAD <10>
 $ git gc <11>
 ------------
 +
-<1> checkout a new branch `mine` from master.
+<1> checkout a new branch `mine` from `master`.
 <2> repeat as needed.
-<3> extract patches from your branch, relative to master,
+<3> extract patches from your branch, relative to `master`,
 <4> and email them.
 <5> return to `master`, ready to see what's new
 <6> `git pull` fetches from `origin` by default and merges into the
@@ -210,7 +210,7 @@ remote-tracking branches on the mothership machine.  You could use this
 as a back-up method. Likewise, you can pretend that mothership
 "fetched" from you (useful when access is one sided).
 <5> on mothership machine, merge the work done on the satellite
-machine into the master branch.
+machine into the `master` branch.
 
 Branch off of a specific tag.::
 +
@@ -305,7 +305,7 @@ master or exposed as a part of a stable branch.
 <8> and bundle topic branches still cooking.
 <9> backport a critical fix.
 <10> create a signed tag.
-<11> make sure master was not accidentally rewound beyond that
+<11> make sure `master` was not accidentally rewound beyond that
 already pushed out.
 <12> In the output from `git show-branch`, `master` should have
 everything `ko/master` has, and `next` should have
@@ -446,7 +446,7 @@ refs/tags/v[0-9]*	david
 <2> and make the shared repository writable by the group.
 <3> use update-hook example by Carl from Documentation/howto/
 for branch policy control.
-<4> alice and cindy can push into master, only bob can push into doc-update.
+<4> alice and cindy can push into `master`, only bob can push into `doc-update`.
 david is the release manager and is the only person who can
 create and push version tags.
 
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b51959ff94..5e87987882 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -189,8 +189,8 @@ post-checkout
 
 This hook is invoked when a linkgit:git-checkout[1] or
 linkgit:git-switch[1] is run after having updated the
-worktree.  The hook is given three parameters: the ref of the previous HEAD,
-the ref of the new HEAD (which may or may not have changed), and a flag
+worktree.  The hook is given three parameters: the ref of the previous `HEAD`,
+the ref of the new `HEAD` (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
 This hook cannot affect the outcome of `git switch` or `git checkout`,
@@ -199,11 +199,11 @@ these two commands.
 
 It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the
-ref of the new HEAD and the flag is always 1. Likewise for `git worktree add`
+ref of the new `HEAD` and the flag is always 1. Likewise for `git worktree add`
 unless `--no-checkout` is used.
 
 This hook can be used to perform repository validity checks, auto-display
-differences from the previous HEAD if different, or set working dir metadata
+differences from the previous `HEAD` if different, or set working dir metadata
 properties.
 
 post-merge
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6ceeae227c..29bd307bb9 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -64,7 +64,7 @@ linkgit:git-rev-list[1] for a complete list.
 --merge::
 
 	After an attempt to merge stops with conflicts, show the commits on
-	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
+	the history between two branches (i.e. the `HEAD` and the `MERGE_HEAD`)
 	that modify the conflicted files and do not exist on all the heads
 	being merged.
 
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index b614969ad2..29bac9e1bf 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 -----------
 
 Git supports dividing the refs of a single repository into multiple
-namespaces, each of which has its own branches, tags, and HEAD.  Git can
+namespaces, each of which has its own branches, tags, and `HEAD`.  Git can
 expose each namespace as an independent repository to pull from and push
 to, while sharing the object store, and exposing all the refs to
 operations such as linkgit:git-gc[1].
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 6f1e269ae4..f5ac7ae7ca 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -322,9 +322,9 @@ Supported if the helper has the "fetch" capability.
 	(if there is only one reference to push, a single 'push' command
 	is followed by a blank line). For example, the following would
 	be two batches of 'push', the first asking the remote-helper
-	to push the local ref 'master' to the remote ref 'master' and
-	the local `HEAD` to the remote 'branch', and the second
-	asking to push ref 'foo' to ref 'bar' (forced update requested
+	to push the local ref `master` to the remote ref `master` and
+	the local `HEAD` to the remote `branch`, and the second
+	asking to push ref `foo` to ref `bar` (forced update requested
 	by the '+').
 +
 ------------
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index 1a2ef4c150..e174a28360 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -128,7 +128,7 @@ HEAD::
 	describing the currently active branch.  It does not mean
 	much if the repository is not associated with any working tree
 	(i.e. a 'bare' repository), but a valid Git repository
-	*must* have the HEAD file; some porcelains may use it to
+	*must* have the `HEAD` file; some porcelains may use it to
 	guess the designated "default" branch of the repository
 	(usually 'master').  It is legal if the named branch
 	'name' does not (yet) exist.  In some legacy setups, it is
@@ -137,7 +137,7 @@ HEAD::
 +
 HEAD can also record a specific commit directly, instead of
 being a symref to point at the current branch.  Such a state
-is often called 'detached HEAD.'  See linkgit:git-checkout[1]
+is often called 'detached `HEAD`.'  See linkgit:git-checkout[1]
 for details.
 
 config::
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index e1e09070ad..2b3cba8ae3 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -132,7 +132,7 @@ and the contents of these files is just the compressed data plus a
 header identifying their length and their type.  The type is either a
 blob, a tree, a commit, or a tag.
 
-The simplest commit to find is the HEAD commit, which we can find
+The simplest commit to find is the `HEAD` commit, which we can find
 from .git/HEAD:
 
 ------------------------------------------------
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index ff366cc752..089a89f776 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -182,7 +182,7 @@ Managing branches
 -----------------
 
 A single Git repository can maintain multiple branches of
-development.  To create a new branch named "experimental", use
+development.  To create a new branch named `experimental`, use
 
 ------------------------------------------------
 $ git branch experimental
@@ -201,8 +201,8 @@ you'll get a list of all existing branches:
 * master
 ------------------------------------------------
 
-The "experimental" branch is the one you just created, and the
-"master" branch is a default branch that was created for you
+The `experimental` branch is the one you just created, and the
+`master` branch is a default branch that was created for you
 automatically.  The asterisk marks the branch you are currently on;
 type
 
@@ -211,7 +211,7 @@ $ git switch experimental
 ------------------------------------------------
 
 to switch to the experimental branch.  Now edit a file, commit the
-change, and switch back to the master branch:
+change, and switch back to the `master` branch:
 
 ------------------------------------------------
 (edit file)
@@ -220,9 +220,9 @@ $ git switch master
 ------------------------------------------------
 
 Check that the change you made is no longer visible, since it was
-made on the experimental branch and you're back on the master branch.
+made on the experimental branch and you're back on the `master` branch.
 
-You can make a different change on the master branch:
+You can make a different change on the `master` branch:
 
 ------------------------------------------------
 (edit file)
@@ -230,7 +230,7 @@ $ git commit -a
 ------------------------------------------------
 
 at this point the two branches have diverged, with different changes
-made in each.  To merge the changes made in experimental into master, run
+made in each.  To merge the changes made in `experimental` into `master`, run
 
 ------------------------------------------------
 $ git merge experimental
@@ -310,7 +310,7 @@ alice$ cd /home/alice/project
 alice$ git pull /home/bob/myrepo master
 ------------------------------------------------
 
-This merges the changes from Bob's "master" branch into Alice's
+This merges the changes from Bob's `master` branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.
 
@@ -327,7 +327,7 @@ some way and pull again when this happens).
 
 Alice can peek at what Bob did without merging first, using the "fetch"
 command; this allows Alice to inspect what Bob did, using a special
-symbol "FETCH_HEAD", in order to determine if he has anything worth
+symbol `FETCH_HEAD`, in order to determine if he has anything worth
 pulling, like this:
 
 ------------------------------------------------
@@ -336,10 +336,10 @@ alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------
 
 This operation is safe even if Alice has uncommitted local changes.
-The range notation "HEAD..FETCH_HEAD" means "show everything that is reachable
-from the FETCH_HEAD but exclude anything that is reachable from HEAD".
-Alice already knows everything that leads to her current state (HEAD),
-and reviews what Bob has in his state (FETCH_HEAD) that she has not
+The range notation "`HEAD`..`FETCH_HEAD`" means "show everything that is reachable
+from the `FETCH_HEAD` but exclude anything that is reachable from `HEAD`".
+Alice already knows everything that leads to her current state (`HEAD`),
+and reviews what Bob has in his state (`FETCH_HEAD`) that she has not
 seen with this command.
 
 If Alice wants to visualize what Bob did since their histories forked
@@ -397,10 +397,10 @@ alice$ git log -p master..bob/master
 -------------------------------------
 
 shows a list of all the changes that Bob made since he branched from
-Alice's master branch.
+Alice's `master` branch.
 
 After examining those changes, Alice
-could merge the changes into her master branch:
+could merge the changes into her `master` branch:
 
 -------------------------------------
 alice$ git merge bob/master
@@ -436,8 +436,8 @@ bob$ git config --get remote.origin.url
 `git config -l`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
-Git also keeps a pristine copy of Alice's master branch under the
-name "origin/master":
+Git also keeps a pristine copy of Alice's `master` branch under the
+name `origin/master`:
 
 -------------------------------------
 bob$ git branch -r
@@ -570,22 +570,22 @@ $ git log v2.5.. Makefile       # commits since v2.5 which modify
 
 You can also give 'git log' a "range" of commits where the first is not
 necessarily an ancestor of the second; for example, if the tips of
-the branches "stable" and "master" diverged from a common
+the branches `stable` and `master` diverged from a common
 commit some time ago, then
 
 -------------------------------------
 $ git log stable..master
 -------------------------------------
 
-will list commits made in the master branch but not in the
-stable branch, while
+will list commits made in the `master` branch but not in the
+`stable` branch, while
 
 -------------------------------------
 $ git log master..stable
 -------------------------------------
 
-will show the list of commits made on the stable branch but not
-the master branch.
+will show the list of commits made on the `stable` branch but not
+the `master` branch.
 
 The 'git log' command has a weakness: it must present commits in a
 list.  When the history has lines of development that diverged and
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 3cc9b034c4..ee6e6a30fd 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -291,7 +291,7 @@ action::
 	is not set, and to 'summary' otherwise.
 
 revision::
-	Revision shown.  Defaults to HEAD.
+	Revision shown.  Defaults to `HEAD`.
 
 path::
 	The path within the <repository> that the action is performed on,
@@ -385,7 +385,7 @@ The 'shortlog' view is more compact; it shows one commit per line.
 
 history::
 	Shows history of the file or directory in a given repository path,
-	starting from given revision (defaults to HEAD, i.e. default branch).
+	starting from given revision (defaults to `HEAD`, i.e. default branch).
 +
 This view is similar to 'shortlog' view.
 
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 47cf97f9be..07344bf85a 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -75,25 +75,25 @@ As a given feature goes from experimental to stable, it also
 "graduates" between the corresponding branches of the software.
 `git.git` uses the following 'integration branches':
 
-* 'maint' tracks the commits that should go into the next "maintenance
+* `maint` tracks the commits that should go into the next "maintenance
   release", i.e., update of the last released stable version;
 
-* 'master' tracks the commits that should go into the next release;
+* `master` tracks the commits that should go into the next release;
 
-* 'next' is intended as a testing branch for topics being tested for
-  stability for master.
+* `next` is intended as a testing branch for topics being tested for
+  stability for `master`.
 
 There is a fourth official branch that is used slightly differently:
 
-* 'seen' (patches seen by the maintainer) is an integration branch for
+* `seen` (patches seen by the maintainer) is an integration branch for
   things that are not quite ready for inclusion yet (see "Integration
   Branches" below).
 
 Each of the four branches is usually a direct descendant of the one
 above it.
 
-Conceptually, the feature enters at an unstable branch (usually 'next'
-or 'seen'), and "graduates" to 'master' for the next release once it is
+Conceptually, the feature enters at an unstable branch (usually `next`
+or `seen`), and "graduates" to `master` for the next release once it is
 considered stable enough.
 
 
@@ -113,7 +113,7 @@ other.
 =====================================
 
 This gives a very controlled flow of fixes.  If you notice that you
-have applied a fix to e.g. 'master' that is also required in 'maint',
+have applied a fix to e.g. `master` that is also required in `maint`,
 you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
 downwards.  This will happen a few times and is nothing to worry about
 unless you do it very frequently.
@@ -149,11 +149,11 @@ Many things can then be done very naturally:
   it.  If the topic has evolved further in the meantime, merge again.
   (Note that you do not necessarily have to merge it to the oldest
   integration branch first.  For example, you can first merge a bugfix
-  to 'next', give it some testing time, and merge to 'maint' when you
+  to `next`, give it some testing time, and merge to `maint` when you
   know it is stable.)
 
-* If you find you need new features from the branch 'other' to continue
-  working on your topic, merge 'other' to 'topic'.  (However, do not
+* If you find you need new features from the branch `other` to continue
+  working on your topic, merge `other` to `topic`.  (However, do not
   do this "just habitually", see below.)
 
 * If you find you forked off the wrong branch and want to move it
@@ -207,7 +207,7 @@ If you make it (very) clear that this branch is going to be deleted
 right after the testing, you can even publish this branch, for example
 to give the testers a chance to work with it, or other developers a
 chance to see if their in-progress work will be compatible.  `git.git`
-has such an official throw-away integration branch called 'seen'.
+has such an official throw-away integration branch called `seen`.
 
 
 Branch management for a release
@@ -217,27 +217,27 @@ Assuming you are using the merge approach discussed above, when you
 are releasing your project you will need to do some additional branch
 management work.
 
-A feature release is created from the 'master' branch, since 'master'
+A feature release is created from the `master` branch, since `master`
 tracks the commits that should go into the next feature release.
 
-The 'master' branch is supposed to be a superset of 'maint'. If this
-condition does not hold, then 'maint' contains some commits that
-are not included on 'master'. The fixes represented by those commits
+The `master` branch is supposed to be a superset of `maint`. If this
+condition does not hold, then `maint` contains some commits that
+are not included on `master`. The fixes represented by those commits
 will therefore not be included in your feature release.
 
-To verify that 'master' is indeed a superset of 'maint', use git log:
+To verify that `master` is indeed a superset of `maint`, use git log:
 
-.Verify 'master' is a superset of 'maint'
+.Verify `master` is a superset of `maint`
 [caption="Recipe: "]
 =====================================
 `git log master..maint`
 =====================================
 
 This command should not list any commits.  Otherwise, check out
-'master' and merge 'maint' into it.
+`master` and merge `maint` into it.
 
 Now you can proceed with the creation of the feature release. Apply a
-tag to the tip of 'master' indicating the release version:
+tag to the tip of `master` indicating the release version:
 
 .Release tagging
 [caption="Recipe: "]
@@ -251,9 +251,9 @@ others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
 release tarballs and preformatted documentation pages.
 
-Similarly, for a maintenance release, 'maint' is tracking the commits
+Similarly, for a maintenance release, `maint` is tracking the commits
 to be released. Therefore, in the steps above simply tag and push
-'maint' rather than 'master'.
+`maint` rather than `master`.
 
 
 Maintenance branch management after a feature release
@@ -275,10 +275,10 @@ where X.Y.Z is the current release).
 `git branch maint-X.Y.(Z-1) maint`
 =====================================
 
-The 'maint' branch should now be fast-forwarded to the newly released
+The `maint` branch should now be fast-forwarded to the newly released
 code so that maintenance fixes can be tracked for the current release:
 
-.Update maint to new release
+.Update `maint` to new release
 [caption="Recipe: "]
 =====================================
 * `git checkout maint`
@@ -286,7 +286,7 @@ code so that maintenance fixes can be tracked for the current release:
 =====================================
 
 If the merge fails because it is not a fast-forward, then it is
-possible some fixes on 'maint' were missed in the feature release.
+possible some fixes on `maint` were missed in the feature release.
 This will not happen if the content of the branches was verified as
 described in the previous section.
 
@@ -294,9 +294,9 @@ described in the previous section.
 Branch management for next and seen after a feature release
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-After a feature release, the integration branch 'next' may optionally be
-rewound and rebuilt from the tip of 'master' using the surviving
-topics on 'next':
+After a feature release, the integration branch `next` may optionally be
+rewound and rebuilt from the tip of `master` using the surviving
+topics on `next`:
 
 .Rewind and rebuild next
 [caption="Recipe: "]
@@ -307,20 +307,20 @@ topics on 'next':
 * ...
 =====================================
 
-The advantage of doing this is that the history of 'next' will be
-clean. For example, some topics merged into 'next' may have initially
+The advantage of doing this is that the history of `next` will be
+clean. For example, some topics merged into `next` may have initially
 looked promising, but were later found to be undesirable or premature.
-In such a case, the topic is reverted out of 'next' but the fact
+In such a case, the topic is reverted out of `next` but the fact
 remains in the history that it was once merged and reverted. By
-recreating 'next', you give another incarnation of such topics a clean
+recreating `next`, you give another incarnation of such topics a clean
 slate to retry, and a feature release is a good point in history to do
 so.
 
 If you do this, then you should make a public announcement indicating
-that 'next' was rewound and rebuilt.
+that `next` was rewound and rebuilt.
 
-The same rewind and rebuild process may be followed for 'seen'. A public
-announcement is not necessary since 'seen' is a throw-away branch, as
+The same rewind and rebuild process may be followed for `seen`. A public
+announcement is not necessary since `seen` is a throw-away branch, as
 described above.
 
 
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 67c7a50b96..88ee109fdf 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -113,16 +113,16 @@ to point at the new commit.
 [[def_detached_HEAD]]detached HEAD::
 	Normally the <<def_HEAD,HEAD>> stores the name of a
 	<<def_branch,branch>>, and commands that operate on the
-	history HEAD represents operate on the history leading to the
-	tip of the branch the HEAD points at.  However, Git also
+	history `HEAD` represents operate on the history leading to the
+	tip of the branch the `HEAD` points at.  However, Git also
 	allows you to <<def_checkout,check out>> an arbitrary
 	<<def_commit,commit>> that isn't necessarily the tip of any
-	particular branch.  The HEAD in such a state is called
+	particular branch.  The `HEAD` in such a state is called
 	"detached".
 +
 Note that commands that operate on the history of the current branch
 (e.g. `git commit` to build a new history on top of it) still work
-while the HEAD is detached. They update the HEAD to point at the tip
+while the `HEAD` is detached. They update the `HEAD` to point at the tip
 of the updated history without affecting any branch.  Commands that
 update or inquire information _about_ the current branch (e.g. `git
 branch --set-upstream-to` that sets what remote-tracking branch the
@@ -193,7 +193,7 @@ for a more flexible and robust system to do the same thing.
 [[def_HEAD]]HEAD::
 	The current <<def_branch,branch>>.  In more detail: Your <<def_working_tree,
 	working tree>> is normally derived from the state of the tree
-	referred to by HEAD.  HEAD is a reference to one of the
+	referred to by `HEAD`.  `HEAD` is a reference to one of the
 	<<def_head,heads>> in your repository, except when using a
 	<<def_detached_HEAD,detached HEAD>>, in which case it directly
 	references an arbitrary commit.
@@ -456,7 +456,7 @@ exclude;;
 	like refs for the purposes of rev-parse, but which are treated
 	specially by git.  Pseudorefs both have names that are all-caps,
 	and always start with a line consisting of a
-	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
+	<<def_SHA1,SHA-1>> followed by whitespace.  So, `HEAD` is not a
 	pseudoref, because it is sometimes a symbolic ref.  They might
 	optionally contain some additional data.  `MERGE_HEAD` and
 	`CHERRY_PICK_HEAD` are examples.  Unlike
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 965cb32f9c..e6e9669f68 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -252,7 +252,7 @@ to list all commits on only one side of them is with
 `--left-right` (see the example below in the description of
 the `--left-right` option). However, it shows the commits that were
 cherry-picked from the other branch (for example, ``3rd on b'' may be
-cherry-picked from branch A). With this option, such pairs of commits are
+cherry-picked from branch `A`). With this option, such pairs of commits are
 excluded from the output.
 
 --left-only::
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d9169c062e..33f30b62eb 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -23,8 +23,8 @@ characters and to avoid word splitting.
   followed by a dash and a number of commits, followed by a dash, a
   'g', and an abbreviated object name.
 
-'<refname>', e.g. 'master', 'heads/master', 'refs/heads/master'::
-  A symbolic ref name.  E.g. 'master' typically means the commit
+'<refname>', e.g. `master`, 'heads/master', 'refs/heads/master'::
+  A symbolic ref name.  E.g. `master` typically means the commit
   object referenced by 'refs/heads/master'.  If you
   happen to have both 'heads/master' and 'tags/master', you can
   explicitly say 'heads/master' to tell Git which one you mean.
@@ -65,7 +65,7 @@ some output processing may assume ref names in UTF-8.
 '@'::
   '@' alone is a shortcut for `HEAD`.
 
-'[<refname>]@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
+'[<refname>]@{<date>}', e.g. `master@{yesterday}`, `HEAD@{5 minutes ago}`::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '{1 month 2 weeks 3 days 1 hour 1
@@ -74,28 +74,28 @@ some output processing may assume ref names in UTF-8.
   used immediately following a ref name and the ref must have an
   existing log ('$GIT_DIR/logs/<ref>'). Note that this looks up the state
   of your *local* ref at a given time; e.g., what was in your local
-  'master' branch last week. If you want to look at commits made during
+  `master` branch last week. If you want to look at commits made during
   certain times, see `--since` and `--until`.
 
-'<refname>@{<n>}', e.g. 'master@\{1\}'::
+'<refname>@{<n>}', e.g. `master@{1}`::
   A ref followed by the suffix '@' with an ordinal specification
   enclosed in a brace pair (e.g. '\{1\}', '\{15\}') specifies
-  the n-th prior value of that ref.  For example 'master@\{1\}'
-  is the immediate prior value of 'master' while 'master@\{5\}'
-  is the 5th prior value of 'master'. This suffix may only be used
+  the n-th prior value of that ref.  For example `master@{1}`
+  is the immediate prior value of `master` while `master@{5}`
+  is the 5th prior value of `master`. This suffix may only be used
   immediately following a ref name and the ref must have an existing
   log ('$GIT_DIR/logs/<refname>').
 
 '@{<n>}', e.g. '@\{1\}'::
   You can use the '@' construct with an empty ref part to get at a
   reflog entry of the current branch. For example, if you are on
-  branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
+  branch `blabla` then `@{1}` means the same as `blabla@{1}`.
 
 '@{-<n>}', e.g. '@{-1}'::
   The construct '@{-<n>}' means the <n>th branch/commit checked out
   before the current one.
 
-'[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
+'[<branchname>]@\{upstream\}', e.g. `master@{upstream}`, '@\{u\}'::
   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
   refers to the branch that the branch specified by branchname is set to build on
   top of (configured with `branch.<name>.remote` and
@@ -103,7 +103,7 @@ some output processing may assume ref names in UTF-8.
   current one. These suffixes are also accepted when spelled in uppercase, and
   they mean the same thing no matter the case.
 
-'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+'[<branchname>]@\{push\}', e.g. `master@{push}`, '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Since our push destination is
@@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
-'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+'<rev>{caret}[<n>]', e.g. `HEAD^`, 'v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'
@@ -139,7 +139,7 @@ thing no matter the case.
   '<rev>{caret}0' means the commit itself and is used when '<rev>' is the
   object name of a tag object that refers to a commit object.
 
-'<rev>{tilde}[<n>]', e.g. 'HEAD{tilde}, master{tilde}3'::
+'<rev>{tilde}[<n>]', e.g. `HEAD~`, `master~3`::
   A suffix '{tilde}' to a revision parameter means the first parent of
   that commit object.
   A suffix '{tilde}<n>' to a revision parameter means the commit
@@ -175,7 +175,7 @@ existing tag object.
   and dereference the tag recursively until a non-tag object is
   found.
 
-'<rev>{caret}{/<text>}', e.g. 'HEAD^{/fix nasty bug}'::
+'<rev>{caret}{/<text>}', e.g. `HEAD^{/fix nasty bug}`::
   A suffix '{caret}' to a revision parameter, followed by a brace
   pair that contains a text led by a slash,
   is the same as the ':/fix nasty bug' syntax below except that
@@ -186,7 +186,7 @@ existing tag object.
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
-  reachable from any ref, including HEAD.
+  reachable from any ref, including `HEAD`.
   The regular expression can match any part of the
   commit message. To match messages starting with a string, one can use
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
@@ -196,7 +196,7 @@ existing tag object.
   Depending on the given text, the shell's word splitting rules might
   require additional quoting.
 
-'<rev>:<path>', e.g. 'HEAD:README', 'master:./README'::
+'<rev>:<path>', e.g. `HEAD:README`, `master:./README`::
   A suffix ':' followed by a path names the blob or tree
   at the given path in the tree-ish object named by the part
   before the colon.
@@ -287,12 +287,12 @@ The '...' (three-dot) Symmetric Difference Notation::
  It is the set of commits that are reachable from either one of
  'r1' (left side) or 'r2' (right side) but not from both.
 
-In these two shorthand notations, you can omit one end and let it default to HEAD.
-For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
-did I do since I forked from the origin branch?"  Similarly, '..origin'
-is a shorthand for 'HEAD..origin' and asks "What did the origin do since
-I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
-empty range that is both reachable and unreachable from HEAD.
+In these two shorthand notations, you can omit one end and let it default to `HEAD`.
+For example, '`origin`..' is a shorthand for '`origin`..`HEAD`' and asks "What
+did I do since I forked from the `origin` branch?"  Similarly, '..`origin`'
+is a shorthand for '`HEAD`..`origin`' and asks "What did the `origin` do since
+I forked from them?"  Note that '..' would mean '`HEAD`..`HEAD`' which is an
+empty range that is both reachable and unreachable from `HEAD`.
 
 Other <rev>{caret} Parent Shorthand Notations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -313,7 +313,7 @@ itself).
 
 While '<rev>{caret}<n>' was about specifying a single commit parent, these
 three notations also consider its parents. For example you can say
-'HEAD{caret}2{caret}@', however you cannot say 'HEAD{caret}@{caret}2'.
+`HEAD^2^@`, however you cannot say `HEAD^@^2`.
 
 Revision Range Summary
 ----------------------
@@ -336,17 +336,17 @@ Revision Range Summary
 	<rev2> but exclude those that are reachable from both.  When
 	either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
 
-'<rev>{caret}@', e.g. 'HEAD{caret}@'::
+'<rev>{caret}@', e.g. `HEAD^@`::
   A suffix '{caret}' followed by an at sign is the same as listing
   all parents of '<rev>' (meaning, include anything reachable from
   its parents, but not the commit itself).
 
-'<rev>{caret}!', e.g. 'HEAD{caret}!'::
+'<rev>{caret}!', e.g. `HEAD^!`::
   A suffix '{caret}' followed by an exclamation mark is the same
   as giving commit '<rev>' and then all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).
 
-'<rev>{caret}-<n>', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
+'<rev>{caret}-<n>', e.g. `HEAD^-`, `HEAD^-2`::
 	Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
 	given.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0f9a699c09..62ddf41e75 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -280,7 +280,7 @@ a summary of the commands:
 	create a new branch `<new>` referencing `<start-point>`, and
 	check it out.
 
-The special symbol "HEAD" can always be used to refer to the current
+The special symbol `HEAD` can always be used to refer to the current
 branch.  In fact, Git uses a file named `HEAD` in the `.git` directory
 to remember which branch is current:
 
@@ -300,7 +300,7 @@ you can check out the commit referenced by a tag:
 $ git switch --detach v2.6.17
 Note: checking out 'v2.6.17'.
 
-You are in 'detached HEAD' state. You can look around, make experimental
+You are in 'detached `HEAD`' state. You can look around, make experimental
 changes and commit them, and you can discard any commits you make in this
 state without impacting any branches by performing another switch.
 
@@ -309,10 +309,10 @@ do so (now or later) by using `-c` with the switch command again. Example:
 
   git switch -c new_branch_name
 
-HEAD is now at 427abfa Linux v2.6.17
+`HEAD` is now at 427abfa Linux v2.6.17
 ------------------------------------------------
 
-The HEAD then refers to the SHA-1 of the commit instead of to a branch,
+The `HEAD` then refers to the SHA-1 of the commit instead of to a branch,
 and git branch shows that you are no longer on a branch:
 
 ------------------------------------------------
@@ -323,7 +323,7 @@ $ git branch
   master
 ------------------------------------------------
 
-In this case we say that the HEAD is "detached".
+In this case we say that the `HEAD` is "detached".
 
 This is an easy way to check out a particular version without having to
 make up a name for the new branch.   You can still create a new branch
@@ -332,8 +332,8 @@ make up a name for the new branch.   You can still create a new branch
 [[examining-remote-branches]]
 === Examining branches from a remote repository
 
-The "master" branch that was created at the time you cloned is a copy
-of the HEAD in the repository that you cloned from.  That repository
+The `master` branch that was created at the time you cloned is a copy
+of the `HEAD` in the repository that you cloned from.  That repository
 may also have had other branches, though, and your local repository
 keeps branches which track each of those remote branches, called
 remote-tracking branches, which you
@@ -351,7 +351,7 @@ $ git branch -r
   origin/todo
 ------------------------------------------------
 
-In this example, "origin" is called a remote repository, or "remote"
+In this example, `origin` is called a remote repository, or "remote"
 for short. The branches of this repository are called "remote
 branches" from our point of view. The remote-tracking branches listed
 above were created based on the remote branches at clone time and will
@@ -368,7 +368,7 @@ $ git switch -c my-todo-copy origin/todo
 You can also check out `origin/todo` directly to examine it or
 write a one-off patch.  See <<detached-head,detached head>>.
 
-Note that the name "origin" is just the name that Git uses by default
+Note that the name `origin` is just the name that Git uses by default
 to refer to the repository that you cloned from.
 
 [[how-git-stores-references]]
@@ -391,9 +391,9 @@ under the path given by their name.  However, for efficiency reasons
 they may also be packed together in a single file; see
 linkgit:git-pack-refs[1]).
 
-As another useful shortcut, the "HEAD" of a repository can be referred
-to just using the name of that repository.  So, for example, "origin"
-is usually a shortcut for the HEAD branch in the repository "origin".
+As another useful shortcut, the `HEAD` of a repository can be referred
+to just using the name of that repository.  So, for example, `origin`
+is usually a shortcut for the HEAD branch in the repository `origin`.
 
 For the complete list of paths which Git checks for references, and
 the order it uses to decide which to choose when there are multiple
@@ -491,9 +491,9 @@ Bisecting: 3537 revisions left to test after this
 -------------------------------------------------
 
 If you run `git branch` at this point, you'll see that Git has
-temporarily moved you in "(no branch)". HEAD is now detached from any
+temporarily moved you in "(no branch)". `HEAD` is now detached from any
 branch and points directly to a commit (with commit id 65934) that
-is reachable from "master" but not from v2.6.18. Compile and test it,
+is reachable from `master` but not from v2.6.18. Compile and test it,
 and see whether it crashes. Assume it does crash. Then:
 
 -------------------------------------------------
@@ -566,7 +566,7 @@ We have seen several ways of naming commits already:
 	- tag name: refers to the commit pointed to by the given tag
 	  (we've seen branches and tags are special cases of
 	  <<how-git-stores-references,references>>).
-	- HEAD: refers to the head of the current branch
+	- `HEAD`: refers to the head of the current branch
 
 There are many more; see the "SPECIFYING REVISIONS" section of the
 linkgit:gitrevisions[7] man page for the complete list of ways to
@@ -589,24 +589,24 @@ $ git show HEAD^1   # show the first parent of HEAD
 $ git show HEAD^2   # show the second parent of HEAD
 -------------------------------------------------
 
-In addition to HEAD, there are several other special names for
+In addition to `HEAD`, there are several other special names for
 commits:
 
 Merges (to be discussed later), as well as operations such as
 `git reset`, which change the currently checked-out commit, generally
-set ORIG_HEAD to the value HEAD had before the current operation.
+set `ORIG_HEAD` to the value `HEAD` had before the current operation.
 
 The `git fetch` operation always stores the head of the last fetched
-branch in FETCH_HEAD.  For example, if you run `git fetch` without
+branch in `FETCH_HEAD`.  For example, if you run `git fetch` without
 specifying a local branch as the target of the operation
 
 -------------------------------------------------
 $ git fetch git://example.com/proj.git theirbranch
 -------------------------------------------------
 
-the fetched commits will still be available from FETCH_HEAD.
+the fetched commits will still be available from `FETCH_HEAD`.
 
-When we discuss merges we'll also see the special name MERGE_HEAD,
+When we discuss merges we'll also see the special name `MERGE_HEAD`,
 which refers to the other branch that we're merging in to the current
 branch.
 
@@ -914,7 +914,7 @@ any version of a project; for example:
 $ git archive -o latest.tar.gz --prefix=project/ HEAD
 -------------------------------------------------
 
-will use HEAD to produce a gzipped tar archive in which each filename
+will use `HEAD` to produce a gzipped tar archive in which each filename
 is preceded by `project/`.  The output file format is inferred from
 the output file extension if possible, see linkgit:git-archive[1] for
 details.
@@ -1037,8 +1037,8 @@ at step 3, Git maintains a snapshot of the tree's contents in a
 special staging area called "the index."
 
 At the beginning, the content of the index will be identical to
-that of the HEAD.  The command `git diff --cached`, which shows
-the difference between the HEAD and the index, should therefore
+that of the `HEAD`.  The command `git diff --cached`, which shows
+the difference between the `HEAD` and the index, should therefore
 produce no output at that point.
 
 Modifying the index is easy:
@@ -1061,7 +1061,7 @@ After each step you can verify that
 $ git diff --cached
 -------------------------------------------------
 
-always shows the difference between the HEAD and the index file--this
+always shows the difference between the `HEAD` and the index file--this
 is what you'd commit if you created the commit now--and that
 
 -------------------------------------------------
@@ -1283,8 +1283,8 @@ index 802992c,2b60207..0000000
 
 Recall that the commit which will be committed after we resolve this
 conflict will have two parents instead of the usual one: one parent
-will be HEAD, the tip of the current branch; the other will be the
-tip of the other branch, which is stored temporarily in MERGE_HEAD.
+will be `HEAD`, the tip of the current branch; the other will be the
+tip of the other branch, which is stored temporarily in `MERGE_HEAD`.
 
 During the merge, the index holds three versions of each file.  Each of
 these three "file stages" represents a different version of the file:
@@ -1348,8 +1348,8 @@ $ git log --merge
 $ gitk --merge
 -------------------------------------------------
 
-These will display all commits which exist only on HEAD or on
-MERGE_HEAD, and which touch an unmerged file.
+These will display all commits which exist only on `HEAD` or on
+`MERGE_HEAD`, and which touch an unmerged file.
 
 You may also use linkgit:git-mergetool[1], which lets you merge the
 unmerged files using external tools such as Emacs or kdiff3.
@@ -1433,7 +1433,7 @@ commit; for example, to revert the most recent commit:
 $ git revert HEAD
 -------------------------------------------------
 
-This will create a new commit which undoes the change in HEAD.  You
+This will create a new commit which undoes the change in `HEAD`.  You
 will be given a chance to edit the commit message for the new commit.
 
 You can also revert an earlier change, for example, the next-to-last:
@@ -1486,7 +1486,7 @@ linkgit:git-restore[1]. The command
 $ git restore --source=HEAD^ path/to/file
 -------------------------------------------------
 
-replaces path/to/file by the contents it had in the commit HEAD^, and
+replaces path/to/file by the contents it had in the commit `HEAD^`, and
 also updates the index to match.  It does not change branches.
 
 If you just want to look at an old version of the file, without
@@ -1600,13 +1600,13 @@ $ gitk master@{"1 week ago"}	# ... or last week
 $ git log --walk-reflogs master	# show reflog entries for master
 -------------------------------------------------
 
-A separate reflog is kept for the HEAD, so
+A separate reflog is kept for the `HEAD`, so
 
 -------------------------------------------------
 $ git show HEAD@{"1 week ago"}
 -------------------------------------------------
 
-will show what HEAD pointed to one week ago, not what the current branch
+will show what `HEAD` pointed to one week ago, not what the current branch
 pointed to one week ago.  This allows you to see the history of what
 you've checked out.
 
@@ -1677,7 +1677,7 @@ into your own work.
 We have already seen <<Updating-a-repository-With-git-fetch,how to
 keep remote-tracking branches up to date>> with linkgit:git-fetch[1],
 and how to merge two branches.  So you can merge in changes from the
-original repository's master branch with:
+original repository's `master` branch with:
 
 -------------------------------------------------
 $ git fetch
@@ -1692,7 +1692,7 @@ $ git pull origin master
 -------------------------------------------------
 
 In fact, if you have `master` checked out, then this branch has been
-configured by `git clone` to get changes from the HEAD branch of the
+configured by `git clone` to get changes from the `HEAD` branch of the
 origin repository.  So often you can
 accomplish the above with just a simple
 
@@ -2568,7 +2568,7 @@ You can also edit a patch series with an interactive rebase.  This is
 the same as <<reordering-patch-series,reordering a patch series using
 `format-patch`>>, so use whichever interface you like best.
 
-Rebase your current HEAD on the last commit you want to retain as-is.
+Rebase your current `HEAD` on the last commit you want to retain as-is.
 For example, if you want to reorder the last 5 commits, use:
 
 -------------------------------------------------
@@ -2980,7 +2980,7 @@ file data at changing paths suggests a rename.  (See, for example, the
 `-M` option to linkgit:git-diff[1]).
 
 A commit is usually created by linkgit:git-commit[1], which creates a
-commit whose parent is normally the current HEAD, and whose tree is
+commit whose parent is normally the current `HEAD`, and whose tree is
 taken from the content currently stored in the index.
 
 [[tree-object]]
@@ -3507,7 +3507,7 @@ $ ls -a
 The `git submodule add <repo> <path>` command does a couple of things:
 
 - It clones the submodule from `<repo>` to the given `<path>` under the
-  current directory and by default checks out the master branch.
+  current directory and by default checks out the `master` branch.
 - It adds the submodule's clone path to the linkgit:gitmodules[5] file and
   adds this file to the index, ready to be committed.
 - It adds the submodule's current commit ID to the index, ready to be
@@ -3540,7 +3540,7 @@ $ git submodule status
 -------------------------------------------------
 
 NOTE: The commit object names shown above would be different for you, but they
-should match the HEAD commit object names of your repositories.  You can check
+should match the `HEAD` commit object names of your repositories.  You can check
 it by running `git ls-remote ../a`.
 
 Pulling down the submodules is a two-step process. First run `git submodule
@@ -4334,7 +4334,7 @@ $ git branch new		# create branch "new" starting at current HEAD
 $ git branch -d new		# delete branch "new"
 -----------------------------------------------
 
-Instead of basing a new branch on current HEAD (the default), use:
+Instead of basing a new branch on current `HEAD` (the default), use:
 
 -----------------------------------------------
 $ git branch new test    # branch named "test"
-- 
2.31.1.133.g84d06cdc06

