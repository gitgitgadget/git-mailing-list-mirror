Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517DC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjDPDDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjDPDDb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447126AA
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k36-20020a05600c1ca400b003f0a7c483feso4537798wms.4
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614208; x=1684206208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/PlAzepPiN3aY4gI037TtT2sVAeHw1xOMsuJh/zSoNU=;
        b=D4miCiNp7MZrnqlsYdkxF6PkY7qMsZ1YNNlu2GSh1BTrgqELJO9xx0AEA4B3tb5PZQ
         xKS0oMiaKuzVX3Wv0fTbkYv36hUa2MEpequVNMLvzgdFDb5QZ0cFZvrIbFwg1ITud/i+
         2EyaFSj2ERYfviVRQztBux1cYYqYXxwXoUq/XkGJKW3IpAJ4bWJi7sm3wLv1htAmDuF2
         FUS3HCyTXVcja3wGmrBG68qq73ekXCwiKyWoYmhgW5D6cOOULl/b7e1tTgA0X6KnUpWR
         zDxiki3wmUT3LiDaEqC4+vZuGlDpJkTwV9EyKb4qZvyz1RypEmAZ1PjbeyJr0E/UDDjn
         Sa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614208; x=1684206208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PlAzepPiN3aY4gI037TtT2sVAeHw1xOMsuJh/zSoNU=;
        b=gXE8qJawpMCsyPXca7frpcW/55jC2yaLQx9vCN16dCvfeLdJR5V9qQs1VLkmxT0iN0
         ylBZDxBlijQgd3cLB5roexfhpg4JdCGclOfe2UhgcIXBf66UVPex4/B2WqDp+fjNuqkZ
         3QifrzUmqnnTIIV7gtTDPTkFwJp1FMF/0gEtplUk1fvAoXyT73eqgzm1S4vD9MRrXCUe
         IWaRpawe7j/he8XaiCLKEV6IYFxx+uck/cJo6xtceIJuJEmasUSgibHiN+V/J1S8suAP
         Nk03ATZ7zOlUBYiMIhp4TUDfbMb/Iqjlmy0WfiLYpBjzJmLEhfFWap6kKRSr0/sdVzxd
         MNUg==
X-Gm-Message-State: AAQBX9eM1xATbE719bLGUpN+G9AG+r5qRKhfzhYU9cZGqF5wshNTW4JJ
        LUNvAIasqXUvaBZBua9m8nO6RZfLVlk=
X-Google-Smtp-Source: AKy350YveYrKyARs+DDZsCleyJsLpHNxw7dfB+iCNNAEgS32uzdPf8CetySP1mTkPGwnvgnj+fXGRw==
X-Received: by 2002:a7b:cb88:0:b0:3f1:6faa:d94c with SMTP id m8-20020a7bcb88000000b003f16faad94cmr1274959wmi.16.1681614208186;
        Sat, 15 Apr 2023 20:03:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b002de99432fc8sm6991208wro.49.2023.04.15.20.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:27 -0700 (PDT)
Message-Id: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:02 +0000
Subject: [PATCH 00/23] Header cleanups (more splitting of cache.h and simplifying a few other deps)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer notes: (1) This series is based on en/header-split-cache-h (now
in next). (2) Although I've tweaked the series to minimize conflicts, there
is a semantic conflict with sl/sparse-write-tree in next; to resolve, add an
include of repository.h in builtin/write-tree.c.

This series continues to focus on splitting declarations from cache.h to
separate headers. This series also untangles some dependencies between
hash.h and repository.h, and between read-cache.c and tree.[ch], and cleans
up a few other headers. At the end of this series the number of cache.h
includes drops from 189 down to 149.

