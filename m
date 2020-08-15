Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C7C433E4
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DC923384
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCm3TVYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgHOVwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgHOVvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48547C0A3BF6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so10921545wrm.12
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IcWebLKiGfBEwgtIAv7pSrcEhe1QF9/VXMB8mF2w3zg=;
        b=mCm3TVYJ/ExcJbRcQ9bmIdXtD+nrkMumnBDHWuk8kZ6MWIzFYRsdy7q0yYK/CKAF3I
         +xdY0UH4+wLV+wXZqgkhPFWBskOw0oi7SIK3oNTcWnMgWJCx4kLGFhXbilGTd6+kpPRn
         WCtO8iMB4m08Mg75DqCgWmri4T6B9H/zEi9JzQEiOtEtw4/hnuSx9LczwgE4blYRwHOe
         y7bKA3ysd3ZM3wdOXqnmry8XZ276YfhxSNSAr1c3w/KnWSTAc6B6eTirAGQ3QOrM/pQI
         xXOkUQn6xbdeW63UNw4Nelf8REmGLPBw7b0vSWHvG3bLpuSEq5zNE2n1T4G0+AgkcCB2
         YTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IcWebLKiGfBEwgtIAv7pSrcEhe1QF9/VXMB8mF2w3zg=;
        b=GtTuI3di/zxHgw5HJI5WP8BLMHhoOmpmhSsPSsT88JuKIQ+cWkoUaxmOymLezSg/fl
         gZs8KAa2wfoyIydhLrXKKdxFlep2K7aDqUfUQJdzKOph952IIwWNxaWzDY/s6AS5XKjD
         glxiW7Ek/ojDtaTzLvx2gbCqGftL7NJzCMbIykpYOi+vbPTqnNa3hglna7rDlmmoSygg
         Uxmek1H7ea+4Oxo5H73BVGjQEHdHV0qbjj7PngsVRv32P7tfAfgJnlfxy8Cobybpyexu
         F3SP97FRUl6hcOaAD94tKpLAuLDP00S3rOJ5IHrVImd+FemF/DfaDmxZBsmxH5Q4msSh
         cOyw==
X-Gm-Message-State: AOAM532N+6G/AFMK+TJAG8wIE9w7bihUtQmUiww/cMQlupSHZI3uM4N2
        e2m2P999XObw4aVbrU80taRaLPQMFt8=
X-Google-Smtp-Source: ABdhPJw/CPopLF0O+/uxjwHrejxthN12rVJ78Qnbo33fqX9DNYDlxL6pjSKK0S9Ip2EXIOXJnn7c4w==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr7392943wrv.127.1597509593839;
        Sat, 15 Aug 2020 09:39:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm24162660wrc.37.2020.08.15.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:53 -0700 (PDT)
Message-Id: <439adc1718d6cc37f18c1eaeafd605f5c2961733.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:42 +0000
Subject: [PATCH v3 10/11] commit-reach: use corrected commit dates in
 paint_down_to_common()
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

With corrected commit dates implemented, we no longer have to rely on
commit date as a heuristic in paint_down_to_common().

t6024-recursive-merge setups a unique repository where all commits have
the same committer date without well-defined merge-base. As this has
already caused problems (as noted in 859fdc0 (commit-graph: define
GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph within the
test script.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c             | 14 ++++++++++++++
 commit-graph.h             |  6 ++++++
 commit-reach.c             |  2 +-
 t/t6024-recursive-merge.sh |  4 +++-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c1292f8e08..6411068411 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -703,6 +703,20 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+int corrected_commit_dates_enabled(struct repository *r)
+{
+	struct commit_graph *g;
+	if (!prepare_commit_graph(r))
+		return 0;
+
+	g = r->objects->commit_graph;
+
+	if (!g->num_commits)
+		return 0;
+
+	return !!g->chunk_generation_data;
+}
+
 static void close_commit_graph_one(struct commit_graph *g)
 {
 	if (!g)
diff --git a/commit-graph.h b/commit-graph.h
index 3cf89d895d..e22ec1e626 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -91,6 +91,12 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
  */
 int generation_numbers_enabled(struct repository *r);
 
+/*
+ * Return 1 if and only if the repository has a commit-graph
+ * file and generation data chunk has been written for the file.
+ */
+int corrected_commit_dates_enabled(struct repository *r);
+
 enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
diff --git a/commit-reach.c b/commit-reach.c
index 470bc80139..3a1b925274 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
-	if (!min_generation)
+	if (!min_generation && !corrected_commit_dates_enabled(r))
 		queue.compare = compare_commits_by_commit_date;
 
 	one->object.flags |= PARENT1;
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 332cfc53fd..d3def66e7d 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -15,6 +15,8 @@ GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
 export GIT_COMMITTER_DATE
 
 test_expect_success 'setup tests' '
+	GIT_TEST_COMMIT_GRAPH=0 &&
+	export GIT_TEST_COMMIT_GRAPH &&
 	echo 1 >a1 &&
 	git add a1 &&
 	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
@@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
 '
 
 test_expect_success 'combined merge conflicts' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
+	test_must_fail git merge -m final G
 '
 
 test_expect_success 'result contains a conflict' '
-- 
gitgitgadget

