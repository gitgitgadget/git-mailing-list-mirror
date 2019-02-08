Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E811C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 01:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBHBNG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 20:13:06 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40518 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726799AbfBHBNF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Feb 2019 20:13:05 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x181CbXu013117;
        Thu, 7 Feb 2019 17:12:52 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qgv6hr9yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 07 Feb 2019 17:12:52 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Thu, 7 Feb 2019 20:12:50 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Thu, 7 Feb 2019 20:12:50 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id CD7EB220FFE8;
        Thu,  7 Feb 2019 17:12:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 0/2] add --combined-all-paths option to log and diff-tree
Date:   Thu, 7 Feb 2019 17:12:45 -0800
Message-ID: <20190208011247.21021-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.311.gb8408a6075
In-Reply-To: <20190204200754.16413-1-newren@gmail.com>
References: <20190204200754.16413-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:
  * Added a second patch that can be squashed in which will add
    'rename from' and 'copy from' extended headers.  I like it, but
    Junio sounded pessimistic about it.  See
    https://public-inbox.org/git/xmqqlg2rmazz.fsf@gitster-ct.c.googlers.com/
  * Micro fixes:
    * Renamed --combined-all-names to --combined-all-paths
    * Fixed formatting error (missed '+') in diff-generate-patch.txt
    * Marked tests which used tabs in filenames with FUNNYNAMES prereq
    * Added tests that didn't depend on FUNNYNAMES

Elijah Newren (2):
  log,diff-tree: add --combined-all-paths option
  squash! log,diff-tree: add --combined-all-paths option

 Documentation/diff-format.txt         | 20 +++++-
 Documentation/diff-generate-patch.txt | 20 ++++--
 Documentation/git-diff-tree.txt       | 11 +++-
 Documentation/rev-list-options.txt    |  7 +++
 builtin/diff-tree.c                   |  6 +-
 combine-diff.c                        | 91 +++++++++++++++++++++++----
 diff.h                                |  1 +
 revision.c                            |  6 ++
 revision.h                            |  1 +
 t/t4038-diff-combined.sh              | 88 ++++++++++++++++++++++++++
 10 files changed, 230 insertions(+), 21 deletions(-)

