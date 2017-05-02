Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A1D207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdEBWXb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:31 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33597 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdEBWXa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:30 -0400
Received: by mail-pg0-f52.google.com with SMTP id y4so62825281pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=encsuYonZqXm6lZqaYUlVuk+gvsMkJLhegU5ZC1Lk+k=;
        b=I56b1hbL6swweifqCv8XTO+vZ+vsdCxA1ois8Qd8XdXLF9NC6yjZOdwMiQTeQsTxKo
         6fQgwPfsqR1hbvGFpX1VF2nSD2U5OtA7YdTI4x/GqNrEPIDtLfyiupwVzKkVTfTa6d33
         UcYJNVBAwRE6YNrBmumEUeEPkmmUFBJ91/ZuCWGgmawVTxOh1YHocqpzn06Prl3dW+88
         9gO9yWNY9WHYMLs8YPgOY/MkwQ/SJ3AlFAs0v67dOHC504HC2Y1XUSqw9b3EZ2dYfjoD
         y8iBCBXjgqSWn2L79IUpjoNCldXW5m9NIMeNIL62LMgBRK3XTJGj5O7BCisVe9ObK5WO
         CJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=encsuYonZqXm6lZqaYUlVuk+gvsMkJLhegU5ZC1Lk+k=;
        b=cczeykXwpvYXJr23c9/5WzBN2jB0rxcvgysOsRuno+Xs1yUqbSFKiP0LMsq7Bm9sDu
         IEH4EOKlYGGn8Tc+LfWNlvCDWLlfyejM6YR91cjd1FVIYfr9lEeuDYJRqhqABS2J0mAg
         YtNA4lZGf563PPyZPWqRR+Xevh085DLDts1/NLlznFQRdBP7hueplgEsYddscJcfw0AP
         PsfbfM0xvwBoLS4iee+pT1bIv6wv84Qi2bt1a/wrvkGIwqr/oAavgtB+2KUj8V3O/qVY
         tkPkyFl0xqDRX6V8XJLXzJHDhwSpkTKjwLn6ueQYZmfbxWKT31wPq9byFcmZCEpR5l/h
         BtGA==
X-Gm-Message-State: AN3rC/5rGnBzW/YvyqG93bliXb4mCGrPV+l+S7TeDGmKC3pSOkXfHELt
        MOjer34J81FH6TkC
X-Received: by 10.98.141.216 with SMTP id p85mr1333402pfk.195.1493763809118;
        Tue, 02 May 2017 15:23:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id b74sm697420pfl.58.2017.05.02.15.23.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/24] Retire NO_THE_INDEX_COMPATIBILITY_MACROS
Date:   Tue,  2 May 2017 15:22:58 -0700
Message-Id: <20170502222322.21055-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the follow up to [1], but actually completed now.

The reasoning why this series is a good idea is in the commit message of the
last patch, quoted here:

The NO_THE_INDEX_COMPATIBILITY_MACROS pre processor setting was introduced
in 4aab5b46f4 (Make read-cache.c "the_index" free., 2007-04-01), stating:

    This makes all low-level functions defined in read-cache.c to
    take an explicit index_state structure as their first parameter,
    to specify which index to work on.

The reasoning is very vague, maybe indicating that having the index
specified to work on is easier to for the new reader to understand what
is going on.

All preceding patches worked on retiring functions that do not take an
explicit index as to where to perform its work. Spelling out the reasons
why we want to specify the index at each call:

1)  Ease of understanding:
   The recent patches dropped a lot of macros that may confuse new people
   diving into the code base.
2a) Spelling out global state explicitly:
   Anything you do in submodule land today needs to spawn new processes in
   the submodule. This is cumbersome and not performant. So we may want to
   have an abstraction of a repo, i.e. all repository state in one struct.
   That way we can open a submodule in-process and perform the required
   actions without spawning a process. The road to this future is a long
   road, and we have to start somewhere. Exposing the global state seems
   like a good starter point.
2b) Spelling out global state explicitly (II): (Jeff Hostetler wrote)
   In addition to (eventually) allowing multiple repos be open at the same
   time for submodules, it would also help with various multi-threading
   efforts.  For example, we have loops that do a
   "for (k = 0, k < active_nr; k++) {...}"  There is no visual clue in that
   code that it references "the_index" and therefore should be subject to
   the same locking.  Granted, this is a trivial example, but goes to the
   argument that the code has lots of subtle global variables and macros
   that make it difficult to reason about the code.

   This step would help un-hide this.
   

