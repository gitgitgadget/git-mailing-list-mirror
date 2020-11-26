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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C2C63798
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3710E221E9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpnz1mKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404617AbgKZTmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404516AbgKZTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:42:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F958C0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id s13so3479971wmh.4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NcD6CegQzRLrpCRla2CzN40u/lAPRIM+pd6MxqrBdog=;
        b=Fpnz1mKd9Nt3ymbJZaufWgHFgiGrGMTzUPT4H1jlCnU/TvP63a372kri/xFdQW8nvk
         csLTXFSbhD+7rDFKphbIzVw3k1685OjNKi7MQDnP17HhB1mFwCCR90F6V8iK6ZW1Zgur
         EMBt0m8b0O05i8SDJ4tImk8D5XhoxptJ1wffhHTd7WJDrFP9DwUwsx12Pg332EueHL8F
         1DR9lVwPBTkZ5UURyh1UIWjYY8hylYSx/WgfuPXNHv+r5LC1As4b0t2SLkj3aqNviI6/
         bpeVVPmwkV6Dd4v3PpAPmLucM4pTWfrRXJf9sDqa0NKVm/axRj8Fn7OMsNL9ETDYEd+q
         C1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NcD6CegQzRLrpCRla2CzN40u/lAPRIM+pd6MxqrBdog=;
        b=NzRHI23furN1xceu628wOMG/3lpfCF1PbHfE8S3Z+kjCib5YapfP/QkhExctJIddNQ
         8dTQPForH2uHTUHwR2IrKdRD64nBt1nMPAZq+tHZjl3RpGjVQfffk99af+29UtS/y3/8
         MHyvbqoLNKjjslsyeClEl9ouBVjqCl0j7twz7Kuh4rfB9c+kDWc/VQNfIrtqTttDheJE
         UR7umhvVaofC8USaofDTMYIUdKt3TO8OCaqe96jf3gK4A1mPAED5V4RFxKsRjSCD8Mu6
         4ML3KAZFf2ZWbpldNEpDbXKhOL7lgcj2fDaqD5BWB7uvv37PU71Q4crCPE9TpERwtnyT
         aoxw==
X-Gm-Message-State: AOAM532dW/MadNR7a9VkS1j/9yAgOr9wCQZ7W7IbYVONLCb4TzBkdffn
        1a8P7d1c9Rafd9uWYUfLyZX3MtJLEoM=
X-Google-Smtp-Source: ABdhPJzzLxL+3rV72FK7QHaX7uhVIclQX/nnNy+5pS4dPPUjQ7wO1/06PxzwHloa/rxOCrfn2jgCIg==
X-Received: by 2002:a1c:a507:: with SMTP id o7mr3929453wme.164.1606419754242;
        Thu, 26 Nov 2020 11:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm11260714wrq.58.2020.11.26.11.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:42:33 -0800 (PST)
Message-Id: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:42:15 +0000
Subject: [PATCH v3 00/16] reftable library
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
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from 
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

The final commit should also be split up, but I want to wait until we have
consensus that the bottom commits look good.

version 26 Nov 2020:

 * split public API header into multiple headers
 * minor adaptions in response to review feedback
 * filter out code for standalone compile
 * get rid of test framework

