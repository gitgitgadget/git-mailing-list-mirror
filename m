Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2401F404
	for <e@80x24.org>; Wed, 11 Apr 2018 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeDKW4M (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 18:56:12 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34502 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeDKW4K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 18:56:10 -0400
Received: by mail-lf0-f46.google.com with SMTP id x125-v6so4945896lff.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BAt5Q1wB9llrBTEitfpK+nEEQUCGSGcMKE2p1HqQsPg=;
        b=gn6jt5ifGU86K0h4v2Yy2hqGTC9fwdFUCuUhtpEOvfcylpboO4WkDAZ1LoeKFmV2eE
         kv1a98n3DnN9vij2KpyP1KFvLy+JFn8rzZFqUl3/1l10ME70/2fAoEU5VR/zda6gNxJ6
         U6sYSha7Jaqa9ySlEe1518bjRkTS1kaZsNvUik75Be6+8baFAtX84zzbBQpGPnmYEhNe
         S+GevbWeMx4ULqq8eLed9uDiSv+MAhRTmDG+MlpNK9TqPKnJPpaRb+GHbEfH3IAxkAmo
         z/Vgu+vIMmHUL7qWKEBCbfHDzAVRI94VrkUuRuggmNrI0FZbic3dbHBBZ1/SB1iM7KUv
         GRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BAt5Q1wB9llrBTEitfpK+nEEQUCGSGcMKE2p1HqQsPg=;
        b=kWxzsOaDedoXOXB2upVCKh76DQOVvmL2nMeCY3o9QKpJyuyAoZI6U86kcZoCwBFl7b
         5PQb/iP37az9CVLAyXkY9TvHDdPerxG+SYHHNVKhUwBv82xoqVDw2exFaoh+b2bhWPTw
         jzY4JL1WbQDf3s8SV15DJPKdoQDrnzzKEHHuS2JThjGuwY+okapb2+b6H5lX8A4xDjs9
         dnNVIQo5aqpduBxi/6NHTnH/vkuV5t0RGNG8t13yWMd3x1wOQyTNHbrWH50ObPFy2UMS
         ftUoOfB9EOd7S0skZDmyijphOpOgS4gwC+vdAIQacCoYFUOnhTWVRJIlut6VlRULBmPd
         VVxw==
X-Gm-Message-State: ALQs6tCJSHZGmz9dEf4MjobQFXxvYbeMQPcIEgAPSCOhizPwqog2GVdZ
        WzZPJOHJ+xmwT7JW/cVQe2yJvG3c
X-Google-Smtp-Source: AIpwx49Oee+7oKxPt/r/cz+lVPCWrd3CwdPJPTCOSmM8jrrijvtegT2B9U/ysU9pLWcV1u+itko7zw==
X-Received: by 2002:a19:fc0d:: with SMTP id a13-v6mr4143529lfi.136.1523487368360;
        Wed, 11 Apr 2018 15:56:08 -0700 (PDT)
Received: from localhost.localdomain (c-5eea22f7-74736162.cust.telenor.se. [94.234.34.247])
        by smtp.gmail.com with ESMTPSA id h9-v6sm433263lfj.78.2018.04.11.15.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 15:56:07 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH] Create '--merges-only' option for 'git bisect'
Date:   Thu, 12 Apr 2018 00:55:34 +0200
Message-Id: <20180411225534.48658-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ran with '--merges-only', git bisect will only look at merge commits -- commits with 2 or more parents or the initial commit.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---

Notes:
    Proof of concept of a feature that I have wanted in Git for a while. In my daily work my company uses GitHub, which creates lots of merge commits. In general, tests are only ran on the tip of a branch before merging, so the different commits within a merge commit are allowed not to be buildable. Therefore 'git bisect' often doesn't work since it will give lots of false positives for anything that is not a merge commit. If we could have a feature to only bisect merge commits then it would be easier to pinpoint which merge causes any particular issue. After that, a bisect could be done within the merge to pinpoint futher. As a follow-up to this patch -- we could potentially create a feature that automatically continues into regular bisect within the bad merge commit after completed '--merges-only' bisection.

 bisect.c                        |  87 ++++++++++++++++++++++++++----
 bisect.h                        |   4 +-
 builtin/bisect--helper.c        |  28 +++++++++-
 builtin/rev-list.c              |   2 +-
 git-bisect.sh                   |   5 ++
 t/t6070-bisect-merge-commits.sh | 116 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 228 insertions(+), 14 deletions(-)
 create mode 100755 t/t6070-bisect-merge-commits.sh

