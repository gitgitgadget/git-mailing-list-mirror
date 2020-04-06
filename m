Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21170C2BB1D
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7120780
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjK1yEAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgDFRAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38507 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbgDFRAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id e5so378889edq.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b09N7vSxma0z7ZkQvyBSUo7VU222X1/gp1zj6yECZGU=;
        b=VjK1yEAvX+oClxI3FeCtGk6J8/gC1yLS88hqGMnUi+bWCn6p1hmbXfUwi4cqveTLz8
         kKJGQ2d6dmcr4WHIyIGs/cAE8BGCqI3O20x7gpIpJr8sxjhSWKJ2wPBnfDbQx2BRrJQk
         V7a+cF9sHJ8zsQQcEgLRjhXUBi4yE+nuTl7GanMERa+Je0seu4AaQ81M05eFNzdMXxG2
         rhh9UV3hRlWPB9BHg8Xpiupny0yN0vqRIygDNuPRZvjzmdCENgFkbNzW72SM3Osrqfen
         fpd/F8HZ4KrHQwiYLsC7I3hMAkoI3p+Lwy4MuAF3uscwBM5QV8tSBCFXaxgGhlzX0lnD
         sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b09N7vSxma0z7ZkQvyBSUo7VU222X1/gp1zj6yECZGU=;
        b=ZxJj1xV47Pq1v2YWM/3w7nAjnxKSajfTg5nUKPEQIZQO2BaALzWmtDt57Gz/FfWvjn
         OMXXQng2y1XMMpo7zttNdmuG7XgKXgvG5cez0FMcuMtFxaMH5FrMVE63Y6CazsbELhhY
         eRdxB6xvK8Z6B2CjykTCEFC2g0r/zMgs3IySU03td+2HcwYNTnv6a+TjLFO7Lawx9uXM
         EPOexgb1iqNXRg/AjBbb0e7IredlBcFPgrM4EDVvwDVlI9BAWUuGbxPjAvr7VNATFhrJ
         AGBkqWLPtDDZwqUTlgpxqPv9MdfS3FEWYFS9i+wwBpy1eRbskrdXiP/4DS632e4uIbrr
         tKpg==
X-Gm-Message-State: AGi0PubmEdkgiyiEtSy2DiuQK/phd8xe7i1+b3gMbeCz+jTOoBpiaaVO
        Gc523GbKvLEtGkP8L3sy+DCI0iai
X-Google-Smtp-Source: APiQypIgNP8ARY7uKc8gs+zM9v9PNBUrckFKvSpm4UjFsyoesEflBloZNANxY0x5P3fBJp4XM8u5ug==
X-Received: by 2002:a50:ab1e:: with SMTP id s30mr20816734edc.336.1586192400378;
        Mon, 06 Apr 2020 10:00:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p20sm2602862edw.31.2020.04.06.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:59:59 -0700 (PDT)
Message-Id: <2d4c0b2da38632424c8bd31ccb2037e0676c3c74.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:45 +0000
Subject: [PATCH v4 05/15] diff: halt tree-diff early after max_changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When computing the changed-paths bloom filters for the commit-graph,
we limit the size of the filter by restricting the number of paths
in the diff. Instead of computing a large diff and then ignoring the
result, it is better to halt the diff computation early.

Create a new "max_changes" option in struct diff_options. If non-zero,
then halt the diff computation after discovering strictly more changed
paths. This includes paths corresponding to trees that change.

Use this max_changes option in the bloom filter calculations. This
reduces the time taken to compute the filters for the Linux kernel
repo from 2m50s to 2m35s. On a large internal repository with ~500
commits that perform tree-wide changes, the time reduced from
6m15s to 3m48s.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 bloom.c     | 4 +++-
 diff.h      | 5 +++++
 tree-diff.c | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index 881a9841ede..a16eee92331 100644
--- a/bloom.c
+++ b/bloom.c
@@ -133,6 +133,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
 	struct diff_options diffopt;
+	int max_changes = 512;
 
 	if (bloom_filters.slab_size == 0)
 		return NULL;
@@ -141,6 +142,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
+	diffopt.max_changes = max_changes;
 	diff_setup_done(&diffopt);
 
 	if (c->parents)
@@ -149,7 +151,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
 	diffcore_std(&diffopt);
 
-	if (diff_queued_diff.nr <= 512) {
+	if (diff_queued_diff.nr <= max_changes) {
 		struct hashmap pathmap;
 		struct pathmap_hash_entry *e;
 		struct hashmap_iter iter;
diff --git a/diff.h b/diff.h
index 6febe7e3656..9443dc1b003 100644
--- a/diff.h
+++ b/diff.h
@@ -285,6 +285,11 @@ struct diff_options {
 	/* Number of hexdigits to abbreviate raw format output to. */
 	int abbrev;
 
+	/* If non-zero, then stop computing after this many changes. */
+	int max_changes;
+	/* For internal use only. */
+	int num_changes;
+
 	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW (1<<12)
diff --git a/tree-diff.c b/tree-diff.c
index 33ded7f8b3e..f3d303c6e54 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -434,6 +434,9 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		if (diff_can_quit_early(opt))
 			break;
 
+		if (opt->max_changes && opt->num_changes > opt->max_changes)
+			break;
+
 		if (opt->pathspec.nr) {
 			skip_uninteresting(&t, base, opt);
 			for (i = 0; i < nparent; i++)
@@ -518,6 +521,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 
 			/* t↓ */
 			update_tree_entry(&t);
+			opt->num_changes++;
 		}
 
 		/* t > p[imin] */
@@ -535,6 +539,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		skip_emit_tp:
 			/* ∀ pi=p[imin]  pi↓ */
 			update_tp_entries(tp, nparent);
+			opt->num_changes++;
 		}
 	}
 
@@ -552,6 +557,7 @@ struct combine_diff_path *diff_tree_paths(
 	const struct object_id **parents_oid, int nparent,
 	struct strbuf *base, struct diff_options *opt)
 {
+	opt->num_changes = 0;
 	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt);
 
 	/*
-- 
gitgitgadget

