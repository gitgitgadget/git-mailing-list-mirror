Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DAC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34D42081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSWwsmnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgERUbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgERUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C4C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d207so823057wmd.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LDdUmd/qLfknRbl08hIXhLgUkpmLimYMqTMaO3kgmDI=;
        b=cSWwsmnpGT30eKIbN4Gw5XH1SJfNzklRSf1ZjDKn185BzYnp0X2Ca1p3vTl9RroGy/
         Q2iG9mC60kFQIMoyf6FJOd58AGiF+IN1N5kVg0Ta6ZvgmRUMHc6MWtIT0XDwy6g+HJX4
         alpYTHmkpFICGTBolRin1ZMhQL7Jc2ASieqzpcXGQS0wNjkCJZMjqW1L2WjGbpuJhg7O
         IkdJ8Jp1b6C6+Kl53rXknTor53n833dq562fr2HmSfThAGYBJwFaQcKSmWsj/9Q7p5fK
         1dVGWaRFImgQzNmAb+sSUnIpG5KQSR/6i5UslQwV7TX3tjQFQ35hFMfhjftDjPWEQLDX
         sgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LDdUmd/qLfknRbl08hIXhLgUkpmLimYMqTMaO3kgmDI=;
        b=B0oklzRY51BGxKui7bqSayVWOv+h7RoDArdxxhg9iUrF4grkB3UWpIEVO9/e5OS6ae
         4JfP/qtiUaehuK0QYDyk+Fd59V325MZjQ92nw4MRQSZfnyc5som7KvlLKRcKT+WZxAB3
         jKb2lAxih0h/DXrQDDvcPtL7wSjAc+qMxmliMQJkBn8QDppo/pRKduHfJi5vHFPsPHxu
         YCcLptVBllO6pQMsxWfr+CHP//G19C0s96kPoGT6BoVAnISdLf8pYEsDLvgES6bUAkIb
         DxbdrA42/u6Smzb0buT3bnPPHP7UcYky4rEw9yXeEIL/hSZSq04vQFFulYmB2bkzSaQ1
         5KSA==
X-Gm-Message-State: AOAM530z4hsoIlRVemKFAYWl+DuTP86LR96vTO8H1t9VdkJRx36yVKPq
        3b20m4k6Yn+5ZOo/a2/VACe1GI9X
X-Google-Smtp-Source: ABdhPJzgIOfJy8OJTqo8EcL0p9PZnrpD0wv/Srbm8aig2t2112po0NCFzl5fpEq5D50ttc/3dcfueg==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr31353wmf.53.1589833886460;
        Mon, 18 May 2020 13:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm17667797wrn.10.2020.05.18.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:25 -0700 (PDT)
Message-Id: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:15 +0000
Subject: [PATCH v14 0/9] Reftable support git-core
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

Summary 18904 tests pass 2750 tests fail

Some issues:

 * many tests inspect .git/{logs,heads}/ directly.
 * worktrees broken. 
 * Rebase/cherry-pick still largely broken

v16

 * handle pseudo refs.
 * various bugfixes and fixes for mem leaks.

v17

 * many style tweaks in reftable/
 * fix rebase
 * GIT_DEBUG_REFS support.

Han-Wen Nienhuys (8):
  Write pseudorefs through ref backends.
  Move REF_LOG_ONLY to refs-internal.h
  Iterate over the "refs/" namespace in for_each_[raw]ref
  Add .gitattributes for the reftable/ directory
  Add reftable library
  Reftable support for git-core
  Add GIT_DEBUG_REFS debugging mechanism
  Add reftable testing infrastructure

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   28 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   56 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 refs.c                                        |  150 +-
 refs.h                                        |   14 +
 refs/debug.c                                  |  309 ++++
 refs/files-backend.c                          |  121 +-
 refs/packed-backend.c                         |   21 +-
 refs/refs-internal.h                          |   26 +
 refs/reftable-backend.c                       | 1313 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  435 ++++++
 reftable/block.h                              |  129 ++
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   97 ++
 reftable/iter.c                               |  241 +++
 reftable/iter.h                               |   63 +
 reftable/merged.c                             |  327 ++++
 reftable/merged.h                             |   39 +
 reftable/pq.c                                 |  114 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  754 ++++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1154 +++++++++++++++
 reftable/record.h                             |  128 ++
 reftable/refname.c                            |  215 +++
 reftable/refname.h                            |   38 +
 reftable/reftable.c                           |   92 ++
 reftable/reftable.h                           |  564 +++++++
 reftable/slice.c                              |  225 +++
 reftable/slice.h                              |   77 +
 reftable/stack.c                              | 1234 ++++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/system.h                             |   54 +
 reftable/tree.c                               |   64 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   24 +
 reftable/writer.c                             |  659 +++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |  136 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/t9903-bash-prompt.sh                        |    6 +
 t/test-lib.sh                                 |    5 +
 59 files changed, 9523 insertions(+), 141 deletions(-)
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
 create mode 100755 t/t0033-debug-refs.sh