Range-diff:
1:  26c64cee8a ! 1:  2205640429 log,diff-tree: add --combined-all-names option
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>
     
    -    log,diff-tree: add --combined-all-names option
    +    log,diff-tree: add --combined-all-paths option
     
         The combined diff format for merges will only list one filename, even if
         rename or copy detection is active.  For example, with raw format one
    @@ -15,7 +15,7 @@
         of phooey.c were in either of the parents.  In contrast, for non-merge
         commits, raw format does provide original filenames (and a rename score
         to boot).  In order to also provide original filenames for merge
    -    commits, add a --combined-all-names option (which must be used with
    +    commits, add a --combined-all-paths option (which must be used with
         either -c or --cc, and is likely only useful with rename or copy
         detection active) so that we can print tab-separated filenames when
         renames are involved.  This transforms the above output to:
    @@ -38,8 +38,6 @@
           +++ b/phooey.c
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -    Message-Id: <20190204200754.16413-1-newren@gmail.com>
     
      diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
      --- a/Documentation/diff-format.txt
    @@ -54,17 +52,17 @@
     -Example:
     +For `-c` and `--cc`, only the destination or final path is shown even
     +if the file was renamed on any side of history.  With
    -+`--combined-all-names`, the name of the path in each parent is shown
    ++`--combined-all-paths`, the name of the path in each parent is shown
     +followed by the name of the path in the merge commit.
     +
    -+Examples for `-c` and `-cc` without `--combined-all-names`:
    ++Examples for `-c` and `-cc` without `--combined-all-paths`:
     +------------------------------------------------
     +::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c
     +::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
     +::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
     +------------------------------------------------
     +
    -+Examples when `--combined-all-names` added to either `-c` or `--cc`:
    ++Examples when `--combined-all-paths` added to either `-c` or `--cc`:
      
      ------------------------------------------------
     -::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
    @@ -79,9 +77,10 @@
      --- a/Documentation/diff-generate-patch.txt
      +++ b/Documentation/diff-generate-patch.txt
     @@
    + Similar to two-line header for traditional 'unified' diff
      format, `/dev/null` is used to signal created or deleted
      files.
    - 
    +++
     +However, if the --combined-all-paths option is provided, instead of a
     +two-line from-file/to-file you get a N+1 line from-file/to-file header,
     +where N is the number of parents in the merge commit
    @@ -94,10 +93,9 @@
     +This extended format can be useful if rename or copy detection is
     +active, to allow you to see the original name of the file in different
     +parents.
    -+
    + 
      4.   Chunk header format is modified to prevent people from
           accidentally feeding it to `patch -p1`. Combined diff format
    -      was created for review of merge commit changes, and was not
     
      diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
      --- a/Documentation/git-diff-tree.txt
    @@ -108,7 +106,7 @@
      'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
     -	      [-t] [-r] [-c | --cc] [--root] [<common diff options>]
     -	      <tree-ish> [<tree-ish>] [<path>...]
    -+	      [-t] [-r] [-c | --cc] [--combined-all-names] [--root]
    ++	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root]
     +	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
      
      DESCRIPTION
    @@ -117,7 +115,7 @@
      	itself and the commit log message is not shown, just like in any other
      	"empty diff" case.
      
    -+--combined-all-names::
    ++--combined-all-paths::
     +	This flag causes combined diffs (used for merge commits) to
     +	list the name of the file from all parents.  It thus only has
     +	effect when -c or --cc are specified, and is likely only
    @@ -135,7 +133,7 @@
      	the parents have only two variants and the merge result picks
      	one of them without modification.
      
    -+--combined-all-names::
    ++--combined-all-paths::
     +	This flag causes combined diffs (used for merge commits) to
     +	list the name of the file from all parents.  It thus only has
     +	effect when -c or --cc are specified, and is likely only
    @@ -159,7 +157,7 @@
      "  -r            diff recursively\n"
     +"  -c            show combined diff for merge commits\n"
     +"  --cc          show combined diff for merge commits removing uninteresting hunks\n"
    -+"  --combined-all-names\n"
    ++"  --combined-all-paths\n"
     +"                show name of file in all parents for combined diffs\n"
      "  --root        include the initial commit as diff against /dev/null\n"
      COMMON_DIFF_OPTIONS_HELP;
    @@ -182,7 +180,7 @@
     +	struct combine_diff_path *curr,
     +	int n,
     +	int num_parent,
    -+	int combined_all_names)
    ++	int combined_all_paths)
      {
      	struct diff_queue_struct *q = &diff_queued_diff;
      	struct combine_diff_path *p, **tail = &curr;
    @@ -196,7 +194,7 @@
      			p->parent[n].mode = q->queue[i]->one->mode;
      			p->parent[n].status = q->queue[i]->status;
     +
    -+			if (combined_all_names &&
    ++			if (combined_all_paths &&
     +			    filename_changed(p->parent[n].status)) {
     +				strbuf_init(&p->parent[n].path, 0);
     +				strbuf_addstr(&p->parent[n].path,
    @@ -210,7 +208,7 @@
      			/* p->path not in q->queue[]; drop it */
      			*tail = p->next;
     +			for (j = 0; j < num_parent; j++)
    -+				if (combined_all_names &&
    ++				if (combined_all_paths &&
     +				    filename_changed(p->parent[j].status))
     +					strbuf_release(&p->parent[j].path);
      			free(p);
    @@ -220,7 +218,7 @@
      		oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
      		p->parent[n].mode = q->queue[i]->one->mode;
      		p->parent[n].status = q->queue[i]->status;
    -+		if (combined_all_names &&
    ++		if (combined_all_paths &&
     +		    filename_changed(p->parent[n].status))
     +			strbuf_addstr(&p->parent[n].path,
     +				      q->queue[i]->one->path);
    @@ -237,7 +235,7 @@
     -	else
     -		dump_quoted_path("--- ", a_prefix, elem->path,
     -				 line_prefix, c_meta, c_reset);
    -+	if (rev->combined_all_names) {
    ++	if (rev->combined_all_paths) {
     +		for (i = 0; i < num_parent; i++) {
     +			char *path = filename_changed(elem->parent[i].status)
     +				? elem->parent[i].path.buf : elem->path;
    @@ -264,7 +262,7 @@
      	}
      
     +	for (i = 0; i < num_parent; i++)
    -+		if (rev->combined_all_names) {
    ++		if (rev->combined_all_paths) {
     +			if (filename_changed(p->parent[i].status))
     +				write_name_quoted(p->parent[i].path.buf, stdout,
     +						  inter_name_termination);
    @@ -282,7 +280,7 @@
     -	const struct oid_array *parents, struct diff_options *opt)
     +	const struct oid_array *parents,
     +	struct diff_options *opt,
    -+	int combined_all_names)
    ++	int combined_all_paths)
      {
      	struct combine_diff_path *paths = NULL;
      	int i, num_parent = parents->nr;
    @@ -292,7 +290,7 @@
      		diffcore_std(opt);
     -		paths = intersect_paths(paths, i, num_parent);
     +		paths = intersect_paths(paths, i, num_parent,
    -+					combined_all_names);
    ++					combined_all_paths);
      
      		/* if showing diff, show it in requested order */
      		if (opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
    @@ -302,7 +300,7 @@
      		 */
     -		paths = find_paths_generic(oid, parents, &diffopts);
     +		paths = find_paths_generic(oid, parents, &diffopts,
    -+					   rev->combined_all_names);
    ++					   rev->combined_all_paths);
      	}
      	else {
      		int stat_opt;
    @@ -311,7 +309,7 @@
      		struct combine_diff_path *tmp = paths;
      		paths = paths->next;
     +		for (i = 0; i < num_parent; i++)
    -+			if (rev->combined_all_names &&
    ++			if (rev->combined_all_paths &&
     +			    filename_changed(tmp->parent[i].status))
     +				strbuf_release(&tmp->parent[i].path);
      		free(tmp);
    @@ -337,9 +335,9 @@
      		revs->diff = 1;
      		revs->dense_combined_merges = 0;
      		revs->combine_merges = 1;
    -+	} else if (!strcmp(arg, "--combined-all-names")) {
    ++	} else if (!strcmp(arg, "--combined-all-paths")) {
     +		revs->diff = 1;
    -+		revs->combined_all_names = 1;
    ++		revs->combined_all_paths = 1;
      	} else if (!strcmp(arg, "--cc")) {
      		revs->diff = 1;
      		revs->dense_combined_merges = 1;
    @@ -347,8 +345,8 @@
      	}
      	if (revs->combine_merges)
      		revs->ignore_merges = 0;
    -+	if (revs->combined_all_names && !revs->combine_merges)
    -+		die("--combined-all-names makes no sense without -c or --cc");
    ++	if (revs->combined_all_paths && !revs->combine_merges)
    ++		die("--combined-all-paths makes no sense without -c or --cc");
     +
      	revs->diffopt.abbrev = revs->abbrev;
      
    @@ -361,7 +359,7 @@
      			verbose_header:1,
      			ignore_merges:1,
      			combine_merges:1,
    -+			combined_all_names:1,
    ++			combined_all_paths:1,
      			dense_combined_merges:1,
      			always_show_header:1;
      
    @@ -373,20 +371,61 @@
      	test_cmp expect actual
      '
      
    -+test_expect_success 'setup for --combined-with-paths' '
    ++test_expect_success 'setup for --combined-all-paths' '
     +	git branch side1c &&
     +	git branch side2c &&
     +	git checkout side1c &&
    ++	test_seq 1 10 >filename-side1c &&
    ++	git add filename-side1c &&
    ++	git commit -m with &&
    ++	git checkout side2c &&
    ++	test_seq 1 9 >filename-side2c &&
    ++	echo ten >>filename-side2c &&
    ++	git add filename-side2c &&
    ++	git commit -m iam &&
    ++	git checkout -b mergery side1c &&
    ++	git merge --no-commit side2c &&
    ++	git rm filename-side1c &&
    ++	echo eleven >>filename-side2c &&
    ++	git mv filename-side2c filename-merged &&
    ++	git add filename-merged &&
    ++	git commit
    ++'
    ++
    ++test_expect_success '--combined-all-paths and --raw' '
    ++	cat <<-\EOF >expect &&
    ++	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	filename-side1c	filename-side2c	filename-merged
    ++	EOF
    ++	git diff-tree -c -M --raw --combined-all-paths HEAD >actual.tmp &&
    ++	sed 1d <actual.tmp >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success '--combined-all-paths and --cc' '
    ++	cat <<-\EOF >expect &&
    ++	--- a/filename-side1c
    ++	--- a/filename-side2c
    ++	+++ b/filename-merged
    ++	EOF
    ++	git diff-tree --cc -M --combined-all-paths HEAD >actual.tmp &&
    ++	grep ^[-+][-+][-+] <actual.tmp >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names' '
    ++	git branch side1d &&
    ++	git branch side2d &&
    ++	git checkout side1d &&
     +	test_seq 1 10 >$(printf "file\twith\ttabs") &&
     +	git add file* &&
     +	git commit -m with &&
    -+	git checkout side2c &&
    ++	git checkout side2d &&
     +	test_seq 1 9 >$(printf "i\tam\ttabbed") &&
     +	echo ten >>$(printf "i\tam\ttabbed") &&
     +	git add *tabbed &&
     +	git commit -m iam &&
    -+	git checkout -b mergery side1c &&
    -+	git merge --no-commit side2c &&
    ++	git checkout -b funny-names-mergery side1d &&
    ++	git merge --no-commit side2d &&
     +	git rm *tabs &&
     +	echo eleven >>$(printf "i\tam\ttabbed") &&
     +	git mv "$(printf "i\tam\ttabbed")" "$(printf "fickle\tnaming")" &&
    @@ -394,28 +433,28 @@
     +	git commit
     +'
     +
    -+test_expect_success '--combined-all-names and --raw' '
    ++test_expect_success FUNNYNAMES '--combined-all-paths and --raw and funny names' '
     +	cat <<-\EOF >expect &&
     +	::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR	"file\twith\ttabs"	"i\tam\ttabbed"	"fickle\tnaming"
     +	EOF
    -+	git diff-tree -c -M --raw --combined-all-names HEAD >actual.tmp &&
    ++	git diff-tree -c -M --raw --combined-all-paths HEAD >actual.tmp &&
     +	sed 1d <actual.tmp >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--combined-all-names and --raw -and -z' '
    -+	printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
    -+	git diff-tree -c -M --raw --combined-all-names -z HEAD >actual &&
    ++test_expect_success FUNNYNAMES '--combined-all-paths and --raw -and -z and funny names' '
    ++	printf "aaf8087c3cbd4db8e185a2d074cf27c53cfb75d7\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
    ++	git diff-tree -c -M --raw --combined-all-paths -z HEAD >actual &&
     +	test_cmp -a expect actual
     +'
     +
    -+test_expect_success '--combined-all-names and --cc' '
    ++test_expect_success FUNNYNAMES '--combined-all-paths and --cc and funny names' '
     +	cat <<-\EOF >expect &&
     +	--- "a/file\twith\ttabs"
     +	--- "a/i\tam\ttabbed"
     +	+++ "b/fickle\tnaming"
     +	EOF
    -+	git diff-tree --cc -M --combined-all-names HEAD >actual.tmp &&
    ++	git diff-tree --cc -M --combined-all-paths HEAD >actual.tmp &&
     +	grep ^[-+][-+][-+] <actual.tmp >actual &&
     +	test_cmp expect actual
     +'
2:  d93e6c5fee < -:  ---------- SQUASH??? fix mark-up
-:  ---------- > 2:  b8408a6075 squash! log,diff-tree: add --combined-all-paths option
-- 
2.20.1.311.gb8408a6075

