Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3EC43331
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA3164EB2
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhBRQsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhBROI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A69C0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l12so3146589wry.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hgf5sIU2eZ2Zo4JCE6f47sg1VrsUi9XM/wReOtIKfW8=;
        b=Mc9FQm6xOo0JRyb8SHtPxqe08ariNZCD1fvZ6AxEufBZvi9bQAxdED2UtUf1uc9685
         xm1ISrlLrgeruggAHH86QUt/LEazNXEsc9eFipEGii67ZE8QIP8mrM51fxVai7hNMLFV
         /WCN+yY5AIU1hxeMBNjN1iYoLfXB3xz+euzajFFNJ2qS6xEri/2HMZ/sXouLxokspMEk
         BSlNN8TT5Az8UQBdItr7j3wmphZ8eqoAOvWB5HnNjmRpFW+W668HaYIDm2/V+/1q5PVn
         nr29+DeLM1tY9DNZ122fS/IscUZahFS1zRZC1R6Ok7OiI1fbMHMp4ggXBe6KB4OUTAJd
         V1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hgf5sIU2eZ2Zo4JCE6f47sg1VrsUi9XM/wReOtIKfW8=;
        b=V5vVmXJhdJLcRuXadYtwJ+4eh1zun9kHH510HbqgewpirRzWtTT8btmK24K60K5evY
         9iHDH86ztGI8ZhinKJJLDxn8bWyapIfrjsolP+aIMnxCezARAWXNBZUhSZrGcZ8BSd5M
         ooK2DgKLk/Y450sVv5I0dmzS2WRYxz1N2bYZisJkooHjeKH4E7RJd653anAYCIBLPym7
         +0wbIIJnRbpap3wRzd0+4VADig3Iw2QmDf8VgtODLwYJhG0kJQkyWrZ5DNdWKUn/XYOp
         7mPkg6hKsPAi12VuRrS7Of8HGY/yc0rqO0Yh+zpLrnNX/G8h7NlNd+6jzx74neYOloWU
         aGpA==
X-Gm-Message-State: AOAM532X4kHNNFmsF7XZHgdxhPY7ADIKze2lDJ0aURUY+dXdXGsA7Z8o
        28/E3vAem4MeqTuA4pmn/kKiZwgrUe8=
X-Google-Smtp-Source: ABdhPJxT8donOcKi/aXOxpAuMhZE6MtkaQ20dT+iJ8J6ySqVeNRtduRf2y1TgYOrq84U0be7JJ8jmQ==
X-Received: by 2002:adf:dece:: with SMTP id i14mr3474869wrn.75.1613657261681;
        Thu, 18 Feb 2021 06:07:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm1945131wrw.74.2021.02.18.06.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:40 -0800 (PST)
Message-Id: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:22 +0000
Subject: [PATCH v4 00/17] Refactor chunk-format into an API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a restart on the topic previously submitted [1] but dropped because
ak/corrected-commit-date was still in progress. This version is based on
that branch.

[1]
https://lore.kernel.org/git/pull.804.git.1607012215.gitgitgadget@gmail.com/

This version also changes the approach to use a more dynamic interaction
with a struct chunkfile pointer. This idea is credited to Taylor Blau [2],
but I started again from scratch. I also go further to make struct chunkfile
anonymous to API consumers. It is defined only in chunk-format.c, which
should hopefully deter future users from interacting with that data
directly.

[2] https://lore.kernel.org/git/X8%2FI%2FRzXZksio+ri@nand.local/

This combined API is beneficial to reduce duplicated logic. Or rather, to
ensure that similar file formats have similar protections against bad data.
The multi-pack-index code did not have as many guards as the commit-graph
code did, but now they both share a common base that checks for things like
duplicate chunks or offsets outside the size of the file.

Here are some stats for the end-to-end change:

 * 570 insertions(+), 456 deletions(-).
 * commit-graph.c: 107 insertions(+), 192 deletions(-)
 * midx.c: 164 insertions(+), 260 deletions(-)

While there is an overall increase to the code size, the consumers do get
smaller. Boilerplate things like abstracting method to match chunk_write_fn
and chunk_read_fn make up a lot of these insertions. The "interesting" code
gets a lot smaller and cleaner.


Updates in V4
=============

 * Out-of-date macros in commit-graph.c and midx.c are removed in their
   appropriate patches.
 * Documentation around the read API is improved.


