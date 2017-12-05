Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EED20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbdLEQ7M (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:18351 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbdLEQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4DDCA844E4;
        Tue,  5 Dec 2017 11:59:11 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B8273844DE;
        Tue,  5 Dec 2017 11:59:10 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 00/12] Partial clone part 2: fsck and promisors
Date:   Tue,  5 Dec 2017 16:58:42 +0000
Message-Id: <20171205165854.64979-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is V6 of part 2 of partial clone.  This assumes V6 of part 1
is already present.  This version fixes a problem in fetch-pack
observed in V5.  It also contains 2 "fixup" commits that are
WIP responses to comments on V5.

Part 2 is concerned with fsck, gc, initial support for dynamic
object fetching, and tracking promisor objects.  Jonathan Tan
originally developed this code.  I have moved it on top of
part 1 and updated it slightly.


Jeff Hostetler (2):
  fixup: sha1_file: convert gotos to break/continue
  fixup: sha1_file: add TODO

Jonathan Tan (10):
  extension.partialclone: introduce partial clone extension
  fsck: introduce partialclone extension
  fsck: support refs pointing to promisor objects
  fsck: support referenced promisor objects
  fsck: support promisor objects as CLI argument
  index-pack: refactor writing of .keep files
  introduce fetch-object: fetch one promisor object
  sha1_file: support lazily fetching missing objects
  rev-list: support termination at promisor objects
  gc: do not repack promisor packfiles

 Documentation/git-pack-objects.txt             |  11 +
 Documentation/gitremote-helpers.txt            |   7 +
 Documentation/rev-list-options.txt             |  11 +
 Documentation/technical/repository-version.txt |  12 +
 Makefile                                       |   1 +
 builtin/cat-file.c                             |   2 +
 builtin/fetch-pack.c                           |  10 +
 builtin/fsck.c                                 |  26 +-
 builtin/gc.c                                   |   3 +
 builtin/index-pack.c                           | 113 ++++----
 builtin/pack-objects.c                         |  37 ++-
 builtin/prune.c                                |   7 +
 builtin/repack.c                               |   8 +-
 builtin/rev-list.c                             |  71 ++++-
 cache.h                                        |  13 +-
 environment.c                                  |   1 +
 fetch-object.c                                 |  27 ++
 fetch-object.h                                 |   6 +
 fetch-pack.c                                   |  48 ++--
 fetch-pack.h                                   |   8 +
 list-objects.c                                 |  29 ++-
 object.c                                       |   2 +-
 packfile.c                                     |  77 +++++-
 packfile.h                                     |  13 +
 remote-curl.c                                  |  14 +-
 revision.c                                     |  33 ++-
 revision.h                                     |   5 +-
 setup.c                                        |   7 +-
 sha1_file.c                                    |  32 ++-
 t/t0410-partial-clone.sh                       | 343 +++++++++++++++++++++++++
 transport.c                                    |   8 +
 transport.h                                    |  11 +
 32 files changed, 899 insertions(+), 97 deletions(-)
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h
 create mode 100755 t/t0410-partial-clone.sh

-- 
2.9.3

