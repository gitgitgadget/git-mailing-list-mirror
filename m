Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DB420C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbdLHP7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:59:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:26192 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754211AbdLHP7H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:59:07 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9078A844F1;
        Fri,  8 Dec 2017 10:59:06 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1868F844DE;
        Fri,  8 Dec 2017 10:59:06 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
Date:   Fri,  8 Dec 2017 15:58:35 +0000
Message-Id: <20171208155851.855-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is V7 of part 3 of partial clone.  It builds upon V7 of part 2
(which builds upon V6 of part 1).

This version adds additional tests, fixes test errors on the MAC version,
and squashes some fixup commits.

It also restores functionality accidentally dropped from the V6 series
for "git fetch" to automatically inherit the partial-clone filter-spec
when appropriate.  This version extends the --no-filter argument to
override this inheritance.

Jeff Hostetler (8):
  upload-pack: add object filtering for partial clone
  fetch-pack, index-pack, transport: partial clone
  fetch-pack: add --no-filter
  fetch: support filters
  partial-clone: define partial clone settings in config
  t5616: end-to-end tests for partial clone
  fetch: inherit filter-spec from partial clone
  t5616: test bulk prefetch after partial fetch

Jonathan Tan (8):
  sha1_file: support lazily fetching missing objects
  rev-list: support termination at promisor objects
  gc: do not repack promisor packfiles
  fetch-pack: test support excluding large blobs
  fetch: refactor calculation of remote list
  clone: partial clone
  unpack-trees: batch fetching of missing blobs
  fetch-pack: restore save_commit_buffer after use

 Documentation/config.txt                          |   4 +
 Documentation/git-pack-objects.txt                |  11 ++
 Documentation/rev-list-options.txt                |  11 ++
 Documentation/technical/pack-protocol.txt         |   8 +
 Documentation/technical/protocol-capabilities.txt |   8 +
 builtin/cat-file.c                                |   2 +
 builtin/clone.c                                   |  22 ++-
 builtin/fetch-pack.c                              |  10 ++
 builtin/fetch.c                                   |  83 ++++++++-
 builtin/fsck.c                                    |   3 +
 builtin/gc.c                                      |   3 +
 builtin/index-pack.c                              |   6 +
 builtin/pack-objects.c                            |  37 +++-
 builtin/prune.c                                   |   7 +
 builtin/repack.c                                  |   8 +-
 builtin/rev-list.c                                |  73 +++++++-
 cache.h                                           |   9 +
 config.c                                          |   5 +
 connected.c                                       |   2 +
 environment.c                                     |   1 +
 fetch-object.c                                    |  29 ++-
 fetch-object.h                                    |   5 +
 fetch-pack.c                                      |  17 ++
 fetch-pack.h                                      |   2 +
 list-objects-filter-options.c                     |  92 ++++++++--
 list-objects-filter-options.h                     |  18 ++
 list-objects.c                                    |  29 ++-
 object.c                                          |   2 +-
 remote-curl.c                                     |   6 +
 revision.c                                        |  33 +++-
 revision.h                                        |   5 +-
 sha1_file.c                                       |  32 +++-
 t/t0410-partial-clone.sh                          | 206 +++++++++++++++++++++-
 t/t5500-fetch-pack.sh                             |  63 +++++++
 t/t5601-clone.sh                                  | 101 +++++++++++
 t/t5616-partial-clone.sh                          | 146 +++++++++++++++
 transport-helper.c                                |   5 +
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 unpack-trees.c                                    |  22 +++
 upload-pack.c                                     |  31 +++-
 41 files changed, 1110 insertions(+), 56 deletions(-)
 create mode 100755 t/t5616-partial-clone.sh

-- 
2.9.3

