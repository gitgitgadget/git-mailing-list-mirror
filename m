Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5679DC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B7F222F9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgLHUoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLHUoG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:44:06 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEFEC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:43:26 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id w139so9129754ybe.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bp0Zht9nnz68NFpw/gKVacGjX2FCoIz7/ZnEIzpIgt8=;
        b=hAB9g+B7qmwspsJhKwfDdt5Hk49Sdvx3JuTkNvVEoZxbvvq0nuHOuvXoSmSAfcc+Jh
         mQgeTWLZczsFlq+VI2afxGlgNoxpOvK320gPfxcCwM+VGjkeScJ+g9GuAhpppQX+yOAs
         nUImIMBqjJbS4I19bvxoA7eJocqyUVm103AM8APAJ2TI7TaNfk/DqFi06X6x1YmYLz6Q
         kEqh0J8/doQfDX/EEMSrNbozDLHp6MYnFy/SWoV+cj3FTcIGN3dCYXuQSwhA/lqQZ0Tn
         1UeiGvqNbRXyXh52hXd2SxWv+gfDUVMyUS6VxTiYaJ4StRMqQaBlml/rq4cio7yu6Mdj
         kdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bp0Zht9nnz68NFpw/gKVacGjX2FCoIz7/ZnEIzpIgt8=;
        b=l6wqW5YgzUj3AM0obLth7mjf/FFopImF3VbsN/btGHPBjrKjuUoo3GBnwVKTz2xZMk
         lWm0E0TXVDMDI7o/QeGnhEzWYAokXTTroxykY8yEJbxa9Oq6i51YJ2EksX9/Bi2dsDPR
         +ltPO+4M6pCMFfqoI5pPqjBKPV7R55abwIyZINQcyW4bgdoNvC0Q+rBOUfEcg4SUHkxl
         Z9IlrfAmyDoc4PoDoHLz+aAekWKBb57+Yk9gUnthdLpeovLwTIv2XDvyq84t2zEid6Rs
         R1hteGUmJOoWRmuAFLD1cedEIFbB05rKijAQ0XI73ywoMjuKL+e3WGa6ecgaM330gLgZ
         JMdg==
X-Gm-Message-State: AOAM532x64i5DHG60CmHCHPOjEe0+3i394xX4k96XNI4irlau52SMx/h
        Wm50U973OL53TqhkA43VIqTnjYnNtXULbp+a
X-Google-Smtp-Source: ABdhPJwpMhKnZRKHalOAGpZfx3D2sjP0/CiHd7H8Qzs2HEmh4guG1LY6FAnrAz56g3YQGLAaUf+F8A==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr7326544otm.234.1607452930071;
        Tue, 08 Dec 2020 10:42:10 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k63sm3869468oia.14.2020.12.08.10.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:42:09 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:42:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] midx: use chunk-format API in write_midx_internal()
