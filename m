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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8DBC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17353206F6
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwkRxKqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgFGTeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGTeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 15:34:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A349C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 12:34:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so5075687pjv.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmjkxN8Ang7C2pefcs0jG85HuCQfghiOZif30tPuXX4=;
        b=NwkRxKqnc05oMiUWLEEGgbkqO3Z4+ozchNkQgWVZIexOu93fjDgbkpoaUejutLUu0e
         dKJlovAlHd883r9YkYvn2KjWU7N2F42hcSfI+otdIlPcpibTj3X5y/4jaXxnwmcXxPbB
         3obAal1FSy+lrssFbLwizMnoCvggXiMfcn4+kOluuBhhBHeKtJJvS3oCKFVtQRvcDsU1
         v7q/Do1CZaUKQm50UoPBBnRJ78AUSlzVmRSnk/1WTddQ7KAIWdA0cvykzbLbXI/yH3RH
         bTR26LjI8NsHd3J8zLGaZus9hD9P3WG03MX0WkO2/37VWHqst92fMdo2wzFXvckENy5y
         yywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmjkxN8Ang7C2pefcs0jG85HuCQfghiOZif30tPuXX4=;
        b=OXNSFfaYaHFlbY19b7HL6rQzHN9yrIBLhMWA+jSpgPqF8UMfbYiIewzn/AoNYJCQV7
         z7priLgUHSq28wrXdA2aeGRQz+m06xbzORe9JTnjAjT9DPP/+M/eEhfSFtBGDmWrSltn
         QEXS32wvCIRVOgo/W+ZEmQLt3oE5Nz/jAFLra+/Dc9wqOh7NagB1Azqz2nuIgZbBcO42
         de/beHUCRZCSGXX6Jm1C/z/d0UYtf/ONmwMixI7NWKxr/6GZp98+EXP8BDGxxpotjlfy
         VXYCq6q7iweUaGkvhNtp9rGgdaYH3K5VICgL93NnQg3ai3MXg8C5b6FcgM7gP9TEyQdI
         zc8g==
X-Gm-Message-State: AOAM531RfjhcdpaVehV+XjvEez1xx9IsEyO3Cf4sRM0OU4nwRegU5frN
        3DweEhJeMZRjfsRoCkG4gUHC00jh
X-Google-Smtp-Source: ABdhPJzoC5jG8Tx/urunla+CuPn5XoNISqRLwD7nRlxG2IITotw7QG/QHsITD3ojc+GyKDovZ/B5fQ==
X-Received: by 2002:a17:90b:3690:: with SMTP id mj16mr13778540pjb.104.1591558485693;
        Sun, 07 Jun 2020 12:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:58e:925f:60d1:f386:43d2:4abb])
        by smtp.gmail.com with ESMTPSA id n69sm158595pfd.171.2020.06.07.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:34:45 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, stolee@gmail.com
Subject: [GSOC Patch v2 3/4] commit-graph: use generation directly when writing commit-graph
Date:   Mon,  8 Jun 2020 01:02:36 +0530
Message-Id: <20200607193237.699335-4-abhishekkumar8222@gmail.com>
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

commit_graph_generation() returns GENERATION_NUMBER_INFINITY if the
graph position for commit is COMMIT_NOT_FROM_GRAPH.

While this is true when reading from a commit graph, no graph positions
are associated with a commit when writing a commit graph. Therefore, the
helper incorrectly returns GENERATION_NUMBER_INFINITY despite having a
finite generation number.

Let's fix this by using generation number directly when writing a commit
graph.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7cca4def4..0dc79e7c90 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1070,7 +1070,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		else
 			packedDate[0] = 0;
 
-		packedDate[0] |= htonl(commit_graph_generation((*list)) << 2);
+		packedDate[0] |= htonl(commit_graph_data_at(*list)->generation << 2);
 
 		packedDate[1] = htonl((*list)->date);
 		hashwrite(f, packedDate, 8);
@@ -1301,9 +1301,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
+		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
+
 		display_progress(ctx->progress, i + 1);
-		if (commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
-		    commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
+		if (generation != GENERATION_NUMBER_INFINITY &&
+		    generation != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1314,8 +1316,9 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			uint32_t max_generation = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
-				if (commit_graph_generation(parent->item) == GENERATION_NUMBER_INFINITY ||
-				    commit_graph_generation(parent->item) == GENERATION_NUMBER_ZERO) {
+
+				if (generation == GENERATION_NUMBER_INFINITY ||
+				    generation == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-- 
2.27.0

