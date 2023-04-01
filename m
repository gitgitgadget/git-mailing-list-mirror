Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83798C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjDAPKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDAPKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DED11EA0
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so16805605wmq.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ngZVnS9Gcc6OUbu8jhdSnVG2qQoW8IZHz/v9P1iWnu8=;
        b=iOcaheJM/t3YTNNatQ0tyfisPvNx0CcpEqY/JZ31hmwyBUW0kjfcQ5NEolhuJNEjRy
         ETPBKfKhcnfLwQq86wX9zmXJspSYsV28OGIu+iG6dSD+YpXCZFrKIbsQZYzh8CUvqYUv
         awMabdlbku10SEVDKTbmxWnWtkH04ncbtBOWMLio/RoJSUK0uADE8fQ91yJRVtPt/vQs
         UKCqKJX/DStMma3qlzl+3JQCuRoHp0driLzefvZFKFmsjbOKef+Q+14+zPY7rp5cScfx
         k63tKDaFbGVMTF/S1VN5Ms/OtiBJQabQsIgbHoE6eBf4+3leHi+aBKP+ItBOkVscb7J2
         WWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngZVnS9Gcc6OUbu8jhdSnVG2qQoW8IZHz/v9P1iWnu8=;
        b=N4NaDULrUB5H41+rYjR8+UqgVe3mWp7OPXPzqTTa3kWPA+fe6E91Qyw/ONazJi+DXe
         x9m6MD2dMUus7AqEXewGgwYMhxMejRhsHEoSjajWxTWWF8Xvn8Rlg0yP7oDSvwMoGMpO
         uVfVsUyZvhHTP+gkCvO/7gKTt0Hlhf07tz+kOmfr6Pi26Qf9CBDi7VkgIW4FjQI6Mg1s
         0AVMzSWCcnPoxCUs+jO2H4zafG8yVxYccWq4kuBOhw46R2DuDGl3hwF7AksNh79R6bPb
         c+C5DjlLHKm8J62n6vCbpmDfY7uUPIsu248Ztj6k1ypIEi0JZ1rRTyCyRX5TtRljXQUm
         zBKA==
X-Gm-Message-State: AAQBX9fJPT7tvNtMhuBzNmFdOr6XmugrQApHwbTw0hXNabFltZdJ7XcB
        tldQs6nhJbIx3hd8AIqPl/dGg0Wsb1g=
X-Google-Smtp-Source: AKy350Z0ftJ/4qktA+DZAl3bp3JHBb6efgG+eK/M8WLdfvSvZ/FryqPHUnmf868wy9/ScVja7H9pqw==
X-Received: by 2002:a1c:7c12:0:b0:3f0:3368:5f7f with SMTP id x18-20020a1c7c12000000b003f033685f7fmr7706169wmc.31.1680361841568;
        Sat, 01 Apr 2023 08:10:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm13553645wmo.25.2023.04.01.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:41 -0700 (PDT)
Message-Id: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:13 +0000
Subject: [PATCH 00/24] Header cleanups (splitting up cache.h)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer notes: (1) This series is based on a merge of
en/header-split-cleanup and ab/remove-implicit-use-of-the-repository (both
in next). (2) Although I've tweaked the series to minimize conflicts (and
this series merges syntactically cleanly with next and seen), there is a
semantic conflict with ja/worktree-orphan in seen; to correct, simply add an
include of advice.h in builtin/worktree.c.

This series builds on en/header-cleanup
(https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget@gmail.com/)
and en/header-split-cleanup
(https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget@gmail.com/),
and continues to focus on splitting declarations from cache.h to separate
headers.

