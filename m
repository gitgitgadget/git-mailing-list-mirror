Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A781F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdHPURg (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:17:36 -0400
Received: from vie01a-dmta-pe05-1.mx.upcmail.net ([84.116.36.11]:48960 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752105AbdHPUQt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:49 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kB-0008SX-Q8
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:47 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGe1v00K5BuuEg01wGfJa; Wed, 16 Aug 2017 22:16:39 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id C211945D4512; Wed, 16 Aug 2017 22:16:37 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 00/19] use size_t
Date:   Wed, 16 Aug 2017 22:16:12 +0200
Message-Id: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

This patchset is for next [24db08a6e8fed761d3bace7f2d5997806e20b9f7].
Its a complete collection of all patches. Some errors were fixed and
it sticks with off_t for length in (pack) files. Object sizes are handled
as size_t.

Martin Koegler (19):
  delta: fix enconding size larger than an "uint" can hold
  Convert size datatype to size_t
  Convert zlib.c to size_t
  delta: Fix offset overflows
  Convert sha1_file.c to size_t
  Use size_t for sha1
  Convert parse_X_buffer to size_t
  Convert fsck.c & commit.c to size_t
  Convert cache functions to size_t
  Add overflow check to get_delta_hdr_size
  Use size_t for config parsing
  Convert pack-objects to size_t
  Convert index-pack to size_t
  Convert unpack-objects to size_t
  Convert archive functions to size_t
  Convert various things to size_t
  Convert ref-filter to size_t
  Convert tree-walk to size_t
  Convert xdiff-interface to size_t

 Documentation/technical/api-parse-options.txt |   2 +-
 apply.c                                       |   6 +-
 archive-tar.c                                 |  20 ++---
 archive-zip.c                                 |  24 ++---
 archive.c                                     |   2 +-
 archive.h                                     |   2 +-
 bisect.c                                      |   2 +-
 blame.c                                       |   6 +-
 blame.h                                       |   2 +-
 blob.c                                        |   2 +-
 blob.h                                        |   2 +-
 block-sha1/sha1.c                             |   2 +-
 block-sha1/sha1.h                             |   2 +-
 builtin/cat-file.c                            |  14 +--
 builtin/difftool.c                            |   2 +-
 builtin/fast-export.c                         |   8 +-
 builtin/fmt-merge-msg.c                       |   4 +-
 builtin/fsck.c                                |   4 +-
 builtin/grep.c                                |   8 +-
 builtin/index-pack.c                          |  40 ++++-----
 builtin/log.c                                 |   4 +-
 builtin/ls-tree.c                             |   4 +-
 builtin/merge-tree.c                          |   6 +-
 builtin/mktag.c                               |   4 +-
 builtin/notes.c                               |   6 +-
 builtin/pack-objects.c                        |  84 +++++++++---------
 builtin/reflog.c                              |   2 +-
 builtin/replace.c                             |   2 +-
 builtin/tag.c                                 |   4 +-
 builtin/unpack-file.c                         |   2 +-
 builtin/unpack-objects.c                      |  34 +++----
 builtin/verify-commit.c                       |   2 +-
 bundle.c                                      |   2 +-
 cache-tree.c                                  |   6 +-
 cache-tree.h                                  |   2 +-
 cache.h                                       |  54 ++++++------
 combine-diff.c                                |  11 +--
 commit.c                                      |  22 ++---
 commit.h                                      |  10 +--
 config.c                                      |  29 ++++--
 config.h                                      |   2 +
 convert.c                                     |  18 ++--
 delta.h                                       |  31 ++++---
 diff-delta.c                                  |  42 +++++----
 diff.c                                        |  46 +++++-----
 diff.h                                        |   2 +-
 diffcore-pickaxe.c                            |   4 +-
 diffcore.h                                    |   2 +-
 dir.c                                         |   6 +-
 dir.h                                         |   2 +-
 entry.c                                       |   4 +-
 environment.c                                 |   4 +-
 fast-import.c                                 |  24 ++---
 fsck.c                                        |  16 ++--
 fsck.h                                        |   2 +-
 grep.h                                        |   2 +-
 http-push.c                                   |   5 +-
 mailmap.c                                     |   2 +-
 match-trees.c                                 |   4 +-
 merge-blobs.c                                 |   6 +-
 merge-blobs.h                                 |   2 +-
 merge-recursive.c                             |   4 +-
 notes-cache.c                                 |   2 +-
 notes-merge.c                                 |   2 +-
 notes.c                                       |   6 +-
 object.c                                      |   4 +-
 object.h                                      |   2 +-
 pack-check.c                                  |   8 +-
 pack-objects.h                                |   6 +-
 pack.h                                        |   2 +-
 parse-options.c                               |   6 +-
 patch-delta.c                                 |  11 +--
 ppc/sha1.c                                    |   2 +-
 ppc/sha1.h                                    |   2 +-
 read-cache.c                                  |  22 ++---
 ref-filter.c                                  |  38 ++++----
 remote-testsvn.c                              |   4 +-
 rerere.c                                      |   2 +-
 sha1_file.c                                   | 122 +++++++++++++-------------
 sha1dc_git.c                                  |   2 +-
 sha1dc_git.h                                  |   2 +-
 streaming.c                                   |  10 +--
 streaming.h                                   |   2 +-
 submodule-config.c                            |   2 +-
 t/helper/test-delta.c                         |   2 +-
 tag.c                                         |   8 +-
 tag.h                                         |   2 +-
 tree-walk.c                                   |  25 +++---
 tree-walk.h                                   |   4 +-
 tree.c                                        |   4 +-
 tree.h                                        |   4 +-
 wrapper.c                                     |   8 +-
 xdiff-interface.c                             |  10 +--
 xdiff-interface.h                             |   6 +-
 zlib.c                                        |   8 +-
 95 files changed, 525 insertions(+), 489 deletions(-)

-- 
2.1.4

