Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48BCC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C9123447
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="V0jlZf3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIRN3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRN3m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:29:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498DC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:29:41 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so4926960qtd.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PqBEEPcSXN6wsHBTOFqHvSk7LIcvsYnybrUx5vFeQU8=;
        b=V0jlZf3xFSFDbhLXnKVZjoJFy9WrvvBvbWnfYWblNavnVLQ4i43fr2D/IhY1YuDGnp
         fOPOP3fW8DV3lmtJ1T9hEGSV+y+Ry7WspnUn50VUfehm5XZCYkErXVwobJ3jVYqnFHWe
         /w864dMXnONQwGZn3XnEHnjfD4+2p8JdX3M2tMwcI1TqqM+XuX3UvzYfNWj2aj5XeNDd
         auW8wT7i5I8mCuyq5DhAF3CKxb0DJDLz328dBIBfNfS78FFK1RO1QOZP7jbJz+WLBUpS
         OW5Tyx4UVFvLYInMYBP4Lz1fjBr498ixYlb4AghKWTXbkADW4v7E0NoVEDunrNk78HP+
         AN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PqBEEPcSXN6wsHBTOFqHvSk7LIcvsYnybrUx5vFeQU8=;
        b=Wgu7Y0gpJA6X1bA6iIuCraeHFTwSqeytNdUtuo4JqwFFUh1FKs4Mom30fXtOXlnohS
         dg5MukbcQIgU6aroGJYOovF7WRGpGxzYisTs+bxgWNrYr7HaN4yJafjnhs6JNxWRwlcS
         bl6YCE17CyMqX5hDanZn9bMWvBp2m4mx/0dtW90mHX3dOk7sdNvf7esqLYdDl3Tojp0G
         Tavk4IZfhcn3+zfBrZCfKLjMXwng9QnYo87iAnRIB/yo2H7ssenh3XmirQOY10qux4al
         QxGFDDNnZPRw1AZM1Vs7mZBuH8qLQjIjFzOmUEszoiuAkQCcL0KGZsOuXUAjkT9wHUg7
         0QIQ==
X-Gm-Message-State: AOAM532dGNlA0h8ZjTsQCsDS/ioT93pW2o5fg0AqeU+A0GiboaO5qf96
        alnV4PN/+l35KrDzeF95aj/V4CRJ/BPGzhcP
X-Google-Smtp-Source: ABdhPJycMz8oW+uN3Zbi5Pfjxpc/QqwyjW/pc77NcBVJbvlYKgM5ub2+m6DczvLRn+rR5VdcecFR3w==
X-Received: by 2002:ac8:6f3b:: with SMTP id i27mr33554856qtv.299.1600435780364;
        Fri, 18 Sep 2020 06:29:40 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id d76sm1975748qkc.81.2020.09.18.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:29:39 -0700 (PDT)
Date:   Fri, 18 Sep 2020 09:29:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 13/13] commit-graph: introduce
 'commitGraph.maxNewFilters'
Message-ID: <20200918132937.GA1601745@nand.local>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
 <375ecf1f3651b250982216d40167e4c23b8e15ff.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <375ecf1f3651b250982216d40167e4c23b8e15ff.1600397826.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 10:59:57PM -0400, Taylor Blau wrote:
> Introduce a configuration variable to specify a default value for the
> recently-introduce '--max-new-filters' option of 'git commit-graph
> write'.

The replacement in [1] causes a conflict when applying this patch after
it, so here is a suggested resolution:

[1]: https://lore.kernel.org/git/cover.1600397826.git.me@ttaylorr.com/

--- >8 ---

Subject: [PATCH] commit-graph: introduce 'commitGraph.maxNewFilters'

Introduce a configuration variable to specify a default value for the
recently-introduce '--max-new-filters' option of 'git commit-graph
write'.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/commitgraph.txt |  4 ++++
 Documentation/git-commit-graph.txt   |  3 ++-
 builtin/commit-graph.c               | 14 ++++++++++++++
 t/t4216-log-bloom.sh                 | 24 +++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index cff0797b54..4582c39fc4 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -1,3 +1,7 @@
+commitGraph.maxNewFilters::
+	Specifies the default value for the `--max-new-filters` option of `git
+	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
+
 commitGraph.readChangedPaths::
 	If true, then git will use the changed-path Bloom filters in the
 	commit-graph file (if it exists, and they are present). Defaults to
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8c75855782..b6ddbb4700 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -71,7 +71,8 @@ With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
 filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
 enforced. Only commits present in the new layer count against this
 limit. To retroactively compute Bloom filters over earlier layers, it is
-advised to use `--split=replace`.
+advised to use `--split=replace`. Overrides the
+`commitGraph.maxNewFilters` configuration.
 +
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 5df9b2ef80..988445abdf 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -181,6 +181,18 @@ static int write_option_max_new_filters(const struct option *opt,
 	return 0;
 }

+static int git_commit_graph_write_config(const char *var, const char *value,
+					 void *cb)
+{
+	if (!strcmp(var, "commitgraph.maxnewfilters"))
+		write_opts.max_new_filters = git_config_int(var, value);
+	/*
+	 * No need to fall-back to 'git_default_config', since this was already
+	 * called in 'cmd_commit_graph()'.
+	 */
+	return 0;
+}
+
 static int graph_write(int argc, const char **argv)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
@@ -231,6 +243,8 @@ static int graph_write(int argc, const char **argv)

 	trace2_cmd_mode("write");

+	git_config(git_commit_graph_write_config, &opts);
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index af0975c841..d11040ce41 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -330,13 +330,15 @@ test_expect_success 'Bloom generation is limited by --max-new-filters' '
 '

 test_expect_success 'Bloom generation backfills previously-skipped filters' '
+	# Check specifying commitGraph.maxNewFilters over "git config" works.
+	test_config -C limits commitGraph.maxNewFilters 1 &&
 	(
 		cd limits &&

 		rm -f trace.event &&
 		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
 			git commit-graph write --reachable --changed-paths \
-				--split=replace --max-new-filters=1 &&
+				--split=replace &&
 		test_filter_computed 1 trace.event &&
 		test_filter_not_computed 4 trace.event &&
 		test_filter_trunc_empty 0 trace.event &&
@@ -344,6 +346,26 @@ test_expect_success 'Bloom generation backfills previously-skipped filters' '
 	)
 '

+test_expect_success '--max-new-filters overrides configuration' '
+	git init override &&
+	test_when_finished "rm -fr override" &&
+	test_config -C override commitGraph.maxNewFilters 2 &&
+	(
+		cd override &&
+		test_commit one &&
+		test_commit two &&
+
+		rm -f trace.event &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.event" \
+			git commit-graph write --reachable --changed-paths \
+				--max-new-filters=1 &&
+		test_filter_computed 1 trace.event &&
+		test_filter_not_computed 1 trace.event &&
+		test_filter_trunc_empty 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_expect_success 'Bloom generation backfills empty commits' '
 	git init empty &&
 	test_when_finished "rm -fr empty" &&
--
2.28.0.510.g375ecf1f36