The series may appear to be long at first glance, but is filled with mostly
repetitive and simple changes similar to those from earlier series. An
overview:

 * Patch 1: files depending on strbuf.h should be explicit about it
 * Patches 2-13: move stuff out of cache.h into other more logical headers
 * Patch 14-16: move functions between hash<->repository and
   read-cache<->tree to simplify dependencies
 * Patch 17: remove includes of cache.h permitted by the previous 16 patches
 * Patches 18-22: clean up now-unnecessary includes in other headers
 * Patch 23: start enforcing git-compat-util.h is first include for reftable
   files as well.

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (23):
  treewide: be explicit about dependence on strbuf.h
  symlinks.h: move declarations for symlinks.c functions from cache.h
  protocol.h: move definition of DEFAULT_GIT_PORT from cache.h
  packfile.h: move pack_window and pack_entry from cache.h
  server-info.h: move declarations for server-info.c functions from
    cache.h
  copy.h: move declarations for copy.c functions from cache.h
  base85.h: move declarations for base85.c functions from cache.h
  pkt-line.h: move declarations for pkt-line.c functions from cache.h
  match-trees.h: move declarations for match-trees.c functions from
    cache.h
  ws.h: move declarations for ws.c functions from cache.h
  versioncmp.h: move declarations for versioncmp.c functions from
    cache.h
  dir.h: move DTYPE defines from cache.h
  tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
  hash.h, repository.h: reverse the order of these dependencies
  cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
  cache,tree: move basic name compare functions from read-cache to tree
  treewide: remove cache.h inclusion due to previous changes
  cache.h: remove unnecessary headers
  fsmonitor: reduce includes of cache.h
  commit.h: reduce unnecessary includes
  object-store.h: reduce unnecessary includes
  diff.h: reduce unnecessary includes
  reftable: ensure git-compat-util.h is the first (indirect) include

 add-interactive.c                            |   1 +
 alloc.c                                      |   1 +
 apply.c                                      |   3 +
 archive-zip.c                                |   2 +-
 archive.c                                    |   2 +
 attr.c                                       |   1 +
 base85.c                                     |   3 +-
 base85.h                                     |   7 +
 bloom.c                                      |   1 +
 branch.c                                     |   1 +
 builtin/apply.c                              |   1 +
 builtin/archive.c                            |   1 +
 builtin/bisect.c                             |   1 +
 builtin/bundle.c                             |   2 +
 builtin/check-attr.c                         |   1 +
 builtin/check-ignore.c                       |   1 +
 builtin/checkout-index.c                     |   1 +
 builtin/checkout.c                           |   1 +
 builtin/clean.c                              |   1 +
 builtin/clone.c                              |   2 +
 builtin/config.c                             |   1 +
 builtin/credential-cache.c                   |   1 +
 builtin/credential-store.c                   |   1 +
 builtin/diff-tree.c                          |   1 +
 builtin/diff.c                               |   1 +
 builtin/difftool.c                           |   1 +
 builtin/fetch.c                              |   1 +
 builtin/for-each-repo.c                      |   2 +
 builtin/gc.c                                 |   1 +
 builtin/help.c                               |   1 +
 builtin/init-db.c                            |   2 +
 builtin/log.c                                |   1 +
 builtin/ls-remote.c                          |   1 +
 builtin/merge-index.c                        |   1 +
 builtin/merge-recursive.c                    |   1 +
 builtin/merge-tree.c                         |   1 +
 builtin/mv.c                                 |   1 +
 builtin/push.c                               |   2 +
 builtin/read-tree.c                          |   1 +
 builtin/receive-pack.c                       |   1 +
 builtin/repack.c                             |   1 +
 builtin/rerere.c                             |   1 +
 builtin/rm.c                                 |   1 +
 builtin/show-branch.c                        |   1 +
 builtin/show-index.c                         |   1 +
 builtin/update-index.c                       |   2 +
 builtin/update-ref.c                         |   1 +
 builtin/update-server-info.c                 |   1 +
 builtin/upload-archive.c                     |   1 +
 builtin/worktree.c                           |   2 +
 bundle-uri.c                                 |   3 +-
 cache.h                                      | 143 +------------------
 checkout.c                                   |   1 +
 chunk-format.c                               |   1 +
 color.c                                      |   3 +-
 combine-diff.c                               |   3 +-
 commit-graph.c                               |   1 +
 commit.c                                     |   1 +
 commit.h                                     |  11 +-
 common-main.c                                |   4 +-
 compat/fsmonitor/fsm-health-darwin.c         |   2 +-
 compat/fsmonitor/fsm-ipc-darwin.c            |   4 +-
 compat/fsmonitor/fsm-ipc-win32.c             |   1 +
 compat/fsmonitor/fsm-listen-darwin.c         |   3 +-
 compat/mingw.c                               |   1 +
 compat/precompose_utf8.c                     |   1 +
 compat/win32/trace2_win32_process_info.c     |   1 +
 config.c                                     |   3 +-
 convert.c                                    |   1 +
 copy.c                                       |   4 +-
 copy.h                                       |  10 ++
 credential.c                                 |   3 +-
 csum-file.c                                  |   1 +
 daemon.c                                     |   4 +-
 date.c                                       |   3 +-
 diagnose.c                                   |   2 +-
 diff-lib.c                                   |   1 +
 diff.c                                       |   2 +
 diff.h                                       |   1 -
 dir.c                                        |   2 +
 dir.h                                        |  15 ++
 editor.c                                     |   1 +
 entry.c                                      |   1 +
 environment.c                                |   3 +-
 exec-cmd.c                                   |   1 +
 fetch-pack.c                                 |   1 +
 fsck.c                                       |   1 +
 fsmonitor--daemon.h                          |   1 -
 fsmonitor-ipc.c                              |   1 +
 gpg-interface.c                              |   2 +
 grep.c                                       |   1 +
 hash-lookup.c                                |   1 +
 hash.h                                       |  97 -------------
 hex.c                                        |   1 +
 hook.c                                       |   1 +
 http-push.c                                  |   2 +
 khash.h                                      |   1 +
 line-log.c                                   |   1 +
 ll-merge.c                                   |   3 +-
 log-tree.c                                   |   1 +
 match-trees.c                                |   3 +-
 match-trees.h                                |  10 ++
 merge-ort-wrappers.c                         |   2 +
 merge-ort.c                                  |   1 +
 merge-recursive.c                            |   2 +
 merge.c                                      |   1 +
 midx.c                                       |   2 +-
 negotiator/default.c                         |   1 +
 negotiator/skipping.c                        |   1 +
 notes-cache.c                                |   1 +
 notes-utils.c                                |   1 +
 object-file.c                                |   3 +-
 object-file.h                                |   2 +
 object-name.c                                |   2 +
 object-store.h                               |   8 +-
 object.h                                     |   1 +
 oid-array.h                                  |   1 +
 oidmap.c                                     |   1 +
 oidtree.c                                    |   1 +
 pack-bitmap-write.c                          |   2 +
 packfile.c                                   |   2 +-
 packfile.h                                   |  16 ++-
 parallel-checkout.c                          |   2 +
 parse-options-cb.c                           |   1 +
 parse-options.c                              |   1 +
 pathspec.c                                   |   2 +
 pkt-line.c                                   |   3 +-
 pkt-line.h                                   |   2 +
 preload-index.c                              |   1 +
 progress.c                                   |   1 +
 protocol.h                                   |  21 +++
 range-diff.c                                 |   2 +-
 read-cache.c                                 |  81 ++---------
 rebase-interactive.c                         |   1 +
 ref-filter.c                                 |   4 +-
 reflog.c                                     |   2 +
 refs/debug.c                                 |   1 +
 refs/files-backend.c                         |   2 +
 refs/packed-backend.c                        |   1 +
 refs/ref-cache.c                             |   1 +
 refs/ref-cache.h                             |   1 +
 refspec.c                                    |   2 +
 reftable/error.c                             |   1 +
 reftable/publicbasics.c                      |   2 +-
 reftable/tree.c                              |   2 +-
 reftable/tree_test.c                         |   1 +
 repository.h                                 |  96 +++++++++++++
 rerere.c                                     |   1 +
 resolve-undo.c                               |   1 +
 revision.h                                   |   1 +
 run-command.c                                |   1 +
 send-pack.c                                  |   1 +
 sequencer.c                                  |   1 +
 server-info.c                                |   3 +-
 server-info.h                                |   7 +
 split-index.c                                |   2 +
 strbuf.c                                     |   1 +
 submodule-config.c                           |   1 +
 symlinks.c                                   |   3 +-
 symlinks.h                                   |  28 ++++
 t/helper/test-bloom.c                        |   1 +
 t/helper/test-cache-tree.c                   |   1 +
 t/helper/test-dump-cache-tree.c              |   1 +
 t/helper/test-dump-fsmonitor.c               |   1 +
 t/helper/test-dump-untracked-cache.c         |   1 +
 t/helper/test-example-decorate.c             |   1 +
 t/helper/test-fsmonitor-client.c             |   1 +
 t/helper/test-lazy-init-name-hash.c          |   1 +
 t/helper/test-match-trees.c                  |   3 +-
 t/helper/test-mergesort.c                    |   2 +-
 t/helper/test-oid-array.c                    |   2 +-
 t/helper/test-oidmap.c                       |   1 +
 t/helper/test-oidtree.c                      |   2 +-
 t/helper/test-parse-options.c                |   2 +-
 t/helper/test-path-utils.c                   |   1 +
 t/helper/test-read-cache.c                   |   1 +
 t/helper/test-read-midx.c                    |   2 +-
 t/helper/test-reftable.c                     |   1 +
 t/helper/test-scrap-cache-tree.c             |   1 +
 t/helper/test-string-list.c                  |   2 +-
 t/helper/test-submodule-config.c             |   1 +
 t/helper/test-submodule-nested-repo-config.c |   1 +
 t/helper/test-submodule.c                    |   1 +
 t/helper/test-trace2.c                       |   1 +
 t/helper/test-write-cache.c                  |   1 +
 trace2.c                                     |   1 +
 trace2/tr2_tgt_event.c                       |   1 +
 trace2/tr2_tgt_normal.c                      |   1 +
 trace2/tr2_tgt_perf.c                        |   1 +
 tree-diff.c                                  |  16 ++-
 tree-walk.c                                  |   2 +-
 tree-walk.h                                  |   1 +
 tree.c                                       |  72 +++++++++-
 tree.h                                       |  11 +-
 unpack-trees.c                               |   1 +
 versioncmp.c                                 |   3 +-
 versioncmp.h                                 |   6 +
 wrapper.c                                    |   5 +-
 ws.c                                         |   6 +-
 ws.h                                         |  33 +++++
 wt-status.c                                  |   1 +
 201 files changed, 598 insertions(+), 371 deletions(-)
 create mode 100644 base85.h
 create mode 100644 copy.h
 create mode 100644 match-trees.h
 create mode 100644 server-info.h
 create mode 100644 symlinks.h
 create mode 100644 versioncmp.h
 create mode 100644 ws.h


base-commit: 4711556905f381c01f1fbae205f67cfa673ab44a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1517%2Fnewren%2Fheader-cleanup-4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1517/newren/header-cleanup-4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1517
-- 
gitgitgadget
