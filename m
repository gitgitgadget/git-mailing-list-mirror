Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45ACD8CB4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjJJUdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjJJUdd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:33:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4897D9E
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7757f2d3956so23865385a.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970008; x=1697574808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mUZYz73TCkmr9Uvn+COH52Jc2nmCrspZUfXeIu/zvWU=;
        b=wYWc8Zhvq/hsLumHrReEIHnPpzgKpW4UE7hGYiEAtXQQEJASNLS+IM+1TfsRWoRQ/e
         iuB9pHwXsD/E09AiuPCf26I+y8v4KHeFViQwjRCfOgOrCfTRBz2Yb+NrBZXvyfMikv1k
         dvrYOifOLCzIFKfQLg7lfK/IQbLLLx240aIq+qY2QkP1qHxXTBz8yICqHMQWeXEUnFEk
         zA+f8OUehfp9JTCHKjiTfNrmXs8CKCx8dew5dIKWYMeR1y1GQkXQPmnGtEDd+DABtYQI
         y8EKLKC7RgEufrS/O73vgrIiDTbRzGUxnDzK1eOb8zyKtVqbI72nKTkAo0YEDBbyLdCu
         NfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970008; x=1697574808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUZYz73TCkmr9Uvn+COH52Jc2nmCrspZUfXeIu/zvWU=;
        b=L6U/oMet6Bly2LBlnV6h8EwQlEh/K8sSOoba/Mg3jNLEaQDh1JFfOj5bVN0ca+znF+
         CSxdRSlRd+7snK7B57yXCaEv7ebFjS8H3kod7CWQK+MV0L3w3XOAqKj5CVnR7lZ/gT2U
         1pmovSEH93X0566F4GdaLRZoeK4PSTJkexRg/FL42gewpN+PeCB3TyxbKLxzg58x3SBJ
         VASPxyYF4e/NtWgF5pRmh4zOKoXNFDetisPWcfyubjVJXa3s7PDv0TQ2ICvd46f6o/zt
         99VPH2QYQX3KEF48zz+rpzMnDf8GJtpP1cNwujwOHvxXl0tGDDSqLU99nrFIf5DOWxiy
         qm2A==
X-Gm-Message-State: AOJu0YzsCvhGj2y+gfyTGH2HK8AbNq48vGAYn9kKK+GuCFHZDhvHmOhE
        s9yJZIGiguQt4Vpm4pcJk0TDXZT+aMjBPUoz9x0FWw==
X-Google-Smtp-Source: AGHT+IFXnfj/j7f2NUxDivvNJb5Qi2+9g1/U8+M5jkNhUKElrDV9o3o9oA8PNA8fq3JJPUul1N/ovQ==
X-Received: by 2002:a05:620a:454f:b0:774:19a4:117a with SMTP id u15-20020a05620a454f00b0077419a4117amr24134408qkp.19.1696970008185;
        Tue, 10 Oct 2023 13:33:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a111800b0075ca4cd03d4sm4618697qkk.64.2023.10.10.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:33:27 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 03/17] commit-graph: ensure Bloom filters are read with
 consistent settings
Message-ID: <2ecc0a2d58432b149d73a3e2abfa948eb1f0aa0b.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The changed-path Bloom filter mechanism is parameterized by a couple of
variables, notably the number of bits per hash (typically "m" in Bloom
filter literature) and the number of hashes themselves (typically "k").

It is critically important that filters are read with the Bloom filter
settings that they were written with. Failing to do so would mean that
each query is liable to compute different fingerprints, meaning that the
filter itself could return a false negative. This goes against a basic
assumption of using Bloom filters (that they may return false positives,
but never false negatives) and can lead to incorrect results.

We have some existing logic to carry forward existing Bloom filter
settings from one layer to the next. In `write_commit_graph()`, we have
something like:

    if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
        struct commit_graph *g = ctx->r->objects->commit_graph;

        /* We have changed-paths already. Keep them in the next graph */
        if (g && g->chunk_bloom_data) {
            ctx->changed_paths = 1;
            ctx->bloom_settings = g->bloom_filter_settings;
        }
    }

, which drags forward Bloom filter settings across adjacent layers.

This doesn't quite address all cases, however, since it is possible for
intermediate layers to contain no Bloom filters at all. For example,
suppose we have two layers in a commit-graph chain, say, {G1, G2}. If G1
contains Bloom filters, but G2 doesn't, a new G3 (whose base graph is
G2) may be written with arbitrary Bloom filter settings, because we only
check the immediately adjacent layer's settings for compatibility.

