Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A57AC43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1945B20637
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="c2wCL6S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgCWUMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:12:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43636 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:12:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so2343514ply.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eP1/J+OaMYEr14EHnIf5tNSNy+Gv0TK5OhE0X2OOdjY=;
        b=c2wCL6S4soQIyPS52+Rsz0TrrSDINipyotF9hsGaaX1WyWymEsos1HR32a6CPk9eW0
         NNdFV5ye4IXfhzSur04iIatKRx4WM6V4EgdwI2m4OWLYYHsA38XfEHU04bdK+l3T/lz0
         tUuIkLVX8P89J2/jDlfnmma5nR8DAPIRJqwOHs3aQ3gDc8UHHmo+0sjmsM5tqOkgqRQu
         jqHOiuOP4/Iqjb9nFKD9OlslRWqk0Dx6Kwx1ownGyQeCew1hz97q8E2wwp8fMXO4P0Lq
         YiffpeuvRviVmnFYGKzAokGbYlwo1WI46T54yvvQjxyfpeESZcypM0Ywi6hrXjpJR+ou
         bOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eP1/J+OaMYEr14EHnIf5tNSNy+Gv0TK5OhE0X2OOdjY=;
        b=eJ15UXxcK1Jyt3AKU3bdRscydpvA2cHB+mIVjIPsPz+aZM4kFzMP308KG6SKiWBg06
         tjygEZpinlCJ9YKoiaPuqEgKRMWQAG7S4l39/kCyrWTD0FTty/AzCz4isYdqQHa92QGV
         Qj9kaBMXkaAR5GXS1cIbcnw5RcHispOdNUWKpIcaVUmpwR1tN20YxQcVoRnR80FpX9uG
         0nAyyczP6Od/5UNN65yn31fzmKioyTy3dfrc7GrjKSTwjpO0tkinskQF81/6ZxAlIj0x
         4eIcn6+oMotkW0XIYrb3v7z90dgalyE0tIE0JhEUK+yoRO0kQxVSNlmaQ4jAhaq+o6Y8
         sWTQ==
X-Gm-Message-State: ANhLgQ1/rWqAPBxyqrAPxZAu21zxG3glw3+w5QDYpxVtexm9UZCmowZf
        knEbNujo8NhqaHLtY3CeiF1/ZH7WzG8=
X-Google-Smtp-Source: ADFU+vuuFtbgJAdTcX2Delz2r/m2YbbY/tMdkfs98N81mPPY/fzeUKOT9wJBaPUyztcYExL0T9hz2Q==
X-Received: by 2002:a17:90a:26ed:: with SMTP id m100mr1188684pje.130.1584994341246;
        Mon, 23 Mar 2020 13:12:21 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a15sm14164298pfg.77.2020.03.23.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:12:20 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:12:19 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: [PATCH v4] builtin/commit-graph.c: support '--input=graphed'
Message-ID: <e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com>
References: <7c47f37122ff2b03f0bccc48cb6ca022904f6353.1583278022.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c47f37122ff2b03f0bccc48cb6ca022904f6353.1583278022.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In response to some discussion in [1], here is another idea instead of
'--input=none' that may make things a little clearer. Since it had been
a long time, I reminded myself that '--input=none' means
"--input=append, but don't look at packs as is usually the default".

In [1], Gabor suggested that we could call this '--input=exists' or
'--input=existing', but I think that 'graphed' may be clearer, since
it is closer to "only _graphed_ commits".

Another option would be to call this '--input=only-graphed', but I think
that may be overly verbose for what we're going for here.

Let me know what you think.

[1]: https://lore.kernel.org/git/20200322110424.GC2224@szeder.dev/

--- 8< ---

In the previous commit, we introduced '--split=<no-merge|merge-all>',
and alluded to the fact that '--split=merge-all' would be useful for
callers who wish to always trigger a merge of an incremental chain.

There is a problem with the above approach, which is that there is no
way to specify to the commit-graph builtin that a caller only wants to
include commits already in the graph. One can specify '--input=append'
to include all commits in the existing graphs, but the absence of
'--input=stdin-{commits,packs}' causes the builtin to call
'fill_oids_from_all_packs()'.

