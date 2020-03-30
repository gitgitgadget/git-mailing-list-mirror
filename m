Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F4C2D0E7
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A8820786
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHa/tFDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgC3AcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:32:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54736 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgC3Abv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so18033554wmd.4
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lKRmXl/SCDI8E+Ga3COYKCQR4IKS00g3pKKk/jGMaB4=;
        b=SHa/tFDv6w+2qiIx/sQ9f1dIIWiQhyohZF9s+Sdsun1q+jQ1/j0HwL5r5BdGt7Lffx
         caYPlD70tAvSR0WXkuCCFDbKZoZCyjtaeibYtWqU+j7ui7H98pZnsUSTyBKyGWrnK7k2
         VVMP6b8qleiQmoKq4bGC22KeALGK2f5BYEUpfe8NMyACJSexBqAbPZ8v945a2PlJao+I
         XKaRsfXA8UT/H+2h+wl7PhHwLK9VDSTaFuNVLBQK8VGL/7aebzHtuzPoV1sEBVh8/q5c
         ggN4OskdSDc5WwT7ONtFgQK1vZ3DU4/BqZgyWuBKFKOR1hMm0kx3q4wbWMDhzVjzH9QF
         +P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lKRmXl/SCDI8E+Ga3COYKCQR4IKS00g3pKKk/jGMaB4=;
        b=fH3jmtnd7Go4N94jUtVB5s5IdknoWX+Pi4QAZON7yH+K23Nc/3Uin82kKg2xVxeuqO
         pHVzJyYvTUhdt9iCpsTivK+sUk6NxO/B2RaS23OCpfMzgkonecfKIghjdxtiAFkzuKN+
         OFem6/S7/hffqwmOcftjbSEtYyT9Kp1RfmbX8GlYHHmOg7GwouY4C0H4IZRwTZdVf/X4
         txVofAPBbLWwbNDFTtWrxK2QMZ8NdpWgAwok1ceGUCLtkObiMJalAwy8BQhPpbqPx4dF
         8/DqmUjR84107oYNHpxaZ7xNUO2McQtUNXoVf+PQHxMQbDGvcyIo9YncpIxiwx3DIltj
         6BXg==
X-Gm-Message-State: ANhLgQ1a14NfX8yp3zubNlkVFv8qTeLMAnwfz6dg9MUn+YQAqFQmrEfy
        EdQNydR4QkeP8TNpq+Ww8edtdIek
X-Google-Smtp-Source: ADFU+vt1hFXGGcXOw5P4ICvrDXujOR5YSvWhmUcSAzWQeqFEpiT0dxrvryEblgBHeYL3eGiWMUal9A==
X-Received: by 2002:a1c:56d5:: with SMTP id k204mr11089925wmb.13.1585528307561;
        Sun, 29 Mar 2020 17:31:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm20012996wrq.33.2020.03.29.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:47 -0700 (PDT)
Message-Id: <5ed16f35fed43018ce441adfff55b85967d3918c.1585528298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:30 +0000
Subject: [PATCH v3 08/16] commit-graph: examine commits by generation number
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

When running 'git commit-graph write --changed-paths', we sort the
commits by pack-order to save time when computing the changed-paths
bloom filters. This does not help when finding the commits via the
'--reachable' flag.

If not using pack-order, then sort by generation number before
examining the diff. Commits with similar generation are more likely
to have many trees in common, making the diff faster.

On the Linux kernel repository, this change reduced the computation
time for 'git commit-graph write --reachable --changed-paths' from
3m00s to 1m37s.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 31b06f878ce..732c81fa1b2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -70,6 +70,25 @@ static int commit_pos_cmp(const void *va, const void *vb)
 	       commit_pos_at(&commit_pos, b);
 }
 
+static int commit_gen_cmp(const void *va, const void *vb)
+{
+	const struct commit *a = *(const struct commit **)va;
+	const struct commit *b = *(const struct commit **)vb;
+
+	/* lower generation commits first */
+	if (a->generation < b->generation)
+		return -1;
+	else if (a->generation > b->generation)
+		return 1;
+
+	/* use date as a heuristic when generations are equal */
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
 char *get_commit_graph_filename(struct object_directory *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir->path);
@@ -815,7 +834,8 @@ struct write_commit_graph_context {
 		 report_progress:1,
 		 split:1,
 		 check_oids:1,
-		 changed_paths:1;
+		 changed_paths:1,
+		 order_by_pack:1;
 
 	const struct split_commit_graph_opts *split_opts;
 	size_t total_bloom_filter_data_size;
@@ -1178,7 +1198,11 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 
 	ALLOC_ARRAY(sorted_commits, ctx->commits.nr);
 	COPY_ARRAY(sorted_commits, ctx->commits.list, ctx->commits.nr);
-	QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
+
+	if (ctx->order_by_pack)
+		QSORT(sorted_commits, ctx->commits.nr, commit_pos_cmp);
+	else
+		QSORT(sorted_commits, ctx->commits.nr, commit_gen_cmp);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = sorted_commits[i];
@@ -1884,6 +1908,7 @@ int write_commit_graph(struct object_directory *odb,
 	}
 
 	if (pack_indexes) {
+		ctx->order_by_pack = 1;
 		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
 			goto cleanup;
 	}
@@ -1893,8 +1918,10 @@ int write_commit_graph(struct object_directory *odb,
 			goto cleanup;
 	}
 
-	if (!pack_indexes && !commit_hex)
+	if (!pack_indexes && !commit_hex) {
+		ctx->order_by_pack = 1;
 		fill_oids_from_all_packs(ctx);
+	}
 
 	close_reachable(ctx);
 
-- 
gitgitgadget

