Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC1C47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF75207FB
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huci95KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgJAQLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgJAQLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:11:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9C4C0613E2
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 09:11:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d4so3489767wmd.5
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BbNKGcLrOFRLZMx5bWHxxnb2Lv0mtPglvvWMd4rdljk=;
        b=Huci95KVYRgZxHnvv231J2zOrZ4RY3YBEY6LITBpHG5drfuMKoCZqKsv4Da9LnQVGn
         hhq2z0OwBrVTEmMykMkK0OBarqEihi26rwHbzq1wRcG/pNR8FQknyrNjT66V9ihKD2wS
         EQv0udQhnUOeTFHajkFWeUT5jgRSq4tdjTDTEc4VthLPgalL18POlx2GhQ/E/GJfu9u6
         VR83arrZUNDmGE0iFPW9FCglkBRV2nPq3XMxvJq0sKwbast9C7INF7wSOHNeX30URV0r
         YInguerydqLPakt+WsxZjoA9FrZqyK5mlIeVlVkEIK2eYL/RZHELGorU7i1vkoit01Uz
         tbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BbNKGcLrOFRLZMx5bWHxxnb2Lv0mtPglvvWMd4rdljk=;
        b=L9TbQdkEBCd0KB5z+YRbDD3d7ejHdcwoUOZ0A8u764h0N3/XA+N4K40EHD2Q3CXT7p
         8/qc4IzyoE+tfGExgOUtjHcSszlAymfZXOi+bzCr4bdBM2DfBW471I2v09PcNgMe2Oyi
         zQatUHuBdNZmeXjejS5+4cdFossrnvH1Y1PmX2gUzzdgccLqpWPkfE84+ZiEKzgCaKu0
         MljsMNi2irB+R5i0j9un6RZJenjDckb4JFhmKr3+2Dev9dwKJMjzd4uhmIONvVCW/gWx
         qNsei7krYR0Howfkzg290cfBydnysBF2RQ+FafDRhcYXoS6KqcrhICEyY5RURziVYJwm
         bv0w==
X-Gm-Message-State: AOAM533La7cpu4U5ZgU6ZheZsXuOucCHNknfEeEnfZOuYhyzqZtRrDei
        40X9gsmRNLKZoMKjDRtrsPhBXNhs1sM=
X-Google-Smtp-Source: ABdhPJyq/K96x0FDwdwgJeHITdKQX90Joan/dWegK2jEwbhTpEleN9S2Riw6uTz/SYTGVQl9psnEWQ==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr789361wme.18.1601568666232;
        Thu, 01 Oct 2020 09:11:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h76sm667634wme.10.2020.10.01.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 09:11:05 -0700 (PDT)
Message-Id: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Oct 2020 16:10:50 +0000
Subject: [PATCH v2 00/13] reftable library
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from 
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

The final commit should also be split up, but I want to wait until we have
consensus that the bottom commits look good.

Han-Wen Nienhuys (12):
  reftable: add LICENSE
  reftable: define the public API
  reftable: add a barebones unittest framework
  reftable: utility functions
  reftable: (de)serialization for the polymorphic record type.
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: read reftable files
  reftable: file level tests
  reftable: rest of library
  reftable: "test-tool dump-reftable" command.

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 Makefile                                   |   46 +-
 config.mak.uname                           |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 reftable/.gitattributes                    |    1 +
 reftable/LICENSE                           |   31 +
 reftable/VERSION                           |    1 +
 reftable/basics.c                          |  131 +++
 reftable/basics.h                          |   48 +
 reftable/block.c                           |  441 +++++++
 reftable/block.h                           |  129 ++
 reftable/block_test.c                      |  158 +++
 reftable/blocksource.c                     |  148 +++
 reftable/blocksource.h                     |   22 +
 reftable/compat.c                          |  110 ++
 reftable/compat.h                          |   48 +
 reftable/constants.h                       |   21 +
 reftable/dump.c                            |  212 ++++
 reftable/iter.c                            |  242 ++++
 reftable/iter.h                            |   72 ++
 reftable/merged.c                          |  358 ++++++
 reftable/merged.h                          |   36 +
 reftable/merged_test.c                     |  331 ++++++
 reftable/pq.c                              |  115 ++
 reftable/pq.h                              |   32 +
 reftable/publicbasics.c                    |  100 ++
 reftable/reader.c                          |  733 ++++++++++++
 reftable/reader.h                          |   78 ++
 reftable/record.c                          | 1116 ++++++++++++++++++
 reftable/record.h                          |  137 +++
 reftable/record_test.c                     |  410 +++++++
 reftable/refname.c                         |  209 ++++
 reftable/refname.h                         |   28 +
 reftable/refname_test.c                    |  100 ++
 reftable/reftable-tests.h                  |   22 +
 reftable/reftable.c                        |  104 ++
 reftable/reftable.h                        |  585 +++++++++
 reftable/reftable_test.c                   |  585 +++++++++
 reftable/stack.c                           | 1240 ++++++++++++++++++++
 reftable/stack.h                           |   40 +
 reftable/stack_test.c                      |  788 +++++++++++++
 reftable/strbuf.c                          |  142 +++
 reftable/strbuf.h                          |   80 ++
 reftable/strbuf_test.c                     |   37 +
 reftable/system.h                          |   51 +
 reftable/test_framework.c                  |   68 ++
 reftable/test_framework.h                  |   59 +
 reftable/tree.c                            |   63 +
 reftable/tree.h                            |   34 +
 reftable/tree_test.c                       |   62 +
 reftable/update.sh                         |   22 +
 reftable/writer.c                          |  673 +++++++++++
 reftable/writer.h                          |   51 +
 reftable/zlib-compat.c                     |   92 ++
 t/helper/test-reftable.c                   |   20 +
 t/helper/test-tool.c                       |    2 +
 t/helper/test-tool.h                       |    2 +
 56 files changed, 10474 insertions(+), 5 deletions(-)
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/publicbasics.c
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
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/strbuf.c
 create mode 100644 reftable/strbuf.h
 create mode 100644 reftable/strbuf_test.c
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


