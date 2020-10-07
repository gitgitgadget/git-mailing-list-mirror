Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EEFC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631DA2076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NigiRWGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgJGOJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgJGOJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50BC0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t9so2318652wrq.11
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gEEemcudnq8KGHyGjlB6DzfDcvsvsJmzl9yYZeOG8QQ=;
        b=NigiRWGp+AL1Bw5p3/FEu0CDb5Oet06Xp/ANe+1X8aRDP5ypxIJ7Qo7XxS2GQ+8KBJ
         sq84oVAN1FtJrHyLTIEnwREdU/chN8Gq0NjgDZ7WbzL8uMDzkw77J8DhU6zdloCRcSNv
         5kgAEa7kf87MKaraMigipHmzNXtqjPA8ZgR8cSthraCbByH2AtPSB+C7VDtKLzPpJCC+
         oe5QJcN1DCiJdKw+s7KN1/uIAqcRlyiA2xQd5fJQc9z68YFsyRSPa+EQohsRMmvpG6pR
         CkUMuGW73wUvHx2a3pklEHHMWQAi3sQvadtFgCHwvs5oYf1STo6t+yAg6LW6BbCVN+GK
         gH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gEEemcudnq8KGHyGjlB6DzfDcvsvsJmzl9yYZeOG8QQ=;
        b=C3GXvhPET1WiULYM1C/F09qrDV6JaK4m7Gf7HW5xRu2qQ4f3VyHvfFdZsbBiTuCTUM
         8oKeBlv+0P5o+ilg/mnw0WM4b1hquL6l8uH9wGyhy29D//gqYBeMZoWX4AwM24CEwRSi
         bpLYWfIvIh7U2Iky3QXfmEkpOJMbXn8YvbBeyIa7HrkBcBkUis+bOLfm0oagKA+h4wiS
         fPYy3dxuKC3dvtxeqXnJTywsM7kh2vHc9pVlWaJrEwpjqH0jzRxnGqBVSsghC6NL+T8n
         PU3baPaeUDkhZrTIHIK/g5regr4ITjA7u6Ub5ngGvUgmq93HFK82GJW0HxNjlE3cfr0k
         S2hA==
X-Gm-Message-State: AOAM532PTNAyAe/FqF0vIWqAwiTw6tvp2Z7X4ygEFe20fiAuSUhJjreO
        znkCyOzO1A2Bw+70b8nKsPbnQG8QxL4=
X-Google-Smtp-Source: ABdhPJxEVl3tWXWesdCGGgUPe4obnf7FjWKUG8luO9yz8MA0m1ASVvpIDBKg84EacxVf+YYVxfR+Bw==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr3786831wrn.265.1602079790451;
        Wed, 07 Oct 2020 07:09:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm2928833wmc.28.2020.10.07.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:49 -0700 (PDT)
Message-Id: <18bb3318a12c859c21c8e95285d551c48d31b54b.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:38 +0000
Subject: [PATCH v4 03/10] commit-graph: consolidate fill_commit_graph_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
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
chunk. However, with the corrected committer date, we have to load
committer date to calculate generation number value.

e51217e15 (t5000: test tar files that overflow ustar headers,
30-06-2016) introduced a test 'generate tar with future mtime' that
creates a commit with committer date of (2 ^ 36 + 1) seconds since
EPOCH. The CDAT chunk provides 34-bits for storing committer date, thus
committer time overflows into generation number (within CDAT chunk) and
has undefined behavior.

The test used to pass as fill_commit_graph_info() would not set struct
member `date` of struct commit and loads committer date from the object
database, generating a tar file with the expected mtime.

However, with corrected commit date, we will load the committer date
from CDAT chunk (truncated to lower 34-bits to populate the generation
number. Thus, Git sets date and generates tar file with the truncated
mtime.

The ustar format (the header format used by most modern tar programs)
only has room for 11 (or 12, depending om some implementations) octal
digits for the size and mtime of each files.

Thus, setting a timestamp of 2 ^ 33 + 1 would overflow the 11-octal
digit implementations while still fitting into commit data chunk.

Since we want to test 12-octal digit implementations of ustar as well,
let's modify the existing test to no longer use commit-graph file.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c      | 27 ++++++++++-----------------
 t/t5000-tar-tree.sh | 20 +++++++++++++++++++-
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 94503e584b..e8362e144e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -749,15 +749,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
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
 
@@ -772,38 +781,22 @@ static int fill_commit_in_graph(struct repository *r,
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
index 3ebb0d3b65..8f41cdc509 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -431,11 +431,29 @@ test_expect_success TAR_HUGE,LONG_IS_64BIT 'system tar can read our huge size' '
 	test_cmp expect actual
 '
 
+test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
+	rm -f .git/index &&
+	echo foo >file &&
+	git add file &&
+	GIT_COMMITTER_DATE="@17179869183 +0000" \
+		git commit -m "tempori parendum"
+'
+
+test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
+	git archive HEAD >future.tar
+'
+
+test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
+	echo 2514 >expect &&
+	tar_info future.tar | cut -d" " -f2 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
 	rm -f .git/index &&
 	echo content >file &&
 	git add file &&
-	GIT_COMMITTER_DATE="@68719476737 +0000" \
+	GIT_TEST_COMMIT_GRAPH=0 GIT_COMMITTER_DATE="@68719476737 +0000" \
 		git commit -m "tempori parendum"
 '
 
-- 
gitgitgadget

