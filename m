Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3343F1F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeEQWwK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:52:10 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:40049 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeEQWwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:52:09 -0400
Received: by mail-pg0-f52.google.com with SMTP id l2-v6so2436047pgc.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQjikV/t6/BU4P5F9xxZLpe1tdny0deJjGQVFpHMNBs=;
        b=kdMxVdLTJp/7hmr7baYfa0y4v/6svkU4BjrIDUq/qCVFyi+O19lFqr6+TjLTBD6Wt8
         79FYxxAm2+OGWK3F5+veF7bQ92PNTO5ZRfSkz1GkqPcb4RO3OUhXZ5AjcLCdY9OlXsAr
         ZhKwCDsmgsIJVVaUlUVO4hNAzHckt0qbPQ/01pn2oL2E7OVJD3FADlYLRuZ+SAjZFbHr
         qI6xqvGLOBMMYBWY+RoKTjT4JGwNUb2yGy5Wr2fBRGV9R9m7hAghkCh0Wx0B9a8K+9ls
         5LURC5pe+2RWCQD8g5Aru7ZLB87rPCuEPHp+jxWt1LC/US0XOCEh1THj7B+fmDiSIfCH
         mqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQjikV/t6/BU4P5F9xxZLpe1tdny0deJjGQVFpHMNBs=;
        b=PYfLKx8hlk/J6pqHJWFDUo2Lmo9rBkiK3FSY5f2l9KKu/scm7S5b9R15keb60PzOXK
         s4oDGBD8XHs0I5SX7SzBc58sNR+01BTxrL8iX0+lKmYJyi6+eFI6Zr6gb3yadlLDc9Fi
         ZH6dWZ2zV8bA3yUfN+POg91D6dGke7e13WDcCm1EcXXSY4xY19MhdMAAdhmj+QCAx/gn
         ErYxU6uJIJDm5MqilAc23lDE5hXcGK7j4FmuaCnNBsZ8Bg0Tc1/G0+0YeJEk6cDK6c2+
         z10qVmFRcApHmF4TFNAE+0Gfi7sGb7XLPp+DlMMZsXU7g33Oa+VtJKGo09j14N9fu0N/
         JgWw==
X-Gm-Message-State: ALKqPwex+EOSzMenHz6VeMUVKfh4iGf77/ZTgCkqnGuBOfcYPbCpceHt
        7GtCGLFO5+4eiQgFJfKICAYc7w==
X-Google-Smtp-Source: AB8JxZqKRwXQm4BPuKJPxdEcue7qaR8RDnfyESlfKm5LSsLfJ5lpWcMIncAYsHqpNV/0om+GmFW7vQ==
X-Received: by 2002:a63:8849:: with SMTP id l70-v6mr5545421pgd.49.1526597528208;
        Thu, 17 May 2018 15:52:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l63-v6sm11087904pfi.6.2018.05.17.15.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:52:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Subject: [PATCH 00/19] object store: grafts and shallow.
Date:   Thu, 17 May 2018 15:51:35 -0700
Message-Id: <20180517225154.9200-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180515234233.143708-1-sbeller@google.com>
References: <20180515234233.143708-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1:

This reroll:
* includes the fixup by Ramsay
  http://public-inbox.org/git/ae96f1c4-add2-d9d8-f08b-a765fe277232@ramsayjones.plus.com
* fixes commit messages
* changes the macro for the global git_path definitions such that we need fewer
  characters (omits the duplicates "path_" that were the same for every function)
