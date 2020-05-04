Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC7C47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16C820721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIdTO/k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEDTD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEDTDy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ED4C061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h9so436276wrt.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kL27JDKguGsU8DFUK95dopO6bYwBPQEGpI6jvq4hY6E=;
        b=CIdTO/k0JN9HKrr1fv7pivCXuXVUR4KIP4vefofNVziWtzhWSjOyMciliol9NoI9LR
         ol1pUTt022pHzupqzhUZOnul8Gv+vROzJW0aLDgfj58CaT70DGp0LRKB//Kf0WdTxABu
         qbVx1YHv5KgJf6eaMx0BfytF1X4flf2y2+v5McqEmZ+J5zCx60Wid/0bVj4YXfxHwzpd
         7qQT7gJl9/b6tSNDWX4ILbMoO+kI8zPmW8dUYWY36xGshQZH+os2Rcu/EaPTbXO6ZB8m
         Sm/9BV2eCgi9iLbKEOeP2USxKGC7ygCjkB8ZiQ0G4ldhnsOAZdUePt4R6sjyjkNUelqh
         Oi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kL27JDKguGsU8DFUK95dopO6bYwBPQEGpI6jvq4hY6E=;
        b=So8nnlOgjhsfUPCaS56QqbDbktJczNj5OA/KygmAGn+b0bVJg/bY5pWpT0+wyv/C6V
         gt3jPbzAn5Cgc5Vd6+QBJlQV8P75nvZMXVzP1YwnKo9nBlF/YQcd2rdyuDjC1ks/l2Nh
         Enn8uD2knlyMQO3Onw4ingiSWmAdp6cm0RyMRhU1Ozewfpfhn1i6Fj1alyurf6N0jmPm
         sWnZ6tZHDLpkeBkPgrD3ZM+1JPKXm81zvPVymRk/OjJB4xXbcr1voR7uF9BEQOKXzSWu
         zo1/B4Lo8F9lZtir75L3EPltuI7ukK3s2cStxi8Ai5i4vbfIeoGdjSiTP0pM1fgoCCp8
         ndUg==
X-Gm-Message-State: AGi0PubjDB3uyas28WzFM3wDZmaD9BrCF+G0FtT9EIqQK309BvjmTb9S
        Kn+MDbq4IdvQ9yyKPOtdd99vO6eJ
X-Google-Smtp-Source: APiQypIuWfufpLz/Zd94xK68Wurc8WABckAPLd5MlAjZU0gLu5HPCQn4q+oykzSYiudNQPlDSmuUCw==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr588447wro.347.1588619030742;
        Mon, 04 May 2020 12:03:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm496968wmc.48.2020.05.04.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:50 -0700 (PDT)
Message-Id: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:36 +0000
Subject: [PATCH v11 00/12] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 18964 tests pass 2871 tests fail

Some issues:

 * worktree support looks broken
 * submodules (eg. t1013)
 * many tests inspect .git/logs/ directly.

v14

 * Fixes for Windows (thanks, Dscho!)
 * Detect file/directory conflicts.
 * Plug some memory leaks.
 * Fixes for autocompaction

Han-Wen Nienhuys (10):
  refs.h: clarify reflog iteration order
  Iterate over the "refs/" namespace in for_each_[raw]ref
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add .gitattributes for the reftable/ directory
  reftable: define version 2 of the spec to accomodate SHA256
  reftable: clarify how empty tables should be written
  Add reftable library
  Reftable support for git-core
  Add some reftable testing infrastructure
  t: use update-ref and show-ref to reading/writing refs

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1080 +++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   27 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   56 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 refs.c                                        |   33 +-
 refs.h                                        |    8 +-
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1045 ++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  436 ++++++
 reftable/block.h                              |  126 ++
 reftable/blocksource.h                        |   22 +
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   99 ++
 reftable/iter.c                               |  240 ++++
 reftable/iter.h                               |   63 +
 reftable/merged.c                             |  327 +++++
 reftable/merged.h                             |   38 +
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  758 ++++++++++
 reftable/reader.h                             |   68 +
 reftable/record.c                             | 1131 +++++++++++++++
 reftable/record.h                             |  121 ++
 reftable/refname.c                            |  215 +++
 reftable/refname.h                            |   39 +
 reftable/reftable.c                           |   91 ++
 reftable/reftable.h                           |  564 ++++++++
 reftable/slice.c                              |  225 +++
 reftable/slice.h                              |   76 +
 reftable/stack.c                              | 1229 +++++++++++++++++
 reftable/stack.h                              |   45 +
 reftable/system.h                             |   54 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   24 +
 reftable/writer.c                             |  661 +++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0002-gitfile.sh                            |    2 +-
 t/t0031-reftable.sh                           |  109 ++
 t/t1400-update-ref.sh                         |   32 +-
 t/t1506-rev-parse-diagnosis.sh                |    2 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/t6050-replace.sh                            |    2 +-
 t/t9020-remote-svn.sh                         |    4 +-
 t/test-lib.sh                                 |    5 +
 60 files changed, 9798 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/technical/reftable.txt
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100755 t/t0031-reftable.sh


