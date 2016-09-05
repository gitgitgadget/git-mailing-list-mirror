Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF162070F
	for <e@80x24.org>; Mon,  5 Sep 2016 20:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964976AbcIEUKi (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:10:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42936 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964877AbcIEUI0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7C5D7280A6;
        Mon,  5 Sep 2016 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106104;
        bh=K7W6daOEeG8hc//fXWX5sflvrzfQgswl0Yi6meJU/ro=;
        h=From:To:Cc:Subject:Date:From;
        b=vcvhxjU+Hl+RHT9i1E1+/YuxHuJeaP2jbiIKhGt7LRwWm4sg7JCbD3gykuOX9rEaD
         2YdYKVA2BAigB0u68wcC9SPM6pVRZO5Wn969T4gYAseXe+zJfbe05YIREb+mjYQajT
         IruCrdN9p805hm5NvpMJ1xvegU7T7+RYdooehZHUKZKBmpFhQU+rcf5q0TFt3SFkca
         zLPRcY9ssOvfvyoDsDZ6hJ81WlS6MIaEXRVwgbPNmrVzAoZE5Dqd+pAhE8NdFUyo7D
         sWXUs/xf2mafRaBCXOg69Oo9t0mNpFPmazefYgOSoITJMJ35wyC7GszSP2wP8gTmpj
         a3Bg2bFbl25pDYIIQ0jLJRs0a6wp2xheY6QmEAeU4JVmIlwcg0t4eZgA/VFu2fzy8Y
         2xy1O4jbWpPzqNUlGjubQdskG9NRLk3hsnksCEL9Q+WLRbA1nEVktKpNcD3neUB232
         B3yhlTpqwZzM2Q0F+9U/peKT4V5UCsuulXvRmOXmzgo7cdp9yKf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 00/20] object_id part 5
Date:   Mon,  5 Sep 2016 20:07:51 +0000
Message-Id: <20160905200811.697889-1-sandals@crustytoothpaste.net>
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

Changes from v1:
* More clearly state that the Coccinelle-using patches also have a manual struct
  update.
* Convert the uninitialized constant in notes-merge.c.
* Convert one additional use of update_ref into update_ref_oid.

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
 builtin/am.c                     | 140 +++++++++++++++++++--------------------
 builtin/apply.c                  |  94 +++++++++++++-------------
 builtin/blame.c                  |  76 ++++++++++-----------
 builtin/cat-file.c               |  70 ++++++++++----------
 builtin/checkout.c               |  70 ++++++++++----------
 builtin/commit-tree.c            |  20 +++---
 builtin/fsck.c                   |   4 +-
 builtin/grep.c                   |   3 +-
 builtin/log.c                    |  44 ++++++------
 builtin/ls-files.c               |   2 +-
 builtin/merge-index.c            |   2 +-
 builtin/read-tree.c              |   2 +-
 builtin/reset.c                  |  52 +++++++--------
 builtin/rm.c                     |  18 ++---
 builtin/submodule--helper.c      |   5 +-
 builtin/update-index.c           |  67 ++++++++++---------
 cache-tree.c                     |   4 +-
 cache.h                          |   4 +-
 diff-lib.c                       |  31 +++++----
 diff.c                           |   2 +-
 dir.c                            |   7 +-
 entry.c                          |   9 +--
 merge-recursive.c                |   8 +--
 notes-merge.c                    | 127 ++++++++++++++++++-----------------
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
 40 files changed, 497 insertions(+), 469 deletions(-)