Passing '--input=reachable' (as in 'git commit-graph write
--split=merge-all --input=reachable --input=append') works around this
issue by making '--input=reachable' effectively a no-op, but this can be
prohibitively expensive in large repositories, making it an undesirable
choice for some users.

Teach '--input=graphed' as an option to behave as if '--input=append' were
given, but to consider no other sources in addition.

This, in conjunction with the option introduced in the previous patch
offers the convenient way to force the commit-graph machinery to
condense a chain of incrementals without requiring any new commits:

  $ git commit-graph write --split=merge-all --input=graphed

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt |  8 +++++++-
 builtin/commit-graph.c             | 11 ++++++++---
 commit-graph.c                     |  6 ++++--
 commit-graph.h                     |  3 ++-
 t/t5324-split-commit-graph.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 0a320cccdd..4d8fbbe8ff 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -39,7 +39,7 @@ COMMANDS
 --------
 'write'::

-Write a commit-graph file based on the commits found in packfiles.
+Write a commit-graph file based on the specified sources of input:
 +
 With the `--input=stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
@@ -57,6 +57,12 @@ walking commits starting at all refs. (Cannot be combined with
 With the `--input=append` option, include all commits that are present
 in the existing commit-graph file.
 +
+With the `--input=graphed` option, behave as if `--input=append` were
+given, but do not walk other packs to find additional commits.
++
+If none of the above options are given, then generate the new
+commit-graph by walking over all pack-indexes.
++
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
 `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0ff25896d0..dfb6c554ac 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,7 +11,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] "
 	   "[--split[=<strategy>]] "
-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append|graphed>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -24,7 +24,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] "
 	   "[--split[=<strategy>]] "
-	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append|graphed>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -33,7 +33,8 @@ enum commit_graph_input {
 	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
 	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
 	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
-	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
+	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4),
+	COMMIT_GRAPH_INPUT_GRAPHED       = (1 << 5)
 };

 static struct opts_commit_graph {
@@ -80,6 +81,8 @@ static int option_parse_input(const struct option *opt, const char *arg,
 		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
 	else if (!strcmp(arg, "append"))
 		*to |= COMMIT_GRAPH_INPUT_APPEND;
+	else if (!strcmp(arg, "graphed"))
+		*to |= (COMMIT_GRAPH_INPUT_APPEND | COMMIT_GRAPH_INPUT_GRAPHED);
 	else
 		die(_("unrecognized --input source, %s"), arg);
 	return 0;
@@ -225,6 +228,8 @@ static int graph_write(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 	if (opts.input & COMMIT_GRAPH_INPUT_APPEND)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
+	if (opts.input & COMMIT_GRAPH_INPUT_GRAPHED)
+		flags |= COMMIT_GRAPH_WRITE_NO_INPUT;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
diff --git a/commit-graph.c b/commit-graph.c
index c5a8ea244b..3da52847e4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -788,7 +788,8 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 no_input:1;

 	const struct split_commit_graph_opts *split_opts;
 };
@@ -1781,6 +1782,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->no_input = flags & COMMIT_GRAPH_WRITE_NO_INPUT ? 1 : 0;

 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1839,7 +1841,7 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}

-	if (!pack_indexes && !commit_hex)
+	if (!ctx->no_input && !pack_indexes && !commit_hex)
 		fill_oids_from_all_packs(ctx);

 	close_reachable(ctx);
diff --git a/commit-graph.h b/commit-graph.h
index 65a7d2edae..df7f3f5961 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -79,7 +79,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_NO_INPUT   = (1 << 4)
 };

 enum commit_graph_split_flags {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 6894106727..6dda4c1f1c 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -376,4 +376,30 @@ test_expect_success '--split=no-merge always writes an incremental' '
 	test_line_count = 2 $graphdir/commit-graph-chain
 '

+test_expect_success '--split=no-merge, --input=graphed writes nothing' '
+	test_when_finished rm -rf a graphs.before graphs.after &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	ls $graphdir/graph-*.graph >graphs.before &&
+	test_line_count = 1 $graphdir/commit-graph-chain &&
+	git commit-graph write --split --input=graphed &&
+	ls $graphdir/graph-*.graph >graphs.after &&
+	test_cmp graphs.before graphs.after
+'
+
+test_expect_success '--split=merge-all, --input=graphed merges the chain' '
+	test_when_finished rm -rf a b &&
+	rm -rf $graphdir &&
+	git reset --hard commits/2 &&
+	git rev-list -1 HEAD~1 >a &&
+	git rev-list -1 HEAD >b &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
+	test_line_count = 2 $graphdir/commit-graph-chain &&
+	git commit-graph write --split=merge-all --input=graphed &&
+	test_line_count = 1 $graphdir/commit-graph-chain
+'
+
 test_done
--
2.26.0.rc2.311.g2e49f7a131
