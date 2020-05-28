Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EAFC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC41207BC
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giCXMXaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406719AbgE1Tru (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgE1Tq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:46:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3461C08C5C8
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so307070wme.3
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KBPVK1/46p4/wuvaRsM+D/a0eUCtsQWwnhUaqOpZj8U=;
        b=giCXMXaW3roZWIe8SnpmfkvYL4iEZGKxvMGnqKJ2ziwq7DLObxvc2HmkvxYihNn8Ad
         vUaEEP+xUUjq7KXP7V53tnSHt+IuJBkMnk8beP1hpAN9rFoYGZWK/IVHGqTkP3/jpxl0
         EZH2yGn2IjkFOplc9QgDuRfhJtY/40iFU56HYkf23FNwV8F9dD9g8AHQJmiodcK70K4P
         /eSTpln4MjCQdiNwy4yv8wpwVtrCCSYAeayDMedwgBve8qTH3+x8HZWqugj2YxUOMrIh
         DoRfiASACQkbtSQpLoP/pDCyc09Nk052TsWn4hCyWKbAeCrNU0NF2aTbAEHK/IAcZIAt
         hpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KBPVK1/46p4/wuvaRsM+D/a0eUCtsQWwnhUaqOpZj8U=;
        b=bJn4Ynp4zC0QqYqbjn11+wgChxI+WbaA8mRwtWzDOon1KdV823wHtDGhRBqrFYGU1U
         YQWyhiuFu2/JYmjJ45s13CItbwczpSeVuHynfIXUD+VjrhK/doVh0NSHrGZsxh1V4d6u
         4Xd+klIqGThTzJvqqokv/jPlS62dC/YCySRIkUjzGTLAQoYjK5yz9y5V72YSjL7SgHq+
         npWUvK67TQqu3Tjm/89dflmRSHQEndA3w1fG0fruuYRYbjyZjAK7/7MIjYrbBvBM8exQ
         3hZwc/hdxEU06oEwvfmN28mspuAvHtye01tUf6MMaEqZVGPEDp21ZwkGWZrjht/+/jsB
         FL9A==
X-Gm-Message-State: AOAM531Cth8I+9C+S5AQLAakGiE3hhoNivmTemVdOi9jgP8HNx97YT1n
        mZQ1lHvHoL1SWrc14LUwyX4FIRF7
X-Google-Smtp-Source: ABdhPJwcDJ5+UUPM7OCjiMmjNZZLw6eEvxUkQNUZZ6Ge3H1GF6i3pG2MuTrHhCS/vWMBiQTTkAkaTA==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr4815960wmn.36.1590695212124;
        Thu, 28 May 2020 12:46:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm7671155wrg.68.2020.05.28.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:46:51 -0700 (PDT)
Message-Id: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 19:46:36 +0000
Subject: [PATCH v15 00/13] Reftable support git-core
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

Summary 20479 tests pass 1299 tests fail

Some issues:

 * many tests inspect .git/{logs,heads}/ directly.
 * worktrees broken. 
 * Rebase/cherry-pick still largely broken

v17

 * many style tweaks in reftable/
 * fix rebase
 * GIT_DEBUG_REFS support.

v18

 * fix pseudo ref usage

Han-Wen Nienhuys (12):
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
  Add GIT_DEBUG_REFS debugging mechanism
  Add reftable testing infrastructure

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   28 +-
 builtin/bisect--helper.c                      |    3 +-
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
 refs/debug.c                                  |  309 ++++
 refs/files-backend.c                          |  121 +-
 refs/packed-backend.c                         |   21 +-
 refs/refs-internal.h                          |   26 +
 refs/reftable-backend.c                       | 1332 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    8 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  433 ++++++
 reftable/block.h                              |  129 ++
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  243 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  320 ++++
 reftable/merged.h                             |   39 +
 reftable/pq.c                                 |  113 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  742 +++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1113 ++++++++++++++
 reftable/record.h                             |  128 ++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   38 +
 reftable/reftable.c                           |   90 ++
 reftable/reftable.h                           |  564 +++++++
 reftable/slice.c                              |  247 +++
 reftable/slice.h                              |   87 ++
 reftable/stack.c                              | 1207 +++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/system.h                             |   54 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   24 +
 reftable/writer.c                             |  644 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |  142 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/t9903-bash-prompt.sh                        |    6 +
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 67 files changed, 9550 insertions(+), 194 deletions(-)
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


base-commit: aada2199e11bff14ee91d5d590c2e3d3eba5e148
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v15
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v14:

  1:  46d04f6740e !  1:  9bb64f748dc Write pseudorefs through ref backends.
     @@ Commit message
          CHERRY_PICK_HEAD, etc.
      
          These refs have always been read through the ref backends, but they were written
     -    in a one-off routine that wrote a object ID or symref directly wrote into
     +    in a one-off routine that wrote an object ID or symref directly into
          .git/<pseudo_ref_name>.
      
          This causes problems when introducing a new ref storage backend. To remedy this,
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## refs.c ##
     +@@ refs.c: int ref_exists(const char *refname)
     + 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
     + }
     + 
     ++int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
     ++{
     ++	return refs_delete_pseudoref(get_main_ref_store(the_repository),
     ++				     pseudoref, old_oid);
     ++}
     ++
     + static int filter_refs(const char *refname, const struct object_id *oid,
     + 			   int flags, void *data)
     + {
      @@ refs.c: long get_files_ref_lock_timeout_ms(void)
       	return timeout_ms;
       }
     @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
       	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
       		assert(refs == get_main_ref_store(the_repository));
      -		return delete_pseudoref(refname, old_oid);
     -+		return ref_store_delete_pseudoref(refs, refname, old_oid);
     ++		return refs_delete_pseudoref(refs, refname, old_oid);
       	}
       
       	transaction = ref_store_transaction_begin(refs, &err);
     @@ refs.c: int refs_update_ref(struct ref_store *refs, const char *msg,
       	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
       		assert(refs == get_main_ref_store(the_repository));
      -		ret = write_pseudoref(refname, new_oid, old_oid, &err);
     -+		ret = ref_store_write_pseudoref(refs, refname, new_oid, old_oid,
     -+						&err);
     ++		ret = refs_write_pseudoref(refs, refname, new_oid, old_oid,
     ++					   &err);
       	} else {
       		t = ref_store_transaction_begin(refs, &err);
       		if (!t ||
     @@ refs.c: int head_ref(each_ref_fn fn, void *cb_data)
       	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
       }
       
     -+int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			      const struct object_id *oid,
     -+			      const struct object_id *old_oid,
     -+			      struct strbuf *err)
     ++int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     ++			 const struct object_id *oid,
     ++			 const struct object_id *old_oid, struct strbuf *err)
      +{
      +	return refs->be->write_pseudoref(refs, pseudoref, oid, old_oid, err);
      +}
      +
     -+int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			       const struct object_id *old_oid)
     ++int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     ++			  const struct object_id *old_oid)
      +{
      +	return refs->be->delete_pseudoref(refs, pseudoref, old_oid);
      +}
     @@ refs.h: int update_ref(const char *msg, const char *refname,
      +   and deletion as they cannot take part in normal transactional updates.
      +   Pseudorefs should only be written for the main repository.
      +*/
     -+int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			      const struct object_id *oid,
     -+			      const struct object_id *old_oid,
     -+			      struct strbuf *err);
     -+int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			       const struct object_id *old_oid);
     ++int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     ++			 const struct object_id *oid,
     ++			 const struct object_id *old_oid, struct strbuf *err);
     ++int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     ++			  const struct object_id *old_oid);
     ++int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid);
      +
       int parse_hide_refs_config(const char *var, const char *value, const char *);
       
  -:  ----------- >  2:  d489806907b Make refs_ref_exists public
  -:  ----------- >  3:  60a82678a1b Treat BISECT_HEAD as a pseudo ref
  -:  ----------- >  4:  1a925f5671a Treat CHERRY_PICK_HEAD as a pseudo ref
  -:  ----------- >  5:  8f2ebf65b90 Treat REVERT_HEAD as a pseudo ref
  2:  c650f7e4345 =  6:  e0e1e3a558d Move REF_LOG_ONLY to refs-internal.h
  3:  0c953fce52a =  7:  27a980d1d9d Iterate over the "refs/" namespace in for_each_[raw]ref
  4:  206b7d329f8 =  8:  dcbd000e7f7 Add .gitattributes for the reftable/ directory
  5:  9a8e504a1d0 !  9:  718b646a54e Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit bad78b6de70700933a2f93ebadaa37a5e852d9ea
     ++commit fe15c65dd95b6a13de92b4baf711e50338ef20ae
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon May 18 20:12:57 2020 +0200
     ++Date:   Thu May 28 19:28:24 2020 +0200
      +
     -+    C: get rid of inner blocks for local scoping
     ++    C: add 'canary' to struct slice
     ++    
     ++    This enforces that all slices are initialized explicitly with
     ++    SLICE_INIT, for future compatibility with git's strbuf.
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +	bw->entries = 0;
      +	bw->restart_len = 0;
      +	bw->last_key.len = 0;
     ++	bw->last_key.canary = SLICE_CANARY;
      +}
      +
      +byte block_writer_type(struct block_writer *bw)
     @@ reftable/block.c (new)
      +   success */
      +int block_writer_add(struct block_writer *w, struct reftable_record *rec)
      +{
     -+	struct slice empty = { 0 };
     ++	struct slice empty = SLICE_INIT;
      +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
      +								    w->last_key;
      +	struct slice out = {
      +		.buf = w->buf + w->next,
      +		.len = w->block_size - w->next,
     ++		.canary = SLICE_CANARY,
      +	};
      +
      +	struct slice start = out;
      +
      +	bool restart = false;
     -+	struct slice key = { 0 };
     ++	struct slice key = SLICE_INIT;
      +	int n = 0;
      +
      +	reftable_record_key(rec, &key);
      +	n = reftable_encode_key(&restart, out, last, key,
      +				reftable_record_val_type(rec));
     -+	if (n < 0) {
     -+		goto err;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&out, n);
      +
      +	n = reftable_record_encode(rec, out, w->hash_size);
     -+	if (n < 0) {
     -+		goto err;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&out, n);
      +
      +	if (block_writer_register_restart(w, start.len - out.len, restart,
     -+					  key) < 0) {
     -+		goto err;
     -+	}
     ++					  key) < 0)
     ++		goto done;
      +
      +	slice_release(&key);
      +	return 0;
      +
     -+err:
     ++done:
      +	slice_release(&key);
      +	return -1;
      +}
     @@ reftable/block.c (new)
      +	if (restart) {
      +		rlen++;
      +	}
     -+	if (2 + 3 * rlen + n > w->block_size - w->next) {
     ++	if (2 + 3 * rlen + n > w->block_size - w->next)
      +		return -1;
     -+	}
      +	if (restart) {
      +		if (w->restart_len == w->restart_cap) {
      +			w->restart_cap = w->restart_cap * 2 + 1;
     @@ reftable/block.c (new)
      +	}
      +
      +	w->next += n;
     ++
      +	slice_copy(&w->last_key, key);
      +	w->entries++;
      +	return 0;
     @@ reftable/block.c (new)
      +
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
     -+		struct slice compressed = { 0 };
     ++		struct slice compressed = SLICE_INIT;
      +		int zresult = 0;
      +		uLongf src_len = w->next - block_header_skip;
      +		slice_resize(&compressed, src_len);
     @@ reftable/block.c (new)
      +	byte typ = block->data[header_off];
      +	uint32_t sz = get_be24(block->data + header_off + 1);
      +
     -+	if (!reftable_is_block_type(typ)) {
     ++	uint16_t restart_count = 0;
     ++	uint32_t restart_start = 0;
     ++	byte *restart_bytes = NULL;
     ++
     ++	if (!reftable_is_block_type(typ))
      +		return REFTABLE_FORMAT_ERROR;
     -+	}
      +
      +	if (typ == BLOCK_TYPE_LOG) {
     -+		struct slice uncompressed = { 0 };
     ++		struct slice uncompressed = SLICE_INIT;
      +		int block_header_skip = 4 + header_off;
      +		uLongf dst_len = sz - block_header_skip; /* total size of dest
      +							    buffer. */
     @@ reftable/block.c (new)
      +			return REFTABLE_ZLIB_ERROR;
      +		}
      +
     -+		if (dst_len + block_header_skip != sz) {
     ++		if (dst_len + block_header_skip != sz)
      +			return REFTABLE_FORMAT_ERROR;
     -+		}
      +
      +		/* We're done with the input data. */
      +		reftable_block_done(block);
     @@ reftable/block.c (new)
      +		full_block_size = sz;
      +	}
      +
     -+	{
     -+		uint16_t restart_count = get_be16(block->data + sz - 2);
     -+		uint32_t restart_start = sz - 2 - 3 * restart_count;
     ++	restart_count = get_be16(block->data + sz - 2);
     ++	restart_start = sz - 2 - 3 * restart_count;
     ++	restart_bytes = block->data + restart_start;
      +
     -+		byte *restart_bytes = block->data + restart_start;
     ++	/* transfer ownership. */
     ++	br->block = *block;
     ++	block->data = NULL;
     ++	block->len = 0;
      +
     -+		/* transfer ownership. */
     -+		br->block = *block;
     -+		block->data = NULL;
     -+		block->len = 0;
     -+
     -+		br->hash_size = hash_size;
     -+		br->block_len = restart_start;
     -+		br->full_block_size = full_block_size;
     -+		br->header_off = header_off;
     -+		br->restart_count = restart_count;
     -+		br->restart_bytes = restart_bytes;
     -+	}
     ++	br->hash_size = hash_size;
     ++	br->block_len = restart_start;
     ++	br->full_block_size = full_block_size;
     ++	br->header_off = header_off;
     ++	br->restart_count = restart_count;
     ++	br->restart_bytes = restart_bytes;
      +
      +	return 0;
      +}
     @@ reftable/block.c (new)
      +	struct slice in = {
      +		.buf = a->r->block.data + off,
      +		.len = a->r->block_len - off,
     ++		.canary = SLICE_CANARY,
      +	};
      +
      +	/* the restart key is verbatim in the block, so this could avoid the
      +	   alloc for decoding the key */
     -+	struct slice rkey = { 0 };
     -+	struct slice last_key = { 0 };
     ++	struct slice rkey = SLICE_INIT;
     ++	struct slice last_key = SLICE_INIT;
      +	byte unused_extra;
      +	int n = reftable_decode_key(&rkey, &unused_extra, last_key, in);
     ++	int result;
      +	if (n < 0) {
      +		a->error = 1;
      +		return -1;
      +	}
      +
     -+	{
     -+		int result = slice_cmp(a->key, rkey);
     -+		slice_release(&rkey);
     -+		return result;
     -+	}
     ++	result = slice_cmp(a->key, rkey);
     ++	slice_release(&rkey);
     ++	return result;
      +}
      +
      +void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
     @@ reftable/block.c (new)
      +	struct slice in = {
      +		.buf = it->br->block.data + it->next_off,
      +		.len = it->br->block_len - it->next_off,
     ++		.canary = SLICE_CANARY,
      +	};
      +	struct slice start = in;
     -+	struct slice key = { 0 };
     ++	struct slice key = SLICE_INIT;
      +	byte extra = 0;
      +	int n = 0;
      +
     -+	if (it->next_off >= it->br->block_len) {
     ++	if (it->next_off >= it->br->block_len)
      +		return 1;
     -+	}
      +
      +	n = reftable_decode_key(&key, &extra, it->last_key, in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +
      +	slice_consume(&in, n);
      +	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&in, n);
      +
      +	slice_copy(&it->last_key, key);
     @@ reftable/block.c (new)
      +
      +int block_reader_first_key(struct block_reader *br, struct slice *key)
      +{
     -+	struct slice empty = { 0 };
     ++	struct slice empty = SLICE_INIT;
      +	int off = br->header_off + 4;
      +	struct slice in = {
      +		.buf = br->block.data + off,
      +		.len = br->block_len - off,
     ++		.canary = SLICE_CANARY,
      +	};
      +
      +	byte extra = 0;
      +	int n = reftable_decode_key(key, &extra, empty, in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
     ++
      +	return 0;
      +}
      +
     @@ reftable/block.c (new)
      +		.r = br,
      +	};
      +	struct reftable_record rec = reftable_new_record(block_reader_type(br));
     -+	struct slice key = { 0 };
     ++	struct slice key = SLICE_INIT;
      +	int err = 0;
     -+	struct block_iter next = { 0 };
     ++	struct block_iter next = {
     ++		.last_key = SLICE_INIT,
     ++	};
      +
      +	int i = binsearch(br->restart_count, &restart_key_less, &args);
      +	if (args.error) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	it->br = br;
     @@ reftable/block.c (new)
      +	while (true) {
      +		block_iter_copy_from(&next, it);
      +		err = block_iter_next(&next, &rec);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     ++		if (err < 0)
     ++			goto done;
      +
      +		reftable_record_key(&rec, &key);
      +		if (err > 0 || slice_cmp(key, want) >= 0) {
      +			err = 0;
     -+			goto exit;
     ++			goto done;
      +		}
      +
      +		block_iter_copy_from(it, &next);
      +	}
      +
     -+exit:
     ++done:
      +	slice_release(&key);
      +	slice_release(&next.last_key);
      +	reftable_record_destroy(&rec);
     @@ reftable/block.h (new)
      +	struct slice last_key;
      +};
      +
     -+/* initializes a block reader */
     ++/* initializes a block reader. */
      +int block_reader_init(struct block_reader *br, struct reftable_block *bl,
      +		      uint32_t header_off, uint32_t table_block_size,
      +		      int hash_size);
     @@ reftable/file.c (new)
      +	struct file_block_source *b = (struct file_block_source *)v;
      +	assert(off + size <= b->size);
      +	dest->data = reftable_malloc(size);
     -+	if (pread(b->fd, dest->data, size, off) != size) {
     ++	if (pread(b->fd, dest->data, size, off) != size)
      +		return -1;
     -+	}
      +	dest->len = size;
      +	return size;
      +}
     @@ reftable/file.c (new)
      +	}
      +
      +	err = fstat(fd, &st);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return -1;
     -+	}
      +
      +	p = reftable_calloc(sizeof(struct file_block_source));
      +	p->size = st.st_size;
     @@ reftable/iter.c (new)
      +
      +static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
      +{
     ++	uint64_t off;
     ++	int err = 0;
      +	if (it->offset_idx == it->offset_len) {
      +		it->finished = true;
      +		return 1;
     @@ reftable/iter.c (new)
      +
      +	reftable_block_done(&it->block_reader.block);
      +
     -+	{
     -+		uint64_t off = it->offsets[it->offset_idx++];
     -+		int err = reader_init_block_reader(it->r, &it->block_reader,
     -+						   off, BLOCK_TYPE_REF);
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		if (err > 0) {
     -+			/* indexed block does not exist. */
     -+			return REFTABLE_FORMAT_ERROR;
     -+		}
     ++	off = it->offsets[it->offset_idx++];
     ++	err = reader_init_block_reader(it->r, &it->block_reader, off,
     ++				       BLOCK_TYPE_REF);
     ++	if (err < 0) {
     ++		return err;
     ++	}
     ++	if (err > 0) {
     ++		/* indexed block does not exist. */
     ++		return REFTABLE_FORMAT_ERROR;
      +	}
      +	block_reader_start(&it->block_reader, &it->cur);
      +	return 0;
     @@ reftable/iter.c (new)
      +			       struct reftable_reader *r, byte *oid,
      +			       int oid_len, uint64_t *offsets, int offset_len)
      +{
     ++	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
      +	struct indexed_table_ref_iter *itr =
      +		reftable_calloc(sizeof(struct indexed_table_ref_iter));
      +	int err = 0;
      +
     ++	*itr = empty;
      +	itr->r = r;
      +	slice_resize(&itr->oid, oid_len);
      +	memcpy(itr->oid.buf, oid, oid_len);
     @@ reftable/iter.h (new)
      +	struct slice oid;
      +	struct reftable_iterator it;
      +};
     ++#define FILTERING_REF_ITERATOR_INIT \
     ++	{                           \
     ++		.oid = SLICE_INIT   \
     ++	}
      +
      +void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
      +					  struct filtering_ref_iterator *);
     @@ reftable/iter.h (new)
      +	bool finished;
      +};
      +
     ++#define INDEXED_TABLE_REF_ITER_INIT                                   \
     ++	{                                                             \
     ++		.cur = { .last_key = SLICE_INIT }, .oid = SLICE_INIT, \
     ++	}
     ++
      +void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr);
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
     @@ reftable/merged.c (new)
      +		.index = idx,
      +	};
      +	int err = iterator_next(&mi->stack[idx], &rec);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	if (err > 0) {
      +		reftable_iterator_destroy(&mi->stack[idx]);
     @@ reftable/merged.c (new)
      +
      +static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
      +{
     -+	if (iterator_is_null(&mi->stack[idx])) {
     ++	if (iterator_is_null(&mi->stack[idx]))
      +		return 0;
     -+	}
      +	return merged_iter_advance_nonnull_subiter(mi, idx);
      +}
      +
      +static int merged_iter_next_entry(struct merged_iter *mi,
      +				  struct reftable_record *rec)
      +{
     -+	struct slice entry_key = { 0 };
     ++	struct slice entry_key = SLICE_INIT;
      +	struct pq_entry entry = { 0 };
      +	int err = 0;
      +
     -+	if (merged_iter_pqueue_is_empty(mi->pq)) {
     ++	if (merged_iter_pqueue_is_empty(mi->pq))
      +		return 1;
     -+	}
      +
      +	entry = merged_iter_pqueue_remove(&mi->pq);
      +	err = merged_iter_advance_subiter(mi, entry.index);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	/*
      +	  One can also use reftable as datacenter-local storage, where the ref
     @@ reftable/merged.c (new)
      +	reftable_record_key(&entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     -+		struct slice k = { 0 };
     ++		struct slice k = SLICE_INIT;
      +		int err = 0, cmp = 0;
      +
      +		reftable_record_key(&top.rec, &k);
     @@ reftable/merged.c (new)
      +static int merged_iter_next_void(void *p, struct reftable_record *rec)
      +{
      +	struct merged_iter *mi = (struct merged_iter *)p;
     -+	if (merged_iter_pqueue_is_empty(mi->pq)) {
     ++	if (merged_iter_pqueue_is_empty(mi->pq))
      +		return 1;
     -+	}
      +
      +	return merged_iter_next(mi, rec);
      +}
     @@ reftable/merged.c (new)
      +	if (err < 0) {
      +		merged_iter_close(&merged);
      +		return err;
     -+	}
     -+
     -+	{
     ++	} else {
      +		struct merged_iter *p =
      +			reftable_malloc(sizeof(struct merged_iter));
      +		*p = merged;
     @@ reftable/pq.c (new)
      +
      +int pq_less(struct pq_entry a, struct pq_entry b)
      +{
     -+	struct slice ak = { 0 };
     -+	struct slice bk = { 0 };
     ++	struct slice ak = SLICE_INIT;
     ++	struct slice bk = SLICE_INIT;
      +	int cmp = 0;
      +	reftable_record_key(&a.rec, &ak);
      +	reftable_record_key(&b.rec, &bk);
     @@ reftable/pq.c (new)
      +	slice_release(&ak);
      +	slice_release(&bk);
      +
     -+	if (cmp == 0) {
     ++	if (cmp == 0)
      +		return a.index > b.index;
     -+	}
      +
      +	return cmp < 0;
      +}
     @@ reftable/reader.c (new)
      +			    struct reftable_block *dest, uint64_t off,
      +			    uint32_t sz)
      +{
     -+	if (off >= r->size) {
     ++	if (off >= r->size)
      +		return 0;
     -+	}
      +
      +	if (off + sz > r->size) {
      +		sz = r->size - off;
     @@ reftable/reader.c (new)
      +
      +	if (memcmp(f, "REFT", 4)) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +	f += 4;
      +
      +	if (memcmp(footer, header, header_size(r->version))) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	f++;
     @@ reftable/reader.c (new)
      +			break;
      +		default:
      +			err = REFTABLE_FORMAT_ERROR;
     -+			goto exit;
     ++			goto done;
      +		}
      +		f += 4;
      +	}
     @@ reftable/reader.c (new)
      +	f += 4;
      +	if (computed_crc != file_crc) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	first_block_typ = header[header_size(r->version)];
     @@ reftable/reader.c (new)
      +				  r->log_offsets.offset > 0);
      +	r->obj_offsets.present = r->obj_offsets.offset > 0;
      +	err = 0;
     -+exit:
     ++done:
      +	return err;
      +}
      +
     @@ reftable/reader.c (new)
      +	err = block_source_read_block(source, &header, 0, header_size(2) + 1);
      +	if (err != header_size(2) + 1) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	if (memcmp(header.data, "REFT", 4)) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +	r->version = header.data[4];
      +	if (r->version != 1 && r->version != 2) {
      +		err = REFTABLE_FORMAT_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	r->size = block_source_size(source) - footer_size(r->version);
     @@ reftable/reader.c (new)
      +				      footer_size(r->version));
      +	if (err != footer_size(r->version)) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = parse_footer(r, footer.data, header.data);
     -+exit:
     ++done:
      +	reftable_block_done(&footer);
      +	reftable_block_done(&header);
      +	return err;
     @@ reftable/reader.c (new)
      +	struct block_iter bi;
      +	bool finished;
      +};
     ++#define TABLE_ITER_INIT                         \
     ++	{                                       \
     ++		.bi = {.last_key = SLICE_INIT } \
     ++	}
      +
      +static void table_iter_copy_from(struct table_iter *dest,
      +				 struct table_iter *src)
     @@ reftable/reader.c (new)
      +	uint32_t header_off = next_off ? 0 : header_size(r->version);
      +	int32_t block_size = 0;
      +
     -+	if (next_off >= r->size) {
     ++	if (next_off >= r->size)
      +		return 1;
     -+	}
      +
      +	err = reader_get_block(r, &block, next_off, guess_block_size);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	block_size = extract_block_size(block.data, &block_typ, next_off,
      +					r->version);
     -+	if (block_size < 0) {
     ++	if (block_size < 0)
      +		return block_size;
     -+	}
      +
      +	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
      +		reftable_block_done(&block);
     @@ reftable/reader.c (new)
      +		dest->finished = true;
      +		return 1;
      +	}
     -+	if (err != 0) {
     ++	if (err != 0)
      +		return err;
     -+	}
     -+
     -+	{
     ++	else {
      +		struct block_reader *brp =
      +			reftable_malloc(sizeof(struct block_reader));
      +		*brp = br;
     @@ reftable/reader.c (new)
      +
      +static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
      +{
     -+	if (reftable_record_type(rec) != ti->typ) {
     ++	if (reftable_record_type(rec) != ti->typ)
      +		return REFTABLE_API_ERROR;
     -+	}
      +
      +	while (true) {
     -+		struct table_iter next = { 0 };
     ++		struct table_iter next = TABLE_ITER_INIT;
      +		int err = 0;
      +		if (ti->finished) {
      +			return 1;
     @@ reftable/reader.c (new)
      +	struct block_reader *brp = NULL;
      +
      +	int err = reader_init_block_reader(r, &br, off, typ);
     -+	if (err != 0) {
     ++	if (err != 0)
      +		return err;
     -+	}
      +
      +	brp = reftable_malloc(sizeof(struct block_reader));
      +	*brp = br;
     @@ reftable/reader.c (new)
      +{
      +	struct reftable_record rec =
      +		reftable_new_record(reftable_record_type(want));
     -+	struct slice want_key = { 0 };
     -+	struct slice got_key = { 0 };
     -+	struct table_iter next = { 0 };
     ++	struct slice want_key = SLICE_INIT;
     ++	struct slice got_key = SLICE_INIT;
     ++	struct table_iter next = TABLE_ITER_INIT;
      +	int err = -1;
     ++
      +	reftable_record_key(want, &want_key);
      +
      +	while (true) {
      +		err = table_iter_next_block(&next, ti);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     ++		if (err < 0)
     ++			goto done;
      +
      +		if (err > 0) {
      +			break;
      +		}
      +
      +		err = block_reader_first_key(next.bi.br, &got_key);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     -+		{
     -+			int cmp = slice_cmp(got_key, want_key);
     -+			if (cmp > 0) {
     -+				table_iter_block_done(&next);
     -+				break;
     -+			}
     ++		if (err < 0)
     ++			goto done;
     ++
     ++		if (slice_cmp(got_key, want_key) > 0) {
     ++			table_iter_block_done(&next);
     ++			break;
      +		}
      +
      +		table_iter_block_done(ti);
     @@ reftable/reader.c (new)
      +	}
      +
      +	err = block_iter_seek(&ti->bi, want_key);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +	err = 0;
      +
     -+exit:
     ++done:
      +	block_iter_close(&next.bi);
      +	reftable_record_destroy(&rec);
      +	slice_release(&want_key);
     @@ reftable/reader.c (new)
      +			       struct reftable_iterator *it,
      +			       struct reftable_record *rec)
      +{
     -+	struct reftable_index_record want_index = { 0 };
     ++	struct reftable_index_record want_index = { .last_key = SLICE_INIT };
      +	struct reftable_record want_index_rec = { 0 };
     -+	struct reftable_index_record index_result = { 0 };
     ++	struct reftable_index_record index_result = { .last_key = SLICE_INIT };
      +	struct reftable_record index_result_rec = { 0 };
     -+	struct table_iter index_iter = { 0 };
     -+	struct table_iter next = { 0 };
     ++	struct table_iter index_iter = TABLE_ITER_INIT;
     ++	struct table_iter next = TABLE_ITER_INIT;
      +	int err = 0;
      +
      +	reftable_record_key(rec, &want_index.last_key);
     @@ reftable/reader.c (new)
      +	reftable_record_from_index(&index_result_rec, &index_result);
      +
      +	err = reader_start(r, &index_iter, reftable_record_type(rec), true);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = reader_seek_linear(r, &index_iter, &want_index_rec);
      +	while (true) {
      +		err = table_iter_next(&index_iter, &index_result_rec);
      +		table_iter_block_done(&index_iter);
     -+		if (err != 0) {
     -+			goto exit;
     -+		}
     ++		if (err != 0)
     ++			goto done;
      +
      +		err = reader_table_iter_at(r, &next, index_result.offset, 0);
     -+		if (err != 0) {
     -+			goto exit;
     -+		}
     ++		if (err != 0)
     ++			goto done;
      +
      +		err = block_iter_seek(&next.bi, want_index.last_key);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     ++		if (err < 0)
     ++			goto done;
      +
      +		if (next.typ == reftable_record_type(rec)) {
      +			err = 0;
     @@ reftable/reader.c (new)
      +	}
      +
      +	if (err == 0) {
     ++		struct table_iter empty = TABLE_ITER_INIT;
      +		struct table_iter *malloced =
      +			reftable_calloc(sizeof(struct table_iter));
     ++		*malloced = empty;
      +		table_iter_copy_from(malloced, &next);
      +		iterator_from_table_iter(it, malloced);
      +	}
     -+exit:
     ++done:
      +	block_iter_close(&next.bi);
      +	table_iter_close(&index_iter);
      +	reftable_record_clear(&want_index_rec);
     @@ reftable/reader.c (new)
      +	struct reftable_reader_offsets *offs =
      +		reader_offsets_for(r, reftable_record_type(rec));
      +	uint64_t idx = offs->index_offset;
     -+	struct table_iter ti = { 0 };
     ++	struct table_iter ti = TABLE_ITER_INIT;
      +	int err = 0;
     -+	if (idx > 0) {
     ++	if (idx > 0)
      +		return reader_seek_indexed(r, it, rec);
     -+	}
      +
      +	err = reader_start(r, &ti, reftable_record_type(rec), false);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +	err = reader_seek_linear(r, &ti, rec);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
     -+
     -+	{
     ++	else {
      +		struct table_iter *p =
      +			reftable_malloc(sizeof(struct table_iter));
      +		*p = ti;
     @@ reftable/reader.c (new)
      +	/* Look through the reverse index. */
      +	reftable_record_from_obj(&want_rec, &want);
      +	err = reader_seek(r, &oit, &want_rec);
     -+	if (err != 0) {
     -+		goto exit;
     -+	}
     ++	if (err != 0)
     ++		goto done;
      +
      +	/* read out the reftable_obj_record */
      +	reftable_record_from_obj(&got_rec, &got);
      +	err = iterator_next(&oit, &got_rec);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	if (err > 0 ||
      +	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
      +		/* didn't find it; return empty iterator */
      +		iterator_set_empty(it);
      +		err = 0;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
      +					 got.offsets, got.offset_len);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +	got.offsets = NULL;
      +	iterator_from_indexed_table_ref_iter(it, itr);
      +
     -+exit:
     ++done:
      +	reftable_iterator_destroy(&oit);
      +	reftable_record_clear(&got_rec);
      +	return err;
     @@ reftable/reader.c (new)
      +					      struct reftable_iterator *it,
      +					      byte *oid)
      +{
     ++	struct table_iter ti_empty = TABLE_ITER_INIT;
      +	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
      +	struct filtering_ref_iterator *filter = NULL;
     ++	struct filtering_ref_iterator empty = FILTERING_REF_ITERATOR_INIT;
      +	int oid_len = hash_size(r->hash_id);
     -+	int err = reader_start(r, ti, BLOCK_TYPE_REF, false);
     ++	int err;
     ++
     ++	*ti = ti_empty;
     ++	err = reader_start(r, ti, BLOCK_TYPE_REF, false);
      +	if (err < 0) {
      +		reftable_free(ti);
      +		return err;
      +	}
      +
     -+	filter = reftable_calloc(sizeof(struct filtering_ref_iterator));
     ++	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
     ++	*filter = empty;
      +	slice_resize(&filter->oid, oid_len);
      +	memcpy(filter->oid.buf, oid, oid_len);
      +	reftable_table_from_reader(&filter->tab, r);
     @@ reftable/reader.c (new)
      +int reftable_reader_refs_for(struct reftable_reader *r,
      +			     struct reftable_iterator *it, byte *oid)
      +{
     -+	if (r->obj_offsets.present) {
     ++	if (r->obj_offsets.present)
      +		return reftable_reader_refs_for_indexed(r, it, oid);
     -+	}
      +	return reftable_reader_refs_for_unindexed(r, it, oid);
      +}
      +
     @@ reftable/record.c (new)
      +	int ptr = 0;
      +	uint64_t val;
      +
     -+	if (in.len == 0) {
     ++	if (in.len == 0)
      +		return -1;
     -+	}
      +	val = in.buf[ptr] & 0x7f;
      +
      +	while (in.buf[ptr] & 0x80) {
     @@ reftable/record.c (new)
      +	}
      +
      +	n = sizeof(buf) - i - 1;
     -+	if (dest.len < n) {
     ++	if (dest.len < n)
      +		return -1;
     -+	}
      +	memcpy(dest.buf, &buf[i + 1], n);
      +	return n;
      +}
     @@ reftable/record.c (new)
      +	int start_len = in.len;
      +	uint64_t tsize = 0;
      +	int n = get_var_int(&tsize, in);
     -+	if (n <= 0) {
     ++	if (n <= 0)
      +		return -1;
     -+	}
      +	slice_consume(&in, n);
     -+	if (in.len < tsize) {
     ++	if (in.len < tsize)
      +		return -1;
     -+	}
      +
      +	slice_resize(dest, tsize + 1);
      +	dest->buf[tsize] = 0;
     @@ reftable/record.c (new)
      +	struct slice start = s;
      +	int l = strlen(str);
      +	int n = put_var_int(s, l);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
     -+	if (s.len < l) {
     ++	if (s.len < l)
      +		return -1;
     -+	}
      +	memcpy(s.buf, str, l);
      +	slice_consume(&s, l);
      +
     @@ reftable/record.c (new)
      +	int prefix_len = common_prefix_size(prev_key, key);
      +	uint64_t suffix_len = key.len - prefix_len;
      +	int n = put_var_int(dest, (uint64_t)prefix_len);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&dest, n);
      +
      +	*restart = (prefix_len == 0);
      +
      +	n = put_var_int(dest, suffix_len << 3 | (uint64_t)extra);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&dest, n);
      +
     -+	if (dest.len < suffix_len) {
     ++	if (dest.len < suffix_len)
      +		return -1;
     -+	}
      +	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
      +	slice_consume(&dest, suffix_len);
      +
     @@ reftable/record.c (new)
      +	uint64_t prefix_len = 0;
      +	uint64_t suffix_len = 0;
      +	int n = get_var_int(&prefix_len, in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&in, n);
      +
     -+	if (prefix_len > last_key.len) {
     ++	if (prefix_len > last_key.len)
      +		return -1;
     -+	}
      +
      +	n = get_var_int(&suffix_len, in);
     -+	if (n <= 0) {
     ++	if (n <= 0)
      +		return -1;
     -+	}
      +	slice_consume(&in, n);
      +
      +	*extra = (byte)(suffix_len & 0x7);
      +	suffix_len >>= 3;
      +
     -+	if (in.len < suffix_len) {
     ++	if (in.len < suffix_len)
      +		return -1;
     -+	}
      +
      +	slice_resize(key, suffix_len + prefix_len);
      +	memcpy(key->buf, last_key.buf, prefix_len);
     @@ reftable/record.c (new)
      +
      +static char hexdigit(int c)
      +{
     -+	if (c <= 9) {
     ++	if (c <= 9)
      +		return '0' + c;
     -+	}
      +	return 'a' + (c - 10);
      +}
      +
     @@ reftable/record.c (new)
      +		} else {
      +			return 1;
      +		}
     -+	} else if (r->target != NULL) {
     ++	} else if (r->target != NULL)
      +		return 3;
     -+	}
      +	return 0;
      +}
      +
     @@ reftable/record.c (new)
      +	struct slice start = s;
      +	int n = put_var_int(s, r->update_index);
      +	assert(hash_size > 0);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
      +	if (r->value != NULL) {
     @@ reftable/record.c (new)
      +	bool seen_target = false;
      +
      +	int n = get_var_int(&r->update_index, in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
      +	assert(hash_size > 0);
      +
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +		slice_consume(&in, hash_size);
      +		break;
      +	case 3: {
     -+		struct slice dest = { 0 };
     ++		struct slice dest = SLICE_INIT;
      +		int n = decode_string(&dest, in);
      +		if (n < 0) {
      +			return -1;
     @@ reftable/record.c (new)
      +	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
      +	const struct reftable_obj_record *src =
      +		(const struct reftable_obj_record *)src_rec;
     ++	int olen;
      +
      +	reftable_obj_record_clear(obj);
      +	*obj = *src;
      +	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
      +	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
      +
     -+	{
     -+		int olen = obj->offset_len * sizeof(uint64_t);
     -+		obj->offsets = reftable_malloc(olen);
     -+		memcpy(obj->offsets, src->offsets, olen);
     -+	}
     ++	olen = obj->offset_len * sizeof(uint64_t);
     ++	obj->offsets = reftable_malloc(olen);
     ++	memcpy(obj->offsets, src->offsets, olen);
      +}
      +
      +static byte reftable_obj_record_val_type(const void *rec)
      +{
      +	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
     -+	if (r->offset_len > 0 && r->offset_len < 8) {
     ++	if (r->offset_len > 0 && r->offset_len < 8)
      +		return r->offset_len;
     -+	}
      +	return 0;
      +}
      +
     @@ reftable/record.c (new)
      +		}
      +		slice_consume(&s, n);
      +	}
     -+	if (r->offset_len == 0) {
     ++	if (r->offset_len == 0)
      +		return start.len - s.len;
     -+	}
      +	n = put_var_int(s, r->offsets[0]);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
      +	last = r->offsets[0];
     @@ reftable/record.c (new)
      +
      +	r->offsets = NULL;
      +	r->offset_len = 0;
     -+	if (count == 0) {
     ++	if (count == 0)
      +		return start.len - in.len;
     -+	}
      +
      +	r->offsets = reftable_malloc(count * sizeof(uint64_t));
      +	r->offset_len = count;
      +
      +	n = get_var_int(&r->offsets[0], in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
      +	slice_consume(&in, n);
      +
      +	last = r->offsets[0];
     @@ reftable/record.c (new)
      +	int n = 0;
      +	byte *oldh = r->old_hash;
      +	byte *newh = r->new_hash;
     -+	if (reftable_log_record_is_deletion(r)) {
     ++	if (reftable_log_record_is_deletion(r))
      +		return 0;
     -+	}
      +
      +	if (oldh == NULL) {
      +		oldh = zero;
     @@ reftable/record.c (new)
      +		newh = zero;
      +	}
      +
     -+	if (s.len < 2 * hash_size) {
     ++	if (s.len < 2 * hash_size)
      +		return -1;
     -+	}
      +
      +	memcpy(s.buf, oldh, hash_size);
      +	memcpy(s.buf + hash_size, newh, hash_size);
      +	slice_consume(&s, 2 * hash_size);
      +
      +	n = encode_string(r->name ? r->name : "", s);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
      +	n = encode_string(r->email ? r->email : "", s);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
      +	n = put_var_int(s, r->time);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
     -+	if (s.len < 2) {
     ++	if (s.len < 2)
      +		return -1;
     -+	}
      +
      +	put_be16(s.buf, r->tz_offset);
      +	slice_consume(&s, 2);
      +
      +	n = encode_string(r->message ? r->message : "", s);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return -1;
     -+	}
      +	slice_consume(&s, n);
      +
      +	return start.len - s.len;
     @@ reftable/record.c (new)
      +	struct reftable_log_record *r = (struct reftable_log_record *)rec;
      +	uint64_t max = 0;
      +	uint64_t ts = 0;
     -+	struct slice dest = { 0 };
     ++	struct slice dest = SLICE_INIT;
      +	int n;
      +
     -+	if (key.len <= 9 || key.buf[key.len - 9] != 0) {
     ++	if (key.len <= 9 || key.buf[key.len - 9] != 0)
      +		return REFTABLE_FORMAT_ERROR;
     -+	}
      +
      +	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
      +	memcpy(r->ref_name, key.buf, key.len - 8);
     @@ reftable/record.c (new)
      +		return 0;
      +	}
      +
     -+	if (in.len < 2 * hash_size) {
     ++	if (in.len < 2 * hash_size)
      +		return REFTABLE_FORMAT_ERROR;
     -+	}
      +
      +	r->old_hash = reftable_realloc(r->old_hash, hash_size);
      +	r->new_hash = reftable_realloc(r->new_hash, hash_size);
     @@ reftable/record.c (new)
      +	slice_consume(&in, 2 * hash_size);
      +
      +	n = decode_string(&dest, in);
     -+	if (n < 0) {
     -+		goto error;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&in, n);
      +
      +	r->name = reftable_realloc(r->name, dest.len + 1);
     @@ reftable/record.c (new)
      +
      +	slice_resize(&dest, 0);
      +	n = decode_string(&dest, in);
     -+	if (n < 0) {
     -+		goto error;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&in, n);
      +
      +	r->email = reftable_realloc(r->email, dest.len + 1);
     @@ reftable/record.c (new)
      +
      +	ts = 0;
      +	n = get_var_int(&ts, in);
     -+	if (n < 0) {
     -+		goto error;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&in, n);
      +	r->time = ts;
     -+	if (in.len < 2) {
     -+		goto error;
     -+	}
     ++	if (in.len < 2)
     ++		goto done;
      +
      +	r->tz_offset = get_be16(in.buf);
      +	slice_consume(&in, 2);
      +
      +	slice_resize(&dest, 0);
      +	n = decode_string(&dest, in);
     -+	if (n < 0) {
     -+		goto error;
     -+	}
     ++	if (n < 0)
     ++		goto done;
      +	slice_consume(&in, n);
      +
      +	r->message = reftable_realloc(r->message, dest.len + 1);
     @@ reftable/record.c (new)
      +	slice_release(&dest);
      +	return start.len - in.len;
      +
     -+error:
     ++done:
      +	slice_release(&dest);
      +	return REFTABLE_FORMAT_ERROR;
      +}
     @@ reftable/record.c (new)
      +static bool null_streq(char *a, char *b)
      +{
      +	char *empty = "";
     -+	if (a == NULL) {
     ++	if (a == NULL)
      +		a = empty;
     -+	}
     -+	if (b == NULL) {
     ++
     ++	if (b == NULL)
      +		b = empty;
     -+	}
     ++
      +	return 0 == strcmp(a, b);
      +}
      +
      +static bool zero_hash_eq(byte *a, byte *b, int sz)
      +{
     -+	if (a == NULL) {
     ++	if (a == NULL)
      +		a = zero;
     -+	}
     -+	if (b == NULL) {
     ++
     ++	if (b == NULL)
      +		b = zero;
     -+	}
     ++
      +	return !memcmp(a, b, sz);
      +}
      +
     @@ reftable/record.c (new)
      +		return rec;
      +	}
      +	case BLOCK_TYPE_INDEX: {
     ++		struct reftable_index_record empty = { .last_key = SLICE_INIT };
      +		struct reftable_index_record *r =
      +			reftable_calloc(sizeof(struct reftable_index_record));
     ++		*r = empty;
      +		reftable_record_from_index(&rec, r);
      +		return rec;
      +	}
     @@ reftable/record.c (new)
      +	struct slice start = out;
      +
      +	int n = put_var_int(out, r->offset);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
      +
      +	slice_consume(&out, n);
      +
     @@ reftable/record.c (new)
      +	slice_copy(&r->last_key, key);
      +
      +	n = get_var_int(&r->offset, in);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
      +
      +	slice_consume(&in, n);
      +	return start.len - in.len;
     @@ reftable/record.c (new)
      +
      +static bool hash_equal(byte *a, byte *b, int hash_size)
      +{
     -+	if (a != NULL && b != NULL) {
     ++	if (a != NULL && b != NULL)
      +		return !memcmp(a, b, hash_size);
     -+	}
      +
      +	return a == b;
      +}
      +
      +static bool str_equal(char *a, char *b)
      +{
     -+	if (a != NULL && b != NULL) {
     ++	if (a != NULL && b != NULL)
      +		return 0 == strcmp(a, b);
     -+	}
      +
      +	return a == b;
      +}
     @@ reftable/record.c (new)
      +	struct reftable_log_record *lb = (struct reftable_log_record *)b;
      +
      +	int cmp = strcmp(la->ref_name, lb->ref_name);
     -+	if (cmp) {
     ++	if (cmp)
      +		return cmp;
     -+	}
     -+	if (la->update_index > lb->update_index) {
     ++	if (la->update_index > lb->update_index)
      +		return -1;
     -+	}
      +	return (la->update_index < lb->update_index) ? 1 : 0;
      +}
      +
     @@ reftable/refname.c (new)
      +		};
      +		int idx = binsearch(mod->add_len, find_name, &arg);
      +		if (idx < mod->add_len &&
     -+		    !strncmp(prefix, mod->add[idx], strlen(prefix))) {
     -+			goto exit;
     -+		}
     ++		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
     ++			goto done;
      +	}
      +	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
     -+	if (err) {
     -+		goto exit;
     -+	}
     ++	if (err)
     ++		goto done;
      +
      +	while (true) {
      +		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err) {
     -+			goto exit;
     -+		}
     ++		if (err)
     ++			goto done;
      +
      +		if (mod->del_len > 0) {
      +			struct find_arg arg = {
     @@ reftable/refname.c (new)
      +
      +		if (strncmp(ref.ref_name, prefix, strlen(prefix))) {
      +			err = 1;
     -+			goto exit;
     ++			goto done;
      +		}
      +		err = 0;
     -+		goto exit;
     ++		goto done;
      +	}
      +
     -+exit:
     ++done:
      +	reftable_ref_record_clear(&ref);
      +	reftable_iterator_destroy(&it);
      +	return err;
     @@ reftable/refname.c (new)
      +
      +int modification_validate(struct modification *mod)
      +{
     -+	struct slice slashed = { 0 };
     ++	struct slice slashed = SLICE_INIT;
      +	int err = 0;
      +	int i = 0;
      +	for (; i < mod->add_len; i++) {
      +		err = validate_ref_name(mod->add[i]);
     -+		if (err) {
     -+			goto exit;
     -+		}
     ++		if (err)
     ++			goto done;
      +		slice_set_string(&slashed, mod->add[i]);
      +		slice_addstr(&slashed, "/");
      +
     @@ reftable/refname.c (new)
      +			mod, slice_as_string(&slashed));
      +		if (err == 0) {
      +			err = REFTABLE_NAME_CONFLICT;
     -+			goto exit;
     -+		}
     -+		if (err < 0) {
     -+			goto exit;
     ++			goto done;
      +		}
     ++		if (err < 0)
     ++			goto done;
      +
      +		slice_set_string(&slashed, mod->add[i]);
      +		while (slashed.len) {
     @@ reftable/refname.c (new)
      +						   slice_as_string(&slashed));
      +			if (err == 0) {
      +				err = REFTABLE_NAME_CONFLICT;
     -+				goto exit;
     -+			}
     -+			if (err < 0) {
     -+				goto exit;
     ++				goto done;
      +			}
     ++			if (err < 0)
     ++				goto done;
      +		}
      +	}
      +	err = 0;
     -+exit:
     ++done:
      +	slice_release(&slashed);
      +	return err;
      +}
     @@ reftable/reftable.c (new)
      +{
      +	struct reftable_iterator it = { 0 };
      +	int err = reftable_table_seek_ref(tab, &it, name);
     -+	if (err) {
     -+		goto exit;
     -+	}
     ++	if (err)
     ++		goto done;
      +
      +	err = reftable_iterator_next_ref(&it, ref);
     -+	if (err) {
     -+		goto exit;
     -+	}
     ++	if (err)
     ++		goto done;
      +
      +	if (strcmp(ref->ref_name, name) ||
      +	    reftable_ref_record_is_deletion(ref)) {
      +		reftable_ref_record_clear(ref);
      +		err = 1;
     -+		goto exit;
     ++		goto done;
      +	}
      +
     -+exit:
     ++done:
      +	reftable_iterator_destroy(&it);
      +	return err;
      +}
     @@ reftable/slice.c (new)
      +
      +#include "reftable.h"
      +
     ++struct slice reftable_empty_slice = SLICE_INIT;
     ++
      +void slice_set_string(struct slice *s, const char *str)
      +{
     ++	int l;
      +	if (str == NULL) {
      +		s->len = 0;
      +		return;
      +	}
     ++	assert(s->canary == SLICE_CANARY);
      +
     -+	{
     -+		int l = strlen(str);
     -+		l++; /* \0 */
     -+		slice_resize(s, l);
     -+		memcpy(s->buf, str, l);
     -+		s->len = l - 1;
     -+	}
     ++	l = strlen(str);
     ++	l++; /* \0 */
     ++	slice_resize(s, l);
     ++	memcpy(s->buf, str, l);
     ++	s->len = l - 1;
     ++}
     ++
     ++void slice_init(struct slice *s)
     ++{
     ++	struct slice empty = SLICE_INIT;
     ++	*s = empty;
      +}
      +
      +void slice_resize(struct slice *s, int l)
      +{
     ++	assert(s->canary == SLICE_CANARY);
      +	if (s->cap < l) {
      +		int c = s->cap * 2;
      +		if (c < l) {
     @@ reftable/slice.c (new)
      +{
      +	int l1 = d->len;
      +	int l2 = strlen(s);
     ++	assert(d->canary == SLICE_CANARY);
      +
      +	slice_resize(d, l2 + l1);
      +	memcpy(d->buf + l1, s, l2);
     @@ reftable/slice.c (new)
      +void slice_addbuf(struct slice *s, struct slice a)
      +{
      +	int end = s->len;
     ++	assert(s->canary == SLICE_CANARY);
      +	slice_resize(s, s->len + a.len);
      +	memcpy(s->buf + end, a.buf, a.len);
      +}
      +
      +void slice_consume(struct slice *s, int n)
      +{
     ++	assert(s->canary == SLICE_CANARY);
      +	s->buf += n;
      +	s->len -= n;
      +}
     @@ reftable/slice.c (new)
      +byte *slice_detach(struct slice *s)
      +{
      +	byte *p = s->buf;
     ++	assert(s->canary == SLICE_CANARY);
      +	s->buf = NULL;
      +	s->cap = 0;
      +	s->len = 0;
     @@ reftable/slice.c (new)
      +
      +void slice_release(struct slice *s)
      +{
     ++	assert(s->canary == SLICE_CANARY);
      +	reftable_free(slice_detach(s));
      +}
      +
      +void slice_copy(struct slice *dest, struct slice src)
      +{
     ++	assert(dest->canary == SLICE_CANARY);
     ++	assert(src.canary == SLICE_CANARY);
      +	slice_resize(dest, src.len);
      +	memcpy(dest->buf, src.buf, src.len);
      +}
     @@ reftable/slice.c (new)
      +   a \0 is added at the end. */
      +const char *slice_as_string(struct slice *s)
      +{
     ++	assert(s->canary == SLICE_CANARY);
      +	if (s->cap == s->len) {
      +		int l = s->len;
      +		slice_resize(s, l + 1);
     @@ reftable/slice.c (new)
      +/* return a newly malloced string for this slice */
      +char *slice_to_string(struct slice in)
      +{
     -+	struct slice s = { 0 };
     ++	struct slice s = SLICE_INIT;
     ++	assert(in.canary == SLICE_CANARY);
      +	slice_resize(&s, in.len + 1);
      +	s.buf[in.len] = 0;
      +	memcpy(s.buf, in.buf, in.len);
     @@ reftable/slice.c (new)
      +
      +bool slice_equal(struct slice a, struct slice b)
      +{
     -+	if (a.len != b.len) {
     ++	assert(a.canary == SLICE_CANARY);
     ++	assert(b.canary == SLICE_CANARY);
     ++	if (a.len != b.len)
      +		return 0;
     -+	}
      +	return memcmp(a.buf, b.buf, a.len) == 0;
      +}
      +
     @@ reftable/slice.c (new)
      +{
      +	int min = a.len < b.len ? a.len : b.len;
      +	int res = memcmp(a.buf, b.buf, min);
     -+	if (res != 0) {
     ++	assert(a.canary == SLICE_CANARY);
     ++	assert(b.canary == SLICE_CANARY);
     ++	if (res != 0)
      +		return res;
     -+	}
     -+	if (a.len < b.len) {
     ++	if (a.len < b.len)
      +		return -1;
     -+	} else if (a.len > b.len) {
     ++	else if (a.len > b.len)
      +		return 1;
     -+	} else {
     ++	else
      +		return 0;
     -+	}
      +}
      +
      +int slice_add(struct slice *b, byte *data, size_t sz)
      +{
     ++	assert(b->canary == SLICE_CANARY);
      +	if (b->len + sz > b->cap) {
      +		int newcap = 2 * b->cap + 1;
      +		if (newcap < b->len + sz) {
     @@ reftable/slice.c (new)
      +int common_prefix_size(struct slice a, struct slice b)
      +{
      +	int p = 0;
     ++	assert(a.canary == SLICE_CANARY);
     ++	assert(b.canary == SLICE_CANARY);
      +	while (p < a.len && p < b.len) {
      +		if (a.buf[p] != b.buf[p]) {
      +			break;
     @@ reftable/slice.h (new)
      +	int len;
      +	int cap;
      +	byte *buf;
     ++	byte canary;
      +};
     ++#define SLICE_CANARY 0x42
     ++#define SLICE_INIT                       \
     ++	{                                \
     ++		0, 0, NULL, SLICE_CANARY \
     ++	}
     ++extern struct slice reftable_empty_slice;
      +
      +void slice_set_string(struct slice *dest, const char *src);
      +void slice_addstr(struct slice *dest, const char *src);
     @@ reftable/slice.h (new)
      +/* Return a malloced string for `src` */
      +char *slice_to_string(struct slice src);
      +
     ++/* Initializes a slice. Accepts a slice with random garbage. */
     ++void slice_init(struct slice *slice);
     ++
      +/* Ensure that `buf` is \0 terminated. */
      +const char *slice_as_string(struct slice *src);
      +
     @@ reftable/stack.c (new)
      +{
      +	struct reftable_stack *p =
      +		reftable_calloc(sizeof(struct reftable_stack));
     -+	struct slice list_file_name = { 0 };
     ++	struct slice list_file_name = SLICE_INIT;
      +	int err = 0;
      +
      +	if (config.hash_id == 0) {
     @@ reftable/stack.c (new)
      +	int err = 0;
      +	if (size < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +	err = lseek(fd, 0, SEEK_SET);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	buf = reftable_malloc(size + 1);
      +	if (read(fd, buf, size) != size) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +	buf[size] = 0;
      +
      +	parse_names(buf, size, namesp);
      +
     -+exit:
     ++done:
      +	reftable_free(buf);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +	int new_tables_len = 0;
      +	struct reftable_merged_table *new_merged = NULL;
      +	int i;
     -+	struct slice table_path = { 0 };
     ++	struct slice table_path = SLICE_INIT;
      +
      +	while (*names) {
      +		struct reftable_reader *rd = NULL;
     @@ reftable/stack.c (new)
      +
      +			err = reftable_block_source_from_file(
      +				&src, slice_as_string(&table_path));
     -+			if (err < 0) {
     -+				goto exit;
     -+			}
     ++			if (err < 0)
     ++				goto done;
      +
      +			err = reftable_new_reader(&rd, &src, name);
     -+			if (err < 0) {
     -+				goto exit;
     -+			}
     ++			if (err < 0)
     ++				goto done;
      +		}
      +
      +		new_tables[new_tables_len++] = rd;
     @@ reftable/stack.c (new)
      +	/* success! */
      +	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
      +					st->config.hash_id);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	new_tables = NULL;
      +	new_tables_len = 0;
     @@ reftable/stack.c (new)
      +		}
      +	}
      +
     -+exit:
     ++done:
      +	slice_release(&table_path);
      +	for (i = 0; i < new_tables_len; i++) {
      +		reader_close(new_tables[i]);
     @@ reftable/stack.c (new)
      +	time_t diff = a->tv_sec - b->tv_sec;
      +	int udiff = a->tv_usec - b->tv_usec;
      +
     -+	if (diff != 0) {
     ++	if (diff != 0)
      +		return diff;
     -+	}
      +
      +	return udiff;
      +}
     @@ reftable/stack.c (new)
      +	int err = gettimeofday(&deadline, NULL);
      +	int64_t delay = 0;
      +	int tries = 0;
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	deadline.tv_sec += 3;
      +	while (true) {
     @@ reftable/stack.c (new)
      +	char **names = NULL;
      +	int err = read_lines(st->list_file, &names);
      +	int i = 0;
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	for (i = 0; i < st->merged->stack_len; i++) {
      +		if (names[i] == NULL) {
      +			err = 1;
     -+			goto exit;
     ++			goto done;
      +		}
      +
      +		if (strcmp(st->merged->stack[i]->name, names[i])) {
      +			err = 1;
     -+			goto exit;
     ++			goto done;
      +		}
      +	}
      +
      +	if (names[st->merged->stack_len] != NULL) {
      +		err = 1;
     -+		goto exit;
     ++		goto done;
      +	}
      +
     -+exit:
     ++done:
      +	free_names(names);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +int reftable_stack_reload(struct reftable_stack *st)
      +{
      +	int err = stack_uptodate(st);
     -+	if (err > 0) {
     ++	if (err > 0)
      +		return reftable_stack_reload_maybe_reuse(st, true);
     -+	}
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +		return err;
      +	}
      +
     -+	if (!st->disable_auto_compact) {
     ++	if (!st->disable_auto_compact)
      +		return reftable_stack_auto_compact(st);
     -+	}
      +
      +	return 0;
      +}
     @@ reftable/stack.c (new)
      +	uint64_t next_update_index;
      +};
      +
     ++#define REFTABLE_ADDITION_INIT               \
     ++	{                                    \
     ++		.lock_file_name = SLICE_INIT \
     ++	}
     ++
      +static int reftable_stack_init_addition(struct reftable_addition *add,
      +					struct reftable_stack *st)
      +{
     @@ reftable/stack.c (new)
      +		} else {
      +			err = REFTABLE_IO_ERROR;
      +		}
     -+		goto exit;
     ++		goto done;
      +	}
      +	err = stack_uptodate(st);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	if (err > 1) {
      +		err = REFTABLE_LOCK_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	add->next_update_index = reftable_stack_next_update_index(st);
     -+exit:
     ++done:
      +	if (err) {
      +		reftable_addition_close(add);
      +	}
     @@ reftable/stack.c (new)
      +void reftable_addition_close(struct reftable_addition *add)
      +{
      +	int i = 0;
     -+	struct slice nm = { 0 };
     ++	struct slice nm = SLICE_INIT;
      +	for (i = 0; i < add->new_tables_len; i++) {
      +		slice_set_string(&nm, add->stack->list_file);
      +		slice_addstr(&nm, "/");
     @@ reftable/stack.c (new)
      +
      +int reftable_addition_commit(struct reftable_addition *add)
      +{
     -+	struct slice table_list = { 0 };
     ++	struct slice table_list = SLICE_INIT;
      +	int i = 0;
      +	int err = 0;
     -+	if (add->new_tables_len == 0) {
     -+		goto exit;
     -+	}
     ++	if (add->new_tables_len == 0)
     ++		goto done;
      +
      +	for (i = 0; i < add->stack->merged->stack_len; i++) {
      +		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
     @@ reftable/stack.c (new)
      +	slice_release(&table_list);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = close(add->lock_file_fd);
      +	add->lock_file_fd = 0;
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = rename(slice_as_string(&add->lock_file_name),
      +		     add->stack->list_file);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = reftable_stack_reload(add->stack);
      +
     -+exit:
     ++done:
      +	reftable_addition_close(add);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +				struct reftable_stack *st)
      +{
      +	int err = 0;
     ++	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
      +	*dest = reftable_calloc(sizeof(**dest));
     ++	**dest = empty;
      +	err = reftable_stack_init_addition(*dest, st);
      +	if (err) {
      +		reftable_free(*dest);
     @@ reftable/stack.c (new)
      +		  int (*write_table)(struct reftable_writer *wr, void *arg),
      +		  void *arg)
      +{
     -+	struct reftable_addition add = { 0 };
     ++	struct reftable_addition add = REFTABLE_ADDITION_INIT;
      +	int err = reftable_stack_init_addition(&add, st);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +	if (err > 0) {
      +		err = REFTABLE_LOCK_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = reftable_addition_add(&add, write_table, arg);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = reftable_addition_commit(&add);
     -+exit:
     ++done:
      +	reftable_addition_close(&add);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +					     void *arg),
      +			  void *arg)
      +{
     -+	struct slice temp_tab_file_name = { 0 };
     -+	struct slice tab_file_name = { 0 };
     -+	struct slice next_name = { 0 };
     ++	struct slice temp_tab_file_name = SLICE_INIT;
     ++	struct slice tab_file_name = SLICE_INIT;
     ++	struct slice next_name = SLICE_INIT;
      +	struct reftable_writer *wr = NULL;
      +	int err = 0;
      +	int tab_fd = 0;
     @@ reftable/stack.c (new)
      +	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
      +	if (tab_fd < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
      +				 &add->stack->config);
      +	err = write_table(wr, arg);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = reftable_writer_close(wr);
      +	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
      +		err = 0;
     -+		goto exit;
     -+	}
     -+	if (err < 0) {
     -+		goto exit;
     ++		goto done;
      +	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = close(tab_fd);
      +	tab_fd = 0;
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = stack_check_addition(add->stack,
      +				   slice_as_string(&temp_tab_file_name));
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	if (wr->min_update_index < add->next_update_index) {
      +		err = REFTABLE_API_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
     @@ reftable/stack.c (new)
      +		     slice_as_string(&tab_file_name));
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	add->new_tables = reftable_realloc(add->new_tables,
     @@ reftable/stack.c (new)
      +						   (add->new_tables_len + 1));
      +	add->new_tables[add->new_tables_len] = slice_to_string(next_name);
      +	add->new_tables_len++;
     -+exit:
     ++done:
      +	if (tab_fd > 0) {
      +		close(tab_fd);
      +		tab_fd = 0;
     @@ reftable/stack.c (new)
      +uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
      +{
      +	int sz = st->merged->stack_len;
     -+	if (sz > 0) {
     ++	if (sz > 0)
      +		return reftable_reader_max_update_index(
      +			       st->merged->stack[sz - 1]) +
      +		       1;
     -+	}
      +	return 1;
      +}
      +
     @@ reftable/stack.c (new)
      +				struct slice *temp_tab,
      +				struct reftable_log_expiry_config *config)
      +{
     -+	struct slice next_name = { 0 };
     ++	struct slice next_name = SLICE_INIT;
      +	int tab_fd = -1;
      +	struct reftable_writer *wr = NULL;
      +	int err = 0;
     @@ reftable/stack.c (new)
      +	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
      +
      +	err = stack_write_compact(st, wr, first, last, config);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +	err = reftable_writer_close(wr);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = close(tab_fd);
      +	tab_fd = 0;
      +
     -+exit:
     ++done:
      +	reftable_writer_free(wr);
      +	if (tab_fd > 0) {
      +		close(tab_fd);
     @@ reftable/stack.c (new)
      +					st->config.hash_id);
      +	if (err < 0) {
      +		reftable_free(subtabs);
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = reftable_merged_table_seek_ref(mt, &it, "");
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	while (true) {
      +		err = reftable_iterator_next_ref(&it, &ref);
     @@ reftable/stack.c (new)
      +	reftable_iterator_destroy(&it);
      +
      +	err = reftable_merged_table_seek_log(mt, &it, "");
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	while (true) {
      +		err = reftable_iterator_next_log(&it, &log);
     @@ reftable/stack.c (new)
      +		entries++;
      +	}
      +
     -+exit:
     ++done:
      +	reftable_iterator_destroy(&it);
      +	if (mt != NULL) {
      +		merged_table_clear(mt);
     @@ reftable/stack.c (new)
      +static int stack_compact_range(struct reftable_stack *st, int first, int last,
      +			       struct reftable_log_expiry_config *expiry)
      +{
     -+	struct slice temp_tab_file_name = { 0 };
     -+	struct slice new_table_name = { 0 };
     -+	struct slice lock_file_name = { 0 };
     -+	struct slice ref_list_contents = { 0 };
     -+	struct slice new_table_path = { 0 };
     ++	struct slice temp_tab_file_name = SLICE_INIT;
     ++	struct slice new_table_name = SLICE_INIT;
     ++	struct slice lock_file_name = SLICE_INIT;
     ++	struct slice ref_list_contents = SLICE_INIT;
     ++	struct slice new_table_path = SLICE_INIT;
      +	int err = 0;
      +	bool have_lock = false;
      +	int lock_file_fd = 0;
     @@ reftable/stack.c (new)
      +
      +	if (first > last || (expiry == NULL && first == last)) {
      +		err = 0;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	st->stats.attempts++;
     @@ reftable/stack.c (new)
      +		} else {
      +			err = REFTABLE_IO_ERROR;
      +		}
     -+		goto exit;
     ++		goto done;
      +	}
      +	/* Don't want to write to the lock for now.  */
      +	close(lock_file_fd);
     @@ reftable/stack.c (new)
      +
      +	have_lock = true;
      +	err = stack_uptodate(st);
     -+	if (err != 0) {
     -+		goto exit;
     -+	}
     ++	if (err != 0)
     ++		goto done;
      +
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct slice subtab_file_name = { 0 };
     -+		struct slice subtab_lock = { 0 };
     ++		struct slice subtab_file_name = SLICE_INIT;
     ++		struct slice subtab_lock = SLICE_INIT;
     ++		int sublock_file_fd = -1;
     ++
      +		slice_set_string(&subtab_file_name, st->reftable_dir);
      +		slice_addstr(&subtab_file_name, "/");
      +		slice_addstr(&subtab_file_name,
     @@ reftable/stack.c (new)
      +		slice_copy(&subtab_lock, subtab_file_name);
      +		slice_addstr(&subtab_lock, ".lock");
      +
     -+		{
     -+			int sublock_file_fd =
     -+				open(slice_as_string(&subtab_lock),
     -+				     O_EXCL | O_CREAT | O_WRONLY, 0644);
     -+			if (sublock_file_fd > 0) {
     -+				close(sublock_file_fd);
     -+			} else if (sublock_file_fd < 0) {
     -+				if (errno == EEXIST) {
     -+					err = 1;
     -+				} else {
     -+					err = REFTABLE_IO_ERROR;
     -+				}
     ++		sublock_file_fd = open(slice_as_string(&subtab_lock),
     ++				       O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++		if (sublock_file_fd > 0) {
     ++			close(sublock_file_fd);
     ++		} else if (sublock_file_fd < 0) {
     ++			if (errno == EEXIST) {
     ++				err = 1;
     ++			} else {
     ++				err = REFTABLE_IO_ERROR;
      +			}
      +		}
      +
     @@ reftable/stack.c (new)
      +			(char *)slice_as_string(&subtab_file_name);
      +		j++;
      +
     -+		if (err != 0) {
     -+			goto exit;
     -+		}
     ++		if (err != 0)
     ++			goto done;
      +	}
      +
      +	err = unlink(slice_as_string(&lock_file_name));
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +	have_lock = false;
      +
      +	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
     @@ reftable/stack.c (new)
      +	if (is_empty_table) {
      +		err = 0;
      +	}
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	lock_file_fd = open(slice_as_string(&lock_file_name),
      +			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     @@ reftable/stack.c (new)
      +		} else {
      +			err = REFTABLE_IO_ERROR;
      +		}
     -+		goto exit;
     ++		goto done;
      +	}
      +	have_lock = true;
      +
     @@ reftable/stack.c (new)
      +			     slice_as_string(&new_table_path));
      +		if (err < 0) {
      +			err = REFTABLE_IO_ERROR;
     -+			goto exit;
     ++			goto done;
      +		}
      +	}
      +
     @@ reftable/stack.c (new)
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
     -+		goto exit;
     ++		goto done;
      +	}
      +	err = close(lock_file_fd);
      +	lock_file_fd = 0;
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = rename(slice_as_string(&lock_file_name), st->list_file);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		unlink(slice_as_string(&new_table_path));
     -+		goto exit;
     ++		goto done;
      +	}
      +	have_lock = false;
      +
     @@ reftable/stack.c (new)
      +		listp++;
      +	}
      +
     -+exit:
     ++done:
      +	free_names(delete_on_success);
      +
      +	listp = subtable_locks;
     @@ reftable/stack.c (new)
      +int fastlog2(uint64_t sz)
      +{
      +	int l = 0;
     -+	if (sz == 0) {
     ++	if (sz == 0)
      +		return 0;
     -+	}
      +	for (; sz; sz /= 2) {
      +		l++;
      +	}
     @@ reftable/stack.c (new)
      +	struct segment seg =
      +		suggest_compaction_segment(sizes, st->merged->stack_len);
      +	reftable_free(sizes);
     -+	if (segment_size(&seg) > 0) {
     ++	if (segment_size(&seg) > 0)
      +		return stack_compact_range_stats(st, seg.start, seg.end - 1,
      +						 NULL);
     -+	}
      +
      +	return 0;
      +}
     @@ reftable/stack.c (new)
      +	struct reftable_iterator it = { 0 };
      +	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
      +	int err = reftable_merged_table_seek_log(mt, &it, refname);
     -+	if (err) {
     -+		goto exit;
     -+	}
     ++	if (err)
     ++		goto done;
      +
      +	err = reftable_iterator_next_log(&it, log);
     -+	if (err) {
     -+		goto exit;
     -+	}
     ++	if (err)
     ++		goto done;
      +
      +	if (strcmp(log->ref_name, refname) ||
      +	    reftable_log_record_is_deletion(log)) {
      +		err = 1;
     -+		goto exit;
     ++		goto done;
      +	}
      +
     -+exit:
     ++done:
      +	if (err) {
      +		reftable_log_record_clear(log);
      +	}
     @@ reftable/stack.c (new)
      +	int len = 0;
      +	int i = 0;
      +
     -+	if (st->config.skip_name_check) {
     ++	if (st->config.skip_name_check)
      +		return 0;
     -+	}
      +
      +	err = reftable_block_source_from_file(&src, new_tab_name);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = reftable_new_reader(&rd, &src, new_tab_name);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	err = reftable_reader_seek_ref(rd, &it, "");
      +	if (err > 0) {
      +		err = 0;
     -+		goto exit;
     -+	}
     -+	if (err < 0) {
     -+		goto exit;
     ++		goto done;
      +	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	while (true) {
      +		struct reftable_ref_record ref = { 0 };
     @@ reftable/stack.c (new)
      +		if (err > 0) {
      +			break;
      +		}
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     ++		if (err < 0)
     ++			goto done;
      +
      +		if (len >= cap) {
      +			cap = 2 * cap + 1;
     @@ reftable/stack.c (new)
      +
      +	err = validate_ref_record_addition(tab, refs, len);
      +
     -+exit:
     ++done:
      +	for (i = 0; i < len; i++) {
      +		reftable_ref_record_clear(&refs[i]);
      +	}
     @@ reftable/tree.c (new)
      +	}
      +
      +	res = compare(key, (*rootp)->key);
     -+	if (res < 0) {
     ++	if (res < 0)
      +		return tree_search(key, &(*rootp)->left, compare, insert);
     -+	} else if (res > 0) {
     ++	else if (res > 0)
      +		return tree_search(key, &(*rootp)->right, compare, insert);
     -+	}
      +	return *rootp;
      +}
      +
     @@ reftable/writer.c (new)
      +	if (w->pending_padding > 0) {
      +		byte *zeroed = reftable_calloc(w->pending_padding);
      +		int n = w->write(w->write_arg, zeroed, w->pending_padding);
     -+		if (n < 0) {
     ++		if (n < 0)
      +			return n;
     -+		}
      +
      +		w->pending_padding = 0;
      +		reftable_free(zeroed);
     @@ reftable/writer.c (new)
      +
      +	w->pending_padding = padding;
      +	n = w->write(w->write_arg, data, len);
     -+	if (n < 0) {
     ++	if (n < 0)
      +		return n;
     -+	}
      +	n += padding;
      +	return 0;
      +}
     @@ reftable/writer.c (new)
      +		block_start = header_size(writer_version(w));
      +	}
      +
     ++	slice_release(&w->last_key);
      +	block_writer_init(&w->block_writer_data, typ, w->block,
      +			  w->opts.block_size, block_start,
      +			  hash_size(w->opts.hash_id));
     @@ reftable/writer.c (new)
      +{
      +	struct reftable_writer *wp =
      +		reftable_calloc(sizeof(struct reftable_writer));
     ++	slice_init(&wp->block_writer_data.last_key);
      +	options_set_defaults(opts);
      +	if (opts->block_size >= (1 << 24)) {
      +		/* TODO - error return? */
      +		abort();
      +	}
     ++	wp->last_key = reftable_empty_slice;
      +	wp->block = reftable_calloc(opts->block_size);
      +	wp->write = writer_func;
      +	wp->write_arg = writer_arg;
     @@ reftable/writer.c (new)
      +	int offset_len;
      +	int offset_cap;
      +};
     ++#define OBJ_INDEX_TREE_NODE_INIT   \
     ++	{                          \
     ++		.hash = SLICE_INIT \
     ++	}
      +
      +static int obj_index_tree_node_compare(const void *a, const void *b)
      +{
     @@ reftable/writer.c (new)
      +					     &obj_index_tree_node_compare, 0);
      +	struct obj_index_tree_node *key = NULL;
      +	if (node == NULL) {
     -+		key = reftable_calloc(sizeof(struct obj_index_tree_node));
     ++		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
     ++		key = reftable_malloc(sizeof(struct obj_index_tree_node));
     ++		*key = empty;
     ++
      +		slice_copy(&key->hash, hash);
      +		tree_search((void *)key, &w->obj_index_tree,
      +			    &obj_index_tree_node_compare, 1);
     @@ reftable/writer.c (new)
      +			     struct reftable_record *rec)
      +{
      +	int result = -1;
     -+	struct slice key = { 0 };
     ++	struct slice key = SLICE_INIT;
      +	int err = 0;
      +	reftable_record_key(rec, &key);
     -+	if (slice_cmp(w->last_key, key) >= 0) {
     -+		goto exit;
     -+	}
     ++	if (slice_cmp(w->last_key, key) >= 0)
     ++		goto done;
      +
      +	slice_copy(&w->last_key, key);
      +	if (w->block_writer == NULL) {
     @@ reftable/writer.c (new)
      +
      +	if (block_writer_add(w->block_writer, rec) == 0) {
      +		result = 0;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	err = writer_flush_block(w);
      +	if (err < 0) {
      +		result = err;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	writer_reinit_block_writer(w, reftable_record_type(rec));
      +	err = block_writer_add(w->block_writer, rec);
      +	if (err < 0) {
      +		result = err;
     -+		goto exit;
     ++		goto done;
      +	}
      +
      +	result = 0;
     -+exit:
     ++done:
      +	slice_release(&key);
      +	return result;
      +}
     @@ reftable/writer.c (new)
      +	struct reftable_ref_record copy = *ref;
      +	int err = 0;
      +
     -+	if (ref->ref_name == NULL) {
     ++	if (ref->ref_name == NULL)
      +		return REFTABLE_API_ERROR;
     -+	}
      +	if (ref->update_index < w->min_update_index ||
     -+	    ref->update_index > w->max_update_index) {
     ++	    ref->update_index > w->max_update_index)
      +		return REFTABLE_API_ERROR;
     -+	}
      +
      +	reftable_record_from_ref(&rec, &copy);
      +	copy.update_index -= w->min_update_index;
      +	err = writer_add_record(w, &rec);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	if (!w->opts.skip_index_objects && ref->value != NULL) {
      +		struct slice h = {
      +			.buf = ref->value,
      +			.len = hash_size(w->opts.hash_id),
     ++			.canary = SLICE_CANARY,
      +		};
      +
      +		writer_index_hash(w, h);
      +	}
     ++
      +	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
      +		struct slice h = {
      +			.buf = ref->target_value,
      +			.len = hash_size(w->opts.hash_id),
     ++			.canary = SLICE_CANARY,
      +		};
      +		writer_index_hash(w, h);
      +	}
     @@ reftable/writer.c (new)
      +{
      +	struct reftable_record rec = { 0 };
      +	int err;
     -+	if (log->ref_name == NULL) {
     ++	if (log->ref_name == NULL)
      +		return REFTABLE_API_ERROR;
     -+	}
      +
      +	if (w->block_writer != NULL &&
      +	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
      +		int err = writer_finish_public_section(w);
     -+		if (err < 0) {
     ++		if (err < 0)
      +			return err;
     -+		}
      +	}
      +
      +	w->next -= w->pending_padding;
     @@ reftable/writer.c (new)
      +	int err = writer_flush_block(w);
      +	int i = 0;
      +	struct reftable_block_stats *bstats = NULL;
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	while (w->index_len > threshold) {
      +		struct reftable_index_record *idx = NULL;
     @@ reftable/writer.c (new)
      +				continue;
      +			}
      +
     -+			{
     -+				int err = writer_flush_block(w);
     -+				if (err < 0) {
     -+					return err;
     -+				}
     -+			}
     ++			err = writer_flush_block(w);
     ++			if (err < 0)
     ++				return err;
      +
      +			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
      +
     @@ reftable/writer.c (new)
      +	writer_clear_index(w);
      +
      +	err = writer_flush_block(w);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	bstats = writer_reftable_block_stats(w, typ);
      +	bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
     @@ reftable/writer.c (new)
      +		.offset_len = entry->offset_len,
      +	};
      +	struct reftable_record rec = { 0 };
     -+	if (arg->err < 0) {
     -+		goto exit;
     -+	}
     ++	if (arg->err < 0)
     ++		goto done;
      +
      +	reftable_record_from_obj(&rec, &obj_rec);
      +	arg->err = block_writer_add(arg->w->block_writer, &rec);
     -+	if (arg->err == 0) {
     -+		goto exit;
     -+	}
     ++	if (arg->err == 0)
     ++		goto done;
      +
      +	arg->err = writer_flush_block(arg->w);
     -+	if (arg->err < 0) {
     -+		goto exit;
     -+	}
     ++	if (arg->err < 0)
     ++		goto done;
      +
      +	writer_reinit_block_writer(arg->w, BLOCK_TYPE_OBJ);
      +	arg->err = block_writer_add(arg->w->block_writer, &rec);
     -+	if (arg->err == 0) {
     -+		goto exit;
     -+	}
     ++	if (arg->err == 0)
     ++		goto done;
      +	obj_rec.offset_len = 0;
      +	arg->err = block_writer_add(arg->w->block_writer, &rec);
      +
      +	/* Should be able to write into a fresh block. */
      +	assert(arg->err == 0);
      +
     -+exit:;
     ++done:;
      +}
      +
      +static void object_record_free(void *void_arg, void *key)
     @@ reftable/writer.c (new)
      +		infix_walk(w->obj_index_tree, &write_object_record, &closure);
      +	}
      +
     -+	if (closure.err < 0) {
     ++	if (closure.err < 0)
      +		return closure.err;
     -+	}
      +	return writer_finish_section(w);
      +}
      +
     @@ reftable/writer.c (new)
      +	byte typ = 0;
      +	int err = 0;
      +
     -+	if (w->block_writer == NULL) {
     ++	if (w->block_writer == NULL)
      +		return 0;
     -+	}
      +
      +	typ = block_writer_type(w->block_writer);
      +	err = writer_finish_section(w);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
      +	    w->stats.ref_stats.index_blocks > 0) {
      +		err = writer_dump_object_index(w);
     -+		if (err < 0) {
     ++		if (err < 0)
      +			return err;
     -+		}
      +	}
      +
      +	if (w->obj_index_tree != NULL) {
     @@ reftable/writer.c (new)
      +	byte *p = footer;
      +	int err = writer_finish_public_section(w);
      +	int empty_table = w->next == 0;
     -+	if (err != 0) {
     -+		goto exit;
     -+	}
     ++	if (err != 0)
     ++		goto done;
      +	w->pending_padding = 0;
      +	if (empty_table) {
      +		/* Empty tables need a header anyway. */
      +		byte header[28];
      +		int n = writer_write_header(w, header);
      +		err = padded_write(w, header, n, 0);
     -+		if (err < 0) {
     -+			goto exit;
     -+		}
     ++		if (err < 0)
     ++			goto done;
      +	}
      +
      +	p += writer_write_header(w, footer);
     @@ reftable/writer.c (new)
      +	p += 4;
      +
      +	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
     -+	if (err < 0) {
     -+		goto exit;
     -+	}
     ++	if (err < 0)
     ++		goto done;
      +
      +	if (empty_table) {
      +		err = REFTABLE_EMPTY_TABLE_ERROR;
     -+		goto exit;
     ++		goto done;
      +	}
      +
     -+exit:
     ++done:
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
     @@ reftable/writer.c (new)
      +	int raw_bytes = block_writer_finish(w->block_writer);
      +	int padding = 0;
      +	int err = 0;
     -+	struct reftable_index_record ir = { 0 };
     -+	if (raw_bytes < 0) {
     ++	struct reftable_index_record ir = { .last_key = SLICE_INIT };
     ++	if (raw_bytes < 0)
      +		return raw_bytes;
     -+	}
      +
      +	if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG) {
      +		padding = w->opts.block_size - raw_bytes;
     @@ reftable/writer.c (new)
      +	}
      +
      +	err = padded_write(w, w->block, raw_bytes, padding);
     -+	if (err < 0) {
     ++	if (err < 0)
      +		return err;
     -+	}
      +
      +	if (w->index_cap == w->index_len) {
      +		w->index_cap = 2 * w->index_cap + 1;
     @@ reftable/writer.c (new)
      +
      +int writer_flush_block(struct reftable_writer *w)
      +{
     -+	if (w->block_writer == NULL) {
     ++	if (w->block_writer == NULL)
      +		return 0;
     -+	}
     -+	if (w->block_writer->entries == 0) {
     ++	if (w->block_writer->entries == 0)
      +		return 0;
     -+	}
      +	return writer_flush_nonempty_block(w);
      +}
      +
  6:  865c2c4567a ! 10:  a86c3753717 Reftable support for git-core
     @@ Commit message
      
          TODO:
      
     -    * Resolve spots marked with XXX
     +    * Fix worktree commands
     +
     +    * Spots marked XXX
      
          Example use: see t/t0031-reftable.sh
      
     @@ refs/reftable-backend.c (new)
      +	strbuf_reset(&sb);
      +
      +	refs->err = reftable_new_stack(&refs->stack, refs->reftable_dir, cfg);
     ++	assert(refs->err != REFTABLE_API_ERROR);
      +	strbuf_release(&sb);
      +	return ref_store;
      +}
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	strbuf_release(&referent);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +	transaction->state = REF_TRANSACTION_PREPARED;
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	if (err < 0) {
      +		transaction->state = REF_TRANSACTION_CLOSED;
      +		strbuf_addf(errbuf, "reftable: transaction prepare: %s",
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	free(logs);
      +	free(sorted);
      +	return err;
     @@ refs/reftable-backend.c (new)
      +	err = reftable_addition_commit(add);
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_addition_destroy(add);
      +	transaction->state = REF_TRANSACTION_CLOSED;
      +	transaction->backend_data = NULL;
     @@ refs/reftable-backend.c (new)
      +				    struct ref_transaction *transaction,
      +				    struct strbuf *errmsg)
      +{
     ++	int err = reftable_transaction_prepare(ref_store, transaction, errmsg);
     ++	if (err)
     ++		return err;
     ++
      +	return reftable_transaction_finish(ref_store, transaction, errmsg);
      +}
      +
     @@ refs/reftable-backend.c (new)
      +
      +	err = reftable_writer_add_ref(writer, &write_ref);
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_ref_record_clear(&read_ref);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_addition_destroy(add);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +	if (err < 0) {
      +		goto done;
      +	}
     ++
     ++	string_list_sort(refnames);
      +	err = reftable_stack_reload(refs->stack);
      +	if (err) {
      +		goto done;
      +	}
      +	err = reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	}
      +	err = reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_ref_record_clear(&ref);
      +	return err;
      +}
     @@ refs/reftable-backend.c (new)
      +
      +	err = reftable_stack_add(refs->stack, &write_rename_table, &arg);
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	return err;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
      +
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_log_record_clear(&log);
      +	reftable_iterator_destroy(&it);
      +	clear_log_tombstones(&arg);
     @@ refs/reftable-backend.c (new)
      +		err = -1;
      +	}
      +done:
     ++	assert(err != REFTABLE_API_ERROR);
      +	reftable_ref_record_clear(&ref);
      +	return err;
      +}
     @@ t/t0031-reftable.sh (new)
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'clone calls transaction_initial_commit' '
     ++	test_commit message1 file1 &&
     ++	git clone . cloned &&
     ++	(test  -f cloned/file1 || echo "Fixme.")
     ++'
     ++
      +test_expect_success 'basic operation of reftable storage: commit, show-ref' '
      +	initialize &&
      +	test_commit file &&
  7:  6b248d5fdb4 = 11:  d3613c2ff53 Add GIT_DEBUG_REFS debugging mechanism
  8:  54102355ce7 = 12:  9b98ed614ec vcxproj: adjust for the reftable changes
  9:  7764ebf0956 ! 13:  5e401e4f1ac Add reftable testing infrastructure
     @@ Commit message
           * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
           * t1405 - inspecs .git/ directly.
      
     -    t6030-bisect-porcelain.sh                - 62 of 72
     +    Worst offenders:
     +
     +    t1400-update-ref.sh                      - 82 of 185
          t2400-worktree-add.sh                    - 58 of 69
     -    t3200-branch.sh                          - 58 of 145
     -    t7406-submodule-update.sh                - 54 of 54
     -    t5601-clone.sh                           - 51 of 105
     -    t9903-bash-prompt.sh                     - 50 of 66
          t1404-update-ref-errors.sh               - 44 of 53
     -    t5510-fetch.sh                           - 40 of 171
     -    t7400-submodule-basic.sh                 - 38 of 111
          t3514-cherry-pick-revert-gpg.sh          - 36 of 36
     +    t5541-http-push-smart.sh                 - 29 of 38
     +    t6003-rev-list-topo-order.sh             - 29 of 35
     +    t3420-rebase-autostash.sh                - 28 of 42
     +    t6120-describe.sh                        - 21 of 82
     +    t3430-rebase-merges.sh                   - 18 of 24
     +    t2018-checkout-branch.sh                 - 15 of 22
          ..
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     @@ t/t9903-bash-prompt.sh: test_description='test git-specific bash prompt function
       actual="$TRASH_DIRECTORY/actual"
      
       ## t/test-lib.sh ##
     -@@ t/test-lib.sh: FreeBSD)
     +@@ t/test-lib.sh: parisc* | hppa*)
       	;;
       esac
       

-- 
gitgitgadget
