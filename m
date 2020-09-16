Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEDEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B092083B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hDuqiQJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgIPSKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgIPSJU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:09:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8BDC061351
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k25so6890175qtu.4
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YSX5z86CwPGzYPidQYbMN3Nk/ZLpPYpBuu0bNpMg9yE=;
        b=hDuqiQJ0b/Yx1xmHfKL/Zllwf9ZJDZ8IfbotxNrQ9L32hr7I4G5Bu2DkaXv9LsNc7Z
         1KFiJd+7d2I0dxKQgjPz5kr9vi0ZyD3r9yk8kRLhoUNQpVgE2MfURxZfKtbJPEOns0qz
         FdtpDVPiMETDlFM49MrwVfQMznK8htjNCm8psJykstguasBi4P3AO2vLCKq2YoZ1ftHV
         rK+Pb+vkZwCYzwpuvgx1wLR789UJTDrmN/y3/LdKiydhR60cidFThddI4b9i3V7jdCMl
         z2oUufwygPp0H39luj8gDK7F2FlBTCZU2mE6b64tVmQHBmMaGSiE4Bbu10u9FkKBX5hX
         nCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YSX5z86CwPGzYPidQYbMN3Nk/ZLpPYpBuu0bNpMg9yE=;
        b=nltJ5nBwyUiPeBOtjIlbaH9Su8oLUd62I+8FsGWCId6n9CfbUA+XlxqsE5pcCBh1FA
         SMDoID9Y1DDESfao3uiNbXQ7j1+yX6WvBL+iNErsyGcV8TvdHlJ16ewbFcjOMcB5JOx9
         75tA+KAg8empk1H/okSxDu5PKR70itwi1j72oam7VsZ1T5rsLl2SI0dJWnkB8cq1o1/k
         eUfkCwLN3WbB6CEb7mG8SVKE7JVT7dli+pwCJRKGmZkQWv+0I9dNhd3B7MAe1eJh71Mz
         mh0+re0isrfTOcC5mZaKHOvPvB5qPsoFljKUVZcQVG0hal3pA1Vr0V92C/NDMo/a5Xkt
         5OWQ==
X-Gm-Message-State: AOAM533YQ/Y8JsB40/wIbQaHxpAN3PX4L/irWNy6jcDJRLlJCt0qYvle
        9WcpNPgwxVr1DK/GifsKwpVu0qaKl0RSg+N9
X-Google-Smtp-Source: ABdhPJxdX6gYU4krGSBuKrRMrYo1qV+JLeDL2lZ0jjkbD+Zhj1WuIPquS6IhMOAXa1EZdHqnUNf+Sg==
X-Received: by 2002:ac8:34f2:: with SMTP id x47mr11582214qtb.282.1600279699426;
        Wed, 16 Sep 2020 11:08:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id m18sm20454530qkg.77.2020.09.16.11.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:08:18 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:08:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 13/13] commit-graph: introduce 'commitGraph.maxNewFilters'
Message-ID: <86fdc5f89a1637e889e686d60f75a904c0f4485c.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a configuration variable to specify a default value for the
recently-introduce '--max-new-filters' option of 'git commit-graph
write'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
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
index 9ce0c318e9..dc7d62c778 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -329,13 +329,15 @@ test_expect_success 'Bloom generation is limited by --max-new-filters' '
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
 		test_filter_trunc_small 0 trace.event &&
@@ -343,6 +345,26 @@ test_expect_success 'Bloom generation backfills previously-skipped filters' '
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
+		test_filter_trunc_small 0 trace.event &&
+		test_filter_trunc_large 0 trace.event
+	)
+'
+
 test_expect_success 'Bloom generation backfills empty commits' '
 	git init empty &&
 	test_when_finished "rm -fr empty" &&
-- 
2.28.0.510.g86fdc5f89a
