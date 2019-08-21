Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A7C1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 11:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHULEj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 07:04:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfHULEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 07:04:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so1661290wml.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjdNGVRrarQeWuY8s5otAf5oHS4ssUMaLsGGBJP9a3c=;
        b=gWu2W03Bml8rJg9dT6ODYqEazlbMu2tOuTaMvkmcTRsVG/6ilso1cTVv35KoBqJkLk
         QLC4tQeiutgjNUxIXc8MXLLyt0wDhvzAma5YMI1qwUA/UgElLJLlHTSrjTkPwKmFm1KY
         8rkTPd+xsplvXU3I4xblCR3g0kkjP4GQUkG77TnCOw4G2QxA8/8mXy/uil33OVB+4jEK
         paBOWqmqIuNSaBD6AuU3KkWl44lrxHnAxBY9KYt2p66c33BRbm3yhndvGMKmv8lJuawI
         7SeiHegPFPY8S+8WphCCktBKSfRDZKbWmNbk3OCSFmLH2dcsc6LzMJMFUe92oLPADGTo
         f1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjdNGVRrarQeWuY8s5otAf5oHS4ssUMaLsGGBJP9a3c=;
        b=eflKoxvVoaMky3IdXiROkEUgWkj7MnowHl6BjfqhjUD18HIxic1JD9YjUQJaUosJv5
         QfvLe9lR3SdpuVb5QR9I7p/P6FmfnEYBDcw0v7zUpzoTZ1AbXvKDkjMQ18V842yVR0Sm
         1dZeQ/CeIbQTDg4qciflfH4SSiaf2mChxvI0hN2q1QQNQmdzlalBlbmsucct7Ey4MHUd
         CHbLFNbbcNpEZbzdcWysC6c5zQgEjUsyiLa3mka2QHgVJgx5Km19urTBSsq8MTNWqLnY
         ta9+GwQeoNEBLhbkgWZikAfoSUYFwmceF/Cig1EGXOhTHYyyHizDU+HKyLQu5of7rWAl
         M+SA==
X-Gm-Message-State: APjAAAWQn97O/+awdSmvfTF1MtMjlJChlnzfI+SkTDpIl9V18JycP9/4
        JrL15zlzxlJGFWXMDyST+jBDZbAR
X-Google-Smtp-Source: APXvYqxzMljA6W7y+MW7Pm4T/MiP5ITkQnRXAUaqCmvHissUBXO9+UXtXICDUDxni87Q52ZqU7vRQA==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr5623398wmc.7.1566385476542;
        Wed, 21 Aug 2019 04:04:36 -0700 (PDT)
Received: from localhost.localdomain (x4db50904.dyn.telefonica.de. [77.181.9.4])
        by smtp.gmail.com with ESMTPSA id c15sm61648441wrb.80.2019.08.21.04.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Aug 2019 04:04:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] line-log: avoid unnecessary full tree diffs
Date:   Wed, 21 Aug 2019 13:04:24 +0200
Message-Id: <20190821110424.18184-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.352.gebb2b55eae
In-Reply-To: <20190821110424.18184-1-szeder.dev@gmail.com>
References: <20190821110424.18184-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With rename detection enabled the line-level log is able to trace the
evolution of line ranges across whole-file renames [1].  Alas, to
achieve that it uses the diff machinery very inefficiently, making the
operation very slow [2].  And since rename detection is enabled by
default, the line-level log is very slow by default.

When the line-level log processes a commit with rename detection
enabled, it currently does the following (see queue_diffs()):

  1. Computes a full tree diff between the commit and (one of) its
     parent(s), i.e. invokes diff_tree_oid() with an empty
     'diffopt->pathspec'.
  2. Checks whether any paths in the line ranges were modified.
  3. Checks whether any modified paths in the line ranges are missing
     in the parent commit's tree.
  4. If there is such a missing path, then calls diffcore_std() to
     figure out whether the path was indeed renamed based on the
     previously computed full tree diff.
  5. Continues doing stuff that are unrelated to the slowness.

So basically the line-level log computes a full tree diff for each
commit-parent pair in step (1) to be used for rename detection in step
(4) in the off chance that an interesting path is missing from the
parent.

Avoid these expensive and mostly unnecessary full tree diffs by
limiting the diffs to paths in the line ranges.  This is much cheaper,
and makes step (2) unnecessary.  If it turns out that an interesting
path is missing from the parent, then fall back and compute a full
tree diff, so the rename detection will still work.