Message-ID: <X8/I/RzXZksio+ri@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <f2f78ee1054f64fe767335c4b0c77ba2fbec5fae.1607012215.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2f78ee1054f64fe767335c4b0c77ba2fbec5fae.1607012215.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 04:16:49PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The chunk-format API allows automatically writing the table of contents
> for a chunk-based file format when using an array of "struct
> chunk_info"s. Update write_midx_internal() to use this strategy, which
> also simplifies the chunk writing loop. This loop will be replaced with
> a chunk-format API call in an upcoming change.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c | 96 +++++++++++++---------------------------------------------
>  1 file changed, 21 insertions(+), 75 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index ce6d4339bd..0548266bea 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -11,6 +11,7 @@
>  #include "trace2.h"
>  #include "run-command.h"
>  #include "repository.h"
> +#include "chunk-format.h"
>
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>  #define MIDX_VERSION 1
> @@ -799,15 +800,14 @@ static int write_midx_large_offsets(struct hashfile *f,
>  static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
>  			       struct string_list *packs_to_drop, unsigned flags)
>  {
> -	unsigned char cur_chunk, num_chunks = 0;
> +	unsigned char num_chunks = 0;
>  	char *midx_name;
>  	uint32_t i;
>  	struct hashfile *f = NULL;
>  	struct lock_file lk;
>  	struct write_midx_context ctx = { 0 };
>  	uint64_t header_size = 0;
> -	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
> -	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
> +	struct chunk_info chunks[MIDX_MAX_CHUNKS];
>  	int pack_name_concat_len = 0;
>  	int dropped_packs = 0;
>  	int result = 0;
> @@ -923,7 +923,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	if (ctx.m)
>  		close_midx(ctx.m);
>
> -	cur_chunk = 0;
>  	num_chunks = ctx.large_offsets_needed ? 5 : 4;
>
>  	if (ctx.nr - dropped_packs == 0) {
> @@ -934,85 +933,32 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>
>  	header_size = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);
>
> -	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
> -	chunk_offsets[cur_chunk] = header_size + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
> +	chunks[0].id = MIDX_CHUNKID_PACKNAMES;
> +	chunks[0].size = pack_name_concat_len;
> +	chunks[0].write_fn = write_midx_pack_names;

[...]

Hmm. The caller has to do quite a lot of work in order to feed chunks
into the new chunk-format code.

I wonder what it would look like if we introduced a new 'struct
chunkfile' type. It would know about the underlying hashfile that it's
writing to, as well as the chunks it's supposed to write. It would
likely support three operations: add a new chunk, write the TOC, and
write the contents (the latter two could probably be combined into one).

Below is a patch to do just that. It seems to work OK on t5319, but
fails some tests in t5318. I haven't looked into the commit-graph test
failures, but I'd be happy to do so if you think this is a direction
worth going in.

Before I show the patch, though, let's take a look at the stat:

 chunk-format.c | 61 ++++++++++++++++++++++++++++++++++++++----------
 chunk-format.h | 25 ++++++++++++--------
 commit-graph.c | 90 ++++++++++++++++++++++-------------------------------------------------
 midx.c         | 38 +++++++++++++-----------------
 4 files changed, 107 insertions(+), 107 deletions(-)

That's a little bit more code in the chunk-format code, which I can live
with, but the diff in commit-graph.c and midx.c is a net-negative, as I
would expect it to be. So, I'm happy that this seems to make things
easier on the callers.

OK, enough rambling. Here's the patch:

diff --git a/chunk-format.c b/chunk-format.c
index 771b6d98d0..14f2fe5c9a 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,26 +1,63 @@
 #include "git-compat-util.h"
 #include "chunk-format.h"
 #include "csum-file.h"
+#include "cache.h"
 #define CHUNK_LOOKUP_WIDTH 12

-void write_table_of_contents(struct hashfile *f,
-			     uint64_t cur_offset,
-			     struct chunk_info *chunks,
-			     int nr)
+void chunkfile_init(struct chunkfile *out, struct hashfile *f)
 {
-	int i;
+	if (!out)
+		BUG("cannot initialize null chunkfile");
+
+	memset(out, 0, sizeof(*out));
+	out->f = f;
+}
+
+void chunkfile_push_chunk(struct chunkfile *c,
+			  uint32_t id, uint64_t size, chunk_write_fn write_fn)
+{
+	ALLOC_GROW(c->chunks, c->chunks_nr + 1, c->chunks_alloc);
+	c->chunks[c->chunks_nr].id = id;
+	c->chunks[c->chunks_nr].size = size;
+	c->chunks[c->chunks_nr].write_fn = write_fn;
+	c->chunks_nr++;
+}
+
+void chunkfile_write_toc(struct chunkfile *c)
+{
+	size_t i;
+	off_t cur_offset = hashfile_total(c->f);

 	/* Add the table of contents to the current offset */
-	cur_offset += (nr + 1) * CHUNK_LOOKUP_WIDTH;
+	cur_offset += (c->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;

-	for (i = 0; i < nr; i++) {
-		hashwrite_be32(f, chunks[i].id);
-		hashwrite_be64(f, cur_offset);
+	for (i = 0; i < c->chunks_nr; i++) {
+		hashwrite_be32(c->f, c->chunks[i].id);
+		hashwrite_be64(c->f, cur_offset);

-		cur_offset += chunks[i].size;
+		cur_offset += c->chunks[i].size;
 	}

 	/* Trailing entry marks the end of the chunks */
-	hashwrite_be32(f, 0);
-	hashwrite_be64(f, cur_offset);
+	hashwrite_be32(c->f, 0);
+	hashwrite_be64(c->f, cur_offset);
+}
+
+void chunkfile_write_chunks(struct chunkfile *c, void *ctx)
+{
+	size_t i;
+
+	for (i = 0; i < c->chunks_nr; i++) {
+		off_t before, after;
+		struct chunk_info *chunk = &c->chunks[i];
+		if (!chunk->write_fn)
+			continue;
+
+		before = hashfile_total(c->f);
+		chunk->write_fn(c->f, ctx);
+		after = hashfile_total(c->f);
+
+		if (after - before != chunk->size)
+			BUG("unexpected chunk size");
+	}
 }
diff --git a/chunk-format.h b/chunk-format.h
index 4b9cbeb372..b0fb515425 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -19,18 +19,23 @@ struct chunk_info {
 	chunk_write_fn write_fn;
 };

+struct chunkfile {
+	struct hashfile *f;
+
+	struct chunk_info *chunks;
+	size_t chunks_nr;
+	size_t chunks_alloc;
+};
+
+void chunkfile_init(struct chunkfile *out, struct hashfile *f);
+void chunkfile_push_chunk(struct chunkfile *c,
+			  uint32_t id, uint64_t size, chunk_write_fn write_fn);
+
 /*
  * Write the chunk data into the supplied hashfile.
- *
- * * 'cur_offset' indicates the number of bytes written to the hashfile
- *   before the table of contents starts.
- *
- * * 'nr' is the number of chunks with non-zero IDs, so 'nr + 1'
- *   chunks are written in total.
  */
-void write_table_of_contents(struct hashfile *f,
-			     uint64_t cur_offset,
-			     struct chunk_info *chunks,
-			     int nr);
+void chunkfile_write_toc(struct chunkfile *c);
+
+void chunkfile_write_chunks(struct chunkfile *c, void *ctx);

 #endif
diff --git a/commit-graph.c b/commit-graph.c
index 5494fda1d3..abc0c9e46f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1702,11 +1702,9 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	uint32_t i;
 	int fd;
 	struct hashfile *f;
+	struct chunkfile cf;
 	struct lock_file lk = LOCK_INIT;
-	struct chunk_info chunks[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
-	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = 3;
 	struct object_id file_hash;

 	if (ctx->split) {
@@ -1753,76 +1751,42 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}

-	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
-	chunks[0].size = GRAPH_FANOUT_SIZE;
-	chunks[0].write_fn = write_graph_chunk_fanout;
-	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
-	chunks[1].size = hashsz * ctx->commits.nr;
-	chunks[1].write_fn = write_graph_chunk_oids;
-	chunks[2].id = GRAPH_CHUNKID_DATA;
-	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
-	chunks[2].write_fn = write_graph_chunk_data;
-	if (ctx->num_extra_edges) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
-		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
-		chunks[num_chunks].write_fn = write_graph_chunk_extra_edges;
-		num_chunks++;
-	}
+	chunkfile_init(&cf, f);
+
+	chunkfile_push_chunk(&cf, GRAPH_CHUNKID_OIDFANOUT,
+			     GRAPH_FANOUT_SIZE, write_graph_chunk_fanout);
+	chunkfile_push_chunk(&cf, GRAPH_CHUNKID_OIDLOOKUP,
+			     hashsz * ctx->commits.nr, write_graph_chunk_oids);
+	chunkfile_push_chunk(&cf, GRAPH_CHUNKID_DATA,
+			     (hashsz + 16) * ctx->commits.nr, write_graph_chunk_data);
+	if (ctx->num_extra_edges)
+		chunkfile_push_chunk(&cf, GRAPH_CHUNKID_EXTRAEDGES,
+				     4 * ctx->num_extra_edges,
+				     write_graph_chunk_extra_edges);
 	if (ctx->changed_paths) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
-		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
-		chunks[num_chunks].write_fn = write_graph_chunk_bloom_indexes;
-		num_chunks++;
-		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
-		chunks[num_chunks].size = sizeof(uint32_t) * 3
-					  + ctx->total_bloom_filter_data_size;
-		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
-		num_chunks++;
-	}
-	if (ctx->num_commit_graphs_after > 1) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
-		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
-		chunks[num_chunks].write_fn = write_graph_chunk_base;
-		num_chunks++;
+		chunkfile_push_chunk(&cf, GRAPH_CHUNKID_BLOOMINDEXES,
+				     sizeof(uint32_t) * ctx->commits.nr,
+				     write_graph_chunk_bloom_indexes);
+		chunkfile_push_chunk(&cf, GRAPH_CHUNKID_BLOOMDATA,
+				     sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size,
+				     write_graph_chunk_bloom_data);
 	}
+	if (ctx->num_commit_graphs_after > 1)
+		chunkfile_push_chunk(&cf, GRAPH_CHUNKID_BASE,
+				     hashsz * (ctx->num_commit_graphs_after - 1),
+				     write_graph_chunk_base);

-	chunks[num_chunks].id = 0;
-	chunks[num_chunks].size = 0;
+	chunkfile_push_chunk(&cf, 0, 0, NULL);

 	hashwrite_be32(f, GRAPH_SIGNATURE);

 	hashwrite_u8(f, GRAPH_VERSION);
 	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, cf.chunks_nr - 1);
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);

