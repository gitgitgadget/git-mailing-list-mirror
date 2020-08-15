Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D8C433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27132053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyTbWC8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgHOVxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgHOVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC721C0A3BF1
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id 88so10968419wrh.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8yKwkpMYec9D/7NkNOP3qoKkDCzYHq6Bs1apFgJT+rs=;
        b=WyTbWC8Lr9PMsPA66qumdHWg72BmF8syIO6/W7ch5HVy2MOtD2xH0j6ONOdFZHTt0j
         N51pvLIq1A+XOEx4WY7xceshch9AMUKmbbIE/34y+4JirxkUTVfJiqU0qk6gdvSI3Pxf
         chNzcpidhO4XPGlTalEA1MSr4HAgYh26ku76maSjX7rCq6Hj2jRAjRVo7I3O+gwC5VVh
         Bax4cipclxNy6ukwFznokF3HgerAX5X6MzrbJNxSXDgOfjvy8uYn4brKiqTMs8qmgDZ3
         2iK2tZBx74qn7C2m+elixpGx8A4rAcWtuPzaTdHtps74qqHFPyFiYb0DupCHeg//FY4A
         3v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8yKwkpMYec9D/7NkNOP3qoKkDCzYHq6Bs1apFgJT+rs=;
        b=TtzJ1CWjp/V7bYS/AobnfezasxYdbCaMnR2K1FcHA7bcry3XlVBccjERiFChqMYk8T
         OpL6/apdAC4xm6g34iAzpzuTY6lLC5ptaFmAOmY2fsvcT4fOdlEZd9a5D1rkrPyryHl/
         rlwpzUw9BJwDl57DanWyvDL7biThzWwKOupbMKKxgLUfG1nIKKSeOGXbKHVbdO6sYYtt
         Rf9HJjlflzehOjjR0Heb1V4X/CLLRx0V2u1k8fOD7JQIrXG3E0ZMSoM+Qzh2j/+hu9q+
         IqIUwmSu9SpMhOnAVbwCOe5Sotn6K2e9PkPPCbtaWVqD250ENGmlP56i3/Pnm8K6yGw7
         0x1A==
X-Gm-Message-State: AOAM531XE49T+5hk136s8+DfUo7jfl5ncO+p+rK3yWSC4orEKQKnu0pg
        E5usNW7ccHMUoj6I+2Jl3ZQTcpJbJ64=
X-Google-Smtp-Source: ABdhPJzh+TVXmuuzS3NtsEBffy+fs+WG0MkNeEtOcIPs0CYZ7GH4C5EnNQvnxoQq5REGayJDT/pLvQ==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr7526084wro.307.1597509588769;
        Sat, 15 Aug 2020 09:39:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm22702664wrv.4.2020.08.15.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:48 -0700 (PDT)
Message-Id: <6a0cde983d9ed20f043a4977313d714154602012.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:36 +0000
Subject: [PATCH v3 04/11] commit-graph: consolidate compare_commits_by_gen
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

Comparing commits by generation has been independently defined twice, in
commit-reach and commit. Let's simplify the implementation by moving
compare_commits_by_gen() to commit-graph.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 15 +++++++++++++++
 commit-graph.h |  2 ++
 commit-reach.c | 15 ---------------
 commit.c       |  9 +++------
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index af8d9cc45e..fb6e2bf18f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -112,6 +112,21 @@ uint32_t commit_graph_generation(const struct commit *c)
 	return data->generation;
 }
 
+int compare_commits_by_gen(const void *_a, const void *_b)
+{
+	const struct commit *a = _a, *b = _b;
+	const uint32_t generation_a = commit_graph_generation(a);
+	const uint32_t generation_b = commit_graph_generation(b);
+
+	/* older commits first */
+	if (generation_a < generation_b)
+		return -1;
+	else if (generation_a > generation_b)
+		return 1;
+
+	return 0;
+}
+
 static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 {
 	unsigned int i, nth_slab;
diff --git a/commit-graph.h b/commit-graph.h
index 09a97030dc..701e3d41aa 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -146,4 +146,6 @@ struct commit_graph_data {
  */
 uint32_t commit_graph_generation(const struct commit *);
 uint32_t commit_graph_position(const struct commit *);
+
+int compare_commits_by_gen(const void *_a, const void *_b);
 #endif
diff --git a/commit-reach.c b/commit-reach.c
index efd5925cbb..c83cc291e7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -561,21 +561,6 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return repo_is_descendant_of(the_repository, commit, list);
 }
 
-static int compare_commits_by_gen(const void *_a, const void *_b)
-{
-	const struct commit *a = *(const struct commit * const *)_a;
-	const struct commit *b = *(const struct commit * const *)_b;
-
-	uint32_t generation_a = commit_graph_generation(a);
-	uint32_t generation_b = commit_graph_generation(b);
-
-	if (generation_a < generation_b)
-		return -1;
-	if (generation_a > generation_b)
-		return 1;
-	return 0;
-}
-
 int can_all_from_reach_with_flag(struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
diff --git a/commit.c b/commit.c
index 4ce8cb38d5..bd6d5e587f 100644
--- a/commit.c
+++ b/commit.c
@@ -731,14 +731,11 @@ int compare_commits_by_author_date(const void *a_, const void *b_,
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused)
 {
 	const struct commit *a = a_, *b = b_;
-	const uint32_t generation_a = commit_graph_generation(a),
-		       generation_b = commit_graph_generation(b);
+	int ret_val = compare_commits_by_gen(a_, b_);
 
 	/* newer commits first */
-	if (generation_a < generation_b)
-		return 1;
-	else if (generation_a > generation_b)
-		return -1;
+	if (ret_val)
+		return -ret_val;
 
 	/* use date as a heuristic when generations are equal */
 	if (a->date < b->date)
-- 
gitgitgadget

