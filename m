Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B959C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCQPf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCQPf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:35:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47476F7E
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd5so21933966edb.7
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eOSg44V11LHGI7JpixiBSHXqV0XbvwktvK1xaQWfWY=;
        b=V3dWaPQh8dUWF5vKf8ILbAzqr00+/+dmxWMrvZYGI6nTCfUZeTyDS0TXx7kbjogOOW
         BphtoB8evhFxHlZnGUYhbnKofphA/b6AfmE5W8iwoRrEK6L5UEKqtkQgIpEj7JRJ2DWB
         EZ+sUpTyWO2etRhz+HMiuuUyGnFEKRrFG8kJlM293LSvh0gO0rh6Hbgg9qD9UtbaCQAl
         ZiFajwUq9J4akL3eLaGgYLRzigvMHXe8HpAmWwDW2Jb8j9DySWMOV5VsAjy8fIvoUFdm
         yu+0AT9U3cI+M0UKvPtZx2sZ2B2jRu2gsUtkPU/mIgk7/2OSQcjWedxpwte37peWHMYO
         mFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eOSg44V11LHGI7JpixiBSHXqV0XbvwktvK1xaQWfWY=;
        b=0/n8zSGPEoQkySiqmTH5SJAPffT5tZv8MggaSW+p2bGkJmIyCz30t5kQHSfgR56Q+X
         JD1rKlX9Gsgmf4KnW1ULYCsX7NkDHo9KnKQaFWk0qipfnfO7hQuq+HRGuZqTjaGgoikK
         n4kLFdmOE4FR1phaYTiohtyB+lzOW5NBikMkN3oDeeFgvCqJ5BZmBiRpXSriPl3Bg1YJ
         3O2BgBdHQ6Iq1B9oi9pbt9svZimxenpeEuR4HuWpuKuKjJ+kOIvgPE2QOZjeB2FxZHN3
         pmWx6rEs8s46pFwy/O9kOtvXZyY3u0OftJuirSMbh/48soX4ZY2JHkFkbMNGR3Hp8Vx1
         nSMA==
X-Gm-Message-State: AO0yUKWolLp1XMvNlQ/puKlpFRDXpEYwg94EEMrk/92n6ZyVFj2S0y3Q
        Qo/BMRLYtTPt4Q/Af+f95rTAUkVf8QErcQ==
X-Google-Smtp-Source: AK7set/l8IZlOoW/MkawnBmLl26hive8Tp+LfTGLCIWZVcwuTkgnZSqpSATCoxdai3fOPCHRA5xzYg==
X-Received: by 2002:a17:907:8d07:b0:932:c1e2:9984 with SMTP id tc7-20020a1709078d0700b00932c1e29984mr534376ejc.58.1679067323806;
        Fri, 17 Mar 2023 08:35:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/17] cocci: remove "the_index" wrapper macros
Date:   Fri, 17 Mar 2023 16:35:04 +0100
Message-Id: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 2.40 the last use of "USE_THE_INDEX_COMPATIBILITY_MACROS" went
away, this series does the same for our long-standing migration of
"NO_THE_REPOSITORY_COMPATIBILITY_MACROS".

For review the only interesting patches here are 01-04/17 and
16-17/17, the rest are all a result of mechanically applying the
coccinelle rules incrementally on a header-by-header basis.

For 3x of those I made minor tweaks to the coccille output, because:

 * For whatever reason, it sometimes emits output that would fail
   "diff --check".
 * It would produce very long lines in some cases, which have been
   manually wrapped.
 * For the few that needed casts it wanted to add whitespace between
   the closing ")" and the function name, but the pre-image didn't use
   that, so I adjusted it back.

