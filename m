Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA788C433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A507820639
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkwgPo11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgHOWFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgHOVux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEEBC0A3BEF
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so10428109wma.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6AVQeslCBa1mSfJ9qfMqVwa16RSD2qGpgXX3ZnaVk/A=;
        b=FkwgPo11Bc0VQFZOBv7a8d4PXg7xUAJolRUW4vVjUwJ44Ec9hrpFqsuwDz3LC10KdW
         3CE25Kr2Z2MrcgomH3+adxUBsZotC3aYL3r2kBBZPvZThWCa7pqsA1pYYAFTPcUrh+wp
         Qd+/0vhuL/bpKAZgqbRTIblehVn3feEAlT4ub3svU2xjyRWSDdypmmFCQap9OT7cZM6I
         6BHKCStxeoL0NnG2GOtcN5omsfvKds9C2AMS0ANtXDJ4INWV7MI5YdcbSUoL7R6fNRUH
         uFerv05GAfcKXCTp3wY2RJfYoUfujuRpWEsHgZvo7GYCDmW4J2keYmd71y4KNxLfl9Qv
         2isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6AVQeslCBa1mSfJ9qfMqVwa16RSD2qGpgXX3ZnaVk/A=;
        b=Tuyx+U/zAHNKtHlEHBfV/fjaPMNUpcrVxBLl2m3akw/fOEi+EfpbuI6QB9eWRBEM1g
         zFQ30NrIqBVaumDJsrZCK2NrkPSZXiKGxrdDBjMOa98UVsLrSEyubDGR8jhdzVSR1bBS
         61Q0XnwO5f9UdBeTUJ51QtY+tkDWQDtKpW4JRc+JCB50rKGCFwTBs13xoqJfGa9n5Grh
         YDFu01adTB1a4Im6IJncsCdyYzV8ldhAAWv4+aV9DrqroBs6/53Xdot4UpzvAHSy2NsW
         9h1cKTb5qbdWhiDoxIV236x6hcc5TaZHK2lTtQsYu8dLeye5tA4M2ZFJmiS8W+aDg6uI
         znyA==
X-Gm-Message-State: AOAM530nJYUh8N6aULzXOlRACwIO0ejYddtpNcsJCJ16yvu1Og/nGM1O
        BntD23JSoF7Y5Tf77N9FXFkagwPWc4A=
X-Google-Smtp-Source: ABdhPJzYmkweA7j1E4fQFrh9Zj64Aarif4Qy/wGrbeXvgH3kpXR0Sh6NyTTUxwQk41lCaEx1fFbHoA==
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr7331105wmy.15.1597509587646;
        Sat, 15 Aug 2020 09:39:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm23251642wmf.47.2020.08.15.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:47 -0700 (PDT)
Message-Id: <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:35 +0000
Subject: [PATCH v3 03/11] commit-graph: consolidate fill_commit_graph_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

Both fill_commit_graph_info() and fill_commit_in_graph() parse
information present in commit data chunk. Let's simplify the
implementation by calling fill_commit_graph_info() within
fill_commit_in_graph().

The test 'generate tar with future mtime' creates a commit with commit
time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
generation number (within CDAT chunk) and has undefined behavior.

The test used to pass as fill_commit_in_graph() guarantees the values of
graph position and generation number, and did not load timestamp.
However, with corrected commit date we will need load the timestamp as
well to populate the generation number.

Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c      | 29 +++++++++++------------------
 t/t5000-tar-tree.sh |  4 ++--
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ace7400a1a..af8d9cc45e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -725,15 +725,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
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
 
@@ -748,38 +757,22 @@ static int fill_commit_in_graph(struct repository *r,
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
-	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
+	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
 
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
index 37655a237c..1986354fc3 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -406,7 +406,7 @@ test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
-	GIT_COMMITTER_DATE="@68719476737 +0000" \
+	GIT_COMMITTER_DATE="@17179869183 +0000" \
 		git commit -m "tempori parendum"
 '
 
@@ -415,7 +415,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 '
 
 test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
-	echo 4147 >expect &&
+	echo 2514 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

