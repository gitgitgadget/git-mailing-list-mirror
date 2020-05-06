Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B891AC47257
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6FE20721
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="F59IBE8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgEFAID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgEFAIC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:08:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D2C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:08:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so88507pfn.11
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTfW4oWalXFbQpuks+wOsWzh2o2ZyNdcHhc5TjQ6BVs=;
        b=F59IBE8KFWd76/Qs5F3aSNEm1GLt2CbJ7Ddb4b9H/Y9IN/0Gx7mYyNrdFMGRJXARAW
         UExwrVFMCfIgeiXVdZGsCfP83xvRlJivz2OkHqZlyWImxoP3SB/tjOrwy4+EPmJ20mcZ
         T5UjNHTqvKs6/qDdt+INrSztjmCjW7jf/LXxQcHVezs6PcMLrtsllLhG8ryKfBh0q3sx
         VxXZ4DinDub1xIa/8eubP5rusJ8BVDW/8vYLnPRuhjSL8mmAqDBWCePoxZ9GlXKoclIW
         4gVKiBATOeqgGhhzRmqM09vxYUcT+Cv+ECbzxSeT4xhxJrly61aqcFyVOaFHv+fQPTsR
         y6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTfW4oWalXFbQpuks+wOsWzh2o2ZyNdcHhc5TjQ6BVs=;
        b=D1hSvffa+gtU81HxcAg6j40fpzwgfBNGcm2yyLuqVA19fO1E+01odMB+OaxONhp1it
         nD1hIAhkJoNRUGlNTYHNilGMBeZljomXkF3MHStIcqfby9KmkMv+2z3FSzszYip5jgmv
         FC53yT+dGjktTEXljlB9bfJ01hZvcdwMcM83zXK2MVZVI/Rx5zj28U/v8OVxCRdYXfT/
         qPi11q3Wrlae7h9VvOgrJ1y+vHYp9SrdINzRxZ4xo23PFacKBG0Z47jUOAdd4c/Otu0V
         BVcwR/6rRHk35CtuPNLU4ykIIvEcg1/lf6tjDSHG5C3NnkIrTjtuw12O9hRV3w0jBx0P
         rfyw==
X-Gm-Message-State: AGi0PubVMsfWOwxjKcLixz9egvyL2nnk5FQbUQ3r+JCqOolofygWU0qQ
        st6pkg5RrvZz/eRwMNLYVtjF1K61Urc=
X-Google-Smtp-Source: APiQypKXZ3Jyk6i3AIHnZ9lMVNpdmJcV1bgbKCakLOlqLdpcR/6K9zj3uMC0KWMmfPz/eZ9/FV/eHA==
X-Received: by 2002:a63:7ce:: with SMTP id 197mr5058453pgh.113.1588723680400;
        Tue, 05 May 2020 17:08:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u5sm138052pfu.198.2020.05.05.17.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:59 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:58 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <ad373f05fff5512b4242ba097b0d12c0107606e9.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7c5c9b9c57 (commit-graph: error out on invalid commit oids in
'write --stdin-commits', 2019-08-05), the commit-graph builtin dies on
receiving non-commit OIDs as input to '--stdin-commits'.

This behavior can be cumbersome to work around in, say, the case of
piping 'git for-each-ref' to 'git commit-graph write --stdin-commits' if
the caller does not want to cull out non-commits themselves. In this
situation, it would be ideal if 'git commit-graph write' wrote the graph
containing the inputs that did pertain to commits, and silently ignored
the remainder of the input.

Some options have been proposed to the effect of '--[no-]check-oids'
which would allow callers to have the commit-graph builtin do just that.
After some discussion, it is difficult to imagine a caller who wouldn't
want to pass '--no-check-oids', suggesting that we should get rid of the
behavior of complaining about non-commit inputs altogether.

If callers do wish to retain this behavior, they can easily work around
this change by doing the following:

    git for-each-ref --format='%(objectname) %(objecttype) %(*objecttype)' |
    awk '/commit/ { print $1 }' |
    git commit-graph write --stdin-commits

