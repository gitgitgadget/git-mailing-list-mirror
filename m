Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8339FC2D0EC
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4826A206A1
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2OZVbFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDKBDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:03:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38147 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgDKBDI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 21:03:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id f20so4412373wmh.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/pAlhTV2VI3Fe2zoXUXryFeLmak93OLBNBWVSPFoTU=;
        b=T2OZVbFXtGJRUiUOTNeM7T5UiYzDVCgvKrxNhC8N+ZM+faEnbgAQBxCMhTrV3P3XUk
         7OCaMJNGs+ifXNRwM+qOxyQe0yXL3VRk9Hm08RDPC2xMGTU9nwYXQIr3I9gLVhiPirMj
         qWyTrb/GKVeMbLbYz3V0s+Bg5zKShWXthnOXINHzv5yL3MCvP2A6ARkzXPlUdno1IJHA
         +A5g5ZImoGU2eH7tY93Exgj83HcnldF6qi69qyNl+dIlj6QUV4weOM9ujJLdtBN8YcAO
         yl34PPc53hLPtp0QYJAFuJ3rFQ2zMgsil+TMti2cADB82ATBZCRxtcLRfrdjS39btaqm
         klag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/pAlhTV2VI3Fe2zoXUXryFeLmak93OLBNBWVSPFoTU=;
        b=H4E8HcEXV529H7hvVllgxVnKmjKeNSOW+lbU0sFjJXfcNDtIIrpGF5Sjcjkep097pK
         gAFR8SN7Ru5dCZ6iUGOviD4sDAyUZcvCHUGgD9sx2M08u1QHK35iIve1v6I6HxNcampr
         u32KZk8InuT0bnEdGB8cDZgKGKZCTbTWLdbCsEcN9oGvQbmS7bMJOtUALygayJ+qVRoA
         YOlxN+CJGglZ0ngy8n2dUAbOw9NlAt1NvigVSyKLMGFUHO6jE8DNs26LRKA/yHHT2wJo
         6mWUfXzjqee3jkQFPbgQBrFUCfSs2nJpWpakvpVnNag9+J/endA6JlUQg3cyG1jJpDnI
         AN6A==
X-Gm-Message-State: AGi0PubjBVXZlUbwrnEF9iSVROtlwEUImNO/2eMmcxfCQC2wsXQKSmgr
        mhIPezT0ulzmM4RuXP2VrLnsl+OB
X-Google-Smtp-Source: APiQypKvPyLPUSU/EQ9I8sGXwdkzjTyfkE5kF849OL5sHMrrq/UEz2iyZNgyt5gC4MEugQe/G9wqNA==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr7424524wml.20.1586566985654;
        Fri, 10 Apr 2020 18:03:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm5033738wrt.14.2020.04.10.18.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:03:05 -0700 (PDT)
Message-Id: <431fde6803140398eec0744c866616a0a78f9433.1586566981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.git.1586566981.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 01:03:01 +0000
Subject: [PATCH 3/3] blame: use changed-path Bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The changed-path Bloom filters help reduce the amount of tree
parsing required during history queries. Before calculating a
diff, we can ask the filter if a path changed between a commit
and its first parent. If the filter says "no" then we can move
on without parsing trees. If the filter says "maybe" then we
parse trees to discover if the answer is actually "yes" or "no".

When computing a blame, there is a section in find_origin() that
computes a diff between a commit and one of its parents. When this
is the first parent, we can check the Bloom filters before calling
diff_tree_oid().

In order to make this work with the blame machinery, we need to
initialize a struct bloom_key with the initial path. But also, we
need to add more keys to a list if a rename is detected. We then
check to see if _any_ of these keys answer "maybe" in the diff.

During development, I purposefully left out this "add a new key
when a rename is detected" to see if the test suite would catch
my error. That is how I discovered the issues with
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS from the previous change.
With that change, we can feel some confidence in the coverage of
this change.

If a user requests copy detection using "git blame -C", then there
are more places where the set of "important" files can expand. I
do not know enough about how this happens in the blame machinery.
Thus, the Bloom filter integration is explicitly disabled in this
mode. A later change could expand the bloom_key data with an
appropriate call (or calls) to add_bloom_key().

If we did not disable this mode, then the following tests would
fail:

	t8003-blame-corner-cases.sh
	t8011-blame-split-file.sh

Generally, this is a performance enhancement and should not
change the behavior of 'git blame' in any way. If a repo has a
commit-graph file with computed changed-path Bloom filters, then
they should notice improved performance for their 'git blame'
commands.

Here are some example timings that I found by blaming some paths
in the Linux kernel repository:

 git blame arch/x86/kernel/topology.c >/dev/null

 Before: 0.83s
  After: 0.24s

 git blame kernel/time/time.c >/dev/null

 Before: 0.72s
  After: 0.24s

 git blame tools/perf/ui/stdio/hist.c >/dev/null

 Before: 0.27s
  After: 0.11s

