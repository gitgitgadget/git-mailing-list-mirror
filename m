Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06D9C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC68861244
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhEQM0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhEQM0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:26:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BC1C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so5064135wmk.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4bg0R8N6S6s6x2otYlP0S5VZkB9kCj3ykEX6BXTEkTI=;
        b=GzU2+I4cUp/Ri4a7WhEl1bOExZX6kJYeYCNepQkuKToruDA+2HIpcRJhXgxMWZtLTU
         2Q8wQQL+VR+mEyJpOSp6nGDHT5cQqcjV16hc6T25exU7km/3oYpVusGQi0v+YNifD1IJ
         AkbrqHCfQymo8fw04hwXtAvL+e8efC4+8CvHuKGUqBDLfD+DF8LNM4oz/JsUEyTQrp3v
         N2zDTXz9kqm5J5lnMPJclcAu9Hv2//K/lYzT6EzX2Z+wJ61xfnR4fMwsMGOFSvlPQwRR
         fMzprnU5oby8YoRBya2saNvyt725KfMXBF+JKWt4E76u9GPZz4PDBjVqC2smBuUyQ31g
         ufcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4bg0R8N6S6s6x2otYlP0S5VZkB9kCj3ykEX6BXTEkTI=;
        b=gDsqrEUEyZCXnNG57sfilMC7u5Egq3DDES7jzSU9eMUyUXl+cuvn+dAdpkSOoNlGqY
         QfsCL/BdMHh7eZ0Zy0+YTnuzhSgSgsRHNtX1lXvpbO7Rvd4SRzYudM3bHkMBD8N97H4p
         NMb1GZLEnH8Q/BCjYFa+D3BZJb4pWTYnSdR9mTYWIcF9j9gPNITt0fy9S2uipxxTYKXr
         gBj2qj6TzpO6hiJTbrgWHhoUjdB0MiP8NteKWKji6elcIUiIDxlXkmPFMFvhu0Rq0ypF
         QgY9Xm33zQT3yr2i/WHWR3LOMGkAXK9D3uMXYeq+tQgA4LLG5ywty28BgeG6QQn1Av5S
         uadg==
X-Gm-Message-State: AOAM530cFlKANHqLdyFdsdF139GBBl/3T5YSk3jTB/Um5RqUUhRV9ZCr
        +mfU7w7lLvY80SW5DJj0M62b8mdT4ow=
X-Google-Smtp-Source: ABdhPJxic8a90i80EqadPeCI/sHnd3CmEJIyMi/8Mvi+3rRBDZrzS3aROtMHjqHLnEOT6hKKHmrNog==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr22899146wmk.183.1621254293660;
        Mon, 17 May 2021 05:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm17420649wrs.50.2021.05.17.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:24:53 -0700 (PDT)
Message-Id: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.git.1616785928.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:24:48 +0000
Subject: [PATCH v2 0/4] Convert index writes to use hashfile API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I prepare some ideas on index v5, one thing that strikes me as an
interesting direction to try is to use the chunk-format API. This would make
our extension model extremely simple (they become optional chunks, easily
identified by the table of contents).

But there is a huge hurdle to even starting that investigation: the index
uses its own hashing methods, separate from the hashfile API in csum-file.c!

The internals of the algorithms are mostly identical. The only possible
change is that the buffer sizes are different: 8KB for hashfile and 128KB in
read-cache.c. This change is actually relatively recent! I was able to see a
performance difference before changing that size, so I do make them equal.
This improves some other commands, too, such as git multi-pack-index write.

There is a subtle point about how the EOIE extension works in that it needs
a hash of just the previous extension headers. This won't be needed by the
chunk-format API, so leave this mostly as-is, except where it collides
somewhat with the hashfile changes.


Updates in v2
=============

 * Sorry for the false start on v1. I'm correctly testing index writes this
   time, but I also verified other commands, such as "git add .", to be sure
   I was exercising everything. I also previously had incorrect assumptions
   about the EOIE extension, since it is not triggered with "small" repos
   like the Linux kernel repository ;).

 * This version is rebased onto a recent version of 'master' so the
   conflicts with ds/sparse-index-protections are resolved.

 * This version abandons the nested hashfile concept, since that was only
   needed for the incorrect interpretation of the EOIE extension's hash.

 * This version does unify the buffer size to 128 KB with justification.

 * There is also some more unification of writing logic to use
   write_in_full() in the hashfile API.

 * When using check_fd, the hashfile API is no longer thread safe due to a
   stack-allocated buffer moving to the global scope. I'm not sure if there
   is a better way to handle this case.

