Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D7FE201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdBRAHB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:07:01 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59994 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750772AbdBRAHA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 19:07:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4BA8F280AD;
        Sat, 18 Feb 2017 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487376418;
        bh=7hlrxWZ+4P9MAoeVcdtC/zKaIMWObdIIoRqvnx4RkUk=;
        h=From:To:Cc:Subject:Date:From;
        b=EjfffCNv3ZGCdWz3A6CO6d1FAirpDxgL+cQfp+onpfhA5cyRSnzBz5uciV2qreA+q
         MEQXsrXgnLFuFJ9jDXofZZykTJ24IdaG9qf8paMyBUl05FUwwTNC71kSViZwtRmkXk
         P4+J7gV338XDqYWrg8dy0EjesxFqu00DYEcBHTqfkU9CXcGDDHYLZ3UrxKtpIT14qN
         xBrHeaThvlCi9OmHTTr/jZruOQwbaA87bjZsKQlxSWoC5UZsaVAicyTo46gacu10vD
         FqPgTIfAhEmLi2Woqy5S7PnvTR5vB3HxSEl4ZOjMKjg1m0HP/EHeQaLsSVLwSZ/UJ2
         +ZW3dwb1kRZrjHwr0dffIb/BxRuQNSMiA9kiwZqm4+2wgdc6T24sFzFstuYuge92Tj
         BNV+nZ+XnuyXDnaKxQQFYF4lKZitjub1h61VaO8xyGKYbc/w2ejhmWHfMd58sU0ymA
         HW4sdoTyhlJQFf8zxztcjMPYHbyb55UPF3D5znmRjo+tJ38yhGS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/19] object_id part 6
Date:   Sat, 18 Feb 2017 00:06:33 +0000
Message-Id: <20170218000652.375129-1-sandals@crustytoothpaste.net>
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

The conflicts in pu with v2 are probably still present, but I expect the
resolution should be easy (and I suspect Junio uses git rerere, so they'll be
even easier).

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
 33 files changed, 483 insertions(+), 448 deletions(-)

-- 
2.11.0

