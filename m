Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DAC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D492610FF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbhIIStB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhIISs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D111CC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n5so3929271wro.12
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=E0+7J3NWEfIXkFcb4lM3JCz3/nwpumDlDlMe4/BudNc=;
        b=RH4NIgSX7YkIZAdVaRyeZfYufZphAosHegUTCyUXOJE78amJVeL/ry9Wb0u9xIXQlg
         yzqYNMCcoxHKTcdhk/bHm6c5gISPC/AnehO82Z0hjFWTN6cR6XHQxbMAv1LKgdMjGCfz
         BgGC0B2kMsnlvenle2jskdGIjKdsSEIxESJUCQgBch1Avw4V2fwGAFUy4cx7DMwOjMpR
         tsxQ6NXldSEnpBpPKbVnDuqnPc7e/o3DpD7Pjl92j1FldqTdTMXg0RCl5echa7EKXkwh
         7dUhZ1jQSRCsQw1qbuZNIBAMUa/YOwscLbMpnFSlxl0eePkvN+EbCbiytW1jjrg6moiY
         qHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=E0+7J3NWEfIXkFcb4lM3JCz3/nwpumDlDlMe4/BudNc=;
        b=DC9HuFuwpfHuZI27FphP292GObvZ4hsQKiNwf0BjHEDt/upu8CrhkO6q5365ePtI2h
         sDYugsFARy12e3Od4lgdrnsIDpRROqlaQiVe0BnlgZE9mhieVbbAeK15bTQTFl0hPgUr
         YPP3mjwM+A7jKSvxIXvwN7+d+KmFgZYP9D21OYzp2IudzoxTy7511OJJWfRW5ZfKWWCi
         p/GwPS8u6yomzF/262Eyeccht3P5zpzgq+r4658wQ9Rpawxtd2oROzlY9jkkQc39tBvc
         +XtFJQNMRY+llgfbn3Hbi424E6paV+XKGGclfvL4lCRJ92TiaB7R3r9KI18kD3bP4ejl
         mNmA==
X-Gm-Message-State: AOAM533EaPMhdYVA1eVvMsgsDv49GgYrxjxDw/Ce/xWhGk92rKcMF9WE
        mwy8q8Vjab06L3039vcpELChGXnaDR0=
X-Google-Smtp-Source: ABdhPJyjMtQrRC63q4jIUSwvNaPr/yZ07enmkF7T71Vs4UKnGTm1uU2Qqy64cYqmVopIL543L644/Q==
X-Received: by 2002:a05:6000:1627:: with SMTP id v7mr5428047wrb.347.1631213266346;
        Thu, 09 Sep 2021 11:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm2566981wru.41.2021.09.09.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:47:46 -0700 (PDT)
