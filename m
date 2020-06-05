Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D35C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FE5206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGOyaxdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFESDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFESD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D92C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y20so2238704wmi.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E2mVUtBPszmit5j8uG2yurxZ78p3em/QgD2ofl6AyQ4=;
        b=DGOyaxdZtmE/2cch1PgffZsbABAT/WfBTF49WaDhRmIZcG6PLELgHzQXFeuGjc3gXJ
         OrcbM3QLdBjjEsdmW63e88hK3HfB3/274/ovwnWSzptaxLL16LcHawHZF5s+/h0RWBBD
         UfkJTkNLXgq1fRLJY2uZdFPh1WDvK0voVhn+Y/j+vAeEoyQiAAJuxzCZSKZfXUUOTlJy
         jqXw+kjMZDMPp+V5u9pX54AG/6JS4iBbjqYdITyuEGjcKUYuHrA3o/LMml0e14zbkBrw
         1lHEK9dpLCkh7e0A2eJEybbUolbVUdnggkKVKHlNdUyJQDW1YW7hYnjgFvbE/5OcA1q6
         bEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E2mVUtBPszmit5j8uG2yurxZ78p3em/QgD2ofl6AyQ4=;
        b=JAT/3KN97bSbUiurcvIomns+r7Npglbo1hLxVHdyuKnp1IUGDSmDt1m/Ar3P11LqIX
         SjUAoICjL3gtxZ5z6ck3zWESQc4lGrTXb7SZw03iesR2tysS77X4tm5Wm+dmju4l0N6s
         GFpo1QNe2R02DIumeMpr3zH9j+H80sM5l9ZPfT1yxjCZaHRgc0ieHATMeiyXINfYErMr
         st4jMzGUnScCGldy764U+mPRCpMijXdtOmE4sJOwlSvQ4YMa5EVlH0tYCBI3ki8Ly/wS
         CZB5mbDNH3apWQMWL14+XwmtewYBlQHa1z50bWbLAq1WNdCf9MNefxg8eH2uu3LMDHrL
         kVRA==
X-Gm-Message-State: AOAM532VgKH7QnrKfgngGETaY7sJGCZ6hMhC+WBIeHInKf1A11iLJs5o
        GusdQG2lcPHS3tzdCQGom0ey6tdl
X-Google-Smtp-Source: ABdhPJztHFesroNOU6bUo4vee2hlUWtsHeN/lzEC3Qnudd3Xf/e1i3Amyui712UZ+keHA5BQ1B1wZg==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr3717473wmd.169.1591380201877;
        Fri, 05 Jun 2020 11:03:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y132sm7572408wmb.11.2020.06.05.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:20 -0700 (PDT)
Message-Id: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:04 +0000
Subject: [PATCH v16 00/14] Reftable support git-core
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

v18

 * fix pseudo ref usage
 * import and execute unittests too.

Han-Wen Nienhuys (13):
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

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   45 +-
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
 refs/refs-internal.h                          |   32 +
 refs/reftable-backend.c                       | 1331 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    1 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  433 ++++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  156 ++
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  243 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  320 ++++
 reftable/merged.h                             |   39 +
 reftable/merged_test.c                        |  273 ++++
 reftable/pq.c                                 |  113 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  742 +++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1113 ++++++++++++++
 reftable/record.h                             |  128 ++
 reftable/record_test.c                        |  400 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   38 +
 reftable/refname_test.c                       |   99 ++
 reftable/reftable-tests.h                     |   13 +
 reftable/reftable.c                           |   90 ++
 reftable/reftable.h                           |  564 +++++++
 reftable/reftable_test.c                      |  631 ++++++++
 reftable/slice.c                              |  243 +++
 reftable/slice.h                              |   87 ++
 reftable/slice_test.c                         |   40 +
 reftable/stack.c                              | 1207 +++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/stack_test.c                         |  743 +++++++++
 reftable/system.h                             |   54 +
 reftable/test_framework.c                     |   69 +
 reftable/test_framework.h                     |   64 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   62 +
 reftable/update.sh                            |   25 +
 reftable/writer.c                             |  644 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   12 +-
 t/helper/test-tool.c                          |    1 +
 t/helper/test-tool.h                          |    1 +
 t/t0031-reftable.sh                           |  147 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/t9903-bash-prompt.sh                        |    6 +
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 80 files changed, 12118 insertions(+), 195 deletions(-)
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
 create mode 100644 reftable/constants.h
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
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0033-debug-refs.sh