Care must be taken when to update the pathspec used to limit the diff
in case of renames.  A path might be renamed on one branch and
modified on several parallel running branches, and while processing
commits on these branches the line-level log might have to alternate
between looking at a path's new and old name.  However, at any one
time there is only a single 'diffopt->pathspec'.

So add a step (0) to the above to ensure that the paths in the
pathspec match the paths in the line ranges associated with the
currently processed commit, and re-parse the pathspec from the paths
in the line ranges if they differ.

The new test cases include a specially crafted piece of history with
two merged branches and two files, where each branch modifies both
files, renames on of them, and then modifies both again.  Then two
separate 'git log -L' invocations check the line-level log of each of
those two files, which ensures that at least one of those invocations
have to do that back-and-forth between the file's old and new name (no
matter which branch is traversed first).  't/t4211-line-log.sh'
already contains two tests involving renames, they don't don't trigger
this back-and-forth.

Avoiding these unnecessary full tree diffs can have huge impact on
performance, especially in big repositories with big trees and mergy
history.  Tracing the evolution of a function through the whole
history:

  # git.git
  $ time git --no-pager log -L:read_alternate_refs:sha1-file.c v2.23.0

  Before:

    real    0m8.874s
    user    0m8.816s
    sys     0m0.057s

  After:

    real    0m2.516s
    user    0m2.456s
    sys     0m0.060s

  # linux.git
  $ time ~/src/git/git --no-pager log \
    -L:build_restore_work_registers:arch/mips/mm/tlbex.c v5.2

  Before:

    real    3m50.033s
    user    3m48.041s
    sys     0m0.300s

  After:

    real    0m2.599s
    user    0m2.466s
    sys     0m0.157s

That's just over 88x speedup.

[1] Line-level log's rename following is quite similar to 'git log
    --follow path', with the notable differences that it does handle
    multiple paths at once as well, and that it doesn't show the
    commit performing the rename if it's an exact rename.

[2] This slowness might not have been apparent initially, because back
    when the line-level log feature was introduced rename detection
    was not yet enabled by default; 12da1d1f6f (Implement line-history
    search (git log -L), 2013-03-28) and 5404c116aa (diff: activate
    diff.renames by default, 2016-02-25).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c          | 43 ++++++++++++++++++++----
 t/t4211-line-log.sh | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index fddd91f060..9010e00950 100644
--- a/line-log.c
+++ b/line-log.c
@@ -737,6 +737,22 @@ static struct line_log_data *lookup_line_range(struct rev_info *revs,
 	return ret;
 }
 
