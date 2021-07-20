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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C4C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6173610D2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhGTQZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhGTQYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB696C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u1so26832409wrs.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=bQ32i+Yd0JBnxU9nnEWPZix1WQCthiRX/vjeKci9srY=;
        b=jlhBngxFz2TEydsNOGjUWA7vkaI+UDUs525CZO7JqcMROEt0vYjffJqQfHWGwG3d/O
         fUckdmWUSMSE8dHqBC2yf/9PfDX0p8AC/vI9Bjtm77FgSa+RQHVjIL3K2Tw3tjbBz6xP
         xckpM/wz+cHkCV7vZIN8LnsJxUqQdf9fXuxgLy6+0/L/EBmRcMvCEG/5sh++m71hcByL
         E1unFpEcZrG9LcMz2EBre2xQ9AXYPs+S481SDPDqQa4xAXCPPhQe7Ba3Q5PDloOX7MQM
         Jfgeq3FCtLDJ1oVtCzsGM+LwaQK9fsVDhjRe8A6Kt2C6qLlQX/zVXJQ+Fzku2q4C5Anh
         rSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bQ32i+Yd0JBnxU9nnEWPZix1WQCthiRX/vjeKci9srY=;
        b=QnUhiPSPfghahuiteXJtiFFNckpTzLGROHtd2y+uATkbUNOW2+2GcPd9d6MEIIVD36
         6CB6KxpP5dnL7j3PP1w1TpHqDgnVGF+UIkaZuroY1iNqD3vo+YPcATUVFA3EDMjfsAZP
         SH3Ij8YZxuGmUG13FJ8o8Gea4atLFl1RffyBAh7pNLSl7fG+IDmS9LEWKF4qAWGRlE56
         32aGT/3QhYxON6vNfkGZM1SQ+qP3FtmYYlI2jOCSNaN965MHl+gW5/UdySl38RLWJJHb
         Hc0nB4w4lbyOdFJULiT8iMA7kLd4D8+UyBJ67Y2zmqR3qnBt/KHpfY7CNL5Nxs/LYbBx
         0AOg==
X-Gm-Message-State: AOAM532dDKRwdVeNedku9HuwdkU+sgAD3TsdnR/qVBSJ4IHVHtw5Ev8B
        8RaeI3sk1o8LN2B8Gsv46IOZXq+6cj4=
X-Google-Smtp-Source: ABdhPJzRfMjw8aqMZERyVtVaxbXxfPOhkp2EWt0EFZICN++AmEG3vmYZNpG+0jDjhz2GC+++NPm3zQ==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr37369142wrw.112.1626800688272;
        Tue, 20 Jul 2021 10:04:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm11064301wrt.94.2021.07.20.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:47 -0700 (PDT)
Message-Id: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:20 +0000
Subject: [PATCH 00/26] Support reftable ref backend for Git
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

Changes relative to last series (version 19 Apr 2021, tip: b8729fe)

 * drop EINVAL for broken refs.
 * fix 2 UBSAN warnings. Thanks to Andrzej Hunt for reporting.
 * make tests pass against master (use oidread)
 * handle worktree/xx/refname refs.
 * handle main-worktree/ref
 * fix double free in branch renaming
 * handle relative paths (used in git upload-pack invocation) for ref
   backend creation.
 * test and fix test-tool dump-reftable command

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


Han-Wen Nienhuys (25):
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
  t7004: avoid direct filesystem access

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
 config.mak.uname                              |    2 +-
 configure.ac                                  |   13 +
 contrib/buildsystems/CMakeLists.txt           |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 hash.h                                        |    6 +
 object-file.c                                 |    7 +-
 refs.c                                        |   26 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1683 +++++++++++++++++
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
 reftable/dump.c                               |  105 +
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
 reftable/readwrite_test.c                     |  650 +++++++
 reftable/record.c                             | 1200 ++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  407 ++++
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
 reftable/stack_test.c                         |  947 ++++++++++
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
 setup.c                                       |    6 +
 t/helper/test-reftable.c                      |   21 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  297 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1301-shared-repo.sh                        |    8 +-
 t/t1401-symbolic-ref.sh                       |   11 +-
 t/t1404-update-ref-errors.sh                  |   56 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t2011-checkout-invalid-head.sh              |   11 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/t7004-tag.sh                                |    7 +-
 t/test-lib.sh                                 |    7 +-
 94 files changed, 13129 insertions(+), 63 deletions(-)
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


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1054%2Fhanwen%2Flibreftable-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1054/hanwen/libreftable-v1
Pull-Request: https://github.com/git/git/pull/1054
-- 
gitgitgadget
