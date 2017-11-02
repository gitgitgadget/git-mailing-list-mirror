Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE2B20281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934502AbdKBUbm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:31:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:41921 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934415AbdKBUbj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 43C58845AB;
        Thu,  2 Nov 2017 16:31:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E8956845AA;
        Thu,  2 Nov 2017 16:31:37 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 00/14] WIP Partial clone part 3: clone, fetch, fetch-pack, upload-pack, and tests
Date:   Thu,  2 Nov 2017 20:31:15 +0000
Message-Id: <20171102203129.59417-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is part 3 of 3 for partial clone.
It assumes that part 1 [1] and part 2 [2] are in place.

Part 3 is concerned with the commands: clone, fetch, upload-pack, fetch-pack,
remote-curl, index-pack, and the pack-protocol.

Jonathan and I independently started on this task.  This is a first
pass at merging those efforts.  So there are several places that need
refactoring and cleanup.  In particular, the test cases should be
squashed and new tests added.

[1] https://public-inbox.org/git/20171102124445.fbffd43521cd35f6a71e1851@google.com/T/
[2] TODO


Jeff Hostetler (5):
  upload-pack: add object filtering for partial clone
  clone, fetch-pack, index-pack, transport: partial clone
  fetch: add object filtering for partial fetch
  remote-curl: add object filtering for partial clone
  index-pack: silently assume missing objects are promisor

Jonathan Tan (9):
  fetch: refactor calculation of remote list
  pack-objects: test support for blob filtering
  fetch-pack: test support excluding large blobs
  fetch: add from_promisor and exclude-promisor-objects parameters
  t5500: add fetch-pack tests for partial clone
  t5601: test for partial clone
  t5500: more tests for partial clone and fetch
  unpack-trees: batch fetching of missing blobs
  fetch-pack: restore save_commit_buffer after use

 Documentation/config.txt                          |   4 +
 Documentation/gitremote-helpers.txt               |   4 +
 Documentation/technical/pack-protocol.txt         |   8 ++
 Documentation/technical/protocol-capabilities.txt |   8 ++
 builtin/clone.c                                   |  24 ++++-
 builtin/fetch-pack.c                              |   4 +
 builtin/fetch.c                                   |  83 ++++++++++++++--
 builtin/index-pack.c                              |  14 +++
 connected.c                                       |   3 +
 fetch-object.c                                    |  27 ++++-
 fetch-object.h                                    |   5 +
 fetch-pack.c                                      |  17 ++++
 fetch-pack.h                                      |   2 +
 remote-curl.c                                     |  10 +-
 t/t5300-pack-object.sh                            |  45 +++++++++
 t/t5500-fetch-pack.sh                             | 115 ++++++++++++++++++++++
 t/t5601-clone.sh                                  | 101 +++++++++++++++++++
 t/test-lib-functions.sh                           |  12 +++
 transport-helper.c                                |   5 +
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 unpack-trees.c                                    |  22 +++++
 upload-pack.c                                     |  20 +++-
 23 files changed, 526 insertions(+), 16 deletions(-)

-- 
2.9.3

