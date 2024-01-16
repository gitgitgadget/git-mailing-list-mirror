Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74A20DC4
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442955; cv=none; b=g7Audtzk5ObxgUrWUhMIiIsiQW9wBVgEmQpuPqpGu3DjksPOX2cX00lEqRENZMLkXO6SzzH7aqjNNlC8zEq4KXA+vVpRvV0mYhy8M42o+zUgfKdEddQaCJ0+ar5x0qf4W8GJX7ZNCDw73EW+E/A5Hm+w3ub6D+i4ZTxMMSdxTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442955; c=relaxed/simple;
	bh=vQob6MiOc1Bz7W8/f5xsbZ/bSC59BpK4zHtnXhPAUC0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=WYF9xJ3x4M6F6Nyj6kzJAVbhkUctUBL/nvmTR8RSrJ93XAzSCz+3ybVQIzD+FzmJdc/xZH1MhZ1PAKVcDfme0GibVOeQfLZNkuI/5AcisSpEaERJUNQP9CknKGCtoRivktuwI6QIXmPathZvaqaIDAghvJWlgPTQ/Ul0o47FnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=W2PYfYQc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="W2PYfYQc"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd5c4cffefso4470016b6e.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705442953; x=1706047753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t668Q1+nUCAaFkiO1yqc4BI6/hd+nKN9qy0/HflmkC4=;
        b=W2PYfYQcAdaYnZ7NkhB4m/zhVLn8mVUoNAbz3612vkWfezPP4YPRl1DIueZX5hG5lz
         FfruPcdgDuDwMnPpLxppUUyXw/ScCaql3WJec6TZFkXgq4gKnE3MVuEOhvvYTATaZ8ju
         ysycfDkdZitbTfWOTS4mPtl/5+65k+Ox/y0oRrgex+ojHVczaETpxkMcQKTNuNwYf3lw
         KWIM2rHeFa4bZG8HHXBHNM+wM6scZfWuF6DraXIL8Chrorvb5/zds/Npxx1RckO7QRQq
         zXRxM+WBRcPBiFulYBxBbmMDRntTl77YK+k/8/6XM/2nE7zl8DBtR+h5rfe5yYbv/R5M
         hJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442953; x=1706047753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t668Q1+nUCAaFkiO1yqc4BI6/hd+nKN9qy0/HflmkC4=;
        b=MPVJtt1sacVRCHdLCkkI3tjyX7vRj40hwezv8XMvkQ+UNiiEdaPchHfpOdKf6dKe4j
         LF6krBrPgn/rg0dKmnmcA2wXwSgndsTITBQdgIHNREbpp/+g4Z0MbAbWY4WUoumUYhHm
         9HG/0yVbz7EnbuPNBJzEWxmzIhjX3iHJ4Cdl4iXjxz5vf7aYYd1AQlevIU4y5pHW2lcH
         UZb+ULfNTlKkPo00/aNhMUna+GNrty4SS0XQnzWkCDWChFHDEr/reLsHtjVwIF8gZeKZ
         6ZHxO7E7w7IPPIAEjf/SuKzyVByJ5ASM+DRKlPZ1Fo3Xoy3BRXYt9KzjW5pG6f6+l+4k
         3SmQ==
X-Gm-Message-State: AOJu0Yxs+KjCA7IP97GGr3PebppB+H8nAjLEbWJo8Xhb01isoIx5FNn8
	luzsXlSg3vWec77R3566i6RnT6PKYvQOtCYp2TfC4dQlu5VpMg==
X-Google-Smtp-Source: AGHT+IGUYh4CYoDBywe5tNy2o7xtXyCa568qg7mBqsOKbToHfnAO0+LNFKli2VrDE0JBj6kQyEtNqw==
X-Received: by 2002:a05:6808:3a0b:b0:3bc:8e1a:a4a with SMTP id gr11-20020a0568083a0b00b003bc8e1a0a4amr10814686oib.36.1705442952867;
        Tue, 16 Jan 2024 14:09:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l8-20020a05620a0c0800b007831ca13f58sm4038368qki.84.2024.01.16.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 14:09:12 -0800 (PST)
Date: Tue, 16 Jan 2024 17:09:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v5 03/17] commit-graph: ensure Bloom filters are read with
 consistent settings
Message-ID: <285b25f1b7cca0a64ec410613135d58f73133722.1705442923.git.me@ttaylorr.com>
References: <cover.1697653929.git.me@ttaylorr.com>
 <cover.1705442923.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1705442923.git.me@ttaylorr.com>

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
 t/t4216-log-bloom.sh | 65 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index bba316913c..00113b0f62 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -543,6 +543,30 @@ static int validate_mixed_generation_chain(struct commit_graph *g)
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
@@ -666,6 +690,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(struct repository *r,
 	}
 
 	validate_mixed_generation_chain(graph_chain);
+	validate_mixed_bloom_settings(graph_chain);
 
 	free(oids);
 	fclose(fp);
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index cc6ebc8140..20b0cf0c0e 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -421,8 +421,71 @@ test_expect_success 'Bloom generation backfills empty commits' '
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
+test_expect_success 'ensure incompatible Bloom filters are ignored' '
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
+	# merging existing layers.
+	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
+	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
+
+	test_path_is_file $repo/$graph &&
+	test_dir_is_empty $repo/$graphdir &&
+
+	git -C $repo -c core.commitGraph=false log --oneline --no-decorate -- \
+		file >expect &&
+	trace_out="$(pwd)/trace.perf" &&
+	GIT_TRACE2_PERF="$trace_out" \
+		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
+
+	test_cmp expect actual &&
+	grep "statistics:{\"filter_not_present\":0," trace.perf &&
+	test_must_be_empty err
+'
+
 corrupt_graph () {
-	graph=.git/objects/info/commit-graph &&
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable --changed-paths &&
 	corrupt_chunk_file $graph "$@"
-- 
2.43.0.334.gd4dbce1db5.dirty