+static int same_paths_in_pathspec_and_range(struct pathspec *pathspec,
+					    struct line_log_data *range)
+{
+	int i;
+	struct line_log_data *r;
+
+	for (i = 0, r = range; i < pathspec->nr && r; i++, r = r->next)
+		if (strcmp(pathspec->items[i].match, r->path))
+			return 0;
+	if (i < pathspec->nr || r)
+		/* different number of pathspec items and ranges */
+		return 0;
+
+	return 1;
+}
+
 static void parse_pathspec_from_ranges(struct pathspec *pathspec,
 				       struct line_log_data *range)
 {
@@ -762,8 +778,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	range = parse_lines(rev->diffopt.repo, commit, prefix, args);
 	add_line_range(rev, commit, range);
 
-	if (!rev->diffopt.detect_rename)
-		parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
+	parse_pathspec_from_ranges(&rev->diffopt.pathspec, range);
 }
 
 static void move_diff_queue(struct diff_queue_struct *dst,
@@ -821,15 +836,29 @@ static void queue_diffs(struct line_log_data *range,
 			struct diff_queue_struct *queue,
 			struct commit *commit, struct commit *parent)
 {
+	struct object_id *tree_oid, *parent_tree_oid;
+
 	assert(commit);
 
+	tree_oid = get_commit_tree_oid(commit);
+	parent_tree_oid = parent ? get_commit_tree_oid(parent) : NULL;
+
+	if (opt->detect_rename &&
+	    !same_paths_in_pathspec_and_range(&opt->pathspec, range)) {
+		clear_pathspec(&opt->pathspec);
+		parse_pathspec_from_ranges(&opt->pathspec, range);
+	}
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
-		      get_commit_tree_oid(commit), "", opt);
-	if (opt->detect_rename) {
+	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
+	if (opt->detect_rename && diff_might_be_rename()) {
+		/* must look at the full tree diff to detect renames */
+		clear_pathspec(&opt->pathspec);
+		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+
+		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
+
 		filter_diffs_for_paths(range, 1);
-		if (diff_might_be_rename())
-			diffcore_std(opt);
+		diffcore_std(opt);
 		filter_diffs_for_paths(range, 0);
 	}
 	move_diff_queue(queue, &diff_queued_diff);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1db7bd0f59..8319163744 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -132,4 +132,86 @@ test_expect_success '--raw is forbidden' '
 	test_must_fail git log -L1,24:b.c --raw
 '
 
+test_expect_success 'setup for checking fancy rename following' '
+	git checkout --orphan moves-start &&
+	git reset --hard &&
+
+	printf "%s\n"    12 13 14 15      b c d e   >file-1 &&
+	printf "%s\n"    22 23 24 25      B C D E   >file-2 &&
+	git add file-1 file-2 &&
+	test_tick &&
+	git commit -m "Add file-1 and file-2" &&
+	oid_add_f1_f2=$(git rev-parse --short HEAD) &&
+
+	git checkout -b moves-main &&
+	printf "%s\n" 11 12 13 14 15      b c d e   >file-1 &&
+	git commit -a -m "Modify file-1 on main" &&
+	oid_mod_f1_main=$(git rev-parse --short HEAD) &&
+
+	printf "%s\n" 21 22 23 24 25      B C D E   >file-2 &&
+	git commit -a -m "Modify file-2 on main #1" &&
+	oid_mod_f2_main_1=$(git rev-parse --short HEAD) &&
+
+	git mv file-1 renamed-1 &&
+	git commit -m "Rename file-1 to renamed-1 on main" &&
+
+	printf "%s\n" 11 12 13 14 15      b c d e f >renamed-1 &&
+	git commit -a -m "Modify renamed-1 on main" &&
+	oid_mod_r1_main=$(git rev-parse --short HEAD) &&
+
+	printf "%s\n" 21 22 23 24 25      B C D E F >file-2 &&
+	git commit -a -m "Modify file-2 on main #2" &&
+	oid_mod_f2_main_2=$(git rev-parse --short HEAD) &&
+
+	git checkout -b moves-side moves-start &&
+	printf "%s\n"    12 13 14 15 16   b c d e   >file-1 &&
+	git commit -a -m "Modify file-1 on side #1" &&
+	oid_mod_f1_side_1=$(git rev-parse --short HEAD) &&
+
+	printf "%s\n"    22 23 24 25 26   B C D E   >file-2 &&
+	git commit -a -m "Modify file-2 on side" &&
+	oid_mod_f2_side=$(git rev-parse --short HEAD) &&
+
+	git mv file-2 renamed-2 &&
+	git commit -m "Rename file-2 to renamed-2 on side" &&
+
+	printf "%s\n"    12 13 14 15 16 a b c d e   >file-1 &&
+	git commit -a -m "Modify file-1 on side #2" &&
+	oid_mod_f1_side_2=$(git rev-parse --short HEAD) &&
+
+	printf "%s\n"    22 23 24 25 26 A B C D E   >renamed-2 &&
+	git commit -a -m "Modify renamed-2 on side" &&
+	oid_mod_r2_side=$(git rev-parse --short HEAD) &&
+
+	git checkout moves-main &&
+	git merge moves-side &&
+	oid_merge=$(git rev-parse --short HEAD)
+'
+
+test_expect_success 'fancy rename following #1' '
+	cat >expect <<-EOF &&
+	$oid_merge Merge branch '\''moves-side'\'' into moves-main
+	$oid_mod_f1_side_2 Modify file-1 on side #2
+	$oid_mod_f1_side_1 Modify file-1 on side #1
+	$oid_mod_r1_main Modify renamed-1 on main
+	$oid_mod_f1_main Modify file-1 on main
+	$oid_add_f1_f2 Add file-1 and file-2
+	EOF
+	git log -L1:renamed-1 --oneline --no-patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fancy rename following #2' '
+	cat >expect <<-EOF &&
+	$oid_merge Merge branch '\''moves-side'\'' into moves-main
+	$oid_mod_r2_side Modify renamed-2 on side
+	$oid_mod_f2_side Modify file-2 on side
+	$oid_mod_f2_main_2 Modify file-2 on main #2
+	$oid_mod_f2_main_1 Modify file-2 on main #1
+	$oid_add_f1_f2 Add file-1 and file-2
+	EOF
+	git log -L1:renamed-2 --oneline --no-patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.352.gebb2b55eae

