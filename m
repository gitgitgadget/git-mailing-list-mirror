Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F8C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF9C207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIc+2svv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgFZMaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgFZMas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940BEC08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so9318987wrv.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=29kqaBYA7Gxjij0cBSK6aKsNhXGneXI6x43eUcgAmI8=;
        b=VIc+2svvikIE0PF9ICwtOClSYQieKeegRk9zmyE1EoxakTodpP9DUF+v/4YtXT/gqX
         1P0IIOgFGGUvWqAJb/EeuATe11EMS+UbiknyoQwLbBDMY0yzEexiBSBprn2bmtMys50f
         mv4Dg3a08pnGqAEGUKBjWfAh137ZiDzJQfkjblWO/en1B+9t3l6WNXHRdwxgIvmJiD6Q
         3LNzXZ77p2Ow9uzd8HAhmhTybtnSlpxv3Q2PKI7VH6eCVrEMm3CK4H30keryvtSVC3AF
         Kg2myL11OxDkNl2G/pxEiFfqq9Da/H6BwnMhfe9T8QK7veTUHw+lXgvK2zQlGoUHPJbw
         c2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=29kqaBYA7Gxjij0cBSK6aKsNhXGneXI6x43eUcgAmI8=;
        b=KxUq8/oZ/dYdwFREu/ledL87unDAa6q0oIIfykWvgGHisK/0U+2gYI1LK7uQLH1A1F
         FZ8gQJgZyb3B0076dylPSncjlN2DmuGykcr97aSbJvI9N6VcOYmikk7f+ndHjrevyR5y
         WTTehkAh2s/BwCSHKnp+sCq8qLuRAsBdLuBmUNHB99KIU38DBMsExkk39v+iEiSUKikV
         YCmydq3SeOKS6V/Ap0PemgQPuiMkXxM3CVdtHq90fR5Ay7si+PBKBy3g98ugMPMj6jge
         BZe7NxWpOut8QRXBCUHc/bCJFFwupKrfX01O1sa8Htk+dhIXwmYX2fNXlXvb+pn1Ooz0
         9l1Q==
X-Gm-Message-State: AOAM5331W3HpBvDtF6PACdWbENd5l9qosKyw2TfyMEqpr1vYmxcMKndT
        qeUACgqNy4xHM7kXXd1v3UlQlGeh
X-Google-Smtp-Source: ABdhPJwmGYkQwHbimWSD71DAGRAZaU4UEF0o0k1LQZ7fpnnwkpBGBggiAZH338yV8VV1jPP99uP41Q==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr3607407wru.208.1593174647102;
        Fri, 26 Jun 2020 05:30:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm16749364wma.43.2020.06.26.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:46 -0700 (PDT)
Message-Id: <40061233ca2dee2ecdb9f197fc3e5999793594b3.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:36 +0000
Subject: [PATCH v3 10/10] commit-graph: check all leading directories in
 changed path Bloom filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

The file 'dir/subdir/file' can only be modified if its leading
directories 'dir' and 'dir/subdir' are modified as well.

So when checking modified path Bloom filters looking for commits
modifying a path with multiple path components, then check not only
the full path in the Bloom filters, but all its leading directories as
well.  Take care to check these paths in "deepest first" order,
because it's the full path that is least likely to be modified, and
the Bloom filter queries can short circuit sooner.

This can significantly reduce the average false positive rate, by
about an order of magnitude or three(!), and can further speed up
pathspec-limited revision walks.  The table below compares the average
false positive rate and runtime of

  git rev-list HEAD -- "$path"

before and after this change for 5000+ randomly* selected paths from
each repository:

                    Average false           Average        Average
                    positive rate           runtime        runtime
                  before     after     before     after   difference
  ------------------------------------------------------------------
  git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
  linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
  tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%

*Path selection was done with the following pipeline:

	git ls-tree -r --name-only HEAD | sort -R | head -n 5000

The improvements in runtime are much smaller than the improvements in
average false positive rate, as we are clearly reaching diminishing
returns here.  However, all these timings depend on that accessing
tree objects is reasonably fast (warm caches).  If we had a partial
clone and the tree objects had to be fetched from a promisor remote,
e.g.:

  $ git clone --filter=tree:0 --bare file://.../webkit.git webkit.notrees.git
  $ git -C webkit.git -c core.modifiedPathBloomFilters=1 \
        commit-graph write --reachable
  $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/info/
  $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=1 \
        rev-list HEAD -- "$path"

then checking all leading path component can reduce the runtime from
over an hour to a few seconds (and this is with the clone and the
promisor on the same machine).

This adjusts the tracing values in t4216-log-bloom.sh, which provides a
concrete way to notice the improvement.

Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c           | 46 +++++++++++++++++++++++++++++++++++---------
 revision.h           |  6 ++++--
 t/t4216-log-bloom.sh |  2 +-
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index b53377cd52..b40bc5b51b 100644
--- a/revision.c
+++ b/revision.c
@@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
 	char *path_alloc = NULL;
-	const char *path;
+	const char *path, *p;
 	int last_index;
-	int len;
+	size_t len;
+	int path_component_nr = 1;
 
 	if (!revs->commits)
 		return;
@@ -709,8 +710,33 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		return;
 	}
 
-	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
-	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
+	p = path;
+	while (*p) {
+		/*
+		 * At this point, the path is normalized to use Unix-style
+		 * path separators. This is required due to how the
+		 * changed-path Bloom filters store the paths.
+		 */
+		if (*p == '/')
+			path_component_nr++;
+		p++;
+	}
+
+	revs->bloom_keys_nr = path_component_nr;
+	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+
+	fill_bloom_key(path, len, &revs->bloom_keys[0],
+		       revs->bloom_filter_settings);
+	path_component_nr = 1;
+
+	p = path + len - 1;
+	while (p > path) {
+		if (*p == '/')
+			fill_bloom_key(path, p - path,
+				       &revs->bloom_keys[path_component_nr++],
+				       revs->bloom_filter_settings);
+		p--;
+	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
 		atexit(trace2_bloom_filter_statistics_atexit);
@@ -724,7 +750,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result;
+	int result = 1, j;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -744,9 +770,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	result = bloom_filter_contains(filter,
-				       revs->bloom_key,
-				       revs->bloom_filter_settings);
+	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
+		result = bloom_filter_contains(filter,
+					       &revs->bloom_keys[j],
+					       revs->bloom_filter_settings);
+	}
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -786,7 +814,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_key && !nth_parent) {
+	if (revs->bloom_keys_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
diff --git a/revision.h b/revision.h
index 7c026fe41f..abbfb4ab59 100644
--- a/revision.h
+++ b/revision.h
@@ -295,8 +295,10 @@ struct rev_info {
 	struct topo_walk_info *topo_walk_info;
 
 	/* Commit graph bloom filter fields */
-	/* The bloom filter key for the pathspec */
-	struct bloom_key *bloom_key;
+	/* The bloom filter key(s) for the pathspec */
+	struct bloom_key *bloom_keys;
+	int bloom_keys_nr;
+
 	/*
 	 * The bloom filter settings used to generate the key.
 	 * This is loaded from the commit-graph being used.
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index e3e4badd4c..d7dd717347 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -146,7 +146,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":8"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
gitgitgadget
