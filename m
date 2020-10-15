Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF0C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C63D20795
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="SV57N2Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgJOVlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgJOVlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 17:41:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BEEC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 14:41:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so129567ilj.9
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5J9pzDBxdgXA3J3w9rU4T25cKys8xaql1bG8+gWSTLI=;
        b=SV57N2TdiZot5/+1qP8j0EYRollcQu8yztiRvmDEzUNJufmsVvun5scKbXaiGAMHhT
         mgK1a5PSFc8IRC2wnmEK7CJOjrahdCOlko78bPENqNzs+tlV/AjcgsD+wpfW+kdC/O9T
         vvw7hW6m3CHOV8fnE1gNKq9h5kz1Z/eiWO9VSfpdLJBDzJcE+Kz9v7I2sVP03pbrQDTM
         wy6DmE47dU65+7CbwjhugmRwXx3Q1DbxET3Kdrq2A21CroTujyb8fZHycUJRgx+8Elaf
         MGjdQiIM9f6CCjE0RleTwbxtTC6bE5ImDJSFVPAxlOU9O+0escKPvnPkFAh3Ocfu/Zir
         iCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5J9pzDBxdgXA3J3w9rU4T25cKys8xaql1bG8+gWSTLI=;
        b=Cmn1mOMHu5zGZJIKnltSzjdJZYGIZvy5xoZCgHF0WQserpUlFnPxF2Rwp4hRlTV+4P
         nb/Bsn4tqkbMfPSIUn1AoTaKjsIm89B65oRF9p1tG4syhWwQcw4JbtwmCEqon/CB75qM
         MAaGi3s7pvxlsVsKQuVLM5/k0W9h3eUuO4/MbTwITvntr3dBBy1WBkE1Qi5hld0AKikY
         PfL4F3V8+uqxn4j/DQJ93erZv0vOUvoAnK5zC8PTzQYjdgsrIYCLKypqOADYLDvd0qE4
         8UxD9YvOHdz0UOnR8i7hLKsZgRrBs1iBvPCGkk474n919YqcexCIhPWeMEsimPF+/4f7
         BUFw==
X-Gm-Message-State: AOAM533qz+BppCmhBi9ZmrqBjv4Ep9oXBDJQmULMRCYzprbL+mpe7qlU
        BEC97JBw0+7LunzcffkcbEe6cw==
X-Google-Smtp-Source: ABdhPJybh3EF6g+OaAGQLrYjkR81MiEGbrZVU7gcCnxSvftIdB5oO2+6jDSGDB/OF0OqN/hfdNLWlA==
X-Received: by 2002:a92:1952:: with SMTP id e18mr420331ilm.189.1602798073874;
        Thu, 15 Oct 2020 14:41:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f8a1:4f77:4a56:23a7])
        by smtp.gmail.com with ESMTPSA id 18sm256773ilg.3.2020.10.15.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 14:41:13 -0700 (PDT)
Date:   Thu, 15 Oct 2020 17:41:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/10] commit-graph: persist existence of changed-paths
Message-ID: <20201015214111.GA2176154@nand.local>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
 <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
 <20201015132147.GB24954@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015132147.GB24954@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 03:21:47PM +0200, SZEDER Gábor wrote:
> As pointed out in my original bug report [1], modified path Bloom
> filters are computed with hardcoded settings in
> bloom.c:get_bloom_filter().  Since this patch does not touch bloom.c
> at all, it still computes Bloom filters with those hardcoded settings,
> and, consequently, despite the commit message's claims, it does not
> persist the settings in the existing commit-graph.
>
> [1] https://public-inbox.org/git/20200619140230.GB22200@szeder.dev/

Right. It is worth mentioning here (as you do below) that this was fixed
as of 9a7a9ed10d (bloom: use provided 'struct bloom_filter_settings',
2020-09-16).

> > Use the trace2 API to signal the settings used during the write, and
> > check that output in a test after manually adjusting the correct bytes
> > in the commit-graph file.
>
> This test is insufficient, as it only checks what settings trace2
> believes the Bloom filters are computed with, not what settings they
> are actually computed with; that's why it succeeded while the bug
> whose absence it was supposed to ensure was still there.
>
> More robust tests should instead look at what actually gets written to
> the commit-graph, and how that is interpreted during pathspec-limited
> revision walks.