The series may appear to be long at first glance, but is repetitive and
simple. It should be relatively easy to review, and falls into roughly 3
categories. An overview:

 * Patches 1-6: Being more explicit about dependencies. This was motivated
   by the fact that trying to find unnecessary dependencies on cache.h were
   being made harder by implicit dependencies on trace.h, trace2.h, and
   advice.h that were included via cache.h. (Similar to gettext.h handling
   in the previous series.) So I simply try to make dependencies more
   explicit, for both these headers and a few others. To make review easy, I
   split it into half a dozen patches, one header per patch (well, except
   that I handle trace.h and trace2.h together).
 * Patch 7: Remove several includes of cache.h that are no longer needed due
   to patches 1-6.
 * Patches 8-18: For several choices of FOO, move declarations of functions
   for FOO.c from cache.h to FOO.h. To simplify reviewing, each case is
   split into two patches, with the second patch cleaning up unnecessary
   includes of cache.h in other source files. (Patch 14 is a slight
   exception that wasn't split into two patches since the movement was
   otherwise so small)
 * Patches 19-24: Other small manual cleanups noticed while doing above work

Since patches 1-14 & 16-18 are just more of the same types of patches
already reviewed in the last two series, it probably makes more sense for
reviewers to focus on the other patches: 15 + 19-24 (which also happen to be
smaller). I would particularly most like review of patches 15, 21, & 24
since they are the least like any previously reviewed patches.

There are more changes I plan to make after this series graduates (still
focused around splitting up cache.h), but this series was long enough.

And thanks once again to Dscho for gitgitgadget. Getting multiple platform
testing + all the special tests (sparse, cocci, hdr-check, etc.) really
helps clean out all the issues that would otherwise hit a series like this.