Updates in V3
=============

 * API methods use better types and changed their order to match internal
   data more closely.

 * Use hashfile_total() instead of internal data values.

 * The implementation of pair_chunk() uses read_chunk().

 * init_chunkfile() has an in-code doc comment warning against using the
   same struct chunkfile for reads and writes.

 * More multiplications are correctly cast in midx.c.

 * The chunk-format technical docs are expanded.


Updates in V2
=============

 * The method pair_chunk() now automatically sets a pointer while
   read_chunk() uses the callback. This greatly reduces the code size.

 * Pointer casts are now implicit instead of explicit.

 * Extra care is taken to not overflow when verifying chunk sizes on write.

Thanks, -Stolee

Derrick Stolee (17):
  commit-graph: anonymize data in chunk_write_fn
  chunk-format: create chunk format write API
  commit-graph: use chunk-format write API
  midx: rename pack_info to write_midx_context
  midx: use context in write_midx_pack_names()
  midx: add entries to write_midx_context
  midx: add pack_perm to write_midx_context
  midx: add num_large_offsets to write_midx_context
  midx: return success/failure in chunk write methods
  midx: drop chunk progress during write
  midx: use chunk-format API in write_midx_internal()
  chunk-format: create read chunk API
  commit-graph: use chunk-format read API
  midx: use chunk-format read API
  midx: use 64-bit multiplication for chunk sizes
  chunk-format: restore duplicate chunk checks
  chunk-format: add technical docs

 Documentation/technical/chunk-format.txt      | 116 +++++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 Makefile                                      |   1 +
 chunk-format.c                                | 179 ++++++++
 chunk-format.h                                |  68 +++
 commit-graph.c                                | 305 +++++-------
 midx.c                                        | 433 +++++++-----------
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5319-multi-pack-index.sh                   |   6 +-
 10 files changed, 652 insertions(+), 464 deletions(-)
 create mode 100644 Documentation/technical/chunk-format.txt
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-848%2Fderrickstolee%2Fchunk-format%2Frefactor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-848/derrickstolee/chunk-format/refactor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/848

