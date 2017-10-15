Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F5F20372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbdJOWHh (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54974 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751159AbdJOWHf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2131160448;
        Sun, 15 Oct 2017 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105254;
        bh=L7hKJavdgPHGN5qS32bR5gUkzSq8P9v8tiEm+4BSvJ8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HFSZfVaIOQxpCjRf+xVgBU4IjG6wyboNpGNlUMjX044E69Tpruz6r/oArSKcmX9gl
         Y/0WYXULh/ctvt+0AWTtfynfqEgzALZkqbU+qIhEPyL1AQvxsadAHKbkCKBqHL1XpO
         cTsUGCTIT+AweSlaanVsvuz687F3BiqNYLvdepoAvZJpOZ/DAjnLVtfXBUAeomBHKp
         x8iR1Y2I5VqSeUfnPGAo8+dYA+mgSvFtWntH6yhOScraHEu+nYUxfSGGlOL05FNThC
         beAVwhk4/Lo8A8cDteTXmbvHnwKN9d2NbKhq+PTgobuJdxjDfWrlPRBv/QJfXuV3G2
         I2LhNfSrHffRyJrW01TLyg03EQPRdHGeqtdP0J9mz/Xw3ZlJorcL2PvU923CGM3PBW
         RNQu6Iekoc2Tj06Az7LjBTtsKnV2TKGgw4eNMpOoEaNbF/Du1WpqjKZcBetAO0tGpt
         GFn2KTn80G7SbNaPgYpMmL1dN06iuMYLFeePGXW+o3zj+UntIVB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 00/25] object_id part 10
Date:   Sun, 15 Oct 2017 22:06:47 +0000
Message-Id: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the tenth in a series of patches to convert from unsigned char
[20] to struct object_id.  This series mostly involves changes to the
refs code.  After these changes, there are almost no references to
unsigned char in the main refs code.

In this iteration, I chose to skip the ALLOC_ARRAY conversion to limit
the scope of changes and because I think to be fixed properly the code
requires converting the targets parameter to size_t, which involves
touching more code unrelated to the series than I'd like to do right
now.

All the other issues that were brought up should be fixed.

This series is available from the following URL:
https://github.com/bk2204/git.git object-id-part10

Changes from v2:
* Rebase on master.  This drops significant parts of one patch, as Junio
  pointed out.
* Restore sane line wrappings.
* Fix several docstrings and error messages to reflect object ID instead
  of SHA-1.
* Fix potential NULL dereference in refs_delete_ref.
* Fix potential NULL dereference in expand_ref.
* Add a patch to fix potential NULL dereference in write_pseudoref.
* Restore the missing line in the refs code.
* Fix two commit message typos.

Changes from v1:
* Fix line wrapping in several places.
* Remove empty line.
* Update die messages to refer to "object ID" instead of "sha1".

brian m. carlson (25):
  walker: convert to struct object_id
  refs/files-backend: convert struct ref_to_prune to object_id
  refs: convert delete_ref and refs_delete_ref to struct object_id
  refs: convert update_ref and refs_update_ref to use struct object_id
  refs: prevent accidental NULL dereference in write_pseudoref
  refs: update ref transactions to use struct object_id
  Convert check_connected to use struct object_id
  refs: convert resolve_refdup and refs_resolve_refdup to struct
    object_id
  refs: convert read_ref and read_ref_full to object_id
  refs: convert dwim_ref and expand_ref to struct object_id
  builtin/reflog: convert remaining unsigned char uses to object_id
  refs: convert dwim_log to struct object_id
  pack-bitmap: convert traverse_bitmap_commit_list to object_id
  builtin/pack-objects: convert to struct object_id
  refs: convert peel_ref to struct object_id
  refs: convert read_ref_at to struct object_id
  refs: convert reflog_expire parameter to struct object_id
  sha1_file: convert index_path and index_fd to struct object_id
  Convert remaining callers of resolve_gitlink_ref to object_id
  refs: convert resolve_gitlink_ref to struct object_id
  worktree: convert struct worktree to object_id
  refs: convert resolve_ref_unsafe to struct object_id
  refs: convert peel_object to struct object_id
  refs: convert read_raw_ref backends to struct object_id
  refs/files-backend: convert static functions to object_id

 archive.c                   |   2 +-
 bisect.c                    |   5 +-
 blame.c                     |   4 +-
 branch.c                    |   4 +-
 builtin/am.c                |  16 +--
 builtin/branch.c            |   8 +-
 builtin/checkout.c          |  10 +-
 builtin/clone.c             |  22 ++--
 builtin/commit.c            |   4 +-
 builtin/describe.c          |   2 +-
 builtin/fast-export.c       |   2 +-
 builtin/fetch.c             |   8 +-
 builtin/fmt-merge-msg.c     |   2 +-
 builtin/fsck.c              |   2 +-
 builtin/log.c               |   2 +-
 builtin/merge-base.c        |   2 +-
 builtin/merge.c             |  17 ++--
 builtin/notes.c             |  12 +--
 builtin/pack-objects.c      | 139 ++++++++++++-------------
 builtin/pull.c              |   2 +-
 builtin/receive-pack.c      |  14 +--
 builtin/reflog.c            |  18 ++--
 builtin/remote.c            |   2 +-
 builtin/replace.c           |   8 +-
 builtin/reset.c             |   6 +-
 builtin/rev-list.c          |   4 +-
 builtin/rev-parse.c         |   2 +-
 builtin/show-branch.c       |  12 +--
 builtin/show-ref.c          |   4 +-
 builtin/submodule--helper.c |   2 +-
 builtin/tag.c               |   8 +-
 builtin/update-index.c      |  10 +-
 builtin/update-ref.c        |  12 +--
 builtin/worktree.c          |   6 +-
 bundle.c                    |   4 +-
 combine-diff.c              |   2 +-
 connected.c                 |  18 ++--
 connected.h                 |   4 +-
 diff-lib.c                  |   4 +-
 dir.c                       |   8 +-
 fast-import.c               |   6 +-
 notes-cache.c               |   4 +-
 notes-merge.c               |   2 +-
 notes-utils.c               |   4 +-
 notes.c                     |   2 +-
 pack-bitmap.c               |   8 +-
 pack-bitmap.h               |   2 +-
 read-cache.c                |   6 +-
 reflog-walk.c               |   2 +-
 refs.c                      | 243 ++++++++++++++++++++++----------------------
 refs.h                      | 103 +++++++++----------
 refs/files-backend.c        | 112 ++++++++++----------
 refs/packed-backend.c       |  12 +--
 refs/ref-cache.c            |   2 +-
 refs/refs-internal.h        |  20 ++--
 remote-testsvn.c            |   2 +-
 remote.c                    |   8 +-
 sequencer.c                 |  14 +--
 sha1_file.c                 |  32 +++---
 sha1_name.c                 |  10 +-
 submodule.c                 |   2 +-
 t/helper/test-ref-store.c   |  28 ++---
 transport-helper.c          |  15 ++-
 transport.c                 |   4 +-
 unpack-trees.c              |   8 +-
 upload-pack.c               |   4 +-
 walker.c                    |  24 ++---
 worktree.c                  |   2 +-
 worktree.h                  |   2 +-
 wt-status.c                 |   2 +-
 70 files changed, 544 insertions(+), 554 deletions(-)

-- 
2.15.0.rc0.271.g36b669edcc

