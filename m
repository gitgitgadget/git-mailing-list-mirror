From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/5] branch: introduce --list argument
Date: Thu, 25 Aug 2011 10:30:19 +0200
Message-ID: <32d0954697da9ac96cc11af0d8cc1390d93fd037.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVL2-0000B1-VQ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab1HYIaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:46 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47723 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1HYIab (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:31 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EBEA120C6A;
	Thu, 25 Aug 2011 04:30:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 25 Aug 2011 04:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=V0
	10vxcgHPGrCdwaeWUAHf0rH+0=; b=aAqJ52Vs/XCXyNUyCzeqPrG7bdde/nzpNp
	vxcryo9PQPIEdLwN4qMPOpr05SBkynelWucdgoTdlQoxW+n9Xi8bjNum8kHtH9PV
	j4CZJVcxgE3JmJ3s+vZ6dFxW8L7Oo1r73mjgTtzT/B6dOhOfCbIY2jbilq7ZXSw1
	rW8oawiNs=
X-Sasl-enc: +tHZSHVm+Dpe0ZgHjc3oxzHX/o8WfvV4n5zvBmaNmU+F 1314261030
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5D7B9901ED5;
	Thu, 25 Aug 2011 04:30:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180073>

Currently, there is no way to invoke the list mode with a pattern
because this is interpreted as branch creation.

Introduce a --list argument which invokes the list mode.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    9 +++++++--
 builtin/branch.c             |   10 +++++++---
 t/t3203-branch-output.sh     |   14 ++++++++++++++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 2152d48..789ff02 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
-	[-v [--abbrev=<length> | --no-abbrev]]
+	[--list] [-v [--abbrev=<length> | --no-abbrev]]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -21,7 +21,7 @@ DESCRIPTION
 With no arguments, existing branches are listed and the current branch will
 be highlighted with an asterisk.  Option `-r` causes the remote-tracking
 branches to be listed, and option `-a` shows both. This list mode is also
-activated by the `-v` option (see below).
+activated by the `--list` and `-v` options (see below).
 <pattern> restricts the output to matching branches, the pattern is a shell
 wildcard (i.e., matched using fnmatch(3))
 
@@ -108,11 +108,16 @@ OPTIONS
 -a::
 	List both remote-tracking branches and local branches.
 
+--list::
+	Activate the list mode. `git branch <pattern>` would try to create a branch,
+	use `git branch --list <pattern>` to list matching branches.
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
index 6b40815..aed0aca 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -617,7 +617,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -656,6 +656,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2),
 		OPT_BIT('m', NULL, &rename, "move/rename a branch and its reflog", 1),
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
+		OPT_BOOLEAN(0, "list", &list, "list branch names"),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT__FORCE(&force_create, "force creation (when already exists)"),
 		{
@@ -695,12 +696,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+	if (!!delete + !!rename + !!force_create + !!list > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (argc == 0 || (verbose && argc == 1))
+		list = 1;
+
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0 || (verbose && argc == 1))
+	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 2df1d3d..f2b294b 100755
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