Review as well as critique if this is the right approach to an endgame with
less globals splattered throughout the codebase is welcome.

Thanks,
Stefan

[1] https://public-inbox.org/git/20170501190719.10669-1-sbeller@google.com/

Stefan Beller (24):
  cache.h: drop read_cache()
  cache.h: drop active_* macros
  cache.h: drop read_cache_from
  cache.h: drop read_cache_preload(pathspec)
  cache.h: drop read_cache_unmerged()
  unpack-trees.c: rename parameter 'the_index'
  cache.h: drop read_blob_data_from_cache
  cache.h: drop unmerge_cache[_entry_at]
  cache.h: drop resolve_undo_clear
  cache.h: drop cache_name_is_other
  cache.h: drop cache_file_exists
  cache.h: drop cache_dir_exists
  cache.h: drop is_cache_unborn(), discard_cache(), unmerged_cache()
  cache.h: drop cache_name_pos
  cache.h: drop add_cache_entry
  cache.h: drop rename_cache_entry_at
  cache.h: drop remove_file_from_cache
  cache.h: drop add_to_cache
  cache.h: drop add_file_to_cache
  cache.h: drop chmod_cache_entry
  cache.h: drop refresh_cache
  cache.h: drop ce_modified
  cache.h: drop ce_match_stat
  cache.h: retire NO_THE_INDEX_COMPATIBILITY_MACROS

 apply.c                              | 32 +++++++------
 attr.c                               |  1 -
 builtin/add.c                        | 12 ++---
 builtin/am.c                         | 26 +++++------
 builtin/blame.c                      | 19 ++++----
 builtin/check-attr.c                 |  2 +-
 builtin/check-ignore.c               |  4 +-
 builtin/checkout-index.c             | 12 ++---
 builtin/checkout.c                   | 66 +++++++++++++-------------
 builtin/clean.c                      |  4 +-
 builtin/commit.c                     | 52 ++++++++++-----------
 builtin/describe.c                   |  2 +-
 builtin/diff-files.c                 |  4 +-
 builtin/diff-index.c                 |  6 +--
 builtin/diff.c                       | 19 ++++----
 builtin/fsck.c                       | 14 +++---
 builtin/grep.c                       | 10 ++--
 builtin/ls-files.c                   | 49 +++++++++----------
 builtin/merge-index.c                | 14 +++---
 builtin/merge.c                      | 24 +++++-----
 builtin/mv.c                         | 22 ++++-----
 builtin/pull.c                       |  4 +-
 builtin/read-tree.c                  |  8 ++--
 builtin/reset.c                      | 11 +++--
 builtin/rev-parse.c                  |  2 +-
 builtin/rm.c                         | 26 +++++------
 builtin/submodule--helper.c          | 10 ++--
 builtin/update-index.c               | 91 +++++++++++++++++++-----------------
 cache.h                              | 35 --------------
 check-racy.c                         | 10 ++--
 convert.c                            |  4 +-
 diff-lib.c                           |  8 ++--
 diff.c                               | 14 +++---
 dir.c                                | 41 ++++++++--------
 entry.c                              |  3 +-
 merge-recursive.c                    | 65 +++++++++++++-------------
 merge.c                              |  8 ++--
 name-hash.c                          |  1 -
 pathspec.c                           | 16 +++----
 read-cache.c                         |  5 +-
 rerere.c                             | 38 +++++++--------
 revision.c                           | 22 ++++-----
 sequencer.c                          | 29 ++++++------
 sha1_name.c                          | 22 ++++-----
 submodule.c                          | 20 ++++----
 t/helper/test-dump-cache-tree.c      |  4 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-lazy-init-name-hash.c  | 20 ++++----
 t/helper/test-read-cache.c           |  4 +-
 t/helper/test-scrap-cache-tree.c     |  4 +-
 t/t2107-update-index-basic.sh        |  2 +-
 tree.c                               | 10 ++--
 unpack-trees.c                       |  9 ++--
 wt-status.c                          | 24 +++++-----
 54 files changed, 471 insertions(+), 495 deletions(-)

-- 
2.13.0.rc1.39.ga6db8bfa24

