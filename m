Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40743C433E5
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E320786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0OZMON5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG1JOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgG1JN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22749C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g7so11622623ejw.12
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hocohXiKSKJ8SJvTHe8NNCewPtWLSpIgIep9ENjbdEU=;
        b=S0OZMON5rW+ikoJHfHVE/M2KUnBNllrAY/fc4NAAPMJjp2b9YohLIP/rgHHi1EzWY/
         ARefRAqh7BpGvBwRlj5hjh0L4xe2PwEUsC0Aff5hz4AIhCjJnTOynkWzr/ZHz8kuGoaB
         WhIm3Eno8J+9xYLx/gsJ9eeQ6pVph99FNg9crl7NpfEojHVwot55wRTB5ibK8OKjgeH/
         sUUj7hRtWrF9i+ePoeL7VevrFVYdsid7dVxzRRAK137CX4n//xPA4FPG5wY+OUFJIpSZ
         deszNMcAY7sYaAN3zmRDpA+vho38yYdYn3rPFKtf9F7YOSsoUVI4NkUG2dvYSmt2Ji3I
         NA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hocohXiKSKJ8SJvTHe8NNCewPtWLSpIgIep9ENjbdEU=;
        b=CbH5DYdPGf+FJw2NaHyp4gW+xO7iOIZeoMTH5GglkRac7YD1KoacrCf+y4PBwM8hFj
         U+ZOedsXoh2n2ER4TKHJR0y4RKiDKi82b49iKfdOpkYaNb/xcGZs5J99hMtF/wVWgaY6
         zxuFJlFWhr69q0BSlUZtqQ2qGlWEERs7nKTA8jzxEQWVr2GZGIl1qr9ngII4HVCA9yCL
         FTDkT4RxijRLvfjXcRdAi5Ih4EiSfC5J5G8FWBF5JzPTI+Otk0KyBRvKRVtsKwm9wMHY
         HYtGt+8EzVVqWrEfBB1dPoVfDBsMI00ADO30w5uLRf7epsgHFI8fZh1gwTlwZS1dHBSq
         /CaQ==
X-Gm-Message-State: AOAM532EZZLbXfrg4uHefBmZSWbFALzlPoxgUBY36WCB1SBqiKRG7hNr
        uEtPHqaUgIWXYB0qtx5AfQcjwuQe
X-Google-Smtp-Source: ABdhPJwXuvLEvLvgvpe+1suJ2GAWHjfF3aDeBQuCDZodynfs13m7GFoV2laDsiYPy+fHDXObDZB2tA==
X-Received: by 2002:a17:906:a88b:: with SMTP id ha11mr8913620ejb.545.1595927637730;
        Tue, 28 Jul 2020 02:13:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm8606401ejc.72.2020.07.28.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:57 -0700 (PDT)
Message-Id: <812fe75fc7252db0b7b6604f84b17dcf7324b922.1595927632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:49 +0000
Subject: [PATCH 4/6] commit-graph: consolidate compare_commits_by_gen
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
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
---
 commit-graph.c | 15 +++++++++++++++
 commit-graph.h |  2 ++
 commit-reach.c | 15 ---------------
 commit.c       |  9 +++------
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 204eb454b2..1c98f38d69 100644
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
index 28f89cdf3e..98cc5a3b9d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -145,4 +145,6 @@ struct commit_graph_data {
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
index 7128895c3a..bed63b41fb 100644
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

