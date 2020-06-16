Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030CDC433E1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6DB20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqG/AzLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgFPTU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPTUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D3BC061755
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:48 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d128so4268133wmc.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fOED8MXR6OWk/jOVOCyqhScwpo1Bef/bEGAQq4f9FJM=;
        b=gqG/AzLnMG48LEcKHZBY5Rqx1f9wbaXsR0bV+wbCxLyS2UZUng9qyE8RPIq41AfCSz
         LkI9HQLVBP+PIzJUkPGcuhW6Bb+lArYgL1XTkRk4OJjZkjO3XvHyH72f4Lwzxxfl3xwu
         6ECYM136vHS7jhoIe2THcHhmOSyAcKoFcEUO7kJcoyOHKz/nxWrbacRIjUeMF+akvZXQ
         LJMcQb415/tzKE3iOqesgtWa1uF0zOqA/hRzQpxoHyguhhxfnSzZ2YLT7xWpmer17L+8
         AsGgT0muSKy8TtGy7xw3N4DbAfdWRWNbdcBd275OzUf3Nlz2/vAqVXtlpwhLt0Ws5nQ6
         u0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fOED8MXR6OWk/jOVOCyqhScwpo1Bef/bEGAQq4f9FJM=;
        b=agVTB/aqvtY6s2+M5w5P/5wgEKT2YPH2w/dR2iWAML+zPw4SqrWzdmmMtkIJyOn80N
         0DujjLe77c0UwCvumjzQLLRrlBJ1Q6FIlbf4stcUWnMYwn79HJMKPg60+x7wKdH2bdp7
         3+6mOwwMQBZ5rnBFUwasybFS/xO3tpOAd1rAsjwme+A+YBZPG6aMu05Jp6TrDggt8Rq0
         RT3WnJwzC6qWBQ+dEHS3xvFyw7RS+QAOrfYHn8OV4LOOrAfZVyR2Vg+68QFvOyOUz773
         aSDNPw9hbs4Uq6Q8KEB4azJG/F3n8/8T27S2VCIb0XxVmAsdLbL9J9CqWu+cA0gC6EA3
         LWuw==
X-Gm-Message-State: AOAM533CLsCDOgtYhIVaJeP2olkhMgs64rAW8dcQWc8fxGgR1w48WYXx
        EtPvj46G2FfNgYH2h68sIStIiZb1
X-Google-Smtp-Source: ABdhPJwu8kj+2FbSpSNL+wmBCnw4g7Xc3Nv5UO15lNdsrixWjquighVtDRShIfU9LQIuyM8UoYOrrg==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr4720330wme.34.1592335244875;
        Tue, 16 Jun 2020 12:20:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm4901040wmi.35.2020.06.16.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:44 -0700 (PDT)
Message-Id: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:25 +0000
Subject: [PATCH v17 00/17] Reftable support git-core
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

This adds the reftable library, and hooks it up as a ref backend. Based on
hn/refs-cleanup.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 20816 tests pass 1122 tests fail

Some issues:

 * many tests inspect .git/{logs,heads}/ directly.
 * worktrees broken. 

v20

 * various reflog fixes; @{-1} now works
 * more debug output for GIT_DEBUG_REFS
 * reftable's slice class is now equivalent to strbuf
 * add test-tool dump-reftable.

Han-Wen Nienhuys (16):
  lib-t6000.sh: write tag using git-update-ref
  checkout: add '\n' to reflog message
  Write pseudorefs through ref backends.
  Make refs_ref_exists public
  Treat BISECT_HEAD as a pseudo ref
  Treat CHERRY_PICK_HEAD as a pseudo ref
  Treat REVERT_HEAD as a pseudo ref
  Move REF_LOG_ONLY to refs-internal.h
  Iterate over the "refs/" namespace in for_each_[raw]ref
  Add .gitattributes for the reftable/ directory
  Add reftable library
  Reftable support for git-core
  Hookup unittests for the reftable library.
  Add GIT_DEBUG_REFS debugging mechanism
  Add reftable testing infrastructure
  Add "test-tool dump-reftable" command.

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   47 +-
 builtin/bisect--helper.c                      |    3 +-
 builtin/checkout.c                            |    5 +-
 builtin/clone.c                               |    3 +-
 builtin/commit.c                              |   34 +-
 builtin/init-db.c                             |   56 +-
 builtin/merge.c                               |    2 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 git-bisect.sh                                 |    4 +-
 path.c                                        |    2 -
 path.h                                        |    9 +-
 refs.c                                        |  157 +-
 refs.h                                        |   16 +
 refs/debug.c                                  |  358 +++++
 refs/files-backend.c                          |  121 +-
 refs/packed-backend.c                         |   21 +-
 refs/refs-internal.h                          |   32 +
 refs/reftable-backend.c                       | 1327 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    1 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  437 ++++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  157 ++
 reftable/compat.c                             |   97 ++
 reftable/compat.h                             |   48 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  212 +++
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  242 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  320 ++++
 reftable/merged.h                             |   39 +
 reftable/merged_test.c                        |  273 ++++
 reftable/pq.c                                 |  113 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  742 +++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1118 ++++++++++++++
 reftable/record.h                             |  128 ++
 reftable/record_test.c                        |  403 +++++
 reftable/refname.c                            |  211 +++
 reftable/refname.h                            |   38 +
 reftable/refname_test.c                       |   99 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable.c                           |   90 ++
 reftable/reftable.h                           |  571 +++++++
 reftable/reftable_test.c                      |  631 ++++++++
 reftable/slice.c                              |  217 +++
 reftable/slice.h                              |   85 ++
 reftable/slice_test.c                         |   39 +
 reftable/stack.c                              | 1214 +++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/stack_test.c                         |  787 ++++++++++
 reftable/system.h                             |   55 +
 reftable/test_framework.c                     |   69 +
 reftable/test_framework.h                     |   64 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   62 +
 reftable/update.sh                            |   22 +
 reftable/writer.c                             |  661 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   12 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    2 +
 t/helper/test-tool.h                          |    2 +
 t/lib-t6000.sh                                |    5 +-
 t/t0031-reftable.sh                           |  160 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/t9903-bash-prompt.sh                        |    6 +
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 86 files changed, 12629 insertions(+), 200 deletions(-)
 create mode 100644 refs/debug.c
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/slice_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0033-debug-refs.sh


