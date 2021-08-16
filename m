Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9138DC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C08760EE4
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHPUR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPURx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:17:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5AC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x12so25264067wrr.11
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9oK443umBrvxG2LMukBRMHQX73Hd16/qNDAWkf6Lhgg=;
        b=l+ZJyNQc8M3H3UWiEI9CmH0SOfD7xCL2SXGiSW3ZK2s185+O8qTQgiJw3n9QzoB6+r
         DxAEwxBnbByCG+GhW2il5D9BnnzVihMdFuTbUvHEb1NhkkkmahkK2+rrBtZYU85F4RbA
         PdnxxZeFW09hjOwrZ88VZ4Hn3o7qdq9b0qpYTgoUttS9rhPwDUbaigwqN6hY7vcazxf5
         M8LEgdwQKNvEw0iInx3Q9+rCj0m2ghRcJ4zcjoEX/11cd6sPqUh93Ev99l84TGOolrv2
         0ZX98iGHBjUW216I4S/B+p0pgAfTggiGbaVBcxABWHGNvjw/SXIhKdvcmxElG8ADT1Fl
         aqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9oK443umBrvxG2LMukBRMHQX73Hd16/qNDAWkf6Lhgg=;
        b=kk6ZoaHBOyunt3THzym/v8CtJGmtKJxkVq1LIctVu0ZR8GU0PzdyU0Ho6tT6G96qLF
         uDL+jxGJtJ4l2DhADlfAD+4D7n50cglMCYUrYBkXFiNNZuiQ0kGTSbgoDGyeJT6idNcX
         kpEiLLNYNYxvNCzaOnmHXGwMAUKsWYe0LHlVH7kK7c85Dq//zHq9jAi1AobPpYIQu9DR
         Ij9iAXaDV3/tzZ79nlaOZkHzwHINHHs6SsB4Ac2W/6pU9o4k5ktj8ybLBCu+HQwE9MJT
         KzoNRte7oeOBaeWCk/OL2lXrRMVP/gP+jZ/4NStGlf95kY7kSfV5X1PtsPjSPGY+6I6D
         8kZg==
X-Gm-Message-State: AOAM530RPbWRcrDW/PfGt9iYnjhcHNtJz0hL4UuewvJMrQI8tyK3OH0F
        p86Ah7bzz/Rxq/uGUyV9GVBpJNNYnA4=
X-Google-Smtp-Source: ABdhPJxTzIYDiB0KGbzV2rw9ZqU8Yl/mfVsy/g8StN3niHSlUsdSPBWPOfY/7OEsAnDTKA249Nc4Kg==
X-Received: by 2002:a5d:6d8f:: with SMTP id l15mr277267wrs.42.1629145039809;
        Mon, 16 Aug 2021 13:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm236032wrt.49.2021.08.16.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:17 -0700 (PDT)
Message-Id: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:16:51 +0000
Subject: [PATCH v2 00/25] Support reftable ref backend for Git
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the work in https://github.com/git/git/pull/847, which the
gitgitgadget erroneously closed.

Changes relative to last series (version 20 Jul 2021, tip: 4a5891f )

 * fix HTTP serving
 * fix t1501 (use absolute paths.)
 * fix git-new-workdir
 * fixes for FreeBSD (thanks, carenas@gmail.com!)

For the 'seen' branch, the following should be applied:

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d7137d1213..9323931eeb 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -108,7 +108,7 @@ static const char *bare_ref_name(const char *ref)
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
                      const char *refname, struct object_id *oid,
                      struct strbuf *referent,