* the range diff is below
  (per https://public-inbox.org/git/20180508034815.GB7242@sigill.intra.peff.net/)

Thanks,
Stefan

v0/RFC:
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
  path.c: migrate global git_path_* to take a repository argument
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
 94 files changed, 449 insertions(+), 315 deletions(-)

-- 
2.17.0.582.gccdcbd54c44.dirty

1:  cbd53a2193d = 1:  20b6bef31b7 object-store: move object access functions to object-store.h
2:  6a1a79fd146 = 2:  6855b203842 object: move grafts to object parser
3:  be479e801da = 3:  0afdfac30da commit: add repository argument to commit_graft_pos
4:  3f5787f8066 = 4:  af84c3bc1dd commit: add repository argument to register_commit_graft
5:  02ba3e1a057 = 5:  154ec8bacc1 commit: add repository argument to read_graft_file
6:  3ee37656ee6 = 6:  c12bd3a7870 commit: add repository argument to prepare_commit_graft
7:  e6c898f460c ! 7:  aef9cd4ffba commit: add repository argument to lookup_commit_graft
    @@ -10,9 +10,6 @@
         As with the previous commits, use a macro to catch callers passing a
         repository other than the_repository at compile time.
     
    -    The included coccinelle semantic patch will adapt any new callers in
    -    the diff produced by `make coccicheck`.
    -
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
8:  f95ee308eb7 ! 8:  0025ae11097 shallow: add repository argument to set_alternate_shallow_file
    @@ -2,8 +2,15 @@
     
         shallow: add repository argument to set_alternate_shallow_file
     
    +    Add a repository argument to allow callers of set_alternate_shallow_file
    +    to be more specific about which repository to handle. This is a small
    +    mechanical change; it doesn't change the implementation to handle
    +    repositories other than the_repository yet.
    +
    +    As with the previous commits, use a macro to catch callers passing a
    +    repository other than the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.h b/commit.h
     --- a/commit.h
9:  11948c4278a ! 9:  3ee6c801d16 shallow: add repository argument to register_shallow
    @@ -2,8 +2,15 @@
     
         shallow: add repository argument to register_shallow
     
    +    Add a repository argument to allow callers of register_shallow
    +    to be more specific about which repository to handle. This is a small
    +    mechanical change; it doesn't change the implementation to handle
    +    repositories other than the_repository yet.
    +
    +    As with the previous commits, use a macro to catch callers passing a
    +    repository other than the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
     --- a/builtin/pack-objects.c
10:  c69182008bd ! 10:  f0d9eb428ef shallow: add repository argument to check_shallow_file_for_update
    @@ -2,8 +2,15 @@
     
         shallow: add repository argument to check_shallow_file_for_update
     
    +    Add a repository argument to allow callers of check_shallow_file_for_update
    +    to be more specific about which repository to handle. This is a small
    +    mechanical change; it doesn't change the implementation to handle
    +    repositories other than the_repository yet.
    +
    +    As with the previous commits, use a macro to catch callers passing a
    +    repository other than the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/shallow.c b/shallow.c
     --- a/shallow.c
11:  2194490111e ! 11:  5ba578b5386 shallow: add repository argument to is_repository_shallow
    @@ -2,8 +2,15 @@
     
         shallow: add repository argument to is_repository_shallow
     
    +    Add a repository argument to allow callers of is_repository_shallow
    +    to be more specific about which repository to handle. This is a small
    +    mechanical change; it doesn't change the implementation to handle
    +    repositories other than the_repository yet.
    +
    +    As with the previous commits, use a macro to catch callers passing a
    +    repository other than the_repository at compile time.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/builtin/fetch.c b/builtin/fetch.c
     --- a/builtin/fetch.c
12:  7560733756e ! 12:  8432e847c05 commit: convert commit_graft_pos() to handle arbitrary repositories
    @@ -4,7 +4,6 @@
     
         Signed-off-by: Brandon Williams <bmwill@google.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
13:  12a4071c6a5 ! 13:  8763c86af52 commit: convert register_commit_graft to handle arbitrary repositories
    @@ -4,7 +4,6 @@
     
         Signed-off-by: Brandon Williams <bmwill@google.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
14:  a333e619158 ! 14:  2eea80787c6 commit: convert read_graft_file to handle arbitrary repositories
    @@ -4,7 +4,6 @@
     
         Signed-off-by: Brandon Williams <bmwill@google.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
15:  5c8f9317393 ! 15:  4f41b5cc4e8 cache: convert get_graft_file to handle arbitrary repositories
    @@ -2,6 +2,10 @@
     
         cache: convert get_graft_file to handle arbitrary repositories
     
    +    This conversion was done without the #define trick used in the earlier
    +    series refactoring to have better repository access, because this function
    +    is easy to review, as all lines are converted and it has only one caller.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
16:  adbe83bff1f ! 16:  77cc05fde8a path.c: migrate git_path_ to take a repository argument
    @@ -1,6 +1,14 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    path.c: migrate git_path_ to take a repository argument
    +    path.c: migrate global git_path_* to take a repository argument
    +
    +    Migrate all git_path_* functions that are defined in path.c to take a
    +    repository argument. Unlike other patches in this series, do not use the
    +     #define trick, as we rewrite the whole function, which is rather small.
    +
    +    This doesn't migrate all the functions, as other builtins have their own
    +    local path functions defined using GIT_PATH_FUNC. So keep that macro
    +    around to serve the other locations.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ -374,15 +382,15 @@
     -GIT_PATH_FUNC(git_path_merge_head, "MERGE_HEAD")
     -GIT_PATH_FUNC(git_path_fetch_head, "FETCH_HEAD")
     -GIT_PATH_FUNC(git_path_shallow, "shallow")
    -+REPO_GIT_PATH_FUNC(path_cherry_pick_head, "CHERRY_PICK_HEAD")
    -+REPO_GIT_PATH_FUNC(path_revert_head, "REVERT_HEAD")
    -+REPO_GIT_PATH_FUNC(path_squash_msg, "SQUASH_MSG")
    -+REPO_GIT_PATH_FUNC(path_merge_msg, "MERGE_MSG")
    -+REPO_GIT_PATH_FUNC(path_merge_rr, "MERGE_RR")
    -+REPO_GIT_PATH_FUNC(path_merge_mode, "MERGE_MODE")
    -+REPO_GIT_PATH_FUNC(path_merge_head, "MERGE_HEAD")
    -+REPO_GIT_PATH_FUNC(path_fetch_head, "FETCH_HEAD")
    -+REPO_GIT_PATH_FUNC(path_shallow, "shallow")
    ++REPO_GIT_PATH_FUNC(cherry_pick_head, "CHERRY_PICK_HEAD")
    ++REPO_GIT_PATH_FUNC(revert_head, "REVERT_HEAD")
    ++REPO_GIT_PATH_FUNC(squash_msg, "SQUASH_MSG")
    ++REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
    ++REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
    ++REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
    ++REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
    ++REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
    ++REPO_GIT_PATH_FUNC(shallow, "shallow")
     
     diff --git a/path.h b/path.h
     --- a/path.h
    @@ -401,7 +409,7 @@
     -const char *git_path_fetch_head(void);
     -const char *git_path_shallow(void);
     +#define REPO_GIT_PATH_FUNC(var, filename) \
    -+	const char *git_##var(struct repository *r) \
    ++	const char *git_path_##var(struct repository *r) \
     +	{ \
     +		if (!r->cached_paths.var) \
     +			r->cached_paths.var = git_pathdup(filename); \
    @@ -409,15 +417,15 @@
     +	}
     +
     +struct path_cache {
    -+	const char *path_cherry_pick_head;
    -+	const char *path_revert_head;
    -+	const char *path_squash_msg;
    -+	const char *path_merge_msg;
    -+	const char *path_merge_rr;
    -+	const char *path_merge_mode;
    -+	const char *path_merge_head;
    -+	const char *path_fetch_head;
    -+	const char *path_shallow;
    ++	const char *cherry_pick_head;
    ++	const char *revert_head;
    ++	const char *squash_msg;
    ++	const char *merge_msg;
    ++	const char *merge_rr;
    ++	const char *merge_mode;
    ++	const char *merge_head;
    ++	const char *fetch_head;
    ++	const char *shallow;
     +};
     +
     +#define PATH_CACHE_INIT { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL }
17:  d73b49b7078 ! 17:  d9b50420d32 shallow: migrate shallow information into the object parser
    @@ -2,8 +2,10 @@
     
         shallow: migrate shallow information into the object parser
     
    +    We need to convert the shallow functions all at the same time
    +    as we move the data structures they operate on into the repository.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.h b/commit.h
     --- a/commit.h
    @@ -72,8 +74,7 @@
     -static int is_shallow = -1;
     -static struct stat_validity shallow_stat;
     -static char *alternate_shallow_file;
    -+struct stat_validity the_repository_shallow_stat;
    - 
    +-
     -void set_alternate_shallow_file_the_repository(const char *path, int override)
     +void set_alternate_shallow_file(struct repository *r, const char *path, int override)
      {
18:  cede061c90f ! 18:  0458d3b9fac commit: allow prepare_commit_graft to handle arbitrary repositories
    @@ -2,8 +2,11 @@
     
         commit: allow prepare_commit_graft to handle arbitrary repositories
     
    +    Move the global variable 'commit_graft_prepared' into the object
    +    pool and convert the function prepare_commit_graft to work
    +    an arbitrary repositories.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
19:  7dc1693a492 ! 19:  39c2ddce2e1 commit: allow lookup_commit_graft to handle arbitrary repositories
    @@ -3,7 +3,6 @@
         commit: allow lookup_commit_graft to handle arbitrary repositories
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/commit.c b/commit.c
     --- a/commit.c