diff --git a/bisect.c b/bisect.c
index a579b5088..e8a2f77c7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -254,7 +254,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights,
-					     int find_all)
+					     int find_all, int only_merge_commits)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -266,6 +266,13 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		unsigned flags = commit->object.flags;
 
 		p->item->util = &weights[n++];
+
+		if (only_merge_commits) {
+			weight_set(p, -2);
+			counted++;
+			continue;
+		}
+
 		switch (count_interesting_parents(commit)) {
 		case 0:
 			if (!(flags & TREESAME)) {
@@ -305,11 +312,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * way, and then fill the blanks using cheaper algorithm.
 	 */
 	for (p = list; p; p = p->next) {
+		int distance;
 		if (p->item->object.flags & UNINTERESTING)
 			continue;
 		if (weight(p) != -2)
 			continue;
-		weight_set(p, count_distance(p));
+
+		if (only_merge_commits)
+			distance = count_distance(p) - 1;
+		else
+			distance = count_distance(p);
+		weight_set(p, distance);
 		clear_distance(list);
 
 		/* Does it happen to be at exactly half-way? */
@@ -330,11 +343,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			for (q = p->item->parents; q; q = q->next) {
 				if (q->item->object.flags & UNINTERESTING)
 					continue;
+				if (!q->item->util)
+					break;
 				if (0 <= weight(q))
 					break;
 			}
 			if (!q)
 				continue;
+			if (!q->item->util) {
+				counted++;
+				continue;
+			}
 
 			/*
 			 * weight for p is unknown but q is known.
@@ -364,8 +383,43 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		return best_bisection_sorted(list, nr);
 }
 
+int merge_commit_or_root(const struct commit c)
+{
+	if (!c.parents)
+		return 1;
+
+	return !!c.parents->next;
+}
+
+void filter_non_merge_commits(struct commit_list **commit_list)
+{
+	struct commit_list *list1 = *commit_list;
+	struct commit_list *list2 = NULL;
+	*commit_list = NULL;
+
+	for ( ; list1; list1 = list1->next) {
+		if (merge_commit_or_root(*list1->item)) {
+			list2 = list1;
+			list1 = list1->next;
+			list2->next = NULL;
+			list2->item->parents = NULL;
+			*commit_list = list2;
+			break;
+		}
+	}
+
+	for ( ; list1; list1 = list1->next) {
+		list2->next = NULL;
+		if (merge_commit_or_root(*list1->item)) {
+			list2->next = list1;
+			list2 = list2->next;
+			list2->item->parents = list1;
+		}
+	}
+}
+
 void find_bisection(struct commit_list **commit_list, int *reaches,
-		    int *all, int find_all)
+		    int *all, int find_all, int only_merge_commits)
 {
 	int nr, on_list;
 	struct commit_list *list, *p, *best, *next, *last;
@@ -373,6 +427,10 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 
 	show_list("bisection 2 entry", 0, 0, *commit_list);
 
+	if (only_merge_commits) {
+		filter_non_merge_commits(commit_list);
+	}
+
 	/*
 	 * Count the number of total and tree-changing items on the
 	 * list, while reversing the list.
@@ -400,7 +458,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	weights = xcalloc(on_list, sizeof(*weights));
 
 	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, nr, weights, find_all);
+	best = do_find_bisection(list, nr, weights, find_all, only_merge_commits);
 	if (best) {
 		if (!find_all) {
 			list->item = best->item;
@@ -878,7 +936,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 /*
  * This does "git diff-tree --pretty COMMIT" without one fork+exec.
  */
-static void show_diff_tree(const char *prefix, struct commit *commit)
+static void show_diff_tree(const char *prefix, struct commit *commit, int only_merge_commits)
 {
 	struct rev_info opt;
 
@@ -893,6 +951,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	opt.use_terminator = 0;
 	opt.commit_format = CMIT_FMT_DEFAULT;
 
+	if (only_merge_commits) {
+		opt.ignore_merges = 0;
+		opt.combine_merges = 1;
+	}
+
 	/* diff-tree init */
 	if (!opt.diffopt.output_format)
 		opt.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -938,7 +1001,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(const char *prefix, int no_checkout)
+int bisect_next_all(const char *prefix, int no_checkout, int only_merge_commits)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -957,7 +1020,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	bisect_common(&revs);
 
-	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr);
+	find_bisection(&revs.commits, &reaches, &all, !!skipped_revs.nr, only_merge_commits);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
@@ -983,10 +1046,14 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (!oidcmp(bisect_rev, current_bad_oid)) {
+		char *format_string = NULL;
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
-			term_bad);
-		show_diff_tree(prefix, revs.commits->item);
+		if (only_merge_commits)
+			format_string = "%s is the first %s merge\n";
+		else
+			format_string = "%s is the first %s commit\n";
+		printf(format_string, oid_to_hex(bisect_rev), term_bad);
+		show_diff_tree(prefix, revs.commits->item, only_merge_commits);
 		/* This means the bisection process succeeded. */
 		exit(10);
 	}
diff --git a/bisect.h b/bisect.h
index a5d9248a4..664ada180 100644
--- a/bisect.h
+++ b/bisect.h
@@ -9,7 +9,7 @@
  * best commit, as chosen by `find_all`.
  */
 extern void find_bisection(struct commit_list **list, int *reaches, int *all,
-			   int find_all);
+			   int find_all, int only_merge_commits);
 
 extern struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
@@ -28,7 +28,7 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix, int no_checkout);
+extern int bisect_next_all(const char *prefix, int no_checkout, int only_merge_commits);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b5fadcbe..9d7a1dd23 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -106,6 +106,32 @@ static void check_expected_revs(const char **revs, int rev_nr)
 	}
 }
 
