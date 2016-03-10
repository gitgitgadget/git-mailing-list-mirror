From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/1] branch: allow conveniently adding new worktrees for new
 branches
Date: Thu, 10 Mar 2016 12:34:28 +0100 (CET)
Message-ID: <c5345f60e4ec247d57877e3e97a1eea5cb283d27.1457609615.git.johannes.schindelin@gmx.de>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:34:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adyra-0000MS-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965718AbcCJLef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 06:34:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:61724 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965662AbcCJLee (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 06:34:34 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LdKs1-1ZvsYB1LxB-00iSW6; Thu, 10 Mar 2016 12:34:30
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1457609615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4lAzf1iye7WEgdmatj6Zx/DvYoekv0NpCGotI8SV2y3k2m73qvW
 YStSFZjBlOWe5P/CmsS9Oita+yAehmjBu7BfdjH+7Z2qZrmU0Cf+T48yN3as5Z7mb25Ee2I
 gevPWHDKUAINASEi93dEqHJ18Cfrt8magUs8nZYVFEjviTa5N9T1f6CGsmHLoy7y6kySh33
 L1wflYajmapvK6C8BcG3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ln6F/cSo9X0=:Lj3n5VtHKHzF4IJyXYj2eZ
 w+Anqm0bEB5SquVgCyYggv/qB85j3PCDtvlXpyUkWt7GwyqN0xzc6H1gNAxDBP/7xeJTgQULi
 /nok71ZqdSFB07IHLKISdDGH9vv6G+EY1VAD9+OTdDJGZSrDvc2cXx3o4jNRBFGmBsOPoUoNY
 3cWcAMp4780mh+tlBtjil3kqtr8AYIiydYB1wTjWT203ScAHtPcYkNyjttOzplJZCxI4Bndpb
 2ucjMm91LhyunGzVd44yxSMCY/5Xf4uFWB6sJioBbb5UNRtTxZqUKrze9ulP93+2r0VGDD6ym
 CKhW/fvm80jdySs1yZam+pw7WzrQZKMgUzX+MN6OMFvUhhvtix08H+mNbuL+tt/U0FnvDalzq
 S2BSYV4+g7P2vHWjOcUOTt53ilYurw+ac1Yf9YeHuF6VWc5pYXJttOHeVX3HQmZhff1H10kmL
 pEz9GNovc9kBlc0fssWFarB7NHSqNv2nUb15ZzBcKgehWg7HNsUYaPZA1mHxayQCQFOA+Xja+
 WHry/TN0+fyej66rCKrqtIPO9YBDqQ7kB+O1TQSlDgsY0aEWko0mJJVl3k3gyxDVpGhtCLTrc
 MhDpSlfciO+F8YM64rXcUhhNc1rSfGqyr+6ThJCg5z/bGuUiInjhcNiak99Z+dsx3505qLIpF
 1BaDihsQx1Tu8/w29OqZwN3XnEPZFw7p1Az1QvkUrk+647hM1J+WadCPb43MtwUd5FSqJCraE
 bdM9tMQkbCiUW43dYOlbi5P5NQeAlmnCxCT9p1NrDA0uSAYhmW9z5i9NibqvzY+DSxBuJjjQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288615>

With the newly-introduced --worktree option, after a new branch was
created we will add a corresponding new worktree with the same name
automatically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-branch.txt |  5 +++--
 builtin/branch.c             | 27 +++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4a7037f..963cdcb 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
 	[--points-at <object>] [<pattern>...]
-'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' [--set-upstream | --track | --no-track] [-l] [-f] [-w | --worktree] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -46,7 +46,8 @@ which points to the current 'HEAD', or <start-point> if given.
 
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
-new branch.
+new branch, or use the `--worktree` option to add a new worktree of
+the same name.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..c681b2e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -20,6 +20,7 @@
 #include "utf8.h"
 #include "wt-status.h"
 #include "ref-filter.h"
+#include "run-command.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
@@ -605,7 +606,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force = 0, list = 0;
 	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
+	int quiet = 0, unset_upstream = 0, new_worktree = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	struct ref_filter filter;
@@ -622,6 +623,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BIT('w', "worktree", &new_worktree, N_("add worktree for the new branch"), 1),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
@@ -678,6 +680,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
+	if (new_worktree) {
+		if (delete || rename || new_upstream || unset_upstream)
+			die("--worktree requires creating a new branch");
+		if (new_worktree && (argc < 1 || argc > 2))
+			die(_("--worktree needs a branch/worktree name"));
+	}
+
 	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
 		list = 1;
 
@@ -797,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
-		int branch_existed = 0, remote_tracking = 0;
+		int branch_existed = 0, remote_tracking = 0, res = 0;
 		struct strbuf buf = STRBUF_INIT;
 
 		if (!strcmp(argv[0], "HEAD"))
@@ -820,6 +829,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
+		if (new_worktree) {
+			const char *child_argv[] = {
+				"worktree", "add", NULL, NULL, NULL
+			};
+			child_argv[2] = child_argv[3] = argv[0];
+			if ((res = run_command_v_opt(child_argv, RUN_GIT_CMD)))
+				error(_("Could not create worktree %s"), argv[0]);
+			else
+				fprintf(stderr, _("New worktree set up at %s\n"), argv[0]);
+		}
+
 		/*
 		 * We only show the instructions if the user gave us
 		 * one branch which doesn't exist locally, but is the
@@ -828,10 +848,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
 		    !branch_existed && remote_tracking) {
 			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
+			if (new_worktree)
+				fprintf(stderr, _("    # remove worktree %s/\n"), branch->name);
 			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
 			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
 		}
 
+		return res;
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
-- 
2.7.2.windows.1.8.g47d64e6.dirty
