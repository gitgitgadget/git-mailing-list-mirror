Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FB17993
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zd3lfLOI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F033A7
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 04:04:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFC3xUO013069
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ba9Xl7LvzUy2/1aQA3w06eDS9ocS4muZFBuTORzDbRc=;
 b=zd3lfLOIE+16kzQbHCwF/WC/C33mkn229Rv7s51IOzTTiO3ZiwzXMQJ6Xjm4lPPGX87S
 yAhPwyxR53VP/OI+BO5v2O4EE5M9pQsSLJrINElRlt7G1BxalBrZR0HGbahaY+3xWAn8
 69JYioDUF7ZR+9fuWB5s4VeKMELxqxhIYVoNdR2XtMRSLR8FW+BCFFOc89bnvwLK3y/c
 od+fv528z8+8orGI/obKGy6ln1u6BOMwxLHWrWsg+YTCkb8s0pqCm1rANu72a4zRAaPe
 c3cfrr7wwLeejmn6KUwv585c1DwU5GptKwqQCTdJAHxHdyEyZrcapbKpsHejgROmZwHD 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd7udh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFAIbTq014850
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqt6rnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFC4Tk9036119
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:04:31 GMT
Received: from localhost.localdomain (dhcp-10-175-48-68.vpn.oracle.com [10.175.48.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uaxqt6rf1-2;
	Wed, 15 Nov 2023 12:04:31 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: git@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH 2/2] rev-list: add --ours/--theirs options
Date: Wed, 15 Nov 2023 13:04:17 +0100
Message-Id: <20231115120417.1327259-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115120417.1327259-1-vegard.nossum@oracle.com>
References: <20231115120417.1327259-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_10,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150093
X-Proofpoint-ORIG-GUID: Uy8hXD5JmXjPZvO_JW1cdatt4C3fxq5L
X-Proofpoint-GUID: Uy8hXD5JmXjPZvO_JW1cdatt4C3fxq5L

When resolving merge conflicts, it is useful to be able to inspect the
commits on either side of the attempted merge. git log/rev-list already
have the --merge option, which shows these commits; however, this doesn't
tell you which side each commit appears on.

Add --ours and --theirs to view the commits from

  $(git merge-base HEAD MERGE_HEAD)..HEAD and
  $(git merge-base HEAD MERGE_HEAD)..MERGE_HEAD

respectively.

I didn't see any existing tests for git rev-list --merge, but I've used
t/t6417-merge-ours-theirs.sh as a template for the new tests, which also
include --merge.

Since git diff/diff-files have their own --ours/--theirs parsing and
handling, we need a mechanism to prevent the generic revision parsing
from consuming these arguments. The mechanism I came up with was adding
a new flag, 'ignore_ours_theirs', to 'struct setup_revision_opt' that
these two commands must set. It's admittedly not extremely elegant, but
I didn't see a better solution.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/rev-list-options.txt |  8 ++++++
 builtin/diff-files.c               |  9 +++++-
 builtin/diff.c                     | 10 ++++++-
 revision.c                         | 16 ++++++++---
 revision.h                         |  6 ++--
 t/t6440-rev-list-merge.sh          | 45 ++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 8 deletions(-)
 create mode 100755 t/t6440-rev-list-merge.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2bf239ff03..1a75420190 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -344,6 +344,14 @@ Under `--pretty=reference`, this information will not be shown at all.
 	After a failed merge, show refs that touch files having a
 	conflict and don't exist on all heads to merge.
 
+--ours::
+	The same as --merge, but only show commits from "our branch"
+	(`HEAD`).
+
+--theirs::
+	The same as --merge, but only show commits from "their branch"
+	(`MERGE_HEAD`).
+
 --boundary::
 	Output excluded boundary commits. Boundary commits are
 	prefixed with `-`.
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index f38912cd40..64f3b1d284 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -20,6 +20,7 @@ COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
+	struct setup_revision_opt opt = { 0 };
 	struct rev_info rev;
 	int result;
 	unsigned options = 0;
@@ -43,7 +44,13 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	/*
+	 * We have our own handling for --ours/--theirs, so don't
+	 * restrict the revision ranges/paths.
+	 */
+	opt.ignore_ours_theirs = 1;
+
+	argc = setup_revisions(argc, argv, &rev, &opt);
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "--base"))
 			rev.max_count = 1;
