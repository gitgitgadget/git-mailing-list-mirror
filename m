Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C3591F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935842AbeF2BWd (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:22:33 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:50238 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935756AbeF2BWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:22:32 -0400
Received: by mail-io0-f202.google.com with SMTP id n15-v6so5628155ioc.17
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=MaD+lz/5Xbmn9ZlKb2ZfmAvVwmoKbr/KDJKQOpXfgYM=;
        b=Vj4aREOwYkj65P2/Wifk3t4En1IaOZmkea0Sm+Ylx9NlUxuvTDXGZE+TpOSpEewMrg
         CMjQCxhHQjgrmaXrz+GKbkgbI6T4eSptB2b7X/noKk4RC32k1FQc3Q5DnancXEpewvx5
         fdoYAx1h2q/EITvFQwn25Z+DdBQ2I2ROdxytkRjvCUTmWNmtIm8EPhHgdDC3I3Ho1ATw
         Rz0bK1iUQtRCfs71X8nIAjHfxDFZ4+BzeB9EKfTxilvEkq2aIPNRp5VXKeN6flZGX+UY
         SnWl23PGfmqvt0eR6PqcHa1w4p6L8z2hDOOVA2liuRbMZ5VrY6vo1NNgklQbTmpz6ZNk
         DRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=MaD+lz/5Xbmn9ZlKb2ZfmAvVwmoKbr/KDJKQOpXfgYM=;
        b=Gdv6o8SBeRVxuMJtAo4DWYFGmwvZZ2JSRMM3tgVeXWMtRnYev7VKLIvyLlcBXsLj+8
         qbFCuNdXhhv2Bx2P4rB/zoOjQDyCbVU/RdChOqDAWjmAN2GQzpjqTf1CgfC7whIOGVmx
         oAP5v1QDVvZERYo6xK/OshF6o5yEomJ2UmgX0NIjjVKNDK8GkS7xAWB7D88k6psOlud7
         tFfSx5lGfRJ5GEtkw8LyV25axAZ4DL3be0Qx2LKtDhZbrFh+JUZM9nZf7efjA6xlvTED
         SadXyvhMsAB+FbLxN6Ma21zUXp+ibMt+0m4SrL85yr9ryfcVfVn6X42bLsdlIF6sJUaP
         OBZQ==
X-Gm-Message-State: APt69E0B4mHeseEQe7dz+lAUKWdttP3Bh5IAYGyoq3sAkHkejsbz0T9R
        pN9JsmQ3KKU9WPdHLO8K7fgdKoAWjjtwlhE5kBi77qM/fB4XqiBdBeakdSRjqANXIlywiWI8PUW
        cQsEomaNKb5RVKbFFSPy0HPIhpMX1qM0S5So0f8YNDNbwvZdm6tvrgh/hyYoU
X-Google-Smtp-Source: AAOMgpeu8fasVQ0kdrWdMPR+7qh+H6svs+wZpHdqsgcYUHCAL1HPw8JkJ3r3DDwZe575c42tWnPV5Sychm3q
MIME-Version: 1.0
X-Received: by 2002:a24:6704:: with SMTP id u4-v6mr78293itc.17.1530235351959;
 Thu, 28 Jun 2018 18:22:31 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:21:50 -0700
Message-Id: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 00/32] object-store: lookup_commit
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the elimination of global variables in the object store and
teaches lookup_commit[_reference] and alike to handle a_repository.

This is also available as
https://github.com/stefanbeller/git/tree/object-store-lookup-commit
or applies on top of 02f70d63027 (Merge branch 'sb/object-store-grafts'
into next, 2018-06-28).

Picking a base for this one is really hard, as nearly all series currently
cooking or in flight collide with it on one or two lines. (lookup_* is used
heavily, who would have thought?); I really needed 'sb/object-store-grafts'
to build on; and there is only one other series before that in current next,
which this series would have conflicted with, if not based on top of it.

In "The state of the object store series" [1], this was tentatively named
"sb/object-store-lookup".

Thanks,
Stefan

[1] https://public-inbox.org/git/CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com/


