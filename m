Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD5D21F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfDYJqN (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46146 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfDYJqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so1788354pgg.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=we4az9EhbXPRjyjiKdFFU2d1wbFPUO4G79josMtTf4E=;
        b=ZiYO3Wt6zsTTeLu7yc/jhrmVw5pAa/HDXw/70A768fJeLR+gq+mjs5HQ5lgqmO+mqV
         QxOAT1p3tl0+nG9VpWiExcflGkuqb7hlYeFPLZkr3esUXEEubyONI+tY+nmk3xH3QTAI
         UhAzoI0es00WHLK8r5bG7cFlpBHjwPD7iNOxnxKR8VIEkCvVmiI04yZzeeC3iHqUeQpJ
         tAdFCUKFCUfIXK3Jt4+y/c91Nf/Iqr53uaFem9lObTNLxm5+zLFwTSRngK/jkS28kUyQ
         s1sokz9JubIn25jR5dMJr0aUaEzQp5VMtOQ4liHFy4o8TgD8PdEosPzPELSP+nLnuo0J
         m5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=we4az9EhbXPRjyjiKdFFU2d1wbFPUO4G79josMtTf4E=;
        b=OcNl0Gv1pl4453ToONi2qVIglvY7CRSOcpOjl+pS/jwp0GBLeTCGqELsFE8GNNMifO
         naA/NeDeyCuSF1f8C7UL7JD99TmEbqMcDu++2gKEKHPrB3dn/YYY2NmiGrJfknscZbK0
         eoNQkAS4FM8K3EUTwvvNXX/dpXLolmW5vCR8kSHD4RJNC98oQE/rCFYBpKsGxmTxhmuP
         sArJjtVAY+/BrB6tYGpyygzha03DHlNRqieaGA/N6cduy8Qho7Wdb4b5yFlJYUFsCOD4
         ps3HrH+zveklu/GjdBFN4ETRhTKxzav3kmh4l3dG96xu0yWUN4H/I0g2f0mFjikocx3y
         N6uw==
X-Gm-Message-State: APjAAAU80Zb7ZzwJGuWY/HzACa/sBq7XcM9/pwevrc9ymCJm9QtEAH3Z
        DkworKVxy5I7kF+CdEu+eeQ=
X-Google-Smtp-Source: APXvYqyd23lxhziEmkmGIZCmMU57xiXvhuj9uMDfg1piIkmR97ro/uansjaINeovCYilCcorwjzzYQ==
X-Received: by 2002:aa7:914d:: with SMTP id 13mr39211716pfi.149.1556185572500;
        Thu, 25 Apr 2019 02:46:12 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id q5sm32098735pff.97.2019.04.25.02.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 01/16] checkout: split part of it to new command 'restore'
Date:   Thu, 25 Apr 2019 16:45:45 +0700
Message-Id: <20190425094600.15673-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the switching branch business of 'git checkout' becomes a
new command 'switch'. This adds the restore command for the checking
out paths path.

Similar to git-switch, a new man page is added to describe what the
command will become. The implementation will be updated shortly to
match the man page.

A couple main differences from 'git checkout <paths>':

- 'restore' by default will only update worktree. This matters more
  when --source is specified ('checkout <tree> <paths>' updates both
  worktree and index).

- 'restore --staged' can be used to restore the index. This command
  overlaps with 'git reset <paths>'.

- both worktree and index could also be restored at the same time
  (from a tree) when both --staged and --worktree are specified. This
  overlaps with 'git checkout <tree> <paths>'

- default source for restoring worktree and index is the index and
  HEAD respectively. A different (tree) source could be specified as
  with --source (*).

- when both index and worktree are restored, --source must be
  specified since the default source for these two individual targets
  are different (**)

- --no-overlay is enabled by default, if an entry is missing in the
  source, restoring means deleting the entry

(*) I originally went with --from instead of --source. I still think
  --from is a better name. The short option -f however is already
  taken by force. And I do think short option is good to have, e.g. to
  write -s@ or -s@^ instead of --source=HEAD.

(**) If you sit down and think about it, moving worktree's source from
  the index to HEAD makes sense, but nobody is really thinking it
  through when they type the commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .gitignore                           |   1 +
 Documentation/config/interactive.txt |   3 +-
 Documentation/git-checkout.txt       |   3 +-
 Documentation/git-reset.txt          |   7 +-
 Documentation/git-restore.txt (new)  | 183 +++++++++++++++++++++++++++
 Documentation/git-revert.txt         |   3 +
 Documentation/git.txt                |  20 +++
 Documentation/gitcli.txt             |  12 ++
 Makefile                             |   1 +
 builtin.h                            |   1 +
 builtin/checkout.c                   |  26 ++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 13 files changed, 257 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index c687b92b1c..fb377106be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -143,6 +143,7 @@
 /git-request-pull
 /git-rerere
 /git-reset
