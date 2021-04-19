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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF91A61165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhDSLij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhDSLic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F41C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g9so17634322wrx.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=H6g5hunJn5+6jg3HG+byVUnJqyQAaYL1ooNQT3McS2A=;
        b=fZk/19IFkxB+2GIZ3rofWzi7QPdWBUtf9oQ8SmKbPjZBVGvpiQp7U3yhJgGXKD0+2/
         6gV+OdpsvvmHPu2CMV86/DHD6scdUA77wbkreoe+iJ3wZSiIW3SVC3fcGBkxObKTZEG6
         XDPyi9JcrByXJifkjV69i8M5OKa2u+23y6hHj5oFapltPSvF/SQMRwOt7jCJviRY3R+Z
         FC8kIPocNZHKNOEw17GQL07bOW1S9jWBea+PRHSWLqzD4cpvHLC583rtQIHlE2eD07Gy
         meZNnLMQyLRHjMI44Ssj4wIMPvopQ2x6jysHGMVWbJqMbnbkAn9ZGwCpMn+5zrOgjMeF
         JoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=H6g5hunJn5+6jg3HG+byVUnJqyQAaYL1ooNQT3McS2A=;
        b=O+bJVTPjIcuZH6MCv8C0ii8+8RsrG8vB5vSSUPHHuhSbuZdwskBSpAubvXgOn+2XwM
         IG1yPFK6QgbPOpSTuoq49ldlZSOQSmWd0aapkcGNzYjgHo2iO2q4T8vvgzDtRpzN7IYg
         T0udVtIGkop58Cq5Puwpr6xbcDivGKXAtLOS2TDbZGJE5aFeuxSiSjxOistuyf5AuA3a
         2LsNaM47+IPJ1xLjO8qaIbLXElEpIxMJ4Ahd8jGCmsVkM45Bjjv3PjK1lTmbx5opFA8G
         9wDhsFxJJQD6NuWkkzsegQB+vG1V9ISB5PrEatN1MppyBkS0D66jpiPb3KdLqcWW7Cp6
         mpfw==
X-Gm-Message-State: AOAM530t9xCj0t6udWxvL5blzlhD/fiY4BO5xUmHNGxyRRRXB6uFcNb7
        Jhaq+2EfXz+7KQGauLeRStDVdPDBaLY=
X-Google-Smtp-Source: ABdhPJyJaV4yBbdbJyj4Wj2CvEgWC6dZ5yB7PaSFv/b6yYCFBNQZojNM3meWOlYF2rb1Qz8jzI/Jsw==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr13534800wru.276.1618832279287;
        Mon, 19 Apr 2021 04:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm21973741wrz.7.2021.04.19.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:37:58 -0700 (PDT)
Message-Id: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:28 +0000
Subject: [PATCH v7 00/28] reftable library
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

Changes relative to last series: version 12 Apr 2021:

 * AEvar's comments: zlib into compat/, void* casts, use implicit pointer
   <-> boolean conversions.
 * Plug memory leak in indexed reverse lookup.
 * Take SHA1/SHA256 constants from git headers.
 * Fix branch rename (branch -M)
 * Fix stash (support reflog deletion.)
 * Move debug printing logic out of dump.c
 * Fix reflog --dry-run expire.
 * Implement branch copy (branch -c)
 * Fix deletion of 0 branches
 * Fix transactions without REF_HAVE_OLD
 * Add requirement REFFILES for test cases that are specific to the files
   backend.
 * Fixes for various test files.

The commits up to "hash.h: provide constants for the hash IDs" should be
good to merge to 'next'.

There are several test fixups, but I've put them in another series because
GGG enforces max 30 commits.

Due to using uncompress2, this build fails on the Linux32 builder; what is
the magic incantation to run autoconf? There are other unexplained failures
in t0031-reftable.sh on CI that I haven't been able to look into. The test
passes for me, locally.

