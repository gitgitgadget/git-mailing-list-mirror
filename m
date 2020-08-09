Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F077EC433E3
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5465206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuLrMSwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHICyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgHICx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03FC061A29
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a5so5056136wrm.6
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0oCQKiZpvmFFQwrKwuo8n2v4wexVlGSS2JtelNy+Og8=;
        b=PuLrMSwqP0PbEeWDglQj61rOeYq4KMCQS0nFl5lu+HZ9qXuDsipyBnlIuMzHYA0/oS
         naddTT3+NT/riymBJeh2y9L1OUlSWbsJyXAp4Dy5YWBXgOIWJRIJdfSvQbKc6pmCMYtp
         831ll76O3/r/UTKdfMELdPiX2LiZiZca5NrGvgku7HYQ8Ke7lr6iLcXHDQoF3jp1saen
         JEvJpGP9FtfAnbylrD3XQt5q7Vzx5kCFEfiGTRk0WzeB2gK1eYtokvoI4b8hfIRxK0Og
         1eSKeFg0KS4p53spamBy4ZNW0pF+7nY5Z4J6PsfSgAMJyQUFQvivtpcI6ge3SxwvDMt7
         x+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0oCQKiZpvmFFQwrKwuo8n2v4wexVlGSS2JtelNy+Og8=;
        b=aI6qefvSMe9Eq/fsZmlTTEH5NAxoLbTozyI2hfhawcediSQ7NZMDc/+YPKggp3Q2LR
         fd9K24yhUi/cRmHVim8yPuyjVCdAhS7nZxbFVuuolp/4bI6ZTWP6t+1lPk4OAb3mMwW+
         yQSk9lBa/5hzBHHkTo/OMwfR2MgGi2mVjxvYWoLGIqPLAyAsx+6kPnXoOcT3sIJonFz3
         PYpmCjmnP9/vxl/t2h1EvA/Yo4+aflsUTtBoN2QjIm+XakVeMpzaRymnXwTnleWB0Kd+
         7RO92chv7Mt8FmTJ+hZjTtx7kR9cztUEBwXVRVe4T8iXufWdhql11ExT87/je/WgOlaz
         SVFw==
X-Gm-Message-State: AOAM533RWCwHELCZy6UZo+leHyFBKO/jBmxPlAAAutGYqY4UIdZ7tXke
        MjR3BrxQVB8u7a5B2uoos7A1DDMO
X-Google-Smtp-Source: ABdhPJwjG/iLFX5ujBERR8Z4exuX/xEi3LT2XduZiXIKCztMakFuL63Hzr+Hla5yZyPmiviByj1mcA==
X-Received: by 2002:adf:fb01:: with SMTP id c1mr17805498wrr.119.1596941634099;
        Sat, 08 Aug 2020 19:53:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm15967850wmu.37.2020.08.08.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:53 -0700 (PDT)
Message-Id: <b2547828585be24f779b7b0672a2984e6b883f3c.1596941624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:38 +0000
Subject: [PATCH v2 04/10] commit-graph: consolidate compare_commits_by_gen
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