I specifically looked for "deep" paths that were also edited many
times. As a counterpoint, the MAINTAINERS file was edited many
times but is located in the root tree. This means that the cost of
computing a diff relative to the pathspec is very small. Here are
the timings for that command:

 git blame MAINTAINERS >/dev/null

 Before: 20.1s
  After: 18.0s

These timings are the best of five. The worst-case runs were on the
order of 2.5 minutes for both cases. Note that the MAINTAINERS file
has 18,740 lines across 17,000+ commits. This happens to be one of
the cases where this change provides the least improvement.

The lack of improvement for the MAINTAINERS file and the relatively
modest improvement for the other examples can be easily explained.
The blame machinery needs to compute line-level diffs to determine
which lines were changed by each commit. That makes up a large
proportion of the computation time, and this change does not
attempt to improve on that section of the algorithm. The
MAINTAINERS file is large and changed often, so it takes time to
determine which lines were updated by which commit. In contrast,
the code files are much smaller, and it takes longer to comute
the line-by-line diff for a single patch on the Linux mailing
lists.

Outside of the "-C" integration, I believe there is little more to
gain from the changed-path Bloom filters for 'git blame' after this
patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 blame.c         | 139 ++++++++++++++++++++++++++++++++++++++++++++----
 blame.h         |   6 +++
 builtin/blame.c |  10 ++++
 3 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index 29770e5c81c..9fbf79e47c3 100644
--- a/blame.c
+++ b/blame.c
@@ -9,6 +9,8 @@
 #include "blame.h"
 #include "alloc.h"
 #include "commit-slab.h"
+#include "bloom.h"
+#include "commit-graph.h"
 
 define_commit_slab(blame_suspects, struct blame_origin *);
 static struct blame_suspects blame_suspects;
@@ -1246,13 +1248,75 @@ static int fill_blob_sha1_and_mode(struct repository *r,
 	return -1;
 }
 
