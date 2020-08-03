Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F1C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAC207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LUWRA1YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCS5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA52C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a19so11845142qvy.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hbhm77ll047MbjjIMnqf5YD9r2bu7O0Hp8srHXLyFPY=;
        b=LUWRA1YKyDe0x4N6zG5O2ACkFQsRwKTPBTps4GqXasG3+aOZuHMcrOrv5sY7UhdGXS
         m8Uy2utpOaxqH/3nXV7x/AzDbARgyy6oeWgtUqZyjdJ430jCwHORwaEt19vyJMOpsd/m
         FohVBPRtkk7Ie7+gKoAjh96HdF4zUtScO/TLQuhJX8EbUfCDDyYF7i2g1e/20hiqzbP8
         NRpgpW/aOq0BVAn9vTGYuRh0AGJv1w1Gzt8BocmfpI0Xmp43E2Wb2utzR+ib3xUW1Zkn
         C0rgIYKoNxgOwmjQ72uLJwVrMR/rifFhIbNlplPnjy8aXlN/rUFJc22QgCicwEs5YZUS
         68dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hbhm77ll047MbjjIMnqf5YD9r2bu7O0Hp8srHXLyFPY=;
        b=aN4GlscZBXwIVhuklW2n0Ie8bMXMN1Q58yeyNWhi6vuYcN6Gf2YtSH6NAKsi8kboLU
         DaJkX9cG3uxk2uFbmVc2KBkQ0baCyoj/T4uaXnS1txGYDRWtMJ2eYRd/ORLlsXKEG76s
         IpyNYaiS/RpIH8knpolNmN2Q0KuEBF/A/QVzL2dn4OKO44YTypy0h5in/ApIbRGSUT0g
         2I2H0+7lVjYjPv7wjFt5kwASfuOodj/KG/JgTBtZE3eNXXIpcrpHXYzOWZeKvDEFv0Pm
         Fnw+OLvz/RmmSFeweOC47jd7p9Ti4/xHg8/ieuP0dSRC3cn1zIXYXPJC3PnscjqwRFwj
         bYvA==
X-Gm-Message-State: AOAM530PrDM3HXJSolWLigTNqvatuE8ITe8H4ezsUAD5KYi0+DxnY7fI
        3pizbauG4EYft2fWo3zPO01ogGaolMaT2w==
X-Google-Smtp-Source: ABdhPJwEjbFcjdW/mn2MsYZm6o/hHlSFJ1fkPMTX7SWDdXvn0pLi4HPV4HQfNNJrCBr6uzjmQ4DFgA==
X-Received: by 2002:a0c:d7c9:: with SMTP id g9mr18919588qvj.83.1596481062822;
        Mon, 03 Aug 2020 11:57:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id p189sm20210395qkb.61.2020.08.03.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:42 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 09/10] commit-graph: rename 'split_commit_graph_opts'
Message-ID: <309e76bb174d64ffae6454f2bc9968c6c2632aff.1596480582.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, additional options will be added to the
commit-graph API, which themselves do not have to do with splitting.

Rename the 'split_commit_graph_opts' structure to the more-generic
'commit_graph_opts' to encompass both.

Suggsted-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 20 ++++++++++----------
 commit-graph.c         | 40 ++++++++++++++++++++--------------------
 commit-graph.h         |  6 +++---
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ba5584463f..38f5f57d15 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -119,7 +119,7 @@ static int graph_verify(int argc, const char **argv)
 }
 
 extern int read_replace_refs;
-static struct split_commit_graph_opts split_opts;
+static struct commit_graph_opts write_opts;
 
 static int write_option_parse_split(const struct option *opt, const char *arg,
 				    int unset)
@@ -187,24 +187,24 @@ static int graph_write(int argc, const char **argv)
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
-		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
+		OPT_CALLBACK_F(0, "split", &write_opts.flags, NULL,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
-		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
+		OPT_INTEGER(0, "max-commits", &write_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
-		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
+		OPT_INTEGER(0, "size-multiple", &write_opts.size_multiple,
 			N_("maximum ratio between two levels of a split commit-graph")),
-		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
+		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
 		OPT_END(),
 	};
 
 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
-	split_opts.size_multiple = 2;
-	split_opts.max_commits = 0;
-	split_opts.expire_time = 0;
+	write_opts.size_multiple = 2;
+	write_opts.max_commits = 0;
+	write_opts.expire_time = 0;
 
 	trace2_cmd_mode("write");
 
@@ -232,7 +232,7 @@ static int graph_write(int argc, const char **argv)
 	odb = find_odb(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb, flags, &split_opts))