base-commit: 369e06977b0442dc153312a6e7fb2ecd8ff540c5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v14
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v13:

  1:  8394c156eb4 <  -:  ----------- refs.h: clarify reflog iteration order
  2:  dbf45fe8753 <  -:  ----------- t: use update-ref and show-ref to reading/writing refs
  3:  be083a85fb5 <  -:  ----------- refs: document how ref_iterator_advance_fn should handle symrefs
  4:  96fd9814a67 <  -:  ----------- reftable: file format documentation
  5:  7aa3f92fca0 <  -:  ----------- reftable: clarify how empty tables should be written
  6:  1e3c8f2d3e8 <  -:  ----------- reftable: define version 2 of the spec to accomodate SHA256
  7:  2c2f94ddc0e !  1:  46d04f6740e Write pseudorefs through ref backends.
     @@ refs.c: long get_files_ref_lock_timeout_ms(void)
       int refs_delete_ref(struct ref_store *refs, const char *msg,
       		    const char *refname,
      @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
     - 	struct strbuf err = STRBUF_INIT;
       
       	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
     --		assert(refs == get_main_ref_store(the_repository));
     + 		assert(refs == get_main_ref_store(the_repository));
      -		return delete_pseudoref(refname, old_oid);
      +		return ref_store_delete_pseudoref(refs, refname, old_oid);
       	}
     @@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
       struct files_ref_iterator {
       	struct ref_iterator base;
       
     -@@ refs/files-backend.c: static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
     - 	return 0;
     - }
     +@@ refs/files-backend.c: struct ref_storage_be refs_be_files = {
     + 	files_rename_ref,
     + 	files_copy_ref,
       
     --struct ref_storage_be refs_be_files = {
     --	NULL,
     --	"files",
     --	files_ref_store_create,
     --	files_init_db,
     --	files_transaction_prepare,
     --	files_transaction_finish,
     --	files_transaction_abort,
     --	files_initial_transaction_commit,
     --
     --	files_pack_refs,
     --	files_create_symref,
     --	files_delete_refs,
     --	files_rename_ref,
     --	files_copy_ref,
     --
     --	files_ref_iterator_begin,
     --	files_read_raw_ref,
     --
     --	files_reflog_iterator_begin,
     --	files_for_each_reflog_ent,
     --	files_for_each_reflog_ent_reverse,
     --	files_reflog_exists,
     --	files_create_reflog,
     --	files_delete_reflog,
     --	files_reflog_expire
     --};
     -+struct ref_storage_be refs_be_files = { NULL,
     -+					"files",
     -+					files_ref_store_create,
     -+					files_init_db,
     -+					files_transaction_prepare,
     -+					files_transaction_finish,
     -+					files_transaction_abort,
     -+					files_initial_transaction_commit,
     -+
     -+					files_pack_refs,
     -+					files_create_symref,
     -+					files_delete_refs,
     -+					files_rename_ref,
     -+					files_copy_ref,
     ++	files_write_pseudoref,
     ++	files_delete_pseudoref,
      +
     -+					files_write_pseudoref,
     -+					files_delete_pseudoref,
     -+
     -+					files_ref_iterator_begin,
     -+					files_read_raw_ref,
     -+
     -+					files_reflog_iterator_begin,
     -+					files_for_each_reflog_ent,
     -+					files_for_each_reflog_ent_reverse,
     -+					files_reflog_exists,
     -+					files_create_reflog,
     -+					files_delete_reflog,
     -+					files_reflog_expire };
     + 	files_ref_iterator_begin,
     + 	files_read_raw_ref,
     + 
     +@@ refs/files-backend.c: struct ref_storage_be refs_be_files = {
     + 	files_reflog_exists,
     + 	files_create_reflog,
     + 	files_delete_reflog,
     +-	files_reflog_expire
     ++	files_reflog_expire,
     + };
      
       ## refs/packed-backend.c ##
     -@@ refs/packed-backend.c: static int packed_reflog_expire(struct ref_store *ref_store,
     +@@ refs/packed-backend.c: static int packed_copy_ref(struct ref_store *ref_store,
     + 	BUG("packed reference store does not support copying references");
       }
       
     - struct ref_storage_be refs_be_packed = {
     --	NULL,
     --	"packed",
     --	packed_ref_store_create,
     --	packed_init_db,
     --	packed_transaction_prepare,
     --	packed_transaction_finish,
     --	packed_transaction_abort,
     --	packed_initial_transaction_commit,
     --
     --	packed_pack_refs,
     --	packed_create_symref,
     --	packed_delete_refs,
     --	packed_rename_ref,
     --	packed_copy_ref,
     --
     --	packed_ref_iterator_begin,
     --	packed_read_raw_ref,
     --
     --	packed_reflog_iterator_begin,
     --	packed_for_each_reflog_ent,
     --	packed_for_each_reflog_ent_reverse,
     --	packed_reflog_exists,
     --	packed_create_reflog,
     --	packed_delete_reflog,
     --	packed_reflog_expire
     -+	NULL, "packed", packed_ref_store_create, packed_init_db,
     -+	packed_transaction_prepare, packed_transaction_finish,
     -+	packed_transaction_abort, packed_initial_transaction_commit,
     -+
     -+	packed_pack_refs, packed_create_symref, packed_delete_refs,
     -+	packed_rename_ref, packed_copy_ref,
     ++static int packed_write_pseudoref(struct ref_store *ref_store,
     ++				  const char *pseudoref,
     ++				  const struct object_id *oid,
     ++				  const struct object_id *old_oid,
     ++				  struct strbuf *err)
     ++{
     ++	BUG("packed reference store does not support writing pseudo-references");
     ++}
      +
     -+	/* XXX */
     -+	NULL, NULL,
     ++static int packed_delete_pseudoref(struct ref_store *ref_store,
     ++				   const char *pseudoref,
     ++				   const struct object_id *old_oid)
     ++{
     ++	BUG("packed reference store does not support deleting pseudo-references");
     ++}
      +
     -+	packed_ref_iterator_begin, packed_read_raw_ref,
     + static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
     + {
     + 	return empty_ref_iterator_begin();
     +@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
     + 	packed_rename_ref,
     + 	packed_copy_ref,
     + 
     ++	packed_write_pseudoref,
     ++	packed_delete_pseudoref,
      +
     -+	packed_reflog_iterator_begin, packed_for_each_reflog_ent,
     -+	packed_for_each_reflog_ent_reverse, packed_reflog_exists,
     -+	packed_create_reflog, packed_delete_reflog, packed_reflog_expire
     + 	packed_ref_iterator_begin,
     + 	packed_read_raw_ref,
     + 
     +@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
     + 	packed_reflog_exists,
     + 	packed_create_reflog,
     + 	packed_delete_reflog,
     +-	packed_reflog_expire
     ++	packed_reflog_expire,
       };
      
       ## refs/refs-internal.h ##
  -:  ----------- >  2:  c650f7e4345 Move REF_LOG_ONLY to refs-internal.h
  8:  3becaaee66a =  3:  0c953fce52a Iterate over the "refs/" namespace in for_each_[raw]ref
  9:  a6f77965f84 =  4:  206b7d329f8 Add .gitattributes for the reftable/ directory
 10:  8103703c358 !  5:  9a8e504a1d0 Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit e74c14b66b6c15f6526c485f2e45d3f2735d359d
     ++commit bad78b6de70700933a2f93ebadaa37a5e852d9ea
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon May 11 21:02:55 2020 +0200
     -+
     -+    C: handle out-of-date reftable stacks
     -+    
     -+    * Make reftable_stack_reload() check out-of-dateness. This makes it very cheap,
     -+      allowing it to be called often. This is useful because Git calls itself often,
     -+      which effectively requires a reload.
     -+    
     -+    * In reftable_stack_add(), check the return value of stack_uptodate(), leading
     -+      to erroneously succeeding the transaction.
     -+    
     -+    * A test that exercises the above.
     ++Date:   Mon May 18 20:12:57 2020 +0200
     ++
     ++    C: get rid of inner blocks for local scoping
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +	return bw->buf[bw->header_off];
      +}
      +
     -+/* adds the record to the block. Returns -1 if it does not fit, 0 on
     ++/* adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
      +   success */
     -+int block_writer_add(struct block_writer *w, struct record rec)
     ++int block_writer_add(struct block_writer *w, struct reftable_record *rec)
      +{
      +	struct slice empty = { 0 };
      +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
     @@ reftable/block.c (new)
      +	struct slice key = { 0 };
      +	int n = 0;
      +
     -+	record_key(rec, &key);
     -+	n = encode_key(&restart, out, last, key, record_val_type(rec));
     ++	reftable_record_key(rec, &key);
     ++	n = reftable_encode_key(&restart, out, last, key,
     ++				reftable_record_val_type(rec));
      +	if (n < 0) {
      +		goto err;
      +	}
      +	slice_consume(&out, n);
      +
     -+	n = record_encode(rec, out, w->hash_size);
     ++	n = reftable_record_encode(rec, out, w->hash_size);
      +	if (n < 0) {
      +		goto err;
      +	}
     @@ reftable/block.c (new)
      +		goto err;
      +	}
      +
     -+	slice_clear(&key);
     ++	slice_release(&key);
      +	return 0;
      +
      +err:
     -+	slice_clear(&key);
     ++	slice_release(&key);
      +	return -1;
      +}
      +
     @@ reftable/block.c (new)
      +			}
      +
      +			if (Z_OK != zresult) {
     -+				slice_clear(&compressed);
     ++				slice_release(&compressed);
      +				return REFTABLE_ZLIB_ERROR;
      +			}
      +
      +			memcpy(w->buf + block_header_skip, compressed.buf,
      +			       dest_len);
      +			w->next = dest_len + block_header_skip;
     -+			slice_clear(&compressed);
     ++			slice_release(&compressed);
      +			break;
      +		}
      +	}
     @@ reftable/block.c (new)
      +	byte typ = block->data[header_off];
      +	uint32_t sz = get_be24(block->data + header_off + 1);
      +
     -+	if (!is_block_type(typ)) {
     ++	if (!reftable_is_block_type(typ)) {
      +		return REFTABLE_FORMAT_ERROR;
      +	}
      +
     @@ reftable/block.c (new)
      +				    uncompressed.buf + block_header_skip,
      +				    &dst_len, block->data + block_header_skip,
      +				    &src_len)) {
     -+			slice_clear(&uncompressed);
     ++			slice_release(&uncompressed);
      +			return REFTABLE_ZLIB_ERROR;
      +		}
      +
     @@ reftable/block.c (new)
      +	struct slice rkey = { 0 };
      +	struct slice last_key = { 0 };
      +	byte unused_extra;
     -+	int n = decode_key(&rkey, &unused_extra, last_key, in);
     ++	int n = reftable_decode_key(&rkey, &unused_extra, last_key, in);
      +	if (n < 0) {
      +		a->error = 1;
      +		return -1;
      +	}
      +
      +	{
     -+		int result = slice_compare(a->key, rkey);
     -+		slice_clear(&rkey);
     ++		int result = slice_cmp(a->key, rkey);
     ++		slice_release(&rkey);
      +		return result;
      +	}
      +}
     @@ reftable/block.c (new)
      +	slice_copy(&dest->last_key, src->last_key);
      +}
      +
     -+int block_iter_next(struct block_iter *it, struct record rec)
     ++int block_iter_next(struct block_iter *it, struct reftable_record *rec)
      +{
      +	struct slice in = {
      +		.buf = it->br->block.data + it->next_off,
     @@ reftable/block.c (new)
      +		return 1;
      +	}
      +
     -+	n = decode_key(&key, &extra, it->last_key, in);
     ++	n = reftable_decode_key(&key, &extra, it->last_key, in);
      +	if (n < 0) {
      +		return -1;
      +	}
      +
      +	slice_consume(&in, n);
     -+	n = record_decode(rec, key, extra, in, it->br->hash_size);
     ++	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
      +	if (n < 0) {
      +		return -1;
      +	}
     @@ reftable/block.c (new)
      +
      +	slice_copy(&it->last_key, key);
      +	it->next_off += start.len - in.len;
     -+	slice_clear(&key);
     ++	slice_release(&key);
      +	return 0;
      +}
      +
     @@ reftable/block.c (new)
      +	};
      +
      +	byte extra = 0;
     -+	int n = decode_key(key, &extra, empty, in);
     ++	int n = reftable_decode_key(key, &extra, empty, in);
      +	if (n < 0) {
      +		return n;
      +	}
     @@ reftable/block.c (new)
      +
      +void block_iter_close(struct block_iter *it)
      +{
     -+	slice_clear(&it->last_key);
     ++	slice_release(&it->last_key);
      +}
      +
      +int block_reader_seek(struct block_reader *br, struct block_iter *it,
     @@ reftable/block.c (new)
      +		.key = want,
      +		.r = br,
      +	};
     -+	struct record rec = new_record(block_reader_type(br));
     ++	struct reftable_record rec = reftable_new_record(block_reader_type(br));
      +	struct slice key = { 0 };
      +	int err = 0;
      +	struct block_iter next = { 0 };
     @@ reftable/block.c (new)
      +	*/
      +	while (true) {
      +		block_iter_copy_from(&next, it);
     -+		err = block_iter_next(&next, rec);
     ++		err = block_iter_next(&next, &rec);
      +		if (err < 0) {
      +			goto exit;
      +		}
      +
     -+		record_key(rec, &key);
     -+		if (err > 0 || slice_compare(key, want) >= 0) {
     ++		reftable_record_key(&rec, &key);
     ++		if (err > 0 || slice_cmp(key, want) >= 0) {
      +			err = 0;
      +			goto exit;
      +		}
     @@ reftable/block.c (new)
      +	}
      +
      +exit:
     -+	slice_clear(&key);
     -+	slice_clear(&next.last_key);
     -+	record_destroy(&rec);
     ++	slice_release(&key);
     ++	slice_release(&next.last_key);
     ++	reftable_record_destroy(&rec);
      +
      +	return err;
      +}
     @@ reftable/block.c (new)
      +void block_writer_clear(struct block_writer *bw)
      +{
      +	FREE_AND_NULL(bw->restarts);
     -+	slice_clear(&bw->last_key);
     ++	slice_release(&bw->last_key);
      +	/* the block is not owned. */
      +}
      
     @@ reftable/block.h (new)
      +byte block_writer_type(struct block_writer *bw);
      +
      +/* appends the record, or -1 if it doesn't fit. */
     -+int block_writer_add(struct block_writer *w, struct record rec);
     ++int block_writer_add(struct block_writer *w, struct reftable_record *rec);
      +
      +/* appends the key restarts, and compress the block if necessary. */
      +int block_writer_finish(struct block_writer *w);
     @@ reftable/block.h (new)
      +void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
      +
      +/* return < 0 for error, 0 for OK, > 0 for EOF. */
     -+int block_iter_next(struct block_iter *it, struct record rec);
     ++int block_iter_next(struct block_iter *it, struct reftable_record *rec);
      +
      +/* Seek to `want` with in the block pointed to by `it` */
      +int block_iter_seek(struct block_iter *it, struct slice want);
     @@ reftable/file.c (new)
      +	struct stat st = { 0 };
      +	int err = 0;
      +	int fd = open(name, O_RDONLY);
     ++	struct file_block_source *p = NULL;
      +	if (fd < 0) {
      +		if (errno == ENOENT) {
      +			return REFTABLE_NOT_EXIST_ERROR;
     @@ reftable/file.c (new)
      +		return -1;
      +	}
      +
     -+	{
     -+		struct file_block_source *p =
     -+			reftable_calloc(sizeof(struct file_block_source));
     -+		p->size = st.st_size;
     -+		p->fd = fd;
     ++	p = reftable_calloc(sizeof(struct file_block_source));
     ++	p->size = st.st_size;
     ++	p->fd = fd;
      +
     -+		assert(bs->ops == NULL);
     -+		bs->ops = &file_vtable;
     -+		bs->arg = p;
     -+	}
     ++	assert(bs->ops == NULL);
     ++	bs->ops = &file_vtable;
     ++	bs->arg = p;
      +	return 0;
      +}
      +
     @@ reftable/iter.c (new)
      +#include "reader.h"
      +#include "reftable.h"
      +
     -+bool iterator_is_null(struct reftable_iterator it)
     ++bool iterator_is_null(struct reftable_iterator *it)
      +{
     -+	return it.ops == NULL;
     ++	return it->ops == NULL;
      +}
      +
     -+static int empty_iterator_next(void *arg, struct record rec)
     ++static int empty_iterator_next(void *arg, struct reftable_record *rec)
      +{
      +	return 1;
      +}
     @@ reftable/iter.c (new)
      +	it->ops = &empty_vtable;
      +}
      +
     -+int iterator_next(struct reftable_iterator it, struct record rec)
     ++int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
      +{
     -+	return it.ops->next(it.iter_arg, rec);
     ++	return it->ops->next(it->iter_arg, rec);
      +}
      +
      +void reftable_iterator_destroy(struct reftable_iterator *it)
     @@ reftable/iter.c (new)
      +	FREE_AND_NULL(it->iter_arg);
      +}
      +
     -+int reftable_iterator_next_ref(struct reftable_iterator it,
     ++int reftable_iterator_next_ref(struct reftable_iterator *it,
      +			       struct reftable_ref_record *ref)
      +{
     -+	struct record rec = { 0 };
     -+	record_from_ref(&rec, ref);
     -+	return iterator_next(it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_ref(&rec, ref);
     ++	return iterator_next(it, &rec);
      +}
      +
     -+int reftable_iterator_next_log(struct reftable_iterator it,
     ++int reftable_iterator_next_log(struct reftable_iterator *it,
      +			       struct reftable_log_record *log)
      +{
     -+	struct record rec = { 0 };
     -+	record_from_log(&rec, log);
     -+	return iterator_next(it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_log(&rec, log);
     ++	return iterator_next(it, &rec);
      +}
      +
      +static void filtering_ref_iterator_close(void *iter_arg)
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
     -+	slice_clear(&fri->oid);
     ++	slice_release(&fri->oid);
      +	reftable_iterator_destroy(&fri->it);
      +}
      +
     -+static int filtering_ref_iterator_next(void *iter_arg, struct record rec)
     ++static int filtering_ref_iterator_next(void *iter_arg,
     ++				       struct reftable_record *rec)
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
      +	struct reftable_ref_record *ref =
     -+		(struct reftable_ref_record *)rec.data;
     ++		(struct reftable_ref_record *)rec->data;
      +	int err = 0;
      +	while (true) {
     -+		err = reftable_iterator_next_ref(fri->it, ref);
     ++		err = reftable_iterator_next_ref(&fri->it, ref);
      +		if (err != 0) {
      +			break;
      +		}
     @@ reftable/iter.c (new)
      +		if (fri->double_check) {
      +			struct reftable_iterator it = { 0 };
      +
     -+			err = reftable_table_seek_ref(fri->tab, &it,
     ++			err = reftable_table_seek_ref(&fri->tab, &it,
      +						      ref->ref_name);
      +			if (err == 0) {
     -+				err = reftable_iterator_next_ref(it, ref);
     ++				err = reftable_iterator_next_ref(&it, ref);
      +			}
      +
      +			reftable_iterator_destroy(&it);
     @@ reftable/iter.c (new)
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	block_iter_close(&it->cur);
      +	reftable_block_done(&it->block_reader.block);
     -+	slice_clear(&it->oid);
     ++	slice_release(&it->oid);
      +}
      +
      +static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
     @@ reftable/iter.c (new)
      +	return 0;
      +}
      +
     -+static int indexed_table_ref_iter_next(void *p, struct record rec)
     ++static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
      +{
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	struct reftable_ref_record *ref =
     -+		(struct reftable_ref_record *)rec.data;
     ++		(struct reftable_ref_record *)rec->data;
      +
      +	while (true) {
      +		int err = block_iter_next(&it->cur, rec);
     @@ reftable/iter.h (new)
      +#include "slice.h"
      +
      +struct reftable_iterator_vtable {
     -+	int (*next)(void *iter_arg, struct record rec);
     ++	int (*next)(void *iter_arg, struct reftable_record *rec);
      +	void (*close)(void *iter_arg);
      +};
      +
      +void iterator_set_empty(struct reftable_iterator *it);
     -+int iterator_next(struct reftable_iterator it, struct record rec);
     ++int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
      +
      +/* Returns true for a zeroed out iterator, such as the one returned from
      +   iterator_destroy. */
     -+bool iterator_is_null(struct reftable_iterator it);
     ++bool iterator_is_null(struct reftable_iterator *it);
      +
      +/* iterator that produces only ref records that point to `oid` */
      +struct filtering_ref_iterator {
     @@ reftable/merged.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < mi->stack_len; i++) {
     -+		struct record rec = new_record(mi->typ);
     -+		int err = iterator_next(mi->stack[i], rec);
     ++		struct reftable_record rec = reftable_new_record(mi->typ);
     ++		int err = iterator_next(&mi->stack[i], &rec);
      +		if (err < 0) {
      +			return err;
      +		}
      +
      +		if (err > 0) {
      +			reftable_iterator_destroy(&mi->stack[i]);
     -+			record_destroy(&rec);
     ++			reftable_record_destroy(&rec);
      +		} else {
      +			struct pq_entry e = {
      +				.rec = rec,
     @@ reftable/merged.c (new)
      +	reftable_free(mi->stack);
      +}
      +
     -+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
     ++static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
     ++					       size_t idx)
      +{
     -+	if (iterator_is_null(mi->stack[idx])) {
     -+		return 0;
     ++	struct reftable_record rec = reftable_new_record(mi->typ);
     ++	struct pq_entry e = {
     ++		.rec = rec,
     ++		.index = idx,
     ++	};
     ++	int err = iterator_next(&mi->stack[idx], &rec);
     ++	if (err < 0) {
     ++		return err;
      +	}
      +
     -+	{
     -+		struct record rec = new_record(mi->typ);
     -+		struct pq_entry e = {
     -+			.rec = rec,
     -+			.index = idx,
     -+		};
     -+		int err = iterator_next(mi->stack[idx], rec);
     -+		if (err < 0) {
     -+			return err;
     -+		}
     ++	if (err > 0) {
     ++		reftable_iterator_destroy(&mi->stack[idx]);
     ++		reftable_record_destroy(&rec);
     ++		return 0;
     ++	}
      +
     -+		if (err > 0) {
     -+			reftable_iterator_destroy(&mi->stack[idx]);
     -+			record_destroy(&rec);
     -+			return 0;
     -+		}
     ++	merged_iter_pqueue_add(&mi->pq, e);
     ++	return 0;
     ++}
      +
     -+		merged_iter_pqueue_add(&mi->pq, e);
     ++static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
     ++{
     ++	if (iterator_is_null(&mi->stack[idx])) {
     ++		return 0;
      +	}
     -+	return 0;
     ++	return merged_iter_advance_nonnull_subiter(mi, idx);
      +}
      +
     -+static int merged_iter_next_entry(struct merged_iter *mi, struct record rec)
     ++static int merged_iter_next_entry(struct merged_iter *mi,
     ++				  struct reftable_record *rec)
      +{
      +	struct slice entry_key = { 0 };
      +	struct pq_entry entry = { 0 };
     @@ reftable/merged.c (new)
      +	  such a deployment, the loop below must be changed to collect all
      +	  entries for the same key, and return new the newest one.
      +	*/
     -+	record_key(entry.rec, &entry_key);
     ++	reftable_record_key(&entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
      +		struct slice k = { 0 };
      +		int err = 0, cmp = 0;
      +
     -+		record_key(top.rec, &k);
     ++		reftable_record_key(&top.rec, &k);
      +
     -+		cmp = slice_compare(k, entry_key);
     -+		slice_clear(&k);
     ++		cmp = slice_cmp(k, entry_key);
     ++		slice_release(&k);
      +
      +		if (cmp > 0) {
      +			break;
     @@ reftable/merged.c (new)
      +		if (err < 0) {
      +			return err;
      +		}
     -+		record_destroy(&top.rec);
     ++		reftable_record_destroy(&top.rec);
      +	}
      +
     -+	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
     -+	record_destroy(&entry.rec);
     -+	slice_clear(&entry_key);
     ++	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
     ++	reftable_record_destroy(&entry.rec);
     ++	slice_release(&entry_key);
      +	return 0;
      +}
      +
     -+static int merged_iter_next(struct merged_iter *mi, struct record rec)
     ++static int merged_iter_next(struct merged_iter *mi, struct reftable_record *rec)
      +{
      +	while (true) {
      +		int err = merged_iter_next_entry(mi, rec);
      +		if (err == 0 && mi->suppress_deletions &&
     -+		    record_is_deletion(rec)) {
     ++		    reftable_record_is_deletion(rec)) {
      +			continue;
      +		}
      +
     @@ reftable/merged.c (new)
      +	}
      +}
      +
     -+static int merged_iter_next_void(void *p, struct record rec)
     ++static int merged_iter_next_void(void *p, struct reftable_record *rec)
      +{
      +	struct merged_iter *mi = (struct merged_iter *)p;
      +	if (merged_iter_pqueue_is_empty(mi->pq)) {
     @@ reftable/merged.c (new)
      +			      struct reftable_reader **stack, int n,
      +			      uint32_t hash_id)
      +{
     ++	struct reftable_merged_table *m = NULL;
      +	uint64_t last_max = 0;
      +	uint64_t first_min = 0;
      +	int i = 0;
     @@ reftable/merged.c (new)
      +		last_max = reftable_reader_max_update_index(r);
      +	}
      +
     -+	{
     -+		struct reftable_merged_table m = {
     -+			.stack = stack,
     -+			.stack_len = n,
     -+			.min = first_min,
     -+			.max = last_max,
     -+			.hash_id = hash_id,
     -+		};
     -+
     -+		*dest = reftable_calloc(sizeof(struct reftable_merged_table));
     -+		**dest = m;
     -+	}
     ++	m = (struct reftable_merged_table *)reftable_calloc(
     ++		sizeof(struct reftable_merged_table));
     ++	m->stack = stack;
     ++	m->stack_len = n;
     ++	m->min = first_min;
     ++	m->max = last_max;
     ++	m->hash_id = hash_id;
     ++	*dest = m;
      +	return 0;
      +}
      +
     @@ reftable/merged.c (new)
      +}
      +
      +int merged_table_seek_record(struct reftable_merged_table *mt,
     -+			     struct reftable_iterator *it, struct record rec)
     ++			     struct reftable_iterator *it,
     ++			     struct reftable_record *rec)
      +{
      +	struct reftable_iterator *iters = reftable_calloc(
      +		sizeof(struct reftable_iterator) * mt->stack_len);
      +	struct merged_iter merged = {
      +		.stack = iters,
     -+		.typ = record_type(rec),
     ++		.typ = reftable_record_type(rec),
      +		.hash_id = mt->hash_id,
      +		.suppress_deletions = mt->suppress_deletions,
      +	};
     @@ reftable/merged.c (new)
      +	struct reftable_ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
     -+	struct record rec = { 0 };
     -+	record_from_ref(&rec, &ref);
     -+	return merged_table_seek_record(mt, it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_ref(&rec, &ref);
     ++	return merged_table_seek_record(mt, it, &rec);
      +}
      +
      +int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     @@ reftable/merged.c (new)
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct record rec = { 0 };
     -+	record_from_log(&rec, &log);
     -+	return merged_table_seek_record(mt, it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_log(&rec, &log);
     ++	return merged_table_seek_record(mt, it, &rec);
      +}
      +
      +int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     @@ reftable/merged.h (new)
      +
      +void merged_table_clear(struct reftable_merged_table *mt);
      +int merged_table_seek_record(struct reftable_merged_table *mt,
     -+			     struct reftable_iterator *it, struct record rec);
     ++			     struct reftable_iterator *it,
     ++			     struct reftable_record *rec);
      +
      +#endif
      
     @@ reftable/pq.c (new)
      +	struct slice ak = { 0 };
      +	struct slice bk = { 0 };
      +	int cmp = 0;
     -+	record_key(a.rec, &ak);
     -+	record_key(b.rec, &bk);
     ++	reftable_record_key(&a.rec, &ak);
     ++	reftable_record_key(&b.rec, &bk);
      +
     -+	cmp = slice_compare(ak, bk);
     ++	cmp = slice_cmp(ak, bk);
      +
     -+	slice_clear(&ak);
     -+	slice_clear(&bk);
     ++	slice_release(&ak);
     ++	slice_release(&bk);
      +
      +	if (cmp == 0) {
      +		return a.index > b.index;
     @@ reftable/pq.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < pq->len; i++) {
     -+		record_destroy(&pq->heap[i].rec);
     ++		reftable_record_destroy(&pq->heap[i].rec);
      +	}
      +	FREE_AND_NULL(pq->heap);
      +	pq->len = pq->cap = 0;
     @@ reftable/pq.h (new)
      +
      +struct pq_entry {
      +	int index;
     -+	struct record rec;
     ++	struct reftable_record rec;
      +};
      +
      +int pq_less(struct pq_entry a, struct pq_entry b);
     @@ reftable/reader.c (new)
      +#include "reftable.h"
      +#include "tree.h"
      +
     -+uint64_t block_source_size(struct reftable_block_source source)
     ++uint64_t block_source_size(struct reftable_block_source *source)
      +{
     -+	return source.ops->size(source.arg);
     ++	return source->ops->size(source->arg);
      +}
      +
     -+int block_source_read_block(struct reftable_block_source source,
     ++int block_source_read_block(struct reftable_block_source *source,
      +			    struct reftable_block *dest, uint64_t off,
      +			    uint32_t size)
      +{
     -+	int result = source.ops->read_block(source.arg, dest, off, size);
     -+	dest->source = source;
     ++	int result = source->ops->read_block(source->arg, dest, off, size);
     ++	dest->source = *source;
      +	return result;
      +}
      +
     @@ reftable/reader.c (new)
      +		sz = r->size - off;
      +	}
      +
     -+	return block_source_read_block(r->source, dest, off, sz);
     ++	return block_source_read_block(&r->source, dest, off, sz);
      +}
      +
      +uint32_t reftable_reader_hash_id(struct reftable_reader *r)
     @@ reftable/reader.c (new)
      +static int parse_footer(struct reftable_reader *r, byte *footer, byte *header)
      +{
      +	byte *f = footer;
     ++	byte first_block_typ;
      +	int err = 0;
     ++	uint32_t computed_crc;
     ++	uint32_t file_crc;
     ++
      +	if (memcmp(f, "REFT", 4)) {
      +		err = REFTABLE_FORMAT_ERROR;
      +		goto exit;
     @@ reftable/reader.c (new)
      +	r->log_offsets.index_offset = get_be64(f);
      +	f += 8;
      +
     -+	{
     -+		uint32_t computed_crc = crc32(0, footer, f - footer);
     -+		uint32_t file_crc = get_be32(f);
     -+		f += 4;
     -+		if (computed_crc != file_crc) {
     -+			err = REFTABLE_FORMAT_ERROR;
     -+			goto exit;
     -+		}
     ++	computed_crc = crc32(0, footer, f - footer);
     ++	file_crc = get_be32(f);
     ++	f += 4;
     ++	if (computed_crc != file_crc) {
     ++		err = REFTABLE_FORMAT_ERROR;
     ++		goto exit;
      +	}
      +
     -+	{
     -+		byte first_block_typ = header[header_size(r->version)];
     -+		r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
     -+		r->ref_offsets.offset = 0;
     -+		r->log_offsets.present = (first_block_typ == BLOCK_TYPE_LOG ||
     -+					  r->log_offsets.offset > 0);
     -+		r->obj_offsets.present = r->obj_offsets.offset > 0;
     -+	}
     ++	first_block_typ = header[header_size(r->version)];
     ++	r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
     ++	r->ref_offsets.offset = 0;
     ++	r->log_offsets.present = (first_block_typ == BLOCK_TYPE_LOG ||
     ++				  r->log_offsets.offset > 0);
     ++	r->obj_offsets.present = r->obj_offsets.offset > 0;
      +	err = 0;
      +exit:
      +	return err;
      +}
      +
     -+int init_reader(struct reftable_reader *r, struct reftable_block_source source,
     ++int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
      +		const char *name)
      +{
      +	struct reftable_block footer = { 0 };
     @@ reftable/reader.c (new)
      +	}
      +
      +	r->size = block_source_size(source) - footer_size(r->version);
     -+	r->source = source;
     ++	r->source = *source;
      +	r->name = xstrdup(name);
      +	r->hash_id = 0;
      +
     @@ reftable/reader.c (new)
      +	block_iter_copy_from(&dest->bi, &src->bi);
      +}
      +
     -+static int table_iter_next_in_block(struct table_iter *ti, struct record rec)
     ++static int table_iter_next_in_block(struct table_iter *ti,
     ++				    struct reftable_record *rec)
      +{
      +	int res = block_iter_next(&ti->bi, rec);
     -+	if (res == 0 && record_type(rec) == BLOCK_TYPE_REF) {
     -+		((struct reftable_ref_record *)rec.data)->update_index +=
     ++	if (res == 0 && reftable_record_type(rec) == BLOCK_TYPE_REF) {
     ++		((struct reftable_ref_record *)rec->data)->update_index +=
      +			ti->r->min_update_index;
      +	}
      +
     @@ reftable/reader.c (new)
      +	}
      +
      +	*typ = data[0];
     -+	if (is_block_type(*typ)) {
     ++	if (reftable_is_block_type(*typ)) {
      +		result = get_be24(data + 1);
      +	}
      +	return result;
     @@ reftable/reader.c (new)
      +	return 0;
      +}
      +
     -+static int table_iter_next(struct table_iter *ti, struct record rec)
     ++static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
      +{
     -+	if (record_type(rec) != ti->typ) {
     ++	if (reftable_record_type(rec) != ti->typ) {
      +		return REFTABLE_API_ERROR;
      +	}
      +
     @@ reftable/reader.c (new)
      +	}
      +}
      +
     -+static int table_iter_next_void(void *ti, struct record rec)
     ++static int table_iter_next_void(void *ti, struct reftable_record *rec)
      +{
      +	return table_iter_next((struct table_iter *)ti, rec);
      +}
     @@ reftable/reader.c (new)
      +}
      +
      +static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
     -+			      struct record want)
     ++			      struct reftable_record *want)
      +{
     -+	struct record rec = new_record(record_type(want));
     ++	struct reftable_record rec =
     ++		reftable_new_record(reftable_record_type(want));
      +	struct slice want_key = { 0 };
      +	struct slice got_key = { 0 };
      +	struct table_iter next = { 0 };
      +	int err = -1;
     -+	record_key(want, &want_key);
     ++	reftable_record_key(want, &want_key);
      +
      +	while (true) {
      +		err = table_iter_next_block(&next, ti);
     @@ reftable/reader.c (new)
      +			goto exit;
      +		}
      +		{
     -+			int cmp = slice_compare(got_key, want_key);
     ++			int cmp = slice_cmp(got_key, want_key);
      +			if (cmp > 0) {
      +				table_iter_block_done(&next);
      +				break;
     @@ reftable/reader.c (new)
      +
      +exit:
      +	block_iter_close(&next.bi);
     -+	record_destroy(&rec);
     -+	slice_clear(&want_key);
     -+	slice_clear(&got_key);
     ++	reftable_record_destroy(&rec);
     ++	slice_release(&want_key);
     ++	slice_release(&got_key);
      +	return err;
      +}
      +
      +static int reader_seek_indexed(struct reftable_reader *r,
     -+			       struct reftable_iterator *it, struct record rec)
     ++			       struct reftable_iterator *it,
     ++			       struct reftable_record *rec)
      +{
     -+	struct index_record want_index = { 0 };
     -+	struct record want_index_rec = { 0 };
     -+	struct index_record index_result = { 0 };
     -+	struct record index_result_rec = { 0 };
     ++	struct reftable_index_record want_index = { 0 };
     ++	struct reftable_record want_index_rec = { 0 };
     ++	struct reftable_index_record index_result = { 0 };
     ++	struct reftable_record index_result_rec = { 0 };
      +	struct table_iter index_iter = { 0 };
      +	struct table_iter next = { 0 };
      +	int err = 0;
      +
     -+	record_key(rec, &want_index.last_key);
     -+	record_from_index(&want_index_rec, &want_index);
     -+	record_from_index(&index_result_rec, &index_result);
     ++	reftable_record_key(rec, &want_index.last_key);
     ++	reftable_record_from_index(&want_index_rec, &want_index);
     ++	reftable_record_from_index(&index_result_rec, &index_result);
      +
     -+	err = reader_start(r, &index_iter, record_type(rec), true);
     ++	err = reader_start(r, &index_iter, reftable_record_type(rec), true);
      +	if (err < 0) {
      +		goto exit;
      +	}
      +
     -+	err = reader_seek_linear(r, &index_iter, want_index_rec);
     ++	err = reader_seek_linear(r, &index_iter, &want_index_rec);
      +	while (true) {
     -+		err = table_iter_next(&index_iter, index_result_rec);
     ++		err = table_iter_next(&index_iter, &index_result_rec);
      +		table_iter_block_done(&index_iter);
      +		if (err != 0) {
      +			goto exit;
     @@ reftable/reader.c (new)
      +			goto exit;
      +		}
      +
     -+		if (next.typ == record_type(rec)) {
     ++		if (next.typ == reftable_record_type(rec)) {
      +			err = 0;
      +			break;
      +		}
     @@ reftable/reader.c (new)
      +exit:
      +	block_iter_close(&next.bi);
      +	table_iter_close(&index_iter);
     -+	record_clear(want_index_rec);
     -+	record_clear(index_result_rec);
     ++	reftable_record_clear(&want_index_rec);
     ++	reftable_record_clear(&index_result_rec);
      +	return err;
      +}
      +
      +static int reader_seek_internal(struct reftable_reader *r,
     -+				struct reftable_iterator *it, struct record rec)
     ++				struct reftable_iterator *it,
     ++				struct reftable_record *rec)
      +{
      +	struct reftable_reader_offsets *offs =
     -+		reader_offsets_for(r, record_type(rec));
     ++		reader_offsets_for(r, reftable_record_type(rec));
      +	uint64_t idx = offs->index_offset;
      +	struct table_iter ti = { 0 };
      +	int err = 0;
     @@ reftable/reader.c (new)
      +		return reader_seek_indexed(r, it, rec);
      +	}
      +
     -+	err = reader_start(r, &ti, record_type(rec), false);
     ++	err = reader_start(r, &ti, reftable_record_type(rec), false);
      +	if (err < 0) {
      +		return err;
      +	}
     @@ reftable/reader.c (new)
      +}
      +
      +int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     -+		struct record rec)
     ++		struct reftable_record *rec)
      +{
     -+	byte typ = record_type(rec);
     ++	byte typ = reftable_record_type(rec);
      +
      +	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
      +	if (!offs->present) {
     @@ reftable/reader.c (new)
      +	struct reftable_ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
     -+	struct record rec = { 0 };
     -+	record_from_ref(&rec, &ref);
     -+	return reader_seek(r, it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_ref(&rec, &ref);
     ++	return reader_seek(r, it, &rec);
      +}
      +
      +int reftable_reader_seek_log_at(struct reftable_reader *r,
     @@ reftable/reader.c (new)
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct record rec = { 0 };
     -+	record_from_log(&rec, &log);
     -+	return reader_seek(r, it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_log(&rec, &log);
     ++	return reader_seek(r, it, &rec);
      +}
      +
      +int reftable_reader_seek_log(struct reftable_reader *r,
     @@ reftable/reader.c (new)
      +}
      +
      +int reftable_new_reader(struct reftable_reader **p,
     -+			struct reftable_block_source src, char const *name)
     ++			struct reftable_block_source *src, char const *name)
      +{
      +	struct reftable_reader *rd =
      +		reftable_calloc(sizeof(struct reftable_reader));
     @@ reftable/reader.c (new)
      +	if (err == 0) {
      +		*p = rd;
      +	} else {
     -+		block_source_close(&src);
     ++		block_source_close(src);
      +		reftable_free(rd);
      +	}
      +	return err;
     @@ reftable/reader.c (new)
      +					    struct reftable_iterator *it,
      +					    byte *oid)
      +{
     -+	struct obj_record want = {
     ++	struct reftable_obj_record want = {
      +		.hash_prefix = oid,
      +		.hash_prefix_len = r->object_id_len,
      +	};
     -+	struct record want_rec = { 0 };
     ++	struct reftable_record want_rec = { 0 };
      +	struct reftable_iterator oit = { 0 };
     -+	struct obj_record got = { 0 };
     -+	struct record got_rec = { 0 };
     ++	struct reftable_obj_record got = { 0 };
     ++	struct reftable_record got_rec = { 0 };
      +	int err = 0;
     ++	struct indexed_table_ref_iter *itr = NULL;
      +
      +	/* Look through the reverse index. */
     -+	record_from_obj(&want_rec, &want);
     -+	err = reader_seek(r, &oit, want_rec);
     ++	reftable_record_from_obj(&want_rec, &want);
     ++	err = reader_seek(r, &oit, &want_rec);
      +	if (err != 0) {
      +		goto exit;
      +	}
      +
     -+	/* read out the obj_record */
     -+	record_from_obj(&got_rec, &got);
     -+	err = iterator_next(oit, got_rec);
     ++	/* read out the reftable_obj_record */
     ++	reftable_record_from_obj(&got_rec, &got);
     ++	err = iterator_next(&oit, &got_rec);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ reftable/reader.c (new)
      +		goto exit;
      +	}
      +
     -+	{
     -+		struct indexed_table_ref_iter *itr = NULL;
     -+		err = new_indexed_table_ref_iter(&itr, r, oid,
     -+						 hash_size(r->hash_id),
     -+						 got.offsets, got.offset_len);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     -+		got.offsets = NULL;
     -+		iterator_from_indexed_table_ref_iter(it, itr);
     ++	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
     ++					 got.offsets, got.offset_len);
     ++	if (err < 0) {
     ++		goto exit;
      +	}
     ++	got.offsets = NULL;
     ++	iterator_from_indexed_table_ref_iter(it, itr);
      +
      +exit:
      +	reftable_iterator_destroy(&oit);
     -+	record_clear(got_rec);
     ++	reftable_record_clear(&got_rec);
      +	return err;
      +}
      +
     @@ reftable/reader.h (new)
      +#include "record.h"
      +#include "reftable.h"
      +
     -+uint64_t block_source_size(struct reftable_block_source source);
     ++uint64_t block_source_size(struct reftable_block_source *source);
      +
     -+int block_source_read_block(struct reftable_block_source source,
     ++int block_source_read_block(struct reftable_block_source *source,
      +			    struct reftable_block *dest, uint64_t off,
      +			    uint32_t size);
      +void block_source_close(struct reftable_block_source *source);
     @@ reftable/reader.h (new)
      +	struct reftable_reader_offsets log_offsets;
      +};
      +
     -+int init_reader(struct reftable_reader *r, struct reftable_block_source source,
     ++int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
      +		const char *name);
      +int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     -+		struct record rec);
     ++		struct reftable_record *rec);
      +void reader_close(struct reftable_reader *r);
      +const char *reader_name(struct reftable_reader *r);
      +
     @@ reftable/record.c (new)
      +{
      +	byte buf[10] = { 0 };
      +	int i = 9;
     ++	int n = 0;
      +	buf[i] = (byte)(val & 0x7f);
      +	i--;
      +	while (true) {
     @@ reftable/record.c (new)
      +		i--;
      +	}
      +
     -+	{
     -+		int n = sizeof(buf) - i - 1;
     -+		if (dest.len < n) {
     -+			return -1;
     -+		}
     -+		memcpy(dest.buf, &buf[i + 1], n);
     -+		return n;
     ++	n = sizeof(buf) - i - 1;
     ++	if (dest.len < n) {
     ++		return -1;
      +	}
     ++	memcpy(dest.buf, &buf[i + 1], n);
     ++	return n;
      +}
      +
     -+int is_block_type(byte typ)
     ++int reftable_is_block_type(byte typ)
      +{
      +	switch (typ) {
      +	case BLOCK_TYPE_REF:
     @@ reftable/record.c (new)
      +	return start.len - s.len;
      +}
      +
     -+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
     -+	       struct slice key, byte extra)
     ++int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
     ++			struct slice key, byte extra)
      +{
      +	struct slice start = dest;
      +	int prefix_len = common_prefix_size(prev_key, key);
     @@ reftable/record.c (new)
      +	return start.len - dest.len;
      +}
      +
     -+int decode_key(struct slice *key, byte *extra, struct slice last_key,
     -+	       struct slice in)
     ++int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
     ++			struct slice in)
      +{
      +	int start_len = in.len;
      +	uint64_t prefix_len = 0;
     @@ reftable/record.c (new)
      +		(const struct reftable_ref_record *)p);
      +}
      +
     -+struct record_vtable reftable_ref_record_vtable = {
     ++struct reftable_record_vtable reftable_ref_record_vtable = {
      +	.key = &reftable_ref_record_key,
      +	.type = BLOCK_TYPE_REF,
      +	.copy_from = &reftable_ref_record_copy_from,
     @@ reftable/record.c (new)
      +	.is_deletion = &reftable_ref_record_is_deletion_void,
      +};
      +
     -+static void obj_record_key(const void *r, struct slice *dest)
     ++static void reftable_obj_record_key(const void *r, struct slice *dest)
      +{
     -+	const struct obj_record *rec = (const struct obj_record *)r;
     ++	const struct reftable_obj_record *rec =
     ++		(const struct reftable_obj_record *)r;
      +	slice_resize(dest, rec->hash_prefix_len);
      +	memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
      +}
      +
     -+static void obj_record_clear(void *rec)
     ++static void reftable_obj_record_clear(void *rec)
      +{
     -+	struct obj_record *obj = (struct obj_record *)rec;
     ++	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
      +	FREE_AND_NULL(obj->hash_prefix);
      +	FREE_AND_NULL(obj->offsets);
     -+	memset(obj, 0, sizeof(struct obj_record));
     ++	memset(obj, 0, sizeof(struct reftable_obj_record));
      +}
      +
     -+static void obj_record_copy_from(void *rec, const void *src_rec, int hash_size)
     ++static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
     ++					  int hash_size)
      +{
     -+	struct obj_record *obj = (struct obj_record *)rec;
     -+	const struct obj_record *src = (const struct obj_record *)src_rec;
     ++	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
     ++	const struct reftable_obj_record *src =
     ++		(const struct reftable_obj_record *)src_rec;
      +
     -+	obj_record_clear(obj);
     ++	reftable_obj_record_clear(obj);
      +	*obj = *src;
      +	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
      +	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
     @@ reftable/record.c (new)
      +	}
      +}
      +
     -+static byte obj_record_val_type(const void *rec)
     ++static byte reftable_obj_record_val_type(const void *rec)
      +{
     -+	struct obj_record *r = (struct obj_record *)rec;
     ++	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
      +	if (r->offset_len > 0 && r->offset_len < 8) {
      +		return r->offset_len;
      +	}
      +	return 0;
      +}
      +
     -+static int obj_record_encode(const void *rec, struct slice s, int hash_size)
     ++static int reftable_obj_record_encode(const void *rec, struct slice s,
     ++				      int hash_size)
      +{
     -+	struct obj_record *r = (struct obj_record *)rec;
     ++	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
      +	struct slice start = s;
     ++	int i = 0;
      +	int n = 0;
     ++	uint64_t last = 0;
      +	if (r->offset_len == 0 || r->offset_len >= 8) {
      +		n = put_var_int(s, r->offset_len);
      +		if (n < 0) {
     @@ reftable/record.c (new)
      +	}
      +	slice_consume(&s, n);
      +
     -+	{
     -+		uint64_t last = r->offsets[0];
     -+		int i = 0;
     -+		for (i = 1; i < r->offset_len; i++) {
     -+			int n = put_var_int(s, r->offsets[i] - last);
     -+			if (n < 0) {
     -+				return -1;
     -+			}
     -+			slice_consume(&s, n);
     -+			last = r->offsets[i];
     ++	last = r->offsets[0];
     ++	for (i = 1; i < r->offset_len; i++) {
     ++		int n = put_var_int(s, r->offsets[i] - last);
     ++		if (n < 0) {
     ++			return -1;
      +		}
     ++		slice_consume(&s, n);
     ++		last = r->offsets[i];
      +	}
      +	return start.len - s.len;
      +}
      +
     -+static int obj_record_decode(void *rec, struct slice key, byte val_type,
     -+			     struct slice in, int hash_size)
     ++static int reftable_obj_record_decode(void *rec, struct slice key,
     ++				      byte val_type, struct slice in,
     ++				      int hash_size)
      +{
      +	struct slice start = in;
     -+	struct obj_record *r = (struct obj_record *)rec;
     ++	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
      +	uint64_t count = val_type;
      +	int n = 0;
     ++	uint64_t last;
     ++	int j;
      +	r->hash_prefix = reftable_malloc(key.len);
      +	memcpy(r->hash_prefix, key.buf, key.len);
      +	r->hash_prefix_len = key.len;
     @@ reftable/record.c (new)
      +	}
      +	slice_consume(&in, n);
      +
     -+	{
     -+		uint64_t last = r->offsets[0];
     -+		int j = 1;
     -+		while (j < count) {
     -+			uint64_t delta = 0;
     -+			int n = get_var_int(&delta, in);
     -+			if (n < 0) {
     -+				return n;
     -+			}
     -+			slice_consume(&in, n);
     -+
     -+			last = r->offsets[j] = (delta + last);
     -+			j++;
     ++	last = r->offsets[0];
     ++	j = 1;
     ++	while (j < count) {
     ++		uint64_t delta = 0;
     ++		int n = get_var_int(&delta, in);
     ++		if (n < 0) {
     ++			return n;
      +		}
     ++		slice_consume(&in, n);
     ++
     ++		last = r->offsets[j] = (delta + last);
     ++		j++;
      +	}
      +	return start.len - in.len;
      +}
     @@ reftable/record.c (new)
      +	return false;
      +}
      +
     -+struct record_vtable obj_record_vtable = {
     -+	.key = &obj_record_key,
     ++struct reftable_record_vtable reftable_obj_record_vtable = {
     ++	.key = &reftable_obj_record_key,
      +	.type = BLOCK_TYPE_OBJ,
     -+	.copy_from = &obj_record_copy_from,
     -+	.val_type = &obj_record_val_type,
     -+	.encode = &obj_record_encode,
     -+	.decode = &obj_record_decode,
     -+	.clear = &obj_record_clear,
     ++	.copy_from = &reftable_obj_record_copy_from,
     ++	.val_type = &reftable_obj_record_val_type,
     ++	.encode = &reftable_obj_record_encode,
     ++	.decode = &reftable_obj_record_decode,
     ++	.clear = &reftable_obj_record_clear,
      +	.is_deletion = not_a_deletion,
      +};
      +
     @@ reftable/record.c (new)
      +	memcpy(r->message, dest.buf, dest.len);
      +	r->message[dest.len] = 0;
      +
     -+	slice_clear(&dest);
     ++	slice_release(&dest);
      +	return start.len - in.len;
      +
      +error:
     -+	slice_clear(&dest);
     ++	slice_release(&dest);
      +	return REFTABLE_FORMAT_ERROR;
      +}
      +
     @@ reftable/record.c (new)
      +		(const struct reftable_log_record *)p);
      +}
      +
     -+struct record_vtable reftable_log_record_vtable = {
     ++struct reftable_record_vtable reftable_log_record_vtable = {
      +	.key = &reftable_log_record_key,
      +	.type = BLOCK_TYPE_LOG,
      +	.copy_from = &reftable_log_record_copy_from,
     @@ reftable/record.c (new)
      +	.is_deletion = &reftable_log_record_is_deletion_void,
      +};
      +
     -+struct record new_record(byte typ)
     ++struct reftable_record reftable_new_record(byte typ)
      +{
     -+	struct record rec = { NULL };
     ++	struct reftable_record rec = { NULL };
      +	switch (typ) {
      +	case BLOCK_TYPE_REF: {
      +		struct reftable_ref_record *r =
      +			reftable_calloc(sizeof(struct reftable_ref_record));
     -+		record_from_ref(&rec, r);
     ++		reftable_record_from_ref(&rec, r);
      +		return rec;
      +	}
      +
      +	case BLOCK_TYPE_OBJ: {
     -+		struct obj_record *r =
     -+			reftable_calloc(sizeof(struct obj_record));
     -+		record_from_obj(&rec, r);
     ++		struct reftable_obj_record *r =
     ++			reftable_calloc(sizeof(struct reftable_obj_record));
     ++		reftable_record_from_obj(&rec, r);
      +		return rec;
      +	}
      +	case BLOCK_TYPE_LOG: {
      +		struct reftable_log_record *r =
      +			reftable_calloc(sizeof(struct reftable_log_record));
     -+		record_from_log(&rec, r);
     ++		reftable_record_from_log(&rec, r);
      +		return rec;
      +	}
      +	case BLOCK_TYPE_INDEX: {
     -+		struct index_record *r =
     -+			reftable_calloc(sizeof(struct index_record));
     -+		record_from_index(&rec, r);
     ++		struct reftable_index_record *r =
     ++			reftable_calloc(sizeof(struct reftable_index_record));
     ++		reftable_record_from_index(&rec, r);
      +		return rec;
      +	}
      +	}
     @@ reftable/record.c (new)
      +	return rec;
      +}
      +
     -+void *record_yield(struct record *rec)
     ++void *reftable_record_yield(struct reftable_record *rec)
      +{
      +	void *p = rec->data;
      +	rec->data = NULL;
      +	return p;
      +}
      +
     -+void record_destroy(struct record *rec)
     ++void reftable_record_destroy(struct reftable_record *rec)
      +{
     -+	record_clear(*rec);
     -+	reftable_free(record_yield(rec));
     ++	reftable_record_clear(rec);
     ++	reftable_free(reftable_record_yield(rec));
      +}
      +
     -+static void index_record_key(const void *r, struct slice *dest)
     ++static void reftable_index_record_key(const void *r, struct slice *dest)
      +{
     -+	struct index_record *rec = (struct index_record *)r;
     ++	struct reftable_index_record *rec = (struct reftable_index_record *)r;
      +	slice_copy(dest, rec->last_key);
      +}
      +
     -+static void index_record_copy_from(void *rec, const void *src_rec,
     -+				   int hash_size)
     ++static void reftable_index_record_copy_from(void *rec, const void *src_rec,
     ++					    int hash_size)
      +{
     -+	struct index_record *dst = (struct index_record *)rec;
     -+	struct index_record *src = (struct index_record *)src_rec;
     ++	struct reftable_index_record *dst = (struct reftable_index_record *)rec;
     ++	struct reftable_index_record *src =
     ++		(struct reftable_index_record *)src_rec;
      +
      +	slice_copy(&dst->last_key, src->last_key);
      +	dst->offset = src->offset;
      +}
      +
     -+static void index_record_clear(void *rec)
     ++static void reftable_index_record_clear(void *rec)
      +{
     -+	struct index_record *idx = (struct index_record *)rec;
     -+	slice_clear(&idx->last_key);
     ++	struct reftable_index_record *idx = (struct reftable_index_record *)rec;
     ++	slice_release(&idx->last_key);
      +}
      +
     -+static byte index_record_val_type(const void *rec)
     ++static byte reftable_index_record_val_type(const void *rec)
      +{
      +	return 0;
      +}
      +
     -+static int index_record_encode(const void *rec, struct slice out, int hash_size)
     ++static int reftable_index_record_encode(const void *rec, struct slice out,
     ++					int hash_size)
      +{
     -+	const struct index_record *r = (const struct index_record *)rec;
     ++	const struct reftable_index_record *r =
     ++		(const struct reftable_index_record *)rec;
      +	struct slice start = out;
      +
      +	int n = put_var_int(out, r->offset);
     @@ reftable/record.c (new)
      +	return start.len - out.len;
      +}
      +
     -+static int index_record_decode(void *rec, struct slice key, byte val_type,
     -+			       struct slice in, int hash_size)
     ++static int reftable_index_record_decode(void *rec, struct slice key,
     ++					byte val_type, struct slice in,
     ++					int hash_size)
      +{
      +	struct slice start = in;
     -+	struct index_record *r = (struct index_record *)rec;
     ++	struct reftable_index_record *r = (struct reftable_index_record *)rec;
      +	int n = 0;
      +
      +	slice_copy(&r->last_key, key);
     @@ reftable/record.c (new)
      +	return start.len - in.len;
      +}
      +
     -+struct record_vtable index_record_vtable = {
     -+	.key = &index_record_key,
     ++struct reftable_record_vtable reftable_index_record_vtable = {
     ++	.key = &reftable_index_record_key,
      +	.type = BLOCK_TYPE_INDEX,
     -+	.copy_from = &index_record_copy_from,
     -+	.val_type = &index_record_val_type,
     -+	.encode = &index_record_encode,
     -+	.decode = &index_record_decode,
     -+	.clear = &index_record_clear,
     ++	.copy_from = &reftable_index_record_copy_from,
     ++	.val_type = &reftable_index_record_val_type,
     ++	.encode = &reftable_index_record_encode,
     ++	.decode = &reftable_index_record_decode,
     ++	.clear = &reftable_index_record_clear,
      +	.is_deletion = &not_a_deletion,
      +};
      +
     -+void record_key(struct record rec, struct slice *dest)
     ++void reftable_record_key(struct reftable_record *rec, struct slice *dest)
      +{
     -+	rec.ops->key(rec.data, dest);
     ++	rec->ops->key(rec->data, dest);
      +}
      +
     -+byte record_type(struct record rec)
     ++byte reftable_record_type(struct reftable_record *rec)
      +{
     -+	return rec.ops->type;
     ++	return rec->ops->type;
      +}
      +
     -+int record_encode(struct record rec, struct slice dest, int hash_size)
     ++int reftable_record_encode(struct reftable_record *rec, struct slice dest,
     ++			   int hash_size)
      +{
     -+	return rec.ops->encode(rec.data, dest, hash_size);
     ++	return rec->ops->encode(rec->data, dest, hash_size);
      +}
      +
     -+void record_copy_from(struct record rec, struct record src, int hash_size)
     ++void reftable_record_copy_from(struct reftable_record *rec,
     ++			       struct reftable_record *src, int hash_size)
      +{
     -+	assert(src.ops->type == rec.ops->type);
     ++	assert(src->ops->type == rec->ops->type);
      +
     -+	rec.ops->copy_from(rec.data, src.data, hash_size);
     ++	rec->ops->copy_from(rec->data, src->data, hash_size);
      +}
      +
     -+byte record_val_type(struct record rec)
     ++byte reftable_record_val_type(struct reftable_record *rec)
      +{
     -+	return rec.ops->val_type(rec.data);
     ++	return rec->ops->val_type(rec->data);
      +}
      +
     -+int record_decode(struct record rec, struct slice key, byte extra,
     -+		  struct slice src, int hash_size)
     ++int reftable_record_decode(struct reftable_record *rec, struct slice key,
     ++			   byte extra, struct slice src, int hash_size)
      +{
     -+	return rec.ops->decode(rec.data, key, extra, src, hash_size);
     ++	return rec->ops->decode(rec->data, key, extra, src, hash_size);
      +}
      +
     -+void record_clear(struct record rec)
     ++void reftable_record_clear(struct reftable_record *rec)
      +{
     -+	rec.ops->clear(rec.data);
     ++	rec->ops->clear(rec->data);
      +}
      +
     -+bool record_is_deletion(struct record rec)
     ++bool reftable_record_is_deletion(struct reftable_record *rec)
      +{
     -+	return rec.ops->is_deletion(rec.data);
     ++	return rec->ops->is_deletion(rec->data);
      +}
      +
     -+void record_from_ref(struct record *rec, struct reftable_ref_record *ref_rec)
     ++void reftable_record_from_ref(struct reftable_record *rec,
     ++			      struct reftable_ref_record *ref_rec)
      +{
      +	assert(rec->ops == NULL);
      +	rec->data = ref_rec;
      +	rec->ops = &reftable_ref_record_vtable;
      +}
      +
     -+void record_from_obj(struct record *rec, struct obj_record *obj_rec)
     ++void reftable_record_from_obj(struct reftable_record *rec,
     ++			      struct reftable_obj_record *obj_rec)
      +{
      +	assert(rec->ops == NULL);
      +	rec->data = obj_rec;
     -+	rec->ops = &obj_record_vtable;
     ++	rec->ops = &reftable_obj_record_vtable;
      +}
      +
     -+void record_from_index(struct record *rec, struct index_record *index_rec)
     ++void reftable_record_from_index(struct reftable_record *rec,
     ++				struct reftable_index_record *index_rec)
      +{
      +	assert(rec->ops == NULL);
      +	rec->data = index_rec;
     -+	rec->ops = &index_record_vtable;
     ++	rec->ops = &reftable_index_record_vtable;
      +}
      +
     -+void record_from_log(struct record *rec, struct reftable_log_record *log_rec)
     ++void reftable_record_from_log(struct reftable_record *rec,
     ++			      struct reftable_log_record *log_rec)
      +{
      +	assert(rec->ops == NULL);
      +	rec->data = log_rec;
      +	rec->ops = &reftable_log_record_vtable;
      +}
      +
     -+struct reftable_ref_record *record_as_ref(struct record rec)
     ++struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *rec)
      +{
     -+	assert(record_type(rec) == BLOCK_TYPE_REF);
     -+	return (struct reftable_ref_record *)rec.data;
     ++	assert(reftable_record_type(rec) == BLOCK_TYPE_REF);
     ++	return (struct reftable_ref_record *)rec->data;
      +}
      +
     -+struct reftable_log_record *record_as_log(struct record rec)
     ++struct reftable_log_record *reftable_record_as_log(struct reftable_record *rec)
      +{
     -+	assert(record_type(rec) == BLOCK_TYPE_LOG);
     -+	return (struct reftable_log_record *)rec.data;
     ++	assert(reftable_record_type(rec) == BLOCK_TYPE_LOG);
     ++	return (struct reftable_log_record *)rec->data;
      +}
      +
      +static bool hash_equal(byte *a, byte *b, int hash_size)
     @@ reftable/record.h (new)
      +int put_var_int(struct slice dest, uint64_t val);
      +
      +/* Methods for records. */
     -+struct record_vtable {
     ++struct reftable_record_vtable {
      +	/* encode the key of to a byte slice. */
      +	void (*key)(const void *rec, struct slice *dest);
      +
     @@ reftable/record.h (new)
      +};
      +
      +/* record is a generic wrapper for different types of records. */
     -+struct record {
     ++struct reftable_record {
      +	void *data;
     -+	struct record_vtable *ops;
     ++	struct reftable_record_vtable *ops;
      +};
      +
      +/* returns true for recognized block types. Block start with the block type. */
     -+int is_block_type(byte typ);
     ++int reftable_is_block_type(byte typ);
      +
      +/* creates a malloced record of the given type. Dispose with record_destroy */
     -+struct record new_record(byte typ);
     ++struct reftable_record reftable_new_record(byte typ);
      +
     -+extern struct record_vtable reftable_ref_record_vtable;
     ++extern struct reftable_record_vtable reftable_ref_record_vtable;
      +
      +/* Encode `key` into `dest`. Sets `restart` to indicate a restart. Returns
      +   number of bytes written. */
     -+int encode_key(bool *restart, struct slice dest, struct slice prev_key,
     -+	       struct slice key, byte extra);
     ++int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
     ++			struct slice key, byte extra);
      +
      +/* Decode into `key` and `extra` from `in` */
     -+int decode_key(struct slice *key, byte *extra, struct slice last_key,
     -+	       struct slice in);
     ++int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
     ++			struct slice in);
      +
     -+/* index_record are used internally to speed up lookups. */
     -+struct index_record {
     ++/* reftable_index_record are used internally to speed up lookups. */
     ++struct reftable_index_record {
      +	uint64_t offset; /* Offset of block */
      +	struct slice last_key; /* Last key of the block. */
      +};
      +
     -+/* obj_record stores an object ID => ref mapping. */
     -+struct obj_record {
     ++/* reftable_obj_record stores an object ID => ref mapping. */
     ++struct reftable_obj_record {
      +	byte *hash_prefix; /* leading bytes of the object ID */
      +	int hash_prefix_len; /* number of leading bytes. Constant
      +			      * across a single table. */
     @@ reftable/record.h (new)
      +
      +/* see struct record_vtable */
      +
     -+void record_key(struct record rec, struct slice *dest);
     -+byte record_type(struct record rec);
     -+void record_copy_from(struct record rec, struct record src, int hash_size);
     -+byte record_val_type(struct record rec);
     -+int record_encode(struct record rec, struct slice dest, int hash_size);
     -+int record_decode(struct record rec, struct slice key, byte extra,
     -+		  struct slice src, int hash_size);
     -+bool record_is_deletion(struct record rec);
     ++void reftable_record_key(struct reftable_record *rec, struct slice *dest);
     ++byte reftable_record_type(struct reftable_record *rec);
     ++void reftable_record_copy_from(struct reftable_record *rec,
     ++			       struct reftable_record *src, int hash_size);
     ++byte reftable_record_val_type(struct reftable_record *rec);
     ++int reftable_record_encode(struct reftable_record *rec, struct slice dest,
     ++			   int hash_size);
     ++int reftable_record_decode(struct reftable_record *rec, struct slice key,
     ++			   byte extra, struct slice src, int hash_size);
     ++bool reftable_record_is_deletion(struct reftable_record *rec);
      +
      +/* zeroes out the embedded record */
     -+void record_clear(struct record rec);
     ++void reftable_record_clear(struct reftable_record *rec);
      +
     -+/* clear out the record, yielding the record data that was encapsulated. */
     -+void *record_yield(struct record *rec);
     ++/* clear out the record, yielding the reftable_record data that was
     ++ * encapsulated. */
     ++void *reftable_record_yield(struct reftable_record *rec);
      +
      +/* clear and deallocate embedded record, and zero `rec`. */
     -+void record_destroy(struct record *rec);
     ++void reftable_record_destroy(struct reftable_record *rec);
      +
      +/* initialize generic records from concrete records. The generic record should
      + * be zeroed out. */
     -+void record_from_obj(struct record *rec, struct obj_record *objrec);
     -+void record_from_index(struct record *rec, struct index_record *idxrec);
     -+void record_from_ref(struct record *rec, struct reftable_ref_record *refrec);
     -+void record_from_log(struct record *rec, struct reftable_log_record *logrec);
     -+struct reftable_ref_record *record_as_ref(struct record ref);
     -+struct reftable_log_record *record_as_log(struct record ref);
     ++void reftable_record_from_obj(struct reftable_record *rec,
     ++			      struct reftable_obj_record *objrec);
     ++void reftable_record_from_index(struct reftable_record *rec,
     ++				struct reftable_index_record *idxrec);
     ++void reftable_record_from_ref(struct reftable_record *rec,
     ++			      struct reftable_ref_record *refrec);
     ++void reftable_record_from_log(struct reftable_record *rec,
     ++			      struct reftable_log_record *logrec);
     ++struct reftable_ref_record *reftable_record_as_ref(struct reftable_record *ref);
     ++struct reftable_log_record *reftable_record_as_log(struct reftable_record *ref);
      +
      +/* for qsort. */
      +int reftable_ref_record_compare_name(const void *a, const void *b);
     @@ reftable/refname.c (new)
      +		}
      +	}
      +
     -+	err = reftable_table_read_ref(mod->tab, name, &ref);
     ++	err = reftable_table_read_ref(&mod->tab, name, &ref);
      +	reftable_ref_record_clear(&ref);
      +	return err;
      +}
     @@ reftable/refname.c (new)
      +			goto exit;
      +		}
      +	}
     -+	err = reftable_table_seek_ref(mod->tab, &it, prefix);
     ++	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
      +	if (err) {
      +		goto exit;
      +	}
      +
      +	while (true) {
     -+		err = reftable_iterator_next_ref(it, &ref);
     ++		err = reftable_iterator_next_ref(&it, &ref);
      +		if (err) {
      +			goto exit;
      +		}
     @@ reftable/refname.c (new)
      +			goto exit;
      +		}
      +		slice_set_string(&slashed, mod->add[i]);
     -+		slice_append_string(&slashed, "/");
     ++		slice_addstr(&slashed, "/");
      +
      +		err = modification_has_ref_with_prefix(
      +			mod, slice_as_string(&slashed));
     @@ reftable/refname.c (new)
      +	}
      +	err = 0;
      +exit:
     -+	slice_clear(&slashed);
     ++	slice_release(&slashed);
      +	return err;
      +}
      
     @@ reftable/reftable.c (new)
      +#include "merged.h"
      +
      +struct reftable_table_vtable {
     -+	int (*seek)(void *tab, struct reftable_iterator *it, struct record);
     ++	int (*seek)(void *tab, struct reftable_iterator *it,
     ++		    struct reftable_record *);
      +};
      +
      +static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     -+				     struct record rec)
     ++				     struct reftable_record *rec)
      +{
      +	return reader_seek((struct reftable_reader *)tab, it, rec);
      +}
     @@ reftable/reftable.c (new)
      +
      +static int reftable_merged_table_seek_void(void *tab,
      +					   struct reftable_iterator *it,
     -+					   struct record rec)
     ++					   struct reftable_record *rec)
      +{
      +	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
      +					rec);
     @@ reftable/reftable.c (new)
      +	.seek = reftable_merged_table_seek_void,
      +};
      +
     -+int reftable_table_seek_ref(struct reftable_table tab,
     ++int reftable_table_seek_ref(struct reftable_table *tab,
      +			    struct reftable_iterator *it, const char *name)
      +{
      +	struct reftable_ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
     -+	struct record rec = { 0 };
     -+	record_from_ref(&rec, &ref);
     -+	return tab.ops->seek(tab.table_arg, it, rec);
     ++	struct reftable_record rec = { 0 };
     ++	reftable_record_from_ref(&rec, &ref);
     ++	return tab->ops->seek(tab->table_arg, it, &rec);
      +}
      +
      +void reftable_table_from_reader(struct reftable_table *tab,
     @@ reftable/reftable.c (new)
      +	tab->table_arg = merged;
      +}
      +
     -+int reftable_table_read_ref(struct reftable_table tab, const char *name,
     ++int reftable_table_read_ref(struct reftable_table *tab, const char *name,
      +			    struct reftable_ref_record *ref)
      +{
      +	struct reftable_iterator it = { 0 };
     @@ reftable/reftable.c (new)
      +		goto exit;
      +	}
      +
     -+	err = reftable_iterator_next_ref(it, ref);
     ++	err = reftable_iterator_next_ref(&it, ref);
      +	if (err) {
      +		goto exit;
      +	}
     @@ reftable/reftable.h (new)
      +/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
      +   end of iteration.
      +*/
     -+int reftable_iterator_next_ref(struct reftable_iterator it,
     ++int reftable_iterator_next_ref(struct reftable_iterator *it,
      +			       struct reftable_ref_record *ref);
      +
      +/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
      +   end of iteration.
      +*/
     -+int reftable_iterator_next_log(struct reftable_iterator it,
     ++int reftable_iterator_next_log(struct reftable_iterator *it,
      +			       struct reftable_log_record *log);
      +
      +/* releases resources associated with an iterator. */
     @@ reftable/reftable.h (new)
      + * closed on calling reftable_reader_destroy().
      + */
      +int reftable_new_reader(struct reftable_reader **pp,
     -+			struct reftable_block_source src, const char *name);
     ++			struct reftable_block_source *src, const char *name);
      +
      +/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
      +   in the table.  To seek to the start of the table, use name = "".
     @@ reftable/reftable.h (new)
      +   example:
      +
      +   struct reftable_reader *r = NULL;
     -+   int err = reftable_new_reader(&r, src, "filename");
     ++   int err = reftable_new_reader(&r, &src, "filename");
      +   if (err < 0) { ... }
      +   struct reftable_iterator it  = {0};
      +   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
      +   if (err < 0) { ... }
      +   struct reftable_ref_record ref  = {0};
      +   while (1) {
     -+     err = reftable_iterator_next_ref(it, &ref);
     ++     err = reftable_iterator_next_ref(&it, &ref);
      +     if (err > 0) {
      +       break;
      +     }
     @@ reftable/reftable.h (new)
      +	void *table_arg;
      +};
      +
     -+int reftable_table_seek_ref(struct reftable_table tab,
     ++int reftable_table_seek_ref(struct reftable_table *tab,
      +			    struct reftable_iterator *it, const char *name);
      +
      +void reftable_table_from_reader(struct reftable_table *tab,
     @@ reftable/reftable.h (new)
      +
      +/* convenience function to read a single ref. Returns < 0 for error, 0
      +   for success, and 1 if ref not found. */
     -+int reftable_table_read_ref(struct reftable_table tab, const char *name,
     ++int reftable_table_read_ref(struct reftable_table *tab, const char *name,
      +			    struct reftable_ref_record *ref);
      +
      +/****************************************************************
     @@ reftable/slice.c (new)
      +	s->len = l;
      +}
      +
     -+void slice_append_string(struct slice *d, const char *s)
     ++void slice_addstr(struct slice *d, const char *s)
      +{
      +	int l1 = d->len;
      +	int l2 = strlen(s);
     @@ reftable/slice.c (new)
      +	memcpy(d->buf + l1, s, l2);
      +}
      +
     -+void slice_append(struct slice *s, struct slice a)
     ++void slice_addbuf(struct slice *s, struct slice a)
      +{
      +	int end = s->len;
      +	slice_resize(s, s->len + a.len);
     @@ reftable/slice.c (new)
      +	s->len -= n;
      +}
      +
     -+byte *slice_yield(struct slice *s)
     ++byte *slice_detach(struct slice *s)
      +{
      +	byte *p = s->buf;
      +	s->buf = NULL;
     @@ reftable/slice.c (new)
      +	return p;
      +}
      +
     -+void slice_clear(struct slice *s)
     ++void slice_release(struct slice *s)
      +{
     -+	reftable_free(slice_yield(s));
     ++	reftable_free(slice_detach(s));
      +}
      +
      +void slice_copy(struct slice *dest, struct slice src)
     @@ reftable/slice.c (new)
      +	slice_resize(&s, in.len + 1);
      +	s.buf[in.len] = 0;
      +	memcpy(s.buf, in.buf, in.len);
     -+	return (char *)slice_yield(&s);
     ++	return (char *)slice_detach(&s);
      +}
      +
      +bool slice_equal(struct slice a, struct slice b)
     @@ reftable/slice.c (new)
      +	return memcmp(a.buf, b.buf, a.len) == 0;
      +}
      +
     -+int slice_compare(struct slice a, struct slice b)
     ++int slice_cmp(struct slice a, struct slice b)
      +{
      +	int min = a.len < b.len ? a.len : b.len;
      +	int res = memcmp(a.buf, b.buf, min);
     @@ reftable/slice.c (new)
      +	}
      +}
      +
     -+int slice_write(struct slice *b, byte *data, size_t sz)
     ++int slice_add(struct slice *b, byte *data, size_t sz)
      +{
      +	if (b->len + sz > b->cap) {
      +		int newcap = 2 * b->cap + 1;
     @@ reftable/slice.c (new)
      +	return sz;
      +}
      +
     -+int slice_write_void(void *b, byte *data, size_t sz)
     ++int slice_add_void(void *b, byte *data, size_t sz)
      +{
     -+	return slice_write((struct slice *)b, data, sz);
     ++	return slice_add((struct slice *)b, data, sz);
      +}
      +
      +static uint64_t slice_size(void *b)
     @@ reftable/slice.h (new)
      +};
      +
      +void slice_set_string(struct slice *dest, const char *src);
     -+void slice_append_string(struct slice *dest, const char *src);
     -+/* Set length to 0, but retain buffer */
     -+void slice_clear(struct slice *slice);
     ++void slice_addstr(struct slice *dest, const char *src);
     ++
     ++/* Deallocate and clear slice */
     ++void slice_release(struct slice *slice);
      +
      +/* Return a malloced string for `src` */
      +char *slice_to_string(struct slice src);
     @@ reftable/slice.h (new)
      +bool slice_equal(struct slice a, struct slice b);
      +
      +/* Return `buf`, clearing out `s` */
     -+byte *slice_yield(struct slice *s);
     ++byte *slice_detach(struct slice *s);
      +
      +/* Copy bytes */
      +void slice_copy(struct slice *dest, struct slice src);
     @@ reftable/slice.h (new)
      +void slice_resize(struct slice *s, int l);
      +
      +/* Signed comparison */
     -+int slice_compare(struct slice a, struct slice b);
     ++int slice_cmp(struct slice a, struct slice b);
      +
      +/* Append `data` to the `dest` slice.  */
     -+int slice_write(struct slice *dest, byte *data, size_t sz);
     ++int slice_add(struct slice *dest, byte *data, size_t sz);
      +
      +/* Append `add` to `dest. */
     -+void slice_append(struct slice *dest, struct slice add);
     ++void slice_addbuf(struct slice *dest, struct slice add);
      +
     -+/* Like slice_write, but suitable for passing to reftable_new_writer
     ++/* Like slice_add, but suitable for passing to reftable_new_writer
      + */
     -+int slice_write_void(void *b, byte *data, size_t sz);
     ++int slice_add_void(void *b, byte *data, size_t sz);
      +
      +/* Find the longest shared prefix size of `a` and `b` */
      +int common_prefix_size(struct slice a, struct slice b);
     @@ reftable/stack.c (new)
      +	*dest = NULL;
      +
      +	slice_set_string(&list_file_name, dir);
     -+	slice_append_string(&list_file_name, "/tables.list");
     ++	slice_addstr(&list_file_name, "/tables.list");
      +
      +	p->list_file = slice_to_string(list_file_name);
     -+	slice_clear(&list_file_name);
     ++	slice_release(&list_file_name);
      +	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
     @@ reftable/stack.c (new)
      +		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
      +	int new_tables_len = 0;
      +	struct reftable_merged_table *new_merged = NULL;
     -+
     ++	int i;
      +	struct slice table_path = { 0 };
      +
      +	while (*names) {
     @@ reftable/stack.c (new)
      +		if (rd == NULL) {
      +			struct reftable_block_source src = { 0 };
      +			slice_set_string(&table_path, st->reftable_dir);
     -+			slice_append_string(&table_path, "/");
     -+			slice_append_string(&table_path, name);
     ++			slice_addstr(&table_path, "/");
     ++			slice_addstr(&table_path, name);
      +
      +			err = reftable_block_source_from_file(
      +				&src, slice_as_string(&table_path));
     @@ reftable/stack.c (new)
      +				goto exit;
      +			}
      +
     -+			err = reftable_new_reader(&rd, src, name);
     ++			err = reftable_new_reader(&rd, &src, name);
      +			if (err < 0) {
      +				goto exit;
      +			}
     @@ reftable/stack.c (new)
      +	new_merged->suppress_deletions = true;
      +	st->merged = new_merged;
      +
     -+	{
     -+		int i = 0;
     -+		for (i = 0; i < cur_len; i++) {
     -+			if (cur[i] != NULL) {
     -+				reader_close(cur[i]);
     -+				reftable_reader_free(cur[i]);
     -+			}
     ++	for (i = 0; i < cur_len; i++) {
     ++		if (cur[i] != NULL) {
     ++			reader_close(cur[i]);
     ++			reftable_reader_free(cur[i]);
      +		}
      +	}
      +
      +exit:
     -+	slice_clear(&table_path);
     -+	{
     -+		int i = 0;
     -+		for (i = 0; i < new_tables_len; i++) {
     -+			reader_close(new_tables[i]);
     -+			reftable_reader_free(new_tables[i]);
     -+		}
     ++	slice_release(&table_path);
     ++	for (i = 0; i < new_tables_len; i++) {
     ++		reader_close(new_tables[i]);
     ++		reftable_reader_free(new_tables[i]);
      +	}
      +	reftable_free(new_tables);
      +	reftable_free(cur);
     @@ reftable/stack.c (new)
      +	add->stack = st;
      +
      +	slice_set_string(&add->lock_file_name, st->list_file);
     -+	slice_append_string(&add->lock_file_name, ".lock");
     ++	slice_addstr(&add->lock_file_name, ".lock");
      +
      +	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
      +				 O_EXCL | O_CREAT | O_WRONLY, 0644);
     @@ reftable/stack.c (new)
      +	struct slice nm = { 0 };
      +	for (i = 0; i < add->new_tables_len; i++) {
      +		slice_set_string(&nm, add->stack->list_file);
     -+		slice_append_string(&nm, "/");
     -+		slice_append_string(&nm, add->new_tables[i]);
     ++		slice_addstr(&nm, "/");
     ++		slice_addstr(&nm, add->new_tables[i]);
      +		unlink(slice_as_string(&nm));
      +		reftable_free(add->new_tables[i]);
      +		add->new_tables[i] = NULL;
     @@ reftable/stack.c (new)
      +	}
      +	if (add->lock_file_name.len > 0) {
      +		unlink(slice_as_string(&add->lock_file_name));
     -+		slice_clear(&add->lock_file_name);
     ++		slice_release(&add->lock_file_name);
      +	}
      +
      +	free_names(add->names);
      +	add->names = NULL;
     -+	slice_clear(&nm);
     ++	slice_release(&nm);
      +}
      +
      +void reftable_addition_destroy(struct reftable_addition *add)
     @@ reftable/stack.c (new)
      +	}
      +
      +	for (i = 0; i < add->stack->merged->stack_len; i++) {
     -+		slice_append_string(&table_list,
     -+				    add->stack->merged->stack[i]->name);
     -+		slice_append_string(&table_list, "\n");
     ++		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
     ++		slice_addstr(&table_list, "\n");
      +	}
      +	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_append_string(&table_list, add->new_tables[i]);
     -+		slice_append_string(&table_list, "\n");
     ++		slice_addstr(&table_list, add->new_tables[i]);
     ++		slice_addstr(&table_list, "\n");
      +	}
      +
      +	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     -+	slice_clear(&table_list);
     ++	slice_release(&table_list);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		goto exit;
     @@ reftable/stack.c (new)
      +	format_name(&next_name, add->next_update_index, add->next_update_index);
      +
      +	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
     -+	slice_append_string(&temp_tab_file_name, "/");
     -+	slice_append(&temp_tab_file_name, next_name);
     -+	slice_append_string(&temp_tab_file_name, ".temp.XXXXXX");
     ++	slice_addstr(&temp_tab_file_name, "/");
     ++	slice_addbuf(&temp_tab_file_name, next_name);
     ++	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
      +
      +	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
      +	if (tab_fd < 0) {
     @@ reftable/stack.c (new)
      +	}
      +
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
     -+	slice_append_string(&next_name, ".ref");
     ++	slice_addstr(&next_name, ".ref");
      +
      +	slice_set_string(&tab_file_name, add->stack->reftable_dir);
     -+	slice_append_string(&tab_file_name, "/");
     -+	slice_append(&tab_file_name, next_name);
     ++	slice_addstr(&tab_file_name, "/");
     ++	slice_addbuf(&tab_file_name, next_name);
      +
      +	/* TODO: should check destination out of paranoia */
      +	err = rename(slice_as_string(&temp_tab_file_name),
     @@ reftable/stack.c (new)
      +		unlink(slice_as_string(&temp_tab_file_name));
      +	}
      +
     -+	slice_clear(&temp_tab_file_name);
     -+	slice_clear(&tab_file_name);
     -+	slice_clear(&next_name);
     ++	slice_release(&temp_tab_file_name);
     ++	slice_release(&tab_file_name);
     ++	slice_release(&next_name);
      +	reftable_writer_free(wr);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +		    reftable_reader_max_update_index(st->merged->stack[first]));
      +
      +	slice_set_string(temp_tab, st->reftable_dir);
     -+	slice_append_string(temp_tab, "/");
     -+	slice_append(temp_tab, next_name);
     -+	slice_append_string(temp_tab, ".temp.XXXXXX");
     ++	slice_addstr(temp_tab, "/");
     ++	slice_addbuf(temp_tab, next_name);
     ++	slice_addstr(temp_tab, ".temp.XXXXXX");
      +
      +	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
      +	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
     @@ reftable/stack.c (new)
      +	}
      +	if (err != 0 && temp_tab->len > 0) {
      +		unlink(slice_as_string(temp_tab));
     -+		slice_clear(temp_tab);
     ++		slice_release(temp_tab);
      +	}
     -+	slice_clear(&next_name);
     ++	slice_release(&next_name);
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +	}
      +
      +	while (true) {
     -+		err = reftable_iterator_next_ref(it, &ref);
     ++		err = reftable_iterator_next_ref(&it, &ref);
      +		if (err > 0) {
      +			err = 0;
      +			break;
     @@ reftable/stack.c (new)
      +	}
      +
      +	while (true) {
     -+		err = reftable_iterator_next_log(it, &log);
     ++		err = reftable_iterator_next_log(&it, &log);
      +		if (err > 0) {
      +			err = 0;
      +			break;
     @@ reftable/stack.c (new)
      +	bool have_lock = false;
      +	int lock_file_fd = 0;
      +	int compact_count = last - first + 1;
     ++	char **listp = NULL;
      +	char **delete_on_success =
      +		reftable_calloc(sizeof(char *) * (compact_count + 1));
      +	char **subtable_locks =
     @@ reftable/stack.c (new)
      +	st->stats.attempts++;
      +
      +	slice_set_string(&lock_file_name, st->list_file);
     -+	slice_append_string(&lock_file_name, ".lock");
     ++	slice_addstr(&lock_file_name, ".lock");
      +
      +	lock_file_fd = open(slice_as_string(&lock_file_name),
      +			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     @@ reftable/stack.c (new)
      +		struct slice subtab_file_name = { 0 };
      +		struct slice subtab_lock = { 0 };
      +		slice_set_string(&subtab_file_name, st->reftable_dir);
     -+		slice_append_string(&subtab_file_name, "/");
     -+		slice_append_string(&subtab_file_name,
     -+				    reader_name(st->merged->stack[i]));
     ++		slice_addstr(&subtab_file_name, "/");
     ++		slice_addstr(&subtab_file_name,
     ++			     reader_name(st->merged->stack[i]));
      +
      +		slice_copy(&subtab_lock, subtab_file_name);
     -+		slice_append_string(&subtab_lock, ".lock");
     ++		slice_addstr(&subtab_lock, ".lock");
      +
      +		{
      +			int sublock_file_fd =
     @@ reftable/stack.c (new)
      +
      +	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
      +		    st->merged->stack[last]->max_update_index);
     -+	slice_append_string(&new_table_name, ".ref");
     ++	slice_addstr(&new_table_name, ".ref");
      +
      +	slice_set_string(&new_table_path, st->reftable_dir);
     -+	slice_append_string(&new_table_path, "/");
     ++	slice_addstr(&new_table_path, "/");
      +
     -+	slice_append(&new_table_path, new_table_name);
     ++	slice_addbuf(&new_table_path, new_table_name);
      +
      +	if (!is_empty_table) {
      +		err = rename(slice_as_string(&temp_tab_file_name),
     @@ reftable/stack.c (new)
      +	}
      +
      +	for (i = 0; i < first; i++) {
     -+		slice_append_string(&ref_list_contents,
     -+				    st->merged->stack[i]->name);
     -+		slice_append_string(&ref_list_contents, "\n");
     ++		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		slice_addstr(&ref_list_contents, "\n");
      +	}
      +	if (!is_empty_table) {
     -+		slice_append(&ref_list_contents, new_table_name);
     -+		slice_append_string(&ref_list_contents, "\n");
     ++		slice_addbuf(&ref_list_contents, new_table_name);
     ++		slice_addstr(&ref_list_contents, "\n");
      +	}
      +	for (i = last + 1; i < st->merged->stack_len; i++) {
     -+		slice_append_string(&ref_list_contents,
     -+				    st->merged->stack[i]->name);
     -+		slice_append_string(&ref_list_contents, "\n");
     ++		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		slice_addstr(&ref_list_contents, "\n");
      +	}
      +
      +	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
     @@ reftable/stack.c (new)
      +	*/
      +	err = reftable_stack_reload_maybe_reuse(st, first < last);
      +
     -+	{
     -+		char **p = delete_on_success;
     -+		while (*p) {
     -+			if (strcmp(*p, slice_as_string(&new_table_path))) {
     -+				unlink(*p);
     -+			}
     -+			p++;
     ++	listp = delete_on_success;
     ++	while (*listp) {
     ++		if (strcmp(*listp, slice_as_string(&new_table_path))) {
     ++			unlink(*listp);
      +		}
     ++		listp++;
      +	}
      +
      +exit:
      +	free_names(delete_on_success);
     -+	{
     -+		char **p = subtable_locks;
     -+		while (*p) {
     -+			unlink(*p);
     -+			p++;
     -+		}
     ++
     ++	listp = subtable_locks;
     ++	while (*listp) {
     ++		unlink(*listp);
     ++		listp++;
      +	}
      +	free_names(subtable_locks);
      +	if (lock_file_fd > 0) {
     @@ reftable/stack.c (new)
      +	if (have_lock) {
      +		unlink(slice_as_string(&lock_file_name));
      +	}
     -+	slice_clear(&new_table_name);
     -+	slice_clear(&new_table_path);
     -+	slice_clear(&ref_list_contents);
     -+	slice_clear(&temp_tab_file_name);
     -+	slice_clear(&lock_file_name);
     ++	slice_release(&new_table_name);
     ++	slice_release(&new_table_path);
     ++	slice_release(&ref_list_contents);
     ++	slice_release(&temp_tab_file_name);
     ++	slice_release(&lock_file_name);
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +{
      +	struct reftable_table tab = { NULL };
      +	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     -+	return reftable_table_read_ref(tab, refname, ref);
     ++	return reftable_table_read_ref(&tab, refname, ref);
      +}
      +
      +int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     @@ reftable/stack.c (new)
      +		goto exit;
      +	}
      +
     -+	err = reftable_iterator_next_log(it, log);
     ++	err = reftable_iterator_next_log(&it, log);
      +	if (err) {
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +		goto exit;
      +	}
      +
     -+	err = reftable_new_reader(&rd, src, new_tab_name);
     ++	err = reftable_new_reader(&rd, &src, new_tab_name);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ reftable/stack.c (new)
      +
      +	while (true) {
      +		struct reftable_ref_record ref = { 0 };
     -+		err = reftable_iterator_next_ref(it, &ref);
     ++		err = reftable_iterator_next_ref(&it, &ref);
      +		if (err > 0) {
      +			break;
      +		}
     @@ reftable/tree.c (new)
      +			      int (*compare)(const void *, const void *),
      +			      int insert)
      +{
     ++	int res;
      +	if (*rootp == NULL) {
      +		if (!insert) {
      +			return NULL;
     @@ reftable/tree.c (new)
      +		}
      +	}
      +
     -+	{
     -+		int res = compare(key, (*rootp)->key);
     -+		if (res < 0) {
     -+			return tree_search(key, &(*rootp)->left, compare,
     -+					   insert);
     -+		} else if (res > 0) {
     -+			return tree_search(key, &(*rootp)->right, compare,
     -+					   insert);
     -+		}
     ++	res = compare(key, (*rootp)->key);
     ++	if (res < 0) {
     ++		return tree_search(key, &(*rootp)->left, compare, insert);
     ++	} else if (res > 0) {
     ++		return tree_search(key, &(*rootp)->right, compare, insert);
      +	}
      +	return *rootp;
      +}
     @@ reftable/writer.c (new)
      +
      +static int obj_index_tree_node_compare(const void *a, const void *b)
      +{
     -+	return slice_compare(((const struct obj_index_tree_node *)a)->hash,
     -+			     ((const struct obj_index_tree_node *)b)->hash);
     ++	return slice_cmp(((const struct obj_index_tree_node *)a)->hash,
     ++			 ((const struct obj_index_tree_node *)b)->hash);
      +}
      +
      +static void writer_index_hash(struct reftable_writer *w, struct slice hash)
     @@ reftable/writer.c (new)
      +	key->offsets[key->offset_len++] = off;
      +}
      +
     -+static int writer_add_record(struct reftable_writer *w, struct record rec)
     ++static int writer_add_record(struct reftable_writer *w,
     ++			     struct reftable_record *rec)
      +{
      +	int result = -1;
      +	struct slice key = { 0 };
      +	int err = 0;
     -+	record_key(rec, &key);
     -+	if (slice_compare(w->last_key, key) >= 0) {
     ++	reftable_record_key(rec, &key);
     ++	if (slice_cmp(w->last_key, key) >= 0) {
      +		goto exit;
      +	}
      +
      +	slice_copy(&w->last_key, key);
      +	if (w->block_writer == NULL) {
     -+		writer_reinit_block_writer(w, record_type(rec));
     ++		writer_reinit_block_writer(w, reftable_record_type(rec));
      +	}
      +
     -+	assert(block_writer_type(w->block_writer) == record_type(rec));
     ++	assert(block_writer_type(w->block_writer) == reftable_record_type(rec));
      +
      +	if (block_writer_add(w->block_writer, rec) == 0) {
      +		result = 0;
     @@ reftable/writer.c (new)
      +		goto exit;
      +	}
      +
     -+	writer_reinit_block_writer(w, record_type(rec));
     ++	writer_reinit_block_writer(w, reftable_record_type(rec));
      +	err = block_writer_add(w->block_writer, rec);
      +	if (err < 0) {
      +		result = err;
     @@ reftable/writer.c (new)
      +
      +	result = 0;
      +exit:
     -+	slice_clear(&key);
     ++	slice_release(&key);
      +	return result;
      +}
      +
      +int reftable_writer_add_ref(struct reftable_writer *w,
      +			    struct reftable_ref_record *ref)
      +{
     -+	struct record rec = { 0 };
     ++	struct reftable_record rec = { 0 };
      +	struct reftable_ref_record copy = *ref;
      +	int err = 0;
      +
     @@ reftable/writer.c (new)
      +		return REFTABLE_API_ERROR;
      +	}
      +
     -+	record_from_ref(&rec, &copy);
     ++	reftable_record_from_ref(&rec, &copy);
      +	copy.update_index -= w->min_update_index;
     -+	err = writer_add_record(w, rec);
     ++	err = writer_add_record(w, &rec);
      +	if (err < 0) {
      +		return err;
      +	}
     @@ reftable/writer.c (new)
      +int reftable_writer_add_log(struct reftable_writer *w,
      +			    struct reftable_log_record *log)
      +{
     ++	struct reftable_record rec = { 0 };
     ++	int err;
      +	if (log->ref_name == NULL) {
      +		return REFTABLE_API_ERROR;
      +	}
     @@ reftable/writer.c (new)
      +	w->next -= w->pending_padding;
      +	w->pending_padding = 0;
      +
     -+	{
     -+		struct record rec = { 0 };
     -+		int err;
     -+		record_from_log(&rec, log);
     -+		err = writer_add_record(w, rec);
     -+		return err;
     -+	}
     ++	reftable_record_from_log(&rec, log);
     ++	err = writer_add_record(w, &rec);
     ++	return err;
      +}
      +
      +int reftable_writer_add_logs(struct reftable_writer *w,
     @@ reftable/writer.c (new)
      +	int before_blocks = w->stats.idx_stats.blocks;
      +	int err = writer_flush_block(w);
      +	int i = 0;
     ++	struct reftable_block_stats *bstats = NULL;
      +	if (err < 0) {
      +		return err;
      +	}
      +
      +	while (w->index_len > threshold) {
     -+		struct index_record *idx = NULL;
     ++		struct reftable_index_record *idx = NULL;
      +		int idx_len = 0;
      +
      +		max_level++;
     @@ reftable/writer.c (new)
      +		w->index_len = 0;
      +		w->index_cap = 0;
      +		for (i = 0; i < idx_len; i++) {
     -+			struct record rec = { 0 };
     -+			record_from_index(&rec, idx + i);
     -+			if (block_writer_add(w->block_writer, rec) == 0) {
     ++			struct reftable_record rec = { 0 };
     ++			reftable_record_from_index(&rec, idx + i);
     ++			if (block_writer_add(w->block_writer, &rec) == 0) {
      +				continue;
      +			}
      +
     @@ reftable/writer.c (new)
      +
      +			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
      +
     -+			err = block_writer_add(w->block_writer, rec);
     ++			err = block_writer_add(w->block_writer, &rec);
      +			if (err != 0) {
      +				/* write into fresh block should always succeed
      +				 */
     @@ reftable/writer.c (new)
      +			}
      +		}
      +		for (i = 0; i < idx_len; i++) {
     -+			slice_clear(&idx[i].last_key);
     ++			slice_release(&idx[i].last_key);
      +		}
      +		reftable_free(idx);
      +	}
     @@ reftable/writer.c (new)
      +		return err;
      +	}
      +
     -+	{
     -+		struct reftable_block_stats *bstats =
     -+			writer_reftable_block_stats(w, typ);
     -+		bstats->index_blocks =
     -+			w->stats.idx_stats.blocks - before_blocks;
     -+		bstats->index_offset = index_start;
     -+		bstats->max_index_level = max_level;
     -+	}
     ++	bstats = writer_reftable_block_stats(w, typ);
     ++	bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
     ++	bstats->index_offset = index_start;
     ++	bstats->max_index_level = max_level;
      +
      +	/* Reinit lastKey, as the next section can start with any key. */
      +	w->last_key.len = 0;
     @@ reftable/writer.c (new)
      +{
      +	struct write_record_arg *arg = (struct write_record_arg *)void_arg;
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
     -+	struct obj_record obj_rec = {
     ++	struct reftable_obj_record obj_rec = {
      +		.hash_prefix = entry->hash.buf,
      +		.hash_prefix_len = arg->w->stats.object_id_len,
      +		.offsets = entry->offsets,
      +		.offset_len = entry->offset_len,
      +	};
     -+	struct record rec = { 0 };
     ++	struct reftable_record rec = { 0 };
      +	if (arg->err < 0) {
      +		goto exit;
      +	}
      +
     -+	record_from_obj(&rec, &obj_rec);
     -+	arg->err = block_writer_add(arg->w->block_writer, rec);
     ++	reftable_record_from_obj(&rec, &obj_rec);
     ++	arg->err = block_writer_add(arg->w->block_writer, &rec);
      +	if (arg->err == 0) {
      +		goto exit;
      +	}
     @@ reftable/writer.c (new)
      +	}
      +
      +	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
     -+	arg->err = block_writer_add(arg->w->block_writer, rec);
     ++	arg->err = block_writer_add(arg->w->block_writer, &rec);
      +	if (arg->err == 0) {
      +		goto exit;
      +	}
      +	obj_rec.offset_len = 0;
     -+	arg->err = block_writer_add(arg->w->block_writer, rec);
     ++	arg->err = block_writer_add(arg->w->block_writer, &rec);
      +
      +	/* Should be able to write into a fresh block. */
      +	assert(arg->err == 0);
     @@ reftable/writer.c (new)
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +
      +	FREE_AND_NULL(entry->offsets);
     -+	slice_clear(&entry->hash);
     ++	slice_release(&entry->hash);
      +	reftable_free(entry);
      +}
      +
     @@ reftable/writer.c (new)
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
     -+	slice_clear(&w->last_key);
     ++	slice_release(&w->last_key);
      +	return err;
      +}
      +
     @@ reftable/writer.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->index_len; i++) {
     -+		slice_clear(&w->index[i].last_key);
     ++		slice_release(&w->index[i].last_key);
      +	}
      +
      +	FREE_AND_NULL(w->index);
     @@ reftable/writer.c (new)
      +	int raw_bytes = block_writer_finish(w->block_writer);
      +	int padding = 0;
      +	int err = 0;
     ++	struct reftable_index_record ir = { 0 };
      +	if (raw_bytes < 0) {
      +		return raw_bytes;
      +	}
     @@ reftable/writer.c (new)
      +	if (w->index_cap == w->index_len) {
      +		w->index_cap = 2 * w->index_cap + 1;
      +		w->index = reftable_realloc(
     -+			w->index, sizeof(struct index_record) * w->index_cap);
     ++			w->index,
     ++			sizeof(struct reftable_index_record) * w->index_cap);
      +	}
      +
     -+	{
     -+		struct index_record ir = {
     -+			.offset = w->next,
     -+		};
     -+		slice_copy(&ir.last_key, w->block_writer->last_key);
     -+		w->index[w->index_len] = ir;
     -+	}
     ++	ir.offset = w->next;
     ++	slice_copy(&ir.last_key, w->block_writer->last_key);
     ++	w->index[w->index_len] = ir;
      +
      +	w->index_len++;
      +	w->next += padding + raw_bytes;
     @@ reftable/writer.h (new)
      +	struct block_writer block_writer_data;
      +
      +	/* pending index records for the current section */
     -+	struct index_record *index;
     ++	struct reftable_index_record *index;
      +	int index_len;
      +	int index_cap;
      +
 11:  ace95b6cd88 !  6:  865c2c4567a Reftable support for git-core
     @@ refs/reftable-backend.c (new)
      +	struct reftable_stack *stack;
      +};
      +
     ++static int reftable_read_raw_ref(struct ref_store *ref_store,
     ++				 const char *refname, struct object_id *oid,
     ++				 struct strbuf *referent, unsigned int *type);
     ++
      +static void clear_reftable_log_record(struct reftable_log_record *log)
      +{
      +	log->old_hash = NULL;
     @@ refs/reftable-backend.c (new)
      +	struct git_reftable_iterator *ri =
      +		(struct git_reftable_iterator *)ref_iterator;
      +	while (ri->err == 0) {
     -+		ri->err = reftable_iterator_next_ref(ri->iter, &ri->ref);
     ++		ri->err = reftable_iterator_next_ref(&ri->iter, &ri->ref);
      +		if (ri->err) {
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +	return &ri->base;
      +}
      +
     ++static int fixup_symrefs(struct ref_store *ref_store,
     ++			 struct ref_transaction *transaction)
     ++{
     ++	struct strbuf referent = STRBUF_INIT;
     ++	int i = 0;
     ++	int err = 0;
     ++
     ++	for (i = 0; i < transaction->nr; i++) {
     ++		struct ref_update *update = transaction->updates[i];
     ++		struct object_id old_oid;
     ++
     ++		err = reftable_read_raw_ref(ref_store, update->refname,
     ++					    &old_oid, &referent,
     ++					    /* mutate input, like
     ++					       files-backend.c */
     ++					    &update->type);
     ++		if (err < 0 && errno == ENOENT &&
     ++		    is_null_oid(&update->old_oid)) {
     ++			err = 0;
     ++		}
     ++		if (err < 0)
     ++			goto done;
     ++
     ++		if (!(update->type & REF_ISSYMREF))
     ++			continue;
     ++
     ++		if (update->flags & REF_NO_DEREF) {
     ++			/* what should happen here? See files-backend.c
     ++			 * lock_ref_for_update. */
     ++		} else {
     ++			/*
     ++			  If we are updating a symref (eg. HEAD), we should also
     ++			  update the branch that the symref points to.
     ++
     ++			  This is generic functionality, and would be better
     ++			  done in refs.c, but the current implementation is
     ++			  intertwined with the locking in files-backend.c.
     ++			*/
     ++			int new_flags = update->flags;
     ++			struct ref_update *new_update = NULL;
     ++
     ++			/* if this is an update for HEAD, should also record a
     ++			   log entry for HEAD? See files-backend.c,
     ++			   split_head_update()
     ++			*/
     ++			new_update = ref_transaction_add_update(
     ++				transaction, referent.buf, new_flags,
     ++				&update->new_oid, &update->old_oid,
     ++				update->msg);
     ++			new_update->parent_update = update;
     ++
     ++			/* files-backend sets REF_LOG_ONLY here. */
     ++			update->flags |= REF_NO_DEREF | REF_LOG_ONLY;
     ++			update->flags &= ~REF_HAVE_OLD;
     ++		}
     ++	}
     ++
     ++done:
     ++	strbuf_release(&referent);
     ++	return err;
     ++}
     ++
      +static int reftable_transaction_prepare(struct ref_store *ref_store,
      +					struct ref_transaction *transaction,
      +					struct strbuf *errbuf)
      +{
     -+	/* XXX rewrite using the reftable transaction API. */
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_addition *add = NULL;
      +	int err = refs->err;
      +	if (err < 0) {
      +		goto done;
      +	}
     ++
      +	err = reftable_stack_reload(refs->stack);
      +	if (err) {
      +		goto done;
      +	}
      +
     ++	err = reftable_stack_new_addition(&add, refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++	err = fixup_symrefs(ref_store, transaction);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++	transaction->backend_data = add;
     ++	transaction->state = REF_TRANSACTION_PREPARED;
     ++
      +done:
     ++	if (err < 0) {
     ++		transaction->state = REF_TRANSACTION_CLOSED;
     ++		strbuf_addf(errbuf, "reftable: transaction prepare: %s",
     ++			    reftable_error_str(err));
     ++	}
     ++
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +				      struct ref_transaction *transaction,
      +				      struct strbuf *err)
      +{
     -+	struct git_reftable_ref_store *refs =
     -+		(struct git_reftable_ref_store *)ref_store;
     -+	(void)refs;
     ++	struct reftable_addition *add =
     ++		(struct reftable_addition *)transaction->backend_data;
     ++	reftable_addition_destroy(add);
     ++	transaction->backend_data = NULL;
      +	return 0;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +
      +static int ref_update_cmp(const void *a, const void *b)
      +{
     -+	return strcmp(((struct ref_update *)a)->refname,
     -+		      ((struct ref_update *)b)->refname);
     ++	return strcmp((*(struct ref_update **)a)->refname,
     ++		      (*(struct ref_update **)b)->refname);
      +}
      +
      +static int write_transaction_table(struct reftable_writer *writer, void *arg)
     @@ refs/reftable-backend.c (new)
      +	QSORT(sorted, transaction->nr, ref_update_cmp);
      +	reftable_writer_set_limits(writer, ts, ts);
      +
     -+	for (i = 0; i < transaction->nr; i++) {
     -+		struct ref_update *u = sorted[i];
     -+		if (u->flags & REF_HAVE_OLD) {
     -+			err = reftable_check_old_oid(transaction->ref_store,
     -+						     u->refname, &u->old_oid);
     -+			if (err < 0) {
     -+				goto exit;
     -+			}
     -+		}
     -+	}
      +
      +	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
     @@ refs/reftable-backend.c (new)
      +		log->update_index = ts;
      +		log->message = u->msg;
      +
     ++		if (u->flags & REF_LOG_ONLY) {
     ++			continue;
     ++		}
     ++
      +		if (u->flags & REF_HAVE_NEW) {
     -+			struct object_id out_oid;
     -+			int out_flags = 0;
     -+			/* Memory owned by refs_resolve_ref_unsafe, no need to
     -+			 * free(). */
     -+			const char *resolved = refs_resolve_ref_unsafe(
     -+				transaction->ref_store, u->refname, 0, &out_oid,
     -+				&out_flags);
      +			struct reftable_ref_record ref = { NULL };
      +			struct object_id peeled;
     -+			int peel_error = peel_object(&u->new_oid, &peeled);
      +
     -+			ref.ref_name =
     -+				(char *)(resolved ? resolved : u->refname);
     -+			log->ref_name = ref.ref_name;
     ++			int peel_error = peel_object(&u->new_oid, &peeled);
     ++			ref.ref_name = (char *)u->refname;
      +
      +			if (!is_null_oid(&u->new_oid)) {
      +				ref.value = u->new_oid.hash;
     @@ refs/reftable-backend.c (new)
      +
      +			err = reftable_writer_add_ref(writer, &ref);
      +			if (err < 0) {
     -+				goto exit;
     ++				goto done;
      +			}
      +		}
      +	}
     @@ refs/reftable-backend.c (new)
      +		err = reftable_writer_add_log(writer, &logs[i]);
      +		clear_reftable_log_record(&logs[i]);
      +		if (err < 0) {
     -+			goto exit;
     ++			goto done;
      +		}
      +	}
      +
     -+exit:
     ++done:
      +	free(logs);
      +	free(sorted);
      +	return err;
      +}
      +
     -+static int reftable_transaction_commit(struct ref_store *ref_store,
     ++static int reftable_transaction_finish(struct ref_store *ref_store,
      +				       struct ref_transaction *transaction,
      +				       struct strbuf *errmsg)
      +{
     -+	struct git_reftable_ref_store *refs =
     -+		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_addition *add =
     ++		(struct reftable_addition *)transaction->backend_data;
      +	int err = 0;
     -+	if (refs->err < 0) {
     -+		return refs->err;
     ++	int i;
     ++
     ++	for (i = 0; i < transaction->nr; i++) {
     ++		struct ref_update *u = transaction->updates[i];
     ++		if (u->flags & REF_HAVE_OLD) {
     ++			err = reftable_check_old_oid(transaction->ref_store,
     ++						     u->refname, &u->old_oid);
     ++			if (err < 0) {
     ++				goto done;
     ++			}
     ++		}
      +	}
      +
     -+	err = reftable_stack_add(refs->stack, &write_transaction_table,
     -+				 transaction);
     ++	err = reftable_addition_add(add, &write_transaction_table, transaction);
      +	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_addition_commit(add);
     ++
     ++done:
     ++	reftable_addition_destroy(add);
     ++	transaction->state = REF_TRANSACTION_CLOSED;
     ++	transaction->backend_data = NULL;
     ++	if (err) {
      +		strbuf_addf(errmsg, "reftable: transaction failure: %s",
      +			    reftable_error_str(err));
      +		return -1;
      +	}
     -+
     -+	return 0;
     ++	return err;
      +}
      +
     -+static int reftable_transaction_finish(struct ref_store *ref_store,
     -+				       struct ref_transaction *transaction,
     -+				       struct strbuf *err)
     ++static int
     ++reftable_transaction_initial_commit(struct ref_store *ref_store,
     ++				    struct ref_transaction *transaction,
     ++				    struct strbuf *errmsg)
      +{
     -+	return reftable_transaction_commit(ref_store, transaction, err);
     ++	return reftable_transaction_finish(ref_store, transaction, errmsg);
      +}
      +
      +struct write_pseudoref_arg {
     @@ refs/reftable-backend.c (new)
      +	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
      +
      +	if (err) {
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	/* XXX do ref renames overwrite the target? */
      +	if (reftable_stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	free(ref.ref_name);
     @@ refs/reftable-backend.c (new)
      +
      +		err = reftable_writer_add_refs(writer, todo, 2);
      +		if (err < 0) {
     -+			goto exit;
     ++			goto done;
      +		}
      +	}
      +
     @@ refs/reftable-backend.c (new)
      +		clear_reftable_log_record(&todo[1]);
      +
      +		if (err < 0) {
     -+			goto exit;
     ++			goto done;
      +		}
      +
      +	} else {
      +		/* XXX symrefs? */
      +	}
      +
     -+exit:
     ++done:
      +	reftable_ref_record_clear(&ref);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +		(struct reftable_reflog_ref_iterator *)ref_iterator;
      +
      +	while (1) {
     -+		int err = reftable_iterator_next_log(ri->iter, &ri->log);
     ++		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
      +		if (err > 0) {
      +			return ITER_DONE;
      +		}
     @@ refs/reftable-backend.c (new)
      +	mt = reftable_stack_merged_table(refs->stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	while (err == 0) {
     -+		err = reftable_iterator_next_log(it, &log);
     ++		err = reftable_iterator_next_log(&it, &log);
      +		if (err != 0) {
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +
      +	while (err == 0) {
      +		struct reftable_log_record log = { NULL };
     -+		err = reftable_iterator_next_log(it, &log);
     ++		err = reftable_iterator_next_log(&it, &log);
      +		if (err != 0) {
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
      +
      +	mt = reftable_stack_merged_table(refs->stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err < 0) {
     -+		return err;
     ++		goto done;
      +	}
      +
      +	while (1) {
      +		struct object_id ooid;
      +		struct object_id noid;
      +
     -+		int err = reftable_iterator_next_log(it, &log);
     ++		int err = reftable_iterator_next_log(&it, &log);
      +		if (err < 0) {
     -+			return err;
     ++			goto done;
      +		}
      +
      +		if (err > 0 || strcmp(log.ref_name, refname)) {
     @@ refs/reftable-backend.c (new)
      +			add_log_tombstone(&arg, refname, log.update_index);
      +		}
      +	}
     ++	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
     ++
     ++done:
      +	reftable_log_record_clear(&log);
      +	reftable_iterator_destroy(&it);
     -+	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
      +	clear_log_tombstones(&arg);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +	if (err > 0) {
      +		errno = ENOENT;
      +		err = -1;
     -+		goto exit;
     ++		goto done;
      +	}
      +	if (err < 0) {
      +		errno = reftable_error_to_errno(err);
      +		err = -1;
     -+		goto exit;
     ++		goto done;
      +	}
      +	if (ref.target != NULL) {
     -+		/* XXX recurse? */
      +		strbuf_reset(referent);
      +		strbuf_addstr(referent, ref.target);
      +		*type |= REF_ISSYMREF;
     @@ refs/reftable-backend.c (new)
      +		errno = EINVAL;
      +		err = -1;
      +	}
     -+exit:
     ++done:
      +	reftable_ref_record_clear(&ref);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +	reftable_transaction_prepare,
      +	reftable_transaction_finish,
      +	reftable_transaction_abort,
     -+	reftable_transaction_commit,
     ++	reftable_transaction_initial_commit,
      +
      +	reftable_pack_refs,
      +	reftable_create_symref,
     @@ refs/reftable-backend.c (new)
      +	reftable_reflog_exists,
      +	reftable_create_reflog,
      +	reftable_delete_reflog,
     -+	reftable_reflog_expire
     ++	reftable_reflog_expire,
      +};
      
       ## repository.c ##
     @@ t/t0031-reftable.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'basic operation of reftable storage: commit, reflog, repack' '
     ++test_expect_success 'basic operation of reftable storage: commit, show-ref' '
      +	initialize &&
      +	test_commit file &&
      +	test_write_lines refs/heads/master refs/tags/file >expect &&
      +	git show-ref &&
      +	git show-ref | cut -f2 -d" " > actual &&
     -+	test_cmp actual expect &&
     ++	test_cmp actual expect
     ++'
     ++
     ++test_expect_success 'reflog, repack' '
     ++	initialize &&
      +	for count in $(test_seq 1 10)
      +	do
      +		test_commit "number $count" file.t $count number-$count ||
     @@ t/t0031-reftable.sh (new)
      +	ls -1 .git/reftable >table-files &&
      +	test_line_count = 2 table-files &&
      +	git reflog refs/heads/master >output &&
     -+	test_line_count = 11 output &&
     -+	grep "commit (initial): file" output &&
     ++	test_line_count = 10 output &&
     ++	grep "commit (initial): number 1" output &&
      +	grep "commit: number 10" output &&
      +	git gc &&
      +	git reflog refs/heads/master >output &&
     @@ t/t0031-reftable.sh (new)
      +	test -f file2
      +'
      +
     ++# cherry-pick uses a pseudo ref.
     ++test_expect_success 'rebase' '
     ++	initialize &&
     ++	test_commit message1 file1 &&
     ++	test_commit message2 file2 &&
     ++	git branch source &&
     ++	git checkout HEAD^ &&
     ++	test_commit message3 file3 &&
     ++ 	git rebase source &&
     ++	test -f file2
     ++'
     ++
      +test_done
      +
  -:  ----------- >  7:  6b248d5fdb4 Add GIT_DEBUG_REFS debugging mechanism
 12:  b96f0712d44 =  8:  54102355ce7 vcxproj: adjust for the reftable changes
 13:  0e732d30b51 !  9:  7764ebf0956 Add some reftable testing infrastructure
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Add some reftable testing infrastructure
     +    Add reftable testing infrastructure
      
          * Add GIT_TEST_REFTABLE environment var to control default ref storage
      
     -    * Add test_prerequisite REFTABLE. Skip t/t3210-pack-refs.sh for REFTABLE.
     +    * Add test_prerequisite REFTABLE.
     +
     +    * Skip some tests that are incompatible:
     +
     +      * t3210-pack-refs.sh - does not apply
     +      * t9903-bash-prompt - The bash mode reads .git/HEAD directly
     +      * t1450-fsck.sh - manipulates .git/ directly to create invalid state
      
          Major test failures:
      
     -     * t9903-bash-prompt - The bash mode reads .git/HEAD directly
           * t1400-update-ref.sh - Reads from .git/{refs,logs} directly
           * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
           * t1405 - inspecs .git/ directly.
     -     * t1450-fsck.sh - manipulates .git/ directly to create invalid state
     -     * Rebase, cherry-pick: pseudo refs aren't written through the refs backend.
     -
     -    Other tests by decreasing brokenness:
     -
     -    t1407-worktree-ref-store.sh              - 5 of 5
     -    t1413-reflog-detach.sh                   - 7 of 7
     -    t1415-worktree-refs.sh                   - 11 of 11
     -    t3908-stash-in-worktree.sh               - 2 of 2
     -    t4207-log-decoration-colors.sh           - 2 of 2
     -    t5515-fetch-merge-logic.sh               - 17 of 17
     -    t5900-repo-selection.sh                  - 8 of 8
     -    t6016-rev-list-graph-simplify-history.sh - 12 of 12
     -    t5573-pull-verify-signatures.sh          - 15 of 16
     -    t5612-clone-refspec.sh                   - 12 of 13
     -    t5514-fetch-multiple.sh                  - 11 of 12
     -    t6030-bisect-porcelain.sh                - 64 of 71
     -    t5533-push-cas.sh                        - 15 of 17
     -    t5539-fetch-http-shallow.sh              - 7 of 8
     -    t7413-submodule-is-active.sh             - 7 of 8
     -    t2400-worktree-add.sh                    - 59 of 69
     -    t0100-previous.sh                        - 5 of 6
     -    t7419-submodule-set-branch.sh            - 5 of 6
     -    t1404-update-ref-errors.sh               - 44 of 53
     -    t6003-rev-list-topo-order.sh             - 29 of 35
     -    t1409-avoid-packing-refs.sh              - 9 of 11
     -    t5541-http-push-smart.sh                 - 31 of 38
     -    t5407-post-rewrite-hook.sh               - 13 of 16
     -    t9903-bash-prompt.sh                     - 52 of 66
     -    t1414-reflog-walk.sh                     - 9 of 12
     -    t1507-rev-parse-upstream.sh              - 21 of 28
     -    t2404-worktree-config.sh                 - 9 of 12
     -    t1505-rev-parse-last.sh                  - 5 of 7
     -    t7510-signed-commit.sh                   - 16 of 23
     -    t2018-checkout-branch.sh                 - 15 of 22
     -    (..etc)
     -
      
     +    t6030-bisect-porcelain.sh                - 62 of 72
     +    t2400-worktree-add.sh                    - 58 of 69
     +    t3200-branch.sh                          - 58 of 145
     +    t7406-submodule-update.sh                - 54 of 54
     +    t5601-clone.sh                           - 51 of 105
     +    t9903-bash-prompt.sh                     - 50 of 66
     +    t1404-update-ref-errors.sh               - 44 of 53
     +    t5510-fetch.sh                           - 40 of 171
     +    t7400-submodule-basic.sh                 - 38 of 111
     +    t3514-cherry-pick-revert-gpg.sh          - 36 of 36
     +    ..
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
      -						 DEFAULT_REF_STORAGE,
      +						 default_ref_storage(),
       					 REF_STORE_ALL_CAPS);
     - 	return r->refs_private;
     - }
     + 	if (getenv("GIT_DEBUG_REFS")) {
     + 		r->refs_private = debug_wrap(r->refs_private);
      @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
       		goto done;
       
     @@ t/t1409-avoid-packing-refs.sh: test_description='avoid rewriting packed-refs unn
       # shouldn't upset readers, and it should be omitted if the file is
       # ever rewritten.
      
     + ## t/t1450-fsck.sh ##
     +@@ t/t1450-fsck.sh: test_description='git fsck random collection of tests
     + 
     + . ./test-lib.sh
     + 
     ++if test_have_prereq REFTABLE
     ++then
     ++  skip_all='skipping tests; incompatible with reftable'
     ++  test_done
     ++fi
     ++
     + test_expect_success setup '
     + 	test_oid_init &&
     + 	git config gc.auto 0 &&
     +
       ## t/t3210-pack-refs.sh ##
      @@ t/t3210-pack-refs.sh: semantic is still the same.
       '
     @@ t/t3210-pack-refs.sh: semantic is still the same.
       	git config core.logallrefupdates true
       '
      
     + ## t/t9903-bash-prompt.sh ##
     +@@ t/t9903-bash-prompt.sh: test_description='test git-specific bash prompt functions'
     + 
     + . ./lib-bash.sh
     + 
     ++if test_have_prereq REFTABLE
     ++then
     ++  skip_all='skipping tests; incompatible with reftable'
     ++  test_done
     ++fi
     ++
     + . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
     + 
     + actual="$TRASH_DIRECTORY/actual"
     +
       ## t/test-lib.sh ##
      @@ t/test-lib.sh: FreeBSD)
       	;;

-- 
gitgitgadget
