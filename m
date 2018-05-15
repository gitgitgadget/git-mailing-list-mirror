Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159BE1F406
	for <e@80x24.org>; Tue, 15 May 2018 23:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeEOXmi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:42:38 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:41183 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXmh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:42:37 -0400
Received: by mail-pl0-f52.google.com with SMTP id az12-v6so960022plb.8
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MOBRcmNdm5OJkdxJr7Do2gg5YROtwJ4l/KUAA8q2HFk=;
        b=AKneIyM7jIx/u02N+E9jB88k6t9aJZ/uf64/NF6GMSn3yF9fRRON6lYDra3O9NX8cB
         sHT+M879Sa9Yled8OFrCdkiTE4mdaQLBKYjxYRy9yaoB/c/AxiKM0a/HxtWpPBfevTrV
         KJz55JvyvcRuPfgU+cOKio6qfNRREnB14CXM9vrUJE1i7xbsZ8JEE/pR17NgbysnCPC5
         BufYPJzpTls9G92AUZF2WJl1A1hHB7GSwNRhmoHj3cDp5zk8ioBCbsdlvgav7gQZGP8P
         bYZ8NxBwuMWCwIYo2uA8rTXedvgKUObovZQ79usUL8Wo/YumN1X/jtxcpUGxFC30YJVk
         73qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MOBRcmNdm5OJkdxJr7Do2gg5YROtwJ4l/KUAA8q2HFk=;
        b=LSG2L6NUTQxA4+Vpco2ntTH7sPNuKKuL3ENhIrgHltHDEEbqHaqUnw2qoB2GFTMyHd
         V0gwp7DK0ilwwAwkSEAY5uenyQ9vh/YvxUMqaYcsGgRabD2scaQbF6WisNgt0Mtpqz8/
         03KzpI3O7cDMw0jDQSID2z1mfannAOHSMdQul9p4neRuK+u8UTGbES4wbml82q4hzaPu
         Jf9PrR2d0dnCB4JkRy3lH1GhMcuM9VZ2Hgd3B1xhSmp6hbjTjpqcKVqtbST19Ut97iDH
         1rC/utEqq1/PLSh4hSA9+Bfgk0LT6iTgUrUTql6uMYObWPtDUgcr4iBbuT+MYL7+a+OP
         aKwg==
X-Gm-Message-State: ALKqPwcorCNx2wkozZOSM94wvUj3ac8IU8NXoexEX4BJTpAIVt9Rr30N
        5sPxIsegUPyi80+bJ7R1VZ+kPbi47QI=
X-Google-Smtp-Source: AB8JxZpxqy4ctVcbDccvIeIecuH8wlisQXXRZz7uZXpySh7Gx1WSiGvSuDvlOqv/biLXQM+iT4DejA==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10-v6mr16518924plz.160.1526427755879;
        Tue, 15 May 2018 16:42:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t190-v6sm1144810pgb.36.2018.05.15.16.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:42:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 00/19] object store: grafts and shallow.
Date:   Tue, 15 May 2018 16:42:14 -0700
Message-Id: <20180515234233.143708-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on top of sb/object-store-alloc[1], and is the next part of the
object store series. 

I think we're getting close to actually being done in the object store series,
as the next series to build on top of this will convert the
lookup_{object, commit, ...} functions.

However I marked this series as RFC, as I expect heavy conflicts with the
code base. sb/object-store-alloc builds on an older base of the code base
and there have been some series that will conflict with this one.
For example the patch to migrate path functions into a repository world
will collide with one of Dschos series as he added another path helper
function there. I am happy to reroll on top of that, but for now I chose
sb/object-store-alloc to keep the momentum in the object-store series'.

There is another object store series that is not part of the critical path:
There is a mem leak in the pack files stored in the raw object store.
Upon free'ing the repository we do not free its pack files. We cannot
free the packfiles, as otherwise the bitmap code would have dangling
pointers into packfiles that no longer exists, leading to segfaults.
So we'll need to have an object store series covering the bitmap code.
I have something local, which I'll send out shortly.

Thanks,
Stefan

[1] with the latest patch replaced as in
    https://public-inbox.org/git/20180515214842.108713-1-sbeller@google.com/

Brandon Williams (3):
  commit: convert commit_graft_pos() to handle arbitrary repositories
  commit: convert register_commit_graft to handle arbitrary repositories
  commit: convert read_graft_file to handle arbitrary repositories

Jonathan Nieder (6):
  object: move grafts to object parser
  commit: add repository argument to commit_graft_pos
  commit: add repository argument to register_commit_graft
  commit: add repository argument to read_graft_file
  commit: add repository argument to prepare_commit_graft
  commit: add repository argument to lookup_commit_graft

