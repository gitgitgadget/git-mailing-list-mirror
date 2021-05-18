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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18937C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A2961261
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbhERSeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351612AbhERSeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:34:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A3C06175F
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so11277440wrt.12
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qd06bViuszC3H/4RYYoSDUGIlCHJWghK8HNy6G6OChA=;
        b=jglSXr/xXhEfCGx96on1QoJ1h/nmw+I3wo/b68AGypsZeDb/nskihIIdPRgc6yzdiz
         XFUgX+3c8XeIVxZwNDP6QOPonOOlz2csEdFRb7kShsMCSCeb0WNF8CKWWVIEeQCSChTU
         Wfv2+Q59TpG4uKiIraK6Pbyhxo0QNKQyr1DxI66Orft9ehLUIM28IjRAj4+d2EAL2ExF
         9BGpWZb+MEQQcrJwDj9WpBobPmeMhLuxQRKjZaLC1vJWQHUKxAe8Idt8RhUN0DgPyP0/
         Q3dTCZ4R3S3E1MNER1Sk3kjhLPu1MuMNkx6nWXAh9aTJ4HLsJT3zXn2aj+DvGp8AqqZm
         0zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qd06bViuszC3H/4RYYoSDUGIlCHJWghK8HNy6G6OChA=;
        b=grbFkxRxHMfuqudT4JghDE3Q0x6Sg/zS0FXvgl5ya5nuZuaMlsVkBBc6lUjyTMITsm
         Bl7Uu4ZAlkYFORLIC/PSDnkdv1JkGk9ObSN+hlOjK/IArgYei5X6I92Po9GVGxUZvsVD
         V5183aQsmDZRn3GbJ/dmUjm2j1K04GppfX/c7ViqTb7fxGlhWt/TxT6k9DGfy5N6AGBi
         lNTT4ltUCKSO2/Ui/rf3+oKJTeQlYCsuuGxLTvNeuZNAN2chfPi7Wo0zLfHKg0egq/F7
         9cfAsoiVBBc3TzxRfhdmZVSPSrWInR1YZM/KFHIu5WmPhz8CuRARb399z92P9TCtn8A4
         ciHQ==
X-Gm-Message-State: AOAM530qRRKyP2+gUb1x6kX/jzNacreSDHMRoJ/AOkyUWqXuxzzVBRos
        RJnNND+t9qO+oomV6NGFOCA8ZhqyEhU=
X-Google-Smtp-Source: ABdhPJzxGZdCelwhfdwJ2/hB2321DXPimf6loqTEEDAQnvAOPIb2ccP0lRfwL89CVVE2skjJe+I42g==
X-Received: by 2002:adf:8b03:: with SMTP id n3mr8657409wra.227.1621362771177;
        Tue, 18 May 2021 11:32:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm3385668wmq.28.2021.05.18.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:32:50 -0700 (PDT)
Message-Id: <64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
References: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <pull.916.v3.git.1621362768.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 18:32:46 +0000
Subject: [PATCH v3 2/4] csum-file.h: increase hashfile buffer size
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

The hashfile API uses a hard-coded buffer size of 8KB and has ever since
it was introduced in c38138c (git-pack-objects: write the pack files
with a SHA1 csum, 2005-06-26). It performs a similar function to the
hashing buffers in read-cache.c, but that code was updated from 8KB to
128KB in f279894 (read-cache: make the index write buffer size 128K,
2021-02-18). The justification there was that do_write_index() improves
from 1.02s to 0.72s. Since our end goal is to have the index writing
code use the hashfile API, we need to unify this buffer size to avoid a
performance regression.

There is a buffer, 'check_buffer', that is used to verify the check_fd
file descriptor. When this buffer increases to 128K to fit the data
being flushed, it causes the stack to overflow the limits placed in the
test suite. To avoid issues with stack size, move both 'buffer' and
'check_buffer' to be heap pointers within 'struct hashfile'. The
'check_buffer' member is left as NULL unless check_fd is set in
hashfd_check(). Both buffers are cleared as part of finalize_hashfile()
which also frees the full structure.

Since these buffers are now on the heap, we can adjust their size based
on the needs of the consumer. In particular, callers to
hashfd_throughput() are expecting to report progress indicators as the
buffer flushes. These callers would prefer the smaller 8k buffer to
avoid large delays between updates, especially for users with slower
networks. When the progress indicator is not used, the larger buffer is
preferrable.

