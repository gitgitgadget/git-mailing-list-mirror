Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2941F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756160AbcH1X2C (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:02 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40954 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbcH1X2B (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 98328280A6;
        Sun, 28 Aug 2016 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426880;
        bh=QbAc0Za0r1nDQPKE+HpjyNFDM70cEeaBPke2qL0wTbY=;
        h=From:To:Cc:Subject:Date:From;
        b=rLF+gpp479mAW7eESOjFk7IPGV2/TIAb2obc1MPm6AqZXbrNNB0fdASvMKVUbgJVL
         ai4f+OTNxhyV90rEKugzujj5V6mc2lGXmT1sCCoJ8++y0Yyx9rMJfRHTQ0UBFFTPg3
         jyMqkwOJsJEGaieSQEMO8cfZlTjZJjFjabx3cV+diqrihwlFQmr0e+jmlDniEF5ctr
         9pAcDNgd/Du6aKmu2RkRfner1l6hM3BPf+ocXtAvlT9QnboEx6DQie1/WpaWOgDl3n
         C1aArE/dDJYbUzgiOYohj7IvBE+C8Yt/4FxEZsAycWUVUMEwqPBIhKIS7EOoFaWyMM
         uW7SLc1mK8f6pbQzEfqTxLnU/JoWT/KFMLsfsr5fbtm2kh0+d6vbWPTDsTzP5bE9no
         VUrpV+tvvfTOXEn247qnkncKVUAXfHt2Ji4gGrPWOYlp/32d85lu1Gbvh1f3r9Scsj
         +baYqTC/6XsKUL0dgc1ytf2PJMazr7yt7I8YtTtoxC8m3qk3eUv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 00/20] object_id part 5
Date:   Sun, 28 Aug 2016 23:27:37 +0000
Message-Id: <20160828232757.373278-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifth in a series of series to convert from unsigned char [20] to
struct object_id.

This series converts many of the files in the builtin directory to use struct
object_id.  This gets us almost to the point where we can convert get_tree_entry
to use struct object_id, but not quite.  That function is used indirectly by
get_sha1, meaning that get_oid would have to completely replace it in order for
get_tree_entry to be converted.

However, this series tackles one of two major sources of object ID values: the
command line (the other, of course, being the refs code).  Converting several of
the builtin commands to use struct object_id as much as possible makes it easier
to convert other functions down the line.

brian m. carlson (20):
  cache: convert struct cache_entry to use struct object_id
  builtin/apply: convert static functions to struct object_id
  builtin/blame: convert struct origin to use struct object_id
  builtin/log: convert some static functions to use struct object_id
  builtin/cat-file: convert struct expand_data to use struct object_id
  builtin/cat-file: convert some static functions to struct object_id
  builtin: convert textconv_object to use struct object_id
  streaming: make stream_blob_to_fd take struct object_id
  builtin/checkout: convert some static functions to struct object_id
  notes-merge: convert struct notes_merge_pair to struct object_id
  Convert read_mmblob to take struct object_id.
  builtin/blame: convert file to use struct object_id
  builtin/rm: convert to use struct object_id
  notes: convert init_notes to use struct object_id
  builtin/update-index: convert file to struct object_id
  sha1_name: convert get_sha1_mb to struct object_id
  refs: add an update_ref_oid function.
  builtin/am: convert to struct object_id
  builtin/commit-tree: convert to struct object_id
  builtin/reset: convert to use struct object_id

 builtin.h                        |   2 +-
 builtin/am.c                     | 138 +++++++++++++++++++--------------------
 builtin/apply.c                  |  94 +++++++++++++-------------
 builtin/blame.c                  |  76 ++++++++++-----------
 builtin/cat-file.c               |  70 ++++++++++----------
 builtin/checkout.c               |  70 ++++++++++----------
 builtin/commit-tree.c            |  20 +++---
 builtin/fsck.c                   |   4 +-
 builtin/grep.c                   |   3 +-
 builtin/log.c                    |  44 ++++++-------
 builtin/ls-files.c               |   2 +-
 builtin/merge-index.c            |   2 +-
 builtin/read-tree.c              |   2 +-
 builtin/reset.c                  |  52 +++++++--------
 builtin/rm.c                     |  18 ++---
 builtin/submodule--helper.c      |   5 +-
 builtin/update-index.c           |  67 +++++++++----------
 cache-tree.c                     |   4 +-
 cache.h                          |   4 +-
 diff-lib.c                       |  31 +++++----
 diff.c                           |   2 +-
 dir.c                            |   7 +-
 entry.c                          |   9 +--
 merge-recursive.c                |   8 +--
 notes-merge.c                    | 122 +++++++++++++++++-----------------
 notes.c                          |  12 ++--
 read-cache.c                     |  24 +++----
 refs.c                           |   8 +++
 refs.h                           |   3 +
 rerere.c                         |   3 +-
 resolve-undo.c                   |   2 +-
 revision.c                       |   2 +-
 sha1_name.c                      |  20 +++---
 streaming.c                      |   4 +-
 streaming.h                      |   2 +-
 t/helper/test-dump-split-index.c |   2 +-
 tree.c                           |   2 +-
 unpack-trees.c                   |   8 +--
 xdiff-interface.c                |   8 +--
 xdiff-interface.h                |   3 +-
 40 files changed, 493 insertions(+), 466 deletions(-)
