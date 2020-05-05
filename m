Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B9FC3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CAB206C0
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mqot0c6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgEEBOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727995AbgEEBOH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:14:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46877C061A10
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:14:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d22so277915pgk.3
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qxp+RYUQvLl8UoxEVVi+qxYVgTs+8lkxtE2/JD3YErA=;
        b=mqot0c6b77QVc9ajKlBwR2jqSITxMjx6pL7L9USISyADFofHZYJ2NepYMVl+zBvfM9
         GkXmntqzHJ6kDzzcH6If39EYxB8XxwAPjyzCa/gTav83+MIpXr8i73+OXA7B1QI9Rk+t
         ovgFCGa36mLbLALUmREJ86WHkLqqArEEAdtO1SwhKpQG9ca0LCv2IuCRZKijEWItvK5P
         FBy1pUjc153NceBkop1Ngq5oQjmGm6JjF3A0oxvMmMJiyx19AnOR7IHNCW5iaePhll+M
         IGhN4nspBIdsE4KIq+dCeVKFDIioibKwZ69FZxitIHCG98i8O8efVQmyWAZCuUy0A4jf
         Kn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qxp+RYUQvLl8UoxEVVi+qxYVgTs+8lkxtE2/JD3YErA=;
        b=kKoEHKKGvlSvghBVAyvCFxfuI0cJ4e0RCZHAm1/toI7RUczPfxpfn/M9K+uKBjPgBa
         wrnX71HYtxhk1KbrTuVz2Ub5oxc1jxGr1NrsQgXcltFLil8/ywUNPaQKXX7Y9IxnKhFI
         cxVfkrRqRgVlLqVp4xaFQ347OeNp0FovbT02aJHqDWHVO+MyhuF8ZSrrMNJUEEPTuwKk
         956rLJOncZlmz0MFj5prKaJ5zjhWKq5uPOobhWVmeVlOW+5/Eqodx9ZUQcme6RSUJMKF
         rvID9JMND7eISByGvGiV3MsL/fjP8fd2Sve8VUYRRtDyN5I1UKmvjz6BbuQVfI42v5c0
         OTXw==
X-Gm-Message-State: AGi0PuaCORJwbJ2vpltEfzZl8ah8wxBmPT15nEoJkmTY3egQhD/FmTCo
        925bJiDF9hRfnCQpZEsHPxMFYyMAT4Eb4A==
X-Google-Smtp-Source: APiQypLNyim69jroftsmRms/XIYp4MiMBfro4BNRdZY777IeehjZAGa9a4MN0F6v13WBV0EhVMVPWQ==
X-Received: by 2002:a63:1447:: with SMTP id 7mr868601pgu.253.1588641245223;
        Mon, 04 May 2020 18:14:05 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j7sm234210pjy.9.2020.05.04.18.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:14:04 -0700 (PDT)
Date:   Mon, 4 May 2020 19:14:03 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <6c2d130b0cd4b6a8a541b362ae7dd44d4c282e3f.1588641176.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588641176.git.me@ttaylorr.com>
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
index 9eec68572f..3637d079fb 100644
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
 					_("Analyzing commits from stdin"), 0);
diff --git a/commit-graph.c b/commit-graph.c
index 24c2d80935..4e5539bac5 100644
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