Han-Wen Nienhuys (27):
  refs: ref_iterator_peel returns boolean, rather than peel_status
  refs: document reflog_expire_fn's flag argument
  refs/debug: trace into reflog expiry too
  hash.h: provide constants for the hash IDs
  init-db: set the_repository->hash_algo early on
  reftable: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  Provide zlib's uncompress2 from compat/zlib-compat.c
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: generic interface to tables
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: add a heap-based priority queue for reftable records
  reftable: add merged table view
  reftable: implement refname validation
  reftable: implement stack, a mutable database of reftable files.
  reftable: add dump utility
  Reftable support for git-core
  Add "test-tool dump-reftable" command.
  t1301: document what needs to be done for REFTABLE
  t1401,t2011: parameterize HEAD.lock for REFTABLE
  t1404: annotate test cases with REFFILES

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   54 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   76 +-
 builtin/stash.c                               |    8 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    8 +-
 compat/.gitattributes                         |    1 +
 compat/zlib-uncompress2.c                     |   92 +
 config.mak.uname                              |    2 +-
 configure.ac                                  |   13 +
 contrib/buildsystems/CMakeLists.txt           |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 git-compat-util.h                             |    4 +
 hash.h                                        |    6 +
 object-file.c                                 |    6 +-
 refs.c                                        |   28 +-
 refs.h                                        |    3 +
 refs/debug.c                                  |   47 +-
 refs/ref-cache.c                              |    2 +-
 refs/refs-internal.h                          |    8 +
 refs/reftable-backend.c                       | 1616 +++++++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/basics.c                             |  128 ++
 reftable/basics.h                             |   60 +
 reftable/basics_test.c                        |   98 +
 reftable/block.c                              |  446 +++++
 reftable/block.h                              |  127 ++
 reftable/block_test.c                         |  121 ++
 reftable/blocksource.c                        |  148 ++
 reftable/blocksource.h                        |   22 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  100 +
 reftable/error.c                              |   41 +
 reftable/generic.c                            |  169 ++
 reftable/generic.h                            |   32 +
 reftable/iter.c                               |  194 ++
 reftable/iter.h                               |   69 +
 reftable/merged.c                             |  362 ++++
 reftable/merged.h                             |   35 +
 reftable/merged_test.c                        |  292 +++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   32 +
 reftable/pq_test.c                            |   72 +
 reftable/publicbasics.c                       |   58 +
 reftable/reader.c                             |  794 ++++++++
 reftable/reader.h                             |   66 +
 reftable/readwrite_test.c                     |  621 +++++++
 reftable/record.c                             | 1202 ++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  407 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   29 +
 reftable/refname_test.c                       |  102 ++
 reftable/reftable-blocksource.h               |   49 +
 reftable/reftable-error.h                     |   62 +
 reftable/reftable-generic.h                   |   47 +
 reftable/reftable-iterator.h                  |   39 +
 reftable/reftable-malloc.h                    |   18 +
 reftable/reftable-merged.h                    |   72 +
 reftable/reftable-reader.h                    |  101 ++
 reftable/reftable-record.h                    |  114 ++
 reftable/reftable-stack.h                     |  128 ++
 reftable/reftable-tests.h                     |   23 +
 reftable/reftable-writer.h                    |  147 ++
 reftable/reftable.c                           |  115 ++
 reftable/stack.c                              | 1395 ++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  940 ++++++++++
 reftable/system.h                             |   24 +
 reftable/test_framework.c                     |   23 +
 reftable/test_framework.h                     |   53 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   61 +
 reftable/writer.c                             |  690 +++++++
 reftable/writer.h                             |   50 +
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    9 +-
 t/helper/test-reftable.c                      |   21 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  271 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1301-shared-repo.sh                        |    8 +-
 t/t1401-symbolic-ref.sh                       |   11 +-
 t/t1404-update-ref-errors.sh                  |   86 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t2011-checkout-invalid-head.sh              |   11 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 95 files changed, 13065 insertions(+), 86 deletions(-)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/error.c
 create mode 100644 reftable/generic.c
 create mode 100644 reftable/generic.h
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/readwrite_test.c
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-blocksource.h
 create mode 100644 reftable/reftable-error.h
 create mode 100644 reftable/reftable-generic.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-merged.h
 create mode 100644 reftable/reftable-reader.h
 create mode 100644 reftable/reftable-record.h
 create mode 100644 reftable/reftable-stack.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable-writer.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: 54a391711554ed41b4b0792cfef004abc74893bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v7
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v6:

  -:  ------------ >  1:  8103a80394ae refs: ref_iterator_peel returns boolean, rather than peel_status
  -:  ------------ >  2:  554bb1ac3aed refs: document reflog_expire_fn's flag argument
  -:  ------------ >  3:  9ae5ddff6aed refs/debug: trace into reflog expiry too
  -:  ------------ >  4:  f0216ae20b69 hash.h: provide constants for the hash IDs
  1:  15b8306fbe4b =  5:  fa64aa9ce7c1 init-db: set the_repository->hash_algo early on
  2:  02bd1f40fa4e =  6:  8a960fb77fa9 reftable: add LICENSE
  3:  bffa33c012ad =  7:  5177919a3fd2 reftable: add error related functionality
  4:  df8003cb9a7d !  8:  a24e9e661616 reftable: utility functions
     @@ reftable/basics.c (new)
      +void free_names(char **a)
      +{
      +	char **p;
     -+	if (a == NULL) {
     ++	if (!a) {
      +		return;
      +	}
      +	for (p = a; *p; p++) {
     @@ reftable/basics_test.c (new)
      +
      +static int binsearch_func(size_t i, void *void_args)
      +{
     -+	struct binsearch_args *args = (struct binsearch_args *)void_args;
     ++	struct binsearch_args *args = void_args;
      +
      +	return args->key < args->arr[i];
      +}
     @@ reftable/basics_test.c (new)
      +	parse_names(in, strlen(in), &out);
      +	EXPECT(!strcmp(out[0], "a"));
      +	EXPECT(!strcmp(out[1], "b"));
     -+	EXPECT(out[2] == NULL);
     ++	EXPECT(!out[2]);
      +	free_names(out);
      +}
      +
     @@ reftable/basics_test.c (new)
      +	char **out = NULL;
      +	parse_names(in, strlen(in), &out);
      +	EXPECT(!strcmp(out[0], "a"));
     -+	EXPECT(out[1] == NULL);
     ++	EXPECT(!out[1]);
      +	free_names(out);
      +}
      +
     @@ reftable/publicbasics.c (new)
      +{
      +	switch (id) {
      +	case 0:
     -+	case SHA1_ID:
     -+		return SHA1_SIZE;
     -+	case SHA256_ID:
     -+		return SHA256_SIZE;
     ++	case GIT_SHA1_HASH_ID:
     ++		return GIT_SHA1_RAWSZ;
     ++	case GIT_SHA256_HASH_ID:
     ++		return GIT_SHA256_RAWSZ;
      +	}
      +	abort();
      +}
     @@ reftable/system.h (new)
      +#ifndef SYSTEM_H
      +#define SYSTEM_H
      +
     ++// This header glues the reftable library to the rest of Git
     ++
      +#include "git-compat-util.h"
      +#include "strbuf.h"
     ++#include "hash.h" /* hash ID, sizes.*/
     ++#include "dir.h" /* remove_dir_recursively, for tests.*/
      +
      +#include <zlib.h>
      +
      +struct strbuf;
     -+/* In git, this is declared in dir.h */
     -+int remove_dir_recursively(struct strbuf *path, int flags);
     -+
     -+#define SHA1_ID 0x73686131
     -+#define SHA256_ID 0x73323536
     -+#define SHA1_SIZE 20
     -+#define SHA256_SIZE 32
     -+
     -+/* This is uncompress2, which is only available in zlib as of 2017.
     -+ */
     -+int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
     -+			       const Bytef *source, uLong *sourceLen);
      +int hash_size(uint32_t id);
      +
      +#endif
     @@ reftable/test_framework.c (new)
      +
      +void set_test_hash(uint8_t *p, int i)
      +{
     -+	memset(p, (uint8_t)i, hash_size(SHA1_ID));
     ++	memset(p, (uint8_t)i, hash_size(GIT_SHA1_HASH_ID));
      +}
      +
     -+int strbuf_add_void(void *b, const void *data, size_t sz)
     ++ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
      +{
     -+	strbuf_add((struct strbuf *)b, data, sz);
     ++	strbuf_add(b, data, sz);
      +	return sz;
      +}
      
     @@ reftable/test_framework.h (new)
      +
      +/* Like strbuf_add, but suitable for passing to reftable_new_writer
      + */
     -+int strbuf_add_void(void *b, const void *data, size_t sz);
     ++ssize_t strbuf_add_void(void *b, const void *data, size_t sz);
      +
      +#endif
      
  5:  6807af53e9a0 !  9:  5d54e6fac99b reftable: add blocksource, an abstraction for random access reads
     @@ reftable/blocksource.c (new)
      +static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
      +			     uint32_t size)
      +{
     -+	struct strbuf *b = (struct strbuf *)v;
     ++	struct strbuf *b = v;
      +	assert(off + size <= b->len);
      +	dest->data = reftable_calloc(size);
      +	memcpy(dest->data, b->buf + off, size);
     @@ reftable/blocksource.c (new)
      +void block_source_from_strbuf(struct reftable_block_source *bs,
      +			      struct strbuf *buf)
      +{
     -+	assert(bs->ops == NULL);
     ++	assert(!bs->ops);
      +	bs->ops = &strbuf_vtable;
      +	bs->arg = buf;
      +}
     @@ reftable/blocksource.c (new)
      +static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
      +			   uint32_t size)
      +{
     -+	struct file_block_source *b = (struct file_block_source *)v;
     ++	struct file_block_source *b = v;
      +	assert(off + size <= b->size);
      +	dest->data = reftable_malloc(size);
      +	if (pread(b->fd, dest->data, size, off) != size)
     @@ reftable/blocksource.c (new)
      +	p->size = st.st_size;
      +	p->fd = fd;
      +
     -+	assert(bs->ops == NULL);
     ++	assert(!bs->ops);
      +	bs->ops = &file_vtable;
      +	bs->arg = p;
      +	return 0;
  6:  78a352c96f82 ! 10:  028dd13e701b reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record.c (new)
      +static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
      +					  int hash_size)
      +{
     -+	struct reftable_ref_record *ref = (struct reftable_ref_record *)rec;
     -+	struct reftable_ref_record *src = (struct reftable_ref_record *)src_rec;
     ++	struct reftable_ref_record *ref = rec;
     ++	const struct reftable_ref_record *src = src_rec;
      +	assert(hash_size > 0);
      +
      +	/* This is simple and correct, but we could probably reuse the hash
      +	 * fields. */
      +	reftable_ref_record_release(ref);
     -+	if (src->refname != NULL) {
     ++	if (src->refname) {
      +		ref->refname = xstrdup(src->refname);
      +	}
      +	ref->update_index = src->update_index;
     @@ reftable/record.c (new)
      +static void hex_format(char *dest, uint8_t *src, int hash_size)
      +{
      +	assert(hash_size > 0);
     -+	if (src != NULL) {
     ++	if (src) {
      +		int i = 0;
      +		for (i = 0; i < hash_size; i++) {
      +			dest[2 * i] = hexdigit(src[i] >> 4);
     @@ reftable/record.c (new)
      +void reftable_ref_record_print(struct reftable_ref_record *ref,
      +			       uint32_t hash_id)
      +{
     -+	char hex[2 * SHA256_SIZE + 1] = { 0 }; /* BUG */
     ++	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
      +	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
      +	switch (ref->value_type) {
      +	case REFTABLE_REF_SYMREF:
     @@ reftable/record.c (new)
      +
      +static void reftable_ref_record_release_void(void *rec)
      +{
     -+	reftable_ref_record_release((struct reftable_ref_record *)rec);
     ++	reftable_ref_record_release(rec);
      +}
      +
      +void reftable_ref_record_release(struct reftable_ref_record *ref)
     @@ reftable/record.c (new)
      +				      uint8_t val_type, struct string_view in,
      +				      int hash_size)
      +{
     -+	struct reftable_ref_record *r = (struct reftable_ref_record *)rec;
     ++	struct reftable_ref_record *r = rec;
      +	struct string_view start = in;
      +	uint64_t update_index = 0;
      +	int n = get_var_int(&update_index, &in);
     @@ reftable/record.c (new)
      +
      +static void reftable_obj_record_release(void *rec)
      +{
     -+	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
     ++	struct reftable_obj_record *obj = rec;
      +	FREE_AND_NULL(obj->hash_prefix);
      +	FREE_AND_NULL(obj->offsets);
      +	memset(obj, 0, sizeof(struct reftable_obj_record));
     @@ reftable/record.c (new)
      +static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
      +					  int hash_size)
      +{
     -+	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
     ++	struct reftable_obj_record *obj = rec;
      +	const struct reftable_obj_record *src =
      +		(const struct reftable_obj_record *)src_rec;
      +	int olen;
     @@ reftable/record.c (new)
      +
      +static uint8_t reftable_obj_record_val_type(const void *rec)
      +{
     -+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
     ++	const struct reftable_obj_record *r = rec;
      +	if (r->offset_len > 0 && r->offset_len < 8)
      +		return r->offset_len;
      +	return 0;
     @@ reftable/record.c (new)
      +static int reftable_obj_record_encode(const void *rec, struct string_view s,
      +				      int hash_size)
      +{
     -+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
     ++	const struct reftable_obj_record *r = rec;
      +	struct string_view start = s;
      +	int i = 0;
      +	int n = 0;
     @@ reftable/record.c (new)
      +				      int hash_size)
      +{
      +	struct string_view start = in;
     -+	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
     ++	struct reftable_obj_record *r = rec;
      +	uint64_t count = val_type;
      +	int n = 0;
      +	uint64_t last;
     @@ reftable/record.c (new)
      +void reftable_log_record_print(struct reftable_log_record *log,
      +			       uint32_t hash_id)
      +{
     -+	char hex[SHA256_SIZE + 1] = { 0 };
     ++	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
      +
      +	switch (log->value_type) {
      +	case REFTABLE_LOG_DELETION:
     @@ reftable/record.c (new)
      +static void reftable_log_record_copy_from(void *rec, const void *src_rec,
      +					  int hash_size)
      +{
     -+	struct reftable_log_record *dst = (struct reftable_log_record *)rec;
     ++	struct reftable_log_record *dst = rec;
      +	const struct reftable_log_record *src =
      +		(const struct reftable_log_record *)src_rec;
      +
      +	reftable_log_record_release(dst);
      +	*dst = *src;
     -+	if (dst->refname != NULL) {
     ++	if (dst->refname) {
      +		dst->refname = xstrdup(dst->refname);
      +	}
      +	switch (dst->value_type) {
      +	case REFTABLE_LOG_DELETION:
      +		break;
      +	case REFTABLE_LOG_UPDATE:
     -+		if (dst->update.email != NULL) {
     ++		if (dst->update.email) {
      +			dst->update.email = xstrdup(dst->update.email);
      +		}
     -+		if (dst->update.name != NULL) {
     ++		if (dst->update.name) {
      +			dst->update.name = xstrdup(dst->update.name);
      +		}
     -+		if (dst->update.message != NULL) {
     ++		if (dst->update.message) {
      +			dst->update.message = xstrdup(dst->update.message);
      +		}
      +
     -+		if (dst->update.new_hash != NULL) {
     ++		if (dst->update.new_hash) {
      +			dst->update.new_hash = reftable_malloc(hash_size);
      +			memcpy(dst->update.new_hash, src->update.new_hash,
      +			       hash_size);
      +		}
     -+		if (dst->update.old_hash != NULL) {
     ++		if (dst->update.old_hash) {
      +			dst->update.old_hash = reftable_malloc(hash_size);
      +			memcpy(dst->update.old_hash, src->update.old_hash,
      +			       hash_size);
     @@ reftable/record.c (new)
      +
      +static void reftable_log_record_release_void(void *rec)
      +{
     -+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     ++	struct reftable_log_record *r = rec;
      +	reftable_log_record_release(r);
      +}
      +
     @@ reftable/record.c (new)
      +	return reftable_log_record_is_deletion(log) ? 0 : 1;
      +}
      +
     -+static uint8_t zero[SHA256_SIZE] = { 0 };
     ++static uint8_t zero[GIT_SHA256_RAWSZ] = { 0 };
      +
      +static int reftable_log_record_encode(const void *rec, struct string_view s,
      +				      int hash_size)
      +{
     -+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     ++	const struct reftable_log_record *r = rec;
      +	struct string_view start = s;
      +	int n = 0;
      +	uint8_t *oldh = NULL;
     @@ reftable/record.c (new)
      +
      +	oldh = r->update.old_hash;
      +	newh = r->update.new_hash;
     -+	if (oldh == NULL) {
     ++	if (!oldh) {
      +		oldh = zero;
      +	}
     -+	if (newh == NULL) {
     ++	if (!newh) {
      +		newh = zero;
      +	}
      +
     @@ reftable/record.c (new)
      +				      int hash_size)
      +{
      +	struct string_view start = in;
     -+	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     ++	struct reftable_log_record *r = rec;
      +	uint64_t max = 0;
      +	uint64_t ts = 0;
      +	struct strbuf dest = STRBUF_INIT;
     @@ reftable/record.c (new)
      +static int null_streq(char *a, char *b)
      +{
      +	char *empty = "";
     -+	if (a == NULL)
     ++	if (!a)
      +		a = empty;
      +
     -+	if (b == NULL)
     ++	if (!b)
      +		b = empty;
      +
      +	return 0 == strcmp(a, b);
     @@ reftable/record.c (new)
      +
      +static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
      +{
     -+	if (a == NULL)
     ++	if (!a)
      +		a = zero;
      +
     -+	if (b == NULL)
     ++	if (!b)
      +		b = zero;
      +
      +	return !memcmp(a, b, sz);
     @@ reftable/record.c (new)
      +
      +static void reftable_index_record_key(const void *r, struct strbuf *dest)
      +{
     -+	struct reftable_index_record *rec = (struct reftable_index_record *)r;
     ++	const struct reftable_index_record *rec = r;
      +	strbuf_reset(dest);
      +	strbuf_addbuf(dest, &rec->last_key);
      +}
     @@ reftable/record.c (new)
      +static void reftable_index_record_copy_from(void *rec, const void *src_rec,
      +					    int hash_size)
      +{
     -+	struct reftable_index_record *dst = (struct reftable_index_record *)rec;
     -+	struct reftable_index_record *src =
     -+		(struct reftable_index_record *)src_rec;
     ++	struct reftable_index_record *dst = rec;
     ++	const struct reftable_index_record *src = src_rec;
      +
      +	strbuf_reset(&dst->last_key);
      +	strbuf_addbuf(&dst->last_key, &src->last_key);
     @@ reftable/record.c (new)
      +
      +static void reftable_index_record_release(void *rec)
      +{
     -+	struct reftable_index_record *idx = (struct reftable_index_record *)rec;
     ++	struct reftable_index_record *idx = rec;
      +	strbuf_release(&idx->last_key);
      +}
      +
     @@ reftable/record.c (new)
      +					int hash_size)
      +{
      +	struct string_view start = in;
     -+	struct reftable_index_record *r = (struct reftable_index_record *)rec;
     ++	struct reftable_index_record *r = rec;
      +	int n = 0;
      +
      +	strbuf_reset(&r->last_key);
     @@ reftable/record.c (new)
      +void reftable_record_from_ref(struct reftable_record *rec,
      +			      struct reftable_ref_record *ref_rec)
      +{
     -+	assert(rec->ops == NULL);
     ++	assert(!rec->ops);
      +	rec->data = ref_rec;
      +	rec->ops = &reftable_ref_record_vtable;
      +}
     @@ reftable/record.c (new)
      +void reftable_record_from_obj(struct reftable_record *rec,
      +			      struct reftable_obj_record *obj_rec)
      +{
     -+	assert(rec->ops == NULL);
     ++	assert(!rec->ops);
      +	rec->data = obj_rec;
      +	rec->ops = &reftable_obj_record_vtable;
      +}
     @@ reftable/record.c (new)
      +void reftable_record_from_index(struct reftable_record *rec,
      +				struct reftable_index_record *index_rec)
      +{
     -+	assert(rec->ops == NULL);
     ++	assert(!rec->ops);
      +	rec->data = index_rec;
      +	rec->ops = &reftable_index_record_vtable;
      +}
     @@ reftable/record.c (new)
      +void reftable_record_from_log(struct reftable_record *rec,
      +			      struct reftable_log_record *log_rec)
      +{
     -+	assert(rec->ops == NULL);
     ++	assert(!rec->ops);
      +	rec->data = log_rec;
      +	rec->ops = &reftable_log_record_vtable;
      +}
     @@ reftable/record.c (new)
      +struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *rec)
      +{
      +	assert(reftable_record_type(rec) == BLOCK_TYPE_REF);
     -+	return (struct reftable_ref_record *)rec->data;
     ++	return rec->data;
      +}
      +
      +struct reftable_log_record *reftable_record_as_log(struct reftable_record *rec)
      +{
      +	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
     -+	return (struct reftable_log_record *)rec->data;
     ++	return rec->data;
      +}
      +
      +static int hash_equal(uint8_t *a, uint8_t *b, int hash_size)
      +{
     -+	if (a != NULL && b != NULL)
     ++	if (a && b)
      +		return !memcmp(a, b, hash_size);
      +
      +	return a == b;
     @@ reftable/record.c (new)
      +
      +int reftable_log_record_compare_key(const void *a, const void *b)
      +{
     -+	struct reftable_log_record *la = (struct reftable_log_record *)a;
     -+	struct reftable_log_record *lb = (struct reftable_log_record *)b;
     ++	const struct reftable_log_record *la = a;
     ++	const struct reftable_log_record *lb = b;
      +
      +	int cmp = strcmp(la->refname, lb->refname);
      +	if (cmp)
     @@ reftable/record_test.c (new)
      +{
      +	struct reftable_record copy =
      +		reftable_new_record(reftable_record_type(rec));
     -+	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
     ++	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
      +	/* do it twice to catch memory leaks */
     -+	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
     ++	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
      +	switch (reftable_record_type(&copy)) {
      +	case BLOCK_TYPE_REF:
      +		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
      +						 reftable_record_as_ref(rec),
     -+						 SHA1_SIZE));
     ++						 GIT_SHA1_RAWSZ));
      +		break;
      +	case BLOCK_TYPE_LOG:
      +		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
      +						 reftable_record_as_log(rec),
     -+						 SHA1_SIZE));
     ++						 GIT_SHA1_RAWSZ));
      +		break;
      +	}
      +	reftable_record_destroy(&copy);
     @@ reftable/record_test.c (new)
      +static void set_hash(uint8_t *h, int j)
      +{
      +	int i = 0;
     -+	for (i = 0; i < hash_size(SHA1_ID); i++) {
     ++	for (i = 0; i < hash_size(GIT_SHA1_HASH_ID); i++) {
      +		h[i] = (j >> i) & 0xff;
      +	}
      +}
     @@ reftable/record_test.c (new)
      +		case REFTABLE_REF_DELETION:
      +			break;
      +		case REFTABLE_REF_VAL1:
     -+			in.value.val1 = reftable_malloc(SHA1_SIZE);
     ++			in.value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_hash(in.value.val1, 1);
      +			break;
      +		case REFTABLE_REF_VAL2:
     -+			in.value.val2.value = reftable_malloc(SHA1_SIZE);
     ++			in.value.val2.value = reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_hash(in.value.val2.value, 1);
     -+			in.value.val2.target_value = reftable_malloc(SHA1_SIZE);
     ++			in.value.val2.target_value =
     ++				reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_hash(in.value.val2.target_value, 2);
      +			break;
      +		case REFTABLE_REF_SYMREF:
     @@ reftable/record_test.c (new)
      +		EXPECT(reftable_record_val_type(&rec) == i);
      +
      +		reftable_record_key(&rec, &key);
     -+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
      +		EXPECT(n > 0);
      +
      +		/* decode into a non-zero reftable_record to test for leaks. */
      +
      +		reftable_record_from_ref(&rec_out, &out);
     -+		m = reftable_record_decode(&rec_out, key, i, dest, SHA1_SIZE);
     ++		m = reftable_record_decode(&rec_out, key, i, dest,
     ++					   GIT_SHA1_RAWSZ);
      +		EXPECT(n == m);
      +
     -+		EXPECT(reftable_ref_record_equal(&in, &out, SHA1_SIZE));
     ++		EXPECT(reftable_ref_record_equal(&in, &out, GIT_SHA1_RAWSZ));
      +		reftable_record_release(&rec_out);
      +
      +		strbuf_release(&key);
     @@ reftable/record_test.c (new)
      +		}
      +	};
      +
     -+	EXPECT(!reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	EXPECT(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
      +	in[1].update_index = in[0].update_index;
     -+	EXPECT(reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	EXPECT(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
      +	reftable_log_record_release(&in[0]);
      +	reftable_log_record_release(&in[1]);
      +}
     @@ reftable/record_test.c (new)
      +			.update_index = 42,
      +			.value_type = REFTABLE_LOG_UPDATE,
      +			.update = {
     -+				.old_hash = reftable_malloc(SHA1_SIZE),
     -+				.new_hash = reftable_malloc(SHA1_SIZE),
     ++				.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     ++				.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
      +				.name = xstrdup("han-wen"),
      +				.email = xstrdup("hanwen@google.com"),
      +				.message = xstrdup("test"),
     @@ reftable/record_test.c (new)
      +			.refname = xstrdup("old name"),
      +			.value_type = REFTABLE_LOG_UPDATE,
      +			.update = {
     -+				.new_hash = reftable_calloc(SHA1_SIZE),
     -+				.old_hash = reftable_calloc(SHA1_SIZE),
     ++				.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     ++				.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
      +				.name = xstrdup("old name"),
      +				.email = xstrdup("old@email"),
      +				.message = xstrdup("old message"),
     @@ reftable/record_test.c (new)
      +
      +		reftable_record_key(&rec, &key);
      +
     -+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
      +		EXPECT(n >= 0);
      +		reftable_record_from_log(&rec_out, &out);
      +		valtype = reftable_record_val_type(&rec);
      +		m = reftable_record_decode(&rec_out, key, valtype, dest,
     -+					   SHA1_SIZE);
     ++					   GIT_SHA1_RAWSZ);
      +		EXPECT(n == m);
      +
     -+		EXPECT(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
     ++		EXPECT(reftable_log_record_equal(&in[i], &out, GIT_SHA1_RAWSZ));
      +		reftable_log_record_release(&in[i]);
      +		strbuf_release(&key);
      +		reftable_record_release(&rec_out);
     @@ reftable/record_test.c (new)
      +
      +static void test_reftable_obj_record_roundtrip(void)
      +{
     -+	uint8_t testHash1[SHA1_SIZE] = { 1, 2, 3, 4, 0 };
     ++	uint8_t testHash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 4, 0 };
      +	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
      +	struct reftable_obj_record recs[3] = { {
      +						       .hash_prefix = testHash1,
     @@ reftable/record_test.c (new)
      +		reftable_record_from_obj(&rec, &in);
      +		test_copy(&rec);
      +		reftable_record_key(&rec, &key);
     -+		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
      +		EXPECT(n > 0);
      +		extra = reftable_record_val_type(&rec);
      +		reftable_record_from_obj(&rec_out, &out);
      +		m = reftable_record_decode(&rec_out, key, extra, dest,
     -+					   SHA1_SIZE);
     ++					   GIT_SHA1_RAWSZ);
      +		EXPECT(n == m);
      +
      +		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
     @@ reftable/record_test.c (new)
      +	test_copy(&rec);
      +
      +	EXPECT(0 == strbuf_cmp(&key, &in.last_key));
     -+	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++	n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
      +	EXPECT(n > 0);
      +
      +	extra = reftable_record_val_type(&rec);
      +	reftable_record_from_index(&out_rec, &out);
     -+	m = reftable_record_decode(&out_rec, key, extra, dest, SHA1_SIZE);
     ++	m = reftable_record_decode(&out_rec, key, extra, dest, GIT_SHA1_RAWSZ);
      +	EXPECT(m == n);
      +
      +	EXPECT(in.offset == out.offset);
  -:  ------------ > 11:  0c2604d7e7d4 Provide zlib's uncompress2 from compat/zlib-compat.c
  7:  9297b9c363f6 ! 12:  425cd0185aab reftable: reading/writing blocks
     @@ Commit message
      
          This commit provides the logic to read and write these blocks.
      
     -    Includes a code snippet copied from zlib
     -
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     @@ Makefile: xdiff-objs: $(XDIFF_OBJS)
       REFTABLE_OBJS += reftable/blocksource.o
       REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/record.o
     -+REFTABLE_OBJS += reftable/zlib-compat.o
       
      +REFTABLE_TEST_OBJS += reftable/block_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
       REFTABLE_TEST_OBJS += reftable/basics_test.o
      
     - ## reftable/.gitattributes (new) ##
     -@@
     -+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
     -
       ## reftable/block.c (new) ##
      @@
      +/*
     @@ reftable/block.c (new)
      +#include "record.h"
      +#include "reftable-error.h"
      +#include "system.h"
     -+#include "zlib.h"
     ++#include <zlib.h>
     ++
     ++#ifdef NO_UNCOMPRESS2
     ++/* This is uncompress2, which is only available in zlib as of 2017.
     ++ */
     ++int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
     ++		uLong *sourceLen);
     ++#endif
      +
      +int header_size(int version)
      +{
     @@ reftable/block.c (new)
      +		memcpy(uncompressed, block->data, block_header_skip);
      +
      +		/* Uncompress */
     -+		if (Z_OK != uncompress_return_consumed(
     -+				    uncompressed + block_header_skip, &dst_len,
     -+				    block->data + block_header_skip,
     -+				    &src_len)) {
     ++		if (Z_OK !=
     ++		    uncompress2(uncompressed + block_header_skip, &dst_len,
     ++				block->data + block_header_skip, &src_len)) {
      +			reftable_free(uncompressed);
      +			return REFTABLE_ZLIB_ERROR;
      +		}
     @@ reftable/block.c (new)
      +
      +static int restart_key_less(size_t idx, void *args)
      +{
     -+	struct restart_find_args *a = (struct restart_find_args *)args;
     ++	struct restart_find_args *a = args;
      +	uint32_t off = block_reader_restart_offset(a->r, idx);
      +	struct string_view in = {
      +		.buf = a->r->block.data + off,
     @@ reftable/block.c (new)
      +void reftable_block_done(struct reftable_block *blockp)
      +{
      +	struct reftable_block_source source = blockp->source;
     -+	if (blockp != NULL && source.ops != NULL)
     ++	if (blockp && source.ops)
      +		source.ops->return_block(source.arg, blockp);
      +	blockp->data = NULL;
      +	blockp->len = 0;
     @@ reftable/block_test.c (new)
      +	block.len = block_size;
      +	block.source = malloc_block_source();
      +	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
     -+			  header_off, hash_size(SHA1_ID));
     ++			  header_off, hash_size(GIT_SHA1_HASH_ID));
      +	reftable_record_from_ref(&rec, &ref);
      +
      +	for (i = 0; i < N; i++) {
      +		char name[100];
     -+		uint8_t hash[SHA1_SIZE];
     ++		uint8_t hash[GIT_SHA1_RAWSZ];
      +		snprintf(name, sizeof(name), "branch%02d", i);
      +		memset(hash, i, sizeof(hash));
      +
     @@ reftable/block_test.c (new)
      +
      +	block_writer_release(&bw);
      +
     -+	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
     ++	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
      +
      +	block_reader_start(&br, &it);
      +
     @@ reftable/block_test.c (new)
      +{
      +	RUN_TEST(test_block_read_write);
      +	return 0;
     -+}
     -
     - ## reftable/zlib-compat.c (new) ##
     -@@
     -+/* taken from zlib's uncompr.c
     -+
     -+   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
     -+   Author: Mark Adler <madler@alumni.caltech.edu>
     -+   Date:   Sun Jan 15 09:18:46 2017 -0800
     -+
     -+       zlib 1.2.11
     -+
     -+*/
     -+
     -+/*
     -+ * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
     -+ * For conditions of distribution and use, see copyright notice in zlib.h
     -+ */
     -+
     -+#include "system.h"
     -+
     -+/* clang-format off */
     -+
     -+/* ===========================================================================
     -+     Decompresses the source buffer into the destination buffer.  *sourceLen is
     -+   the byte length of the source buffer. Upon entry, *destLen is the total size
     -+   of the destination buffer, which must be large enough to hold the entire
     -+   uncompressed data. (The size of the uncompressed data must have been saved
     -+   previously by the compressor and transmitted to the decompressor by some
     -+   mechanism outside the scope of this compression library.) Upon exit,
     -+   *destLen is the size of the decompressed data and *sourceLen is the number
     -+   of source bytes consumed. Upon return, source + *sourceLen points to the
     -+   first unused input byte.
     -+
     -+     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
     -+   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
     -+   Z_DATA_ERROR if the input data was corrupted, including if the input data is
     -+   an incomplete zlib stream.
     -+*/
     -+int ZEXPORT uncompress_return_consumed (
     -+    Bytef *dest,
     -+    uLongf *destLen,
     -+    const Bytef *source,
     -+    uLong *sourceLen) {
     -+    z_stream stream;
     -+    int err;
     -+    const uInt max = (uInt)-1;
     -+    uLong len, left;
     -+    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
     -+
     -+    len = *sourceLen;
     -+    if (*destLen) {
     -+        left = *destLen;
     -+        *destLen = 0;
     -+    }
     -+    else {
     -+        left = 1;
     -+        dest = buf;
     -+    }
     -+
     -+    stream.next_in = (z_const Bytef *)source;
     -+    stream.avail_in = 0;
     -+    stream.zalloc = (alloc_func)0;
     -+    stream.zfree = (free_func)0;
     -+    stream.opaque = (voidpf)0;
     -+
     -+    err = inflateInit(&stream);
     -+    if (err != Z_OK) return err;
     -+
     -+    stream.next_out = dest;
     -+    stream.avail_out = 0;
     -+
     -+    do {
     -+        if (stream.avail_out == 0) {
     -+            stream.avail_out = left > (uLong)max ? max : (uInt)left;
     -+            left -= stream.avail_out;
     -+        }
     -+        if (stream.avail_in == 0) {
     -+            stream.avail_in = len > (uLong)max ? max : (uInt)len;
     -+            len -= stream.avail_in;
     -+        }
     -+        err = inflate(&stream, Z_NO_FLUSH);
     -+    } while (err == Z_OK);
     -+
     -+    *sourceLen -= len + stream.avail_in;
     -+    if (dest != buf)
     -+        *destLen = stream.total_out;
     -+    else if (stream.total_out && err == Z_BUF_ERROR)
     -+        left = 1;
     -+
     -+    inflateEnd(&stream);
     -+    return err == Z_STREAM_END ? Z_OK :
     -+           err == Z_NEED_DICT ? Z_DATA_ERROR  :
     -+           err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
     -+           err;
      +}
      
       ## t/helper/test-reftable.c ##
  8:  ceddefadd48c ! 13:  c03957db45c0 reftable: a generic binary tree implementation
     @@ Makefile: REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/record.o
      +REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
       
      +REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
     @@ reftable/tree.c (new)
      +void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
      +		void *arg)
      +{
     -+	if (t->left != NULL) {
     ++	if (t->left) {
      +		infix_walk(t->left, action, arg);
      +	}
      +	action(arg, t->key);
     -+	if (t->right != NULL) {
     ++	if (t->right) {
      +		infix_walk(t->right, action, arg);
      +	}
      +}
     @@ reftable/tree.c (new)
      +	if (t == NULL) {
      +		return;
      +	}
     -+	if (t->left != NULL) {
     ++	if (t->left) {
      +		tree_free(t->left);
      +	}
     -+	if (t->right != NULL) {
     ++	if (t->right) {
      +		tree_free(t->right);
      +	}
      +	reftable_free(t);
     @@ reftable/tree_test.c (new)
      +
      +static void check_increasing(void *arg, void *key)
      +{
     -+	struct curry *c = (struct curry *)arg;
     -+	if (c->last != NULL) {
     ++	struct curry *c = arg;
     ++	if (c->last) {
      +		assert(test_compare(c->last, key) < 0);
      +	}
      +	c->last = key;
  9:  1f635e6c86c5 ! 14:  922deb272fff reftable: write reftable files
     @@ Makefile: REFTABLE_OBJS += reftable/blocksource.o
       REFTABLE_OBJS += reftable/record.o
       REFTABLE_OBJS += reftable/tree.o
      +REFTABLE_OBJS += reftable/writer.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
       
       REFTABLE_TEST_OBJS += reftable/basics_test.o
     + REFTABLE_TEST_OBJS += reftable/block_test.o
      
       ## reftable/reftable-writer.h (new) ##
      @@
     @@ reftable/reftable-writer.h (new)
      +
      +/* reftable_new_writer creates a new writer */
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
     ++reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts);
      +
      +/* Set the range of update indices for the records we will add. When writing a
     @@ reftable/writer.c (new)
      +	}
      +
      +	if (opts->hash_id == 0) {
     -+		opts->hash_id = SHA1_ID;
     ++		opts->hash_id = GIT_SHA1_HASH_ID;
      +	}
      +	if (opts->block_size == 0) {
      +		opts->block_size = DEFAULT_BLOCK_SIZE;
     @@ reftable/writer.c (new)
      +
      +static int writer_version(struct reftable_writer *w)
      +{
     -+	return (w->opts.hash_id == 0 || w->opts.hash_id == SHA1_ID) ? 1 : 2;
     ++	return (w->opts.hash_id == 0 || w->opts.hash_id == GIT_SHA1_HASH_ID) ?
     ++			     1 :
     ++			     2;
      +}
      +
      +static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
     @@ reftable/writer.c (new)
      +static struct strbuf reftable_empty_strbuf = STRBUF_INIT;
      +
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
     ++reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts)
      +{
      +	struct reftable_writer *wp =
     @@ reftable/writer.c (new)
      +static int writer_add_record(struct reftable_writer *w,
      +			     struct reftable_record *rec)
      +{
     -+	int result = -1;
      +	struct strbuf key = STRBUF_INIT;
     -+	int err = 0;
     ++	int err = -1;
      +	reftable_record_key(rec, &key);
     -+	if (strbuf_cmp(&w->last_key, &key) >= 0)
     ++	if (strbuf_cmp(&w->last_key, &key) >= 0) {
     ++		err = REFTABLE_API_ERROR;
      +		goto done;
     ++	}
      +
      +	strbuf_reset(&w->last_key);
      +	strbuf_addbuf(&w->last_key, &key);
     @@ reftable/writer.c (new)
      +	assert(block_writer_type(w->block_writer) == reftable_record_type(rec));
      +
      +	if (block_writer_add(w->block_writer, rec) == 0) {
     -+		result = 0;
     ++		err = 0;
      +		goto done;
      +	}
      +
      +	err = writer_flush_block(w);
      +	if (err < 0) {
     -+		result = err;
      +		goto done;
      +	}
      +
      +	writer_reinit_block_writer(w, reftable_record_type(rec));
      +	err = block_writer_add(w->block_writer, rec);
      +	if (err < 0) {
     -+		result = err;
      +		goto done;
      +	}
      +
     -+	result = 0;
     ++	err = 0;
      +done:
      +	strbuf_release(&key);
     -+	return result;
     ++	return err;
      +}
      +
      +int reftable_writer_add_ref(struct reftable_writer *w,
     @@ reftable/writer.c (new)
      +	if (err < 0)
      +		return err;
      +
     -+	if (!w->opts.skip_index_objects &&
     -+	    reftable_ref_record_val1(ref) != NULL) {
     ++	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
      +		struct strbuf h = STRBUF_INIT;
      +		strbuf_add(&h, (char *)reftable_ref_record_val1(ref),
      +			   hash_size(w->opts.hash_id));
     @@ reftable/writer.c (new)
      +		strbuf_release(&h);
      +	}
      +
     -+	if (!w->opts.skip_index_objects &&
     -+	    reftable_ref_record_val2(ref) != NULL) {
     ++	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
      +		struct strbuf h = STRBUF_INIT;
      +		strbuf_add(&h, reftable_ref_record_val2(ref),
      +			   hash_size(w->opts.hash_id));
     @@ reftable/writer.c (new)
      +					    struct reftable_log_record *log)
      +{
      +	struct reftable_record rec = { NULL };
     -+	if (w->block_writer != NULL &&
     ++	if (w->block_writer &&
      +	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
      +		int err = writer_finish_public_section(w);
      +		if (err < 0)
     @@ reftable/writer.c (new)
      +		return REFTABLE_API_ERROR;
      +
      +	input_log_message = log->update.message;
     -+	if (!w->opts.exact_log_message && log->update.message != NULL) {
     ++	if (!w->opts.exact_log_message && log->update.message) {
      +		strbuf_addstr(&cleaned_message, log->update.message);
      +		while (cleaned_message.len &&
      +		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
     @@ reftable/writer.c (new)
      +
      +static void update_common(void *void_arg, void *key)
      +{
     -+	struct common_prefix_arg *arg = (struct common_prefix_arg *)void_arg;
     -+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
     -+	if (arg->last != NULL) {
     ++	struct common_prefix_arg *arg = void_arg;
     ++	struct obj_index_tree_node *entry = key;
     ++	if (arg->last) {
      +		int n = common_prefix_size(&entry->hash, arg->last);
      +		if (n > arg->max) {
      +			arg->max = n;
     @@ reftable/writer.c (new)
      +
      +static void write_object_record(void *void_arg, void *key)
      +{
     -+	struct write_record_arg *arg = (struct write_record_arg *)void_arg;
     -+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
     ++	struct write_record_arg *arg = void_arg;
     ++	struct obj_index_tree_node *entry = key;
      +	struct reftable_obj_record obj_rec = {
      +		.hash_prefix = (uint8_t *)entry->hash.buf,
      +		.hash_prefix_len = arg->w->stats.object_id_len,
     @@ reftable/writer.c (new)
      +
      +static void object_record_free(void *void_arg, void *key)
      +{
     -+	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
     ++	struct obj_index_tree_node *entry = key;
      +
      +	FREE_AND_NULL(entry->offsets);
      +	strbuf_release(&entry->hash);
     @@ reftable/writer.c (new)
      +{
      +	struct write_record_arg closure = { .w = w };
      +	struct common_prefix_arg common = { NULL };
     -+	if (w->obj_index_tree != NULL) {
     ++	if (w->obj_index_tree) {
      +		infix_walk(w->obj_index_tree, &update_common, &common);
      +	}
      +	w->stats.object_id_len = common.max + 1;
      +
      +	writer_reinit_block_writer(w, BLOCK_TYPE_OBJ);
      +
     -+	if (w->obj_index_tree != NULL) {
     ++	if (w->obj_index_tree) {
      +		infix_walk(w->obj_index_tree, &write_object_record, &closure);
      +	}
      +
     @@ reftable/writer.c (new)
      +			return err;
      +	}
      +
     -+	if (w->obj_index_tree != NULL) {
     ++	if (w->obj_index_tree) {
      +		infix_walk(w->obj_index_tree, &object_record_free, NULL);
      +		tree_free(w->obj_index_tree);
      +		w->obj_index_tree = NULL;
     @@ reftable/writer.h (new)
      +#include "reftable-writer.h"
      +
      +struct reftable_writer {
     -+	int (*write)(void *, const void *, size_t);
     ++	ssize_t (*write)(void *, const void *, size_t);
      +	void *write_arg;
      +	int pending_padding;
      +	struct strbuf last_key;
 10:  9c3fd77fbbac ! 15:  afca8f8f6a29 reftable: generic interface to tables
     @@ Makefile: REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/blocksource.o
       REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/record.o
     -+REFTABLE_OBJS += reftable/reftable.o
     ++REFTABLE_OBJS += reftable/refname.o
     ++REFTABLE_OBJS += reftable/generic.o
     ++REFTABLE_OBJS += reftable/stack.o
       REFTABLE_OBJS += reftable/tree.o
       REFTABLE_OBJS += reftable/writer.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
     + 
     +
     + ## reftable/generic.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "basics.h"
     ++#include "record.h"
     ++#include "generic.h"
     ++#include "reftable-iterator.h"
     ++#include "reftable-generic.h"
     ++
     ++int reftable_table_seek_ref(struct reftable_table *tab,
     ++			    struct reftable_iterator *it, const char *name)
     ++{
     ++	struct reftable_ref_record ref = {
     ++		.refname = (char *)name,
     ++	};
     ++	struct reftable_record rec = { NULL };
     ++	reftable_record_from_ref(&rec, &ref);
     ++	return tab->ops->seek_record(tab->table_arg, it, &rec);
     ++}
     ++
     ++int reftable_table_seek_log(struct reftable_table *tab,
     ++			    struct reftable_iterator *it, const char *name)
     ++{
     ++	struct reftable_log_record log = {
     ++		.refname = (char *)name,
     ++		.update_index = ~((uint64_t)0),
     ++	};
     ++	struct reftable_record rec = { NULL };
     ++	reftable_record_from_log(&rec, &log);
     ++	return tab->ops->seek_record(tab->table_arg, it, &rec);
     ++}
     ++
     ++int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     ++			    struct reftable_ref_record *ref)
     ++{
     ++	struct reftable_iterator it = { NULL };
     ++	int err = reftable_table_seek_ref(tab, &it, name);
     ++	if (err)
     ++		goto done;
     ++
     ++	err = reftable_iterator_next_ref(&it, ref);
     ++	if (err)
     ++		goto done;
     ++
     ++	if (strcmp(ref->refname, name) ||
     ++	    reftable_ref_record_is_deletion(ref)) {
     ++		reftable_ref_record_release(ref);
     ++		err = 1;
     ++		goto done;
     ++	}
     ++
     ++done:
     ++	reftable_iterator_destroy(&it);
     ++	return err;
     ++}
     ++
     ++int reftable_table_print(struct reftable_table *tab) {
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
     ++	uint32_t hash_id = reftable_table_hash_id(tab);
     ++	int err = reftable_table_seek_ref(tab, &it, "");
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
     ++	reftable_ref_record_release(&ref);
     ++
     ++	err = reftable_table_seek_log(tab, &it, "");
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
     ++	reftable_log_record_release(&log);
     ++	return 0;
     ++}
     ++
     ++uint64_t reftable_table_max_update_index(struct reftable_table *tab)
     ++{
     ++	return tab->ops->max_update_index(tab->table_arg);
     ++}
     ++
     ++uint64_t reftable_table_min_update_index(struct reftable_table *tab)
     ++{
     ++	return tab->ops->min_update_index(tab->table_arg);
     ++}
     ++
     ++uint32_t reftable_table_hash_id(struct reftable_table *tab)
     ++{
     ++	return tab->ops->hash_id(tab->table_arg);
     ++}
     ++
     ++void reftable_iterator_destroy(struct reftable_iterator *it)
     ++{
     ++	if (!it->ops) {
     ++		return;
     ++	}
     ++	it->ops->close(it->iter_arg);
     ++	it->ops = NULL;
     ++	FREE_AND_NULL(it->iter_arg);
     ++}
     ++
     ++int reftable_iterator_next_ref(struct reftable_iterator *it,
     ++			       struct reftable_ref_record *ref)
     ++{
     ++	struct reftable_record rec = { NULL };
     ++	reftable_record_from_ref(&rec, ref);
     ++	return iterator_next(it, &rec);
     ++}
     ++
     ++int reftable_iterator_next_log(struct reftable_iterator *it,
     ++			       struct reftable_log_record *log)
     ++{
     ++	struct reftable_record rec = { NULL };
     ++	reftable_record_from_log(&rec, log);
     ++	return iterator_next(it, &rec);
     ++}
     ++
     ++int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
     ++{
     ++	return it->ops->next(it->iter_arg, rec);
     ++}
     ++
     ++static int empty_iterator_next(void *arg, struct reftable_record *rec)
     ++{
     ++	return 1;
     ++}
     ++
     ++static void empty_iterator_close(void *arg)
     ++{
     ++}
     ++
     ++static struct reftable_iterator_vtable empty_vtable = {
     ++	.next = &empty_iterator_next,
     ++	.close = &empty_iterator_close,
     ++};
     ++
     ++void iterator_set_empty(struct reftable_iterator *it)
     ++{
     ++	assert(!it->ops);
     ++	it->iter_arg = NULL;
     ++	it->ops = &empty_vtable;
     ++}
      
       ## reftable/generic.h (new) ##
      @@
     @@ reftable/reftable-generic.h (new)
      +	void *table_arg;
      +};
      +
     ++int reftable_table_seek_log(struct reftable_table *tab,
     ++			    struct reftable_iterator *it, const char *name);
     ++
      +int reftable_table_seek_ref(struct reftable_table *tab,
      +			    struct reftable_iterator *it, const char *name);
      +
     @@ reftable/reftable-generic.h (new)
      +int reftable_table_read_ref(struct reftable_table *tab, const char *name,
      +			    struct reftable_ref_record *ref);
      +
     ++/* dump table contents onto stdout for debugging */
     ++int reftable_table_print(struct reftable_table *tab);
     ++
      +#endif
      
       ## reftable/reftable-iterator.h (new) ##
     @@ reftable/reftable.c (new)
      +
      +void reftable_iterator_destroy(struct reftable_iterator *it)
      +{
     -+	if (it->ops == NULL) {
     ++	if (!it->ops) {
      +		return;
      +	}
      +	it->ops->close(it->iter_arg);
     @@ reftable/reftable.c (new)
      +
      +void iterator_set_empty(struct reftable_iterator *it)
      +{
     -+	assert(it->ops == NULL);
     ++	assert(!it->ops);
      +	it->iter_arg = NULL;
      +	it->ops = &empty_vtable;
      +}
 11:  8ba486f44a72 ! 16:  501cf0677ce4 reftable: read reftable files
     @@ Makefile: REFTABLE_OBJS += reftable/basics.o
       REFTABLE_OBJS += reftable/publicbasics.o
      +REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/reftable.o
     - REFTABLE_OBJS += reftable/tree.o
     + REFTABLE_OBJS += reftable/refname.o
     + REFTABLE_OBJS += reftable/generic.o
      
       ## reftable/iter.c (new) ##
      @@
     @@ reftable/iter.c (new)
      +
      +int iterator_is_null(struct reftable_iterator *it)
      +{
     -+	return it->ops == NULL;
     ++	return !it->ops;
      +}
      +
      +static void filtering_ref_iterator_close(void *iter_arg)
      +{
     -+	struct filtering_ref_iterator *fri =
     -+		(struct filtering_ref_iterator *)iter_arg;
     ++	struct filtering_ref_iterator *fri = iter_arg;
      +	strbuf_release(&fri->oid);
      +	reftable_iterator_destroy(&fri->it);
      +}
     @@ reftable/iter.c (new)
      +static int filtering_ref_iterator_next(void *iter_arg,
      +				       struct reftable_record *rec)
      +{
     -+	struct filtering_ref_iterator *fri =
     -+		(struct filtering_ref_iterator *)iter_arg;
     -+	struct reftable_ref_record *ref =
     -+		(struct reftable_ref_record *)rec->data;
     ++	struct filtering_ref_iterator *fri = iter_arg;
     ++	struct reftable_ref_record *ref = rec->data;
      +	int err = 0;
      +	while (1) {
      +		err = reftable_iterator_next_ref(&fri->it, ref);
     @@ reftable/iter.c (new)
      +void iterator_from_filtering_ref_iterator(struct reftable_iterator *it,
      +					  struct filtering_ref_iterator *fri)
      +{
     -+	assert(it->ops == NULL);
     ++	assert(!it->ops);
      +	it->iter_arg = fri;
      +	it->ops = &filtering_ref_iterator_vtable;
      +}
      +
      +static void indexed_table_ref_iter_close(void *p)
      +{
     -+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
     ++	struct indexed_table_ref_iter *it = p;
      +	block_iter_close(&it->cur);
      +	reftable_block_done(&it->block_reader.block);
     ++	reftable_free(it->offsets);
      +	strbuf_release(&it->oid);
      +}
      +
     @@ reftable/iter.c (new)
      +
      +static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
      +{
     -+	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
     -+	struct reftable_ref_record *ref =
     -+		(struct reftable_ref_record *)rec->data;
     ++	struct indexed_table_ref_iter *it = p;
     ++	struct reftable_ref_record *ref = rec->data;
      +
      +	while (1) {
      +		int err = block_iter_next(&it->cur, rec);
     @@ reftable/iter.c (new)
      +void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr)
      +{
     -+	assert(it->ops == NULL);
     ++	assert(!it->ops);
      +	it->iter_arg = itr;
      +	it->ops = &indexed_table_ref_iter_vtable;
      +}
     @@ reftable/iter.h (new)
      +
      +void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr);
     ++
     ++/* Takes ownership of `offsets` */
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
      +			       struct reftable_reader *r, uint8_t *oid,
      +			       int oid_len, uint64_t *offsets, int offset_len);
     @@ reftable/reader.c (new)
      +
      +void block_source_close(struct reftable_block_source *source)
      +{
     -+	if (source->ops == NULL) {
     ++	if (!source->ops) {
      +		return;
      +	}
      +
     @@ reftable/reader.c (new)
      +	f += 8;
      +
      +	if (r->version == 1) {
     -+		r->hash_id = SHA1_ID;
     ++		r->hash_id = GIT_SHA1_HASH_ID;
      +	} else {
      +		r->hash_id = get_be32(f);
      +		switch (r->hash_id) {
     -+		case SHA1_ID:
     ++		case GIT_SHA1_HASH_ID:
      +			break;
     -+		case SHA256_ID:
     ++		case GIT_SHA256_HASH_ID:
      +			break;
      +		default:
      +			err = REFTABLE_FORMAT_ERROR;
     @@ reftable/reader.c (new)
      +
      +static void table_iter_block_done(struct table_iter *ti)
      +{
     -+	if (ti->bi.br == NULL) {
     ++	if (!ti->bi.br) {
      +		return;
      +	}
      +	reftable_block_done(&ti->bi.br->block);
     @@ reftable/reader.c (new)
      +
      +static int table_iter_next_void(void *ti, struct reftable_record *rec)
      +{
     -+	return table_iter_next((struct table_iter *)ti, rec);
     ++	return table_iter_next(ti, rec);
      +}
      +
      +static void table_iter_close(void *p)
      +{
     -+	struct table_iter *ti = (struct table_iter *)p;
     ++	struct table_iter *ti = p;
      +	table_iter_block_done(ti);
      +	block_iter_close(&ti->bi);
      +}
     @@ reftable/reader.c (new)
      +static void iterator_from_table_iter(struct reftable_iterator *it,
      +				     struct table_iter *ti)
      +{
     -+	assert(it->ops == NULL);
     ++	assert(!it->ops);
      +	it->iter_arg = ti;
      +	it->ops = &table_iter_vtable;
      +}
     @@ reftable/reader.c (new)
      +static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
      +				     struct reftable_record *rec)
      +{
     -+	return reader_seek((struct reftable_reader *)tab, it, rec);
     ++	return reader_seek(tab, it, rec);
      +}
      +
      +static uint32_t reftable_reader_hash_id_void(void *tab)
      +{
     -+	return reftable_reader_hash_id((struct reftable_reader *)tab);
     ++	return reftable_reader_hash_id(tab);
      +}
      +
      +static uint64_t reftable_reader_min_update_index_void(void *tab)
      +{
     -+	return reftable_reader_min_update_index((struct reftable_reader *)tab);
     ++	return reftable_reader_min_update_index(tab);
      +}
      +
      +static uint64_t reftable_reader_max_update_index_void(void *tab)
      +{
     -+	return reftable_reader_max_update_index((struct reftable_reader *)tab);
     ++	return reftable_reader_max_update_index(tab);
      +}
      +
      +static struct reftable_table_vtable reader_vtable = {
     @@ reftable/reader.c (new)
      +void reftable_table_from_reader(struct reftable_table *tab,
      +				struct reftable_reader *reader)
      +{
     -+	assert(tab->ops == NULL);
     ++	assert(!tab->ops);
      +	tab->ops = &reader_vtable;
      +	tab->table_arg = reader;
     ++}
     ++
     ++
     ++int reftable_reader_print_file(const char *tablename)
     ++{
     ++	struct reftable_block_source src = { NULL };
     ++	int err = reftable_block_source_from_file(&src, tablename);
     ++	struct reftable_reader *r = NULL;
     ++	struct reftable_table tab = { NULL };
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_new_reader(&r, &src, tablename);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	reftable_table_from_reader(&tab, r);
     ++	err = reftable_table_print(&tab);
     ++done:
     ++	reftable_reader_free(r);
     ++	return err;
      +}
      
       ## reftable/reader.h (new) ##
     @@ reftable/reftable-reader.h (new)
      +void reftable_table_from_reader(struct reftable_table *tab,
      +				struct reftable_reader *reader);
      +
     ++/* print table onto stdout for debugging. */
     ++int reftable_reader_print_file(const char *tablename);
     ++
      +#endif
 12:  9ade9303f08f ! 17:  dc04ec88cf53 reftable: reftable file level tests
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
       REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     -+REFTABLE_TEST_OBJS += reftable/reftable_test.o
     ++REFTABLE_TEST_OBJS += reftable/readwrite_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
       REFTABLE_TEST_OBJS += reftable/tree_test.o
       
      
     - ## reftable/reftable_test.c (new) ##
     + ## reftable/readwrite_test.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/reftable_test.c (new)
      +	*names = reftable_calloc(sizeof(char *) * (N + 1));
      +	reftable_writer_set_limits(w, update_index, update_index);
      +	for (i = 0; i < N; i++) {
     -+		uint8_t hash[SHA256_SIZE] = { 0 };
     ++		uint8_t hash[GIT_SHA256_RAWSZ] = { 0 };
      +		char name[100];
      +		int n;
      +
     @@ reftable/reftable_test.c (new)
      +	}
      +
      +	for (i = 0; i < N; i++) {
     -+		uint8_t hash[SHA256_SIZE] = { 0 };
     ++		uint8_t hash[GIT_SHA256_RAWSZ] = { 0 };
      +		char name[100];
      +		int n;
      +
     @@ reftable/reftable_test.c (new)
      +	for (i = 0; i < stats->ref_stats.blocks; i++) {
      +		int off = i * opts.block_size;
      +		if (off == 0) {
     -+			off = header_size((hash_id == SHA256_ID) ? 2 : 1);
     ++			off = header_size((hash_id == GIT_SHA256_HASH_ID) ? 2 :
     ++										  1);
      +		}
      +		EXPECT(buf->buf[off] == 'r');
      +	}
     @@ reftable/reftable_test.c (new)
      +	/* This tests buffer extension for log compression. Must use a random
      +	   hash, to ensure that the compressed part is larger than the original.
      +	*/
     -+	uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     -+	for (int i = 0; i < SHA1_SIZE; i++) {
     ++	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
     ++	for (int i = 0; i < GIT_SHA1_RAWSZ; i++) {
      +		hash1[i] = (uint8_t)(rand() % 256);
      +		hash2[i] = (uint8_t)(rand() % 256);
      +	}
     @@ reftable/reftable_test.c (new)
      +		EXPECT_ERR(err);
      +	}
      +	for (i = 0; i < N; i++) {
     -+		uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     ++		uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
      +		struct reftable_log_record log = { NULL };
      +		set_test_hash(hash1, i);
      +		set_test_hash(hash2, i + 1);
     @@ reftable/reftable_test.c (new)
      +	int err = 0;
      +	int j = 0;
      +
     -+	write_table(&names, &buf, N, 256, SHA1_ID);
     ++	write_table(&names, &buf, N, 256, GIT_SHA1_HASH_ID);
      +
      +	block_source_from_strbuf(&source, &buf);
      +
     @@ reftable/reftable_test.c (new)
      +	char **names;
      +	struct strbuf buf = STRBUF_INIT;
      +	int N = 1;
     -+	write_table(&names, &buf, N, 4096, SHA1_ID);
     ++	write_table(&names, &buf, N, 4096, GIT_SHA1_HASH_ID);
      +	EXPECT(buf.len < 200);
      +	strbuf_release(&buf);
      +	free_names(names);
     @@ reftable/reftable_test.c (new)
      +	struct reftable_log_record log = { NULL };
      +	struct reftable_iterator it = { NULL };
      +
     -+	write_table(&names, &buf, N, 256, SHA1_ID);
     ++	write_table(&names, &buf, N, 256, GIT_SHA1_HASH_ID);
      +
      +	block_source_from_strbuf(&source, &buf);
      +
     @@ reftable/reftable_test.c (new)
      +
      +static void test_table_read_write_seek_linear(void)
      +{
     -+	test_table_read_write_seek(0, SHA1_ID);
     ++	test_table_read_write_seek(0, GIT_SHA1_HASH_ID);
      +}
      +
      +static void test_table_read_write_seek_linear_sha256(void)
      +{
     -+	test_table_read_write_seek(0, SHA256_ID);
     ++	test_table_read_write_seek(0, GIT_SHA256_HASH_ID);
      +}
      +
      +static void test_table_read_write_seek_index(void)
      +{
     -+	test_table_read_write_seek(1, SHA1_ID);
     ++	test_table_read_write_seek(1, GIT_SHA1_HASH_ID);
      +}
      +
      +static void test_table_refs_for(int indexed)
     @@ reftable/reftable_test.c (new)
      +	int N = 50;
      +	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
      +	int want_names_len = 0;
     -+	uint8_t want_hash[SHA1_SIZE];
     ++	uint8_t want_hash[GIT_SHA1_RAWSZ];
      +
      +	struct reftable_write_options opts = {
      +		.block_size = 256,
     @@ reftable/reftable_test.c (new)
      +	set_test_hash(want_hash, 4);
      +
      +	for (i = 0; i < N; i++) {
     -+		uint8_t hash[SHA1_SIZE];
     ++		uint8_t hash[GIT_SHA1_RAWSZ];
      +		char fill[51] = { 0 };
      +		char name[100];
     -+		uint8_t hash1[SHA1_SIZE];
     -+		uint8_t hash2[SHA1_SIZE];
     ++		uint8_t hash1[GIT_SHA1_RAWSZ];
     ++		uint8_t hash2[GIT_SHA1_RAWSZ];
      +		struct reftable_ref_record ref = { NULL };
      +
      +		memset(hash, i, sizeof(hash));
     @@ reftable/reftable_test.c (new)
      +		n = reftable_writer_add_ref(w, &ref);
      +		EXPECT(n == 0);
      +
     -+		if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
     -+		    !memcmp(hash2, want_hash, SHA1_SIZE)) {
     ++		if (!memcmp(hash1, want_hash, GIT_SHA1_RAWSZ) ||
     ++		    !memcmp(hash2, want_hash, GIT_SHA1_RAWSZ)) {
      +			want_names[want_names_len++] = xstrdup(name);
      +		}
      +	}
     @@ reftable/reftable_test.c (new)
      +	strbuf_release(&buf);
      +}
      +
     -+int reftable_test_main(int argc, const char *argv[])
     ++static void test_write_key_order(void)
     ++{
     ++	struct reftable_write_options opts = { 0 };
     ++	struct strbuf buf = STRBUF_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     ++	struct reftable_ref_record refs[2] = {
     ++		{
     ++			.refname = "b",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value = {
     ++				.symref = "target",
     ++			},
     ++		}, {
     ++			.refname = "a",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value = {
     ++				.symref = "target",
     ++			},
     ++		}
     ++	};
     ++	int err;
     ++
     ++	reftable_writer_set_limits(w, 1, 1);
     ++	err = reftable_writer_add_ref(w, &refs[0]);
     ++	EXPECT_ERR(err);
     ++	err = reftable_writer_add_ref(w, &refs[1]);
     ++	printf("%d\n", err);
     ++	EXPECT(err == REFTABLE_API_ERROR);
     ++	reftable_writer_close(w);
     ++	reftable_writer_free(w);
     ++	strbuf_release(&buf);
     ++}
     ++
     ++int readwrite_test_main(int argc, const char *argv[])
      +{
      +	RUN_TEST(test_log_write_read);
     ++	RUN_TEST(test_write_key_order);
      +	RUN_TEST(test_table_read_write_seek_linear_sha256);
      +	RUN_TEST(test_log_buffer_size);
      +	RUN_TEST(test_table_write_small_table);
     @@ reftable/reftable_test.c (new)
      +	return 0;
      +}
      
     + ## reftable/reftable-tests.h ##
     +@@ reftable/reftable-tests.h: int block_test_main(int argc, const char **argv);
     + int merged_test_main(int argc, const char **argv);
     + int record_test_main(int argc, const char **argv);
     + int refname_test_main(int argc, const char **argv);
     +-int reftable_test_main(int argc, const char **argv);
     ++int readwrite_test_main(int argc, const char **argv);
     + int stack_test_main(int argc, const char **argv);
     + int tree_test_main(int argc, const char **argv);
     + int reftable_dump_main(int argc, char *const *argv);
     +
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	basics_test_main(argc, argv);
       	block_test_main(argc, argv);
       	record_test_main(argc, argv);
     -+	reftable_test_main(argc, argv);
     ++	readwrite_test_main(argc, argv);
       	tree_test_main(argc, argv);
       	return 0;
       }
 13:  0a6119d910a3 ! 18:  84578b666a40 reftable: add a heap-based priority queue for reftable records
     @@ Makefile: REFTABLE_OBJS += reftable/block.o
      +REFTABLE_OBJS += reftable/pq.o
       REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/reftable.o
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     + REFTABLE_OBJS += reftable/refname.o
     +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
       
       REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
      +REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
     + REFTABLE_TEST_OBJS += reftable/readwrite_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
      
       ## reftable/pq.c (new) ##
     @@ reftable/pq_test.c (new)
      +
      +		merged_iter_pqueue_check(pq);
      +
     -+		if (last != NULL) {
     ++		if (last) {
      +			assert(strcmp(last, ref->refname) < 0);
      +		}
      +		last = ref->refname;
     @@ reftable/reftable-tests.h: license that can be found in the LICENSE file or at
      +int pq_test_main(int argc, const char **argv);
       int record_test_main(int argc, const char **argv);
       int refname_test_main(int argc, const char **argv);
     - int reftable_test_main(int argc, const char **argv);
     + int readwrite_test_main(int argc, const char **argv);
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	block_test_main(argc, argv);
      +	pq_test_main(argc, argv);
       	record_test_main(argc, argv);
     - 	reftable_test_main(argc, argv);
     + 	readwrite_test_main(argc, argv);
       	tree_test_main(argc, argv);
 14:  393fcecdae1e ! 19:  e3a776f2076c reftable: add merged table view
     @@ Makefile: REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/pq.o
       REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
       
       REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
      +REFTABLE_TEST_OBJS += reftable/merged_test.o
       REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
     + REFTABLE_TEST_OBJS += reftable/readwrite_test.o
      
       ## reftable/merged.c (new) ##
      @@
     @@ reftable/merged.c (new)
      +
      +static void merged_iter_close(void *p)
      +{
     -+	struct merged_iter *mi = (struct merged_iter *)p;
     ++	struct merged_iter *mi = p;
      +	int i = 0;
      +	merged_iter_pqueue_release(&mi->pq);
      +	for (i = 0; i < mi->stack_len; i++) {
     @@ reftable/merged.c (new)
      +
      +static int merged_iter_next_void(void *p, struct reftable_record *rec)
      +{
     -+	struct merged_iter *mi = (struct merged_iter *)p;
     ++	struct merged_iter *mi = p;
      +	if (merged_iter_pqueue_is_empty(mi->pq))
      +		return 1;
      +
     @@ reftable/merged.c (new)
      +static void iterator_from_merged_iter(struct reftable_iterator *it,
      +				      struct merged_iter *mi)
      +{
     -+	assert(it->ops == NULL);
     ++	assert(!it->ops);
      +	it->iter_arg = mi;
      +	it->ops = &merged_iter_vtable;
      +}
     @@ reftable/merged.c (new)
      +		}
      +	}
      +
     -+	m = (struct reftable_merged_table *)reftable_calloc(
     -+		sizeof(struct reftable_merged_table));
     ++	m = reftable_calloc(sizeof(struct reftable_merged_table));
      +	m->stack = stack;
      +	m->stack_len = n;
      +	m->min = first_min;
     @@ reftable/merged.c (new)
      +
      +void reftable_merged_table_free(struct reftable_merged_table *mt)
      +{
     -+	if (mt == NULL) {
     ++	if (!mt) {
      +		return;
      +	}
      +	merged_table_release(mt);
     @@ reftable/merged.c (new)
      +					   struct reftable_iterator *it,
      +					   struct reftable_record *rec)
      +{
     -+	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
     -+					rec);
     ++	return merged_table_seek_record(tab, it, rec);
      +}
      +
      +static uint32_t reftable_merged_table_hash_id_void(void *tab)
      +{
     -+	return reftable_merged_table_hash_id(
     -+		(struct reftable_merged_table *)tab);
     ++	return reftable_merged_table_hash_id(tab);
      +}
      +
      +static uint64_t reftable_merged_table_min_update_index_void(void *tab)
      +{
     -+	return reftable_merged_table_min_update_index(
     -+		(struct reftable_merged_table *)tab);
     ++	return reftable_merged_table_min_update_index(tab);
      +}
      +
      +static uint64_t reftable_merged_table_max_update_index_void(void *tab)
      +{
     -+	return reftable_merged_table_max_update_index(
     -+		(struct reftable_merged_table *)tab);
     ++	return reftable_merged_table_max_update_index(tab);
      +}
      +
      +static struct reftable_table_vtable merged_table_vtable = {
     @@ reftable/merged.c (new)
      +void reftable_table_from_merged_table(struct reftable_table *tab,
      +				      struct reftable_merged_table *merged)
      +{
     -+	assert(tab->ops == NULL);
     ++	assert(!tab->ops);
      +	tab->ops = &merged_table_vtable;
      +	tab->table_arg = merged;
      +}
     @@ reftable/merged_test.c (new)
      +		reftable_table_from_reader(&tabs[i], (*readers)[i]);
      +	}
      +
     -+	err = reftable_new_merged_table(&mt, tabs, n, SHA1_ID);
     ++	err = reftable_new_merged_table(&mt, tabs, n, GIT_SHA1_HASH_ID);
      +	EXPECT_ERR(err);
      +	return mt;
      +}
     @@ reftable/merged_test.c (new)
      +
      +static void test_merged_between(void)
      +{
     -+	uint8_t hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
     ++	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1, 2, 3, 0 };
      +
      +	struct reftable_ref_record r1[] = { {
      +		.refname = "b",
     @@ reftable/merged_test.c (new)
      +
      +static void test_merged(void)
      +{
     -+	uint8_t hash1[SHA1_SIZE] = { 1 };
     -+	uint8_t hash2[SHA1_SIZE] = { 2 };
     ++	uint8_t hash1[GIT_SHA1_RAWSZ] = { 1 };
     ++	uint8_t hash2[GIT_SHA1_RAWSZ] = { 2 };
      +	struct reftable_ref_record r1[] = {
      +		{
      +			.refname = "a",
     @@ reftable/merged_test.c (new)
      +
      +	assert(ARRAY_SIZE(want) == len);
      +	for (i = 0; i < len; i++) {
     -+		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
     ++		assert(reftable_ref_record_equal(&want[i], &out[i],
     ++						 GIT_SHA1_RAWSZ));
      +	}
      +	for (i = 0; i < len; i++) {
      +		reftable_ref_record_release(&out[i]);
     @@ reftable/merged_test.c (new)
      +	EXPECT_ERR(err);
      +
      +	hash_id = reftable_reader_hash_id(rd);
     -+	assert(hash_id == SHA1_ID);
     ++	assert(hash_id == GIT_SHA1_HASH_ID);
      +
      +	reftable_table_from_reader(&tab[0], rd);
     -+	err = reftable_new_merged_table(&merged, tab, 1, SHA1_ID);
     ++	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_HASH_ID);
      +	EXPECT_ERR(err);
      +
      +	reftable_reader_free(rd);
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
      +	merged_test_main(argc, argv);
       	pq_test_main(argc, argv);
       	record_test_main(argc, argv);
     - 	reftable_test_main(argc, argv);
     + 	readwrite_test_main(argc, argv);
 15:  3186b2b70f73 ! 20:  7913027063a2 reftable: implement refname validation
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/merged.o
     - REFTABLE_OBJS += reftable/pq.o
     - REFTABLE_OBJS += reftable/reader.o
     - REFTABLE_OBJS += reftable/record.o
     -+REFTABLE_OBJS += reftable/refname.o
     - REFTABLE_OBJS += reftable/reftable.o
     - REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/writer.o
     -@@ Makefile: REFTABLE_TEST_OBJS += reftable/block_test.o
     - REFTABLE_TEST_OBJS += reftable/merged_test.o
     +@@ Makefile: REFTABLE_TEST_OBJS += reftable/merged_test.o
       REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     + REFTABLE_TEST_OBJS += reftable/readwrite_test.o
      +REFTABLE_TEST_OBJS += reftable/refname_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
       REFTABLE_TEST_OBJS += reftable/tree_test.o
     + 
      
       ## reftable/refname.c (new) ##
      @@
     @@ reftable/refname.c (new)
      +
      +static int find_name(size_t k, void *arg)
      +{
     -+	struct find_arg *f_arg = (struct find_arg *)arg;
     ++	struct find_arg *f_arg = arg;
      +	return strcmp(f_arg->names[k], f_arg->want) >= 0;
      +}
      +
     @@ reftable/refname_test.c (new)
      +			.tab = tab,
      +		};
      +
     -+		if (cases[i].add != NULL) {
     ++		if (cases[i].add) {
      +			mod.add = &cases[i].add;
      +			mod.add_len = 1;
      +		}
     -+		if (cases[i].del != NULL) {
     ++		if (cases[i].del) {
      +			mod.del = &cases[i].del;
      +			mod.del_len = 1;
      +		}
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	pq_test_main(argc, argv);
       	record_test_main(argc, argv);
      +	refname_test_main(argc, argv);
     - 	reftable_test_main(argc, argv);
     + 	readwrite_test_main(argc, argv);
       	tree_test_main(argc, argv);
       	return 0;
 16:  b5492d5a13d7 ! 21:  3f1e5aedf4a8 reftable: implement stack, a mutable database of reftable files.
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/reader.o
     - REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/refname.o
     - REFTABLE_OBJS += reftable/reftable.o
     -+REFTABLE_OBJS += reftable/stack.o
     - REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/writer.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
      @@ Makefile: REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     + REFTABLE_TEST_OBJS += reftable/readwrite_test.o
       REFTABLE_TEST_OBJS += reftable/refname_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
      +REFTABLE_TEST_OBJS += reftable/stack_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
       REFTABLE_TEST_OBJS += reftable/tree_test.o
     @@ reftable/reftable-stack.h (new)
      +					     void *arg),
      +			  void *arg);
      +
     -+/* Commits the transaction, releasing the lock. */
     ++/* Commits the transaction, releasing the lock. After calling this,
     ++ * reftable_addition_destroy should still be called.
     ++ */
      +int reftable_addition_commit(struct reftable_addition *add);
      +
      +/* Release all non-committed data from the transaction, and deallocate the
     @@ reftable/reftable-stack.h (new)
      +struct reftable_compaction_stats *
      +reftable_stack_compaction_stats(struct reftable_stack *st);
      +
     ++/* print the entire stack represented by the directory */
     ++int reftable_stack_print_directory(const char *stackdir);
     ++
      +#endif
      
       ## reftable/stack.c (new) ##
     @@ reftable/stack.c (new)
      +	strbuf_addstr(dest, name);
      +}
      +
     -+static int reftable_fd_write(void *arg, const void *data, size_t sz)
     ++static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
      +{
      +	int *fdp = (int *)arg;
      +	return write(*fdp, data, sz);
     @@ reftable/stack.c (new)
      +	int err = 0;
      +
      +	if (config.hash_id == 0) {
     -+		config.hash_id = SHA1_ID;
     ++		config.hash_id = GIT_SHA1_HASH_ID;
      +	}
      +
      +	*dest = NULL;
     @@ reftable/stack.c (new)
      +{
      +	char **names = NULL;
      +	int err = 0;
     -+	if (st->merged != NULL) {
     ++	if (st->merged) {
      +		reftable_merged_table_free(st->merged);
      +		st->merged = NULL;
      +	}
     @@ reftable/stack.c (new)
      +		FREE_AND_NULL(names);
      +	}
      +
     -+	if (st->readers != NULL) {
     ++	if (st->readers) {
      +		int i = 0;
      +		struct strbuf filename = STRBUF_INIT;
      +		for (i = 0; i < st->readers_len; i++) {
     @@ reftable/stack.c (new)
      +static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
      +				      int reuse_open)
      +{
     -+	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     ++	int cur_len = !st->merged ? 0 : st->merged->stack_len;
      +	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
      +	int err = 0;
      +	int names_len = names_length(names);
     @@ reftable/stack.c (new)
      +		   tables under control so this is not quadratic. */
      +		int j = 0;
      +		for (j = 0; reuse_open && j < cur_len; j++) {
     -+			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
     ++			if (cur[j] && 0 == strcmp(cur[j]->name, name)) {
      +				rd = cur[j];
      +				cur[j] = NULL;
      +				break;
      +			}
      +		}
      +
     -+		if (rd == NULL) {
     ++		if (!rd) {
      +			struct reftable_block_source src = { NULL };
      +			struct strbuf table_path = STRBUF_INIT;
      +			stack_filename(&table_path, st, name);
     @@ reftable/stack.c (new)
      +
      +	new_tables = NULL;
      +	st->readers_len = new_readers_len;
     -+	if (st->merged != NULL) {
     ++	if (st->merged) {
      +		merged_table_release(st->merged);
      +		reftable_merged_table_free(st->merged);
      +	}
     -+	if (st->readers != NULL) {
     ++	if (st->readers) {
      +		reftable_free(st->readers);
      +	}
      +	st->readers = new_readers;
     @@ reftable/stack.c (new)
      +	new_merged->suppress_deletions = 1;
      +	st->merged = new_merged;
      +	for (i = 0; i < cur_len; i++) {
     -+		if (cur[i] != NULL) {
     ++		if (cur[i]) {
      +			const char *name = reader_name(cur[i]);
      +			struct strbuf filename = STRBUF_INIT;
      +			stack_filename(&filename, st, name);
     @@ reftable/stack.c (new)
      +		return err;
      +
      +	for (i = 0; i < st->readers_len; i++) {
     -+		if (names[i] == NULL) {
     ++		if (!names[i]) {
      +			err = 1;
      +			goto done;
      +		}
     @@ reftable/stack.c (new)
      +		}
      +	}
      +
     -+	if (names[st->merged->stack_len] != NULL) {
     ++	if (names[st->merged->stack_len]) {
      +		err = 1;
      +		goto done;
      +	}
     @@ reftable/stack.c (new)
      +
      +void reftable_addition_destroy(struct reftable_addition *add)
      +{
     -+	if (add == NULL) {
     ++	if (!add) {
      +		return;
      +	}
      +	reftable_addition_close(add);
     @@ reftable/stack.c (new)
      +			continue;
      +		}
      +
     -+		if (config != NULL && config->min_update_index > 0 &&
     ++		if (config && config->min_update_index > 0 &&
      +		    log.update_index < config->min_update_index) {
      +			continue;
      +		}
      +
     -+		if (config != NULL && config->time > 0 &&
     ++		if (config && config->time > 0 &&
      +		    log.update.time < config->time) {
      +			continue;
      +		}
     @@ reftable/stack.c (new)
      +
      +done:
      +	reftable_iterator_destroy(&it);
     -+	if (mt != NULL) {
     ++	if (mt) {
      +		merged_table_release(mt);
      +		reftable_merged_table_free(mt);
      +	}
     @@ reftable/stack.c (new)
      +	int j = 0;
      +	int is_empty_table = 0;
      +
     -+	if (first > last || (expiry == NULL && first == last)) {
     ++	if (first > last || (!expiry && first == last)) {
      +		err = 0;
      +		goto done;
      +	}
     @@ reftable/stack.c (new)
      +{
      +	uint64_t *sizes =
      +		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
     -+	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
     ++	int version = (st->config.hash_id == GIT_SHA1_HASH_ID) ? 1 : 2;
      +	int overhead = header_size(version) - 1;
      +	int i = 0;
      +	for (i = 0; i < st->merged->stack_len; i++) {
     @@ reftable/stack.c (new)
      +static int is_table_name(const char *s)
      +{
      +	const char *dot = strrchr(s, '.');
     -+	return dot != NULL && !strcmp(dot, ".ref");
     ++	return dot && !strcmp(dot, ".ref");
      +}
      +
      +static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
     @@ reftable/stack.c (new)
      +		reftable_stack_merged_table(st));
      +	DIR *dir = opendir(st->reftable_dir);
      +	struct dirent *d = NULL;
     -+	if (dir == NULL) {
     ++	if (!dir) {
      +		return REFTABLE_IO_ERROR;
      +	}
      +
     -+	while ((d = readdir(dir)) != NULL) {
     ++	while ((d = readdir(dir))) {
      +		int i = 0;
      +		int found = 0;
      +		if (!is_table_name(d->d_name))
     @@ reftable/stack.c (new)
      +done:
      +	reftable_addition_destroy(add);
      +	return err;
     ++}
     ++
     ++int reftable_stack_print_directory(const char *stackdir)
     ++{
     ++	struct reftable_stack *stack = NULL;
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_merged_table *merged = NULL;
     ++	struct reftable_table table = { NULL };
     ++
     ++	int err = reftable_new_stack(&stack, stackdir, cfg);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	merged = reftable_stack_merged_table(stack);
     ++	reftable_table_from_merged_table(&table, merged);
     ++	err = reftable_table_print(&table);
     ++done:
     ++	reftable_stack_destroy(stack);
     ++	return err;
      +}
      
       ## reftable/stack.h (new) ##
     @@ reftable/stack_test.c (new)
      +	if (dir == NULL)
      +		return 0;
      +
     -+	while ((d = readdir(dir)) != NULL) {
     ++	while ((d = readdir(dir))) {
      +		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
      +			continue;
      +		len++;
     @@ reftable/stack_test.c (new)
      +	return template;
      +}
      +
     ++static char *get_tmp_dir(const char *prefix)
     ++{
     ++	char *dir = get_tmp_template(prefix);
     ++	EXPECT(mkdtemp(dir));
     ++	return dir;
     ++}
     ++
      +static void test_read_file(void)
      +{
      +	char *fn = get_tmp_template(__FUNCTION__);
     @@ reftable/stack_test.c (new)
      +	err = read_lines(fn, &names);
      +	EXPECT_ERR(err);
      +
     -+	for (i = 0; names[i] != NULL; i++) {
     ++	for (i = 0; names[i]; i++) {
      +		EXPECT(0 == strcmp(want[i], names[i]));
      +	}
      +	free_names(names);
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_add_one(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st1 = NULL;
      +	struct reftable_stack *st2 = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	int err;
      +	struct reftable_ref_record ref1 = {
      +		.refname = "HEAD",
     @@ reftable/stack_test.c (new)
      +		.value.symref = "master",
      +	};
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	/* simulate multi-process access to the same stack
      +	   by creating two stacks for the same directory.
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_transaction_api(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	int i;
      +	struct reftable_ref_record ref = {
      +		.refname = "a/b",
     @@ reftable/stack_test.c (new)
      +	};
      +	char *additions[] = { "a", "a/b/c" };
      +
     -+	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_update_index_check(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +		.value_type = REFTABLE_REF_SYMREF,
      +		.value.symref = "master",
      +	};
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_lock_failure(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err, i;
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +		.exact_log_message = 1,
      +	};
      +	struct reftable_stack *st = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_ref_record refs[2] = { { NULL } };
      +	struct reftable_log_record logs[2] = { { NULL } };
      +	int N = ARRAY_SIZE(refs);
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +		refs[i].refname = xstrdup(buf);
      +		refs[i].update_index = i + 1;
      +		refs[i].value_type = REFTABLE_REF_VAL1;
     -+		refs[i].value.val1 = reftable_malloc(SHA1_SIZE);
     ++		refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
      +		set_test_hash(refs[i].value.val1, i);
      +
      +		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = N + i + 1;
      +		logs[i].value_type = REFTABLE_LOG_UPDATE;
      +
     -+		logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
      +		logs[i].update.email = xstrdup("identity@invalid");
      +		set_test_hash(logs[i].update.new_hash, i);
      +	}
     @@ reftable/stack_test.c (new)
      +
      +		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
      +		EXPECT_ERR(err);
     -+		EXPECT(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
     ++		EXPECT(reftable_ref_record_equal(&dest, refs + i,
     ++						 GIT_SHA1_RAWSZ));
      +		reftable_ref_record_release(&dest);
      +	}
      +
     @@ reftable/stack_test.c (new)
      +		struct reftable_log_record dest = { NULL };
      +		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
      +		EXPECT_ERR(err);
     -+		EXPECT(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
     ++		EXPECT(reftable_log_record_equal(&dest, logs + i,
     ++						 GIT_SHA1_RAWSZ));
      +		reftable_log_record_release(&dest);
      +	}
      +
     @@ reftable/stack_test.c (new)
      +		0,
      +	};
      +	struct reftable_stack *st = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +
     -+	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
     ++	uint8_t h1[GIT_SHA1_RAWSZ] = { 0x01 }, h2[GIT_SHA1_RAWSZ] = { 0x02 };
      +
      +	struct reftable_log_record input = { .refname = "branch",
      +					     .update_index = 1,
     @@ reftable/stack_test.c (new)
      +		.update_index = 1,
      +	};
      +
     -+	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     @@ reftable/stack_test.c (new)
      +static void test_reftable_stack_tombstone(void)
      +{
      +	int i = 0;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +	struct reftable_ref_record dest = { NULL };
      +	struct reftable_log_record log_dest = { NULL };
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     ++	/* even entries add the refs, odd entries delete them. */
      +	for (i = 0; i < N; i++) {
      +		const char *buf = "branch";
      +		refs[i].refname = xstrdup(buf);
      +		refs[i].update_index = i + 1;
      +		if (i % 2 == 0) {
      +			refs[i].value_type = REFTABLE_REF_VAL1;
     -+			refs[i].value.val1 = reftable_malloc(SHA1_SIZE);
     ++			refs[i].value.val1 = reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_test_hash(refs[i].value.val1, i);
      +		}
      +
     @@ reftable/stack_test.c (new)
      +		logs[i].update_index = 42;
      +		if (i % 2 == 0) {
      +			logs[i].value_type = REFTABLE_LOG_UPDATE;
     -+			logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++			logs[i].update.new_hash =
     ++				reftable_malloc(GIT_SHA1_RAWSZ);
      +			set_test_hash(logs[i].update.new_hash, i);
      +			logs[i].update.email = xstrdup("identity@invalid");
      +		}
     @@ reftable/stack_test.c (new)
      +		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
      +		EXPECT_ERR(err);
      +	}
     ++
      +	for (i = 0; i < N; i++) {
      +		struct write_log_arg arg = {
      +			.log = &logs[i],
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_hash_id(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +		.value.symref = "target",
      +		.update_index = 1,
      +	};
     -+	struct reftable_write_options cfg32 = { .hash_id = SHA256_ID };
     ++	struct reftable_write_options cfg32 = { .hash_id = GIT_SHA256_HASH_ID };
      +	struct reftable_stack *st32 = NULL;
      +	struct reftable_write_options cfg_default = { 0 };
      +	struct reftable_stack *st_default = NULL;
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_read_ref(st_default, "master", &dest);
      +	EXPECT_ERR(err);
      +
     -+	EXPECT(reftable_ref_record_equal(&ref, &dest, SHA1_SIZE));
     ++	EXPECT(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
      +	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st_default);
     @@ reftable/stack_test.c (new)
      +
      +static void test_reflog_expire(void)
      +{
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	struct reftable_log_record logs[20] = { { NULL } };
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_log_record log = { NULL };
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +		logs[i].update_index = i;
      +		logs[i].value_type = REFTABLE_LOG_UPDATE;
      +		logs[i].update.time = i;
     -+		logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
      +		logs[i].update.email = xstrdup("identity@invalid");
      +		set_test_hash(logs[i].update.new_hash, i);
      +	}
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	struct reftable_stack *st2 = NULL;
      +
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +{
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	int err, i;
      +	int N = 100;
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +{
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st1 = NULL, *st2 = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	int err, i;
      +	int N = 3;
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st1, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +{
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
     -+	char *dir = get_tmp_template(__FUNCTION__);
     ++	char *dir = get_tmp_dir(__FUNCTION__);
     ++
      +	int err, i;
      +	int N = 3;
     -+	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st1, dir, cfg);
      +	EXPECT_ERR(err);
     @@ reftable/stack_test.c (new)
      +
      +int stack_test_main(int argc, const char *argv[])
      +{
     -+	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
     ++	RUN_TEST(test_empty_add);
     ++	RUN_TEST(test_log2);
     ++	RUN_TEST(test_names_equal);
     ++	RUN_TEST(test_parse_names);
     ++	RUN_TEST(test_read_file);
     ++	RUN_TEST(test_reflog_expire);
     ++	RUN_TEST(test_reftable_stack_add);
     ++	RUN_TEST(test_reftable_stack_add_one);
     ++	RUN_TEST(test_reftable_stack_auto_compaction);
      +	RUN_TEST(test_reftable_stack_compaction_concurrent);
     -+	RUN_TEST(test_reftable_stack_uptodate);
     -+	RUN_TEST(test_reftable_stack_transaction_api);
     ++	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
      +	RUN_TEST(test_reftable_stack_hash_id);
     -+	RUN_TEST(test_sizes_to_segments_all_equal);
     -+	RUN_TEST(test_reftable_stack_auto_compaction);
     -+	RUN_TEST(test_reftable_stack_validate_refname);
     -+	RUN_TEST(test_reftable_stack_update_index_check);
      +	RUN_TEST(test_reftable_stack_lock_failure);
      +	RUN_TEST(test_reftable_stack_log_normalize);
      +	RUN_TEST(test_reftable_stack_tombstone);
     -+	RUN_TEST(test_reftable_stack_add_one);
     -+	RUN_TEST(test_empty_add);
     -+	RUN_TEST(test_reflog_expire);
     -+	RUN_TEST(test_suggest_compaction_segment);
     -+	RUN_TEST(test_suggest_compaction_segment_nothing);
     ++	RUN_TEST(test_reftable_stack_transaction_api);
     ++	RUN_TEST(test_reftable_stack_update_index_check);
     ++	RUN_TEST(test_reftable_stack_uptodate);
     ++	RUN_TEST(test_reftable_stack_validate_refname);
      +	RUN_TEST(test_sizes_to_segments);
     ++	RUN_TEST(test_sizes_to_segments_all_equal);
      +	RUN_TEST(test_sizes_to_segments_empty);
     -+	RUN_TEST(test_log2);
     -+	RUN_TEST(test_parse_names);
     -+	RUN_TEST(test_read_file);
     -+	RUN_TEST(test_names_equal);
     -+	RUN_TEST(test_reftable_stack_add);
     ++	RUN_TEST(test_suggest_compaction_segment);
     ++	RUN_TEST(test_suggest_compaction_segment_nothing);
      +	return 0;
      +}
      
     @@ t/helper/test-reftable.c
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	record_test_main(argc, argv);
       	refname_test_main(argc, argv);
     - 	reftable_test_main(argc, argv);
     + 	readwrite_test_main(argc, argv);
      +	stack_test_main(argc, argv);
       	tree_test_main(argc, argv);
       	return 0;
 17:  5db7c8ab7f23 ! 22:  b2ac95a25af8 reftable: add dump utility
     @@ reftable/dump.c (new)
      +#include <unistd.h>
      +#include <string.h>
      +
     -+#include "reftable.h"
     ++#include "reftable-blocksource.h"
     ++#include "reftable-error.h"
     ++#include "reftable-merged.h"
     ++#include "reftable-record.h"
      +#include "reftable-tests.h"
     -+
     -+static uint32_t hash_id;
     -+
     -+static int dump_table(const char *tablename)
     -+{
     -+	struct reftable_block_source src = { 0 };
     -+	int err = reftable_block_source_from_file(&src, tablename);
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     -+	struct reftable_reader *r = NULL;
     -+
     -+	if (err < 0)
     -+		return err;
     -+
     -+	err = reftable_new_reader(&r, &src, tablename);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	err = reftable_reader_seek_ref(r, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	while (1) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_ref_record_print(&ref, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_ref_record_clear(&ref);
     -+
     -+	err = reftable_reader_seek_log(r, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+	while (1) {
     -+		err = reftable_iterator_next_log(&it, &log);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_log_record_print(&log, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_log_record_clear(&log);
     -+
     -+	reftable_reader_free(r);
     -+	return 0;
     -+}
     ++#include "reftable-writer.h"
     ++#include "reftable-iterator.h"
     ++#include "reftable-reader.h"
     ++#include "reftable-stack.h"
     ++#include "reftable-generic.h"
      +
      +static int compact_stack(const char *stackdir)
      +{
      +	struct reftable_stack *stack = NULL;
     -+	struct reftable_write_options cfg = {};
     ++	struct reftable_write_options cfg = { 0 };
      +
      +	int err = reftable_new_stack(&stack, stackdir, cfg);
      +	if (err < 0)
     @@ reftable/dump.c (new)
      +	if (err < 0)
      +		goto done;
      +done:
     -+	if (stack != NULL) {
     ++	if (stack) {
      +		reftable_stack_destroy(stack);
      +	}
      +	return err;
      +}
      +
     -+static int dump_stack(const char *stackdir)
     -+{
     -+	struct reftable_stack *stack = NULL;
     -+	struct reftable_write_options cfg = {};
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     -+	struct reftable_merged_table *merged = NULL;
     -+
     -+	int err = reftable_new_stack(&stack, stackdir, cfg);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	merged = reftable_stack_merged_table(stack);
     -+
     -+	err = reftable_merged_table_seek_ref(merged, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	while (1) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_ref_record_print(&ref, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_ref_record_clear(&ref);
     -+
     -+	err = reftable_merged_table_seek_log(merged, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+	while (1) {
     -+		err = reftable_iterator_next_log(&it, &log);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_log_record_print(&log, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_log_record_clear(&log);
     -+
     -+	reftable_stack_destroy(stack);
     -+	return 0;
     -+}
     -+
      +static void print_help(void)
      +{
      +	printf("usage: dump [-cst] arg\n\n"
     @@ reftable/dump.c (new)
      +	       "  -t dump table\n"
      +	       "  -s dump stack\n"
      +	       "  -h this help\n"
     -+	       "  -2 use SHA256\n"
      +	       "\n");
      +}
      +
      +int reftable_dump_main(int argc, char *const *argv)
      +{
      +	int err = 0;
     -+	int opt;
      +	int opt_dump_table = 0;
      +	int opt_dump_stack = 0;
      +	int opt_compact = 0;
     -+	const char *arg = NULL;
     -+	while ((opt = getopt(argc, argv, "2chts")) != -1) {
     -+		switch (opt) {
     -+		case '2':
     -+			hash_id = 0x73323536;
     ++	const char *arg = NULL, *argv0 = argv[0];
     ++
     ++	for (; argc > 1; argv++, argc--)
     ++		if (*argv[1] != '-')
      +			break;
     -+		case 't':
     ++		else if (!strcmp("-t", argv[1]))
      +			opt_dump_table = 1;
     -+			break;
     -+		case 's':
     ++		else if (!strcmp("-s", argv[1]))
      +			opt_dump_stack = 1;
     -+			break;
     -+		case 'c':
     ++		else if (!strcmp("-c", argv[1]))
      +			opt_compact = 1;
     -+			break;
     -+		case '?':
     -+		case 'h':
     ++		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
      +			print_help();
      +			return 2;
     -+			break;
      +		}
     -+	}
      +
     -+	if (argv[optind] == NULL) {
     ++	if (argc != 2) {
      +		fprintf(stderr, "need argument\n");
      +		print_help();
      +		return 2;
      +	}
      +
     -+	arg = argv[optind];
     ++	arg = argv[1];
      +
      +	if (opt_dump_table) {
     -+		err = dump_table(arg);
     ++		err = reftable_reader_print_file(arg);
      +	} else if (opt_dump_stack) {
     -+		err = dump_stack(arg);
     ++		err = reftable_stack_print_directory(arg);
      +	} else if (opt_compact) {
      +		err = compact_stack(arg);
      +	}
      +
      +	if (err < 0) {
     -+		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
     ++		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
      +			reftable_error_str(err));
      +		return 1;
      +	}
 18:  2dc73bf2ec96 ! 23:  2fd7cb8c0983 Reftable support for git-core
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Helped-by: Junio Hamano <gitster@pobox.com>
     +    Helped-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
          Co-authored-by: Jeff King <peff@peff.net>
      
       ## Documentation/config/extensions.txt ##
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
      +		       initial_branch, ref_storage_format, flags);
       }
      
     + ## builtin/stash.c ##
     +@@ builtin/stash.c: static int get_stash_info(struct stash_info *info, int argc, const char **argv)
     + static int do_clear_stash(void)
     + {
     + 	struct object_id obj;
     ++	int result;
     + 	if (get_oid(ref_stash, &obj))
     + 		return 0;
     + 
     +-	return delete_ref(NULL, ref_stash, &obj, 0);
     ++	result = delete_ref(NULL, ref_stash, &obj, 0);
     ++
     ++	/* Ignore error; this is necessary for reftable, which keeps reflogs
     ++	 * even when refs are deleted. */
     ++	delete_reflog(ref_stash);
     ++	return result;
     + }
     + 
     + static int clear_stash(int argc, const char **argv, const char *prefix)
     +
       ## builtin/worktree.c ##
      @@
       #include "utf8.h"
     @@ refs.c
       
      +const char *default_ref_storage(void)
      +{
     -+	const char *test = getenv("GIT_TEST_REFTABLE");
     -+	return test ? "reftable" : "files";
     ++	return git_env_bool("GIT_TEST_REFTABLE", 0) ? "reftable" : "files";
      +}
      +
       /*
     @@ refs/reftable-backend.c (new)
      +static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
      +					const char *refname)
      +{
     -+	if (store->worktree_stack == NULL)
     ++	if (store->worktree_stack == NULL || refname == NULL)
      +		return store->main_stack;
      +
      +	switch (ref_type(refname)) {
     @@ refs/reftable-backend.c (new)
      +		ri->base.flags = 0;
      +		switch (ri->ref.value_type) {
      +		case REFTABLE_REF_VAL1:
     -+			hashcpy(ri->oid.hash, ri->ref.value.val1);
     ++			oidread(&ri->oid, ri->ref.value.val1);
      +			break;
      +		case REFTABLE_REF_VAL2:
     -+			hashcpy(ri->oid.hash, ri->ref.value.val2.value);
     ++			oidread(&ri->oid, ri->ref.value.val2.value);
      +			break;
      +		case REFTABLE_REF_SYMREF: {
      +			int out_flags = 0;
     @@ refs/reftable-backend.c (new)
      +	struct git_reftable_iterator *ri =
      +		(struct git_reftable_iterator *)ref_iterator;
      +	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
     -+		hashcpy(peeled->hash, ri->ref.value.val2.target_value);
     ++		oidread(peeled, ri->ref.value.val2.target_value);
      +		return 0;
      +	}
      +
     -+	return -1;
     ++	return 1;
      +}
      +
      +static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
     @@ refs/reftable-backend.c (new)
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_addition *add = NULL;
      +	struct reftable_stack *stack =
     -+		transaction->nr ?
     -+			      stack_for(refs, transaction->updates[0]->refname) :
     -+			      refs->main_stack;
     ++		stack_for(refs,
     ++			  transaction->nr ? transaction->updates[0]->refname : NULL);
     ++
      +	int err = refs->err;
      +	if (err < 0) {
      +		goto done;
     @@ refs/reftable-backend.c (new)
      +		calloc(transaction->nr, sizeof(*logs));
      +	struct ref_update **sorted =
      +		malloc(transaction->nr * sizeof(struct ref_update *));
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
     ++	struct reftable_table tab = {NULL};
     ++	struct reftable_ref_record ref = {NULL};
     ++	reftable_table_from_merged_table(&tab, mt);
      +	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
      +	QSORT(sorted, transaction->nr, ref_update_cmp);
      +	reftable_writer_set_limits(writer, ts, ts);
     @@ refs/reftable-backend.c (new)
      +	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
      +		struct reftable_log_record *log = &logs[i];
     ++		struct object_id old_id;
      +		fill_reftable_log_record(log);
      +		log->update_index = ts;
      +		log->value_type = REFTABLE_LOG_UPDATE;
      +		log->refname = (char *)u->refname;
     -+		log->update.old_hash = u->old_oid.hash;
      +		log->update.new_hash = u->new_oid.hash;
      +		log->update.message = u->msg;
      +
     ++		err = reftable_table_read_ref(&tab, u->refname, &ref);
     ++		if (err < 0)
     ++			goto done;
     ++		else if (err > 0) {
     ++			old_id = null_oid;
     ++		} else {
     ++			oidread(&old_id, ref.value.val1);
     ++		}
     ++
     ++		/* XXX fold together with the old_id check below? */
     ++
     ++		log->update.old_hash = old_id.hash;
      +		if (u->flags & REF_LOG_ONLY) {
      +			continue;
      +		}
     @@ refs/reftable-backend.c (new)
      +
      +done:
      +	assert(err != REFTABLE_API_ERROR);
     ++	reftable_ref_record_release(&ref);
      +	free(logs);
      +	free(sorted);
      +	return err;
     @@ refs/reftable-backend.c (new)
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_stack *stack =
     -+		stack_for(refs, refnames->items[0].string);
     ++		stack_for(refs, refnames->nr ? refnames->items[0].string : NULL);
      +	struct write_delete_refs_arg arg = {
      +		.stack = stack,
      +		.refnames = refnames,
     @@ refs/reftable-backend.c (new)
      +{
      +	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
      +	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     -+	struct reftable_ref_record ref = { NULL };
     -+	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
     ++	struct reftable_ref_record old_ref = { NULL };
     ++	struct reftable_ref_record new_ref = { NULL };
     ++	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
      +
      +	if (err) {
      +		goto done;
      +	}
      +
     -+	/* XXX do ref renames overwrite the target? */
     -+	if (reftable_stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
     ++	/* git-branch supports a --force, but the check is not atomic. */
     ++	if (reftable_stack_read_ref(arg->stack, arg->newname, &new_ref) == 0) {
      +		goto done;
      +	}
      +
     @@ refs/reftable-backend.c (new)
      +				.update_index = ts,
      +				.value_type = REFTABLE_REF_DELETION,
      +			},
     -+			ref,
     ++			old_ref,
      +		};
      +		todo[1].update_index = ts;
      +		free(todo[1].refname);
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	if (reftable_ref_record_val1(&ref)) {
     -+		uint8_t *val1 = reftable_ref_record_val1(&ref);
     ++	if (reftable_ref_record_val1(&old_ref)) {
     ++		uint8_t *val1 = reftable_ref_record_val1(&old_ref);
      +		struct reftable_log_record todo[2] = { { NULL } };
      +		fill_reftable_log_record(&todo[0]);
      +		fill_reftable_log_record(&todo[1]);
     @@ refs/reftable-backend.c (new)
      +
      +done:
      +	assert(err != REFTABLE_API_ERROR);
     -+	reftable_ref_record_release(&ref);
     ++	reftable_ref_record_release(&new_ref);
     ++	reftable_ref_record_release(&old_ref);
     ++	return err;
     ++}
     ++
     ++static int write_copy_table(struct reftable_writer *writer, void *argv)
     ++{
     ++	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     ++	struct reftable_ref_record old_ref = { NULL };
     ++	struct reftable_ref_record new_ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { NULL };
     ++	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++	/* git-branch supports a --force, but the check is not atomic. */
     ++	if (reftable_stack_read_ref(arg->stack, arg->newname, &new_ref) == 0) {
     ++		goto done;
     ++	}
     ++
     ++	reftable_writer_set_limits(writer, ts, ts);
     ++
     ++	FREE_AND_NULL(old_ref.refname);
     ++	old_ref.refname = xstrdup(arg->newname);
     ++	old_ref.update_index = ts;
     ++	err = reftable_writer_add_ref(writer, &old_ref);
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	/* this copies the entire reflog history. Is this the right semantics? */
     ++	/* XXX should clear out existing reflog entries for oldname? */
     ++	err = reftable_merged_table_seek_log(reftable_stack_merged_table(arg->stack), &it, arg->oldname);
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	while (1) {
     ++		int err = reftable_iterator_next_log(&it, &log);
     ++		if (err < 0) {
     ++			goto done;
     ++		}
     ++
     ++		if (err > 0 || strcmp(log.refname, arg->oldname)) {
     ++			break;
     ++		}
     ++		FREE_AND_NULL(log.refname);
     ++		log.refname = xstrdup(arg->newname);
     ++		reftable_writer_add_log(writer, &log);
     ++		reftable_log_record_release(&log);
     ++	}
     ++
     ++done:
     ++	assert(err != REFTABLE_API_ERROR);
     ++	reftable_ref_record_release(&new_ref);
     ++	reftable_ref_record_release(&old_ref);
     ++	reftable_log_record_release(&log);
     ++	reftable_iterator_destroy(&it);
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +				 const char *oldrefname, const char *newrefname,
      +				 const char *logmsg)
      +{
     -+	BUG("reftable reference store does not support copying references");
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, newrefname);
     ++	struct write_rename_arg arg = {
     ++		.stack = stack,
     ++		.oldname = oldrefname,
     ++		.newname = newrefname,
     ++		.logmsg = logmsg,
     ++	};
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_reload(stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_stack_add(stack, &write_copy_table, &arg);
     ++done:
     ++	assert(err != REFTABLE_API_ERROR);
     ++	return err;
      +}
      +
      +struct git_reftable_reflog_ref_iterator {
     @@ refs/reftable-backend.c (new)
      +
      +		free(ri->last_name);
      +		ri->last_name = xstrdup(ri->log.refname);
     -+		hashcpy(ri->oid.hash, ri->log.update.new_hash);
     ++		oidread(&ri->oid, ri->log.update.new_hash);
      +		return ITER_OK;
      +	}
      +}
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		hashcpy(old_oid.hash, log.update.old_hash);
     -+		hashcpy(new_oid.hash, log.update.new_hash);
     ++		oidread(&old_oid, log.update.old_hash);
     ++		oidread(&new_oid, log.update.new_hash);
      +
      +		full_committer = fmt_ident(log.update.name, log.update.email,
      +					   WANT_COMMITTER_IDENT,
     @@ refs/reftable-backend.c (new)
      +		struct object_id new_oid;
      +		const char *full_committer = "";
      +
     -+		hashcpy(old_oid.hash, log->update.old_hash);
     -+		hashcpy(new_oid.hash, log->update.new_hash);
     ++		oidread(&old_oid, log->update.old_hash);
     ++		oidread(&new_oid, log->update.new_hash);
      +
      +		full_committer = fmt_ident(log->update.name, log->update.email,
      +					   WANT_COMMITTER_IDENT, NULL,
     @@ refs/reftable-backend.c (new)
      +	return 0;
      +}
      +
     -+static int git_reftable_delete_reflog(struct ref_store *ref_store,
     -+				      const char *refname)
     -+{
     -+	return 0;
     -+}
     -+
     -+struct reflog_expiry_arg {
     -+	struct git_reftable_ref_store *refs;
     ++struct write_reflog_delete_arg {
      +	struct reftable_stack *stack;
     -+	struct reftable_log_record *tombstones;
     -+	int len;
     -+	int cap;
     ++	const char *refname;
      +};
      +
     -+static void clear_log_tombstones(struct reflog_expiry_arg *arg)
     ++static int write_reflog_delete_table(struct reftable_writer *writer, void *argv)
      +{
     -+	int i = 0;
     -+	for (; i < arg->len; i++) {
     -+		reftable_log_record_release(&arg->tombstones[i]);
     ++	struct write_reflog_delete_arg *arg = argv;
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(arg->stack);
     ++	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { NULL };
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     ++	int err = reftable_merged_table_seek_log(mt, &it, arg->refname);
     ++
     ++	reftable_writer_set_limits(writer, ts, ts);
     ++	while (err == 0) {
     ++		struct reftable_log_record tombstone = {
     ++			.refname = (char*)arg->refname,
     ++			.update_index = REFTABLE_LOG_DELETION,
     ++		};
     ++		err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
     ++			err = 0;
     ++			break;
     ++		}
     ++
     ++		if (err < 0 || strcmp(log.refname, arg->refname)) {
     ++			break;
     ++		}
     ++		tombstone.update_index = log.update_index;
     ++		err = reftable_writer_add_log(writer, &tombstone);
      +	}
      +
     -+	FREE_AND_NULL(arg->tombstones);
     ++	return err;
      +}
      +
     -+static void add_log_tombstone(struct reflog_expiry_arg *arg,
     -+			      const char *refname, uint64_t ts)
     ++
     ++static int git_reftable_delete_reflog(struct ref_store *ref_store,
     ++				      const char *refname)
      +{
     -+	struct reftable_log_record tombstone = {
     -+		.refname = xstrdup(refname),
     -+		.update_index = ts,
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
     ++	struct write_reflog_delete_arg arg = {
     ++		.stack = stack,
     ++		.refname = refname,
      +	};
     -+	if (arg->len == arg->cap) {
     -+		arg->cap = 2 * arg->cap + 1;
     -+		arg->tombstones =
     -+			realloc(arg->tombstones, arg->cap * sizeof(tombstone));
     -+	}
     -+	arg->tombstones[arg->len++] = tombstone;
     ++	int err = reftable_stack_add(stack, &write_reflog_delete_table, &arg);
     ++	assert(err != REFTABLE_API_ERROR);
     ++	return err;
      +}
      +
     ++struct reflog_expiry_arg {
     ++	struct reftable_stack *stack;
     ++	struct reftable_log_record *records;
     ++	int len;
     ++};
     ++
      +static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
      +{
      +	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
     @@ refs/reftable-backend.c (new)
      +	int i = 0;
      +	reftable_writer_set_limits(writer, ts, ts);
      +	for (i = 0; i < arg->len; i++) {
     -+		int err = reftable_writer_add_log(writer, &arg->tombstones[i]);
     ++		int err = reftable_writer_add_log(writer, &arg->records[i]);
      +		if (err) {
      +			return err;
      +		}
     @@ refs/reftable-backend.c (new)
      +	struct reftable_merged_table *mt = NULL;
      +	struct reflog_expiry_arg arg = {
      +		.stack = stack,
     -+		.refs = refs,
      +	};
     -+	struct reftable_log_record log = { NULL };
     ++	struct reftable_log_record *logs = NULL;
     ++	struct reftable_log_record *rewritten = NULL;
     ++	int logs_len = 0;
     ++	int logs_cap = 0;
     ++	int i = 0;
     ++	uint8_t *last_hash = NULL;
      +	struct reftable_iterator it = { NULL };
     ++	struct reftable_addition *add = NULL;
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
     @@ refs/reftable-backend.c (new)
      +		goto done;
      +	}
      +
     ++	err = reftable_stack_new_addition(&add, stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++	prepare_fn(refname, oid, policy_cb_data);
      +	while (1) {
     -+		struct object_id ooid;
     -+		struct object_id noid;
     -+
     ++		struct reftable_log_record log = {NULL};
      +		int err = reftable_iterator_next_log(&it, &log);
      +		if (err < 0) {
      +			goto done;
     @@ refs/reftable-backend.c (new)
      +		if (err > 0 || strcmp(log.refname, refname)) {
      +			break;
      +		}
     -+		hashcpy(ooid.hash, log.update.old_hash);
     -+		hashcpy(noid.hash, log.update.new_hash);
      +
     -+		if (should_prune_fn(&ooid, &noid, log.update.email,
     -+				    (timestamp_t)log.update.time,
     -+				    log.update.tz_offset, log.update.message,
     ++		if (logs_len >= logs_cap) {
     ++			int new_cap = logs_cap * 2 + 1;
     ++			logs = realloc(logs, new_cap * sizeof(*logs));
     ++			logs_cap = new_cap;
     ++		}
     ++		logs[logs_len++] = log;
     ++	}
     ++
     ++	rewritten = calloc(logs_len, sizeof(*rewritten));
     ++	for (i = logs_len-1; i >= 0; i--) {
     ++		struct object_id ooid;
     ++		struct object_id noid;
     ++		struct reftable_log_record *dest = &rewritten[i];
     ++
     ++		*dest = logs[i];
     ++		oidread(&ooid, logs[i].update.old_hash);
     ++		oidread(&noid, logs[i].update.new_hash);
     ++
     ++		if (should_prune_fn(&ooid, &noid, logs[i].update.email,
     ++				    (timestamp_t)logs[i].update.time,
     ++				    logs[i].update.tz_offset, logs[i].update.message,
      +				    policy_cb_data)) {
     -+			add_log_tombstone(&arg, refname, log.update_index);
     ++			dest->value_type = REFTABLE_LOG_DELETION;
     ++		} else {
     ++			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash != NULL) {
     ++				dest->update.old_hash = last_hash;
     ++			}
     ++			last_hash = logs[i].update.new_hash;
      +		}
      +	}
     -+	err = reftable_stack_add(stack, &write_reflog_expiry_table, &arg);
     ++
     ++	arg.records = rewritten;
     ++	arg.len = logs_len;
     ++	err = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
     ++		/* XXX - skip writing records that were not changed. */
     ++		err = reftable_addition_commit(add);
     ++	} else {
     ++		/* XXX - print something */
     ++	}
      +
      +done:
     ++	if (add) {
     ++		cleanup_fn(policy_cb_data);
     ++	}
      +	assert(err != REFTABLE_API_ERROR);
     -+	reftable_log_record_release(&log);
     ++	reftable_addition_destroy(add);
     ++	for (i = 0; i < logs_len; i++)
     ++		reftable_log_record_release(&logs[i]);
     ++	free(logs);
     ++	free(rewritten);
      +	reftable_iterator_destroy(&it);
     -+	clear_log_tombstones(&arg);
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +		strbuf_addstr(referent, ref.value.symref);
      +		*type |= REF_ISSYMREF;
      +	} else if (reftable_ref_record_val1(&ref) != NULL) {
     -+		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
     ++		oidread(oid, reftable_ref_record_val1(&ref));
      +	} else {
      +		*type |= REF_ISBROKEN;
      +		errno = EINVAL;
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
      +				xstrdup_or_null(repo_fmt.ref_storage);
      +		}
       	}
     - 
     - 	strbuf_release(&dir);
     + 	/*
     + 	 * Since precompose_string_if_needed() needs to look at
      
       ## t/t0031-reftable.sh (new) ##
      @@
     @@ t/t0031-reftable.sh (new)
      +	mv .git/hooks .git/hooks-disabled
      +}
      +
     ++write_script fake_editor <<\EOF
     ++echo "$MSG" >"$1"
     ++echo "$MSG" >&2
     ++EOF
     ++GIT_EDITOR=./fake_editor
     ++export GIT_EDITOR
     ++
     ++test_expect_success 'read existing old OID if REF_HAVE_OLD is not set' '
     ++	initialize &&
     ++	test_commit 1st &&
     ++	test_commit 2nd &&
     ++	MSG=b4 git notes add &&
     ++	MSG=b3 git notes edit  &&
     ++	echo b4 >expect &&
     ++	git notes --ref commits@{1} show >actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git reflog delete' '
     ++	initialize &&
     ++	test_commit file &&
     ++	test_commit file2 &&
     ++	test_commit file3 &&
     ++	test_commit file4 &&
     ++	git reflog delete HEAD@{1} &&
     ++	git reflog > output &&
     ++	! grep file3 output
     ++'
     ++
     ++test_expect_success 'branch -D delete nonexistent branch' '
     ++	initialize &&
     ++	test_commit file &&
     ++	test_must_fail git branch -D ../../my-private-file
     ++'
     ++
     ++test_expect_success 'branch copy' '
     ++	initialize &&
     ++	test_commit file1 &&
     ++	test_commit file2 &&
     ++	git branch src &&
     ++	git reflog src > expect &&
     ++	git branch -c src dst &&
     ++	git reflog dst | sed "s/dst/src/g" > actual &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'git stash' '
     ++	initialize &&
     ++	test_commit file &&
     ++	touch actual expected &&
     ++	git -c status.showStash=true status >expected &&
     ++	echo hoi >> file.t &&
     ++	git stash push -m stashed &&
     ++	git stash clear &&
     ++	git -c status.showStash=true status >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'rename branch' '
     ++	initialize &&
     ++	git symbolic-ref HEAD refs/heads/before &&
     ++	test_commit file &&
     ++	git show-ref | sed s/before/after/g > expected &&
     ++	git branch -M after &&
     ++	git show-ref > actual &&
     ++	test_cmp expected actual
     ++'
     ++
      +test_expect_success 'SHA256 support, env' '
      +	rm -rf .git &&
      +	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
 19:  b2fa6ea62c16 = 24:  742d716e4510 git-prompt: prepare for reftable refs backend
 20:  39e644b9436b ! 25:  aca82763e72c Add "test-tool dump-reftable" command.
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
       
       REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
     @@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
       REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
      
     - ## reftable/dump.c ##
     -@@ reftable/dump.c: license that can be found in the LICENSE file or at
     - #include <unistd.h>
     - #include <string.h>
     - 
     --#include "reftable.h"
     -+#include "reftable-blocksource.h"
     -+#include "reftable-error.h"
     -+#include "reftable-merged.h"
     -+#include "reftable-record.h"
     - #include "reftable-tests.h"
     -+#include "reftable-writer.h"
     -+#include "reftable-iterator.h"
     -+#include "reftable-reader.h"
     -+#include "reftable-stack.h"
     - 
     - static uint32_t hash_id;
     - 
     - static int dump_table(const char *tablename)
     - {
     --	struct reftable_block_source src = { 0 };
     -+	struct reftable_block_source src = { NULL };
     - 	int err = reftable_block_source_from_file(&src, tablename);
     --	struct reftable_iterator it = { 0 };
     --	struct reftable_ref_record ref = { 0 };
     --	struct reftable_log_record log = { 0 };
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	struct reftable_log_record log = { NULL };
     - 	struct reftable_reader *r = NULL;
     - 
     - 	if (err < 0)
     -@@ reftable/dump.c: static int dump_table(const char *tablename)
     - 		reftable_ref_record_print(&ref, hash_id);
     - 	}
     - 	reftable_iterator_destroy(&it);
     --	reftable_ref_record_clear(&ref);
     -+	reftable_ref_record_release(&ref);
     - 
     - 	err = reftable_reader_seek_log(r, &it, "");
     - 	if (err < 0) {
     -@@ reftable/dump.c: static int dump_table(const char *tablename)
     - 		reftable_log_record_print(&log, hash_id);
     - 	}
     - 	reftable_iterator_destroy(&it);
     --	reftable_log_record_clear(&log);
     -+	reftable_log_record_release(&log);
     - 
     - 	reftable_reader_free(r);
     - 	return 0;
     -@@ reftable/dump.c: static int dump_table(const char *tablename)
     - static int compact_stack(const char *stackdir)
     - {
     - 	struct reftable_stack *stack = NULL;
     --	struct reftable_write_options cfg = {};
     -+	struct reftable_write_options cfg = { 0 };
     - 
     - 	int err = reftable_new_stack(&stack, stackdir, cfg);
     - 	if (err < 0)
     -@@ reftable/dump.c: static int compact_stack(const char *stackdir)
     - static int dump_stack(const char *stackdir)
     - {
     - 	struct reftable_stack *stack = NULL;
     --	struct reftable_write_options cfg = {};
     --	struct reftable_iterator it = { 0 };
     --	struct reftable_ref_record ref = { 0 };
     --	struct reftable_log_record log = { 0 };
     -+	struct reftable_write_options cfg = { 0 };
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	struct reftable_log_record log = { NULL };
     - 	struct reftable_merged_table *merged = NULL;
     - 
     - 	int err = reftable_new_stack(&stack, stackdir, cfg);
     -@@ reftable/dump.c: static int dump_stack(const char *stackdir)
     - 		reftable_ref_record_print(&ref, hash_id);
     - 	}
     - 	reftable_iterator_destroy(&it);
     --	reftable_ref_record_clear(&ref);
     -+	reftable_ref_record_release(&ref);
     - 
     - 	err = reftable_merged_table_seek_log(merged, &it, "");
     - 	if (err < 0) {
     -@@ reftable/dump.c: static int dump_stack(const char *stackdir)
     - 		reftable_log_record_print(&log, hash_id);
     - 	}
     - 	reftable_iterator_destroy(&it);
     --	reftable_log_record_clear(&log);
     -+	reftable_log_record_release(&log);
     - 
     - 	reftable_stack_destroy(stack);
     - 	return 0;
     -@@ reftable/dump.c: static void print_help(void)
     - int reftable_dump_main(int argc, char *const *argv)
     - {
     - 	int err = 0;
     --	int opt;
     - 	int opt_dump_table = 0;
     - 	int opt_dump_stack = 0;
     - 	int opt_compact = 0;
     --	const char *arg = NULL;
     --	while ((opt = getopt(argc, argv, "2chts")) != -1) {
     --		switch (opt) {
     --		case '2':
     --			hash_id = 0x73323536;
     -+	const char *arg = NULL, *argv0 = argv[0];
     -+
     -+	for (; argc > 1; argv++, argc--)
     -+		if (*argv[1] != '-')
     - 			break;
     --		case 't':
     -+		else if (!strcmp("-2", argv[1]))
     -+			hash_id = 0x73323536;
     -+		else if (!strcmp("-t", argv[1]))
     - 			opt_dump_table = 1;
     --			break;
     --		case 's':
     -+		else if (!strcmp("-s", argv[1]))
     - 			opt_dump_stack = 1;
     --			break;
     --		case 'c':
     -+		else if (!strcmp("-c", argv[1]))
     - 			opt_compact = 1;
     --			break;
     --		case '?':
     --		case 'h':
     -+		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
     - 			print_help();
     - 			return 2;
     --			break;
     - 		}
     --	}
     - 
     --	if (argv[optind] == NULL) {
     -+	if (argc != 2) {
     - 		fprintf(stderr, "need argument\n");
     - 		print_help();
     - 		return 2;
     - 	}
     - 
     --	arg = argv[optind];
     -+	arg = argv[1];
     - 
     - 	if (opt_dump_table) {
     - 		err = dump_table(arg);
     -@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
     - 	}
     - 
     - 	if (err < 0) {
     --		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
     -+		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
     - 			reftable_error_str(err));
     - 		return 1;
     - 	}
     -
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	tree_test_main(argc, argv);
  -:  ------------ > 26:  ae88f41de9a9 t1301: document what needs to be done for REFTABLE
  -:  ------------ > 27:  0c1eb69900a7 t1401,t2011: parameterize HEAD.lock for REFTABLE
  -:  ------------ > 28:  dd8ffbf53157 t1404: annotate test cases with REFFILES

-- 
gitgitgadget
