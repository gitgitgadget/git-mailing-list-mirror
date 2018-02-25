Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70DF1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeBYVM0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33822 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751557AbeBYVMZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:25 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 22CC86042F;
        Sun, 25 Feb 2018 21:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593141;
        bh=kCNp8RgUPY7BD6mtd4Z4RdF0bCk1xcBFItzb/v94/S8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gqSn51qudwSA8miMNBIhU+Orr2AKiia0D1VmiEMSx9GWioC2gpOIGTvnej8fiK4/9
         99ikBHL50cdAUaodaeRGmw8FoEhNJfbt86/mfWKpJfTKwImmwAuzdpOOAV3pitoNQs
         K1TMuycgzLnRbr3BqPJeM4vheISn3d2pwKst54PY3b8IvhnrEqTOho+EzwtQrp/WEz
         uz8qyxV3FJzCd9Eb+uGVpzROSyI5lLYz9rbhRRpl9SxjGsKZi/7feW0l3d5gLCKnS1
         LHiKtwFHZ4oHeNOKVNbAMs6bVNUcyrnDQ4OqxnS9T69bmieMeeZauYNFE6Rf9K+oNJ
         wNyKTnVhOlljeCPHB2UPDnWRtKUG6H8Doi46PBeFdKSptJFn0QddptZJNIkK0NrVp+
         IDL5h12rEwBTAnjVePoT6QXLj8CLwu/AcUO2fHwgdENWbyf3msQFM23z/kpmk//Rgd
         wOEvLR80ejTMUhQhIhT3XOhs1VvBsiHpII8FRe2r2ZWMjaxLw0Z
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/36] object_id part 12
Date:   Sun, 25 Feb 2018 21:11:36 +0000
Message-Id: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the twelfth in a series of patches to convert various parts of
the code to struct object_id.

The primary changes here are to the sha1_file code, find_unique_abbrev,
and lookup_replace_object.  Due to the circular nature of converting the
latter, there are several places where we briefly insert temporaries to
allow a multi-patch conversion.

Also included is a constant for object header length allocation.  This
isn't strictly related to the series, but it makes for a nice cleanup of
hard-coded constants, which is good for maintainability.

This series further decreases the number of hard-coded constants in the
code.  After this series, there are only 172 instances of the constant
"20" in the code (for any purpose) and 98 instances of "40".

Changes from v1:
* Rebase onto master.

