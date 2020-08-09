Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF7C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FD0206DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agQQ9fnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHICyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICyA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:54:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A556BC061A27
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so5059196wrf.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7h7jK5uvxqsvZDY4WJcTkp4cmOBz3r+zPD48AjNXcAE=;
        b=agQQ9fnIOBMd9zNK5SNqE32LV7XZ4wHeg59JVD/Pai74XM2wubx77tjXh1/QPlnqoq
         nC7T0vz9GYpDmaNNmSH4cWT0YUg+cJvMDPZu10Dm+HKDo709o6+BDoYHAwm5Ez8AMy5r
         majZRW5YMpVlIiSul4DkLBOBoC1WdQKgBiQFX8+buD6RY7HJ7bA6ZViHmTBTM7RzNMLM
         79puf5ndhdQJEuGtzRFMzsfyM3h5LSzcD0SAUhBX6kUOdXQ5p9y1zYr/vlzaJaNCbtKr
         Wla+dLCZ9sXvV4ycINjmfjLreizTyAZSOfvZyVvCxIxFzsfJe0ql41iNuaITbxMx36uu
         iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7h7jK5uvxqsvZDY4WJcTkp4cmOBz3r+zPD48AjNXcAE=;
        b=uZXPdnepusbbazNIFqHpVP2FnXONAu4Px71dHqsvYX6v+R1d1USz/MBmH+6EFQPget
         83+B8CS4/gcNPWVG9Hr8kFkYspPITJ6z9hTL4uLvjdPKcPQbS/ECHOcOIqnz6vBTkEvL
         s/6bdpjNpPttLMUB22yJH+E5YR1SylnF8zoOSOuFk2U7PF7IGz64pjSCAp3aP0oVBTgL
         PBED6I9Gky/PW1iVLn2y6JpviBAaJ5qkkXlDwOl0dpx2uu8ZjWtUfuKYDUhEvl4DOUu1
         AJpNH3JbbEQN2M5CzMNshcgwwcnc1nY7ffB6retUFGMpUgY6RtFDf/3HAztjvHev6oXA
         0GhQ==
X-Gm-Message-State: AOAM532gBwSo5+DPBOQWzqw3X0HyEyUGK9C5nq6NLLTAYaYFRvWNrc55
        4BtQQ1S88QfXjwFMC5w1j56qWExJ
X-Google-Smtp-Source: ABdhPJxVroM9LpJmBaUPB8QvkZkRscXkXMc/T8TDCYACHrQ93iEjPi1FoogBHX/MXzVUT9gGPN4ymg==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr17445120wrf.190.1596941638312;
        Sat, 08 Aug 2020 19:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm15278284wml.30.2020.08.08.19.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:57 -0700 (PDT)
Message-Id: <58a2d5da0105e6572305b07d4e39ef6be9ee0044.1596941625.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:43 +0000
Subject: [PATCH v2 09/10] commit-reach: use corrected commit dates in
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
index c6b6111adf..eb78af3dad 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -688,6 +688,20 @@ int generation_numbers_enabled(struct repository *r)
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
index f89614ecd5..d3a485faa6 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -89,6 +89,12 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
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

