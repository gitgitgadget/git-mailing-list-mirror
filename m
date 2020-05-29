Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55101C433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3610720723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIBLOAry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgE2Iv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgE2Ivs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67402C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so2490226wru.12
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASAVWnZfh22QQeQWl73yInYANgZJd/78wSrozFID7lI=;
        b=iIBLOAryQszWkQnlry/7a7GBzfCsT+TpDRMmr3raWsYqw4PnvTXsiD1Ey6nbkcR+Lm
         gDBQe/9nXwZFp7pqn5W1VCAhLVzVsoR/94oEK6K4/+0ueB9NQeny1vH+htgG/1qTQn72
         70qDa1gxbzO4x4PhopWsbXEgPlrQyCWxPiZS3cAwbizCk8R2oBNnRM86jxvbOMFH3LU9
         w4gQnvSQzXW0akNIEcCjpF7QJ2qgXm4suJQ9zetqR4tO4xREJPl5LBShs5x7ZO1/ffe7
         ahs3+C6waba4Qr80GSB52woxba3l3z2XpNdmFuTmSgZFrZgujMAOgfji2yGHDsZ7qDkR
         DFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASAVWnZfh22QQeQWl73yInYANgZJd/78wSrozFID7lI=;
        b=L4sIPzfhnIDahMo+/incwkeLNdB/YgBp/4eXABGCPULE4C1JSEaEBY+cma8Y+lIwHr
         qFiwSiYkTTkJ4VQ4wqS4QH2aYrskbLtPPKO8r6GrGhwVHVo/e/VFsNx2XhkGlAg9GJDy
         oClGQCxen/+cLU51XXsMhCgdEiKooIp+gYK14zyTDqsC7yJLymcLwFErKXSh4CppWpwp
         FU9A2zQySXCvMUD4AInPv5khGNxi7sYARZmUvDOj/X/SnwjFWK9BzjudPjvhOgYJwpRD
         JEboiwB4+nX1tjCmhyA9kPP+nwxxYEX6cUgQQyuR+74aMOfOhExmlNSii16L3v0vx/Vb
         p5VA==
X-Gm-Message-State: AOAM531RJO7zBRhduqyW1L/33nwA3xs+6rEAx0eJF6L2kPs/eU7ipJu0
        GtL5QQUh76qBtBnODeraoj9nF/F/
X-Google-Smtp-Source: ABdhPJwUDU6sPRRnRaRee/Mv4sWD0Ol0+dpcn8tnwNso/alxJW36e4euDzcuLyWJ2kd42yI0TTJoEw==
X-Received: by 2002:a05:6000:1042:: with SMTP id c2mr8213720wrx.351.1590742306583;
        Fri, 29 May 2020 01:51:46 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 32/34] PoC commit-graph: use revision walk machinery for '--reachable'
Date:   Fri, 29 May 2020 10:50:36 +0200
Message-Id: <20200529085038.26008-33-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Not sure it is legal to do this.  I hope it's legal.  It would be
great if it were legal.  But I really doubt it's legal.  FWIW, at
least the test suite still passes, even with GIT_TEST_COMMIT_GRAPH=1.
Or we have a hole in test coverage...]

Our revision walk machinery knows a thing or two about how to traverse
the history in an order that is friendlier to the delta base cache.
The hand-rolled revision walk in commit-graph.c:close_reachable() is
unaware of any such tricks: it is just a simple loop iterating over an
array of commits, appending unseen parents to the end.  This didn't
really matter in the past, because we only accessed commit objects
while writing the commit-graph.  Now, however, we have modified path
Bloom filters, and to fill them we need access to tree objects as well
to gather all modified paths, which puts more strain on the caches,
and the order in which we traverse the commits becomes relevant.

So let's use the regular revision walk machinery (i.e. 'struct
rev_info', setup_revisions(), get_revision() and friends) for
'--reachable' to speed up writing a commit-graph with modified path
Bloom filters.