Thanks for the test! That saved me a little bit of work trying to set up
the scenario you're describing in a reproducible way. I think that the
third test can be fixed relatively easily. The crux of the issue there
is that we are computing Bloom filters for commits, some of which
already had Bloom filters computed in an earlier layer, but with
different settings than the one that we're using to write the current
layer.

So, we need to be more aggressively checking the Bloom filter settings
in any layer we want to reuse a Bloom filter out of before reusing it
verbatim in the current layer. The patch below the scissors line is
sufficient to do that, and it causes the third test to start passing.

...But, teaching the revision machinery how to handle a walk through
commits in multiple commit-graph layers with incompatible Bloom filter
settings is trickier. Right now we compute all of the Bloom keys up
front using the Bloom filter settings in the top layer. I think we'd
probably want to change this to lazily compute those keys by:

  - Keeping around the contents of the Bloom keys, i.e., the pathspecs
    themselves.

  - Keeping a hashmap from Bloom filter settings to computed Bloom keys
    corresponding to those settings.

  - Lazily filling in that hashmap as we traverse through different
    commits.

At least, that's the best way that I can think to do it. It does get
kind of slow, though; we'd have to scan every commit graph layer at each
commit in the worst case to find the actual 'struct commit_graph *' in
order to get its Bloom filter settings. So, I think that's sort of
show-stoppingly slow, and that we should probably think more deeply
about it before taking up that direction.

Maybe Stolee has some better thoughts about how we can quickly go from a
commit to either (a) the commit-graph struct that that commit is stored
in, or (b) the Bloom filter settings belonging to that struct.

Thanks,
Taylor

--- >8 ---

Subject: [PATCH] bloom: recompute filters with incompatible settings
---
 bloom.c        | 21 +++++++++++++++++++--
 commit-graph.c |  4 ++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/bloom.c b/bloom.c
index 68c73200a5..30da128474 100644
--- a/bloom.c
+++ b/bloom.c
@@ -30,7 +30,8 @@ static inline unsigned char get_bitmask(uint32_t pos)

 static int load_bloom_filter_from_graph(struct commit_graph *g,
 					struct bloom_filter *filter,
-					struct commit *c)
+					struct commit *c,
+					const struct bloom_filter_settings *settings)
 {
 	uint32_t lex_pos, start_index, end_index;
 	uint32_t graph_pos = commit_graph_position(c);
@@ -42,6 +43,21 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	if (!g->chunk_bloom_indexes)
 		return 0;

+	if (settings) {
+		struct bloom_filter_settings *graph_settings = g->bloom_filter_settings;
+		/*
+		 * Check that the settings used to generate new Bloom filters is
+		 * compatible with the settings Bloom filters in this
+		 * commit-graph layer were generated with.
+		 */
+		if (settings->hash_version != graph_settings->hash_version)
+			return 0;
+		if (settings->num_hashes != graph_settings->num_hashes)
+			return 0;
+		if (settings->bits_per_entry != graph_settings->bits_per_entry)
+			return 0;
+	}
+
 	lex_pos = graph_pos - g->num_commits_in_base;

 	end_index = get_be32(g->chunk_bloom_indexes + 4 * lex_pos);
@@ -205,7 +221,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
+			load_bloom_filter_from_graph(r->objects->commit_graph,
+						     filter, c, settings);
 	}

 	if (filter->data && filter->len)
diff --git a/commit-graph.c b/commit-graph.c
index cb042bdba8..afe14af2a3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1188,7 +1188,7 @@ static int write_graph_chunk_bloom_indexes(struct hashfile *f,
 	uint32_t cur_pos = 0;

 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, *list, 0, ctx->bloom_settings, NULL);
 		size_t len = filter ? filter->len : 0;
 		cur_pos += len;
 		display_progress(ctx->progress, ++ctx->progress_cnt);
@@ -1228,7 +1228,7 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);

 	while (list < last) {
-		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		struct bloom_filter *filter = get_or_compute_bloom_filter(ctx->r, *list, 0, ctx->bloom_settings, NULL);
 		size_t len = filter ? filter->len : 0;

 		display_progress(ctx->progress, ++ctx->progress_cnt);
--
2.29.0.rc1.dirty

