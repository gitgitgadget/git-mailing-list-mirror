Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B5EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHUVol (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjHUVok (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2E18D
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:34 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58caaedb20bso43621667b3.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654273; x=1693259073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqpZRffTNAuTW9lnNBgr48lAndSmA4HxvpZWVnPLdn4=;
        b=MtCC7wghOiLrB3t5dDu6uoDO7lWMIHxDhIgscv4xBFt8JNEDp2ZIHOVXF3wayYeSMN
         fiak3RVFE47AcplLu5NsyRTb409+cd7DHu0sSltrwmG5UBkzEoshykpJVv2Or2Iks0r8
         yOyxgfAVZI8JAQ+FjXW3BYJJniQ+AxBPs5pCbG/AnS+9FJ8HE92iMIkfzigyFJIZ+gDt
         dhAM3b/4HWZintVone/wV0IOa//4uZPMQmtFKZJsM3KP1364WXQj1gBh+oZ5gSlxy4VY
         lhlFxAajdfYq2/mZH4S5qzhhxircsYYoABpojc/5Lzo0aTSDDicZi1AdqfjZ927/5ZHQ
         Tf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654273; x=1693259073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqpZRffTNAuTW9lnNBgr48lAndSmA4HxvpZWVnPLdn4=;
        b=h484xFr/mDcRP8ID1Nb9mENzlNlZH+e8RjDzd9tZGeM5VRjK2nlQQ9gvDCV4EaIq2A
         mjIhD7yFUfNa+GVLSomgoEZRXds1yhm7Y+XmGdOkgIMYGdtFNLruThfn6IwSzXr1Sz/o
         kyMlbkmS6QzXFom24wYAaY+xTpbl1q9TJUvBNAX06/v0/dqtQ1gCr1Tt9t6EK5AgJMMt
         UcutlnC5yVAoZacC6PcOAwZOF7NcGHy1asl3PhezxqHuDuPWMpohqQ8TYIq2lgNJoTRL
         oVLFs75UoaCpCeblozwx9KYgbKW7QOL4t308x6SmAHqwdSPeLDWLnwZD79rMlsc6SFa9
         1NgQ==
X-Gm-Message-State: AOJu0YylY2AzJsd4N0HOiYM9qs4D4bUtoXh8Rc9AfVqiRiRd2xH6fdJW
        lf3NpXtrZkXVP9BcLazj1QBM0azOI7OJ6Y8qECn3CA==
X-Google-Smtp-Source: AGHT+IHpjWx1XPHm+VXdZZuqLyeMD4KUvhAmuPSKzl+YHXB0Lx/WfgBcaTYAWqr5F3wR3dU14kLSLg==
X-Received: by 2002:a0d:e2c5:0:b0:589:a937:2b67 with SMTP id l188-20020a0de2c5000000b00589a9372b67mr8151738ywe.9.1692654273186;
        Mon, 21 Aug 2023 14:44:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u64-20020a816043000000b00582fae92aa7sm2442988ywb.93.2023.08.21.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:33 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 11/15] commit-graph.c: unconditionally load Bloom filters
Message-ID: <05516aa898aa5008eac113381b6aa58ef7b90065.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
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
index f7322c4fff..665a3edf78 100644
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
@@ -2408,8 +2402,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2441,10 +2434,18 @@ int write_commit_graph(struct object_directory *odb,
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
2.42.0.4.g52b49bb434

