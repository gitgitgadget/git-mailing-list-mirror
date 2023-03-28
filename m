Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B4FC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjC1Uw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC1Uwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:52:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6551721
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:52:54 -0700 (PDT)
Received: (qmail 2205 invoked by uid 109); 28 Mar 2023 20:52:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:52:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2198 invoked by uid 111); 28 Mar 2023 20:52:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:52:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:52:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] unused argc/argv/prefix parameters
Message-ID: <20230328205253.GA1753925@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

More from my -Wunused-parameter silencing. The first one actually fixes
a bug. The second is a cleanup, and the rest are just UNUSED annotations
(but grouped into similar cases).

  [1/7]: fast-import: fix file access when run from subdir
  [2/7]: builtins: always pass prefix to parse_options()
  [3/7]: builtins: annotate always-empty prefix parameters
  [4/7]: builtins: mark unused prefix parameters
  [5/7]: mark "argv" as unused when we check argc
  [6/7]: t/helper: mark unused argv/argc arguments
  [7/7]: parse-options: drop parse_opt_unknown_cb()

 builtin.h                            | 10 ++++++++++
 builtin/check-ref-format.c           |  2 ++
 builtin/credential.c                 |  2 +-
 builtin/diff.c                       |  6 +++---
 builtin/fast-import.c                | 10 ++++++++--
 builtin/fetch-pack.c                 |  2 +-
 builtin/fsmonitor--daemon.c          |  2 +-
 builtin/get-tar-commit-id.c          |  4 +++-
 builtin/mailsplit.c                  |  2 ++
 builtin/merge-index.c                |  2 +-
 builtin/merge-ours.c                 |  2 +-
 builtin/merge-recursive.c            |  2 +-
 builtin/mktag.c                      |  2 +-
 builtin/pack-redundant.c             |  2 +-
 builtin/remote-ext.c                 |  2 ++
 builtin/remote-fd.c                  |  2 ++
 builtin/revert.c                     |  9 +++++----
 builtin/stash.c                      |  2 +-
 builtin/submodule--helper.c          |  2 +-
 builtin/unpack-file.c                |  2 +-
 builtin/unpack-objects.c             |  2 +-
 builtin/upload-archive.c             |  2 ++
 builtin/var.c                        |  2 +-
 parse-options-cb.c                   | 15 --------------
 parse-options.h                      |  3 ---
 scalar.c                             |  2 +-
 t/helper/test-ctype.c                |  2 +-
 t/helper/test-date.c                 |  2 +-
 t/helper/test-drop-caches.c          |  2 +-
 t/helper/test-dump-cache-tree.c      |  2 +-
 t/helper/test-dump-fsmonitor.c       |  2 +-
 t/helper/test-dump-split-index.c     |  2 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-example-decorate.c     |  2 +-
 t/helper/test-fsmonitor-client.c     |  2 +-
 t/helper/test-hexdump.c              |  2 +-
 t/helper/test-index-version.c        |  2 +-
 t/helper/test-match-trees.c          |  2 +-
 t/helper/test-oid-array.c            |  2 +-
 t/helper/test-oidmap.c               |  2 +-
 t/helper/test-oidtree.c              |  4 ++--
 t/helper/test-online-cpus.c          |  2 +-
 t/helper/test-parse-options.c        |  4 ++--
 t/helper/test-prio-queue.c           |  2 +-
 t/helper/test-read-graph.c           |  2 +-
 t/helper/test-ref-store.c            |  5 +++--
 t/helper/test-scrap-cache-tree.c     |  2 +-
 t/helper/test-sigchain.c             |  2 +-
 t/helper/test-strcmp-offset.c        |  2 +-
 t/helper/test-submodule-config.c     |  2 +-
 t/helper/test-submodule.c            |  2 +-
 t/helper/test-trace2.c               |  6 +++---
 t/helper/test-xml-encode.c           |  2 +-
 t/t9304-fast-import-marks.sh         | 29 ++++++++++++++++++++++++++++
 54 files changed, 115 insertions(+), 74 deletions(-)