+struct blame_bloom_data {
+	/*
+	 * Changed-path Bloom filter keys. These can help prevent
+	 * computing diffs against first parents, but we need to
+	 * expand the list as code is moved or files are renamed.
+	 */
+	struct bloom_filter_settings *settings;
+	struct bloom_key **keys;
+	int nr;
+	int alloc;
+};
+
+static int bloom_count_queries = 0;
+static int bloom_count_no = 0;
+static int maybe_changed_path(struct repository *r,
+			      struct commit *parent,
+			      struct blame_origin *origin,
+			      struct blame_bloom_data *bd)
+{
+	int i;
+	struct bloom_filter *filter;
+
+	if (!bd)
+		return 1;
+
+	if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
+		return 1;
+
+	filter = get_bloom_filter(r, origin->commit, 0);
+
+	if (!filter)
+		return 1;
+
+	bloom_count_queries++;
+	for (i = 0; i < bd->nr; i++) {
+		if (bloom_filter_contains(filter,
+					  bd->keys[i],
+					  bd->settings))
+			return 1;
+	}
+
+	bloom_count_no++;
+	return 0;
+}
+
+static void add_bloom_key(struct blame_bloom_data *bd,
+			  const char *path)
+{
+	if (!bd)
+		return;
+
+	if (bd->nr >= bd->alloc) {
+		bd->alloc *= 2;
+		REALLOC_ARRAY(bd->keys, bd->alloc);
+	}
+
+	bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
+	fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
+	bd->nr++;
+}
+
 /*
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
 static struct blame_origin *find_origin(struct repository *r,
 					struct commit *parent,
-					struct blame_origin *origin)
+					struct blame_origin *origin,
+					struct blame_bloom_data *bd)
 {
 	struct blame_origin *porigin;
 	struct diff_options diff_opts;
@@ -1286,10 +1350,19 @@ static struct blame_origin *find_origin(struct repository *r,
 
 	if (is_null_oid(&origin->commit->object.oid))
 		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
-	else
-		diff_tree_oid(get_commit_tree_oid(parent),
-			      get_commit_tree_oid(origin->commit),
-			      "", &diff_opts);
+	else {
+		int compute_diff = 1;
+		if (origin->commit->parents &&
+		    !oidcmp(&parent->object.oid,
+			    &origin->commit->parents->item->object.oid))
+			compute_diff = maybe_changed_path(r, parent,
+							  origin, bd);
+
+		if (compute_diff)
+			diff_tree_oid(get_commit_tree_oid(parent),
+				      get_commit_tree_oid(origin->commit),
+				      "", &diff_opts);
+	}
 	diffcore_std(&diff_opts);
 
 	if (!diff_queued_diff.nr) {
@@ -1341,7 +1414,8 @@ static struct blame_origin *find_origin(struct repository *r,
  */
 static struct blame_origin *find_rename(struct repository *r,
 					struct commit *parent,
-					struct blame_origin *origin)
+					struct blame_origin *origin,
+					struct blame_bloom_data *bd)
 {
 	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
@@ -1366,6 +1440,7 @@ static struct blame_origin *find_rename(struct repository *r,
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		if ((p->status == 'R' || p->status == 'C') &&
 		    !strcmp(p->two->path, origin->path)) {
+			add_bloom_key(bd, p->one->path);
 			porigin = get_origin(parent, p->one->path);
 			oidcpy(&porigin->blob_oid, &p->one->oid);
 			porigin->mode = p->one->mode;
@@ -2332,6 +2407,11 @@ static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *bl
 
 #define MAXSG 16
 
+typedef struct blame_origin *(*blame_find_alg)(struct repository *,
+					       struct commit *,
+					       struct blame_origin *,
+					       struct blame_bloom_data *);
+
 static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
@@ -2356,8 +2436,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
-		struct blame_origin *(*find)(struct repository *, struct commit *, struct blame_origin *);
-		find = pass ? find_rename : find_origin;
+		blame_find_alg find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
@@ -2369,7 +2448,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 				continue;
 			if (parse_commit(p))
 				continue;
-			porigin = find(sb->repo, p, origin);
+			porigin = find(sb->repo, p, origin, sb->bloom_data);
 			if (!porigin)
 				continue;
 			if (oideq(&porigin->blob_oid, &origin->blob_oid)) {
@@ -2809,3 +2888,45 @@ struct blame_entry *blame_entry_prepend(struct blame_entry *head,
 	blame_origin_incref(o);
 	return new_head;
 }
+
+void setup_blame_bloom_data(struct blame_scoreboard *sb,
+			    const char *path)
+{
+	struct blame_bloom_data *bd;
+
+	if (!sb->repo->objects->commit_graph)
+		return;
+
+	if (!sb->repo->objects->commit_graph->bloom_filter_settings)
+		return;
+
+	bd = xmalloc(sizeof(struct blame_bloom_data));
+
+	bd->settings = sb->repo->objects->commit_graph->bloom_filter_settings;
+
+	bd->alloc = 4;
+	bd->nr = 0;
+	ALLOC_ARRAY(bd->keys, bd->alloc);
+
+	add_bloom_key(bd, path);
+
+	sb->bloom_data = bd;
+}
+
+void cleanup_scoreboard(struct blame_scoreboard *sb)
+{
+	if (sb->bloom_data) {
+		int i;
+		for (i = 0; i < sb->bloom_data->nr; i++) {
+			free(sb->bloom_data->keys[i]->hashes);
+			free(sb->bloom_data->keys[i]);
+		}
+		free(sb->bloom_data->keys);
+		FREE_AND_NULL(sb->bloom_data);
+
+		trace2_data_intmax("blame", sb->repo,
+				   "bloom/queries", bloom_count_queries);
+		trace2_data_intmax("blame", sb->repo,
+				   "bloom/response-no", bloom_count_no);
+	}
+}
diff --git a/blame.h b/blame.h
index 089b181ff27..b6bbee41472 100644
--- a/blame.h
+++ b/blame.h
@@ -100,6 +100,8 @@ struct blame_entry {
 	int unblamable;
 };
 
+struct blame_bloom_data;
+
 /*
  * The current state of the blame assignment.
  */
@@ -156,6 +158,7 @@ struct blame_scoreboard {
 	void(*found_guilty_entry)(struct blame_entry *, void *);
 
 	void *found_guilty_entry_data;
+	struct blame_bloom_data *bloom_data;
 };
 
 /*
@@ -180,6 +183,9 @@ void init_scoreboard(struct blame_scoreboard *sb);
 void setup_scoreboard(struct blame_scoreboard *sb,
 		      const char *path,
 		      struct blame_origin **orig);
+void setup_blame_bloom_data(struct blame_scoreboard *sb,
+			    const char *path);
+void cleanup_scoreboard(struct blame_scoreboard *sb);
 
 struct blame_entry *blame_entry_prepend(struct blame_entry *head,
 					long start, long end,
diff --git a/builtin/blame.c b/builtin/blame.c
index bf1cecdf3f9..3c13634f279 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1061,6 +1061,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	string_list_clear(&ignore_revs_file_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, path, &o);
+
+	/*
+	 * Changed-path Bloom filters are disabled when looking
+	 * for copies.
+	 */
+	if (!(opt & PICKAXE_BLAME_COPY))
+		setup_blame_bloom_data(&sb, path);
+
 	lno = sb.num_lines;
 
 	if (lno && !range_list.nr)
@@ -1164,5 +1172,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		printf("num get patch: %d\n", sb.num_get_patch);
 		printf("num commits: %d\n", sb.num_commits);
 	}
+
+	cleanup_scoreboard(&sb);
 	return 0;
 }
-- 
gitgitgadget
