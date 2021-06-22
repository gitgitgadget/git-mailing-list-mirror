Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE365C48BDF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C639461351
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhFVIHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFVIHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65BEC0617A6
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so11950232wrs.12
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XINKupP9EZI+poFCqnlKAsUbuPBBJzJF9ke1oIyiHBk=;
        b=DUpYHHMWy4Nwzic71EXxxCkdOcvJflgpeNfqLRkvDkH4JJcw6ITFApyok3lflATXPe
         4kA+yd9mNGUXsUKHS+GpgXt+7pY2ViYDLSpay/62PlNSwHvTrbCsXpGJjLpaA2l//xuu
         iHb4xaY97AdFOgpUnJA85V9LI1Mx4UdDR6ppBQF18Dt4bQiu7rR0cjW2zR2NgKOWlmpq
         +knJtrBALaYmv/9tnWr9T4qU1KZyY8Ps9ZMGqMyyQYZJU0kSHDmDGdzBaz0Hqiyxscj6
         uvhFj0mjYfrQdgnwfMXMgJrFB1JboqRgkR0kVwtYR0VPiSfpH+wAijIOCeyDu2eA/FCE
         4L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XINKupP9EZI+poFCqnlKAsUbuPBBJzJF9ke1oIyiHBk=;
        b=o7b9dZ+CzvT03bXwpRZ6hHJ2p9akW8lvmEsbgTduyJDHJ7LXT5ClzycD3tjCqKfjSV
         pH2gy8ZzzgzaGWb7UMuJVDX4lArdCCyRU5RMZO2GHGuU+WGMIHA+h/wCHbJaZuUCH5MG
         pdb8oyxjTR23GmYj7MlkNmflaa5zWCvADgo6e9hhnADZQMWbHjq3ldWWvB7p5PNSlZg1
         ZfdsrDmVfTY9ty4qDev6NDKsSW8mRw3edAybwqu5L9+lYPryU4zUvHYOISlghg32ynsU
         0lg2tEpGoX2jNfly+6Ywbu9UG+YYFz2h7H+rZW0IrXLwblZ+/gEgjzT6RkifHd/KJb4x
         LUsA==
X-Gm-Message-State: AOAM533WkCKVmYTwX72+nDTXqhqRlq+O7Bg2OwvD3YVyI51ysUZQVx0z
        TfowcElPExB1VItOIH+aRwo0vr5mm/s=
X-Google-Smtp-Source: ABdhPJxsXPaSXMaRHI46izaVMQfBM4QVkhV1gSEgz4Z1YdyUi0xMNV5XfI0Tdi9WpBcnFHscFUWLQQ==
X-Received: by 2002:a05:6000:1207:: with SMTP id e7mr3158601wrx.77.1624349085524;
        Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm14632303wru.3.2021.06.22.01.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
Message-Id: <c9b55241d83144df0ddc479f67fbf3aabca43bd8.1624349082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 08:04:40 +0000
Subject: [PATCH v3 4/5] diffcore-rename: use a different prefetch for basename
 comparisons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-ort was designed to minimize the amount of data needed and used,
and several changes were made to diffcore-rename to take advantage of
extra metadata to enable this data minimization (particularly the
relevant_sources variable for skipping "irrelevant" renames).  This
effort obviously succeeded in drastically reducing computation times,
but should also theoretically allow partial clones to download much less
information.  Previously, though, the "prefetch" command used in
diffcore-rename had never been modified and downloaded many blobs that
were unnecessary for merge-ort.  This commit corrects that.

When doing basename comparisons, we want to fetch only the objects that
will be used for basename comparisons.  If after basename fetching this
leaves us with no more relevant sources (or no more destinations), then
we won't need to do the full inexact rename detection and can skip
downloading additional source and destination files.  Even if we have to
do that later full inexact rename detection, irrelevant sources are
culled after basename matching and before the full inexact rename
detection, so we can still avoid downloading the blobs for irrelevant
sources.  Rename prefetch() to inexact_prefetch(), and introduce a
new basename_prefetch() to take advantage of this.

If we modify the testcase from commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2021-01-23)
to pass
    --sparse --filter=blob:none
to the clone command, and use the new trace2 "fetch_count" output from
a few commits ago to track both the number of fetch subcommands invoked
and the number of objects fetched across all those fetches, then for
the mega-renames testcase we observe the following:

BEFORE this commit, rebasing 35 patches:
    strategy     # of fetches    total # of objects fetched
    ---------    ------------    --------------------------
    recursive    62              11423
    ort          30              11391

AFTER this commit, rebasing the same 35 patches:
    ort          32                 63

This means that the new code only needs to download less than 2 blobs
per patch being rebased.  That is especially interesting given that the
repository at the start only had approximately half a dozen TOTAL blobs
downloaded to start with (because the default sparse-checkout of just
the toplevel directory was in use).

So, for this particular linux kernel testcase that involved ~26,000
renames on the upstream side (drivers/ -> pilots/) across which 35
patches were being rebased, this change reduces the number of blobs that
need to be downloaded by a factor of ~180.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c              | 101 +++++++++++++++++++++++++++------
 t/t6421-merge-partial-clone.sh |   4 +-
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index e13e52046026..4ef0459cfb50 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -87,13 +87,13 @@ struct diff_score {
 	short name_score;
 };
 