base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v11
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v10:

  1:  d3d8ed2032c =  1:  dfa5fd74f85 refs.h: clarify reflog iteration order
  2:  45fd65f72e0 =  2:  340c5c415e1 Iterate over the "refs/" namespace in for_each_[raw]ref
  3:  bc89bcd9c8c <  -:  ----------- create .git/refs in files-backend.c
  4:  fd67cdff0cd =  3:  6553285043b refs: document how ref_iterator_advance_fn should handle symrefs
  5:  5373828f854 =  4:  7dc47c7756f Add .gitattributes for the reftable/ directory
  6:  8eeed29ebbf =  5:  06fcb49e903 reftable: file format documentation
  7:  5ebc272e23d =  6:  093fa74a3d0 reftable: define version 2 of the spec to accomodate SHA256
  8:  95aae041613 =  7:  6d9031372ce reftable: clarify how empty tables should be written
  9:  59209a5ad39 !  8:  6ee6c44752c Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit a6d6b31bea256044621d789df64a8159647f21bc
     ++commit 3a486f79abcd17e88e3bca62f43188a7c8b80ff3
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon Apr 27 20:46:21 2020 +0200
     ++Date:   Mon May 4 19:20:21 2020 +0200
      +
     -+    C: prefix error codes with REFTABLE_
     ++    C: include "cache.h" in git-core sleep_millisec()
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/basics.c (new)
      +{
      +	out[0] = (byte)((i >> 16) & 0xff);
      +	out[1] = (byte)((i >> 8) & 0xff);
     -+	out[2] = (byte)((i)&0xff);
     ++	out[2] = (byte)(i & 0xff);
      +}
      +
      +uint32_t get_be24(byte *in)
     @@ reftable/basics.c (new)
      +void put_be16(uint8_t *out, uint16_t i)
      +{
      +	out[0] = (uint8_t)((i >> 8) & 0xff);
     -+	out[1] = (uint8_t)((i)&0xff);
     ++	out[1] = (uint8_t)(i & 0xff);
      +}
      +
     -+int binsearch(int sz, int (*f)(int k, void *args), void *args)
     ++int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
      +{
     -+	int lo = 0;
     -+	int hi = sz;
     ++	size_t lo = 0;
     ++	size_t hi = sz;
      +
      +	/* invariant: (hi == sz) || f(hi) == true
      +	   (lo == 0 && f(0) == true) || fi(lo) == false
      +	 */
      +	while (hi - lo > 1) {
     -+		int mid = lo + (hi - lo) / 2;
     ++		size_t mid = lo + (hi - lo) / 2;
      +
      +		int val = f(mid, args);
      +		if (val) {
     @@ reftable/basics.c (new)
      +
      +const char *reftable_error_str(int err)
      +{
     ++	static char buf[250];
      +	switch (err) {
      +	case REFTABLE_IO_ERROR:
      +		return "I/O error";
     @@ reftable/basics.c (new)
      +		return "misuse of the reftable API";
      +	case REFTABLE_ZLIB_ERROR:
      +		return "zlib failure";
     ++	case REFTABLE_NAME_CONFLICT:
     ++		return "file/directory conflict";
     ++	case REFTABLE_REFNAME_ERROR:
     ++		return "invalid refname";
      +	case -1:
      +		return "general error";
      +	default:
     -+		return "unknown error code";
     ++		snprintf(buf, sizeof(buf), "unknown error code %d", err);
     ++		return buf;
      +	}
      +}
      +
     -+int reftable_error_to_errno(int err) {
     ++int reftable_error_to_errno(int err)
     ++{
      +	switch (err) {
      +	case REFTABLE_IO_ERROR:
      +		return EIO;
     @@ reftable/basics.c (new)
      +	}
      +}
      +
     -+
      +void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
      +void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
      +void (*reftable_free_ptr)(void *) = &free;
     @@ reftable/basics.h (new)
      +  find smallest index i in [0, sz) at which f(i) is true, assuming
      +  that f is ascending. Return sz if f(i) is false for all indices.
      +*/
     -+int binsearch(int sz, int (*f)(int k, void *args), void *args);
     ++int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
      +
      +/*
      +  Frees a NULL terminated array of malloced strings. The array itself is also
     @@ reftable/block.c (new)
      +			memcpy(w->buf + block_header_skip, compressed.buf,
      +			       dest_len);
      +			w->next = dest_len + block_header_skip;
     ++			slice_clear(&compressed);
      +			break;
      +		}
      +	}
     @@ reftable/block.c (new)
      +	if (typ == BLOCK_TYPE_LOG) {
      +		struct slice uncompressed = { 0 };
      +		int block_header_skip = 4 + header_off;
     -+		uLongf dst_len = sz - block_header_skip;
     ++		uLongf dst_len = sz - block_header_skip; /* total size of dest
     ++							    buffer. */
      +		uLongf src_len = block->len - block_header_skip;
      +
     ++		/* Log blocks specify the *uncompressed* size in their header.
     ++		 */
      +		slice_resize(&uncompressed, sz);
     ++
     ++		/* Copy over the block header verbatim. It's not compressed. */
      +		memcpy(uncompressed.buf, block->data, block_header_skip);
      +
     ++		/* Uncompress */
      +		if (Z_OK != uncompress_return_consumed(
      +				    uncompressed.buf + block_header_skip,
      +				    &dst_len, block->data + block_header_skip,
     @@ reftable/block.c (new)
      +			return REFTABLE_ZLIB_ERROR;
      +		}
      +
     ++		if (dst_len + block_header_skip != sz) {
     ++			return REFTABLE_FORMAT_ERROR;
     ++		}
     ++
     ++		/* We're done with the input data. */
      +		block_source_return_block(block->source, block);
      +		block->data = uncompressed.buf;
     -+		block->len = dst_len; /* XXX: 4 bytes missing? */
     ++		block->len = sz;
      +		block->source = malloc_block_source();
      +		full_block_size = src_len + block_header_skip;
      +	} else if (full_block_size == 0) {
     @@ reftable/block.c (new)
      +	struct block_reader *r;
      +};
      +
     -+static int restart_key_less(int idx, void *args)
     ++static int restart_key_less(size_t idx, void *args)
      +{
      +	struct restart_find_args *a = (struct restart_find_args *)args;
      +	uint32_t off = block_reader_restart_offset(a->r, idx);
     @@ reftable/block.c (new)
      +	slice_copy(&dest->last_key, src->last_key);
      +}
      +
     -+/* return < 0 for error, 0 for OK, > 0 for EOF. */
      +int block_iter_next(struct block_iter *it, struct record rec)
      +{
      +	if (it->next_off >= it->br->block_len) {
     @@ reftable/block.h (new)
      +int block_reader_first_key(struct block_reader *br, struct slice *key);
      +
      +void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
     ++
     ++/* return < 0 for error, 0 for OK, > 0 for EOF. */
      +int block_iter_next(struct block_iter *it, struct record rec);
      +
      +/* Seek to `want` with in the block pointed to by `it` */
     @@ reftable/blocksource.h (new)
      +
      +#endif
      
     - ## reftable/bytes.c (new) ##
     -
     - ## reftable/config.h (new) ##
     -@@
     -+/* empty */
     -
       ## reftable/constants.h (new) ##
      @@
      +/*
     @@ reftable/constants.h (new)
      +
      +#endif
      
     - ## reftable/dump.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "system.h"
     -+
     -+#include "reftable.h"
     -+
     -+static int dump_table(const char *tablename)
     -+{
     -+	struct block_source src = { 0 };
     -+	int err = block_source_from_file(&src, tablename);
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	struct reader *r = NULL;
     -+	err = new_reader(&r, src, tablename);
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	{
     -+		struct iterator it = { 0 };
     -+		err = reader_seek_ref(r, &it, "");
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+
     -+		struct ref_record ref = { 0 };
     -+		while (1) {
     -+			err = iterator_next_ref(it, &ref);
     -+			if (err > 0) {
     -+				break;
     -+			}
     -+			if (err < 0) {
     -+				return err;
     -+			}
     -+			ref_record_print(&ref, 20);
     -+		}
     -+		iterator_destroy(&it);
     -+		ref_record_clear(&ref);
     -+	}
     -+
     -+	{
     -+		struct iterator it = { 0 };
     -+		err = reader_seek_log(r, &it, "");
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		struct log_record log = { 0 };
     -+		while (1) {
     -+			err = iterator_next_log(it, &log);
     -+			if (err > 0) {
     -+				break;
     -+			}
     -+			if (err < 0) {
     -+				return err;
     -+			}
     -+			log_record_print(&log, 20);
     -+		}
     -+		iterator_destroy(&it);
     -+		log_record_clear(&log);
     -+	}
     -+	return 0;
     -+}
     -+
     -+int main(int argc, char *argv[])
     -+{
     -+	int opt;
     -+	const char *table = NULL;
     -+	while ((opt = getopt(argc, argv, "t:")) != -1) {
     -+		switch (opt) {
     -+		case 't':
     -+			table = xstrdup(optarg);
     -+			break;
     -+		case '?':
     -+			printf("usage: %s [-table tablefile]\n", argv[0]);
     -+			return 2;
     -+			break;
     -+		}
     -+	}
     -+
     -+	if (table != NULL) {
     -+		int err = dump_table(table);
     -+		if (err < 0) {
     -+			fprintf(stderr, "%s: %s: %s\n", argv[0], table,
     -+				error_str(err));
     -+			return 1;
     -+		}
     -+	}
     -+	return 0;
     -+}
     -
       ## reftable/file.c (new) ##
      @@
      +/*
     @@ reftable/file.c (new)
      +		p->size = st.st_size;
      +		p->fd = fd;
      +
     ++		assert(bs->ops == NULL);
      +		bs->ops = &file_vtable;
      +		bs->arg = p;
      +	}
      +	return 0;
      +}
      +
     -+int reftable_fd_write(void *arg, byte *data, int sz)
     ++int reftable_fd_write(void *arg, byte *data, size_t sz)
      +{
      +	int *fdp = (int *)arg;
      +	return write(*fdp, data, sz);
     @@ reftable/iter.c (new)
      +
      +void iterator_set_empty(struct reftable_iterator *it)
      +{
     ++	assert(it->ops == NULL);
      +	it->iter_arg = NULL;
      +	it->ops = &empty_vtable;
      +}
     @@ reftable/iter.c (new)
      +		(struct filtering_ref_iterator *)iter_arg;
      +	struct reftable_ref_record *ref =
      +		(struct reftable_ref_record *)rec.data;
     -+
     ++	int err = 0;
      +	while (true) {
     -+		int err = reftable_iterator_next_ref(fri->it, ref);
     ++		err = reftable_iterator_next_ref(fri->it, ref);
      +		if (err != 0) {
     -+			return err;
     ++			break;
      +		}
      +
      +		if (fri->double_check) {
      +			struct reftable_iterator it = { 0 };
      +
     -+			int err = reftable_reader_seek_ref(fri->r, &it,
     -+							   ref->ref_name);
     ++			err = reftable_reader_seek_ref(fri->r, &it,
     ++						       ref->ref_name);
      +			if (err == 0) {
      +				err = reftable_iterator_next_ref(it, ref);
      +			}
     @@ reftable/iter.c (new)
      +			reftable_iterator_destroy(&it);
      +
      +			if (err < 0) {
     -+				return err;
     ++				break;
      +			}
      +
      +			if (err > 0) {
     @@ reftable/iter.c (new)
      +			return 0;
      +		}
      +	}
     ++
     ++	reftable_ref_record_clear(ref);
     ++	return err;
      +}
      +
      +struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
     @@ reftable/iter.c (new)
      +void iterator_from_filtering_ref_iterator(struct reftable_iterator *it,
      +					  struct filtering_ref_iterator *fri)
      +{
     ++	assert(it->ops == NULL);
      +	it->iter_arg = fri;
      +	it->ops = &filtering_ref_iterator_vtable;
      +}
     @@ reftable/iter.c (new)
      +void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr)
      +{
     ++	assert(it->ops == NULL);
      +	it->iter_arg = itr;
      +	it->ops = &indexed_table_ref_iter_vtable;
      +}
     @@ reftable/iter.h (new)
      +
      +void iterator_set_empty(struct reftable_iterator *it);
      +int iterator_next(struct reftable_iterator it, struct record rec);
     ++
     ++/* Returns true for a zeroed out iterator, such as the one returned from
     ++   iterator_destroy. */
      +bool iterator_is_null(struct reftable_iterator it);
      +
      +/* iterator that produces only ref records that point to `oid` */
     @@ reftable/merged.c (new)
      +	reftable_free(mi->stack);
      +}
      +
     -+static int merged_iter_advance_subiter(struct merged_iter *mi, int idx)
     ++static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
      +{
      +	if (iterator_is_null(mi->stack[idx])) {
      +		return 0;
     @@ reftable/merged.c (new)
      +static void iterator_from_merged_iter(struct reftable_iterator *it,
      +				      struct merged_iter *mi)
      +{
     ++	assert(it->ops == NULL);
      +	it->iter_arg = mi;
      +	it->ops = &merged_iter_vtable;
      +}
     @@ reftable/merged.c (new)
      +	return mt->min;
      +}
      +
     -+static int merged_table_seek_record(struct reftable_merged_table *mt,
     -+				    struct reftable_iterator *it,
     -+				    struct record rec)
     ++int merged_table_seek_record(struct reftable_merged_table *mt,
     ++			     struct reftable_iterator *it, struct record rec)
      +{
      +	struct reftable_iterator *iters = reftable_calloc(
      +		sizeof(struct reftable_iterator) * mt->stack_len);
     @@ reftable/merged.h (new)
      +};
      +
      +void merged_table_clear(struct reftable_merged_table *mt);
     ++int merged_table_seek_record(struct reftable_merged_table *mt,
     ++			     struct reftable_iterator *it, struct record rec);
      +
      +#endif
      
     @@ reftable/reader.c (new)
      +static void iterator_from_table_iter(struct reftable_iterator *it,
      +				     struct table_iter *ti)
      +{
     ++	assert(it->ops == NULL);
      +	it->iter_arg = ti;
      +	it->ops = &table_iter_vtable;
      +}
     @@ reftable/reader.c (new)
      +	if (err == 0) {
      +		*p = rd;
      +	} else {
     ++		block_source_close(&src);
      +		reftable_free(rd);
      +	}
      +	return err;
     @@ reftable/reader.c (new)
      +	struct record got_rec = { 0 };
      +	int err = 0;
      +
     ++	/* Look through the reverse index. */
      +	record_from_obj(&want_rec, &want);
     -+
      +	err = reader_seek(r, &oit, want_rec);
      +	if (err != 0) {
     -+		return err;
     ++		goto exit;
      +	}
      +
     ++	/* read out the obj_record */
      +	record_from_obj(&got_rec, &got);
      +	err = iterator_next(oit, got_rec);
     -+	reftable_iterator_destroy(&oit);
      +	if (err < 0) {
     -+		return err;
     ++		goto exit;
      +	}
      +
      +	if (err > 0 ||
      +	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
     ++		/* didn't find it; return empty iterator */
      +		iterator_set_empty(it);
     -+		return 0;
     ++		err = 0;
     ++		goto exit;
      +	}
      +
      +	{
     @@ reftable/reader.c (new)
      +						 hash_size(r->hash_id),
      +						 got.offsets, got.offset_len);
      +		if (err < 0) {
     -+			record_clear(got_rec);
     -+			return err;
     ++			goto exit;
      +		}
      +		got.offsets = NULL;
     -+		record_clear(got_rec);
     -+
      +		iterator_from_indexed_table_ref_iter(it, itr);
      +	}
      +
     -+	return 0;
     ++exit:
     ++	reftable_iterator_destroy(&oit);
     ++	record_clear(got_rec);
     ++	return err;
      +}
      +
      +static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
     @@ reftable/record.c (new)
      +	memcpy(r->message, dest.buf, dest.len);
      +	r->message[dest.len] = 0;
      +
     ++	slice_clear(&dest);
      +	return start.len - in.len;
      +
      +error:
     @@ reftable/record.c (new)
      +
      +struct record new_record(byte typ)
      +{
     -+	struct record rec;
     ++	struct record rec = { NULL };
      +	switch (typ) {
      +	case BLOCK_TYPE_REF: {
      +		struct reftable_ref_record *r =
     @@ reftable/record.c (new)
      +
      +void record_clear(struct record rec)
      +{
     -+	return rec.ops->clear(rec.data);
     ++	rec.ops->clear(rec.data);
      +}
      +
      +bool record_is_deletion(struct record rec)
     @@ reftable/record.c (new)
      +
      +void record_from_ref(struct record *rec, struct reftable_ref_record *ref_rec)
      +{
     ++	assert(rec->ops == NULL);
      +	rec->data = ref_rec;
      +	rec->ops = &reftable_ref_record_vtable;
      +}
      +
      +void record_from_obj(struct record *rec, struct obj_record *obj_rec)
      +{
     ++	assert(rec->ops == NULL);
      +	rec->data = obj_rec;
      +	rec->ops = &obj_record_vtable;
      +}
      +
      +void record_from_index(struct record *rec, struct index_record *index_rec)
      +{
     ++	assert(rec->ops == NULL);
      +	rec->data = index_rec;
      +	rec->ops = &index_record_vtable;
      +}
      +
      +void record_from_log(struct record *rec, struct reftable_log_record *log_rec)
      +{
     ++	assert(rec->ops == NULL);
      +	rec->data = log_rec;
      +	rec->ops = &reftable_log_record_vtable;
      +}
     @@ reftable/record.h (new)
      +
      +#endif
      
     + ## reftable/refname.c (new) ##
     +@@
     ++/*
     ++  Copyright 2020 Google LLC
     ++
     ++  Use of this source code is governed by a BSD-style
     ++  license that can be found in the LICENSE file or at
     ++  https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "system.h"
     ++#include "reftable.h"
     ++#include "basics.h"
     ++#include "refname.h"
     ++#include "slice.h"
     ++
     ++struct find_arg {
     ++	char **names;
     ++	const char *want;
     ++};
     ++
     ++static int find_name(size_t k, void *arg)
     ++{
     ++	struct find_arg *f_arg = (struct find_arg *)arg;
     ++
     ++	return strcmp(f_arg->names[k], f_arg->want) >= 0;
     ++}
     ++
     ++int modification_has_ref(struct modification *mod, const char *name)
     ++{
     ++	struct reftable_ref_record ref = { 0 };
     ++	int err = 0;
     ++
     ++	if (mod->add_len > 0) {
     ++		struct find_arg arg = {
     ++			.names = mod->add,
     ++			.want = name,
     ++		};
     ++		int idx = binsearch(mod->add_len, find_name, &arg);
     ++		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
     ++			return 0;
     ++		}
     ++	}
     ++
     ++	if (mod->del_len > 0) {
     ++		struct find_arg arg = {
     ++			.names = mod->del,
     ++			.want = name,
     ++		};
     ++		int idx = binsearch(mod->del_len, find_name, &arg);
     ++		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
     ++			return 1;
     ++		}
     ++	}
     ++
     ++	err = reftable_table_read_ref(mod->tab, name, &ref);
     ++	reftable_ref_record_clear(&ref);
     ++	return err;
     ++}
     ++
     ++static void modification_clear(struct modification *mod)
     ++{
     ++	FREE_AND_NULL(mod->add);
     ++	FREE_AND_NULL(mod->del);
     ++	mod->add_len = 0;
     ++	mod->del_len = 0;
     ++}
     ++
     ++int modification_has_ref_with_prefix(struct modification *mod,
     ++				     const char *prefix)
     ++{
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	int err = 0;
     ++
     ++	if (mod->add_len > 0) {
     ++		struct find_arg arg = {
     ++			.names = mod->add,
     ++			.want = prefix,
     ++		};
     ++		int idx = binsearch(mod->add_len, find_name, &arg);
     ++		if (idx < mod->add_len &&
     ++		    !strncmp(prefix, mod->add[idx], strlen(prefix))) {
     ++			goto exit;
     ++		}
     ++	}
     ++
     ++	err = reftable_table_seek_ref(mod->tab, &it, prefix);
     ++	if (err) {
     ++		goto exit;
     ++	}
     ++
     ++	while (true) {
     ++		err = reftable_iterator_next_ref(it, &ref);
     ++		if (err) {
     ++			goto exit;
     ++		}
     ++
     ++		if (mod->del_len > 0) {
     ++			struct find_arg arg = {
     ++				.names = mod->del,
     ++				.want = ref.ref_name,
     ++			};
     ++			int idx = binsearch(mod->del_len, find_name, &arg);
     ++			if (idx < mod->del_len &&
     ++			    !strcmp(ref.ref_name, mod->del[idx])) {
     ++				continue;
     ++			}
     ++		}
     ++
     ++		if (strncmp(ref.ref_name, prefix, strlen(prefix))) {
     ++			err = 1;
     ++			goto exit;
     ++		}
     ++		err = 0;
     ++		goto exit;
     ++	}
     ++
     ++exit:
     ++	reftable_ref_record_clear(&ref);
     ++	reftable_iterator_destroy(&it);
     ++	return err;
     ++}
     ++
     ++int validate_ref_name(const char *name)
     ++{
     ++	while (true) {
     ++		char *next = strchr(name, '/');
     ++		if (!*name) {
     ++			return REFTABLE_REFNAME_ERROR;
     ++		}
     ++		if (!next) {
     ++			return 0;
     ++		}
     ++		if (next - name == 0 || (next - name == 1 && *name == '.') ||
     ++		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
     ++			return REFTABLE_REFNAME_ERROR;
     ++		name = next + 1;
     ++	}
     ++	return 0;
     ++}
     ++
     ++int validate_ref_record_addition(struct reftable_table tab,
     ++				 struct reftable_ref_record *recs, size_t sz)
     ++{
     ++	struct modification mod = {
     ++		.tab = tab,
     ++		.add = reftable_calloc(sizeof(char *) * sz),
     ++		.del = reftable_calloc(sizeof(char *) * sz),
     ++	};
     ++	int i = 0;
     ++	int err = 0;
     ++	for (; i < sz; i++) {
     ++		if (reftable_ref_record_is_deletion(&recs[i])) {
     ++			mod.del[mod.del_len++] = recs[i].ref_name;
     ++		} else {
     ++			mod.add[mod.add_len++] = recs[i].ref_name;
     ++		}
     ++	}
     ++
     ++	err = modification_validate(&mod);
     ++	modification_clear(&mod);
     ++	return err;
     ++}
     ++
     ++static void slice_trim_component(struct slice *sl)
     ++{
     ++	while (sl->len > 0) {
     ++		bool is_slash = (sl->buf[sl->len - 1] == '/');
     ++		sl->len--;
     ++		if (is_slash)
     ++			break;
     ++	}
     ++}
     ++
     ++int modification_validate(struct modification *mod)
     ++{
     ++	struct slice slashed = { 0 };
     ++	int err = 0;
     ++	int i = 0;
     ++	for (; i < mod->add_len; i++) {
     ++		err = validate_ref_name(mod->add[i]);
     ++		if (err) {
     ++			goto exit;
     ++		}
     ++		slice_set_string(&slashed, mod->add[i]);
     ++		slice_append_string(&slashed, "/");
     ++
     ++		err = modification_has_ref_with_prefix(
     ++			mod, slice_as_string(&slashed));
     ++		if (err == 0) {
     ++			err = REFTABLE_NAME_CONFLICT;
     ++			goto exit;
     ++		}
     ++		if (err < 0) {
     ++			goto exit;
     ++		}
     ++
     ++		slice_set_string(&slashed, mod->add[i]);
     ++		while (slashed.len) {
     ++			slice_trim_component(&slashed);
     ++			err = modification_has_ref(mod,
     ++						   slice_as_string(&slashed));
     ++			if (err == 0) {
     ++				err = REFTABLE_NAME_CONFLICT;
     ++				goto exit;
     ++			}
     ++			if (err < 0) {
     ++				goto exit;
     ++			}
     ++		}
     ++	}
     ++	err = 0;
     ++exit:
     ++	slice_clear(&slashed);
     ++	return err;
     ++}
     +
     + ## reftable/refname.h (new) ##
     +@@
     ++/*
     ++  Copyright 2020 Google LLC
     ++
     ++  Use of this source code is governed by a BSD-style
     ++  license that can be found in the LICENSE file or at
     ++  https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++#ifndef REFNAME_H
     ++#define REFNAME_H
     ++
     ++struct modification {
     ++	struct reftable_table tab;
     ++
     ++	char **add;
     ++	size_t add_len;
     ++
     ++	char **del;
     ++	size_t del_len;
     ++};
     ++
     ++// -1 = error, 0 = found, 1 = not found
     ++int modification_has_ref(struct modification *mod, const char *name);
     ++
     ++// -1 = error, 0 = found, 1 = not found.
     ++int modification_has_ref_with_prefix(struct modification *mod,
     ++				     const char *prefix);
     ++
     ++// 0 = OK.
     ++int validate_ref_name(const char *name);
     ++
     ++int validate_ref_record_addition(struct reftable_table tab,
     ++				 struct reftable_ref_record *recs, size_t sz);
     ++
     ++int modification_validate(struct modification *mod);
     ++
     ++/* illegal name, or dir/file conflict */
     ++#define REFTABLE_REFNAME_ERROR -9
     ++
     ++#endif
     +
     + ## reftable/reftable.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "reftable.h"
     ++#include "record.h"
     ++#include "reader.h"
     ++#include "merged.h"
     ++
     ++struct reftable_table_vtable {
     ++	int (*seek)(void *tab, struct reftable_iterator *it, struct record);
     ++};
     ++
     ++static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     ++				     struct record rec)
     ++{
     ++	return reader_seek((struct reftable_reader *)tab, it, rec);
     ++}
     ++
     ++static struct reftable_table_vtable reader_vtable = {
     ++	.seek = reftable_reader_seek_void,
     ++};
     ++
     ++static int reftable_merged_table_seek_void(void *tab,
     ++					   struct reftable_iterator *it,
     ++					   struct record rec)
     ++{
     ++	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
     ++					rec);
     ++}
     ++
     ++static struct reftable_table_vtable merged_table_vtable = {
     ++	.seek = reftable_merged_table_seek_void,
     ++};
     ++
     ++int reftable_table_seek_ref(struct reftable_table tab,
     ++			    struct reftable_iterator *it, const char *name)
     ++{
     ++	struct reftable_ref_record ref = {
     ++		.ref_name = (char *)name,
     ++	};
     ++	struct record rec = { 0 };
     ++	record_from_ref(&rec, &ref);
     ++	return tab.ops->seek(tab.table_arg, it, rec);
     ++}
     ++
     ++void reftable_table_from_reader(struct reftable_table *tab,
     ++				struct reftable_reader *reader)
     ++{
     ++	assert(tab->ops == NULL);
     ++	tab->ops = &reader_vtable;
     ++	tab->table_arg = reader;
     ++}
     ++
     ++void reftable_table_from_merged_table(struct reftable_table *tab,
     ++				      struct reftable_merged_table *merged)
     ++{
     ++	assert(tab->ops == NULL);
     ++	tab->ops = &merged_table_vtable;
     ++	tab->table_arg = merged;
     ++}
     ++
     ++int reftable_table_read_ref(struct reftable_table tab, const char *name,
     ++			    struct reftable_ref_record *ref)
     ++{
     ++	struct reftable_iterator it = { 0 };
     ++	int err = reftable_table_seek_ref(tab, &it, name);
     ++	if (err) {
     ++		goto exit;
     ++	}
     ++
     ++	err = reftable_iterator_next_ref(it, ref);
     ++	if (err) {
     ++		goto exit;
     ++	}
     ++
     ++	if (strcmp(ref->ref_name, name) ||
     ++	    reftable_ref_record_is_deletion(ref)) {
     ++		reftable_ref_record_clear(ref);
     ++		err = 1;
     ++		goto exit;
     ++	}
     ++
     ++exit:
     ++	reftable_iterator_destroy(&it);
     ++	return err;
     ++}
     +
       ## reftable/reftable.h (new) ##
      @@
      +/*
     @@ reftable/reftable.h (new)
      +
      +	/* Wrote a table without blocks. */
      +	REFTABLE_EMPTY_TABLE_ERROR = -8,
     ++
     ++	/* Dir/file conflict. */
     ++	REFTABLE_NAME_CONFLICT = -9,
     ++
     ++	/* Illegal ref name. */
     ++	REFTABLE_REFNAME_ERROR = -10,
      +};
      +
      +/* convert the numeric error code to a string. The string should not be
     @@ reftable/reftable.h (new)
      +	 * Defaults to SHA1 if unset
      +	 */
      +	uint32_t hash_id;
     ++
     ++	/* boolean: do not check ref names for validity or dir/file conflicts.
     ++	 */
     ++	int skip_name_check;
      +};
      +
      +/* reftable_block_stats holds statistics for a single block type */
     @@ reftable/reftable.h (new)
      +
      +/* reftable_new_writer creates a new writer */
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, uint8_t *, int),
     ++reftable_new_writer(int (*writer_func)(void *, uint8_t *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts);
      +
      +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
     -+int reftable_fd_write(void *fdp, uint8_t *data, int size);
     ++int reftable_fd_write(void *fdp, uint8_t *data, size_t size);
      +
      +/* Set the range of update indices for the records we will add.  When
      +   writing a table into a stack, the min should be at least
     @@ reftable/reftable.h (new)
      +struct reftable_reader;
      +
      +/* reftable_new_reader opens a reftable for reading. If successful, returns 0
     -+ * code and sets pp.  The name is used for creating a
     -+ * stack. Typically, it is the basename of the file.
     ++ * code and sets pp. The name is used for creating a stack. Typically, it is the
     ++ * basename of the file. The block source `src` is owned by the reader, and is
     ++ * closed on calling reftable_reader_destroy().
      + */
      +int reftable_new_reader(struct reftable_reader **pp,
     -+			struct reftable_block_source, const char *name);
     ++			struct reftable_block_source src, const char *name);
      +
      +/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
      +   in the table.  To seek to the start of the table, use name = "".
     @@ reftable/reftable.h (new)
      +void reftable_merged_table_free(struct reftable_merged_table *m);
      +
      +/****************************************************************
     ++ Generic tables
     ++
     ++ A unified API for reading tables, either merged tables, or single readers.
     ++ ****************************************************************/
     ++
     ++struct reftable_table {
     ++	struct reftable_table_vtable *ops;
     ++	void *table_arg;
     ++};
     ++
     ++int reftable_table_seek_ref(struct reftable_table tab,
     ++			    struct reftable_iterator *it, const char *name);
     ++
     ++void reftable_table_from_reader(struct reftable_table *tab,
     ++				struct reftable_reader *reader);
     ++void reftable_table_from_merged_table(struct reftable_table *tab,
     ++				      struct reftable_merged_table *table);
     ++
     ++/* convenience function to read a single ref. Returns < 0 for error, 0
     ++   for success, and 1 if ref not found. */
     ++int reftable_table_read_ref(struct reftable_table tab, const char *name,
     ++			    struct reftable_ref_record *ref);
     ++
     ++/****************************************************************
      + Mutable ref database
      +
      + The stack presents an interface to a mutable sequence of reftables.
     @@ reftable/reftable.h (new)
      +/* statistics on past compactions. */
      +struct reftable_compaction_stats {
      +	uint64_t bytes; /* total number of bytes written */
     ++	uint64_t entries_written; /* total number of entries written, including
     ++				     failures. */
      +	int attempts; /* how often we tried to compact */
      +	int failures; /* failures happen on concurrent updates */
      +};
     @@ reftable/slice.c (new)
      +	}
      +}
      +
     -+int slice_write(struct slice *b, byte *data, int sz)
     ++int slice_write(struct slice *b, byte *data, size_t sz)
      +{
      +	if (b->len + sz > b->cap) {
      +		int newcap = 2 * b->cap + 1;
     @@ reftable/slice.c (new)
      +	return sz;
      +}
      +
     -+int slice_write_void(void *b, byte *data, int sz)
     ++int slice_write_void(void *b, byte *data, size_t sz)
      +{
      +	return slice_write((struct slice *)b, data, sz);
      +}
     @@ reftable/slice.c (new)
      +void block_source_from_slice(struct reftable_block_source *bs,
      +			     struct slice *buf)
      +{
     ++	assert(bs->ops == NULL);
      +	bs->ops = &slice_vtable;
      +	bs->arg = buf;
      +}
     @@ reftable/slice.h (new)
      +int slice_compare(struct slice a, struct slice b);
      +
      +/* Append `data` to the `dest` slice.  */
     -+int slice_write(struct slice *dest, byte *data, int sz);
     ++int slice_write(struct slice *dest, byte *data, size_t sz);
      +
      +/* Append `add` to `dest. */
      +void slice_append(struct slice *dest, struct slice add);
      +
      +/* Like slice_write, but suitable for passing to reftable_new_writer
      + */
     -+int slice_write_void(void *b, byte *data, int sz);
     ++int slice_write_void(void *b, byte *data, size_t sz);
      +
      +/* Find the longest shared prefix size of `a` and `b` */
      +int common_prefix_size(struct slice a, struct slice b);
     @@ reftable/stack.c (new)
      +#include "system.h"
      +#include "merged.h"
      +#include "reader.h"
     ++#include "refname.h"
      +#include "reftable.h"
      +#include "writer.h"
      +
     @@ reftable/stack.c (new)
      +{
      +	struct reftable_stack *p =
      +		reftable_calloc(sizeof(struct reftable_stack));
     -+	struct slice list_file_name = {};
     ++	struct slice list_file_name = { 0 };
      +	int err = 0;
      +
      +	if (config.hash_id == 0) {
     @@ reftable/stack.c (new)
      +			}
      +		}
      +	}
     ++
      +exit:
      +	slice_clear(&table_path);
      +	{
     @@ reftable/stack.c (new)
      +		free_names(names);
      +		free_names(names_after);
      +
     -+		delay = delay + (delay * rand()) / RAND_MAX + 100;
     -+		usleep(delay);
     ++		delay = delay + (delay * rand()) / RAND_MAX + 1;
     ++		sleep_millisec(delay);
      +	}
      +
      +	return 0;
     @@ reftable/stack.c (new)
      +	int err = stack_try_add(st, write, arg);
      +	if (err < 0) {
      +		if (err == REFTABLE_LOCK_ERROR) {
     -+			// Ignore error return, we want to propagate
     -+			// REFTABLE_LOCK_ERROR.
     ++			/* Ignore error return, we want to propagate
     ++			   REFTABLE_LOCK_ERROR.
     ++			*/
      +			reftable_stack_reload(st);
      +		}
      +		return err;
     @@ reftable/stack.c (new)
      +void reftable_addition_close(struct reftable_addition *add)
      +{
      +	int i = 0;
     -+	struct slice nm = {};
     ++	struct slice nm = { 0 };
      +	for (i = 0; i < add->new_tables_len; i++) {
      +		slice_set_string(&nm, add->stack->list_file);
      +		slice_append_string(&nm, "/");
      +		slice_append_string(&nm, add->new_tables[i]);
      +		unlink(slice_as_string(&nm));
     -+
      +		reftable_free(add->new_tables[i]);
      +		add->new_tables[i] = NULL;
      +	}
     @@ reftable/stack.c (new)
      +
      +	free_names(add->names);
      +	add->names = NULL;
     ++	slice_clear(&nm);
      +}
      +
      +int reftable_addition_commit(struct reftable_addition *add)
     @@ reftable/stack.c (new)
      +	struct reftable_writer *wr = NULL;
      +	int err = 0;
      +	int tab_fd = 0;
     -+	uint64_t next_update_index = 0;
      +
      +	slice_resize(&next_name, 0);
     -+	format_name(&next_name, next_update_index, next_update_index);
     ++	format_name(&next_name, add->next_update_index, add->next_update_index);
      +
      +	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
      +	slice_append_string(&temp_tab_file_name, "/");
     @@ reftable/stack.c (new)
      +		goto exit;
      +	}
      +
     -+	if (wr->min_update_index < next_update_index) {
     ++	err = stack_check_addition(add->stack,
     ++				   slice_as_string(&temp_tab_file_name));
     ++	if (err < 0) {
     ++		goto exit;
     ++	}
     ++
     ++	if (wr->min_update_index < add->next_update_index) {
      +		err = REFTABLE_API_ERROR;
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +	struct reftable_ref_record ref = { 0 };
      +	struct reftable_log_record log = { 0 };
      +
     ++	uint64_t entries = 0;
     ++
      +	int i = 0, j = 0;
      +	for (i = first, j = 0; i <= last; i++) {
      +		struct reftable_reader *t = st->merged->stack[i];
     @@ reftable/stack.c (new)
      +		if (err < 0) {
      +			break;
      +		}
     ++		entries++;
      +	}
     ++	reftable_iterator_destroy(&it);
      +
      +	err = reftable_merged_table_seek_log(mt, &it, "");
      +	if (err < 0) {
     @@ reftable/stack.c (new)
      +			continue;
      +		}
      +
     -+		/* XXX collect stats? */
     -+
      +		if (config != NULL && config->time > 0 &&
      +		    log.time < config->time) {
      +			continue;
     @@ reftable/stack.c (new)
      +		if (err < 0) {
      +			break;
      +		}
     ++		entries++;
      +	}
      +
      +exit:
     @@ reftable/stack.c (new)
      +		reftable_merged_table_free(mt);
      +	}
      +	reftable_ref_record_clear(&ref);
     -+
     ++	reftable_log_record_clear(&log);
     ++	st->stats.entries_written += entries;
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +		}
      +		goto exit;
      +	}
     ++	/* Don't want to write to the lock for now.  */
     ++	close(lock_file_fd);
     ++	lock_file_fd = 0;
     ++
      +	have_lock = true;
      +	err = stack_uptodate(st);
      +	if (err != 0) {
     @@ reftable/stack.c (new)
      +	}
      +	have_lock = false;
      +
     ++	/* Reload the stack before deleting. On windows, we can only delete the
     ++	   files after we closed them.
     ++	*/
     ++	err = reftable_stack_reload_maybe_reuse(st, first < last);
     ++
      +	{
      +		char **p = delete_on_success;
      +		while (*p) {
     @@ reftable/stack.c (new)
      +		}
      +	}
      +
     -+	err = reftable_stack_reload_maybe_reuse(st, first < last);
      +exit:
      +	free_names(delete_on_success);
      +	{
     @@ reftable/stack.c (new)
      +int fastlog2(uint64_t sz)
      +{
      +	int l = 0;
     -+	assert(sz > 0);
     ++	if (sz == 0) {
     ++		return 0;
     ++	}
      +	for (; sz; sz /= 2) {
      +		l++;
      +	}
     @@ reftable/stack.c (new)
      +	int next = 0;
      +	struct segment cur = { 0 };
      +	int i = 0;
     ++
     ++	if (n == 0) {
     ++		*seglen = 0;
     ++		return segs;
     ++	}
      +	for (i = 0; i < n; i++) {
      +		int log = fastlog2(sizes[i]);
      +		if (cur.log != log && cur.bytes > 0) {
     @@ reftable/stack.c (new)
      +		cur.end = i + 1;
      +		cur.bytes += sizes[i];
      +	}
     -+	if (next > 0) {
     -+		segs[next++] = cur;
     -+	}
     ++	segs[next++] = cur;
      +	*seglen = next;
      +	return segs;
      +}
     @@ reftable/stack.c (new)
      +	uint64_t *sizes =
      +		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
      +	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
     -+	int overhead = footer_size(version) + header_size(version) - 1;
     ++	int overhead = header_size(version) - 1;
      +	int i = 0;
      +	for (i = 0; i < st->merged->stack_len; i++) {
      +		sizes[i] = st->merged->stack[i]->size - overhead;
     @@ reftable/stack.c (new)
      +int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
      +			    struct reftable_ref_record *ref)
      +{
     ++	struct reftable_table tab = { NULL };
     ++	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     ++	return reftable_table_read_ref(tab, refname, ref);
     ++}
     ++
     ++int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_log_record *log)
     ++{
      +	struct reftable_iterator it = { 0 };
      +	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     -+	int err = reftable_merged_table_seek_ref(mt, &it, refname);
     ++	int err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	err = reftable_iterator_next_ref(it, ref);
     ++	err = reftable_iterator_next_log(it, log);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	if (strcmp(ref->ref_name, refname) ||
     -+	    reftable_ref_record_is_deletion(ref)) {
     ++	if (strcmp(log->ref_name, refname) ||
     ++	    reftable_log_record_is_deletion(log)) {
      +		err = 1;
      +		goto exit;
      +	}
      +
      +exit:
     ++	if (err) {
     ++		reftable_log_record_clear(log);
     ++	}
      +	reftable_iterator_destroy(&it);
      +	return err;
      +}
      +
     -+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     -+			    struct reftable_log_record *log)
     ++int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
      +{
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     -+	int err = reftable_merged_table_seek_log(mt, &it, refname);
     -+	if (err) {
     ++	int err = 0;
     ++	struct reftable_block_source src = { 0 };
     ++	struct reftable_reader *rd = NULL;
     ++	struct reftable_table tab = { NULL };
     ++	struct reftable_ref_record *refs = NULL;
     ++	struct reftable_iterator it = { NULL };
     ++	int cap = 0;
     ++	int len = 0;
     ++	int i = 0;
     ++
     ++	if (st->config.skip_name_check) {
     ++		return 0;
     ++	}
     ++
     ++	err = reftable_block_source_from_file(&src, new_tab_name);
     ++	if (err < 0) {
      +		goto exit;
      +	}
      +
     -+	err = reftable_iterator_next_log(it, log);
     -+	if (err) {
     ++	err = reftable_new_reader(&rd, src, new_tab_name);
     ++	if (err < 0) {
      +		goto exit;
      +	}
      +
     -+	if (strcmp(log->ref_name, refname) ||
     -+	    reftable_log_record_is_deletion(log)) {
     -+		err = 1;
     ++	err = reftable_reader_seek_ref(rd, &it, "");
     ++	if (err > 0) {
     ++		err = 0;
      +		goto exit;
      +	}
     ++	if (err < 0) {
     ++		goto exit;
     ++	}
     ++
     ++	while (true) {
     ++		struct reftable_ref_record ref = { 0 };
     ++		err = reftable_iterator_next_ref(it, &ref);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0) {
     ++			goto exit;
     ++		}
     ++
     ++		if (len >= cap) {
     ++			cap = 2 * cap + 1;
     ++			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
     ++		}
     ++
     ++		refs[len++] = ref;
     ++	}
     ++
     ++	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     ++
     ++	err = validate_ref_record_addition(tab, refs, len);
     ++
     ++	for (i = 0; i < len; i++) {
     ++		reftable_ref_record_clear(&refs[i]);
     ++	}
      +
      +exit:
     ++	free(refs);
      +	reftable_iterator_destroy(&it);
     ++	reftable_reader_free(rd);
      +	return err;
      +}
      
     @@ reftable/stack.h (new)
      +			int first, int last,
      +			struct reftable_log_expiry_config *config);
      +int fastlog2(uint64_t sz);
     ++int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
      +
      +struct segment {
      +	int start, end;
     @@ reftable/system.h (new)
      +#if 1 /* REFTABLE_IN_GITCORE */
      +
      +#include "git-compat-util.h"
     ++#include "cache.h"
      +#include <zlib.h>
      +
      +#else
     @@ reftable/update.sh (new)
      +set -eu
      +
      +# Override this to import from somewhere else, say "../reftable".
     -+SRC=${SRC:-origin} BRANCH=${BRANCH:-origin/master}
     ++SRC=${SRC:-origin}
     ++BRANCH=${BRANCH:-master}
      +
     -+((git --git-dir reftable-repo/.git fetch ${SRC} && cd reftable-repo && git checkout ${BRANCH} ) ||
     ++((git --git-dir reftable-repo/.git fetch ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
      +   git clone https://github.com/google/reftable reftable-repo)
      +
      +cp reftable-repo/c/*.[ch] reftable/
      +cp reftable-repo/c/include/*.[ch] reftable/
      +cp reftable-repo/LICENSE reftable/
     -+git --git-dir reftable-repo/.git show --no-patch origin/master \
     ++git --git-dir reftable-repo/.git show --no-patch HEAD \
      +  > reftable/VERSION
      +
      +mv reftable/system.h reftable/system.h~
     @@ reftable/writer.c (new)
      +}
      +
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, byte *, int), void *writer_arg,
     -+		    struct reftable_write_options *opts)
     ++reftable_new_writer(int (*writer_func)(void *, byte *, size_t),
     ++		    void *writer_arg, struct reftable_write_options *opts)
      +{
      +	struct reftable_writer *wp =
      +		reftable_calloc(sizeof(struct reftable_writer));
     @@ reftable/writer.c (new)
      +	}
      +	w->pending_padding = 0;
      +	if (empty_table) {
     -+		// Empty tables need a header anyway.
     ++		/* Empty tables need a header anyway. */
      +		byte header[28];
      +		int n = writer_write_header(w, header);
      +		err = padded_write(w, header, n, 0);
     @@ reftable/writer.h (new)
      +#include "tree.h"
      +
      +struct reftable_writer {
     -+	int (*write)(void *, byte *, int);
     ++	int (*write)(void *, byte *, size_t);
      +	void *write_arg;
      +	int pending_padding;
      +	struct slice last_key;
 10:  be2371cd6e4 !  9:  d731e1669b7 Reftable support for git-core
     @@ Commit message
      
           * Resolve spots marked with XXX
      
     -     * Detect and prevent directory/file conflicts in naming.
     -
           * Support worktrees (t0002-gitfile "linked repo" testcase)
      
          Example use: see t/t0031-reftable.sh
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
       VCSSVN_LIB = vcs-svn/lib.a
      +REFTABLE_LIB = reftable/libreftable.a
       
     + GENERATED_H += config-list.h
       GENERATED_H += command-list.h
     - 
     -@@ Makefile: LIB_OBJS += rebase-interactive.o
     +@@ Makefile: LIB_OBJS += ref-filter.o
       LIB_OBJS += reflog-walk.o
       LIB_OBJS += refs.o
       LIB_OBJS += refs/files-backend.o
     @@ Makefile: THIRD_PARTY_SOURCES += compat/regex/%
       EXTLIBS =
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
     -@@ Makefile: VCSSVN_OBJS += vcs-svn/fast_export.o
     +@@ Makefile: VCSSVN_OBJS += vcs-svn/sliding_window.o
       VCSSVN_OBJS += vcs-svn/svndiff.o
       VCSSVN_OBJS += vcs-svn/svndump.o
       
      +REFTABLE_OBJS += reftable/basics.o
      +REFTABLE_OBJS += reftable/block.o
     -+REFTABLE_OBJS += reftable/bytes.o
      +REFTABLE_OBJS += reftable/file.o
      +REFTABLE_OBJS += reftable/iter.o
      +REFTABLE_OBJS += reftable/merged.o
      +REFTABLE_OBJS += reftable/pq.o
      +REFTABLE_OBJS += reftable/reader.o
      +REFTABLE_OBJS += reftable/record.o
     ++REFTABLE_OBJS += reftable/refname.o
     ++REFTABLE_OBJS += reftable/reftable.o
      +REFTABLE_OBJS += reftable/slice.o
      +REFTABLE_OBJS += reftable/stack.o
      +REFTABLE_OBJS += reftable/tree.o
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      +	reinit = (!access(path, R_OK) ||
      +		  readlink(path, junk, sizeof(junk) - 1) != -1);
      +
     -+        /*
     -+         * refs/heads is a file when using reftable. We can't reinitialize with
     -+         * a reftable because it will overwrite HEAD
     -+         */
     ++	/*
     ++	 * refs/heads is a file when using reftable. We can't reinitialize with
     ++	 * a reftable because it will overwrite HEAD
     ++	 */
      +	if (reinit && (!strcmp(fmt->ref_storage, "reftable")) ==
      +			      is_directory(git_path_buf(&buf, "refs/heads"))) {
      +		die("cannot switch ref storage format.");
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	/*
       	 * We need to create a "refs" dir in any case so that older
       	 * versions of git can tell that this is a repository.
     - 	 */
     --
     - 	if (refs_init_db(&err))
     - 		die("failed to set up refs db: %s", err.buf);
     - 
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	 * Create the default symlink from ".git/HEAD" to the "master"
       	 * branch, if it does not exist yet.
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	if (!reinit) {
       		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
       			exit(1);
     --	}
     --
     --	initialize_repository_version(fmt->hash_algo);
     -+	} 
     + 	}
       
     +-	initialize_repository_version(fmt->hash_algo);
      +	initialize_repository_version(fmt->hash_algo, fmt->ref_storage);
     -+        
     + 
       	/* Check filemode trustability */
       	path = git_path_buf(&buf, "config");
     - 	filemode = TEST_FILEMODE;
      @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
       }
       
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       		BUG("attempting to get main_ref_store outside of repository");
       
      -	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
     -+	r->refs_private = ref_store_init(
     -+                r->gitdir,
     -+                r->ref_storage_format ? r->ref_storage_format : DEFAULT_REF_STORAGE,
     -+                REF_STORE_ALL_CAPS);
     ++	r->refs_private = ref_store_init(r->gitdir,
     ++					 r->ref_storage_format ?
     ++						 r->ref_storage_format :
     ++						 DEFAULT_REF_STORAGE,
     ++					 REF_STORE_ALL_CAPS);
       	return r->refs_private;
       }
       
     @@ refs/reftable-backend.c (new)
      +	unsigned int store_flags;
      +
      +	int err;
     -+        char *repo_dir;
     ++	char *repo_dir;
      +	char *reftable_dir;
      +	struct reftable_stack *stack;
      +};
     @@ refs/reftable-backend.c (new)
      +
      +	base_ref_store_init(ref_store, &refs_be_reftable);
      +	refs->store_flags = store_flags;
     -+        refs->repo_dir = xstrdup(path);
     ++	refs->repo_dir = xstrdup(path);
      +	strbuf_addf(&sb, "%s/reftable", path);
      +	refs->reftable_dir = xstrdup(sb.buf);
      +	strbuf_reset(&sb);
     @@ refs/reftable-backend.c (new)
      +	strbuf_addf(&sb, "%s/refs/heads", refs->repo_dir);
      +	write_file(sb.buf, "this repository uses the reftable format");
      +
     -+        return 0;
     ++	return 0;
      +}
      +
      +struct git_reftable_iterator {
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	err = reftable_stack_read_ref(refs->stack, refname, &ref);
     -+        if (err > 0) {
     -+                errno = ENOENT;
     -+                err = -1;
     -+                goto exit;
     -+        }
     ++	if (err > 0) {
     ++		errno = ENOENT;
     ++		err = -1;
     ++		goto exit;
     ++	}
      +	if (err < 0) {
     -+                errno = reftable_error_to_errno(err);
     -+                err = -1;
     ++		errno = reftable_error_to_errno(err);
     ++		err = -1;
      +		goto exit;
      +	}
      +	if (ref.target != NULL) {
     @@ refs/reftable-backend.c (new)
      +	} else if (ref.value != NULL) {
      +		hashcpy(oid->hash, ref.value);
      +	} else {
     -+                *type |= REF_ISBROKEN;
     -+                errno = EINVAL;
     -+                err = -1;
     -+        }
     ++		*type |= REF_ISBROKEN;
     ++		errno = EINVAL;
     ++		err = -1;
     ++	}
      +exit:
      +	reftable_ref_record_clear(&ref);
      +	return err;
     @@ refs/reftable-backend.c (new)
      +	reftable_reflog_expire
      +};
      
     - ## reftable/update.sh ##
     -@@ reftable/update.sh: SRC=${SRC:-origin} BRANCH=${BRANCH:-origin/master}
     - cp reftable-repo/c/*.[ch] reftable/
     - cp reftable-repo/c/include/*.[ch] reftable/
     - cp reftable-repo/LICENSE reftable/
     --git --git-dir reftable-repo/.git show --no-patch origin/master \
     -+git --git-dir reftable-repo/.git show --no-patch ${BRANCH} \
     -   > reftable/VERSION
     - 
     - mv reftable/system.h reftable/system.h~
     -
       ## repository.c ##
      @@ repository.c: int repo_init(struct repository *repo,
       	if (worktree)
     @@ t/t0031-reftable.sh (new)
      +	git checkout -b master
      +'
      +
     ++
     ++test_expect_success 'dir/file conflict' '
     ++	initialize &&
     ++	test_commit file &&
     ++	! git branch master/forbidden
     ++'
     ++
     ++
      +test_expect_success 'do not clobber existing repo' '
      +	rm -rf .git &&
      +	git init --ref-storage=files &&
     @@ t/t0031-reftable.sh (new)
      +	test_cmp expect actual
      +'
      +
     ++
      +test_done
     ++
  -:  ----------- > 10:  513d585f0f8 vcxproj: adjust for the reftable changes
 11:  8af67b85e49 ! 11:  846fe29fa4b Add some reftable testing infrastructure
     @@ builtin/init-db.c: static const char *const init_db_usage[] = {
      
       ## refs.c ##
      @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
     - 	if (!r->gitdir)
     - 		BUG("attempting to get main_ref_store outside of repository");
     - 
     --	r->refs_private = ref_store_init(
     --                r->gitdir,
     --                r->ref_storage_format ? r->ref_storage_format : DEFAULT_REF_STORAGE,
     --                REF_STORE_ALL_CAPS);
     -+	r->refs_private = ref_store_init(r->gitdir,
     -+					 r->ref_storage_format ?
     -+						 r->ref_storage_format :
     + 	r->refs_private = ref_store_init(r->gitdir,
     + 					 r->ref_storage_format ?
     + 						 r->ref_storage_format :
     +-						 DEFAULT_REF_STORAGE,
      +						 default_ref_storage(),
     -+					 REF_STORE_ALL_CAPS);
     + 					 REF_STORE_ALL_CAPS);
       	return r->refs_private;
       }
     - 
      @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
       		goto done;
       
 12:  b02b83a92ad = 12:  a7d1d2e721c t: use update-ref and show-ref to reading/writing refs

-- 
gitgitgadget
