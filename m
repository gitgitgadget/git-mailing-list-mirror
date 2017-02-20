Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C03201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdBTAKq (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:10:46 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36298 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751470AbdBTAKo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Feb 2017 19:10:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 93891280AD;
        Mon, 20 Feb 2017 00:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487549441;
        bh=bPOv5Dn8gN9EX6iX+r/boxUIL7zTgcm+KAXojpuMHS8=;
        h=From:To:Cc:Subject:Date:From;
        b=qkkFcxl8rm7CTA+d/6qAfSN0E1dzOB9InLJpJD3RmSTRZ+nu8qqwU+mGuEYuL8Msz
         5VuUrW9AR4vasiJWw9a+M2nLYwbYX2Abu6IUzp0XLOHSYC1MPOOF1lXeGWfBQE/oTp
         1zz0VjXqwxMfg9qshut0ncvoR0WHSxIGNjnTFwuUvzgb+zZuUApT8bL6Kbhl0EeZq+
         y8R3S9qBgPFBJrd21gmxb7jLkdzvd8VIS32m8H7EM2xogcqHzexDb1ViF/NtSszKlQ
         /Vi847jrx8PMxy6kcDROypZZXi3G5VO/O3n+bQfS3zaKUXjw5qY5KokAHaBiimyadX
         HfXP59/MNH852TEr2+E6odVDmc1k496u2Mn6/3ccLmiT9KmljH4JRH02RDVVh+8wvO
         P33QP2YBZBdE2Rxqj4Yv49msJeGJBE/RzNQiuPtoIDRR2HX2UZhQP4Ok6zg/MNHvXB
         mYRVuLi3jLUxlogl9KvfoQQ4MugjiKOAsdwRWVP/EzJ27rYYMRW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 00/19] object_id part 6
Date:   Mon, 20 Feb 2017 00:10:12 +0000
Message-Id: <20170220001031.559931-1-sandals@crustytoothpaste.net>
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

Changes from v3:
* Move the parse_oid_hex patch earlier in the series.
* Use parse_oid_hex in builtin/diff-tree.c.
* Fix several warts with parse_oid_hex pointed out by Peff.

Changes from v2:
* Fix misnamed function in commit message.
* Improve parameter name of parse_oid_hex.
* Improve docstring of parse_oid_hex.
* Remove needless variable.
* Rebase on master.

Changes from v1:
* Implement parse_oid_hex and use it.
* Make nth_packed_object_oid take a variable into which to store the
  object ID.  This avoids concerns about unsafe casts.
* Rebase on master.

brian m. carlson (19):
  hex: introduce parse_oid_hex
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
 builtin/diff-tree.c     |  43 ++++++++--------
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
 cache.h                 |  19 ++++++-
 hex.c                   |   8 +++
 reachable.c             |  30 +++++------
 ref-filter.c            |   4 +-
 reflog-walk.c           |  26 +++++-----
 refs.c                  |  24 ++++-----
 refs.h                  |   2 +-
 refs/files-backend.c    |  29 ++++++-----
 revision.c              |  12 ++---
 sha1_file.c             |  27 +++++++---
 sha1_name.c             |   2 +-
 transport.c             |   4 +-
 wt-status.c             |  52 +++++++++----------
 33 files changed, 484 insertions(+), 452 deletions(-)

-- 
2.11.0