-struct prefetch_options {
+struct inexact_prefetch_options {
 	struct repository *repo;
 	int skip_unmodified;
 };
-static void prefetch(void *prefetch_options)
+static void inexact_prefetch(void *prefetch_options)
 {
-	struct prefetch_options *options = prefetch_options;
+	struct inexact_prefetch_options *options = prefetch_options;
 	int i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
@@ -816,6 +816,78 @@ static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 	return idx;
 }
 
+struct basename_prefetch_options {
+	struct repository *repo;
+	struct strintmap *relevant_sources;
+	struct strintmap *sources;
+	struct strintmap *dests;
+	struct dir_rename_info *info;
+};
+static void basename_prefetch(void *prefetch_options)
+{
+	struct basename_prefetch_options *options = prefetch_options;
+	struct strintmap *relevant_sources = options->relevant_sources;
+	struct strintmap *sources = options->sources;
+	struct strintmap *dests = options->dests;
+	struct dir_rename_info *info = options->info;
+	int i;
+	struct oid_array to_fetch = OID_ARRAY_INIT;
+
+	/*
+	 * TODO: The following loops mirror the code/logic from
+	 * find_basename_matches(), though not quite exactly.  Maybe
+	 * abstract the iteration logic out somehow?
+	 */
+	for (i = 0; i < rename_src_nr; ++i) {
+		char *filename = rename_src[i].p->one->path;
+		const char *base = NULL;
+		intptr_t src_index;
+		intptr_t dst_index;
+
+		/* Skip irrelevant sources */
+		if (relevant_sources &&
+		    !strintmap_contains(relevant_sources, filename))
+			continue;
+
+		/*
+		 * If the basename is unique among remaining sources, then
+		 * src_index will equal 'i' and we can attempt to match it
+		 * to a unique basename in the destinations.  Otherwise,
+		 * use directory rename heuristics, if possible.
+		 */
+		base = get_basename(filename);
+		src_index = strintmap_get(sources, base);
+		assert(src_index == -1 || src_index == i);
+
+		if (strintmap_contains(dests, base)) {
+			struct diff_filespec *one, *two;
+
+			/* Find a matching destination, if possible */
+			dst_index = strintmap_get(dests, base);
+			if (src_index == -1 || dst_index == -1) {
+				src_index = i;
+				dst_index = idx_possible_rename(filename, info);
+			}
+			if (dst_index == -1)
+				continue;
+
+			/* Ignore this dest if already used in a rename */
+			if (rename_dst[dst_index].is_rename)
+				continue; /* already used previously */
+
+			one = rename_src[src_index].p->one;
+			two = rename_dst[dst_index].p->two;
+
+			/* Add the pairs */
+			diff_add_if_missing(options->repo, &to_fetch, two);
+			diff_add_if_missing(options->repo, &to_fetch, one);
+		}
+	}
+
+	promisor_remote_get_direct(options->repo, to_fetch.oid, to_fetch.nr);
+	oid_array_clear(&to_fetch);
+}
+
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
@@ -860,19 +932,12 @@ static int find_basename_matches(struct diff_options *options,
 		.missing_object_cb = NULL,
 		.missing_object_data = NULL
 	};
-	/*
-	 * The prefeteching stuff wants to know if it can skip prefetching
-	 * blobs that are unmodified...and will then do a little extra work
-	 * to verify that the oids are indeed different before prefetching.
-	 * Unmodified blobs are only relevant when doing copy detection;
-	 * when limiting to rename detection, diffcore_rename[_extended]()
-	 * will never be called with unmodified source paths fed to us, so
-	 * the extra work necessary to check if rename_src entries are
-	 * unmodified would be a small waste.
-	 */
-	struct prefetch_options prefetch_options = {
+	struct basename_prefetch_options prefetch_options = {
 		.repo = options->repo,
-		.skip_unmodified = 0
+		.relevant_sources = relevant_sources,
+		.sources = &sources,
+		.dests = &dests,
+		.info = info
 	};
 
 	/*
@@ -911,7 +976,7 @@ static int find_basename_matches(struct diff_options *options,
 	}
 
 	if (options->repo == the_repository && has_promisor_remote()) {
-		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
 
@@ -1282,7 +1347,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		.missing_object_cb = NULL,
 		.missing_object_data = NULL
 	};
-	struct prefetch_options prefetch_options = {
+	struct inexact_prefetch_options prefetch_options = {
 		.repo = options->repo
 	};
 
@@ -1449,7 +1514,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
 	if (options->repo == the_repository && has_promisor_remote()) {
-		dpf_options.missing_object_cb = prefetch;
+		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
 
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 3dcffc15f801..aad975d24ddb 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -207,7 +207,7 @@ test_setup_repo () {
 #
 #   Summary: 2 fetches (1 for 2 objects, 1 for 1 object)
 #
-test_expect_merge_algorithm failure failure 'Objects downloaded for single relevant rename' '
+test_expect_merge_algorithm failure success 'Objects downloaded for single relevant rename' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
 	(
@@ -296,7 +296,7 @@ test_expect_merge_algorithm failure failure 'Objects downloaded for single relev
 #      this are not all that common.)
 #   Summary: 1 fetches for 6 objects
 #
-test_expect_merge_algorithm failure failure 'Objects downloaded when a directory rename triggered' '
+test_expect_merge_algorithm failure success 'Objects downloaded when a directory rename triggered' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-dir &&
 	(
-- 
gitgitgadget