+static GIT_PATH_FUNC(git_path_bisect_merges_only, "MERGES_ONLY_BISECT")
+
+static int merges_only(void)
+{
+	const char *filename = git_path_bisect_merges_only();
+	struct stat st;
+	struct strbuf str = STRBUF_INIT;
+	FILE *fp;
+	int res = 0;
+
+	if (stat(filename, &st) || !S_ISREG(st.st_mode))
+		return 0;
+
+	fp = fopen_or_warn(filename, "r");
+	if (!fp)
+		return 0;
+
+	if (strbuf_getline_lf(&str, fp) != EOF)
+		res = atoi(str.buf);
+
+	strbuf_release(&str);
+	fclose(fp);
+
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -137,7 +163,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case NEXT_ALL:
-		return bisect_next_all(prefix, no_checkout);
+		return bisect_next_all(prefix, no_checkout, merges_only());
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index fadd3ec14..cacffe6c6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -538,7 +538,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (bisect_list) {
 		int reaches, all;
 
-		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
+		find_bisection(&revs.commits, &reaches, &all, bisect_find_all, 0);
 
 		if (bisect_show_vars)
 			return show_bisect_vars(&info, reaches, all);
diff --git a/git-bisect.sh b/git-bisect.sh
index 54cbfecc5..730c983c5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -82,6 +82,7 @@ bisect_start() {
 	bad_seen=0
 	eval=''
 	must_write_terms=0
+	merges_only=0
 	revs=''
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
@@ -96,6 +97,9 @@ bisect_start() {
 			shift
 			break
 		;;
+		--merges-only)
+			merges_only=1
+			shift ;;
 		--no-checkout)
 			mode=--no-checkout
 			shift ;;
@@ -212,6 +216,7 @@ bisect_start() {
 		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
+	echo "$merges_only" >"$GIT_DIR/MERGES_ONLY_BISECT" || exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
diff --git a/t/t6070-bisect-merge-commits.sh b/t/t6070-bisect-merge-commits.sh
new file mode 100755
index 000000000..edfae0cfd
--- /dev/null
+++ b/t/t6070-bisect-merge-commits.sh
@@ -0,0 +1,116 @@
+#!/bin/sh
+#
+# Copyright (c) 2018 Harald Nordgren
+#
+test_description='Tests git bisect merge commit functionality'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+add_line_into_file()
+{
+    _line=$1
+    _file=$2
+
+    if [ -f "$_file" ]; then
+        echo "$_line" >> $_file || return $?
+        MSG="Add <$_line> into <$_file>."
+    else
+        echo "$_line" > $_file || return $?
+        git add $_file || return $?
+        MSG="Create file <$_file> with <$_line> inside."
+    fi
+
+    test_tick
+    git commit --quiet -m "$MSG" $_file
+}
+
+create_merge_commit()
+{
+    _branch=$1
+    _file=$2
+
+     git checkout -b $_branch &&
+     add_line_into_file "hello" $_file &&
+     git checkout master &&
+     git merge $_branch --no-edit --no-ff
+}
+
+HASH1=
+HASH2=
+HASH3=
+HASH4=
+HASH5=
+HASH6=
+
+test_expect_success 'set up basic repo with 3 files and 3 merge commits' '
+    add_line_into_file "hello" hello &&
+    HASH1=$(git rev-parse --verify HEAD) &&
+
+    add_line_into_file "hello" hello &&
+    git checkout -b branch1 &&
+    add_line_into_file "hello" hello1 &&
+    git checkout master &&
+    git checkout -b branch2 &&
+    add_line_into_file "hello" hello2 &&
+    git checkout master &&
+    git checkout -b branch3 &&
+    add_line_into_file "hello" hello3 &&
+    git checkout master &&
+    git merge branch1 --no-edit --no-ff &&
+    HASH2=$(git rev-parse --verify HEAD) &&
+
+    add_line_into_file "hello" hello &&
+    add_line_into_file "hello" hello &&
+    git merge branch2 --no-edit --no-ff &&
+    git merge branch3 --no-edit --no-ff &&
+    HASH3=$(git rev-parse --verify HEAD) &&
+
+    add_line_into_file "hello" hello &&
+    HASH4=$(git rev-parse --verify HEAD) &&
+
+    create_merge_commit branch4 hello4 &&
+    create_merge_commit branch5 hello5 &&
+    create_merge_commit branch6 hello6 &&
+    create_merge_commit branch7 hello7 &&
+    create_merge_commit branch8 hello8 &&
+    create_merge_commit branch9 hello9 &&
+    create_merge_commit branch10 hello10 &&
+    create_merge_commit branch11 hello11 &&
+    create_merge_commit branch12 hello12 &&
+    create_merge_commit branch13 hello13 &&
+    create_merge_commit branch14 hello14 &&
+    create_merge_commit branch15 hello15 &&
+    create_merge_commit branch16 hello16 &&
+    HASH5=$(git rev-parse --verify HEAD) &&
+
+    create_merge_commit branch17 hello17 &&
+    create_merge_commit branch18 hello18 &&
+    create_merge_commit branch19 hello19 &&
+    create_merge_commit branch20 hello20 &&
+    HASH6=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success 'bisect skip: successful result' '
+	test_when_finished git bisect reset &&
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 --merges-only &&
+	git bisect good &&
+	git bisect good &&
+	git bisect bad > my_bisect_log.txt &&
+	grep "$HASH3 is the first bad merge" my_bisect_log.txt
+'
+
+test_expect_success 'bisect skip: successful result' '
+	test_when_finished git bisect reset &&
+	git bisect reset &&
+	git bisect start $HASH6 $HASH2 --merges-only &&
+	git bisect good &&
+	git bisect good &&
+	git bisect bad &&
+	git bisect bad > my_bisect_log.txt &&
+	grep "$HASH5 is the first bad merge" my_bisect_log.txt
+'
+
+test_done
-- 
2.14.3 (Apple Git-98)

