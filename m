From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 4/5] branch: introduce --list option
Date: Thu,  8 Sep 2011 16:25:57 +0200
Message-ID: <c259dcbada3de282325b59b143209ace57ff8b9d.1315491900.git.git@drmicha.warpmail.net>
References: <4E6889DF.7030404@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 16:26:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fYR-0001r0-0k
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab1IHO0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:26:05 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39619 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab1IHO0D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 10:26:03 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 88F762B1BD;
	Thu,  8 Sep 2011 10:26:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 08 Sep 2011 10:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=xL
	4rxkU8Q4Fn+dOKCOqAFeu5VN8=; b=awjFwf/+2/9btAqUfHVUfyyAAixhPR3idW
	vWB+B0CZbB5mS2Cma1dJDbatmW9ft47eM/36sq5zLGkU8JbZxZnGqwBKcRxQieEs
	GdFxyX0IlCHvWnZ/crOv0Em8K9wkGQxZMW835MyBPs8nvi6XPssvKLziBTSbkIFu
	iK4Z7sokc=
X-Sasl-enc: 7PdOYynmhIDLtwnO+BjtV8DPtQ4/zhqF7a1rgFQgc4EB 1315491961
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E41FA78034A;
	Thu,  8 Sep 2011 10:26:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E6889DF.7030404@drmicha.warpmail.net>
In-Reply-To: <cover.1315491900.git.git@drmicha.warpmail.net>
References: <cover.1315491900.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180973>

Currently, there is no way to invoke the list mode explicitly.

Introduce a --list option which invokes the list mode. This will be
beneficial for invoking list mode with pattern matching, which otherwise
would be interpreted as branch creation.

Along with --list, test also combinations of existing options.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |   11 ++++++++---
 builtin/branch.c             |   11 ++++++++---
 t/t3200-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh     |    5 +++++
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4c64ac9..26024b6 100644
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
+activated by the `--list` option (see below).
 
 With `--contains`, shows only the branches that contain the named commit
 (in other words, the branches whose tip commits are descendants of the
@@ -110,9 +111,13 @@ OPTIONS
 --all::
 	List both remote-tracking branches and local branches.
 
+--list::
+	Activate the list mode.
+
 -v::
 --verbose::
-	Show sha1 and commit subject line for each head, along with
+	When in list mode,
+	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
 	the name of the upstream branch, as well.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index bd3a315..b17ad26 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -612,7 +612,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -651,6 +651,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', "move", &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN(0, "list", &list, "list branch names"),
 		OPT_BOOLEAN('l', "create-reflog", &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
@@ -693,7 +694,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+
+	if (!delete && !rename && !force_create && argc == 0)
+		list = 1;
+
+	if (!!delete + !!rename + !!force_create + !!list > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -701,7 +706,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0)
+	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9e69c8c..c466b20 100755
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
 mv .git/config .git/config-saved
 
 test_expect_success 'git branch -m q q2 without config should succeed' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 6b7c118..97d10b1 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -32,6 +32,11 @@ test_expect_success 'git branch shows local branches' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --list shows local branches' '
+	git branch --list >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<'EOF'
   origin/HEAD -> origin/branch-one
   origin/branch-one
-- 
1.7.7.rc0.469.g9eb94
