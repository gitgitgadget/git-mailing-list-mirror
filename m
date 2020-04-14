Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C2C2BB1D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2387206E9
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 04:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0cM3m0WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbgDNEE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405073AbgDNEE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 00:04:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F098C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so4178959plq.12
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 21:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nfIRM5MvACeZd3GmE3VOfNjO9AsWS/C+JtoP8T4WkgQ=;
        b=0cM3m0WBKlK7F7OVC1H73NmLJYK+jkn25c7oMUApdlxx5hrFBFBmpdx6WBjdlaydPS
         3lzuvN0UmEp5qyBAc4Szbw2P1U1QqefeGHBPvzfw9LGvoU/D7/DUalU+/DpjMwzh5HWn
         wcQfW5X5om7QV4M+6+QpswfIEItzD3vWMxOpQaJSTJjM/AKXktrh/I/cVGRRxPx16u7S
         O6u0KhBoWZk81yaCM/USpGaS65jV+haYemDKhM+2woSlwbD+IdMOfzV3nUbkG/8nMnJw
         cf3kozxtxfGTEmqXIEuY0m4KHAXh0b2rf5rEOqTq8vWNMUktiiE1qJs6NSBNvg9VWYW2
         nPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfIRM5MvACeZd3GmE3VOfNjO9AsWS/C+JtoP8T4WkgQ=;
        b=b2Pkc9zekPcMPjJ+bKP+lGLLwhnzPT5LeisLEXpD+Lrhtwcby2eqNXQ9hB5twbWodk
         0MP8/q271F41k17fWbhOb06lfoabNQBJTQaFqe1Nfl/MsAnzzHqI8EJANBElsZOeKf/E
         Tnn/+S1LEa3xeMav9Q0wmhC9okhrVedKgJiNgXEbeKntg3LoEsmsKM5ndtKBKc6FIFjr
         lJyh3OPy6kJEaimWNfdbPhLLdeIP4Mo8oYjl7kn7lnoLUDRXTjg/iMBQzxgrpJu7VRVA
         m/jkyr+4PXqF29ibvBjLUSaXYXhc/eQYXCQTFZ8bXgqZUmmdcLnebU4g9yZKOaTrfa1r
         6htg==
X-Gm-Message-State: AGi0PuYj58ARiRwrEYdeyAyXq0N3EacRjJxX5RTh1h4n7qj8ZjFQL0M5
        R2Imrlw23gpOQ2JY4q0RWejk2NgV0GD6DNXG
X-Google-Smtp-Source: APiQypK1kmxaBgtUmfeaZTfB/sqL62n4g9iC7SRlKLkXlPjbeNvhqfplHxjG60Aa4XugtnpE5VQQug==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr26610718pjn.34.1586837067396;
        Mon, 13 Apr 2020 21:04:27 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b189sm1207755pfb.163.2020.04.13.21.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:04:26 -0700 (PDT)
Date:   Mon, 13 Apr 2020 22:04:25 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH 6/7] commit-graph.h: replace 'commit_hex' with 'commits'
Message-ID: <811a2ece05f2d576bf2b3d6429c537800649b27b.1586836700.git.me@ttaylorr.com>
References: <cover.1586836700.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1586836700.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'write_commit_graph()' function takes in either a string list of
pack indices, or a string list of hexadecimal commit OIDs. These
correspond to the '--stdin-packs' and '--stdin-commits' mode(s) from
'git commit-graph write'.

Using a string_list of hexadecimal commit IDs is not the most efficient
use of memory, since we can instead use the 'struct oidset', which is
more well-suited for this case.

This has another benefit which will become apparent in the following
commit. This is that we are about to disambiguate the kinds of errors we
produce with '--stdin-commits' into "non-hex input" and "hex-input, but
referring to a non-commit object". By having 'write_commit_graph' take
in a 'struct oidset *' of commits, we place the burden on the caller (in
this case, the builtin) to handle the first case, and the commit-graph
machinery can handle the second case.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c  | 19 ++++++++++---
 commit-graph.c          | 59 +++++++++++++++++++++++------------------
 commit-graph.h          |  3 ++-
 t/t5318-commit-graph.sh |  2 +-
 4 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 922f876bfa..c69716aa7e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -140,7 +140,7 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list *pack_indexes = NULL;
-	struct string_list *commit_hex = NULL;
+	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
 	struct string_list lines;
 	int result = 0;