base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v2
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v1:

  1:  f697eac228 =  1:  6228103b4a reftable: add LICENSE
  2:  e2dbc84833 =  2:  5d1b946ab5 reftable: define the public API
  3:  0f6efc065c =  3:  01a669a731 vcxproj: adjust for the reftable changes
  4:  7bf59d491d !  4:  b94c5f5c61 reftable: add a barebones unittest framework
     @@ reftable/test_framework.c (new)
      +#include "system.h"
      +#include "basics.h"
      +
     -+struct test_case **test_cases;
     -+int test_case_len;
     -+int test_case_cap;
     ++static struct test_case **test_cases;
     ++static int test_case_len;
     ++static int test_case_cap;
      +
     -+struct test_case *new_test_case(const char *name, void (*testfunc)(void))
     ++static struct test_case *new_test_case(const char *name, void (*testfunc)(void))
      +{
      +	struct test_case *tc = reftable_malloc(sizeof(struct test_case));
      +	tc->name = name;
     @@ reftable/test_framework.c (new)
      +		reftable_free(test_cases[i]);
      +	}
      +	reftable_free(test_cases);
     -+	test_cases = 0;
     ++	test_cases = NULL;
      +	test_case_len = 0;
      +	test_case_cap = 0;
      +	return 0;
     @@ reftable/test_framework.h (new)
      +	void (*testfunc)(void);
      +};
      +
     -+struct test_case *new_test_case(const char *name, void (*testfunc)(void));
      +struct test_case *add_test_case(const char *name, void (*testfunc)(void));
      +int test_main(int argc, const char *argv[]);
      +
  5:  570a8c4bca !  5:  4190da597e reftable: utility functions
     @@ reftable/blocksource.c (new)
      +	return ((struct strbuf *)b)->len;
      +}
      +
     -+struct reftable_block_source_vtable strbuf_vtable = {
     ++static struct reftable_block_source_vtable strbuf_vtable = {
      +	.size = &strbuf_size,
      +	.read_block = &strbuf_read_block,
      +	.return_block = &strbuf_return_block,
     @@ reftable/blocksource.c (new)
      +	reftable_free(dest->data);
      +}
      +
     -+struct reftable_block_source_vtable malloc_vtable = {
     ++static struct reftable_block_source_vtable malloc_vtable = {
      +	.return_block = &malloc_return_block,
      +};
      +
     -+struct reftable_block_source malloc_block_source_instance = {
     ++static struct reftable_block_source malloc_block_source_instance = {
      +	.ops = &malloc_vtable,
      +};
      +
     @@ reftable/blocksource.c (new)
      +	return size;
      +}
      +
     -+struct reftable_block_source_vtable file_vtable = {
     ++static struct reftable_block_source_vtable file_vtable = {
      +	.size = &file_size,
      +	.read_block = &file_read_block,
      +	.return_block = &file_return_block,
     @@ reftable/publicbasics.c (new)
      +	}
      +}
      +
     -+void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
     -+void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
     -+void (*reftable_free_ptr)(void *) = &free;
     ++static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
     ++static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
     ++static void (*reftable_free_ptr)(void *) = &free;
      +
      +void *reftable_malloc(size_t sz)
      +{
  6:  791f69c000 !  6:  8eb944ea9b reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record.c (new)
      +		(const struct reftable_ref_record *)p);
      +}
      +
     -+struct reftable_record_vtable reftable_ref_record_vtable = {
     ++static struct reftable_record_vtable reftable_ref_record_vtable = {
      +	.key = &reftable_ref_record_key,
      +	.type = BLOCK_TYPE_REF,
      +	.copy_from = &reftable_ref_record_copy_from,
     @@ reftable/record.c (new)
      +	return 0;
      +}
      +
     -+struct reftable_record_vtable reftable_obj_record_vtable = {
     ++static struct reftable_record_vtable reftable_obj_record_vtable = {
      +	.key = &reftable_obj_record_key,
      +	.type = BLOCK_TYPE_OBJ,
      +	.copy_from = &reftable_obj_record_copy_from,
     @@ reftable/record.c (new)
      +		(const struct reftable_log_record *)p);
      +}
      +
     -+struct reftable_record_vtable reftable_log_record_vtable = {
     ++static struct reftable_record_vtable reftable_log_record_vtable = {
      +	.key = &reftable_log_record_key,
      +	.type = BLOCK_TYPE_LOG,
      +	.copy_from = &reftable_log_record_copy_from,
     @@ reftable/record.c (new)
      +	return rec;
      +}
      +
     -+void *reftable_record_yield(struct reftable_record *rec)
     ++/* clear out the record, yielding the reftable_record data that was
     ++ * encapsulated. */
     ++static void *reftable_record_yield(struct reftable_record *rec)
      +{
      +	void *p = rec->data;
      +	rec->data = NULL;
     @@ reftable/record.c (new)
      +	return start.len - in.len;
      +}
      +
     -+struct reftable_record_vtable reftable_index_record_vtable = {
     ++static struct reftable_record_vtable reftable_index_record_vtable = {
      +	.key = &reftable_index_record_key,
      +	.type = BLOCK_TYPE_INDEX,
      +	.copy_from = &reftable_index_record_copy_from,
     @@ reftable/record.h (new)
      +/* creates a malloced record of the given type. Dispose with record_destroy */
      +struct reftable_record reftable_new_record(uint8_t typ);
      +
     -+extern struct reftable_record_vtable reftable_ref_record_vtable;
     -+
      +/* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
      +   number of bytes written. */
      +int reftable_encode_key(int *is_restart, struct string_view dest,
     @@ reftable/record.h (new)
      +/* zeroes out the embedded record */
      +void reftable_record_clear(struct reftable_record *rec);
      +
     -+/* clear out the record, yielding the reftable_record data that was
     -+ * encapsulated. */
     -+void *reftable_record_yield(struct reftable_record *rec);
     -+
      +/* clear and deallocate embedded record, and zero `rec`. */
      +void reftable_record_destroy(struct reftable_record *rec);
      +
     @@ reftable/record_test.c (new)
      +	int i = 0;
      +
      +	for (i = 0; i <= 3; i++) {
     -+		struct reftable_ref_record in = { 0 };
     ++		struct reftable_ref_record in = { NULL };
      +		struct reftable_ref_record out = {
      +			.refname = xstrdup("old name"),
      +			.value = reftable_calloc(SHA1_SIZE),
      +			.target_value = reftable_calloc(SHA1_SIZE),
      +			.target = xstrdup("old value"),
      +		};
     -+		struct reftable_record rec_out = { 0 };
     ++		struct reftable_record rec_out = { NULL };
      +		struct strbuf key = STRBUF_INIT;
     -+		struct reftable_record rec = { 0 };
     ++		struct reftable_record rec = { NULL };
      +		uint8_t buffer[1024] = { 0 };
      +		struct string_view dest = {
      +			.buf = buffer,
     @@ reftable/record_test.c (new)
      +	set_test_hash(in[0].new_hash, 1);
      +	set_test_hash(in[0].old_hash, 2);
      +	for (int i = 0; i < ARRAY_SIZE(in); i++) {
     -+		struct reftable_record rec = { 0 };
     ++		struct reftable_record rec = { NULL };
      +		struct strbuf key = STRBUF_INIT;
      +		uint8_t buffer[1024] = { 0 };
      +		struct string_view dest = {
     @@ reftable/record_test.c (new)
      +			.email = xstrdup("old@email"),
      +			.message = xstrdup("old message"),
      +		};
     -+		struct reftable_record rec_out = { 0 };
     ++		struct reftable_record rec_out = { NULL };
      +		int n, m, valtype;
      +
      +		reftable_record_from_log(&rec, &in[i]);
     @@ reftable/record_test.c (new)
      +			.buf = buffer,
      +			.len = sizeof(buffer),
      +		};
     -+		struct reftable_record rec = { 0 };
     ++		struct reftable_record rec = { NULL };
      +		struct strbuf key = STRBUF_INIT;
     -+		struct reftable_obj_record out = { 0 };
     -+		struct reftable_record rec_out = { 0 };
     ++		struct reftable_obj_record out = { NULL };
     ++		struct reftable_record rec_out = { NULL };
      +		int n, m;
      +		uint8_t extra;
      +
     @@ reftable/record_test.c (new)
      +		.len = sizeof(buffer),
      +	};
      +	struct strbuf key = STRBUF_INIT;
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	struct reftable_index_record out = { .last_key = STRBUF_INIT };
      +	struct reftable_record out_rec = { NULL };
      +	int n, m;
  7:  1ba8e3eb30 !  7:  757dd30fe2 reftable: reading/writing blocks
     @@ reftable/block.c (new)
      +	abort();
      +}
      +
     -+int block_writer_register_restart(struct block_writer *w, int n, int restart,
     -+				  struct strbuf *key);
     ++static int block_writer_register_restart(struct block_writer *w, int n,
     ++					 int is_restart, struct strbuf *key)
     ++{
     ++	int rlen = w->restart_len;
     ++	if (rlen >= MAX_RESTARTS) {
     ++		is_restart = 0;
     ++	}
     ++
     ++	if (is_restart) {
     ++		rlen++;
     ++	}
     ++	if (2 + 3 * rlen + n > w->block_size - w->next)
     ++		return -1;
     ++	if (is_restart) {
     ++		if (w->restart_len == w->restart_cap) {
     ++			w->restart_cap = w->restart_cap * 2 + 1;
     ++			w->restarts = reftable_realloc(
     ++				w->restarts, sizeof(uint32_t) * w->restart_cap);
     ++		}
     ++
     ++		w->restarts[w->restart_len++] = w->next;
     ++	}
     ++
     ++	w->next += n;
     ++
     ++	strbuf_reset(&w->last_key);
     ++	strbuf_addbuf(&w->last_key, key);
     ++	w->entries++;
     ++	return 0;
     ++}
      +
      +void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size)
     @@ reftable/block.c (new)
      +	return -1;
      +}
      +
     -+int block_writer_register_restart(struct block_writer *w, int n, int is_restart,
     -+				  struct strbuf *key)
     -+{
     -+	int rlen = w->restart_len;
     -+	if (rlen >= MAX_RESTARTS) {
     -+		is_restart = 0;
     -+	}
     -+
     -+	if (is_restart) {
     -+		rlen++;
     -+	}
     -+	if (2 + 3 * rlen + n > w->block_size - w->next)
     -+		return -1;
     -+	if (is_restart) {
     -+		if (w->restart_len == w->restart_cap) {
     -+			w->restart_cap = w->restart_cap * 2 + 1;
     -+			w->restarts = reftable_realloc(
     -+				w->restarts, sizeof(uint32_t) * w->restart_cap);
     -+		}
     -+
     -+		w->restarts[w->restart_len++] = w->next;
     -+	}
     -+
     -+	w->next += n;
     -+
     -+	strbuf_reset(&w->last_key);
     -+	strbuf_addbuf(&w->last_key, key);
     -+	w->entries++;
     -+	return 0;
     -+}
      +
      +int block_writer_finish(struct block_writer *w)
      +{
     @@ reftable/block_test.c (new)
      +	char *names[30];
      +	const int N = ARRAY_SIZE(names);
      +	const int block_size = 1024;
     -+	struct reftable_block block = { 0 };
     ++	struct reftable_block block = { NULL };
      +	struct block_writer bw = {
      +		.last_key = STRBUF_INIT,
      +	};
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_record rec = { NULL };
      +	int i = 0;
      +	int n;
      +	struct block_reader br = { 0 };
  8:  17fb8d050d !  8:  e30a7e0281 reftable: a generic binary tree implementation
     @@ reftable/tree_test.c (new)
      +{
      +	struct tree_node *root = NULL;
      +
     -+	void *values[11] = { 0 };
     -+	struct tree_node *nodes[11] = { 0 };
     ++	void *values[11] = { NULL };
     ++	struct tree_node *nodes[11] = { NULL };
      +	int i = 1;
     -+	struct curry c = { 0 };
     ++	struct curry c = { NULL };
      +	do {
      +		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
      +		i = (i * 7) % 11;
  9:  4e40fc3b40 !  9:  68aee16e60 reftable: write reftable files
     @@ reftable/writer.c (new)
      +#include "reftable.h"
      +#include "tree.h"
      +
     ++/* finishes a block, and writes it to storage */
     ++static int writer_flush_block(struct reftable_writer *w);
     ++
     ++/* deallocates memory related to the index */
     ++static void writer_clear_index(struct reftable_writer *w);
     ++
     ++/* finishes writing a 'r' (refs) or 'g' (reflogs) section */
     ++static int writer_finish_public_section(struct reftable_writer *w);
     ++
      +static struct reftable_block_stats *
      +writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
      +{
     @@ reftable/writer.c (new)
      +int reftable_writer_add_ref(struct reftable_writer *w,
      +			    struct reftable_ref_record *ref)
      +{
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	struct reftable_ref_record copy = *ref;
      +	int err = 0;
      +
     @@ reftable/writer.c (new)
      +int reftable_writer_add_log(struct reftable_writer *w,
      +			    struct reftable_log_record *log)
      +{
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	char *input_log_message = log->message;
      +	struct strbuf cleaned_message = STRBUF_INIT;
      +	int err;
     @@ reftable/writer.c (new)
      +		w->index_len = 0;
      +		w->index_cap = 0;
      +		for (i = 0; i < idx_len; i++) {
     -+			struct reftable_record rec = { 0 };
     ++			struct reftable_record rec = { NULL };
      +			reftable_record_from_index(&rec, idx + i);
      +			if (block_writer_add(w->block_writer, &rec) == 0) {
      +				continue;
     @@ reftable/writer.c (new)
      +		.offsets = entry->offsets,
      +		.offset_len = entry->offset_len,
      +	};
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	if (arg->err < 0)
      +		goto done;
      +
     @@ reftable/writer.c (new)
      +static int writer_dump_object_index(struct reftable_writer *w)
      +{
      +	struct write_record_arg closure = { .w = w };
     -+	struct common_prefix_arg common = { 0 };
     ++	struct common_prefix_arg common = { NULL };
      +	if (w->obj_index_tree != NULL) {
      +		infix_walk(w->obj_index_tree, &update_common, &common);
      +	}
     @@ reftable/writer.c (new)
      +	return writer_finish_section(w);
      +}
      +
     -+int writer_finish_public_section(struct reftable_writer *w)
     ++static int writer_finish_public_section(struct reftable_writer *w)
      +{
      +	uint8_t typ = 0;
      +	int err = 0;
     @@ reftable/writer.c (new)
      +	return err;
      +}
      +
     -+void writer_clear_index(struct reftable_writer *w)
     ++static void writer_clear_index(struct reftable_writer *w)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->index_len; i++) {
     @@ reftable/writer.c (new)
      +	w->index_cap = 0;
      +}
      +
     -+const int debug = 0;
     ++static const int debug = 0;
      +
      +static int writer_flush_nonempty_block(struct reftable_writer *w)
      +{
     @@ reftable/writer.c (new)
      +	return 0;
      +}
      +
     -+int writer_flush_block(struct reftable_writer *w)
     ++static int writer_flush_block(struct reftable_writer *w)
      +{
      +	if (w->block_writer == NULL)
      +		return 0;
     @@ reftable/writer.h (new)
      +	struct reftable_stats stats;
      +};
      +
     -+/* finishes a block, and writes it to storage */
     -+int writer_flush_block(struct reftable_writer *w);
     -+
     -+/* deallocates memory related to the index */
     -+void writer_clear_index(struct reftable_writer *w);
     -+
     -+/* finishes writing a 'r' (refs) or 'g' (reflogs) section */
     -+int writer_finish_public_section(struct reftable_writer *w);
     -+
      +#endif
 10:  25259b683b ! 10:  c196de7f06 reftable: read reftable files
     @@ reftable/iter.c (new)
      +{
      +}
      +
     -+struct reftable_iterator_vtable empty_vtable = {
     ++static struct reftable_iterator_vtable empty_vtable = {
      +	.next = &empty_iterator_next,
      +	.close = &empty_iterator_close,
      +};
     @@ reftable/iter.c (new)
      +	return err;
      +}
      +
     -+struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
     ++static struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
      +	.next = &filtering_ref_iterator_next,
      +	.close = &filtering_ref_iterator_close,
      +};
     @@ reftable/iter.c (new)
      +	return err;
      +}
      +
     -+struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
     ++static struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
      +	.next = &indexed_table_ref_iter_next,
      +	.close = &indexed_table_ref_iter_close,
      +};
     @@ reftable/reader.c (new)
      +	block_iter_close(&ti->bi);
      +}
      +
     -+struct reftable_iterator_vtable table_iter_vtable = {
     ++static struct reftable_iterator_vtable table_iter_vtable = {
      +	.next = &table_iter_next_void,
      +	.close = &table_iter_close,
      +};
 11:  3448fcf828 ! 11:  bf6b929b86 reftable: file level tests
     @@ reftable/reftable_test.c (new)
      +{
      +	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_block_source source = { NULL };
     -+	struct reftable_block out = { 0 };
     ++	struct reftable_block out = { NULL };
      +	int n;
      +	uint8_t in[] = "hello";
      +	strbuf_add(&buf, in, sizeof(in));
     @@ reftable/reftable_test.c (new)
      +	};
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, buf, &opts);
     -+	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
      +	int i = 0, n;
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_log_record log = { NULL };
      +	const struct reftable_stats *stats = NULL;
      +	*names = reftable_calloc(sizeof(char *) * (N + 1));
      +	reftable_writer_set_limits(w, update_index, update_index);
     @@ reftable/reftable_test.c (new)
      +	struct reftable_write_options opts = {
      +		.block_size = 256,
      +	};
     -+	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
      +	int i = 0;
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_log_record log = { NULL };
      +	int n;
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_reader rd = { 0 };
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_reader rd = { NULL };
     ++	struct reftable_block_source source = { NULL };
      +	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     @@ reftable/reftable_test.c (new)
      +	reftable_writer_set_limits(w, 0, N);
      +	for (i = 0; i < N; i++) {
      +		char name[256];
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
      +		names[i] = xstrdup(name);
      +		ref.refname = name;
     @@ reftable/reftable_test.c (new)
      +	}
      +	for (i = 0; i < N; i++) {
      +		uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     -+		struct reftable_log_record log = { 0 };
     ++		struct reftable_log_record log = { NULL };
      +		set_test_hash(hash1, i);
      +		set_test_hash(hash2, i + 1);
      +
     @@ reftable/reftable_test.c (new)
      +	char **names;
      +	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_block_source source = { 0 };
     -+	struct reftable_reader rd = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_block_source source = { NULL };
     ++	struct reftable_reader rd = { NULL };
      +	int err = 0;
      +	int j = 0;
      +
     @@ reftable/reftable_test.c (new)
      +	assert_err(err);
      +
      +	while (1) {
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +		int r = reftable_iterator_next_ref(&it, &ref);
      +		assert(r >= 0);
      +		if (r > 0) {
     @@ reftable/reftable_test.c (new)
      +	char **names;
      +	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
     -+	struct reftable_reader rd = { 0 };
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader rd = { NULL };
     ++	struct reftable_block_source source = { NULL };
      +	int err;
      +	int i;
     -+	struct reftable_log_record log = { 0 };
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { NULL };
      +
      +	write_table(&names, &buf, N, 256, SHA1_ID);
      +
     @@ reftable/reftable_test.c (new)
      +	char **names;
      +	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
     -+	struct reftable_reader rd = { 0 };
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader rd = { NULL };
     ++	struct reftable_block_source source = { NULL };
      +	int err;
      +	int i = 0;
      +
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_iterator it = { NULL };
      +	struct strbuf pastLast = STRBUF_INIT;
     -+	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
      +
      +	write_table(&names, &buf, N, 256, hash_id);
      +
     @@ reftable/reftable_test.c (new)
      +
      +	err = reftable_reader_seek_ref(&rd, &it, pastLast.buf);
      +	if (err == 0) {
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +		int err = reftable_iterator_next_ref(&it, &ref);
      +		assert(err > 0);
      +	} else {
     @@ reftable/reftable_test.c (new)
      +	struct reftable_write_options opts = {
      +		.block_size = 256,
      +	};
     -+	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
      +	int i = 0;
      +	int n;
      +	int err;
      +	struct reftable_reader rd;
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_block_source source = { NULL };
      +
      +	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_iterator it = { NULL };
      +	int j;
      +
      +	set_test_hash(want_hash, 4);
     @@ reftable/reftable_test.c (new)
      +		char name[100];
      +		uint8_t hash1[SHA1_SIZE];
      +		uint8_t hash2[SHA1_SIZE];
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +
      +		memset(hash, i, sizeof(hash));
      +		memset(fill, 'x', 50);
     @@ reftable/reftable_test.c (new)
      +	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_block_source source = { NULL };
      +	struct reftable_reader *rd = NULL;
     -+	struct reftable_ref_record rec = { 0 };
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record rec = { NULL };
     ++	struct reftable_iterator it = { NULL };
      +	int err;
      +
      +	reftable_writer_set_limits(w, 1, 1);
 12:  64d98e60b2 ! 12:  4e38db7f48 reftable: rest of library
     @@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
      
       ## reftable/VERSION (new) ##
      @@
     -+b8ec0f74c74cb6752eb2033ad8e755a9c19aad15 C: add missing header
     ++7134eb9f8171a9759800f4187f9e6dde997335e7 C: NULL iso 0 for init
      
       ## reftable/dump.c (new) ##
      @@
     @@ reftable/dump.c (new)
      +
      +static int dump_table(const char *tablename)
      +{
     -+	struct reftable_block_source src = { 0 };
     ++	struct reftable_block_source src = { NULL };
      +	int err = reftable_block_source_from_file(&src, tablename);
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
      +	struct reftable_reader *r = NULL;
      +
      +	if (err < 0)
     @@ reftable/dump.c (new)
      +{
      +	struct reftable_stack *stack = NULL;
      +	struct reftable_write_options cfg = {};
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
      +	struct reftable_merged_table *merged = NULL;
      +
      +	int err = reftable_new_stack(&stack, stackdir, cfg);
     @@ reftable/merged.c (new)
      +	return merged_iter_next(mi, rec);
      +}
      +
     -+struct reftable_iterator_vtable merged_iter_vtable = {
     ++static struct reftable_iterator_vtable merged_iter_vtable = {
      +	.next = &merged_iter_next_void,
      +	.close = &merged_iter_close,
      +};
     @@ reftable/merged.c (new)
      +	return mt->min;
      +}
      +
     -+int merged_table_seek_record(struct reftable_merged_table *mt,
     -+			     struct reftable_iterator *it,
     -+			     struct reftable_record *rec)
     ++static int merged_table_seek_record(struct reftable_merged_table *mt,
     ++				    struct reftable_iterator *it,
     ++				    struct reftable_record *rec)
      +{
      +	struct reftable_iterator *iters = reftable_calloc(
      +		sizeof(struct reftable_iterator) * mt->stack_len);
     @@ reftable/merged.c (new)
      +	struct reftable_ref_record ref = {
      +		.refname = (char *)name,
      +	};
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_ref(&rec, &ref);
      +	return merged_table_seek_record(mt, it, &rec);
      +}
     @@ reftable/merged.c (new)
      +		.refname = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_log(&rec, &log);
      +	return merged_table_seek_record(mt, it, &rec);
      +}
     @@ reftable/merged.h (new)
      +};
      +
      +void merged_table_clear(struct reftable_merged_table *mt);
     -+int merged_table_seek_record(struct reftable_merged_table *mt,
     -+			     struct reftable_iterator *it,
     -+			     struct reftable_record *rec);
      +
      +#endif
      
     @@ reftable/merged_test.c (new)
      +
      +static void test_pq(void)
      +{
     -+	char *names[54] = { 0 };
     ++	char *names[54] = { NULL };
      +	int N = ARRAY_SIZE(names) - 1;
      +
     -+	struct merged_iter_pqueue pq = { 0 };
     ++	struct merged_iter_pqueue pq = { NULL };
      +	const char *last = NULL;
      +
      +	int i = 0;
     @@ reftable/merged_test.c (new)
      +	struct reftable_merged_table *mt =
      +		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
      +	int i;
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_iterator it = { NULL };
      +	int err = reftable_merged_table_seek_ref(mt, &it, "a");
      +	assert_err(err);
      +
     @@ reftable/merged_test.c (new)
      +	struct reftable_merged_table *mt =
      +		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
      +
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_iterator it = { NULL };
      +	int err = reftable_merged_table_seek_ref(mt, &it, "a");
      +	struct reftable_ref_record *out = NULL;
      +	size_t len = 0;
     @@ reftable/merged_test.c (new)
      +
      +	assert_err(err);
      +	while (len < 100) { /* cap loops/recursion. */
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +		int err = reftable_iterator_next_ref(&it, &ref);
      +		if (err > 0) {
      +			break;
     @@ reftable/merged_test.c (new)
      +		.update_index = 1,
      +	};
      +	int err;
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_block_source source = { NULL };
      +	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
      +	uint32_t hash_id;
      +	struct reftable_reader *rd = NULL;
     @@ reftable/pq.c (new)
      +#include "system.h"
      +#include "basics.h"
      +
     -+int pq_less(struct pq_entry a, struct pq_entry b)
     ++static int pq_less(struct pq_entry a, struct pq_entry b)
      +{
      +	struct strbuf ak = STRBUF_INIT;
      +	struct strbuf bk = STRBUF_INIT;
     @@ reftable/pq.h (new)
      +	struct reftable_record rec;
      +};
      +
     -+int pq_less(struct pq_entry a, struct pq_entry b);
     -+
      +struct merged_iter_pqueue {
      +	struct pq_entry *heap;
      +	size_t len;
     @@ reftable/refname.c (new)
      +	return strcmp(f_arg->names[k], f_arg->want) >= 0;
      +}
      +
     -+int modification_has_ref(struct modification *mod, const char *name)
     ++static int modification_has_ref(struct modification *mod, const char *name)
      +{
     -+	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_ref_record ref = { NULL };
      +	int err = 0;
      +
      +	if (mod->add_len > 0) {
     @@ reftable/refname.c (new)
      +	mod->del_len = 0;
      +}
      +
     -+int modification_has_ref_with_prefix(struct modification *mod,
     -+				     const char *prefix)
     ++static int modification_has_ref_with_prefix(struct modification *mod,
     ++					    const char *prefix)
      +{
      +	struct reftable_iterator it = { NULL };
      +	struct reftable_ref_record ref = { NULL };
     @@ reftable/refname.c (new)
      +	return err;
      +}
      +
     -+int validate_refname(const char *name)
     ++static int validate_refname(const char *name)
      +{
      +	while (1) {
      +		char *next = strchr(name, '/');
     @@ reftable/refname.h (new)
      +	size_t del_len;
      +};
      +
     -+// -1 = error, 0 = found, 1 = not found
     -+int modification_has_ref(struct modification *mod, const char *name);
     -+
     -+// -1 = error, 0 = found, 1 = not found.
     -+int modification_has_ref_with_prefix(struct modification *mod,
     -+				     const char *prefix);
     -+
     -+// 0 = OK.
     -+int validate_refname(const char *name);
     -+
      +int validate_ref_record_addition(struct reftable_table tab,
      +				 struct reftable_ref_record *recs, size_t sz);
      +
     @@ reftable/refname_test.c (new)
      +	};
      +	int err;
      +	int i;
     -+	struct reftable_block_source source = { 0 };
     ++	struct reftable_block_source source = { NULL };
      +	struct reftable_reader *rd = NULL;
      +	struct reftable_table tab = { NULL };
      +	struct testcase cases[] = {
     @@ reftable/refname_test.c (new)
      +	return test_main(argc, argv);
      +}
      
     + ## reftable/reftable.c ##
     +@@ reftable/reftable.c: int reftable_table_seek_ref(struct reftable_table *tab,
     + 	struct reftable_ref_record ref = {
     + 		.refname = (char *)name,
     + 	};
     +-	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
     + 	reftable_record_from_ref(&rec, &ref);
     + 	return tab->ops->seek_record(tab->table_arg, it, &rec);
     + }
     +@@ reftable/reftable.c: void reftable_table_from_reader(struct reftable_table *tab,
     + int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     + 			    struct reftable_ref_record *ref)
     + {
     +-	struct reftable_iterator it = { 0 };
     ++	struct reftable_iterator it = { NULL };
     + 	int err = reftable_table_seek_ref(tab, &it, name);
     + 	if (err)
     + 		goto done;
     +
       ## reftable/stack.c (new) ##
      @@
      +/*
     @@ reftable/stack.c (new)
      +#include "reftable.h"
      +#include "writer.h"
      +
     ++static int stack_try_add(struct reftable_stack *st,
     ++			 int (*write_table)(struct reftable_writer *wr,
     ++					    void *arg),
     ++			 void *arg);
     ++static int stack_write_compact(struct reftable_stack *st,
     ++			       struct reftable_writer *wr, int first, int last,
     ++			       struct reftable_log_expiry_config *config);
     ++static int stack_check_addition(struct reftable_stack *st,
     ++				const char *new_tab_name);
     ++static void reftable_addition_close(struct reftable_addition *add);
     ++static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++					     int reuse_open);
     ++
      +int reftable_new_stack(struct reftable_stack **dest, const char *dir,
      +		       struct reftable_write_options config)
      +{
     @@ reftable/stack.c (new)
      +		}
      +
      +		if (rd == NULL) {
     -+			struct reftable_block_source src = { 0 };
     ++			struct reftable_block_source src = { NULL };
      +			struct strbuf table_path = STRBUF_INIT;
      +			strbuf_addstr(&table_path, st->reftable_dir);
      +			strbuf_addstr(&table_path, "/");
     @@ reftable/stack.c (new)
      +	return udiff;
      +}
      +
     -+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st, int reuse_open)
     ++static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++					     int reuse_open)
      +{
      +	struct timeval deadline = { 0 };
      +	int err = gettimeofday(&deadline, NULL);
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     -+void reftable_addition_close(struct reftable_addition *add)
     ++static void reftable_addition_close(struct reftable_addition *add)
      +{
      +	int i = 0;
      +	struct strbuf nm = STRBUF_INIT;
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     -+int stack_try_add(struct reftable_stack *st,
     -+		  int (*write_table)(struct reftable_writer *wr, void *arg),
     -+		  void *arg)
     ++static int stack_try_add(struct reftable_stack *st,
     ++			 int (*write_table)(struct reftable_writer *wr,
     ++					    void *arg),
     ++			 void *arg)
      +{
      +	struct reftable_addition add = REFTABLE_ADDITION_INIT;
      +	int err = reftable_stack_init_addition(&add, st);
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     -+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     -+			int first, int last,
     -+			struct reftable_log_expiry_config *config)
     ++static int stack_write_compact(struct reftable_stack *st,
     ++			       struct reftable_writer *wr, int first, int last,
     ++			       struct reftable_log_expiry_config *config)
      +{
      +	int subtabs_len = last - first + 1;
      +	struct reftable_table *subtabs = reftable_calloc(
      +		sizeof(struct reftable_table) * (last - first + 1));
      +	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
      +
      +	uint64_t entries = 0;
      +
     @@ reftable/stack.c (new)
      +int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
      +			    struct reftable_log_record *log)
      +{
     -+	struct reftable_iterator it = { 0 };
     ++	struct reftable_iterator it = { NULL };
      +	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
      +	int err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err)
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     -+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
     ++static int stack_check_addition(struct reftable_stack *st,
     ++				const char *new_tab_name)
      +{
      +	int err = 0;
     -+	struct reftable_block_source src = { 0 };
     ++	struct reftable_block_source src = { NULL };
      +	struct reftable_reader *rd = NULL;
      +	struct reftable_table tab = { NULL };
      +	struct reftable_ref_record *refs = NULL;
     @@ reftable/stack.c (new)
      +		goto done;
      +
      +	while (1) {
     -+		struct reftable_ref_record ref = { 0 };
     ++		struct reftable_ref_record ref = { NULL };
      +		err = reftable_iterator_next_ref(&it, &ref);
      +		if (err > 0) {
      +			break;
     @@ reftable/stack.h (new)
      +};
      +
      +int read_lines(const char *filename, char ***lines);
     -+int stack_try_add(struct reftable_stack *st,
     -+		  int (*write_table)(struct reftable_writer *wr, void *arg),
     -+		  void *arg);
     -+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     -+			int first, int last,
     -+			struct reftable_log_expiry_config *config);
     -+int fastlog2(uint64_t sz);
     -+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
     -+void reftable_addition_close(struct reftable_addition *add);
     -+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     -+				      int reuse_open);
      +
      +struct segment {
      +	int start, end;
     @@ reftable/stack.h (new)
      +	uint64_t bytes;
      +};
      +
     ++int fastlog2(uint64_t sz);
      +struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
      +struct segment suggest_compaction_segment(uint64_t *sizes, int n);
      +
     @@ reftable/stack_test.c (new)
      +		.update_index = 1,
      +		.target = "master",
      +	};
     -+	struct reftable_ref_record dest = { 0 };
     ++	struct reftable_ref_record dest = { NULL };
      +
      +	assert(mkdtemp(dir));
      +
     @@ reftable/stack_test.c (new)
      +		.update_index = 1,
      +		.target = "master",
      +	};
     -+	struct reftable_ref_record dest = { 0 };
     ++	struct reftable_ref_record dest = { NULL };
      +
      +	assert(mkdtemp(dir));
      +
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_stack *st = NULL;
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
     -+	struct reftable_ref_record refs[2] = { { 0 } };
     -+	struct reftable_log_record logs[2] = { { 0 } };
     ++	struct reftable_ref_record refs[2] = { { NULL } };
     ++	struct reftable_log_record logs[2] = { { NULL } };
      +	int N = ARRAY_SIZE(refs);
      +
      +	assert(mkdtemp(dir));
     @@ reftable/stack_test.c (new)
      +	assert_err(err);
      +
      +	for (i = 0; i < N; i++) {
     -+		struct reftable_ref_record dest = { 0 };
     ++		struct reftable_ref_record dest = { NULL };
     ++
      +		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
      +		assert_err(err);
      +		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
     @@ reftable/stack_test.c (new)
      +	}
      +
      +	for (i = 0; i < N; i++) {
     -+		struct reftable_log_record dest = { 0 };
     ++		struct reftable_log_record dest = { NULL };
      +		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
      +		assert_err(err);
      +		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	struct reftable_ref_record refs[2] = { { 0 } };
     -+	struct reftable_log_record logs[2] = { { 0 } };
     ++	struct reftable_ref_record refs[2] = { { NULL } };
     ++	struct reftable_log_record logs[2] = { { NULL } };
      +	int N = ARRAY_SIZE(refs);
     -+	struct reftable_ref_record dest = { 0 };
     -+	struct reftable_log_record log_dest = { 0 };
     ++	struct reftable_ref_record dest = { NULL };
     ++	struct reftable_log_record log_dest = { NULL };
      +
      +	assert(mkdtemp(dir));
      +
     @@ reftable/stack_test.c (new)
      +	struct reftable_stack *st32 = NULL;
      +	struct reftable_write_options cfg_default = { 0 };
      +	struct reftable_stack *st_default = NULL;
     -+	struct reftable_ref_record dest = { 0 };
     ++	struct reftable_ref_record dest = { NULL };
      +
      +	assert(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
     -+	struct reftable_log_record logs[20] = { { 0 } };
     ++	struct reftable_log_record logs[20] = { { NULL } };
      +	int N = ARRAY_SIZE(logs) - 1;
      +	int i = 0;
      +	int err;
      +	struct reftable_log_expiry_config expiry = {
      +		.time = 10,
      +	};
     -+	struct reftable_log_record log = { 0 };
     ++	struct reftable_log_record log = { NULL };
      +
      +	assert(mkdtemp(dir));
      +
 13:  b8729fee9e ! 13:  c535f838d6 reftable: "test-tool dump-reftable" command.
     @@ Makefile: REFTABLE_OBJS += reftable/writer.o
       REFTABLE_TEST_OBJS += reftable/refname_test.o
       REFTABLE_TEST_OBJS += reftable/reftable_test.o
      
     + ## reftable/iter.c ##
     +@@ reftable/iter.c: void reftable_iterator_destroy(struct reftable_iterator *it)
     + int reftable_iterator_next_ref(struct reftable_iterator *it,
     + 			       struct reftable_ref_record *ref)
     + {
     +-	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
     + 	reftable_record_from_ref(&rec, ref);
     + 	return iterator_next(it, &rec);
     + }
     +@@ reftable/iter.c: int reftable_iterator_next_ref(struct reftable_iterator *it,
     + int reftable_iterator_next_log(struct reftable_iterator *it,
     + 			       struct reftable_log_record *log)
     + {
     +-	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
     + 	reftable_record_from_log(&rec, log);
     + 	return iterator_next(it, &rec);
     + }
     +@@ reftable/iter.c: static int filtering_ref_iterator_next(void *iter_arg,
     + 		}
     + 
     + 		if (fri->double_check) {
     +-			struct reftable_iterator it = { 0 };
     ++			struct reftable_iterator it = { NULL };
     + 
     + 			err = reftable_table_seek_ref(&fri->tab, &it,
     + 						      ref->refname);
     +
     + ## reftable/reader.c ##
     +@@ reftable/reader.c: static int parse_footer(struct reftable_reader *r, uint8_t *footer,
     + int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
     + 		const char *name)
     + {
     +-	struct reftable_block footer = { 0 };
     +-	struct reftable_block header = { 0 };
     ++	struct reftable_block footer = { NULL };
     ++	struct reftable_block header = { NULL };
     + 	int err = 0;
     + 
     + 	memset(r, 0, sizeof(struct reftable_reader));
     +@@ reftable/reader.c: int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     + {
     + 	int32_t guess_block_size = r->block_size ? r->block_size :
     + 							 DEFAULT_BLOCK_SIZE;
     +-	struct reftable_block block = { 0 };
     ++	struct reftable_block block = { NULL };
     + 	uint8_t block_typ = 0;
     + 	int err = 0;
     + 	uint32_t header_off = next_off ? 0 : header_size(r->version);
     +@@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
     + 			       struct reftable_record *rec)
     + {
     + 	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
     +-	struct reftable_record want_index_rec = { 0 };
     ++	struct reftable_record want_index_rec = { NULL };
     + 	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
     +-	struct reftable_record index_result_rec = { 0 };
     ++	struct reftable_record index_result_rec = { NULL };
     + 	struct table_iter index_iter = TABLE_ITER_INIT;
     + 	struct table_iter next = TABLE_ITER_INIT;
     + 	int err = 0;
     +@@ reftable/reader.c: int reftable_reader_seek_ref(struct reftable_reader *r,
     + 	struct reftable_ref_record ref = {
     + 		.refname = (char *)name,
     + 	};
     +-	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
     + 	reftable_record_from_ref(&rec, &ref);
     + 	return reader_seek(r, it, &rec);
     + }
     +@@ reftable/reader.c: int reftable_reader_seek_log_at(struct reftable_reader *r,
     + 		.refname = (char *)name,
     + 		.update_index = update_index,
     + 	};
     +-	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
     + 	reftable_record_from_log(&rec, &log);
     + 	return reader_seek(r, it, &rec);
     + }
     +@@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
     + 		.hash_prefix = oid,
     + 		.hash_prefix_len = r->object_id_len,
     + 	};
     +-	struct reftable_record want_rec = { 0 };
     +-	struct reftable_iterator oit = { 0 };
     +-	struct reftable_obj_record got = { 0 };
     +-	struct reftable_record got_rec = { 0 };
     ++	struct reftable_record want_rec = { NULL };
     ++	struct reftable_iterator oit = { NULL };
     ++	struct reftable_obj_record got = { NULL };
     ++	struct reftable_record got_rec = { NULL };
     + 	int err = 0;
     + 	struct indexed_table_ref_iter *itr = NULL;
     + 
     +
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       	tree_test_main(argc, argv);

-- 
gitgitgadget
