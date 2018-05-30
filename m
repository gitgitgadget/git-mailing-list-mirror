Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1131F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968493AbeE3AsZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:48:25 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:44103 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968488AbeE3AsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:48:20 -0400
Received: by mail-pl0-f47.google.com with SMTP id z9-v6so6614459plk.11
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jjC3iZe/mjxrEuN3Qt+fB6zcWridaCOeEAYtWV6Wcmg=;
        b=CEOCV/b1AsoKJLcWwpPa4aPe0w6vssq4MnpJ9OTMO7F5nYKTfPRWxV4CJLgjx06gOE
         Tp8b45UPJiczVBegPCmtRQnVQYrY6MNKT8D4MPq3WEMu/O1O585/Qpuo/cxdINpIKpaD
         /e1hG2AdgTSKbXZDxJ73qXkm+9oUsFXNOfbjl1cKgWrjQodEBLLvI8Ya+L/Pe5EQM/HP
         Z88bWfa3NtoT/TTvRj72ox35f7iek0t46Apv58XDmaL2/RbPlyaL9uBRepgEOYBCT3Tc
         QcSMa+tpa8ckdCM59uEPaYK9kmITMjYvoqo+uK5gVAkEB2bKO0SHO8s6vk7fbNfRIvA+
         vERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jjC3iZe/mjxrEuN3Qt+fB6zcWridaCOeEAYtWV6Wcmg=;
        b=li90EtTmuQ211jgOAxHkGtE5nI2uIfp7tOlRad2vd1nMMZ88q0AdP8oQNPJm1B+ejb
         A6ER+bAnCNTqkLEiYtg3JZCSbs24mSZHAUZIyjW2XRp1N+IojdbJ5OZanReQZrWodO6h
         t9xEtute7WMbEmml4vCzlakkZJaFUHheSCPDhuE5snLAl6qwkS6yNiOt/SnJD8S3HaAn
         UJgSWVImlFlnxH/ijU9guqG5BngCCeRhJIV63NKB/4/ZDJnXyYDZZa6XOTfBID1OnM6S
         YU/MAfaOZ0AtbuevCJsRDg+LLFoCcWCysFil7J3USU6KwhX0dOwE52KBRrJqAWenueVS
         Un9Q==
X-Gm-Message-State: ALKqPwcnBrFiW0K+Km/2HH6Pn9KTAe42SeVsPQrp/2AeHgbyCDYaETU1
        1jUOsmi8EkWTCrWr1SFZBliUh9xltZU=
X-Google-Smtp-Source: ADUXVKJeTgOtgb2uJPVeNd55k/aE5MDOPV5Bcmwm7yNaPt2K9y1xtZYePVodKwwdnXZiZAB/zxJzEw==
X-Received: by 2002:a17:902:ba97:: with SMTP id k23-v6mr609817pls.259.1527641299220;
        Tue, 29 May 2018 17:48:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v5-v6sm52724895pff.130.2018.05.29.17.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:48:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 00/35] object-store: lookup_commit
Date:   Tue, 29 May 2018 17:47:35 -0700
Message-Id: <20180530004810.30076-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on the merge of nd/commit-util-to-slab and sb/object-store-grafts,
and is available at http://github.com/stefanbeller/ as branch object-store-lookup-commit
as the merge has some merge conflicts as well as syntactical conflicts (upload-pack.c
and fetch-pack.c introduce new calls of functions that would want to take a repository struct
in the object-store-grafts series)

As layed out in https://public-inbox.org/git/20180517225154.9200-1-sbeller@google.com/
this is getting close to finishing the set of object store series though the last
unfinished part of this RFC hints at new work on the plate:
* To give this series a nice polish, we'd want to convert parse_commit, too.
  But that requires the conversion of the new commit graph. Maybe we need
  to split this series into 2. 
* Once this is in good shape we can talk about converting parts of the revision
  walking code,
* which then can be used by the submodule code as the end goal for the
  object store series.

Thanks,
Stefan

Jonathan Nieder (1):
  object: add repository argument to lookup_unknown_object

