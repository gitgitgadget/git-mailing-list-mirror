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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F862C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443FB60E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhH3O64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbhH3O6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:58:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D4C06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:57:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so16670641wrg.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=u30AIxMQgXd7gjjhc4cjPxZPibNoDchyXq6NCr8yBEU=;
        b=Pww6DaMgHPszNUSjnY2b9swJShAH8joLomYfxlbUaLRz1+jQYOTrd2Fgyn2I73tUQp
         mnymelbgyjqaYLbg0MFaWEs8My2IcsqEfcldNp8ePstfy/1WQp3F10UDdHys0GKGnT6U
         0jJxP10Af82eCzE029dKnDwxbXG1YjhKwokG5tJL8UFnpnNfeQbGxlxwn6x+z51D02Jm
         dKLid6rp8qKGAHKNORh2+TEURCaoPSd4jUND1LMiNkah4//zNGX0pQY/cK3VY/yq2UHD
         jUB6iLrNv5pINGK09Q75u8AxiEqYN5EJ268QkBFhw7ZLHaxn4rCOtHC1bvb75/qEJbo9
         dQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=u30AIxMQgXd7gjjhc4cjPxZPibNoDchyXq6NCr8yBEU=;
        b=T9+l4JP1nu6kEtZsrvPXmrwvsvbhDU4yy/tc0EopYMopc5VM7Fwwj5xvf7uNSM/mDS
         TtAzqLZFyavXJuxkcU3eKhTxk0hjzwypMsheow+wIj3U/5V3DoBFpBv4IwX0MrZT3ttb
         ZlVdmHhZg/nnWTxkECkacx/HIDIBN820lPW5TkMgwJhvycDO18IyJ2jnzNi4UzyrOIwb
         AfeJPJjLgqLqtIt2jMJPTVkJtV1SKc4Fijy05srl599/d1AWb4MjW/yQXt7YUgwjTne4
         AbcVaP1YyJ91JVngfdOt2J/ZqDkrfJ8tgtQ7oHaDoxe6jZPOePgGioET+EgTPoyq2wjm
         7DPw==
X-Gm-Message-State: AOAM530nWanPISOs9fnPKYZSvLySAMnyPN7n7ZtW1uzTD0ptxF9chuz6
        5qzOK1gAI4GkfqNJWLWcb/ZtE6670ZY=
X-Google-Smtp-Source: ABdhPJw/FVfZno3jIFZcRI9xg+1zqzrWEgLSNiQJmh1ulFMpFUK9bCoNoSPOxBwgc6a0fD/m6ch7SA==
X-Received: by 2002:adf:9f4e:: with SMTP id f14mr8377925wrg.396.1630335477647;
        Mon, 30 Aug 2021 07:57:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b62sm9153830wmb.17.2021.08.30.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:57:57 -0700 (PDT)
Message-Id: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:57:36 +0000
Subject: [PATCH 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reftable format is described in Documentation/technical/reftable.txt.

This is a fully reentrant implementation of reading and writing the reftable
file format, and should be suitable for embedding in libgit2 too. It does
not hook the code up to git to function as a ref storage backend yet.

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
 compat/zlib-uncompress2.c                  |   92 ++
 config.mak.uname                           |    1 +
 configure.ac                               |   13 +
 contrib/buildsystems/CMakeLists.txt        |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm |   11 +-
 hash.h                                     |    6 +
 object-file.c                              |    7 +-
 reftable/LICENSE                           |   31 +
 reftable/basics.c                          |  128 ++
 reftable/basics.h                          |   60 +
 reftable/basics_test.c                     |   98 ++
 reftable/block.c                           |  448 +++++++
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
 reftable/pq.c                              |  115 ++
 reftable/pq.h                              |   32 +
 reftable/pq_test.c                         |   72 +
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
 reftable/system.h                          |   24 +
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
 69 files changed, 10932 insertions(+), 12 deletions(-)
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


base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1081%2Fhanwen%2Fjust-library-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1081/hanwen/just-library-v1
Pull-Request: https://github.com/git/git/pull/1081
-- 
gitgitgadget