@@ -213,7 +213,20 @@ static int graph_write(int argc, const char **argv)
 		if (opts.stdin_packs)
 			pack_indexes = &lines;
 		if (opts.stdin_commits) {
-			commit_hex = &lines;
+			struct string_list_item *item;
+			oidset_init(&commits, lines.nr);
+			for_each_string_list_item(item, &lines) {
+				struct object_id oid;
+				const char *end;
+
+				if (parse_oid_hex(item->string, &oid, &end)) {
+					error(_("unexpected non-hex object ID: "
+						"%s"), item->string);
+					return 1;
+				}
+
+				oidset_insert(&commits, &oid);
+			}
 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
 
@@ -222,7 +235,7 @@ static int graph_write(int argc, const char **argv)
 
 	if (write_commit_graph(odb,
 			       pack_indexes,
-			       commit_hex,
+			       opts.stdin_commits ? &commits : NULL,
 			       flags,
 			       &split_opts))
 		result = 1;
diff --git a/commit-graph.c b/commit-graph.c
index c598508d7f..f60346baee 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1136,13 +1136,13 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static int add_ref_to_list(const char *refname,
-			   const struct object_id *oid,
-			   int flags, void *cb_data)
+static int add_ref_to_set(const char *refname,
+			  const struct object_id *oid,
+			  int flags, void *cb_data)
 {
-	struct string_list *list = (struct string_list *)cb_data;
+	struct oidset *commits = (struct oidset *)cb_data;
 
-	string_list_append(list, oid_to_hex(oid));
+	oidset_insert(commits, oid);
 	return 0;
 }
 
@@ -1150,14 +1150,14 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct split_commit_graph_opts *split_opts)
 {
-	struct string_list list = STRING_LIST_INIT_DUP;
+	struct oidset commits = OIDSET_INIT;
 	int result;
 
-	for_each_ref(add_ref_to_list, &list);
-	result = write_commit_graph(odb, NULL, &list,
+	for_each_ref(add_ref_to_set, &commits);
+	result = write_commit_graph(odb, NULL, &commits,
 				    flags, split_opts);
 
-	string_list_clear(&list, 0);
+	oidset_clear(&commits);
 	return result;
 }
 
@@ -1206,39 +1206,46 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	return 0;
 }
 
-static int fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
-				     struct string_list *commit_hex)
+static int fill_oids_from_commits(struct write_commit_graph_context *ctx,
+				  struct oidset *commits)
 {
-	uint32_t i;
+	uint32_t i = 0;
 	struct strbuf progress_title = STRBUF_INIT;
+	struct oidset_iter iter;
+	struct object_id *oid;
+
+	if (!oidset_size(commits))
+		return 0;
 
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
 			    Q_("Finding commits for commit graph from %d ref",
 			       "Finding commits for commit graph from %d refs",
-			       commit_hex->nr),
-			    commit_hex->nr);
+			       oidset_size(commits)),
+			    oidset_size(commits));
 		ctx->progress = start_delayed_progress(
 					progress_title.buf,
-					commit_hex->nr);
+					oidset_size(commits));
 	}
-	for (i = 0; i < commit_hex->nr; i++) {
-		const char *end;
-		struct object_id oid;
+
+	oidset_iter_init(commits, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
 		struct commit *result;
 
-		display_progress(ctx->progress, i + 1);
-		if (!parse_oid_hex(commit_hex->items[i].string, &oid, &end) &&
-		    (result = lookup_commit_reference_gently(ctx->r, &oid, 1))) {
+		display_progress(ctx->progress, ++i);
+
+		result = lookup_commit_reference_gently(ctx->r, oid, 1);
+		if (result) {
 			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
 			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
 			ctx->oids.nr++;
 		} else if (ctx->check_oids) {
 			error(_("invalid commit object id: %s"),
-			    commit_hex->items[i].string);
+			      oid_to_hex(oid));
 			return -1;
 		}
 	}
+
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
@@ -1781,7 +1788,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
+		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
 		       const struct split_commit_graph_opts *split_opts)
 {
@@ -1857,12 +1864,12 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}
 
-	if (commit_hex) {
-		if ((res = fill_oids_from_commit_hex(ctx, commit_hex)))
+	if (commits) {
+		if ((res = fill_oids_from_commits(ctx, commits)))
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commits)
 		fill_oids_from_all_packs(ctx);
 
 	close_reachable(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index 718433d79b..98ef121924 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "cache.h"
 #include "object-store.h"
+#include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
@@ -106,7 +107,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 const struct split_commit_graph_opts *split_opts);
 int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
+		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
 		       const struct split_commit_graph_opts *split_opts);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9bf920ae17..e874a12696 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -43,7 +43,7 @@ test_expect_success 'create commits and repack' '
 test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	cd "$TRASH_DIRECTORY/full" &&
 	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "invalid commit object id" stderr &&
+	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
 	# valid tree OID, but not a commit OID
 	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
 	test_i18ngrep "invalid commit object id" stderr
-- 
2.26.0.106.g9fadedd637

