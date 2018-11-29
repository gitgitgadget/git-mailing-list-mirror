Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4297B211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeK3JG3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36370 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeK3JGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so3161711ljk.3
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdBHp/nTbWrYRZ0prozY7gej5mMZwainL1ZP3Gm3Tlg=;
        b=ECVaRG/egZr8vkbpWlTQqgP+P4htxttlB4Z0+Kfnxlc9orzvqYi7GJBCc4dfXwgVLk
         Wy7F1w2DiMDtk6XpOj5MasZI3lOboD78pvnNWrckWQBU9fhpxq+sEDlOsyCkQ+7+BmS4
         959KAf0zp48yvE8Bz4+X/xPvtAMBqgt7NeakYO/4Kd/CA5LgJJ9TdPYipsaRiKOc5DAU
         ifwrmHVSazvQbU0CymiJnXBiux9p/cleKMSUGAFVmyV0+OJUBXq2FNxlerH4KxnwHD6o
         POf5O59hWTcHUGiP2vOBvlwzn1Ll9nTDS+4oaXD4UBw3ILT/feGK3Hy8YLmOOOUD9qm7
         7XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdBHp/nTbWrYRZ0prozY7gej5mMZwainL1ZP3Gm3Tlg=;
        b=HnKQOXSqHGI7eLP7prdvYTY1WxtvTkOYo+/emao7R6SNzK3A05nF+lWi3+/sngzdIX
         JaGEX5UqSAXRJ8Do+QtFSsCXZigvY9wi6Gs6Q5QNpZuK5kcP5dJAyk2/Jt5uPtVdi3/x
         FWHUvsQ+4LS/na7BBYeAV7hsGXsSvxYc7k8hXBDxvxXzwM3YoQEVhflt/7tupYL+HTMg
         AQCslTrskevd+iyP1mTVM7nBv+kzBqfB0L1g3vQYajz+5wwtN5Rblhfc+0BH9quANeyg
         hnm1i7PQMJawypp45O2X3GaeFDMWINpW0/qTkfIR3dp7xGIF8GphTAkWCqDG4Vw3zUiH
         ahDw==
X-Gm-Message-State: AA+aEWbLJftEyjt8P0RbdRfxkRZzUbTMC1JhU6UuZU6RTTdHSnxl2yLx
        rnIjEcnfgd8hYxm71axpIYM=
X-Google-Smtp-Source: AFSGD/XWSU3AQUA4gUUEEJSir1xtVIvXbfjxkT5XSIwICZD98HNP5sEA2QMFWsh6TELSa6tZjQGFdQ==
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr1952231ljc.77.1543528760433;
        Thu, 29 Nov 2018 13:59:20 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:19 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
Date:   Thu, 29 Nov 2018 22:58:42 +0100
Message-Id: <20181129215850.7278-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" doing too many things is a source of confusion for many
users (and it even bites old timers sometimes). To rememdy that, the
command is now split in two: switch-branch and checkout-files. The
good old "git checkout" command is still here and will be until all
(or most of users) are sick of it.

See the new man pages for the final design of these commands. The
actual implementation though is still pretty much the same as "git
checkout". Following patches will adjust their behavior to match the
man pages.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore                          |   2 +
 Documentation/git-checkout.txt      |   5 +
 Documentation/git-restore-files.txt | 167 ++++++++++++++++
 Documentation/git-switch-branch.txt | 289 ++++++++++++++++++++++++++++
 Makefile                            |   2 +
 builtin.h                           |   2 +
 builtin/checkout.c                  |  84 ++++++--
 command-list.txt                    |   2 +
 git.c                               |   2 +
 9 files changed, 543 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/git-restore-files.txt
 create mode 100644 Documentation/git-switch-branch.txt

diff --git a/.gitignore b/.gitignore
index 0d77ea5894..c63dcb1427 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,7 @@
 /git-request-pull
 /git-rerere
 /git-reset
+/git-restore-files
 /git-rev-list
 /git-rev-parse
 /git-revert
@@ -167,6 +168,7 @@
 /git-submodule
 /git-submodule--helper
 /git-svn