However, stick to the current algorithm when scanning pack files in
commits, because passing all packed commits to setup_revisions() might
do more harm than good (presumably, I didn't check; scanning all packs
for commits can be hopelessly inefficient anyway).  '--stdin-commits',
too, could benefit from using the revision walk machinery when it's
fed with branch tips from 'git for-each-ref', or fare worse when it's
fed all commits from 'git rev-list' (didn't check this, either)... so
let's just leave it using the current algorithm for now.

The table below shows the reduced runtime and max RSS of writing a
commit-graph file from scratch with '--reachable' and modified path
Bloom filters, i.e. that of:

  git -c core.modifiedPathBloomFilters=1 commit-graph write --reachable

                       Runtime                         Max RSS
                  before     after               before      after
  --------------------------------------------------------------------------
  android-base    57.722s   40.113s   -30.5%     711804k    697624k    -2.0%
  cmssw           27.977s   25.154s   -10.1%     980884k    786196k   -19.9%
  cpython         10.161s    8.956s   -11.9%     331736k    328704k    -0.9%
  gcc            114.980s   36.975s   -67.9%     561928k    484212k   -13.8%
  gecko-dev      132.557s   97.314s   -26.6%    2203544k   2161480k    -1.9%
  git              8.097s    5.215s   -35.6%     240564k    189652k   -21.2%
  glibc            4.693s    3.996s   -14.9%     215924k    207572k    -3.9%
  homebrew-core   56.661s   56.384s    -0.5%     469668k    475596k    +1.3%
  jdk             20.355s   18.936s    -7.0%     327244k    322316k    -1.5%
  linux          215.235s   98.991s   -54.0%    1549852k   1445028k    -6.8%
  llvm-project    48.659s   30.933s   -36.4%     783740k    736988k    -6.0%
  rails            5.804s    5.389s    -7.2%     284524k    284528k       0%
  rust            20.151s   12.921s   -35.9%     687840k    664104k    -3.5%
  webkit          31.226s   30.341s    -2.8%    2018396k   1902884k    -5.7%
---
 commit-graph.c | 110 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4cbfce61bf..1677e4fb3e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1703,6 +1703,9 @@ static void create_modified_path_bloom_filter(
 	 * (a commit can be present in multiple pack files, or multiple
 	 * refs can point to the same commit) so check first whether we have
 	 * already created a modified path Bloom filter for it.
+	 *
+	 * TODO: with '--reachable' we can now be sure that we only look at
+	 * each commit only once, so this is unnecessary in that code path.
 	 */
 	bfi = modified_path_bloom_filters_peek(&modified_path_bloom_filters,
 					       commit);
@@ -1891,16 +1894,6 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static int add_ref_to_list(const char *refname,
-			   const struct object_id *oid,
-			   int flags, void *cb_data)
-{
-	struct string_list *list = (struct string_list *)cb_data;
-
-	string_list_append(list, oid_to_hex(oid));
-	return 0;
-}
-
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 				struct string_list *pack_indexes)
 {
@@ -2773,14 +2766,99 @@ int write_commit_graph_reachable(const char *obj_dir,
 				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts)
 {
-	struct string_list list = STRING_LIST_INIT_DUP;
-	int result;
+	struct write_commit_graph_context *ctx;
+	struct rev_info revs;
+	const char *revs_argv[] = { NULL, "--all", NULL };
+	struct commit *commit;
+	int result = 0;
+
+	ctx = init_write_commit_graph_context(obj_dir, flags, split_opts);
+	if (!ctx)
+		return 0;
+
+	/*
+	 * Some git commands write a commit-graph in-process at the end,
+	 * prevent their revision walk to interfere with ours.
+	 */
+	clear_object_flags(SEEN | ADDED | SHOWN | TOPO_WALK_EXPLORED |
+			   TOPO_WALK_INDEGREE | UNINTERESTING);
+
+	init_revisions(&revs, NULL);
+	setup_revisions(ARRAY_SIZE(revs_argv) - 1, revs_argv, &revs, NULL);
+	if (prepare_revision_walk(&revs)) {
+		error(_("revision walk setup failed"));
+		result = -1;
+		goto cleanup;
+	}
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+				_("Gathering commit info"),
+				0);
+	while ((commit = get_revision(&revs))) {
+		display_progress(ctx->progress, ctx->oids.nr + 1);
+		ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+		oidcpy(&ctx->oids.list[ctx->oids.nr], &commit->object.oid);
+		ctx->oids.nr++;
+
+		if (!commit->parents) {
+			create_modified_path_bloom_filter(&ctx->mpbfctx,
+							  commit, 0);
+		} else {
+			struct commit_list *parent;
+			int nth_parent;
+
+			for (parent = commit->parents, nth_parent = 0;
+			     parent;
+			     parent = parent->next, nth_parent++)
+				create_modified_path_bloom_filter(&ctx->mpbfctx,
+								  commit, nth_parent);
+		}
+	}
+	stop_progress(&ctx->progress);
+
+	if (ctx->oids.nr >= GRAPH_EDGE_LAST_MASK) {
+		error(_("the commit graph format cannot write %d commits"), ctx->oids.nr);
+		result = -1;
+		goto cleanup;
+	}
 
-	for_each_ref(add_ref_to_list, &list);
-	result = write_commit_graph(obj_dir, NULL, &list,
-				    flags, split_opts);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
+
+	/*
+	 * TODO: the revision walking loop above could fill ctx->commits
+	 * straight away, counting extra edges as well.
+	 */
+	ctx->commits.alloc = ctx->oids.nr;
+	ALLOC_ARRAY(ctx->commits.list, ctx->commits.alloc);
+
+	/*
+	 * Despite its unassuming name, this function removes duplicate
+	 * commits/oids and, worse, it does counts extra edges as well.
+	 */
+	copy_oids_to_commits(ctx);
+
+	if (!ctx->commits.nr)
+		goto cleanup;
+
+	if (ctx->split) {
+		split_graph_merge_strategy(ctx);
 
-	string_list_clear(&list, 0);
+		merge_commit_graphs(ctx);
+	} else
+		ctx->num_commit_graphs_after = 1;
+
+	compute_generation_numbers(ctx);
+
+	result = write_commit_graph_file(ctx);
+
+	if (ctx->split)
+		mark_commit_graphs(ctx);
+
+	expire_commit_graphs(ctx);
+
+cleanup:
+	free_write_commit_graph_context(ctx);
 	return result;
 }
 
-- 
2.27.0.rc1.431.g5c813f95dc