+		if (write_commit_graph_reachable(odb, flags, &write_opts))
 			return 1;
 		return 0;
 	}
@@ -261,7 +261,7 @@ static int graph_write(int argc, const char **argv)
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
-			       &split_opts))
+			       &write_opts))
 		result = 1;
 
 cleanup:
diff --git a/commit-graph.c b/commit-graph.c
index 2e765b26d5..8626024faa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -995,7 +995,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;
 
-	const struct split_commit_graph_opts *split_opts;
+	const struct commit_graph_opts *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
 	struct bitmap *bloom_large;
@@ -1327,8 +1327,8 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit *commit;
-	enum commit_graph_split_flags flags = ctx->split_opts ?
-		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts ?
+		ctx->opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1520,7 +1520,7 @@ static int add_ref_to_set(const char *refname,
 
 int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
-				 const struct split_commit_graph_opts *split_opts)
+				 const struct commit_graph_opts *opts)
 {
 	struct oidset commits = OIDSET_INIT;
 	struct refs_cb_data data;
@@ -1537,7 +1537,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 	stop_progress(&data.progress);
 
 	result = write_commit_graph(odb, NULL, &commits,
-				    flags, split_opts);
+				    flags, opts);
 
 	oidset_clear(&commits);
 	return result;
@@ -1652,8 +1652,8 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	enum commit_graph_split_flags flags = ctx->split_opts ?
-		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts ?
+		ctx->opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 
 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
@@ -1951,13 +1951,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	int max_commits = 0;
 	int size_mult = 2;
 
-	if (ctx->split_opts) {
-		max_commits = ctx->split_opts->max_commits;
+	if (ctx->opts) {
+		max_commits = ctx->opts->max_commits;
 
-		if (ctx->split_opts->size_multiple)
-			size_mult = ctx->split_opts->size_multiple;
+		if (ctx->opts->size_multiple)
+			size_mult = ctx->opts->size_multiple;
 
-		flags = ctx->split_opts->flags;
+		flags = ctx->opts->flags;
 	}
 
 	g = ctx->r->objects->commit_graph;
@@ -2135,8 +2135,8 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	size_t dirnamelen;
 	timestamp_t expire_time = time(NULL);
 
-	if (ctx->split_opts && ctx->split_opts->expire_time)
-		expire_time = ctx->split_opts->expire_time;
+	if (ctx->opts && ctx->opts->expire_time)
+		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name = get_chain_filename(ctx->odb);
 		unlink(chain_file_name);
@@ -2187,7 +2187,7 @@ int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct split_commit_graph_opts *split_opts)
+		       const struct commit_graph_opts *opts)
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
@@ -2203,7 +2203,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->split_opts = split_opts;
+	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
@@ -2243,15 +2243,15 @@ int write_commit_graph(struct object_directory *odb,
 			}
 		}
 
-		if (ctx->split_opts)
-			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
+		if (ctx->opts)
+			replace = ctx->opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;
 
-	if (ctx->split && split_opts && ctx->oids.alloc > split_opts->max_commits)
-		ctx->oids.alloc = split_opts->max_commits;
+	if (ctx->split && opts && ctx->oids.alloc > opts->max_commits)
+		ctx->oids.alloc = opts->max_commits;
 
 	if (ctx->append) {
 		prepare_commit_graph_one(ctx->r, ctx->odb);
diff --git a/commit-graph.h b/commit-graph.h
index afbc5fa41e..4cd991cf26 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -107,7 +107,7 @@ enum commit_graph_split_flags {
 	COMMIT_GRAPH_SPLIT_REPLACE          = 2
 };
 
-struct split_commit_graph_opts {
+struct commit_graph_opts {
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
@@ -122,12 +122,12 @@ struct split_commit_graph_opts {
  */
 int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
-				 const struct split_commit_graph_opts *split_opts);
+				 const struct commit_graph_opts *opts);
 int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct split_commit_graph_opts *split_opts);
+		       const struct commit_graph_opts *opts);
 
 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
 
-- 
2.28.0.rc1.13.ge78abce653

