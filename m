Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F63C2D0E7
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B4D20780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKzFjR4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgC3Aby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42996 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgC3Abt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so19273252wrx.9
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UFasefMTFJlBZT0H7l3YT+5vQ3mTXZeAfKd7dCO5Krw=;
        b=EKzFjR4bdBp1fI4DnnTeJc4NNGsBf822vG0cLPRuDgfuagmD3aPO1CimgUYS+SftDh
         P+n2eq84mIv3zNJy+muSMLqBHSn2zEbRdTZjjkOD8tyFcesuCDmdLOqhHiUxiNQ1URj6
         wlT5z5C0a+uhrZIgRf0pzM1X/7JtCY5Cq8AlZMIlpOEqCQ8+gjle5CxyzIFHcpQMfF8U
         esZ5yukMBzr7JXierqCVrA1seua9jfuEw36XMHzl5dUtCtjEFjRdBpP6VoXEMMJUd2Hr
         gu16x6I1sKvjEn52uFfpRrEBygAlc3qV1M9d8ijvhRefl4uqOpJJI2XIU/O2dThqJu8h
         Td1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UFasefMTFJlBZT0H7l3YT+5vQ3mTXZeAfKd7dCO5Krw=;
        b=cTcqwxC1sPZKQw38gd58MVOPSrp+0kduLzKNlGFbgFdkelVftFzT0wdjGvVEJCMa/l
         PbFKDgmDDdDlPoK/S1vQ4kOg25TIj/LIx+k9Sp+PlxVh3cCDW6jwHVoxQBMCyamFHQrA
         4wCAT6gFuzyNBOBnkTyvCRV+sGr0kfnzH6YVG0dili9bkRbt4cttfbSK+h9X1tocho6j
         r/Uynr1K0h1WZ0e2fKVXyNa2X0K6BhcmFmUmPD3jlIgBwGWg3kfKJkeDZspNM24ENLPS
         paiKv5ncShAmVFbYVqsa8QA66S3hTXVHNPqMcn6fctyDclwK51fD/NC/LBZHTMZtAkCt
         gUfQ==
X-Gm-Message-State: ANhLgQ0FEafWM4qGIaT3jmxDDrq+hNkXNc7qbsfkMQcT/1wO4G704/Da
        tZibYn2LkS4lqpCr1AVrXW9h2m5m
X-Google-Smtp-Source: ADFU+vutmmSUtJyn+Gpf71lOQoWX6nDOl6jKltFvCcsPHDO/TwUYVoMMi2jXUaBrsXlpuATaYEU7VQ==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr12688749wru.390.1585528306747;
        Sun, 29 Mar 2020 17:31:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm18359569wmh.22.2020.03.29.17.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:46 -0700 (PDT)
Message-Id: <d24c85c54ef841eb2a62d95937c1bf9884ba690a.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:29 +0000
Subject: [PATCH v3 07/16] commit-graph: examine changed-path objects in pack
 order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Looking at the diff of commit objects in pack order is much faster than
in sha1 order, as it gives locality to the access of tree deltas
(whereas sha1 order is effectively random). Unfortunately the
commit-graph code sorts the commits (several times, sometimes as an oid
and sometimes a pointer-to-commit), and we ultimately traverse in sha1
order.

Instead, let's remember the position at which we see each commit, and
traverse in that order when looking at bloom filters. This drops my time
for "git commit-graph write --changed-paths" in linux.git from ~4
minutes to ~1.5 minutes.

Probably the "--reachable" code path would want something similar.

Or alternatively, we could use a different data structure (either a
hash, or maybe even just a bit in "struct commit") to keep track of
which oids we've seen, etc instead of sorting. And then we could keep
the original order.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 862a00d67ed..31b06f878ce 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -17,6 +17,7 @@
 #include "replace-object.h"
 #include "progress.h"
 #include "bloom.h"
+#include "commit-slab.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -46,9 +47,32 @@
 /* Remember to update object flag allocation in object.h */
 #define REACHABLE       (1u<<15)
 
-char *get_commit_graph_filename(struct object_directory *odb)
+/* Keep track of the order in which commits are added to our list. */
+define_commit_slab(commit_pos, int);
+static struct commit_pos commit_pos = COMMIT_SLAB_INIT(1, commit_pos);
+
+static void set_commit_pos(struct repository *r, const struct object_id *oid)
+{
+	static int32_t max_pos;
+	struct commit *commit = lookup_commit(r, oid);
+
+	if (!commit)
+		return; /* should never happen, but be lenient */
+
+	*commit_pos_at(&commit_pos, commit) = max_pos++;
+}
+
+static int commit_pos_cmp(const void *va, const void *vb)
 {
-	return xstrfmt("%s/info/commit-graph", odb->path);
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+	return commit_pos_at(&commit_pos, a) -
+	       commit_pos_at(&commit_pos, b);
+}
+
+char *get_commit_graph_filename(struct object_directory *obj_dir)
+{
+	return xstrfmt("%s/info/commit-graph", obj_dir->path);
 }
 
 static char *get_split_graph_filename(struct object_directory *odb,
@@ -1021,6 +1045,8 @@ static int add_packed_commits(const struct object_id *oid,
 	oidcpy(&(ctx->oids.list[ctx->oids.nr]), oid);
 	ctx->oids.nr++;
 
+	set_commit_pos(ctx->r, oid);
+
 	return 0;
 }
 
@@ -1141,6 +1167,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct progress *progress = NULL;
+	struct commit **sorted_commits;
 
 	init_bloom_filters();
 
@@ -1149,13 +1176,18 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 			_("Computing commit changed paths Bloom filters"),
 			ctx->commits.nr);
 
+	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
+	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
+	QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
+
 	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *c = ctx->commits.list[i];
+		struct commit *c = sorted_commits[i];
 		struct bloom_filter *filter = get_bloom_filter(ctx->r, c);
 		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
+	free(sorted_commits);
 	stop_progress(&progress);
 }
 
-- 
gitgitgadget