+/git-switch-branch
 /git-symbolic-ref
 /git-tag
 /git-unpack-file
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 25887a6087..25ec7f508f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -406,6 +406,11 @@ $ edit frotz
 $ git add frotz
 ------------
 
+SEE ALSO
+--------
+linkgit:git-switch-branch[1]
+linkgit:git-restore-files[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-restore-files.txt b/Documentation/git-restore-files.txt
new file mode 100644
index 0000000000..03c1250ad0
--- /dev/null
+++ b/Documentation/git-restore-files.txt
@@ -0,0 +1,167 @@
+git-restore-files(1)
+====================
+
+NAME
+----
+git-restore-files - Restore working tree files
+
+SYNOPSIS
+--------
+[verse]
+'git restore-files' [-f|--ours|--theirs|-m|--conflict=<style>] [--from=<tree-ish>] <pathspec>...
+'git restore-files' [--from=<tree-ish>] <pathspec>...
+'git restore-files' (-p|--patch) [--from=<tree-ish>] [<pathspec>...]
+
+DESCRIPTION
+-----------
+Updates files in the working tree to match the version in the index
+or the specified tree.
+
+'git restore-files' [--from=<tree-ish>] <pathspec>...::
+
+	Overwrite paths in the working tree by replacing with the
+	contents in the index or in the <tree-ish> (most often a
+	commit).  When a <tree-ish> is given, the paths that
+	match the <pathspec> are updated both in the index and in
+	the working tree.
++
+The index may contain unmerged entries because of a previous failed merge.
+By default, if you try to check out such an entry from the index, the
+checkout operation will fail and nothing will be checked out.
+Using `-f` will ignore these unmerged entries.  The contents from a
+specific side of the merge can be checked out of the index by
+using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
+file can be discarded to re-create the original conflicted merge result.
+
+'git restore-files' (-p|--patch) [--from=<tree-ish>] [<pathspec>...]::
+	This is similar to the "check out paths to the working tree
+	from either the index or from a tree-ish" mode described
+	above, but lets you use the interactive interface to show
+	the "diff" output and choose which hunks to use in the
+	result.  See below for the description of `--patch` option.
+
+OPTIONS
+-------
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
+-f::
+--force::
+	Do not fail upon unmerged entries; instead, unmerged entries
+	are ignored.
+
+--ours::
+--theirs::
+	Check out stage #2 ('ours') or #3 ('theirs') for unmerged
+	paths.
++
+Note that during `git rebase` and `git pull --rebase`, 'ours' and
+'theirs' may appear swapped; `--ours` gives the version from the
+branch the changes are rebased onto, while `--theirs` gives the
+version from the branch that holds your work that is being rebased.
++
+This is because `rebase` is used in a workflow that treats the
+history at the remote as the shared canonical one, and treats the
+work done on the branch you are rebasing as the third-party work to
+be integrated, and you are temporarily assuming the role of the
+keeper of the canonical history during the rebase.  As the keeper of
+the canonical history, you need to view the history from the remote
+as `ours` (i.e. "our shared canonical history"), while what you did
+on your side branch as `theirs` (i.e. "one contributor's work on top
+of it").
+
+--ignore-skip-worktree-bits::
+	In sparse checkout mode, update only entries matched by
+	<paths> and sparse patterns in
+	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	patterns and adds back any files in <paths>.
+
+-m::
+--merge::
+	When checking out paths from the index, this option lets you
+	recreate the conflicted merge in the specified paths.
+
+--conflict=<style>::
+	The same as --merge option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	merge.conflictStyle configuration variable.  Possible values are
+	"merge" (default) and "diff3" (in addition to what is shown by
+	"merge" style, shows the original contents).
+
+-p::
+--patch::
+	Interactively select hunks in the difference between the
+	<tree-ish> (or the index, if unspecified) and the working
+	tree.  The chosen hunks are then applied in reverse to the
+	working tree (and if a <tree-ish> was specified, the index).
++
+This means that you can use `git restore-files -p` to selectively
+discard edits from your current working tree. See the ``Interactive
+Mode'' section of linkgit:git-add[1] to learn how to operate the
+`--patch` mode.
+
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated.
+	Just like linkgit:git-submodule[1], this will detach the
+	submodules HEAD.
+
+<tree-ish>::
+	Tree to checkout from (when paths are given). If not specified,
+	the index will be used.
+
+EXAMPLES
+--------
+
+. The following sequence checks out the `master` branch, reverts
+the `Makefile` to two revisions back, deletes hello.c by
+mistake, and gets it back from the index.
++
+------------
+$ git switch-branch master                    <1>
+$ git restore-files --from master~2 Makefile  <2>
+$ rm -f hello.c
+$ git restore-files hello.c                   <3>
+------------
++
+<1> switch branch
+<2> take a file out of another commit
+<3> restore hello.c from the index
++
+If you want to check out _all_ C source files out of the index,
+you can say
++
+------------
+$ git restore-files '*.c'
+------------
++
+Note the quotes around `*.c`.  The file `hello.c` will also be
+checked out, even though it is no longer in the working tree,
+because the file globbing is used to match entries in the index
+(not in the working tree by the shell).
++
+If you have an unfortunate branch that is named `hello.c`, this
+step would be confused as an instruction to switch to that branch.
+You should instead write:
++
+------------
+$ git restore-files hello.c
+------------
+
+SEE ALSO
+--------
+linkgit:git-checkout[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-switch-branch.txt b/Documentation/git-switch-branch.txt
new file mode 100644
index 0000000000..d5bf5cb37d
--- /dev/null
+++ b/Documentation/git-switch-branch.txt
@@ -0,0 +1,289 @@
+git-switch-branch(1)
+====================
+
+NAME
+----
+git-switch-branch - Switch branches
+
+SYNOPSIS
+--------
+[verse]
+'git switch-branch' [-q] [-f] [-m] <branch>
+'git switch-branch' [-q] [-f] [-m] --detach [<commit>]
+'git switch-branch' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+
+DESCRIPTION
+-----------
+Switch to a specified branch and update files in the working tree to
+match it.
+
+'git switch-branch' <branch>::
+	To prepare for working on <branch>, switch to it by updating
+	the index and the files in the working tree. Local
+	modifications to the files in the working tree are kept, so
+	that they can be committed to the <branch>.
++
+If <branch> is not found but there does exist a tracking branch in
+exactly one remote (call it <remote>) with a matching name, treat as
+equivalent to
++
+------------
+$ git switch-branch -b <branch> --track <remote>/<branch>
+------------
++
+If the branch exists in multiple remotes and one of them is named by
+the `checkout.defaultRemote` configuration variable, we'll use that
+one for the purposes of disambiguation, even if the `<branch>` isn't
+unique across all remotes. Set it to
+e.g. `checkout.defaultRemote=origin` to always checkout remote
+branches from there if `<branch>` is ambiguous but exists on the
+'origin' remote. See also `checkout.defaultRemote` in
+linkgit:git-config[1].
+
+'git switch-branch' -c|-C <new_branch> [<start_point>]::
+
+	Specifying `-c` causes a new branch to be created as if
+	linkgit:git-branch[1] were called and then switched to. In
+	this case you can use the `--track` or `--no-track` options,
+	which will be passed to 'git branch'.  As a convenience,
+	`--track` without `-c` implies branch creation; see the
+	description of `--track` below.
++
+If `-C` is given, <new_branch> is created if it doesn't exist;
+otherwise, it is reset. This is the transactional equivalent of
++
+------------
+$ git branch -f <branch> [<start_point>]
+$ git switch-branch <branch>
+------------
++
+that is to say, the branch is not reset/created unless "git
+switch-branch" is successful.
+
+'git switch-branch' --detach [<commit>]::
+
+	Prepare to work on a unnamed branch on top of <commit> (see
+	"DETACHED HEAD" section), and updating the index and the files
+	in the working tree.  Local modifications to the files in the
+	working tree are kept, so that the resulting working tree will
+	be the state recorded in the commit plus the local
+	modifications.
++
+When the <commit> argument is a branch name, the `--detach` option can
+be used to detach HEAD at the tip of the branch (`git switch-branch
+<branch>` would check out that branch without detaching HEAD).
++
+Omitting <commit> detaches HEAD at the tip of the current branch.
+
+OPTIONS
+-------
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
+-f::
+--force::
+	Proceed even if the index or the working tree differs from
+	HEAD.  This is used to throw away local changes.
+
+-c <new_branch>::
+--create <new_branch>::
+	Create a new branch named <new_branch> and start it at
+	<start_point>; see linkgit:git-branch[1] for details.
+
+-C <new_branch>::
+--force-create <new_branch>::
+	Creates the branch <new_branch> and start it at <start_point>;
+	if it already exists, then reset it to <start_point>. This is
+	equivalent to running "git branch" with "-f"; see
+	linkgit:git-branch[1] for details.
+
+-t::
+--track::
+	When creating a new branch, set up "upstream" configuration. See
+	"--track" in linkgit:git-branch[1] for details.
++
+If no `-c` option is given, the name of the new branch will be derived
+from the remote-tracking branch, by looking at the local part of the
+refspec configured for the corresponding remote, and then stripping
+the initial part up to the "*".
+This would tell us to use "hack" as the local branch when branching
+off of "origin/hack" (or "remotes/origin/hack", or even
+"refs/remotes/origin/hack").  If the given name has no slash, or the above
+guessing results in an empty name, the guessing is aborted.  You can
+explicitly give a name with `-c` in such a case.
+
+--no-track::
+	Do not set up "upstream" configuration, even if the
+	branch.autoSetupMerge configuration variable is true.
+
+-l::
+	Create the new branch's reflog; see linkgit:git-branch[1] for
+	details.
+
+--detach::
+	Rather than checking out a branch to work on it, check out a
+	commit for inspection and discardable experiments.
+	This is the default behavior of "git checkout <commit>" when
+	<commit> is not a branch name.  See the "DETACHED HEAD" section
+	below for details.
+
+--orphan <new_branch>::
+	Create a new 'orphan' branch, named <new_branch>, started from
+	<start_point> and switch to it.  The first commit made on this
+	new branch will have no parents and it will be the root of a new
+	history totally disconnected from all the other branches and
+	commits.
++
+The index and the working tree are adjusted as if you had previously run
+"git checkout <start_point>".  This allows you to start a new history
+that records a set of paths similar to <start_point> by easily running
+"git commit -a" to make the root commit.
++
+This can be useful when you want to publish the tree from a commit
+without exposing its full history. You might want to do this to publish
+an open source branch of a project whose current tree is "clean", but
+whose full history contains proprietary or otherwise encumbered bits of
+code.
++
+If you want to start a disconnected history that records a set of paths
+that is totally different from the one of <start_point>, then you should
+clear the index and the working tree right after creating the orphan
+branch by running "git rm -rf ." from the top level of the working tree.
+Afterwards you will be ready to prepare your new files, repopulating the
+working tree, by copying them from elsewhere, extracting a tarball, etc.
+
+-m::
+--merge::
+	If you have local modifications to one or more files that are
+	different between the current branch and the branch to which
+	you are switching, the command refuses to switch branches in
+	order to preserve your modifications in context.  However,
+	with this option, a three-way merge between the current
+	branch, your working tree contents, and the new branch is
+	done, and you will be on the new branch.
++
+When a merge conflict happens, the index entries for conflicting
+paths are left unmerged, and you need to resolve the conflicts
+and mark the resolved paths with `git add` (or `git rm` if the merge
+should result in deletion of the path).
+
+--conflict=<style>::
+	The same as --merge option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	merge.conflictStyle configuration variable.  Possible values are
+	"merge" (default) and "diff3" (in addition to what is shown by
+	"merge" style, shows the original contents).
+
+--ignore-other-worktrees::
+	`git switch-branch` refuses when the wanted ref is already
+	checked out by another worktree. This option makes it check
+	the ref out anyway. In other words, the ref can be held by
+	more than one worktree.
+
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated.
+	Just like linkgit:git-submodule[1], this will detach the
+	submodules HEAD.
+
+<branch>::
+	Branch to checkout; if it refers to a branch (i.e., a name that,
+	when prepended with "refs/heads/", is a valid ref), then that
+	branch is checked out. Otherwise, if it refers to a valid
+	commit, your HEAD becomes "detached" and you are no longer on
+	any branch (see below for details).
++
+You can use the `"@{-N}"` syntax to refer to the N-th last
+branch/commit checked out using "git checkout" operation. You may
+also specify `-` which is synonymous to `"@{-1}`.
++
+As a special case, you may use `"A...B"` as a shortcut for the
+merge base of `A` and `B` if there is exactly one merge base. You can
+leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+
+<new_branch>::
+	Name for the new branch.
+
+<start_point>::
+	The name of a commit at which to start the new branch; see
+	linkgit:git-branch[1] for details. Defaults to HEAD.
+
+DETACHED HEAD
+-------------
+include::detach-head.txt[]
+
+EXAMPLES
+--------
+
+. The following sequence checks out the `master` branch.
++
+------------
+$ git switch-branch master
+------------
++
+
+. After working in the wrong branch, switching to the correct
+branch would be done using:
++
+------------
+$ git switch-branch mytopic
+------------
++
+However, your "wrong" branch and correct "mytopic" branch may
+differ in files that you have modified locally, in which case
+the above checkout would fail like this:
++
+------------
+$ git switch-branch mytopic
+error: You have local changes to 'frotz'; not switching branches.
+------------
++
+You can give the `-m` flag to the command, which would try a
+three-way merge:
++
+------------
+$ git switch-branch -m mytopic
+Auto-merging frotz
+------------
++
+After this three-way merge, the local modifications are _not_
+registered in your index file, so `git diff` would show you what
+changes you made since the tip of the new branch.
+
+. When a merge conflict happens during switching branches with
+the `-m` option, you would see something like this:
++
+------------
+$ git switch-branch -m mytopic
+Auto-merging frotz
+ERROR: Merge conflict in frotz
+fatal: merge program failed
+------------
++
+At this point, `git diff` shows the changes cleanly merged as in
+the previous example, as well as the changes in the conflicted
+files.  Edit and resolve the conflict and mark it resolved with
+`git add` as usual:
++
+------------
+$ edit frotz
+$ git add frotz
+------------
+
+SEE ALSO
+--------
+linkgit:git-checkout[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1a44c811aa..f035dbab9e 100644
--- a/Makefile
+++ b/Makefile
@@ -777,9 +777,11 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
+BUILT_INS += git-restore-files$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
+BUILT_INS += git-switch-branch$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
diff --git a/builtin.h b/builtin.h
index 6538932e99..01ed43ea69 100644
--- a/builtin.h
+++ b/builtin.h
@@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repack(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_restore_files(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
@@ -227,6 +228,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_switch_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 764e1a83a1..7dc0f4d3f3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,16 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+static const char * const switch_branch_usage[] = {
+	N_("git switch-branch [<options>] [<branch>]"),
+	NULL,
+};
+
+static const char * const restore_files_usage[] = {
+	N_("git restore-files [<options>] [<branch>] -- <file>..."),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1302,31 +1312,23 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			 struct checkout_opts *opts, struct option *options,
+			 const char * const usagestr[])
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	int dwim_remotes_matched = 0;
-	struct option *options = NULL;
 
-	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
-	opts->dwim_new_local_branch = 1;
 
 	git_config(git_checkout_config, opts);
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
-	options = parse_options_dup(options);
-	options = add_common_options(opts, options);
-	options = add_switch_branch_options(opts, options);
-	options = add_checkout_path_options(opts, options);
-
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, usagestr,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (opts->show_progress < 0) {
@@ -1455,3 +1457,61 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		return checkout_branch(opts, &new_branch_info);
 	}
 }
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, checkout_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_switch_branch(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, switch_branch_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_restore_files(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, restore_files_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..4638802754 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -151,6 +151,7 @@ git-replace                             ancillarymanipulators           complete
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
+git-restore-files                       mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
@@ -171,6 +172,7 @@ git-status                              mainporcelain           info
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
+git-switch-branch                       mainporcelain           history
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain           history
 git-unpack-file                         plumbinginterrogators
diff --git a/git.c b/git.c
index 2f604a41ea..a2be6c3eb5 100644
--- a/git.c
+++ b/git.c
@@ -542,6 +542,7 @@ static struct cmd_struct commands[] = {
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
+	{ "restore-files", cmd_restore_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
 	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
@@ -557,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
-- 
2.20.0.rc1.380.g3eb999425c.dirty