By adding a new trace2 region in the chunk-format API, we can see that
the writing portion of 'git multi-pack-index write' lowers from ~1.49s
to ~1.47s on a Linux machine. These effects may be more pronounced or
diminished on other filesystems. The end-to-end timing is too noisy to
have a definitive change either way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 12 +++++---
 csum-file.c    | 77 +++++++++++++++++++++++++++++++++++++-------------
 csum-file.h    |  4 ++-
 3 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index da191e59a29d..1c3dca62e205 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -58,9 +58,11 @@ void add_chunk(struct chunkfile *cf,
 
 int write_chunkfile(struct chunkfile *cf, void *data)
 {
-	int i;
+	int i, result = 0;
 	uint64_t cur_offset = hashfile_total(cf->f);
 
+	trace2_region_enter("chunkfile", "write", the_repository);
+
 	/* Add the table of contents to the current offset */
 	cur_offset += (cf->chunks_nr + 1) * CHUNK_TOC_ENTRY_SIZE;
 
@@ -77,10 +79,10 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 
 	for (i = 0; i < cf->chunks_nr; i++) {
 		off_t start_offset = hashfile_total(cf->f);
-		int result = cf->chunks[i].write_fn(cf->f, data);
+		result = cf->chunks[i].write_fn(cf->f, data);
 
 		if (result)
-			return result;
+			goto cleanup;
 
 		if (hashfile_total(cf->f) - start_offset != cf->chunks[i].size)
 			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
@@ -88,7 +90,9 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 			    hashfile_total(cf->f) - start_offset);
 	}
 
-	return 0;
+cleanup:
+	trace2_region_leave("chunkfile", "write", the_repository);
+	return result;
 }
 
 int read_table_of_contents(struct chunkfile *cf,
diff --git a/csum-file.c b/csum-file.c
index 3c26389d4914..3487d28ed7ad 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,19 +11,24 @@
 #include "progress.h"
 #include "csum-file.h"
 
+static void verify_buffer_or_die(struct hashfile *f,
+				 const void *buf,
+				 unsigned int count)
+{
+	ssize_t ret = read_in_full(f->check_fd, f->check_buffer, count);
+
+	if (ret < 0)
+		die_errno("%s: sha1 file read error", f->name);
+	if (ret != count)
+		die("%s: sha1 file truncated", f->name);
+	if (memcmp(buf, f->check_buffer, count))
+		die("sha1 file '%s' validation error", f->name);
+}
+
 static void flush(struct hashfile *f, const void *buf, unsigned int count)
 {
-	if (0 <= f->check_fd && count)  {
-		unsigned char check_buffer[8192];
-		ssize_t ret = read_in_full(f->check_fd, check_buffer, count);
-
-		if (ret < 0)
-			die_errno("%s: sha1 file read error", f->name);
-		if (ret != count)
-			die("%s: sha1 file truncated", f->name);
-		if (memcmp(buf, check_buffer, count))
-			die("sha1 file '%s' validation error", f->name);
-	}
+	if (0 <= f->check_fd && count)
+		verify_buffer_or_die(f, buf, count);
 
 	if (write_in_full(f->fd, buf, count) < 0) {
 		if (errno == ENOSPC)
@@ -46,6 +51,13 @@ void hashflush(struct hashfile *f)
 	}
 }
 
+static void free_hashfile(struct hashfile *f)
+{
+	free(f->buffer);
+	free(f->check_buffer);
+	free(f);
+}
+
 int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
 {
 	int fd;
@@ -75,20 +87,20 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
 		if (close(f->check_fd))
 			die_errno("%s: sha1 file error on close", f->name);
 	}
-	free(f);
+	free_hashfile(f);
 	return fd;
 }
 
 void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 {
 	while (count) {
-		unsigned left = sizeof(f->buffer) - f->offset;
+		unsigned left = f->buffer_len - f->offset;
 		unsigned nr = count > left ? left : count;
 
 		if (f->do_crc)
 			f->crc32 = crc32(f->crc32, buf, nr);
 
-		if (nr == sizeof(f->buffer)) {
+		if (nr == f->buffer_len) {
 			/*
 			 * Flush a full batch worth of data directly
 			 * from the input, skipping the memcpy() to
@@ -114,11 +126,6 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 	}
 }
 
-struct hashfile *hashfd(int fd, const char *name)
-{
-	return hashfd_throughput(fd, name, NULL);
-}
-
 struct hashfile *hashfd_check(const char *name)
 {
 	int sink, check;
@@ -132,10 +139,14 @@ struct hashfile *hashfd_check(const char *name)
 		die_errno("unable to open '%s'", name);
 	f = hashfd(sink, name);
 	f->check_fd = check;
+	f->check_buffer = xmalloc(f->buffer_len);
+
 	return f;
 }
 
-struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
+static struct hashfile *hashfd_internal(int fd, const char *name,
+					struct progress *tp,
+					size_t buffer_len)
 {
 	struct hashfile *f = xmalloc(sizeof(*f));
 	f->fd = fd;
@@ -146,9 +157,35 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	f->name = name;
 	f->do_crc = 0;
 	the_hash_algo->init_fn(&f->ctx);
+
+	f->buffer_len = buffer_len;
+	f->buffer = xmalloc(buffer_len);
+	f->check_buffer = NULL;
+
 	return f;
 }
 
+struct hashfile *hashfd(int fd, const char *name)
+{
+	/*
+	 * Since we are not going to use a progress meter to
+	 * measure the rate of data passing through this hashfile,
+	 * use a larger buffer size to reduce fsync() calls.
+	 */
+	return hashfd_internal(fd, name, NULL, 128 * 1024);
+}
+
+struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
+{
+	/*
+	 * Since we are expecting to report progress of the
+	 * write into this hashfile, use a smaller buffer
+	 * size so the progress indicators arrive at a more
+	 * frequent rate.
+	 */
+	return hashfd_internal(fd, name, tp, 8 * 1024);
+}
+
 void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
 	hashflush(f);
diff --git a/csum-file.h b/csum-file.h
index e54d53d1d0b3..3044bd19ab65 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -16,7 +16,9 @@ struct hashfile {
 	const char *name;
 	int do_crc;
 	uint32_t crc32;
-	unsigned char buffer[8192];
+	size_t buffer_len;
+	unsigned char *buffer;
+	unsigned char *check_buffer;
 };
 
 /* Checkpoint */
-- 
gitgitgadget

