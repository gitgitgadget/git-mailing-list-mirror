Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021EC38A2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE2821BE5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnytz9sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgDPUUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730158AbgDPUTv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 16:19:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA306C03C1A6
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so9677103edx.4
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/pAlhTV2VI3Fe2zoXUXryFeLmak93OLBNBWVSPFoTU=;
        b=cnytz9sXOjZPS6Wk+l59JGZIL3SC3UaS6by9se2DCWYALT9mM7Wd30WGeD04jkELii
         0ACO00iudSki+rq4bcwB30DQE/rbBuYrtjMVpm+KIPJONJBhLCEh2W6c0QNcstj9dfIt
         K6c+hix5HmzVIsQMERLG0ochpYT+3ARx5q/ZmXAst9ldVFTIEC5sT5p1pT4n8GRxzIoJ
         2HzFHUZTbnfmm88Jgf8K1wHM+SLSiYxgFEUF5hht58hQctbeqYXZye23e9H/4vbn4bHE
         ogoyenWawQSNCmfZ/57DybGAAeT8y6Jsc+O39vm+6uzzDrxGlnmpXFYEFwFOdszRw/1q
         x8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/pAlhTV2VI3Fe2zoXUXryFeLmak93OLBNBWVSPFoTU=;
        b=CLMSUJjjlRDHjcuyzhvPk73nIOff0GkaP9ChxjfCpUsCx5nPNWaQHNHqZBH4ANcfB1
         /XOzdS11HgtceIl65W72RPoToHOfoZWmDUDIxjmke9ZVOyC2Q5dViUA9wpwBF3ezNrEw
         XNpkQ1Ugle9tPsw6Bbm9r4NI8delSTFxedecegLLmGIb7fDoc8VQd1/myNBnlf09/rPL
         TPWw2Sj+TIDXGcL6/go/xEJMHuVHxPZ/aGI/h+uoufQpm32SxvjJyyJq8uGLZ9b/YQ90
         dIQwAdYWVBpS1Xw2X2PzZ2KDwoG9zgG6d2/SFCB2lTWljHblX+rj9bs8V0xm4jmq0ue8
         YEqA==
X-Gm-Message-State: AGi0PubctJ4tWBuLiq3bKX3o7/mYK1331BM6M571ZoagghvsAKzJe6NB
        Igi/tHH2E3xfShVcw4qfkcfIaske
X-Google-Smtp-Source: APiQypL9NBez5KcnMJaydswbiTR2OqbKB1Av+slYMTHCFnRmLRz6YjD0Ako3cpB6BkYsE1JakZC+Rw==
X-Received: by 2002:a50:c389:: with SMTP id h9mr31874846edf.1.1587068047989;
        Thu, 16 Apr 2020 13:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y23sm3073905eju.85.2020.04.16.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:14:07 -0700 (PDT)
Message-Id: <463d6bf5033cc6c3d22913c72535d094ffb5b41d.1587068044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
References: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 20:14:04 +0000
Subject: [PATCH v3 3/3] blame: use changed-path Bloom filters
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
