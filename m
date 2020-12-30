Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B427BC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1AE207B3
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL3Ech (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 23:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgL3Ech (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 23:32:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0157C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 20:31:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w5so16415456wrm.11
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 20:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FvStqSLXMQan7VAbKtquJ9eNl/R55JVgu986+ebNbBY=;
        b=iBiTtXbGxh5Q+lLfnEHeOXvkmLphlTJ0ciz6QfGaBGBZ4slS/2Lh7xM8oZKdHZXOUs
         6AKexh5gkg2yoDFDzWDvRnBhjLCFxZlZj+AVNIIFuHEbafp+xAGfWOVqJZLMfLAnQjm8
         FomdzWi5fM0EE3YTgsFszP6MjpY4k5o2J+yk8aSzR7xTg4iLmGv86PJOC3C0cqRg57RH
         g3nPSbF4DBA7Xv7Evz+YeR3tYRvAVFy5MNoEGPITNvx5Svb/vXQnN1FIlC1WNFjixSvJ
         jYLqkYLtiwQUq8X7CXAXYIY3Xyt5nr81PNekJCxLR5/KcIr5Hr0SvDJpfuML8GqsiiSP
         3VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FvStqSLXMQan7VAbKtquJ9eNl/R55JVgu986+ebNbBY=;
        b=B/lPdOaYrO9315CNb2tw3O1vPyW6xtXwrumDYsFrrIbkiueVAPnjXVmOmjn+IPQB7k
         ZpdTPzoRi2YnWBjkbErRXtRpdaaZzcOciLqRV9MjuojDT4VJSWKA6q5xUh4ly1oj1PBt
         lFQQoby4le+Ub3hoO4lKvK3tlulGq077+WcjsM7Ih+KcYeuPJuQ9ym7offzEwrQF1DYc
         zFb5FqfKee23ZeDUbC9Md8Dv33NBFd1FOjTS9gvc+M+XcjkrvnSqH6TxyI0l+jF196Pb
         N6bEgAQb7P1k5GLmIWz5/iLfZllXk2EIzMK4x3chL6eGrCd72XMiwzNO9BDXKoGfG/5v
         ePtQ==
X-Gm-Message-State: AOAM532NnzisaFtMvyc8gfSHErs8ca3ndQhgS/H+/abdiybBVFvQdoO/
        B84d8i866jAbDRKgCYMF5Rtlu+7SOp4=
X-Google-Smtp-Source: ABdhPJz+yRLciZQkUaTOJWhbpuXys+blAGMs0ZMBf3u6a12PoJ6rQgO+Izc5xRSsRTZHIu5NH1PSKw==
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr58755494wrw.42.1609302715255;
        Tue, 29 Dec 2020 20:31:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm5177395wmc.44.2020.12.29.20.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 20:31:54 -0800 (PST)
Message-Id: <pull.828.git.1609302714183.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 04:31:53 +0000
Subject: [PATCH] revision: trace topo-walk statistics
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We trace statistics about the effectiveness of changed-path Bloom
filters since 42e50e78 (revision.c: add trace2 stats around Bloom
filter usage, 2020-04-06). Add similar tracing for the topo-walk
algorithm that uses generation numbers to limit the walk size.

This information can help investigate and describe benefits to
heuristics and other changes.

The information that is printed is in JSON format and can be formatted
nicely to present as follows:

    {
	"count_explort_walked":2603,
	"count_indegree_walked":2603,
	"count_topo_walked":473
    }

Each of these values count the number of commits are visited by each of
the three "stages" of the topo-walk as detailed in b4542418 (revision.c:
generation-based topo-order algorithm, 2018-11-01).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    revision: trace topo-walk statistics
    
    Here is a patch I thought useful when investigating the performance
    implications of Abhishek's series [1]
    
    [1]
    https://lore.kernel.org/git/pull.676.v5.git.1609154168.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-828%2Fderrickstolee%2Ftrace2-topo-walk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-828/derrickstolee/trace2-topo-walk-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/828

 revision.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/revision.c b/revision.c
index 9dff845bed6..1bb590ece78 100644
--- a/revision.c
+++ b/revision.c
@@ -3308,6 +3308,26 @@ struct topo_walk_info {
 	struct author_date_slab author_date;
 };
 
+static int topo_walk_atexit_registered;
+static unsigned int count_explore_walked;
+static unsigned int count_indegree_walked;
+static unsigned int count_topo_walked;
+
+static void trace2_topo_walk_statistics_atexit(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "count_explore_walked", count_explore_walked);
+	jw_object_intmax(&jw, "count_indegree_walked", count_indegree_walked);
+	jw_object_intmax(&jw, "count_topo_walked", count_topo_walked);
+	jw_end(&jw);
+
+	trace2_data_json("topo_walk", the_repository, "statistics", &jw);
+
+	jw_release(&jw);
+}
+
 static inline void test_flag_and_insert(struct prio_queue *q, struct commit *c, int flag)
 {
 	if (c->object.flags & flag)
@@ -3329,6 +3349,8 @@ static void explore_walk_step(struct rev_info *revs)
 	if (repo_parse_commit_gently(revs->repo, c, 1) < 0)
 		return;
 
+	count_explore_walked++;
+
 	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
 		record_author_date(&info->author_date, c);
 
@@ -3367,6 +3389,8 @@ static void indegree_walk_step(struct rev_info *revs)
 	if (repo_parse_commit_gently(revs->repo, c, 1) < 0)
 		return;
 
+	count_indegree_walked++;
+
 	explore_to_depth(revs, commit_graph_generation(c));
 
 	for (p = c->parents; p; p = p->next) {
@@ -3476,6 +3500,11 @@ static void init_topo_walk(struct rev_info *revs)
 	 */
 	if (revs->sort_order == REV_SORT_IN_GRAPH_ORDER)
 		prio_queue_reverse(&info->topo_queue);
+
+	if (trace2_is_enabled() && !topo_walk_atexit_registered) {
+		atexit(trace2_topo_walk_statistics_atexit);
+		topo_walk_atexit_registered = 1;
+	}
 }
 
 static struct commit *next_topo_commit(struct rev_info *revs)
@@ -3502,6 +3531,8 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 			    oid_to_hex(&commit->object.oid));
 	}
 
+	count_topo_walked++;
+
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
 		int *pi;

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
