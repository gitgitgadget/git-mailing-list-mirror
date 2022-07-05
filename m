Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B905EC43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 22:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiGEW2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGEW2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 18:28:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CAD17058
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 15:28:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id ck6so15868067qtb.7
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l3N3eO1mGcCsOgFFsEudqdIBTSzpKVI6giozweLT+WY=;
        b=tA9xuha5adqazb6//THpYfeReGYRRwmJ+x+RX+h/d9CXwHhQcNmE4HkZkCE8s43uRE
         9z91HwGHGzU0bi7AevrwfpXiR0qT/7d7oqfJ3WkeFeu3mPUlu5G7MqRyNJ5LZg7Xje2R
         fOS4CEUQHTDC5xLw32R2DRRVJHP+HALjNm0FQU4fwzoA7V2n9DXECVuHkUPIjrEgFIyk
         x7lBBA2eDK3yRuVuNMfhuA7+J4xHVCmTSsxRDyTF+xCAQ50o/CZDqzvxy2Skw/U12/gg
         eq02nLhYFAAUyBmFW/ync0Sz3gNpEj167WZVBA4zfarS64S8/CJHgOcR/2Ozv6TzgumA
         fQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l3N3eO1mGcCsOgFFsEudqdIBTSzpKVI6giozweLT+WY=;
        b=kDkbDirObpZWZHUtcx1xILPtxPKHlT2D//1wRshVeRXMiA/PA+qKimfidYOtX5OK/x
         ZhVF+NEC4UlpJFJn0D0yxt9KP4Rb4Jf2cKhjFqdlcRkyT8f7e7I9sqL4Ucx6orx3FrJ3
         BkPYkAsAhOzIgKfIILClgThMqYBZIZKHZvmpmx8TuXRwbPbrPsscPdmsxGOBL5XuciF7
         r0G6sIfkZT20mxyml+90Kp1bAhCCgAOFrHTIj0LxcjDvo/LXK7GfySjmsp1K31gWjTn1
         qS2O4u99aRZ8r+JP8BcmGLtJIN6ljLkL1DfNgJ4vBn4z5a9zc/OT1WDLJNlj/TQE4XQ2
         fZrA==
X-Gm-Message-State: AJIora+c+60EvQ6cqVrkCaEP4ih0b0wEhCFKGyec476eLie9R19JJu+c
        +VrltU0K98Vm38f4R8zRQd/P6Q==
X-Google-Smtp-Source: AGRyM1spMFMV7yQH81B8EuIwQgM7y9dr3DMW1chCJ4gsBqL33rlBiXxNYzPLNSSxfOn5MRA/5h0/Bg==
X-Received: by 2002:ac8:5f4e:0:b0:31b:f6eb:d109 with SMTP id y14-20020ac85f4e000000b0031bf6ebd109mr30355383qta.150.1657060128738;
        Tue, 05 Jul 2022 15:28:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 93-20020aed3166000000b00304df6f73f0sm23119628qtg.0.2022.07.05.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:28:48 -0700 (PDT)
Date:   Tue, 5 Jul 2022 18:28:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     derrickstolee@github.com, git@vger.kernel.org, peff@peff.net,
        ps@pks.im
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YsS7H4i5DqUZVQ5i@nand.local>
References: <a154e109-3f4c-c500-3365-d47879abf30d@github.com>
 <DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 05, 2022 at 05:03:44PM -0400, Will Chandler wrote:
> Hi all,
>
> I think I've reproduced this problem on v2.36.1 and main.

Great find. I played around with this a little bit locally and your
reproduction works for me on any sufficiently-large repository. Looking
around in the code, I'm pretty confident that this is the issue.

>   $ git -c commitGraph.generationVersion=2 commit-graph write --changed-paths

This step is critical: without it we never end up overwriting the
`->generation` data, and the conversion works fine.

> Because the existing commit graph did not include generation data,
> graph.read_generation_data is 0. When compute_bloom_filters executes, it
> will call fill_commit_graph_info which checks that value and falls back
> to the older generation calculation if false:
>
>   if (g->read_generation_data) {
>   	offset = (timestamp_t)get_be32(g->chunk_generation_data + sizeof(uint32_t) * lex_index);
>
>   	if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
>   		if (!g->chunk_generation_data_overflow)
>   			die(_("commit-graph requires overflow generation data but has none"));
>
>   		offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
>   		graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
>   	} else
>   		graph_data->generation = item->date + offset;
>   } else
>   	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
>
> This re-writes the commit data to:
>
>   {
>     graph_pos = 0,
>     generation = 17631
>   }

Nicely explained. To me, it seems like the problem is that we're reusing
the same slab to:

  - store data that we're going to write as a part of commit-graph
    generation, and
  - store auxiliary data about commits that we have *read* from a
    commit-graph

A complete fix might be to use a separate slab to store data that we
read from data that we are about to write, to avoid polluting the latter
with the former.

In the meantime, a more minimal fix would be to avoid reading and
overwriting the generation data where we can avoid it. AFAICT, this is
the only spot that would need to be changed. The following patch does
the trick for me:

--- >8 ---

diff --git a/bloom.c b/bloom.c
index 5e297038bb..863052fa68 100644
--- a/bloom.c
+++ b/bloom.c
@@ -30,10 +30,9 @@ static inline unsigned char get_bitmask(uint32_t pos)

 static int load_bloom_filter_from_graph(struct commit_graph *g,
 					struct bloom_filter *filter,
-					struct commit *c)
+					uint32_t graph_pos)
 {
 	uint32_t lex_pos, start_index, end_index;
-	uint32_t graph_pos = commit_graph_position(c);

 	while (graph_pos < g->num_commits_in_base)
 		g = g->base_graph;
@@ -203,9 +202,11 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	filter = bloom_filter_slab_at(&bloom_filters, c);

 	if (!filter->data) {
-		load_commit_graph_info(r, c);
-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
+		uint32_t pos;
+		if ((repo_find_commit_pos_in_graph(r, c, &pos)) &&
+		    (pos != COMMIT_NOT_FROM_GRAPH))
+			load_bloom_filter_from_graph(r->objects->commit_graph,
+						     filter, pos);
 	}

 	if (filter->data && filter->len)
diff --git a/commit-graph.c b/commit-graph.c
index 92d4503336..2d9fad5910 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -889,6 +889,14 @@ static int find_commit_pos_in_graph(struct commit *item, struct commit_graph *g,
 	}
 }

+int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
+				  uint32_t *pos)
+{
+	if (!prepare_commit_graph(r))
+		return 0;
+	return find_commit_pos_in_graph(c, r->objects->commit_graph, pos);
+}
+
 struct commit *lookup_commit_in_graph(struct repository *repo, const struct object_id *id)
 {
 	struct commit *commit;
diff --git a/commit-graph.h b/commit-graph.h
index 2e3ac35237..52ddfbe349 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,6 +40,9 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
  */
 int parse_commit_in_graph(struct repository *r, struct commit *item);

+int repo_find_commit_pos_in_graph(struct repository *r, struct commit *c,
+				  uint32_t *pos);
+
 /*
  * Look up the given commit ID in the commit-graph. This will only return a
  * commit if the ID exists both in the graph and in the object database such

--- 8< ---

Thanks,
Taylor