This behavior has existed since the introduction of changed-path Bloom
filters. But in practice, this is not such a big deal, since the only
way up until this point to modify the Bloom filter settings at write
time is with the undocumented environment variables:

  - GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY
  - GIT_TEST_BLOOM_SETTINGS_NUM_HASHES
  - GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS

(it is still possible to tweak MAX_CHANGED_PATHS between layers, but
this does not affect reads, so is allowed to differ across multiple
graph layers).

But in future commits, we will introduce another parameter to change the
hash algorithm used to compute Bloom fingerprints itself. This will be
exposed via a configuration setting, making this foot-gun easier to use.

To prevent this potential issue, validate that all layers of a split
commit-graph have compatible settings with the newest layer which
contains Bloom filters.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-test-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c       | 25 +++++++++++++++++
 t/t4216-log-bloom.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 1a56efcf69..ae0902f7f4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -498,6 +498,30 @@ static int validate_mixed_generation_chain(struct commit_graph *g)
 	return 0;
 }
 
+static void validate_mixed_bloom_settings(struct commit_graph *g)
+{
+	struct bloom_filter_settings *settings = NULL;
+	for (; g; g = g->base_graph) {
+		if (!g->bloom_filter_settings)
+			continue;
+		if (!settings) {
+			settings = g->bloom_filter_settings;
+			continue;
+		}
+
+		if (g->bloom_filter_settings->bits_per_entry != settings->bits_per_entry ||
+		    g->bloom_filter_settings->num_hashes != settings->num_hashes) {
+			g->chunk_bloom_indexes = NULL;
+			g->chunk_bloom_data = NULL;
+			FREE_AND_NULL(g->bloom_filter_settings);
+
+			warning(_("disabling Bloom filters for commit-graph "
+				  "layer '%s' due to incompatible settings"),
+				oid_to_hex(&g->oid));
+		}
+	}
+}
+
 static int add_graph_to_chain(struct commit_graph *g,
 			      struct commit_graph *chain,
 			      struct object_id *oids,
@@ -614,6 +638,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	}
 
 	validate_mixed_generation_chain(graph_chain);
+	validate_mixed_bloom_settings(graph_chain);
 
 	free(oids);
 	fclose(fp);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 322640feeb..f49a8f2fbf 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -420,4 +420,68 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+graph=.git/objects/info/commit-graph
+graphdir=.git/objects/info/commit-graphs
+chain=$graphdir/commit-graph-chain
+
+test_expect_success 'setup for mixed Bloom setting tests' '
+	repo=mixed-bloom-settings &&
+
+	git init $repo &&
+	for i in one two three
+	do
+		test_commit -C $repo $i file || return 1
+	done
+'
+
+test_expect_success 'split' '
+	# Compute Bloom filters with "unusual" settings.
+	git -C $repo rev-parse one >in &&
+	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3 git -C $repo commit-graph write \
+		--stdin-commits --changed-paths --split <in &&
+	layer=$(head -n 1 $repo/$chain) &&
+
+	# A commit-graph layer without Bloom filters "hides" the layers
+	# below ...
+	git -C $repo rev-parse two >in &&
+	git -C $repo commit-graph write --stdin-commits --no-changed-paths \
+		--split=no-merge <in &&
+
+	# Another commit-graph layer that has Bloom filters, but with
+	# standard settings, and is thus incompatible with the base
+	# layer written above.
+	git -C $repo rev-parse HEAD >in &&
+	git -C $repo commit-graph write --stdin-commits --changed-paths \
+		--split=no-merge <in &&
+
+	test_line_count = 3 $repo/$chain &&
+
+	# Ensure that incompatible Bloom filters are ignored.
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- file \
+		>expect 2>err &&
+	git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+	test_cmp expect actual &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err
+'
+
+test_expect_success 'merge graph layers with incompatible Bloom settings' '
+	# Ensure that incompatible Bloom filters are ignored when
+	# generating new layers.
+	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+
+	test_path_is_file $repo/$graph &&
+	test_dir_is_empty $repo/$graphdir &&
+
+	# ...and merging existing ones.
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- file \
+		>expect 2>err &&
+	GIT_TRACE2_PERF="$(pwd)/trace.perf" \
+		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+
+	test_cmp expect actual && cat err &&
+	grep "statistics:{\"filter_not_present\":0" trace.perf &&
+	! grep "disabling Bloom filters" err
+'
+
 test_done
-- 
2.42.0.342.g8bb3a896ee

