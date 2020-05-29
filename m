Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2224C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B02720776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0qTUysw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgE2IwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgE2Ivu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30F2C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so2416777wmh.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uX6HbOpHQEtIxexZFdu0oXN+a6kSCCA/+9ji0J8xGcE=;
        b=H0qTUysw9qgAH8lB0jSeLqj7lsnc59qmKgNtge1Pd9q3OTKk7Rx0KFMsKUHetRmHHJ
         CEO7IrfkxQ4n2MA4xe8LOk06Uj21g1CbuUpAWSg6MrXbOeTd0mjVvLbVBR+I073DqH20
         khiCK/WpzHQ5DhRs6G1O41PxrsCHXMx3p8qs8TwU9fFwDM4tEZcSWb51F0BDi79ozEft
         XVO4ABvurO56VFbGha+s6+YyrCgFu1LfOzjEfTrwqWDUEpRCtUWlGTwPN0Ola8Xcv2OP
         MEkBlMBygc37fT5alZKwjl5vs4ULxIYMj3kyt8848X8MzDyIm4lJOK7ExOrvUFu9soNg
         AaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uX6HbOpHQEtIxexZFdu0oXN+a6kSCCA/+9ji0J8xGcE=;
        b=rBfBuvr/y5seQK/itnxoX+i9CePAUCTyiFjEaA+tC+Dcfi4PrXmxoKq9U9CqUONNO3
         O9fmvxG8I/4NVSaf4wNyFud/AjgVWy/C8+SPCGU/vV1s06lDQF+ALyYIEMR+XhysPiUx
         PdXhaffmTVGwEUkysj+DKhVUnQE7bCLOvTyf+z9/nw7Kj7e5c/vDRYxiYzo4uI1dz/AT
         RIaUNjqVoM/GzSVuS4+DR8lswp/520mqHFaIRQUNOi4O1reHFbz542Z4W6f2MIn1cPGs
         8eeSAChnrtdgIMFevZ/tdKZRWTHLt6WhGqCQX9LGh4U9yCni503ESlVO7g4ihPCr2npS
         l/cg==
X-Gm-Message-State: AOAM531OEHTEzPUBTs3CEkckd9tt2me2YdC0ArmB7bYyoN3ZnejXcEPM
        L6QhfHwVONbOHXbhY6s/kibiDr1q
X-Google-Smtp-Source: ABdhPJy9xQo/GNjKb8jk4LjfcXruohXfo3k8cF5KmmNHChNfc2BMbC5hvphjFTHRK6DAR+TzzReU4w==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr7784267wmh.46.1590742307901;
        Fri, 29 May 2020 01:51:47 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 33/34] commit-graph: write modified path Bloom filters in "history order"
Date:   Fri, 29 May 2020 10:50:37 +0200
Message-Id: <20200529085038.26008-34-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Explain!  Try topo order!]

I don't have recent benchmark results at hand yet, but as far as I can
recall some old results this reduces the time spent loading and
checking modified path Bloom filters by another ~10%.  Checking Bloom
filters is of course only a small part of the whole runtime of a
pathspec-limited revision walk, so the overall improvement is only
about 1-2%.
Oh, well, I expected more from this change... But perhaps it has
larger impact with less embedded modified path Bloom filters?

This is the last patch in this series that improves pathspec-limited
revision walk performance, so it's time to compare average runtime and
memory usage of

  git rev-list HEAD -- "$path"

for 5000+ randomly selected paths from each repository with and
without modified path Bloom filters:

                  Average runtime     Average  |  Average max RSS
                 without      with    speedup  |  without    with
  ---------------------------------------------+----------------------------
  android-base   0.8780s    0.1456s     6.03x  |  387MB    91.2MB    -76.5%
  cmssw          0.3143s    0.0313s    10.04x  |  181MB    37.4MB    -79.4%
  cpython        0.7453s    0.0810s     9.20x  |  159MB    43.8MB    -72.5%
  elasticsearch  0.1492s    0.0136s    10.95x  |  134MB    21.8MB    -83.7%
  gcc            7.1852s    0.2114s    34.00x  |  297MB    91.1MB    -69.3%
  gecko-dev      4.6113s    0.4815s     9.58x  |  832MB   175.2MB    -79.0%
  git            0.6180s    0.0310s    19.94x  |  131MB    31.5MB    -76.0%
  glibc          0.5618s    0.0282s    19.92x  |  135MB    25.0MB    -81.6%
  go             0.4913s    0.0403s    12.19x  |  130MB    24.7MB    -81.1%
  jdk            0.0482s    0.0068s     7.09x  |   52MB    27.1MB    -48.2%
  linux          0.7043s    0.0873s     8.08x  |  438MB   150.9MB    -65.5%
  llvm-project   2.6844s    0.4135s     6.49x  |  384MB   126.5MB    -67.1%
  rails          0.2784s    0.0391s     7.12x  |   88MB    28.8MB    -67.3%
  rust           0.7757s    0.0439s    17.67x  |  344MB    42.0MB    -87.8%
  tensorflow     0.6258s    0.0487s    12.85x  |  233MB    36.7MB    -84.2%
  webkit         1.9137s    0.2420s     7.91x  |  940MB    84.7MB    -91.0%

