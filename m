Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E580DC4332B
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7078229C4
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbhAPSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbhAPSMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 13:12:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AD0C061757
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 6so5190801wri.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ac+MwXeGUKbNK/PNg6KPk7bDf6C2PPLDQznxPd6T63g=;
        b=cBYSkV33rVdlgujmx6Jj4C4dKMduxtrnZzj2LGHzP60Yb9e8SsDbJlGSYiwGDmVfP3
         H9+dknthytKgerYHqHwYYJeEYx3nADKdXlcgkL3GsQJTQG6vPdrqmAh4manQzFkKV0F4
         7Mxvb2VRZGDQo7iLaM7R3qfqeNaw2awkc6oTL5Fb0LWgmYd3YGs32d5bKDlD6Bakhg1A
         3uAlW/4tmWRodnvQplJOuG3xnMBLnL5GNRVsbGfdHvOhaFg1314Iq3xbNRisoOeRIz7e
         iwIBBjHgFg760spp1+tcPUs1r5/Nn7mL2WRwWV0fK2Itn4QMjpYc3i+hAetW2WgxLvZS
         mFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ac+MwXeGUKbNK/PNg6KPk7bDf6C2PPLDQznxPd6T63g=;
        b=tLAI+P0Bx2KG2+DaMHzJS09+mjJ2tVbzSSs69GuLVj8es+oPlns2Ar4i0+9r7OrKAU
         4AzcIGD9hVQ9bOy5QG2e+sn0o+a6IY9iGOfOZZx2cgpRjBj+I1Bg7aPx1w7v9Fmobxet
         pJY3KJaK83GQL5eKWkVBhsQWKKnn+Bz49iEH/Jt2Eh0q3Xwvj/merT9V7kR4IyWSKr3S
         /Yg12BGKk3NJZUaNRbFB2MnwpSA0wdcoQtgpCmNwNLtrp+mCzLs8kWG2tOFXrLfcanK4
         aKNEcWuA4JMI7XKFyDJUncZ4K9sFbPrBB4YWxSMhbcXKgH3uWP57jDfHy+bR9fX2V7Z0
         xa9w==
X-Gm-Message-State: AOAM531pO8BUjJVSNZb+++bi2AxPW2NKdfh6K7e+VTXX3hAc8qt8DXOC
        zN0rRPd0SHgSRSUeVX+CM0abWsS9bnA=
X-Google-Smtp-Source: ABdhPJypg/TsRHIsKiNgPo1/XNxbolQm88XQv1vSN2+xFvvDQ1/eLSiTKgAtRtP3C0m7m/shGy0qfg==
X-Received: by 2002:a05:6000:cc:: with SMTP id q12mr19221182wrx.335.1610820683926;
        Sat, 16 Jan 2021 10:11:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm8729805wmb.47.2021.01.16.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 10:11:23 -0800 (PST)
Message-Id: <dcb9891d819d9d848d26c93de8b5ed80f912535f.1610820679.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 18:11:10 +0000
Subject: [PATCH v6 03/11] commit-graph: consolidate fill_commit_graph_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Both fill_commit_graph_info() and fill_commit_in_graph() parse
information present in commit data chunk. Let's simplify the
implementation by calling fill_commit_graph_info() within
fill_commit_in_graph().

fill_commit_graph_info() used to not load committer data from commit data
chunk. However, with the upcoming switch to using corrected committer
date as generation number v2, we will have to load committer date to
compute generation number value anyway.

e51217e15 (t5000: test tar files that overflow ustar headers,
30-06-2016) introduced a test 'generate tar with future mtime' that
creates a commit with committer date of (2^36 + 1) seconds since
EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
committer time overflows into generation number (within CDAT chunk) and
has undefined behavior.

The test used to pass as fill_commit_graph_info() would not set struct
member `date` of struct commit and load committer date from the object
database, generating a tar file with the expected mtime.