+/git-restore
 /git-rev-list
 /git-rev-parse
 /git-revert
diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index ad846dd7c9..a2d3c7ec44 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -2,7 +2,8 @@ interactive.singleKey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
 	Currently this is used by the `--patch` mode of
-	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
+	linkgit:git-add[1], linkgit:git-checkout[1],
+	linkgit:git-restore[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
 	setting is silently ignored if portable keystroke input
 	is not available; requires the Perl module Term::ReadKey.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 58f18a0842..a294652dd6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -570,7 +570,8 @@ $ git add frotz
 
 SEE ALSO
 --------
-linkgit:git-switch[1]
+linkgit:git-switch[1],
+linkgit:git-restore[1]
 
 GIT
 ---
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index cbf901efb4..c25f8a95b9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -25,7 +25,8 @@ The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 	the current branch.)
 +
 This means that `git reset <paths>` is the opposite of `git add
-<paths>`.
+<paths>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <paths>...`.
 +
 After running `git reset <paths>` to update the index entry, you can
 use linkgit:git-checkout[1] to check the contents out of the index to
@@ -86,8 +87,8 @@ but carries forward unmerged index entries.
 	changes, reset is aborted.
 --
 
-If you want to undo a commit other than the latest on a branch,
-linkgit:git-revert[1] is your friend.
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
 
 
 OPTIONS
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
new file mode 100644
index 0000000000..b608f3f360
--- /dev/null
+++ b/Documentation/git-restore.txt
@@ -0,0 +1,183 @@
+git-restore(1)
+==============
+
+NAME
+----
+git-restore - Restore working tree files
+
+SYNOPSIS
+--------
+[verse]
+'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
+'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]
+
+DESCRIPTION
+-----------
+Restore specified paths in the working tree with some contents from a
+restore source. If a path is tracked but does not exist in the restore
+source, it will be removed to match the source.
+
+The command can also be used to restore the content in the index with
+`--staged`, or restore both the working tree and the index with
+`--staged --worktree`.
+
+By default, the restore sources for working tree and the index are the
+index and `HEAD` respectively. `--source` could be used to specify a
+commit as the restore source.
+
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
+
+OPTIONS
+-------
+-s <tree>::
+--source=<tree>::
+	Restore the working tree files with the content from the given
+	tree. It is common to specify the source tree by naming a
+	commit, branch or tag associated with it.
++
+If not specified, the default restore source for the working tree is
+the index, and the default restore source for the index index is
+`HEAD`. When both `--staged` and `--worktree` are specified,
+`--source` must also be specified.
+
+-p::
+--patch::
+	Interactively select hunks in the difference between the
+	restore source and the restore location. See the ``Interactive
+	Mode'' section of linkgit:git-add[1] to learn how to operate
+	the `--patch` mode.
++
+Note that `--patch` can accept no pathspec and will prompt to restore
+all modified paths.
+
+-W::
+--worktree::
+-S::
+--staged::
+	Specify the restore location. If neither option is specified,
+	by default the working tree is restored. Specifying `--staged`
+	will only restore the index. Specifying both restores both.
+
+-q::
+--quiet::
+	Quiet, suppress feedback messages. Implies `--no-progress`.
+
+--progress::
+--no-progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
+--ours::
+--theirs::
+	When restoring files in the working tree from the index, use
+	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
++
+Note that during `git rebase` and `git pull --rebase`, 'ours' and
+'theirs' may appear swapped. See the explanation of the same options
+in linkgit:git-checkout[1] for details.
+
+-m::
+--merge::
+	When restoring files on the working tree from the index,
+	recreate the conflicted merge in the unmerged paths.
+
+--conflict=<style>::
+	The same as `--merge` option above, but changes the way the
+	conflicting hunks are presented, overriding the
+	`merge.conflictStyle` configuration variable.  Possible values
+	are "merge" (default) and "diff3" (in addition to what is
+	shown by "merge" style, shows the original contents).
+
+--ignore-unmerged::
+	When restoring files on the working tree from the index, do
+	not abort the operation if there are unmerged entries and
+	neither `--ours`, `--theirs`, `--merge` or `--conflict` is
+	specified. Unmerged paths on the working tree are left alone.
+
+--ignore-skip-worktree-bits::
+	In sparse checkout mode, by default is to only update entries
+	matched by `<pathspec>` and sparse patterns in
+	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	patterns and unconditionally restores any files in
+	`<pathspec>`.
+
+--overlay::
+--no-overlay::
+	In overlay mode, the command never removes files when
+	restoring. In no-overlay mode, tracked files that do not
+	appear in the `--source` tree are removed, to make them match
+	`<tree>` exactly. The default is no-overlay mode.
+
+EXAMPLES
+--------
+
+The following sequence switches to the `master` branch, reverts the
+`Makefile` to two revisions back, deletes hello.c by mistake, and gets
+it back from the index.
+
+------------
+$ git switch master
+$ git restore --source master~2 Makefile  <1>
+$ rm -f hello.c
+$ git restore hello.c                     <2>
+------------
+
+<1> take a file out of another commit
+<2> restore hello.c from the index
+
+If you want to restore _all_ C source files to match the version in
+the index, you can say
+
+------------
+$ git restore '*.c'
+------------
+
+Note the quotes around `*.c`.  The file `hello.c` will also be
+restored, even though it is no longer in the working tree, because the
+file globbing is used to match entries in the index (not in the
+working tree by the shell).
+
+To restore all files in the current directory
+
+------------
+$ git restore .
+------------
+
+or to restore all working tree files with 'top' pathspec magic (see
+linkgit:gitglossary[7])
+
+------------
+$ git restore :/
+------------
+
+To restore a file in the index to match the version in `HEAD` (this is
+the same as using linkgit:git-reset[1])
+
+------------
+$ git restore --staged hello.c
+------------
+
+or you can restore both the index and the working tree (this the same
+as using linkgit:git-checkout[1])
+
+------------
+$ git restore --source=HEAD --staged --worktree hello.c
+------------
+
+or the short form which is more practical but less readable:
+
+------------
+$ git restore -s@ -SW hello.c
+------------
+
+SEE ALSO
+--------
+linkgit:git-checkout[1],
+linkgit:git-reset[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..018ecf49d3 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -30,6 +30,9 @@ should see linkgit:git-checkout[1], specifically the `git checkout
 <commit> -- <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