The astute reader may notice that in several cases the achieved
speedup is a bit higher than the calculated potential speedup shown in
the log message of the patch adding the modified path Bloom filter
specs, e.g. 34x vs. 29.7x in the gcc repository.  I suspect that by
eliminating much of the tree-diff overhead we load a lot less (tree)
objects, putting less strain on the caches, and in turn making other
parts of the process faster as well.

Alas, this is not without extra cost: writing the commit-graph file
with modified path Bloom filters takes a lot longer and the resulting
commit-graph file is considerably larger:

          Writing a commit-graph file from      |
             scratch with '--reachable'         | commit-graph file size
                 without       with             |   without      with
  ----------------------------------------------+--------------------------------
  android-base    6.230s     40.880s     6.56x  |  25077512    31278605    +24.7%
  cmssw           3.177s     25.691s     8.09x  |  13017516    23971497    +84.1%
  cpython         1.344s      8.951s     6.66x  |   6808068     8152146    +19.7%
  gcc             2.886s     36.917s    12.79x  |  12839660    18068286    +40.7%
  gecko-dev       9.331s     97.729s    10.47x  |  43335208    66568549    +53.6%
  git             0.750s      5.245s     6.99x  |   3388208     4011595    +18.3%
  glibc           0.565s      4.146s     7.34x  |   2832460     3936588    +38.9%
  homebrew-cask   1.083s     27.024s    24.95x  |   5928644     6859160    +15.7%
  homebrew-core   1.702s     55.478s    32.60x  |   9171324    10509040    +14.5%
  jdk             0.568s     19.418s    34.19x  |   3237508    15858410   +389.8%
  linux          13.525s    100.837s     7.46x  |  49800744    81939893    +64.5%
  llvm-project    4.275s     31.188s     7.30x  |  19309116    25336867    +31.2%
  rails           0.986s      5.607s     5.69x  |   4990252     6317541    +26.5%
  rust            1.260s     13.250s    10.52x  |   6053824     8601440    +42.0%
  webkit          3.658s     30.469s     8.33x  |  12288620    19438512    +58.1%
---
 commit-graph.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1677e4fb3e..8eb0cbedaf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -67,6 +67,8 @@ struct modified_path_bloom_filter_info {
 	uint64_t offset;
 	uint32_t merge_index_pos;
 	struct modified_path_bloom_filter_info *next;
+	/* TODO: need better names for 'next' and 'next_commit_bfi' */
+	struct modified_path_bloom_filter_info *next_commit_bfi;
 };
 
 static void free_modified_path_bloom_filter_info_in_slab(
@@ -1159,6 +1161,10 @@ struct write_commit_graph_context {
 
 		/* Used to find identical modified path Bloom filters */
 		struct hashmap dedup_hashmap;
+
+		/* To chain up Bloom filters in history order */
+		struct modified_path_bloom_filter_info *first_commit_bfi;
+		struct modified_path_bloom_filter_info *prev_commit_bfi;
 	} mpbfctx;
 };
 
@@ -1363,18 +1369,18 @@ static int write_graph_chunk_modified_path_bloom_filters(struct hashfile *f,
 		struct write_commit_graph_context *ctx)
 {
 	uint64_t offset = 0;
-	int i;
+	struct modified_path_bloom_filter_info *next_commit_bfi;
 
-	for (i = 0; i < ctx->commits.nr; i++) {
-		struct commit *commit = ctx->commits.list[i];
-		struct modified_path_bloom_filter_info *bfi;
-		unsigned int filter_size;
+	next_commit_bfi = ctx->mpbfctx.first_commit_bfi;
+	while (next_commit_bfi) {
+		struct modified_path_bloom_filter_info *bfi = next_commit_bfi;
+
+		next_commit_bfi = next_commit_bfi->next_commit_bfi;
 
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		bfi = modified_path_bloom_filters_peek(
-				&modified_path_bloom_filters, commit);
 		for (; bfi; bfi = bfi->next) {
+			unsigned int filter_size;
 			if (bfi->duplicate_of)
 				continue;
 			if (!bfi->filter.nr_bits)
@@ -1762,6 +1768,14 @@ static void create_modified_path_bloom_filter(
 	bloom_filter_set_bits(&bfi->filter, mpbfctx->hashes,
 			      mpbfctx->hashes_nr);
 
+	if (!mpbfctx->first_commit_bfi) {
+		mpbfctx->first_commit_bfi = bfi;
+		mpbfctx->prev_commit_bfi = bfi;
+	} else if (!nth_parent) {
+		mpbfctx->prev_commit_bfi->next_commit_bfi = bfi;
+		mpbfctx->prev_commit_bfi = bfi;
+	}
+
 	if (path_component_count > mpbfctx->embedded_limit &&
 	    !handle_duplicate_modified_path_bloom_filter(mpbfctx, bfi))
 		mpbfctx->total_filter_size += sizeof(uint32_t) +
-- 
2.27.0.rc1.431.g5c813f95dc

