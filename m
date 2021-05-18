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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5CC43460
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3835761261
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351595AbhERSeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351609AbhERSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:34:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E18C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so11343949wrr.2
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=neRP/8nSp8b7/KPPMAA10cYSsPHWlz+ezNEHLDx0TXc=;
        b=HN8Wz7HJAo2maknmlr1OTnjHBb1L85OaqRYLVGuCK07sX8lBGse1xPxRzfiAQwR+Ns
         EXBp1Kn4SZRGKAz4AZrDyJ4nUyQCQCwuDF5iSB8TsKZd1RaVTcm5V9DnQ5uPEO5GBfKQ
         /Mm/cwJdBIIv8A1uRDWy6BPgFJaLY8JwPO3cy0iIMXHib5GnpiIZ0X4yfkYBjo5TUDSM
         St7zpXdLmDpp3YMTPJrXMjbuWweebl+U1NTQ5AVQgQxTpltnQziXRqlGeKEcC72G8aUb
         k91NK5sRtYckJhRlzN9CcZNwefcAnPxnSE5XzbTxC98AW4YR90PuELzR95HLFv3ea8ZM
         cLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=neRP/8nSp8b7/KPPMAA10cYSsPHWlz+ezNEHLDx0TXc=;
        b=pfeu9nWNG0yCLK5HvKqV2Ul9UlQ+T9Gzgf55AnqJXgheiVd+WAAavbKSLrVxrZeaal
         x3oIoewHUdcUDQExWVifHWCiHq+vGhXtDwnfx5dAwGc6IDtMtOpFy3EHzckmu5jmvGiy
         0PQLvxdefsBgsUqinJBdRmFstyMteooL1XZwuJfStWFxslI8LEX4cBZVbPcjqkWsTpCj
         SPnVBDaQOUTT9x31Ho7Tf87uyC/J5e6dPNHg2kUgoCwicY47Uqd8YxFaQREh8YG9yQ7b
         lLbeMdJ43TXFwG2RqW1shFuGE7to/DLUcZc5FvIoHbhkuEb5FXx74tPnKQB2/cuCk8Lg
         gQsQ==
X-Gm-Message-State: AOAM532kELal2cjerbawxJMAH/lK4qOEyvvQ72tmFlyfDG2+3dt4EO1d
        KbWmzO11WUVp1ANFhmHFHc5RsiLTA5k=
X-Google-Smtp-Source: ABdhPJyZqErjF3PvEuRFWmoCGqhWlSB1757WvqUO8rPGGRfTQVypZowtpLYIYtiTcLF6wFy/KjPKgg==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr8657308wra.227.1621362769893;
        Tue, 18 May 2021 11:32:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm22317243wro.21.2021.05.18.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:32:49 -0700 (PDT)
Message-Id: <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
References: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 18:32:44 +0000
Subject: [PATCH v3 0/4] Convert index writes to use hashfile API
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


Updates in v3
=============

 * Fixed typos in commit messages.

 * Updated buffer and check_buffer to be heap-allocated members of struct
   hashfile.

 * These buffers have variable size, allowing the uses that calculate a
   throughput progress bar can still use an 8k buffer, while the others grow
   to 128k.

 * The heap-allocated check_buffer allows the hashfile API to remain as
   thread safe as before (parallel threads can write to independent
   hashfiles, not the same one).


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
 csum-file.c    |  94 +++++++++++++++---------
 csum-file.h    |   4 +-
 read-cache.c   | 191 ++++++++++++++++---------------------------------
 4 files changed, 134 insertions(+), 167 deletions(-)


base-commit: 97eea85a0a1ec66d356567808a1e4ca2367e0ce7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-916%2Fderrickstolee%2Findex-hashfile-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-916/derrickstolee/index-hashfile-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/916

