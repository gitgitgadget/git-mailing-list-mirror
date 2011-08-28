From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 4/5] branch: introduce --list option
Date: Sun, 28 Aug 2011 16:54:31 +0200
Message-ID: <05a1a73e0b942dd94dd091c233be964fa19dfc6a.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxglO-000078-Bw
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab1H1Oyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54683 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390Ab1H1Oyr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:47 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9711C20F57;
	Sun, 28 Aug 2011 10:54:46 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 28 Aug 2011 10:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=NC
	fqIllAtX7i81qexTrZc+gZ+cI=; b=deUY9Bbnt+2KgOPxSNTZ2pE2crMov3Ul4G
	IrBHGhCrL4e2O0S7fVM7q+/Yw5YJDHz1AGthEZ6/HC9yeqbwb1A1p87Z77NXBS6N
	nJptGcWV6Zh0FS9Gy5ZUPvZr0xxg02bn7PoAjXc5IAlutsOL/TKMVuTOFAb0bgZP
	IZRbRUqnM=
X-Sasl-enc: q0epaBbJ8S/EcV0qLf9+8ARFdsRCeSxrQr5Ic9kvaw50 1314543285
Received: from localhost (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A438EA00251;
	Sun, 28 Aug 2011 10:54:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314543252.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180271>

Currently, there is no way to invoke the list mode explicitly, without
giving -v to force verbose output.

Introduce a --list option which invokes the list mode. This will be
beneficial for invoking list mode with pattern matching, which otherwise
would be interpreted as branch creation.

Along with --list, test also combinations of existing options.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    9 +++++++--
 builtin/branch.c             |   12 +++++++++---
 t/t3200-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh     |   14 ++++++++++++++
 4 files changed, 62 insertions(+), 5 deletions(-)

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
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cb6458d..931373c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -98,6 +98,38 @@ test_expect_success 'git branch -m q r/q should fail when r exists' '
 	test_must_fail git branch -m q r/q
 '
 
+test_expect_success 'git branch -v -d t should work' '
+	git branch t &&
+	test .git/refs/heads/t &&
+	git branch -v -d t &&
+	test ! -f .git/refs/heads/t
+'
+
+test_expect_success 'git branch -v -m t s should work' '
+	git branch t &&
+	test .git/refs/heads/t &&
+	git branch -v -m t s &&
+	test ! -f .git/refs/heads/t &&
+	test -f .git/refs/heads/s &&
+	git branch -d s
+'
+
+test_expect_success 'git branch -m -d t s should fail' '
+	git branch t &&
+	test .git/refs/heads/t &&
+	test_must_fail git branch -m -d t s &&
+	git branch -d t &&
+	test ! -f .git/refs/heads/t
+'
+
+test_expect_success 'git branch --list -d t should fail' '
+	git branch t &&
+	test .git/refs/heads/t &&
+	test_must_fail git branch --list -d t &&
+	git branch -d t &&
+	test ! -f .git/refs/heads/t
+'
+
 test_expect_success 'git branch -M foo bar should fail when bar is checked out' '
 	git branch bar &&
 	git checkout -b foo &&
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
