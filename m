Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04882C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2E7207F7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTRvqWb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgFLSmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFLSmH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:42:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6992C08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:42:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so4709426pfd.6
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9ipF4JCL50KRBsG7AlUwCno9TVG6XLBA+mAXJma6RI=;
        b=vTRvqWb03yq3qbiJA81qxKyJf/rPDpYQ4GdqHik9mNlMHfwCa9yJ3a6icd9R9KWigb
         7iCfrl1k/y2jU1qSNwNTnOd+i9m3XV3kGbKWkeTTdLYDjTfMpelVXn2kKhNflnELp3Fu
         ErAUkEl121rmGVbOWxvujplzDNTyRLO84gxNv5Cj7Q0fHiunsizuopFmo5uZtEhuhwDo
         4oEFnh9/OeJw953t9Dgba6M+KGrTvVZ7JdWuiE5S/bzj6ttOtYXmh2Ile+EaE3wwPOwx
         dtrbMEDstOe4xu50Yc+uzx6e1NORPKA7Gm8XdEzPORB1dKfatPQdB4i20jerSNK1Czbj
         IkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9ipF4JCL50KRBsG7AlUwCno9TVG6XLBA+mAXJma6RI=;
        b=X281PJTH0bjbbyWhgC1DMe9CVRcAeUrNGH1hKsbdQIKv0depj76J1ZH/5mXpvGi90z
         v38BGQCBIcBnn8+TnX9t06Ryt62724o96KK8Z/odDNXp/qtvdvh26uWW+dS7hDItV46d
         4Jm+DbdfKAYrPt3ZlDdUeuMx3cickfQGzzBCpqejrDVtjRm3pwhCRhOPMMWvd08jNjHX
         rk81BtwnrLgsV7m9/vPNb7zbs7QvW8ty/nX5J6SFbP4SKVGHL1KVQgpKhjFukKyVaTI+
         C8/yVKIcoYcZuVr6xsSElZATcnsC1YRMdTKD9/i/6Wmgne7SU786QFu6jfVAbMOYKYhb
         OzEg==
X-Gm-Message-State: AOAM5329A/SlDrh7ce3gvdcMhUw2rEYxMk2ytV392V0v0ct38CTIsMp7
        tGB4nDLxjdXxSR7/dCwlEvIeWtLI
X-Google-Smtp-Source: ABdhPJyjBA4kE43PvnAXmNVjsk7K1Ziok+hYPzXAd8GQMJwUuOxq7UqLZNOeoMadPZRp54NkdyB4Qw==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr11567107pgq.265.1591987325632;
        Fri, 12 Jun 2020 11:42:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:307:970b:360c:5006:374c:b8c0])
        by smtp.gmail.com with ESMTPSA id k12sm5985535pgm.11.2020.06.12.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:42:04 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [PATCH v3 2/4] commit-graph: introduce commit_graph_data_slab
Date:   Sat, 13 Jun 2020 00:10:12 +0530
Message-Id: <20200612184014.1226972-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members
`generation` and `graph_pos` are only used for commit-graph related
operations and otherwise waste memory.

This wastage would have been more pronounced as we transition to
generation number v2, which uses 64-bit generation number instead of
current 32-bits.

As they are often accessed together, let's introduce struct
commit_graph_data and move them to a commit_graph_data slab.

While the overall test suite runs just as fast as master,
(series: 27m10s, master: 27m34s), certain commands like
`git merge-base --is-ancestor` are slowed by nearly 40% as
discovered by SDEZER Gabor [1].

Derrick Stolee believes the slow down is attributable to the
underlying algorithm rather slowness of commit-slab access [2] and we will
follow-up on that in a later series.

[1]: https://lore.kernel.org/git/20200607195347.GA8232@szeder.dev/
[2]: https://lore.kernel.org/git/13db757a-9412-7f1e-805c-8a028c4ab2b1@gmail.com/

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h | 10 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 2ff042fbf4..91120ba3d3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -87,6 +87,55 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
+static struct commit_graph_data_slab commit_graph_data_slab =
+	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
+
+uint32_t commit_graph_position(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
+}
+
+uint32_t commit_graph_generation(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	if (!data)
+		return GENERATION_NUMBER_INFINITY;
+	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return GENERATION_NUMBER_INFINITY;
+
+	return data->generation;
+}
+
+static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
+{
+	uint32_t i = commit_graph_data_slab.slab_count, j;
+	uint32_t slab_size = commit_graph_data_slab.slab_size;
+	struct commit_graph_data *data =
+		commit_graph_data_slab_at(&commit_graph_data_slab, c);
+
+	/*
+	 * commit-slab initializes elements with zero, overwrite this with
+	 * COMMIT_NOT_FROM_GRAPH for graph_pos.
+	 *
+	 * We avoid initializing generation with checking if graph position
+	 * is not COMMIT_NOT_FROM_GRAPH.
+	 */
+	for (; i < commit_graph_data_slab.slab_count; i++) {
+		for (j = 0; j < slab_size; j++) {
+			commit_graph_data_slab[i][j].graph_pos =
+				COMMIT_NOT_FROM_GRAPH;
+		}
+	}
+
+	return data;
+}
+
 static int commit_gen_cmp(const void *va, const void *vb)
 {
 	const struct commit *a = *(const struct commit **)va;
diff --git a/commit-graph.h b/commit-graph.h
index 3ba0da1e5f..cc76757007 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -135,4 +135,14 @@ void free_commit_graph(struct commit_graph *);
  */
 void disable_commit_graph(struct repository *r);
 
+struct commit_graph_data {
+	uint32_t graph_pos;
+	uint32_t generation;
+};
+
+/* 
+ * Commits should be parsed before accessing generation, graph positions.
+ */
+uint32_t commit_graph_generation(const struct commit *);
+uint32_t commit_graph_position(const struct commit *);
 #endif
-- 
2.27.0

