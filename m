Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E641FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 02:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdBNCc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 21:32:57 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50612 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751175AbdBNCcN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Feb 2017 21:32:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0D988280AD;
        Tue, 14 Feb 2017 02:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487039514;
        bh=zg2nhS4eLFr6VcLrU4u/z/hT+3aPYX7QgWvvKuqjyis=;
        h=From:To:Cc:Subject:Date:From;
        b=l1nDgWbKVWeACC8ePp2rb6xenMkRqlGD7ygyyTjNp/5IFc0wKO0TfAWy75McKOB9T
         Iit+X2PJbgTDXPop6phQ07PY70UK7rKAAugi2XUCXSwk/eolsap/MElbdjoSddP4b5
         BtyovsEY9ZuqwbEVC3z/vy/F/htNyAJnMVYYyUKzVwH4q5zy7MimxSm3rBCQ8vn0tK
         D3nKGP1EgW6+fhKIzZmFpNJ9w28EdeIgATm1frEgVDwWmei8HY4kEv/+gKXjY8N5Oz
         okMhngV5qLg1IDX9siZRea94wlmExMs0tcax4L1fWE7tD/bUAId+eQ5vyO5uTWO8+b
         dLahzppSoy02I2o5G8WVYxTajkN9HmJ97GyHDrC+ERzoftthbDq0C62wlzDirrwlT2
         tU0CVC1yuIqxAubI5+rdM/OP2OJ9offoDL0aCWhhk7+/61nMhnrNhp++9qngCij89x
         T4UgAkzRoj/i9SqbyUstr+OkdLRi+ykjg9wV+RiltxEKDcCt7qR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/19] object_id part 6
Date:   Tue, 14 Feb 2017 02:31:22 +0000
Message-Id: <20170214023141.842922-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another series in the continuing conversion to struct object_id.

This series converts more of the builtin directory and some of the refs
code to use struct object_id. Additionally, it implements an
nth_packed_object_oid function which provides a struct object_id version
of the nth_packed_object function, and a parse_oid_hex function that
makes parsing easier.

The patch to use parse_oid_hex in the refs code has been split out into
its own patch, just because I'm wary of that code and potentially
breaking things, and I want it to be easy to revert in case things go
wrong.  I have no reason to believe it is anything other than fully
functional, however.

Changes from v1:
* Implement parse_oid_hex and use it.
* Make nth_packed_object_oid take a variable into which to store the
  object ID.  This avoids concerns about unsafe casts.
* Rebase on master.

brian m. carlson (19):
  builtin/commit: convert to struct object_id
  builtin/diff-tree: convert to struct object_id
  builtin/describe: convert to struct object_id
  builtin/fast-export: convert to struct object_id
  builtin/fmt-merge-message: convert to struct object_id
  builtin/grep: convert to struct object_id
  builtin/branch: convert to struct object_id
  builtin/clone: convert to struct object_id
  builtin/merge: convert to struct object_id
  Convert remaining callers of resolve_refdup to object_id
  builtin/replace: convert to struct object_id
  reflog-walk: convert struct reflog_info to struct object_id
  refs: convert each_reflog_ent_fn to struct object_id
  hex: introduce parse_oid_hex
  refs: simplify parsing of reflog entries
  sha1_file: introduce an nth_packed_object_oid function
  Convert object iteration callbacks to struct object_id
  builtin/merge-base: convert to struct object_id
  wt-status: convert to struct object_id

 builtin/branch.c        |  26 +++++-----
 builtin/cat-file.c      |   8 +--
 builtin/clone.c         |  10 ++--
 builtin/commit.c        |  46 ++++++++---------
 builtin/count-objects.c |   4 +-
 builtin/describe.c      |  50 +++++++++---------
 builtin/diff-tree.c     |  38 +++++++-------
 builtin/fast-export.c   |  58 ++++++++++-----------
 builtin/fmt-merge-msg.c |  70 ++++++++++++-------------
 builtin/fsck.c          |  40 +++++++--------
 builtin/grep.c          |  24 ++++-----
 builtin/merge-base.c    |  30 +++++------
 builtin/merge.c         | 134 ++++++++++++++++++++++++------------------------
 builtin/notes.c         |  18 +++----
 builtin/pack-objects.c  |   6 +--
 builtin/prune-packed.c  |   4 +-
 builtin/prune.c         |   8 +--
 builtin/receive-pack.c  |   4 +-
 builtin/reflog.c        |   2 +-
 builtin/replace.c       | 112 ++++++++++++++++++++--------------------
 cache.h                 |  18 ++++++-
 hex.c                   |   8 +++
 reachable.c             |  30 +++++------
 ref-filter.c            |   4 +-
 reflog-walk.c           |  26 +++++-----
 refs.c                  |  24 ++++-----
 refs.h                  |   2 +-
 refs/files-backend.c    |  30 ++++++-----
 revision.c              |  12 ++---
 sha1_file.c             |  27 +++++++---
 sha1_name.c             |   2 +-
 transport.c             |   4 +-
 wt-status.c             |  52 +++++++++----------
 33 files changed, 483 insertions(+), 448 deletions(-)

-- 
2.11.0

