Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F021C0007A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81CB207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501892AbgLCQSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501888AbgLCQSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:20 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4AC061A52
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:12 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so2476810wrt.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x8Lbb1KbdEQ46sFMnLOoqdM26A56F4xaMLIe5N9T+7c=;
        b=c0VMC+QYyU9oBTzF1arD4FnyN9SqsSZ/7up6h7DYJoBNE2Km69eCLjTqNAryMHWOEA
         IvDXJoSFpoNZXeBphI3hc7F+nZFq71PNDHspbrbVTUGD1qrb9OpEiWBbw3OYE4R0rhUa
         +2ua7OnypJ6grS4m8ZHxrIv0j22m8r4Oig6gEYAGsXhxI63K7SI7cBbu0IqddyxNPxng
         OkgmEvqcBjONDFj3I3QhFuFdtnrpNRHAzaDdUkNOA9VEZx1rn77uN67cYsALXj+PknqH
         9qoMMRen2jrII3ZeVt+gqbJ4uh68d82vHmYwyQVwxaqsbyKmQD1OxFHJ5VBSQ/BZIw1M
         hdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x8Lbb1KbdEQ46sFMnLOoqdM26A56F4xaMLIe5N9T+7c=;
        b=VT9DBhXHi2f8+nltbTYarXSkil+HJutH9a6L2JKNuUz35BVLkbcp38GnqS4YjKoxiX
         X27MTczUw8Tmu2DwWWNdylj3Fel+2PWx3fq4RWeftB/cgtGc1IAR53yrHM3trFfOvd65
         hihdVu5DKRICDhWZaLDCfQK8rgkIpw5H/S+UHX3CvOws8FNN3ONKxEXu2V9pLMGfFmBV
         G2ljAbHfmo0ieU7fA5rlFKg9ZZpmxpDoOk/8E2d+0LfwVAXR9hDJ4bStShJEJMcXMWwZ
         dYJqBtczVKvvWxETnBjNtP2YdG87LaEft/3a/rYGAEfVB5CZFNrYcFyy38MnaitKeGwz
         l+2w==
X-Gm-Message-State: AOAM531k27ItlcMkOHA5cN4gMAYMB/RxBWhUzsKw5i/iATkhvIOU9mYo
        YcBtLxOiqcIKJ+VP0U+jp0DS8uTvK9k=
X-Google-Smtp-Source: ABdhPJzFUxzULx9mrAFJh4PqxbmVxYZc85VGb4lWlXdS+T+lvczoul4DINiKqhyfNZsRhgN29JNrTw==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr4593168wrw.238.1607012230737;
        Thu, 03 Dec 2020 08:17:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 90sm2331033wra.95.2020.12.03.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:10 -0800 (PST)
Message-Id: <106dd51f75699fbf4fc1e46687124995f5ef0278.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:53 +0000
Subject: [PATCH 14/15] commit-graph: restore duplicate chunk checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change introduced read_table_of_contents() in the
chunk-format API, but dropped the duplicate chunk check from the
commit-graph parsing logic. This was done to keep flexibility in the
chunk-format API.

One way to restore this check is to have each chunk_read_fn method check
if it has run before. This is somewhat repetitive. If we determine that
the chunk-format API would be better off with a hard requirement that
chunks are never repeated, then this could be replaced with a check in
chunk-format.c.

For now, only restore the duplicate checks that previously existed in
the commit-graph parsing logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 0a3ba147df..c0102fceba 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -289,10 +289,20 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
+static int report_duplicate(void)
+{
+	warning(_("duplicate chunk detected"));
+	return 1;
+}
+
 static int graph_read_oid_fanout(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_oid_fanout)
+		return report_duplicate();
+
 	g->chunk_oid_fanout = (uint32_t*)chunk_start;
 	return 0;
 }
@@ -301,6 +311,10 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_oid_lookup)
+		return report_duplicate();
+
 	g->chunk_oid_lookup = chunk_start;
 	g->num_commits = chunk_size / g->hash_len;
 	return 0;
@@ -310,6 +324,10 @@ static int graph_read_data(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_commit_data)
+		return report_duplicate();
+
 	g->chunk_commit_data = chunk_start;
 	return 0;
 }
@@ -318,6 +336,10 @@ static int graph_read_extra_edges(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_extra_edges)
+		return report_duplicate();
+
 	g->chunk_extra_edges = chunk_start;
 	return 0;
 }
@@ -326,6 +348,10 @@ static int graph_read_base_graphs(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_base_graphs)
+		return report_duplicate();
+
 	g->chunk_base_graphs = chunk_start;
 	return 0;
 }
@@ -334,6 +360,10 @@ static int graph_read_bloom_indices(const unsigned char *chunk_start,
 				    size_t chunk_size, void *data)
 {
 	struct commit_graph *g = (struct commit_graph *)data;
+
+	if (g->chunk_bloom_indexes)
+		return report_duplicate();
+
 	g->chunk_bloom_indexes = chunk_start;
 	return 0;
 }
@@ -343,6 +373,10 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = (struct commit_graph *)data;
 	uint32_t hash_version;
+
+	if (g->chunk_bloom_data)
+		return report_duplicate();
+
 	g->chunk_bloom_data = chunk_start;
 	hash_version = get_be32(chunk_start);
 
-- 
gitgitgadget

