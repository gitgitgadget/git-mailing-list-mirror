Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B3620A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdLERDL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:22967 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbdLERDK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0BC9F844E2;
        Tue,  5 Dec 2017 12:03:10 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 65B07844DE;
        Tue,  5 Dec 2017 12:03:09 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 00/14] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
Date:   Tue,  5 Dec 2017 17:02:40 +0000
Message-Id: <20171205170254.65293-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is V6 of part 3 of partial clone.  It assumes that V6
of parts 1 and 2 are already present.

This version is refactors and reorders commits to better combine
new functionality and tests.  It contains 3 fixup commits that
should be squashed after some discussion.

Jeff Hostetler (9):
  upload-pack: add object filtering for partial clone
  fetch-pack, index-pack, transport: partial clone
  fetch-pack: add --no-filter
  fetch: support filters
  fixup: fetch: update error messages from --blob-max-bytes to --filter
  fixup: fetch: update --blob-max-bytes to --fitler
  fixup: connected: conditionally pass --exclude-promisor-objects to
    rev-list
  partial-clone: define partial clone settings in config
  t5616: end-to-end tests for partial clone

Jonathan Tan (5):
  fetch-pack: test support excluding large blobs
  fetch: refactor calculation of remote list
  clone: partial clone
  unpack-trees: batch fetching of missing blobs
  fetch-pack: restore save_commit_buffer after use

 Documentation/config.txt                          |   4 +
 Documentation/technical/pack-protocol.txt         |   8 ++
 Documentation/technical/protocol-capabilities.txt |   8 ++
 builtin/clone.c                                   |  22 +++-
 builtin/fetch-pack.c                              |   8 ++
 builtin/fetch.c                                   |  33 ++++--
 cache.h                                           |   1 +
 config.c                                          |   5 +
 connected.c                                       |   2 +
 environment.c                                     |   1 +
 fetch-object.c                                    |  26 ++++-
 fetch-object.h                                    |   5 +
 fetch-pack.c                                      |  17 +++
 fetch-pack.h                                      |   2 +
 list-objects-filter-options.c                     |  90 +++++++++++++---
 list-objects-filter-options.h                     |   6 ++
 remote-curl.c                                     |   6 ++
 t/t5500-fetch-pack.sh                             |  63 +++++++++++
 t/t5601-clone.sh                                  | 101 +++++++++++++++++
 t/t5616-partial-clone.sh                          | 125 ++++++++++++++++++++++
 transport-helper.c                                |   5 +
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 unpack-trees.c                                    |  22 ++++
 upload-pack.c                                     |  31 +++++-
 25 files changed, 572 insertions(+), 28 deletions(-)
 create mode 100755 t/t5616-partial-clone.sh

-- 
2.9.3

