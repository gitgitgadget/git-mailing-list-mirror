Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86994C04FE1
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHGQif (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjHGQiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:23 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C331FCD
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d479d128596so3291077276.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426274; x=1692031074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PeSoczXdOvAxnaG+yi3KBXu1dZhE6+EhokHcg9k2Xk=;
        b=k2fwkBvmADLnKX6KWs5Lo5iUQsDBPtmLraRqhUhGGgmvxP+H+7tQduzJE4KQWYwuG+
         wdP6YHZBx746Gp0NhTDv1G32nGj6EA8dfgwJUDEQBsis4OWrkKebkH4b7gEkkPs6rD29
         M/YWZnADSOZrqkUzrFNfLLCF46ZsqtMrhl2rHGflcAW1iejm6AWW2Pfxbx7CiJm5/17O
         wlMiezdXbzU3p8/NPm4Z1H8s3mQnfUPpI3fS+DTr6up1X1E6UJuFxQnYxasRFKoEIT0e
         xXm1odkRwiog0wRDN4s6MQd9ta/IF0Gaa50ZWoDQGWlowxP5kI3M2UDiinEJNvgltyFD
         sTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426274; x=1692031074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PeSoczXdOvAxnaG+yi3KBXu1dZhE6+EhokHcg9k2Xk=;
        b=jWZ/xs1IXbefk+KtITlNbfbiLWEaiKwe9hbA9lzWXIi5hewjx8rgQHqoNEcVzAsY+1
         COiMGLly3TV7G7zvTPZbkSlugDBPB7tstEjn0O54EVFYRYsyP1urmnHXiWAdFlQCgflj
         phd0hmau9qixB9/xFyYrdSkhXVWx4donUTVcER177cAbuFH/ehhy0j/1BDwc6iZOjtiT
         nM6sBDQxKSK+hKMHnLjgSfwHQn6uaMSOOHQh7/3LS2LpVr093hlnGXmqW5ibYw5SSg9J
         Fj0dORED8Y/OvLGOPIUS/XO2leOSrPA2uE671qHblzeD/l2HQg3hpgsNbdmYvgmBMIlC
         +MAA==
X-Gm-Message-State: AOJu0YwhPzzPui1v9eWxpa3DnsHQWjxTWUTQ2MJb5ioqBFgXfe1bUPxj
        pgSnlTfbhVFbdkQp31hCqUmLsPp7AnY1LxU+j0QyNA==
X-Google-Smtp-Source: AGHT+IGogonKi+BLcyoKL/yPlnHz+6D2jBL/sGiD7meawMdRGB5M4T5+mwQMQKMaIKBzFyMZ5YoFZA==
X-Received: by 2002:a25:2d12:0:b0:cb7:e3e9:fe6f with SMTP id t18-20020a252d12000000b00cb7e3e9fe6fmr7094092ybt.30.1691426274139;
        Mon, 07 Aug 2023 09:37:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 192-20020a2515c9000000b00c389676f3a2sm2382839ybv.40.2023.08.07.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:53 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 4/6] commit-graph.c: unconditionally load Bloom filters
Message-ID: <6676afe56db74828ba2532f3460e9b73a3ff20fd.1691426160.git.me@ttaylorr.com>
References: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
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
index 38edb12669..60e5f9ada7 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -317,12 +317,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
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
@@ -2390,8 +2384,7 @@ int write_commit_graph(struct object_directory *odb,
 			r->settings.commit_graph_changed_paths_version);
 		return 0;
 	}
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2423,10 +2416,18 @@ int write_commit_graph(struct object_directory *odb,
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
2.41.0.407.g6d1c33951b