When merging this to "seen" there's a very trivial conflict in
commit.h, the resolution is to delete both sides:
	
	diff --cc commit.h
	index d4adf111019,d65f1e00145..00000000000
	--- a/commit.h
	+++ b/commit.h
	@@@ -193,7 -207,9 +195,13 @@@ void free_commit_list(struct commit_lis
	  
	  struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
	  
	++<<<<<<< HEAD
	 +int has_non_ascii(const char *text);
	++=======
	+ const char *logmsg_reencode(const struct commit *commit,
	+                           char **commit_encoding,
	+                           const char *output_encoding);
	++>>>>>>> origin/seen
	  const char *repo_logmsg_reencode(struct repository *r,
	                                 const struct commit *commit,
	                                 char **commit_encoding,

Branch & CI for this at:
https://github.com/avar/git/tree/avar/cocci-the-repository-from-pending

Ævar Arnfjörð Bjarmason (17):
  cocci: remove dead rule from "the_repository.pending.cocci"
  cocci: fix incorrect & verbose "the_repository" rules
  cocci: sort "the_repository" rules by header
  cocci: add missing "the_repository" macros to "pending"
  cocci: apply the "cache.h" part of "the_repository.pending"
  cocci: apply the "commit-reach.h" part of "the_repository.pending"
  cocci: apply the "commit.h" part of "the_repository.pending"
  cocci: apply the "diff.h" part of "the_repository.pending"
  cocci: apply the "object-store.h" part of "the_repository.pending"
  cocci: apply the "pretty.h" part of "the_repository.pending"
  cocci: apply the "packfile.h" part of "the_repository.pending"
  cocci: apply the "promisor-remote.h" part of "the_repository.pending"
  cocci: apply the "refs.h" part of "the_repository.pending"
  cocci: apply the "rerere.h" part of "the_repository.pending"
  cocci: apply the "revision.h" part of "the_repository.pending"
  post-cocci: adjust comments for recent repo_* migration
  libs: use "struct repository *" argument, not "the_repository"

 add-interactive.c                             |   2 +-
 add-patch.c                                   |   2 +-
 apply.c                                       |  13 +-
 archive.c                                     |  12 +-
 bisect.c                                      |  11 +-
 blame.c                                       |  15 +-
 branch.c                                      |   7 +-
 builtin/am.c                                  |  23 +--
 builtin/bisect.c                              |  33 ++--
 builtin/blame.c                               |  15 +-
 builtin/branch.c                              |   9 +-
 builtin/cat-file.c                            |  25 +--
 builtin/checkout.c                            |  35 ++--
 builtin/clone.c                               |   6 +-
 builtin/commit-tree.c                         |   4 +-
 builtin/commit.c                              |  29 ++--
 builtin/describe.c                            |   9 +-
 builtin/diff.c                                |   3 +-
 builtin/difftool.c                            |   3 +-
 builtin/fast-export.c                         |  12 +-
 builtin/fast-import.c                         |  17 +-
 builtin/fetch.c                               |  21 +--
 builtin/fsck.c                                |   2 +-
 builtin/gc.c                                  |   8 +-
 builtin/grep.c                                |   6 +-
 builtin/index-pack.c                          |  11 +-
 builtin/log.c                                 |  30 ++--
 builtin/ls-files.c                            |   4 +-
 builtin/ls-tree.c                             |   9 +-
 builtin/merge-base.c                          |   9 +-
 builtin/merge-recursive.c                     |   6 +-
 builtin/merge-tree.c                          |  18 ++-
 builtin/merge.c                               |  23 +--
 builtin/mktag.c                               |   3 +-
 builtin/name-rev.c                            |  11 +-
 builtin/notes.c                               |  34 ++--
 builtin/pack-objects.c                        |  24 ++-
 builtin/prune.c                               |   2 +-
 builtin/pull.c                                |   4 +-
 builtin/range-diff.c                          |  12 +-
 builtin/read-tree.c                           |   2 +-
 builtin/rebase.c                              |  21 +--
 builtin/receive-pack.c                        |  14 +-
 builtin/remote.c                              |   2 +-
 builtin/repack.c                              |   2 +-
 builtin/replace.c                             |  20 +--
 builtin/reset.c                               |  22 +--
 builtin/rev-list.c                            |   2 +-
 builtin/rev-parse.c                           |  18 ++-
 builtin/rm.c                                  |   2 +-
 builtin/shortlog.c                            |  13 +-
 builtin/show-branch.c                         |  19 +--
 builtin/show-ref.c                            |   6 +-
 builtin/sparse-checkout.c                     |   2 +-
 builtin/stash.c                               |  26 +--
 builtin/submodule--helper.c                   |   6 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   4 +-
 builtin/unpack-objects.c                      |   5 +-
 builtin/update-ref.c                          |   8 +-
 builtin/verify-commit.c                       |   2 +-
 builtin/verify-tag.c                          |   2 +-
 builtin/worktree.c                            |   8 +-
 bulk-checkin.c                                |   2 +-
 bundle.c                                      |   5 +-
 cache-tree.c                                  |  16 +-
 cache.h                                       |  19 +--
 checkout.c                                    |   2 +-
 combine-diff.c                                |   8 +-
 commit-graph.c                                |   4 +-
 commit-reach.c                                |  21 +--
 commit-reach.h                                |   9 --
 commit.c                                      |  44 ++---
 commit.h                                      |  22 +--
 connected.c                                   |   4 +-
 contrib/coccinelle/the_repository.cocci       | 123 ++++++++++++++
 .../coccinelle/the_repository.pending.cocci   | 128 ---------------
 delta-islands.c                               |   5 +-
 diff-lib.c                                    |   2 +-
 diff.c                                        |   6 +-
 diff.h                                        |   5 +-
 diffcore-break.c                              |   2 +-
 diffcore-rename.c                             |   4 +-
 dir.c                                         |   2 +-
 entry.c                                       |   3 +-
 fetch-pack.c                                  |   8 +-
 fmt-merge-msg.c                               |  15 +-
 fsck.c                                        |   6 +-
 http-push.c                                   |  16 +-
 http-walker.c                                 |   4 +-
 list-objects-filter-options.c                 |   7 +-
 list-objects.c                                |  20 ++-
 log-tree.c                                    |  28 ++--
 mailmap.c                                     |   4 +-
 match-trees.c                                 |   4 +-
 merge-blobs.c                                 |   6 +-
 merge-ort.c                                   |   6 +-
 merge-recursive.c                             |   9 +-
 negotiator/default.c                          |   6 +-
 negotiator/skipping.c                         |   2 +-
 notes-cache.c                                 |   5 +-
 notes-merge.c                                 |  11 +-
 notes-utils.c                                 |   2 +-
 notes.c                                       |  18 ++-
 object-file.c                                 |   4 +-
 object-name.c                                 |  19 ++-
 object-store.h                                |  11 +-
 pack-bitmap-write.c                           |   3 +-
 packfile.c                                    |   2 +-
 packfile.h                                    |   1 -
 parse-options-cb.c                            |   8 +-
 pretty.c                                      |  10 +-
 pretty.h                                      |   4 -
 promisor-remote.h                             |  15 --
 range-diff.c                                  |  12 +-
 read-cache.c                                  |   9 +-
 rebase-interactive.c                          |   2 +-
 ref-filter.c                                  |   8 +-
 reflog.c                                      |   7 +-
 refs.c                                        |   2 +-
 refs.h                                        |   6 -
 remote.c                                      |  15 +-
 rerere.c                                      |   5 +-
 rerere.h                                      |   3 -
 reset.c                                       |   4 +-
 revision.c                                    |  27 ++--
 revision.h                                    |   3 -
 send-pack.c                                   |   6 +-
 sequencer.c                                   | 150 ++++++++++--------
 shallow.c                                     |  21 +--
 strbuf.h                                      |   6 +-
 submodule-config.c                            |   5 +-
 submodule.c                                   |   8 +-
 t/helper/test-fast-rebase.c                   |  19 ++-
 t/helper/test-match-trees.c                   |   4 +-
 t/helper/test-oidmap.c                        |   6 +-
 t/helper/test-reach.c                         |  12 +-
 t/helper/test-revision-walking.c              |   3 +-
 t/helper/test-submodule-config.c              |   2 +-
 tag.c                                         |   9 +-
 transport-helper.c                            |   2 +-
 transport.c                                   |   3 +-
 tree.c                                        |   5 +-
 unpack-trees.c                                |   2 +-
 upload-pack.c                                 |   8 +-
 walker.c                                      |   6 +-
 wt-status.c                                   |  21 +--
 xdiff-interface.c                             |   2 +-
 148 files changed, 958 insertions(+), 873 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci
 delete mode 100644 contrib/coccinelle/the_repository.pending.cocci

-- 
2.40.0.rc1.1034.g5867a1b10c5