diff --git a/builtin/diff.c b/builtin/diff.c
index 55e7d21755..ab2388b5bc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -393,6 +393,7 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
+	struct setup_revision_opt opt = { 0 };
 	struct rev_info rev;
 	struct object_array ent = OBJECT_ARRAY_INIT;
 	int first_non_parent = -1;
@@ -499,7 +500,14 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (nongit)
 		die(_("Not a git repository"));
-	argc = setup_revisions(argc, argv, &rev, NULL);
+
+	/*
+	 * We have our own handling for --ours/--theirs, so don't
+	 * restrict the revision ranges/paths.
+	 */
+	opt.ignore_ours_theirs = 1;
+
+	argc = setup_revisions(argc, argv, &rev, &opt);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		diff_setup_done(&rev.diffopt);
diff --git a/revision.c b/revision.c
index 00d5c29bfc..070b5dd73b 100644
--- a/revision.c
+++ b/revision.c
@@ -1978,8 +1978,10 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
 		die("--merge without MERGE_HEAD?");
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
-	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	if (revs->show_merge_ours)
+		add_pending_object(revs, &head->object, "HEAD");
+	if (revs->show_merge_theirs)
+		add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
@@ -2231,6 +2233,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	const char *optarg = NULL;
 	int argcount;
 	const unsigned hexsz = the_hash_algo->hexsz;
+	int parse_ours_theirs = !(opt && opt->ignore_ours_theirs);
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -2324,7 +2327,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->def = argv[1];
 		return 2;
 	} else if (!strcmp(arg, "--merge")) {
-		revs->show_merge = 1;
+		revs->show_merge_ours = 1;
+		revs->show_merge_theirs = 1;
+	} else if (parse_ours_theirs && !strcmp(arg, "--ours")) {
+		revs->show_merge_ours = 1;
+	} else if (parse_ours_theirs && !strcmp(arg, "--theirs")) {
+		revs->show_merge_theirs = 1;
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs->topo_order = 1;
@@ -2982,7 +2990,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->def = opt ? opt->def : NULL;
 	if (opt && opt->tweak)
 		opt->tweak(revs);
-	if (revs->show_merge)
+	if (revs->show_merge_ours | revs->show_merge_theirs)
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr && !revs->rev_input_given) {
 		struct object_id oid;
diff --git a/revision.h b/revision.h
index 94c43138bc..63effe69c7 100644
--- a/revision.h
+++ b/revision.h
@@ -253,7 +253,8 @@ struct rev_info {
 	int		show_notes;
 	unsigned int	shown_one:1,
 			shown_dashes:1,
-			show_merge:1,
+			show_merge_ours:1,
+			show_merge_theirs:1,
 			show_notes_given:1,
 			show_notes_by_default:1,
 			show_signature:1,
@@ -436,7 +437,8 @@ void repo_init_revisions(struct repository *r,
 struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *);
-	unsigned int	assume_dashdash:1,
+	unsigned int	ignore_ours_theirs:1,
+			assume_dashdash:1,
 			allow_exclude_promisor_objects:1,
 			free_removed_argv_elements:1;
 	unsigned revarg_opt;
diff --git a/t/t6440-rev-list-merge.sh b/t/t6440-rev-list-merge.sh
new file mode 100755
index 0000000000..d1d6af6f31
--- /dev/null
+++ b/t/t6440-rev-list-merge.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='git rev-list --merge/--ours/--theirs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_write_lines initial >file &&
+	git add file &&
+	git commit -m initial &&
+
+	git checkout -b ours main &&
+	test_write_lines ours >file &&
+	git commit -a -m ours &&
+
+	git checkout -b theirs main &&
+	test_write_lines theirs >file &&
+	git commit -a -m theirs &&
+
+	git checkout ours^0 &&
+	test_must_fail git merge theirs &&
+
+	INITIAL=$(git rev-parse main) &&
+	OURS=$(git rev-parse ours) &&
+	THEIRS=$(git rev-parse theirs)
+'
+
+test_expect_success 'git rev-list --merge' '
+	git rev-parse $OURS $THEIRS >expected &&
+	git rev-list --merge >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-list --ours' '
+	test $OURS = $(git rev-list --ours)
+'
+
+test_expect_success 'git rev-list --theirs' '
+	test $THEIRS = $(git rev-list --theirs)
+'
+
+test_done
-- 
2.34.1

