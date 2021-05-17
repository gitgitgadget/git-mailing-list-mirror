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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D4C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D98761244
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhEQM0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbhEQM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:26:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4CC061756
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i17so6158737wrq.11
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mL3VTJcZRgjHjWnseSbPBgNW4A9nsJStj0QoIQD9lIo=;
        b=XVqUU5HL3qSQtfIJqBKLAAFsy+2dXOjamlfjPUcE6T8T1u3cCvZz302AMQ5f6bXSDQ
         8u1FZ7ZBBWMCZY8bhU+iL+gL2CDLz5219PwNWUWH2p3JLUumBQR1vOFXrzolAjI7vzfE
         XquR8RGQTd4MaNcODlCgB0AeUSdLpp+EyA5AebnVViAGGut3t9U3lVicwyOEO9Cd+1Is
         VVIJVSPRrI4ALHq4wNDLpATWYJjJ26YO+2n4ymlnLpMabKGMX0iNK1K/3ijxCedrO/sC
         /6g0Nw4Jev3efCGMryMZIg1EvTAkUogRUMYAoQiOpiDpEghByYJNJhqcGUeBUzq8pYN/
         uJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mL3VTJcZRgjHjWnseSbPBgNW4A9nsJStj0QoIQD9lIo=;
        b=fkToVfO6rTbkSy1x3+W5XwR54BeIdIJEwFGr4eS/qYzYnn97Ng1z+57zSUS4rAO/G2
         ftqgeLypvysq2ZSG+KE28nS85PL7EkwJ8azCD0Vm4e6+VKU1YuD0c1nTBwnzyBH/D3Pp
         3uPPXhLjCIoEtWaQrK05g9xO9CgrBLmpYFSKBbKXoEc8CpM1oyIIwfhpcq3I3cNtF+PJ
         lJ2OsTfwuG4TllRJ/mhji0S3y3KbwSoX7ZqfSwQKkzo/M8JfDe2JsxM6KeT6UGF2d1yU
         auPhhOFuiu7tLuRrdPGhO9ktd0PbHfV3YWND4ClqwA+mEhvOJWyOJjN0jlcyvl0mJ0+5
         MwaA==
X-Gm-Message-State: AOAM533UktgrUnmREjFGsxEe2MM3QEqjoqO0cUi+QZwz0Ve2M7Myzs4x
        iD1NDTvmR4QulAXsPeV7Nu5hP0RtIYI=
X-Google-Smtp-Source: ABdhPJyyC3ZDhi3R8qQu9mErfTCqP9KyVhokJhgNnVU3W4Unob14XqFR/+taoQH4Xd/wBEcDcSJrwQ==
X-Received: by 2002:adf:e589:: with SMTP id l9mr5494244wrm.361.1621254295372;
        Mon, 17 May 2021 05:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm16439321wry.60.2021.05.17.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:24:55 -0700 (PDT)
Message-Id: <b94172ccf5e91fe59a1d32774dbec23e624f1135.1621254292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:24:51 +0000
Subject: [PATCH v2 3/4] read-cache: use hashfile instead of git_hash_ctx
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
mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
unify the index writing code to use the same mechanism.

I discovered this disparity while trying to create a new index format
that uses the chunk-format API. That API uses a hashfile as its base, so
it is incompatible with the custom code in read-cache.c.

This rewrite is rather straightforward. It replaces all writes to the
temporary file with writes to the hashfile struct. This takes care of
many of the direct interactions with the_hash_algo.

There are still some remaining: the extension headers are hashed for use
in the End of Index Entries (EOIE) extension. This use of the
git_hash_ctx is left as-is. There are multiple reasons to not use a
hashfile here, including the fact that the data is not actually writing
to a file, just a hash computation. These hashes do not block our
adoption of the chunk-format API in a future change to the index, so
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
demonstrated less than 1% difference in behavior, so the performance
should be considered identical.

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