+See "Reset, restore and revert" in linkgit:git[1] for the differences
+between the three commands.
+
 OPTIONS
 -------
 <commit>...::
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 00156d64aa..fbed007354 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -210,6 +210,26 @@ people via patch over e-mail.
 
 include::cmds-foreignscminterface.txt[]
 
+Reset, restore and revert
+~~~~~~~~~~~~~~~~~~~~~~~~~
+There are three commands with similar names: `git reset`,
+`git restore` and `git revert`.
+
+* linkgit:git-revert[1] is about making a new commit that reverts the
+  changes made by other commits.
+
+* linkgit:git-restore[1] is about restoring files in the working tree
+  from either the index or another commit. This command does not
+  update your branch. The command can also be used to restore files in
+  the index from another commit.
+
+* linkgit:git-reset[1] is about updating your branch, moving the tip
+  in order to add or remove commits from the branch. This operation
+  changes the commit history.
++
+`git reset` can also be used to restore the index, overlapping with
+`git restore`.
+
 
 Low-level commands (plumbing)
 -----------------------------
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 592e06d839..225513ef5e 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -209,6 +209,18 @@ See also http://marc.info/?l=git&m=116563135620359 and
 http://marc.info/?l=git&m=119150393620273 for further
 information.
 
+Some other commands that also work on files in the working tree and/or
+in the index can take `--staged` and/or `--worktree`.
+
+* `--staged` is exactly like `--cached`, which is used to ask a
+  command to only work on the index, not the working tree.
+
+* `--worktree` is the opposite, to ask a command to work on the
+  working tree only, not the index.
+
+* The two options can be specified together to ask a command to work
+  on both the index and the working tree.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 8e91db73ad..ffe7e4f58f 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ BUILT_INS += git-format-patch$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
+BUILT_INS += git-restore$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/builtin.h b/builtin.h
index c64e44450e..6830000e14 100644
--- a/builtin.h
+++ b/builtin.h
@@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repack(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_restore(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0351735c6e..98dc2ded38 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -38,6 +38,11 @@ static const char * const switch_branch_usage[] = {
 	NULL,
 };
 
+static const char * const restore_usage[] = {
+	N_("git restore [<options>] [<branch>] -- <file>..."),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -1622,3 +1627,24 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	FREE_AND_NULL(options);
 	return ret;
 }
+
+int cmd_restore(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.dwim_new_local_branch = 1;
+	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.accept_pathspec = 1;
+
+	options = parse_options_dup(options);
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, restore_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 13317f47d4..b9eae1c258 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -151,6 +151,7 @@ git-replace                             ancillarymanipulators           complete
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
+git-restore                             mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
diff --git a/git.c b/git.c
index 39582cf511..6d439e723f 100644
--- a/git.c
+++ b/git.c
@@ -558,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
+	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
 	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
 	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
-- 
2.21.0.854.ge34a79f761