base-commit: bcb73516bf1f7fd16f882782d42250dd19f39b85
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v17
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v16:

  -:  ----------- >  1:  8304c3d6379 lib-t6000.sh: write tag using git-update-ref
  -:  ----------- >  2:  4012d801e3c checkout: add '\n' to reflog message
  1:  4a1f600fb85 =  3:  95a6a1d968e Write pseudorefs through ref backends.
  2:  a4a67ce9635 =  4:  1f8865f4b3e Make refs_ref_exists public
  3:  ecd6591d86f =  5:  7f376a76d84 Treat BISECT_HEAD as a pseudo ref
  4:  7c31727de69 =  6:  959c69b5ee4 Treat CHERRY_PICK_HEAD as a pseudo ref
  5:  fbdcee5208b =  7:  3f18475d0d3 Treat REVERT_HEAD as a pseudo ref
  6:  d8801367f7d =  8:  4981e5395c6 Move REF_LOG_ONLY to refs-internal.h
  7:  556d57610cc =  9:  f452c48ae44 Iterate over the "refs/" namespace in for_each_[raw]ref
  8:  78cb1930172 = 10:  1fa68d5d34f Add .gitattributes for the reftable/ directory
  9:  0bc28ac610f ! 11:  86646c834c2 Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+0c164275ea8f8aa7d099f7425ddcef1affe137e9 C: compile framework with Git options
     ++2c91c4b305dcbf6500c0806bb1a7fbcfc668510c C: include system.h in compat.h
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +
      +	w->next += n;
      +
     -+	slice_copy(&w->last_key, key);
     ++	slice_reset(&w->last_key);
     ++	slice_addbuf(&w->last_key, key);
      +	w->entries++;
      +	return 0;
      +}
     @@ reftable/block.c (new)
      +
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
     -+		struct slice compressed = SLICE_INIT;
     ++		byte *compressed = NULL;
      +		int zresult = 0;
      +		uLongf src_len = w->next - block_header_skip;
     -+		slice_resize(&compressed, src_len);
     ++		size_t dest_cap = src_len;
      +
     ++		compressed = reftable_malloc(dest_cap);
      +		while (1) {
     -+			uLongf dest_len = compressed.len;
     ++			uLongf out_dest_len = dest_cap;
      +
     -+			zresult = compress2(compressed.buf, &dest_len,
     ++			zresult = compress2(compressed, &out_dest_len,
      +					    w->buf + block_header_skip, src_len,
      +					    9);
      +			if (zresult == Z_BUF_ERROR) {
     -+				slice_resize(&compressed, 2 * compressed.len);
     ++				dest_cap *= 2;
     ++				compressed =
     ++					reftable_realloc(compressed, dest_cap);
      +				continue;
      +			}
      +
      +			if (Z_OK != zresult) {
     -+				slice_release(&compressed);
     ++				reftable_free(compressed);
      +				return REFTABLE_ZLIB_ERROR;
      +			}
      +
     -+			memcpy(w->buf + block_header_skip, compressed.buf,
     -+			       dest_len);
     -+			w->next = dest_len + block_header_skip;
     -+			slice_release(&compressed);
     ++			memcpy(w->buf + block_header_skip, compressed,
     ++			       out_dest_len);
     ++			w->next = out_dest_len + block_header_skip;
     ++			reftable_free(compressed);
      +			break;
      +		}
      +	}
     @@ reftable/block.c (new)
      +		return REFTABLE_FORMAT_ERROR;
      +
      +	if (typ == BLOCK_TYPE_LOG) {
     -+		struct slice uncompressed = SLICE_INIT;
      +		int block_header_skip = 4 + header_off;
      +		uLongf dst_len = sz - block_header_skip; /* total size of dest
      +							    buffer. */
      +		uLongf src_len = block->len - block_header_skip;
     -+
      +		/* Log blocks specify the *uncompressed* size in their header.
      +		 */
     -+		slice_resize(&uncompressed, sz);
     ++		byte *uncompressed = reftable_malloc(sz);
      +
      +		/* Copy over the block header verbatim. It's not compressed. */
     -+		memcpy(uncompressed.buf, block->data, block_header_skip);
     ++		memcpy(uncompressed, block->data, block_header_skip);
      +
      +		/* Uncompress */
      +		if (Z_OK != uncompress_return_consumed(
     -+				    uncompressed.buf + block_header_skip,
     -+				    &dst_len, block->data + block_header_skip,
     ++				    uncompressed + block_header_skip, &dst_len,
     ++				    block->data + block_header_skip,
      +				    &src_len)) {
     -+			slice_release(&uncompressed);
     ++			reftable_free(uncompressed);
      +			return REFTABLE_ZLIB_ERROR;
      +		}
      +
     @@ reftable/block.c (new)
      +
      +		/* We're done with the input data. */
      +		reftable_block_done(block);
     -+		block->data = uncompressed.buf;
     ++		block->data = uncompressed;
      +		block->len = sz;
      +		block->source = malloc_block_source();
      +		full_block_size = src_len + block_header_skip;
     @@ reftable/block.c (new)
      +void block_reader_start(struct block_reader *br, struct block_iter *it)
      +{
      +	it->br = br;
     -+	slice_resize(&it->last_key, 0);
     ++	slice_reset(&it->last_key);
      +	it->next_off = br->header_off + 4;
      +}
      +
     @@ reftable/block.c (new)
      +{
      +	dest->br = src->br;
      +	dest->next_off = src->next_off;
     -+	slice_copy(&dest->last_key, &src->last_key);
     ++	slice_reset(&dest->last_key);
     ++	slice_addbuf(&dest->last_key, &src->last_key);
      +}
      +
      +int block_iter_next(struct block_iter *it, struct reftable_record *rec)
     @@ reftable/block.c (new)
      +		return -1;
      +	slice_consume(&in, n);
      +
     -+	slice_copy(&it->last_key, &key);
     ++	slice_reset(&it->last_key);
     ++	slice_addbuf(&it->last_key, &key);
      +	it->next_off += start.len - in.len;
      +	slice_release(&key);
      +	return 0;
     @@ reftable/block_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		struct block_iter it = { .last_key = SLICE_INIT };
     -+		slice_set_string(&want, names[i]);
     ++		slice_reset(&want);
     ++		slice_addstr(&want, names[i]);
      +
      +		n = block_reader_seek(&br, &it, &want);
      +		assert(n == 0);
     @@ reftable/block_test.c (new)
      +	return test_main(argc, argv);
      +}
      
     + ## reftable/compat.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++
     ++*/
     ++
     ++/* compat.c - compatibility functions for standalone compilation */
     ++
     ++#include "system.h"
     ++#include "basics.h"
     ++
     ++#ifndef REFTABLE_IN_GITCORE
     ++
     ++#include <dirent.h>
     ++
     ++void put_be32(void *p, uint32_t i)
     ++{
     ++	byte *out = (byte *)p;
     ++
     ++	out[0] = (uint8_t)((i >> 24) & 0xff);
     ++	out[1] = (uint8_t)((i >> 16) & 0xff);
     ++	out[2] = (uint8_t)((i >> 8) & 0xff);
     ++	out[3] = (uint8_t)((i)&0xff);
     ++}
     ++
     ++uint32_t get_be32(uint8_t *in)
     ++{
     ++	return (uint32_t)(in[0]) << 24 | (uint32_t)(in[1]) << 16 |
     ++	       (uint32_t)(in[2]) << 8 | (uint32_t)(in[3]);
     ++}
     ++
     ++void put_be64(void *p, uint64_t v)
     ++{
     ++	byte *out = (byte *)p;
     ++	int i = sizeof(uint64_t);
     ++	while (i--) {
     ++		out[i] = (uint8_t)(v & 0xff);
     ++		v >>= 8;
     ++	}
     ++}
     ++
     ++uint64_t get_be64(uint8_t *out)
     ++{
     ++	uint64_t v = 0;
     ++	int i = 0;
     ++	for (i = 0; i < sizeof(uint64_t); i++) {
     ++		v = (v << 8) | (uint8_t)(out[i] & 0xff);
     ++	}
     ++	return v;
     ++}
     ++
     ++uint16_t get_be16(uint8_t *in)
     ++{
     ++	return (uint32_t)(in[0]) << 8 | (uint32_t)(in[1]);
     ++}
     ++
     ++char *xstrdup(const char *s)
     ++{
     ++	int l = strlen(s);
     ++	char *dest = (char *)reftable_malloc(l + 1);
     ++	strncpy(dest, s, l + 1);
     ++	return dest;
     ++}
     ++
     ++void sleep_millisec(int millisecs)
     ++{
     ++	usleep(millisecs * 1000);
     ++}
     ++
     ++void reftable_clear_dir(const char *dirname)
     ++{
     ++	DIR *dir = opendir(dirname);
     ++	struct dirent *ent = NULL;
     ++	assert(dir);
     ++	while ((ent = readdir(dir)) != NULL) {
     ++		unlinkat(dirfd(dir), ent->d_name, 0);
     ++	}
     ++	closedir(dir);
     ++	rmdir(dirname);
     ++}
     ++
     ++#else
     ++
     ++#include "../dir.h"
     ++
     ++void reftable_clear_dir(const char *dirname)
     ++{
     ++	struct strbuf path = STRBUF_INIT;
     ++	strbuf_addstr(&path, dirname);
     ++	remove_dir_recursively(&path, 0);
     ++	strbuf_release(&path);
     ++}
     ++
     ++#endif
     +
     + ## reftable/compat.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef COMPAT_H
     ++#define COMPAT_H
     ++
     ++#include "system.h"
     ++
     ++#ifndef REFTABLE_IN_GITCORE
     ++
     ++/* functions that git-core provides, for standalone compilation */
     ++#include <stdint.h>
     ++
     ++uint64_t get_be64(uint8_t *in);
     ++void put_be64(void *out, uint64_t i);
     ++
     ++void put_be32(void *out, uint32_t i);
     ++uint32_t get_be32(uint8_t *in);
     ++
     ++uint16_t get_be16(uint8_t *in);
     ++
     ++#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
     ++#define FREE_AND_NULL(x)          \
     ++	do {                      \
     ++		reftable_free(x); \
     ++		(x) = NULL;       \
     ++	} while (0)
     ++#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
     ++#define SWAP(a, b)                              \
     ++	{                                       \
     ++		char tmp[sizeof(a)];            \
     ++		assert(sizeof(a) == sizeof(b)); \
     ++		memcpy(&tmp[0], &a, sizeof(a)); \
     ++		memcpy(&a, &b, sizeof(a));      \
     ++		memcpy(&b, &tmp[0], sizeof(a)); \
     ++	}
     ++
     ++char *xstrdup(const char *s);
     ++
     ++void sleep_millisec(int millisecs);
     ++
     ++#endif
     ++#endif
     +
       ## reftable/constants.h (new) ##
      @@
      +/*
     @@ reftable/constants.h (new)
      +
      +#endif
      
     + ## reftable/dump.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include <stddef.h>
     ++#include <stdio.h>
     ++#include <stdlib.h>
     ++#include <unistd.h>
     ++#include <string.h>
     ++
     ++#include "reftable.h"
     ++#include "reftable-tests.h"
     ++
     ++static uint32_t hash_id;
     ++
     ++static int dump_table(const char *tablename)
     ++{
     ++	struct reftable_block_source src = { 0 };
     ++	int err = reftable_block_source_from_file(&src, tablename);
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
     ++	struct reftable_reader *r = NULL;
     ++
     ++	if (err < 0)
     ++		return err;
     ++
     ++	err = reftable_new_reader(&r, &src, tablename);
     ++	if (err < 0)
     ++		return err;
     ++
     ++	err = reftable_reader_seek_ref(r, &it, "");
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++
     ++	while (1) {
     ++		err = reftable_iterator_next_ref(&it, &ref);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++		reftable_ref_record_print(&ref, hash_id);
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++	reftable_ref_record_clear(&ref);
     ++
     ++	err = reftable_reader_seek_log(r, &it, "");
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++	while (1) {
     ++		err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++		reftable_log_record_print(&log, hash_id);
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++	reftable_log_record_clear(&log);
     ++
     ++	reftable_reader_free(r);
     ++	return 0;
     ++}
     ++
     ++static int compact_stack(const char *stackdir)
     ++{
     ++	struct reftable_stack *stack = NULL;
     ++	struct reftable_write_options cfg = {};
     ++
     ++	int err = reftable_new_stack(&stack, stackdir, cfg);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_stack_compact_all(stack, NULL);
     ++	if (err < 0)
     ++		goto done;
     ++done:
     ++	if (stack != NULL) {
     ++		reftable_stack_destroy(stack);
     ++	}
     ++	return err;
     ++}
     ++
     ++static int dump_stack(const char *stackdir)
     ++{
     ++	struct reftable_stack *stack = NULL;
     ++	struct reftable_write_options cfg = {};
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
     ++	struct reftable_merged_table *merged = NULL;
     ++
     ++	int err = reftable_new_stack(&stack, stackdir, cfg);
     ++	if (err < 0)
     ++		return err;
     ++
     ++	merged = reftable_stack_merged_table(stack);
     ++
     ++	err = reftable_merged_table_seek_ref(merged, &it, "");
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++
     ++	while (1) {
     ++		err = reftable_iterator_next_ref(&it, &ref);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++		reftable_ref_record_print(&ref, hash_id);
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++	reftable_ref_record_clear(&ref);
     ++
     ++	err = reftable_merged_table_seek_log(merged, &it, "");
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++	while (1) {
     ++		err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++		reftable_log_record_print(&log, hash_id);
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++	reftable_log_record_clear(&log);
     ++
     ++	reftable_stack_destroy(stack);
     ++	return 0;
     ++}
     ++
     ++static void print_help(void)
     ++{
     ++	printf("usage: dump [-cst] arg\n\n"
     ++	       "options: \n"
     ++	       "  -c compact\n"
     ++	       "  -t dump table\n"
     ++	       "  -s dump stack\n"
     ++	       "  -h this help\n"
     ++	       "  -2 use SHA256\n"
     ++	       "\n");
     ++}
     ++
     ++int reftable_dump_main(int argc, char *const *argv)
     ++{
     ++	int err = 0;
     ++	int opt;
     ++	int opt_dump_table = 0;
     ++	int opt_dump_stack = 0;
     ++	int opt_compact = 0;
     ++	const char *arg = NULL;
     ++	while ((opt = getopt(argc, argv, "2chts")) != -1) {
     ++		switch (opt) {
     ++		case '2':
     ++			hash_id = 0x73323536;
     ++			break;
     ++		case 't':
     ++			opt_dump_table = 1;
     ++			break;
     ++		case 's':
     ++			opt_dump_stack = 1;
     ++			break;
     ++		case 'c':
     ++			opt_compact = 1;
     ++			break;
     ++		case '?':
     ++		case 'h':
     ++			print_help();
     ++			return 2;
     ++			break;
     ++		}
     ++	}
     ++
     ++	if (argv[optind] == NULL) {
     ++		fprintf(stderr, "need argument\n");
     ++		print_help();
     ++		return 2;
     ++	}
     ++
     ++	arg = argv[optind];
     ++
     ++	if (opt_dump_table) {
     ++		err = dump_table(arg);
     ++	} else if (opt_dump_stack) {
     ++		err = dump_stack(arg);
     ++	} else if (opt_compact) {
     ++		err = compact_stack(arg);
     ++	}
     ++
     ++	if (err < 0) {
     ++		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
     ++			reftable_error_str(err));
     ++		return 1;
     ++	}
     ++	return 0;
     ++}
     +
       ## reftable/file.c (new) ##
      @@
      +/*
     @@ reftable/iter.c (new)
      +
      +	*itr = empty;
      +	itr->r = r;
     -+	slice_resize(&itr->oid, oid_len);
     -+	memcpy(itr->oid.buf, oid, oid_len);
     ++	slice_add(&itr->oid, oid, oid_len);
      +
      +	itr->offsets = offsets;
      +	itr->offset_len = offset_len;
     @@ reftable/reader.c (new)
      +
      +	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
      +	*filter = empty;
     -+	slice_resize(&filter->oid, oid_len);
     -+	memcpy(filter->oid.buf, oid, oid_len);
     ++
     ++	slice_add(&filter->oid, oid, oid_len);
      +	reftable_table_from_reader(&filter->tab, r);
      +	filter->double_check = false;
      +	iterator_from_table_iter(&filter->it, ti);
     @@ reftable/record.c (new)
      +	if (in.len < tsize)
      +		return -1;
      +
     -+	slice_resize(dest, tsize + 1);
     -+	dest->buf[tsize] = 0;
     -+	memcpy(dest->buf, in.buf, tsize);
     ++	slice_reset(dest);
     ++	slice_add(dest, in.buf, tsize);
      +	slice_consume(&in, tsize);
      +
      +	return start_len - in.len;
     @@ reftable/record.c (new)
      +	if (in.len < suffix_len)
      +		return -1;
      +
     -+	slice_resize(key, suffix_len + prefix_len);
     -+	memcpy(key->buf, last_key.buf, prefix_len);
     -+
     -+	memcpy(key->buf + prefix_len, in.buf, suffix_len);
     ++	slice_reset(key);
     ++	slice_add(key, last_key.buf, prefix_len);
     ++	slice_add(key, in.buf, suffix_len);
      +	slice_consume(&in, suffix_len);
      +
      +	return start_len - in.len;
     @@ reftable/record.c (new)
      +{
      +	const struct reftable_ref_record *rec =
      +		(const struct reftable_ref_record *)r;
     -+	slice_set_string(dest, rec->ref_name);
     ++	slice_reset(dest);
     ++	slice_addstr(dest, rec->ref_name);
      +}
      +
      +static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +{
      +	const struct reftable_obj_record *rec =
      +		(const struct reftable_obj_record *)r;
     -+	slice_resize(dest, rec->hash_prefix_len);
     -+	memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
     ++	slice_reset(dest);
     ++	slice_add(dest, rec->hash_prefix, rec->hash_prefix_len);
      +}
      +
      +static void reftable_obj_record_clear(void *rec)
     @@ reftable/record.c (new)
      +	const struct reftable_log_record *rec =
      +		(const struct reftable_log_record *)r;
      +	int len = strlen(rec->ref_name);
     ++	byte i64[8];
      +	uint64_t ts = 0;
     -+	slice_resize(dest, len + 9);
     -+	memcpy(dest->buf, rec->ref_name, len + 1);
     ++	slice_reset(dest);
     ++	slice_add(dest, (byte *)rec->ref_name, len + 1);
     ++
      +	ts = (~ts) - rec->update_index;
     -+	put_be64(dest->buf + 1 + len, ts);
     ++	put_be64(&i64[0], ts);
     ++	slice_add(dest, i64, sizeof(i64));
      +}
      +
      +static void reftable_log_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	memcpy(r->name, dest.buf, dest.len);
      +	r->name[dest.len] = 0;
      +
     -+	slice_resize(&dest, 0);
     ++	slice_reset(&dest);
      +	n = decode_string(&dest, in);
      +	if (n < 0)
      +		goto done;
     @@ reftable/record.c (new)
      +	r->tz_offset = get_be16(in.buf);
      +	slice_consume(&in, 2);
      +
     -+	slice_resize(&dest, 0);
     ++	slice_reset(&dest);
      +	n = decode_string(&dest, in);
      +	if (n < 0)
      +		goto done;
     @@ reftable/record.c (new)
      +static void reftable_index_record_key(const void *r, struct slice *dest)
      +{
      +	struct reftable_index_record *rec = (struct reftable_index_record *)r;
     -+	slice_copy(dest, &rec->last_key);
     ++	slice_reset(dest);
     ++	slice_addbuf(dest, &rec->last_key);
      +}
      +
      +static void reftable_index_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	struct reftable_index_record *src =
      +		(struct reftable_index_record *)src_rec;
      +
     -+	slice_copy(&dst->last_key, &src->last_key);
     ++	slice_reset(&dst->last_key);
     ++	slice_addbuf(&dst->last_key, &src->last_key);
      +	dst->offset = src->offset;
      +}
      +
     @@ reftable/record.c (new)
      +	struct reftable_index_record *r = (struct reftable_index_record *)rec;
      +	int n = 0;
      +
     -+	slice_copy(&r->last_key, &key);
     ++	slice_reset(&r->last_key);
     ++	slice_addbuf(&r->last_key, &key);
      +
      +	n = get_var_int(&r->offset, &in);
      +	if (n < 0)
     @@ reftable/record_test.c (new)
      +	for (i = 0; i < ARRAY_SIZE(cases); i++) {
      +		struct slice a = SLICE_INIT;
      +		struct slice b = SLICE_INIT;
     -+		slice_set_string(&a, cases[i].a);
     -+		slice_set_string(&b, cases[i].b);
     -+
     ++		slice_addstr(&a, cases[i].a);
     ++		slice_addstr(&b, cases[i].b);
      +		assert(common_prefix_size(&a, &b) == cases[i].want);
      +
      +		slice_release(&a);
     @@ reftable/record_test.c (new)
      +		assert(reftable_record_val_type(&rec) == i);
      +
      +		reftable_record_key(&rec, &key);
     -+		slice_resize(&dest, 1024);
     ++		slice_grow(&dest, 1024);
     ++		slice_setlen(&dest, 1024);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n > 0);
      +
     @@ reftable/record_test.c (new)
      +
      +		reftable_record_key(&rec, &key);
      +
     -+		slice_resize(&dest, 1024);
     ++		slice_grow(&dest, 1024);
     ++		slice_setlen(&dest, 1024);
      +
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n >= 0);
     @@ reftable/record_test.c (new)
      +	int n, m;
      +	byte rt_extra;
      +
     -+	slice_resize(&dest, 1024);
     -+	slice_set_string(&last_key, "refs/heads/master");
     -+	slice_set_string(&key, "refs/tags/bla");
     -+
     ++	slice_grow(&dest, 1024);
     ++	slice_setlen(&dest, 1024);
     ++	slice_addstr(&last_key, "refs/heads/master");
     ++	slice_addstr(&key, "refs/tags/bla");
      +	extra = 6;
      +	n = reftable_encode_key(&restart, dest, last_key, key, extra);
      +	assert(!restart);
     @@ reftable/record_test.c (new)
      +
      +	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
      +	assert(n == m);
     -+	assert(slice_equal(&key, &roundtrip));
     ++	assert(0 == slice_cmp(&key, &roundtrip));
      +	assert(rt_extra == extra);
      +
      +	slice_release(&last_key);
     @@ reftable/record_test.c (new)
      +		reftable_record_from_obj(&rec, &in);
      +		test_copy(&rec);
      +		reftable_record_key(&rec, &key);
     -+		slice_resize(&dest, 1024);
     ++		slice_grow(&dest, 1024);
     ++		slice_setlen(&dest, 1024);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n > 0);
      +		extra = reftable_record_val_type(&rec);
     @@ reftable/record_test.c (new)
      +	int n, m;
      +	byte extra;
      +
     -+	slice_set_string(&in.last_key, "refs/heads/master");
     ++	slice_addstr(&in.last_key, "refs/heads/master");
      +	reftable_record_from_index(&rec, &in);
      +	reftable_record_key(&rec, &key);
      +	test_copy(&rec);
      +
      +	assert(0 == slice_cmp(&key, &in.last_key));
     -+	slice_resize(&dest, 1024);
     ++	slice_grow(&dest, 1024);
     ++	slice_setlen(&dest, 1024);
      +	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +	assert(n > 0);
      +
     @@ reftable/refname.c (new)
      +{
      +	while (sl->len > 0) {
      +		bool is_slash = (sl->buf[sl->len - 1] == '/');
     -+		sl->len--;
     ++		slice_setlen(sl, sl->len - 1);
      +		if (is_slash)
      +			break;
      +	}
     @@ reftable/refname.c (new)
      +		err = validate_ref_name(mod->add[i]);
      +		if (err)
      +			goto done;
     -+		slice_set_string(&slashed, mod->add[i]);
     ++		slice_reset(&slashed);
     ++		slice_addstr(&slashed, mod->add[i]);
      +		slice_addstr(&slashed, "/");
      +
      +		err = modification_has_ref_with_prefix(
     @@ reftable/refname.c (new)
      +		if (err < 0)
      +			goto done;
      +
     -+		slice_set_string(&slashed, mod->add[i]);
     ++		slice_reset(&slashed);
     ++		slice_addstr(&slashed, mod->add[i]);
      +		while (slashed.len) {
      +			slice_trim_component(&slashed);
      +			err = modification_has_ref(mod,
     @@ reftable/refname_test.c (new)
      
       ## reftable/reftable-tests.h (new) ##
      @@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
      +#ifndef REFTABLE_TESTS_H
      +#define REFTABLE_TESTS_H
      +
     @@ reftable/reftable-tests.h (new)
      +int slice_test_main(int argc, const char **argv);
      +int stack_test_main(int argc, const char **argv);
      +int tree_test_main(int argc, const char **argv);
     ++int reftable_dump_main(int argc, char *const *argv);
      +
      +#endif
      
     @@ reftable/reftable.h (new)
      +	   - on writing a record with NULL ref_name.
      +	   - on writing a reftable_ref_record outside the table limits
      +	   - on writing a ref or log record before the stack's next_update_index
     ++	   - on writing a log record with multiline message with
     ++	   exact_log_message unset
      +	   - on reading a reftable_ref_record from log iterator, or vice versa.
      +	*/
      +	REFTABLE_API_ERROR = -6,
     @@ reftable/reftable.h (new)
      +	/* boolean: do not check ref names for validity or dir/file conflicts.
      +	 */
      +	int skip_name_check;
     ++
     ++	/* boolean: copy log messages exactly. If unset, check that the message
     ++	 *   is a single line, and add '\n' if missing.
     ++	 */
     ++	int exact_log_message;
      +};
      +
      +/* reftable_block_stats holds statistics for a single block type */
     @@ reftable/reftable_test.c (new)
      +		reftable_iterator_destroy(&it);
      +	}
      +
     -+	slice_set_string(&pastLast, names[N - 1]);
     ++	slice_addstr(&pastLast, names[N - 1]);
      +	slice_addstr(&pastLast, "/");
      +
      +	err = reftable_reader_seek_ref(&rd, &it, slice_as_string(&pastLast));
     @@ reftable/slice.c (new)
      +
      +struct slice reftable_empty_slice = SLICE_INIT;
      +
     -+void slice_set_string(struct slice *s, const char *str)
     -+{
     -+	int l;
     -+	if (str == NULL) {
     -+		s->len = 0;
     -+		return;
     -+	}
     -+	assert(s->canary == SLICE_CANARY);
     -+
     -+	l = strlen(str);
     -+	l++; /* \0 */
     -+	slice_resize(s, l);
     -+	memcpy(s->buf, str, l);
     -+	s->len = l - 1;
     -+}
     -+
      +void slice_init(struct slice *s)
      +{
      +	struct slice empty = SLICE_INIT;
      +	*s = empty;
      +}
      +
     -+void slice_resize(struct slice *s, int l)
     ++void slice_grow(struct slice *s, size_t extra)
      +{
     ++	size_t newcap = s->len + extra + 1;
     ++	if (newcap > s->cap) {
     ++		s->buf = reftable_realloc(s->buf, newcap);
     ++		s->cap = newcap;
     ++	}
     ++}
     ++
     ++static void slice_resize(struct slice *s, int l)
     ++{
     ++	int zl = l + 1; /* one byte for 0 termination. */
      +	assert(s->canary == SLICE_CANARY);
     -+	if (s->cap < l) {
     ++	if (s->cap < zl) {
      +		int c = s->cap * 2;
     -+		if (c < l) {
     -+			c = l;
     ++		if (c < zl) {
     ++			c = zl;
      +		}
      +		s->cap = c;
      +		s->buf = reftable_realloc(s->buf, s->cap);
      +	}
      +	s->len = l;
     ++	s->buf[l] = 0;
     ++}
     ++
     ++void slice_setlen(struct slice *s, size_t l)
     ++{
     ++	assert(s->cap >= l + 1);
     ++	s->len = l;
     ++	s->buf[l] = 0;
     ++}
     ++
     ++void slice_reset(struct slice *s)
     ++{
     ++	slice_resize(s, 0);
      +}
      +
      +void slice_addstr(struct slice *d, const char *s)
     @@ reftable/slice.c (new)
      +	s->len -= n;
      +}
      +
     -+byte *slice_detach(struct slice *s)
     ++char *slice_detach(struct slice *s)
      +{
     -+	byte *p = s->buf;
     -+	assert(s->canary == SLICE_CANARY);
     ++	char *p = NULL;
     ++	slice_as_string(s);
     ++	p = (char *)s->buf;
      +	s->buf = NULL;
      +	s->cap = 0;
      +	s->len = 0;
     @@ reftable/slice.c (new)
      +
      +void slice_release(struct slice *s)
      +{
     ++	byte *ptr = s->buf;
      +	assert(s->canary == SLICE_CANARY);
     -+	reftable_free(slice_detach(s));
     -+}
     -+
     -+void slice_copy(struct slice *dest, struct slice *src)
     -+{
     -+	assert(dest->canary == SLICE_CANARY);
     -+	assert(src->canary == SLICE_CANARY);
     -+	slice_resize(dest, src->len);
     -+	memcpy(dest->buf, src->buf, src->len);
     ++	s->buf = NULL;
     ++	s->cap = 0;
     ++	s->len = 0;
     ++	reftable_free(ptr);
      +}
      +
      +/* return the underlying data as char*. len is left unchanged, but
      +   a \0 is added at the end. */
      +const char *slice_as_string(struct slice *s)
      +{
     -+	assert(s->canary == SLICE_CANARY);
     -+	if (s->cap == s->len) {
     -+		int l = s->len;
     -+		slice_resize(s, l + 1);
     -+		s->len = l;
     -+	}
     -+	s->buf[s->len] = 0;
      +	return (const char *)s->buf;
      +}
      +
     -+/* return a newly malloced string for this slice */
     -+char *slice_to_string(struct slice *in)
     -+{
     -+	struct slice s = SLICE_INIT;
     -+	assert(in->canary == SLICE_CANARY);
     -+	slice_resize(&s, in->len + 1);
     -+	s.buf[in->len] = 0;
     -+	memcpy(s.buf, in->buf, in->len);
     -+	return (char *)slice_detach(&s);
     -+}
     -+
     -+bool slice_equal(struct slice *a, struct slice *b)
     -+{
     -+	return slice_cmp(a, b) == 0;
     -+}
     -+
      +int slice_cmp(const struct slice *a, const struct slice *b)
      +{
      +	int min = a->len < b->len ? a->len : b->len;
     @@ reftable/slice.c (new)
      +		return 0;
      +}
      +
     -+int slice_add(struct slice *b, byte *data, size_t sz)
     ++int slice_add(struct slice *b, const byte *data, size_t sz)
      +{
      +	assert(b->canary == SLICE_CANARY);
     -+	if (b->len + sz > b->cap) {
     -+		int newcap = 2 * b->cap + 1;
     -+		if (newcap < b->len + sz) {
     -+			newcap = (b->len + sz);
     -+		}
     -+		b->buf = reftable_realloc(b->buf, newcap);
     -+		b->cap = newcap;
     -+	}
     -+
     ++	slice_grow(b, sz);
      +	memcpy(b->buf + b->len, data, sz);
      +	b->len += sz;
     ++	b->buf[b->len] = 0;
      +	return sz;
      +}
      +
     @@ reftable/slice.h (new)
      +#include "reftable.h"
      +
      +/*
     -+  provides bounds-checked byte ranges.
     -+  To use, initialize as "slice x = {0};"
     ++  Provides a bounds-checked, growable byte ranges. To use, initialize as "slice
     ++  x = SLICE_INIT;"
      + */
      +struct slice {
      +	int len;
      +	int cap;
      +	byte *buf;
     ++
     ++	/* Used to enforce initialization with SLICE_INIT */
      +	byte canary;
      +};
      +#define SLICE_CANARY 0x42
     @@ reftable/slice.h (new)
      +	}
      +extern struct slice reftable_empty_slice;
      +
     -+void slice_set_string(struct slice *dest, const char *src);
      +void slice_addstr(struct slice *dest, const char *src);
      +
      +/* Deallocate and clear slice */
      +void slice_release(struct slice *slice);
      +
     -+/* Return a malloced string for `src` */
     -+char *slice_to_string(struct slice *src);
     ++/* Set slice to 0 length, but retain buffer. */
     ++void slice_reset(struct slice *slice);
      +
      +/* Initializes a slice. Accepts a slice with random garbage. */
      +void slice_init(struct slice *slice);
     @@ reftable/slice.h (new)
      +/* Ensure that `buf` is \0 terminated. */
      +const char *slice_as_string(struct slice *src);
      +
     -+/* Compare slices */
     -+bool slice_equal(struct slice *a, struct slice *b);
     -+
      +/* Return `buf`, clearing out `s` */
     -+byte *slice_detach(struct slice *s);
     ++char *slice_detach(struct slice *s);
      +
     -+/* Copy bytes */
     -+void slice_copy(struct slice *dest, struct slice *src);
     ++/* Set length of the slace to `l`, but don't reallocated. */
     ++void slice_setlen(struct slice *s, size_t l);
      +
     -+/* Advance `buf` by `n`, and decrease length. A copy of the slice
     -+   should be kept for deallocating the slice. */
     -+void slice_consume(struct slice *s, int n);
     -+
     -+/* Set length of the slice to `l` */
     -+void slice_resize(struct slice *s, int l);
     ++/* Ensure `l` bytes beyond current length are available */
     ++void slice_grow(struct slice *s, size_t l);
      +
      +/* Signed comparison */
      +int slice_cmp(const struct slice *a, const struct slice *b);
      +
      +/* Append `data` to the `dest` slice.  */
     -+int slice_add(struct slice *dest, byte *data, size_t sz);
     ++int slice_add(struct slice *dest, const byte *data, size_t sz);
      +
      +/* Append `add` to `dest. */
      +void slice_addbuf(struct slice *dest, struct slice *add);
     @@ reftable/slice.h (new)
      +
      +struct reftable_block_source malloc_block_source(void);
      +
     ++/* Advance `buf` by `n`, and decrease length. A copy of the slice
     ++   should be kept for deallocating the slice. */
     ++void slice_consume(struct slice *s, int n);
     ++
      +#endif
      
       ## reftable/slice_test.c (new) ##
     @@ reftable/slice_test.c (new)
      +	struct slice s = SLICE_INIT;
      +	struct slice t = SLICE_INIT;
      +
     -+	slice_set_string(&s, "abc");
     ++	slice_addstr(&s, "abc");
      +	assert(0 == strcmp("abc", slice_as_string(&s)));
      +
     -+	slice_set_string(&t, "pqr");
     -+
     ++	slice_addstr(&t, "pqr");
      +	slice_addbuf(&s, &t);
      +	assert(0 == strcmp("abcpqr", slice_as_string(&s)));
      +
     @@ reftable/stack.c (new)
      +
      +	*dest = NULL;
      +
     -+	slice_set_string(&list_file_name, dir);
     ++	slice_reset(&list_file_name);
     ++	slice_addstr(&list_file_name, dir);
      +	slice_addstr(&list_file_name, "/tables.list");
      +
     -+	p->list_file = slice_to_string(&list_file_name);
     -+	slice_release(&list_file_name);
     ++	p->list_file = slice_detach(&list_file_name);
      +	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
     @@ reftable/stack.c (new)
      +	int new_tables_len = 0;
      +	struct reftable_merged_table *new_merged = NULL;
      +	int i;
     -+	struct slice table_path = SLICE_INIT;
      +
      +	while (*names) {
      +		struct reftable_reader *rd = NULL;
     @@ reftable/stack.c (new)
      +
      +		if (rd == NULL) {
      +			struct reftable_block_source src = { 0 };
     -+			slice_set_string(&table_path, st->reftable_dir);
     ++			struct slice table_path = SLICE_INIT;
     ++			slice_addstr(&table_path, st->reftable_dir);
      +			slice_addstr(&table_path, "/");
      +			slice_addstr(&table_path, name);
      +
      +			err = reftable_block_source_from_file(
      +				&src, slice_as_string(&table_path));
     ++			slice_release(&table_path);
     ++
      +			if (err < 0)
      +				goto done;
      +
     @@ reftable/stack.c (new)
      +	}
      +
      +done:
     -+	slice_release(&table_path);
      +	for (i = 0; i < new_tables_len; i++) {
      +		reader_close(new_tables[i]);
      +		reftable_reader_free(new_tables[i]);
     @@ reftable/stack.c (new)
      +{
      +	char buf[100];
      +	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
     -+	slice_set_string(dest, buf);
     ++	slice_reset(dest);
     ++	slice_addstr(dest, buf);
      +}
      +
      +struct reftable_addition {
     @@ reftable/stack.c (new)
      +	int err = 0;
      +	add->stack = st;
      +
     -+	slice_set_string(&add->lock_file_name, st->list_file);
     ++	slice_reset(&add->lock_file_name);
     ++	slice_addstr(&add->lock_file_name, st->list_file);
      +	slice_addstr(&add->lock_file_name, ".lock");
      +
      +	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
     @@ reftable/stack.c (new)
      +	int i = 0;
      +	struct slice nm = SLICE_INIT;
      +	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_set_string(&nm, add->stack->list_file);
     ++		slice_reset(&nm);
     ++		slice_addstr(&nm, add->stack->list_file);
      +		slice_addstr(&nm, "/");
      +		slice_addstr(&nm, add->new_tables[i]);
      +		unlink(slice_as_string(&nm));
     @@ reftable/stack.c (new)
      +	int err = 0;
      +	int tab_fd = 0;
      +
     -+	slice_resize(&next_name, 0);
     ++	slice_reset(&next_name);
      +	format_name(&next_name, add->next_update_index, add->next_update_index);
      +
     -+	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
     ++	slice_addstr(&temp_tab_file_name, add->stack->reftable_dir);
      +	slice_addstr(&temp_tab_file_name, "/");
      +	slice_addbuf(&temp_tab_file_name, &next_name);
      +	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
     @@ reftable/stack.c (new)
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
      +	slice_addstr(&next_name, ".ref");
      +
     -+	slice_set_string(&tab_file_name, add->stack->reftable_dir);
     ++	slice_addstr(&tab_file_name, add->stack->reftable_dir);
      +	slice_addstr(&tab_file_name, "/");
      +	slice_addbuf(&tab_file_name, &next_name);
      +
     @@ reftable/stack.c (new)
      +	add->new_tables = reftable_realloc(add->new_tables,
      +					   sizeof(*add->new_tables) *
      +						   (add->new_tables_len + 1));
     -+	add->new_tables[add->new_tables_len] = slice_to_string(&next_name);
     ++	add->new_tables[add->new_tables_len] = slice_detach(&next_name);
      +	add->new_tables_len++;
      +done:
      +	if (tab_fd > 0) {
     @@ reftable/stack.c (new)
      +		    reftable_reader_min_update_index(st->merged->stack[first]),
      +		    reftable_reader_max_update_index(st->merged->stack[first]));
      +
     -+	slice_set_string(temp_tab, st->reftable_dir);
     ++	slice_reset(temp_tab);
     ++	slice_addstr(temp_tab, st->reftable_dir);
      +	slice_addstr(temp_tab, "/");
      +	slice_addbuf(temp_tab, &next_name);
      +	slice_addstr(temp_tab, ".temp.XXXXXX");
     @@ reftable/stack.c (new)
      +
      +	st->stats.attempts++;
      +
     -+	slice_set_string(&lock_file_name, st->list_file);
     ++	slice_reset(&lock_file_name);
     ++	slice_addstr(&lock_file_name, st->list_file);
      +	slice_addstr(&lock_file_name, ".lock");
      +
      +	lock_file_fd = open(slice_as_string(&lock_file_name),
     @@ reftable/stack.c (new)
      +		struct slice subtab_lock = SLICE_INIT;
      +		int sublock_file_fd = -1;
      +
     -+		slice_set_string(&subtab_file_name, st->reftable_dir);
     ++		slice_addstr(&subtab_file_name, st->reftable_dir);
      +		slice_addstr(&subtab_file_name, "/");
      +		slice_addstr(&subtab_file_name,
      +			     reader_name(st->merged->stack[i]));
      +
     -+		slice_copy(&subtab_lock, &subtab_file_name);
     ++		slice_reset(&subtab_lock);
     ++		slice_addbuf(&subtab_lock, &subtab_file_name);
      +		slice_addstr(&subtab_lock, ".lock");
      +
      +		sublock_file_fd = open(slice_as_string(&subtab_lock),
     @@ reftable/stack.c (new)
      +		    st->merged->stack[last]->max_update_index);
      +	slice_addstr(&new_table_name, ".ref");
      +
     -+	slice_set_string(&new_table_path, st->reftable_dir);
     ++	slice_reset(&new_table_path);
     ++	slice_addstr(&new_table_path, st->reftable_dir);
      +	slice_addstr(&new_table_path, "/");
     -+
      +	slice_addbuf(&new_table_path, &new_table_name);
      +
      +	if (!is_empty_table) {
     @@ reftable/stack_test.c (new)
      +#include <sys/types.h>
      +#include <dirent.h>
      +
     -+static void clear_dir(const char *dirname)
     -+{
     -+	int fd = open(dirname, O_DIRECTORY, 0);
     -+	DIR *dir = fdopendir(fd);
     -+	struct dirent *ent = NULL;
     -+
     -+	assert(fd >= 0);
     -+
     -+	while ((ent = readdir(dir)) != NULL) {
     -+		unlinkat(fd, ent->d_name, 0);
     -+	}
     -+	closedir(dir);
     -+	rmdir(dirname);
     -+}
     -+
      +static void test_read_file(void)
      +{
      +	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
     @@ reftable/stack_test.c (new)
      +
      +	reftable_ref_record_clear(&dest);
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_uptodate(void)
     @@ reftable/stack_test.c (new)
      +	assert_err(err);
      +	reftable_stack_destroy(st1);
      +	reftable_stack_destroy(st2);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_transaction_api(void)
     @@ reftable/stack_test.c (new)
      +
      +	reftable_ref_record_clear(&dest);
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_validate_refname(void)
     @@ reftable/stack_test.c (new)
      +	}
      +
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static int write_error(struct reftable_writer *wr, void *arg)
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_add(st, &write_test_ref, &ref2);
      +	assert(err == REFTABLE_API_ERROR);
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_lock_failure(void)
     @@ reftable/stack_test.c (new)
      +	}
      +
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_add(void)
      +{
      +	int i = 0;
      +	int err = 0;
     -+	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_write_options cfg = {
     ++		.exact_log_message = true,
     ++	};
      +	struct reftable_stack *st = NULL;
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
     -+	struct reftable_ref_record refs[2] = { 0 };
     -+	struct reftable_log_record logs[2] = { 0 };
     ++	struct reftable_ref_record refs[2] = { { 0 } };
     ++	struct reftable_log_record logs[2] = { { 0 } };
      +	int N = ARRAY_SIZE(refs);
      +
      +	assert(mkdtemp(dir));
     @@ reftable/stack_test.c (new)
      +		reftable_ref_record_clear(&refs[i]);
      +		reftable_log_record_clear(&logs[i]);
      +	}
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
     ++}
     ++
     ++static void test_reftable_stack_log_normalize(void)
     ++{
     ++	int err = 0;
     ++	struct reftable_write_options cfg = {
     ++		0,
     ++	};
     ++	struct reftable_stack *st = NULL;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++
     ++	byte h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
     ++
     ++	struct reftable_log_record input = {
     ++		.ref_name = "branch",
     ++		.update_index = 1,
     ++		.new_hash = h1,
     ++		.old_hash = h2,
     ++	};
     ++	struct reftable_log_record dest = {
     ++		.update_index = 0,
     ++	};
     ++	struct write_log_arg arg = {
     ++		.log = &input,
     ++		.update_index = 1,
     ++	};
     ++
     ++	assert(mkdtemp(dir));
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++
     ++	input.message = "one\ntwo";
     ++	err = reftable_stack_add(st, &write_test_log, &arg);
     ++	assert(err == REFTABLE_API_ERROR);
     ++
     ++	input.message = "one";
     ++	err = reftable_stack_add(st, &write_test_log, &arg);
     ++	assert_err(err);
     ++
     ++	err = reftable_stack_read_log(st, input.ref_name, &dest);
     ++	assert_err(err);
     ++	assert(0 == strcmp(dest.message, "one\n"));
     ++
     ++	input.message = "two\n";
     ++	arg.update_index = 2;
     ++	err = reftable_stack_add(st, &write_test_log, &arg);
     ++	assert_err(err);
     ++	err = reftable_stack_read_log(st, input.ref_name, &dest);
     ++	assert_err(err);
     ++	assert(0 == strcmp(dest.message, "two\n"));
     ++
     ++	/* cleanup */
     ++	reftable_stack_destroy(st);
     ++	reftable_log_record_clear(&dest);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_tombstone(void)
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	struct reftable_ref_record refs[2] = { 0 };
     -+	struct reftable_log_record logs[2] = { 0 };
     ++	struct reftable_ref_record refs[2] = { { 0 } };
     ++	struct reftable_log_record logs[2] = { { 0 } };
      +	int N = ARRAY_SIZE(refs);
      +	struct reftable_ref_record dest = { 0 };
      +	struct reftable_log_record log_dest = { 0 };
     @@ reftable/stack_test.c (new)
      +		reftable_ref_record_clear(&refs[i]);
      +		reftable_log_record_clear(&logs[i]);
      +	}
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_hash_id(void)
     @@ reftable/stack_test.c (new)
      +	reftable_ref_record_clear(&dest);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st_default);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +static void test_log2(void)
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
     -+	struct reftable_log_record logs[20] = { 0 };
     ++	struct reftable_log_record logs[20] = { { 0 } };
      +	int N = ARRAY_SIZE(logs) - 1;
      +	int i = 0;
      +	int err;
     @@ reftable/stack_test.c (new)
      +	for (i = 0; i <= N; i++) {
      +		reftable_log_record_clear(&logs[i]);
      +	}
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +	reftable_log_record_clear(&log);
      +}
      +
     @@ reftable/stack_test.c (new)
      +
      +	err = reftable_new_stack(&st2, dir, cfg);
      +	assert_err(err);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st2);
      +}
     @@ reftable/stack_test.c (new)
      +	       (uint64_t)(N * fastlog2(N)));
      +
      +	reftable_stack_destroy(st);
     -+	clear_dir(dir);
     ++	reftable_clear_dir(dir);
      +}
      +
      +int stack_test_main(int argc, const char *argv[])
     @@ reftable/stack_test.c (new)
      +		      &test_reftable_stack_update_index_check);
      +	add_test_case("test_reftable_stack_lock_failure",
      +		      &test_reftable_stack_lock_failure);
     ++	add_test_case("test_reftable_stack_log_normalize",
     ++		      &test_reftable_stack_log_normalize);
      +	add_test_case("test_reftable_stack_tombstone",
      +		      &test_reftable_stack_tombstone);
      +	add_test_case("test_reftable_stack_add_one",
     @@ reftable/system.h (new)
      +#define SYSTEM_H
      +
      +#if 1 /* REFTABLE_IN_GITCORE */
     ++#define REFTABLE_IN_GITCORE
      +
      +#include "git-compat-util.h"
      +#include "cache.h"
     @@ reftable/system.h (new)
      +
      +#endif /* REFTABLE_IN_GITCORE */
      +
     ++void reftable_clear_dir(const char *dirname);
     ++
      +#define SHA1_ID 0x73686131
      +#define SHA256_ID 0x73323536
      +#define SHA1_SIZE 20
     @@ reftable/system.h (new)
      +typedef int bool;
      +
      +/* This is uncompress2, which is only available in zlib as of 2017.
     -+ *
     -+ * TODO: in git-core, this should fallback to uncompress2 if it is available.
      + */
      +int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
      +			       const Bytef *source, uLong *sourceLen);
     @@ reftable/update.sh (new)
      +mv reftable/system.h reftable/system.h~
      +sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
      +
     -+# Remove compatibility hacks we don't need here.
     -+rm reftable/compat.*
     -+
      +git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
      
       ## reftable/writer.c (new) ##
     @@ reftable/writer.c (new)
      +		key = reftable_malloc(sizeof(struct obj_index_tree_node));
      +		*key = empty;
      +
     -+		slice_copy(&key->hash, hash);
     ++		slice_reset(&key->hash);
     ++		slice_addbuf(&key->hash, hash);
      +		tree_search((void *)key, &w->obj_index_tree,
      +			    &obj_index_tree_node_compare, 1);
      +	} else {
     @@ reftable/writer.c (new)
      +	if (slice_cmp(&w->last_key, &key) >= 0)
      +		goto done;
      +
     -+	slice_copy(&w->last_key, &key);
     ++	slice_reset(&w->last_key);
     ++	slice_addbuf(&w->last_key, &key);
      +	if (w->block_writer == NULL) {
      +		writer_reinit_block_writer(w, reftable_record_type(rec));
      +	}
     @@ reftable/writer.c (new)
      +		return err;
      +
      +	if (!w->opts.skip_index_objects && ref->value != NULL) {
     -+		struct slice h = {
     -+			.buf = ref->value,
     -+			.len = hash_size(w->opts.hash_id),
     -+			.canary = SLICE_CANARY,
     -+		};
     -+
     ++		struct slice h = SLICE_INIT;
     ++		slice_add(&h, ref->value, hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
     ++		slice_release(&h);
      +	}
      +
      +	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
     -+		struct slice h = {
     -+			.buf = ref->target_value,
     -+			.len = hash_size(w->opts.hash_id),
     -+			.canary = SLICE_CANARY,
     -+		};
     ++		struct slice h = SLICE_INIT;
     ++		slice_add(&h, ref->target_value, hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
      +	}
      +	return 0;
     @@ reftable/writer.c (new)
      +			    struct reftable_log_record *log)
      +{
      +	struct reftable_record rec = { 0 };
     ++	char *input_log_message = log->message;
     ++	struct slice cleaned_message = SLICE_INIT;
      +	int err;
      +	if (log->ref_name == NULL)
      +		return REFTABLE_API_ERROR;
     @@ reftable/writer.c (new)
      +			return err;
      +	}
      +
     ++	if (!w->opts.exact_log_message && log->message != NULL) {
     ++		slice_addstr(&cleaned_message, log->message);
     ++		while (cleaned_message.len &&
     ++		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
     ++			slice_setlen(&cleaned_message, cleaned_message.len - 1);
     ++		if (strchr(slice_as_string(&cleaned_message), '\n')) {
     ++			// multiple lines not allowed.
     ++			err = REFTABLE_API_ERROR;
     ++			goto done;
     ++		}
     ++		slice_addstr(&cleaned_message, "\n");
     ++		log->message = (char *)slice_as_string(&cleaned_message);
     ++	}
     ++
      +	w->next -= w->pending_padding;
      +	w->pending_padding = 0;
      +
      +	reftable_record_from_log(&rec, log);
      +	err = writer_add_record(w, &rec);
     ++
     ++done:
     ++	log->message = input_log_message;
     ++	slice_release(&cleaned_message);
      +	return err;
      +}
      +
     @@ reftable/writer.c (new)
      +	}
      +
      +	ir.offset = w->next;
     -+	slice_copy(&ir.last_key, &w->block_writer->last_key);
     ++	slice_reset(&ir.last_key);
     ++	slice_addbuf(&ir.last_key, &w->block_writer->last_key);
      +	w->index[w->index_len] = ir;
      +
      +	w->index_len++;
 10:  f3d74b78135 ! 12:  e1b01927454 Reftable support for git-core
     @@ Makefile: VCSSVN_OBJS += vcs-svn/sliding_window.o
       
      +REFTABLE_OBJS += reftable/basics.o
      +REFTABLE_OBJS += reftable/block.o
     ++REFTABLE_OBJS += reftable/compat.o
      +REFTABLE_OBJS += reftable/file.o
      +REFTABLE_OBJS += reftable/iter.o
      +REFTABLE_OBJS += reftable/merged.o
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	for (i = 0; i < arg->refnames->nr; i++) {
     -+		struct reftable_log_record log = { NULL };
     ++		struct reftable_log_record log = {
     ++			.update_index = ts,
     ++		};
      +		struct reftable_ref_record current = { NULL };
      +		fill_reftable_log_record(&log);
      +		log.message = xstrdup(arg->logmsg);
     @@ refs/reftable-backend.c (new)
      +	};
      +	reftable_writer_set_limits(writer, ts, ts);
      +	err = reftable_writer_add_ref(writer, &ref);
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	{
     ++	if (err == 0) {
      +		struct reftable_log_record log = { NULL };
      +		struct object_id new_oid;
      +		struct object_id old_oid;
     -+		struct reftable_ref_record current = { NULL };
     -+		reftable_stack_read_ref(create->refs->stack, create->refname,
     -+					&current);
      +
      +		fill_reftable_log_record(&log);
     -+		log.ref_name = current.ref_name;
     ++		log.ref_name = (char *)create->refname;
     ++		log.message = (char *)create->logmsg;
     ++		log.update_index = ts;
      +		if (refs_resolve_ref_unsafe(
      +			    (struct ref_store *)create->refs, create->refname,
      +			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
     @@ refs/reftable-backend.c (new)
      +		}
      +
      +		if (log.old_hash != NULL || log.new_hash != NULL) {
     -+			reftable_writer_add_log(writer, &log);
     ++			err = reftable_writer_add_log(writer, &log);
      +		}
      +		log.ref_name = NULL;
     ++		log.message = NULL;
      +		log.old_hash = NULL;
      +		log.new_hash = NULL;
      +		clear_reftable_log_record(&log);
      +	}
     -+	return 0;
     ++	return err;
      +}
      +
      +static int reftable_create_symref(struct ref_store *ref_store,
     @@ refs/reftable-backend.c (new)
      +	mt = reftable_stack_merged_table(refs->stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	while (err == 0) {
     ++		struct object_id old_oid;
     ++		struct object_id new_oid;
     ++		const char *full_committer = "";
     ++
      +		err = reftable_iterator_next_log(&it, &log);
     -+		if (err != 0) {
     ++		if (err > 0) {
     ++			err = 0;
     ++			break;
     ++		}
     ++		if (err < 0) {
      +			break;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		{
     -+			struct object_id old_oid;
     -+			struct object_id new_oid;
     -+			const char *full_committer = "";
     -+
     -+			hashcpy(old_oid.hash, log.old_hash);
     -+			hashcpy(new_oid.hash, log.new_hash);
     -+
     -+			full_committer = fmt_ident(log.name, log.email,
     -+						   WANT_COMMITTER_IDENT,
     -+						   /*date*/ NULL,
     -+						   IDENT_NO_DATE);
     -+			if (fn(&old_oid, &new_oid, full_committer, log.time,
     -+			       log.tz_offset, log.message, cb_data)) {
     -+				err = -1;
     -+				break;
     -+			}
     -+		}
     ++		hashcpy(old_oid.hash, log.old_hash);
     ++		hashcpy(new_oid.hash, log.new_hash);
     ++
     ++		full_committer = fmt_ident(log.name, log.email,
     ++					   WANT_COMMITTER_IDENT,
     ++					   /*date*/ NULL, IDENT_NO_DATE);
     ++		err = fn(&old_oid, &new_oid, full_committer, log.time,
     ++			 log.tz_offset, log.message, cb_data);
     ++		if (err)
     ++			break;
      +	}
      +
      +	reftable_log_record_clear(&log);
      +	reftable_iterator_destroy(&it);
     -+	if (err > 0) {
     -+		err = 0;
     -+	}
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	while (err == 0) {
      +		struct reftable_log_record log = { NULL };
      +		err = reftable_iterator_next_log(&it, &log);
     -+		if (err != 0) {
     ++		if (err > 0) {
     ++			err = 0;
     ++			break;
     ++		}
     ++		if (err < 0) {
      +			break;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +		full_committer = fmt_ident(log->name, log->email,
      +					   WANT_COMMITTER_IDENT, NULL,
      +					   IDENT_NO_DATE);
     -+		if (!fn(&old_oid, &new_oid, full_committer, log->time,
     -+			log->tz_offset, log->message, cb_data)) {
     -+			err = -1;
     ++		err = fn(&old_oid, &new_oid, full_committer, log->time,
     ++			 log->tz_offset, log->message, cb_data);
     ++		if (err) {
      +			break;
      +		}
      +	}
     @@ refs/reftable-backend.c (new)
      +	free(logs);
      +
      +	reftable_iterator_destroy(&it);
     -+	if (err > 0) {
     -+		err = 0;
     -+	}
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	reftable_read_raw_ref,
      +
      +	reftable_reflog_iterator_begin,
     -+	reftable_for_each_reflog_ent_newest_first,
      +	reftable_for_each_reflog_ent_oldest_first,
     ++	reftable_for_each_reflog_ent_newest_first,
      +	reftable_reflog_exists,
      +	reftable_create_reflog,
      +	reftable_delete_reflog,
     @@ t/t0031-reftable.sh (new)
      +	test_line_count = 0 output
      +'
      +
     ++test_expect_success 'branch switch in reflog output' '
     ++	initialize &&
     ++	test_commit file1 &&
     ++	git checkout -b branch1 &&
     ++	test_commit file2 &&
     ++	git checkout -b branch2 &&
     ++	git switch - &&
     ++	git rev-parse --symbolic-full-name HEAD > actual &&
     ++	echo refs/heads/branch1 > expect &&
     ++	test_cmp actual expect
     ++'
     ++
     ++
      +# This matches show-ref's output
      +print_ref() {
      +	echo "$(git rev-parse "$1") $1"
 11:  3e7868ee409 ! 13:  0359fe416fa Hookup unittests for the reftable library.
     @@ Makefile: t/helper/test-svn-fe$X: $(VCSSVN_LIB)
       
       check-sha1:: t/helper/test-tool$X
      
     + ## t/helper/test-reftable.c (new) ##
     +@@
     ++#include "reftable/reftable-tests.h"
     ++#include "test-tool.h"
     ++
     ++int cmd__reftable(int argc, const char **argv)
     ++{
     ++	block_test_main(argc, argv);
     ++	merged_test_main(argc, argv);
     ++	record_test_main(argc, argv);
     ++	refname_test_main(argc, argv);
     ++	reftable_test_main(argc, argv);
     ++	slice_test_main(argc, argv);
     ++	stack_test_main(argc, argv);
     ++	tree_test_main(argc, argv);
     ++	return 0;
     ++}
     +
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "read-graph", cmd__read_graph },
 12:  1f193b6da23 ! 14:  88640ea13f9 Add GIT_DEBUG_REFS debugging mechanism
     @@ refs/debug.c (new)
      +static void print_update(int i, const char *refname,
      +			 const struct object_id *old_oid,
      +			 const struct object_id *new_oid, unsigned int flags,
     -+			 unsigned int type)
     ++			 unsigned int type, const char *msg)
      +{
      +	char o[200] = "null";
      +	char n[200] = "null";
     @@ refs/debug.c (new)
      +	type &= 0xf; /* see refs.h REF_* */
      +	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
      +		 REF_FORCE_CREATE_REFLOG | REF_LOG_ONLY;
     -+	printf("%d: %s %s -> %s (F=0x%x, T=0x%x)\n", i, refname, o, n, flags,
     -+	       type);
     ++	printf("%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname, o, n,
     ++	       flags, type, msg);
      +}
      +
      +static void print_transaction(struct ref_transaction *transaction)
     @@ refs/debug.c (new)
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = transaction->updates[i];
      +		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
     -+			     u->type);
     ++			     u->type, u->msg);
      +	}
      +	printf("}\n");
      +}
     @@ refs/debug.c (new)
      +}
      +
      +static int debug_create_symref(struct ref_store *ref_store,
     -+			       const char *ref_target,
     -+			       const char *refs_heads_master,
     ++			       const char *ref_name, const char *target,
      +			       const char *logmsg)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     -+	int res = drefs->refs->be->create_symref(drefs->refs, ref_target,
     -+						 refs_heads_master, logmsg);
     ++	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
     ++						 logmsg);
     ++	printf("create_symref: %s -> %s \"%s\": %d\n", ref_name, target, logmsg,
     ++	       res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
      +	return res;
      +}
     ++
      +static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
      +			    const char *newref, const char *logmsg)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
      +					      logmsg);
     ++	printf("rename_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg,
     ++	       res);
      +	return res;
      +}
     ++
      +static int debug_copy_ref(struct ref_store *ref_store, const char *oldref,
      +			  const char *newref, const char *logmsg)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res =
      +		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
     ++	printf("copy_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	struct ref_iterator *res =
      +		drefs->refs->be->reflog_iterator_begin(drefs->refs);
     ++	printf("for_each_reflog_iterator_begin\n");
      +	return res;
      +}
      +
     ++struct debug_reflog {
     ++	const char *refname;
     ++	each_reflog_ent_fn *fn;
     ++	void *cb_data;
     ++};
     ++
     ++static int debug_print_reflog_ent(struct object_id *old_oid,
     ++				  struct object_id *new_oid,
     ++				  const char *committer, timestamp_t timestamp,
     ++				  int tz, const char *msg, void *cb_data)
     ++{
     ++	struct debug_reflog *dbg = (struct debug_reflog *)cb_data;
     ++	int ret;
     ++	char o[100] = "null";
     ++	char n[100] = "null";
     ++	if (old_oid)
     ++		oid_to_hex_r(o, old_oid);
     ++	if (new_oid)
     ++		oid_to_hex_r(n, new_oid);
     ++
     ++	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
     ++		      dbg->cb_data);
     ++	printf("reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
     ++	       dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
     ++	return ret;
     ++}
     ++
      +static int debug_for_each_reflog_ent(struct ref_store *ref_store,
      +				     const char *refname, each_reflog_ent_fn fn,
      +				     void *cb_data)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     -+	int res = drefs->refs->be->for_each_reflog_ent(drefs->refs, refname, fn,
     -+						       cb_data);
     ++	struct debug_reflog dbg = {
     ++		.refname = refname,
     ++		.fn = fn,
     ++		.cb_data = cb_data,
     ++	};
     ++
     ++	int res = drefs->refs->be->for_each_reflog_ent(
     ++		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     ++	printf("for_each_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
     ++
      +static int debug_for_each_reflog_ent_reverse(struct ref_store *ref_store,
      +					     const char *refname,
      +					     each_reflog_ent_fn fn,
      +					     void *cb_data)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     ++	struct debug_reflog dbg = {
     ++		.refname = refname,
     ++		.fn = fn,
     ++		.cb_data = cb_data,
     ++	};
      +	int res = drefs->refs->be->for_each_reflog_ent_reverse(
     -+		drefs->refs, refname, fn, cb_data);
     ++		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     ++	printf("for_each_reflog_reverse: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
     ++	printf("reflog_exists: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ t/t0033-debug-refs.sh (new)
      +test_expect_success 'GIT_DEBUG_REFS' '
      +	git init --ref-storage=files files &&
      +	git init --ref-storage=reftable reftable &&
     -+	(cd files && GIT_DEBUG_REFS=1 test_commit message file) > files.txt && 
     ++	(cd files && GIT_DEBUG_REFS=1 test_commit message file) > files.txt &&
      +	(cd reftable && GIT_DEBUG_REFS=1 test_commit message file) > reftable.txt &&
      +	test_cmp files.txt reftable.txt
      +'
 13:  0471f7e3570 = 15:  1c0cc646084 vcxproj: adjust for the reftable changes
 14:  a03c882b075 ! 16:  4f24b5f73de Add reftable testing infrastructure
     @@ Commit message
           * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
           * t1405 - inspecs .git/ directly.
      
     -    Worst offenders:
     -
     -    t1400-update-ref.sh                      - 82 of 185
     -    t2400-worktree-add.sh                    - 58 of 69
     -    t1404-update-ref-errors.sh               - 44 of 53
     -    t3514-cherry-pick-revert-gpg.sh          - 36 of 36
     -    t5541-http-push-smart.sh                 - 29 of 38
     -    t6003-rev-list-topo-order.sh             - 29 of 35
     -    t3420-rebase-autostash.sh                - 28 of 42
     -    t6120-describe.sh                        - 21 of 82
     -    t3430-rebase-merges.sh                   - 18 of 24
     -    t2018-checkout-branch.sh                 - 15 of 22
     -    ..
     -
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## builtin/clone.c ##
  -:  ----------- > 17:  ad5658ffc51 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