Range-diff vs v3:

  1:  243dcec94368 =  1:  243dcec94368 commit-graph: anonymize data in chunk_write_fn
  2:  16c37d2370cf !  2:  da1fcc683576 chunk-format: create chunk format write API
     @@ chunk-format.c (new)
      +#include "cache.h"
      +#include "chunk-format.h"
      +#include "csum-file.h"
     -+#define CHUNK_LOOKUP_WIDTH 12
      +
      +/*
      + * When writing a chunk-based file format, collect the chunks in
     @@ chunk-format.c (new)
      +	uint64_t cur_offset = hashfile_total(cf->f);
      +
      +	/* Add the table of contents to the current offset */
     -+	cur_offset += (cf->chunks_nr + 1) * CHUNK_LOOKUP_WIDTH;
     ++	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
      +
      +	for (i = 0; i < cf->chunks_nr; i++) {
      +		hashwrite_be32(cf->f, cf->chunks[i].id);
     @@ chunk-format.h (new)
      +struct hashfile;
      +struct chunkfile;
      +
     ++#define CHUNK_TOC_ENTRY_SIZE (sizeof(uint32_t) + sizeof(uint64_t))
     ++
      +struct chunkfile *init_chunkfile(struct hashfile *f);
      +void free_chunkfile(struct chunkfile *cf);
      +int get_num_chunks(struct chunkfile *cf);
  3:  e549e24d79af !  3:  ddebf2389880 commit-graph: use chunk-format write API
     @@ commit-graph.c
       
       void git_test_write_commit_graph_or_die(void)
       {
     +@@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
     + #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
     + #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
     + #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
     +-#define MAX_NUM_CHUNKS 9
     + 
     + #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
     + 
      @@ commit-graph.c: static int write_graph_chunk_base(struct hashfile *f,
       	return 0;
       }
  4:  66ff49ed9309 =  4:  8fdaae017dab midx: rename pack_info to write_midx_context
  5:  1d7484c0cffa =  5:  c18f3738f5d4 midx: use context in write_midx_pack_names()
  6:  ea0e7d40e537 =  6:  2bb2847aad6e midx: add entries to write_midx_context
  7:  b283a38fb775 =  7:  f5d44c012ad5 midx: add pack_perm to write_midx_context
  8:  e7064512ab7f =  8:  f5baadf276ff midx: add num_large_offsets to write_midx_context
  9:  7aa3242e15b7 =  9:  fd008449fc89 midx: return success/failure in chunk write methods
 10:  70f68c95e479 = 10:  60e77e451800 midx: drop chunk progress during write
 11:  787cd7f18d2e ! 11:  0b95aa7e152f midx: use chunk-format API in write_midx_internal()
     @@ midx.c
       
       #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
       #define MIDX_VERSION 1
     +@@
     + #define MIDX_HEADER_SIZE 12
     + #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
     + 
     +-#define MIDX_MAX_CHUNKS 5
     + #define MIDX_CHUNK_ALIGNMENT 4
     + #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
     + #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
      @@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
       static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
       			       struct string_list *packs_to_drop, unsigned flags)
 12:  366eb2afee83 ! 12:  3e0dbc45ce7f chunk-format: create read chunk API
     @@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
      +			return 1;
      +		}
      +
     -+		table_of_contents += CHUNK_LOOKUP_WIDTH;
     ++		table_of_contents += CHUNK_TOC_ENTRY_SIZE;
      +		next_chunk_offset = get_be64(table_of_contents + 4);
      +
      +		if (next_chunk_offset < chunk_offset ||
     @@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
      +}
      
       ## chunk-format.h ##
     -@@
     - struct hashfile;
     - struct chunkfile;
     +@@ chunk-format.h: struct chunkfile;
     + 
     + #define CHUNK_TOC_ENTRY_SIZE (sizeof(uint32_t) + sizeof(uint64_t))
       
      +/*
      + * Initialize a 'struct chunkfile' for writing _or_ reading a file
     @@ chunk-format.h
      + * If writing a file, supply a non-NULL 'struct hashfile *' that will
      + * be used to write.
      + *
     -+ * If reading a file, then supply the memory-mapped data to the
     ++ * If reading a file, use a NULL 'struct hashfile *' and then call
     ++ * read_table_of_contents(). Supply the memory-mapped data to the
      + * pair_chunk() or read_chunk() methods, as appropriate.
      + *
      + * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
 13:  7838ad32e2e0 ! 13:  87f441fc5e15 commit-graph: use chunk-format read API
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit-graph.c ##
     +@@ commit-graph.c: void git_test_write_commit_graph_or_die(void)
     + 
     + #define GRAPH_HEADER_SIZE 8
     + #define GRAPH_FANOUT_SIZE (4 * 256)
     +-#define GRAPH_CHUNKLOOKUP_WIDTH 12
     +-#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
     ++#define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * CHUNK_TOC_ENTRY_SIZE \
     + 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
     + 
     + #define CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW (1ULL << 31)
      @@ commit-graph.c: static int verify_commit_graph_lite(struct commit_graph *g)
       	return 0;
       }
     @@ commit-graph.c: static int verify_commit_graph_lite(struct commit_graph *g)
       
       	if (!graph_map)
       		return NULL;
     +@@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
     + 	graph->data_len = graph_size;
     + 
     + 	if (graph_size < GRAPH_HEADER_SIZE +
     +-			 (graph->num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH +
     ++			 (graph->num_chunks + 1) * CHUNK_TOC_ENTRY_SIZE +
     + 			 GRAPH_FANOUT_SIZE + the_hash_algo->rawsz) {
     + 		error(_("commit-graph file is too small to hold %u chunks"),
     + 		      graph->num_chunks);
      @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
       		return NULL;
       	}
 14:  6bddd9e63b9b ! 14:  64010031db0e midx: use chunk-format read API
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## midx.c ##
     +@@
     + #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
     + #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
     + #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
     +-#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
     + #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
     + #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
     + #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
      @@ midx.c: static char *get_midx_filename(const char *object_dir)
       	return xstrfmt("%s/pack/multi-pack-index", object_dir);
       }
 15:  3cd97f389f1f = 15:  16205d8f8c40 midx: use 64-bit multiplication for chunk sizes
 16:  b9a1bddf615f = 16:  0e58218be418 chunk-format: restore duplicate chunk checks
 17:  4c7d751f1e39 = 17:  84bf6506dc12 chunk-format: add technical docs

-- 
gitgitgadget