Message-Id: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 18:47:25 +0000
Subject: [PATCH v2 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reftable format is described in Documentation/technical/reftable.txt.

This is a fully reentrant implementation of reading and writing the reftable
file format, and should be suitable for embedding in libgit2 too. It does
not hook the code up to git to function as a ref storage backend yet.

v2:

 * fold in OpenBSD fixes by Carlo Belón.

Han-Wen Nienhuys (19):
  hash.h: provide constants for the hash IDs
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
  Add "test-tool dump-reftable" command.

 Makefile                                   |   53 +-
 ci/lib.sh                                  |    1 +
 compat/.gitattributes                      |    1 +
 compat/zlib-uncompress2.c                  |   95 ++
 config.mak.uname                           |    5 +
 configure.ac                               |   13 +
 contrib/buildsystems/CMakeLists.txt        |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 hash.h                                     |    6 +
 object-file.c                              |    7 +-
 reftable/LICENSE                           |   31 +
 reftable/basics.c                          |  128 ++
 reftable/basics.h                          |   60 +
 reftable/basics_test.c                     |   98 ++
 reftable/block.c                           |  439 ++++++
 reftable/block.h                           |  127 ++
 reftable/block_test.c                      |  120 ++
 reftable/blocksource.c                     |  148 +++
 reftable/blocksource.h                     |   22 +
 reftable/constants.h                       |   21 +
 reftable/dump.c                            |  107 ++
 reftable/error.c                           |   41 +
 reftable/generic.c                         |  169 +++
 reftable/generic.h                         |   32 +
 reftable/iter.c                            |  194 +++
 reftable/iter.h                            |   69 +
 reftable/merged.c                          |  362 +++++
 reftable/merged.h                          |   35 +
 reftable/merged_test.c                     |  292 ++++
 reftable/pq.c                              |  105 ++
 reftable/pq.h                              |   33 +
 reftable/pq_test.c                         |   82 ++
 reftable/publicbasics.c                    |   58 +
 reftable/reader.c                          |  801 +++++++++++
 reftable/reader.h                          |   66 +
 reftable/readwrite_test.c                  |  652 +++++++++
 reftable/record.c                          | 1212 +++++++++++++++++
 reftable/record.h                          |  139 ++
 reftable/record_test.c                     |  412 ++++++
 reftable/refname.c                         |  209 +++
 reftable/refname.h                         |   29 +
 reftable/refname_test.c                    |  102 ++
 reftable/reftable-blocksource.h            |   49 +
 reftable/reftable-error.h                  |   62 +
 reftable/reftable-generic.h                |   47 +
 reftable/reftable-iterator.h               |   39 +
 reftable/reftable-malloc.h                 |   18 +
 reftable/reftable-merged.h                 |   72 +
 reftable/reftable-reader.h                 |  101 ++
 reftable/reftable-record.h                 |  114 ++
 reftable/reftable-stack.h                  |  128 ++
 reftable/reftable-tests.h                  |   23 +
 reftable/reftable-writer.h                 |  148 +++
 reftable/reftable.c                        |  115 ++
 reftable/stack.c                           | 1396 ++++++++++++++++++++
 reftable/stack.h                           |   41 +
 reftable/stack_test.c                      |  949 +++++++++++++
 reftable/system.h                          |   32 +
 reftable/test_framework.c                  |   23 +
 reftable/test_framework.h                  |   53 +
 reftable/tree.c                            |   63 +
 reftable/tree.h                            |   34 +
 reftable/tree_test.c                       |   61 +
 reftable/writer.c                          |  690 ++++++++++
 reftable/writer.h                          |   50 +
 t/helper/test-reftable.c                   |   21 +
 t/helper/test-tool.c                       |    4 +-
 t/helper/test-tool.h                       |    2 +
 t/t0032-reftable-unittest.sh               |   15 +
 69 files changed, 10939 insertions(+), 12 deletions(-)
 create mode 100644 compat/.gitattributes
 create mode 100644 compat/zlib-uncompress2.c
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
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1081%2Fhanwen%2Fjust-library-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1081/hanwen/just-library-v2
Pull-Request: https://github.com/git/git/pull/1081

Range-diff vs v1:

  1:  b9ee8cd8e9f =  1:  8534c69cf84 hash.h: provide constants for the hash IDs
  2:  2d31c783fb5 =  2:  52968d8e83f reftable: RFC: add LICENSE
  3:  ea6f4f8c150 =  3:  84c8b396df5 reftable: add error related functionality
  4:  fd5c5c9f338 !  4:  fa58f3d73e7 reftable: utility functions
     @@ Makefile: OBJECTS += $(PROGRAM_OBJS)
       endif
      @@ Makefile: $(LIB_FILE): $(LIB_OBJS)
       $(XDIFF_LIB): $(XDIFF_OBJS)
     - 	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
     + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
       
      +$(REFTABLE_LIB): $(REFTABLE_OBJS)
      +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     @@ reftable/system.h (new)
      +
      +#include <zlib.h>
      +
     -+struct strbuf;
     ++#ifdef NO_UNCOMPRESS2
     ++/*
     ++ * This is uncompress2, which is only available in zlib >= 1.2.9
     ++ * (released as of early 2017)
     ++ */
     ++int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
     ++		uLong *sourceLen);
     ++#endif
     ++
      +int hash_size(uint32_t id);
      +
      +#endif
  5:  c11f06ed6fb =  5:  e9206532126 reftable: add blocksource, an abstraction for random access reads
  6:  23977331cf8 =  6:  651e195fe77 reftable: (de)serialization for the polymorphic record type.
  7:  aa9b8e05dbd !  7:  e595dbc6c84 Provide zlib's uncompress2 from compat/zlib-compat.c
     @@ compat/zlib-uncompress2.c (new)
      +
      +*/
      +
     ++#include "../reftable/system.h"
     ++#define z_const
     ++
      +/*
      + * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
      + * For conditions of distribution and use, see copyright notice in zlib.h
     @@ config.mak.uname: ifeq ($(uname_S),FreeBSD)
       endif
       ifeq ($(uname_S),OpenBSD)
      +	NO_UNCOMPRESS2 = YesPlease
     ++	# Versions < 7.0 need compatibility layer
     ++	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
     ++		NO_UNCOMPRESS2 = UnfortunatelyYes
     ++	endif
       	NO_STRCASESTR = YesPlease
       	NO_MEMMEM = YesPlease
       	USE_ST_TIMESPEC = YesPlease
  8:  2648e05c510 !  8:  97f7ee04886 reftable: reading/writing blocks
     @@ reftable/block.c (new)
      +#include "system.h"
      +#include <zlib.h>
      +
     -+#ifdef NO_UNCOMPRESS2
     -+/*
     -+ * This is uncompress2, which is only available in zlib >= 1.2.9
     -+ * (released as of early 2017)
     -+ */
     -+int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
     -+		uLong *sourceLen);
     -+#endif
     -+
      +int header_size(int version)
      +{
      +	switch (version) {
  9:  49a9a00465d !  9:  8d2e8be5795 reftable: a generic binary tree implementation
     @@ reftable/tree_test.c (new)
      +{
      +	struct curry *c = arg;
      +	if (c->last) {
     -+		assert(test_compare(c->last, key) < 0);
     ++		EXPECT(test_compare(c->last, key) < 0);
      +	}
      +	c->last = key;
      +}
     @@ reftable/tree_test.c (new)
      +	} while (i != 1);
      +
      +	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
     -+		assert(values + i == nodes[i]->key);
     -+		assert(nodes[i] ==
     ++		EXPECT(values + i == nodes[i]->key);
     ++		EXPECT(nodes[i] ==
      +		       tree_search(values + i, &root, &test_compare, 0));
      +	}
      +
 10:  c00876afd26 = 10:  965af6ec065 reftable: write reftable files
 11:  0f32d6f4c91 = 11:  4e259380fda reftable: generic interface to tables
 12:  a77878993aa = 12:  a43d3512164 reftable: read reftable files
 13:  4bbefe977ae = 13:  f0e159cd853 reftable: reftable file level tests
 14:  7ee46496081 ! 14:  5a5c108d601 reftable: add a heap-based priority queue for reftable records
     @@ reftable/pq.c (new)
      +#include "system.h"
      +#include "basics.h"
      +
     -+static int pq_less(struct pq_entry a, struct pq_entry b)
     ++int pq_less(struct pq_entry *a, struct pq_entry *b)
      +{
      +	struct strbuf ak = STRBUF_INIT;
      +	struct strbuf bk = STRBUF_INIT;
      +	int cmp = 0;
     -+	reftable_record_key(&a.rec, &ak);
     -+	reftable_record_key(&b.rec, &bk);
     ++	reftable_record_key(&a->rec, &ak);
     ++	reftable_record_key(&b->rec, &bk);
      +
      +	cmp = strbuf_cmp(&ak, &bk);
      +
     @@ reftable/pq.c (new)
      +	strbuf_release(&bk);
      +
      +	if (cmp == 0)
     -+		return a.index > b.index;
     ++		return a->index > b->index;
      +
      +	return cmp < 0;
      +}
     @@ reftable/pq.c (new)
      +	return pq.len == 0;
      +}
      +
     -+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
     -+{
     -+	int i = 0;
     -+	for (i = 1; i < pq.len; i++) {
     -+		int parent = (i - 1) / 2;
     -+
     -+		assert(pq_less(pq.heap[parent], pq.heap[i]));
     -+	}
     -+}
     -+
      +struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
      +{
      +	int i = 0;
     @@ reftable/pq.c (new)
      +		int min = i;
      +		int j = 2 * i + 1;
      +		int k = 2 * i + 2;
     -+		if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
     ++		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i])) {
      +			min = j;
      +		}
     -+		if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
     ++		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min])) {
      +			min = k;
      +		}
      +
     @@ reftable/pq.c (new)
      +	i = pq->len - 1;
      +	while (i > 0) {
      +		int j = (i - 1) / 2;
     -+		if (pq_less(pq->heap[j], pq->heap[i])) {
     ++		if (pq_less(&pq->heap[j], &pq->heap[i])) {
      +			break;
      +		}
      +
     @@ reftable/pq.h (new)
      +struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
      +void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
      +void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
     ++int pq_less(struct pq_entry *a, struct pq_entry *b);
      +
      +#endif
      
     @@ reftable/pq_test.c (new)
      +#include "reftable-tests.h"
      +#include "test_framework.h"
      +
     ++void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
     ++{
     ++	int i = 0;
     ++	for (i = 1; i < pq.len; i++) {
     ++		int parent = (i - 1) / 2;
     ++
     ++		assert(pq_less(&pq.heap[parent], &pq.heap[i]));
     ++	}
     ++}
     ++
      +static void test_pq(void)
      +{
      +	char *names[54] = { NULL };
     @@ reftable/pq_test.c (new)
      +		merged_iter_pqueue_check(pq);
      +
      +		if (last) {
     -+			assert(strcmp(last, ref->refname) < 0);
     ++			EXPECT(strcmp(last, ref->refname) < 0);
      +		}
      +		last = ref->refname;
      +		ref->refname = NULL;
 15:  8bc889aaae8 ! 15:  905ffa58f36 reftable: add merged table view
     @@ reftable/merged_test.c (new)
      +	for (i = 0; i < n; i++) {
      +		uint64_t before = refs[i].update_index;
      +		int n = reftable_writer_add_ref(w, &refs[i]);
     -+		assert(n == 0);
     -+		assert(before == refs[i].update_index);
     ++		EXPECT(n == 0);
     ++		EXPECT(before == refs[i].update_index);
      +	}
      +
      +	err = reftable_writer_close(w);
     @@ reftable/merged_test.c (new)
      +	}
      +	reftable_iterator_destroy(&it);
      +
     -+	assert(ARRAY_SIZE(want) == len);
     ++	EXPECT(ARRAY_SIZE(want) == len);
      +	for (i = 0; i < len; i++) {
     -+		assert(reftable_ref_record_equal(&want[i], &out[i],
     ++		EXPECT(reftable_ref_record_equal(&want[i], &out[i],
      +						 GIT_SHA1_RAWSZ));
      +	}
      +	for (i = 0; i < len; i++) {
     @@ reftable/merged_test.c (new)
      +	EXPECT_ERR(err);
      +
      +	hash_id = reftable_reader_hash_id(rd);
     -+	assert(hash_id == GIT_SHA1_FORMAT_ID);
     ++	EXPECT(hash_id == GIT_SHA1_FORMAT_ID);
      +
      +	reftable_table_from_reader(&tab[0], rd);
      +	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 16:  9a30c1c4666 = 16:  e9598889af2 reftable: implement refname validation
 17:  b099c42d65d = 17:  8b0ee68c636 reftable: implement stack, a mutable database of reftable files.
 18:  0170f20b5e7 = 18:  a9bebe45bde reftable: add dump utility
 19:  4fc6b5cbf16 = 19:  104fbc7502f Add "test-tool dump-reftable" command.

-- 
gitgitgadget
