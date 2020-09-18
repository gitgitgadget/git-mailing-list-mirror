Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE5C43466
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EC423119
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 03:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wLT+nnU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgIRDAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgIRDAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 23:00:17 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905AC06178C
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 20:00:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so4613660qke.13
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 20:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kCDfNkMkNN2xKgzVV9LsbBnCksRGKPytvatVrVDNvAM=;
        b=wLT+nnU/00ihSaps/XCSO0NmJ/SqVBiXkmHN5capsZ/J+ADrfpuU6KH2pHd9Em7PQG
         +bueSFZJN1mIrspQSpocZE8I24g4QnTGQ+HJuePRSDbctdTWDLx9TJpiMMWT09/XdHa7
         QNvYUwUrzpWmIkS/JmqiCrKC/KuR8sj2eOzslVKBkgUHSjkGJNjOIYhVWI1iHy1OT/mR
         fPGXWn4HtspAQP2hSuEwqnFXGjXmEMJRcPtMc7IXXu1cpASk3TrJ8bP6d5ZwwM9BLCuF
         dUx6mK2Elh39zyvh+Dg5mnt23kxzft7sfl3hEiLgJWFFKeq3JWoL1JpMblrjLW1yvw7a
         BcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCDfNkMkNN2xKgzVV9LsbBnCksRGKPytvatVrVDNvAM=;
        b=L7fzRrL/7Hqlp8qrbRZpA/Bkg64Sjf5ZJaETL4JxkIQIna8YSxvh8qUSPF1t/Z7Rwa
         5XnXSF8VuALuERiXJI0nJ47b9qN2xMksNo/E0dqgbgDr2ir74z6/t7+j06GsQYQANey2
         WNuxWTWZYnXEUGMqOenNEr6f12LuNqj9Mm6Te3Hh8kyTifZ8TQw7sA+Vr3oDrS69eJd9
         lzLyXLlsrM40jOrPrLatKlc9L3xM0lDPvljhe7Vj2idTTaulpfdGw3n8h5y2UihZkf1W
         irvYxuUdCRV71AombJnc3RCN4UQ6cJf/GlYY6gVPrNwyCQY0xfZS2dnAxltWUUmzaj9K
         wlsg==
X-Gm-Message-State: AOAM531CoXRaJT8KjQEJwVW5wHQEDV+weU8QkNojVHKbJfH9HMV+py0j
        6FuWeW+67dMovtupb0E0W6j2eWQAaLVhQvGd
X-Google-Smtp-Source: ABdhPJyt8XDtrr2tMAvgJMybEkfX9zdDW9umUSfOF0ZOji80SJuqyeLAQo4MkRZ1ksJdfmSh1JhJUQ==
X-Received: by 2002:a37:d41:: with SMTP id 62mr29790354qkn.444.1600397999735;
        Thu, 17 Sep 2020 19:59:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id a25sm1216913qtd.8.2020.09.17.19.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:59:59 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:59:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 13/13] commit-graph: introduce 'commitGraph.maxNewFilters'
Message-ID: <375ecf1f3651b250982216d40167e4c23b8e15ff.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600397826.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600397826.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 8357846d30..60df4e4bfa 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -70,7 +70,8 @@ data.
 With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
 filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
 enforced. Commits whose filters are not calculated are stored as a
-length zero Bloom filter.
+length zero Bloom filter. Overrides the `commitGraph.maxNewFilters`
+configuration.
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