Stefan Beller (10):
  object-store: move object access functions to object-store.h
  shallow: add repository argument to set_alternate_shallow_file
  shallow: add repository argument to register_shallow
  shallow: add repository argument to check_shallow_file_for_update
  shallow: add repository argument to is_repository_shallow
  cache: convert get_graft_file to handle arbitrary repositories
  path.c: migrate git_path_ to take a repository argument
  shallow: migrate shallow information into the object parser
  commit: allow prepare_commit_graft to handle arbitrary repositories
  commit: allow lookup_commit_graft to handle arbitrary repositories

 apply.c                  |   1 +
 archive-tar.c            |   1 +
 archive-zip.c            |   1 +
 archive.c                |   1 +
 blame.c                  |   9 ++-
 branch.c                 |  14 ++---
 builtin/blame.c          |   4 +-
 builtin/cat-file.c       |   1 +
 builtin/checkout.c       |   1 +
 builtin/clone.c          |   1 +
 builtin/commit-tree.c    |   1 +
 builtin/commit.c         |  38 ++++++-------
 builtin/describe.c       |   1 +
 builtin/difftool.c       |   1 +
 builtin/fast-export.c    |   1 +
 builtin/fetch.c          |   7 ++-
 builtin/fmt-merge-msg.c  |   1 +
 builtin/hash-object.c    |   1 +
 builtin/log.c            |   1 +
 builtin/ls-tree.c        |   1 +
 builtin/merge-tree.c     |   1 +
 builtin/merge.c          |  37 ++++++------
 builtin/mktag.c          |   1 +
 builtin/mktree.c         |   1 +
 builtin/notes.c          |   1 +
 builtin/pack-objects.c   |   6 +-
 builtin/prune.c          |   3 +-
 builtin/pull.c           |   4 +-
 builtin/receive-pack.c   |   3 +-
 builtin/reflog.c         |   1 +
 builtin/remote.c         |   1 +
 builtin/reset.c          |   2 +-
 builtin/rev-list.c       |   1 +
 builtin/rev-parse.c      |   3 +-
 builtin/show-ref.c       |   1 +
 builtin/tag.c            |   1 +
 builtin/unpack-file.c    |   1 +
 builtin/unpack-objects.c |   1 +
 builtin/verify-commit.c  |   1 +
 bulk-checkin.c           |   1 +
 bundle.c                 |   1 +
 cache-tree.c             |   1 +
 cache.h                  | 119 +--------------------------------------
 combine-diff.c           |   1 +
 commit.c                 |  77 +++++++++++++------------
 commit.h                 |  10 ++--
 config.c                 |   1 +
 convert.c                |   1 +
 diff.c                   |   1 +
 diffcore-rename.c        |   1 +
 dir.c                    |   1 +
 entry.c                  |   1 +
 environment.c            |   8 +--
 fetch-pack.c             |   9 +--
 fsck.c                   |   3 +-
 git.c                    |   2 +-
 grep.c                   |   1 +
 list-objects-filter.c    |   1 +
 list-objects.c           |   1 +
 log-tree.c               |   1 +
 mailmap.c                |   1 +
 match-trees.c            |   1 +
 merge-blobs.c            |   1 +
 merge-recursive.c        |   1 +
 notes-cache.c            |   1 +
 notes-merge.c            |   1 +
 notes.c                  |   1 +
 object-store.h           | 117 ++++++++++++++++++++++++++++++++++++++
 object.c                 |   4 ++
 object.h                 |  10 ++++
 pack-bitmap-write.c      |   1 +
 packfile.h               |   5 ++
 path.c                   |  18 +++---
 path.h                   |  40 ++++++++++---
 read-cache.c             |   1 +
 ref-filter.c             |   1 +
 refs.c                   |   1 +
 remote-testsvn.c         |   1 +
 remote.c                 |   1 +
 repository.h             |   5 ++
 rerere.c                 |   8 ++-
 revision.c               |   1 +
 send-pack.c              |   7 ++-
 sequencer.c              |  38 +++++++------
 shallow.c                |  74 ++++++++++++------------
 submodule-config.c       |   1 +
 tag.c                    |   1 +
 tree-walk.c              |   1 +
 tree.c                   |   1 +
 unpack-trees.c           |   1 +
 upload-pack.c            |  10 ++--
 walker.c                 |   1 +
 wt-status.c              |   8 +--
 xdiff-interface.c        |   1 +
 94 files changed, 450 insertions(+), 314 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty

