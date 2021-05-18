Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A6C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DF26135F
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351604AbhERSeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351622AbhERSeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:34:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B12AC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2047786wmc.1
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sa8p0xN0Kc1lDWwL+xwSpEhn5tOQjYMx5XS/jyyb6es=;
        b=jRnslSihuRBboSaRlIZGWQZUWCaPUI/y6xj1TUlz8jycBkM4Sxx7H2tkjJSGmMHIrP
         IlklTptUf4i02siRZdgpcGcZNaRsr4FEB8kbSjlMnND+WlNun1Dfmzy+tWaw0VzyX+kc
         HCymLQ2ZCLGGOx0W5sDyHrY/PJF15q2C2qDO0108In7xmAXAa4XfrcfTq6hnE2OFSHfn
         p4PjfHmd3Ys9dUS2jlOR84PCQDZ9czL8VZVmFFeCK4DGsuJQs+oOuNcGaZ1EXOlcF7xT
         mRM25tBJZkOgJF5e4zd1LUo+MS2VdhMHYE4KFk1pj/1HY8D/jSgXeZ2n+I7IRTqVBFIu
         8pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sa8p0xN0Kc1lDWwL+xwSpEhn5tOQjYMx5XS/jyyb6es=;
        b=t7rgwFTF/4FHE6aonxhr4kkUHVzd6t/outcKi5l/iBXHAztLmuKZkLn4ZuUOA4D8KT
         tRKXZff3B77BSo0985DA8xS/aYiJH85m4KowbDMK9i24K05OK+XOtYKAglMvDG3zNjSm
         84UNtVv8a++fu6hLqrYShym7OyHpfpBrMMRkIkOUWNSk+mc/JLNnxl5+CLs4bM//q65g
         qYvn+QDJ1q6ArI+5LlwvuvynFOK4YzSQPAlMO4o+aXQneFUvDLhf1QhjqMn5BgU9Wr90
         arYu4RtPOHRnn91t3w1Aokv+pjjz4sdChwGOuQ3VdzytaragEYZ0V3uOBWPHe3ZBbjNc
         h3fQ==
X-Gm-Message-State: AOAM532bpKVfpiZ1Rcub1Xbt2IJhcUx+jXpb42WVYZvxX2kzEc4KV7wL
        2Tvj9j/T+WV3J1RjhTiGix2gjGjjGrw=
X-Google-Smtp-Source: ABdhPJySJ3TM5oZBJdI+0XwnlHoRUJydpvVQE67U3BZH9rI/knX5m3qYDJ2sGSssMWHwC822u/GubQ==
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr6384356wme.178.1621362771796;
        Tue, 18 May 2021 11:32:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm1785323wrx.38.2021.05.18.11.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:32:51 -0700 (PDT)
Message-Id: <afd278bef3abce511b0ff90dd9b28e135baccc54.1621362768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
References: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 18:32:47 +0000
Subject: [PATCH v3 3/4] read-cache: use hashfile instead of git_hash_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The do_write_index() method in read-cache.c has its own hashing logic
and buffering mechanism. Specifically, the ce_write() method was
introduced by 4990aadc (Speed up index file writing by chunking it
nicely, 2005-04-20) and similar mechanisms were introduced a few months
later in c38138cd (git-pack-objects: write the pack files with a SHA1
csum, 2005-06-26). Based on the timing, in the early days of the Git
codebase, I figured that these roughly equivalent code paths were never
unified only because it got lost in the shuffle. The hashfile API has
since been used extensively in other file formats, such as pack-indexes,
multi-pack-indexes, and commit-graphs. Therefore, it seems prudent to
unify the index writing code to use the same mechanism.

I discovered this disparity while trying to create a new index format
that uses the chunk-format API. That API uses a hashfile as its base, so
it is incompatible with the custom code in read-cache.c.

This rewrite is rather straightforward. It replaces all writes to the
temporary file with writes to the hashfile struct. This takes care of
many of the direct interactions with the_hash_algo.

There are still some git_hash_ctx uses remaining: the extension headers
are hashed for use in the End of Index Entries (EOIE) extension. This
use of the git_hash_ctx is left as-is. There are multiple reasons to not
use a hashfile here, including the fact that the data is not actually
writing to a file, just a hash computation. These hashes do not block
our adoption of the chunk-format API in a future change to the index, so
leave it as-is.

The internals of the algorithms are mostly identical. Previously, the
hashfile API used a smaller 8KB buffer instead of the 128KB buffer from
read-cache.c. The previous change already unified these sizes.

There is one subtle point: we do not pass the CSUM_FSYNC to the
finalize_hashfile() method, which differs from most consumers of the
hashfile API. The extra fsync() call indicated by this flag causes a
significant peformance degradation that is noticeable for quick
commands that write the index, such as "git add". Other consumers can
absorb this cost with their more complicated data structure
organization, and further writing structures such as pack-files and
commit-graphs is rarely in the critical path for common user
interactions.

Some static methods become orphaned in this diff, so I marked them as
MAYBE_UNUSED. The diff is much harder to read if they are deleted during
this change. Instead, they will be deleted in the following change.

In addition to the test suite passing, I computed indexes using the
previous binaries and the binaries compiled after this change, and found
the index data to be exactly equal. Finally, I did extensive performance
testing of "git update-index --force-write" on repos of various sizes,
including one with over 2 million paths at HEAD. These tests
demonstrated less than 1% difference in behavior. As expected, the
performance should be considered unchanged. The previous changes to
increase the hashfile buffer size from 8K to 128K ensured this change
would not create a peformance regression.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 137 +++++++++++++++++++++++++--------------------------
 1 file changed, 66 insertions(+), 71 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fbf3a4ce7d5d..1c0bda81e7e7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -26,6 +26,7 @@
 #include "thread-utils.h"
 #include "progress.h"
 #include "sparse-index.h"
+#include "csum-file.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -2519,6 +2520,7 @@ int repo_index_has_changes(struct repository *repo,
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
 static unsigned long write_buffer_len;
 
+MAYBE_UNUSED
 static int ce_write_flush(git_hash_ctx *context, int fd)
 {
 	unsigned int buffered = write_buffer_len;
@@ -2531,6 +2533,7 @@ static int ce_write_flush(git_hash_ctx *context, int fd)
 	return 0;
 }
 
+MAYBE_UNUSED
 static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 {
 	while (len) {
@@ -2553,19 +2556,24 @@ static int ce_write(git_hash_ctx *context, int fd, void *data, unsigned int len)
 	return 0;
 }
 
-static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
-				  int fd, unsigned int ext, unsigned int sz)
+static int write_index_ext_header(struct hashfile *f,
+				  git_hash_ctx *eoie_f,
+				  unsigned int ext,
+				  unsigned int sz)
 {
-	ext = htonl(ext);
-	sz = htonl(sz);
-	if (eoie_context) {
-		the_hash_algo->update_fn(eoie_context, &ext, 4);
-		the_hash_algo->update_fn(eoie_context, &sz, 4);
+	hashwrite_be32(f, ext);
+	hashwrite_be32(f, sz);
+
+	if (eoie_f) {
+		ext = htonl(ext);
+		sz = htonl(sz);
+		the_hash_algo->update_fn(eoie_f, &ext, sizeof(ext));
+		the_hash_algo->update_fn(eoie_f, &sz, sizeof(sz));
 	}
-	return ((ce_write(context, fd, &ext, 4) < 0) ||
-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
+	return 0;
 }
 
+MAYBE_UNUSED
 static int ce_flush(git_hash_ctx *context, int fd, unsigned char *hash)
 {
 	unsigned int left = write_buffer_len;
@@ -2667,11 +2675,10 @@ static void copy_cache_entry_to_ondisk(struct ondisk_cache_entry *ondisk,
 	}
 }
 
-static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
+static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
 {
 	int size;
-	int result;
 	unsigned int saved_namelen;
 	int stripped_name = 0;
 	static unsigned char padding[8] = { 0x00 };
@@ -2687,11 +2694,9 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 	if (!previous_name) {
 		int len = ce_namelen(ce);
 		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
-		if (!result)
-			result = ce_write(c, fd, ce->name, len);
-		if (!result)
-			result = ce_write(c, fd, padding, align_padding_size(size, len));
+		hashwrite(f, ondisk, size);
+		hashwrite(f, ce->name, len);
+		hashwrite(f, padding, align_padding_size(size, len));
 	} else {
 		int common, to_remove, prefix_size;
 		unsigned char to_remove_vi[16];
@@ -2705,13 +2710,10 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		prefix_size = encode_varint(to_remove, to_remove_vi);
 
 		copy_cache_entry_to_ondisk(ondisk, ce);
-		result = ce_write(c, fd, ondisk, size);
-		if (!result)
-			result = ce_write(c, fd, to_remove_vi, prefix_size);
-		if (!result)
-			result = ce_write(c, fd, ce->name + common, ce_namelen(ce) - common);
-		if (!result)
-			result = ce_write(c, fd, padding, 1);
+		hashwrite(f, ondisk, size);
+		hashwrite(f, to_remove_vi, prefix_size);
+		hashwrite(f, ce->name + common, ce_namelen(ce) - common);
+		hashwrite(f, padding, 1);
 
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
@@ -2721,7 +2723,7 @@ static int ce_write_entry(git_hash_ctx *c, int fd, struct cache_entry *ce,
 		ce->ce_flags &= ~CE_STRIP_NAME;
 	}
 
-	return result;
+	return 0;
 }
 
 /*
@@ -2833,8 +2835,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
 	uint64_t start = getnanotime();
-	int newfd = tempfile->fd;
-	git_hash_ctx c, eoie_c;
+	struct hashfile *f;
+	git_hash_ctx *eoie_c = NULL;
 	struct cache_header hdr;
 	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
@@ -2848,6 +2850,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
 
+	f = hashfd(tempfile->fd, tempfile->filename.buf);
+
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
 			removed++;
@@ -2876,9 +2880,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	hdr.hdr_version = htonl(hdr_version);
 	hdr.hdr_entries = htonl(entries - removed);
 
-	the_hash_algo->init_fn(&c);
-	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
-		return -1;
+	hashwrite(f, &hdr, sizeof(hdr));
 
 	if (!HAVE_THREADS || git_config_get_index_threads(&nr_threads))
 		nr_threads = 1;
@@ -2913,12 +2915,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		}
 	}
 
-	offset = lseek(newfd, 0, SEEK_CUR);
-	if (offset < 0) {
-		free(ieot);
-		return -1;
-	}
-	offset += write_buffer_len;
+	offset = hashfile_total(f);
+
 	nr = 0;
 	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
 
@@ -2953,14 +2951,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			if (previous_name)
 				previous_name->buf[0] = 0;
 			nr = 0;
-			offset = lseek(newfd, 0, SEEK_CUR);
-			if (offset < 0) {
-				free(ieot);
-				return -1;
-			}
-			offset += write_buffer_len;
+
+			offset = hashfile_total(f);
 		}
-		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
+		if (ce_write_entry(f, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
 			err = -1;
 
 		if (err)
@@ -2979,14 +2973,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return err;
 	}
 
-	/* Write extension data here */
-	offset = lseek(newfd, 0, SEEK_CUR);
-	if (offset < 0) {
-		free(ieot);
-		return -1;
+	offset = hashfile_total(f);
+
+	/*
+	 * The extension headers must be hashed on their own for the
+	 * EOIE extension. Create a hashfile here to compute that hash.
+	 */
+	if (offset && record_eoie()) {
+		CALLOC_ARRAY(eoie_c, 1);
+		the_hash_algo->init_fn(eoie_c);
 	}
-	offset += write_buffer_len;
-	the_hash_algo->init_fn(&eoie_c);
 
 	/*
 	 * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
@@ -2999,8 +2995,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		free(ieot);
 		if (err)
@@ -3012,9 +3008,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		err = write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
-					       sb.len) < 0 ||
-			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
+					       sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3023,8 +3019,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		cache_tree_write(&sb, istate->cache_tree);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3033,9 +3029,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UNDO,
-					     sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
+					     sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3044,9 +3040,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_untracked_extension(&sb, istate->untracked);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
-					     sb.len) < 0 ||
-			ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
+					     sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
@@ -3055,14 +3051,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		struct strbuf sb = STRBUF_INIT;
 
 		write_fsmonitor_extension(&sb, istate);
-		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		err = write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
 	if (istate->sparse_index) {
-		if (write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
+		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
 			return -1;
 	}
 
@@ -3072,19 +3068,18 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * read.  Write it out regardless of the strip_extensions parameter as we need it
 	 * when loading the shared index.
 	 */
-	if (offset && record_eoie()) {
+	if (eoie_c) {
 		struct strbuf sb = STRBUF_INIT;
 
-		write_eoie_extension(&sb, &eoie_c, offset);
-		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
-			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		write_eoie_extension(&sb, eoie_c, offset);
+		err = write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
+		hashwrite(f, sb.buf, sb.len);
 		strbuf_release(&sb);
 		if (err)
 			return -1;
 	}
 
-	if (ce_flush(&c, newfd, istate->oid.hash))
-		return -1;
+	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
-- 
gitgitgadget