Han-Wen Nienhuys (15):
  move sleep_millisec to git-compat-util.h
  init-db: set the_repository->hash_algo early on
  reftable: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: rest of library
  Reftable support for git-core
  Add "test-tool dump-reftable" command.

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   46 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   56 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    9 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 git-compat-util.h                             |    2 +
 refs.c                                        |   27 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1418 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/VERSION                              |    1 +
 reftable/basics.c                             |  144 ++
 reftable/basics.h                             |   56 +
 reftable/basics_test.c                        |   56 +
 reftable/block.c                              |  440 +++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  119 ++
 reftable/blocksource.c                        |  148 ++
 reftable/blocksource.h                        |   22 +
 reftable/compat.h                             |   48 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  219 +++
 reftable/error.c                              |   39 +
 reftable/iter.c                               |  242 +++
 reftable/iter.h                               |   75 +
 reftable/merged.c                             |  366 +++++
 reftable/merged.h                             |   35 +
 reftable/merged_test.c                        |  333 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   32 +
 reftable/publicbasics.c                       |   58 +
 reftable/reader.c                             |  733 +++++++++
 reftable/reader.h                             |   75 +
 reftable/record.c                             | 1116 +++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  404 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   29 +
 reftable/refname_test.c                       |  100 ++
 reftable/reftable-blocksource.h               |   50 +
 reftable/reftable-error.h                     |   62 +
 reftable/reftable-generic.h                   |   49 +
 reftable/reftable-iterator.h                  |   37 +
 reftable/reftable-malloc.h                    |   20 +
 reftable/reftable-merged.h                    |   68 +
 reftable/reftable-reader.h                    |   89 ++
 reftable/reftable-record.h                    |   73 +
 reftable/reftable-stack.h                     |  116 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable-writer.h                    |  149 ++
 reftable/reftable.c                           |   98 ++
 reftable/reftable_test.c                      |  577 +++++++
 reftable/stack.c                              | 1247 +++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  781 +++++++++
 reftable/system.h                             |   32 +
 reftable/test_framework.c                     |   23 +
 reftable/test_framework.h                     |   48 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   61 +
 reftable/writer.c                             |  676 ++++++++
 reftable/writer.h                             |   50 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    9 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  199 +++
 t/t0032-reftable-unittest.sh                  |   14 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 82 files changed, 11951 insertions(+), 39 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/error.c
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
 create mode 100644 reftable/reftable_test.c
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
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v3
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v2:

  -:  ---------- >  1:  030998a732 move sleep_millisec to git-compat-util.h
  -:  ---------- >  2:  cf667653df init-db: set the_repository->hash_algo early on
  1:  6228103b4a =  3:  91c3ac2449 reftable: add LICENSE
  2:  5d1b946ab5 !  4:  2aa30f536f reftable: define the public API
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: define the public API
     +    reftable: add error related functionality
     +
     +    The reftable/ directory is structured as a library, so it cannot
     +    crash on misuse. Instead, it returns an error codes.
     +
     +    In addition, the error code can be used to signal conditions from lower levels
     +    of the library to be handled by higher levels of the library. For example, a
     +    transaction might legitimately write an empty reftable file, but in that case,
     +    we'd want to shortcut the transaction overhead.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## reftable/reftable.h (new) ##
     + ## reftable/error.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/reftable.h (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#ifndef REFTABLE_H
     -+#define REFTABLE_H
     -+
     -+#include <stdint.h>
     -+#include <stddef.h>
     -+
     -+void reftable_set_alloc(void *(*malloc)(size_t),
     -+			void *(*realloc)(void *, size_t), void (*free)(void *));
     -+
     -+/****************************************************************
     -+ Basic data types
     -+
     -+ Reftables store the state of each ref in struct reftable_ref_record, and they
     -+ store a sequence of reflog updates in struct reftable_log_record.
     -+ ****************************************************************/
     -+
     -+/* reftable_ref_record holds a ref database entry target_value */
     -+struct reftable_ref_record {
     -+	char *refname; /* Name of the ref, malloced. */
     -+	uint64_t update_index; /* Logical timestamp at which this value is
     -+				  written */
     -+	uint8_t *value; /* SHA1, or NULL. malloced. */
     -+	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
     -+	char *target; /* symref, or NULL. malloced. */
     -+};
     -+
     -+/* returns whether 'ref' represents a deletion */
     -+int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
     -+
     -+/* prints a reftable_ref_record onto stdout */
     -+void reftable_ref_record_print(struct reftable_ref_record *ref,
     -+			       uint32_t hash_id);
     -+
     -+/* frees and nulls all pointer values. */
     -+void reftable_ref_record_clear(struct reftable_ref_record *ref);
     -+
     -+/* returns whether two reftable_ref_records are the same */
     -+int reftable_ref_record_equal(struct reftable_ref_record *a,
     -+			      struct reftable_ref_record *b, int hash_size);
     -+
     -+/* reftable_log_record holds a reflog entry */
     -+struct reftable_log_record {
     -+	char *refname;
     -+	uint64_t update_index; /* logical timestamp of a transactional update.
     -+				*/
     -+	uint8_t *new_hash;
     -+	uint8_t *old_hash;
     -+	char *name;
     -+	char *email;
     -+	uint64_t time;
     -+	int16_t tz_offset;
     -+	char *message;
     -+};
     -+
     -+/* returns whether 'ref' represents the deletion of a log record. */
     -+int reftable_log_record_is_deletion(const struct reftable_log_record *log);
     -+
     -+/* frees and nulls all pointer values. */
     -+void reftable_log_record_clear(struct reftable_log_record *log);
     -+
     -+/* returns whether two records are equal. */
     -+int reftable_log_record_equal(struct reftable_log_record *a,
     -+			      struct reftable_log_record *b, int hash_size);
     -+
     -+/* dumps a reftable_log_record on stdout, for debugging/testing. */
     -+void reftable_log_record_print(struct reftable_log_record *log,
     -+			       uint32_t hash_id);
     ++#include "reftable-error.h"
     ++
     ++#include <stdio.h>
     ++
     ++const char *reftable_error_str(int err)
     ++{
     ++	static char buf[250];
     ++	switch (err) {
     ++	case REFTABLE_IO_ERROR:
     ++		return "I/O error";
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
     ++	case REFTABLE_NAME_CONFLICT:
     ++		return "file/directory conflict";
     ++	case REFTABLE_REFNAME_ERROR:
     ++		return "invalid refname";
     ++	case -1:
     ++		return "general error";
     ++	default:
     ++		snprintf(buf, sizeof(buf), "unknown error code %d", err);
     ++		return buf;
     ++	}
     ++}
     +
     + ## reftable/reftable-error.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+/****************************************************************
     -+ Error handling
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+ Error are signaled with negative integer return values. 0 means success.
     -+ ****************************************************************/
     ++#ifndef REFTABLE_ERROR_H
     ++#define REFTABLE_ERROR_H
      +
     -+/* different types of errors */
     ++/*
     ++ Errors in reftable calls are signaled with negative integer return values. 0
     ++ means success.
     ++*/
      +enum reftable_error {
      +	/* Unexpected file system behavior */
      +	REFTABLE_IO_ERROR = -2,
     @@ reftable/reftable.h (new)
      +	   - on writing a log record with multiline message with
      +	   exact_log_message unset
      +	   - on reading a reftable_ref_record from log iterator, or vice versa.
     ++
     ++	  When a call misuses the API, the internal state of the library is kept
     ++	  unchanged.
      +	*/
      +	REFTABLE_API_ERROR = -6,
      +
     @@ reftable/reftable.h (new)
      + * deallocated. */
      +const char *reftable_error_str(int err);
      +
     -+/*
     -+ * Convert the numeric error code to an equivalent errno code.
     -+ */
     -+int reftable_error_to_errno(int err);
     -+
     -+/****************************************************************
     -+ Writing
     -+
     -+ Writing single reftables
     -+ ****************************************************************/
     -+
     -+/* reftable_write_options sets options for writing a single reftable. */
     -+struct reftable_write_options {
     -+	/* boolean: do not pad out blocks to block size. */
     -+	int unpadded;
     -+
     -+	/* the blocksize. Should be less than 2^24. */
     -+	uint32_t block_size;
     -+
     -+	/* boolean: do not generate a SHA1 => ref index. */
     -+	int skip_index_objects;
     -+
     -+	/* how often to write complete keys in each block. */
     -+	int restart_interval;
     -+
     -+	/* 4-byte identifier ("sha1", "s256") of the hash.
     -+	 * Defaults to SHA1 if unset
     -+	 */
     -+	uint32_t hash_id;
     -+
     -+	/* boolean: do not check ref names for validity or dir/file conflicts.
     -+	 */
     -+	int skip_name_check;
     -+
     -+	/* boolean: copy log messages exactly. If unset, check that the message
     -+	 *   is a single line, and add '\n' if missing.
     -+	 */
     -+	int exact_log_message;
     -+};
     -+
     -+/* reftable_block_stats holds statistics for a single block type */
     -+struct reftable_block_stats {
     -+	/* total number of entries written */
     -+	int entries;
     -+	/* total number of key restarts */
     -+	int restarts;
     -+	/* total number of blocks */
     -+	int blocks;
     -+	/* total number of index blocks */
     -+	int index_blocks;
     -+	/* depth of the index */
     -+	int max_index_level;
     -+
     -+	/* offset of the first block for this type */
     -+	uint64_t offset;
     -+	/* offset of the top level index block for this type, or 0 if not
     -+	 * present */
     -+	uint64_t index_offset;
     -+};
     -+
     -+/* stats holds overall statistics for a single reftable */
     -+struct reftable_stats {
     -+	/* total number of blocks written. */
     -+	int blocks;
     -+	/* stats for ref data */
     -+	struct reftable_block_stats ref_stats;
     -+	/* stats for the SHA1 to ref map. */
     -+	struct reftable_block_stats obj_stats;
     -+	/* stats for index blocks */
     -+	struct reftable_block_stats idx_stats;
     -+	/* stats for log blocks */
     -+	struct reftable_block_stats log_stats;
     -+
     -+	/* disambiguation length of shortened object IDs. */
     -+	int object_id_len;
     -+};
     -+
     -+/* reftable_new_writer creates a new writer */
     -+struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
     -+		    void *writer_arg, struct reftable_write_options *opts);
     -+
     -+/* write to a file descriptor. fdp should be an int* pointing to the fd. */
     -+int reftable_fd_write(void *fdp, const void *data, size_t size);
     -+
     -+/* Set the range of update indices for the records we will add.  When
     -+   writing a table into a stack, the min should be at least
     -+   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
     -+
     -+   For transactional updates, typically min==max. When converting an existing
     -+   ref database into a single reftable, this would be a range of update-index
     -+   timestamps.
     -+ */
     -+void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
     -+				uint64_t max);
     -+
     -+/* adds a reftable_ref_record. Must be called in ascending
     -+   order. The update_index must be within the limits set by
     -+   reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned.
     -+
     -+   It is an error to write a ref record after a log record.
     -+ */
     -+int reftable_writer_add_ref(struct reftable_writer *w,
     -+			    struct reftable_ref_record *ref);
     -+
     -+/* Convenience function to add multiple refs. Will sort the refs by
     -+   name before adding. */
     -+int reftable_writer_add_refs(struct reftable_writer *w,
     -+			     struct reftable_ref_record *refs, int n);
     -+
     -+/* adds a reftable_log_record. Must be called in ascending order (with more
     -+   recent log entries first.)
     -+ */
     -+int reftable_writer_add_log(struct reftable_writer *w,
     -+			    struct reftable_log_record *log);
     -+
     -+/* Convenience function to add multiple logs. Will sort the records by
     -+   key before adding. */
     -+int reftable_writer_add_logs(struct reftable_writer *w,
     -+			     struct reftable_log_record *logs, int n);
     -+
     -+/* reftable_writer_close finalizes the reftable. The writer is retained so
     -+ * statistics can be inspected. */
     -+int reftable_writer_close(struct reftable_writer *w);
     -+
     -+/* writer_stats returns the statistics on the reftable being written.
     -+
     -+   This struct becomes invalid when the writer is freed.
     -+ */
     -+const struct reftable_stats *writer_stats(struct reftable_writer *w);
     -+
     -+/* reftable_writer_free deallocates memory for the writer */
     -+void reftable_writer_free(struct reftable_writer *w);
     -+
     -+/****************************************************************
     -+ * ITERATING
     -+ ****************************************************************/
     -+
     -+/* iterator is the generic interface for walking over data stored in a
     -+   reftable. It is generally passed around by value.
     -+*/
     -+struct reftable_iterator {
     -+	struct reftable_iterator_vtable *ops;
     -+	void *iter_arg;
     -+};
     -+
     -+/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     -+int reftable_iterator_next_ref(struct reftable_iterator *it,
     -+			       struct reftable_ref_record *ref);
     -+
     -+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     -+int reftable_iterator_next_log(struct reftable_iterator *it,
     -+			       struct reftable_log_record *log);
     -+
     -+/* releases resources associated with an iterator. */
     -+void reftable_iterator_destroy(struct reftable_iterator *it);
     -+
     -+/****************************************************************
     -+ Reading single tables
     -+
     -+ The follow routines are for reading single files. For an application-level
     -+ interface, skip ahead to struct reftable_merged_table and struct
     -+ reftable_stack.
     -+ ****************************************************************/
     -+
     -+/* block_source is a generic wrapper for a seekable readable file.
     -+   It is generally passed around by value.
     -+ */
     -+struct reftable_block_source {
     -+	struct reftable_block_source_vtable *ops;
     -+	void *arg;
     -+};
     -+
     -+/* a contiguous segment of bytes. It keeps track of its generating block_source
     -+   so it can return itself into the pool.
     -+*/
     -+struct reftable_block {
     -+	uint8_t *data;
     -+	int len;
     -+	struct reftable_block_source source;
     -+};
     -+
     -+/* block_source_vtable are the operations that make up block_source */
     -+struct reftable_block_source_vtable {
     -+	/* returns the size of a block source */
     -+	uint64_t (*size)(void *source);
     -+
     -+	/* reads a segment from the block source. It is an error to read
     -+	   beyond the end of the block */
     -+	int (*read_block)(void *source, struct reftable_block *dest,
     -+			  uint64_t off, uint32_t size);
     -+	/* mark the block as read; may return the data back to malloc */
     -+	void (*return_block)(void *source, struct reftable_block *blockp);
     -+
     -+	/* release all resources associated with the block source */
     -+	void (*close)(void *source);
     -+};
     -+
     -+/* opens a file on the file system as a block_source */
     -+int reftable_block_source_from_file(struct reftable_block_source *block_src,
     -+				    const char *name);
     -+
     -+/* The reader struct is a handle to an open reftable file. */
     -+struct reftable_reader;
     -+
     -+/* reftable_new_reader opens a reftable for reading. If successful, returns 0
     -+ * code and sets pp. The name is used for creating a stack. Typically, it is the
     -+ * basename of the file. The block source `src` is owned by the reader, and is
     -+ * closed on calling reftable_reader_destroy().
     -+ */
     -+int reftable_new_reader(struct reftable_reader **pp,
     -+			struct reftable_block_source *src, const char *name);
     -+
     -+/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
     -+   in the table.  To seek to the start of the table, use name = "".
     -+
     -+   example:
     -+
     -+   struct reftable_reader *r = NULL;
     -+   int err = reftable_new_reader(&r, &src, "filename");
     -+   if (err < 0) { ... }
     -+   struct reftable_iterator it  = {0};
     -+   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
     -+   if (err < 0) { ... }
     -+   struct reftable_ref_record ref  = {0};
     -+   while (1) {
     -+     err = reftable_iterator_next_ref(&it, &ref);
     -+     if (err > 0) {
     -+       break;
     -+     }
     -+     if (err < 0) {
     -+       ..error handling..
     -+     }
     -+     ..found..
     -+   }
     -+   reftable_iterator_destroy(&it);
     -+   reftable_ref_record_clear(&ref);
     -+ */
     -+int reftable_reader_seek_ref(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, const char *name);
     -+
     -+/* returns the hash ID used in this table. */
     -+uint32_t reftable_reader_hash_id(struct reftable_reader *r);
     -+
     -+/* seek to logs for the given name, older than update_index. To seek to the
     -+   start of the table, use name = "".
     -+ */
     -+int reftable_reader_seek_log_at(struct reftable_reader *r,
     -+				struct reftable_iterator *it, const char *name,
     -+				uint64_t update_index);
     -+
     -+/* seek to newest log entry for given name. */
     -+int reftable_reader_seek_log(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, const char *name);
     -+
     -+/* closes and deallocates a reader. */
     -+void reftable_reader_free(struct reftable_reader *);
     -+
     -+/* return an iterator for the refs pointing to `oid`. */
     -+int reftable_reader_refs_for(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, uint8_t *oid);
     -+
     -+/* return the max_update_index for a table */
     -+uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
     -+
     -+/* return the min_update_index for a table */
     -+uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
     -+
     -+/****************************************************************
     -+ Merged tables
     -+
     -+ A ref database kept in a sequence of table files. The merged_table presents a
     -+ unified view to reading (seeking, iterating) a sequence of immutable tables.
     -+ ****************************************************************/
     -+
     -+/* A merged table is implements seeking/iterating over a stack of tables. */
     -+struct reftable_merged_table;
     -+
     -+/* A generic reftable; see below. */
     -+struct reftable_table;
     -+
     -+/* reftable_new_merged_table creates a new merged table. It takes ownership of
     -+   the stack array.
     -+*/
     -+int reftable_new_merged_table(struct reftable_merged_table **dest,
     -+			      struct reftable_table *stack, int n,
     -+			      uint32_t hash_id);
     -+
     -+/* returns an iterator positioned just before 'name' */
     -+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name);
     -+
     -+/* returns an iterator for log entry, at given update_index */
     -+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     -+				      struct reftable_iterator *it,
     -+				      const char *name, uint64_t update_index);
     -+
     -+/* like reftable_merged_table_seek_log_at but look for the newest entry. */
     -+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name);
     -+
     -+/* returns the max update_index covered by this merged table. */
     -+uint64_t
     -+reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
     -+
     -+/* returns the min update_index covered by this merged table. */
     -+uint64_t
     -+reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
     -+
     -+/* releases memory for the merged_table */
     -+void reftable_merged_table_free(struct reftable_merged_table *m);
     -+
     -+/* return the hash ID of the merged table. */
     -+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
     -+
     -+/****************************************************************
     -+ Generic tables
     -+
     -+ A unified API for reading tables, either merged tables, or single readers.
     -+ ****************************************************************/
     -+
     -+struct reftable_table {
     -+	struct reftable_table_vtable *ops;
     -+	void *table_arg;
     -+};
     -+
     -+int reftable_table_seek_ref(struct reftable_table *tab,
     -+			    struct reftable_iterator *it, const char *name);
     -+
     -+void reftable_table_from_reader(struct reftable_table *tab,
     -+				struct reftable_reader *reader);
     -+
     -+/* returns the hash ID from a generic reftable_table */
     -+uint32_t reftable_table_hash_id(struct reftable_table *tab);
     -+
     -+/* create a generic table from reftable_merged_table */
     -+void reftable_table_from_merged_table(struct reftable_table *tab,
     -+				      struct reftable_merged_table *table);
     -+
     -+/* returns the max update_index covered by this table. */
     -+uint64_t reftable_table_max_update_index(struct reftable_table *tab);
     -+
     -+/* returns the min update_index covered by this table. */
     -+uint64_t reftable_table_min_update_index(struct reftable_table *tab);
     -+
     -+/* convenience function to read a single ref. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     -+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     -+			    struct reftable_ref_record *ref);
     -+
     -+/****************************************************************
     -+ Mutable ref database
     -+
     -+ The stack presents an interface to a mutable sequence of reftables.
     -+ ****************************************************************/
     -+
     -+/* a stack is a stack of reftables, which can be mutated by pushing a table to
     -+ * the top of the stack */
     -+struct reftable_stack;
     -+
     -+/* open a new reftable stack. The tables along with the table list will be
     -+   stored in 'dir'. Typically, this should be .git/reftables.
     -+*/
     -+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     -+		       struct reftable_write_options config);
     -+
     -+/* returns the update_index at which a next table should be written. */
     -+uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
     -+
     -+/* holds a transaction to add tables at the top of a stack. */
     -+struct reftable_addition;
     -+
     -+/*
     -+  returns a new transaction to add reftables to the given stack. As a side
     -+  effect, the ref database is locked.
     -+*/
     -+int reftable_stack_new_addition(struct reftable_addition **dest,
     -+				struct reftable_stack *st);
     -+
     -+/* Adds a reftable to transaction. */
     -+int reftable_addition_add(struct reftable_addition *add,
     -+			  int (*write_table)(struct reftable_writer *wr,
     -+					     void *arg),
     -+			  void *arg);
     -+
     -+/* Commits the transaction, releasing the lock. */
     -+int reftable_addition_commit(struct reftable_addition *add);
     -+
     -+/* Release all non-committed data from the transaction, and deallocate the
     -+   transaction. Releases the lock if held. */
     -+void reftable_addition_destroy(struct reftable_addition *add);
     -+
     -+/* add a new table to the stack. The write_table function must call
     -+   reftable_writer_set_limits, add refs and return an error value. */
     -+int reftable_stack_add(struct reftable_stack *st,
     -+		       int (*write_table)(struct reftable_writer *wr,
     -+					  void *write_arg),
     -+		       void *write_arg);
     -+
     -+/* returns the merged_table for seeking. This table is valid until the
     -+   next write or reload, and should not be closed or deleted.
     -+*/
     -+struct reftable_merged_table *
     -+reftable_stack_merged_table(struct reftable_stack *st);
     -+
     -+/* frees all resources associated with the stack. */
     -+void reftable_stack_destroy(struct reftable_stack *st);
     -+
     -+/* Reloads the stack if necessary. This is very cheap to run if the stack was up
     -+ * to date */
     -+int reftable_stack_reload(struct reftable_stack *st);
     -+
     -+/* Policy for expiring reflog entries. */
     -+struct reftable_log_expiry_config {
     -+	/* Drop entries older than this timestamp */
     -+	uint64_t time;
     -+
     -+	/* Drop older entries */
     -+	uint64_t min_update_index;
     -+};
     -+
     -+/* compacts all reftables into a giant table. Expire reflog entries if config is
     -+ * non-NULL */
     -+int reftable_stack_compact_all(struct reftable_stack *st,
     -+			       struct reftable_log_expiry_config *config);
     -+
     -+/* heuristically compact unbalanced table stack. */
     -+int reftable_stack_auto_compact(struct reftable_stack *st);
     -+
     -+/* convenience function to read a single ref. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     -+int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     -+			    struct reftable_ref_record *ref);
     -+
     -+/* convenience function to read a single log. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     -+int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     -+			    struct reftable_log_record *log);
     -+
     -+/* statistics on past compactions. */
     -+struct reftable_compaction_stats {
     -+	uint64_t bytes; /* total number of bytes written */
     -+	uint64_t entries_written; /* total number of entries written, including
     -+				     failures. */
     -+	int attempts; /* how often we tried to compact */
     -+	int failures; /* failures happen on concurrent updates */
     -+};
     -+
     -+/* return statistics for compaction up till now. */
     -+struct reftable_compaction_stats *
     -+reftable_stack_compaction_stats(struct reftable_stack *st);
     -+
      +#endif
  3:  01a669a731 <  -:  ---------- vcxproj: adjust for the reftable changes
  5:  4190da597e !  5:  987d1d186f reftable: utility functions
     @@ Commit message
      
          This commit provides basic utility classes for the reftable library.
      
     -    Since the reftable library must compile standalone, there may be some overlap
     -    with git-core utility functions.
     -
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
      +REFTABLE_LIB = reftable/libreftable.a
      +REFTABLE_TEST_LIB = reftable/libreftable_test.a
       
     - GENERATED_H += config-list.h
       GENERATED_H += command-list.h
     + GENERATED_H += config-list.h
      @@ Makefile: THIRD_PARTY_SOURCES += compat/regex/%
       THIRD_PARTY_SOURCES += sha1collisiondetection/%
       THIRD_PARTY_SOURCES += sha1dc/%
     @@ Makefile: XDIFF_OBJS += xdiff/xpatience.o
       XDIFF_OBJS += xdiff/xutils.o
       
      +REFTABLE_OBJS += reftable/basics.o
     -+REFTABLE_OBJS += reftable/blocksource.o
     ++REFTABLE_OBJS += reftable/error.o
      +REFTABLE_OBJS += reftable/publicbasics.o
     -+REFTABLE_OBJS += reftable/compat.o
     -+REFTABLE_OBJS += reftable/strbuf.o
      +
     -+REFTABLE_TEST_OBJS += reftable/strbuf_test.o
      +REFTABLE_TEST_OBJS += reftable/test_framework.o
     ++REFTABLE_TEST_OBJS += reftable/basics_test.o
      +
       TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
       OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
     @@ reftable/basics.c (new)
      +	}
      +
      +	return *a == *b;
     ++}
     ++
     ++int common_prefix_size(struct strbuf *a, struct strbuf *b)
     ++{
     ++	int p = 0;
     ++	while (p < a->len && p < b->len) {
     ++		if (a->buf[p] != b->buf[p]) {
     ++			break;
     ++		}
     ++		p++;
     ++	}
     ++
     ++	return p;
      +}
      
       ## reftable/basics.h (new) ##
     @@ reftable/basics.h (new)
      +#ifndef BASICS_H
      +#define BASICS_H
      +
     ++/*
     ++ * miscellaneous utilities that are not provided by Git.
     ++ */
     ++
      +#include "system.h"
      +
      +/* Bigendian en/decoding of integers */
     @@ reftable/basics.h (new)
      +void reftable_free(void *p);
      +void *reftable_calloc(size_t sz);
      +
     ++/* Find the longest shared prefix size of `a` and `b` */
     ++struct strbuf;
     ++int common_prefix_size(struct strbuf *a, struct strbuf *b);
     ++
      +#endif
      
     - ## reftable/blocksource.c (new) ##
     + ## reftable/basics_test.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/blocksource.c (new)
      +#include "system.h"
      +
      +#include "basics.h"
     -+#include "blocksource.h"
     -+#include "strbuf.h"
     -+#include "reftable.h"
     -+
     -+static void strbuf_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     -+}
     -+
     -+static void strbuf_close(void *b)
     -+{
     -+}
     -+
     -+static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
     -+			     uint32_t size)
     -+{
     -+	struct strbuf *b = (struct strbuf *)v;
     -+	assert(off + size <= b->len);
     -+	dest->data = reftable_calloc(size);
     -+	memcpy(dest->data, b->buf + off, size);
     -+	dest->len = size;
     -+	return size;
     -+}
     -+
     -+static uint64_t strbuf_size(void *b)
     -+{
     -+	return ((struct strbuf *)b)->len;
     -+}
     -+
     -+static struct reftable_block_source_vtable strbuf_vtable = {
     -+	.size = &strbuf_size,
     -+	.read_block = &strbuf_read_block,
     -+	.return_block = &strbuf_return_block,
     -+	.close = &strbuf_close,
     -+};
     -+
     -+void block_source_from_strbuf(struct reftable_block_source *bs,
     -+			      struct strbuf *buf)
     -+{
     -+	assert(bs->ops == NULL);
     -+	bs->ops = &strbuf_vtable;
     -+	bs->arg = buf;
     -+}
     -+
     -+static void malloc_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     -+}
     -+
     -+static struct reftable_block_source_vtable malloc_vtable = {
     -+	.return_block = &malloc_return_block,
     -+};
     -+
     -+static struct reftable_block_source malloc_block_source_instance = {
     -+	.ops = &malloc_vtable,
     -+};
     -+
     -+struct reftable_block_source malloc_block_source(void)
     -+{
     -+	return malloc_block_source_instance;
     -+}
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
      +
     -+struct file_block_source {
     -+	int fd;
     -+	uint64_t size;
     ++struct binsearch_args {
     ++	int key;
     ++	int *arr;
      +};
      +
     -+static uint64_t file_size(void *b)
     ++static int binsearch_func(size_t i, void *void_args)
      +{
     -+	return ((struct file_block_source *)b)->size;
     -+}
     ++	struct binsearch_args *args = (struct binsearch_args *)void_args;
      +
     -+static void file_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     ++	return args->key < args->arr[i];
      +}
      +
     -+static void file_close(void *b)
     -+{
     -+	int fd = ((struct file_block_source *)b)->fd;
     -+	if (fd > 0) {
     -+		close(fd);
     -+		((struct file_block_source *)b)->fd = 0;
     -+	}
     -+
     -+	reftable_free(b);
     -+}
     -+
     -+static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
     -+			   uint32_t size)
     -+{
     -+	struct file_block_source *b = (struct file_block_source *)v;
     -+	assert(off + size <= b->size);
     -+	dest->data = reftable_malloc(size);
     -+	if (pread(b->fd, dest->data, size, off) != size)
     -+		return -1;
     -+	dest->len = size;
     -+	return size;
     -+}
     -+
     -+static struct reftable_block_source_vtable file_vtable = {
     -+	.size = &file_size,
     -+	.read_block = &file_read_block,
     -+	.return_block = &file_return_block,
     -+	.close = &file_close,
     -+};
     -+
     -+int reftable_block_source_from_file(struct reftable_block_source *bs,
     -+				    const char *name)
     ++static void test_binsearch(void)
      +{
     -+	struct stat st = { 0 };
     -+	int err = 0;
     -+	int fd = open(name, O_RDONLY);
     -+	struct file_block_source *p = NULL;
     -+	if (fd < 0) {
     -+		if (errno == ENOENT) {
     -+			return REFTABLE_NOT_EXIST_ERROR;
     -+		}
     -+		return -1;
     -+	}
     -+
     -+	err = fstat(fd, &st);
     -+	if (err < 0)
     -+		return -1;
     -+
     -+	p = reftable_calloc(sizeof(struct file_block_source));
     -+	p->size = st.st_size;
     -+	p->fd = fd;
     -+
     -+	assert(bs->ops == NULL);
     -+	bs->ops = &file_vtable;
     -+	bs->arg = p;
     -+	return 0;
     -+}
     -
     - ## reftable/blocksource.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef BLOCKSOURCE_H
     -+#define BLOCKSOURCE_H
     -+
     -+#include "strbuf.h"
     -+
     -+struct reftable_block_source;
     -+
     -+/* Create an in-memory block source for reading reftables */
     -+void block_source_from_strbuf(struct reftable_block_source *bs,
     -+			      struct strbuf *buf);
     ++	int arr[] = { 2, 4, 6, 8, 10 };
     ++	size_t sz = ARRAY_SIZE(arr);
     ++	struct binsearch_args args = {
     ++		.arr = arr,
     ++	};
      +
     -+struct reftable_block_source malloc_block_source(void);
     -+
     -+#endif
     -
     - ## reftable/compat.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+
     -+*/
     -+
     -+/* compat.c - compatibility functions for standalone compilation */
     -+
     -+#include "system.h"
     -+#include "basics.h"
     -+
     -+#ifdef REFTABLE_STANDALONE
     -+
     -+#include <dirent.h>
     -+
     -+void put_be32(void *p, uint32_t i)
     -+{
     -+	uint8_t *out = (uint8_t *)p;
     -+
     -+	out[0] = (uint8_t)((i >> 24) & 0xff);
     -+	out[1] = (uint8_t)((i >> 16) & 0xff);
     -+	out[2] = (uint8_t)((i >> 8) & 0xff);
     -+	out[3] = (uint8_t)((i)&0xff);
     -+}
     -+
     -+uint32_t get_be32(uint8_t *in)
     -+{
     -+	return (uint32_t)(in[0]) << 24 | (uint32_t)(in[1]) << 16 |
     -+	       (uint32_t)(in[2]) << 8 | (uint32_t)(in[3]);
     -+}
     -+
     -+void put_be64(void *p, uint64_t v)
     -+{
     -+	uint8_t *out = (uint8_t *)p;
     -+	int i = sizeof(uint64_t);
     -+	while (i--) {
     -+		out[i] = (uint8_t)(v & 0xff);
     -+		v >>= 8;
     -+	}
     -+}
     -+
     -+uint64_t get_be64(void *out)
     -+{
     -+	uint8_t *bytes = (uint8_t *)out;
     -+	uint64_t v = 0;
      +	int i = 0;
     -+	for (i = 0; i < sizeof(uint64_t); i++) {
     -+		v = (v << 8) | (uint8_t)(bytes[i] & 0xff);
     -+	}
     -+	return v;
     -+}
     -+
     -+uint16_t get_be16(uint8_t *in)
     -+{
     -+	return (uint32_t)(in[0]) << 8 | (uint32_t)(in[1]);
     -+}
     -+
     -+char *xstrdup(const char *s)
     -+{
     -+	int l = strlen(s);
     -+	char *dest = (char *)reftable_malloc(l + 1);
     -+	strncpy(dest, s, l + 1);
     -+	return dest;
     -+}
     -+
     -+void sleep_millisec(int millisecs)
     -+{
     -+	usleep(millisecs * 1000);
     -+}
     -+
     -+void reftable_clear_dir(const char *dirname)
     -+{
     -+	DIR *dir = opendir(dirname);
     -+	struct dirent *ent = NULL;
     -+	assert(dir);
     -+	while ((ent = readdir(dir)) != NULL) {
     -+		unlinkat(dirfd(dir), ent->d_name, 0);
     ++	for (i = 1; i < 11; i++) {
     ++		int res;
     ++		args.key = i;
     ++		res = binsearch(sz, &binsearch_func, &args);
     ++
     ++		if (res < sz) {
     ++			EXPECT(args.key < arr[res]);
     ++			if (res > 0) {
     ++				EXPECT(args.key >= arr[res - 1]);
     ++			}
     ++		} else {
     ++			EXPECT(args.key == 10 || args.key == 11);
     ++		}
      +	}
     -+	closedir(dir);
     -+	rmdir(dirname);
      +}
      +
     -+#else
     -+
     -+#include "../dir.h"
     -+
     -+void reftable_clear_dir(const char *dirname)
     ++int basics_test_main(int argc, const char *argv[])
      +{
     -+	struct strbuf path = STRBUF_INIT;
     -+	strbuf_addstr(&path, dirname);
     -+	remove_dir_recursively(&path, 0);
     -+	strbuf_release(&path);
     -+}
     -+
     -+#endif
     -+
     -+int hash_size(uint32_t id)
     -+{
     -+	switch (id) {
     -+	case 0:
     -+	case SHA1_ID:
     -+		return SHA1_SIZE;
     -+	case SHA256_ID:
     -+		return SHA256_SIZE;
     -+	}
     -+	abort();
     ++	test_binsearch();
     ++	return 0;
      +}
      
       ## reftable/compat.h (new) ##
     @@ reftable/publicbasics.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "reftable.h"
     ++#include "reftable-malloc.h"
      +
      +#include "basics.h"
      +#include "system.h"
      +
     -+const char *reftable_error_str(int err)
     -+{
     -+	static char buf[250];
     -+	switch (err) {
     -+	case REFTABLE_IO_ERROR:
     -+		return "I/O error";
     -+	case REFTABLE_FORMAT_ERROR:
     -+		return "corrupt reftable file";
     -+	case REFTABLE_NOT_EXIST_ERROR:
     -+		return "file does not exist";
     -+	case REFTABLE_LOCK_ERROR:
     -+		return "data is outdated";
     -+	case REFTABLE_API_ERROR:
     -+		return "misuse of the reftable API";
     -+	case REFTABLE_ZLIB_ERROR:
     -+		return "zlib failure";
     -+	case REFTABLE_NAME_CONFLICT:
     -+		return "file/directory conflict";
     -+	case REFTABLE_REFNAME_ERROR:
     -+		return "invalid refname";
     -+	case -1:
     -+		return "general error";
     -+	default:
     -+		snprintf(buf, sizeof(buf), "unknown error code %d", err);
     -+		return buf;
     -+	}
     -+}
     -+
     -+int reftable_error_to_errno(int err)
     -+{
     -+	switch (err) {
     -+	case REFTABLE_IO_ERROR:
     -+		return EIO;
     -+	case REFTABLE_FORMAT_ERROR:
     -+		return EFAULT;
     -+	case REFTABLE_NOT_EXIST_ERROR:
     -+		return ENOENT;
     -+	case REFTABLE_LOCK_ERROR:
     -+		return EBUSY;
     -+	case REFTABLE_API_ERROR:
     -+		return EINVAL;
     -+	case REFTABLE_ZLIB_ERROR:
     -+		return EDOM;
     -+	default:
     -+		return ERANGE;
     -+	}
     -+}
     -+
      +static void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
      +static void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
      +static void (*reftable_free_ptr)(void *) = &free;
     @@ reftable/publicbasics.c (new)
      +	reftable_free_ptr = free;
      +}
      +
     -+int reftable_fd_write(void *arg, const void *data, size_t sz)
     ++int hash_size(uint32_t id)
      +{
     -+	int *fdp = (int *)arg;
     -+	return write(*fdp, data, sz);
     ++	switch (id) {
     ++	case 0:
     ++	case SHA1_ID:
     ++		return SHA1_SIZE;
     ++	case SHA256_ID:
     ++		return SHA256_SIZE;
     ++	}
     ++	abort();
      +}
      
     - ## reftable/reftable-tests.h (new) ##
     + ## reftable/reftable-malloc.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/reftable-tests.h (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#ifndef REFTABLE_TESTS_H
     -+#define REFTABLE_TESTS_H
     ++#ifndef REFTABLE_H
     ++#define REFTABLE_H
      +
     -+int block_test_main(int argc, const char **argv);
     -+int merged_test_main(int argc, const char **argv);
     -+int record_test_main(int argc, const char **argv);
     -+int refname_test_main(int argc, const char **argv);
     -+int reftable_test_main(int argc, const char **argv);
     -+int strbuf_test_main(int argc, const char **argv);
     -+int stack_test_main(int argc, const char **argv);
     -+int tree_test_main(int argc, const char **argv);
     -+int reftable_dump_main(int argc, char *const *argv);
     ++#include <stddef.h>
     ++
     ++/*
     ++  Overrides the functions to use for memory management.
     ++ */
     ++void reftable_set_alloc(void *(*malloc)(size_t),
     ++			void *(*realloc)(void *, size_t), void (*free)(void *));
      +
      +#endif
      
     - ## reftable/strbuf.c (new) ##
     + ## reftable/reftable-tests.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/strbuf.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "strbuf.h"
     -+
     -+#ifdef REFTABLE_STANDALONE
     -+
     -+void strbuf_init(struct strbuf *s, size_t alloc)
     -+{
     -+	struct strbuf empty = STRBUF_INIT;
     -+	*s = empty;
     -+}
     -+
     -+void strbuf_grow(struct strbuf *s, size_t extra)
     -+{
     -+	size_t newcap = s->len + extra + 1;
     -+	if (newcap > s->cap) {
     -+		s->buf = reftable_realloc(s->buf, newcap);
     -+		s->cap = newcap;
     -+	}
     -+}
     -+
     -+static void strbuf_resize(struct strbuf *s, int l)
     -+{
     -+	int zl = l + 1; /* one uint8_t for 0 termination. */
     -+	assert(s->canary == STRBUF_CANARY);
     -+	if (s->cap < zl) {
     -+		int c = s->cap * 2;
     -+		if (c < zl) {
     -+			c = zl;
     -+		}
     -+		s->cap = c;
     -+		s->buf = reftable_realloc(s->buf, s->cap);
     -+	}
     -+	s->len = l;
     -+	s->buf[l] = 0;
     -+}
     -+
     -+void strbuf_setlen(struct strbuf *s, size_t l)
     -+{
     -+	assert(s->cap >= l + 1);
     -+	s->len = l;
     -+	s->buf[l] = 0;
     -+}
     -+
     -+void strbuf_reset(struct strbuf *s)
     -+{
     -+	strbuf_resize(s, 0);
     -+}
     -+
     -+void strbuf_addstr(struct strbuf *d, const char *s)
     -+{
     -+	int l1 = d->len;
     -+	int l2 = strlen(s);
     -+	assert(d->canary == STRBUF_CANARY);
     -+
     -+	strbuf_resize(d, l2 + l1);
     -+	memcpy(d->buf + l1, s, l2);
     -+}
     -+
     -+void strbuf_addbuf(struct strbuf *s, struct strbuf *a)
     -+{
     -+	int end = s->len;
     -+	assert(s->canary == STRBUF_CANARY);
     -+	strbuf_resize(s, s->len + a->len);
     -+	memcpy(s->buf + end, a->buf, a->len);
     -+}
     -+
     -+char *strbuf_detach(struct strbuf *s, size_t *sz)
     -+{
     -+	char *p = NULL;
     -+	p = (char *)s->buf;
     -+	if (sz)
     -+		*sz = s->len;
     -+	s->buf = NULL;
     -+	s->cap = 0;
     -+	s->len = 0;
     -+	return p;
     -+}
     -+
     -+void strbuf_release(struct strbuf *s)
     -+{
     -+	assert(s->canary == STRBUF_CANARY);
     -+	s->cap = 0;
     -+	s->len = 0;
     -+	reftable_free(s->buf);
     -+	s->buf = NULL;
     -+}
     -+
     -+int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
     -+{
     -+	int min = a->len < b->len ? a->len : b->len;
     -+	int res = memcmp(a->buf, b->buf, min);
     -+	assert(a->canary == STRBUF_CANARY);
     -+	assert(b->canary == STRBUF_CANARY);
     -+	if (res != 0)
     -+		return res;
     -+	if (a->len < b->len)
     -+		return -1;
     -+	else if (a->len > b->len)
     -+		return 1;
     -+	else
     -+		return 0;
     -+}
     ++#ifndef REFTABLE_TESTS_H
     ++#define REFTABLE_TESTS_H
      +
     -+int strbuf_add(struct strbuf *b, const void *data, size_t sz)
     -+{
     -+	assert(b->canary == STRBUF_CANARY);
     -+	strbuf_grow(b, sz);
     -+	memcpy(b->buf + b->len, data, sz);
     -+	b->len += sz;
     -+	b->buf[b->len] = 0;
     -+	return sz;
     -+}
     ++int basics_test_main(int argc, const char **argv);
     ++int block_test_main(int argc, const char **argv);
     ++int merged_test_main(int argc, const char **argv);
     ++int record_test_main(int argc, const char **argv);
     ++int refname_test_main(int argc, const char **argv);
     ++int reftable_test_main(int argc, const char **argv);
     ++int stack_test_main(int argc, const char **argv);
     ++int tree_test_main(int argc, const char **argv);
     ++int reftable_dump_main(int argc, char *const *argv);
      +
      +#endif
     -+
     -+int strbuf_add_void(void *b, const void *data, size_t sz)
     -+{
     -+	strbuf_add((struct strbuf *)b, data, sz);
     -+	return sz;
     -+}
     -+
     -+int common_prefix_size(struct strbuf *a, struct strbuf *b)
     -+{
     -+	int p = 0;
     -+	while (p < a->len && p < b->len) {
     -+		if (a->buf[p] != b->buf[p]) {
     -+			break;
     -+		}
     -+		p++;
     -+	}
     -+
     -+	return p;
     -+}
     -+
     -+struct strbuf reftable_empty_strbuf = STRBUF_INIT;
      
     - ## reftable/strbuf.h (new) ##
     + ## reftable/system.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/strbuf.h (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#ifndef SLICE_H
     -+#define SLICE_H
     -+
     -+#ifdef REFTABLE_STANDALONE
     -+
     -+#include "basics.h"
     -+
     -+/*
     -+  Provides a bounds-checked, growable byte ranges. To use, initialize as "strbuf
     -+  x = STRBUF_INIT;"
     -+ */
     -+struct strbuf {
     -+	size_t len;
     -+	size_t cap;
     -+	char *buf;
     -+
     -+	/* Used to enforce initialization with STRBUF_INIT */
     -+	uint8_t canary;
     -+};
     -+
     -+#define STRBUF_CANARY 0x42
     -+#define STRBUF_INIT                       \
     -+	{                                 \
     -+		0, 0, NULL, STRBUF_CANARY \
     -+	}
     -+
     -+void strbuf_addstr(struct strbuf *dest, const char *src);
     -+
     -+/* Deallocate and clear strbuf */
     -+void strbuf_release(struct strbuf *strbuf);
     -+
     -+/* Set strbuf to 0 length, but retain buffer. */
     -+void strbuf_reset(struct strbuf *strbuf);
     -+
     -+/* Initializes a strbuf. Accepts a strbuf with random garbage. */
     -+void strbuf_init(struct strbuf *strbuf, size_t alloc);
     -+
     -+/* Return `buf`, clearing out `s`. Optionally return len (not cap) in `sz`.  */
     -+char *strbuf_detach(struct strbuf *s, size_t *sz);
     -+
     -+/* Set length of the slace to `l`, but don't reallocated. */
     -+void strbuf_setlen(struct strbuf *s, size_t l);
     -+
     -+/* Ensure `l` bytes beyond current length are available */
     -+void strbuf_grow(struct strbuf *s, size_t l);
     -+
     -+/* Signed comparison */
     -+int strbuf_cmp(const struct strbuf *a, const struct strbuf *b);
     -+
     -+/* Append `data` to the `dest` strbuf.  */
     -+int strbuf_add(struct strbuf *dest, const void *data, size_t sz);
     ++#ifndef SYSTEM_H
     ++#define SYSTEM_H
      +
     -+/* Append `add` to `dest. */
     -+void strbuf_addbuf(struct strbuf *dest, struct strbuf *add);
     ++#include "git-compat-util.h"
     ++#include "strbuf.h"
      +
     -+#else
     ++#include <zlib.h>
      +
     -+#include "../git-compat-util.h"
     -+#include "../strbuf.h"
     ++struct strbuf;
     ++/* In git, this is declared in dir.h */
     ++int remove_dir_recursively(struct strbuf *path, int flags);
      +
     -+#endif
     -+
     -+extern struct strbuf reftable_empty_strbuf;
     ++#define SHA1_ID 0x73686131
     ++#define SHA256_ID 0x73323536
     ++#define SHA1_SIZE 20
     ++#define SHA256_SIZE 32
      +
     -+/* Like strbuf_add, but suitable for passing to reftable_new_writer
     ++/* This is uncompress2, which is only available in zlib as of 2017.
      + */
     -+int strbuf_add_void(void *b, const void *data, size_t sz);
     -+
     -+/* Find the longest shared prefix size of `a` and `b` */
     -+int common_prefix_size(struct strbuf *a, struct strbuf *b);
     ++int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
     ++			       const Bytef *source, uLong *sourceLen);
     ++int hash_size(uint32_t id);
      +
      +#endif
      
     - ## reftable/strbuf_test.c (new) ##
     + ## reftable/test_framework.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/strbuf_test.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "strbuf.h"
     -+
      +#include "system.h"
     ++#include "test_framework.h"
      +
      +#include "basics.h"
     -+#include "test_framework.h"
     -+#include "reftable-tests.h"
      +
     -+static void test_strbuf(void)
     ++void set_test_hash(uint8_t *p, int i)
      +{
     -+	struct strbuf s = STRBUF_INIT;
     -+	struct strbuf t = STRBUF_INIT;
     -+
     -+	strbuf_addstr(&s, "abc");
     -+	assert(0 == strcmp("abc", s.buf));
     -+
     -+	strbuf_addstr(&t, "pqr");
     -+	strbuf_addbuf(&s, &t);
     -+	assert(0 == strcmp("abcpqr", s.buf));
     -+
     -+	strbuf_release(&s);
     -+	strbuf_release(&t);
     ++	memset(p, (uint8_t)i, hash_size(SHA1_ID));
      +}
      +
     -+int strbuf_test_main(int argc, const char *argv[])
     ++int strbuf_add_void(void *b, const void *data, size_t sz)
      +{
     -+	add_test_case("test_strbuf", &test_strbuf);
     -+	return test_main(argc, argv);
     ++	strbuf_add((struct strbuf *)b, data, sz);
     ++	return sz;
      +}
      
     - ## reftable/system.h (new) ##
     + ## reftable/test_framework.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/system.h (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#ifndef SYSTEM_H
     -+#define SYSTEM_H
     -+
     -+#ifndef REFTABLE_STANDALONE
     -+
     -+#include "git-compat-util.h"
     -+#include "cache.h"
     -+#include <zlib.h>
     -+
     -+#else
     -+
     -+#include <assert.h>
     -+#include <errno.h>
     -+#include <fcntl.h>
     -+#include <inttypes.h>
     -+#include <stdint.h>
     -+#include <stdio.h>
     -+#include <stdlib.h>
     -+#include <string.h>
     -+#include <sys/stat.h>
     -+#include <sys/time.h>
     -+#include <sys/types.h>
     -+#include <unistd.h>
     -+#include <zlib.h>
     ++#ifndef TEST_FRAMEWORK_H
     ++#define TEST_FRAMEWORK_H
      +
     -+#include "compat.h"
     ++#include "system.h"
     ++#include "reftable-error.h"
     ++
     ++#define EXPECT_ERR(c)                                                  \
     ++	if (c != 0) {                                                  \
     ++		fflush(stderr);                                        \
     ++		fflush(stdout);                                        \
     ++		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
     ++			__FILE__, __LINE__, c, reftable_error_str(c)); \
     ++		abort();                                               \
     ++	}
      +
     -+#endif /* REFTABLE_STANDALONE */
     ++#define EXPECT_STREQ(a, b)                                               \
     ++	if (strcmp(a, b)) {                                              \
     ++		fflush(stderr);                                          \
     ++		fflush(stdout);                                          \
     ++		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
     ++			__LINE__, #a, a, #b, b);                         \
     ++		abort();                                                 \
     ++	}
      +
     -+void reftable_clear_dir(const char *dirname);
     ++#define EXPECT(c)                                                          \
     ++	if (!(c)) {                                                        \
     ++		fflush(stderr);                                            \
     ++		fflush(stdout);                                            \
     ++		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
     ++			__LINE__, #c);                                     \
     ++		abort();                                                   \
     ++	}
      +
     -+#define SHA1_ID 0x73686131
     -+#define SHA256_ID 0x73323536
     -+#define SHA1_SIZE 20
     -+#define SHA256_SIZE 32
     ++void set_test_hash(uint8_t *p, int i);
      +
     -+/* This is uncompress2, which is only available in zlib as of 2017.
     ++/* Like strbuf_add, but suitable for passing to reftable_new_writer
      + */
     -+int uncompress_return_consumed(Bytef *dest, uLongf *destLen,
     -+			       const Bytef *source, uLong *sourceLen);
     -+int hash_size(uint32_t id);
     ++int strbuf_add_void(void *b, const void *data, size_t sz);
      +
      +#endif
      
     @@ t/helper/test-reftable.c (new)
      +
      +int cmd__reftable(int argc, const char **argv)
      +{
     -+	strbuf_test_main(argc, argv);
     ++	basics_test_main(argc, argv);
     ++
      +	return 0;
      +}
      
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     + 	{ "path-utils", cmd__path_utils },
     + 	{ "pkt-line", cmd__pkt_line },
     + 	{ "prio-queue", cmd__prio_queue },
     +-	{ "proc-receive", cmd__proc_receive},
     ++	{ "proc-receive", cmd__proc_receive },
     + 	{ "progress", cmd__progress },
     + 	{ "reach", cmd__reach },
     + 	{ "read-cache", cmd__read_cache },
       	{ "read-graph", cmd__read_graph },
       	{ "read-midx", cmd__read_midx },
       	{ "ref-store", cmd__ref_store },
     @@ t/helper/test-tool.h: int cmd__read_cache(int argc, const char **argv);
       int cmd__regex(int argc, const char **argv);
       int cmd__repository(int argc, const char **argv);
       int cmd__revision_walking(int argc, const char **argv);
     +
     + ## t/t0032-reftable-unittest.sh (new) ##
     +@@
     ++#!/bin/sh
     ++#
     ++# Copyright (c) 2020 Google LLC
     ++#
     ++
     ++test_description='reftable unittests'
     ++
     ++. ./test-lib.sh
     ++
     ++test_expect_success 'unittests' '
     ++       test-tool reftable
     ++'
     ++
     ++test_done
  4:  b94c5f5c61 !  6:  f71e82b995 reftable: add a barebones unittest framework
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: add a barebones unittest framework
     +    reftable: add blocksource, an abstraction for random access reads
     +
     +    The reftable format is usually used with files for storage. However, we abstract
     +    away this using the blocksource data structure. This has two advantages:
     +
     +    * log blocks are zlib compressed, and handling them is simplified if we can
     +      discard byte segments from within the block layer.
     +
     +    * for unittests, it is useful to read and write in-memory. The blocksource
     +      allows us to abstract the data away from on-disk files.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## reftable/test_framework.c (new) ##
     + ## Makefile ##
     +@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
     + 
     + REFTABLE_OBJS += reftable/basics.o
     + REFTABLE_OBJS += reftable/error.o
     ++REFTABLE_OBJS += reftable/blocksource.o
     + REFTABLE_OBJS += reftable/publicbasics.o
     + 
     + REFTABLE_TEST_OBJS += reftable/test_framework.o
     +
     + ## reftable/blocksource.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/test_framework.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "test_framework.h"
     -+
      +#include "system.h"
     ++
      +#include "basics.h"
     ++#include "blocksource.h"
     ++#include "reftable-blocksource.h"
     ++#include "reftable-error.h"
      +
     -+static struct test_case **test_cases;
     -+static int test_case_len;
     -+static int test_case_cap;
     ++static void strbuf_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
      +
     -+static struct test_case *new_test_case(const char *name, void (*testfunc)(void))
     ++static void strbuf_close(void *b)
      +{
     -+	struct test_case *tc = reftable_malloc(sizeof(struct test_case));
     -+	tc->name = name;
     -+	tc->testfunc = testfunc;
     -+	return tc;
      +}
      +
     -+struct test_case *add_test_case(const char *name, void (*testfunc)(void))
     ++static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
     ++			     uint32_t size)
      +{
     -+	struct test_case *tc = new_test_case(name, testfunc);
     -+	if (test_case_len == test_case_cap) {
     -+		test_case_cap = 2 * test_case_cap + 1;
     -+		test_cases = reftable_realloc(
     -+			test_cases, sizeof(struct test_case) * test_case_cap);
     -+	}
     ++	struct strbuf *b = (struct strbuf *)v;
     ++	assert(off + size <= b->len);
     ++	dest->data = reftable_calloc(size);
     ++	memcpy(dest->data, b->buf + off, size);
     ++	dest->len = size;
     ++	return size;
     ++}
      +
     -+	test_cases[test_case_len++] = tc;
     -+	return tc;
     ++static uint64_t strbuf_size(void *b)
     ++{
     ++	return ((struct strbuf *)b)->len;
      +}
      +
     -+int test_main(int argc, const char *argv[])
     ++static struct reftable_block_source_vtable strbuf_vtable = {
     ++	.size = &strbuf_size,
     ++	.read_block = &strbuf_read_block,
     ++	.return_block = &strbuf_return_block,
     ++	.close = &strbuf_close,
     ++};
     ++
     ++void block_source_from_strbuf(struct reftable_block_source *bs,
     ++			      struct strbuf *buf)
      +{
     -+	const char *filter = NULL;
     -+	int i = 0;
     -+	if (argc > 1) {
     -+		filter = argv[1];
     -+	}
     ++	assert(bs->ops == NULL);
     ++	bs->ops = &strbuf_vtable;
     ++	bs->arg = buf;
     ++}
      +
     -+	for (i = 0; i < test_case_len; i++) {
     -+		const char *name = test_cases[i]->name;
     -+		if (filter == NULL || strstr(name, filter) != NULL) {
     -+			printf("case %s\n", name);
     -+			test_cases[i]->testfunc();
     -+		} else {
     -+			printf("skip %s\n", name);
     -+		}
     ++static void malloc_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++static struct reftable_block_source_vtable malloc_vtable = {
     ++	.return_block = &malloc_return_block,
     ++};
     ++
     ++static struct reftable_block_source malloc_block_source_instance = {
     ++	.ops = &malloc_vtable,
     ++};
      +
     -+		reftable_free(test_cases[i]);
     ++struct reftable_block_source malloc_block_source(void)
     ++{
     ++	return malloc_block_source_instance;
     ++}
     ++
     ++struct file_block_source {
     ++	int fd;
     ++	uint64_t size;
     ++};
     ++
     ++static uint64_t file_size(void *b)
     ++{
     ++	return ((struct file_block_source *)b)->size;
     ++}
     ++
     ++static void file_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++static void file_close(void *b)
     ++{
     ++	int fd = ((struct file_block_source *)b)->fd;
     ++	if (fd > 0) {
     ++		close(fd);
     ++		((struct file_block_source *)b)->fd = 0;
      +	}
     -+	reftable_free(test_cases);
     -+	test_cases = NULL;
     -+	test_case_len = 0;
     -+	test_case_cap = 0;
     -+	return 0;
     ++
     ++	reftable_free(b);
      +}
      +
     -+void set_test_hash(uint8_t *p, int i)
     ++static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
     ++			   uint32_t size)
      +{
     -+	memset(p, (uint8_t)i, hash_size(SHA1_ID));
     ++	struct file_block_source *b = (struct file_block_source *)v;
     ++	assert(off + size <= b->size);
     ++	dest->data = reftable_malloc(size);
     ++	if (pread(b->fd, dest->data, size, off) != size)
     ++		return -1;
     ++	dest->len = size;
     ++	return size;
     ++}
     ++
     ++static struct reftable_block_source_vtable file_vtable = {
     ++	.size = &file_size,
     ++	.read_block = &file_read_block,
     ++	.return_block = &file_return_block,
     ++	.close = &file_close,
     ++};
     ++
     ++int reftable_block_source_from_file(struct reftable_block_source *bs,
     ++				    const char *name)
     ++{
     ++	struct stat st = { 0 };
     ++	int err = 0;
     ++	int fd = open(name, O_RDONLY);
     ++	struct file_block_source *p = NULL;
     ++	if (fd < 0) {
     ++		if (errno == ENOENT) {
     ++			return REFTABLE_NOT_EXIST_ERROR;
     ++		}
     ++		return -1;
     ++	}
     ++
     ++	err = fstat(fd, &st);
     ++	if (err < 0)
     ++		return -1;
     ++
     ++	p = reftable_calloc(sizeof(struct file_block_source));
     ++	p->size = st.st_size;
     ++	p->fd = fd;
     ++
     ++	assert(bs->ops == NULL);
     ++	bs->ops = &file_vtable;
     ++	bs->arg = p;
     ++	return 0;
      +}
      
     - ## reftable/test_framework.h (new) ##
     + ## reftable/blocksource.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/test_framework.h (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#ifndef TEST_FRAMEWORK_H
     -+#define TEST_FRAMEWORK_H
     ++#ifndef BLOCKSOURCE_H
     ++#define BLOCKSOURCE_H
      +
      +#include "system.h"
      +
     -+#ifdef NDEBUG
     -+#undef NDEBUG
     -+#endif
     ++struct reftable_block_source;
     ++
     ++/* Create an in-memory block source for reading reftables */
     ++void block_source_from_strbuf(struct reftable_block_source *bs,
     ++			      struct strbuf *buf);
     ++
     ++struct reftable_block_source malloc_block_source(void);
      +
     -+#ifdef assert
     -+#undef assert
      +#endif
     +
     + ## reftable/reftable-blocksource.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+#define assert_err(c)                                                  \
     -+	if (c != 0) {                                                  \
     -+		fflush(stderr);                                        \
     -+		fflush(stdout);                                        \
     -+		fprintf(stderr, "%s: %d: error == %d (%s), want 0\n",  \
     -+			__FILE__, __LINE__, c, reftable_error_str(c)); \
     -+		abort();                                               \
     -+	}
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+#define assert_streq(a, b)                                               \
     -+	if (strcmp(a, b)) {                                              \
     -+		fflush(stderr);                                          \
     -+		fflush(stdout);                                          \
     -+		fprintf(stderr, "%s:%d: %s (%s) != %s (%s)\n", __FILE__, \
     -+			__LINE__, #a, a, #b, b);                         \
     -+		abort();                                                 \
     -+	}
     ++#ifndef REFTABLE_BLOCKSOURCE_H
     ++#define REFTABLE_BLOCKSOURCE_H
      +
     -+#define assert(c)                                                          \
     -+	if (!(c)) {                                                        \
     -+		fflush(stderr);                                            \
     -+		fflush(stdout);                                            \
     -+		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
     -+			__LINE__, #c);                                     \
     -+		abort();                                                   \
     -+	}
     ++#include <stdint.h>
     ++
     ++/* block_source is a generic wrapper for a seekable readable file.
     ++ */
     ++struct reftable_block_source {
     ++	struct reftable_block_source_vtable *ops;
     ++	void *arg;
     ++};
      +
     -+struct test_case {
     -+	const char *name;
     -+	void (*testfunc)(void);
     ++/* a contiguous segment of bytes. It keeps track of its generating block_source
     ++   so it can return itself into the pool.
     ++*/
     ++struct reftable_block {
     ++	uint8_t *data;
     ++	int len;
     ++	struct reftable_block_source source;
      +};
      +
     -+struct test_case *add_test_case(const char *name, void (*testfunc)(void));
     -+int test_main(int argc, const char *argv[]);
     ++/* block_source_vtable are the operations that make up block_source */
     ++struct reftable_block_source_vtable {
     ++	/* returns the size of a block source */
     ++	uint64_t (*size)(void *source);
     ++
     ++	/* reads a segment from the block source. It is an error to read
     ++	   beyond the end of the block */
     ++	int (*read_block)(void *source, struct reftable_block *dest,
     ++			  uint64_t off, uint32_t size);
     ++	/* mark the block as read; may return the data back to malloc */
     ++	void (*return_block)(void *source, struct reftable_block *blockp);
     ++
     ++	/* release all resources associated with the block source */
     ++	void (*close)(void *source);
     ++};
      +
     -+void set_test_hash(uint8_t *p, int i);
     ++/* opens a file on the file system as a block_source */
     ++int reftable_block_source_from_file(struct reftable_block_source *block_src,
     ++				    const char *name);
      +
      +#endif
  6:  8eb944ea9b !  7:  bbe2ed7173 reftable: (de)serialization for the polymorphic record type.
     @@ Metadata
       ## Commit message ##
          reftable: (de)serialization for the polymorphic record type.
      
     +    The reftable format is structured as a sequence of blocks, and each block
     +    contains a sequence of prefix-compressed key-value records. There are 4 types of
     +    records, and they have similarities in how they must be handled. This is
     +    achieved by introducing a polymorphic 'record' type that encapsulates ref, log,
     +    index and object records.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
      @@ Makefile: REFTABLE_OBJS += reftable/basics.o
     + REFTABLE_OBJS += reftable/error.o
       REFTABLE_OBJS += reftable/blocksource.o
       REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/compat.o
      +REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/strbuf.o
       
      +REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/strbuf_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
     + REFTABLE_TEST_OBJS += reftable/basics_test.o
       
      
       ## reftable/constants.h (new) ##
     @@ reftable/record.c (new)
      +
      +#include "system.h"
      +#include "constants.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
      +#include "basics.h"
      +
      +int get_var_int(uint64_t *dest, struct string_view *in)
     @@ reftable/record.c (new)
      +
      +	/* This is simple and correct, but we could probably reuse the hash
      +	   fields. */
     -+	reftable_ref_record_clear(ref);
     ++	reftable_ref_record_release(ref);
      +	if (src->refname != NULL) {
      +		ref->refname = xstrdup(src->refname);
      +	}
     @@ reftable/record.c (new)
      +	printf("}\n");
      +}
      +
     -+static void reftable_ref_record_clear_void(void *rec)
     ++static void reftable_ref_record_release_void(void *rec)
      +{
     -+	reftable_ref_record_clear((struct reftable_ref_record *)rec);
     ++	reftable_ref_record_release((struct reftable_ref_record *)rec);
      +}
      +
     -+void reftable_ref_record_clear(struct reftable_ref_record *ref)
     ++void reftable_ref_record_release(struct reftable_ref_record *ref)
      +{
      +	reftable_free(ref->refname);
      +	reftable_free(ref->target);
     @@ reftable/record.c (new)
      +	.val_type = &reftable_ref_record_val_type,
      +	.encode = &reftable_ref_record_encode,
      +	.decode = &reftable_ref_record_decode,
     -+	.clear = &reftable_ref_record_clear_void,
     ++	.release = &reftable_ref_record_release_void,
      +	.is_deletion = &reftable_ref_record_is_deletion_void,
      +};
      +
     @@ reftable/record.c (new)
      +	strbuf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
      +}
      +
     -+static void reftable_obj_record_clear(void *rec)
     ++static void reftable_obj_record_release(void *rec)
      +{
      +	struct reftable_obj_record *obj = (struct reftable_obj_record *)rec;
      +	FREE_AND_NULL(obj->hash_prefix);
     @@ reftable/record.c (new)
      +		(const struct reftable_obj_record *)src_rec;
      +	int olen;
      +
     -+	reftable_obj_record_clear(obj);
     ++	reftable_obj_record_release(obj);
      +	*obj = *src;
      +	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
      +	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
     @@ reftable/record.c (new)
      +	.val_type = &reftable_obj_record_val_type,
      +	.encode = &reftable_obj_record_encode,
      +	.decode = &reftable_obj_record_decode,
     -+	.clear = &reftable_obj_record_clear,
     ++	.release = &reftable_obj_record_release,
      +	.is_deletion = not_a_deletion,
      +};
      +
     @@ reftable/record.c (new)
      +	const struct reftable_log_record *src =
      +		(const struct reftable_log_record *)src_rec;
      +
     -+	reftable_log_record_clear(dst);
     ++	reftable_log_record_release(dst);
      +	*dst = *src;
      +	if (dst->refname != NULL) {
      +		dst->refname = xstrdup(dst->refname);
     @@ reftable/record.c (new)
      +	}
      +}
      +
     -+static void reftable_log_record_clear_void(void *rec)
     ++static void reftable_log_record_release_void(void *rec)
      +{
      +	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     -+	reftable_log_record_clear(r);
     ++	reftable_log_record_release(r);
      +}
      +
     -+void reftable_log_record_clear(struct reftable_log_record *r)
     ++void reftable_log_record_release(struct reftable_log_record *r)
      +{
      +	reftable_free(r->refname);
      +	reftable_free(r->new_hash);
     @@ reftable/record.c (new)
      +	.val_type = &reftable_log_record_val_type,
      +	.encode = &reftable_log_record_encode,
      +	.decode = &reftable_log_record_decode,
     -+	.clear = &reftable_log_record_clear_void,
     ++	.release = &reftable_log_record_release_void,
      +	.is_deletion = &reftable_log_record_is_deletion_void,
      +};
      +
     @@ reftable/record.c (new)
      +
      +void reftable_record_destroy(struct reftable_record *rec)
      +{
     -+	reftable_record_clear(rec);
     ++	reftable_record_release(rec);
      +	reftable_free(reftable_record_yield(rec));
      +}
      +
     @@ reftable/record.c (new)
      +	dst->offset = src->offset;
      +}
      +
     -+static void reftable_index_record_clear(void *rec)
     ++static void reftable_index_record_release(void *rec)
      +{
      +	struct reftable_index_record *idx = (struct reftable_index_record *)rec;
      +	strbuf_release(&idx->last_key);
     @@ reftable/record.c (new)
      +	.val_type = &reftable_index_record_val_type,
      +	.encode = &reftable_index_record_encode,
      +	.decode = &reftable_index_record_decode,
     -+	.clear = &reftable_index_record_clear,
     ++	.release = &reftable_index_record_release,
      +	.is_deletion = &not_a_deletion,
      +};
      +
     @@ reftable/record.c (new)
      +	return rec->ops->decode(rec->data, key, extra, src, hash_size);
      +}
      +
     -+void reftable_record_clear(struct reftable_record *rec)
     ++void reftable_record_release(struct reftable_record *rec)
      +{
     -+	rec->ops->clear(rec->data);
     ++	rec->ops->release(rec->data);
      +}
      +
      +int reftable_record_is_deletion(struct reftable_record *rec)
     @@ reftable/record.h (new)
      +#ifndef RECORD_H
      +#define RECORD_H
      +
     -+#include "reftable.h"
     -+#include "strbuf.h"
      +#include "system.h"
      +
     ++#include <stdint.h>
     ++
     ++#include "reftable-record.h"
     ++
      +/*
      +  A substring of existing string data. This structure takes no responsibility
      +  for the lifetime of the data it points to.
     @@ reftable/record.h (new)
      +		      struct string_view src, int hash_size);
      +
      +	/* deallocate and null the record. */
     -+	void (*clear)(void *rec);
     ++	void (*release)(void *rec);
      +
      +	/* is this a tombstone? */
      +	int (*is_deletion)(const void *rec);
     @@ reftable/record.h (new)
      +int reftable_record_is_deletion(struct reftable_record *rec);
      +
      +/* zeroes out the embedded record */
     -+void reftable_record_clear(struct reftable_record *rec);
     ++void reftable_record_release(struct reftable_record *rec);
      +
      +/* clear and deallocate embedded record, and zero `rec`. */
      +void reftable_record_destroy(struct reftable_record *rec);
     @@ reftable/record_test.c (new)
      +#include "system.h"
      +#include "basics.h"
      +#include "constants.h"
     -+#include "reftable.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
      +
     @@ reftable/record_test.c (new)
      +	reftable_record_copy_from(&copy, rec, SHA1_SIZE);
      +	switch (reftable_record_type(&copy)) {
      +	case BLOCK_TYPE_REF:
     -+		assert(reftable_ref_record_equal(reftable_record_as_ref(&copy),
     ++		EXPECT(reftable_ref_record_equal(reftable_record_as_ref(&copy),
      +						 reftable_record_as_ref(rec),
      +						 SHA1_SIZE));
      +		break;
      +	case BLOCK_TYPE_LOG:
     -+		assert(reftable_log_record_equal(reftable_record_as_log(&copy),
     ++		EXPECT(reftable_log_record_equal(reftable_record_as_log(&copy),
      +						 reftable_record_as_log(rec),
      +						 SHA1_SIZE));
      +		break;
     @@ reftable/record_test.c (new)
      +		int n = put_var_int(&out, in);
      +		uint64_t got = 0;
      +
     -+		assert(n > 0);
     ++		EXPECT(n > 0);
      +		out.len = n;
      +		n = get_var_int(&got, &out);
     -+		assert(n > 0);
     ++		EXPECT(n > 0);
      +
     -+		assert(got == in);
     ++		EXPECT(got == in);
      +	}
      +}
      +
     @@ reftable/record_test.c (new)
      +		struct strbuf b = STRBUF_INIT;
      +		strbuf_addstr(&a, cases[i].a);
      +		strbuf_addstr(&b, cases[i].b);
     -+		assert(common_prefix_size(&a, &b) == cases[i].want);
     ++		EXPECT(common_prefix_size(&a, &b) == cases[i].want);
      +
      +		strbuf_release(&a);
      +		strbuf_release(&b);
     @@ reftable/record_test.c (new)
      +		reftable_record_from_ref(&rec, &in);
      +		test_copy(&rec);
      +
     -+		assert(reftable_record_val_type(&rec) == i);
     ++		EXPECT(reftable_record_val_type(&rec) == i);
      +
      +		reftable_record_key(&rec, &key);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     -+		assert(n > 0);
     ++		EXPECT(n > 0);
      +
      +		/* decode into a non-zero reftable_record to test for leaks. */
      +
      +		reftable_record_from_ref(&rec_out, &out);
      +		m = reftable_record_decode(&rec_out, key, i, dest, SHA1_SIZE);
     -+		assert(n == m);
     ++		EXPECT(n == m);
      +
     -+		assert((out.value != NULL) == (in.value != NULL));
     -+		assert((out.target_value != NULL) == (in.target_value != NULL));
     -+		assert((out.target != NULL) == (in.target != NULL));
     -+		reftable_record_clear(&rec_out);
     ++		EXPECT((out.value != NULL) == (in.value != NULL));
     ++		EXPECT((out.target_value != NULL) == (in.target_value != NULL));
     ++		EXPECT((out.target != NULL) == (in.target != NULL));
     ++		reftable_record_release(&rec_out);
      +
      +		strbuf_release(&key);
     -+		reftable_ref_record_clear(&in);
     ++		reftable_ref_record_release(&in);
      +	}
      +}
      +
     @@ reftable/record_test.c (new)
      +		}
      +	};
      +
     -+	assert(!reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	EXPECT(!reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
      +	in[1].update_index = in[0].update_index;
     -+	assert(reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     -+	reftable_log_record_clear(&in[0]);
     -+	reftable_log_record_clear(&in[1]);
     ++	EXPECT(reftable_log_record_equal(&in[0], &in[1], SHA1_SIZE));
     ++	reftable_log_record_release(&in[0]);
     ++	reftable_log_record_release(&in[1]);
      +}
      +
      +static void test_reftable_log_record_roundtrip(void)
     @@ reftable/record_test.c (new)
      +		reftable_record_key(&rec, &key);
      +
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     -+		assert(n >= 0);
     ++		EXPECT(n >= 0);
      +		reftable_record_from_log(&rec_out, &out);
      +		valtype = reftable_record_val_type(&rec);
      +		m = reftable_record_decode(&rec_out, key, valtype, dest,
      +					   SHA1_SIZE);
     -+		assert(n == m);
     ++		EXPECT(n == m);
      +
     -+		assert(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
     -+		reftable_log_record_clear(&in[i]);
     ++		EXPECT(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
     ++		reftable_log_record_release(&in[i]);
      +		strbuf_release(&key);
     -+		reftable_record_clear(&rec_out);
     ++		reftable_record_release(&rec_out);
      +	}
      +}
      +
     @@ reftable/record_test.c (new)
      +	uint32_t out;
      +	put_be24(dest, in);
      +	out = get_be24(dest);
     -+	assert(in == out);
     ++	EXPECT(in == out);
      +}
      +
      +static void test_key_roundtrip(void)
     @@ reftable/record_test.c (new)
      +	strbuf_addstr(&key, "refs/tags/bla");
      +	extra = 6;
      +	n = reftable_encode_key(&restart, dest, last_key, key, extra);
     -+	assert(!restart);
     -+	assert(n > 0);
     ++	EXPECT(!restart);
     ++	EXPECT(n > 0);
      +
      +	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
     -+	assert(n == m);
     -+	assert(0 == strbuf_cmp(&key, &roundtrip));
     -+	assert(rt_extra == extra);
     ++	EXPECT(n == m);
     ++	EXPECT(0 == strbuf_cmp(&key, &roundtrip));
     ++	EXPECT(rt_extra == extra);
      +
      +	strbuf_release(&last_key);
      +	strbuf_release(&key);
     @@ reftable/record_test.c (new)
      +		test_copy(&rec);
      +		reftable_record_key(&rec, &key);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     -+		assert(n > 0);
     ++		EXPECT(n > 0);
      +		extra = reftable_record_val_type(&rec);
      +		reftable_record_from_obj(&rec_out, &out);
      +		m = reftable_record_decode(&rec_out, key, extra, dest,
      +					   SHA1_SIZE);
     -+		assert(n == m);
     ++		EXPECT(n == m);
      +
     -+		assert(in.hash_prefix_len == out.hash_prefix_len);
     -+		assert(in.offset_len == out.offset_len);
     ++		EXPECT(in.hash_prefix_len == out.hash_prefix_len);
     ++		EXPECT(in.offset_len == out.offset_len);
      +
     -+		assert(!memcmp(in.hash_prefix, out.hash_prefix,
     ++		EXPECT(!memcmp(in.hash_prefix, out.hash_prefix,
      +			       in.hash_prefix_len));
     -+		assert(0 == memcmp(in.offsets, out.offsets,
     ++		EXPECT(0 == memcmp(in.offsets, out.offsets,
      +				   sizeof(uint64_t) * in.offset_len));
      +		strbuf_release(&key);
     -+		reftable_record_clear(&rec_out);
     ++		reftable_record_release(&rec_out);
      +	}
      +}
      +
     @@ reftable/record_test.c (new)
      +	reftable_record_key(&rec, &key);
      +	test_copy(&rec);
      +
     -+	assert(0 == strbuf_cmp(&key, &in.last_key));
     ++	EXPECT(0 == strbuf_cmp(&key, &in.last_key));
      +	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
     -+	assert(n > 0);
     ++	EXPECT(n > 0);
      +
      +	extra = reftable_record_val_type(&rec);
      +	reftable_record_from_index(&out_rec, &out);
      +	m = reftable_record_decode(&out_rec, key, extra, dest, SHA1_SIZE);
     -+	assert(m == n);
     ++	EXPECT(m == n);
      +
     -+	assert(in.offset == out.offset);
     ++	EXPECT(in.offset == out.offset);
      +
     -+	reftable_record_clear(&out_rec);
     ++	reftable_record_release(&out_rec);
      +	strbuf_release(&key);
      +	strbuf_release(&in.last_key);
      +}
      +
      +int record_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_reftable_log_record_equal",
     -+		      &test_reftable_log_record_equal);
     -+	add_test_case("test_reftable_log_record_roundtrip",
     -+		      &test_reftable_log_record_roundtrip);
     -+	add_test_case("test_reftable_ref_record_roundtrip",
     -+		      &test_reftable_ref_record_roundtrip);
     -+	add_test_case("test_varint_roundtrip", &test_varint_roundtrip);
     -+	add_test_case("test_key_roundtrip", &test_key_roundtrip);
     -+	add_test_case("test_common_prefix", &test_common_prefix);
     -+	add_test_case("test_reftable_obj_record_roundtrip",
     -+		      &test_reftable_obj_record_roundtrip);
     -+	add_test_case("test_reftable_index_record_roundtrip",
     -+		      &test_reftable_index_record_roundtrip);
     -+	add_test_case("test_u24_roundtrip", &test_u24_roundtrip);
     -+	return test_main(argc, argv);
     ++	test_reftable_log_record_equal();
     ++	test_reftable_log_record_roundtrip();
     ++	test_reftable_ref_record_roundtrip();
     ++	test_varint_roundtrip();
     ++	test_key_roundtrip();
     ++	test_common_prefix();
     ++	test_reftable_obj_record_roundtrip();
     ++	test_reftable_index_record_roundtrip();
     ++	test_u24_roundtrip();
     ++	return 0;
      +}
      
     + ## reftable/reftable-record.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef REFTABLE_RECORD_H
     ++#define REFTABLE_RECORD_H
     ++
     ++#include <stdint.h>
     ++
     ++/*
     ++ Basic data types
     ++
     ++ Reftables store the state of each ref in struct reftable_ref_record, and they
     ++ store a sequence of reflog updates in struct reftable_log_record.
     ++*/
     ++
     ++/* reftable_ref_record holds a ref database entry target_value */
     ++struct reftable_ref_record {
     ++	char *refname; /* Name of the ref, malloced. */
     ++	uint64_t update_index; /* Logical timestamp at which this value is
     ++				  written */
     ++	uint8_t *value; /* SHA1, or NULL. malloced. */
     ++	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
     ++	char *target; /* symref, or NULL. malloced. */
     ++};
     ++
     ++/* returns whether 'ref' represents a deletion */
     ++int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
     ++
     ++/* prints a reftable_ref_record onto stdout */
     ++void reftable_ref_record_print(struct reftable_ref_record *ref,
     ++			       uint32_t hash_id);
     ++
     ++/* frees and nulls all pointer values. */
     ++void reftable_ref_record_release(struct reftable_ref_record *ref);
     ++
     ++/* returns whether two reftable_ref_records are the same */
     ++int reftable_ref_record_equal(struct reftable_ref_record *a,
     ++			      struct reftable_ref_record *b, int hash_size);
     ++
     ++/* reftable_log_record holds a reflog entry */
     ++struct reftable_log_record {
     ++	char *refname;
     ++	uint64_t update_index; /* logical timestamp of a transactional update.
     ++				*/
     ++	uint8_t *new_hash;
     ++	uint8_t *old_hash;
     ++	char *name;
     ++	char *email;
     ++	uint64_t time;
     ++	int16_t tz_offset;
     ++	char *message;
     ++};
     ++
     ++/* returns whether 'ref' represents the deletion of a log record. */
     ++int reftable_log_record_is_deletion(const struct reftable_log_record *log);
     ++
     ++/* frees and nulls all pointer values. */
     ++void reftable_log_record_release(struct reftable_log_record *log);
     ++
     ++/* returns whether two records are equal. Useful for testing. */
     ++int reftable_log_record_equal(struct reftable_log_record *a,
     ++			      struct reftable_log_record *b, int hash_size);
     ++
     ++/* dumps a reftable_log_record on stdout, for debugging/testing. */
     ++void reftable_log_record_print(struct reftable_log_record *log,
     ++			       uint32_t hash_id);
     ++
     ++#endif
     +
       ## t/helper/test-reftable.c ##
      @@
     - 
       int cmd__reftable(int argc, const char **argv)
       {
     + 	basics_test_main(argc, argv);
     +-
      +	record_test_main(argc, argv);
     - 	strbuf_test_main(argc, argv);
       	return 0;
       }
  7:  757dd30fe2 !  8:  a358b052d5 reftable: reading/writing blocks
     @@ Metadata
       ## Commit message ##
          reftable: reading/writing blocks
      
     +    The reftable format is structured as a sequence of block. Within a block,
     +    records are prefix compressed, with an index of offsets for fully expand keys to
     +    enable binary search within blocks.
     +
     +    This commit provides the logic to read and write these blocks.
     +
          Includes a code snippet copied from zlib
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: XDIFF_OBJS += xdiff/xprepare.o
     - XDIFF_OBJS += xdiff/xutils.o
     +@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
       
       REFTABLE_OBJS += reftable/basics.o
     + REFTABLE_OBJS += reftable/error.o
      +REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/blocksource.o
       REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/compat.o
       REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/strbuf.o
      +REFTABLE_OBJS += reftable/zlib-compat.o
       
      +REFTABLE_TEST_OBJS += reftable/block_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/strbuf_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
     + REFTABLE_TEST_OBJS += reftable/basics_test.o
      
       ## reftable/.gitattributes (new) ##
      @@
     @@ reftable/block.c (new)
      +#include "blocksource.h"
      +#include "constants.h"
      +#include "record.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
      +#include "system.h"
      +#include "zlib.h"
      +
     @@ reftable/block.c (new)
      +	return -1;
      +}
      +
     -+
      +int block_writer_finish(struct block_writer *w)
      +{
      +	int i = 0;
     @@ reftable/block.c (new)
      +	return err;
      +}
      +
     -+void block_writer_clear(struct block_writer *bw)
     ++void block_writer_release(struct block_writer *bw)
      +{
      +	FREE_AND_NULL(bw->restarts);
      +	strbuf_release(&bw->last_key);
     @@ reftable/block.h (new)
      +
      +#include "basics.h"
      +#include "record.h"
     -+#include "reftable.h"
     ++#include "reftable-blocksource.h"
      +
      +/*
      +  Writes reftable blocks. The block_writer is reused across blocks to minimize
     @@ reftable/block.h (new)
      +int block_writer_finish(struct block_writer *w);
      +
      +/* clears out internally allocated block_writer members. */
     -+void block_writer_clear(struct block_writer *bw);
     ++void block_writer_release(struct block_writer *bw);
      +
      +/* Read a block. */
      +struct block_reader {
     @@ reftable/block_test.c (new)
      +#include "basics.h"
      +#include "constants.h"
      +#include "record.h"
     -+#include "reftable.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
      +
     -+struct binsearch_args {
     -+	int key;
     -+	int *arr;
     -+};
     -+
     -+static int binsearch_func(size_t i, void *void_args)
     -+{
     -+	struct binsearch_args *args = (struct binsearch_args *)void_args;
     -+
     -+	return args->key < args->arr[i];
     -+}
     -+
     -+static void test_binsearch(void)
     -+{
     -+	int arr[] = { 2, 4, 6, 8, 10 };
     -+	size_t sz = ARRAY_SIZE(arr);
     -+	struct binsearch_args args = {
     -+		.arr = arr,
     -+	};
     -+
     -+	int i = 0;
     -+	for (i = 1; i < 11; i++) {
     -+		int res;
     -+		args.key = i;
     -+		res = binsearch(sz, &binsearch_func, &args);
     -+
     -+		if (res < sz) {
     -+			assert(args.key < arr[res]);
     -+			if (res > 0) {
     -+				assert(args.key >= arr[res - 1]);
     -+			}
     -+		} else {
     -+			assert(args.key == 10 || args.key == 11);
     -+		}
     -+	}
     -+}
     -+
      +static void test_block_read_write(void)
      +{
      +	const int header_off = 21; /* random */
     @@ reftable/block_test.c (new)
      +		n = block_writer_add(&bw, &rec);
      +		ref.refname = NULL;
      +		ref.value = NULL;
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +	}
      +
      +	n = block_writer_finish(&bw);
     -+	assert(n > 0);
     ++	EXPECT(n > 0);
      +
     -+	block_writer_clear(&bw);
     ++	block_writer_release(&bw);
      +
      +	block_reader_init(&br, &block, header_off, block_size, SHA1_SIZE);
      +
     @@ reftable/block_test.c (new)
      +
      +	while (1) {
      +		int r = block_iter_next(&it, &rec);
     -+		assert(r >= 0);
     ++		EXPECT(r >= 0);
      +		if (r > 0) {
      +			break;
      +		}
     -+		assert_streq(names[j], ref.refname);
     ++		EXPECT_STREQ(names[j], ref.refname);
      +		j++;
      +	}
      +
     -+	reftable_record_clear(&rec);
     ++	reftable_record_release(&rec);
      +	block_iter_close(&it);
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/block_test.c (new)
      +		strbuf_addstr(&want, names[i]);
      +
      +		n = block_reader_seek(&br, &it, &want);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +
      +		n = block_iter_next(&it, &rec);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +
     -+		assert_streq(names[i], ref.refname);
     ++		EXPECT_STREQ(names[i], ref.refname);
      +
      +		want.len--;
      +		n = block_reader_seek(&br, &it, &want);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +
      +		n = block_iter_next(&it, &rec);
     -+		assert(n == 0);
     -+		assert_streq(names[10 * (i / 10)], ref.refname);
     ++		EXPECT(n == 0);
     ++		EXPECT_STREQ(names[10 * (i / 10)], ref.refname);
      +
      +		block_iter_close(&it);
      +	}
      +
     -+	reftable_record_clear(&rec);
     ++	reftable_record_release(&rec);
      +	reftable_block_done(&br.block);
      +	strbuf_release(&want);
      +	for (i = 0; i < N; i++) {
     @@ reftable/block_test.c (new)
      +
      +int block_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("binsearch", &test_binsearch);
     -+	add_test_case("block_read_write", &test_block_read_write);
     -+	return test_main(argc, argv);
     ++	test_block_read_write();
     ++	return 0;
      +}
      
       ## reftable/zlib-compat.c (new) ##
     @@ reftable/zlib-compat.c (new)
      
       ## t/helper/test-reftable.c ##
      @@
     - 
       int cmd__reftable(int argc, const char **argv)
       {
     + 	basics_test_main(argc, argv);
      +	block_test_main(argc, argv);
       	record_test_main(argc, argv);
     - 	strbuf_test_main(argc, argv);
       	return 0;
     + }
  8:  e30a7e0281 !  9:  24afac9c91 reftable: a generic binary tree implementation
     @@ Metadata
       ## Commit message ##
          reftable: a generic binary tree implementation
      
     -    This is necessary for building a OID => ref map on write
     +    The reftable format includes support for an (OID => ref) map. This map can speed
     +    up visibility and reachability checks. In particular, various operations along
     +    the fetch/push path within Gerrit have ben sped up by using this structure.
     +
     +    The map is constructed with help of a binary tree. Object IDs are hashes, so
     +    they are uniformly distributed. Hence, the tree does not attempt forced
     +    rebalancing.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/block.o
     + REFTABLE_OBJS += reftable/blocksource.o
     + REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/strbuf.o
      +REFTABLE_OBJS += reftable/tree.o
       REFTABLE_OBJS += reftable/zlib-compat.o
       
     ++REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/strbuf_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
     +-REFTABLE_TEST_OBJS += reftable/basics_test.o
      +REFTABLE_TEST_OBJS += reftable/tree_test.o
       
       TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
     @@ reftable/tree_test.c (new)
      +
      +#include "basics.h"
      +#include "record.h"
     -+#include "reftable.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
      +
     @@ reftable/tree_test.c (new)
      +
      +int tree_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_tree", &test_tree);
     -+	return test_main(argc, argv);
     ++	test_tree();
     ++	return 0;
      +}
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     + 	basics_test_main(argc, argv);
       	block_test_main(argc, argv);
       	record_test_main(argc, argv);
     - 	strbuf_test_main(argc, argv);
      +	tree_test_main(argc, argv);
       	return 0;
       }
  9:  68aee16e60 ! 10:  5f0b7c5592 reftable: write reftable files
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/blocksource.o
     + REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/record.o
     - REFTABLE_OBJS += reftable/strbuf.o
       REFTABLE_OBJS += reftable/tree.o
      +REFTABLE_OBJS += reftable/writer.o
       REFTABLE_OBJS += reftable/zlib-compat.o
       
     - REFTABLE_TEST_OBJS += reftable/block_test.o
     + REFTABLE_TEST_OBJS += reftable/basics_test.o
     +
     + ## reftable/reftable-writer.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef REFTABLE_WRITER_H
     ++#define REFTABLE_WRITER_H
     ++
     ++#include <stdint.h>
     ++
     ++#include "reftable-record.h"
     ++
     ++/*
     ++ Writing single reftables
     ++*/
     ++
     ++/* reftable_write_options sets options for writing a single reftable. */
     ++struct reftable_write_options {
     ++	/* boolean: do not pad out blocks to block size. */
     ++	unsigned unpadded : 1;
     ++
     ++	/* the blocksize. Should be less than 2^24. */
     ++	uint32_t block_size;
     ++
     ++	/* boolean: do not generate a SHA1 => ref index. */
     ++	unsigned skip_index_objects : 1;
     ++
     ++	/* how often to write complete keys in each block. */
     ++	int restart_interval;
     ++
     ++	/* 4-byte identifier ("sha1", "s256") of the hash.
     ++	 * Defaults to SHA1 if unset
     ++	 */
     ++	uint32_t hash_id;
     ++
     ++	/* boolean: do not check ref names for validity or dir/file conflicts.
     ++	 */
     ++	unsigned skip_name_check : 1;
     ++
     ++	/* boolean: copy log messages exactly. If unset, check that the message
     ++	 *   is a single line, and add '\n' if missing.
     ++	 */
     ++	unsigned exact_log_message : 1;
     ++};
     ++
     ++/* reftable_block_stats holds statistics for a single block type */
     ++struct reftable_block_stats {
     ++	/* total number of entries written */
     ++	int entries;
     ++	/* total number of key restarts */
     ++	int restarts;
     ++	/* total number of blocks */
     ++	int blocks;
     ++	/* total number of index blocks */
     ++	int index_blocks;
     ++	/* depth of the index */
     ++	int max_index_level;
     ++
     ++	/* offset of the first block for this type */
     ++	uint64_t offset;
     ++	/* offset of the top level index block for this type, or 0 if not
     ++	 * present */
     ++	uint64_t index_offset;
     ++};
     ++
     ++/* stats holds overall statistics for a single reftable */
     ++struct reftable_stats {
     ++	/* total number of blocks written. */
     ++	int blocks;
     ++	/* stats for ref data */
     ++	struct reftable_block_stats ref_stats;
     ++	/* stats for the SHA1 to ref map. */
     ++	struct reftable_block_stats obj_stats;
     ++	/* stats for index blocks */
     ++	struct reftable_block_stats idx_stats;
     ++	/* stats for log blocks */
     ++	struct reftable_block_stats log_stats;
     ++
     ++	/* disambiguation length of shortened object IDs. */
     ++	int object_id_len;
     ++};
     ++
     ++/* reftable_new_writer creates a new writer */
     ++struct reftable_writer *
     ++reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
     ++		    void *writer_arg, struct reftable_write_options *opts);
     ++
     ++/* Set the range of update indices for the records we will add. When writing a
     ++   table into a stack, the min should be at least
     ++   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
     ++
     ++   For transactional updates to a stack, typically min==max, and the
     ++   update_index can be obtained by inspeciting the stack. When converting an
     ++   existing ref database into a single reftable, this would be a range of
     ++   update-index timestamps.
     ++ */
     ++void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
     ++				uint64_t max);
     ++
     ++/*
     ++  Add a reftable_ref_record. The record should have names that come after
     ++  already added records.
     ++
     ++  The update_index must be within the limits set by
     ++  reftable_writer_set_limits(), or REFTABLE_API_ERROR is returned. It is an
     ++  REFTABLE_API_ERROR error to write a ref record after a log record.
     ++*/
     ++int reftable_writer_add_ref(struct reftable_writer *w,
     ++			    struct reftable_ref_record *ref);
     ++
     ++/*
     ++  Convenience function to add multiple reftable_ref_records; the function sorts
     ++  the records before adding them, reordering the records array passed in.
     ++*/
     ++int reftable_writer_add_refs(struct reftable_writer *w,
     ++			     struct reftable_ref_record *refs, int n);
     ++
     ++/*
     ++  adds reftable_log_records. Log records are keyed by (refname, decreasing
     ++  update_index). The key for the record added must come after the already added
     ++  log records.
     ++*/
     ++int reftable_writer_add_log(struct reftable_writer *w,
     ++			    struct reftable_log_record *log);
     ++
     ++/*
     ++  Convenience function to add multiple reftable_log_records; the function sorts
     ++  the records before adding them, reordering records array passed in.
     ++*/
     ++int reftable_writer_add_logs(struct reftable_writer *w,
     ++			     struct reftable_log_record *logs, int n);
     ++
     ++/* reftable_writer_close finalizes the reftable. The writer is retained so
     ++ * statistics can be inspected. */
     ++int reftable_writer_close(struct reftable_writer *w);
     ++
     ++/* writer_stats returns the statistics on the reftable being written.
     ++
     ++   This struct becomes invalid when the writer is freed.
     ++ */
     ++const struct reftable_stats *writer_stats(struct reftable_writer *w);
     ++
     ++/* reftable_writer_free deallocates memory for the writer */
     ++void reftable_writer_free(struct reftable_writer *w);
     ++
     ++#endif
      
       ## reftable/writer.c (new) ##
      @@
     @@ reftable/writer.c (new)
      +#include "block.h"
      +#include "constants.h"
      +#include "record.h"
     -+#include "reftable.h"
      +#include "tree.h"
     ++#include "reftable-error.h"
      +
      +/* finishes a block, and writes it to storage */
      +static int writer_flush_block(struct reftable_writer *w);
     @@ reftable/writer.c (new)
      +	w->block_writer->restart_interval = w->opts.restart_interval;
      +}
      +
     ++static struct strbuf reftable_empty_strbuf = STRBUF_INIT;
     ++
      +struct reftable_writer *
      +reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts)
     @@ reftable/writer.c (new)
      +	int err = 0;
      +	int i = 0;
      +	QSORT(logs, n, reftable_log_record_compare_key);
     ++
      +	for (i = 0; err == 0 && i < n; i++) {
      +		err = reftable_writer_add_log(w, &logs[i]);
      +	}
     @@ reftable/writer.c (new)
      +
      +done:
      +	/* free up memory. */
     -+	block_writer_clear(&w->block_writer_data);
     ++	block_writer_release(&w->block_writer_data);
      +	writer_clear_index(w);
      +	strbuf_release(&w->last_key);
      +	return err;
     @@ reftable/writer.h (new)
      +
      +#include "basics.h"
      +#include "block.h"
     -+#include "reftable.h"
     -+#include "strbuf.h"
      +#include "tree.h"
     ++#include "reftable-writer.h"
      +
      +struct reftable_writer {
      +	int (*write)(void *, const void *, size_t);
 10:  c196de7f06 ! 11:  9aa2caade8 reftable: read reftable files
     @@ Metadata
       ## Commit message ##
          reftable: read reftable files
      
     +    This supports reading a single reftable file.
     +
     +    The commit introduces an abstract iterator type, which captures the usecases
     +    both of reading individual refs, and iterating over a segment of the ref
     +    namespace.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/block.o
     +@@ Makefile: REFTABLE_OBJS += reftable/basics.o
     + REFTABLE_OBJS += reftable/error.o
     + REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/blocksource.o
     - REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/compat.o
      +REFTABLE_OBJS += reftable/iter.o
     + REFTABLE_OBJS += reftable/publicbasics.o
      +REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
      +REFTABLE_OBJS += reftable/reftable.o
     - REFTABLE_OBJS += reftable/strbuf.o
       REFTABLE_OBJS += reftable/tree.o
       REFTABLE_OBJS += reftable/writer.o
     + REFTABLE_OBJS += reftable/zlib-compat.o
      
       ## reftable/iter.c (new) ##
      @@
     @@ reftable/iter.c (new)
      +#include "block.h"
      +#include "constants.h"
      +#include "reader.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
      +
      +int iterator_is_null(struct reftable_iterator *it)
      +{
     @@ reftable/iter.c (new)
      +int reftable_iterator_next_ref(struct reftable_iterator *it,
      +			       struct reftable_ref_record *ref)
      +{
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_ref(&rec, ref);
      +	return iterator_next(it, &rec);
      +}
     @@ reftable/iter.c (new)
      +int reftable_iterator_next_log(struct reftable_iterator *it,
      +			       struct reftable_log_record *log)
      +{
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_log(&rec, log);
      +	return iterator_next(it, &rec);
      +}
     @@ reftable/iter.c (new)
      +		}
      +
      +		if (fri->double_check) {
     -+			struct reftable_iterator it = { 0 };
     ++			struct reftable_iterator it = { NULL };
      +
      +			err = reftable_table_seek_ref(&fri->tab, &it,
      +						      ref->refname);
     @@ reftable/iter.c (new)
      +		}
      +	}
      +
     -+	reftable_ref_record_clear(ref);
     ++	reftable_ref_record_release(ref);
      +	return err;
      +}
      +
     @@ reftable/iter.h (new)
      +#ifndef ITER_H
      +#define ITER_H
      +
     ++#include "system.h"
      +#include "block.h"
      +#include "record.h"
     -+#include "strbuf.h"
     ++
     ++#include "reftable-iterator.h"
     ++#include "reftable-generic.h"
      +
      +struct reftable_iterator_vtable {
      +	int (*next)(void *iter_arg, struct reftable_record *rec);
     @@ reftable/reader.c (new)
      +#include "constants.h"
      +#include "iter.h"
      +#include "record.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
      +#include "tree.h"
      +
      +uint64_t block_source_size(struct reftable_block_source *source)
     @@ reftable/reader.c (new)
      +int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
      +		const char *name)
      +{
     -+	struct reftable_block footer = { 0 };
     -+	struct reftable_block header = { 0 };
     ++	struct reftable_block footer = { NULL };
     ++	struct reftable_block header = { NULL };
      +	int err = 0;
      +
      +	memset(r, 0, sizeof(struct reftable_reader));
     @@ reftable/reader.c (new)
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
      +							 DEFAULT_BLOCK_SIZE;
     -+	struct reftable_block block = { 0 };
     ++	struct reftable_block block = { NULL };
      +	uint8_t block_typ = 0;
      +	int err = 0;
      +	uint32_t header_off = next_off ? 0 : header_size(r->version);
     @@ reftable/reader.c (new)
      +			       struct reftable_record *rec)
      +{
      +	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
     -+	struct reftable_record want_index_rec = { 0 };
     ++	struct reftable_record want_index_rec = { NULL };
      +	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
     -+	struct reftable_record index_result_rec = { 0 };
     ++	struct reftable_record index_result_rec = { NULL };
      +	struct table_iter index_iter = TABLE_ITER_INIT;
      +	struct table_iter next = TABLE_ITER_INIT;
      +	int err = 0;
     @@ reftable/reader.c (new)
      +done:
      +	block_iter_close(&next.bi);
      +	table_iter_close(&index_iter);
     -+	reftable_record_clear(&want_index_rec);
     -+	reftable_record_clear(&index_result_rec);
     ++	reftable_record_release(&want_index_rec);
     ++	reftable_record_release(&index_result_rec);
      +	return err;
      +}
      +
     @@ reftable/reader.c (new)
      +	struct reftable_ref_record ref = {
      +		.refname = (char *)name,
      +	};
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_ref(&rec, &ref);
      +	return reader_seek(r, it, &rec);
      +}
     @@ reftable/reader.c (new)
      +		.refname = (char *)name,
      +		.update_index = update_index,
      +	};
     -+	struct reftable_record rec = { 0 };
     ++	struct reftable_record rec = { NULL };
      +	reftable_record_from_log(&rec, &log);
      +	return reader_seek(r, it, &rec);
      +}
     @@ reftable/reader.c (new)
      +		.hash_prefix = oid,
      +		.hash_prefix_len = r->object_id_len,
      +	};
     -+	struct reftable_record want_rec = { 0 };
     -+	struct reftable_iterator oit = { 0 };
     -+	struct reftable_obj_record got = { 0 };
     -+	struct reftable_record got_rec = { 0 };
     ++	struct reftable_record want_rec = { NULL };
     ++	struct reftable_iterator oit = { NULL };
     ++	struct reftable_obj_record got = { NULL };
     ++	struct reftable_record got_rec = { NULL };
      +	int err = 0;
      +	struct indexed_table_ref_iter *itr = NULL;
      +
     @@ reftable/reader.c (new)
      +
      +done:
      +	reftable_iterator_destroy(&oit);
     -+	reftable_record_clear(&got_rec);
     ++	reftable_record_release(&got_rec);
      +	return err;
      +}
      +
     @@ reftable/reader.h (new)
      +
      +#include "block.h"
      +#include "record.h"
     -+#include "reftable.h"
     ++#include "reftable-iterator.h"
     ++#include "reftable-reader.h"
      +
      +uint64_t block_source_size(struct reftable_block_source *source);
      +
     @@ reftable/reader.h (new)
      +	uint64_t (*max_update_index)(void *tab);
      +};
      +
     -+int reftable_table_seek_record(struct reftable_table *tab,
     -+			       struct reftable_iterator *it,
     -+			       struct reftable_record *rec);
     -+
      +#endif
      
     - ## reftable/reftable.c (new) ##
     + ## reftable/reftable-iterator.h (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/reftable.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "reftable.h"
     -+#include "record.h"
     -+#include "reader.h"
     ++#ifndef REFTABLE_ITERATOR_H
     ++#define REFTABLE_ITERATOR_H
      +
     -+static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     -+				     struct reftable_record *rec)
     -+{
     -+	return reader_seek((struct reftable_reader *)tab, it, rec);
     -+}
     ++#include "reftable-record.h"
      +
     -+static uint32_t reftable_reader_hash_id_void(void *tab)
     -+{
     -+	return reftable_reader_hash_id((struct reftable_reader *)tab);
     -+}
     ++/* iterator is the generic interface for walking over data stored in a
     ++   reftable.
     ++*/
     ++struct reftable_iterator {
     ++	struct reftable_iterator_vtable *ops;
     ++	void *iter_arg;
     ++};
      +
     -+static uint64_t reftable_reader_min_update_index_void(void *tab)
     -+{
     -+	return reftable_reader_min_update_index((struct reftable_reader *)tab);
     -+}
     ++/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
     ++   end of iteration.
     ++*/
     ++int reftable_iterator_next_ref(struct reftable_iterator *it,
     ++			       struct reftable_ref_record *ref);
      +
     -+static uint64_t reftable_reader_max_update_index_void(void *tab)
     -+{
     -+	return reftable_reader_max_update_index((struct reftable_reader *)tab);
     -+}
     ++/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
     ++   end of iteration.
     ++*/
     ++int reftable_iterator_next_log(struct reftable_iterator *it,
     ++			       struct reftable_log_record *log);
      +
     -+static struct reftable_table_vtable reader_vtable = {
     -+	.seek_record = reftable_reader_seek_void,
     -+	.hash_id = reftable_reader_hash_id_void,
     -+	.min_update_index = reftable_reader_min_update_index_void,
     -+	.max_update_index = reftable_reader_max_update_index_void,
     -+};
     ++/* releases resources associated with an iterator. */
     ++void reftable_iterator_destroy(struct reftable_iterator *it);
      +
     -+int reftable_table_seek_ref(struct reftable_table *tab,
     -+			    struct reftable_iterator *it, const char *name)
     -+{
     -+	struct reftable_ref_record ref = {
     -+		.refname = (char *)name,
     -+	};
     -+	struct reftable_record rec = { 0 };
     -+	reftable_record_from_ref(&rec, &ref);
     -+	return tab->ops->seek_record(tab->table_arg, it, &rec);
     -+}
     ++#endif
     +
     + ## reftable/reftable-reader.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
      +
     -+void reftable_table_from_reader(struct reftable_table *tab,
     -+				struct reftable_reader *reader)
     -+{
     -+	assert(tab->ops == NULL);
     -+	tab->ops = &reader_vtable;
     -+	tab->table_arg = reader;
     -+}
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
      +
     -+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     -+			    struct reftable_ref_record *ref)
     -+{
     -+	struct reftable_iterator it = { 0 };
     -+	int err = reftable_table_seek_ref(tab, &it, name);
     -+	if (err)
     -+		goto done;
     ++#ifndef REFTABLE_READER_H
     ++#define REFTABLE_READER_H
      +
     -+	err = reftable_iterator_next_ref(&it, ref);
     -+	if (err)
     -+		goto done;
     ++#include "reftable-iterator.h"
     ++#include "reftable-blocksource.h"
      +
     -+	if (strcmp(ref->refname, name) ||
     -+	    reftable_ref_record_is_deletion(ref)) {
     -+		reftable_ref_record_clear(ref);
     -+		err = 1;
     -+		goto done;
     -+	}
     ++/*
     ++ Reading single tables
      +
     -+done:
     -+	reftable_iterator_destroy(&it);
     -+	return err;
     -+}
     ++ The follow routines are for reading single files. For an application-level
     ++ interface, skip ahead to struct reftable_merged_table and struct
     ++ reftable_stack.
     ++*/
      +
     -+int reftable_table_seek_record(struct reftable_table *tab,
     -+			       struct reftable_iterator *it,
     -+			       struct reftable_record *rec)
     -+{
     -+	return tab->ops->seek_record(tab->table_arg, it, rec);
     -+}
     ++/* The reader struct is a handle to an open reftable file. */
     ++struct reftable_reader;
      +
     -+uint64_t reftable_table_max_update_index(struct reftable_table *tab)
     -+{
     -+	return tab->ops->max_update_index(tab->table_arg);
     -+}
     ++/* reftable_new_reader opens a reftable for reading. If successful, returns 0
     ++ * code and sets pp. The name is used for creating a stack. Typically, it is the
     ++ * basename of the file. The block source `src` is owned by the reader, and is
     ++ * closed on calling reftable_reader_destroy().
     ++ */
     ++int reftable_new_reader(struct reftable_reader **pp,
     ++			struct reftable_block_source *src, const char *name);
     ++
     ++/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
     ++   in the table.  To seek to the start of the table, use name = "".
     ++
     ++   example:
     ++
     ++   struct reftable_reader *r = NULL;
     ++   int err = reftable_new_reader(&r, &src, "filename");
     ++   if (err < 0) { ... }
     ++   struct reftable_iterator it  = {0};
     ++   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
     ++   if (err < 0) { ... }
     ++   struct reftable_ref_record ref  = {0};
     ++   while (1) {
     ++     err = reftable_iterator_next_ref(&it, &ref);
     ++     if (err > 0) {
     ++       break;
     ++     }
     ++     if (err < 0) {
     ++       ..error handling..
     ++     }
     ++     ..found..
     ++   }
     ++   reftable_iterator_destroy(&it);
     ++   reftable_ref_record_release(&ref);
     ++ */
     ++int reftable_reader_seek_ref(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name);
      +
     -+uint64_t reftable_table_min_update_index(struct reftable_table *tab)
     -+{
     -+	return tab->ops->min_update_index(tab->table_arg);
     -+}
     ++/* returns the hash ID used in this table. */
     ++uint32_t reftable_reader_hash_id(struct reftable_reader *r);
      +
     -+uint32_t reftable_table_hash_id(struct reftable_table *tab)
     -+{
     -+	return tab->ops->hash_id(tab->table_arg);
     -+}
     ++/* seek to logs for the given name, older than update_index. To seek to the
     ++   start of the table, use name = "".
     ++ */
     ++int reftable_reader_seek_log_at(struct reftable_reader *r,
     ++				struct reftable_iterator *it, const char *name,
     ++				uint64_t update_index);
     ++
     ++/* seek to newest log entry for given name. */
     ++int reftable_reader_seek_log(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name);
     ++
     ++/* closes and deallocates a reader. */
     ++void reftable_reader_free(struct reftable_reader *);
     ++
     ++/* return an iterator for the refs pointing to `oid`. */
     ++int reftable_reader_refs_for(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, uint8_t *oid);
     ++
     ++/* return the max_update_index for a table */
     ++uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
     ++
     ++/* return the min_update_index for a table */
     ++uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
     ++
     ++#endif
 11:  bf6b929b86 ! 12:  581a4200d6 reftable: file level tests
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: file level tests
     +    reftable: reftable file level tests
     +
     +    With support for reading and writing files in place, we can construct files (in
     +    memory) and attempt to read them back.
     +
     +    Because some sections of the format are optional (eg. indices, log entries), we
     +    have to exercise this code using multiple sizes of input data
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
      @@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     - 
     + REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
      +REFTABLE_TEST_OBJS += reftable/reftable_test.o
     - REFTABLE_TEST_OBJS += reftable/strbuf_test.o
       REFTABLE_TEST_OBJS += reftable/test_framework.o
       REFTABLE_TEST_OBJS += reftable/tree_test.o
     + 
      
       ## reftable/reftable_test.c (new) ##
      @@
     @@ reftable/reftable_test.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "reftable.h"
     -+
      +#include "system.h"
      +
      +#include "basics.h"
     @@ reftable/reftable_test.c (new)
      +#include "record.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
     ++#include "reftable-stack.h"
      +
      +static const int update_index = 5;
      +
     @@ reftable/reftable_test.c (new)
      +	uint8_t in[] = "hello";
      +	strbuf_add(&buf, in, sizeof(in));
      +	block_source_from_strbuf(&source, &buf);
     -+	assert(block_source_size(&source) == 6);
     ++	EXPECT(block_source_size(&source) == 6);
      +	n = block_source_read_block(&source, &out, 0, sizeof(in));
     -+	assert(n == sizeof(in));
     -+	assert(!memcmp(in, out.data, n));
     ++	EXPECT(n == sizeof(in));
     ++	EXPECT(!memcmp(in, out.data, n));
      +	reftable_block_done(&out);
      +
      +	n = block_source_read_block(&source, &out, 1, 2);
     -+	assert(n == 2);
     -+	assert(!memcmp(out.data, "el", 2));
     ++	EXPECT(n == 2);
     ++	EXPECT(!memcmp(out.data, "el", 2));
      +
      +	reftable_block_done(&out);
      +	block_source_close(&source);
     @@ reftable/reftable_test.c (new)
      +		(*names)[i] = xstrdup(name);
      +
      +		n = reftable_writer_add_ref(w, &ref);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +	}
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/reftable_test.c (new)
      +		log.message = "message";
      +
      +		n = reftable_writer_add_log(w, &log);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +	}
      +
      +	n = reftable_writer_close(w);
     -+	assert(n == 0);
     ++	EXPECT(n == 0);
      +
      +	stats = writer_stats(w);
      +	for (i = 0; i < stats->ref_stats.blocks; i++) {
     @@ reftable/reftable_test.c (new)
      +		if (off == 0) {
      +			off = header_size((hash_id == SHA256_ID) ? 2 : 1);
      +		}
     -+		assert(buf->buf[off] == 'r');
     ++		EXPECT(buf->buf[off] == 'r');
      +	}
      +
     -+	assert(stats->log_stats.blocks > 0);
     ++	EXPECT(stats->log_stats.blocks > 0);
      +	reftable_writer_free(w);
      +}
      +
     @@ reftable/reftable_test.c (new)
      +	log.new_hash = hash2;
      +	reftable_writer_set_limits(w, update_index, update_index);
      +	err = reftable_writer_add_log(w, &log);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	err = reftable_writer_close(w);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	reftable_writer_free(w);
      +	strbuf_release(&buf);
      +}
     @@ reftable/reftable_test.c (new)
      +		ref.update_index = i;
      +
      +		err = reftable_writer_add_ref(w, &ref);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +	for (i = 0; i < N; i++) {
      +		uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     @@ reftable/reftable_test.c (new)
      +		log.new_hash = hash2;
      +
      +		err = reftable_writer_add_log(w, &log);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +
      +	n = reftable_writer_close(w);
     -+	assert(n == 0);
     ++	EXPECT(n == 0);
      +
      +	stats = writer_stats(w);
     -+	assert(stats->log_stats.blocks > 0);
     ++	EXPECT(stats->log_stats.blocks > 0);
      +	reftable_writer_free(w);
      +	w = NULL;
      +
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.log");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_reader_seek_ref(&rd, &it, names[N - 1]);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_iterator_next_ref(&it, &ref);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	/* end of iteration. */
      +	err = reftable_iterator_next_ref(&it, &ref);
     -+	assert(0 < err);
     ++	EXPECT(0 < err);
      +
      +	reftable_iterator_destroy(&it);
     -+	reftable_ref_record_clear(&ref);
     ++	reftable_ref_record_release(&ref);
      +
      +	err = reftable_reader_seek_log(&rd, &it, "");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	i = 0;
      +	while (1) {
     @@ reftable/reftable_test.c (new)
      +			break;
      +		}
      +
     -+		assert_err(err);
     -+		assert_streq(names[i], log.refname);
     -+		assert(i == log.update_index);
     ++		EXPECT_ERR(err);
     ++		EXPECT_STREQ(names[i], log.refname);
     ++		EXPECT(i == log.update_index);
      +		i++;
     -+		reftable_log_record_clear(&log);
     ++		reftable_log_record_release(&log);
      +	}
      +
     -+	assert(i == N);
     ++	EXPECT(i == N);
      +	reftable_iterator_destroy(&it);
      +
      +	/* cleanup. */
     @@ reftable/reftable_test.c (new)
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_reader_seek_ref(&rd, &it, "");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	while (1) {
      +		struct reftable_ref_record ref = { NULL };
      +		int r = reftable_iterator_next_ref(&it, &ref);
     -+		assert(r >= 0);
     ++		EXPECT(r >= 0);
      +		if (r > 0) {
      +			break;
      +		}
     -+		assert(0 == strcmp(names[j], ref.refname));
     -+		assert(update_index == ref.update_index);
     ++		EXPECT(0 == strcmp(names[j], ref.refname));
     ++		EXPECT(update_index == ref.update_index);
      +
      +		j++;
     -+		reftable_ref_record_clear(&ref);
     ++		reftable_ref_record_release(&ref);
      +	}
     -+	assert(j == N);
     ++	EXPECT(j == N);
      +	reftable_iterator_destroy(&it);
      +	strbuf_release(&buf);
      +	free_names(names);
     @@ reftable/reftable_test.c (new)
      +	struct strbuf buf = STRBUF_INIT;
      +	int N = 1;
      +	write_table(&names, &buf, N, 4096, SHA1_ID);
     -+	assert(buf.len < 200);
     ++	EXPECT(buf.len < 200);
      +	strbuf_release(&buf);
      +	free_names(names);
      +}
     @@ reftable/reftable_test.c (new)
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_reader_seek_ref(&rd, &it, names[0]);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_iterator_next_log(&it, &log);
     -+	assert(err == REFTABLE_API_ERROR);
     ++	EXPECT(err == REFTABLE_API_ERROR);
      +
      +	strbuf_release(&buf);
      +	for (i = 0; i < N; i++) {
     @@ reftable/reftable_test.c (new)
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
     -+	assert_err(err);
     -+	assert(hash_id == reftable_reader_hash_id(&rd));
     ++	EXPECT_ERR(err);
     ++	EXPECT(hash_id == reftable_reader_hash_id(&rd));
      +
      +	if (!index) {
      +		rd.ref_offsets.index_offset = 0;
      +	} else {
     -+		assert(rd.ref_offsets.index_offset > 0);
     ++		EXPECT(rd.ref_offsets.index_offset > 0);
      +	}
      +
      +	for (i = 1; i < N; i++) {
      +		int err = reftable_reader_seek_ref(&rd, &it, names[i]);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +		err = reftable_iterator_next_ref(&it, &ref);
     -+		assert_err(err);
     -+		assert(0 == strcmp(names[i], ref.refname));
     -+		assert(i == ref.value[0]);
     ++		EXPECT_ERR(err);
     ++		EXPECT(0 == strcmp(names[i], ref.refname));
     ++		EXPECT(i == ref.value[0]);
      +
     -+		reftable_ref_record_clear(&ref);
     ++		reftable_ref_record_release(&ref);
      +		reftable_iterator_destroy(&it);
      +	}
      +
     @@ reftable/reftable_test.c (new)
      +	if (err == 0) {
      +		struct reftable_ref_record ref = { NULL };
      +		int err = reftable_iterator_next_ref(&it, &ref);
     -+		assert(err > 0);
     ++		EXPECT(err > 0);
      +	} else {
     -+		assert(err > 0);
     ++		EXPECT(err > 0);
      +	}
      +
      +	strbuf_release(&pastLast);
     @@ reftable/reftable_test.c (new)
      +		 */
      +		/* blocks. */
      +		n = reftable_writer_add_ref(w, &ref);
     -+		assert(n == 0);
     ++		EXPECT(n == 0);
      +
      +		if (!memcmp(hash1, want_hash, SHA1_SIZE) ||
      +		    !memcmp(hash2, want_hash, SHA1_SIZE)) {
     @@ reftable/reftable_test.c (new)
      +	}
      +
      +	n = reftable_writer_close(w);
     -+	assert(n == 0);
     ++	EXPECT(n == 0);
      +
      +	reftable_writer_free(w);
      +	w = NULL;
     @@ reftable/reftable_test.c (new)
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	if (!indexed) {
      +		rd.obj_offsets.is_present = 0;
      +	}
      +
      +	err = reftable_reader_seek_ref(&rd, &it, "");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	reftable_iterator_destroy(&it);
      +
      +	err = reftable_reader_refs_for(&rd, &it, want_hash);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	j = 0;
      +	while (1) {
      +		int err = reftable_iterator_next_ref(&it, &ref);
     -+		assert(err >= 0);
     ++		EXPECT(err >= 0);
      +		if (err > 0) {
      +			break;
      +		}
      +
     -+		assert(j < want_names_len);
     -+		assert(0 == strcmp(ref.refname, want_names[j]));
     ++		EXPECT(j < want_names_len);
     ++		EXPECT(0 == strcmp(ref.refname, want_names[j]));
      +		j++;
     -+		reftable_ref_record_clear(&ref);
     ++		reftable_ref_record_release(&ref);
      +	}
     -+	assert(j == want_names_len);
     ++	EXPECT(j == want_names_len);
      +
      +	strbuf_release(&buf);
      +	free_names(want_names);
     @@ reftable/reftable_test.c (new)
      +	reftable_writer_set_limits(w, 1, 1);
      +
      +	err = reftable_writer_close(w);
     -+	assert(err == REFTABLE_EMPTY_TABLE_ERROR);
     ++	EXPECT(err == REFTABLE_EMPTY_TABLE_ERROR);
      +	reftable_writer_free(w);
      +
     -+	assert(buf.len == header_size(1) + footer_size(1));
     ++	EXPECT(buf.len == header_size(1) + footer_size(1));
      +
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = reftable_new_reader(&rd, &source, "filename");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_reader_seek_ref(rd, &it, "");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_iterator_next_ref(&it, &rec);
     -+	assert(err > 0);
     ++	EXPECT(err > 0);
      +
      +	reftable_iterator_destroy(&it);
      +	reftable_reader_free(rd);
     @@ reftable/reftable_test.c (new)
      +
      +int reftable_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_log_write_read", test_log_write_read);
     -+	add_test_case("test_table_read_write_seek_linear_sha256",
     -+		      &test_table_read_write_seek_linear_sha256);
     -+	add_test_case("test_log_buffer_size", test_log_buffer_size);
     -+	add_test_case("test_table_write_small_table",
     -+		      &test_table_write_small_table);
     -+	add_test_case("test_buffer", &test_buffer);
     -+	add_test_case("test_table_read_api", &test_table_read_api);
     -+	add_test_case("test_table_read_write_sequential",
     -+		      &test_table_read_write_sequential);
     -+	add_test_case("test_table_read_write_seek_linear",
     -+		      &test_table_read_write_seek_linear);
     -+	add_test_case("test_table_read_write_seek_index",
     -+		      &test_table_read_write_seek_index);
     -+	add_test_case("test_table_read_write_refs_for_no_index",
     -+		      &test_table_refs_for_no_index);
     -+	add_test_case("test_table_read_write_refs_for_obj_index",
     -+		      &test_table_refs_for_obj_index);
     -+	add_test_case("test_table_empty", &test_table_empty);
     -+	return test_main(argc, argv);
     ++	test_log_write_read();
     ++	test_table_read_write_seek_linear_sha256();
     ++	test_log_buffer_size();
     ++	test_table_write_small_table();
     ++	test_buffer();
     ++	test_table_read_api();
     ++	test_table_read_write_sequential();
     ++	test_table_read_write_seek_linear();
     ++	test_table_read_write_seek_index();
     ++	test_table_refs_for_no_index();
     ++	test_table_refs_for_obj_index();
     ++	test_table_empty();
     ++	return 0;
      +}
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     - {
     + 	basics_test_main(argc, argv);
       	block_test_main(argc, argv);
       	record_test_main(argc, argv);
      +	reftable_test_main(argc, argv);
     - 	strbuf_test_main(argc, argv);
       	tree_test_main(argc, argv);
       	return 0;
     + }
 12:  4e38db7f48 ! 13:  a26fb180ad reftable: rest of library
     @@ Metadata
       ## Commit message ##
          reftable: rest of library
      
     -    This will be further split up once preceding commits have passed review.
     -
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
     - REFTABLE_OBJS += reftable/basics.o
     +@@ Makefile: REFTABLE_OBJS += reftable/error.o
       REFTABLE_OBJS += reftable/block.o
       REFTABLE_OBJS += reftable/blocksource.o
     --REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/compat.o
       REFTABLE_OBJS += reftable/iter.o
      +REFTABLE_OBJS += reftable/merged.o
      +REFTABLE_OBJS += reftable/pq.o
     -+REFTABLE_OBJS += reftable/publicbasics.o
     + REFTABLE_OBJS += reftable/publicbasics.o
       REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
      +REFTABLE_OBJS += reftable/refname.o
       REFTABLE_OBJS += reftable/reftable.o
      +REFTABLE_OBJS += reftable/stack.o
     - REFTABLE_OBJS += reftable/strbuf.o
       REFTABLE_OBJS += reftable/tree.o
       REFTABLE_OBJS += reftable/writer.o
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     - 
     - REFTABLE_TEST_OBJS += reftable/block_test.o
     - REFTABLE_TEST_OBJS += reftable/record_test.o
     -+REFTABLE_TEST_OBJS += reftable/refname_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
     -+REFTABLE_TEST_OBJS += reftable/stack_test.o
     - REFTABLE_TEST_OBJS += reftable/strbuf_test.o
     - REFTABLE_TEST_OBJS += reftable/test_framework.o
     - REFTABLE_TEST_OBJS += reftable/tree_test.o
     + REFTABLE_OBJS += reftable/zlib-compat.o
      
       ## reftable/VERSION (new) ##
      @@
     -+7134eb9f8171a9759800f4187f9e6dde997335e7 C: NULL iso 0 for init
     ++b8ec0f74c74cb6752eb2033ad8e755a9c19aad15 C: add missing header
      
       ## reftable/dump.c (new) ##
      @@
     @@ reftable/dump.c (new)
      +
      +static int dump_table(const char *tablename)
      +{
     -+	struct reftable_block_source src = { NULL };
     ++	struct reftable_block_source src = { 0 };
      +	int err = reftable_block_source_from_file(&src, tablename);
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
      +	struct reftable_reader *r = NULL;
      +
      +	if (err < 0)
     @@ reftable/dump.c (new)
      +{
      +	struct reftable_stack *stack = NULL;
      +	struct reftable_write_options cfg = {};
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
      +	struct reftable_merged_table *merged = NULL;
      +
      +	int err = reftable_new_stack(&stack, stackdir, cfg);
     @@ reftable/merged.c (new)
      +#include "pq.h"
      +#include "reader.h"
      +#include "record.h"
     -+#include "reftable.h"
     ++#include "reftable-merged.h"
     ++#include "reftable-error.h"
      +#include "system.h"
      +
      +static int merged_iter_init(struct merged_iter *mi)
     @@ reftable/merged.c (new)
      +{
      +	struct merged_iter *mi = (struct merged_iter *)p;
      +	int i = 0;
     -+	merged_iter_pqueue_clear(&mi->pq);
     ++	merged_iter_pqueue_release(&mi->pq);
      +	for (i = 0; i < mi->stack_len; i++) {
      +		reftable_iterator_destroy(&mi->stack[i]);
      +	}
     @@ reftable/merged.c (new)
      +}
      +
      +/* clears the list of subtable, without affecting the readers themselves. */
     -+void merged_table_clear(struct reftable_merged_table *mt)
     ++void merged_table_release(struct reftable_merged_table *mt)
      +{
      +	FREE_AND_NULL(mt->stack);
      +	mt->stack_len = 0;
     @@ reftable/merged.c (new)
      +	if (mt == NULL) {
      +		return;
      +	}
     -+	merged_table_clear(mt);
     ++	merged_table_release(mt);
      +	reftable_free(mt);
      +}
      +
     @@ reftable/merged.c (new)
      +	return mt->min;
      +}
      +
     ++static int reftable_table_seek_record(struct reftable_table *tab,
     ++				      struct reftable_iterator *it,
     ++				      struct reftable_record *rec)
     ++{
     ++	return tab->ops->seek_record(tab->table_arg, it, rec);
     ++}
     ++
      +static int merged_table_seek_record(struct reftable_merged_table *mt,
      +				    struct reftable_iterator *it,
      +				    struct reftable_record *rec)
     @@ reftable/merged.h (new)
      +#define MERGED_H
      +
      +#include "pq.h"
     -+#include "reftable.h"
      +
      +struct reftable_merged_table {
      +	struct reftable_table *stack;
     @@ reftable/merged.h (new)
      +	struct merged_iter_pqueue pq;
      +};
      +
     -+void merged_table_clear(struct reftable_merged_table *mt);
     ++void merged_table_release(struct reftable_merged_table *mt);
      +
      +#endif
      
     @@ reftable/merged_test.c (new)
      +#include "pq.h"
      +#include "reader.h"
      +#include "record.h"
     -+#include "reftable.h"
      +#include "test_framework.h"
     ++#include "reftable-merged.h"
      +#include "reftable-tests.h"
     ++#include "reftable-generic.h"
     ++#include "reftable-stack.h"
      +
      +static void test_pq(void)
      +{
     @@ reftable/merged_test.c (new)
      +		reftable_free(names[i]);
      +	}
      +
     -+	merged_iter_pqueue_clear(&pq);
     ++	merged_iter_pqueue_release(&pq);
      +}
      +
      +static void write_test_table(struct strbuf *buf,
     @@ reftable/merged_test.c (new)
      +	}
      +
      +	err = reftable_writer_close(w);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	reftable_writer_free(w);
      +}
     @@ reftable/merged_test.c (new)
      +
      +		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
      +					  "name");
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +		reftable_table_from_reader(&tabs[i], (*readers)[i]);
      +	}
      +
      +	err = reftable_new_merged_table(&mt, tabs, n, SHA1_ID);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	return mt;
      +}
      +
     @@ reftable/merged_test.c (new)
      +	struct reftable_ref_record ref = { NULL };
      +	struct reftable_iterator it = { NULL };
      +	int err = reftable_merged_table_seek_ref(mt, &it, "a");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_iterator_next_ref(&it, &ref);
     -+	assert_err(err);
     -+	assert(ref.update_index == 2);
     -+	reftable_ref_record_clear(&ref);
     ++	EXPECT_ERR(err);
     ++	EXPECT(ref.update_index == 2);
     ++	reftable_ref_record_release(&ref);
      +	reftable_iterator_destroy(&it);
      +	readers_destroy(readers, 2);
      +	reftable_merged_table_free(mt);
     @@ reftable/merged_test.c (new)
      +	size_t cap = 0;
      +	int i = 0;
      +
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	while (len < 100) { /* cap loops/recursion. */
      +		struct reftable_ref_record ref = { NULL };
      +		int err = reftable_iterator_next_ref(&it, &ref);
     @@ reftable/merged_test.c (new)
      +		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
      +	}
      +	for (i = 0; i < len; i++) {
     -+		reftable_ref_record_clear(&out[i]);
     ++		reftable_ref_record_release(&out[i]);
      +	}
      +	reftable_free(out);
      +
     @@ reftable/merged_test.c (new)
      +	reftable_writer_set_limits(w, 1, 1);
      +
      +	err = reftable_writer_add_ref(w, &rec);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_writer_close(w);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	reftable_writer_free(w);
      +
      +	block_source_from_strbuf(&source, &buf);
      +
      +	err = reftable_new_reader(&rd, &source, "filename");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	hash_id = reftable_reader_hash_id(rd);
      +	assert(hash_id == SHA1_ID);
      +
      +	reftable_table_from_reader(&tab[0], rd);
      +	err = reftable_new_merged_table(&merged, tab, 1, SHA1_ID);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	reftable_reader_free(rd);
      +	reftable_merged_table_free(merged);
     @@ reftable/merged_test.c (new)
      +
      +int merged_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_merged_between", &test_merged_between);
     -+	add_test_case("test_pq", &test_pq);
     -+	add_test_case("test_merged", &test_merged);
     -+	add_test_case("test_default_write_opts", &test_default_write_opts);
     -+	return test_main(argc, argv);
     ++	test_merged_between();
     ++	test_pq();
     ++	test_merged();
     ++	test_default_write_opts();
     ++	return 0;
      +}
      
       ## reftable/pq.c (new) ##
     @@ reftable/pq.c (new)
      +
      +#include "pq.h"
      +
     -+#include "reftable.h"
     ++#include "reftable-record.h"
      +#include "system.h"
      +#include "basics.h"
      +
     @@ reftable/pq.c (new)
      +	}
      +}
      +
     -+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq)
     ++void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
      +{
      +	int i = 0;
      +	for (i = 0; i < pq->len; i++) {
     @@ reftable/pq.h (new)
      +void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
      +struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
      +void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
     -+void merged_iter_pqueue_clear(struct merged_iter_pqueue *pq);
     ++void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
      +
      +#endif
      
     @@ reftable/refname.c (new)
      +*/
      +
      +#include "system.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
      +#include "basics.h"
      +#include "refname.h"
     -+#include "strbuf.h"
     ++#include "reftable-iterator.h"
      +
      +struct find_arg {
      +	char **names;
     @@ reftable/refname.c (new)
      +	}
      +
      +	err = reftable_table_read_ref(&mod->tab, name, &ref);
     -+	reftable_ref_record_clear(&ref);
     ++	reftable_ref_record_release(&ref);
      +	return err;
      +}
      +
     -+static void modification_clear(struct modification *mod)
     ++static void modification_release(struct modification *mod)
      +{
      +	/* don't delete the strings themselves; they're owned by ref records.
      +	 */
     @@ reftable/refname.c (new)
      +	}
      +
      +done:
     -+	reftable_ref_record_clear(&ref);
     ++	reftable_ref_record_release(&ref);
      +	reftable_iterator_destroy(&it);
      +	return err;
      +}
     @@ reftable/refname.c (new)
      +	}
      +
      +	err = modification_validate(&mod);
     -+	modification_clear(&mod);
     ++	modification_release(&mod);
      +	return err;
      +}
      +
     @@ reftable/refname.h (new)
      +#ifndef REFNAME_H
      +#define REFNAME_H
      +
     -+#include "reftable.h"
     ++#include "reftable-record.h"
     ++#include "reftable-generic.h"
      +
      +struct modification {
      +	struct reftable_table tab;
     @@ reftable/refname_test.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "reftable.h"
     -+
      +#include "basics.h"
      +#include "block.h"
      +#include "blocksource.h"
     @@ reftable/refname_test.c (new)
      +#include "reader.h"
      +#include "record.h"
      +#include "refname.h"
     ++#include "reftable-error.h"
     ++#include "reftable-writer.h"
      +#include "system.h"
      +
      +#include "test_framework.h"
     @@ reftable/refname_test.c (new)
      +	reftable_writer_set_limits(w, 1, 1);
      +
      +	err = reftable_writer_add_ref(w, &rec);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_writer_close(w);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	reftable_writer_free(w);
      +
      +	block_source_from_strbuf(&source, &buf);
      +	err = reftable_new_reader(&rd, &source, "filename");
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	reftable_table_from_reader(&tab, rd);
      +
     @@ reftable/refname_test.c (new)
      +		}
      +
      +		err = modification_validate(&mod);
     -+		assert(err == cases[i].error_code);
     ++		EXPECT(err == cases[i].error_code);
      +	}
      +
      +	reftable_reader_free(rd);
     @@ reftable/refname_test.c (new)
      +
      +int refname_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_conflict", &test_conflict);
     -+	return test_main(argc, argv);
     ++	test_conflict();
     ++	return 0;
      +}
      
     - ## reftable/reftable.c ##
     -@@ reftable/reftable.c: int reftable_table_seek_ref(struct reftable_table *tab,
     - 	struct reftable_ref_record ref = {
     - 		.refname = (char *)name,
     - 	};
     --	struct reftable_record rec = { 0 };
     + ## reftable/reftable-generic.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef REFTABLE_GENERIC_H
     ++#define REFTABLE_GENERIC_H
     ++
     ++#include "reftable-iterator.h"
     ++#include "reftable-reader.h"
     ++#include "reftable-merged.h"
     ++
     ++/*
     ++ Provides a unified API for reading tables, either merged tables, or single
     ++ readers.
     ++*/
     ++struct reftable_table {
     ++	struct reftable_table_vtable *ops;
     ++	void *table_arg;
     ++};
     ++
     ++int reftable_table_seek_ref(struct reftable_table *tab,
     ++			    struct reftable_iterator *it, const char *name);
     ++
     ++void reftable_table_from_reader(struct reftable_table *tab,
     ++				struct reftable_reader *reader);
     ++
     ++/* returns the hash ID from a generic reftable_table */
     ++uint32_t reftable_table_hash_id(struct reftable_table *tab);
     ++
     ++/* create a generic table from reftable_merged_table */
     ++void reftable_table_from_merged_table(struct reftable_table *tab,
     ++				      struct reftable_merged_table *table);
     ++
     ++/* returns the max update_index covered by this table. */
     ++uint64_t reftable_table_max_update_index(struct reftable_table *tab);
     ++
     ++/* returns the min update_index covered by this table. */
     ++uint64_t reftable_table_min_update_index(struct reftable_table *tab);
     ++
     ++/* convenience function to read a single ref. Returns < 0 for error, 0
     ++   for success, and 1 if ref not found. */
     ++int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     ++			    struct reftable_ref_record *ref);
     ++
     ++#endif
     +
     + ## reftable/reftable-merged.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef REFTABLE_MERGED_H
     ++#define REFTABLE_MERGED_H
     ++
     ++#include "reftable-iterator.h"
     ++
     ++/*
     ++ Merged tables
     ++
     ++ A ref database kept in a sequence of table files. The merged_table presents a
     ++ unified view to reading (seeking, iterating) a sequence of immutable tables.
     ++
     ++ The merged tables are on purpose kept disconnected from their actual storage
     ++ (eg. files on disk), because it is useful to merge tables aren't files. For
     ++ example, the per-workspace and global ref namespace can be implemented as a
     ++ merged table of two stacks of file-backed reftables.
     ++*/
     ++
     ++/* A merged table is implements seeking/iterating over a stack of tables. */
     ++struct reftable_merged_table;
     ++
     ++/* A generic reftable; see below. */
     ++struct reftable_table;
     ++
     ++/* reftable_new_merged_table creates a new merged table. It takes ownership of
     ++   the stack array.
     ++*/
     ++int reftable_new_merged_table(struct reftable_merged_table **dest,
     ++			      struct reftable_table *stack, int n,
     ++			      uint32_t hash_id);
     ++
     ++/* returns an iterator positioned just before 'name' */
     ++int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name);
     ++
     ++/* returns an iterator for log entry, at given update_index */
     ++int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     ++				      struct reftable_iterator *it,
     ++				      const char *name, uint64_t update_index);
     ++
     ++/* like reftable_merged_table_seek_log_at but look for the newest entry. */
     ++int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name);
     ++
     ++/* returns the max update_index covered by this merged table. */
     ++uint64_t
     ++reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
     ++
     ++/* returns the min update_index covered by this merged table. */
     ++uint64_t
     ++reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
     ++
     ++/* releases memory for the merged_table */
     ++void reftable_merged_table_free(struct reftable_merged_table *m);
     ++
     ++/* return the hash ID of the merged table. */
     ++uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
     ++
     ++#endif
     +
     + ## reftable/reftable-stack.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef REFTABLE_STACK_H
     ++#define REFTABLE_STACK_H
     ++
     ++#include "reftable-writer.h"
     ++
     ++/*
     ++  The stack presents an interface to a mutable sequence of reftables.
     ++
     ++  A stack can be mutated by pushing a table to the top of the stack.
     ++
     ++  The reftable_stack automatically compacts files on disk to ensure good
     ++  amortized performance.
     ++*/
     ++struct reftable_stack;
     ++
     ++/* open a new reftable stack. The tables along with the table list will be
     ++   stored in 'dir'. Typically, this should be .git/reftables.
     ++*/
     ++int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     ++		       struct reftable_write_options config);
     ++
     ++/* returns the update_index at which a next table should be written. */
     ++uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
     ++
     ++/* holds a transaction to add tables at the top of a stack. */
     ++struct reftable_addition;
     ++
     ++/*
     ++  returns a new transaction to add reftables to the given stack. As a side
     ++  effect, the ref database is locked.
     ++*/
     ++int reftable_stack_new_addition(struct reftable_addition **dest,
     ++				struct reftable_stack *st);
     ++
     ++/* Adds a reftable to transaction. */
     ++int reftable_addition_add(struct reftable_addition *add,
     ++			  int (*write_table)(struct reftable_writer *wr,
     ++					     void *arg),
     ++			  void *arg);
     ++
     ++/* Commits the transaction, releasing the lock. */
     ++int reftable_addition_commit(struct reftable_addition *add);
     ++
     ++/* Release all non-committed data from the transaction, and deallocate the
     ++   transaction. Releases the lock if held. */
     ++void reftable_addition_destroy(struct reftable_addition *add);
     ++
     ++/* add a new table to the stack. The write_table function must call
     ++   reftable_writer_set_limits, add refs and return an error value. */
     ++int reftable_stack_add(struct reftable_stack *st,
     ++		       int (*write_table)(struct reftable_writer *wr,
     ++					  void *write_arg),
     ++		       void *write_arg);
     ++
     ++/* returns the merged_table for seeking. This table is valid until the
     ++   next write or reload, and should not be closed or deleted.
     ++*/
     ++struct reftable_merged_table *
     ++reftable_stack_merged_table(struct reftable_stack *st);
     ++
     ++/* frees all resources associated with the stack. */
     ++void reftable_stack_destroy(struct reftable_stack *st);
     ++
     ++/* Reloads the stack if necessary. This is very cheap to run if the stack was up
     ++ * to date */
     ++int reftable_stack_reload(struct reftable_stack *st);
     ++
     ++/* Policy for expiring reflog entries. */
     ++struct reftable_log_expiry_config {
     ++	/* Drop entries older than this timestamp */
     ++	uint64_t time;
     ++
     ++	/* Drop older entries */
     ++	uint64_t min_update_index;
     ++};
     ++
     ++/* compacts all reftables into a giant table. Expire reflog entries if config is
     ++ * non-NULL */
     ++int reftable_stack_compact_all(struct reftable_stack *st,
     ++			       struct reftable_log_expiry_config *config);
     ++
     ++/* heuristically compact unbalanced table stack. */
     ++int reftable_stack_auto_compact(struct reftable_stack *st);
     ++
     ++/* convenience function to read a single ref. Returns < 0 for error, 0
     ++   for success, and 1 if ref not found. */
     ++int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_ref_record *ref);
     ++
     ++/* convenience function to read a single log. Returns < 0 for error, 0
     ++   for success, and 1 if ref not found. */
     ++int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_log_record *log);
     ++
     ++/* statistics on past compactions. */
     ++struct reftable_compaction_stats {
     ++	uint64_t bytes; /* total number of bytes written */
     ++	uint64_t entries_written; /* total number of entries written, including
     ++				     failures. */
     ++	int attempts; /* how often we tried to compact */
     ++	int failures; /* failures happen on concurrent updates */
     ++};
     ++
     ++/* return statistics for compaction up till now. */
     ++struct reftable_compaction_stats *
     ++reftable_stack_compaction_stats(struct reftable_stack *st);
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
     ++#include "record.h"
     ++#include "reader.h"
     ++#include "reftable-iterator.h"
     ++#include "reftable-generic.h"
     ++
     ++static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     ++				     struct reftable_record *rec)
     ++{
     ++	return reader_seek((struct reftable_reader *)tab, it, rec);
     ++}
     ++
     ++static uint32_t reftable_reader_hash_id_void(void *tab)
     ++{
     ++	return reftable_reader_hash_id((struct reftable_reader *)tab);
     ++}
     ++
     ++static uint64_t reftable_reader_min_update_index_void(void *tab)
     ++{
     ++	return reftable_reader_min_update_index((struct reftable_reader *)tab);
     ++}
     ++
     ++static uint64_t reftable_reader_max_update_index_void(void *tab)
     ++{
     ++	return reftable_reader_max_update_index((struct reftable_reader *)tab);
     ++}
     ++
     ++static struct reftable_table_vtable reader_vtable = {
     ++	.seek_record = reftable_reader_seek_void,
     ++	.hash_id = reftable_reader_hash_id_void,
     ++	.min_update_index = reftable_reader_min_update_index_void,
     ++	.max_update_index = reftable_reader_max_update_index_void,
     ++};
     ++
     ++int reftable_table_seek_ref(struct reftable_table *tab,
     ++			    struct reftable_iterator *it, const char *name)
     ++{
     ++	struct reftable_ref_record ref = {
     ++		.refname = (char *)name,
     ++	};
      +	struct reftable_record rec = { NULL };
     - 	reftable_record_from_ref(&rec, &ref);
     - 	return tab->ops->seek_record(tab->table_arg, it, &rec);
     - }
     -@@ reftable/reftable.c: void reftable_table_from_reader(struct reftable_table *tab,
     - int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     - 			    struct reftable_ref_record *ref)
     - {
     --	struct reftable_iterator it = { 0 };
     ++	reftable_record_from_ref(&rec, &ref);
     ++	return tab->ops->seek_record(tab->table_arg, it, &rec);
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
     ++int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     ++			    struct reftable_ref_record *ref)
     ++{
      +	struct reftable_iterator it = { NULL };
     - 	int err = reftable_table_seek_ref(tab, &it, name);
     - 	if (err)
     - 		goto done;
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
      
       ## reftable/stack.c (new) ##
      @@
     @@ reftable/stack.c (new)
      +#include "merged.h"
      +#include "reader.h"
      +#include "refname.h"
     -+#include "reftable.h"
     ++#include "reftable-error.h"
     ++#include "reftable-record.h"
      +#include "writer.h"
      +
      +static int stack_try_add(struct reftable_stack *st,
     @@ reftable/stack.c (new)
      +static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
      +					     int reuse_open);
      +
     ++static int reftable_fd_write(void *arg, const void *data, size_t sz)
     ++{
     ++	int *fdp = (int *)arg;
     ++	return write(*fdp, data, sz);
     ++}
     ++
      +int reftable_new_stack(struct reftable_stack **dest, const char *dir,
      +		       struct reftable_write_options config)
      +{
     @@ reftable/stack.c (new)
      +	new_tables = NULL;
      +	st->readers_len = new_readers_len;
      +	if (st->merged != NULL) {
     -+		merged_table_clear(st->merged);
     ++		merged_table_release(st->merged);
      +		reftable_merged_table_free(st->merged);
      +	}
      +	if (st->readers != NULL) {
     @@ reftable/stack.c (new)
      +done:
      +	reftable_iterator_destroy(&it);
      +	if (mt != NULL) {
     -+		merged_table_clear(mt);
     ++		merged_table_release(mt);
      +		reftable_merged_table_free(mt);
      +	}
     -+	reftable_ref_record_clear(&ref);
     -+	reftable_log_record_clear(&log);
     ++	reftable_ref_record_release(&ref);
     ++	reftable_log_record_release(&log);
      +	st->stats.entries_written += entries;
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +
      +done:
      +	if (err) {
     -+		reftable_log_record_clear(log);
     ++		reftable_log_record_release(log);
      +	}
      +	reftable_iterator_destroy(&it);
      +	return err;
     @@ reftable/stack.c (new)
      +
      +done:
      +	for (i = 0; i < len; i++) {
     -+		reftable_ref_record_clear(&refs[i]);
     ++		reftable_ref_record_release(&refs[i]);
      +	}
      +
      +	free(refs);
     @@ reftable/stack.h (new)
      +#ifndef STACK_H
      +#define STACK_H
      +
     -+#include "reftable.h"
      +#include "system.h"
     ++#include "reftable-writer.h"
     ++#include "reftable-stack.h"
      +
      +struct reftable_stack {
      +	char *list_file;
     @@ reftable/stack_test.c (new)
      +#include "basics.h"
      +#include "constants.h"
      +#include "record.h"
     -+#include "reftable.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
      +
      +#include <sys/types.h>
      +#include <dirent.h>
      +
     ++static void clear_dir(const char *dirname)
     ++{
     ++	struct strbuf path = STRBUF_INIT;
     ++	strbuf_addstr(&path, dirname);
     ++	remove_dir_recursively(&path, 0);
     ++	strbuf_release(&path);
     ++}
     ++
      +static void test_read_file(void)
      +{
      +	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
     @@ reftable/stack_test.c (new)
      +	char *want[] = { "line1", "line2", "line3" };
      +	int i = 0;
      +
     -+	assert(fd > 0);
     ++	EXPECT(fd > 0);
      +	n = write(fd, out, strlen(out));
     -+	assert(n == strlen(out));
     ++	EXPECT(n == strlen(out));
      +	err = close(fd);
     -+	assert(err >= 0);
     ++	EXPECT(err >= 0);
      +
      +	err = read_lines(fn, &names);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 0; names[i] != NULL; i++) {
     -+		assert(0 == strcmp(want[i], names[i]));
     ++		EXPECT(0 == strcmp(want[i], names[i]));
      +	}
      +	free_names(names);
      +	remove(fn);
     @@ reftable/stack_test.c (new)
      +	char **names = NULL;
      +	parse_names(buf, strlen(buf), &names);
      +
     -+	assert(NULL != names[0]);
     -+	assert(0 == strcmp(names[0], "line"));
     -+	assert(NULL == names[1]);
     ++	EXPECT(NULL != names[0]);
     ++	EXPECT(0 == strcmp(names[0], "line"));
     ++	EXPECT(NULL == names[1]);
      +	free_names(names);
      +}
      +
     @@ reftable/stack_test.c (new)
      +	char *b[] = { "a", "b", "d", NULL };
      +	char *c[] = { "a", "b", NULL };
      +
     -+	assert(names_equal(a, a));
     -+	assert(!names_equal(a, b));
     -+	assert(!names_equal(a, c));
     ++	EXPECT(names_equal(a, a));
     ++	EXPECT(!names_equal(a, b));
     ++	EXPECT(!names_equal(a, c));
      +}
      +
      +static int write_test_ref(struct reftable_writer *wr, void *arg)
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_test_ref, &ref);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_ref(st, ref.refname, &dest);
     -+	assert_err(err);
     -+	assert(0 == strcmp("master", dest.target));
     ++	EXPECT_ERR(err);
     ++	EXPECT(0 == strcmp("master", dest.target));
      +
     -+	reftable_ref_record_clear(&dest);
     ++	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_uptodate(void)
     @@ reftable/stack_test.c (new)
      +		.target = "master",
      +	};
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st1, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_new_stack(&st2, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st1, &write_test_ref, &ref1);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st2, &write_test_ref, &ref2);
     -+	assert(err == REFTABLE_LOCK_ERROR);
     ++	EXPECT(err == REFTABLE_LOCK_ERROR);
      +
      +	err = reftable_stack_reload(st2);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st2, &write_test_ref, &ref2);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	reftable_stack_destroy(st1);
      +	reftable_stack_destroy(st2);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_transaction_api(void)
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	reftable_addition_destroy(add);
      +
      +	err = reftable_stack_new_addition(&add, st);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_addition_add(add, &write_test_ref, &ref);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_addition_commit(add);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	reftable_addition_destroy(add);
      +
      +	err = reftable_stack_read_ref(st, ref.refname, &dest);
     -+	assert_err(err);
     -+	assert(0 == strcmp("master", dest.target));
     ++	EXPECT_ERR(err);
     ++	EXPECT(0 == strcmp("master", dest.target));
      +
     -+	reftable_ref_record_clear(&dest);
     ++	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_validate_refname(void)
     @@ reftable/stack_test.c (new)
      +	};
      +	char *additions[] = { "a", "a/b/c" };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_test_ref, &ref);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 0; i < ARRAY_SIZE(additions); i++) {
      +		struct reftable_ref_record ref = {
     @@ reftable/stack_test.c (new)
      +		};
      +
      +		err = reftable_stack_add(st, &write_test_ref, &ref);
     -+		assert(err == REFTABLE_NAME_CONFLICT);
     ++		EXPECT(err == REFTABLE_NAME_CONFLICT);
      +	}
      +
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static int write_error(struct reftable_writer *wr, void *arg)
     @@ reftable/stack_test.c (new)
      +		.update_index = 1,
      +		.target = "master",
      +	};
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_test_ref, &ref1);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_test_ref, &ref2);
     -+	assert(err == REFTABLE_API_ERROR);
     ++	EXPECT(err == REFTABLE_API_ERROR);
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_lock_failure(void)
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err, i;
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
      +		err = reftable_stack_add(st, &write_error, &i);
     -+		assert(err == i);
     ++		EXPECT(err == i);
      +	}
      +
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_add(void)
     @@ reftable/stack_test.c (new)
      +	struct reftable_log_record logs[2] = { { NULL } };
      +	int N = ARRAY_SIZE(refs);
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	st->disable_auto_compact = 1;
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +			.update_index = reftable_stack_next_update_index(st),
      +		};
      +		int err = reftable_stack_add(st, &write_test_log, &arg);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +
      +	err = reftable_stack_compact_all(st, NULL);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 0; i < N; i++) {
      +		struct reftable_ref_record dest = { NULL };
      +
      +		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
     -+		assert_err(err);
     -+		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
     -+		reftable_ref_record_clear(&dest);
     ++		EXPECT_ERR(err);
     ++		EXPECT(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
     ++		reftable_ref_record_release(&dest);
      +	}
      +
      +	for (i = 0; i < N; i++) {
      +		struct reftable_log_record dest = { NULL };
      +		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
     -+		assert_err(err);
     -+		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
     -+		reftable_log_record_clear(&dest);
     ++		EXPECT_ERR(err);
     ++		EXPECT(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
     ++		reftable_log_record_release(&dest);
      +	}
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
      +	for (i = 0; i < N; i++) {
     -+		reftable_ref_record_clear(&refs[i]);
     -+		reftable_log_record_clear(&logs[i]);
     ++		reftable_ref_record_release(&refs[i]);
     ++		reftable_log_record_release(&logs[i]);
      +	}
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_log_normalize(void)
     @@ reftable/stack_test.c (new)
      +		.update_index = 1,
      +	};
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	input.message = "one\ntwo";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
     -+	assert(err == REFTABLE_API_ERROR);
     ++	EXPECT(err == REFTABLE_API_ERROR);
      +
      +	input.message = "one";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_log(st, input.refname, &dest);
     -+	assert_err(err);
     -+	assert(0 == strcmp(dest.message, "one\n"));
     ++	EXPECT_ERR(err);
     ++	EXPECT(0 == strcmp(dest.message, "one\n"));
      +
      +	input.message = "two\n";
      +	arg.update_index = 2;
      +	err = reftable_stack_add(st, &write_test_log, &arg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +	err = reftable_stack_read_log(st, input.refname, &dest);
     -+	assert_err(err);
     -+	assert(0 == strcmp(dest.message, "two\n"));
     ++	EXPECT_ERR(err);
     ++	EXPECT(0 == strcmp(dest.message, "two\n"));
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
     -+	reftable_log_record_clear(&dest);
     -+	reftable_clear_dir(dir);
     ++	reftable_log_record_release(&dest);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_tombstone(void)
     @@ reftable/stack_test.c (new)
      +	struct reftable_ref_record dest = { NULL };
      +	struct reftable_log_record log_dest = { NULL };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 0; i < N; i++) {
      +		const char *buf = "branch";
     @@ reftable/stack_test.c (new)
      +	}
      +	for (i = 0; i < N; i++) {
      +		int err = reftable_stack_add(st, &write_test_ref, &refs[i]);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +	for (i = 0; i < N; i++) {
      +		struct write_log_arg arg = {
     @@ reftable/stack_test.c (new)
      +			.update_index = reftable_stack_next_update_index(st),
      +		};
      +		int err = reftable_stack_add(st, &write_test_log, &arg);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +
      +	err = reftable_stack_read_ref(st, "branch", &dest);
     -+	assert(err == 1);
     -+	reftable_ref_record_clear(&dest);
     ++	EXPECT(err == 1);
     ++	reftable_ref_record_release(&dest);
      +
      +	err = reftable_stack_read_log(st, "branch", &log_dest);
     -+	assert(err == 1);
     -+	reftable_log_record_clear(&log_dest);
     ++	EXPECT(err == 1);
     ++	reftable_log_record_release(&log_dest);
      +
      +	err = reftable_stack_compact_all(st, NULL);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_ref(st, "branch", &dest);
     -+	assert(err == 1);
     ++	EXPECT(err == 1);
      +
      +	err = reftable_stack_read_log(st, "branch", &log_dest);
     -+	assert(err == 1);
     -+	reftable_ref_record_clear(&dest);
     -+	reftable_log_record_clear(&log_dest);
     ++	EXPECT(err == 1);
     ++	reftable_ref_record_release(&dest);
     ++	reftable_log_record_release(&log_dest);
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
      +	for (i = 0; i < N; i++) {
     -+		reftable_ref_record_clear(&refs[i]);
     -+		reftable_log_record_clear(&logs[i]);
     ++		reftable_ref_record_release(&refs[i]);
     ++		reftable_log_record_release(&logs[i]);
      +	}
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_reftable_stack_hash_id(void)
     @@ reftable/stack_test.c (new)
      +	struct reftable_stack *st_default = NULL;
      +	struct reftable_ref_record dest = { NULL };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_test_ref, &ref);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	/* can't read it with the wrong hash ID. */
      +	err = reftable_new_stack(&st32, dir, cfg32);
     -+	assert(err == REFTABLE_FORMAT_ERROR);
     ++	EXPECT(err == REFTABLE_FORMAT_ERROR);
      +
      +	/* check that we can read it back with default config too. */
      +	err = reftable_new_stack(&st_default, dir, cfg_default);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_ref(st_default, "master", &dest);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
     -+	assert(!strcmp(dest.target, ref.target));
     -+	reftable_ref_record_clear(&dest);
     ++	EXPECT(!strcmp(dest.target, ref.target));
     ++	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st_default);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +static void test_log2(void)
      +{
     -+	assert(1 == fastlog2(3));
     -+	assert(2 == fastlog2(4));
     -+	assert(2 == fastlog2(5));
     ++	EXPECT(1 == fastlog2(3));
     ++	EXPECT(2 == fastlog2(4));
     ++	EXPECT(2 == fastlog2(5));
      +}
      +
      +static void test_sizes_to_segments(void)
     @@ reftable/stack_test.c (new)
      +	int seglen = 0;
      +	struct segment *segs =
      +		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     -+	assert(segs[2].log == 3);
     -+	assert(segs[2].start == 5);
     -+	assert(segs[2].end == 6);
     ++	EXPECT(segs[2].log == 3);
     ++	EXPECT(segs[2].start == 5);
     ++	EXPECT(segs[2].end == 6);
      +
     -+	assert(segs[1].log == 2);
     -+	assert(segs[1].start == 2);
     -+	assert(segs[1].end == 5);
     ++	EXPECT(segs[1].log == 2);
     ++	EXPECT(segs[1].start == 2);
     ++	EXPECT(segs[1].end == 5);
      +	reftable_free(segs);
      +}
      +
     @@ reftable/stack_test.c (new)
      +	int seglen = 0;
      +	struct segment *segs =
      +		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     -+	assert(seglen == 0);
     ++	EXPECT(seglen == 0);
      +	reftable_free(segs);
      +}
      +
     @@ reftable/stack_test.c (new)
      +	int seglen = 0;
      +	struct segment *segs =
      +		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     -+	assert(seglen == 1);
     -+	assert(segs[0].start == 0);
     -+	assert(segs[0].end == 2);
     ++	EXPECT(seglen == 1);
     ++	EXPECT(segs[0].start == 0);
     ++	EXPECT(segs[0].end == 2);
      +	reftable_free(segs);
      +}
      +
     @@ reftable/stack_test.c (new)
      +	/* .................0    1    2  3   4  5  6 */
      +	struct segment min =
      +		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
     -+	assert(min.start == 2);
     -+	assert(min.end == 7);
     ++	EXPECT(min.start == 2);
     ++	EXPECT(min.end == 7);
      +}
      +
      +static void test_suggest_compaction_segment_nothing(void)
     @@ reftable/stack_test.c (new)
      +	uint64_t sizes[] = { 64, 32, 16, 8, 4, 2 };
      +	struct segment result =
      +		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
     -+	assert(result.start == result.end);
     ++	EXPECT(result.start == result.end);
      +}
      +
      +static void test_reflog_expire(void)
     @@ reftable/stack_test.c (new)
      +	};
      +	struct reftable_log_record log = { NULL };
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 1; i <= N; i++) {
      +		char buf[256];
     @@ reftable/stack_test.c (new)
      +			.update_index = reftable_stack_next_update_index(st),
      +		};
      +		int err = reftable_stack_add(st, &write_test_log, &arg);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +	}
      +
      +	err = reftable_stack_compact_all(st, NULL);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_compact_all(st, &expiry);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_log(st, logs[9].refname, &log);
     -+	assert(err == 1);
     ++	EXPECT(err == 1);
      +
      +	err = reftable_stack_read_log(st, logs[11].refname, &log);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	expiry.min_update_index = 15;
      +	err = reftable_stack_compact_all(st, &expiry);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_log(st, logs[14].refname, &log);
     -+	assert(err == 1);
     ++	EXPECT(err == 1);
      +
      +	err = reftable_stack_read_log(st, logs[16].refname, &log);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
      +	for (i = 0; i <= N; i++) {
     -+		reftable_log_record_clear(&logs[i]);
     ++		reftable_log_record_release(&logs[i]);
      +	}
     -+	reftable_clear_dir(dir);
     -+	reftable_log_record_clear(&log);
     ++	clear_dir(dir);
     ++	reftable_log_record_release(&log);
      +}
      +
      +static int write_nothing(struct reftable_writer *wr, void *arg)
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
      +	struct reftable_stack *st2 = NULL;
      +
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_stack_add(st, &write_nothing, NULL);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	err = reftable_new_stack(&st2, dir, cfg);
     -+	assert_err(err);
     -+	reftable_clear_dir(dir);
     ++	EXPECT_ERR(err);
     ++	clear_dir(dir);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st2);
      +}
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
      +	int err, i;
      +	int N = 100;
     -+	assert(mkdtemp(dir));
     ++	EXPECT(mkdtemp(dir));
      +
      +	err = reftable_new_stack(&st, dir, cfg);
     -+	assert_err(err);
     ++	EXPECT_ERR(err);
      +
      +	for (i = 0; i < N; i++) {
      +		char name[100];
     @@ reftable/stack_test.c (new)
      +		snprintf(name, sizeof(name), "branch%04d", i);
      +
      +		err = reftable_stack_add(st, &write_test_ref, &ref);
     -+		assert_err(err);
     ++		EXPECT_ERR(err);
      +
     -+		assert(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
     ++		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
      +	}
      +
     -+	assert(reftable_stack_compaction_stats(st)->entries_written <
     ++	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
      +	       (uint64_t)(N * fastlog2(N)));
      +
      +	reftable_stack_destroy(st);
     -+	reftable_clear_dir(dir);
     ++	clear_dir(dir);
      +}
      +
      +int stack_test_main(int argc, const char *argv[])
      +{
     -+	add_test_case("test_reftable_stack_uptodate",
     -+		      &test_reftable_stack_uptodate);
     -+	add_test_case("test_reftable_stack_transaction_api",
     -+		      &test_reftable_stack_transaction_api);
     -+	add_test_case("test_reftable_stack_hash_id",
     -+		      &test_reftable_stack_hash_id);
     -+	add_test_case("test_sizes_to_segments_all_equal",
     -+		      &test_sizes_to_segments_all_equal);
     -+	add_test_case("test_reftable_stack_auto_compaction",
     -+		      &test_reftable_stack_auto_compaction);
     -+	add_test_case("test_reftable_stack_validate_refname",
     -+		      &test_reftable_stack_validate_refname);
     -+	add_test_case("test_reftable_stack_update_index_check",
     -+		      &test_reftable_stack_update_index_check);
     -+	add_test_case("test_reftable_stack_lock_failure",
     -+		      &test_reftable_stack_lock_failure);
     -+	add_test_case("test_reftable_stack_log_normalize",
     -+		      &test_reftable_stack_log_normalize);
     -+	add_test_case("test_reftable_stack_tombstone",
     -+		      &test_reftable_stack_tombstone);
     -+	add_test_case("test_reftable_stack_add_one",
     -+		      &test_reftable_stack_add_one);
     -+	add_test_case("test_empty_add", test_empty_add);
     -+	add_test_case("test_reflog_expire", test_reflog_expire);
     -+	add_test_case("test_suggest_compaction_segment",
     -+		      &test_suggest_compaction_segment);
     -+	add_test_case("test_suggest_compaction_segment_nothing",
     -+		      &test_suggest_compaction_segment_nothing);
     -+	add_test_case("test_sizes_to_segments", &test_sizes_to_segments);
     -+	add_test_case("test_sizes_to_segments_empty",
     -+		      &test_sizes_to_segments_empty);
     -+	add_test_case("test_log2", &test_log2);
     -+	add_test_case("test_parse_names", &test_parse_names);
     -+	add_test_case("test_read_file", &test_read_file);
     -+	add_test_case("test_names_equal", &test_names_equal);
     -+	add_test_case("test_reftable_stack_add", &test_reftable_stack_add);
     -+	return test_main(argc, argv);
     ++	test_reftable_stack_uptodate();
     ++	test_reftable_stack_transaction_api();
     ++	test_reftable_stack_hash_id();
     ++	test_sizes_to_segments_all_equal();
     ++	test_reftable_stack_auto_compaction();
     ++	test_reftable_stack_validate_refname();
     ++	test_reftable_stack_update_index_check();
     ++	test_reftable_stack_lock_failure();
     ++	test_reftable_stack_log_normalize();
     ++	test_reftable_stack_tombstone();
     ++	test_reftable_stack_add_one();
     ++	test_empty_add();
     ++	test_reflog_expire();
     ++	test_suggest_compaction_segment();
     ++	test_suggest_compaction_segment_nothing();
     ++	test_sizes_to_segments();
     ++	test_sizes_to_segments_empty();
     ++	test_log2();
     ++	test_parse_names();
     ++	test_read_file();
     ++	test_names_equal();
     ++	test_reftable_stack_add();
     ++	return 0;
      +}
      
     - ## reftable/update.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+set -eu
     -+
     -+# Override this to import from somewhere else, say "../reftable".
     -+SRC=${SRC:-origin}
     -+BRANCH=${BRANCH:-master}
     -+
     -+((git --git-dir reftable-repo/.git fetch -f ${SRC} ${BRANCH}:import && cd reftable-repo && git checkout -f $(git rev-parse import) ) ||
     -+   git clone https://github.com/google/reftable reftable-repo)
     -+
     -+cp reftable-repo/c/*.[ch] reftable/
     -+cp reftable-repo/c/include/*.[ch] reftable/
     -+cp reftable-repo/LICENSE reftable/
     -+
     -+git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
     -+  > reftable/VERSION
     -+
     -+mv reftable/system.h reftable/system.h~
     -+sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
     -+
     -+git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
     -
       ## t/helper/test-reftable.c ##
     -@@
     - int cmd__reftable(int argc, const char **argv)
     +@@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
       {
     + 	basics_test_main(argc, argv);
       	block_test_main(argc, argv);
      +	merged_test_main(argc, argv);
       	record_test_main(argc, argv);
      +	refname_test_main(argc, argv);
       	reftable_test_main(argc, argv);
     - 	strbuf_test_main(argc, argv);
      +	stack_test_main(argc, argv);
       	tree_test_main(argc, argv);
       	return 0;
  -:  ---------- > 14:  a590865a70 Reftable support for git-core
  -:  ---------- > 15:  57626bfe2d git-prompt: prepare for reftable refs backend
 13:  c535f838d6 ! 16:  6229da992e reftable: "test-tool dump-reftable" command.
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: "test-tool dump-reftable" command.
     +    Add "test-tool dump-reftable" command.
      
          This command dumps individual tables or a stack of of tables.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/writer.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
     +@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
       
     + REFTABLE_TEST_OBJS += reftable/basics_test.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
      +REFTABLE_TEST_OBJS += reftable/dump.o
     -+REFTABLE_TEST_OBJS += reftable/merged_test.o
     + REFTABLE_TEST_OBJS += reftable/merged_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
       REFTABLE_TEST_OBJS += reftable/refname_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
      
     - ## reftable/iter.c ##
     -@@ reftable/iter.c: void reftable_iterator_destroy(struct reftable_iterator *it)
     - int reftable_iterator_next_ref(struct reftable_iterator *it,
     - 			       struct reftable_ref_record *ref)
     - {
     --	struct reftable_record rec = { 0 };
     -+	struct reftable_record rec = { NULL };
     - 	reftable_record_from_ref(&rec, ref);
     - 	return iterator_next(it, &rec);
     - }
     -@@ reftable/iter.c: int reftable_iterator_next_ref(struct reftable_iterator *it,
     - int reftable_iterator_next_log(struct reftable_iterator *it,
     - 			       struct reftable_log_record *log)
     - {
     --	struct reftable_record rec = { 0 };
     -+	struct reftable_record rec = { NULL };
     - 	reftable_record_from_log(&rec, log);
     - 	return iterator_next(it, &rec);
     - }
     -@@ reftable/iter.c: static int filtering_ref_iterator_next(void *iter_arg,
     - 		}
     + ## reftable/dump.c ##
     +@@ reftable/dump.c: license that can be found in the LICENSE file or at
     + #include <unistd.h>
     + #include <string.h>
       
     - 		if (fri->double_check) {
     --			struct reftable_iterator it = { 0 };
     -+			struct reftable_iterator it = { NULL };
     +-#include "reftable.h"
     ++#include "reftable-blocksource.h"
     ++#include "reftable-error.h"
     ++#include "reftable-merged.h"
     ++#include "reftable-record.h"
     + #include "reftable-tests.h"
     ++#include "reftable-writer.h"
     ++#include "reftable-iterator.h"
     ++#include "reftable-reader.h"
     ++#include "reftable-stack.h"
       
     - 			err = reftable_table_seek_ref(&fri->tab, &it,
     - 						      ref->refname);
     -
     - ## reftable/reader.c ##
     -@@ reftable/reader.c: static int parse_footer(struct reftable_reader *r, uint8_t *footer,
     - int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
     - 		const char *name)
     - {
     --	struct reftable_block footer = { 0 };
     --	struct reftable_block header = { 0 };
     -+	struct reftable_block footer = { NULL };
     -+	struct reftable_block header = { NULL };
     - 	int err = 0;
     + static uint32_t hash_id;
       
     - 	memset(r, 0, sizeof(struct reftable_reader));
     -@@ reftable/reader.c: int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     + static int dump_table(const char *tablename)
       {
     - 	int32_t guess_block_size = r->block_size ? r->block_size :
     - 							 DEFAULT_BLOCK_SIZE;
     --	struct reftable_block block = { 0 };
     -+	struct reftable_block block = { NULL };
     - 	uint8_t block_typ = 0;
     - 	int err = 0;
     - 	uint32_t header_off = next_off ? 0 : header_size(r->version);
     -@@ reftable/reader.c: static int reader_seek_indexed(struct reftable_reader *r,
     - 			       struct reftable_record *rec)
     +-	struct reftable_block_source src = { 0 };
     ++	struct reftable_block_source src = { NULL };
     + 	int err = reftable_block_source_from_file(&src, tablename);
     +-	struct reftable_iterator it = { 0 };
     +-	struct reftable_ref_record ref = { 0 };
     +-	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
     + 	struct reftable_reader *r = NULL;
     + 
     + 	if (err < 0)
     +@@ reftable/dump.c: static int dump_table(const char *tablename)
     + 		reftable_ref_record_print(&ref, hash_id);
     + 	}
     + 	reftable_iterator_destroy(&it);
     +-	reftable_ref_record_clear(&ref);
     ++	reftable_ref_record_release(&ref);
     + 
     + 	err = reftable_reader_seek_log(r, &it, "");
     + 	if (err < 0) {
     +@@ reftable/dump.c: static int dump_table(const char *tablename)
     + 		reftable_log_record_print(&log, hash_id);
     + 	}
     + 	reftable_iterator_destroy(&it);
     +-	reftable_log_record_clear(&log);
     ++	reftable_log_record_release(&log);
     + 
     + 	reftable_reader_free(r);
     + 	return 0;
     +@@ reftable/dump.c: static int dump_stack(const char *stackdir)
       {
     - 	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
     --	struct reftable_record want_index_rec = { 0 };
     -+	struct reftable_record want_index_rec = { NULL };
     - 	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
     --	struct reftable_record index_result_rec = { 0 };
     -+	struct reftable_record index_result_rec = { NULL };
     - 	struct table_iter index_iter = TABLE_ITER_INIT;
     - 	struct table_iter next = TABLE_ITER_INIT;
     - 	int err = 0;
     -@@ reftable/reader.c: int reftable_reader_seek_ref(struct reftable_reader *r,
     - 	struct reftable_ref_record ref = {
     - 		.refname = (char *)name,
     - 	};
     --	struct reftable_record rec = { 0 };
     -+	struct reftable_record rec = { NULL };
     - 	reftable_record_from_ref(&rec, &ref);
     - 	return reader_seek(r, it, &rec);
     - }
     -@@ reftable/reader.c: int reftable_reader_seek_log_at(struct reftable_reader *r,
     - 		.refname = (char *)name,
     - 		.update_index = update_index,
     - 	};
     --	struct reftable_record rec = { 0 };
     -+	struct reftable_record rec = { NULL };
     - 	reftable_record_from_log(&rec, &log);
     - 	return reader_seek(r, it, &rec);
     - }
     -@@ reftable/reader.c: static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
     - 		.hash_prefix = oid,
     - 		.hash_prefix_len = r->object_id_len,
     - 	};
     --	struct reftable_record want_rec = { 0 };
     --	struct reftable_iterator oit = { 0 };
     --	struct reftable_obj_record got = { 0 };
     --	struct reftable_record got_rec = { 0 };
     -+	struct reftable_record want_rec = { NULL };
     -+	struct reftable_iterator oit = { NULL };
     -+	struct reftable_obj_record got = { NULL };
     -+	struct reftable_record got_rec = { NULL };
     - 	int err = 0;
     - 	struct indexed_table_ref_iter *itr = NULL;
     + 	struct reftable_stack *stack = NULL;
     + 	struct reftable_write_options cfg = {};
     +-	struct reftable_iterator it = { 0 };
     +-	struct reftable_ref_record ref = { 0 };
     +-	struct reftable_log_record log = { 0 };
     ++	struct reftable_iterator it = { NULL };
     ++	struct reftable_ref_record ref = { NULL };
     ++	struct reftable_log_record log = { NULL };
     + 	struct reftable_merged_table *merged = NULL;
       
     + 	int err = reftable_new_stack(&stack, stackdir, cfg);
     +@@ reftable/dump.c: static int dump_stack(const char *stackdir)
     + 		reftable_ref_record_print(&ref, hash_id);
     + 	}
     + 	reftable_iterator_destroy(&it);
     +-	reftable_ref_record_clear(&ref);
     ++	reftable_ref_record_release(&ref);
     + 
     + 	err = reftable_merged_table_seek_log(merged, &it, "");
     + 	if (err < 0) {
     +@@ reftable/dump.c: static int dump_stack(const char *stackdir)
     + 		reftable_log_record_print(&log, hash_id);
     + 	}
     + 	reftable_iterator_destroy(&it);
     +-	reftable_log_record_clear(&log);
     ++	reftable_log_record_release(&log);
     + 
     + 	reftable_stack_destroy(stack);
     + 	return 0;
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     @@ t/helper/test-tool.h: int cmd__dump_cache_tree(int argc, const char **argv);
       int cmd__dump_untracked_cache(int argc, const char **argv);
      +int cmd__dump_reftable(int argc, const char **argv);
       int cmd__example_decorate(int argc, const char **argv);
     + int cmd__fast_rebase(int argc, const char **argv);
       int cmd__genrandom(int argc, const char **argv);
     - int cmd__genzeros(int argc, const char **argv);

-- 
gitgitgadget