-	write_table_of_contents(f, /* cur_offset */ 8, chunks, num_chunks);
-
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Writing out commit graph in %d pass",
-			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
-		ctx->progress = start_delayed_progress(
-			progress_title.buf,
-			num_chunks * ctx->commits.nr);
-	}
-
-	for (i = 0; i < num_chunks; i++) {
-		uint64_t start_offset = f->total + f->offset;
-
-		if (chunks[i].write_fn(f, ctx))
-			return -1;
-
-		if (f->total + f->offset != start_offset + chunks[i].size)
-			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
-			    chunks[i].size, chunks[i].id,
-			    f->total + f->offset - start_offset);
-	}
-
-	stop_progress(&ctx->progress);
-	strbuf_release(&progress_title);
+	chunkfile_write_toc(&cf);
+	chunkfile_write_chunks(&cf, ctx);

 	if (ctx->split && ctx->base_graph_name && ctx->num_commit_graphs_after > 1) {
 		char *new_base_hash = xstrdup(oid_to_hex(&ctx->new_base_graph->oid));
diff --git a/midx.c b/midx.c
index 0548266bea..6315ea7555 100644
--- a/midx.c
+++ b/midx.c
@@ -807,7 +807,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	struct lock_file lk;
 	struct write_midx_context ctx = { 0 };
 	uint64_t header_size = 0;
-	struct chunk_info chunks[MIDX_MAX_CHUNKS];
+	struct chunkfile cf;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -933,33 +933,27 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *

 	header_size = write_midx_header(f, num_chunks, ctx.nr - dropped_packs);

-	chunks[0].id = MIDX_CHUNKID_PACKNAMES;
-	chunks[0].size = pack_name_concat_len;
-	chunks[0].write_fn = write_midx_pack_names;
+	chunkfile_init(&cf, f);

-	chunks[1].id = MIDX_CHUNKID_OIDFANOUT;
-	chunks[1].size = MIDX_CHUNK_FANOUT_SIZE;
-	chunks[1].write_fn = write_midx_oid_fanout;
-
-	chunks[2].id = MIDX_CHUNKID_OIDLOOKUP;
-	chunks[2].size = ctx.entries_nr * the_hash_algo->rawsz;
-	chunks[2].write_fn = write_midx_oid_lookup;
-
-	chunks[3].id = MIDX_CHUNKID_OBJECTOFFSETS;
-	chunks[3].size = ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH;
-	chunks[3].write_fn = write_midx_object_offsets;
+	chunkfile_push_chunk(&cf, MIDX_CHUNKID_PACKNAMES,
+			     pack_name_concat_len, write_midx_pack_names);
+	chunkfile_push_chunk(&cf, MIDX_CHUNKID_OIDFANOUT,
+			     MIDX_CHUNK_FANOUT_SIZE, write_midx_oid_fanout);
+	chunkfile_push_chunk(&cf, MIDX_CHUNKID_OIDLOOKUP,
+			     ctx.entries_nr * the_hash_algo->rawsz, write_midx_oid_lookup);
+	chunkfile_push_chunk(&cf, MIDX_CHUNKID_OBJECTOFFSETS,
+			     ctx.entries_nr * MIDX_CHUNK_OFFSET_WIDTH, write_midx_object_offsets);

 	if (ctx.large_offsets_needed) {
-		chunks[4].id = MIDX_CHUNKID_LARGEOFFSETS;
-		chunks[4].size = ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
-		chunks[4].write_fn = write_midx_large_offsets;
+		chunkfile_push_chunk(&cf, MIDX_CHUNKID_LARGEOFFSETS,
+				     ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH,
+				     write_midx_large_offsets);
 	}

-	write_table_of_contents(f, header_size, chunks, num_chunks);
-
-	for (i = 0; i < num_chunks; i++)
-		chunks[i].write_fn(f, &ctx);
+	chunkfile_write_toc(&cf);
+	chunkfile_write_chunks(&cf, &ctx);

+	/* maybe move this into chunkfile??? */
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);