v2 https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/
* removed mentions of cooci patches
* added forward declaration of commit buffer slabs.
* dropped 3 patches that add the repository to lookup_unkonwn_object,
  parse_commit and parse_commit_gently, but were not converting those
  functions. We'll convert these in the next series, as this series is
  growing big already.
* This series can be found as branch 'object-store-lookup-commit' on github,
  it applies on top of nd/commit-util-to-slab merged with sb/object-store-grafts

v1, https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/

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


Stefan Beller (32):
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

 archive.c                |  2 +-
 bisect.c                 |  2 +-
 blame.c                  | 13 ++++---
 blob.c                   | 10 ++---
 blob.h                   |  2 +-
 branch.c                 |  2 +-
 builtin/am.c             |  9 +++--
 builtin/branch.c         |  7 ++--
 builtin/checkout.c       |  6 +--
 builtin/clone.c          |  3 +-
 builtin/commit-tree.c    |  4 +-
 builtin/describe.c       | 13 ++++---
 builtin/diff-tree.c      |  9 +++--
 builtin/diff.c           |  7 ++--
 builtin/fast-export.c    | 14 ++++---
 builtin/fetch.c          |  9 +++--
 builtin/fmt-merge-msg.c  |  9 +++--
 builtin/fsck.c           | 21 +++++++----
 builtin/grep.c           |  3 +-
 builtin/index-pack.c     |  5 ++-
 builtin/log.c            | 10 +++--
 builtin/merge-base.c     |  7 ++--
 builtin/merge-tree.c     |  3 +-
 builtin/name-rev.c       | 13 ++++---
 builtin/notes.c          |  3 +-
 builtin/pack-objects.c   |  2 +-
 builtin/prune.c          |  2 +-
 builtin/pull.c           | 15 +++++---
 builtin/receive-pack.c   |  6 +--
 builtin/reflog.c         | 15 +++++---
 builtin/replace.c        |  8 ++--
 builtin/reset.c          |  4 +-
 builtin/rev-list.c       |  2 +-
 builtin/rev-parse.c      |  6 +--
 builtin/show-branch.c    |  5 ++-
 builtin/tag.c            |  2 +-
 builtin/unpack-objects.c |  7 ++--
 builtin/verify-commit.c  |  4 +-
 bundle.c                 | 10 +++--
 cache-tree.c             |  3 +-
 commit-graph.c           | 14 +++----
 commit-slab-impl.h       |  3 --
 commit.c                 | 80 +++++++++++++++++++++++++---------------
 commit.h                 | 18 ++++++---
 fast-import.c            |  6 ++-
 fetch-pack.c             | 39 ++++++++++++--------
 fsck.c                   |  9 +++--
 http-backend.c           |  4 +-
 http-push.c              | 16 +++++---
 line-log.c               |  2 +-
 list-objects.c           |  4 +-
 log-tree.c               | 13 ++++---
 merge-recursive.c        | 17 +++++----
 notes-cache.c            |  3 +-
 notes-merge.c            |  5 ++-
 notes-utils.c            |  4 +-
 object.c                 | 61 ++++++++++++++++--------------
 object.h                 | 12 ++++--
 packfile.c               |  2 +-
 parse-options-cb.c       |  2 +-
 pretty.c                 |  4 +-
 reachable.c              |  8 ++--
 ref-filter.c             | 12 ++++--
 reflog-walk.c            |  3 +-
 refs.c                   |  2 +-
 refs/files-backend.c     |  2 +-
 remote.c                 | 19 ++++++----
 revision.c               | 26 ++++++-------
 sequencer.c              | 14 +++----
 server-info.c            |  4 +-
 sha1-file.c              |  4 +-
 sha1-name.c              | 33 +++++++++--------
 shallow.c                | 30 +++++++++------
 submodule.c              |  4 +-
 tag.c                    | 28 +++++++-------
 tag.h                    |  7 ++--
 tree.c                   | 19 +++++-----
 tree.h                   |  2 +-
 upload-pack.c            | 17 +++++----
 walker.c                 | 12 ++++--
 wt-status.c              |  2 +-
 81 files changed, 485 insertions(+), 358 deletions(-)

-- 
2.18.0.399.gad0ab374a1-goog