To make it so that valid OIDs that refer to non-existent objects are
indeed an error after loosening the error handling, perform an extra
lookup to make sure that object indeed exists before sending it to the
commit-graph internals.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  6 ++++--
 builtin/commit-graph.c             | 10 +++++-----
 commit-graph.c                     |  2 --
 commit-graph.h                     | 10 ++++------
 t/t5318-commit-graph.sh            | 15 +++++++++++----
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 53a650225a..fcac7d12e1 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -47,8 +47,10 @@ with `--stdin-commits` or `--reachable`.)
 +
 With the `--stdin-commits` option, generate the new commit graph by
 walking commits starting at the commits specified in stdin as a list
-of OIDs in hex, one OID per line. (Cannot be combined with
-`--stdin-packs` or `--reachable`.)
+of OIDs in hex, one OID per line. OIDs that resolve to non-commits
+(either directly, or by peeling tags) are silently ignored. OIDs that
+are malformed, or do not exist generate an error. (Cannot be combined
+with `--stdin-packs` or `--reachable`.)
 +
 With the `--reachable` option, generate the new commit graph by walking
 commits starting at all refs. (Cannot be combined with `--stdin-commits`
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 6537e9acef..a4685a1553 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -153,13 +153,14 @@ static int read_one_commit(struct oidset *commits, struct progress *progress,
 
 	display_progress(progress, oidset_size(commits) + 1);
 
+	if (oid_object_info(the_repository, &oid, NULL) < 0) {
+		error(_("object %s does not exist"), hash);
+		return 1;
+	}
+
 	result = lookup_commit_reference_gently(the_repository, &oid, 1);
 	if (result)
 		oidset_insert(commits, &result->object.oid);
-	else {
-		error(_("invalid commit object id: %s"), hash);
-		return 1;
-	}
 	return 0;
 }
 
@@ -239,7 +240,6 @@ static int graph_write(int argc, const char **argv)
 		struct strbuf buf = STRBUF_INIT;
 		if (opts.stdin_commits) {
 			oidset_init(&commits, 0);
-			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 			if (opts.progress)
 				progress = start_delayed_progress(
 					_("Collecting commits from input"), 0);
diff --git a/commit-graph.c b/commit-graph.c
index 56a4a43b30..3c3ada29b1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -880,7 +880,6 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1,
 		 changed_paths:1,
 		 order_by_pack:1;
 
@@ -2001,7 +2000,6 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
 	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
 	ctx->total_bloom_filter_data_size = 0;
diff --git a/commit-graph.h b/commit-graph.h
index 4212766a4f..659393e07f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -88,12 +88,10 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
 int generation_numbers_enabled(struct repository *r);
 
 enum commit_graph_write_flags {
-	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
-	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
-	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
-	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
-	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
+	COMMIT_GRAPH_WRITE_APPEND        = (1 << 0),
+	COMMIT_GRAPH_WRITE_PROGRESS      = (1 << 1),
+	COMMIT_GRAPH_WRITE_SPLIT         = (1 << 2),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3)
 };
 
 enum commit_graph_split_flags {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 89020d3d44..74f93f0a17 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -84,11 +84,18 @@ graph_read_expect() {
 
 test_expect_success 'exit with correct error on bad input to --stdin-commits' '
 	cd "$TRASH_DIRECTORY/full" &&
-	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	# invalid, non-hex OID
+	echo HEAD >in &&
+	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
 	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
-	# valid tree OID, but not a commit OID
-	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
-	test_i18ngrep "invalid commit object id" stderr
+	# non-existent OID
+	echo $ZERO_OID >in &&
+	test_expect_code 1 git commit-graph write --stdin-commits <in 2>stderr &&
+	test_i18ngrep "does not exist" stderr &&
+	# valid commit and tree OID
+	git rev-parse HEAD HEAD^{tree} >in &&
+	git commit-graph write --stdin-commits <in &&
+	graph_read_expect 3
 '
 
 test_expect_success 'write graph' '
-- 
2.26.0.113.ge9739cdccc
