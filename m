Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF35C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC35206F6
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="on3c7JGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgFGTeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTef (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:34:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF32C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:34:36 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t7so7767829pgt.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLZ3DUMILfriWfuGR3/PMfKCuVXypczWP5abF3vYtCY=;
        b=on3c7JGEyxgvt38j2d75xyVbI7IFE2119gEGGGWZjRdYPcrXBUz25j06QYlHq0sFjJ
         jpkN6oOPH26jtHnGEBL1nwx5V/HZyFg8/AyjQi/DO3vtwV/txxBfxLfHRpj5GFGUN0Ax
         tIR84lub82kKFYHnYkbNN7SRNEJmJbVW/yScBmdDet4W+kfnkGNw+PPIMJYgNZ+Eoqwm
         SxeT7BY+/8YwHMwRQIri20ExR5r/oub0lPXtz2sOjY+h3a3IU9dfTEFo1hedQvA7dFdw
         4TjPXemM+wHHlkInPM/tYwHLfebodLkrcOlfkwK2c8Y6wLmTWwxFIDAeT17FkM2WYxw1
         hFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLZ3DUMILfriWfuGR3/PMfKCuVXypczWP5abF3vYtCY=;
        b=Z5iQiE+pNsH3n7l0bdHeQg5hJERbXhlLoB/Xjo+aJCT0D0TzKTiZruZdgdNWAdOGAw
         pYtbZU5HvSd8F6H7H412rcY28c3WzKM0/7kpk8OTf8olWlKQITTJptFnhZXkqD4Cpwd8
         z8JLc0Tc4E42kY4TZC/BHDry4pdsNtXlWRHVAULckMOlgUuX8dZOktA+oVGVsxu00FnD
         DNOo7h+4MGDkocHh7voa0mdmBM+t0PkhRvLHRJxHsieRIY0NwD1fcNu8Rtvr88BIhHoK
         P401WIyZk87J9whAvoBHkrAIlHyLrMZSTL1XvZwJ8cnkZhTN0nmttWgLM+0hiUpzXBPY
         2HPw==
X-Gm-Message-State: AOAM530jy/IWUZv+xNW0EqAGQMPRG0oPWGoO3lXMTJc4wEwJNxl+Vw1O
        L6/Q0ZV6TPt9urw3OEOuOe9YCJCs
X-Google-Smtp-Source: ABdhPJwIQ/FPgtunGou7/wlRWnlr4LzK/iB+NrXARzkMXMy47xu/kfGAvanLyrE+trWy3k5w619AmA==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr15353161pgk.237.1591558475117;
        Sun, 07 Jun 2020 12:34:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id n69sm158595pfd.171.2020.06.07.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:34:34 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v2 1/4] commit-graph: introduce commit_graph_data_slab
Date:   Mon,  8 Jun 2020 01:02:34 +0530
Message-Id: <20200607193237.699335-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200607193237.699335-1-abhishekkumar8222@gmail.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members
`generation` and `graph_pos` are only used for commit-graph related
operations and otherwise waste memory.

As they are often accessed together, let's introduce struct
commit_graph_data and move them to a commit_graph_data slab.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-graph.h | 10 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index e3420ddcbf..7d887a6a2c 100644
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
+	if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
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
+	 * We avoid the cost of initializing `generation` as generation
+	 * number would be GENERATION_NUMBER_INFINITY if graph position
+	 * is COMMIT_NOT_FROM_GRAPH.
+	 */
+	for (; i < commit_graph_data_slab.slab_count; i++) {
+		for (j = 0; j < slab_size; j++) {
+			commit_graph_data_slab.slab[i][j].graph_pos = COMMIT_NOT_FROM_GRAPH;
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
index 4212766a4f..9d22f98f44 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -137,4 +137,14 @@ void free_commit_graph(struct commit_graph *);
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

