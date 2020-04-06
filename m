Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC5C2BABC
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8599B21841
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOmHIflD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgDFRAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40504 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgDFRAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so360261edu.7
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KAmO1RySrgApRaoIdXSMKQzey0ygDFzHa23GpHnOhvk=;
        b=gOmHIflDLr3c58VBq0RTQet6FCkRX1aO6cf76WJkf/jF4nrPQ5X+EoYAwmMCfoXRSX
         oFxt1ZTtwm731hjU8rQio5vkjj3t6Kl53ZjWO6u+AiteZOFxuMsCjCrViBPsjthDHUKr
         LVKEBRZiEzXRNnxtIc6ZOue8lpfB/Z+3I3A5/wizL40Scrh0ywA79DK2+th37dB/BicO
         5jPkbDEn8a0GRG/NGirfdWRECs6cV508Ng2au3l1RdGcZQgqpVcGfvLQAbiYcgIxWimB
         /kfSJwS3NazMrAjlwK6fftlzcSDqRF7pAaGSsZ+zRmfg4koWXQRI076LAChaJZz7uuzf
         e6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KAmO1RySrgApRaoIdXSMKQzey0ygDFzHa23GpHnOhvk=;
        b=Q5AdVsOWUxtmHeeRCp9ooab8avGn9BLiMDFBYY4F/niILacTermLjDECXb4tSlIG5x
         6mEDqA1hwnC4SwBE8+DhJM+PBno/vbszs/O4g162Yx62sj80ivneR6jJIn+ezpN9H5dY
         Szub181WYeB+P+voTGGPR879H0Xg1jqAv0i74TqVApFRZ8Ohe+nCdX+jw7kRStrh6/U5
         5159vML1/VcMhCLNaDP3/fDNATNZlMdozQC5cQKsAG6fJSq6e2L7APcCHku3qXdTGXPY
         q4/cASyl5bsx8BxWAh/rrEkvVrGvnnlTSNzsmCkXgWmLtcLVvwd92rk8k4ITa5N3WTWF
         YkJA==
X-Gm-Message-State: AGi0PuZufd2/KbJYQFUPijpBBapEDpqp+n/vvCeXL3t9Qaw9UZXlauod
        tTocW07UJQWdiqOOvJioWv9xuvJW
X-Google-Smtp-Source: APiQypLzJwpNktdudPIunErpwM+DLDcY3IVRxQVkj5D/3F4F7XBzeL9GdXOcvA6YY11vLWf+zXPgPQ==
X-Received: by 2002:a17:906:3502:: with SMTP id r2mr416807eja.67.1586192401265;
        Mon, 06 Apr 2020 10:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26sm1283701edx.9.2020.04.06.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:00 -0700 (PDT)
Message-Id: <c38b9b386ef246cd3144ec5ede991c3cad32f3d9.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:46 +0000
Subject: [PATCH v4 06/15] commit-graph: compute Bloom filters for changed
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add new COMMIT_GRAPH_WRITE_CHANGED_PATHS flag that makes Git compute
Bloom filters for the paths that changed between a commit and it's
first parent, for each commit in the commit-graph.  This computation
is done on a commit-by-commit basis.

We will write these Bloom filters to the commit-graph file, to store
this data on disk, in the next change in this series.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 32 +++++++++++++++++++++++++++++++-
 commit-graph.h |  3 ++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e4f1a5b2f1a..862a00d67ed 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -16,6 +16,7 @@
 #include "hashmap.h"
 #include "replace-object.h"
 #include "progress.h"
+#include "bloom.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -789,9 +790,11 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1,
-		 check_oids:1;
+		 check_oids:1,
+		 changed_paths:1;
 
 	const struct split_commit_graph_opts *split_opts;
+	size_t total_bloom_filter_data_size;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1134,6 +1137,28 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static void compute_bloom_filters(struct write_commit_graph_context *ctx)
+{
+	int i;
+	struct progress *progress = NULL;
+
+	init_bloom_filters();
+
+	if (ctx->report_progress)
+		progress = start_delayed_progress(
+			_("Computing commit changed paths Bloom filters"),
+			ctx->commits.nr);
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *c = ctx->commits.list[i];
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
+		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
+		display_progress(progress, i + 1);
+	}
+
+	stop_progress(&progress);
+}
+
 static int add_ref_to_list(const char *refname,
 			   const struct object_id *oid,
 			   int flags, void *cb_data)
@@ -1776,6 +1801,8 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
 	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
 	ctx->split_opts = split_opts;
+	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
+	ctx->total_bloom_filter_data_size = 0;
 
 	if (ctx->split) {
 		struct commit_graph *g;
@@ -1870,6 +1897,9 @@ int write_commit_graph(struct object_directory *odb,
 
 	compute_generation_numbers(ctx);
 
+	if (ctx->changed_paths)
+		compute_bloom_filters(ctx);
+
 	res = write_commit_graph_file(ctx);
 
 	if (ctx->split)
diff --git a/commit-graph.h b/commit-graph.h
index e87a6f63600..86be81219da 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -79,7 +79,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4),
 };
 
 struct split_commit_graph_opts {
-- 
gitgitgadget

