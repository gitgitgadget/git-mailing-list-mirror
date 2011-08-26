From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 26 Aug 2011 16:05:14 +0200
Message-ID: <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx2U-0007ZO-1E
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab1HZOF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:05:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55709 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab1HZOF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:05:26 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 991BF20814;
	Fri, 26 Aug 2011 10:05:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 26 Aug 2011 10:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=qp
	HU1JIxY9zKJyWiUT1jWfXg0Js=; b=ZtOrshZZyjdvjMoSNepsms9utj9vcbn+ZO
	vINrRhN0WNYaJmON9b8uF3TAljcPAJS+gea55rXQg0MCyt9BfKgS27egVeOX0z0a
	xTL/O3AisrB53Q9Ecn1I+XbKJcIcDbAwZ9eS0IQrw9GN4lTnLnorxuFHQJo2XTej
	3tn9u+Mxc=
X-Sasl-enc: ovnOUa/wX5Ed7JqB+qyydCceINqZUcnDwZe4kXVicSJF 1314367525
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A8859205E4;
	Fri, 26 Aug 2011 10:05:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180168>

Currently, there is no way to invoke the list mode explicitly.
Introduce a --list option which invokes the list mode. This will be
beneficial for invoking list mode with pattern matching, which otherwise
would be interpreted as branch creation.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    9 +++++++--
 builtin/branch.c             |   12 +++++++++---
 t/t3203-branch-output.sh     |   14 ++++++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4c64ac9..ac278fb 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[-v [--abbrev=<length> | --no-abbrev]]
+	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -20,7 +20,8 @@ DESCRIPTION
 
 With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
-branches to be listed, and option `-a` shows both.
+branches to be listed, and option `-a` shows both. This list mode is also
+activated by the `--list` and `-v` options (see below).
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -110,11 +111,15 @@ OPTIONS
 --all::
 	List both remote-tracking branches and local branches.
 
+--list::
+	Activate the list mode.
+
 -v::
 --verbose::
 	Show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
 	the name of the upstream branch, as well.
+	`--list` is implied by all verbosity options.
 
 --abbrev=<length>::
 	Alter the sha1's minimum display length in the output listing.
diff --git a/builtin/branch.c b/builtin/branch.c
index 94e41ae..4a33b07 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -608,7 +608,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -647,6 +647,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', "move", &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN(0, "list", &list, "list branch names"),
 		OPT_BOOLEAN('l', "create-reflog", &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
@@ -686,7 +687,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+
+	if (!delete && !rename && !force_create &&
+	    (argc == 0 || (verbose && argc)))
+		list = 1;
+
+	if (!!delete + !!rename + !!force_create + !!list > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -694,7 +700,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
+	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6b7c118..61e095c 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -32,6 +32,20 @@ test_expect_success 'git branch shows local branches' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --list shows local branches' '
+	git branch --list >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+  branch-one
+  branch-two
+EOF
+test_expect_success 'git branch --list pattern shows matching local branches' '
+	git branch --list branch* >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<'EOF'
   origin/HEAD -> origin/branch-one
   origin/branch-one
-- 
1.7.6.845.gc3c05
