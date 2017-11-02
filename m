Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0FEC20281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbdKBUVJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:22638 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934337AbdKBUVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CFEF3845A5;
        Thu,  2 Nov 2017 16:21:07 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 361C0844EC;
        Thu,  2 Nov 2017 16:21:07 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/9] WIP Partial clone part 2: fsck and promisors
Date:   Thu,  2 Nov 2017 20:20:43 +0000
Message-Id: <20171102202052.58762-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is part 2 of a proposed 3 part sequence for partial clone.
Part 2 assumes part 1 [1] is in place.

Part 2 is concerned with fsck, gc, initial support for dynamic
object fetching, and tracking promisor objects.  Jonathan Tan
originally developed this code.  I have moved it on top of [1].

[1] https://public-inbox.org/git/20171102124445.fbffd43521cd35f6a71e1851@google.com/T/
[2] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/


Jeff Hostetler (1):
  extension.partialclone: introduce partial clone extension

Jonathan Tan (8):
  fsck: introduce partialclone extension
  fsck: support refs pointing to promisor objects
  fsck: support referenced promisor objects
  fsck: support promisor objects as CLI argument
  index-pack: refactor writing of .keep files
  introduce fetch-object: fetch one promisor object
  sha1_file: support lazily fetching missing objects
  gc: do not repack promisor packfiles

 Documentation/git-pack-objects.txt             |   4 +
 Documentation/gitremote-helpers.txt            |   2 +
 Documentation/technical/repository-version.txt |  22 ++
 Makefile                                       |   2 +
 builtin/cat-file.c                             |   3 +
 builtin/fetch-pack.c                           |  10 +
 builtin/fsck.c                                 |  26 +-
 builtin/gc.c                                   |   4 +
 builtin/index-pack.c                           | 113 ++++----
 builtin/pack-objects.c                         |  14 +
 builtin/prune.c                                |   7 +
 builtin/repack.c                               |  12 +-
 builtin/rev-list.c                             |  35 ++-
 cache.h                                        |  15 +-
 config.h                                       |   3 +
 environment.c                                  |   2 +
 fetch-object.c                                 |  26 ++
 fetch-object.h                                 |   6 +
 fetch-pack.c                                   |   8 +-
 fetch-pack.h                                   |   2 +
 list-objects.c                                 |   8 +-
 object.c                                       |   2 +-
 packfile.c                                     |  78 +++++-
 packfile.h                                     |  13 +
 partial-clone-utils.c                          |  78 ++++++
 partial-clone-utils.h                          |  34 +++
 remote-curl.c                                  |  17 +-
 revision.c                                     |  32 ++-
 revision.h                                     |   5 +-
 setup.c                                        |  12 +
 sha1_file.c                                    |  39 ++-
 t/t0410-partial-clone.sh                       | 343 +++++++++++++++++++++++++
 transport.c                                    |   8 +
 transport.h                                    |   8 +
 34 files changed, 917 insertions(+), 76 deletions(-)
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h
 create mode 100644 partial-clone-utils.c
 create mode 100644 partial-clone-utils.h
 create mode 100755 t/t0410-partial-clone.sh

-- 
2.9.3