Range-diff vs v2:

 1:  b3e578ac0365 = 1:  b3e578ac0365 hashfile: use write_in_full()
 2:  9dc602f6c422 ! 2:  64ffddd79116 csum-file.h: increase hashfile buffer size
     @@ Commit message
          hashing buffers in read-cache.c, but that code was updated from 8KB to
          128KB in f279894 (read-cache: make the index write buffer size 128K,
          2021-02-18). The justification there was that do_write_index() improves
     -    from 1.02s to 0.72s.
     +    from 1.02s to 0.72s. Since our end goal is to have the index writing
     +    code use the hashfile API, we need to unify this buffer size to avoid a
     +    performance regression.
      
     -    There is a buffer, check_buffer, that is used to verify the check_fd
     +    There is a buffer, 'check_buffer', that is used to verify the check_fd
          file descriptor. When this buffer increases to 128K to fit the data
          being flushed, it causes the stack to overflow the limits placed in the
     -    test suite. By moving this to a static buffer, we stop using stack data
     -    for this purpose, but we lose some thread-safety. This change makes it
     -    unsafe to write to multiple hashfiles across different threads.
     +    test suite. To avoid issues with stack size, move both 'buffer' and
     +    'check_buffer' to be heap pointers within 'struct hashfile'. The
     +    'check_buffer' member is left as NULL unless check_fd is set in
     +    hashfd_check(). Both buffers are cleared as part of finalize_hashfile()
     +    which also frees the full structure.
     +
     +    Since these buffers are now on the heap, we can adjust their size based
     +    on the needs of the consumer. In particular, callers to
     +    hashfd_throughput() are expecting to report progress indicators as the
     +    buffer flushes. These callers would prefer the smaller 8k buffer to
     +    avoid large delays between updates, especially for users with slower
     +    networks. When the progress indicator is not used, the larger buffer is
     +    preferrable.
      
          By adding a new trace2 region in the chunk-format API, we can see that
          the writing portion of 'git multi-pack-index write' lowers from ~1.49s
     @@ csum-file.c
      +				 const void *buf,
      +				 unsigned int count)
      +{
     -+	static unsigned char check_buffer[WRITE_BUFFER_SIZE];
     -+	ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
     ++	ssize_t ret = read_in_full(f->check_fd, f->check_buffer, count);
      +
      +	if (ret < 0)
      +		die_errno("%s: sha1 file read error", f->name);
      +	if (ret != count)
      +		die("%s: sha1 file truncated", f->name);
     -+	if (memcmp(buf, check_buffer, count))
     ++	if (memcmp(buf, f->check_buffer, count))
      +		die("sha1 file '%s' validation error", f->name);
      +}
      +
     @@ csum-file.c
       
       	if (write_in_full(f->fd, buf, count) < 0) {
       		if (errno == ENOSPC)
     -
     - ## csum-file.h ##
     -@@
     - 
     - struct progress;
     +@@ csum-file.c: void hashflush(struct hashfile *f)
     + 	}
     + }
       
     -+#define WRITE_BUFFER_SIZE (128 * 1024)
     ++static void free_hashfile(struct hashfile *f)
     ++{
     ++	free(f->buffer);
     ++	free(f->check_buffer);
     ++	free(f);
     ++}
      +
     - /* A SHA1-protected file */
     - struct hashfile {
     + int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
     + {
       	int fd;
     +@@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
     + 		if (close(f->check_fd))
     + 			die_errno("%s: sha1 file error on close", f->name);
     + 	}
     +-	free(f);
     ++	free_hashfile(f);
     + 	return fd;
     + }
     + 
     + void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
     + {
     + 	while (count) {
     +-		unsigned left = sizeof(f->buffer) - f->offset;
     ++		unsigned left = f->buffer_len - f->offset;
     + 		unsigned nr = count > left ? left : count;
     + 
     + 		if (f->do_crc)
     + 			f->crc32 = crc32(f->crc32, buf, nr);
     + 
     +-		if (nr == sizeof(f->buffer)) {
     ++		if (nr == f->buffer_len) {
     + 			/*
     + 			 * Flush a full batch worth of data directly
     + 			 * from the input, skipping the memcpy() to
     +@@ csum-file.c: void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
     + 	}
     + }
     + 
     +-struct hashfile *hashfd(int fd, const char *name)
     +-{
     +-	return hashfd_throughput(fd, name, NULL);
     +-}
     +-
     + struct hashfile *hashfd_check(const char *name)
     + {
     + 	int sink, check;
     +@@ csum-file.c: struct hashfile *hashfd_check(const char *name)
     + 		die_errno("unable to open '%s'", name);
     + 	f = hashfd(sink, name);
     + 	f->check_fd = check;
     ++	f->check_buffer = xmalloc(f->buffer_len);
     ++
     + 	return f;
     + }
     + 
     +-struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
     ++static struct hashfile *hashfd_internal(int fd, const char *name,
     ++					struct progress *tp,
     ++					size_t buffer_len)
     + {
     + 	struct hashfile *f = xmalloc(sizeof(*f));
     + 	f->fd = fd;
     +@@ csum-file.c: struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
     + 	f->name = name;
     + 	f->do_crc = 0;
     + 	the_hash_algo->init_fn(&f->ctx);
     ++
     ++	f->buffer_len = buffer_len;
     ++	f->buffer = xmalloc(buffer_len);
     ++	f->check_buffer = NULL;
     ++
     + 	return f;
     + }
     + 
     ++struct hashfile *hashfd(int fd, const char *name)
     ++{
     ++	/*
     ++	 * Since we are not going to use a progress meter to
     ++	 * measure the rate of data passing through this hashfile,
     ++	 * use a larger buffer size to reduce fsync() calls.
     ++	 */
     ++	return hashfd_internal(fd, name, NULL, 128 * 1024);
     ++}
     ++
     ++struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
     ++{
     ++	/*
     ++	 * Since we are expecting to report progress of the
     ++	 * write into this hashfile, use a smaller buffer
     ++	 * size so the progress indicators arrive at a more
     ++	 * frequent rate.
     ++	 */
     ++	return hashfd_internal(fd, name, tp, 8 * 1024);
     ++}
     ++
     + void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
     + {
     + 	hashflush(f);
     +
     + ## csum-file.h ##
      @@ csum-file.h: struct hashfile {
       	const char *name;
       	int do_crc;
       	uint32_t crc32;
      -	unsigned char buffer[8192];
     -+	unsigned char buffer[WRITE_BUFFER_SIZE];
     ++	size_t buffer_len;
     ++	unsigned char *buffer;
     ++	unsigned char *check_buffer;
       };
       
       /* Checkpoint */
 3:  b94172ccf5e9 ! 3:  afd278bef3ab read-cache: use hashfile instead of git_hash_ctx
     @@ Commit message
          codebase, I figured that these roughly equivalent code paths were never
          unified only because it got lost in the shuffle. The hashfile API has
          since been used extensively in other file formats, such as pack-indexes,
     -    mult-pack-indexes, and commit-graphs. Therefore, it seems prudent to
     +    multi-pack-indexes, and commit-graphs. Therefore, it seems prudent to
          unify the index writing code to use the same mechanism.
      
          I discovered this disparity while trying to create a new index format
     @@ Commit message
          temporary file with writes to the hashfile struct. This takes care of
          many of the direct interactions with the_hash_algo.
      
     -    There are still some remaining: the extension headers are hashed for use
     -    in the End of Index Entries (EOIE) extension. This use of the
     -    git_hash_ctx is left as-is. There are multiple reasons to not use a
     -    hashfile here, including the fact that the data is not actually writing
     -    to a file, just a hash computation. These hashes do not block our
     -    adoption of the chunk-format API in a future change to the index, so
     +    There are still some git_hash_ctx uses remaining: the extension headers
     +    are hashed for use in the End of Index Entries (EOIE) extension. This
     +    use of the git_hash_ctx is left as-is. There are multiple reasons to not
     +    use a hashfile here, including the fact that the data is not actually
     +    writing to a file, just a hash computation. These hashes do not block
     +    our adoption of the chunk-format API in a future change to the index, so
          leave it as-is.
      
          The internals of the algorithms are mostly identical. Previously, the
     @@ Commit message
          the index data to be exactly equal. Finally, I did extensive performance
          testing of "git update-index --force-write" on repos of various sizes,
          including one with over 2 million paths at HEAD. These tests
     -    demonstrated less than 1% difference in behavior, so the performance
     -    should be considered identical.
     +    demonstrated less than 1% difference in behavior. As expected, the
     +    performance should be considered unchanged. The previous changes to
     +    increase the hashfile buffer size from 8K to 128K ensured this change
     +    would not create a peformance regression.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
 4:  4b3814eb4c80 = 4:  42fb10fb2998 read-cache: delete unused hashing methods

-- 
gitgitgadget