Thanks, -Stolee

Derrick Stolee (4):
  hashfile: use write_in_full()
  csum-file.h: increase hashfile buffer size
  read-cache: use hashfile instead of git_hash_ctx
  read-cache: delete unused hashing methods

 chunk-format.c |  12 ++--
 csum-file.c    |  45 ++++++------
 csum-file.h    |   4 +-
 read-cache.c   | 191 ++++++++++++++++---------------------------------
 4 files changed, 94 insertions(+), 158 deletions(-)


base-commit: 97eea85a0a1ec66d356567808a1e4ca2367e0ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-916%2Fderrickstolee%2Findex-hashfile-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-916/derrickstolee/index-hashfile-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/916

Range-diff vs v1:

 -:  ------------ > 1:  b3e578ac0365 hashfile: use write_in_full()
 1:  0eca529766fc ! 2:  9dc602f6c422 csum-file: add nested_hashfile()
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    csum-file: add nested_hashfile()
     +    csum-file.h: increase hashfile buffer size
      
     -    The index writing code in do_write_index() uses a custom set of hashing
     -    code, in part because it was introduced before the hashfile API. But
     -    also, the End of Index Entries extension computes a hash of just the
     -    extension data, not the entire file preceding that extension.
     +    The hashfile API uses a hard-coded buffer size of 8KB and has ever since
     +    it was introduced in c38138c (git-pack-objects: write the pack files
     +    with a SHA1 csum, 2005-06-26). It performs a similar function to the
     +    hashing buffers in read-cache.c, but that code was updated from 8KB to
     +    128KB in f279894 (read-cache: make the index write buffer size 128K,
     +    2021-02-18). The justification there was that do_write_index() improves
     +    from 1.02s to 0.72s.
      
     -    Before converting the index writing code to use the hashfile API, create
     -    a concept of a "nested hashfile". By adding a 'base' member to 'struct
     -    hashfile', we indicate that any writes to this hashfile should be passed
     -    along to the base hashfile, too.
     +    There is a buffer, check_buffer, that is used to verify the check_fd
     +    file descriptor. When this buffer increases to 128K to fit the data
     +    being flushed, it causes the stack to overflow the limits placed in the
     +    test suite. By moving this to a static buffer, we stop using stack data
     +    for this purpose, but we lose some thread-safety. This change makes it
     +    unsafe to write to multiple hashfiles across different threads.
      
     -    In the next change, the index code will use this to create a new
     -    hashfile wose base is the hashfile for the index. The outer hashfile
     -    will compute the hash just for the extension details. Thus, it will
     -    finalize earlier than the base hashfile, hence there is no modification
     -    to finalize_hashfile() here.
     +    By adding a new trace2 region in the chunk-format API, we can see that
     +    the writing portion of 'git multi-pack-index write' lowers from ~1.49s
     +    to ~1.47s on a Linux machine. These effects may be more pronounced or
     +    diminished on other filesystems. The end-to-end timing is too noisy to
     +    have a definitive change either way.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## csum-file.c ##
     -@@
     + ## chunk-format.c ##
     +@@ chunk-format.c: void add_chunk(struct chunkfile *cf,
       
     - static void flush(struct hashfile *f, const void *buf, unsigned int count)
     + int write_chunkfile(struct chunkfile *cf, void *data)
       {
     -+	if (f->base)
     -+		return;
     +-	int i;
     ++	int i, result = 0;
     + 	uint64_t cur_offset = hashfile_total(cf->f);
     + 
     ++	trace2_region_enter("chunkfile", "write", the_repository);
      +
     - 	if (0 <= f->check_fd && count)  {
     - 		unsigned char check_buffer[8192];
     - 		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
     -@@ csum-file.c: void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
     - 		}
     - 		f->offset = offset;
     + 	/* Add the table of contents to the current offset */
     + 	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
     + 
     +@@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
     + 
     + 	for (i = 0; i < cf->chunks_nr; i++) {
     + 		off_t start_offset = hashfile_total(cf->f);
     +-		int result = cf->chunks[i].write_fn(cf->f, data);
     ++		result = cf->chunks[i].write_fn(cf->f, data);
     + 
     + 		if (result)
     +-			return result;
     ++			goto cleanup;
     + 
     + 		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
     + 			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
     +@@ chunk-format.c: int write_chunkfile(struct chunkfile *cf, void *data)
     + 			    hashfile_total(cf->f) - start_offset);
       	}
     -+
     -+	if (f->base)
     -+		hashwrite(f->base, buf, count);
     - }
       
     - struct hashfile *hashfd(int fd, const char *name)
     -@@ csum-file.c: struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
     - 	f->name = name;
     - 	f->do_crc = 0;
     - 	the_hash_algo->init_fn(&f->ctx);
     -+	f->base = NULL;
     - 	return f;
     +-	return 0;
     ++cleanup:
     ++	trace2_region_leave("chunkfile", "write", the_repository);
     ++	return result;
       }
       
     -@@ csum-file.c: uint32_t crc32_end(struct hashfile *f)
     - 	f->do_crc = 0;
     - 	return f->crc32;
     - }
     -+
     -+struct hashfile *nested_hashfile(struct hashfile *f)
     + int read_table_of_contents(struct chunkfile *cf,
     +
     + ## csum-file.c ##
     +@@
     + #include "progress.h"
     + #include "csum-file.h"
     + 
     ++static void verify_buffer_or_die(struct hashfile *f,
     ++				 const void *buf,
     ++				 unsigned int count)
      +{
     -+	struct hashfile *n = xmalloc(sizeof(*f));
     -+	n->fd = -1;
     -+	n->check_fd = -1;
     -+	n->offset = 0;
     -+	n->total = 0;
     -+	n->tp = NULL;
     -+	n->name = NULL;
     -+	n->do_crc = 0;
     -+	the_hash_algo->init_fn(&n->ctx);
     -+	n->base = f;
     -+	return n;
     ++	static unsigned char check_buffer[WRITE_BUFFER_SIZE];
     ++	ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
     ++
     ++	if (ret < 0)
     ++		die_errno("%s: sha1 file read error", f->name);
     ++	if (ret != count)
     ++		die("%s: sha1 file truncated", f->name);
     ++	if (memcmp(buf, check_buffer, count))
     ++		die("sha1 file '%s' validation error", f->name);
      +}
     ++
     + static void flush(struct hashfile *f, const void *buf, unsigned int count)
     + {
     +-	if (0 <= f->check_fd && count)  {
     +-		unsigned char check_buffer[8192];
     +-		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
     +-
     +-		if (ret < 0)
     +-			die_errno("%s: sha1 file read error", f->name);
     +-		if (ret != count)
     +-			die("%s: sha1 file truncated", f->name);
     +-		if (memcmp(buf, check_buffer, count))
     +-			die("sha1 file '%s' validation error", f->name);
     +-	}
     ++	if (0 <= f->check_fd && count)
     ++		verify_buffer_or_die(f, buf, count);
     + 
     + 	if (write_in_full(f->fd, buf, count) < 0) {
     + 		if (errno == ENOSPC)
      
       ## csum-file.h ##
     +@@
     + 
     + struct progress;
     + 
     ++#define WRITE_BUFFER_SIZE (128 * 1024)
     ++
     + /* A SHA1-protected file */
     + struct hashfile {
     + 	int fd;
      @@ csum-file.h: struct hashfile {
       	const char *name;
       	int do_crc;
       	uint32_t crc32;
     -+	struct hashfile *base;
     - 	unsigned char buffer[8192];
     +-	unsigned char buffer[8192];
     ++	unsigned char buffer[WRITE_BUFFER_SIZE];
       };
       
     -@@ csum-file.h: void hashflush(struct hashfile *f);
     - void crc32_begin(struct hashfile *);
     - uint32_t crc32_end(struct hashfile *);
     - 
     -+/*
     -+ * A nested hashfile uses the same interface as a hashfile, and computes
     -+ * a hash for the input bytes while passing them to the base hashfile
     -+ * instead of writing them to its own file. This is useful for computing
     -+ * a hash of a region within a file during the write.
     -+ */
     -+struct hashfile *nested_hashfile(struct hashfile *f);
     -+
     - /*
     -  * Returns the total number of bytes fed to the hashfile so far (including ones
     -  * that have not been written out to the descriptor yet).
     + /* Checkpoint */
 2:  e2611bbc007a ! 3:  b94172ccf5e9 read-cache: use hashfile instead of git_hash_ctx
     @@ Commit message
          that uses the chunk-format API. That API uses a hashfile as its base, so
          it is incompatible with the custom code in read-cache.c.
      
     -    This rewrite of the logic is rather straightforward, except for the
     -    special case of creating a nested hashfile to handle computing the hash
     -    of the extension data just for the End of Index Entries extension. The
     -    previous change introduced the concept for just this purpose.
     +    This rewrite is rather straightforward. It replaces all writes to the
     +    temporary file with writes to the hashfile struct. This takes care of
     +    many of the direct interactions with the_hash_algo.
      
     -    The internals of the algorithms are mostly identical. The only
     -    meaningful change is that the buffer sizes are different: 8KB for
     -    hashfile and 128KB in read-cache.c. I was unable to find a performance
     -    difference in these two implementations, despite testing on several repo
     -    sizes. I also tried adjusting the buffer size of the hashfile struct for
     -    a variety of sizes between 8KB and 128KB, and did not see a performance
     -    change for any of the commands that currently use hashfiles.
     +    There are still some remaining: the extension headers are hashed for use
     +    in the End of Index Entries (EOIE) extension. This use of the
     +    git_hash_ctx is left as-is. There are multiple reasons to not use a
     +    hashfile here, including the fact that the data is not actually writing
     +    to a file, just a hash computation. These hashes do not block our
     +    adoption of the chunk-format API in a future change to the index, so
     +    leave it as-is.
     +
     +    The internals of the algorithms are mostly identical. Previously, the
     +    hashfile API used a smaller 8KB buffer instead of the 128KB buffer from
     +    read-cache.c. The previous change already unified these sizes.
     +
     +    There is one subtle point: we do not pass the CSUM_FSYNC to the
     +    finalize_hashfile() method, which differs from most consumers of the
     +    hashfile API. The extra fsync() call indicated by this flag causes a
     +    significant peformance degradation that is noticeable for quick
     +    commands that write the index, such as "git add". Other consumers can
     +    absorb this cost with their more complicated data structure
     +    organization, and further writing structures such as pack-files and
     +    commit-graphs is rarely in the critical path for common user
     +    interactions.
      
          Some static methods become orphaned in this diff, so I marked them as
          MAYBE_UNUSED. The diff is much harder to read if they are deleted during
     @@ Commit message
          In addition to the test suite passing, I computed indexes using the
          previous binaries and the binaries compiled after this change, and found
          the index data to be exactly equal. Finally, I did extensive performance
     -    testing of "git update-index --really-refresh" on repos of various
     -    sizes, including one with over 2 million paths at HEAD. These tests
     +    testing of "git update-index --force-write" on repos of various sizes,
     +    including one with over 2 million paths at HEAD. These tests
          demonstrated less than 1% difference in behavior, so the performance
          should be considered identical.
      
     @@ Commit message
      
       ## read-cache.c ##
      @@
     - #include "fsmonitor.h"
       #include "thread-utils.h"
       #include "progress.h"
     + #include "sparse-index.h"
      +#include "csum-file.h"
       
       /* Mask for the name length in ce_flags in the on-disk index */
       
     -@@ read-cache.c: static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
     - static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
     - 
     - static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
     --static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
     -+static void write_eoie_extension(struct strbuf *sb, const unsigned char *hash, size_t offset);
     - 
     - struct load_index_extensions
     - {
      @@ read-cache.c: int repo_index_has_changes(struct repository *repo,
       static unsigned char write_buffer[WRITE_BUFFER_SIZE];
       static unsigned long write_buffer_len;
     @@ read-cache.c: static int ce_write(git_hash_ctx *context, int fd, void *data, uns
       
      -static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoie_context,
      -				  int fd, unsigned int ext, unsigned int sz)
     -+static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned int sz)
     ++static int write_index_ext_header(struct hashfile *f,
     ++				  git_hash_ctx *eoie_f,
     ++				  unsigned int ext,
     ++				  unsigned int sz)
       {
      -	ext = htonl(ext);
      -	sz = htonl(sz);
      -	if (eoie_context) {
      -		the_hash_algo->update_fn(eoie_context, &ext, 4);
      -		the_hash_algo->update_fn(eoie_context, &sz, 4);
     --	}
     --	return ((ce_write(context, fd, &ext, 4) < 0) ||
     --		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
      +	hashwrite_be32(f, ext);
      +	hashwrite_be32(f, sz);
     ++
     ++	if (eoie_f) {
     ++		ext = htonl(ext);
     ++		sz = htonl(sz);
     ++		the_hash_algo->update_fn(eoie_f, &ext, sizeof(ext));
     ++		the_hash_algo->update_fn(eoie_f, &sz, sizeof(sz));
     + 	}
     +-	return ((ce_write(context, fd, &ext, 4) < 0) ||
     +-		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
      +	return 0;
       }
       
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       	uint64_t start = getnanotime();
      -	int newfd = tempfile->fd;
      -	git_hash_ctx c, eoie_c;
     -+	struct hashfile *f, *eoie_f;
     ++	struct hashfile *f;
     ++	git_hash_ctx *eoie_c = NULL;
       	struct cache_header hdr;
       	int i, err = 0, removed, extended, hdr_version;
       	struct cache_entry **cache = istate->cache;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       	}
       
      -	offset = lseek(newfd, 0, SEEK_CUR);
     -+	offset = lseek(f->fd, 0, SEEK_CUR);
     - 	if (offset < 0) {
     - 		free(ieot);
     - 		return -1;
     - 	}
     +-	if (offset < 0) {
     +-		free(ieot);
     +-		return -1;
     +-	}
      -	offset += write_buffer_len;
     ++	offset = hashfile_total(f);
      +
       	nr = 0;
       	previous_name = (hdr_version == 4) ? &previous_name_buf : NULL;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       				previous_name->buf[0] = 0;
       			nr = 0;
      -			offset = lseek(newfd, 0, SEEK_CUR);
     -+
     -+			offset = lseek(f->fd, 0, SEEK_CUR);
     - 			if (offset < 0) {
     - 				free(ieot);
     - 				return -1;
     - 			}
     +-			if (offset < 0) {
     +-				free(ieot);
     +-				return -1;
     +-			}
      -			offset += write_buffer_len;
     ++
     ++			offset = hashfile_total(f);
       		}
      -		if (ce_write_entry(&c, newfd, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
      +		if (ce_write_entry(f, ce, previous_name, (struct ondisk_cache_entry *)&ondisk) < 0)
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       
      -	/* Write extension data here */
      -	offset = lseek(newfd, 0, SEEK_CUR);
     -+	offset = lseek(f->fd, 0, SEEK_CUR);
     - 	if (offset < 0) {
     - 		free(ieot);
     - 		return -1;
     - 	}
     --	offset += write_buffer_len;
     --	the_hash_algo->init_fn(&eoie_c);
     +-	if (offset < 0) {
     +-		free(ieot);
     +-		return -1;
     ++	offset = hashfile_total(f);
      +
      +	/*
     -+	 * The extensions must be hashed on their own for use in the EOIE
     -+	 * extension. Use a nested hashfile to compute the hash for this
     -+	 * region while passing the buffer to the original hashfile.
     ++	 * The extension headers must be hashed on their own for the
     ++	 * EOIE extension. Create a hashfile here to compute that hash.
      +	 */
     -+	if (offset && record_eoie())
     -+		eoie_f = nested_hashfile(f);
     -+	else
     -+		eoie_f = f;
     ++	if (offset && record_eoie()) {
     ++		CALLOC_ARRAY(eoie_c, 1);
     ++		the_hash_algo->init_fn(eoie_c);
     + 	}
     +-	offset += write_buffer_len;
     +-	the_hash_algo->init_fn(&eoie_c);
       
       	/*
       	 * Lets write out CACHE_EXT_INDEXENTRYOFFSETTABLE first so that we
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       		write_ieot_extension(&sb, ieot);
      -		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0
      -			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		err = write_index_ext_header(eoie_f, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		err = write_index_ext_header(f, eoie_c, CACHE_EXT_INDEXENTRYOFFSETTABLE, sb.len) < 0;
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		free(ieot);
       		if (err)
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
      -			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
      -					       sb.len) < 0 ||
      -			ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+			write_index_ext_header(eoie_f, CACHE_EXT_LINK,
     ++			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
      +					       sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
       			return -1;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       		cache_tree_write(&sb, istate->cache_tree);
      -		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.len) < 0
      -			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		err = write_index_ext_header(eoie_f, CACHE_EXT_TREE, sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		err = write_index_ext_header(f, eoie_c, CACHE_EXT_TREE, sb.len) < 0;
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
       			return -1;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
      -		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UNDO,
      -					     sb.len) < 0
      -			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		err = write_index_ext_header(eoie_f, CACHE_EXT_RESOLVE_UNDO,
     ++		err = write_index_ext_header(f, eoie_c, CACHE_EXT_RESOLVE_UNDO,
      +					     sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
       			return -1;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
      -		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
      -					     sb.len) < 0 ||
      -			ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		err = write_index_ext_header(eoie_f, CACHE_EXT_UNTRACKED,
     ++		err = write_index_ext_header(f, eoie_c, CACHE_EXT_UNTRACKED,
      +					     sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
       			return -1;
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       		write_fsmonitor_extension(&sb, istate);
      -		err = write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, sb.len) < 0
      -			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		err = write_index_ext_header(eoie_f, CACHE_EXT_FSMONITOR, sb.len) < 0;
     -+		hashwrite(eoie_f, sb.buf, sb.len);
     ++		err = write_index_ext_header(f, eoie_c, CACHE_EXT_FSMONITOR, sb.len) < 0;
     ++		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
       			return -1;
     + 	}
     + 	if (istate->sparse_index) {
     +-		if (write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
     ++		if (write_index_ext_header(f, eoie_c, CACHE_EXT_SPARSE_DIRECTORIES, 0) < 0)
     + 			return -1;
     + 	}
     + 
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
       	 * read.  Write it out regardless of the strip_extensions parameter as we need it
       	 * when loading the shared index.
       	 */
      -	if (offset && record_eoie()) {
     -+	if (f != eoie_f) {
     ++	if (eoie_c) {
       		struct strbuf sb = STRBUF_INIT;
     -+		unsigned char hash[GIT_MAX_RAWSZ];
       
      -		write_eoie_extension(&sb, &eoie_c, offset);
      -		err = write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0
      -			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
     -+		finalize_hashfile(eoie_f, hash, 0);
     -+
     -+		write_eoie_extension(&sb, hash, offset);
     -+		err = write_index_ext_header(f, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
     ++		write_eoie_extension(&sb, eoie_c, offset);
     ++		err = write_index_ext_header(f, NULL, CACHE_EXT_ENDOFINDEXENTRIES, sb.len) < 0;
      +		hashwrite(f, sb.buf, sb.len);
       		strbuf_release(&sb);
       		if (err)
     @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempf
       
      -	if (ce_flush(&c, newfd, istate->oid.hash))
      -		return -1;
     -+	finalize_hashfile(f, istate->oid.hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
     ++	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
       	if (close_tempfile_gently(tempfile)) {
       		error(_("could not close '%s'"), get_tempfile_path(tempfile));
       		return -1;
     -@@ read-cache.c: static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
     - 	return offset;
     - }
     - 
     --static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset)
     -+static void write_eoie_extension(struct strbuf *sb, const unsigned char *hash, size_t offset)
     - {
     - 	uint32_t buffer;
     --	unsigned char hash[GIT_MAX_RAWSZ];
     - 
     - 	/* offset */
     - 	put_be32(&buffer, offset);
     - 	strbuf_add(sb, &buffer, sizeof(uint32_t));
     - 
     - 	/* hash */
     --	the_hash_algo->final_fn(hash, eoie_context);
     - 	strbuf_add(sb, hash, the_hash_algo->rawsz);
     - }
     - 
 3:  e2d5a8dc919b ! 4:  4b3814eb4c80 read-cache: delete unused hashing methods
     @@ read-cache.c: int repo_index_has_changes(struct repository *repo,
      -	return 0;
      -}
      -
     - static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned int sz)
     - {
     - 	hashwrite_be32(f, ext);
     -@@ read-cache.c: static int write_index_ext_header(struct hashfile *f, unsigned int ext, unsigned
     + static int write_index_ext_header(struct hashfile *f,
     + 				  git_hash_ctx *eoie_f,
     + 				  unsigned int ext,
     +@@ read-cache.c: static int write_index_ext_header(struct hashfile *f,
       	return 0;
       }
       

-- 
gitgitgadget
