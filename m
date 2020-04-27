Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBADAC81BC1
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD112074F
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAnr2Aaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD0UUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726818AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D48C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so344604wmg.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qFroDduybF8VftKVjy2pTtKtOxcBNqTSEHPajJ1VCDA=;
        b=lAnr2Aaa3S/VxsF6ybjWjo+/F/2E2RjQCrS/SUYUXw1igdAoFHZs24MxosMrH49X5A
         k5fbaAdfNwWdFVOiHn35IlQiPM9aFr0rBxuQ2L4gfj/uQsaEzwZVcyM5q1lVvQ6SFY3B
         uCxebYu5K7QBH23WN3T0BTXlbQr2AqcKhQuT2dVV5JEyQrwIaucirCWbMBYvYvTYedH4
         lzShsbAL6jVA5ujtZltAM1ZkSt136XtzBHZLqd+65IVmOMp7KKD/cGKZGAfXYDeFKlCr
         MU9E8AOBya3ygCz/7K1NK9q+q01K3uxxJe8nYf3N0jwBVmmqBINFkHbx+51++SCtQ8QV
         DceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qFroDduybF8VftKVjy2pTtKtOxcBNqTSEHPajJ1VCDA=;
        b=A7ztu0qIeJHrLmBkeo+dXPTJ3VH2uAdrqC5qZLjVhOZcSYylmQO9BObolEmsHvK5my
         orS+OwzC6bXbRXKvi8BLFV9Pt4Tz01byKqMQD3E8//l2n3vNDsLezvQlUcgbcffaZS7c
         TgbqHz1Std0te4h0bUlhH8LxYkbfbN2ALAO+G14bRGPbO6ZYKrQXneKBvQheqmyfzxeh
         mh24mmc+4qB71mF6jHz093Jl+hBsoOFimBVKobVbxUCkwb9CMai9GNf0gxtJPb3KNKny
         8GV1N/CxxOqomGgqUSC5hjYRJ6FdzQAcnhUvoCizhZ+4q1/wmoU4Cav0JOqP0uVZrenY
         Aw1g==
X-Gm-Message-State: AGi0Pua53HeCwrslnK68MZecDS5hbhLiq8iHWBurH9eOe6bzxVwZmJ5m
        Yk+CtvN+FzZ4BRZg70fylP7mFTss
X-Google-Smtp-Source: APiQypKrJwH1yx0Cf8RLhvXe29Ea+5GLyhhDKgxsXsNlV0qOD4h/9DD5nLmzl8P0aE4HdNsRP8F/EQ==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr426455wmc.11.1588018419954;
        Mon, 27 Apr 2020 13:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f83sm304635wmf.42.2020.04.27.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:39 -0700 (PDT)
Message-Id: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:26 +0000
Subject: [PATCH v10 00/12] Reftable support git-core
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

Summary 18816 tests pass 2994 tests fail

Some issues:

 * worktree support looks broken
 * no detection for file/dir conflicts. You can have branch {a, a/b}
   simultaneously.
 * submodules (eg. t1013)
 * many tests inspect .git/logs/ directly.

v13

 * Avoid exposing tombstones from reftable_stack to git 
 * Write peeled tags
 * Fix GC issue: use git-refpack in test
 * Fix unborn branches: must propagate errno from read_raw_ref.
 * add GIT_TEST_REFTABLE environment to control default.
 * add REFTABLE test prerequisite.
 * fix & test update-ref -d.
 * print error message for failed update-ref transactions.

Han-Wen Nienhuys (11):
  refs.h: clarify reflog iteration order
  Iterate over the "refs/" namespace in for_each_[raw]ref
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add .gitattributes for the reftable/ directory
  reftable: define version 2 of the spec to accomodate SHA256
  reftable: clarify how empty tables should be written
  Add reftable library
  Reftable support for git-core
  Add some reftable testing infrastructure
  t: use update-ref and show-ref to reading/writing refs

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1080 ++++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   26 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   63 +-
 cache.h                                       |    6 +-
 refs.c                                        |   33 +-
 refs.h                                        |    8 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1045 +++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  209 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  425 ++++++
 reftable/block.h                              |  124 ++
 reftable/blocksource.h                        |   22 +
 reftable/bytes.c                              |    0
 reftable/config.h                             |    1 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |   97 ++
 reftable/file.c                               |   98 ++
 reftable/iter.c                               |  234 ++++
 reftable/iter.h                               |   60 +
 reftable/merged.c                             |  327 +++++
 reftable/merged.h                             |   36 +
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  754 +++++++++++
 reftable/reader.h                             |   68 +
 reftable/record.c                             | 1126 ++++++++++++++++
 reftable/record.h                             |  121 ++
 reftable/reftable.h                           |  527 ++++++++
 reftable/slice.c                              |  224 ++++
 reftable/slice.h                              |   76 ++
 reftable/stack.c                              | 1151 +++++++++++++++++
 reftable/stack.h                              |   44 +
 reftable/system.h                             |   53 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   23 +
 reftable/writer.c                             |  661 ++++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0002-gitfile.sh                            |    2 +-
 t/t0031-reftable.sh                           |   99 ++
 t/t1400-update-ref.sh                         |   32 +-
 t/t1506-rev-parse-diagnosis.sh                |    2 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/t6050-replace.sh                            |    2 +-
 t/t9020-remote-svn.sh                         |    4 +-
 t/test-lib.sh                                 |    5 +
 59 files changed, 9378 insertions(+), 60 deletions(-)
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
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/config.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
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