brian m. carlson (36):
  bulk-checkin: convert index_bulk_checkin to struct object_id
  builtin/write-tree: convert to struct object_id
  cache-tree: convert write_*_as_tree to object_id
  cache-tree: convert remnants to struct object_id
  resolve-undo: convert struct resolve_undo_info to object_id
  tree: convert read_tree_recursive to struct object_id
  ref-filter: convert grab_objectname to struct object_id
  strbuf: convert strbuf_add_unique_abbrev to use struct object_id
  wt-status: convert struct wt_status_state to object_id
  Convert find_unique_abbrev* to struct object_id
  http-walker: convert struct object_request to use struct object_id
  send-pack: convert remaining functions to struct object_id
  replace_object: convert struct replace_object to object_id
  builtin/mktag: convert to struct object_id
  archive: convert write_archive_entry_fn_t to object_id
  archive: convert sha1_file_to_archive to struct object_id
  builtin/index-pack: convert struct ref_delta_entry to object_id
  sha1_file: convert read_loose_object to use struct object_id
  sha1_file: convert check_sha1_signature to struct object_id
  streaming: convert open_istream to use struct object_id
  builtin/mktree: convert to struct object_id
  sha1_file: convert assert_sha1_type to object_id
  sha1_file: convert retry_bad_packed_offset to struct object_id
  packfile: convert unpack_entry to struct object_id
  Convert remaining callers of sha1_object_info_extended to object_id
  sha1_file: convert sha1_object_info* to object_id
  builtin/fmt-merge-msg: convert remaining code to object_id
  builtin/notes: convert static functions to object_id
  tree-walk: convert get_tree_entry_follow_symlinks internals to
    object_id
  streaming: convert istream internals to struct object_id
  tree-walk: convert tree entry functions to object_id
  sha1_file: convert read_object_with_reference to object_id
  sha1_file: convert read_sha1_file to struct object_id
  Convert lookup_replace_object to struct object_id
  sha1_file: introduce a constant for max header length
  convert: convert to struct object_id

 apply.c                  |   4 +-
 archive-tar.c            |  28 ++++----
 archive-zip.c            |  18 ++---
 archive.c                |  32 ++++-----
 archive.h                |  10 +--
 bisect.c                 |   3 +-
 blame.c                  |  18 +++--
 builtin/am.c             |   8 +--
 builtin/blame.c          |   2 +-
 builtin/branch.c         |   2 +-
 builtin/cat-file.c       |  30 +++++----
 builtin/checkout.c       |  12 ++--
 builtin/commit-tree.c    |   2 +-
 builtin/describe.c       |   4 +-
 builtin/difftool.c       |   2 +-
 builtin/fast-export.c    |   8 +--
 builtin/fetch.c          |  10 +--
 builtin/fmt-merge-msg.c  |   4 +-
 builtin/fsck.c           |   4 +-
 builtin/grep.c           |   6 +-
 builtin/index-pack.c     |  43 ++++++------
 builtin/log.c            |   8 +--
 builtin/ls-files.c       |   4 +-
 builtin/ls-tree.c        |   8 +--
 builtin/merge-tree.c     |   5 +-
 builtin/merge.c          |   8 +--
 builtin/mktag.c          |  20 +++---
 builtin/mktree.c         |  24 +++----
 builtin/name-rev.c       |   2 +-
 builtin/notes.c          |  14 ++--
 builtin/pack-objects.c   |  27 ++++----
 builtin/prune.c          |   2 +-
 builtin/receive-pack.c   |   8 +--
 builtin/reflog.c         |   2 +-
 builtin/replace.c        |  10 +--
 builtin/reset.c          |   2 +-
 builtin/rev-list.c       |   2 +-
 builtin/rev-parse.c      |   2 +-
 builtin/rm.c             |   2 +-
 builtin/show-branch.c    |   2 +-
 builtin/show-ref.c       |   4 +-
 builtin/tag.c            |  16 +++--
 builtin/unpack-file.c    |   2 +-
 builtin/unpack-objects.c |   4 +-
 builtin/update-index.c   |   2 +-
 builtin/verify-commit.c  |   2 +-
 builtin/worktree.c       |   4 +-
 builtin/write-tree.c     |   6 +-
 bulk-checkin.c           |  18 ++---
 bulk-checkin.h           |   2 +-
 bundle.c                 |   2 +-
 cache-tree.c             |  36 +++++-----
 cache-tree.h             |   4 +-
 cache.h                  |  42 ++++++------
 combine-diff.c           |   6 +-
 commit.c                 |   8 +--
 config.c                 |   2 +-
 convert.c                |  12 ++--
 convert.h                |   2 +-
 diff.c                   |   6 +-
 dir.c                    |   2 +-
 entry.c                  |   4 +-
 fast-import.c            |  31 ++++-----
 fsck.c                   |   2 +-
 grep.c                   |   2 +-
 http-push.c              |   2 +-
 http-walker.c            |  16 ++---
 line-log.c               |   3 +-
 list-objects-filter.c    |   2 +-
 log-tree.c               |  12 ++--
 mailmap.c                |   2 +-
 match-trees.c            |  10 +--
 merge-blobs.c            |   4 +-
 merge-recursive.c        |  20 +++---
 notes-cache.c            |   2 +-
 notes-merge.c            |   2 +-
 notes.c                  |  10 +--
 object.c                 |  12 ++--
 pack-bitmap-write.c      |   3 +-
 pack-check.c             |   4 +-
 packfile.c               |  30 ++++-----
 pretty.c                 |   8 +--
 reachable.c              |   2 +-
 read-cache.c             |   4 +-
 ref-filter.c             |  14 ++--
 refs.c                   |   2 +-
 remote-testsvn.c         |   4 +-
 remote.c                 |   2 +-
 replace_object.c         |  26 ++++----
 rerere.c                 |   4 +-
 resolve-undo.c           |   8 +--
 resolve-undo.h           |   2 +-
 send-pack.c              |  12 ++--
 sequencer.c              |   9 +--
 sha1_file.c              | 137 ++++++++++++++++++++-------------------
 sha1_name.c              |  31 +++++----
 strbuf.c                 |   4 +-
 strbuf.h                 |   8 ++-
 streaming.c              |  18 ++---
 streaming.h              |   2 +-
 submodule-config.c       |   2 +-
 submodule.c              |   6 +-
 tag.c                    |  10 +--
 transport.c              |   6 +-
 tree-walk.c              |  45 +++++++------
 tree-walk.h              |   2 +-
 tree.c                   |  16 ++---
 tree.h                   |   2 +-
 wt-status.c              |  20 +++---
 wt-status.h              |   6 +-
 xdiff-interface.c        |   2 +-
 111 files changed, 591 insertions(+), 580 deletions(-)