However, with corrected commit date, we will load the committer date
from CDAT chunk (truncated to lower 34-bits to populate the generation
number. Thus, Git sets date and generates tar file with the truncated
mtime.

The ustar format (the header format used by most modern tar programs)
only has room for 11 (or 12, depending on some implementations) octal
digits for the size and mtime of each file.

As the CDAT chunk is overflow by 12-octal digits but not 11-octal
digits, we split the existing tests to test both implementations
separately and add a new explicit test for 11-digit implementation.

To test the 11-octal digit implementation, we create a future commit
with committer date of 2^34 - 1, which overflows 11-octal digits without
overflowing 34-bits of the Commit Date chunks.

To test the 12-octal digit implementation, the smallest committer date
possible is 2^36 + 1, which overflows the CDAT chunk and thus
commit-graph must be disabled for the test.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c      | 27 ++++++++++-----------------
 t/t5000-tar-tree.sh | 24 +++++++++++++++++++++---
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0267886e76c..3d59b8b905d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -753,15 +753,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 	const unsigned char *commit_data;
 	struct commit_graph_data *graph_data;
 	uint32_t lex_index;
+	uint64_t date_high, date_low;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
+	if (pos >= g->num_commits + g->num_commits_in_base)
+		die(_("invalid commit position. commit-graph is likely corrupt"));
+
 	lex_index = pos - g->num_commits_in_base;
 	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 
 	graph_data = commit_graph_data_at(item);
 	graph_data->graph_pos = pos;
+
+	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
+	date_low = get_be32(commit_data + g->hash_len + 12);
+	item->date = (timestamp_t)((date_high << 32) | date_low);
+
 	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
 }
 
@@ -776,38 +785,22 @@ static int fill_commit_in_graph(struct repository *r,
 {
 	uint32_t edge_value;
 	uint32_t *parent_data_ptr;
-	uint64_t date_low, date_high;
 	struct commit_list **pptr;
-	struct commit_graph_data *graph_data;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
 
 	while (pos < g->num_commits_in_base)
 		g = g->base_graph;
 
-	if (pos >= g->num_commits + g->num_commits_in_base)
-		die(_("invalid commit position. commit-graph is likely corrupt"));
+	fill_commit_graph_info(item, g, pos);
 
-	/*
-	 * Store the "full" position, but then use the
-	 * "local" position for the rest of the calculation.
-	 */
-	graph_data = commit_graph_data_at(item);
-	graph_data->graph_pos = pos;
 	lex_index = pos - g->num_commits_in_base;
-
 	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
 
 	item->object.parsed = 1;
 
 	set_commit_tree(item, NULL);
 
-	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
-	date_low = get_be32(commit_data + g->hash_len + 12);
-	item->date = (timestamp_t)((date_high << 32) | date_low);
-
-	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
-
 	pptr = &item->parents;
 
 	edge_value = get_be32(commit_data + g->hash_len);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ebb0d3b652..7204799a0b5 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -431,15 +431,33 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
 	test_cmp expect actual
 '
 
-test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
+test_expect_success TIME_IS_64BIT 'set up repository with far-future (2^34 - 1) commit' '
+	rm -f .git/index &&
+	echo foo >file &&
+	git add file &&
+	GIT_COMMITTER_DATE="@17179869183 +0000" \
+		git commit -m "tempori parendum"
+'
+
+test_expect_success TIME_IS_64BIT 'generate tar with far-future mtime' '
+	git archive HEAD >future.tar
+'
+
+test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
+	echo 2514 >expect &&
+	tar_info future.tar | cut -d" " -f2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success TIME_IS_64BIT 'set up repository with far-far-future (2^36 + 1) commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
-	GIT_COMMITTER_DATE="@68719476737 +0000" \
+	GIT_TEST_COMMIT_GRAPH=0 GIT_COMMITTER_DATE="@68719476737 +0000" \
 		git commit -m "tempori parendum"
 '
 
-test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
+test_expect_success TIME_IS_64BIT 'generate tar with far-far-future mtime' '
 	git archive HEAD >future.tar
 '
 
-- 
gitgitgadget