Elijah Newren (24):
  treewide: be explicit about dependence on trace.h & trace2.h
  treewide: be explicit about dependence on advice.h
  treewide: be explicit about dependence on convert.h
  treewide: be explicit about dependence on pack-revindex.h
  treewide: be explicit about dependence on oid-array.h
  treewide: be explicit about dependence on mem-pool.h
  treewide: remove unnecessary cache.h inclusion
  object-name.h: move declarations for object-name.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-name.h changes
  git-zlib: move declarations for git-zlib functions from cache.h
  treewide: remove cache.h inclusion due to git-zlib changes
  object-file.h: move declarations for object-file.c functions from
    cache.h
  treewide: remove cache.h inclusion due to object-file.h changes
  object.h: move an inline function and some defines from cache.h
  editor: move editor-related functions and declarations into common
    file
  treewide: remove cache.h inclusion due to editor.h changes
  pager.h: move declarations for pager.c functions from cache.h
  treewide: remove cache.h inclusion due to pager.h changes
  cache.h: remove unnecessary includes
  strbuf: move forward declarations to beginning of file
  treewide: remove double forward declaration of read_in_full
  treewide: reduce includes of cache.h in other headers
  chdir-notify, quote: replace cache.h include with path.h
  mailmap, quote: move declarations of global vars to correct unit

 Makefile                                 |   2 +-
 add-patch.c                              |   3 +
 apply.c                                  |   2 +
 archive-tar.c                            |   1 +
 archive-zip.c                            |   1 +
 archive.c                                |   1 +
 archive.h                                |   3 +-
 blame.c                                  |   2 +
 branch.c                                 |   4 +-
 builtin/add.c                            |   2 +
 builtin/am.c                             |   4 +
 builtin/bisect.c                         |   2 +
 builtin/blame.c                          |   2 +
 builtin/branch.c                         |   2 +
 builtin/bugreport.c                      |   2 +
 builtin/cat-file.c                       |   3 +
 builtin/check-attr.c                     |   1 +
 builtin/checkout.c                       |   3 +
 builtin/clone.c                          |   3 +
 builtin/commit-graph.c                   |   1 +
 builtin/commit-tree.c                    |   1 +
 builtin/commit.c                         |   3 +
 builtin/config.c                         |   1 +
 builtin/credential-cache--daemon.c       |   1 +
 builtin/describe.c                       |   1 +
 builtin/diagnose.c                       |   1 +
 builtin/difftool.c                       |   1 +
 builtin/fast-export.c                    |   1 +
 builtin/fast-import.c                    |   2 +
 builtin/fetch.c                          |   6 +
 builtin/fsck.c                           |   2 +
 builtin/fsmonitor--daemon.c              |   1 +
 builtin/gc.c                             |   2 +
 builtin/grep.c                           |   3 +
 builtin/hash-object.c                    |   1 +
 builtin/help.c                           |   1 +
 builtin/index-pack.c                     |   3 +
 builtin/init-db.c                        |   1 +
 builtin/log.c                            |   4 +
 builtin/ls-files.c                       |   2 +
 builtin/ls-tree.c                        |   1 +
 builtin/merge-base.c                     |   1 +
 builtin/merge-recursive.c                |   2 +
 builtin/merge-tree.c                     |   1 +
 builtin/merge.c                          |   3 +
 builtin/mktag.c                          |   1 +
 builtin/mv.c                             |   2 +
 builtin/name-rev.c                       |   2 +
 builtin/notes.c                          |   2 +
 builtin/pack-objects.c                   |   1 +
 builtin/prune.c                          |   1 +
 builtin/pull.c                           |   2 +
 builtin/push.c                           |   2 +
 builtin/range-diff.c                     |   1 +
 builtin/read-tree.c                      |   1 +
 builtin/rebase.c                         |   3 +
 builtin/receive-pack.c                   |   3 +
 builtin/replace.c                        |   3 +
 builtin/reset.c                          |   4 +
 builtin/rev-list.c                       |   1 +
 builtin/rev-parse.c                      |   1 +
 builtin/rm.c                             |   1 +
 builtin/show-branch.c                    |   1 +
 builtin/show-ref.c                       |   1 +
 builtin/sparse-checkout.c                |   2 +
 builtin/stash.c                          |   1 +
 builtin/submodule--helper.c              |   2 +
 builtin/tag.c                            |   3 +
 builtin/unpack-file.c                    |   1 +
 builtin/unpack-objects.c                 |   1 +
 builtin/update-index.c                   |   1 +
 builtin/update-ref.c                     |   1 +
 builtin/var.c                            |   2 +
 builtin/verify-commit.c                  |   1 +
 builtin/verify-tag.c                     |   1 +
 builtin/worktree.c                       |   2 +
 bulk-checkin.c                           |   4 +-
 bundle.c                                 |   2 +-
 cache-tree.c                             |   3 +
 cache.h                                  | 279 +----------------------
 chdir-notify.c                           |   4 +-
 checkout.c                               |   4 +-
 color.c                                  |   2 +
 column.c                                 |   3 +-
 combine-diff.c                           |   3 +
 commit-graph.c                           |   4 +-
 commit.c                                 |   1 +
 common-main.c                            |   1 +
 compat/fsmonitor/fsm-listen-win32.c      |   1 +
 compat/mingw.c                           |   1 +
 compat/pread.c                           |   1 +
 compat/simple-ipc/ipc-unix-socket.c      |   3 +-
 compat/simple-ipc/ipc-win32.c            |   2 +
 compat/win32/trace2_win32_process_info.c |   1 +
 config.c                                 |   6 +
 connect.c                                |   3 +-
 convert.c                                |   3 +
 date.c                                   |   1 +
 delta-islands.c                          |   2 +-
 diff-lib.c                               |   2 +
 diff.c                                   |   5 +
 dir.c                                    |   3 +
 editor.c                                 |  34 ++-
 editor.h                                 |  34 +++
 environment.c                            |   4 +-
 exec-cmd.c                               |   2 +
 fetch-pack.c                             |   3 +-
 fmt-merge-msg.c                          |   3 +-
 fsck.c                                   |   2 +-
 fsmonitor.c                              |   1 +
 fsmonitor.h                              |   1 +
 git-compat-util.h                        |   6 -
 zlib.c => git-zlib.c                     |   3 +-
 git-zlib.h                               |  28 +++
 git.c                                    |   3 +
 grep.c                                   |   1 +
 http-backend.c                           |   3 +-
 http-fetch.c                             |   2 +-
 http-push.c                              |   2 +-
 http-walker.c                            |   2 +-
 http.c                                   |   2 +
 http.h                                   |   4 +-
 list-objects-filter.c                    |   1 +
 list-objects.c                           |   2 +-
 ll-merge.c                               |   1 +
 log-tree.c                               |   1 +
 mailmap.c                                |   3 +-
 mailmap.h                                |   3 +
 merge-ort.c                              |   4 +
 merge-recursive.c                        |   1 +
 midx.c                                   |   1 +
 name-hash.c                              |   1 +
 notes-merge.c                            |   6 +-
 notes.c                                  |   3 +-
 object-file.c                            |   2 +
 object-file.h                            | 121 ++++++++++
 object-name.c                            |   2 +
 object-name.h                            |  99 ++++++++
 object.c                                 |   1 +
 object.h                                 |  21 ++
 pack-bitmap-write.c                      |   2 +-
 pack-bitmap.c                            |   4 +-
 pack-check.c                             |   3 +-
 pack-mtimes.c                            |   3 +-
 pack-revindex.c                          |   4 +-
 pack-write.c                             |   4 +-
 packfile.c                               |   3 +
 pager.c                                  |   6 +-
 pager.h                                  |  17 ++
 parse-options-cb.c                       |   1 +
 path.c                                   |   1 +
 pkt-line.c                               |   1 +
 preload-index.c                          |   1 +
 pretty.c                                 |   3 +-
 progress.c                               |   4 +-
 promisor-remote.c                        |   3 +-
 protocol.c                               |   3 +-
 quote.c                                  |   3 +-
 quote.h                                  |   2 +
 range-diff.c                             |   2 +
 read-cache.c                             |   5 +
 rebase-interactive.c                     |   2 +
 ref-filter.c                             |   2 +
 refs.c                                   |   4 +-
 refs/files-backend.c                     |   1 +
 refs/packed-backend.c                    |   1 +
 refs/ref-cache.h                         |   2 +-
 remote-curl.c                            |   1 +
 remote.c                                 |   3 +-
 repository.c                             |   1 +
 rerere.c                                 |   3 +-
 reset.c                                  |   1 +
 resolve-undo.h                           |   7 +-
 revision.c                               |   4 +-
 run-command.c                            |   2 +
 scalar.c                                 |   3 +-
 send-pack.c                              |   1 +
 sequencer.c                              |   4 +
 server-info.c                            |   1 +
 setup.c                                  |   5 +-
 shallow.c                                |   1 +
 sideband.c                               |   3 +-
 split-index.c                            |   1 +
 split-index.h                            |   2 +-
 strbuf.c                                 |  31 +--
 strbuf.h                                 |  33 +--
 streaming.c                              |   4 +-
 submodule-config.c                       |   3 +-
 submodule.c                              |   3 +
 t/helper/test-date.c                     |   2 +-
 t/helper/test-fast-rebase.c              |   1 +
 t/helper/test-lazy-init-name-hash.c      |   1 +
 t/helper/test-match-trees.c              |   1 +
 t/helper/test-mergesort.c                |   1 +
 t/helper/test-oidmap.c                   |   2 +-
 t/helper/test-path-utils.c               |   1 +
 t/helper/test-reach.c                    |   2 +-
 t/helper/test-submodule-config.c         |   2 +-
 tag.c                                    |   1 +
 tmp-objdir.c                             |   3 +-
 trace.c                                  |   3 +-
 trace2.c                                 |   1 +
 transport-helper.c                       |   3 +-
 transport.c                              |   3 +
 tree-walk.c                              |   2 +
 tree.c                                   |   1 +
 unpack-trees.c                           |   2 +
 unpack-trees.h                           |   1 +
 upload-pack.c                            |   5 +-
 walker.c                                 |   2 +-
 wrapper.c                                |   1 +
 wt-status.c                              |   4 +
 212 files changed, 743 insertions(+), 404 deletions(-)
 create mode 100644 editor.h
 rename zlib.c => git-zlib.c (99%)
 create mode 100644 git-zlib.h
 create mode 100644 object-file.h
 create mode 100644 object-name.h
 create mode 100644 pager.h


base-commit: dc1c48a4a2bce29542f330137106c01daa728f9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1509%2Fnewren%2Fheader-cleanup-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1509/newren/header-cleanup-3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1509
-- 
gitgitgadget