-                     unsigned int *type);
+                     unsigned int *type, int *failure_errno);
 
 static void clear_reftable_log_record(struct reftable_log_record *log)
 {
@@ -425,13 +424,14 @@ static int fixup_symrefs(struct ref_store *ref_store,
     for (i = 0; i < transaction->nr; i++) {
         struct ref_update *update = transaction->updates[i];
         struct object_id old_oid;
+        int failure_errno;
 
         err = git_reftable_read_raw_ref(ref_store, update->refname,
                         &old_oid, &referent,
                         /* mutate input, like
                            files-backend.c */
-                        &update->type);
-        if (err < 0 && errno == ENOENT &&
+                        &update->type, &failure_errno);
+        if (err < 0 && failure_errno == ENOENT &&
             is_null_oid(&update->old_oid)) {
             err = 0;
         }
@@ -1602,7 +1603,7 @@ static int reftable_error_to_errno(int err)
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
                      const char *refname, struct object_id *oid,
                      struct strbuf *referent,
-                     unsigned int *type)
+                     unsigned int *type, int *failure_errno)
 {
     struct git_reftable_ref_store *refs =
         (struct git_reftable_ref_store *)ref_store;
@@ -1626,13 +1627,11 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 
     err = reftable_stack_read_ref(stack, refname, &ref);
     if (err > 0) {
-        errno = ENOENT;
+        *failure_errno = ENOENT;
         err = -1;
         goto done;
     }
     if (err < 0) {
-        errno = reftable_error_to_errno(err);
-        err = -1;
         goto done;
     }


Han-Wen Nienhuys (24):
  hash.h: provide constants for the hash IDs
  init-db: set the_repository->hash_algo early on
  reftable: RFC: add LICENSE
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
  refs: RFC: Reftable support for git-core
  Add "test-tool dump-reftable" command.
  t1301: document what needs to be done for reftable
  t1401,t2011: parameterize HEAD.lock for REFFILES
  t1404: annotate test cases with REFFILES

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   54 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   60 +-
 builtin/stash.c                               |    8 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    8 +-
 ci/lib.sh                                     |    1 +
 compat/.gitattributes                         |    1 +
 compat/zlib-uncompress2.c                     |   92 +
 config.mak.uname                              |    3 +-
 configure.ac                                  |   13 +
 contrib/buildsystems/CMakeLists.txt           |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 contrib/workdir/git-new-workdir               |    2 +-
 hash.h                                        |    6 +
 object-file.c                                 |    7 +-
 refs.c                                        |   26 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1686 +++++++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/basics.c                             |  128 ++
 reftable/basics.h                             |   60 +
 reftable/basics_test.c                        |   98 +
 reftable/block.c                              |  448 +++++
 reftable/block.h                              |  127 ++
 reftable/block_test.c                         |  121 ++
 reftable/blocksource.c                        |  148 ++
 reftable/blocksource.h                        |   22 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  107 ++
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
 reftable/reader.c                             |  801 ++++++++
 reftable/reader.h                             |   66 +
 reftable/readwrite_test.c                     |  651 +++++++
 reftable/record.c                             | 1200 ++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  408 ++++
 reftable/refname.c                            |  209 ++
 reftable/refname.h                            |   29 +
 reftable/refname_test.c                       |  102 +
 reftable/reftable-blocksource.h               |   49 +
 reftable/reftable-error.h                     |   62 +
 reftable/reftable-generic.h                   |   47 +
 reftable/reftable-iterator.h                  |   39 +
 reftable/reftable-malloc.h                    |   18 +
 reftable/reftable-merged.h                    |   72 +
 reftable/reftable-reader.h                    |  101 +
 reftable/reftable-record.h                    |  114 ++
 reftable/reftable-stack.h                     |  128 ++
 reftable/reftable-tests.h                     |   23 +
 reftable/reftable-writer.h                    |  148 ++
 reftable/reftable.c                           |  115 ++
 reftable/stack.c                              | 1396 ++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  947 +++++++++
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
 setup.c                                       |    8 +
 t/helper/test-reftable.c                      |   21 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  316 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1301-shared-repo.sh                        |    8 +-
 t/t1401-symbolic-ref.sh                       |   11 +-
 t/t1404-update-ref-errors.sh                  |   56 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t2011-checkout-invalid-head.sh              |   11 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    7 +-
 94 files changed, 13156 insertions(+), 62 deletions(-)
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


base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1054%2Fhanwen%2Flibreftable-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1054/hanwen/libreftable-v2
Pull-Request: https://github.com/git/git/pull/1054

Range-diff vs v1:

  1:  dc24dccf041 =  1:  c40393e83e1 hash.h: provide constants for the hash IDs
  2:  f1167669848 =  2:  49dffeeae58 init-db: set the_repository->hash_algo early on
  3:  76c2a1005da =  3:  dba354eca12 reftable: RFC: add LICENSE
  4:  616d6ed89ee =  4:  75864034af2 reftable: add error related functionality
  5:  9d2cdfe3ddd =  5:  eabb25d95b3 reftable: utility functions
  6:  5ef4b7040a3 =  6:  ad54d17f84b reftable: add blocksource, an abstraction for random access reads
  7:  13a5cbef0df !  7:  282d8e4d817 reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record_test.c (new)
      +
      +static void test_reftable_log_record_roundtrip(void)
      +{
     ++	int i;
      +	struct reftable_log_record in[2] = {
      +		{
      +			.refname = xstrdup("refs/heads/master"),
     @@ reftable/record_test.c (new)
      +	};
      +	set_test_hash(in[0].update.new_hash, 1);
      +	set_test_hash(in[0].update.old_hash, 2);
     -+	for (int i = 0; i < ARRAY_SIZE(in); i++) {
     ++	for (i = 0; i < ARRAY_SIZE(in); i++) {
      +		struct reftable_record rec = { NULL };
      +		struct strbuf key = STRBUF_INIT;
      +		uint8_t buffer[1024] = { 0 };
  8:  27abd159658 !  8:  893ee4ca21b Provide zlib's uncompress2 from compat/zlib-compat.c
     @@ Commit message
      
          This will be needed for reading reflog blocks in reftable.
      
     +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     @@ Makefile: ifdef NO_DEFLATE_BOUND
       
      +ifdef NO_UNCOMPRESS2
      +	BASIC_CFLAGS += -DNO_UNCOMPRESS2
     -+	LIB_OBJS += compat/zlib-uncompress2.o
     ++	REFTABLE_OBJS += compat/zlib-uncompress2.o
      +endif
      +
       ifdef NO_POSIX_GOODIES
     @@ compat/zlib-uncompress2.c (new)
      +           err;
      +}
      
     + ## config.mak.uname ##
     +@@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
     + 	FILENO_IS_A_MACRO = UnfortunatelyYes
     + endif
     + ifeq ($(uname_S),OpenBSD)
     ++	NO_UNCOMPRESS2 = YesPlease
     + 	NO_STRCASESTR = YesPlease
     + 	NO_MEMMEM = YesPlease
     + 	USE_ST_TIMESPEC = YesPlease
     +
       ## configure.ac ##
      @@ configure.ac: AC_LINK_IFELSE([ZLIBTEST_SRC],
       	NO_DEFLATE_BOUND=yes])
  9:  25aa2bf9b71 !  9:  e4da0a2ef37 reftable: reading/writing blocks
     @@ reftable/block.c (new)
      +#include <zlib.h>
      +
      +#ifdef NO_UNCOMPRESS2
     -+/* This is uncompress2, which is only available in zlib as of 2017.
     ++/*
     ++ * This is uncompress2, which is only available in zlib >= 1.2.9
     ++ * (released as of early 2017)
      + */
      +int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
      +		uLong *sourceLen);
 10:  92970da9cb9 = 10:  0f325881389 reftable: a generic binary tree implementation
 11:  3b817f37a01 = 11:  26cbc468f1f reftable: write reftable files
 12:  99708f408b0 = 12:  69129fca086 reftable: generic interface to tables
 13:  fa9d3b95fd4 = 13:  22599d785b7 reftable: read reftable files
 14:  3eeefa5665f ! 14:  45565bfb9c4 reftable: reftable file level tests
     @@ reftable/readwrite_test.c (new)
      +		.block_size = 4096,
      +	};
      +	int err;
     ++	int i;
      +	struct reftable_log_record log = { .refname = "refs/heads/master",
      +					   .update_index = 0xa,
      +					   .value_type = REFTABLE_LOG_UPDATE,
     @@ reftable/readwrite_test.c (new)
      +	   hash, to ensure that the compressed part is larger than the original.
      +	*/
      +	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
     -+	for (int i = 0; i < GIT_SHA1_RAWSZ; i++) {
     ++	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
      +		hash1[i] = (uint8_t)(rand() % 256);
      +		hash2[i] = (uint8_t)(rand() % 256);
      +	}
 15:  4d7745e6552 = 15:  57b3e709c3e reftable: add a heap-based priority queue for reftable records
 16:  c906d79b341 = 16:  f834cc5299f reftable: add merged table view
 17:  806c2e04392 = 17:  15799d93ff7 reftable: implement refname validation
 18:  67f1282469d = 18:  b7728ceaef2 reftable: implement stack, a mutable database of reftable files.
 19:  05e46f7e1d8 ! 19:  0f682be20bd reftable: add dump utility
     @@ Commit message
          inspecting a complete ref database
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
       ## reftable/dump.c (new) ##
      @@
     @@ reftable/dump.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     ++#include "git-compat-util.h"
     ++#include "hash.h"
     ++
      +#include "reftable-blocksource.h"
      +#include "reftable-error.h"
      +#include "reftable-merged.h"
     @@ reftable/dump.c (new)
      +#include "reftable-reader.h"
      +#include "reftable-stack.h"
      +#include "reftable-generic.h"
     -+#include "hash.h"
      +
      +#include <stddef.h>
      +#include <stdio.h>
 20:  d1d4b2f9e9b ! 20:  754085752f4 refs: RFC: Reftable support for git-core
     @@ contrib/buildsystems/Generators/Vcxproj.pm: EOM
               print F << "EOM";
           <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
      
     + ## contrib/workdir/git-new-workdir ##
     +@@ contrib/workdir/git-new-workdir: trap cleanup $siglist
     + # create the links to the original repo.  explicitly exclude index, HEAD and
     + # logs/HEAD from the list since they are purely related to the current working
     + # directory, and should not be shared.
     +-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
     ++for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn reftable
     + do
     + 	# create a containing directory if needed
     + 	case $x in
     +
       ## refs.c ##
      @@
       #include "repository.h"
     @@ refs/reftable-backend.c (new)
      +		.hash_id = the_hash_algo->format_id,
      +	};
      +	struct strbuf sb = STRBUF_INIT;
     -+	const char *gitdir = path;
     ++	struct strbuf gitdir = STRBUF_INIT;
      +	struct strbuf wt_buf = STRBUF_INIT;
      +	int wt = 0;
      +
     @@ refs/reftable-backend.c (new)
      +	 * backend, leading to infinite recursion.  */
      +	wt = is_worktree(&wt_buf);
      +	if (wt) {
     -+		gitdir = wt_buf.buf;
     ++		strbuf_addbuf(&gitdir, &wt_buf);
     ++	} else {
     ++		strbuf_realpath(&gitdir, path, /*die_on_error=*/0);
      +	}
      +
      +	base_ref_store_init(ref_store, &refs_be_reftable);
     -+	ref_store->gitdir = xstrdup(gitdir);
     ++	ref_store->gitdir = xstrdup(gitdir.buf);
      +	refs->store_flags = store_flags;
     -+	strbuf_addf(&sb, "%s/reftable", gitdir);
     ++	strbuf_addf(&sb, "%s/reftable", gitdir.buf);
      +	refs->reftable_dir = xstrdup(sb.buf);
      +	strbuf_reset(&sb);
      +
     @@ refs/reftable-backend.c (new)
      +
      +	strbuf_release(&sb);
      +	strbuf_release(&wt_buf);
     ++	strbuf_release(&gitdir);
      +	return ref_store;
      +}
      +
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
       		}
       	}
       	/*
     +@@ setup.c: void check_repository_format(struct repository_format *fmt)
     + 	repo_set_hash_algo(the_repository, fmt->hash_algo);
     + 	the_repository->repository_format_partial_clone =
     + 		xstrdup_or_null(fmt->partial_clone);
     ++	/* XXX why is repo->ref_storage_format set in multiple places?! */
     ++	the_repository->ref_storage_format = xstrdup_or_null(fmt->ref_storage);
     + 	clear_repository_format(&repo_fmt);
     + }
     + 
      
       ## t/t0031-reftable.sh (new) ##
      @@
     @@ t/t0031-reftable.sh (new)
      +	test_cmp expect actual
      +'
      +
     ++. "$TEST_DIRECTORY"/lib-httpd.sh
     ++start_httpd
     ++
     ++REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
     ++
     ++test_expect_success 'serving ls-remote' '
     ++	GIT_TEST_REFTABLE=1 git init -b main "$REPO" &&
     ++	cd "$REPO" &&
     ++	test_commit m1 &&
     ++	>.git/git-daemon-export-ok &&
     ++	git ls-remote "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" | cut -f 2-2 -d "	" >actual &&
     ++	cat << EOF >expect &&
     ++HEAD
     ++refs/heads/main
     ++refs/tags/m1
     ++EOF
     ++	test_cmp actual expect
     ++'
     ++
      +test_done
      
       ## t/t1409-avoid-packing-refs.sh ##
 21:  7541a4b8d6d = 21:  79c4b90d0f4 git-prompt: prepare for reftable refs backend
 22:  3c9c3a2d56d ! 22:  1f48091e549 Add "test-tool dump-reftable" command.
     @@ t/t0031-reftable.sh: test_expect_success 'FETCH_HEAD' '
      +	test-tool dump-reftable $(test "${hash_id}" = "sha256" && echo "-6") -s .git/reftable
      +'
      +
     - test_done
     + . "$TEST_DIRECTORY"/lib-httpd.sh
     + start_httpd
     + 
 23:  73eece0caac = 23:  64dc87746db t1301: document what needs to be done for reftable
 24:  d895736f0e1 = 24:  c248b69c6e3 t1401,t2011: parameterize HEAD.lock for REFFILES
 25:  f0a528b9ece = 25:  9f1b792459e t1404: annotate test cases with REFFILES
 26:  4a5891fa8cc <  -:  ----------- t7004: avoid direct filesystem access

-- 
gitgitgadget