base-commit: aada2199e11bff14ee91d5d590c2e3d3eba5e148
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v16
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v16
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v15:

  1:  9bb64f748dc !  1:  4a1f600fb85 Write pseudorefs through ref backends.
     @@ refs/refs-internal.h: typedef int copy_ref_fn(struct ref_store *ref_store,
      +			       const struct object_id *oid,
      +			       const struct object_id *old_oid,
      +			       struct strbuf *err);
     ++
     ++/*
     ++ * Deletes a pseudoref. Deletion always succeeds (even if the pseudoref doesn't
     ++ * exist.), except if old_oid is specified. If it is, it can fail due to lock
     ++ * failure, failure reading the old OID, or an OID mismatch
     ++ */
      +typedef int delete_pseudoref_fn(struct ref_store *ref_store,
      +				const char *pseudoref,
      +				const struct object_id *old_oid);
  2:  d489806907b =  2:  a4a67ce9635 Make refs_ref_exists public
  3:  60a82678a1b =  3:  ecd6591d86f Treat BISECT_HEAD as a pseudo ref
  4:  1a925f5671a !  4:  7c31727de69 Treat CHERRY_PICK_HEAD as a pseudo ref
     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
      -		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
      +		if (refs_ref_exists(get_main_ref_store(r),
      +				    "CHERRY_PICK_HEAD") &&
     -+		    !refs_delete_pseudoref(get_main_ref_store(r),
     -+					   "CHERRY_PICK_HEAD", NULL))
     ++		    refs_delete_pseudoref(get_main_ref_store(r),
     ++					  "CHERRY_PICK_HEAD", NULL))
       			return error(_("could not remove CHERRY_PICK_HEAD"));
       		if (!final_fixup)
       			return 0;
  5:  8f2ebf65b90 !  5:  fbdcee5208b Treat REVERT_HEAD as a pseudo ref
     @@ sequencer.c: static int create_seq_dir(struct repository *r)
       	const char *in_progress_advice = NULL;
       	unsigned int advise_skip =
      -		file_exists(git_path_revert_head(r)) ||
     --		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
     -+		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD");
     -+	refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
     ++		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
     + 		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
       
       	if (!sequencer_get_last_command(r, &action)) {
     - 		switch (action) {
      @@ sequencer.c: static int rollback_single_pick(struct repository *r)
       	struct object_id head_oid;
       
  6:  e0e1e3a558d =  6:  d8801367f7d Move REF_LOG_ONLY to refs-internal.h
  7:  27a980d1d9d =  7:  556d57610cc Iterate over the "refs/" namespace in for_each_[raw]ref
  8:  dcbd000e7f7 =  8:  78cb1930172 Add .gitattributes for the reftable/ directory
  9:  718b646a54e !  9:  0bc28ac610f Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit fe15c65dd95b6a13de92b4baf711e50338ef20ae
     -+Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Thu May 28 19:28:24 2020 +0200
     -+
     -+    C: add 'canary' to struct slice
     -+    
     -+    This enforces that all slices are initialized explicitly with
     -+    SLICE_INIT, for future compatibility with git's strbuf.
     ++0c164275ea8f8aa7d099f7425ddcef1affe137e9 C: compile framework with Git options
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +}
      +
      +int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice key);
     ++				  struct slice *key);
      +
      +void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size)
     @@ reftable/block.c (new)
      +	slice_consume(&out, n);
      +
      +	if (block_writer_register_restart(w, start.len - out.len, restart,
     -+					  key) < 0)
     ++					  &key) < 0)
      +		goto done;
      +
      +	slice_release(&key);
     @@ reftable/block.c (new)
      +}
      +
      +int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice key)
     ++				  struct slice *key)
      +{
      +	int rlen = w->restart_len;
      +	if (rlen >= MAX_RESTARTS) {
     @@ reftable/block.c (new)
      +		return -1;
      +	}
      +
     -+	result = slice_cmp(a->key, rkey);
     ++	result = slice_cmp(&a->key, &rkey);
      +	slice_release(&rkey);
      +	return result;
      +}
     @@ reftable/block.c (new)
      +{
      +	dest->br = src->br;
      +	dest->next_off = src->next_off;
     -+	slice_copy(&dest->last_key, src->last_key);
     ++	slice_copy(&dest->last_key, &src->last_key);
      +}
      +
      +int block_iter_next(struct block_iter *it, struct reftable_record *rec)
     @@ reftable/block.c (new)
      +		return -1;
      +	slice_consume(&in, n);
      +
     -+	slice_copy(&it->last_key, key);
     ++	slice_copy(&it->last_key, &key);
      +	it->next_off += start.len - in.len;
      +	slice_release(&key);
      +	return 0;
     @@ reftable/block.c (new)
      +	return 0;
      +}
      +
     -+int block_iter_seek(struct block_iter *it, struct slice want)
     ++int block_iter_seek(struct block_iter *it, struct slice *want)
      +{
      +	return block_reader_seek(it->br, it, want);
      +}
     @@ reftable/block.c (new)
      +}
      +
      +int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice want)
     ++		      struct slice *want)
      +{
      +	struct restart_find_args args = {
     -+		.key = want,
     ++		.key = *want,
      +		.r = br,
      +	};
      +	struct reftable_record rec = reftable_new_record(block_reader_type(br));
     @@ reftable/block.c (new)
      +			goto done;
      +
      +		reftable_record_key(&rec, &key);
     -+		if (err > 0 || slice_cmp(key, want) >= 0) {
     ++		if (err > 0 || slice_cmp(&key, want) >= 0) {
      +			err = 0;
      +			goto done;
      +		}
     @@ reftable/block.h (new)
      +
      +/* Position `it` to the `want` key in the block */
      +int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice want);
     ++		      struct slice *want);
      +
      +/* Returns the block type (eg. 'r' for refs) */
      +byte block_reader_type(struct block_reader *r);
     @@ reftable/block.h (new)
      +int block_iter_next(struct block_iter *it, struct reftable_record *rec);
      +
      +/* Seek to `want` with in the block pointed to by `it` */
     -+int block_iter_seek(struct block_iter *it, struct slice want);
     ++int block_iter_seek(struct block_iter *it, struct slice *want);
      +
      +/* deallocate memory for `it`. The block reader and its block is left intact. */
      +void block_iter_close(struct block_iter *it);
     @@ reftable/block.h (new)
      +
      +#endif
      
     + ## reftable/block_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "block.h"
     ++
     ++#include "system.h"
     ++
     ++#include "basics.h"
     ++#include "constants.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++struct binsearch_args {
     ++	int key;
     ++	int *arr;
     ++};
     ++
     ++static int binsearch_func(size_t i, void *void_args)
     ++{
     ++	struct binsearch_args *args = (struct binsearch_args *)void_args;
     ++
     ++	return args->key < args->arr[i];
     ++}
     ++
     ++static void test_binsearch(void)
     ++{
     ++	int arr[] = { 2, 4, 6, 8, 10 };
     ++	size_t sz = ARRAY_SIZE(arr);
     ++	struct binsearch_args args = {
     ++		.arr = arr,
     ++	};
     ++
     ++	int i = 0;
     ++	for (i = 1; i < 11; i++) {
     ++		int res;
     ++		args.key = i;
     ++		res = binsearch(sz, &binsearch_func, &args);
     ++
     ++		if (res < sz) {
     ++			assert(args.key < arr[res]);
     ++			if (res > 0) {
     ++				assert(args.key >= arr[res - 1]);
     ++			}
     ++		} else {
     ++			assert(args.key == 10 || args.key == 11);
     ++		}
     ++	}
     ++}
     ++
     ++static void test_block_read_write(void)
     ++{
     ++	const int header_off = 21; /* random */
     ++	char *names[30];
     ++	const int N = ARRAY_SIZE(names);
     ++	const int block_size = 1024;
     ++	struct reftable_block block = { 0 };
     ++	struct block_writer bw = {
     ++		.last_key = SLICE_INIT,
     ++	};
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_record rec = { 0 };
     ++	int i = 0;
     ++	int n;
     ++	struct block_reader br = { 0 };
     ++	struct block_iter it = { .last_key = SLICE_INIT };
     ++	int j = 0;
     ++	struct slice want = SLICE_INIT;
     ++
     ++	block.data = reftable_calloc(block_size);
     ++	block.len = block_size;
     ++	block.source = malloc_block_source();
     ++	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
     ++			  header_off, hash_size(SHA1_ID));
     ++	reftable_record_from_ref(&rec, &ref);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		char name[100];
     ++		byte hash[SHA1_SIZE];
     ++		snprintf(name, sizeof(name), "branch%02d", i);
     ++		memset(hash, i, sizeof(hash));
     ++
     ++		ref.ref_name = name;
     ++		ref.value = hash;
     ++		names[i] = xstrdup(name);
     ++		n = block_writer_add(&bw, &rec);
     ++		ref.ref_name = NULL;
     ++		ref.value = NULL;
     ++		assert(n == 0);
     ++	}
     ++
     ++	n = block_writer_finish(&bw);
     ++	assert(n > 0);
     ++
     ++	block_writer_clear(&bw);
     ++
     ++	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
     ++
     ++	block_reader_start(&br, &it);
     ++
     ++	while (true) {
     ++		int r = block_iter_next(&it, &rec);
     ++		assert(r >= 0);
     ++		if (r > 0) {
     ++			break;
     ++		}
     ++		assert_streq(names[j], ref.ref_name);
     ++		j++;
     ++	}
     ++
     ++	reftable_record_clear(&rec);
     ++	block_iter_close(&it);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		struct block_iter it = { .last_key = SLICE_INIT };
     ++		slice_set_string(&want, names[i]);
     ++
     ++		n = block_reader_seek(&br, &it, &want);
     ++		assert(n == 0);
     ++
     ++		n = block_iter_next(&it, &rec);
     ++		assert(n == 0);
     ++
     ++		assert_streq(names[i], ref.ref_name);
     ++
     ++		want.len--;
     ++		n = block_reader_seek(&br, &it, &want);
     ++		assert(n == 0);
     ++
     ++		n = block_iter_next(&it, &rec);
     ++		assert(n == 0);
     ++		assert_streq(names[10 * (i / 10)], ref.ref_name);
     ++
     ++		block_iter_close(&it);
     ++	}
     ++
     ++	reftable_record_clear(&rec);
     ++	reftable_block_done(&br.block);
     ++	slice_release(&want);
     ++	for (i = 0; i < N; i++) {
     ++		reftable_free(names[i]);
     ++	}
     ++}
     ++
     ++int block_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("binsearch", &test_binsearch);
     ++	add_test_case("block_read_write", &test_block_read_write);
     ++	return test_main(argc, argv);
     ++}
     +
       ## reftable/constants.h (new) ##
      @@
      +/*
     @@ reftable/merged.c (new)
      +
      +		reftable_record_key(&top.rec, &k);
      +
     -+		cmp = slice_cmp(k, entry_key);
     ++		cmp = slice_cmp(&k, &entry_key);
      +		slice_release(&k);
      +
      +		if (cmp > 0) {
     @@ reftable/merged.h (new)
      +
      +#endif
      
     + ## reftable/merged_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "merged.h"
     ++
     ++#include "system.h"
     ++
     ++#include "basics.h"
     ++#include "block.h"
     ++#include "constants.h"
     ++#include "pq.h"
     ++#include "reader.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++static void test_pq(void)
     ++{
     ++	char *names[54] = { 0 };
     ++	int N = ARRAY_SIZE(names) - 1;
     ++
     ++	struct merged_iter_pqueue pq = { 0 };
     ++	const char *last = NULL;
     ++
     ++	int i = 0;
     ++	for (i = 0; i < N; i++) {
     ++		char name[100];
     ++		snprintf(name, sizeof(name), "%02d", i);
     ++		names[i] = xstrdup(name);
     ++	}
     ++
     ++	i = 1;
     ++	do {
     ++		struct reftable_record rec =
     ++			reftable_new_record(BLOCK_TYPE_REF);
     ++		struct pq_entry e = { 0 };
     ++
     ++		reftable_record_as_ref(&rec)->ref_name = names[i];
     ++		e.rec = rec;
     ++		merged_iter_pqueue_add(&pq, e);
     ++		merged_iter_pqueue_check(pq);
     ++		i = (i * 7) % N;
     ++	} while (i != 1);
     ++
     ++	while (!merged_iter_pqueue_is_empty(pq)) {
     ++		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     ++		struct reftable_ref_record *ref =
     ++			reftable_record_as_ref(&e.rec);
     ++
     ++		merged_iter_pqueue_check(pq);
     ++
     ++		if (last != NULL) {
     ++			assert(strcmp(last, ref->ref_name) < 0);
     ++		}
     ++		last = ref->ref_name;
     ++		ref->ref_name = NULL;
     ++		reftable_free(ref);
     ++	}
     ++
     ++	for (i = 0; i < N; i++) {
     ++		reftable_free(names[i]);
     ++	}
     ++
     ++	merged_iter_pqueue_clear(&pq);
     ++}
     ++
     ++static void write_test_table(struct slice *buf,
     ++			     struct reftable_ref_record refs[], int n)
     ++{
     ++	int min = 0xffffffff;
     ++	int max = 0;
     ++	int i = 0;
     ++	int err;
     ++
     ++	struct reftable_write_options opts = {
     ++		.block_size = 256,
     ++	};
     ++	struct reftable_writer *w = NULL;
     ++	for (i = 0; i < n; i++) {
     ++		uint64_t ui = refs[i].update_index;
     ++		if (ui > max) {
     ++			max = ui;
     ++		}
     ++		if (ui < min) {
     ++			min = ui;
     ++		}
     ++	}
     ++
     ++	w = reftable_new_writer(&slice_add_void, buf, &opts);
     ++	reftable_writer_set_limits(w, min, max);
     ++
     ++	for (i = 0; i < n; i++) {
     ++		uint64_t before = refs[i].update_index;
     ++		int n = reftable_writer_add_ref(w, &refs[i]);
     ++		assert(n == 0);
     ++		assert(before == refs[i].update_index);
     ++	}
     ++
     ++	err = reftable_writer_close(w);
     ++	assert_err(err);
     ++
     ++	reftable_writer_free(w);
     ++}
     ++
     ++static struct reftable_merged_table *
     ++merged_table_from_records(struct reftable_ref_record **refs,
     ++			  struct reftable_block_source **source, int *sizes,
     ++			  struct slice *buf, int n)
     ++{
     ++	struct reftable_reader **rd = reftable_calloc(n * sizeof(*rd));
     ++	int i = 0;
     ++	struct reftable_merged_table *mt = NULL;
     ++	int err;
     ++	*source = reftable_calloc(n * sizeof(**source));
     ++	for (i = 0; i < n; i++) {
     ++		write_test_table(&buf[i], refs[i], sizes[i]);
     ++		block_source_from_slice(&(*source)[i], &buf[i]);
     ++
     ++		err = reftable_new_reader(&rd[i], &(*source)[i], "name");
     ++		assert_err(err);
     ++	}
     ++
     ++	err = reftable_new_merged_table(&mt, rd, n, SHA1_ID);
     ++	assert_err(err);
     ++	return mt;
     ++}
     ++
     ++static void test_merged_between(void)
     ++{
     ++	byte hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
     ++
     ++	struct reftable_ref_record r1[] = { {
     ++		.ref_name = "b",
     ++		.update_index = 1,
     ++		.value = hash1,
     ++	} };
     ++	struct reftable_ref_record r2[] = { {
     ++		.ref_name = "a",
     ++		.update_index = 2,
     ++	} };
     ++
     ++	struct reftable_ref_record *refs[] = { r1, r2 };
     ++	int sizes[] = { 1, 1 };
     ++	struct slice bufs[2] = { SLICE_INIT, SLICE_INIT };
     ++	struct reftable_block_source *bs = NULL;
     ++	struct reftable_merged_table *mt =
     ++		merged_table_from_records(refs, &bs, sizes, bufs, 2);
     ++	int i;
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_iterator it = { 0 };
     ++	int err = reftable_merged_table_seek_ref(mt, &it, "a");
     ++	assert_err(err);
     ++
     ++	err = reftable_iterator_next_ref(&it, &ref);
     ++	assert_err(err);
     ++	assert(ref.update_index == 2);
     ++	reftable_ref_record_clear(&ref);
     ++
     ++	reftable_iterator_destroy(&it);
     ++	reftable_merged_table_close(mt);
     ++	reftable_merged_table_free(mt);
     ++	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
     ++		slice_release(&bufs[i]);
     ++	}
     ++	reftable_free(bs);
     ++}
     ++
     ++static void test_merged(void)
     ++{
     ++	byte hash1[SHA1_SIZE] = { 1 };
     ++	byte hash2[SHA1_SIZE] = { 2 };
     ++	struct reftable_ref_record r1[] = { {
     ++						    .ref_name = "a",
     ++						    .update_index = 1,
     ++						    .value = hash1,
     ++					    },
     ++					    {
     ++						    .ref_name = "b",
     ++						    .update_index = 1,
     ++						    .value = hash1,
     ++					    },
     ++					    {
     ++						    .ref_name = "c",
     ++						    .update_index = 1,
     ++						    .value = hash1,
     ++					    } };
     ++	struct reftable_ref_record r2[] = { {
     ++		.ref_name = "a",
     ++		.update_index = 2,
     ++	} };
     ++	struct reftable_ref_record r3[] = {
     ++		{
     ++			.ref_name = "c",
     ++			.update_index = 3,
     ++			.value = hash2,
     ++		},
     ++		{
     ++			.ref_name = "d",
     ++			.update_index = 3,
     ++			.value = hash1,
     ++		},
     ++	};
     ++
     ++	struct reftable_ref_record want[] = {
     ++		r2[0],
     ++		r1[1],
     ++		r3[0],
     ++		r3[1],
     ++	};
     ++
     ++	struct reftable_ref_record *refs[] = { r1, r2, r3 };
     ++	int sizes[3] = { 3, 1, 2 };
     ++	struct slice bufs[3] = { SLICE_INIT, SLICE_INIT, SLICE_INIT };
     ++	struct reftable_block_source *bs = NULL;
     ++
     ++	struct reftable_merged_table *mt =
     ++		merged_table_from_records(refs, &bs, sizes, bufs, 3);
     ++
     ++	struct reftable_iterator it = { 0 };
     ++	int err = reftable_merged_table_seek_ref(mt, &it, "a");
     ++	struct reftable_ref_record *out = NULL;
     ++	int len = 0;
     ++	int cap = 0;
     ++	int i = 0;
     ++
     ++	assert_err(err);
     ++	while (len < 100) { /* cap loops/recursion. */
     ++		struct reftable_ref_record ref = { 0 };
     ++		int err = reftable_iterator_next_ref(&it, &ref);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (len == cap) {
     ++			cap = 2 * cap + 1;
     ++			out = reftable_realloc(
     ++				out, sizeof(struct reftable_ref_record) * cap);
     ++		}
     ++		out[len++] = ref;
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++
     ++	assert(ARRAY_SIZE(want) == len);
     ++	for (i = 0; i < len; i++) {
     ++		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
     ++	}
     ++	for (i = 0; i < len; i++) {
     ++		reftable_ref_record_clear(&out[i]);
     ++	}
     ++	reftable_free(out);
     ++
     ++	for (i = 0; i < 3; i++) {
     ++		slice_release(&bufs[i]);
     ++	}
     ++	reftable_merged_table_close(mt);
     ++	reftable_merged_table_free(mt);
     ++	reftable_free(bs);
     ++}
     ++
     ++/* XXX test refs_for(oid) */
     ++
     ++int merged_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_merged_between", &test_merged_between);
     ++	add_test_case("test_pq", &test_pq);
     ++	add_test_case("test_merged", &test_merged);
     ++	return test_main(argc, argv);
     ++}
     +
       ## reftable/pq.c (new) ##
      @@
      +/*
     @@ reftable/pq.c (new)
      +	reftable_record_key(&a.rec, &ak);
      +	reftable_record_key(&b.rec, &bk);
      +
     -+	cmp = slice_cmp(ak, bk);
     ++	cmp = slice_cmp(&ak, &bk);
      +
      +	slice_release(&ak);
      +	slice_release(&bk);
     @@ reftable/reader.c (new)
      +		if (err < 0)
      +			goto done;
      +
     -+		if (slice_cmp(got_key, want_key) > 0) {
     ++		if (slice_cmp(&got_key, &want_key) > 0) {
      +			table_iter_block_done(&next);
      +			break;
      +		}
     @@ reftable/reader.c (new)
      +		table_iter_copy_from(ti, &next);
      +	}
      +
     -+	err = block_iter_seek(&ti->bi, want_key);
     ++	err = block_iter_seek(&ti->bi, &want_key);
      +	if (err < 0)
      +		goto done;
      +	err = 0;
     @@ reftable/reader.c (new)
      +		if (err != 0)
      +			goto done;
      +
     -+		err = block_iter_seek(&next.bi, want_index.last_key);
     ++		err = block_iter_seek(&next.bi, &want_index.last_key);
      +		if (err < 0)
      +			goto done;
      +
     @@ reftable/record.c (new)
      +#include "constants.h"
      +#include "reftable.h"
      +
     -+int get_var_int(uint64_t *dest, struct slice in)
     ++int get_var_int(uint64_t *dest, struct slice *in)
      +{
      +	int ptr = 0;
      +	uint64_t val;
      +
     -+	if (in.len == 0)
     ++	if (in->len == 0)
      +		return -1;
     -+	val = in.buf[ptr] & 0x7f;
     ++	val = in->buf[ptr] & 0x7f;
      +
     -+	while (in.buf[ptr] & 0x80) {
     ++	while (in->buf[ptr] & 0x80) {
      +		ptr++;
     -+		if (ptr > in.len) {
     ++		if (ptr > in->len) {
      +			return -1;
      +		}
     -+		val = (val + 1) << 7 | (uint64_t)(in.buf[ptr] & 0x7f);
     ++		val = (val + 1) << 7 | (uint64_t)(in->buf[ptr] & 0x7f);
      +	}
      +
      +	*dest = val;
      +	return ptr + 1;
      +}
      +
     -+int put_var_int(struct slice dest, uint64_t val)
     ++int put_var_int(struct slice *dest, uint64_t val)
      +{
      +	byte buf[10] = { 0 };
      +	int i = 9;
     @@ reftable/record.c (new)
      +	}
      +
      +	n = sizeof(buf) - i - 1;
     -+	if (dest.len < n)
     ++	if (dest->len < n)
      +		return -1;
     -+	memcpy(dest.buf, &buf[i + 1], n);
     ++	memcpy(dest->buf, &buf[i + 1], n);
      +	return n;
      +}
      +
     @@ reftable/record.c (new)
      +{
      +	int start_len = in.len;
      +	uint64_t tsize = 0;
     -+	int n = get_var_int(&tsize, in);
     ++	int n = get_var_int(&tsize, &in);
      +	if (n <= 0)
      +		return -1;
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +{
      +	struct slice start = s;
      +	int l = strlen(str);
     -+	int n = put_var_int(s, l);
     ++	int n = put_var_int(&s, l);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&s, n);
     @@ reftable/record.c (new)
      +			struct slice key, byte extra)
      +{
      +	struct slice start = dest;
     -+	int prefix_len = common_prefix_size(prev_key, key);
     ++	int prefix_len = common_prefix_size(&prev_key, &key);
      +	uint64_t suffix_len = key.len - prefix_len;
     -+	int n = put_var_int(dest, (uint64_t)prefix_len);
     ++	int n = put_var_int(&dest, (uint64_t)prefix_len);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&dest, n);
      +
      +	*restart = (prefix_len == 0);
      +
     -+	n = put_var_int(dest, suffix_len << 3 | (uint64_t)extra);
     ++	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&dest, n);
     @@ reftable/record.c (new)
      +	int start_len = in.len;
      +	uint64_t prefix_len = 0;
      +	uint64_t suffix_len = 0;
     -+	int n = get_var_int(&prefix_len, in);
     ++	int n = get_var_int(&prefix_len, &in);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +	if (prefix_len > last_key.len)
      +		return -1;
      +
     -+	n = get_var_int(&suffix_len, in);
     ++	n = get_var_int(&suffix_len, &in);
      +	if (n <= 0)
      +		return -1;
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +	const struct reftable_ref_record *r =
      +		(const struct reftable_ref_record *)rec;
      +	struct slice start = s;
     -+	int n = put_var_int(s, r->update_index);
     ++	int n = put_var_int(&s, r->update_index);
      +	assert(hash_size > 0);
      +	if (n < 0)
      +		return -1;
     @@ reftable/record.c (new)
      +	bool seen_target_value = false;
      +	bool seen_target = false;
      +
     -+	int n = get_var_int(&r->update_index, in);
     ++	int n = get_var_int(&r->update_index, &in);
      +	if (n < 0)
      +		return n;
      +	assert(hash_size > 0);
     @@ reftable/record.c (new)
      +	int n = 0;
      +	uint64_t last = 0;
      +	if (r->offset_len == 0 || r->offset_len >= 8) {
     -+		n = put_var_int(s, r->offset_len);
     ++		n = put_var_int(&s, r->offset_len);
      +		if (n < 0) {
      +			return -1;
      +		}
     @@ reftable/record.c (new)
      +	}
      +	if (r->offset_len == 0)
      +		return start.len - s.len;
     -+	n = put_var_int(s, r->offsets[0]);
     ++	n = put_var_int(&s, r->offsets[0]);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&s, n);
      +
      +	last = r->offsets[0];
      +	for (i = 1; i < r->offset_len; i++) {
     -+		int n = put_var_int(s, r->offsets[i] - last);
     ++		int n = put_var_int(&s, r->offsets[i] - last);
      +		if (n < 0) {
      +			return -1;
      +		}
     @@ reftable/record.c (new)
      +	r->hash_prefix_len = key.len;
      +
      +	if (val_type == 0) {
     -+		n = get_var_int(&count, in);
     ++		n = get_var_int(&count, &in);
      +		if (n < 0) {
      +			return n;
      +		}
     @@ reftable/record.c (new)
      +	r->offsets = reftable_malloc(count * sizeof(uint64_t));
      +	r->offset_len = count;
      +
     -+	n = get_var_int(&r->offsets[0], in);
     ++	n = get_var_int(&r->offsets[0], &in);
      +	if (n < 0)
      +		return n;
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +	j = 1;
      +	while (j < count) {
      +		uint64_t delta = 0;
     -+		int n = get_var_int(&delta, in);
     ++		int n = get_var_int(&delta, &in);
      +		if (n < 0) {
      +			return n;
      +		}
     @@ reftable/record.c (new)
      +		return -1;
      +	slice_consume(&s, n);
      +
     -+	n = put_var_int(s, r->time);
     ++	n = put_var_int(&s, r->time);
      +	if (n < 0)
      +		return -1;
      +	slice_consume(&s, n);
     @@ reftable/record.c (new)
      +	r->email[dest.len] = 0;
      +
      +	ts = 0;
     -+	n = get_var_int(&ts, in);
     ++	n = get_var_int(&ts, &in);
      +	if (n < 0)
      +		goto done;
      +	slice_consume(&in, n);
     @@ reftable/record.c (new)
      +static void reftable_index_record_key(const void *r, struct slice *dest)
      +{
      +	struct reftable_index_record *rec = (struct reftable_index_record *)r;
     -+	slice_copy(dest, rec->last_key);
     ++	slice_copy(dest, &rec->last_key);
      +}
      +
      +static void reftable_index_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	struct reftable_index_record *src =
      +		(struct reftable_index_record *)src_rec;
      +
     -+	slice_copy(&dst->last_key, src->last_key);
     ++	slice_copy(&dst->last_key, &src->last_key);
      +	dst->offset = src->offset;
      +}
      +
     @@ reftable/record.c (new)
      +		(const struct reftable_index_record *)rec;
      +	struct slice start = out;
      +
     -+	int n = put_var_int(out, r->offset);
     ++	int n = put_var_int(&out, r->offset);
      +	if (n < 0)
      +		return n;
      +
     @@ reftable/record.c (new)
      +	struct reftable_index_record *r = (struct reftable_index_record *)rec;
      +	int n = 0;
      +
     -+	slice_copy(&r->last_key, key);
     ++	slice_copy(&r->last_key, &key);
      +
     -+	n = get_var_int(&r->offset, in);
     ++	n = get_var_int(&r->offset, &in);
      +	if (n < 0)
      +		return n;
      +
     @@ reftable/record.h (new)
      +
      +/* utilities for de/encoding varints */
      +
     -+int get_var_int(uint64_t *dest, struct slice in);
     -+int put_var_int(struct slice dest, uint64_t val);
     ++int get_var_int(uint64_t *dest, struct slice *in);
     ++int put_var_int(struct slice *dest, uint64_t val);
      +
      +/* Methods for records. */
      +struct reftable_record_vtable {
     @@ reftable/record.h (new)
      +
      +#endif
      
     - ## reftable/refname.c (new) ##
     + ## reftable/record_test.c (new) ##
      @@
      +/*
     -+  Copyright 2020 Google LLC
     ++Copyright 2020 Google LLC
      +
     -+  Use of this source code is governed by a BSD-style
     -+  license that can be found in the LICENSE file or at
     -+  https://developers.google.com/open-source/licenses/bsd
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     ++#include "record.h"
     ++
      +#include "system.h"
     -+#include "reftable.h"
      +#include "basics.h"
     -+#include "refname.h"
     -+#include "slice.h"
     -+
     -+struct find_arg {
     -+	char **names;
     -+	const char *want;
     -+};
     ++#include "constants.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
      +
     -+static int find_name(size_t k, void *arg)
     ++static void test_copy(struct reftable_record *rec)
      +{
     -+	struct find_arg *f_arg = (struct find_arg *)arg;
     -+	return strcmp(f_arg->names[k], f_arg->want) >= 0;
     ++	struct reftable_record copy =
     ++		reftable_new_record(reftable_record_type(rec));
     ++	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
     ++	/* do it twice to catch memory leaks */
     ++	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
     ++	switch (reftable_record_type(&copy)) {
     ++	case BLOCK_TYPE_REF:
     ++		assert(reftable_ref_record_equal(reftable_record_as_ref(&copy),
     ++						 reftable_record_as_ref(rec),
     ++						 SHA1_SIZE));
     ++		break;
     ++	case BLOCK_TYPE_LOG:
     ++		assert(reftable_log_record_equal(reftable_record_as_log(&copy),
     ++						 reftable_record_as_log(rec),
     ++						 SHA1_SIZE));
     ++		break;
     ++	}
     ++	reftable_record_destroy(&copy);
      +}
      +
     -+int modification_has_ref(struct modification *mod, const char *name)
     ++static void test_varint_roundtrip(void)
      +{
     -+	struct reftable_ref_record ref = { 0 };
     -+	int err = 0;
     ++	uint64_t inputs[] = { 0,
     ++			      1,
     ++			      27,
     ++			      127,
     ++			      128,
     ++			      257,
     ++			      4096,
     ++			      ((uint64_t)1 << 63),
     ++			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
     ++	int i = 0;
     ++	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
     ++		byte dest[10];
      +
     -+	if (mod->add_len > 0) {
     -+		struct find_arg arg = {
     -+			.names = mod->add,
     -+			.want = name,
     -+		};
     -+		int idx = binsearch(mod->add_len, find_name, &arg);
     -+		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
     -+			return 0;
     -+		}
     -+	}
     ++		struct slice out = { .buf = dest, .len = 10, .cap = 10 };
      +
     -+	if (mod->del_len > 0) {
     -+		struct find_arg arg = {
     -+			.names = mod->del,
     -+			.want = name,
     -+		};
     -+		int idx = binsearch(mod->del_len, find_name, &arg);
     -+		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
     -+			return 1;
     -+		}
     ++		uint64_t in = inputs[i];
     ++		int n = put_var_int(&out, in);
     ++		uint64_t got = 0;
     ++
     ++		assert(n > 0);
     ++		out.len = n;
     ++		n = get_var_int(&got, &out);
     ++		assert(n > 0);
     ++
     ++		assert(got == in);
      +	}
     ++}
      +
     -+	err = reftable_table_read_ref(&mod->tab, name, &ref);
     -+	reftable_ref_record_clear(&ref);
     -+	return err;
     ++static void test_common_prefix(void)
     ++{
     ++	struct {
     ++		const char *a, *b;
     ++		int want;
     ++	} cases[] = {
     ++		{ "abc", "ab", 2 },
     ++		{ "", "abc", 0 },
     ++		{ "abc", "abd", 2 },
     ++		{ "abc", "pqr", 0 },
     ++	};
     ++
     ++	int i = 0;
     ++	for (i = 0; i < ARRAY_SIZE(cases); i++) {
     ++		struct slice a = SLICE_INIT;
     ++		struct slice b = SLICE_INIT;
     ++		slice_set_string(&a, cases[i].a);
     ++		slice_set_string(&b, cases[i].b);
     ++
     ++		assert(common_prefix_size(&a, &b) == cases[i].want);
     ++
     ++		slice_release(&a);
     ++		slice_release(&b);
     ++	}
      +}
      +
     -+static void modification_clear(struct modification *mod)
     ++static void set_hash(byte *h, int j)
      +{
     -+	/* don't delete the strings themselves; they're owned by ref records.
     -+	 */
     -+	FREE_AND_NULL(mod->add);
     -+	FREE_AND_NULL(mod->del);
     -+	mod->add_len = 0;
     -+	mod->del_len = 0;
     ++	int i = 0;
     ++	for (i = 0; i < hash_size(SHA1_ID); i++) {
     ++		h[i] = (j >> i) & 0xff;
     ++	}
      +}
      +
     -+int modification_has_ref_with_prefix(struct modification *mod,
     -+				     const char *prefix)
     ++static void test_reftable_ref_record_roundtrip(void)
      +{
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	int err = 0;
     ++	int i = 0;
     ++
     ++	for (i = 0; i <= 3; i++) {
     ++		struct reftable_ref_record in = { 0 };
     ++		struct reftable_ref_record out = {
     ++			.ref_name = xstrdup("old name"),
     ++			.value = reftable_calloc(SHA1_SIZE),
     ++			.target_value = reftable_calloc(SHA1_SIZE),
     ++			.target = xstrdup("old value"),
     ++		};
     ++		struct reftable_record rec_out = { 0 };
     ++		struct slice key = SLICE_INIT;
     ++		struct reftable_record rec = { 0 };
     ++		struct slice dest = SLICE_INIT;
     ++		int n, m;
     ++
     ++		switch (i) {
     ++		case 0:
     ++			break;
     ++		case 1:
     ++			in.value = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.value, 1);
     ++			break;
     ++		case 2:
     ++			in.value = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.value, 1);
     ++			in.target_value = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.target_value, 2);
     ++			break;
     ++		case 3:
     ++			in.target = xstrdup("target");
     ++			break;
     ++		}
     ++		in.ref_name = xstrdup("refs/heads/master");
     ++
     ++		reftable_record_from_ref(&rec, &in);
     ++		test_copy(&rec);
     ++
     ++		assert(reftable_record_val_type(&rec) == i);
     ++
     ++		reftable_record_key(&rec, &key);
     ++		slice_resize(&dest, 1024);
     ++		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		assert(n > 0);
     ++
     ++		/* decode into a non-zero reftable_record to test for leaks. */
     ++
     ++		reftable_record_from_ref(&rec_out, &out);
     ++		m = reftable_record_decode(&rec_out, key, i, dest, SHA1_SIZE);
     ++		assert(n == m);
     ++
     ++		assert((out.value != NULL) == (in.value != NULL));
     ++		assert((out.target_value != NULL) == (in.target_value != NULL));
     ++		assert((out.target != NULL) == (in.target != NULL));
     ++		reftable_record_clear(&rec_out);
     ++
     ++		slice_release(&key);
     ++		slice_release(&dest);
     ++		reftable_ref_record_clear(&in);
     ++	}
     ++}
     ++
     ++static void test_reftable_log_record_equal(void)
     ++{
     ++	struct reftable_log_record in[2] = {
     ++		{
     ++			.ref_name = xstrdup("refs/heads/master"),
     ++			.update_index = 42,
     ++		},
     ++		{
     ++			.ref_name = xstrdup("refs/heads/master"),
     ++			.update_index = 22,
     ++		}
     ++	};
     ++
     ++	assert(!reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	in[1].update_index = in[0].update_index;
     ++	assert(reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	reftable_log_record_clear(&in[0]);
     ++	reftable_log_record_clear(&in[1]);
     ++}
     ++
     ++static void test_reftable_log_record_roundtrip(void)
     ++{
     ++	struct reftable_log_record in[2] = {
     ++		{
     ++			.ref_name = xstrdup("refs/heads/master"),
     ++			.old_hash = reftable_malloc(SHA1_SIZE),
     ++			.new_hash = reftable_malloc(SHA1_SIZE),
     ++			.name = xstrdup("han-wen"),
     ++			.email = xstrdup("hanwen@google.com"),
     ++			.message = xstrdup("test"),
     ++			.update_index = 42,
     ++			.time = 1577123507,
     ++			.tz_offset = 100,
     ++		},
     ++		{
     ++			.ref_name = xstrdup("refs/heads/master"),
     ++			.update_index = 22,
     ++		}
     ++	};
     ++	set_test_hash(in[0].new_hash, 1);
     ++	set_test_hash(in[0].old_hash, 2);
     ++	for (int i = 0; i < ARRAY_SIZE(in); i++) {
     ++		struct reftable_record rec = { 0 };
     ++		struct slice key = SLICE_INIT;
     ++		struct slice dest = SLICE_INIT;
     ++		/* populate out, to check for leaks. */
     ++		struct reftable_log_record out = {
     ++			.ref_name = xstrdup("old name"),
     ++			.new_hash = reftable_calloc(SHA1_SIZE),
     ++			.old_hash = reftable_calloc(SHA1_SIZE),
     ++			.name = xstrdup("old name"),
     ++			.email = xstrdup("old@email"),
     ++			.message = xstrdup("old message"),
     ++		};
     ++		struct reftable_record rec_out = { 0 };
     ++		int n, m, valtype;
     ++
     ++		reftable_record_from_log(&rec, &in[i]);
     ++
     ++		test_copy(&rec);
     ++
     ++		reftable_record_key(&rec, &key);
     ++
     ++		slice_resize(&dest, 1024);
     ++
     ++		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		assert(n >= 0);
     ++		reftable_record_from_log(&rec_out, &out);
     ++		valtype = reftable_record_val_type(&rec);
     ++		m = reftable_record_decode(&rec_out, key, valtype, dest,
     ++					   SHA1_SIZE);
     ++		assert(n == m);
     ++
     ++		assert(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
     ++		reftable_log_record_clear(&in[i]);
     ++		slice_release(&key);
     ++		slice_release(&dest);
     ++		reftable_record_clear(&rec_out);
     ++	}
     ++}
     ++
     ++static void test_u24_roundtrip(void)
     ++{
     ++	uint32_t in = 0x112233;
     ++	byte dest[3];
     ++	uint32_t out;
     ++	put_be24(dest, in);
     ++	out = get_be24(dest);
     ++	assert(in == out);
     ++}
     ++
     ++static void test_key_roundtrip(void)
     ++{
     ++	struct slice dest = SLICE_INIT;
     ++	struct slice last_key = SLICE_INIT;
     ++	struct slice key = SLICE_INIT;
     ++	struct slice roundtrip = SLICE_INIT;
     ++	bool restart;
     ++	byte extra;
     ++	int n, m;
     ++	byte rt_extra;
     ++
     ++	slice_resize(&dest, 1024);
     ++	slice_set_string(&last_key, "refs/heads/master");
     ++	slice_set_string(&key, "refs/tags/bla");
     ++
     ++	extra = 6;
     ++	n = reftable_encode_key(&restart, dest, last_key, key, extra);
     ++	assert(!restart);
     ++	assert(n > 0);
     ++
     ++	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
     ++	assert(n == m);
     ++	assert(slice_equal(&key, &roundtrip));
     ++	assert(rt_extra == extra);
     ++
     ++	slice_release(&last_key);
     ++	slice_release(&key);
     ++	slice_release(&dest);
     ++	slice_release(&roundtrip);
     ++}
     ++
     ++static void test_reftable_obj_record_roundtrip(void)
     ++{
     ++	byte testHash1[SHA1_SIZE] = { 1, 2, 3, 4, 0 };
     ++	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
     ++	struct reftable_obj_record recs[3] = { {
     ++						       .hash_prefix = testHash1,
     ++						       .hash_prefix_len = 5,
     ++						       .offsets = till9,
     ++						       .offset_len = 3,
     ++					       },
     ++					       {
     ++						       .hash_prefix = testHash1,
     ++						       .hash_prefix_len = 5,
     ++						       .offsets = till9,
     ++						       .offset_len = 9,
     ++					       },
     ++					       {
     ++						       .hash_prefix = testHash1,
     ++						       .hash_prefix_len = 5,
     ++					       } };
     ++	int i = 0;
     ++	for (i = 0; i < ARRAY_SIZE(recs); i++) {
     ++		struct reftable_obj_record in = recs[i];
     ++		struct slice dest = SLICE_INIT;
     ++		struct reftable_record rec = { 0 };
     ++		struct slice key = SLICE_INIT;
     ++		struct reftable_obj_record out = { 0 };
     ++		struct reftable_record rec_out = { 0 };
     ++		int n, m;
     ++		byte extra;
     ++
     ++		reftable_record_from_obj(&rec, &in);
     ++		test_copy(&rec);
     ++		reftable_record_key(&rec, &key);
     ++		slice_resize(&dest, 1024);
     ++		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++		assert(n > 0);
     ++		extra = reftable_record_val_type(&rec);
     ++		reftable_record_from_obj(&rec_out, &out);
     ++		m = reftable_record_decode(&rec_out, key, extra, dest,
     ++					   SHA1_SIZE);
     ++		assert(n == m);
     ++
     ++		assert(in.hash_prefix_len == out.hash_prefix_len);
     ++		assert(in.offset_len == out.offset_len);
     ++
     ++		assert(!memcmp(in.hash_prefix, out.hash_prefix,
     ++			       in.hash_prefix_len));
     ++		assert(0 == memcmp(in.offsets, out.offsets,
     ++				   sizeof(uint64_t) * in.offset_len));
     ++		slice_release(&key);
     ++		slice_release(&dest);
     ++		reftable_record_clear(&rec_out);
     ++	}
     ++}
     ++
     ++static void test_reftable_index_record_roundtrip(void)
     ++{
     ++	struct reftable_index_record in = {
     ++		.offset = 42,
     ++		.last_key = SLICE_INIT,
     ++	};
     ++	struct slice dest = SLICE_INIT;
     ++	struct slice key = SLICE_INIT;
     ++	struct reftable_record rec = { 0 };
     ++	struct reftable_index_record out = { .last_key = SLICE_INIT };
     ++	struct reftable_record out_rec = { NULL };
     ++	int n, m;
     ++	byte extra;
     ++
     ++	slice_set_string(&in.last_key, "refs/heads/master");
     ++	reftable_record_from_index(&rec, &in);
     ++	reftable_record_key(&rec, &key);
     ++	test_copy(&rec);
     ++
     ++	assert(0 == slice_cmp(&key, &in.last_key));
     ++	slice_resize(&dest, 1024);
     ++	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     ++	assert(n > 0);
     ++
     ++	extra = reftable_record_val_type(&rec);
     ++	reftable_record_from_index(&out_rec, &out);
     ++	m = reftable_record_decode(&out_rec, key, extra, dest, SHA1_SIZE);
     ++	assert(m == n);
     ++
     ++	assert(in.offset == out.offset);
     ++
     ++	reftable_record_clear(&out_rec);
     ++	slice_release(&key);
     ++	slice_release(&in.last_key);
     ++	slice_release(&dest);
     ++}
     ++
     ++int record_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_reftable_log_record_equal",
     ++		      &test_reftable_log_record_equal);
     ++	add_test_case("test_reftable_log_record_roundtrip",
     ++		      &test_reftable_log_record_roundtrip);
     ++	add_test_case("test_reftable_ref_record_roundtrip",
     ++		      &test_reftable_ref_record_roundtrip);
     ++	add_test_case("test_varint_roundtrip", &test_varint_roundtrip);
     ++	add_test_case("test_key_roundtrip", &test_key_roundtrip);
     ++	add_test_case("test_common_prefix", &test_common_prefix);
     ++	add_test_case("test_reftable_obj_record_roundtrip",
     ++		      &test_reftable_obj_record_roundtrip);
     ++	add_test_case("test_reftable_index_record_roundtrip",
     ++		      &test_reftable_index_record_roundtrip);
     ++	add_test_case("test_u24_roundtrip", &test_u24_roundtrip);
     ++	return test_main(argc, argv);
     ++}
     +
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
     ++	err = reftable_table_read_ref(&mod->tab, name, &ref);
     ++	reftable_ref_record_clear(&ref);
     ++	return err;
     ++}
     ++
     ++static void modification_clear(struct modification *mod)
     ++{
     ++	/* don't delete the strings themselves; they're owned by ref records.
     ++	 */
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
      +
      +	if (mod->add_len > 0) {
      +		struct find_arg arg = {
     @@ reftable/refname.h (new)
      +
      +int modification_validate(struct modification *mod);
      +
     ++#endif
     +
     + ## reftable/refname_test.c (new) ##
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
     ++
     ++#include "basics.h"
     ++#include "block.h"
     ++#include "constants.h"
     ++#include "reader.h"
     ++#include "record.h"
     ++#include "refname.h"
     ++#include "system.h"
     ++
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++struct testcase {
     ++	char *add;
     ++	char *del;
     ++	int error_code;
     ++};
     ++
     ++static void test_conflict(void)
     ++{
     ++	struct reftable_write_options opts = { 0 };
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++	struct reftable_ref_record rec = {
     ++		.ref_name = "a/b",
     ++		.target = "destination", /* make sure it's not a symref. */
     ++		.update_index = 1,
     ++	};
     ++	int err;
     ++	int i;
     ++	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader *rd = NULL;
     ++	struct reftable_table tab = { NULL };
     ++	struct testcase cases[] = {
     ++		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
     ++		{ "b", NULL, 0 },
     ++		{ "a", NULL, REFTABLE_NAME_CONFLICT },
     ++		{ "a", "a/b", 0 },
     ++
     ++		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
     ++		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
     ++		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
     ++		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
     ++
     ++		{ "a/b/c", "a/b", 0 },
     ++		{ NULL, "a//b", 0 },
     ++	};
     ++	reftable_writer_set_limits(w, 1, 1);
     ++
     ++	err = reftable_writer_add_ref(w, &rec);
     ++	assert_err(err);
     ++
     ++	err = reftable_writer_close(w);
     ++	assert_err(err);
     ++	reftable_writer_free(w);
     ++
     ++	block_source_from_slice(&source, &buf);
     ++	err = reftable_new_reader(&rd, &source, "filename");
     ++	assert_err(err);
     ++
     ++	reftable_table_from_reader(&tab, rd);
     ++
     ++	for (i = 0; i < ARRAY_SIZE(cases); i++) {
     ++		struct modification mod = {
     ++			.tab = tab,
     ++		};
     ++
     ++		if (cases[i].add != NULL) {
     ++			mod.add = &cases[i].add;
     ++			mod.add_len = 1;
     ++		}
     ++		if (cases[i].del != NULL) {
     ++			mod.del = &cases[i].del;
     ++			mod.del_len = 1;
     ++		}
     ++
     ++		err = modification_validate(&mod);
     ++		assert(err == cases[i].error_code);
     ++	}
     ++
     ++	reftable_reader_free(rd);
     ++	slice_release(&buf);
     ++}
     ++
     ++int refname_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_conflict", &test_conflict);
     ++	return test_main(argc, argv);
     ++}
     +
     + ## reftable/reftable-tests.h (new) ##
     +@@
     ++#ifndef REFTABLE_TESTS_H
     ++#define REFTABLE_TESTS_H
     ++
     ++int block_test_main(int argc, const char **argv);
     ++int merged_test_main(int argc, const char **argv);
     ++int record_test_main(int argc, const char **argv);
     ++int refname_test_main(int argc, const char **argv);
     ++int reftable_test_main(int argc, const char **argv);
     ++int slice_test_main(int argc, const char **argv);
     ++int stack_test_main(int argc, const char **argv);
     ++int tree_test_main(int argc, const char **argv);
     ++
      +#endif
      
       ## reftable/reftable.c (new) ##
     @@ reftable/reftable.h (new)
      +
      +#endif
      
     - ## reftable/slice.c (new) ##
     + ## reftable/reftable_test.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/slice.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "slice.h"
     ++#include "reftable.h"
      +
      +#include "system.h"
      +
     -+#include "reftable.h"
     ++#include "basics.h"
     ++#include "block.h"
     ++#include "constants.h"
     ++#include "reader.h"
     ++#include "record.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
      +
     -+struct slice reftable_empty_slice = SLICE_INIT;
     ++static const int update_index = 5;
      +
     -+void slice_set_string(struct slice *s, const char *str)
     ++static void test_buffer(void)
      +{
     -+	int l;
     -+	if (str == NULL) {
     -+		s->len = 0;
     -+		return;
     -+	}
     -+	assert(s->canary == SLICE_CANARY);
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_block_source source = { NULL };
     ++	struct reftable_block out = { 0 };
     ++	int n;
     ++	byte in[] = "hello";
     ++	slice_add(&buf, in, sizeof(in));
     ++	block_source_from_slice(&source, &buf);
     ++	assert(block_source_size(&source) == 6);
     ++	n = block_source_read_block(&source, &out, 0, sizeof(in));
     ++	assert(n == sizeof(in));
     ++	assert(!memcmp(in, out.data, n));
     ++	reftable_block_done(&out);
     ++
     ++	n = block_source_read_block(&source, &out, 1, 2);
     ++	assert(n == 2);
     ++	assert(!memcmp(out.data, "el", 2));
     ++
     ++	reftable_block_done(&out);
     ++	block_source_close(&source);
     ++	slice_release(&buf);
     ++}
     ++
     ++static void test_default_write_opts(void)
     ++{
     ++	struct reftable_write_options opts = { 0 };
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++
     ++	struct reftable_ref_record rec = {
     ++		.ref_name = "master",
     ++		.update_index = 1,
     ++	};
     ++	int err;
     ++	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader **readers = malloc(sizeof(*readers) * 1);
     ++	uint32_t hash_id;
     ++	struct reftable_reader *rd = NULL;
     ++	struct reftable_merged_table *merged = NULL;
      +
     -+	l = strlen(str);
     -+	l++; /* \0 */
     -+	slice_resize(s, l);
     -+	memcpy(s->buf, str, l);
     -+	s->len = l - 1;
     -+}
     ++	reftable_writer_set_limits(w, 1, 1);
      +
     -+void slice_init(struct slice *s)
     -+{
     -+	struct slice empty = SLICE_INIT;
     -+	*s = empty;
     -+}
     ++	err = reftable_writer_add_ref(w, &rec);
     ++	assert_err(err);
      +
     -+void slice_resize(struct slice *s, int l)
     -+{
     -+	assert(s->canary == SLICE_CANARY);
     -+	if (s->cap < l) {
     -+		int c = s->cap * 2;
     -+		if (c < l) {
     -+			c = l;
     -+		}
     -+		s->cap = c;
     -+		s->buf = reftable_realloc(s->buf, s->cap);
     -+	}
     -+	s->len = l;
     -+}
     ++	err = reftable_writer_close(w);
     ++	assert_err(err);
     ++	reftable_writer_free(w);
      +
     -+void slice_addstr(struct slice *d, const char *s)
     -+{
     -+	int l1 = d->len;
     -+	int l2 = strlen(s);
     -+	assert(d->canary == SLICE_CANARY);
     ++	block_source_from_slice(&source, &buf);
      +
     -+	slice_resize(d, l2 + l1);
     -+	memcpy(d->buf + l1, s, l2);
     ++	err = reftable_new_reader(&rd, &source, "filename");
     ++	assert_err(err);
     ++
     ++	hash_id = reftable_reader_hash_id(rd);
     ++	assert(hash_id == SHA1_ID);
     ++
     ++	readers[0] = rd;
     ++
     ++	err = reftable_new_merged_table(&merged, readers, 1, SHA1_ID);
     ++	assert_err(err);
     ++
     ++	reftable_merged_table_close(merged);
     ++	reftable_merged_table_free(merged);
     ++	slice_release(&buf);
      +}
      +
     -+void slice_addbuf(struct slice *s, struct slice a)
     ++static void write_table(char ***names, struct slice *buf, int N, int block_size,
     ++			uint32_t hash_id)
      +{
     -+	int end = s->len;
     -+	assert(s->canary == SLICE_CANARY);
     -+	slice_resize(s, s->len + a.len);
     -+	memcpy(s->buf + end, a.buf, a.len);
     -+}
     -+
     -+void slice_consume(struct slice *s, int n)
     -+{
     -+	assert(s->canary == SLICE_CANARY);
     -+	s->buf += n;
     -+	s->len -= n;
     -+}
     ++	struct reftable_write_options opts = {
     ++		.block_size = block_size,
     ++		.hash_id = hash_id,
     ++	};
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, buf, &opts);
     ++	struct reftable_ref_record ref = { 0 };
     ++	int i = 0, n;
     ++	struct reftable_log_record log = { 0 };
     ++	const struct reftable_stats *stats = NULL;
     ++	*names = reftable_calloc(sizeof(char *) * (N + 1));
     ++	reftable_writer_set_limits(w, update_index, update_index);
     ++	for (i = 0; i < N; i++) {
     ++		byte hash[SHA256_SIZE] = { 0 };
     ++		char name[100];
     ++		int n;
      +
     -+byte *slice_detach(struct slice *s)
     -+{
     -+	byte *p = s->buf;
     -+	assert(s->canary == SLICE_CANARY);
     -+	s->buf = NULL;
     -+	s->cap = 0;
     -+	s->len = 0;
     -+	return p;
     -+}
     ++		set_test_hash(hash, i);
      +
     -+void slice_release(struct slice *s)
     -+{
     -+	assert(s->canary == SLICE_CANARY);
     -+	reftable_free(slice_detach(s));
     -+}
     ++		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
     -+void slice_copy(struct slice *dest, struct slice src)
     -+{
     -+	assert(dest->canary == SLICE_CANARY);
     -+	assert(src.canary == SLICE_CANARY);
     -+	slice_resize(dest, src.len);
     -+	memcpy(dest->buf, src.buf, src.len);
     -+}
     ++		ref.ref_name = name;
     ++		ref.value = hash;
     ++		ref.update_index = update_index;
     ++		(*names)[i] = xstrdup(name);
      +
     -+/* return the underlying data as char*. len is left unchanged, but
     -+   a \0 is added at the end. */
     -+const char *slice_as_string(struct slice *s)
     -+{
     -+	assert(s->canary == SLICE_CANARY);
     -+	if (s->cap == s->len) {
     -+		int l = s->len;
     -+		slice_resize(s, l + 1);
     -+		s->len = l;
     ++		n = reftable_writer_add_ref(w, &ref);
     ++		assert(n == 0);
      +	}
     -+	s->buf[s->len] = 0;
     -+	return (const char *)s->buf;
     -+}
      +
     -+/* return a newly malloced string for this slice */
     -+char *slice_to_string(struct slice in)
     -+{
     -+	struct slice s = SLICE_INIT;
     -+	assert(in.canary == SLICE_CANARY);
     -+	slice_resize(&s, in.len + 1);
     -+	s.buf[in.len] = 0;
     -+	memcpy(s.buf, in.buf, in.len);
     -+	return (char *)slice_detach(&s);
     -+}
     ++	for (i = 0; i < N; i++) {
     ++		byte hash[SHA256_SIZE] = { 0 };
     ++		char name[100];
     ++		int n;
      +
     -+bool slice_equal(struct slice a, struct slice b)
     -+{
     -+	assert(a.canary == SLICE_CANARY);
     -+	assert(b.canary == SLICE_CANARY);
     -+	if (a.len != b.len)
     -+		return 0;
     -+	return memcmp(a.buf, b.buf, a.len) == 0;
     -+}
     ++		set_test_hash(hash, i);
      +
     -+int slice_cmp(struct slice a, struct slice b)
     -+{
     -+	int min = a.len < b.len ? a.len : b.len;
     -+	int res = memcmp(a.buf, b.buf, min);
     -+	assert(a.canary == SLICE_CANARY);
     -+	assert(b.canary == SLICE_CANARY);
     -+	if (res != 0)
     -+		return res;
     -+	if (a.len < b.len)
     -+		return -1;
     -+	else if (a.len > b.len)
     -+		return 1;
     -+	else
     -+		return 0;
     -+}
     ++		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
     -+int slice_add(struct slice *b, byte *data, size_t sz)
     -+{
     -+	assert(b->canary == SLICE_CANARY);
     -+	if (b->len + sz > b->cap) {
     -+		int newcap = 2 * b->cap + 1;
     -+		if (newcap < b->len + sz) {
     -+			newcap = (b->len + sz);
     ++		log.ref_name = name;
     ++		log.new_hash = hash;
     ++		log.update_index = update_index;
     ++		log.message = "message";
     ++
     ++		n = reftable_writer_add_log(w, &log);
     ++		assert(n == 0);
     ++	}
     ++
     ++	n = reftable_writer_close(w);
     ++	assert(n == 0);
     ++
     ++	stats = writer_stats(w);
     ++	for (i = 0; i < stats->ref_stats.blocks; i++) {
     ++		int off = i * opts.block_size;
     ++		if (off == 0) {
     ++			off = header_size((hash_id == SHA256_ID) ? 2 : 1);
      +		}
     -+		b->buf = reftable_realloc(b->buf, newcap);
     -+		b->cap = newcap;
     ++		assert(buf->buf[off] == 'r');
      +	}
      +
     -+	memcpy(b->buf + b->len, data, sz);
     -+	b->len += sz;
     -+	return sz;
     ++	assert(stats->log_stats.blocks > 0);
     ++	reftable_writer_free(w);
      +}
      +
     -+int slice_add_void(void *b, byte *data, size_t sz)
     ++static void test_log_buffer_size(void)
      +{
     -+	return slice_add((struct slice *)b, data, sz);
     -+}
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_write_options opts = {
     ++		.block_size = 4096,
     ++	};
     ++	int err;
     ++	struct reftable_log_record log = {
     ++		.ref_name = "refs/heads/master",
     ++		.name = "Han-Wen Nienhuys",
     ++		.email = "hanwen@google.com",
     ++		.tz_offset = 100,
     ++		.time = 0x5e430672,
     ++		.update_index = 0xa,
     ++		.message = "commit: 9\n",
     ++	};
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
      +
     -+static uint64_t slice_size(void *b)
     -+{
     -+	return ((struct slice *)b)->len;
     -+}
     ++	/* This tests buffer extension for log compression. Must use a random
     ++	   hash, to ensure that the compressed part is larger than the original.
     ++	*/
     ++	byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     ++	for (int i = 0; i < SHA1_SIZE; i++) {
     ++		hash1[i] = (byte)(rand() % 256);
     ++		hash2[i] = (byte)(rand() % 256);
     ++	}
     ++	log.old_hash = hash1;
     ++	log.new_hash = hash2;
     ++	reftable_writer_set_limits(w, update_index, update_index);
     ++	err = reftable_writer_add_log(w, &log);
     ++	assert_err(err);
     ++	err = reftable_writer_close(w);
     ++	assert_err(err);
     ++	reftable_writer_free(w);
     ++	slice_release(&buf);
     ++}
     ++
     ++static void test_log_write_read(void)
     ++{
     ++	int N = 2;
     ++	char **names = reftable_calloc(sizeof(char *) * (N + 1));
     ++	int err;
     ++	struct reftable_write_options opts = {
     ++		.block_size = 256,
     ++	};
     ++	struct reftable_ref_record ref = { 0 };
     ++	int i = 0;
     ++	struct reftable_log_record log = { 0 };
     ++	int n;
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_reader rd = { 0 };
     ++	struct reftable_block_source source = { 0 };
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++	const struct reftable_stats *stats = NULL;
     ++	reftable_writer_set_limits(w, 0, N);
     ++	for (i = 0; i < N; i++) {
     ++		char name[256];
     ++		struct reftable_ref_record ref = { 0 };
     ++		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
     ++		names[i] = xstrdup(name);
     ++		puts(name);
     ++		ref.ref_name = name;
     ++		ref.update_index = i;
      +
     -+static void slice_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     -+}
     ++		err = reftable_writer_add_ref(w, &ref);
     ++		assert_err(err);
     ++	}
     ++	for (i = 0; i < N; i++) {
     ++		byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     ++		struct reftable_log_record log = { 0 };
     ++		set_test_hash(hash1, i);
     ++		set_test_hash(hash2, i + 1);
      +
     -+static void slice_close(void *b)
     -+{
     -+}
     ++		log.ref_name = names[i];
     ++		log.update_index = i;
     ++		log.old_hash = hash1;
     ++		log.new_hash = hash2;
      +
     -+static int slice_read_block(void *v, struct reftable_block *dest, uint64_t off,
     -+			    uint32_t size)
     -+{
     -+	struct slice *b = (struct slice *)v;
     -+	assert(off + size <= b->len);
     -+	dest->data = reftable_calloc(size);
     -+	memcpy(dest->data, b->buf + off, size);
     -+	dest->len = size;
     -+	return size;
     -+}
     ++		err = reftable_writer_add_log(w, &log);
     ++		assert_err(err);
     ++	}
      +
     -+struct reftable_block_source_vtable slice_vtable = {
     -+	.size = &slice_size,
     -+	.read_block = &slice_read_block,
     -+	.return_block = &slice_return_block,
     -+	.close = &slice_close,
     -+};
     ++	n = reftable_writer_close(w);
     ++	assert(n == 0);
      +
     -+void block_source_from_slice(struct reftable_block_source *bs,
     -+			     struct slice *buf)
     -+{
     -+	assert(bs->ops == NULL);
     -+	bs->ops = &slice_vtable;
     -+	bs->arg = buf;
     -+}
     ++	stats = writer_stats(w);
     ++	assert(stats->log_stats.blocks > 0);
     ++	reftable_writer_free(w);
     ++	w = NULL;
      +
     -+static void malloc_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     -+}
     ++	block_source_from_slice(&source, &buf);
      +
     -+struct reftable_block_source_vtable malloc_vtable = {
     -+	.return_block = &malloc_return_block,
     -+};
     ++	err = init_reader(&rd, &source, "file.log");
     ++	assert_err(err);
      +
     -+struct reftable_block_source malloc_block_source_instance = {
     -+	.ops = &malloc_vtable,
     -+};
     ++	err = reftable_reader_seek_ref(&rd, &it, names[N - 1]);
     ++	assert_err(err);
      +
     -+struct reftable_block_source malloc_block_source(void)
     -+{
     -+	return malloc_block_source_instance;
     -+}
     ++	err = reftable_iterator_next_ref(&it, &ref);
     ++	assert_err(err);
      +
     -+int common_prefix_size(struct slice a, struct slice b)
     -+{
     -+	int p = 0;
     -+	assert(a.canary == SLICE_CANARY);
     -+	assert(b.canary == SLICE_CANARY);
     -+	while (p < a.len && p < b.len) {
     -+		if (a.buf[p] != b.buf[p]) {
     ++	/* end of iteration. */
     ++	err = reftable_iterator_next_ref(&it, &ref);
     ++	assert(0 < err);
     ++
     ++	reftable_iterator_destroy(&it);
     ++	reftable_ref_record_clear(&ref);
     ++
     ++	err = reftable_reader_seek_log(&rd, &it, "");
     ++	assert_err(err);
     ++
     ++	i = 0;
     ++	while (true) {
     ++		int err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
      +			break;
      +		}
     -+		p++;
     ++
     ++		assert_err(err);
     ++		assert_streq(names[i], log.ref_name);
     ++		assert(i == log.update_index);
     ++		i++;
     ++		reftable_log_record_clear(&log);
      +	}
      +
     -+	return p;
     ++	assert(i == N);
     ++	reftable_iterator_destroy(&it);
     ++
     ++	/* cleanup. */
     ++	slice_release(&buf);
     ++	free_names(names);
     ++	reader_close(&rd);
      +}
     -
     - ## reftable/slice.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
      +
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     ++static void test_table_read_write_sequential(void)
     ++{
     ++	char **names;
     ++	struct slice buf = SLICE_INIT;
     ++	int N = 50;
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader rd = { 0 };
     ++	int err = 0;
     ++	int j = 0;
      +
     -+#ifndef SLICE_H
     -+#define SLICE_H
     ++	write_table(&names, &buf, N, 256, SHA1_ID);
      +
     -+#include "basics.h"
     -+#include "reftable.h"
     ++	block_source_from_slice(&source, &buf);
      +
     -+/*
     -+  provides bounds-checked byte ranges.
     -+  To use, initialize as "slice x = {0};"
     -+ */
     -+struct slice {
     -+	int len;
     -+	int cap;
     -+	byte *buf;
     -+	byte canary;
     -+};
     -+#define SLICE_CANARY 0x42
     -+#define SLICE_INIT                       \
     -+	{                                \
     -+		0, 0, NULL, SLICE_CANARY \
     ++	err = init_reader(&rd, &source, "file.ref");
     ++	assert_err(err);
     ++
     ++	err = reftable_reader_seek_ref(&rd, &it, "");
     ++	assert_err(err);
     ++
     ++	while (true) {
     ++		struct reftable_ref_record ref = { 0 };
     ++		int r = reftable_iterator_next_ref(&it, &ref);
     ++		assert(r >= 0);
     ++		if (r > 0) {
     ++			break;
     ++		}
     ++		assert(0 == strcmp(names[j], ref.ref_name));
     ++		assert(update_index == ref.update_index);
     ++
     ++		j++;
     ++		reftable_ref_record_clear(&ref);
      +	}
     -+extern struct slice reftable_empty_slice;
     ++	assert(j == N);
     ++	reftable_iterator_destroy(&it);
     ++	slice_release(&buf);
     ++	free_names(names);
      +
     -+void slice_set_string(struct slice *dest, const char *src);
     -+void slice_addstr(struct slice *dest, const char *src);
     ++	reader_close(&rd);
     ++}
      +
     -+/* Deallocate and clear slice */
     -+void slice_release(struct slice *slice);
     ++static void test_table_write_small_table(void)
     ++{
     ++	char **names;
     ++	struct slice buf = SLICE_INIT;
     ++	int N = 1;
     ++	write_table(&names, &buf, N, 4096, SHA1_ID);
     ++	assert(buf.len < 200);
     ++	slice_release(&buf);
     ++	free_names(names);
     ++}
      +
     -+/* Return a malloced string for `src` */
     -+char *slice_to_string(struct slice src);
     ++static void test_table_read_api(void)
     ++{
     ++	char **names;
     ++	struct slice buf = SLICE_INIT;
     ++	int N = 50;
     ++	struct reftable_reader rd = { 0 };
     ++	struct reftable_block_source source = { 0 };
     ++	int err;
     ++	int i;
     ++	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { 0 };
      +
     -+/* Initializes a slice. Accepts a slice with random garbage. */
     -+void slice_init(struct slice *slice);
     ++	write_table(&names, &buf, N, 256, SHA1_ID);
      +
     -+/* Ensure that `buf` is \0 terminated. */
     -+const char *slice_as_string(struct slice *src);
     ++	block_source_from_slice(&source, &buf);
      +
     -+/* Compare slices */
     -+bool slice_equal(struct slice a, struct slice b);
     ++	err = init_reader(&rd, &source, "file.ref");
     ++	assert_err(err);
      +
     -+/* Return `buf`, clearing out `s` */
     -+byte *slice_detach(struct slice *s);
     ++	err = reftable_reader_seek_ref(&rd, &it, names[0]);
     ++	assert_err(err);
      +
     -+/* Copy bytes */
     -+void slice_copy(struct slice *dest, struct slice src);
     ++	err = reftable_iterator_next_log(&it, &log);
     ++	assert(err == REFTABLE_API_ERROR);
      +
     -+/* Advance `buf` by `n`, and decrease length. A copy of the slice
     -+   should be kept for deallocating the slice. */
     -+void slice_consume(struct slice *s, int n);
     ++	slice_release(&buf);
     ++	for (i = 0; i < N; i++) {
     ++		reftable_free(names[i]);
     ++	}
     ++	reftable_iterator_destroy(&it);
     ++	reftable_free(names);
     ++	reader_close(&rd);
     ++	slice_release(&buf);
     ++}
      +
     -+/* Set length of the slice to `l` */
     -+void slice_resize(struct slice *s, int l);
     ++static void test_table_read_write_seek(bool index, int hash_id)
     ++{
     ++	char **names;
     ++	struct slice buf = SLICE_INIT;
     ++	int N = 50;
     ++	struct reftable_reader rd = { 0 };
     ++	struct reftable_block_source source = { 0 };
     ++	int err;
     ++	int i = 0;
      +
     -+/* Signed comparison */
     -+int slice_cmp(struct slice a, struct slice b);
     ++	struct reftable_iterator it = { 0 };
     ++	struct slice pastLast = SLICE_INIT;
     ++	struct reftable_ref_record ref = { 0 };
      +
     -+/* Append `data` to the `dest` slice.  */
     -+int slice_add(struct slice *dest, byte *data, size_t sz);
     ++	write_table(&names, &buf, N, 256, hash_id);
      +
     -+/* Append `add` to `dest. */
     -+void slice_addbuf(struct slice *dest, struct slice add);
     ++	block_source_from_slice(&source, &buf);
      +
     -+/* Like slice_add, but suitable for passing to reftable_new_writer
     -+ */
     -+int slice_add_void(void *b, byte *data, size_t sz);
     ++	err = init_reader(&rd, &source, "file.ref");
     ++	assert_err(err);
     ++	assert(hash_id == reftable_reader_hash_id(&rd));
      +
     -+/* Find the longest shared prefix size of `a` and `b` */
     -+int common_prefix_size(struct slice a, struct slice b);
     ++	if (!index) {
     ++		rd.ref_offsets.index_offset = 0;
     ++	} else {
     ++		assert(rd.ref_offsets.index_offset > 0);
     ++	}
      +
     -+struct reftable_block_source;
     ++	for (i = 1; i < N; i++) {
     ++		int err = reftable_reader_seek_ref(&rd, &it, names[i]);
     ++		assert_err(err);
     ++		err = reftable_iterator_next_ref(&it, &ref);
     ++		assert_err(err);
     ++		assert(0 == strcmp(names[i], ref.ref_name));
     ++		assert(i == ref.value[0]);
      +
     -+/* Create an in-memory block source for reading reftables */
     -+void block_source_from_slice(struct reftable_block_source *bs,
     -+			     struct slice *buf);
     ++		reftable_ref_record_clear(&ref);
     ++		reftable_iterator_destroy(&it);
     ++	}
      +
     -+struct reftable_block_source malloc_block_source(void);
     ++	slice_set_string(&pastLast, names[N - 1]);
     ++	slice_addstr(&pastLast, "/");
      +
     -+#endif
     -
     - ## reftable/stack.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     ++	err = reftable_reader_seek_ref(&rd, &it, slice_as_string(&pastLast));
     ++	if (err == 0) {
     ++		struct reftable_ref_record ref = { 0 };
     ++		int err = reftable_iterator_next_ref(&it, &ref);
     ++		assert(err > 0);
     ++	} else {
     ++		assert(err > 0);
     ++	}
      +
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     ++	slice_release(&pastLast);
     ++	reftable_iterator_destroy(&it);
      +
     -+#include "stack.h"
     ++	slice_release(&buf);
     ++	for (i = 0; i < N; i++) {
     ++		reftable_free(names[i]);
     ++	}
     ++	reftable_free(names);
     ++	reader_close(&rd);
     ++}
      +
     -+#include "system.h"
     -+#include "merged.h"
     -+#include "reader.h"
     -+#include "refname.h"
     -+#include "reftable.h"
     -+#include "writer.h"
     ++static void test_table_read_write_seek_linear(void)
     ++{
     ++	test_table_read_write_seek(false, SHA1_ID);
     ++}
      +
     -+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     -+		       struct reftable_write_options config)
     ++static void test_table_read_write_seek_linear_sha256(void)
      +{
     -+	struct reftable_stack *p =
     -+		reftable_calloc(sizeof(struct reftable_stack));
     -+	struct slice list_file_name = SLICE_INIT;
     -+	int err = 0;
     ++	test_table_read_write_seek(false, SHA256_ID);
     ++}
      +
     -+	if (config.hash_id == 0) {
     -+		config.hash_id = SHA1_ID;
     -+	}
     ++static void test_table_read_write_seek_index(void)
     ++{
     ++	test_table_read_write_seek(true, SHA1_ID);
     ++}
      +
     -+	*dest = NULL;
     ++static void test_table_refs_for(bool indexed)
     ++{
     ++	int N = 50;
     ++	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
     ++	int want_names_len = 0;
     ++	byte want_hash[SHA1_SIZE];
      +
     -+	slice_set_string(&list_file_name, dir);
     -+	slice_addstr(&list_file_name, "/tables.list");
     ++	struct reftable_write_options opts = {
     ++		.block_size = 256,
     ++	};
     ++	struct reftable_ref_record ref = { 0 };
     ++	int i = 0;
     ++	int n;
     ++	int err;
     ++	struct reftable_reader rd;
     ++	struct reftable_block_source source = { 0 };
      +
     -+	p->list_file = slice_to_string(list_file_name);
     -+	slice_release(&list_file_name);
     -+	p->reftable_dir = xstrdup(dir);
     -+	p->config = config;
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
      +
     -+	err = reftable_stack_reload_maybe_reuse(p, true);
     -+	if (err < 0) {
     -+		reftable_stack_destroy(p);
     -+	} else {
     -+		*dest = p;
     -+	}
     -+	return err;
     -+}
     ++	struct reftable_iterator it = { 0 };
     ++	int j;
      +
     -+static int fd_read_lines(int fd, char ***namesp)
     -+{
     -+	off_t size = lseek(fd, 0, SEEK_END);
     -+	char *buf = NULL;
     -+	int err = 0;
     -+	if (size < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     -+	err = lseek(fd, 0, SEEK_SET);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     ++	set_test_hash(want_hash, 4);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		byte hash[SHA1_SIZE];
     ++		char fill[51] = { 0 };
     ++		char name[100];
     ++		byte hash1[SHA1_SIZE];
     ++		byte hash2[SHA1_SIZE];
     ++		struct reftable_ref_record ref = { 0 };
     ++
     ++		memset(hash, i, sizeof(hash));
     ++		memset(fill, 'x', 50);
     ++		/* Put the variable part in the start */
     ++		snprintf(name, sizeof(name), "br%02d%s", i, fill);
     ++		name[40] = 0;
     ++		ref.ref_name = name;
     ++
     ++		set_test_hash(hash1, i / 4);
     ++		set_test_hash(hash2, 3 + i / 4);
     ++		ref.value = hash1;
     ++		ref.target_value = hash2;
     ++
     ++		/* 80 bytes / entry, so 3 entries per block. Yields 17
     ++		 */
     ++		/* blocks. */
     ++		n = reftable_writer_add_ref(w, &ref);
     ++		assert(n == 0);
     ++
     ++		if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
     ++		    !memcmp(hash2, want_hash, SHA1_SIZE)) {
     ++			want_names[want_names_len++] = xstrdup(name);
     ++		}
      +	}
      +
     -+	buf = reftable_malloc(size + 1);
     -+	if (read(fd, buf, size) != size) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     ++	n = reftable_writer_close(w);
     ++	assert(n == 0);
     ++
     ++	reftable_writer_free(w);
     ++	w = NULL;
     ++
     ++	block_source_from_slice(&source, &buf);
     ++
     ++	err = init_reader(&rd, &source, "file.ref");
     ++	assert_err(err);
     ++	if (!indexed) {
     ++		rd.obj_offsets.present = 0;
      +	}
     -+	buf[size] = 0;
      +
     -+	parse_names(buf, size, namesp);
     ++	err = reftable_reader_seek_ref(&rd, &it, "");
     ++	assert_err(err);
     ++	reftable_iterator_destroy(&it);
      +
     -+done:
     -+	reftable_free(buf);
     -+	return err;
     -+}
     ++	err = reftable_reader_refs_for(&rd, &it, want_hash);
     ++	assert_err(err);
      +
     -+int read_lines(const char *filename, char ***namesp)
     -+{
     -+	int fd = open(filename, O_RDONLY, 0644);
     -+	int err = 0;
     -+	if (fd < 0) {
     -+		if (errno == ENOENT) {
     -+			*namesp = reftable_calloc(sizeof(char *));
     -+			return 0;
     ++	j = 0;
     ++	while (true) {
     ++		int err = reftable_iterator_next_ref(&it, &ref);
     ++		assert(err >= 0);
     ++		if (err > 0) {
     ++			break;
      +		}
      +
     -+		return REFTABLE_IO_ERROR;
     ++		assert(j < want_names_len);
     ++		assert(0 == strcmp(ref.ref_name, want_names[j]));
     ++		j++;
     ++		reftable_ref_record_clear(&ref);
      +	}
     -+	err = fd_read_lines(fd, namesp);
     -+	close(fd);
     -+	return err;
     -+}
     ++	assert(j == want_names_len);
      +
     -+struct reftable_merged_table *
     -+reftable_stack_merged_table(struct reftable_stack *st)
     -+{
     -+	return st->merged;
     ++	slice_release(&buf);
     ++	free_names(want_names);
     ++	reftable_iterator_destroy(&it);
     ++	reader_close(&rd);
      +}
      +
     -+/* Close and free the stack */
     -+void reftable_stack_destroy(struct reftable_stack *st)
     ++static void test_table_refs_for_no_index(void)
      +{
     -+	if (st->merged != NULL) {
     -+		reftable_merged_table_close(st->merged);
     -+		reftable_merged_table_free(st->merged);
     -+		st->merged = NULL;
     -+	}
     -+	FREE_AND_NULL(st->list_file);
     -+	FREE_AND_NULL(st->reftable_dir);
     -+	reftable_free(st);
     ++	test_table_refs_for(false);
      +}
      +
     -+static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     -+						   int cur_len)
     ++static void test_table_refs_for_obj_index(void)
      +{
     -+	struct reftable_reader **cur =
     -+		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
     -+	int i = 0;
     -+	for (i = 0; i < cur_len; i++) {
     -+		cur[i] = st->merged->stack[i];
     -+	}
     -+	return cur;
     ++	test_table_refs_for(true);
      +}
      +
     -+static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
     -+				      bool reuse_open)
     ++static void test_table_empty(void)
      +{
     -+	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     -+	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
     -+	int err = 0;
     -+	int names_len = names_length(names);
     -+	struct reftable_reader **new_tables =
     -+		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
     -+	int new_tables_len = 0;
     -+	struct reftable_merged_table *new_merged = NULL;
     -+	int i;
     -+	struct slice table_path = SLICE_INIT;
     ++	struct reftable_write_options opts = { 0 };
     ++	struct slice buf = SLICE_INIT;
     ++	struct reftable_writer *w =
     ++		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++	struct reftable_block_source source = { 0 };
     ++	struct reftable_reader *rd = NULL;
     ++	struct reftable_ref_record rec = { 0 };
     ++	struct reftable_iterator it = { 0 };
     ++	int err;
      +
     -+	while (*names) {
     -+		struct reftable_reader *rd = NULL;
     -+		char *name = *names++;
     ++	reftable_writer_set_limits(w, 1, 1);
      +
     -+		/* this is linear; we assume compaction keeps the number of
     -+		   tables under control so this is not quadratic. */
     -+		int j = 0;
     -+		for (j = 0; reuse_open && j < cur_len; j++) {
     -+			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
     -+				rd = cur[j];
     -+				cur[j] = NULL;
     -+				break;
     -+			}
     -+		}
     ++	err = reftable_writer_close(w);
     ++	assert(err == REFTABLE_EMPTY_TABLE_ERROR);
     ++	reftable_writer_free(w);
      +
     -+		if (rd == NULL) {
     -+			struct reftable_block_source src = { 0 };
     -+			slice_set_string(&table_path, st->reftable_dir);
     -+			slice_addstr(&table_path, "/");
     -+			slice_addstr(&table_path, name);
     ++	assert(buf.len == header_size(1) + footer_size(1));
      +
     -+			err = reftable_block_source_from_file(
     -+				&src, slice_as_string(&table_path));
     -+			if (err < 0)
     -+				goto done;
     ++	block_source_from_slice(&source, &buf);
      +
     -+			err = reftable_new_reader(&rd, &src, name);
     -+			if (err < 0)
     -+				goto done;
     -+		}
     ++	err = reftable_new_reader(&rd, &source, "filename");
     ++	assert_err(err);
      +
     -+		new_tables[new_tables_len++] = rd;
     -+	}
     ++	err = reftable_reader_seek_ref(rd, &it, "");
     ++	assert_err(err);
      +
     -+	/* success! */
     -+	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
     -+					st->config.hash_id);
     -+	if (err < 0)
     -+		goto done;
     ++	err = reftable_iterator_next_ref(&it, &rec);
     ++	assert(err > 0);
      +
     -+	new_tables = NULL;
     -+	new_tables_len = 0;
     -+	if (st->merged != NULL) {
     -+		merged_table_clear(st->merged);
     -+		reftable_merged_table_free(st->merged);
     -+	}
     -+	new_merged->suppress_deletions = true;
     -+	st->merged = new_merged;
     ++	reftable_iterator_destroy(&it);
     ++	reftable_reader_free(rd);
     ++	slice_release(&buf);
     ++}
     ++
     ++int reftable_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_default_write_opts", test_default_write_opts);
     ++	add_test_case("test_log_write_read", test_log_write_read);
     ++	add_test_case("test_table_read_write_seek_linear_sha256",
     ++		      &test_table_read_write_seek_linear_sha256);
     ++	add_test_case("test_log_buffer_size", test_log_buffer_size);
     ++	add_test_case("test_table_write_small_table",
     ++		      &test_table_write_small_table);
     ++	add_test_case("test_buffer", &test_buffer);
     ++	add_test_case("test_table_read_api", &test_table_read_api);
     ++	add_test_case("test_table_read_write_sequential",
     ++		      &test_table_read_write_sequential);
     ++	add_test_case("test_table_read_write_seek_linear",
     ++		      &test_table_read_write_seek_linear);
     ++	add_test_case("test_table_read_write_seek_index",
     ++		      &test_table_read_write_seek_index);
     ++	add_test_case("test_table_read_write_refs_for_no_index",
     ++		      &test_table_refs_for_no_index);
     ++	add_test_case("test_table_read_write_refs_for_obj_index",
     ++		      &test_table_refs_for_obj_index);
     ++	add_test_case("test_table_empty", &test_table_empty);
     ++	return test_main(argc, argv);
     ++}
     +
     + ## reftable/slice.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+	for (i = 0; i < cur_len; i++) {
     -+		if (cur[i] != NULL) {
     -+			reader_close(cur[i]);
     -+			reftable_reader_free(cur[i]);
     -+		}
     -+	}
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+done:
     -+	slice_release(&table_path);
     -+	for (i = 0; i < new_tables_len; i++) {
     -+		reader_close(new_tables[i]);
     -+		reftable_reader_free(new_tables[i]);
     -+	}
     -+	reftable_free(new_tables);
     -+	reftable_free(cur);
     -+	return err;
     -+}
     ++#include "slice.h"
      +
     -+/* return negative if a before b. */
     -+static int tv_cmp(struct timeval *a, struct timeval *b)
     ++#include "system.h"
     ++
     ++#include "reftable.h"
     ++
     ++struct slice reftable_empty_slice = SLICE_INIT;
     ++
     ++void slice_set_string(struct slice *s, const char *str)
      +{
     -+	time_t diff = a->tv_sec - b->tv_sec;
     -+	int udiff = a->tv_usec - b->tv_usec;
     ++	int l;
     ++	if (str == NULL) {
     ++		s->len = 0;
     ++		return;
     ++	}
     ++	assert(s->canary == SLICE_CANARY);
      +
     -+	if (diff != 0)
     -+		return diff;
     ++	l = strlen(str);
     ++	l++; /* \0 */
     ++	slice_resize(s, l);
     ++	memcpy(s->buf, str, l);
     ++	s->len = l - 1;
     ++}
      +
     -+	return udiff;
     ++void slice_init(struct slice *s)
     ++{
     ++	struct slice empty = SLICE_INIT;
     ++	*s = empty;
      +}
      +
     -+int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     -+				      bool reuse_open)
     ++void slice_resize(struct slice *s, int l)
      +{
     -+	struct timeval deadline = { 0 };
     ++	assert(s->canary == SLICE_CANARY);
     ++	if (s->cap < l) {
     ++		int c = s->cap * 2;
     ++		if (c < l) {
     ++			c = l;
     ++		}
     ++		s->cap = c;
     ++		s->buf = reftable_realloc(s->buf, s->cap);
     ++	}
     ++	s->len = l;
     ++}
     ++
     ++void slice_addstr(struct slice *d, const char *s)
     ++{
     ++	int l1 = d->len;
     ++	int l2 = strlen(s);
     ++	assert(d->canary == SLICE_CANARY);
     ++
     ++	slice_resize(d, l2 + l1);
     ++	memcpy(d->buf + l1, s, l2);
     ++}
     ++
     ++void slice_addbuf(struct slice *s, struct slice *a)
     ++{
     ++	int end = s->len;
     ++	assert(s->canary == SLICE_CANARY);
     ++	slice_resize(s, s->len + a->len);
     ++	memcpy(s->buf + end, a->buf, a->len);
     ++}
     ++
     ++void slice_consume(struct slice *s, int n)
     ++{
     ++	assert(s->canary == SLICE_CANARY);
     ++	s->buf += n;
     ++	s->len -= n;
     ++}
     ++
     ++byte *slice_detach(struct slice *s)
     ++{
     ++	byte *p = s->buf;
     ++	assert(s->canary == SLICE_CANARY);
     ++	s->buf = NULL;
     ++	s->cap = 0;
     ++	s->len = 0;
     ++	return p;
     ++}
     ++
     ++void slice_release(struct slice *s)
     ++{
     ++	assert(s->canary == SLICE_CANARY);
     ++	reftable_free(slice_detach(s));
     ++}
     ++
     ++void slice_copy(struct slice *dest, struct slice *src)
     ++{
     ++	assert(dest->canary == SLICE_CANARY);
     ++	assert(src->canary == SLICE_CANARY);
     ++	slice_resize(dest, src->len);
     ++	memcpy(dest->buf, src->buf, src->len);
     ++}
     ++
     ++/* return the underlying data as char*. len is left unchanged, but
     ++   a \0 is added at the end. */
     ++const char *slice_as_string(struct slice *s)
     ++{
     ++	assert(s->canary == SLICE_CANARY);
     ++	if (s->cap == s->len) {
     ++		int l = s->len;
     ++		slice_resize(s, l + 1);
     ++		s->len = l;
     ++	}
     ++	s->buf[s->len] = 0;
     ++	return (const char *)s->buf;
     ++}
     ++
     ++/* return a newly malloced string for this slice */
     ++char *slice_to_string(struct slice *in)
     ++{
     ++	struct slice s = SLICE_INIT;
     ++	assert(in->canary == SLICE_CANARY);
     ++	slice_resize(&s, in->len + 1);
     ++	s.buf[in->len] = 0;
     ++	memcpy(s.buf, in->buf, in->len);
     ++	return (char *)slice_detach(&s);
     ++}
     ++
     ++bool slice_equal(struct slice *a, struct slice *b)
     ++{
     ++	return slice_cmp(a, b) == 0;
     ++}
     ++
     ++int slice_cmp(const struct slice *a, const struct slice *b)
     ++{
     ++	int min = a->len < b->len ? a->len : b->len;
     ++	int res = memcmp(a->buf, b->buf, min);
     ++	assert(a->canary == SLICE_CANARY);
     ++	assert(b->canary == SLICE_CANARY);
     ++	if (res != 0)
     ++		return res;
     ++	if (a->len < b->len)
     ++		return -1;
     ++	else if (a->len > b->len)
     ++		return 1;
     ++	else
     ++		return 0;
     ++}
     ++
     ++int slice_add(struct slice *b, byte *data, size_t sz)
     ++{
     ++	assert(b->canary == SLICE_CANARY);
     ++	if (b->len + sz > b->cap) {
     ++		int newcap = 2 * b->cap + 1;
     ++		if (newcap < b->len + sz) {
     ++			newcap = (b->len + sz);
     ++		}
     ++		b->buf = reftable_realloc(b->buf, newcap);
     ++		b->cap = newcap;
     ++	}
     ++
     ++	memcpy(b->buf + b->len, data, sz);
     ++	b->len += sz;
     ++	return sz;
     ++}
     ++
     ++int slice_add_void(void *b, byte *data, size_t sz)
     ++{
     ++	return slice_add((struct slice *)b, data, sz);
     ++}
     ++
     ++static uint64_t slice_size(void *b)
     ++{
     ++	return ((struct slice *)b)->len;
     ++}
     ++
     ++static void slice_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++static void slice_close(void *b)
     ++{
     ++}
     ++
     ++static int slice_read_block(void *v, struct reftable_block *dest, uint64_t off,
     ++			    uint32_t size)
     ++{
     ++	struct slice *b = (struct slice *)v;
     ++	assert(off + size <= b->len);
     ++	dest->data = reftable_calloc(size);
     ++	memcpy(dest->data, b->buf + off, size);
     ++	dest->len = size;
     ++	return size;
     ++}
     ++
     ++struct reftable_block_source_vtable slice_vtable = {
     ++	.size = &slice_size,
     ++	.read_block = &slice_read_block,
     ++	.return_block = &slice_return_block,
     ++	.close = &slice_close,
     ++};
     ++
     ++void block_source_from_slice(struct reftable_block_source *bs,
     ++			     struct slice *buf)
     ++{
     ++	assert(bs->ops == NULL);
     ++	bs->ops = &slice_vtable;
     ++	bs->arg = buf;
     ++}
     ++
     ++static void malloc_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++struct reftable_block_source_vtable malloc_vtable = {
     ++	.return_block = &malloc_return_block,
     ++};
     ++
     ++struct reftable_block_source malloc_block_source_instance = {
     ++	.ops = &malloc_vtable,
     ++};
     ++
     ++struct reftable_block_source malloc_block_source(void)
     ++{
     ++	return malloc_block_source_instance;
     ++}
     ++
     ++int common_prefix_size(struct slice *a, struct slice *b)
     ++{
     ++	int p = 0;
     ++	assert(a->canary == SLICE_CANARY);
     ++	assert(b->canary == SLICE_CANARY);
     ++	while (p < a->len && p < b->len) {
     ++		if (a->buf[p] != b->buf[p]) {
     ++			break;
     ++		}
     ++		p++;
     ++	}
     ++
     ++	return p;
     ++}
     +
     + ## reftable/slice.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef SLICE_H
     ++#define SLICE_H
     ++
     ++#include "basics.h"
     ++#include "reftable.h"
     ++
     ++/*
     ++  provides bounds-checked byte ranges.
     ++  To use, initialize as "slice x = {0};"
     ++ */
     ++struct slice {
     ++	int len;
     ++	int cap;
     ++	byte *buf;
     ++	byte canary;
     ++};
     ++#define SLICE_CANARY 0x42
     ++#define SLICE_INIT                       \
     ++	{                                \
     ++		0, 0, NULL, SLICE_CANARY \
     ++	}
     ++extern struct slice reftable_empty_slice;
     ++
     ++void slice_set_string(struct slice *dest, const char *src);
     ++void slice_addstr(struct slice *dest, const char *src);
     ++
     ++/* Deallocate and clear slice */
     ++void slice_release(struct slice *slice);
     ++
     ++/* Return a malloced string for `src` */
     ++char *slice_to_string(struct slice *src);
     ++
     ++/* Initializes a slice. Accepts a slice with random garbage. */
     ++void slice_init(struct slice *slice);
     ++
     ++/* Ensure that `buf` is \0 terminated. */
     ++const char *slice_as_string(struct slice *src);
     ++
     ++/* Compare slices */
     ++bool slice_equal(struct slice *a, struct slice *b);
     ++
     ++/* Return `buf`, clearing out `s` */
     ++byte *slice_detach(struct slice *s);
     ++
     ++/* Copy bytes */
     ++void slice_copy(struct slice *dest, struct slice *src);
     ++
     ++/* Advance `buf` by `n`, and decrease length. A copy of the slice
     ++   should be kept for deallocating the slice. */
     ++void slice_consume(struct slice *s, int n);
     ++
     ++/* Set length of the slice to `l` */
     ++void slice_resize(struct slice *s, int l);
     ++
     ++/* Signed comparison */
     ++int slice_cmp(const struct slice *a, const struct slice *b);
     ++
     ++/* Append `data` to the `dest` slice.  */
     ++int slice_add(struct slice *dest, byte *data, size_t sz);
     ++
     ++/* Append `add` to `dest. */
     ++void slice_addbuf(struct slice *dest, struct slice *add);
     ++
     ++/* Like slice_add, but suitable for passing to reftable_new_writer
     ++ */
     ++int slice_add_void(void *b, byte *data, size_t sz);
     ++
     ++/* Find the longest shared prefix size of `a` and `b` */
     ++int common_prefix_size(struct slice *a, struct slice *b);
     ++
     ++struct reftable_block_source;
     ++
     ++/* Create an in-memory block source for reading reftables */
     ++void block_source_from_slice(struct reftable_block_source *bs,
     ++			     struct slice *buf);
     ++
     ++struct reftable_block_source malloc_block_source(void);
     ++
     ++#endif
     +
     + ## reftable/slice_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "slice.h"
     ++
     ++#include "system.h"
     ++
     ++#include "basics.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++static void test_slice(void)
     ++{
     ++	struct slice s = SLICE_INIT;
     ++	struct slice t = SLICE_INIT;
     ++
     ++	slice_set_string(&s, "abc");
     ++	assert(0 == strcmp("abc", slice_as_string(&s)));
     ++
     ++	slice_set_string(&t, "pqr");
     ++
     ++	slice_addbuf(&s, &t);
     ++	assert(0 == strcmp("abcpqr", slice_as_string(&s)));
     ++
     ++	slice_release(&s);
     ++	slice_release(&t);
     ++}
     ++
     ++int slice_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_slice", &test_slice);
     ++	return test_main(argc, argv);
     ++}
     +
     + ## reftable/stack.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "stack.h"
     ++
     ++#include "system.h"
     ++#include "merged.h"
     ++#include "reader.h"
     ++#include "refname.h"
     ++#include "reftable.h"
     ++#include "writer.h"
     ++
     ++int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     ++		       struct reftable_write_options config)
     ++{
     ++	struct reftable_stack *p =
     ++		reftable_calloc(sizeof(struct reftable_stack));
     ++	struct slice list_file_name = SLICE_INIT;
     ++	int err = 0;
     ++
     ++	if (config.hash_id == 0) {
     ++		config.hash_id = SHA1_ID;
     ++	}
     ++
     ++	*dest = NULL;
     ++
     ++	slice_set_string(&list_file_name, dir);
     ++	slice_addstr(&list_file_name, "/tables.list");
     ++
     ++	p->list_file = slice_to_string(&list_file_name);
     ++	slice_release(&list_file_name);
     ++	p->reftable_dir = xstrdup(dir);
     ++	p->config = config;
     ++
     ++	err = reftable_stack_reload_maybe_reuse(p, true);
     ++	if (err < 0) {
     ++		reftable_stack_destroy(p);
     ++	} else {
     ++		*dest = p;
     ++	}
     ++	return err;
     ++}
     ++
     ++static int fd_read_lines(int fd, char ***namesp)
     ++{
     ++	off_t size = lseek(fd, 0, SEEK_END);
     ++	char *buf = NULL;
     ++	int err = 0;
     ++	if (size < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++	err = lseek(fd, 0, SEEK_SET);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	buf = reftable_malloc(size + 1);
     ++	if (read(fd, buf, size) != size) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++	buf[size] = 0;
     ++
     ++	parse_names(buf, size, namesp);
     ++
     ++done:
     ++	reftable_free(buf);
     ++	return err;
     ++}
     ++
     ++int read_lines(const char *filename, char ***namesp)
     ++{
     ++	int fd = open(filename, O_RDONLY, 0644);
     ++	int err = 0;
     ++	if (fd < 0) {
     ++		if (errno == ENOENT) {
     ++			*namesp = reftable_calloc(sizeof(char *));
     ++			return 0;
     ++		}
     ++
     ++		return REFTABLE_IO_ERROR;
     ++	}
     ++	err = fd_read_lines(fd, namesp);
     ++	close(fd);
     ++	return err;
     ++}
     ++
     ++struct reftable_merged_table *
     ++reftable_stack_merged_table(struct reftable_stack *st)
     ++{
     ++	return st->merged;
     ++}
     ++
     ++/* Close and free the stack */
     ++void reftable_stack_destroy(struct reftable_stack *st)
     ++{
     ++	if (st->merged != NULL) {
     ++		reftable_merged_table_close(st->merged);
     ++		reftable_merged_table_free(st->merged);
     ++		st->merged = NULL;
     ++	}
     ++	FREE_AND_NULL(st->list_file);
     ++	FREE_AND_NULL(st->reftable_dir);
     ++	reftable_free(st);
     ++}
     ++
     ++static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     ++						   int cur_len)
     ++{
     ++	struct reftable_reader **cur =
     ++		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
     ++	int i = 0;
     ++	for (i = 0; i < cur_len; i++) {
     ++		cur[i] = st->merged->stack[i];
     ++	}
     ++	return cur;
     ++}
     ++
     ++static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
     ++				      bool reuse_open)
     ++{
     ++	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     ++	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
     ++	int err = 0;
     ++	int names_len = names_length(names);
     ++	struct reftable_reader **new_tables =
     ++		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
     ++	int new_tables_len = 0;
     ++	struct reftable_merged_table *new_merged = NULL;
     ++	int i;
     ++	struct slice table_path = SLICE_INIT;
     ++
     ++	while (*names) {
     ++		struct reftable_reader *rd = NULL;
     ++		char *name = *names++;
     ++
     ++		/* this is linear; we assume compaction keeps the number of
     ++		   tables under control so this is not quadratic. */
     ++		int j = 0;
     ++		for (j = 0; reuse_open && j < cur_len; j++) {
     ++			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
     ++				rd = cur[j];
     ++				cur[j] = NULL;
     ++				break;
     ++			}
     ++		}
     ++
     ++		if (rd == NULL) {
     ++			struct reftable_block_source src = { 0 };
     ++			slice_set_string(&table_path, st->reftable_dir);
     ++			slice_addstr(&table_path, "/");
     ++			slice_addstr(&table_path, name);
     ++
     ++			err = reftable_block_source_from_file(
     ++				&src, slice_as_string(&table_path));
     ++			if (err < 0)
     ++				goto done;
     ++
     ++			err = reftable_new_reader(&rd, &src, name);
     ++			if (err < 0)
     ++				goto done;
     ++		}
     ++
     ++		new_tables[new_tables_len++] = rd;
     ++	}
     ++
     ++	/* success! */
     ++	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
     ++					st->config.hash_id);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	new_tables = NULL;
     ++	new_tables_len = 0;
     ++	if (st->merged != NULL) {
     ++		merged_table_clear(st->merged);
     ++		reftable_merged_table_free(st->merged);
     ++	}
     ++	new_merged->suppress_deletions = true;
     ++	st->merged = new_merged;
     ++
     ++	for (i = 0; i < cur_len; i++) {
     ++		if (cur[i] != NULL) {
     ++			reader_close(cur[i]);
     ++			reftable_reader_free(cur[i]);
     ++		}
     ++	}
     ++
     ++done:
     ++	slice_release(&table_path);
     ++	for (i = 0; i < new_tables_len; i++) {
     ++		reader_close(new_tables[i]);
     ++		reftable_reader_free(new_tables[i]);
     ++	}
     ++	reftable_free(new_tables);
     ++	reftable_free(cur);
     ++	return err;
     ++}
     ++
     ++/* return negative if a before b. */
     ++static int tv_cmp(struct timeval *a, struct timeval *b)
     ++{
     ++	time_t diff = a->tv_sec - b->tv_sec;
     ++	int udiff = a->tv_usec - b->tv_usec;
     ++
     ++	if (diff != 0)
     ++		return diff;
     ++
     ++	return udiff;
     ++}
     ++
     ++int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++				      bool reuse_open)
     ++{
     ++	struct timeval deadline = { 0 };
      +	int err = gettimeofday(&deadline, NULL);
      +	int64_t delay = 0;
      +	int tries = 0;
      +	if (err < 0)
     -+		return err;
     ++		return err;
     ++
     ++	deadline.tv_sec += 3;
     ++	while (true) {
     ++		char **names = NULL;
     ++		char **names_after = NULL;
     ++		struct timeval now = { 0 };
     ++		int err = gettimeofday(&now, NULL);
     ++		int err2 = 0;
     ++		if (err < 0) {
     ++			return err;
     ++		}
     ++
     ++		/* Only look at deadlines after the first few times. This
     ++		   simplifies debugging in GDB */
     ++		tries++;
     ++		if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
     ++			break;
     ++		}
     ++
     ++		err = read_lines(st->list_file, &names);
     ++		if (err < 0) {
     ++			free_names(names);
     ++			return err;
     ++		}
     ++		err = reftable_stack_reload_once(st, names, reuse_open);
     ++		if (err == 0) {
     ++			free_names(names);
     ++			break;
     ++		}
     ++		if (err != REFTABLE_NOT_EXIST_ERROR) {
     ++			free_names(names);
     ++			return err;
     ++		}
     ++
     ++		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
     ++		   writer. Check if there was one by checking if the name list
     ++		   changed.
     ++		*/
     ++		err2 = read_lines(st->list_file, &names_after);
     ++		if (err2 < 0) {
     ++			free_names(names);
     ++			return err2;
     ++		}
     ++
     ++		if (names_equal(names_after, names)) {
     ++			free_names(names);
     ++			free_names(names_after);
     ++			return err;
     ++		}
     ++		free_names(names);
     ++		free_names(names_after);
     ++
     ++		delay = delay + (delay * rand()) / RAND_MAX + 1;
     ++		sleep_millisec(delay);
     ++	}
     ++
     ++	return 0;
     ++}
     ++
     ++/* -1 = error
     ++ 0 = up to date
     ++ 1 = changed. */
     ++static int stack_uptodate(struct reftable_stack *st)
     ++{
     ++	char **names = NULL;
     ++	int err = read_lines(st->list_file, &names);
     ++	int i = 0;
     ++	if (err < 0)
     ++		return err;
     ++
     ++	for (i = 0; i < st->merged->stack_len; i++) {
     ++		if (names[i] == NULL) {
     ++			err = 1;
     ++			goto done;
     ++		}
     ++
     ++		if (strcmp(st->merged->stack[i]->name, names[i])) {
     ++			err = 1;
     ++			goto done;
     ++		}
     ++	}
     ++
     ++	if (names[st->merged->stack_len] != NULL) {
     ++		err = 1;
     ++		goto done;
     ++	}
     ++
     ++done:
     ++	free_names(names);
     ++	return err;
     ++}
     ++
     ++int reftable_stack_reload(struct reftable_stack *st)
     ++{
     ++	int err = stack_uptodate(st);
     ++	if (err > 0)
     ++		return reftable_stack_reload_maybe_reuse(st, true);
     ++	return err;
     ++}
     ++
     ++int reftable_stack_add(struct reftable_stack *st,
     ++		       int (*write)(struct reftable_writer *wr, void *arg),
     ++		       void *arg)
     ++{
     ++	int err = stack_try_add(st, write, arg);
     ++	if (err < 0) {
     ++		if (err == REFTABLE_LOCK_ERROR) {
     ++			/* Ignore error return, we want to propagate
     ++			   REFTABLE_LOCK_ERROR.
     ++			*/
     ++			reftable_stack_reload(st);
     ++		}
     ++		return err;
     ++	}
     ++
     ++	if (!st->disable_auto_compact)
     ++		return reftable_stack_auto_compact(st);
     ++
     ++	return 0;
     ++}
     ++
     ++static void format_name(struct slice *dest, uint64_t min, uint64_t max)
     ++{
     ++	char buf[100];
     ++	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
     ++	slice_set_string(dest, buf);
     ++}
     ++
     ++struct reftable_addition {
     ++	int lock_file_fd;
     ++	struct slice lock_file_name;
     ++	struct reftable_stack *stack;
     ++	char **names;
     ++	char **new_tables;
     ++	int new_tables_len;
     ++	uint64_t next_update_index;
     ++};
     ++
     ++#define REFTABLE_ADDITION_INIT               \
     ++	{                                    \
     ++		.lock_file_name = SLICE_INIT \
     ++	}
     ++
     ++static int reftable_stack_init_addition(struct reftable_addition *add,
     ++					struct reftable_stack *st)
     ++{
     ++	int err = 0;
     ++	add->stack = st;
     ++
     ++	slice_set_string(&add->lock_file_name, st->list_file);
     ++	slice_addstr(&add->lock_file_name, ".lock");
     ++
     ++	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
     ++				 O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	if (add->lock_file_fd < 0) {
     ++		if (errno == EEXIST) {
     ++			err = REFTABLE_LOCK_ERROR;
     ++		} else {
     ++			err = REFTABLE_IO_ERROR;
     ++		}
     ++		goto done;
     ++	}
     ++	err = stack_uptodate(st);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	if (err > 1) {
     ++		err = REFTABLE_LOCK_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	add->next_update_index = reftable_stack_next_update_index(st);
     ++done:
     ++	if (err) {
     ++		reftable_addition_close(add);
     ++	}
     ++	return err;
     ++}
     ++
     ++void reftable_addition_close(struct reftable_addition *add)
     ++{
     ++	int i = 0;
     ++	struct slice nm = SLICE_INIT;
     ++	for (i = 0; i < add->new_tables_len; i++) {
     ++		slice_set_string(&nm, add->stack->list_file);
     ++		slice_addstr(&nm, "/");
     ++		slice_addstr(&nm, add->new_tables[i]);
     ++		unlink(slice_as_string(&nm));
     ++		reftable_free(add->new_tables[i]);
     ++		add->new_tables[i] = NULL;
     ++	}
     ++	reftable_free(add->new_tables);
     ++	add->new_tables = NULL;
     ++	add->new_tables_len = 0;
     ++
     ++	if (add->lock_file_fd > 0) {
     ++		close(add->lock_file_fd);
     ++		add->lock_file_fd = 0;
     ++	}
     ++	if (add->lock_file_name.len > 0) {
     ++		unlink(slice_as_string(&add->lock_file_name));
     ++		slice_release(&add->lock_file_name);
     ++	}
     ++
     ++	free_names(add->names);
     ++	add->names = NULL;
     ++	slice_release(&nm);
     ++}
     ++
     ++void reftable_addition_destroy(struct reftable_addition *add)
     ++{
     ++	if (add == NULL) {
     ++		return;
     ++	}
     ++	reftable_addition_close(add);
     ++	reftable_free(add);
     ++}
     ++
     ++int reftable_addition_commit(struct reftable_addition *add)
     ++{
     ++	struct slice table_list = SLICE_INIT;
     ++	int i = 0;
     ++	int err = 0;
     ++	if (add->new_tables_len == 0)
     ++		goto done;
     ++
     ++	for (i = 0; i < add->stack->merged->stack_len; i++) {
     ++		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
     ++		slice_addstr(&table_list, "\n");
     ++	}
     ++	for (i = 0; i < add->new_tables_len; i++) {
     ++		slice_addstr(&table_list, add->new_tables[i]);
     ++		slice_addstr(&table_list, "\n");
     ++	}
     ++
     ++	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     ++	slice_release(&table_list);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	err = close(add->lock_file_fd);
     ++	add->lock_file_fd = 0;
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	err = rename(slice_as_string(&add->lock_file_name),
     ++		     add->stack->list_file);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_stack_reload(add->stack);
     ++
     ++done:
     ++	reftable_addition_close(add);
     ++	return err;
     ++}
     ++
     ++int reftable_stack_new_addition(struct reftable_addition **dest,
     ++				struct reftable_stack *st)
     ++{
     ++	int err = 0;
     ++	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
     ++	*dest = reftable_calloc(sizeof(**dest));
     ++	**dest = empty;
     ++	err = reftable_stack_init_addition(*dest, st);
     ++	if (err) {
     ++		reftable_free(*dest);
     ++		*dest = NULL;
     ++	}
     ++	return err;
     ++}
     ++
     ++int stack_try_add(struct reftable_stack *st,
     ++		  int (*write_table)(struct reftable_writer *wr, void *arg),
     ++		  void *arg)
     ++{
     ++	struct reftable_addition add = REFTABLE_ADDITION_INIT;
     ++	int err = reftable_stack_init_addition(&add, st);
     ++	if (err < 0)
     ++		goto done;
     ++	if (err > 0) {
     ++		err = REFTABLE_LOCK_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_addition_add(&add, write_table, arg);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_addition_commit(&add);
     ++done:
     ++	reftable_addition_close(&add);
     ++	return err;
     ++}
     ++
     ++int reftable_addition_add(struct reftable_addition *add,
     ++			  int (*write_table)(struct reftable_writer *wr,
     ++					     void *arg),
     ++			  void *arg)
     ++{
     ++	struct slice temp_tab_file_name = SLICE_INIT;
     ++	struct slice tab_file_name = SLICE_INIT;
     ++	struct slice next_name = SLICE_INIT;
     ++	struct reftable_writer *wr = NULL;
     ++	int err = 0;
     ++	int tab_fd = 0;
     ++
     ++	slice_resize(&next_name, 0);
     ++	format_name(&next_name, add->next_update_index, add->next_update_index);
     ++
     ++	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
     ++	slice_addstr(&temp_tab_file_name, "/");
     ++	slice_addbuf(&temp_tab_file_name, &next_name);
     ++	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
     ++
     ++	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
     ++	if (tab_fd < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
     ++				 &add->stack->config);
     ++	err = write_table(wr, arg);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_writer_close(wr);
     ++	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
     ++		err = 0;
     ++		goto done;
     ++	}
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = close(tab_fd);
     ++	tab_fd = 0;
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	err = stack_check_addition(add->stack,
     ++				   slice_as_string(&temp_tab_file_name));
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	if (wr->min_update_index < add->next_update_index) {
     ++		err = REFTABLE_API_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	format_name(&next_name, wr->min_update_index, wr->max_update_index);
     ++	slice_addstr(&next_name, ".ref");
     ++
     ++	slice_set_string(&tab_file_name, add->stack->reftable_dir);
     ++	slice_addstr(&tab_file_name, "/");
     ++	slice_addbuf(&tab_file_name, &next_name);
     ++
     ++	/* TODO: should check destination out of paranoia */
     ++	err = rename(slice_as_string(&temp_tab_file_name),
     ++		     slice_as_string(&tab_file_name));
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	add->new_tables = reftable_realloc(add->new_tables,
     ++					   sizeof(*add->new_tables) *
     ++						   (add->new_tables_len + 1));
     ++	add->new_tables[add->new_tables_len] = slice_to_string(&next_name);
     ++	add->new_tables_len++;
     ++done:
     ++	if (tab_fd > 0) {
     ++		close(tab_fd);
     ++		tab_fd = 0;
     ++	}
     ++	if (temp_tab_file_name.len > 0) {
     ++		unlink(slice_as_string(&temp_tab_file_name));
     ++	}
     ++
     ++	slice_release(&temp_tab_file_name);
     ++	slice_release(&tab_file_name);
     ++	slice_release(&next_name);
     ++	reftable_writer_free(wr);
     ++	return err;
     ++}
     ++
     ++uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
     ++{
     ++	int sz = st->merged->stack_len;
     ++	if (sz > 0)
     ++		return reftable_reader_max_update_index(
     ++			       st->merged->stack[sz - 1]) +
     ++		       1;
     ++	return 1;
     ++}
     ++
     ++static int stack_compact_locked(struct reftable_stack *st, int first, int last,
     ++				struct slice *temp_tab,
     ++				struct reftable_log_expiry_config *config)
     ++{
     ++	struct slice next_name = SLICE_INIT;
     ++	int tab_fd = -1;
     ++	struct reftable_writer *wr = NULL;
     ++	int err = 0;
     ++
     ++	format_name(&next_name,
     ++		    reftable_reader_min_update_index(st->merged->stack[first]),
     ++		    reftable_reader_max_update_index(st->merged->stack[first]));
     ++
     ++	slice_set_string(temp_tab, st->reftable_dir);
     ++	slice_addstr(temp_tab, "/");
     ++	slice_addbuf(temp_tab, &next_name);
     ++	slice_addstr(temp_tab, ".temp.XXXXXX");
     ++
     ++	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
     ++	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
     ++
     ++	err = stack_write_compact(st, wr, first, last, config);
     ++	if (err < 0)
     ++		goto done;
     ++	err = reftable_writer_close(wr);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = close(tab_fd);
     ++	tab_fd = 0;
     ++
     ++done:
     ++	reftable_writer_free(wr);
     ++	if (tab_fd > 0) {
     ++		close(tab_fd);
     ++		tab_fd = 0;
     ++	}
     ++	if (err != 0 && temp_tab->len > 0) {
     ++		unlink(slice_as_string(temp_tab));
     ++		slice_release(temp_tab);
     ++	}
     ++	slice_release(&next_name);
     ++	return err;
     ++}
     ++
     ++int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     ++			int first, int last,
     ++			struct reftable_log_expiry_config *config)
     ++{
     ++	int subtabs_len = last - first + 1;
     ++	struct reftable_reader **subtabs = reftable_calloc(
     ++		sizeof(struct reftable_reader *) * (last - first + 1));
     ++	struct reftable_merged_table *mt = NULL;
     ++	int err = 0;
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
     ++
     ++	uint64_t entries = 0;
     ++
     ++	int i = 0, j = 0;
     ++	for (i = first, j = 0; i <= last; i++) {
     ++		struct reftable_reader *t = st->merged->stack[i];
     ++		subtabs[j++] = t;
     ++		st->stats.bytes += t->size;
     ++	}
     ++	reftable_writer_set_limits(wr,
     ++				   st->merged->stack[first]->min_update_index,
     ++				   st->merged->stack[last]->max_update_index);
     ++
     ++	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
     ++					st->config.hash_id);
     ++	if (err < 0) {
     ++		reftable_free(subtabs);
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_merged_table_seek_ref(mt, &it, "");
     ++	if (err < 0)
     ++		goto done;
      +
     -+	deadline.tv_sec += 3;
      +	while (true) {
     -+		char **names = NULL;
     -+		char **names_after = NULL;
     -+		struct timeval now = { 0 };
     -+		int err = gettimeofday(&now, NULL);
     -+		int err2 = 0;
     ++		err = reftable_iterator_next_ref(&it, &ref);
     ++		if (err > 0) {
     ++			err = 0;
     ++			break;
     ++		}
      +		if (err < 0) {
     -+			return err;
     ++			break;
     ++		}
     ++		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
     ++			continue;
      +		}
      +
     -+		/* Only look at deadlines after the first few times. This
     -+		   simplifies debugging in GDB */
     -+		tries++;
     -+		if (tries > 3 && tv_cmp(&now, &deadline) >= 0) {
     ++		err = reftable_writer_add_ref(wr, &ref);
     ++		if (err < 0) {
      +			break;
      +		}
     ++		entries++;
     ++	}
     ++	reftable_iterator_destroy(&it);
      +
     -+		err = read_lines(st->list_file, &names);
     -+		if (err < 0) {
     -+			free_names(names);
     -+			return err;
     ++	err = reftable_merged_table_seek_log(mt, &it, "");
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	while (true) {
     ++		err = reftable_iterator_next_log(&it, &log);
     ++		if (err > 0) {
     ++			err = 0;
     ++			break;
      +		}
     -+		err = reftable_stack_reload_once(st, names, reuse_open);
     -+		if (err == 0) {
     -+			free_names(names);
     ++		if (err < 0) {
      +			break;
      +		}
     -+		if (err != REFTABLE_NOT_EXIST_ERROR) {
     -+			free_names(names);
     -+			return err;
     ++		if (first == 0 && reftable_log_record_is_deletion(&log)) {
     ++			continue;
      +		}
      +
     -+		/* err == REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
     -+		   writer. Check if there was one by checking if the name list
     -+		   changed.
     -+		*/
     -+		err2 = read_lines(st->list_file, &names_after);
     -+		if (err2 < 0) {
     -+			free_names(names);
     -+			return err2;
     ++		if (config != NULL && config->time > 0 &&
     ++		    log.time < config->time) {
     ++			continue;
      +		}
      +
     -+		if (names_equal(names_after, names)) {
     -+			free_names(names);
     -+			free_names(names_after);
     -+			return err;
     ++		if (config != NULL && config->min_update_index > 0 &&
     ++		    log.update_index < config->min_update_index) {
     ++			continue;
      +		}
     -+		free_names(names);
     -+		free_names(names_after);
      +
     -+		delay = delay + (delay * rand()) / RAND_MAX + 1;
     -+		sleep_millisec(delay);
     ++		err = reftable_writer_add_log(wr, &log);
     ++		if (err < 0) {
     ++			break;
     ++		}
     ++		entries++;
     ++	}
     ++
     ++done:
     ++	reftable_iterator_destroy(&it);
     ++	if (mt != NULL) {
     ++		merged_table_clear(mt);
     ++		reftable_merged_table_free(mt);
     ++	}
     ++	reftable_ref_record_clear(&ref);
     ++	reftable_log_record_clear(&log);
     ++	st->stats.entries_written += entries;
     ++	return err;
     ++}
     ++
     ++/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
     ++static int stack_compact_range(struct reftable_stack *st, int first, int last,
     ++			       struct reftable_log_expiry_config *expiry)
     ++{
     ++	struct slice temp_tab_file_name = SLICE_INIT;
     ++	struct slice new_table_name = SLICE_INIT;
     ++	struct slice lock_file_name = SLICE_INIT;
     ++	struct slice ref_list_contents = SLICE_INIT;
     ++	struct slice new_table_path = SLICE_INIT;
     ++	int err = 0;
     ++	bool have_lock = false;
     ++	int lock_file_fd = 0;
     ++	int compact_count = last - first + 1;
     ++	char **listp = NULL;
     ++	char **delete_on_success =
     ++		reftable_calloc(sizeof(char *) * (compact_count + 1));
     ++	char **subtable_locks =
     ++		reftable_calloc(sizeof(char *) * (compact_count + 1));
     ++	int i = 0;
     ++	int j = 0;
     ++	bool is_empty_table = false;
     ++
     ++	if (first > last || (expiry == NULL && first == last)) {
     ++		err = 0;
     ++		goto done;
     ++	}
     ++
     ++	st->stats.attempts++;
     ++
     ++	slice_set_string(&lock_file_name, st->list_file);
     ++	slice_addstr(&lock_file_name, ".lock");
     ++
     ++	lock_file_fd = open(slice_as_string(&lock_file_name),
     ++			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	if (lock_file_fd < 0) {
     ++		if (errno == EEXIST) {
     ++			err = 1;
     ++		} else {
     ++			err = REFTABLE_IO_ERROR;
     ++		}
     ++		goto done;
     ++	}
     ++	/* Don't want to write to the lock for now.  */
     ++	close(lock_file_fd);
     ++	lock_file_fd = 0;
     ++
     ++	have_lock = true;
     ++	err = stack_uptodate(st);
     ++	if (err != 0)
     ++		goto done;
     ++
     ++	for (i = first, j = 0; i <= last; i++) {
     ++		struct slice subtab_file_name = SLICE_INIT;
     ++		struct slice subtab_lock = SLICE_INIT;
     ++		int sublock_file_fd = -1;
     ++
     ++		slice_set_string(&subtab_file_name, st->reftable_dir);
     ++		slice_addstr(&subtab_file_name, "/");
     ++		slice_addstr(&subtab_file_name,
     ++			     reader_name(st->merged->stack[i]));
     ++
     ++		slice_copy(&subtab_lock, &subtab_file_name);
     ++		slice_addstr(&subtab_lock, ".lock");
     ++
     ++		sublock_file_fd = open(slice_as_string(&subtab_lock),
     ++				       O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++		if (sublock_file_fd > 0) {
     ++			close(sublock_file_fd);
     ++		} else if (sublock_file_fd < 0) {
     ++			if (errno == EEXIST) {
     ++				err = 1;
     ++			} else {
     ++				err = REFTABLE_IO_ERROR;
     ++			}
     ++		}
     ++
     ++		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
     ++		delete_on_success[j] =
     ++			(char *)slice_as_string(&subtab_file_name);
     ++		j++;
     ++
     ++		if (err != 0)
     ++			goto done;
      +	}
      +
     -+	return 0;
     -+}
     ++	err = unlink(slice_as_string(&lock_file_name));
     ++	if (err < 0)
     ++		goto done;
     ++	have_lock = false;
      +
     -+/* -1 = error
     -+ 0 = up to date
     -+ 1 = changed. */
     -+static int stack_uptodate(struct reftable_stack *st)
     -+{
     -+	char **names = NULL;
     -+	int err = read_lines(st->list_file, &names);
     -+	int i = 0;
     ++	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
     ++				   expiry);
     ++	/* Compaction + tombstones can create an empty table out of non-empty
     ++	 * tables. */
     ++	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
     ++	if (is_empty_table) {
     ++		err = 0;
     ++	}
      +	if (err < 0)
     -+		return err;
     ++		goto done;
      +
     -+	for (i = 0; i < st->merged->stack_len; i++) {
     -+		if (names[i] == NULL) {
     ++	lock_file_fd = open(slice_as_string(&lock_file_name),
     ++			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	if (lock_file_fd < 0) {
     ++		if (errno == EEXIST) {
      +			err = 1;
     -+			goto done;
     ++		} else {
     ++			err = REFTABLE_IO_ERROR;
      +		}
     ++		goto done;
     ++	}
     ++	have_lock = true;
      +
     -+		if (strcmp(st->merged->stack[i]->name, names[i])) {
     -+			err = 1;
     ++	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
     ++		    st->merged->stack[last]->max_update_index);
     ++	slice_addstr(&new_table_name, ".ref");
     ++
     ++	slice_set_string(&new_table_path, st->reftable_dir);
     ++	slice_addstr(&new_table_path, "/");
     ++
     ++	slice_addbuf(&new_table_path, &new_table_name);
     ++
     ++	if (!is_empty_table) {
     ++		err = rename(slice_as_string(&temp_tab_file_name),
     ++			     slice_as_string(&new_table_path));
     ++		if (err < 0) {
     ++			err = REFTABLE_IO_ERROR;
      +			goto done;
      +		}
      +	}
      +
     -+	if (names[st->merged->stack_len] != NULL) {
     -+		err = 1;
     ++	for (i = 0; i < first; i++) {
     ++		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		slice_addstr(&ref_list_contents, "\n");
     ++	}
     ++	if (!is_empty_table) {
     ++		slice_addbuf(&ref_list_contents, &new_table_name);
     ++		slice_addstr(&ref_list_contents, "\n");
     ++	}
     ++	for (i = last + 1; i < st->merged->stack_len; i++) {
     ++		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		slice_addstr(&ref_list_contents, "\n");
     ++	}
     ++
     ++	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		unlink(slice_as_string(&new_table_path));
     ++		goto done;
     ++	}
     ++	err = close(lock_file_fd);
     ++	lock_file_fd = 0;
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		unlink(slice_as_string(&new_table_path));
     ++		goto done;
     ++	}
     ++
     ++	err = rename(slice_as_string(&lock_file_name), st->list_file);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		unlink(slice_as_string(&new_table_path));
      +		goto done;
      +	}
     ++	have_lock = false;
     ++
     ++	/* Reload the stack before deleting. On windows, we can only delete the
     ++	   files after we closed them.
     ++	*/
     ++	err = reftable_stack_reload_maybe_reuse(st, first < last);
     ++
     ++	listp = delete_on_success;
     ++	while (*listp) {
     ++		if (strcmp(*listp, slice_as_string(&new_table_path))) {
     ++			unlink(*listp);
     ++		}
     ++		listp++;
     ++	}
      +
      +done:
     -+	free_names(names);
     ++	free_names(delete_on_success);
     ++
     ++	listp = subtable_locks;
     ++	while (*listp) {
     ++		unlink(*listp);
     ++		listp++;
     ++	}
     ++	free_names(subtable_locks);
     ++	if (lock_file_fd > 0) {
     ++		close(lock_file_fd);
     ++		lock_file_fd = 0;
     ++	}
     ++	if (have_lock) {
     ++		unlink(slice_as_string(&lock_file_name));
     ++	}
     ++	slice_release(&new_table_name);
     ++	slice_release(&new_table_path);
     ++	slice_release(&ref_list_contents);
     ++	slice_release(&temp_tab_file_name);
     ++	slice_release(&lock_file_name);
      +	return err;
      +}
      +
     -+int reftable_stack_reload(struct reftable_stack *st)
     ++int reftable_stack_compact_all(struct reftable_stack *st,
     ++			       struct reftable_log_expiry_config *config)
      +{
     -+	int err = stack_uptodate(st);
     -+	if (err > 0)
     -+		return reftable_stack_reload_maybe_reuse(st, true);
     -+	return err;
     ++	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
      +}
      +
     -+int reftable_stack_add(struct reftable_stack *st,
     -+		       int (*write)(struct reftable_writer *wr, void *arg),
     -+		       void *arg)
     ++static int stack_compact_range_stats(struct reftable_stack *st, int first,
     ++				     int last,
     ++				     struct reftable_log_expiry_config *config)
      +{
     -+	int err = stack_try_add(st, write, arg);
     -+	if (err < 0) {
     -+		if (err == REFTABLE_LOCK_ERROR) {
     -+			/* Ignore error return, we want to propagate
     -+			   REFTABLE_LOCK_ERROR.
     -+			*/
     -+			reftable_stack_reload(st);
     -+		}
     -+		return err;
     ++	int err = stack_compact_range(st, first, last, config);
     ++	if (err > 0) {
     ++		st->stats.failures++;
      +	}
     -+
     -+	if (!st->disable_auto_compact)
     -+		return reftable_stack_auto_compact(st);
     -+
     -+	return 0;
     ++	return err;
      +}
      +
     -+static void format_name(struct slice *dest, uint64_t min, uint64_t max)
     ++static int segment_size(struct segment *s)
      +{
     -+	char buf[100];
     -+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
     -+	slice_set_string(dest, buf);
     ++	return s->end - s->start;
      +}
      +
     -+struct reftable_addition {
     -+	int lock_file_fd;
     -+	struct slice lock_file_name;
     -+	struct reftable_stack *stack;
     -+	char **names;
     -+	char **new_tables;
     -+	int new_tables_len;
     -+	uint64_t next_update_index;
     -+};
     -+
     -+#define REFTABLE_ADDITION_INIT               \
     -+	{                                    \
     -+		.lock_file_name = SLICE_INIT \
     ++int fastlog2(uint64_t sz)
     ++{
     ++	int l = 0;
     ++	if (sz == 0)
     ++		return 0;
     ++	for (; sz; sz /= 2) {
     ++		l++;
      +	}
     ++	return l - 1;
     ++}
      +
     -+static int reftable_stack_init_addition(struct reftable_addition *add,
     -+					struct reftable_stack *st)
     ++struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
      +{
     -+	int err = 0;
     -+	add->stack = st;
     ++	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
     ++	int next = 0;
     ++	struct segment cur = { 0 };
     ++	int i = 0;
      +
     -+	slice_set_string(&add->lock_file_name, st->list_file);
     -+	slice_addstr(&add->lock_file_name, ".lock");
     ++	if (n == 0) {
     ++		*seglen = 0;
     ++		return segs;
     ++	}
     ++	for (i = 0; i < n; i++) {
     ++		int log = fastlog2(sizes[i]);
     ++		if (cur.log != log && cur.bytes > 0) {
     ++			struct segment fresh = {
     ++				.start = i,
     ++			};
      +
     -+	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
     -+				 O_EXCL | O_CREAT | O_WRONLY, 0644);
     -+	if (add->lock_file_fd < 0) {
     -+		if (errno == EEXIST) {
     -+			err = REFTABLE_LOCK_ERROR;
     -+		} else {
     -+			err = REFTABLE_IO_ERROR;
     ++			segs[next++] = cur;
     ++			cur = fresh;
      +		}
     -+		goto done;
     ++
     ++		cur.log = log;
     ++		cur.end = i + 1;
     ++		cur.bytes += sizes[i];
      +	}
     -+	err = stack_uptodate(st);
     -+	if (err < 0)
     -+		goto done;
     ++	segs[next++] = cur;
     ++	*seglen = next;
     ++	return segs;
     ++}
      +
     -+	if (err > 1) {
     -+		err = REFTABLE_LOCK_ERROR;
     -+		goto done;
     ++struct segment suggest_compaction_segment(uint64_t *sizes, int n)
     ++{
     ++	int seglen = 0;
     ++	struct segment *segs = sizes_to_segments(&seglen, sizes, n);
     ++	struct segment min_seg = {
     ++		.log = 64,
     ++	};
     ++	int i = 0;
     ++	for (i = 0; i < seglen; i++) {
     ++		if (segment_size(&segs[i]) == 1) {
     ++			continue;
     ++		}
     ++
     ++		if (segs[i].log < min_seg.log) {
     ++			min_seg = segs[i];
     ++		}
      +	}
      +
     -+	add->next_update_index = reftable_stack_next_update_index(st);
     -+done:
     -+	if (err) {
     -+		reftable_addition_close(add);
     ++	while (min_seg.start > 0) {
     ++		int prev = min_seg.start - 1;
     ++		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
     ++			break;
     ++		}
     ++
     ++		min_seg.start = prev;
     ++		min_seg.bytes += sizes[prev];
      +	}
     -+	return err;
     ++
     ++	reftable_free(segs);
     ++	return min_seg;
      +}
      +
     -+void reftable_addition_close(struct reftable_addition *add)
     ++static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
      +{
     ++	uint64_t *sizes =
     ++		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
     ++	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
     ++	int overhead = header_size(version) - 1;
      +	int i = 0;
     -+	struct slice nm = SLICE_INIT;
     -+	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_set_string(&nm, add->stack->list_file);
     -+		slice_addstr(&nm, "/");
     -+		slice_addstr(&nm, add->new_tables[i]);
     -+		unlink(slice_as_string(&nm));
     -+		reftable_free(add->new_tables[i]);
     -+		add->new_tables[i] = NULL;
     ++	for (i = 0; i < st->merged->stack_len; i++) {
     ++		sizes[i] = st->merged->stack[i]->size - overhead;
      +	}
     -+	reftable_free(add->new_tables);
     -+	add->new_tables = NULL;
     -+	add->new_tables_len = 0;
     ++	return sizes;
     ++}
      +
     -+	if (add->lock_file_fd > 0) {
     -+		close(add->lock_file_fd);
     -+		add->lock_file_fd = 0;
     -+	}
     -+	if (add->lock_file_name.len > 0) {
     -+		unlink(slice_as_string(&add->lock_file_name));
     -+		slice_release(&add->lock_file_name);
     -+	}
     ++int reftable_stack_auto_compact(struct reftable_stack *st)
     ++{
     ++	uint64_t *sizes = stack_table_sizes_for_compaction(st);
     ++	struct segment seg =
     ++		suggest_compaction_segment(sizes, st->merged->stack_len);
     ++	reftable_free(sizes);
     ++	if (segment_size(&seg) > 0)
     ++		return stack_compact_range_stats(st, seg.start, seg.end - 1,
     ++						 NULL);
      +
     -+	free_names(add->names);
     -+	add->names = NULL;
     -+	slice_release(&nm);
     ++	return 0;
      +}
      +
     -+void reftable_addition_destroy(struct reftable_addition *add)
     ++struct reftable_compaction_stats *
     ++reftable_stack_compaction_stats(struct reftable_stack *st)
      +{
     -+	if (add == NULL) {
     -+		return;
     -+	}
     -+	reftable_addition_close(add);
     -+	reftable_free(add);
     ++	return &st->stats;
      +}
      +
     -+int reftable_addition_commit(struct reftable_addition *add)
     ++int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_ref_record *ref)
      +{
     -+	struct slice table_list = SLICE_INIT;
     -+	int i = 0;
     -+	int err = 0;
     -+	if (add->new_tables_len == 0)
     -+		goto done;
     -+
     -+	for (i = 0; i < add->stack->merged->stack_len; i++) {
     -+		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
     -+		slice_addstr(&table_list, "\n");
     -+	}
     -+	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_addstr(&table_list, add->new_tables[i]);
     -+		slice_addstr(&table_list, "\n");
     -+	}
     ++	struct reftable_table tab = { NULL };
     ++	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     ++	return reftable_table_read_ref(&tab, refname, ref);
     ++}
      +
     -+	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     -+	slice_release(&table_list);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     ++int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_log_record *log)
     ++{
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     ++	int err = reftable_merged_table_seek_log(mt, &it, refname);
     ++	if (err)
      +		goto done;
     -+	}
      +
     -+	err = close(add->lock_file_fd);
     -+	add->lock_file_fd = 0;
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     ++	err = reftable_iterator_next_log(&it, log);
     ++	if (err)
      +		goto done;
     -+	}
      +
     -+	err = rename(slice_as_string(&add->lock_file_name),
     -+		     add->stack->list_file);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     ++	if (strcmp(log->ref_name, refname) ||
     ++	    reftable_log_record_is_deletion(log)) {
     ++		err = 1;
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_reload(add->stack);
     -+
      +done:
     -+	reftable_addition_close(add);
     -+	return err;
     -+}
     -+
     -+int reftable_stack_new_addition(struct reftable_addition **dest,
     -+				struct reftable_stack *st)
     -+{
     -+	int err = 0;
     -+	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
     -+	*dest = reftable_calloc(sizeof(**dest));
     -+	**dest = empty;
     -+	err = reftable_stack_init_addition(*dest, st);
      +	if (err) {
     -+		reftable_free(*dest);
     -+		*dest = NULL;
     ++		reftable_log_record_clear(log);
      +	}
     ++	reftable_iterator_destroy(&it);
      +	return err;
      +}
      +
     -+int stack_try_add(struct reftable_stack *st,
     -+		  int (*write_table)(struct reftable_writer *wr, void *arg),
     -+		  void *arg)
     ++int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
      +{
     -+	struct reftable_addition add = REFTABLE_ADDITION_INIT;
     -+	int err = reftable_stack_init_addition(&add, st);
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
     ++	if (st->config.skip_name_check)
     ++		return 0;
     ++
     ++	err = reftable_block_source_from_file(&src, new_tab_name);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_new_reader(&rd, &src, new_tab_name);
      +	if (err < 0)
      +		goto done;
     ++
     ++	err = reftable_reader_seek_ref(rd, &it, "");
      +	if (err > 0) {
     -+		err = REFTABLE_LOCK_ERROR;
     ++		err = 0;
      +		goto done;
      +	}
     -+
     -+	err = reftable_addition_add(&add, write_table, arg);
      +	if (err < 0)
      +		goto done;
      +
     -+	err = reftable_addition_commit(&add);
     ++	while (true) {
     ++		struct reftable_ref_record ref = { 0 };
     ++		err = reftable_iterator_next_ref(&it, &ref);
     ++		if (err > 0) {
     ++			break;
     ++		}
     ++		if (err < 0)
     ++			goto done;
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
      +done:
     -+	reftable_addition_close(&add);
     ++	for (i = 0; i < len; i++) {
     ++		reftable_ref_record_clear(&refs[i]);
     ++	}
     ++
     ++	free(refs);
     ++	reftable_iterator_destroy(&it);
     ++	reftable_reader_free(rd);
      +	return err;
      +}
     +
     + ## reftable/stack.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+int reftable_addition_add(struct reftable_addition *add,
     -+			  int (*write_table)(struct reftable_writer *wr,
     -+					     void *arg),
     -+			  void *arg)
     -+{
     -+	struct slice temp_tab_file_name = SLICE_INIT;
     -+	struct slice tab_file_name = SLICE_INIT;
     -+	struct slice next_name = SLICE_INIT;
     -+	struct reftable_writer *wr = NULL;
     -+	int err = 0;
     -+	int tab_fd = 0;
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+	slice_resize(&next_name, 0);
     -+	format_name(&next_name, add->next_update_index, add->next_update_index);
     ++#ifndef STACK_H
     ++#define STACK_H
      +
     -+	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
     -+	slice_addstr(&temp_tab_file_name, "/");
     -+	slice_addbuf(&temp_tab_file_name, next_name);
     -+	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
     ++#include "reftable.h"
     ++#include "system.h"
      +
     -+	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
     -+	if (tab_fd < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     ++struct reftable_stack {
     ++	char *list_file;
     ++	char *reftable_dir;
     ++	bool disable_auto_compact;
      +
     -+	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
     -+				 &add->stack->config);
     -+	err = write_table(wr, arg);
     -+	if (err < 0)
     -+		goto done;
     ++	struct reftable_write_options config;
      +
     -+	err = reftable_writer_close(wr);
     -+	if (err == REFTABLE_EMPTY_TABLE_ERROR) {
     -+		err = 0;
     -+		goto done;
     -+	}
     -+	if (err < 0)
     -+		goto done;
     ++	struct reftable_merged_table *merged;
     ++	struct reftable_compaction_stats stats;
     ++};
      +
     -+	err = close(tab_fd);
     -+	tab_fd = 0;
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     ++int read_lines(const char *filename, char ***lines);
     ++int stack_try_add(struct reftable_stack *st,
     ++		  int (*write_table)(struct reftable_writer *wr, void *arg),
     ++		  void *arg);
     ++int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     ++			int first, int last,
     ++			struct reftable_log_expiry_config *config);
     ++int fastlog2(uint64_t sz);
     ++int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
     ++void reftable_addition_close(struct reftable_addition *add);
     ++int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++				      bool reuse_open);
      +
     -+	err = stack_check_addition(add->stack,
     -+				   slice_as_string(&temp_tab_file_name));
     -+	if (err < 0)
     -+		goto done;
     ++struct segment {
     ++	int start, end;
     ++	int log;
     ++	uint64_t bytes;
     ++};
      +
     -+	if (wr->min_update_index < add->next_update_index) {
     -+		err = REFTABLE_API_ERROR;
     -+		goto done;
     -+	}
     ++struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
     ++struct segment suggest_compaction_segment(uint64_t *sizes, int n);
      +
     -+	format_name(&next_name, wr->min_update_index, wr->max_update_index);
     -+	slice_addstr(&next_name, ".ref");
     ++#endif
     +
     + ## reftable/stack_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+	slice_set_string(&tab_file_name, add->stack->reftable_dir);
     -+	slice_addstr(&tab_file_name, "/");
     -+	slice_addbuf(&tab_file_name, next_name);
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+	/* TODO: should check destination out of paranoia */
     -+	err = rename(slice_as_string(&temp_tab_file_name),
     -+		     slice_as_string(&tab_file_name));
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     ++#include "stack.h"
      +
     -+	add->new_tables = reftable_realloc(add->new_tables,
     -+					   sizeof(*add->new_tables) *
     -+						   (add->new_tables_len + 1));
     -+	add->new_tables[add->new_tables_len] = slice_to_string(next_name);
     -+	add->new_tables_len++;
     -+done:
     -+	if (tab_fd > 0) {
     -+		close(tab_fd);
     -+		tab_fd = 0;
     -+	}
     -+	if (temp_tab_file_name.len > 0) {
     -+		unlink(slice_as_string(&temp_tab_file_name));
     -+	}
     ++#include "system.h"
      +
     -+	slice_release(&temp_tab_file_name);
     -+	slice_release(&tab_file_name);
     -+	slice_release(&next_name);
     -+	reftable_writer_free(wr);
     -+	return err;
     -+}
     ++#include "merged.h"
     ++#include "basics.h"
     ++#include "constants.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
      +
     -+uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
     -+{
     -+	int sz = st->merged->stack_len;
     -+	if (sz > 0)
     -+		return reftable_reader_max_update_index(
     -+			       st->merged->stack[sz - 1]) +
     -+		       1;
     -+	return 1;
     -+}
     ++#include <sys/types.h>
     ++#include <dirent.h>
      +
     -+static int stack_compact_locked(struct reftable_stack *st, int first, int last,
     -+				struct slice *temp_tab,
     -+				struct reftable_log_expiry_config *config)
     ++static void clear_dir(const char *dirname)
      +{
     -+	struct slice next_name = SLICE_INIT;
     -+	int tab_fd = -1;
     -+	struct reftable_writer *wr = NULL;
     -+	int err = 0;
     ++	int fd = open(dirname, O_DIRECTORY, 0);
     ++	DIR *dir = fdopendir(fd);
     ++	struct dirent *ent = NULL;
      +
     -+	format_name(&next_name,
     -+		    reftable_reader_min_update_index(st->merged->stack[first]),
     -+		    reftable_reader_max_update_index(st->merged->stack[first]));
     ++	assert(fd >= 0);
      +
     -+	slice_set_string(temp_tab, st->reftable_dir);
     -+	slice_addstr(temp_tab, "/");
     -+	slice_addbuf(temp_tab, next_name);
     -+	slice_addstr(temp_tab, ".temp.XXXXXX");
     ++	while ((ent = readdir(dir)) != NULL) {
     ++		unlinkat(fd, ent->d_name, 0);
     ++	}
     ++	closedir(dir);
     ++	rmdir(dirname);
     ++}
      +
     -+	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
     -+	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
     ++static void test_read_file(void)
     ++{
     ++	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
     ++	int fd = mkstemp(fn);
     ++	char out[1024] = "line1\n\nline2\nline3";
     ++	int n, err;
     ++	char **names = NULL;
     ++	char *want[] = { "line1", "line2", "line3" };
     ++	int i = 0;
      +
     -+	err = stack_write_compact(st, wr, first, last, config);
     -+	if (err < 0)
     -+		goto done;
     -+	err = reftable_writer_close(wr);
     -+	if (err < 0)
     -+		goto done;
     ++	assert(fd > 0);
     ++	n = write(fd, out, strlen(out));
     ++	assert(n == strlen(out));
     ++	err = close(fd);
     ++	assert(err >= 0);
      +
     -+	err = close(tab_fd);
     -+	tab_fd = 0;
     ++	err = read_lines(fn, &names);
     ++	assert_err(err);
      +
     -+done:
     -+	reftable_writer_free(wr);
     -+	if (tab_fd > 0) {
     -+		close(tab_fd);
     -+		tab_fd = 0;
     ++	for (i = 0; names[i] != NULL; i++) {
     ++		assert(0 == strcmp(want[i], names[i]));
      +	}
     -+	if (err != 0 && temp_tab->len > 0) {
     -+		unlink(slice_as_string(temp_tab));
     -+		slice_release(temp_tab);
     -+	}
     -+	slice_release(&next_name);
     -+	return err;
     ++	free_names(names);
     ++	remove(fn);
      +}
      +
     -+int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     -+			int first, int last,
     -+			struct reftable_log_expiry_config *config)
     ++static void test_parse_names(void)
      +{
     -+	int subtabs_len = last - first + 1;
     -+	struct reftable_reader **subtabs = reftable_calloc(
     -+		sizeof(struct reftable_reader *) * (last - first + 1));
     -+	struct reftable_merged_table *mt = NULL;
     -+	int err = 0;
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     ++	char buf[] = "line\n";
     ++	char **names = NULL;
     ++	parse_names(buf, strlen(buf), &names);
      +
     -+	uint64_t entries = 0;
     ++	assert(NULL != names[0]);
     ++	assert(0 == strcmp(names[0], "line"));
     ++	assert(NULL == names[1]);
     ++	free_names(names);
     ++}
      +
     -+	int i = 0, j = 0;
     -+	for (i = first, j = 0; i <= last; i++) {
     -+		struct reftable_reader *t = st->merged->stack[i];
     -+		subtabs[j++] = t;
     -+		st->stats.bytes += t->size;
     -+	}
     -+	reftable_writer_set_limits(wr,
     -+				   st->merged->stack[first]->min_update_index,
     -+				   st->merged->stack[last]->max_update_index);
     ++static void test_names_equal(void)
     ++{
     ++	char *a[] = { "a", "b", "c", NULL };
     ++	char *b[] = { "a", "b", "d", NULL };
     ++	char *c[] = { "a", "b", NULL };
      +
     -+	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
     -+					st->config.hash_id);
     -+	if (err < 0) {
     -+		reftable_free(subtabs);
     -+		goto done;
     -+	}
     ++	assert(names_equal(a, a));
     ++	assert(!names_equal(a, b));
     ++	assert(!names_equal(a, c));
     ++}
      +
     -+	err = reftable_merged_table_seek_ref(mt, &it, "");
     -+	if (err < 0)
     -+		goto done;
     ++static int write_test_ref(struct reftable_writer *wr, void *arg)
     ++{
     ++	struct reftable_ref_record *ref = arg;
     ++	reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
     ++	return reftable_writer_add_ref(wr, ref);
     ++}
      +
     -+	while (true) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			err = 0;
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			break;
     -+		}
     -+		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
     -+			continue;
     -+		}
     ++struct write_log_arg {
     ++	struct reftable_log_record *log;
     ++	uint64_t update_index;
     ++};
      +
     -+		err = reftable_writer_add_ref(wr, &ref);
     -+		if (err < 0) {
     -+			break;
     -+		}
     -+		entries++;
     -+	}
     -+	reftable_iterator_destroy(&it);
     ++static int write_test_log(struct reftable_writer *wr, void *arg)
     ++{
     ++	struct write_log_arg *wla = arg;
      +
     -+	err = reftable_merged_table_seek_log(mt, &it, "");
     -+	if (err < 0)
     -+		goto done;
     ++	reftable_writer_set_limits(wr, wla->update_index, wla->update_index);
     ++	return reftable_writer_add_log(wr, wla->log);
     ++}
      +
     -+	while (true) {
     -+		err = reftable_iterator_next_log(&it, &log);
     -+		if (err > 0) {
     -+			err = 0;
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			break;
     -+		}
     -+		if (first == 0 && reftable_log_record_is_deletion(&log)) {
     -+			continue;
     -+		}
     ++static void test_reftable_stack_add_one(void)
     ++{
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	struct reftable_ref_record ref = {
     ++		.ref_name = "HEAD",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	struct reftable_ref_record dest = { 0 };
      +
     -+		if (config != NULL && config->time > 0 &&
     -+		    log.time < config->time) {
     -+			continue;
     -+		}
     ++	assert(mkdtemp(dir));
      +
     -+		if (config != NULL && config->min_update_index > 0 &&
     -+		    log.update_index < config->min_update_index) {
     -+			continue;
     -+		}
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
      +
     -+		err = reftable_writer_add_log(wr, &log);
     -+		if (err < 0) {
     -+			break;
     -+		}
     -+		entries++;
     -+	}
     ++	err = reftable_stack_add(st, &write_test_ref, &ref);
     ++	assert_err(err);
      +
     -+done:
     -+	reftable_iterator_destroy(&it);
     -+	if (mt != NULL) {
     -+		merged_table_clear(mt);
     -+		reftable_merged_table_free(mt);
     -+	}
     -+	reftable_ref_record_clear(&ref);
     -+	reftable_log_record_clear(&log);
     -+	st->stats.entries_written += entries;
     -+	return err;
     ++	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
     ++	assert_err(err);
     ++	assert(0 == strcmp("master", dest.target));
     ++
     ++	reftable_ref_record_clear(&dest);
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
      +}
      +
     -+/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
     -+static int stack_compact_range(struct reftable_stack *st, int first, int last,
     -+			       struct reftable_log_expiry_config *expiry)
     ++static void test_reftable_stack_uptodate(void)
      +{
     -+	struct slice temp_tab_file_name = SLICE_INIT;
     -+	struct slice new_table_name = SLICE_INIT;
     -+	struct slice lock_file_name = SLICE_INIT;
     -+	struct slice ref_list_contents = SLICE_INIT;
     -+	struct slice new_table_path = SLICE_INIT;
     -+	int err = 0;
     -+	bool have_lock = false;
     -+	int lock_file_fd = 0;
     -+	int compact_count = last - first + 1;
     -+	char **listp = NULL;
     -+	char **delete_on_success =
     -+		reftable_calloc(sizeof(char *) * (compact_count + 1));
     -+	char **subtable_locks =
     -+		reftable_calloc(sizeof(char *) * (compact_count + 1));
     -+	int i = 0;
     -+	int j = 0;
     -+	bool is_empty_table = false;
     -+
     -+	if (first > last || (expiry == NULL && first == last)) {
     -+		err = 0;
     -+		goto done;
     -+	}
     -+
     -+	st->stats.attempts++;
     -+
     -+	slice_set_string(&lock_file_name, st->list_file);
     -+	slice_addstr(&lock_file_name, ".lock");
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st1 = NULL;
     ++	struct reftable_stack *st2 = NULL;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	int err;
     ++	struct reftable_ref_record ref1 = {
     ++		.ref_name = "HEAD",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	struct reftable_ref_record ref2 = {
     ++		.ref_name = "branch2",
     ++		.update_index = 2,
     ++		.target = "master",
     ++	};
      +
     -+	lock_file_fd = open(slice_as_string(&lock_file_name),
     -+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     -+	if (lock_file_fd < 0) {
     -+		if (errno == EEXIST) {
     -+			err = 1;
     -+		} else {
     -+			err = REFTABLE_IO_ERROR;
     -+		}
     -+		goto done;
     -+	}
     -+	/* Don't want to write to the lock for now.  */
     -+	close(lock_file_fd);
     -+	lock_file_fd = 0;
     ++	assert(mkdtemp(dir));
      +
     -+	have_lock = true;
     -+	err = stack_uptodate(st);
     -+	if (err != 0)
     -+		goto done;
     ++	err = reftable_new_stack(&st1, dir, cfg);
     ++	assert_err(err);
      +
     -+	for (i = first, j = 0; i <= last; i++) {
     -+		struct slice subtab_file_name = SLICE_INIT;
     -+		struct slice subtab_lock = SLICE_INIT;
     -+		int sublock_file_fd = -1;
     ++	err = reftable_new_stack(&st2, dir, cfg);
     ++	assert_err(err);
      +
     -+		slice_set_string(&subtab_file_name, st->reftable_dir);
     -+		slice_addstr(&subtab_file_name, "/");
     -+		slice_addstr(&subtab_file_name,
     -+			     reader_name(st->merged->stack[i]));
     ++	err = reftable_stack_add(st1, &write_test_ref, &ref1);
     ++	assert_err(err);
      +
     -+		slice_copy(&subtab_lock, subtab_file_name);
     -+		slice_addstr(&subtab_lock, ".lock");
     ++	err = reftable_stack_add(st2, &write_test_ref, &ref2);
     ++	assert(err == REFTABLE_LOCK_ERROR);
      +
     -+		sublock_file_fd = open(slice_as_string(&subtab_lock),
     -+				       O_EXCL | O_CREAT | O_WRONLY, 0644);
     -+		if (sublock_file_fd > 0) {
     -+			close(sublock_file_fd);
     -+		} else if (sublock_file_fd < 0) {
     -+			if (errno == EEXIST) {
     -+				err = 1;
     -+			} else {
     -+				err = REFTABLE_IO_ERROR;
     -+			}
     -+		}
     ++	err = reftable_stack_reload(st2);
     ++	assert_err(err);
      +
     -+		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
     -+		delete_on_success[j] =
     -+			(char *)slice_as_string(&subtab_file_name);
     -+		j++;
     ++	err = reftable_stack_add(st2, &write_test_ref, &ref2);
     ++	assert_err(err);
     ++	reftable_stack_destroy(st1);
     ++	reftable_stack_destroy(st2);
     ++	clear_dir(dir);
     ++}
      +
     -+		if (err != 0)
     -+			goto done;
     -+	}
     ++static void test_reftable_stack_transaction_api(void)
     ++{
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	struct reftable_addition *add = NULL;
      +
     -+	err = unlink(slice_as_string(&lock_file_name));
     -+	if (err < 0)
     -+		goto done;
     -+	have_lock = false;
     ++	struct reftable_ref_record ref = {
     ++		.ref_name = "HEAD",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	struct reftable_ref_record dest = { 0 };
      +
     -+	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
     -+				   expiry);
     -+	/* Compaction + tombstones can create an empty table out of non-empty
     -+	 * tables. */
     -+	is_empty_table = (err == REFTABLE_EMPTY_TABLE_ERROR);
     -+	if (is_empty_table) {
     -+		err = 0;
     -+	}
     -+	if (err < 0)
     -+		goto done;
     ++	assert(mkdtemp(dir));
      +
     -+	lock_file_fd = open(slice_as_string(&lock_file_name),
     -+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     -+	if (lock_file_fd < 0) {
     -+		if (errno == EEXIST) {
     -+			err = 1;
     -+		} else {
     -+			err = REFTABLE_IO_ERROR;
     -+		}
     -+		goto done;
     -+	}
     -+	have_lock = true;
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
      +
     -+	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
     -+		    st->merged->stack[last]->max_update_index);
     -+	slice_addstr(&new_table_name, ".ref");
     ++	reftable_addition_destroy(add);
      +
     -+	slice_set_string(&new_table_path, st->reftable_dir);
     -+	slice_addstr(&new_table_path, "/");
     ++	err = reftable_stack_new_addition(&add, st);
     ++	assert_err(err);
      +
     -+	slice_addbuf(&new_table_path, new_table_name);
     ++	err = reftable_addition_add(add, &write_test_ref, &ref);
     ++	assert_err(err);
      +
     -+	if (!is_empty_table) {
     -+		err = rename(slice_as_string(&temp_tab_file_name),
     -+			     slice_as_string(&new_table_path));
     -+		if (err < 0) {
     -+			err = REFTABLE_IO_ERROR;
     -+			goto done;
     -+		}
     -+	}
     ++	err = reftable_addition_commit(add);
     ++	assert_err(err);
      +
     -+	for (i = 0; i < first; i++) {
     -+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     -+		slice_addstr(&ref_list_contents, "\n");
     -+	}
     -+	if (!is_empty_table) {
     -+		slice_addbuf(&ref_list_contents, new_table_name);
     -+		slice_addstr(&ref_list_contents, "\n");
     -+	}
     -+	for (i = last + 1; i < st->merged->stack_len; i++) {
     -+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     -+		slice_addstr(&ref_list_contents, "\n");
     -+	}
     ++	reftable_addition_destroy(add);
      +
     -+	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     -+		goto done;
     -+	}
     -+	err = close(lock_file_fd);
     -+	lock_file_fd = 0;
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     -+		goto done;
     -+	}
     ++	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
     ++	assert_err(err);
     ++	assert(0 == strcmp("master", dest.target));
      +
     -+	err = rename(slice_as_string(&lock_file_name), st->list_file);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     -+		goto done;
     -+	}
     -+	have_lock = false;
     ++	reftable_ref_record_clear(&dest);
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
     ++}
      +
     -+	/* Reload the stack before deleting. On windows, we can only delete the
     -+	   files after we closed them.
     -+	*/
     -+	err = reftable_stack_reload_maybe_reuse(st, first < last);
     ++static void test_reftable_stack_validate_refname(void)
     ++{
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	int i;
     ++	struct reftable_ref_record ref = {
     ++		.ref_name = "a/b",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	char *additions[] = { "a", "a/b/c" };
      +
     -+	listp = delete_on_success;
     -+	while (*listp) {
     -+		if (strcmp(*listp, slice_as_string(&new_table_path))) {
     -+			unlink(*listp);
     -+		}
     -+		listp++;
     -+	}
     ++	assert(mkdtemp(dir));
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
      +
     -+done:
     -+	free_names(delete_on_success);
     ++	err = reftable_stack_add(st, &write_test_ref, &ref);
     ++	assert_err(err);
      +
     -+	listp = subtable_locks;
     -+	while (*listp) {
     -+		unlink(*listp);
     -+		listp++;
     -+	}
     -+	free_names(subtable_locks);
     -+	if (lock_file_fd > 0) {
     -+		close(lock_file_fd);
     -+		lock_file_fd = 0;
     -+	}
     -+	if (have_lock) {
     -+		unlink(slice_as_string(&lock_file_name));
     ++	for (i = 0; i < ARRAY_SIZE(additions); i++) {
     ++		struct reftable_ref_record ref = {
     ++			.ref_name = additions[i],
     ++			.update_index = 1,
     ++			.target = "master",
     ++		};
     ++
     ++		err = reftable_stack_add(st, &write_test_ref, &ref);
     ++		assert(err == REFTABLE_NAME_CONFLICT);
      +	}
     -+	slice_release(&new_table_name);
     -+	slice_release(&new_table_path);
     -+	slice_release(&ref_list_contents);
     -+	slice_release(&temp_tab_file_name);
     -+	slice_release(&lock_file_name);
     -+	return err;
     -+}
      +
     -+int reftable_stack_compact_all(struct reftable_stack *st,
     -+			       struct reftable_log_expiry_config *config)
     -+{
     -+	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
      +}
      +
     -+static int stack_compact_range_stats(struct reftable_stack *st, int first,
     -+				     int last,
     -+				     struct reftable_log_expiry_config *config)
     ++static int write_error(struct reftable_writer *wr, void *arg)
      +{
     -+	int err = stack_compact_range(st, first, last, config);
     -+	if (err > 0) {
     -+		st->stats.failures++;
     -+	}
     -+	return err;
     ++	return *((int *)arg);
      +}
      +
     -+static int segment_size(struct segment *s)
     ++static void test_reftable_stack_update_index_check(void)
      +{
     -+	return s->end - s->start;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	struct reftable_ref_record ref1 = {
     ++		.ref_name = "name1",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	struct reftable_ref_record ref2 = {
     ++		.ref_name = "name2",
     ++		.update_index = 1,
     ++		.target = "master",
     ++	};
     ++	assert(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++
     ++	err = reftable_stack_add(st, &write_test_ref, &ref1);
     ++	assert_err(err);
     ++
     ++	err = reftable_stack_add(st, &write_test_ref, &ref2);
     ++	assert(err == REFTABLE_API_ERROR);
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
      +}
      +
     -+int fastlog2(uint64_t sz)
     ++static void test_reftable_stack_lock_failure(void)
      +{
     -+	int l = 0;
     -+	if (sz == 0)
     -+		return 0;
     -+	for (; sz; sz /= 2) {
     -+		l++;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err, i;
     ++	assert(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
     ++		err = reftable_stack_add(st, &write_error, &i);
     ++		assert(err == i);
      +	}
     -+	return l - 1;
     ++
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
      +}
      +
     -+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
     ++static void test_reftable_stack_add(void)
      +{
     -+	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
     -+	int next = 0;
     -+	struct segment cur = { 0 };
      +	int i = 0;
     ++	int err = 0;
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_ref_record refs[2] = { 0 };
     ++	struct reftable_log_record logs[2] = { 0 };
     ++	int N = ARRAY_SIZE(refs);
     ++
     ++	assert(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++	st->disable_auto_compact = true;
     ++
     ++	for (i = 0; i < N; i++) {
     ++		char buf[256];
     ++		snprintf(buf, sizeof(buf), "branch%02d", i);
     ++		refs[i].ref_name = xstrdup(buf);
     ++		refs[i].value = reftable_malloc(SHA1_SIZE);
     ++		refs[i].update_index = i + 1;
     ++		set_test_hash(refs[i].value, i);
     ++
     ++		logs[i].ref_name = xstrdup(buf);
     ++		logs[i].update_index = N + i + 1;
     ++		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].new_hash, i);
     ++	}
     ++
     ++	for (i = 0; i < N; i++) {
     ++		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
     ++		assert_err(err);
     ++	}
     ++
     ++	for (i = 0; i < N; i++) {
     ++		struct write_log_arg arg = {
     ++			.log = &logs[i],
     ++			.update_index = reftable_stack_next_update_index(st),
     ++		};
     ++		int err = reftable_stack_add(st, &write_test_log, &arg);
     ++		assert_err(err);
     ++	}
      +
     -+	if (n == 0) {
     -+		*seglen = 0;
     -+		return segs;
     ++	err = reftable_stack_compact_all(st, NULL);
     ++	assert_err(err);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		struct reftable_ref_record dest = { 0 };
     ++		int err = reftable_stack_read_ref(st, refs[i].ref_name, &dest);
     ++		assert_err(err);
     ++		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
     ++		reftable_ref_record_clear(&dest);
      +	}
     -+	for (i = 0; i < n; i++) {
     -+		int log = fastlog2(sizes[i]);
     -+		if (cur.log != log && cur.bytes > 0) {
     -+			struct segment fresh = {
     -+				.start = i,
     -+			};
      +
     -+			segs[next++] = cur;
     -+			cur = fresh;
     -+		}
     ++	for (i = 0; i < N; i++) {
     ++		struct reftable_log_record dest = { 0 };
     ++		int err = reftable_stack_read_log(st, refs[i].ref_name, &dest);
     ++		assert_err(err);
     ++		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
     ++		reftable_log_record_clear(&dest);
     ++	}
      +
     -+		cur.log = log;
     -+		cur.end = i + 1;
     -+		cur.bytes += sizes[i];
     ++	/* cleanup */
     ++	reftable_stack_destroy(st);
     ++	for (i = 0; i < N; i++) {
     ++		reftable_ref_record_clear(&refs[i]);
     ++		reftable_log_record_clear(&logs[i]);
      +	}
     -+	segs[next++] = cur;
     -+	*seglen = next;
     -+	return segs;
     ++	clear_dir(dir);
      +}
      +
     -+struct segment suggest_compaction_segment(uint64_t *sizes, int n)
     ++static void test_reftable_stack_tombstone(void)
      +{
     -+	int seglen = 0;
     -+	struct segment *segs = sizes_to_segments(&seglen, sizes, n);
     -+	struct segment min_seg = {
     -+		.log = 64,
     -+	};
      +	int i = 0;
     -+	for (i = 0; i < seglen; i++) {
     -+		if (segment_size(&segs[i]) == 1) {
     -+			continue;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	struct reftable_ref_record refs[2] = { 0 };
     ++	struct reftable_log_record logs[2] = { 0 };
     ++	int N = ARRAY_SIZE(refs);
     ++	struct reftable_ref_record dest = { 0 };
     ++	struct reftable_log_record log_dest = { 0 };
     ++
     ++	assert(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		const char *buf = "branch";
     ++		refs[i].ref_name = xstrdup(buf);
     ++		refs[i].update_index = i + 1;
     ++		if (i % 2 == 0) {
     ++			refs[i].value = reftable_malloc(SHA1_SIZE);
     ++			set_test_hash(refs[i].value, i);
      +		}
     -+
     -+		if (segs[i].log < min_seg.log) {
     -+			min_seg = segs[i];
     ++		logs[i].ref_name = xstrdup(buf);
     ++		/* update_index is part of the key. */
     ++		logs[i].update_index = 42;
     ++		if (i % 2 == 0) {
     ++			logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     ++			set_test_hash(logs[i].new_hash, i);
     ++			logs[i].email = xstrdup("identity@invalid");
      +		}
      +	}
     ++	for (i = 0; i < N; i++) {
     ++		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
     ++		assert_err(err);
     ++	}
     ++	for (i = 0; i < N; i++) {
     ++		struct write_log_arg arg = {
     ++			.log = &logs[i],
     ++			.update_index = reftable_stack_next_update_index(st),
     ++		};
     ++		int err = reftable_stack_add(st, &write_test_log, &arg);
     ++		assert_err(err);
     ++	}
      +
     -+	while (min_seg.start > 0) {
     -+		int prev = min_seg.start - 1;
     -+		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev])) {
     -+			break;
     -+		}
     ++	err = reftable_stack_read_ref(st, "branch", &dest);
     ++	assert(err == 1);
     ++	reftable_ref_record_clear(&dest);
      +
     -+		min_seg.start = prev;
     -+		min_seg.bytes += sizes[prev];
     -+	}
     ++	err = reftable_stack_read_log(st, "branch", &log_dest);
     ++	assert(err == 1);
     ++	reftable_log_record_clear(&log_dest);
      +
     -+	reftable_free(segs);
     -+	return min_seg;
     -+}
     ++	err = reftable_stack_compact_all(st, NULL);
     ++	assert_err(err);
      +
     -+static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
     -+{
     -+	uint64_t *sizes =
     -+		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
     -+	int version = (st->config.hash_id == SHA1_ID) ? 1 : 2;
     -+	int overhead = header_size(version) - 1;
     -+	int i = 0;
     -+	for (i = 0; i < st->merged->stack_len; i++) {
     -+		sizes[i] = st->merged->stack[i]->size - overhead;
     ++	err = reftable_stack_read_ref(st, "branch", &dest);
     ++	assert(err == 1);
     ++
     ++	err = reftable_stack_read_log(st, "branch", &log_dest);
     ++	assert(err == 1);
     ++	reftable_ref_record_clear(&dest);
     ++	reftable_log_record_clear(&log_dest);
     ++
     ++	/* cleanup */
     ++	reftable_stack_destroy(st);
     ++	for (i = 0; i < N; i++) {
     ++		reftable_ref_record_clear(&refs[i]);
     ++		reftable_log_record_clear(&logs[i]);
      +	}
     -+	return sizes;
     ++	clear_dir(dir);
      +}
      +
     -+int reftable_stack_auto_compact(struct reftable_stack *st)
     ++static void test_reftable_stack_hash_id(void)
      +{
     -+	uint64_t *sizes = stack_table_sizes_for_compaction(st);
     -+	struct segment seg =
     -+		suggest_compaction_segment(sizes, st->merged->stack_len);
     -+	reftable_free(sizes);
     -+	if (segment_size(&seg) > 0)
     -+		return stack_compact_range_stats(st, seg.start, seg.end - 1,
     -+						 NULL);
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++
     ++	struct reftable_ref_record ref = {
     ++		.ref_name = "master",
     ++		.target = "target",
     ++		.update_index = 1,
     ++	};
     ++	struct reftable_write_options cfg32 = { .hash_id = SHA256_ID };
     ++	struct reftable_stack *st32 = NULL;
     ++	struct reftable_write_options cfg_default = { 0 };
     ++	struct reftable_stack *st_default = NULL;
     ++	struct reftable_ref_record dest = { 0 };
     ++
     ++	assert(mkdtemp(dir));
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++
     ++	err = reftable_stack_add(st, &write_test_ref, &ref);
     ++	assert_err(err);
     ++
     ++	/* can't read it with the wrong hash ID. */
     ++	err = reftable_new_stack(&st32, dir, cfg32);
     ++	assert(err == REFTABLE_FORMAT_ERROR);
     ++
     ++	/* check that we can read it back with default config too. */
     ++	err = reftable_new_stack(&st_default, dir, cfg_default);
     ++	assert_err(err);
     ++
     ++	err = reftable_stack_read_ref(st_default, "master", &dest);
     ++	assert_err(err);
     ++
     ++	assert(!strcmp(dest.target, ref.target));
     ++	reftable_ref_record_clear(&dest);
     ++	reftable_stack_destroy(st);
     ++	reftable_stack_destroy(st_default);
     ++	clear_dir(dir);
     ++}
      +
     -+	return 0;
     ++static void test_log2(void)
     ++{
     ++	assert(1 == fastlog2(3));
     ++	assert(2 == fastlog2(4));
     ++	assert(2 == fastlog2(5));
      +}
      +
     -+struct reftable_compaction_stats *
     -+reftable_stack_compaction_stats(struct reftable_stack *st)
     ++static void test_sizes_to_segments(void)
      +{
     -+	return &st->stats;
     ++	uint64_t sizes[] = { 2, 3, 4, 5, 7, 9 };
     ++	/* .................0  1  2  3  4  5 */
     ++
     ++	int seglen = 0;
     ++	struct segment *segs =
     ++		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     ++	assert(segs[2].log == 3);
     ++	assert(segs[2].start == 5);
     ++	assert(segs[2].end == 6);
     ++
     ++	assert(segs[1].log == 2);
     ++	assert(segs[1].start == 2);
     ++	assert(segs[1].end == 5);
     ++	reftable_free(segs);
      +}
      +
     -+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     -+			    struct reftable_ref_record *ref)
     ++static void test_sizes_to_segments_empty(void)
      +{
     -+	struct reftable_table tab = { NULL };
     -+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     -+	return reftable_table_read_ref(&tab, refname, ref);
     ++	uint64_t sizes[0];
     ++
     ++	int seglen = 0;
     ++	struct segment *segs =
     ++		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     ++	assert(seglen == 0);
     ++	reftable_free(segs);
      +}
      +
     -+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     -+			    struct reftable_log_record *log)
     ++static void test_sizes_to_segments_all_equal(void)
      +{
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     -+	int err = reftable_merged_table_seek_log(mt, &it, refname);
     -+	if (err)
     -+		goto done;
     ++	uint64_t sizes[] = { 5, 5 };
      +
     -+	err = reftable_iterator_next_log(&it, log);
     -+	if (err)
     -+		goto done;
     ++	int seglen = 0;
     ++	struct segment *segs =
     ++		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     ++	assert(seglen == 1);
     ++	assert(segs[0].start == 0);
     ++	assert(segs[0].end == 2);
     ++	reftable_free(segs);
     ++}
      +
     -+	if (strcmp(log->ref_name, refname) ||
     -+	    reftable_log_record_is_deletion(log)) {
     -+		err = 1;
     -+		goto done;
     -+	}
     ++static void test_suggest_compaction_segment(void)
     ++{
     ++	uint64_t sizes[] = { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
     ++	/* .................0    1    2  3   4  5  6 */
     ++	struct segment min =
     ++		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
     ++	assert(min.start == 2);
     ++	assert(min.end == 7);
     ++}
      +
     -+done:
     -+	if (err) {
     -+		reftable_log_record_clear(log);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	return err;
     ++static void test_suggest_compaction_segment_nothing(void)
     ++{
     ++	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
     ++	struct segment result =
     ++		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
     ++	assert(result.start == result.end);
      +}
      +
     -+int stack_check_addition(struct reftable_stack *st, const char *new_tab_name)
     ++static void test_reflog_expire(void)
      +{
     -+	int err = 0;
     -+	struct reftable_block_source src = { 0 };
     -+	struct reftable_reader *rd = NULL;
     -+	struct reftable_table tab = { NULL };
     -+	struct reftable_ref_record *refs = NULL;
     -+	struct reftable_iterator it = { NULL };
     -+	int cap = 0;
     -+	int len = 0;
     ++	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	struct reftable_log_record logs[20] = { 0 };
     ++	int N = ARRAY_SIZE(logs) - 1;
      +	int i = 0;
     ++	int err;
     ++	struct reftable_log_expiry_config expiry = {
     ++		.time = 10,
     ++	};
     ++	struct reftable_log_record log = { 0 };
      +
     -+	if (st->config.skip_name_check)
     -+		return 0;
     ++	assert(mkdtemp(dir));
      +
     -+	err = reftable_block_source_from_file(&src, new_tab_name);
     -+	if (err < 0)
     -+		goto done;
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
      +
     -+	err = reftable_new_reader(&rd, &src, new_tab_name);
     -+	if (err < 0)
     -+		goto done;
     ++	for (i = 1; i <= N; i++) {
     ++		char buf[256];
     ++		snprintf(buf, sizeof(buf), "branch%02d", i);
      +
     -+	err = reftable_reader_seek_ref(rd, &it, "");
     -+	if (err > 0) {
     -+		err = 0;
     -+		goto done;
     ++		logs[i].ref_name = xstrdup(buf);
     ++		logs[i].update_index = i;
     ++		logs[i].time = i;
     ++		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].new_hash, i);
      +	}
     -+	if (err < 0)
     -+		goto done;
      +
     -+	while (true) {
     -+		struct reftable_ref_record ref = { 0 };
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0)
     -+			goto done;
     ++	for (i = 1; i <= N; i++) {
     ++		struct write_log_arg arg = {
     ++			.log = &logs[i],
     ++			.update_index = reftable_stack_next_update_index(st),
     ++		};
     ++		int err = reftable_stack_add(st, &write_test_log, &arg);
     ++		assert_err(err);
     ++	}
      +
     -+		if (len >= cap) {
     -+			cap = 2 * cap + 1;
     -+			refs = reftable_realloc(refs, cap * sizeof(refs[0]));
     -+		}
     ++	err = reftable_stack_compact_all(st, NULL);
     ++	assert_err(err);
      +
     -+		refs[len++] = ref;
     -+	}
     ++	err = reftable_stack_compact_all(st, &expiry);
     ++	assert_err(err);
      +
     -+	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
     ++	err = reftable_stack_read_log(st, logs[9].ref_name, &log);
     ++	assert(err == 1);
      +
     -+	err = validate_ref_record_addition(tab, refs, len);
     ++	err = reftable_stack_read_log(st, logs[11].ref_name, &log);
     ++	assert_err(err);
      +
     -+done:
     -+	for (i = 0; i < len; i++) {
     -+		reftable_ref_record_clear(&refs[i]);
     -+	}
     ++	expiry.min_update_index = 15;
     ++	err = reftable_stack_compact_all(st, &expiry);
     ++	assert_err(err);
      +
     -+	free(refs);
     -+	reftable_iterator_destroy(&it);
     -+	reftable_reader_free(rd);
     -+	return err;
     -+}
     -
     - ## reftable/stack.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     ++	err = reftable_stack_read_log(st, logs[14].ref_name, &log);
     ++	assert(err == 1);
      +
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     ++	err = reftable_stack_read_log(st, logs[16].ref_name, &log);
     ++	assert_err(err);
      +
     -+#ifndef STACK_H
     -+#define STACK_H
     ++	/* cleanup */
     ++	reftable_stack_destroy(st);
     ++	for (i = 0; i <= N; i++) {
     ++		reftable_log_record_clear(&logs[i]);
     ++	}
     ++	clear_dir(dir);
     ++	reftable_log_record_clear(&log);
     ++}
      +
     -+#include "reftable.h"
     -+#include "system.h"
     ++static int write_nothing(struct reftable_writer *wr, void *arg)
     ++{
     ++	reftable_writer_set_limits(wr, 1, 1);
     ++	return 0;
     ++}
      +
     -+struct reftable_stack {
     -+	char *list_file;
     -+	char *reftable_dir;
     -+	bool disable_auto_compact;
     ++static void test_empty_add(void)
     ++{
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	int err;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	struct reftable_stack *st2 = NULL;
      +
     -+	struct reftable_write_options config;
     ++	assert(mkdtemp(dir));
      +
     -+	struct reftable_merged_table *merged;
     -+	struct reftable_compaction_stats stats;
     -+};
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
      +
     -+int read_lines(const char *filename, char ***lines);
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
     -+				      bool reuse_open);
     ++	err = reftable_stack_add(st, &write_nothing, NULL);
     ++	assert_err(err);
      +
     -+struct segment {
     -+	int start, end;
     -+	int log;
     -+	uint64_t bytes;
     -+};
     ++	err = reftable_new_stack(&st2, dir, cfg);
     ++	assert_err(err);
     ++	clear_dir(dir);
     ++	reftable_stack_destroy(st);
     ++	reftable_stack_destroy(st2);
     ++}
      +
     -+struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n);
     -+struct segment suggest_compaction_segment(uint64_t *sizes, int n);
     ++static void test_reftable_stack_auto_compaction(void)
     ++{
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st = NULL;
     ++	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	int err, i;
     ++	int N = 100;
     ++	assert(mkdtemp(dir));
      +
     -+#endif
     ++	err = reftable_new_stack(&st, dir, cfg);
     ++	assert_err(err);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		char name[100];
     ++		struct reftable_ref_record ref = {
     ++			.ref_name = name,
     ++			.update_index = reftable_stack_next_update_index(st),
     ++			.target = "master",
     ++		};
     ++		snprintf(name, sizeof(name), "branch%04d", i);
     ++
     ++		err = reftable_stack_add(st, &write_test_ref, &ref);
     ++		assert_err(err);
     ++
     ++		assert(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
     ++	}
     ++
     ++	assert(reftable_stack_compaction_stats(st)->entries_written <
     ++	       (uint64_t)(N * fastlog2(N)));
     ++
     ++	reftable_stack_destroy(st);
     ++	clear_dir(dir);
     ++}
     ++
     ++int stack_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_reftable_stack_uptodate",
     ++		      &test_reftable_stack_uptodate);
     ++	add_test_case("test_reftable_stack_transaction_api",
     ++		      &test_reftable_stack_transaction_api);
     ++	add_test_case("test_reftable_stack_hash_id",
     ++		      &test_reftable_stack_hash_id);
     ++	add_test_case("test_sizes_to_segments_all_equal",
     ++		      &test_sizes_to_segments_all_equal);
     ++	add_test_case("test_reftable_stack_auto_compaction",
     ++		      &test_reftable_stack_auto_compaction);
     ++	add_test_case("test_reftable_stack_validate_refname",
     ++		      &test_reftable_stack_validate_refname);
     ++	add_test_case("test_reftable_stack_update_index_check",
     ++		      &test_reftable_stack_update_index_check);
     ++	add_test_case("test_reftable_stack_lock_failure",
     ++		      &test_reftable_stack_lock_failure);
     ++	add_test_case("test_reftable_stack_tombstone",
     ++		      &test_reftable_stack_tombstone);
     ++	add_test_case("test_reftable_stack_add_one",
     ++		      &test_reftable_stack_add_one);
     ++	add_test_case("test_empty_add", test_empty_add);
     ++	add_test_case("test_reflog_expire", test_reflog_expire);
     ++	add_test_case("test_suggest_compaction_segment",
     ++		      &test_suggest_compaction_segment);
     ++	add_test_case("test_suggest_compaction_segment_nothing",
     ++		      &test_suggest_compaction_segment_nothing);
     ++	add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
     ++	add_test_case("test_sizes_to_segments_empty",
     ++		      &test_sizes_to_segments_empty);
     ++	add_test_case("test_log2", &test_log2);
     ++	add_test_case("test_parse_names", &test_parse_names);
     ++	add_test_case("test_read_file", &test_read_file);
     ++	add_test_case("test_names_equal", &test_names_equal);
     ++	add_test_case("test_reftable_stack_add", &test_reftable_stack_add);
     ++	return test_main(argc, argv);
     ++}
      
       ## reftable/system.h (new) ##
      @@
     @@ reftable/system.h (new)
      +			       const Bytef *source, uLong *sourceLen);
      +int hash_size(uint32_t id);
      +
     ++#endif
     +
     + ## reftable/test_framework.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "test_framework.h"
     ++
     ++#include "system.h"
     ++#include "basics.h"
     ++#include "constants.h"
     ++
     ++struct test_case **test_cases;
     ++int test_case_len;
     ++int test_case_cap;
     ++
     ++struct test_case *new_test_case(const char *name, void (*testfunc)(void))
     ++{
     ++	struct test_case *tc = reftable_malloc(sizeof(struct test_case));
     ++	tc->name = name;
     ++	tc->testfunc = testfunc;
     ++	return tc;
     ++}
     ++
     ++struct test_case *add_test_case(const char *name, void (*testfunc)(void))
     ++{
     ++	struct test_case *tc = new_test_case(name, testfunc);
     ++	if (test_case_len == test_case_cap) {
     ++		test_case_cap = 2 * test_case_cap + 1;
     ++		test_cases = reftable_realloc(
     ++			test_cases, sizeof(struct test_case) * test_case_cap);
     ++	}
     ++
     ++	test_cases[test_case_len++] = tc;
     ++	return tc;
     ++}
     ++
     ++int test_main(int argc, const char *argv[])
     ++{
     ++	const char *filter = NULL;
     ++	int i = 0;
     ++	if (argc > 1) {
     ++		filter = argv[1];
     ++	}
     ++
     ++	for (i = 0; i < test_case_len; i++) {
     ++		const char *name = test_cases[i]->name;
     ++		if (filter == NULL || strstr(name, filter) != NULL) {
     ++			printf("case %s\n", name);
     ++			test_cases[i]->testfunc();
     ++		} else {
     ++			printf("skip %s\n", name);
     ++		}
     ++
     ++		reftable_free(test_cases[i]);
     ++	}
     ++	reftable_free(test_cases);
     ++	test_cases = 0;
     ++	test_case_len = 0;
     ++	test_case_cap = 0;
     ++	return 0;
     ++}
     ++
     ++void set_test_hash(byte *p, int i)
     ++{
     ++	memset(p, (byte)i, hash_size(SHA1_ID));
     ++}
     +
     + ## reftable/test_framework.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef TEST_FRAMEWORK_H
     ++#define TEST_FRAMEWORK_H
     ++
     ++#include "system.h"
     ++
     ++#include "reftable.h"
     ++
     ++#ifdef NDEBUG
     ++#undef NDEBUG
     ++#endif
     ++
     ++#include "system.h"
     ++
     ++#ifdef assert
     ++#undef assert
     ++#endif
     ++
     ++#define assert_err(c)                                                  \
     ++	if (c != 0) {                                                  \
     ++		fflush(stderr);                                        \
     ++		fflush(stdout);                                        \
     ++		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
     ++			__FILE__, __LINE__, c, reftable_error_str(c)); \
     ++		abort();                                               \
     ++	}
     ++
     ++#define assert_streq(a, b)                                               \
     ++	if (strcmp(a, b)) {                                              \
     ++		fflush(stderr);                                          \
     ++		fflush(stdout);                                          \
     ++		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
     ++			__LINE__, #a, a, #b, b);                         \
     ++		abort();                                                 \
     ++	}
     ++
     ++#define assert(c)                                                          \
     ++	if (!(c)) {                                                        \
     ++		fflush(stderr);                                            \
     ++		fflush(stdout);                                            \
     ++		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
     ++			__LINE__, #c);                                     \
     ++		abort();                                                   \
     ++	}
     ++
     ++struct test_case {
     ++	const char *name;
     ++	void (*testfunc)(void);
     ++};
     ++
     ++struct test_case *new_test_case(const char *name, void (*testfunc)(void));
     ++struct test_case *add_test_case(const char *name, void (*testfunc)(void));
     ++int test_main(int argc, const char *argv[]);
     ++
     ++void set_test_hash(byte *p, int i);
     ++
      +#endif
      
       ## reftable/tree.c (new) ##
     @@ reftable/tree.h (new)
      +
      +#endif
      
     + ## reftable/tree_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "tree.h"
     ++
     ++#include "basics.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++static int test_compare(const void *a, const void *b)
     ++{
     ++	return (char *)a - (char *)b;
     ++}
     ++
     ++struct curry {
     ++	void *last;
     ++};
     ++
     ++static void check_increasing(void *arg, void *key)
     ++{
     ++	struct curry *c = (struct curry *)arg;
     ++	if (c->last != NULL) {
     ++		assert(test_compare(c->last, key) < 0);
     ++	}
     ++	c->last = key;
     ++}
     ++
     ++static void test_tree(void)
     ++{
     ++	struct tree_node *root = NULL;
     ++
     ++	void *values[11] = { 0 };
     ++	struct tree_node *nodes[11] = { 0 };
     ++	int i = 1;
     ++	struct curry c = { 0 };
     ++	do {
     ++		nodes[i] = tree_search(values + i, &root, &test_compare, 1);
     ++		i = (i * 7) % 11;
     ++	} while (i != 1);
     ++
     ++	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
     ++		assert(values + i == nodes[i]->key);
     ++		assert(nodes[i] ==
     ++		       tree_search(values + i, &root, &test_compare, 0));
     ++	}
     ++
     ++	infix_walk(root, check_increasing, &c);
     ++	tree_free(root);
     ++}
     ++
     ++int tree_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_tree", &test_tree);
     ++	return test_main(argc, argv);
     ++}
     +
       ## reftable/update.sh (new) ##
      @@
      +#!/bin/sh
     @@ reftable/update.sh (new)
      +SRC=${SRC:-origin}
      +BRANCH=${BRANCH:-master}
      +
     -+((git --git-dir reftable-repo/.git fetch ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
     ++((git --git-dir reftable-repo/.git fetch -f ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
      +   git clone https://github.com/google/reftable reftable-repo)
      +
      +cp reftable-repo/c/*.[ch] reftable/
      +cp reftable-repo/c/include/*.[ch] reftable/
      +cp reftable-repo/LICENSE reftable/
     -+git --git-dir reftable-repo/.git show --no-patch HEAD \
     ++
     ++git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
      +  > reftable/VERSION
      +
      +mv reftable/system.h reftable/system.h~
      +sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
      +
     -+# Remove unittests and compatibility hacks we don't need here.  
     -+rm reftable/*_test.c reftable/test_framework.* reftable/compat.*
     ++# Remove compatibility hacks we don't need here.
     ++rm reftable/compat.*
      +
     -+git add reftable/*.[ch] reftable/LICENSE reftable/VERSION 
     ++git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
      
       ## reftable/writer.c (new) ##
      @@
     @@ reftable/writer.c (new)
      +
      +static int obj_index_tree_node_compare(const void *a, const void *b)
      +{
     -+	return slice_cmp(((const struct obj_index_tree_node *)a)->hash,
     -+			 ((const struct obj_index_tree_node *)b)->hash);
     ++	return slice_cmp(&((const struct obj_index_tree_node *)a)->hash,
     ++			 &((const struct obj_index_tree_node *)b)->hash);
      +}
      +
     -+static void writer_index_hash(struct reftable_writer *w, struct slice hash)
     ++static void writer_index_hash(struct reftable_writer *w, struct slice *hash)
      +{
      +	uint64_t off = w->next;
      +
     -+	struct obj_index_tree_node want = { .hash = hash };
     ++	struct obj_index_tree_node want = { .hash = *hash };
      +
      +	struct tree_node *node = tree_search(&want, &w->obj_index_tree,
      +					     &obj_index_tree_node_compare, 0);
     @@ reftable/writer.c (new)
      +	struct slice key = SLICE_INIT;
      +	int err = 0;
      +	reftable_record_key(rec, &key);
     -+	if (slice_cmp(w->last_key, key) >= 0)
     ++	if (slice_cmp(&w->last_key, &key) >= 0)
      +		goto done;
      +
     -+	slice_copy(&w->last_key, key);
     ++	slice_copy(&w->last_key, &key);
      +	if (w->block_writer == NULL) {
      +		writer_reinit_block_writer(w, reftable_record_type(rec));
      +	}
     @@ reftable/writer.c (new)
      +			.canary = SLICE_CANARY,
      +		};
      +
     -+		writer_index_hash(w, h);
     ++		writer_index_hash(w, &h);
      +	}
      +
      +	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
     @@ reftable/writer.c (new)
      +			.len = hash_size(w->opts.hash_id),
      +			.canary = SLICE_CANARY,
      +		};
     -+		writer_index_hash(w, h);
     ++		writer_index_hash(w, &h);
      +	}
      +	return 0;
      +}
     @@ reftable/writer.c (new)
      +	struct common_prefix_arg *arg = (struct common_prefix_arg *)void_arg;
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +	if (arg->last != NULL) {
     -+		int n = common_prefix_size(entry->hash, *arg->last);
     ++		int n = common_prefix_size(&entry->hash, arg->last);
      +		if (n > arg->max) {
      +			arg->max = n;
      +		}
     @@ reftable/writer.c (new)
      +	}
      +
      +	ir.offset = w->next;
     -+	slice_copy(&ir.last_key, w->block_writer->last_key);
     ++	slice_copy(&ir.last_key, &w->block_writer->last_key);
      +	w->index[w->index_len] = ir;
      +
      +	w->index_len++;
 10:  a86c3753717 ! 10:  f3d74b78135 Reftable support for git-core
     @@ builtin/init-db.c: static const char *const init_db_usage[] = {
       int cmd_init_db(int argc, const char **argv, const char *prefix)
       {
       	const char *git_dir;
     -+	const char *ref_storage_format = DEFAULT_REF_STORAGE;
     ++	const char *ref_storage_format = default_ref_storage();
       	const char *real_git_dir = NULL;
       	const char *work_tree;
       	const char *template_dir = NULL;
     @@ refs/reftable-backend.c (new)
      +	QSORT(sorted, transaction->nr, ref_update_cmp);
      +	reftable_writer_set_limits(writer, ts, ts);
      +
     -+
      +	for (i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
      +		struct reftable_log_record *log = &logs[i];
     @@ t/t0031-reftable.sh (new)
      +	grep "commit: number 10" output &&
      +	git gc &&
      +	git reflog refs/heads/master >output &&
     -+	test_line_count = 0 output 
     ++	test_line_count = 0 output
      +'
      +
      +# This matches show-ref's output
     @@ t/t0031-reftable.sh (new)
      +		print_ref "refs/heads/master" &&
      +		print_ref "refs/tags/file" &&
      +		print_ref "refs/tags/test_tag" &&
     -+		print_ref "refs/tags/test_tag^{}" 
     ++		print_ref "refs/tags/test_tag^{}"
      +	} >expect &&
      +	git show-ref -d >actual &&
      +	test_cmp expect actual
  -:  ----------- > 11:  3e7868ee409 Hookup unittests for the reftable library.
 11:  d3613c2ff53 = 12:  1f193b6da23 Add GIT_DEBUG_REFS debugging mechanism
 12:  9b98ed614ec = 13:  0471f7e3570 vcxproj: adjust for the reftable changes
 13:  5e401e4f1ac ! 14:  a03c882b075 Add reftable testing infrastructure
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (real_git_dir)
       		git_dir = real_git_dir;
      
     - ## builtin/init-db.c ##
     -@@ builtin/init-db.c: static const char *const init_db_usage[] = {
     - int cmd_init_db(int argc, const char **argv, const char *prefix)
     - {
     - 	const char *git_dir;
     --	const char *ref_storage_format = DEFAULT_REF_STORAGE;
     -+	const char *ref_storage_format = default_ref_storage();
     - 	const char *real_git_dir = NULL;
     - 	const char *work_tree;
     - 	const char *template_dir = NULL;
     -
       ## refs.c ##
      @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       	r->refs_private = ref_store_init(r->gitdir,

-- 
gitgitgadget
