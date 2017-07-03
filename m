Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509A4201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbdGCSzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52934 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751907AbdGCSzr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 251EE280AD;
        Mon,  3 Jul 2017 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108146;
        bh=F4yzVUhQq8t1OAizbxgA0+vb9TdVtFhrTAXlv2XrCTc=;
        h=From:To:Cc:Subject:Date:From;
        b=NtqMGvDrQcDawGMuzLYDK9SXJCszjmrxRKI6hhObhf+wc9kD2aiRdnG2zQXOBpSAD
         nR3FziuXDL4zdhmlpe+kkASN4yI6i5BCe3BQ+a+NdibJ+dNQtreyvP/ubUu7ToFkCp
         CoQCSXKvgibS7lMv4tQx185ym123Ds6C0iyuEVB6PLuZ722icr/9gYhv/EyZf8uyo1
         O4CFJTuu5U3E8RzlB0JC2xwH0lKXJKO/PFh99r7xnK4mkvXEvAm9idM73Sb3fqKqos
         8MWVl1xST5ZExlOTjtOyck/j2oqV6YvhUo3gsW5OqxTFirHdieHgPJSvbloXMWn01G
         5bn1cJq0TRPccSxb5P9a0i4aWx9RLW55M4/beXqzeRJcaIP8t3J9zQ0tgMOW3DFitq
         hZP204S1uoZd/SF4B4vsLF9J+bKFMhq/dJiDWubewCt+7eLVYNzCsFt01Mvwcl4gDB
         /Qo1k1eI+lhcjoVWfVyqZgXjmquNSBK33m27UJ1tPj4WWsnPsmR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 00/12] object_id part 9
Date:   Mon,  3 Jul 2017 18:55:21 +0000
Message-Id: <20170703185533.51530-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the ninth in a series of series to convert Git to use struct
object_id.  This series converts the remaining callers of get_sha1 and
friends to take and use struct object_id, and in doing so, renames them
to get_oid and friends.

It is possible there will be some other conflicts with in flight topics,
as get_sha1 is commonly used in the codebase.  This is unavoidable to
some extent, but should be kept in mind.  My experience is that usually
the required changes for conversion are minimal.

This series is much reduced in size thanks to the conversion work done
by Brandon Williams in his earlier series touching the notes code.

brian m. carlson (12):
  builtin/fsck: convert remaining caller of get_sha1 to object_id
  builtin/merge-tree: convert remaining caller of get_sha1 to object_id
  submodule: convert submodule config lookup to use object_id
  remote: convert struct push_cas to struct object_id
  sequencer: convert to struct object_id
  builtin/update_ref: convert to struct object_id
  bisect: convert bisect_checkout to struct object_id
  builtin/unpack-file: convert to struct object_id
  builtin/verify-tag: convert to struct object_id
  Convert remaining callers of get_sha1 to get_oid.
  sha1_name: convert get_sha1* to get_oid*
  sha1_name: convert GET_SHA1* flags to GET_OID*

 apply.c                          |   4 +-
 archive.c                        |   2 +-
 bisect.c                         |  18 +--
 builtin/am.c                     |   6 +-
 builtin/cat-file.c               |   8 +-
 builtin/commit-tree.c            |   4 +-
 builtin/commit.c                 |   8 +-
 builtin/fsck.c                   |   8 +-
 builtin/grep.c                   |   8 +-
 builtin/log.c                    |   4 +-
 builtin/merge-tree.c             |   6 +-
 builtin/receive-pack.c           |   4 +-
 builtin/replace.c                |   4 +-
 builtin/reset.c                  |  10 +-
 builtin/rev-parse.c              |   8 +-
 builtin/show-branch.c            |   8 +-
 builtin/submodule--helper.c      |   8 +-
 builtin/unpack-file.c            |  12 +-
 builtin/update-ref.c             |  69 ++++++------
 builtin/verify-tag.c             |   8 +-
 cache.h                          |  45 ++++----
 commit.c                         |   4 +-
 config.c                         |  12 +-
 config.h                         |   4 +-
 mailmap.c                        |   6 +-
 notes.c                          |   2 +-
 refs.c                           |   2 +-
 remote.c                         |   8 +-
 remote.h                         |   2 +-
 revision.c                       |  16 +--
 sequencer.c                      |  65 +++++------
 sha1_name.c                      | 234 +++++++++++++++++++--------------------
 submodule-config.c               |  36 +++---
 submodule-config.h               |  10 +-
 submodule.c                      |  32 +++---
 submodule.h                      |   2 +-
 t/helper/test-submodule-config.c |  10 +-
 transport-helper.c               |   2 +-
 38 files changed, 345 insertions(+), 354 deletions(-)