Stefan Beller (34):
  object: add repository argument to parse_object
  object: add repository argument to lookup_object
  object: add repository argument to parse_object_buffer
  object: add repository argument to object_as_type
  blob: add repository argument to lookup_blob
  tree: add repository argument to lookup_tree
  commit: add repository argument to lookup_commit_reference_gently
  commit: add repository argument to lookup_commit_reference
  commit: add repository argument to lookup_commit
  commit: add repository argument to parse_commit_buffer
  commit: add repository argument to set_commit_buffer
  commit: add repository argument to get_cached_commit_buffer
  tag: add repository argument to lookup_tag
  tag: add repository argument to parse_tag_buffer
  tag: add repository argument to deref_tag
  object: add repository argument to parse_commit_gently
  commit: add repository argument to parse_commit
  object: allow object_as_type to handle arbitrary repositories
  object: allow lookup_object to handle arbitrary repositories
  blob: allow lookup_blob to handle arbitrary repositories
  tree: allow lookup_tree to handle arbitrary repositories
  commit: allow lookup_commit to handle arbitrary repositories
  tag: allow lookup_tag to handle arbitrary repositories
  tag: allow parse_tag_buffer to handle arbitrary repositories
  commit.c: allow parse_commit_buffer to handle arbitrary repositories
  commit-slabs: remove realloc counter outside of slab struct
  commit.c: migrate the commit buffer to the parsed object store
  commit.c: allow set_commit_buffer to handle arbitrary repositories
  commit.c: allow get_cached_commit_buffer to handle arbitrary
    repositories
  object.c: allow parse_object_buffer to handle arbitrary repositories
  object.c: allow parse_object to handle arbitrary repositories
  tag.c: allow deref_tag to handle arbitrary repositories
  commit.c: allow lookup_commit_reference_gently to handle arbitrary
    repositories
  commit.c: allow lookup_commit_reference to handle arbitrary
    repositories

 archive.c                        |   2 +-
 bisect.c                         |   2 +-
 blame.c                          |  17 +++---
 blob.c                           |  10 ++--
 blob.h                           |   2 +-
 branch.c                         |   2 +-
 builtin/am.c                     |   9 ++-
 builtin/branch.c                 |   7 ++-
 builtin/checkout.c               |  10 ++--
 builtin/clone.c                  |   3 +-
 builtin/commit-tree.c            |   4 +-
 builtin/commit.c                 |   2 +-
 builtin/describe.c               |  17 +++---
 builtin/diff-tree.c              |   9 +--
 builtin/diff.c                   |   7 ++-
 builtin/fast-export.c            |  14 +++--
 builtin/fetch.c                  |   9 ++-
 builtin/fmt-merge-msg.c          |   9 ++-
 builtin/fsck.c                   |  22 ++++---
 builtin/grep.c                   |   3 +-
 builtin/index-pack.c             |   5 +-
 builtin/log.c                    |  10 ++--
 builtin/merge-base.c             |   9 +--
 builtin/merge-tree.c             |   3 +-
 builtin/name-rev.c               |  15 +++--
 builtin/notes.c                  |   5 +-
 builtin/pack-objects.c           |   4 +-
 builtin/prune.c                  |   2 +-
 builtin/pull.c                   |  15 +++--
 builtin/receive-pack.c           |   6 +-
 builtin/reflog.c                 |  17 +++---
 builtin/replace.c                |   4 +-
 builtin/reset.c                  |   4 +-
 builtin/rev-list.c               |   2 +-
 builtin/rev-parse.c              |   6 +-
 builtin/show-branch.c            |   9 +--
 builtin/tag.c                    |   2 +-
 builtin/unpack-objects.c         |   7 ++-
 builtin/verify-commit.c          |   4 +-
 bundle.c                         |  10 ++--
 cache-tree.c                     |   3 +-
 commit-graph.c                   |  20 +++----
 commit-slab-impl.h               |   3 -
 commit.c                         | 100 ++++++++++++++++++-------------
 commit.h                         |  24 +++++---
 fast-import.c                    |   6 +-
 fetch-pack.c                     |  45 ++++++++------
 fsck.c                           |   9 +--
 http-backend.c                   |   4 +-
 http-push.c                      |  18 +++---
 line-log.c                       |   2 +-
 list-objects.c                   |   4 +-
 log-tree.c                       |  13 ++--
 merge-recursive.c                |  15 +++--
 notes-cache.c                    |   3 +-
 notes-merge.c                    |   5 +-
 notes-utils.c                    |   6 +-
 object.c                         |  63 ++++++++++---------
 object.h                         |  13 ++--
 packfile.c                       |   2 +-
 parse-options-cb.c               |   2 +-
 pretty.c                         |   4 +-
 reachable.c                      |   8 +--
 ref-filter.c                     |  12 ++--
 reflog-walk.c                    |   3 +-
 refs.c                           |   4 +-
 refs/files-backend.c             |   2 +-
 remote.c                         |  21 ++++---
 revision.c                       |  37 ++++++------
 sequencer.c                      |  30 +++++-----
 server-info.c                    |   4 +-
 sha1-file.c                      |   4 +-
 sha1-name.c                      |  37 ++++++------
 shallow.c                        |  34 +++++++----
 submodule.c                      |  10 ++--
 t/helper/test-example-decorate.c |   6 +-
 tag.c                            |  28 ++++-----
 tag.h                            |   7 +--
 tree.c                           |  21 +++----
 tree.h                           |   2 +-
 upload-pack.c                    |  19 +++---
 walker.c                         |  16 +++--
 wt-status.c                      |   2 +-
 83 files changed, 547 insertions(+), 423 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty

