Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D0C001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbjHKRFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbjHKRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1BE54
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:44 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579de633419so23835557b3.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773544; x=1692378344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKiZfuEq6Bg+OUJWwBvKqqN1lGYUPMbbEcRiff0dsN4=;
        b=h+Qqg7AyYTXRsXuzWBcUpSxLAw/5OCekgN0GMxskY6cNYoVFSXzITwDLQg2e+s9Eal
         yHI4XGEuXIdsYaooT5H5YxZdME4DQOXmt/D2n2eTM7NnJduTK8mZ+EWKRcq1MHEZlMzF
         HUnWMhpaExkKM5RidTcin47mXsVPhIXWl0ENK0E4jjPFJPd6AWEbbhb3bY2uAZVWLDCs
         DW1HYnXQHfnHuDuV8XlFBl9NfVO10WDdTPOe4yRR6mvjg3JI4rSq/PjBzPO/hL6uZ4f/
         BE9d3u12ie6UbSlq7QbkLweWKcI2r1ECcf4V3LYgv+8uklM3qXeIXeUwhby0i8LSOZj8
         tvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773544; x=1692378344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKiZfuEq6Bg+OUJWwBvKqqN1lGYUPMbbEcRiff0dsN4=;
        b=M5V6fFSLvDRT8LzRRC/vsM2pQ09P0vEmvut33QYhDBswtDX8AF00mO2aW5RF44W1T2
         2XJVckpCm5BfFpazmA9zyphJMmmJhbD2DUk1O+QN8zLz4pZPRjS+2CNRE0b+1ViW2lwi
         FPx8bvWk1vZ+2XLAhJSeaEyYX3Iipzf79nneQZWiChDswYu4sMmRit6lKL+SpLVcJqFd
         Pf6WQq2fbnVnipPfDsMqIQE9X9ggMZoEm6wxnkAkI0F+cI9Adaq10QRyrbg4B3TTvK5z
         a1F77v9lr6WOovovhTb9/QKYO1tBFUnd23ahoIOI7tcWN0H7Smx0M7d9uGgVykaAwAI/
         EHcQ==
X-Gm-Message-State: AOJu0YwjD0M+JBcUzxPkpGgEynIUt0BF5/4sg8dNHxYQ+r2JSAeYTyf5
        sMTSJRICTc6SiYXjSdWZ4vizA235XvYmDVS49PpsyA==
X-Google-Smtp-Source: AGHT+IGR87IQc6gvugRDNjCD0ygYdMXr6g7h5xiKyUMqdiHrozy6tb5SQE6kHDFqfboj+9I70Q/sDQ==
X-Received: by 2002:a0d:ea42:0:b0:583:e958:39c6 with SMTP id t63-20020a0dea42000000b00583e95839c6mr2812871ywe.34.1691773543856;
        Fri, 11 Aug 2023 10:05:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6-20020a815e06000000b00559f1cb8444sm1103456ywb.70.2023.08.11.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:43 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 1/5] commit-graph: introduce
 `commit_graph_generation_from_graph()`
Message-ID: <701c198e197a8e6008672b7be7e11e02007f808a.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2ee11f7261 (commit-graph: return generation from memory, 2023-03-20),
the `commit_graph_generation()` function stopped returning zeros when
asked to locate the generation number of a given commit.

This was done at the time to prepare for a later change which set
generation values in memory, meaning that we could no longer rely on
`graph_pos` alone to tell us whether or not to trust the generation
number returned by this function.

In 2ee11f7261, it was noted that this change only impacted very old
commit-graphs, which were written with all commits having generation
number 0. Indeed, zero is not a valid generation number, so we should
never expect to see that value outside of the aforementioned case.

The test fallout in 2ee11f7261 indicated that we were no longer able to
fsck a specific old case of commit-graph corruption, where we see a
non-zero generation number after having seen a generation number of 0
earlier.

Introduce a variant of `commit_graph_generation()` which behaves like
that function did prior to 2ee11f7261, known as
`commit_graph_generation_from_graph()`. Then use this function in the
context of `verify_one_commit_graph()`, where we only want to trust the
values from the graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 14 ++++++++++++--
 t/t5318-commit-graph.sh |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..c68f5c6b3a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -128,6 +128,16 @@ timestamp_t commit_graph_generation(const struct commit *c)
 	return GENERATION_NUMBER_INFINITY;
 }
 
+static timestamp_t commit_graph_generation_from_graph(const struct commit *c)
+{
+	struct commit_graph_data *data =
+		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
+
+	if (!data || data->graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return GENERATION_NUMBER_INFINITY;
+	return data->generation;
+}
+
 static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
 {
 	unsigned int i, nth_slab;
@@ -2659,7 +2669,7 @@ static int verify_one_commit_graph(struct repository *r,
 					     oid_to_hex(&graph_parents->item->object.oid),
 					     oid_to_hex(&odb_parents->item->object.oid));
 
-			generation = commit_graph_generation(graph_parents->item);
+			generation = commit_graph_generation_from_graph(graph_parents->item);
 			if (generation > max_generation)
 				max_generation = generation;
 
@@ -2671,7 +2681,7 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		if (!commit_graph_generation(graph_commit)) {
+		if (!commit_graph_generation_from_graph(graph_commit)) {
 			if (generation_zero == GENERATION_NUMBER_EXISTS)
 				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
 					     oid_to_hex(&cur_oid));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4df76173a8..4e70820c74 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -598,7 +598,7 @@ test_expect_success 'detect incorrect generation number' '
 
 test_expect_success 'detect incorrect generation number' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"commit-graph generation for commit"
+		"but zero elsewhere"
 '
 
 test_expect_success 'detect incorrect commit date' '
-- 
2.42.0.rc0.30.gb82b15ebc8