base-commit: e870325ee8575d5c3d7afe0ba2c9be072c692b65
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v9:

  1:  b600d0bc6dd =  1:  d3d8ed2032c refs.h: clarify reflog iteration order
  2:  89b68145e8f =  2:  45fd65f72e0 Iterate over the "refs/" namespace in for_each_[raw]ref
  3:  91f1efe24ec =  3:  bc89bcd9c8c create .git/refs in files-backend.c
  4:  56f65a2a0d7 =  4:  fd67cdff0cd refs: document how ref_iterator_advance_fn should handle symrefs
  5:  b432c1cc2ae =  5:  5373828f854 Add .gitattributes for the reftable/ directory
  6:  b1d94be691a =  6:  8eeed29ebbf reftable: file format documentation
  7:  3e418d27f67 =  7:  5ebc272e23d reftable: define version 2 of the spec to accomodate SHA256
  8:  6f62be4067b =  8:  95aae041613 reftable: clarify how empty tables should be written
  9:  a30001ad1e8 !  9:  59209a5ad39 Add reftable library
     @@ Commit message
      
          * reftable.h - the public API
      
     +    * record.{c,h} - reading and writing records
     +
          * block.{c,h} - reading and writing blocks.
      
          * writer.{c,h} - writing a complete reftable file.
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit b68690acad769d59e80cbb4f79c442ece133e6bd
     ++commit a6d6b31bea256044621d789df64a8159647f21bc
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon Apr 20 21:33:11 2020 +0200
     ++Date:   Mon Apr 27 20:46:21 2020 +0200
      +
     -+    C: fix search/replace error in dump.c
     ++    C: prefix error codes with REFTABLE_
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/basics.c (new)
      +const char *reftable_error_str(int err)
      +{
      +	switch (err) {
     -+	case IO_ERROR:
     ++	case REFTABLE_IO_ERROR:
      +		return "I/O error";
     -+	case FORMAT_ERROR:
     -+		return "FORMAT_ERROR";
     -+	case NOT_EXIST_ERROR:
     -+		return "NOT_EXIST_ERROR";
     -+	case LOCK_ERROR:
     -+		return "LOCK_ERROR";
     -+	case API_ERROR:
     -+		return "API_ERROR";
     -+	case ZLIB_ERROR:
     -+		return "ZLIB_ERROR";
     ++	case REFTABLE_FORMAT_ERROR:
     ++		return "corrupt reftable file";
     ++	case REFTABLE_NOT_EXIST_ERROR:
     ++		return "file does not exist";
     ++	case REFTABLE_LOCK_ERROR:
     ++		return "data is outdated";
     ++	case REFTABLE_API_ERROR:
     ++		return "misuse of the reftable API";
     ++	case REFTABLE_ZLIB_ERROR:
     ++		return "zlib failure";
      +	case -1:
      +		return "general error";
      +	default:
     @@ reftable/basics.c (new)
      +	}
      +}
      +
     ++int reftable_error_to_errno(int err) {
     ++	switch (err) {
     ++	case REFTABLE_IO_ERROR:
     ++		return EIO;
     ++	case REFTABLE_FORMAT_ERROR:
     ++		return EFAULT;
     ++	case REFTABLE_NOT_EXIST_ERROR:
     ++		return ENOENT;
     ++	case REFTABLE_LOCK_ERROR:
     ++		return EBUSY;
     ++	case REFTABLE_API_ERROR:
     ++		return EINVAL;
     ++	case REFTABLE_ZLIB_ERROR:
     ++		return EDOM;
     ++	default:
     ++		return ERANGE;
     ++	}
     ++}
     ++
     ++
      +void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
      +void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
      +void (*reftable_free_ptr)(void *) = &free;
     @@ reftable/block.c (new)
      +
      +			if (Z_OK != zresult) {
      +				slice_clear(&compressed);
     -+				return ZLIB_ERROR;
     ++				return REFTABLE_ZLIB_ERROR;
      +			}
      +
      +			memcpy(w->buf + block_header_skip, compressed.buf,
     @@ reftable/block.c (new)
      +	uint32_t sz = get_be24(block->data + header_off + 1);
      +
      +	if (!is_block_type(typ)) {
     -+		return FORMAT_ERROR;
     ++		return REFTABLE_FORMAT_ERROR;
      +	}
      +
      +	if (typ == BLOCK_TYPE_LOG) {
     @@ reftable/block.c (new)
      +				    &dst_len, block->data + block_header_skip,
      +				    &src_len)) {
      +			slice_clear(&uncompressed);
     -+			return ZLIB_ERROR;
     ++			return REFTABLE_ZLIB_ERROR;
      +		}
      +
      +		block_source_return_block(block->source, block);
     @@ reftable/file.c (new)
      +	int fd = open(name, O_RDONLY);
      +	if (fd < 0) {
      +		if (errno == ENOENT) {
     -+			return NOT_EXIST_ERROR;
     ++			return REFTABLE_NOT_EXIST_ERROR;
      +		}
      +		return -1;
      +	}
     @@ reftable/iter.c (new)
      +		}
      +		if (err > 0) {
      +			/* indexed block does not exist. */
     -+			return FORMAT_ERROR;
     ++			return REFTABLE_FORMAT_ERROR;
      +		}
      +	}
      +	block_reader_start(&it->block_reader, &it->cur);
     @@ reftable/merged.c (new)
      +	return 0;
      +}
      +
     -+static int merged_iter_next(struct merged_iter *mi, struct record rec)
     ++static int merged_iter_next_entry(struct merged_iter *mi, struct record rec)
      +{
      +	struct slice entry_key = { 0 };
     -+	struct pq_entry entry = merged_iter_pqueue_remove(&mi->pq);
     -+	int err = merged_iter_advance_subiter(mi, entry.index);
     ++	struct pq_entry entry = { 0 };
     ++	int err = 0;
     ++
     ++	if (merged_iter_pqueue_is_empty(mi->pq)) {
     ++		return 1;
     ++	}
     ++
     ++	entry = merged_iter_pqueue_remove(&mi->pq);
     ++	err = merged_iter_advance_subiter(mi, entry.index);
      +	if (err < 0) {
      +		return err;
      +	}
      +
     -+
     -+        /*
     -+          One can also use reftable as datacenter-local storage, where the ref
     -+          database is maintained in globally consistent database (eg.
     -+          CockroachDB or Spanner). In this scenario, replication delays together
     -+          with compaction may cause newer tables to contain older entries. In
     -+          such a deployment, the loop below must be changed to collect all
     -+          entries for the same key, and return new the newest one.
     -+        */
     ++	/*
     ++	  One can also use reftable as datacenter-local storage, where the ref
     ++	  database is maintained in globally consistent database (eg.
     ++	  CockroachDB or Spanner). In this scenario, replication delays together
     ++	  with compaction may cause newer tables to contain older entries. In
     ++	  such a deployment, the loop below must be changed to collect all
     ++	  entries for the same key, and return new the newest one.
     ++	*/
      +	record_key(entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     @@ reftable/merged.c (new)
      +	return 0;
      +}
      +
     ++static int merged_iter_next(struct merged_iter *mi, struct record rec)
     ++{
     ++	while (true) {
     ++		int err = merged_iter_next_entry(mi, rec);
     ++		if (err == 0 && mi->suppress_deletions &&
     ++		    record_is_deletion(rec)) {
     ++			continue;
     ++		}
     ++
     ++		return err;
     ++	}
     ++}
     ++
      +static int merged_iter_next_void(void *p, struct record rec)
      +{
      +	struct merged_iter *mi = (struct merged_iter *)p;
     @@ reftable/merged.c (new)
      +	for (i = 0; i < n; i++) {
      +		struct reftable_reader *r = stack[i];
      +		if (r->hash_id != hash_id) {
     -+			return FORMAT_ERROR;
     ++			return REFTABLE_FORMAT_ERROR;
      +		}
      +		if (i > 0 && last_max >= reftable_reader_min_update_index(r)) {
     -+			return FORMAT_ERROR;
     ++			return REFTABLE_FORMAT_ERROR;
      +		}
      +		if (i == 0) {
      +			first_min = reftable_reader_min_update_index(r);
     @@ reftable/merged.c (new)
      +		.stack = iters,
      +		.typ = record_type(rec),
      +		.hash_id = mt->hash_id,
     ++		.suppress_deletions = mt->suppress_deletions,
      +	};
      +	int n = 0;
      +	int err = 0;
     @@ reftable/merged.h (new)
      +	struct reftable_reader **stack;
      +	int stack_len;
      +	uint32_t hash_id;
     ++	bool suppress_deletions;
      +
      +	uint64_t min;
      +	uint64_t max;
     @@ reftable/merged.h (new)
      +	uint32_t hash_id;
      +	int stack_len;
      +	byte typ;
     ++	bool suppress_deletions;
      +	struct merged_iter_pqueue pq;
      +};
      +
     @@ reftable/reader.c (new)
      +	byte *f = footer;
      +	int err = 0;
      +	if (memcmp(f, "REFT", 4)) {
     -+		err = FORMAT_ERROR;
     ++		err = REFTABLE_FORMAT_ERROR;
      +		goto exit;
      +	}
      +	f += 4;
      +
      +	if (memcmp(footer, header, header_size(r->version))) {
     -+		err = FORMAT_ERROR;
     ++		err = REFTABLE_FORMAT_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/reader.c (new)
      +		case SHA256_ID:
      +			break;
      +		default:
     -+			err = FORMAT_ERROR;
     ++			err = REFTABLE_FORMAT_ERROR;
      +			goto exit;
      +		}
      +		f += 4;
     @@ reftable/reader.c (new)
      +		uint32_t file_crc = get_be32(f);
      +		f += 4;
      +		if (computed_crc != file_crc) {
     -+			err = FORMAT_ERROR;
     ++			err = REFTABLE_FORMAT_ERROR;
      +			goto exit;
      +		}
      +	}
     @@ reftable/reader.c (new)
      +	/* Need +1 to read type of first block. */
      +	err = block_source_read_block(source, &header, 0, header_size(2) + 1);
      +	if (err != header_size(2) + 1) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
      +	if (memcmp(header.data, "REFT", 4)) {
     -+		err = FORMAT_ERROR;
     ++		err = REFTABLE_FORMAT_ERROR;
      +		goto exit;
      +	}
      +	r->version = header.data[4];
      +	if (r->version != 1 && r->version != 2) {
     -+		err = FORMAT_ERROR;
     ++		err = REFTABLE_FORMAT_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/reader.c (new)
      +	err = block_source_read_block(source, &footer, r->size,
      +				      footer_size(r->version));
      +	if (err != footer_size(r->version)) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/reader.c (new)
      +static int table_iter_next(struct table_iter *ti, struct record rec)
      +{
      +	if (record_type(rec) != ti->typ) {
     -+		return API_ERROR;
     ++		return REFTABLE_API_ERROR;
      +	}
      +
      +	while (true) {
     @@ reftable/reader.c (new)
      +		}
      +
      +		if (next.typ != BLOCK_TYPE_INDEX) {
     -+			err = FORMAT_ERROR;
     ++			err = REFTABLE_FORMAT_ERROR;
      +			break;
      +		}
      +
     @@ reftable/record.c (new)
      +	return start_len - in.len;
      +}
      +
     -+static byte reftable_ref_record_type(void)
     -+{
     -+	return BLOCK_TYPE_REF;
     -+}
     -+
      +static void reftable_ref_record_key(const void *r, struct slice *dest)
      +{
      +	const struct reftable_ref_record *rec =
     @@ reftable/record.c (new)
      +	}
      +}
      +
     -+void reftable_ref_record_print(struct reftable_ref_record *ref, int hash_size)
     ++void reftable_ref_record_print(struct reftable_ref_record *ref,
     ++			       uint32_t hash_id)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
     -+
      +	printf("ref{%s(%" PRIu64 ") ", ref->ref_name, ref->update_index);
      +	if (ref->value != NULL) {
     -+		hex_format(hex, ref->value, hash_size);
     ++		hex_format(hex, ref->value, hash_size(hash_id));
      +		printf("%s", hex);
      +	}
      +	if (ref->target_value != NULL) {
     -+		hex_format(hex, ref->target_value, hash_size);
     ++		hex_format(hex, ref->target_value, hash_size(hash_id));
      +		printf(" (T %s)", hex);
      +	}
      +	if (ref->target != NULL) {
     @@ reftable/record.c (new)
      +	return start.len - in.len;
      +}
      +
     ++static bool reftable_ref_record_is_deletion_void(const void *p)
     ++{
     ++	return reftable_ref_record_is_deletion(
     ++		(const struct reftable_ref_record *)p);
     ++}
     ++
      +struct record_vtable reftable_ref_record_vtable = {
      +	.key = &reftable_ref_record_key,
     -+	.type = &reftable_ref_record_type,
     ++	.type = BLOCK_TYPE_REF,
      +	.copy_from = &reftable_ref_record_copy_from,
      +	.val_type = &reftable_ref_record_val_type,
      +	.encode = &reftable_ref_record_encode,
      +	.decode = &reftable_ref_record_decode,
      +	.clear = &reftable_ref_record_clear_void,
     ++	.is_deletion = &reftable_ref_record_is_deletion_void,
      +};
      +
     -+static byte obj_record_type(void)
     -+{
     -+	return BLOCK_TYPE_OBJ;
     -+}
     -+
      +static void obj_record_key(const void *r, struct slice *dest)
      +{
      +	const struct obj_record *rec = (const struct obj_record *)r;
     @@ reftable/record.c (new)
      +	return start.len - in.len;
      +}
      +
     ++static bool not_a_deletion(const void *p)
     ++{
     ++	return false;
     ++}
     ++
      +struct record_vtable obj_record_vtable = {
      +	.key = &obj_record_key,
     -+	.type = &obj_record_type,
     ++	.type = BLOCK_TYPE_OBJ,
      +	.copy_from = &obj_record_copy_from,
      +	.val_type = &obj_record_val_type,
      +	.encode = &obj_record_encode,
      +	.decode = &obj_record_decode,
      +	.clear = &obj_record_clear,
     ++	.is_deletion = not_a_deletion,
      +};
      +
     -+void reftable_log_record_print(struct reftable_log_record *log, int hash_size)
     ++void reftable_log_record_print(struct reftable_log_record *log,
     ++			       uint32_t hash_id)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
      +
      +	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->ref_name,
      +	       log->update_index, log->name, log->email, log->time,
      +	       log->tz_offset);
     -+	hex_format(hex, log->old_hash, hash_size);
     ++	hex_format(hex, log->old_hash, hash_size(hash_id));
      +	printf("%s => ", hex);
     -+	hex_format(hex, log->new_hash, hash_size);
     ++	hex_format(hex, log->new_hash, hash_size(hash_id));
      +	printf("%s\n\n%s\n}\n", hex, log->message);
      +}
      +
     -+static byte reftable_log_record_type(void)
     -+{
     -+	return BLOCK_TYPE_LOG;
     -+}
     -+
      +static void reftable_log_record_key(const void *r, struct slice *dest)
      +{
      +	const struct reftable_log_record *rec =
     @@ reftable/record.c (new)
      +	int n;
      +
      +	if (key.len <= 9 || key.buf[key.len - 9] != 0) {
     -+		return FORMAT_ERROR;
     ++		return REFTABLE_FORMAT_ERROR;
      +	}
      +
      +	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
     @@ reftable/record.c (new)
      +	}
      +
      +	if (in.len < 2 * hash_size) {
     -+		return FORMAT_ERROR;
     ++		return REFTABLE_FORMAT_ERROR;
      +	}
      +
      +	r->old_hash = reftable_realloc(r->old_hash, hash_size);
     @@ reftable/record.c (new)
      +
      +error:
      +	slice_clear(&dest);
     -+	return FORMAT_ERROR;
     ++	return REFTABLE_FORMAT_ERROR;
      +}
      +
      +static bool null_streq(char *a, char *b)
     @@ reftable/record.c (new)
      +	       a->update_index == b->update_index;
      +}
      +
     ++static bool reftable_log_record_is_deletion_void(const void *p)
     ++{
     ++	return reftable_log_record_is_deletion(
     ++		(const struct reftable_log_record *)p);
     ++}
     ++
      +struct record_vtable reftable_log_record_vtable = {
      +	.key = &reftable_log_record_key,
     -+	.type = &reftable_log_record_type,
     ++	.type = BLOCK_TYPE_LOG,
      +	.copy_from = &reftable_log_record_copy_from,
      +	.val_type = &reftable_log_record_val_type,
      +	.encode = &reftable_log_record_encode,
      +	.decode = &reftable_log_record_decode,
      +	.clear = &reftable_log_record_clear_void,
     ++	.is_deletion = &reftable_log_record_is_deletion_void,
      +};
      +
      +struct record new_record(byte typ)
     @@ reftable/record.c (new)
      +	reftable_free(record_yield(rec));
      +}
      +
     -+static byte index_record_type(void)
     -+{
     -+	return BLOCK_TYPE_INDEX;
     -+}
     -+
      +static void index_record_key(const void *r, struct slice *dest)
      +{
      +	struct index_record *rec = (struct index_record *)r;
     @@ reftable/record.c (new)
      +
      +struct record_vtable index_record_vtable = {
      +	.key = &index_record_key,
     -+	.type = &index_record_type,
     ++	.type = BLOCK_TYPE_INDEX,
      +	.copy_from = &index_record_copy_from,
      +	.val_type = &index_record_val_type,
      +	.encode = &index_record_encode,
      +	.decode = &index_record_decode,
      +	.clear = &index_record_clear,
     ++	.is_deletion = &not_a_deletion,
      +};
      +
      +void record_key(struct record rec, struct slice *dest)
     @@ reftable/record.c (new)
      +
      +byte record_type(struct record rec)
      +{
     -+	return rec.ops->type();
     ++	return rec.ops->type;
      +}
      +
      +int record_encode(struct record rec, struct slice dest, int hash_size)
     @@ reftable/record.c (new)
      +
      +void record_copy_from(struct record rec, struct record src, int hash_size)
      +{
     -+	assert(src.ops->type() == rec.ops->type());
     ++	assert(src.ops->type == rec.ops->type);
      +
      +	rec.ops->copy_from(rec.data, src.data, hash_size);
      +}
     @@ reftable/record.c (new)
      +	return rec.ops->clear(rec.data);
      +}
      +
     ++bool record_is_deletion(struct record rec)
     ++{
     ++	return rec.ops->is_deletion(rec.data);
     ++}
     ++
      +void record_from_ref(struct record *rec, struct reftable_ref_record *ref_rec)
      +{
      +	rec->data = ref_rec;
     @@ reftable/record.h (new)
      +	void (*key)(const void *rec, struct slice *dest);
      +
      +	/* The record type of ('r' for ref). */
     -+	byte (*type)(void);
     ++	byte type;
      +
      +	void (*copy_from)(void *dest, const void *src, int hash_size);
      +
     @@ reftable/record.h (new)
      +
      +	/* deallocate and null the record. */
      +	void (*clear)(void *rec);
     ++
     ++	/* is this a tombstone? */
     ++	bool (*is_deletion)(const void *rec);
      +};
      +
      +/* record is a generic wrapper for different types of records. */
     @@ reftable/record.h (new)
      +int record_encode(struct record rec, struct slice dest, int hash_size);
      +int record_decode(struct record rec, struct slice key, byte extra,
      +		  struct slice src, int hash_size);
     ++bool record_is_deletion(struct record rec);
      +
      +/* zeroes out the embedded record */
      +void record_clear(struct record rec);
     @@ reftable/reftable.h (new)
      +int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
      +
      +/* prints a reftable_ref_record onto stdout */
     -+void reftable_ref_record_print(struct reftable_ref_record *ref, int hash_size);
     ++void reftable_ref_record_print(struct reftable_ref_record *ref,
     ++			       uint32_t hash_id);
      +
      +/* frees and nulls all pointer values. */
      +void reftable_ref_record_clear(struct reftable_ref_record *ref);
     @@ reftable/reftable.h (new)
      +			      struct reftable_log_record *b, int hash_size);
      +
      +/* dumps a reftable_log_record on stdout, for debugging/testing. */
     -+void reftable_log_record_print(struct reftable_log_record *log, int hash_size);
     ++void reftable_log_record_print(struct reftable_log_record *log,
     ++			       uint32_t hash_id);
      +
      +/****************************************************************
      + Error handling
     @@ reftable/reftable.h (new)
      +/* different types of errors */
      +enum reftable_error {
      +	/* Unexpected file system behavior */
     -+	IO_ERROR = -2,
     ++	REFTABLE_IO_ERROR = -2,
      +
      +	/* Format inconsistency on reading data
      +	 */
     -+	FORMAT_ERROR = -3,
     ++	REFTABLE_FORMAT_ERROR = -3,
      +
      +	/* File does not exist. Returned from block_source_from_file(),  because
      +	   it needs special handling in stack.
      +	*/
     -+	NOT_EXIST_ERROR = -4,
     ++	REFTABLE_NOT_EXIST_ERROR = -4,
      +
      +	/* Trying to write out-of-date data. */
     -+	LOCK_ERROR = -5,
     ++	REFTABLE_LOCK_ERROR = -5,
      +
      +	/* Misuse of the API:
      +	   - on writing a record with NULL ref_name.
     @@ reftable/reftable.h (new)
      +	   - on writing a ref or log record before the stack's next_update_index
      +	   - on reading a reftable_ref_record from log iterator, or vice versa.
      +	*/
     -+	API_ERROR = -6,
     ++	REFTABLE_API_ERROR = -6,
      +
      +	/* Decompression error */
     -+	ZLIB_ERROR = -7,
     ++	REFTABLE_ZLIB_ERROR = -7,
      +
      +	/* Wrote a table without blocks. */
     -+	EMPTY_TABLE_ERROR = -8,
     ++	REFTABLE_EMPTY_TABLE_ERROR = -8,
      +};
      +
      +/* convert the numeric error code to a string. The string should not be
      + * deallocated. */
      +const char *reftable_error_str(int err);
      +
     ++/*
     ++ * Convert the numeric error code to an equivalent errno code.
     ++ */
     ++int reftable_error_to_errno(int err);
     ++
      +/****************************************************************
      + Writing
      +
     @@ reftable/reftable.h (new)
      +
      +/* Set the range of update indices for the records we will add.  When
      +   writing a table into a stack, the min should be at least
     -+   reftable_stack_next_update_index(), or API_ERROR is returned.
     ++   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
      +
      +   For transactional updates, typically min==max. When converting an existing
      +   ref database into a single reftable, this would be a range of update-index
     @@ reftable/reftable.h (new)
      +
      +/* adds a reftable_ref_record. Must be called in ascending
      +   order. The update_index must be within the limits set by
     -+   reftable_writer_set_limits(), or API_ERROR is returned.
     ++   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
      +
      +   It is an error to write a ref record after a log record.
      + */
     @@ reftable/reftable.h (new)
      +			      struct reftable_reader **stack, int n,
      +			      uint32_t hash_id);
      +
     -+/* returns the hash id used in this merged table. */
     -+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt);
     -+
      +/* returns an iterator positioned just before 'name' */
      +int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
      +				   struct reftable_iterator *it,
     @@ reftable/stack.c (new)
      +		reftable_calloc(sizeof(struct reftable_stack));
      +	struct slice list_file_name = {};
      +	int err = 0;
     ++
     ++	if (config.hash_id == 0) {
     ++		config.hash_id = SHA1_ID;
     ++	}
     ++
      +	*dest = NULL;
      +
      +	slice_set_string(&list_file_name, dir);
     -+	slice_append_string(&list_file_name, "/reftables.list");
     ++	slice_append_string(&list_file_name, "/tables.list");
      +
      +	p->list_file = slice_to_string(list_file_name);
      +	slice_clear(&list_file_name);
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     -+static int fread_lines(FILE *f, char ***namesp)
     ++static int fd_read_lines(int fd, char ***namesp)
      +{
     -+	long size = 0;
     -+	int err = fseek(f, 0, SEEK_END);
     ++	off_t size = lseek(fd, 0, SEEK_END);
      +	char *buf = NULL;
     -+	if (err < 0) {
     -+		err = IO_ERROR;
     -+		goto exit;
     -+	}
     -+	size = ftell(f);
     ++	int err = 0;
      +	if (size < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
     -+	err = fseek(f, 0, SEEK_SET);
     ++	err = lseek(fd, 0, SEEK_SET);
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
      +	buf = reftable_malloc(size + 1);
     -+	if (fread(buf, 1, size, f) != size) {
     -+		err = IO_ERROR;
     ++	if (read(fd, buf, size) != size) {
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +	buf[size] = 0;
      +
      +	parse_names(buf, size, namesp);
     ++
      +exit:
      +	reftable_free(buf);
      +	return err;
     @@ reftable/stack.c (new)
      +
      +int read_lines(const char *filename, char ***namesp)
      +{
     -+	FILE *f = fopen(filename, "r");
     ++	int fd = open(filename, O_RDONLY, 0644);
      +	int err = 0;
     -+	if (f == NULL) {
     ++	if (fd < 0) {
      +		if (errno == ENOENT) {
      +			*namesp = reftable_calloc(sizeof(char *));
      +			return 0;
      +		}
      +
     -+		return IO_ERROR;
     ++		return REFTABLE_IO_ERROR;
      +	}
     -+	err = fread_lines(f, namesp);
     -+	fclose(f);
     ++	err = fd_read_lines(fd, namesp);
     ++	close(fd);
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +		merged_table_clear(st->merged);
      +		reftable_merged_table_free(st->merged);
      +	}
     ++	new_merged->suppress_deletions = true;
      +	st->merged = new_merged;
      +
      +	{
     @@ reftable/stack.c (new)
      +		char **names_after = NULL;
      +		struct timeval now = { 0 };
      +		int err = gettimeofday(&now, NULL);
     ++		int err2 = 0;
      +		if (err < 0) {
      +			return err;
      +		}
     @@ reftable/stack.c (new)
      +			free_names(names);
      +			break;
      +		}
     -+		if (err != NOT_EXIST_ERROR) {
     ++		if (err != REFTABLE_NOT_EXIST_ERROR) {
      +			free_names(names);
      +			return err;
      +		}
      +
     -+		err = read_lines(st->list_file, &names_after);
     -+		if (err < 0) {
     ++		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
     ++		   writer. Check if there was one by checking if the name list
     ++		   changed.
     ++		*/
     ++		err2 = read_lines(st->list_file, &names_after);
     ++		if (err2 < 0) {
      +			free_names(names);
     -+			return err;
     ++			return err2;
      +		}
      +
      +		if (names_equal(names_after, names)) {
      +			free_names(names);
      +			free_names(names_after);
     -+			return -1;
     ++			return err;
      +		}
      +		free_names(names);
      +		free_names(names_after);
     @@ reftable/stack.c (new)
      +{
      +	int err = stack_try_add(st, write, arg);
      +	if (err < 0) {
     -+		if (err == LOCK_ERROR) {
     -+			err = reftable_stack_reload(st);
     ++		if (err == REFTABLE_LOCK_ERROR) {
     ++			// Ignore error return, we want to propagate
     ++			// REFTABLE_LOCK_ERROR.
     ++			reftable_stack_reload(st);
      +		}
      +		return err;
      +	}
      +
     -+	return reftable_stack_auto_compact(st);
     ++	if (!st->disable_auto_compact) {
     ++		return reftable_stack_auto_compact(st);
     ++	}
     ++
     ++	return 0;
      +}
      +
      +static void format_name(struct slice *dest, uint64_t min, uint64_t max)
      +{
      +	char buf[100];
     -+	snprintf(buf, sizeof(buf), "%012" PRIx64 "-%012" PRIx64, min, max);
     ++	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
      +	slice_set_string(dest, buf);
      +}
      +
     @@ reftable/stack.c (new)
      +				 O_EXCL | O_CREAT | O_WRONLY, 0644);
      +	if (add->lock_file_fd < 0) {
      +		if (errno == EEXIST) {
     -+			err = LOCK_ERROR;
     ++			err = REFTABLE_LOCK_ERROR;
      +		} else {
     -+			err = IO_ERROR;
     ++			err = REFTABLE_IO_ERROR;
      +		}
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +	}
      +
      +	if (err > 1) {
     -+		err = LOCK_ERROR;
     ++		err = REFTABLE_LOCK_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/stack.c (new)
      +	err = write(add->lock_file_fd, table_list.buf, table_list.len);
      +	slice_clear(&table_list);
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
      +	err = close(add->lock_file_fd);
      +	add->lock_file_fd = 0;
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
      +	err = rename(slice_as_string(&add->lock_file_name),
      +		     add->stack->list_file);
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/stack.c (new)
      +
      +	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
      +	if (tab_fd < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/stack.c (new)
      +	}
      +
      +	err = reftable_writer_close(wr);
     -+	if (err == EMPTY_TABLE_ERROR) {
     ++	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
      +		err = 0;
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +	err = close(tab_fd);
      +	tab_fd = 0;
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
      +	if (wr->min_update_index < next_update_index) {
     -+		err = API_ERROR;
     ++		err = REFTABLE_API_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/stack.c (new)
      +	err = rename(slice_as_string(&temp_tab_file_name),
      +		     slice_as_string(&tab_file_name));
      +	if (err < 0) {
     -+		err = IO_ERROR;
     ++		err = REFTABLE_IO_ERROR;
      +		goto exit;
      +	}
      +
     @@ reftable/stack.c (new)
      +		if (errno == EEXIST) {
      +			err = 1;
      +		} else {
     -+			err = IO_ERROR;
     ++			err = REFTABLE_IO_ERROR;
      +		}
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +			} else if (sublock_file_fd < 0) {
      +				if (errno == EEXIST) {
      +					err = 1;
     ++				} else {
     ++					err = REFTABLE_IO_ERROR;
      +				}
     -+				err = IO_ERROR;
      +			}
      +		}
      +
     @@ reftable/stack.c (new)
      +				   expiry);
      +	/* Compaction + tombstones can create an empty table out of non-empty
      +	 * tables. */
     -+	is_empty_table = (err == EMPTY_TABLE_ERROR);
     ++	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
      +	if (is_empty_table) {
      +		err = 0;
      +	}
     @@ reftable/stack.c (new)
      +		if (errno == EEXIST) {
      +			err = 1;
      +		} else {
     -+			err = IO_ERROR;
     ++			err = REFTABLE_IO_ERROR;
      +		}
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +		err = rename(slice_as_string(&temp_tab_file_name),
      +			     slice_as_string(&new_table_path));
      +		if (err < 0) {
     ++			err = REFTABLE_IO_ERROR;
      +			goto exit;
      +		}
      +	}
     @@ reftable/stack.c (new)
      +
      +	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
      +	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
      +		goto exit;
      +	}
      +	err = close(lock_file_fd);
      +	lock_file_fd = 0;
      +	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
      +		goto exit;
      +	}
      +
      +	err = rename(slice_as_string(&lock_file_name), st->list_file);
      +	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +{
      +	uint64_t *sizes =
      +		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
     ++	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
     ++	int overhead = footer_size(version) + header_size(version) - 1;
      +	int i = 0;
      +	for (i = 0; i < st->merged->stack_len; i++) {
     -+		/* overhead is 24 + 68 = 92. */
     -+		sizes[i] = st->merged->stack[i]->size - 91;
     ++		sizes[i] = st->merged->stack[i]->size - overhead;
      +	}
      +	return sizes;
      +}
     @@ reftable/stack.h (new)
      +#define STACK_H
      +
      +#include "reftable.h"
     ++#include "system.h"
      +
      +struct reftable_stack {
      +	char *list_file;
      +	char *reftable_dir;
     ++	bool disable_auto_compact;
      +
      +	struct reftable_write_options config;
      +
     @@ reftable/update.sh (new)
      @@
      +#!/bin/sh
      +
     -+set -eux
     ++set -eu
      +
     -+((cd reftable-repo && git fetch origin && git checkout origin/master ) ||
     -+git clone https://github.com/google/reftable reftable-repo) && \
     -+cp reftable-repo/c/*.[ch] reftable/ && \
     -+cp reftable-repo/c/include/*.[ch] reftable/ && \
     -+cp reftable-repo/LICENSE reftable/ &&
     ++# Override this to import from somewhere else, say "../reftable".
     ++SRC=${SRC:-origin} BRANCH=${BRANCH:-origin/master}
     ++
     ++((git --git-dir reftable-repo/.git fetch ${SRC} && cd reftable-repo && git checkout ${BRANCH} ) ||
     ++   git clone https://github.com/google/reftable reftable-repo)
     ++
     ++cp reftable-repo/c/*.[ch] reftable/
     ++cp reftable-repo/c/include/*.[ch] reftable/
     ++cp reftable-repo/LICENSE reftable/
      +git --git-dir reftable-repo/.git show --no-patch origin/master \
     -+> reftable/VERSION && \
     -+sed -i~ 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|' reftable/system.h
     ++  > reftable/VERSION
     ++
     ++mv reftable/system.h reftable/system.h~
     ++sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
     ++
     ++# Remove unittests and compatibility hacks we don't need here.  
      +rm reftable/*_test.c reftable/test_framework.* reftable/compat.*
     -+git add reftable/*.[ch]
     ++
     ++git add reftable/*.[ch] reftable/LICENSE reftable/VERSION 
      
       ## reftable/writer.c (new) ##
      @@
     @@ reftable/writer.c (new)
      +	int err = 0;
      +
      +	if (ref->ref_name == NULL) {
     -+		return API_ERROR;
     ++		return REFTABLE_API_ERROR;
      +	}
      +	if (ref->update_index < w->min_update_index ||
      +	    ref->update_index > w->max_update_index) {
     -+		return API_ERROR;
     ++		return REFTABLE_API_ERROR;
      +	}
      +
      +	record_from_ref(&rec, &copy);
     @@ reftable/writer.c (new)
      +			    struct reftable_log_record *log)
      +{
      +	if (log->ref_name == NULL) {
     -+		return API_ERROR;
     ++		return REFTABLE_API_ERROR;
      +	}
      +
      +	if (w->block_writer != NULL &&
     @@ reftable/writer.c (new)
      +	}
      +
      +	if (empty_table) {
     -+		err = EMPTY_TABLE_ERROR;
     ++		err = REFTABLE_EMPTY_TABLE_ERROR;
      +		goto exit;
      +	}
      +
 10:  ad72edbcfd4 ! 10:  be2371cd6e4 Reftable support for git-core
     @@ Commit message
          TODO:
      
           * Resolve spots marked with XXX
     -     * Test strategy?
     +
     +     * Detect and prevent directory/file conflicts in naming.
     +
     +     * Support worktrees (t0002-gitfile "linked repo" testcase)
      
          Example use: see t/t0031-reftable.sh
      
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	}
       
      -	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
     -+	init_db(git_dir, real_git_dir, option_template,
     -+                GIT_HASH_UNKNOWN,
     -+		DEFAULT_REF_STORAGE, /* XXX */
     -+		INIT_DB_QUIET);
     ++	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
     ++		DEFAULT_REF_STORAGE, INIT_DB_QUIET);
       
       	if (real_git_dir)
       		git_dir = real_git_dir;
     @@ builtin/init-db.c: static int needs_work_tree_config(const char *git_dir, const
       }
       
      -void initialize_repository_version(int hash_algo)
     -+void initialize_repository_version(int hash_algo, const char *ref_storage_format)
     ++void initialize_repository_version(int hash_algo,
     ++				   const char *ref_storage_format)
       {
       	char repo_version_string[10];
       	int repo_version = GIT_REPO_VERSION;
     @@ builtin/init-db.c: void initialize_repository_version(int hash_algo)
       #endif
       
      -	if (hash_algo != GIT_HASH_SHA1)
     -+	if (hash_algo != GIT_HASH_SHA1 || !strcmp(ref_storage_format, "reftable"))
     ++	if (hash_algo != GIT_HASH_SHA1 ||
     ++	    !strcmp(ref_storage_format, "reftable"))
       		repo_version = GIT_REPO_VERSION_READ;
       
       	/* This forces creation of new config file */
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      +	path = git_path_buf(&buf, "HEAD");
      +	reinit = (!access(path, R_OK) ||
      +		  readlink(path, junk, sizeof(junk) - 1) != -1);
     ++
     ++        /*
     ++         * refs/heads is a file when using reftable. We can't reinitialize with
     ++         * a reftable because it will overwrite HEAD
     ++         */
     ++	if (reinit && (!strcmp(fmt->ref_storage, "reftable")) ==
     ++			      is_directory(git_path_buf(&buf, "refs/heads"))) {
     ++		die("cannot switch ref storage format.");
     ++	}
      +
       	/*
       	 * We need to create a "refs" dir in any case so that older
       	 * versions of git can tell that this is a repository.
     + 	 */
     +-
     + 	if (refs_init_db(&err))
     + 		die("failed to set up refs db: %s", err.buf);
     + 
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	 * Create the default symlink from ".git/HEAD" to the "master"
       	 * branch, if it does not exist yet.
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	if (!reinit) {
       		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
       			exit(1);
     -+	} else {
     -+		/*
     -+		 * XXX should check whether our ref backend matches the
     -+		 * original one; if not, either die() or convert
     -+		 */
     - 	}
     - 
     +-	}
     +-
      -	initialize_repository_version(fmt->hash_algo);
     -+	initialize_repository_version(fmt->hash_algo, fmt->ref_storage);
     ++	} 
       
     ++	initialize_repository_version(fmt->hash_algo, fmt->ref_storage);
     ++        
       	/* Check filemode trustability */
       	path = git_path_buf(&buf, "config");
     + 	filemode = TEST_FILEMODE;
      @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
       }
       
       int init_db(const char *git_dir, const char *real_git_dir,
      -	    const char *template_dir, int hash, unsigned int flags)
      +	    const char *template_dir, int hash, const char *ref_storage_format,
     -+            unsigned int flags)
     ++	    unsigned int flags)
       {
       	int reinit;
       	int exist_ok = flags & INIT_DB_EXIST_OK;
     @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
       	 * is an attempt to reinitialize new repository with an old tool.
       	 */
       	check_repository_format(&repo_fmt);
     -+        repo_fmt.ref_storage = xstrdup(ref_storage_format);
     ++	repo_fmt.ref_storage = xstrdup(ref_storage_format);
       
       	validate_hash_algorithm(&repo_fmt, hash);
       
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       
       	flags |= INIT_DB_EXIST_OK;
      -	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
     -+	return init_db(git_dir, real_git_dir, template_dir, hash_algo, ref_storage_format, flags);
     ++	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
     ++		       ref_storage_format, flags);
       }
      
       ## cache.h ##
     @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
       
       int init_db(const char *git_dir, const char *real_git_dir,
       	    const char *template_dir, int hash_algo,
     -+            const char *ref_storage_format,
     - 	    unsigned int flags);
     +-	    unsigned int flags);
      -void initialize_repository_version(int hash_algo);
     -+void initialize_repository_version(int hash_algo, const char *ref_storage_format);
     ++	    const char *ref_storage_format, unsigned int flags);
     ++void initialize_repository_version(int hash_algo,
     ++				   const char *ref_storage_format);
       
       void sanitize_stdfds(void);
       int daemonize(void);
     @@ cache.h: struct repository_format {
      
       ## refs.c ##
      @@
     + #include "argv-array.h"
     + #include "repository.h"
     + 
     ++const char *default_ref_storage(void)
     ++{
     ++	const char *test = getenv("GIT_TEST_REFTABLE");
     ++	return test ? "reftable" : "files";
     ++}
     ++
       /*
        * List of all available backends
        */
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       	if (!r->gitdir)
       		BUG("attempting to get main_ref_store outside of repository");
       
     --	r->refs = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
     -+	r->refs = ref_store_init(r->gitdir,
     -+				 r->ref_storage_format ? r->ref_storage_format :
     -+							 DEFAULT_REF_STORAGE,
     -+				 REF_STORE_ALL_CAPS);
     - 	return r->refs;
     +-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
     ++	r->refs_private = ref_store_init(
     ++                r->gitdir,
     ++                r->ref_storage_format ? r->ref_storage_format : DEFAULT_REF_STORAGE,
     ++                REF_STORE_ALL_CAPS);
     + 	return r->refs_private;
       }
       
      @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
     @@ refs.h: struct string_list;
       struct string_list_item;
       struct worktree;
       
     -+#define DEFAULT_REF_STORAGE "files"
     ++/* Returns the ref storage backend to use by default. */
     ++const char *default_ref_storage(void);
      +
       /*
        * Resolve a reference, recursively following symbolic refererences.
     @@ refs/reftable-backend.c (new)
      +	unsigned int store_flags;
      +
      +	int err;
     ++        char *repo_dir;
      +	char *reftable_dir;
      +	struct reftable_stack *stack;
      +};
     @@ refs/reftable-backend.c (new)
      +
      +	base_ref_store_init(ref_store, &refs_be_reftable);
      +	refs->store_flags = store_flags;
     -+
     ++        refs->repo_dir = xstrdup(path);
      +	strbuf_addf(&sb, "%s/reftable", path);
      +	refs->reftable_dir = xstrdup(sb.buf);
      +	strbuf_reset(&sb);
      +
     -+	strbuf_addf(&sb, "%s/refs", path);
     -+	safe_create_dir(sb.buf, 1);
     -+	strbuf_reset(&sb);
     -+
     -+	strbuf_addf(&sb, "%s/HEAD", path);
     -+	write_file(sb.buf, "ref: refs/.invalid");
     -+	strbuf_reset(&sb);
     -+
     -+	strbuf_addf(&sb, "%s/refs/heads", path);
     -+	write_file(sb.buf, "this repository uses the reftable format");
     -+
      +	refs->err = reftable_new_stack(&refs->stack, refs->reftable_dir, cfg);
      +	strbuf_release(&sb);
      +	return ref_store;
     @@ refs/reftable-backend.c (new)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct strbuf sb = STRBUF_INIT;
     ++
      +	safe_create_dir(refs->reftable_dir, 1);
     -+	return 0;
     ++
     ++	strbuf_addf(&sb, "%s/HEAD", refs->repo_dir);
     ++	write_file(sb.buf, "ref: refs/.invalid");
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/refs", refs->repo_dir);
     ++	safe_create_dir(sb.buf, 1);
     ++	strbuf_reset(&sb);
     ++
     ++	strbuf_addf(&sb, "%s/refs/heads", refs->repo_dir);
     ++	write_file(sb.buf, "this repository uses the reftable format");
     ++
     ++        return 0;
      +}
      +
      +struct git_reftable_iterator {
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
     -+        ri->prefix = prefix;
     ++	ri->prefix = prefix;
      +	ri->base.oid = &ri->oid;
      +	ri->flags = flags;
      +	ri->ref_store = ref_store;
     @@ refs/reftable-backend.c (new)
      +	const char *resolved = refs_resolve_ref_unsafe(
      +		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
      +	if (is_null_oid(want_oid) != (resolved == NULL)) {
     -+		return LOCK_ERROR;
     ++		return REFTABLE_LOCK_ERROR;
      +	}
      +
      +	if (resolved != NULL && !oideq(&out_oid, want_oid)) {
     -+		return LOCK_ERROR;
     ++		return REFTABLE_LOCK_ERROR;
      +	}
      +
      +	return 0;
     @@ refs/reftable-backend.c (new)
      +		(struct git_reftable_ref_store *)transaction->ref_store;
      +	uint64_t ts = reftable_stack_next_update_index(refs->stack);
      +	int err = 0;
     ++	int i = 0;
      +	struct reftable_log_record *logs =
      +		calloc(transaction->nr, sizeof(*logs));
      +	struct ref_update **sorted =
     @@ refs/reftable-backend.c (new)
      +	QSORT(sorted, transaction->nr, ref_update_cmp);
      +	reftable_writer_set_limits(writer, ts, ts);
      +
     -+	for (int i = 0; i < transaction->nr; i++) {
     ++	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
      +		if (u->flags & REF_HAVE_OLD) {
      +			err = reftable_check_old_oid(transaction->ref_store,
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	for (int i = 0; i < transaction->nr; i++) {
     ++	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
      +		struct reftable_log_record *log = &logs[i];
      +		fill_reftable_log_record(log);
     @@ refs/reftable-backend.c (new)
      +				transaction->ref_store, u->refname, 0, &out_oid,
      +				&out_flags);
      +			struct reftable_ref_record ref = { NULL };
     ++			struct object_id peeled;
     ++			int peel_error = peel_object(&u->new_oid, &peeled);
     ++
      +			ref.ref_name =
      +				(char *)(resolved ? resolved : u->refname);
      +			log->ref_name = ref.ref_name;
     -+			ref.value = u->new_oid.hash;
     ++
     ++			if (!is_null_oid(&u->new_oid)) {
     ++				ref.value = u->new_oid.hash;
     ++			}
      +			ref.update_index = ts;
     ++			if (!peel_error) {
     ++				ref.target_value = peeled.hash;
     ++			}
     ++
      +			err = reftable_writer_add_ref(writer, &ref);
      +			if (err < 0) {
      +				goto exit;
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	for (int i = 0; i < transaction->nr; i++) {
     ++	for (i = 0; i < transaction->nr; i++) {
      +		err = reftable_writer_add_log(writer, &logs[i]);
      +		clear_reftable_log_record(&logs[i]);
      +		if (err < 0) {
     @@ refs/reftable-backend.c (new)
      +	err = reftable_stack_add(refs->stack, &write_transaction_table,
      +				 transaction);
      +	if (err < 0) {
     -+		strbuf_addf(errmsg, "reftable: transaction failure %s",
     ++		strbuf_addf(errmsg, "reftable: transaction failure: %s",
      +			    reftable_error_str(err));
      +		return -1;
      +	}
     @@ refs/reftable-backend.c (new)
      +		(struct write_delete_refs_arg *)argv;
      +	uint64_t ts = reftable_stack_next_update_index(arg->stack);
      +	int err = 0;
     ++	int i = 0;
      +
      +	reftable_writer_set_limits(writer, ts, ts);
     -+	for (int i = 0; i < arg->refnames->nr; i++) {
     ++	for (i = 0; i < arg->refnames->nr; i++) {
      +		struct reftable_ref_record ref = {
      +			.ref_name = (char *)arg->refnames->items[i].string,
      +			.update_index = ts,
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	for (int i = 0; i < arg->refnames->nr; i++) {
     ++	for (i = 0; i < arg->refnames->nr; i++) {
      +		struct reftable_log_record log = { NULL };
      +		struct reftable_ref_record current = { NULL };
      +		fill_reftable_log_record(&log);
     @@ refs/reftable-backend.c (new)
      +			return ITER_ERROR;
      +		}
      +
     -+                if (reftable_log_record_is_deletion(&ri->log)) {
     -+                        /* XXX - Why does the reftable_stack filter these? */
     -+                        continue;
     -+                }
      +		ri->base.refname = ri->log.ref_name;
      +		if (ri->last_name != NULL &&
      +		    !strcmp(ri->log.ref_name, ri->last_name)) {
     -+                        /* we want the refnames that we have reflogs for, so we
     -+                         * skip if we've already produced this name. This could
     -+                         * be faster by seeking directly to
     -+                         * reflog@update_index==0.
     -+                         */
     ++			/* we want the refnames that we have reflogs for, so we
     ++			 * skip if we've already produced this name. This could
     ++			 * be faster by seeking directly to
     ++			 * reflog@update_index==0.
     ++			 */
      +			continue;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +	int cap = 0;
      +	int len = 0;
      +	int err = 0;
     ++	int i = 0;
      +
      +	if (refs->err < 0) {
      +		return refs->err;
     @@ refs/reftable-backend.c (new)
      +		logs[len++] = log;
      +	}
      +
     -+	for (int i = len; i--;) {
     ++	for (i = len; i--;) {
      +		struct reftable_log_record *log = &logs[i];
      +		struct object_id old_oid;
      +		struct object_id new_oid;
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	for (int i = 0; i < len; i++) {
     ++	for (i = 0; i < len; i++) {
      +		reftable_log_record_clear(&logs[i]);
      +	}
      +	free(logs);
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	err = reftable_stack_read_ref(refs->stack, refname, &ref);
     -+	if (err) {
     ++        if (err > 0) {
     ++                errno = ENOENT;
     ++                err = -1;
     ++                goto exit;
     ++        }
     ++	if (err < 0) {
     ++                errno = reftable_error_to_errno(err);
     ++                err = -1;
      +		goto exit;
      +	}
      +	if (ref.target != NULL) {
     @@ refs/reftable-backend.c (new)
      +		strbuf_reset(referent);
      +		strbuf_addstr(referent, ref.target);
      +		*type |= REF_ISSYMREF;
     -+	} else {
     ++	} else if (ref.value != NULL) {
      +		hashcpy(oid->hash, ref.value);
     -+	}
     ++	} else {
     ++                *type |= REF_ISBROKEN;
     ++                errno = EINVAL;
     ++                err = -1;
     ++        }
      +exit:
      +	reftable_ref_record_clear(&ref);
      +	return err;
     @@ refs/reftable-backend.c (new)
      +	reftable_reflog_expire
      +};
      
     + ## reftable/update.sh ##
     +@@ reftable/update.sh: SRC=${SRC:-origin} BRANCH=${BRANCH:-origin/master}
     + cp reftable-repo/c/*.[ch] reftable/
     + cp reftable-repo/c/include/*.[ch] reftable/
     + cp reftable-repo/LICENSE reftable/
     +-git --git-dir reftable-repo/.git show --no-patch origin/master \
     ++git --git-dir reftable-repo/.git show --no-patch ${BRANCH} \
     +   > reftable/VERSION
     + 
     + mv reftable/system.h reftable/system.h~
     +
       ## repository.c ##
      @@ repository.c: int repo_init(struct repository *repo,
       	if (worktree)
     @@ repository.c: int repo_init(struct repository *repo,
      
       ## repository.h ##
      @@ repository.h: struct repository {
     - 	/* The store in which the refs are held. */
     - 	struct ref_store *refs;
     + 	 */
     + 	struct ref_store *refs_private;
       
      +	/* The format to use for the ref database. */
      +	char *ref_storage_format;
     @@ t/t0031-reftable.sh (new)
      +
      +. ./test-lib.sh
      +
     -+# XXX - fix GC
     -+test_expect_success 'basic operation of reftable storage' '
     ++INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
     ++
     ++initialize ()  {
      +	rm -rf .git &&
      +	git init --ref-storage=reftable &&
     -+	mv .git/hooks .git/hooks-disabled &&
     ++	mv .git/hooks .git/hooks-disabled
     ++}
     ++
     ++test_expect_success 'delete ref' '
     ++	initialize &&
     ++	test_commit file &&
     ++	SHA=$(git show-ref -s --verify HEAD) &&
     ++	test_write_lines "$SHA refs/heads/master" "$SHA refs/tags/file" >expect &&
     ++	git show-ref > actual &&
     ++	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
     ++	test_cmp expect actual &&
     ++	git update-ref -d refs/tags/file $SHA  &&
     ++	test_write_lines "$SHA refs/heads/master" >expect &&
     ++	git show-ref > actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'basic operation of reftable storage: commit, reflog, repack' '
     ++	initialize &&
      +	test_commit file &&
      +	test_write_lines refs/heads/master refs/tags/file >expect &&
      +	git show-ref &&
     @@ t/t0031-reftable.sh (new)
      +	for count in $(test_seq 1 10)
      +	do
      +		test_commit "number $count" file.t $count number-$count ||
     -+ 		return 1
     ++	        return 1
      +	done &&
     -+(true || (test_pause &&
     -+	git gc &&
     ++	git pack-refs &&
      +	ls -1 .git/reftable >table-files &&
      +	test_line_count = 2 table-files &&
     -+ 	git reflog refs/heads/master >output &&
     ++	git reflog refs/heads/master >output &&
      +	test_line_count = 11 output &&
     -+	grep "commit (initial): first post" output &&
     -+	grep "commit: number 10" output ))
     ++	grep "commit (initial): file" output &&
     ++	grep "commit: number 10" output &&
     ++	git gc &&
     ++	git reflog refs/heads/master >output &&
     ++	test_line_count = 0 output 
     ++'
     ++
     ++# This matches show-ref's output
     ++print_ref() {
     ++	echo "$(git rev-parse "$1") $1"
     ++}
     ++
     ++test_expect_success 'peeled tags are stored' '
     ++	initialize &&
     ++	test_commit file &&
     ++	git tag -m "annotated tag" test_tag HEAD &&
     ++	{
     ++		print_ref "refs/heads/master" &&
     ++		print_ref "refs/tags/file" &&
     ++		print_ref "refs/tags/test_tag" &&
     ++		print_ref "refs/tags/test_tag^{}" 
     ++	} >expect &&
     ++	git show-ref -d >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'show-ref works on fresh repo' '
     ++	initialize &&
     ++	rm -rf .git &&
     ++	git init --ref-storage=reftable &&
     ++	>expect &&
     ++	! git show-ref > actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'checkout unborn branch' '
     ++	initialize &&
     ++	git checkout -b master
     ++'
     ++
     ++test_expect_success 'do not clobber existing repo' '
     ++	rm -rf .git &&
     ++	git init --ref-storage=files &&
     ++	cat .git/HEAD > expect &&
     ++	test_commit file &&
     ++	(git init --ref-storage=reftable || true) &&
     ++	cat .git/HEAD > actual &&
     ++	test_cmp expect actual
      +'
      +
      +test_done
  -:  ----------- > 11:  8af67b85e49 Add some reftable testing infrastructure
  -:  ----------- > 12:  b02b83a92ad t: use update-ref and show-ref to reading/writing refs

-- 
gitgitgadget
