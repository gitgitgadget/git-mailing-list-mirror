Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D56C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABA26137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHWMNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhHWMNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BEC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso13914255wmg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzR69EL3nGxsAKJqofHS2w/QBlWYtqJIobQTzA/z2MI=;
        b=VqfWyJ0SDuTlSPdctrKaQ8Ur4evF/f4rJYoH75cxve9aMUOVPYIDYc5Pq+zPh1p5/b
         MXO5Y+aQXhAOc3kWqJoZThlXwEAPBLPzBtas6D4cVF+96iK2sF71TSB+GnpqnFaacLJ7
         Q1Bm9Uiic7eqpk8VVNGo3T+C2ou+8S9I8fixkMzLsXqtDhWNRqG0hp7SXPL2O3zZYaJ2
         EMWWcn/PoLUFtPR+gtYq4u6thq1mAuYpbTU8m2VJrojgI9oZ6kia0EttffpiHvtiV1h8
         /1e5zQFxlCOmeRL2xfKs9TwpixU9x4UYZdghb5M0lSI1mhYnn66EAyTXF3MOfyaI4LZc
         zqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzR69EL3nGxsAKJqofHS2w/QBlWYtqJIobQTzA/z2MI=;
        b=FF0Hqv3EckBC1OZQk0VTKgtXzpOrvzALQ7BeqPOoKQ4lrDt4mEDZ/SQQaDm/78zJTZ
         qcAQEMiCWz4SL5S5y70xyr14A0Tfe8qtCZecY0RQWEdyOLuez+n1CagOa8TMfmWuZx0y
         lETn1nUXdW31ImRC3vNTRhDgNsP3SZu2xCPhjc+L5J6P8R5bVVN/8n6yFCYKFH+LAqs6
         Exl7uUayQPwlvIiGmCrgKabFjWW3bVn0kZkR8HQrwXMnCwdG1yKIX6yN2mVvefvUe7kY
         dc/LJt2eeKPvtyzHRbt357PctCc7dsDmcKVLDO41p44J+Ko8ehneOMGctdBAQCpY6Rte
         TrpA==
X-Gm-Message-State: AOAM533DfUh7uOXmyiD9q9tK45eIsuJ/XhmLf9mIkd+6SDuCbiLhjwWg
        CiARuWXAc/Rk1pte5WjkQLW0K7lnYPsD+MmS
X-Google-Smtp-Source: ABdhPJwARyQVaKct0XiVsH8smeb95J5C55LQG2EVA6uWaEi4d5hu6ElPmk8xXZoDvE0SLtgQ/jOiuA==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr16006502wmq.101.1629720774700;
        Mon, 23 Aug 2021 05:12:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/28] Support reftable ref backend for Git
Date:   Mon, 23 Aug 2021 14:12:11 +0200
Message-Id: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a version of the reftable series queued on top of my
just-re-rolled fixes to the refs APIs, which it can make use of. For
the base topics see:

    https://lore.kernel.org/git/cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com/
    https://lore.kernel.org/git/cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com/

For Han-Wen's v3 of this see:
https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com/

I've got no desire to take over the reftable topic in its entirety,
but think given the rationale in
https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/
(summarized in
https://lore.kernel.org/git/87y28sfokk.fsf@evledraar.gmail.com/) that
having the refs API fixes I noted above wait on the still-unstable
reftable doesn't make sense.

I think that plan came about due to my non-responsiveness for the past
couple of weeks (I was on vacation).

So I'm submitting this so Junio has something to pick up and put in
hn/reftable which compiles and passes tests, this should clear up the
outstanding issues in the "seen" branch.

As the range-diff shows the only changes are the addition of three new
patches at the end. Those patches clearly need to be squashed into
their respective preceding commits.

I'll let Han-Wen deal with that squashing in a presumed future v5 of
this, assuming of course that Junio's happy with the plan of basing
hn/reftable on the refs API fixes above.

I'm not sure that the fix I have in 27/28 is the right one, perhaps
we've already got information about what the tip OID of the refname is
at that point in git_reftable_reflog_expire() via some API I missed,
but that fix works, and is clearly more correct than the outstanding
segfault.

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

Ævar Arnfjörð Bjarmason (3):
  reftable: fixup for new base topic 1/3
  reftable: fixup for new base topic 2/3
  reftable: fixup for new base topic 3/3

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
 refs/reftable-backend.c                       | 1687 +++++++++++++++++
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
 94 files changed, 13174 insertions(+), 62 deletions(-)
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

Range-diff against v3:
 1:  cad3c4835a2 =  1:  295ccff312f hash.h: provide constants for the hash IDs
 2:  97aba3ae406 =  2:  2fb0fb20282 init-db: set the_repository->hash_algo early on
 3:  fca162dd676 =  3:  6cf0b244fc5 reftable: RFC: add LICENSE
 4:  44923074a5a =  4:  a0686356c11 reftable: add error related functionality
 5:  2f2beb70078 =  5:  23ceb2e5723 reftable: utility functions
 6:  79d4a23764d =  6:  9429aaf7c76 reftable: add blocksource, an abstraction for random access reads
 7:  2c143c75cd5 =  7:  f4cebccb9e0 reftable: (de)serialization for the polymorphic record type.
 8:  d92338467d6 =  8:  e2f2729443b Provide zlib's uncompress2 from compat/zlib-compat.c
 9:  74ac0b135fa =  9:  9d468fbdd07 reftable: reading/writing blocks
10:  a2219670079 = 10:  7d8b8e3b76a reftable: a generic binary tree implementation
11:  ac3063fd08c = 11:  7ec422318eb reftable: write reftable files
12:  e0f3476555e = 12:  df4fae30ceb reftable: generic interface to tables
13:  f1fe338f67e = 13:  7e8a613206f reftable: read reftable files
14:  7da9a85c1db = 14:  ebe55aa6295 reftable: reftable file level tests
15:  953590034a8 = 15:  a9880fc1a10 reftable: add a heap-based priority queue for reftable records
16:  64fe3c8edc5 = 16:  c073be56a6b reftable: add merged table view
17:  acb0d435a20 = 17:  092b9715672 reftable: implement refname validation
18:  764d45fccd4 = 18:  374c22efbd9 reftable: implement stack, a mutable database of reftable files.
19:  88dbab683dc = 19:  007c9359f42 reftable: add dump utility
20:  3d57f7c4430 = 20:  8f948c0b257 refs: RFC: Reftable support for git-core
21:  460658a13cb = 21:  443bdebfb5d git-prompt: prepare for reftable refs backend
22:  b305fcd49f1 = 22:  f76e7a7bd10 Add "test-tool dump-reftable" command.
23:  a44956d7b08 = 23:  6b62a8c52ae t1301: document what needs to be done for reftable
24:  f0b7b1e2380 = 24:  c926f1526aa t1401,t2011: parameterize HEAD.lock for REFFILES
25:  3110d6e6758 = 25:  0b3db9fc2d6 t1404: annotate test cases with REFFILES
 -:  ----------- > 26:  dde80a982c1 reftable: fixup for new base topic 1/3
 -:  ----------- > 27:  c4f9fb42d9e reftable: fixup for new base topic 2/3
 -:  ----------- > 28:  c863b03201c reftable: fixup for new base topic 3/3
-- 
2.33.0.662.gbaddc25a55e

