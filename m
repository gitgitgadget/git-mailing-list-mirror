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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E4C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6960FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhHQNou (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbhHQNos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:44:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224CC0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q6so17194516wrv.6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gBiHyq1JIeYeeyO9ZH54wX56uKS4Cxi+WDPwxhxu3R0=;
        b=nZ03MXONHyPgBSY8Vs4u7Gyl8HVc5MATtM5rDxS+uwPLAhfyTDyDauODxUcmoROuj9
         N2Dgdl81kotRrY/mhYDqT3jCAeHzvbf5Swb8Ns2j1vxcIgp3C4YxCZRyQmeFTuvH15+M
         TG683C+rPGzDTxsvjfY1siSLiszwCMy32wdW38lCw+9PcZyMX0iEUUfiG70pHA2gCF5N
         cMbN9TEN/P9COODjyKSXRgiezMMtJV54KAPWi2voCuw4DGB4C+4UXBnKfu4B0lGK7TBr
         +/U5OkH350pc4SdVPnadrK0rB9F9IHOJBDPAuPYGdXWnfsgpxV8FdMzeOHwgltup/it5
         hbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gBiHyq1JIeYeeyO9ZH54wX56uKS4Cxi+WDPwxhxu3R0=;
        b=dBDX7Fm4OqyiM4aYVs6Tyyy/An3WIo5UG3o4cJUR8xM98Irce+X+W8S85+3MzKBU23
         qmYdIm7I4jvSEj9VO7QRgUTne4Zj7d6gXhQj+htPOIZkkdOpJBRF3APywAR7SCGOPE/b
         RWNUiomz3OLb0tZW2eACCgGIMiZ6Zo5vjOBulTkYEAv4M2K2evYpQkfOyjcGaA5ifalG
         1Jnc48FsYfW/kz//sZ9UtdeVvkN8VZtNtDBm1MjjuQ3QdGmQSUoMBwxmZBcIoo2YXbte
         kcLjCga6yN+0iAn6wNubpIhRRCXasOJdSS0OliivBzrWeAzkHf+WDePjpl/cnHXxBt7Y
         OlwQ==
X-Gm-Message-State: AOAM532vnVvHJ18h58skZCsAdiOc5mF3AZTfZdG1QV4wGY/3ZBoSoxby
        rts0VoEhrl8ccltSWrlNAHxWpsh/iok=
X-Google-Smtp-Source: ABdhPJwyHGqE0Ow0r3YI9k+ziu7KEAca0SIdzKx/9d41cxBAOqtBVkLlI8BIezBD8itK49Llcmqcbg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr4365244wrn.111.1629207610048;
        Tue, 17 Aug 2021 06:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm3095812wro.45.2021.08.17.06.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:08 -0700 (PDT)
Message-Id: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:39:42 +0000
Subject: [PATCH v3 00/25] Support reftable ref backend for Git
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
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
 refs/reftable-backend.c                       | 1691 +++++++++++++++++
 reftable/LICENSE                              |   31 +
 reftable/basics.c                             |  128 ++
 reftable/basics.h                             |   60 +
 reftable/basics_test.c                        |   98 +
 reftable/block.c                              |  448 +++++
 reftable/block.h                              |  127 ++
 reftable/block_test.c                         |  120 ++
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
 reftable/readwrite_test.c                     |  652 +++++++
 reftable/record.c                             | 1212 ++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  412 ++++
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
 reftable/stack_test.c                         |  948 +++++++++
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
 94 files changed, 13178 insertions(+), 62 deletions(-)
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


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1054%2Fhanwen%2Flibreftable-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1054/hanwen/libreftable-v3
Pull-Request: https://github.com/git/git/pull/1054

Range-diff vs v2:

  1:  c40393e83e1 =  1:  cad3c4835a2 hash.h: provide constants for the hash IDs
  2:  49dffeeae58 =  2:  97aba3ae406 init-db: set the_repository->hash_algo early on
  3:  dba354eca12 =  3:  fca162dd676 reftable: RFC: add LICENSE
  4:  75864034af2 =  4:  44923074a5a reftable: add error related functionality
  5:  eabb25d95b3 !  5:  2f2beb70078 reftable: utility functions
     @@ reftable/system.h (new)
      +#ifndef SYSTEM_H
      +#define SYSTEM_H
      +
     -+// This header glues the reftable library to the rest of Git
     ++/* This header glues the reftable library to the rest of Git */
      +
      +#include "git-compat-util.h"
      +#include "strbuf.h"
  6:  ad54d17f84b =  6:  79d4a23764d reftable: add blocksource, an abstraction for random access reads
  7:  282d8e4d817 !  7:  2c143c75cd5 reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record.c (new)
      +		break;
      +	case REFTABLE_LOG_UPDATE:
      +		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
     -+		       log->refname, log->update_index, log->update.name,
     -+		       log->update.email, log->update.time,
     -+		       log->update.tz_offset);
     -+		hex_format(hex, log->update.old_hash, hash_size(hash_id));
     ++		       log->refname, log->update_index, log->value.update.name,
     ++		       log->value.update.email, log->value.update.time,
     ++		       log->value.update.tz_offset);
     ++		hex_format(hex, log->value.update.old_hash, hash_size(hash_id));
      +		printf("%s => ", hex);
     -+		hex_format(hex, log->update.new_hash, hash_size(hash_id));
     -+		printf("%s\n\n%s\n}\n", hex, log->update.message);
     ++		hex_format(hex, log->value.update.new_hash, hash_size(hash_id));
     ++		printf("%s\n\n%s\n}\n", hex, log->value.update.message);
      +		break;
      +	}
      +}
     @@ reftable/record.c (new)
      +	case REFTABLE_LOG_DELETION:
      +		break;
      +	case REFTABLE_LOG_UPDATE:
     -+		if (dst->update.email) {
     -+			dst->update.email = xstrdup(dst->update.email);
     ++		if (dst->value.update.email) {
     ++			dst->value.update.email =
     ++				xstrdup(dst->value.update.email);
      +		}
     -+		if (dst->update.name) {
     -+			dst->update.name = xstrdup(dst->update.name);
     ++		if (dst->value.update.name) {
     ++			dst->value.update.name =
     ++				xstrdup(dst->value.update.name);
      +		}
     -+		if (dst->update.message) {
     -+			dst->update.message = xstrdup(dst->update.message);
     ++		if (dst->value.update.message) {
     ++			dst->value.update.message =
     ++				xstrdup(dst->value.update.message);
      +		}
      +
     -+		if (dst->update.new_hash) {
     -+			dst->update.new_hash = reftable_malloc(hash_size);
     -+			memcpy(dst->update.new_hash, src->update.new_hash,
     -+			       hash_size);
     ++		if (dst->value.update.new_hash) {
     ++			dst->value.update.new_hash = reftable_malloc(hash_size);
     ++			memcpy(dst->value.update.new_hash,
     ++			       src->value.update.new_hash, hash_size);
      +		}
     -+		if (dst->update.old_hash) {
     -+			dst->update.old_hash = reftable_malloc(hash_size);
     -+			memcpy(dst->update.old_hash, src->update.old_hash,
     -+			       hash_size);
     ++		if (dst->value.update.old_hash) {
     ++			dst->value.update.old_hash = reftable_malloc(hash_size);
     ++			memcpy(dst->value.update.old_hash,
     ++			       src->value.update.old_hash, hash_size);
      +		}
      +		break;
      +	}
     @@ reftable/record.c (new)
      +	case REFTABLE_LOG_DELETION:
      +		break;
      +	case REFTABLE_LOG_UPDATE:
     -+		reftable_free(r->update.new_hash);
     -+		reftable_free(r->update.old_hash);
     -+		reftable_free(r->update.name);
     -+		reftable_free(r->update.email);
     -+		reftable_free(r->update.message);
     ++		reftable_free(r->value.update.new_hash);
     ++		reftable_free(r->value.update.old_hash);
     ++		reftable_free(r->value.update.name);
     ++		reftable_free(r->value.update.email);
     ++		reftable_free(r->value.update.message);
      +		break;
      +	}
      +	memset(r, 0, sizeof(struct reftable_log_record));
     @@ reftable/record.c (new)
      +	if (reftable_log_record_is_deletion(r))
      +		return 0;
      +
     -+	oldh = r->update.old_hash;
     -+	newh = r->update.new_hash;
     ++	oldh = r->value.update.old_hash;
     ++	newh = r->value.update.new_hash;
      +	if (!oldh) {
      +		oldh = zero;
      +	}
     @@ reftable/record.c (new)
      +	memcpy(s.buf + hash_size, newh, hash_size);
      +	string_view_consume(&s, 2 * hash_size);
      +
     -+	n = encode_string(r->update.name ? r->update.name : "", s);
     ++	n = encode_string(r->value.update.name ? r->value.update.name : "", s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
      +
     -+	n = encode_string(r->update.email ? r->update.email : "", s);
     ++	n = encode_string(r->value.update.email ? r->value.update.email : "",
     ++			  s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
      +
     -+	n = put_var_int(&s, r->update.time);
     ++	n = put_var_int(&s, r->value.update.time);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
     @@ reftable/record.c (new)
      +	if (s.len < 2)
      +		return -1;
      +
     -+	put_be16(s.buf, r->update.tz_offset);
     ++	put_be16(s.buf, r->value.update.tz_offset);
      +	string_view_consume(&s, 2);
      +
     -+	n = encode_string(r->update.message ? r->update.message : "", s);
     ++	n = encode_string(
     ++		r->value.update.message ? r->value.update.message : "", s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
     @@ reftable/record.c (new)
      +	if (val_type != r->value_type) {
      +		switch (r->value_type) {
      +		case REFTABLE_LOG_UPDATE:
     -+			FREE_AND_NULL(r->update.old_hash);
     -+			FREE_AND_NULL(r->update.new_hash);
     -+			FREE_AND_NULL(r->update.message);
     -+			FREE_AND_NULL(r->update.email);
     -+			FREE_AND_NULL(r->update.name);
     ++			FREE_AND_NULL(r->value.update.old_hash);
     ++			FREE_AND_NULL(r->value.update.new_hash);
     ++			FREE_AND_NULL(r->value.update.message);
     ++			FREE_AND_NULL(r->value.update.email);
     ++			FREE_AND_NULL(r->value.update.name);
      +			break;
      +		case REFTABLE_LOG_DELETION:
      +			break;
     @@ reftable/record.c (new)
      +	if (in.len < 2 * hash_size)
      +		return REFTABLE_FORMAT_ERROR;
      +
     -+	r->update.old_hash = reftable_realloc(r->update.old_hash, hash_size);
     -+	r->update.new_hash = reftable_realloc(r->update.new_hash, hash_size);
     ++	r->value.update.old_hash =
     ++		reftable_realloc(r->value.update.old_hash, hash_size);
     ++	r->value.update.new_hash =
     ++		reftable_realloc(r->value.update.new_hash, hash_size);
      +
     -+	memcpy(r->update.old_hash, in.buf, hash_size);
     -+	memcpy(r->update.new_hash, in.buf + hash_size, hash_size);
     ++	memcpy(r->value.update.old_hash, in.buf, hash_size);
     ++	memcpy(r->value.update.new_hash, in.buf + hash_size, hash_size);
      +
      +	string_view_consume(&in, 2 * hash_size);
      +
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->update.name = reftable_realloc(r->update.name, dest.len + 1);
     -+	memcpy(r->update.name, dest.buf, dest.len);
     -+	r->update.name[dest.len] = 0;
     ++	r->value.update.name =
     ++		reftable_realloc(r->value.update.name, dest.len + 1);
     ++	memcpy(r->value.update.name, dest.buf, dest.len);
     ++	r->value.update.name[dest.len] = 0;
      +
      +	strbuf_reset(&dest);
      +	n = decode_string(&dest, in);
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->update.email = reftable_realloc(r->update.email, dest.len + 1);
     -+	memcpy(r->update.email, dest.buf, dest.len);
     -+	r->update.email[dest.len] = 0;
     ++	r->value.update.email =
     ++		reftable_realloc(r->value.update.email, dest.len + 1);
     ++	memcpy(r->value.update.email, dest.buf, dest.len);
     ++	r->value.update.email[dest.len] = 0;
      +
      +	ts = 0;
      +	n = get_var_int(&ts, &in);
      +	if (n < 0)
      +		goto done;
      +	string_view_consume(&in, n);
     -+	r->update.time = ts;
     ++	r->value.update.time = ts;
      +	if (in.len < 2)
      +		goto done;
      +
     -+	r->update.tz_offset = get_be16(in.buf);
     ++	r->value.update.tz_offset = get_be16(in.buf);
      +	string_view_consume(&in, 2);
      +
      +	strbuf_reset(&dest);
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->update.message = reftable_realloc(r->update.message, dest.len + 1);
     -+	memcpy(r->update.message, dest.buf, dest.len);
     -+	r->update.message[dest.len] = 0;
     ++	r->value.update.message =
     ++		reftable_realloc(r->value.update.message, dest.len + 1);
     ++	memcpy(r->value.update.message, dest.buf, dest.len);
     ++	r->value.update.message[dest.len] = 0;
      +
      +	strbuf_release(&dest);
      +	return start.len - in.len;
     @@ reftable/record.c (new)
      +	case REFTABLE_LOG_DELETION:
      +		return 1;
      +	case REFTABLE_LOG_UPDATE:
     -+		return null_streq(a->update.name, b->update.name) &&
     -+		       a->update.time == b->update.time &&
     -+		       a->update.tz_offset == b->update.tz_offset &&
     -+		       null_streq(a->update.email, b->update.email) &&
     -+		       null_streq(a->update.message, b->update.message) &&
     -+		       zero_hash_eq(a->update.old_hash, b->update.old_hash,
     -+				    hash_size) &&
     -+		       zero_hash_eq(a->update.new_hash, b->update.new_hash,
     -+				    hash_size);
     ++		return null_streq(a->value.update.name, b->value.update.name) &&
     ++		       a->value.update.time == b->value.update.time &&
     ++		       a->value.update.tz_offset == b->value.update.tz_offset &&
     ++		       null_streq(a->value.update.email,
     ++				  b->value.update.email) &&
     ++		       null_streq(a->value.update.message,
     ++				  b->value.update.message) &&
     ++		       zero_hash_eq(a->value.update.old_hash,
     ++				    b->value.update.old_hash, hash_size) &&
     ++		       zero_hash_eq(a->value.update.new_hash,
     ++				    b->value.update.new_hash, hash_size);
      +	}
      +
      +	abort();
     @@ reftable/record_test.c (new)
      +			.refname = xstrdup("refs/heads/master"),
      +			.update_index = 42,
      +			.value_type = REFTABLE_LOG_UPDATE,
     -+			.update = {
     -+				.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     -+				.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     -+				.name = xstrdup("han-wen"),
     -+				.email = xstrdup("hanwen@google.com"),
     -+				.message = xstrdup("test"),
     -+				.time = 1577123507,
     -+				.tz_offset = 100,
     ++			.value = {
     ++				.update = {
     ++					.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     ++					.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
     ++					.name = xstrdup("han-wen"),
     ++					.email = xstrdup("hanwen@google.com"),
     ++					.message = xstrdup("test"),
     ++					.time = 1577123507,
     ++					.tz_offset = 100,
     ++				},
      +			}
      +		},
      +		{
     @@ reftable/record_test.c (new)
      +			.value_type = REFTABLE_LOG_DELETION,
      +		}
      +	};
     -+	set_test_hash(in[0].update.new_hash, 1);
     -+	set_test_hash(in[0].update.old_hash, 2);
     ++	set_test_hash(in[0].value.update.new_hash, 1);
     ++	set_test_hash(in[0].value.update.old_hash, 2);
      +	for (i = 0; i < ARRAY_SIZE(in); i++) {
      +		struct reftable_record rec = { NULL };
      +		struct strbuf key = STRBUF_INIT;
     @@ reftable/record_test.c (new)
      +		struct reftable_log_record out = {
      +			.refname = xstrdup("old name"),
      +			.value_type = REFTABLE_LOG_UPDATE,
     -+			.update = {
     -+				.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     -+				.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     -+				.name = xstrdup("old name"),
     -+				.email = xstrdup("old@email"),
     -+				.message = xstrdup("old message"),
     ++			.value = {
     ++				.update = {
     ++					.new_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     ++					.old_hash = reftable_calloc(GIT_SHA1_RAWSZ),
     ++					.name = xstrdup("old name"),
     ++					.email = xstrdup("old@email"),
     ++					.message = xstrdup("old message"),
     ++				},
      +			},
      +		};
      +		struct reftable_record rec_out = { NULL };
     @@ reftable/reftable-record.h (new)
      +			int16_t tz_offset;
      +			char *message;
      +		} update;
     -+	};
     ++	} value;
      +};
      +
      +/* returns whether 'ref' represents the deletion of a log record. */
  8:  893ee4ca21b =  8:  d92338467d6 Provide zlib's uncompress2 from compat/zlib-compat.c
  9:  e4da0a2ef37 !  9:  74ac0b135fa reftable: reading/writing blocks
     @@ reftable/block_test.c (new)
      +#include "block.h"
      +
      +#include "system.h"
     -+
      +#include "blocksource.h"
      +#include "basics.h"
      +#include "constants.h"
 10:  0f325881389 = 10:  a2219670079 reftable: a generic binary tree implementation
 11:  26cbc468f1f ! 11:  ac3063fd08c reftable: write reftable files
     @@ reftable/writer.c (new)
      +	if (log->refname == NULL)
      +		return REFTABLE_API_ERROR;
      +
     -+	input_log_message = log->update.message;
     -+	if (!w->opts.exact_log_message && log->update.message) {
     -+		strbuf_addstr(&cleaned_message, log->update.message);
     ++	input_log_message = log->value.update.message;
     ++	if (!w->opts.exact_log_message && log->value.update.message) {
     ++		strbuf_addstr(&cleaned_message, log->value.update.message);
      +		while (cleaned_message.len &&
      +		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
      +			strbuf_setlen(&cleaned_message,
      +				      cleaned_message.len - 1);
      +		if (strchr(cleaned_message.buf, '\n')) {
     -+			// multiple lines not allowed.
     ++			/* multiple lines not allowed. */
      +			err = REFTABLE_API_ERROR;
      +			goto done;
      +		}
      +		strbuf_addstr(&cleaned_message, "\n");
     -+		log->update.message = cleaned_message.buf;
     ++		log->value.update.message = cleaned_message.buf;
      +	}
      +
      +	err = reftable_writer_add_log_verbatim(w, log);
     -+	log->update.message = input_log_message;
     ++	log->value.update.message = input_log_message;
      +done:
      +	strbuf_release(&cleaned_message);
      +	return err;
 12:  69129fca086 = 12:  e0f3476555e reftable: generic interface to tables
 13:  22599d785b7 = 13:  f1fe338f67e reftable: read reftable files
 14:  45565bfb9c4 ! 14:  7da9a85c1db reftable: reftable file level tests
     @@ reftable/readwrite_test.c (new)
      +		log.refname = name;
      +		log.update_index = update_index;
      +		log.value_type = REFTABLE_LOG_UPDATE;
     -+		log.update.new_hash = hash;
     -+		log.update.message = "message";
     ++		log.value.update.new_hash = hash;
     ++		log.value.update.message = "message";
      +
      +		n = reftable_writer_add_log(w, &log);
      +		EXPECT(n == 0);
     @@ reftable/readwrite_test.c (new)
      +	for (i = 0; i < stats->ref_stats.blocks; i++) {
      +		int off = i * opts.block_size;
      +		if (off == 0) {
     -+			off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 :
     -+										  1);
     ++			off = header_size(
     ++				(hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
      +		}
      +		EXPECT(buf->buf[off] == 'r');
      +	}
     @@ reftable/readwrite_test.c (new)
      +	};
      +	int err;
      +	int i;
     -+	struct reftable_log_record log = { .refname = "refs/heads/master",
     -+					   .update_index = 0xa,
     -+					   .value_type = REFTABLE_LOG_UPDATE,
     -+					   .update = {
     -+						   .name = "Han-Wen Nienhuys",
     -+						   .email = "hanwen@google.com",
     -+						   .tz_offset = 100,
     -+						   .time = 0x5e430672,
     -+						   .message = "commit: 9\n",
     -+					   } };
     ++	struct reftable_log_record
     ++		log = { .refname = "refs/heads/master",
     ++			.update_index = 0xa,
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.value = { .update = {
     ++					   .name = "Han-Wen Nienhuys",
     ++					   .email = "hanwen@google.com",
     ++					   .tz_offset = 100,
     ++					   .time = 0x5e430672,
     ++					   .message = "commit: 9\n",
     ++				   } } };
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
     @@ reftable/readwrite_test.c (new)
      +		hash1[i] = (uint8_t)(rand() % 256);
      +		hash2[i] = (uint8_t)(rand() % 256);
      +	}
     -+	log.update.old_hash = hash1;
     -+	log.update.new_hash = hash2;
     ++	log.value.update.old_hash = hash1;
     ++	log.value.update.new_hash = hash2;
      +	reftable_writer_set_limits(w, update_index, update_index);
      +	err = reftable_writer_add_log(w, &log);
      +	EXPECT_ERR(err);
     @@ reftable/readwrite_test.c (new)
      +		log.refname = names[i];
      +		log.update_index = i;
      +		log.value_type = REFTABLE_LOG_UPDATE;
     -+		log.update.old_hash = hash1;
     -+		log.update.new_hash = hash2;
     ++		log.value.update.old_hash = hash1;
     ++		log.value.update.new_hash = hash2;
      +
      +		err = reftable_writer_add_log(w, &log);
      +		EXPECT_ERR(err);
 15:  57b3e709c3e = 15:  953590034a8 reftable: add a heap-based priority queue for reftable records
 16:  f834cc5299f = 16:  64fe3c8edc5 reftable: add merged table view
 17:  15799d93ff7 = 17:  acb0d435a20 reftable: implement refname validation
 18:  b7728ceaef2 ! 18:  764d45fccd4 reftable: implement stack, a mutable database of reftable files.
     @@ reftable/stack.c (new)
      +			reftable_reader_free(st->readers[i]);
      +
      +			if (filename.len) {
     -+				// On Windows, can only unlink after closing.
     ++				/* On Windows, can only unlink after closing. */
      +				unlink(filename.buf);
      +			}
      +		}
     @@ reftable/stack.c (new)
      +			reader_close(cur[i]);
      +			reftable_reader_free(cur[i]);
      +
     -+			// On Windows, can only unlink after closing.
     ++			/* On Windows, can only unlink after closing. */
      +			unlink(filename.buf);
      +
      +			strbuf_release(&filename);
     @@ reftable/stack.c (new)
      +		}
      +
      +		if (config && config->time > 0 &&
     -+		    log.update.time < config->time) {
     ++		    log.value.update.time < config->time) {
      +			continue;
      +		}
      +
     @@ reftable/stack_test.c (new)
      +		logs[i].update_index = N + i + 1;
      +		logs[i].value_type = REFTABLE_LOG_UPDATE;
      +
     -+		logs[i].update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
     -+		logs[i].update.email = xstrdup("identity@invalid");
     -+		set_test_hash(logs[i].update.new_hash, i);
     ++		logs[i].value.update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
     ++		logs[i].value.update.email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].value.update.new_hash, i);
      +	}
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +	struct reftable_log_record input = { .refname = "branch",
      +					     .update_index = 1,
      +					     .value_type = REFTABLE_LOG_UPDATE,
     -+					     .update = {
     -+						     .new_hash = h1,
     -+						     .old_hash = h2,
     -+					     } };
     ++					     .value = { .update = {
     ++								.new_hash = h1,
     ++								.old_hash = h2,
     ++							} } };
      +	struct reftable_log_record dest = {
      +		.update_index = 0,
      +	};
     @@ reftable/stack_test.c (new)
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     -+	input.update.message = "one\ntwo";
     ++	input.value.update.message = "one\ntwo";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT(err == REFTABLE_API_ERROR);
      +
     -+	input.update.message = "one";
     ++	input.value.update.message = "one";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_log(st, input.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp(dest.update.message, "one\n"));
     ++	EXPECT(0 == strcmp(dest.value.update.message, "one\n"));
      +
     -+	input.update.message = "two\n";
     ++	input.value.update.message = "two\n";
      +	arg.update_index = 2;
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT_ERR(err);
      +	err = reftable_stack_read_log(st, input.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp(dest.update.message, "two\n"));
     ++	EXPECT(0 == strcmp(dest.value.update.message, "two\n"));
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
     @@ reftable/stack_test.c (new)
      +		logs[i].update_index = 42;
      +		if (i % 2 == 0) {
      +			logs[i].value_type = REFTABLE_LOG_UPDATE;
     -+			logs[i].update.new_hash =
     ++			logs[i].value.update.new_hash =
      +				reftable_malloc(GIT_SHA1_RAWSZ);
     -+			set_test_hash(logs[i].update.new_hash, i);
     -+			logs[i].update.email = xstrdup("identity@invalid");
     ++			set_test_hash(logs[i].value.update.new_hash, i);
     ++			logs[i].value.update.email =
     ++				xstrdup("identity@invalid");
      +		}
      +	}
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = i;
      +		logs[i].value_type = REFTABLE_LOG_UPDATE;
     -+		logs[i].update.time = i;
     -+		logs[i].update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
     -+		logs[i].update.email = xstrdup("identity@invalid");
     -+		set_test_hash(logs[i].update.new_hash, i);
     ++		logs[i].value.update.time = i;
     ++		logs[i].value.update.new_hash = reftable_malloc(GIT_SHA1_RAWSZ);
     ++		logs[i].value.update.email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].value.update.new_hash, i);
      +	}
      +
      +	for (i = 1; i <= N; i++) {
 19:  0f682be20bd = 19:  88dbab683dc reftable: add dump utility
 20:  754085752f4 ! 20:  3d57f7c4430 refs: RFC: Reftable support for git-core
     @@ refs/reftable-backend.c (new)
      +	log->refname = NULL;
      +	switch (log->value_type) {
      +	case REFTABLE_LOG_UPDATE:
     -+		log->update.old_hash = NULL;
     -+		log->update.new_hash = NULL;
     -+		log->update.message = NULL;
     ++		log->value.update.old_hash = NULL;
     ++		log->value.update.new_hash = NULL;
     ++		log->value.update.message = NULL;
      +		break;
      +	case REFTABLE_LOG_DELETION:
      +		break;
     @@ refs/reftable-backend.c (new)
      +
      +	reftable_log_record_release(log);
      +	log->value_type = REFTABLE_LOG_UPDATE;
     -+	log->update.name =
     ++	log->value.update.name =
      +		xstrndup(split.name_begin, split.name_end - split.name_begin);
     -+	log->update.email =
     ++	log->value.update.email =
      +		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
     -+	log->update.time = atol(split.date_begin);
     ++	log->value.update.time = atol(split.date_begin);
      +	if (*split.tz_begin == '-') {
      +		sign = -1;
      +		split.tz_begin++;
     @@ refs/reftable-backend.c (new)
      +		split.tz_begin++;
      +	}
      +
     -+	log->update.tz_offset = sign * atoi(split.tz_begin);
     ++	log->value.update.tz_offset = sign * atoi(split.tz_begin);
      +}
      +
      +static int has_suffix(struct strbuf *b, const char *suffix)
     @@ refs/reftable-backend.c (new)
      +		log->update_index = ts;
      +		log->value_type = REFTABLE_LOG_UPDATE;
      +		log->refname = (char *)u->refname;
     -+		log->update.new_hash = u->new_oid.hash;
     -+		log->update.message = u->msg;
     ++		log->value.update.new_hash = u->new_oid.hash;
     ++		log->value.update.message = u->msg;
      +
      +		err = reftable_table_read_ref(&tab, u->refname, &ref);
      +		if (err < 0)
     @@ refs/reftable-backend.c (new)
      +
      +		/* XXX fold together with the old_id check below? */
      +
     -+		log->update.old_hash = old_id.hash;
     ++		log->value.update.old_hash = old_id.hash;
      +		if (u->flags & REF_LOG_ONLY) {
      +			continue;
      +		}
     @@ refs/reftable-backend.c (new)
      +		log.update_index = ts;
      +		log.refname = (char *)arg->refnames->items[i].string;
      +
     -+		log.update.message = xstrdup(arg->logmsg);
     -+		log.update.new_hash = NULL;
     -+		log.update.old_hash = NULL;
     ++		log.value.update.message = xstrdup(arg->logmsg);
     ++		log.value.update.new_hash = NULL;
     ++		log.value.update.old_hash = NULL;
      +		if (reftable_stack_read_ref(arg->stack, log.refname,
      +					    &current) == 0) {
     -+			log.update.old_hash =
     ++			log.value.update.old_hash =
      +				reftable_ref_record_val1(&current);
      +		}
      +		err = reftable_writer_add_log(writer, &log);
     -+		log.update.old_hash = NULL;
     ++		log.value.update.old_hash = NULL;
      +		reftable_ref_record_release(&current);
      +
      +		clear_reftable_log_record(&log);
     @@ refs/reftable-backend.c (new)
      +		fill_reftable_log_record(&log);
      +		log.refname = (char *)create->refname;
      +		log.update_index = ts;
     -+		log.update.message = (char *)create->logmsg;
     ++		log.value.update.message = (char *)create->logmsg;
      +		if (refs_resolve_ref_unsafe(
      +			    (struct ref_store *)create->refs, create->refname,
      +			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
     -+			log.update.old_hash = old_oid.hash;
     ++			log.value.update.old_hash = old_oid.hash;
      +		}
      +
      +		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
      +					    create->target, RESOLVE_REF_READING,
      +					    &new_oid, NULL) != NULL) {
     -+			log.update.new_hash = new_oid.hash;
     ++			log.value.update.new_hash = new_oid.hash;
      +		}
      +
     -+		if (log.update.old_hash != NULL ||
     -+		    log.update.new_hash != NULL) {
     ++		if (log.value.update.old_hash != NULL ||
     ++		    log.value.update.new_hash != NULL) {
      +			err = reftable_writer_add_log(writer, &log);
      +		}
      +		log.refname = NULL;
     -+		log.update.message = NULL;
     -+		log.update.old_hash = NULL;
     -+		log.update.new_hash = NULL;
     ++		log.value.update.message = NULL;
     ++		log.value.update.old_hash = NULL;
     ++		log.value.update.new_hash = NULL;
      +		clear_reftable_log_record(&log);
      +	}
      +	return err;
     @@ refs/reftable-backend.c (new)
      +
      +		todo[0].refname = (char *)arg->oldname;
      +		todo[0].update_index = ts;
     -+		todo[0].update.message = (char *)arg->logmsg;
     -+		todo[0].update.old_hash = val1;
     -+		todo[0].update.new_hash = NULL;
     ++		todo[0].value.update.message = (char *)arg->logmsg;
     ++		todo[0].value.update.old_hash = val1;
     ++		todo[0].value.update.new_hash = NULL;
      +
      +		todo[1].refname = (char *)arg->newname;
      +		todo[1].update_index = ts;
     -+		todo[1].update.old_hash = NULL;
     -+		todo[1].update.new_hash = val1;
     -+		todo[1].update.message = (char *)arg->logmsg;
     ++		todo[1].value.update.old_hash = NULL;
     ++		todo[1].value.update.new_hash = val1;
     ++		todo[1].value.update.message = (char *)arg->logmsg;
      +
      +		err = reftable_writer_add_logs(writer, todo, 2);
      +
     @@ refs/reftable-backend.c (new)
      +
      +		free(ri->last_name);
      +		ri->last_name = xstrdup(ri->log.refname);
     -+		oidread(&ri->oid, ri->log.update.new_hash);
     ++		oidread(&ri->oid, ri->log.value.update.new_hash);
      +		return ITER_OK;
      +	}
      +}
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		oidread(&old_oid, log.update.old_hash);
     -+		oidread(&new_oid, log.update.new_hash);
     ++		oidread(&old_oid, log.value.update.old_hash);
     ++		oidread(&new_oid, log.value.update.new_hash);
      +
     -+		full_committer = fmt_ident(log.update.name, log.update.email,
     ++		full_committer = fmt_ident(log.value.update.name,
     ++					   log.value.update.email,
      +					   WANT_COMMITTER_IDENT,
      +					   /*date*/ NULL, IDENT_NO_DATE);
     -+		err = fn(&old_oid, &new_oid, full_committer, log.update.time,
     -+			 log.update.tz_offset, log.update.message, cb_data);
     ++		err = fn(&old_oid, &new_oid, full_committer,
     ++			 log.value.update.time, log.value.update.tz_offset,
     ++			 log.value.update.message, cb_data);
      +		if (err)
      +			break;
      +	}
     @@ refs/reftable-backend.c (new)
      +		struct object_id new_oid;
      +		const char *full_committer = "";
      +
     -+		oidread(&old_oid, log->update.old_hash);
     -+		oidread(&new_oid, log->update.new_hash);
     ++		oidread(&old_oid, log->value.update.old_hash);
     ++		oidread(&new_oid, log->value.update.new_hash);
      +
     -+		full_committer = fmt_ident(log->update.name, log->update.email,
     ++		full_committer = fmt_ident(log->value.update.name,
     ++					   log->value.update.email,
      +					   WANT_COMMITTER_IDENT, NULL,
      +					   IDENT_NO_DATE);
     -+		err = fn(&old_oid, &new_oid, full_committer, log->update.time,
     -+			 log->update.tz_offset, log->update.message, cb_data);
     ++		err = fn(&old_oid, &new_oid, full_committer,
     ++			 log->value.update.time, log->value.update.tz_offset,
     ++			 log->value.update.message, cb_data);
      +		if (err) {
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +		struct reftable_log_record *dest = &rewritten[i];
      +
      +		*dest = logs[i];
     -+		oidread(&ooid, logs[i].update.old_hash);
     -+		oidread(&noid, logs[i].update.new_hash);
     -+
     -+		if (should_prune_fn(&ooid, &noid, logs[i].update.email,
     -+				    (timestamp_t)logs[i].update.time,
     -+				    logs[i].update.tz_offset,
     -+				    logs[i].update.message, policy_cb_data)) {
     ++		oidread(&ooid, logs[i].value.update.old_hash);
     ++		oidread(&noid, logs[i].value.update.new_hash);
     ++
     ++		if (should_prune_fn(&ooid, &noid, logs[i].value.update.email,
     ++				    (timestamp_t)logs[i].value.update.time,
     ++				    logs[i].value.update.tz_offset,
     ++				    logs[i].value.update.message,
     ++				    policy_cb_data)) {
      +			dest->value_type = REFTABLE_LOG_DELETION;
      +		} else {
      +			if ((flags & EXPIRE_REFLOGS_REWRITE) &&
      +			    last_hash != NULL) {
     -+				dest->update.old_hash = last_hash;
     ++				dest->value.update.old_hash = last_hash;
      +			}
     -+			last_hash = logs[i].update.new_hash;
     ++			last_hash = logs[i].value.update.new_hash;
      +		}
      +	}
      +
 21:  79c4b90d0f4 = 21:  460658a13cb git-prompt: prepare for reftable refs backend
 22:  1f48091e549 = 22:  b305fcd49f1 Add "test-tool dump-reftable" command.
 23:  64dc87746db = 23:  a44956d7b08 t1301: document what needs to be done for reftable
 24:  c248b69c6e3 = 24:  f0b7b1e2380 t1401,t2011: parameterize HEAD.lock for REFFILES
 25:  9f1b792459e = 25:  3110d6e6758 t1404: annotate test cases with REFFILES

-- 
gitgitgadget
