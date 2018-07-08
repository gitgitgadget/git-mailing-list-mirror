Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889E51F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGHXgu (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:36:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54278 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932799AbeGHXgt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C8A56047B;
        Sun,  8 Jul 2018 23:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093006;
        bh=DrwVTP3DjMDEp/4sbBDaxQwPiwtIr7WSlO+ghBPlU/M=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rdSDniRxcR+I1InEww4P1qsWZ8/8//5af4gCiL+mACYrNPfZTbul/Ws0b7NzdnjYu
         G85irXAV6Pa2TDb74MBf4CZwmuzqn35D14RvrWH9I8f/xjICSdW9w5f3xjmQ9Nfeqh
         +rkUZUv82dLQcpvItulXwF/+KCg8UI+/03BTLHAFmbN3k0srlABbcCZ5gaAjjJ5VAs
         iFXR1+JZZ485CdvvIes9rgBA8rhgxIuKZo4/idxDaDyUxpz3HOR2ZRB1N02EcJapOI
         wO5czeyc/jJidtvXCT/OvZ4vlG5chrqIlWU/k3ksqHZRiTQ2U6batIBNRVcjTslDKa
         CHDJhiHKbe39PHruHjJOijg2c8jVk1gUMrGIjHnLNG9SA2fvA1Wa5R4QcOC/qgYsRd
         nV+FM5PQHc9ox4VGLTQ6NVqDv42c+7+hj8Ma5y2CoHhb4Ak76NPIBEqrBA/6Kiu8hy
         xjxOnqxpmPn+U55TU24cwy+h3LjLzo19rfa2eXh92ywrzPJ61Z2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/17] object_id part 14
Date:   Sun,  8 Jul 2018 23:36:21 +0000
Message-Id: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fourteenth series of patches to switch to using struct
object_id and the_hash_algo.  This series converts several core pieces
to use struct object_id, including the oid* and hex functions.

All of these patches have been tested with both SHA-1 and a 256-bit
hash.

brian m. carlson (17):
  cache: update object ID functions for the_hash_algo
  tree-walk: replace hard-coded constants with the_hash_algo
  hex: switch to using the_hash_algo
  commit: express tree entry constants in terms of the_hash_algo
  strbuf: allocate space with GIT_MAX_HEXSZ
  sha1-name: use the_hash_algo when parsing object names
  commit: increase commit message buffer size
  refs/files-backend: use the_hash_algo for writing refs
  builtin/update-index: convert to using the_hash_algo
  builtin/update-index: simplify parsing of cacheinfo
  builtin/fmt-merge-msg: make hash independent
  builtin/merge: switch to use the_hash_algo
  builtin/merge-recursive: make hash independent
  diff: switch GIT_SHA1_HEXSZ to use the_hash_algo
  log-tree: switch GIT_SHA1_HEXSZ to the_hash_algo->hexsz
  sha1-file: convert constants to uses of the_hash_algo
  pretty: switch hard-coded constants to the_hash_algo

 builtin/fmt-merge-msg.c   | 19 ++++++++++---------
 builtin/merge-recursive.c |  4 ++--
 builtin/merge.c           | 11 ++++++-----
 builtin/update-index.c    | 14 ++++++++------
 cache.h                   |  6 +++---
 commit.c                  |  4 ++--
 diff.c                    |  6 +++---
 hex.c                     |  6 +++---
 log-tree.c                |  2 +-
 pretty.c                  |  4 ++--
 refs/files-backend.c      |  6 +++---
 sha1-file.c               |  8 ++++----
 sha1-name.c               | 12 +++++++-----
 strbuf.c                  |  2 +-
 tree-walk.c               |  3 ++-
 15 files changed, 57 insertions(+), 50 deletions(-)

