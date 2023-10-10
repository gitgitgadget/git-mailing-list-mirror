Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A720CD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjJJUeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjJJUeF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 16:34:05 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E8C6
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:01 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-417f872fb94so43021841cf.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696970040; x=1697574840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ypW6Fo5acSQYVAcI+hiGciE9kVHJqjoj87AiDRIe7Q=;
        b=bcshmg4qSQHGP6EYQMlvEiitlVkbWouOsitT40beNVrm62dDXd7ryPulZo+oKgFjd1
         Fnoa/2DNP1atuvSQyHmsrMusHvjFLtMZ6RVXYuVzdruvqwimOXGXMF1/qqF5C9gXhiiB
         Y5WuXcSmTVwBIFDRf4srHhnAGmCM2Tc/cf7n7PXBRTOylaFzloKEDFAkhQHG2l2dS4Ns
         odlT3t+1HuTbqyI4aZVD8VEbObsTfm/Xput4hBZ2kfuiIP2wRhKi5zGac9jpDEroKZic
         HjfrucYwkmRJW4o6YdTErXTwHwtDwsVljOYxYzixvn2ab4PfBY09eYprmTbJ8bRKaJkF
         V1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970040; x=1697574840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ypW6Fo5acSQYVAcI+hiGciE9kVHJqjoj87AiDRIe7Q=;
        b=Pv/EoRILZuZQ/44mjBUVKLTc+3cKGL4GM7phasUrdKEekrTNTcJcZAsi543ghU/LOb
         yv26l5LHK/cy9mbAXdn1NcgFupi5EyLpRuLI4hT7F42XQ7ArCLoBoIBsV2uHGmXYlEiF
         E+Wk9Jg6SrJsBv1FfozzyIqNAcn0Fd8gkVVBgCgyk1r6/fVzv49WhZx6v0g14YDgB6qN
         33SytpYAaAdknrRFesBS847dgD9vBkMYB99ZZtQqVXX067+eqOuoUGmVhLBqXMXxCjBS
         bARFOWPsjGUSh1g6y+/ua599qFemz2H2tb8GuaTDv0FOu/iCoVquE7u6ok6FmmG5z7cr
         6LWA==
X-Gm-Message-State: AOJu0YzkDnHnBPEiQeSt35YmhYNEmY4FGxDhWi44+OybyPgzq6Cm06lH
        k51aF7Q9MuHShzpkQf3qy4F+SOng6/1JzQs0YVKMlQ==
X-Google-Smtp-Source: AGHT+IETD5tu7JLnakpFFHgyStz+AapPtqoDkh9FgC66W4VEWWvObJEIM1osz2yJ3BaAiyfBHg3iDg==
X-Received: by 2002:ac8:5e4c:0:b0:413:5e4d:bf40 with SMTP id i12-20020ac85e4c000000b004135e4dbf40mr20916509qtx.68.1696970040611;
        Tue, 10 Oct 2023 13:34:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e1-20020ac81301000000b0040331a24f16sm4767114qtj.3.2023.10.10.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:34:00 -0700 (PDT)
Date:   Tue, 10 Oct 2023 16:33:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 13/17] commit-graph.c: unconditionally load Bloom filters
Message-ID: <09d8669c3a074e7a2ace9d650a345244b2362f7e.1696969994.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
2023-08-01), we began ignoring the Bloom data ("BDAT") chunk for
commit-graphs whose Bloom filters were computed using a hash version
incompatible with the value of `commitGraph.changedPathVersion`.

Now that the Bloom API has been hardened to discard these incompatible
filters (with the exception of low-level APIs), we can safely load these
Bloom filters unconditionally.

We no longer want to return early from `graph_read_bloom_data()`, and
similarly do not want to set the bloom_settings' `hash_version` field as
a side-effect. The latter is because we want to wait until we know which
Bloom settings we're using (either the defaults, from the GIT_TEST
variables, or from the previous commit-graph layer) before deciding what
hash_version to use.

If we detect an existing BDAT chunk, we'll infer the rest of the
settings (e.g., number of hashes, bits per entry, and maximum number of
changed paths) from the earlier graph layer. The hash_version will be
inferred from the previous layer as well, unless one has already been
specified via configuration.

Once all of that is done, we normalize the value of the hash_version to
either "1" or "2".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index db623afd09..fa3b58e762 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -327,12 +327,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
-	if (*c->commit_graph_changed_paths_version == -1) {
-		*c->commit_graph_changed_paths_version = hash_version;
-	} else if (hash_version != *c->commit_graph_changed_paths_version) {
-		return 0;
-	}
-
 	g->chunk_bloom_data = chunk_start;
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
@@ -2473,8 +2467,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2506,10 +2499,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+
+			/* don't propagate the hash_version unless unspecified */
+			if (bloom_settings.hash_version == -1)
+				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
+			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
+			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
+			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;
 		}
 	}
 
+	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
+
 	if (ctx->split) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
-- 
2.42.0.342.g8bb3a896ee

