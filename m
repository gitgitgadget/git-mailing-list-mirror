Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF7C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D579B20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Y5q5O9XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgEMV76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730305AbgEMV76 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:59:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7CC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so352969plo.7
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XDveAncyndA1OpRGe166+RHhfPUwNZxvEDdVenpaLMs=;
        b=Y5q5O9XJUbKHa/gYg/6U2ZSSbelLlMmICGRPz/Uh/xlRMI5UmdBCsuPzVTt+aQgzGu
         ND5LawW+jvVhbcjcM3h2CzCCZQnzDF/PVJVZNUQZg+ZXg+xHRlf+N7dhd8RK5etE2AgG
         D5ik116WvKfziwRlmSXBJerhPbbEGp2/PkFGDtRj+y71wXz/a6KbcO1esMylcmTDoPnV
         iLQKJ+EZfp//K9P6IXfw7+xOIIik/UxK9+tm1SpPtyPgx5CcPwGhZpHddCzRARXGUjnh
         sUJ2jLl8bI/JzZkXB4R+QVBtHvNg56PjH7t6hKqwOmUHYY4fR5TR9UfD/PkzAajZsy79
         cj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XDveAncyndA1OpRGe166+RHhfPUwNZxvEDdVenpaLMs=;
        b=gk0JklMytl8YId3ND6KTg5AC7n8d1ySWO+DzcDEd0xzOz3cJoHq1tihPjhkyC3enaH
         i3xiEjQCkUPsjMjQ/suw7LW0EEabd8gHeOu/EXEcJ/lG0tFF93OrSR9qfTnGXt7YRhV0
         UT381kaBPSYU0tAmc9zl4L4g8qDjy/s7oN6tiu0QaqTK8lKx1f2qBcb5yv8pPrTcapBZ
         kXZp7OR4aGVDzZnyuV4dxySKD1UaRfPJbhmuRZcJJvVZ7uvrKvoxqOZUpVLcb2IrVS9Z
         ugJUxqgecggVP7MR6GD8ol3G3HgHBzq/FuidAgabG92dfzxFwAoc/XywEn2nwBg4ElSr
         GYLA==
X-Gm-Message-State: AGi0PubuIAe2VzE08LfuHUYTfkmznr1aDgRfQjsfTNCYdoVEc/T8aM3q
        W8x6iPlMxRln/7y2BuS2yCQd0asnMqs=
X-Google-Smtp-Source: APiQypIhs+KH6WUNZArFdQl6syBGQeD7Q1Ufuf5uYP1ZTYM8JzAagM4KXkoWcK5yePynO5YL3+FLSQ==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr36498090pjj.119.1589407197221;
        Wed, 13 May 2020 14:59:57 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 140sm460520pfw.96.2020.05.13.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:56 -0700 (PDT)
Date:   Wed, 13 May 2020 15:59:55 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 8/8] commit-graph: drop COMMIT_GRAPH_WRITE_CHECK_OIDS flag
Message-ID: <3cb0bd306cbb971715f84db07a8d1acac658f2d0.1589407015.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589407014.git.me@ttaylorr.com>
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
     awk '
       !/commit/ { print "not-a-commit:"$1 }
        /commit/ { print $1 }
     ' |
     git commit-graph write --stdin-commits

To make it so that valid OIDs that refer to non-existent objects are
indeed an error after loosening the error handling, perform an extra
lookup to make sure that object indeed exists before sending it to the
commit-graph internals.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  6 ++++--
 builtin/commit-graph.c             | 15 ++++++++-------
 commit-graph.c                     |  2 --
 commit-graph.h                     |  4 +---
 t/t5318-commit-graph.sh            | 15 +++++++++++----
 5 files changed, 24 insertions(+), 18 deletions(-)

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
index 83c55d9227..d3bd1c31c9 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -7,6 +7,7 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "progress.h"
+#include "tag.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
@@ -142,18 +143,19 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 static int read_one_commit(struct oidset *commits, struct progress *progress,
 			   const char *hash)
 {
-	struct commit *result;
+	struct object *result;
 	struct object_id oid;
 	const char *end;
 
 	if (parse_oid_hex(hash, &oid, &end))
 		return error(_("unexpected non-hex object ID: %s"), hash);
 
-	result = lookup_commit_reference_gently(the_repository, &oid, 1);
-	if (result)
-		oidset_insert(commits, &result->object.oid);
-	else
-		return error(_("invalid commit object id: %s"), hash);
+	result = deref_tag(the_repository, parse_object(the_repository, &oid),
+			   NULL, 0);
+	if (!result)
+		return error(_("invalid object: %s"), hash);
+	else if (object_as_type(the_repository, result, OBJ_COMMIT, 1))
+		oidset_insert(commits, &result->oid);
 
 	display_progress(progress, oidset_size(commits));
 
@@ -240,7 +242,6 @@ static int graph_write(int argc, const char **argv)
 					   strbuf_detach(&buf, NULL));
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
-		flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		if (opts.progress)
 			progress = start_delayed_progress(
 				_("Collecting commits from input"), 0);
diff --git a/commit-graph.c b/commit-graph.c
index 3ea70e6676..2ff042fbf4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -881,7 +881,6 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1,
 		 changed_paths:1,
 		 order_by_pack:1;
 
@@ -2011,7 +2010,6 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
 	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
 	ctx->total_bloom_filter_data_size = 0;
diff --git a/commit-graph.h b/commit-graph.h
index 4212766a4f..3ba0da1e5f 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -91,9 +91,7 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
-	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
-	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 3),
 };
 
 enum commit_graph_split_flags {
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 255e3bb1c9..a79c624875 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -88,11 +88,18 @@ graph_read_expect() {
 
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
+	test_i18ngrep "invalid object" stderr &&
+	# valid commit and tree OID
+	git rev-parse HEAD HEAD^{tree} >in &&
+	git commit-graph write --stdin-commits <in &&
+	graph_read_expect 3
 '
 
 test_expect_success 'write graph' '
-- 
2.26.0.113.ge9739cdccc
