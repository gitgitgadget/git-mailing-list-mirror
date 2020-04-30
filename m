Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215C0C4724C
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB3C20774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="HN+xFQvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgD3Tss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Tsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:48:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C449C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so391788pfa.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zHABMtSO+HkuOGmD9w0Q4DVklBXduWsS/Age8ky7Hio=;
        b=HN+xFQvyiOCKKRFEoOn6pM093Rp1Ca9RuFb21v5d1Q7+5eyKXrP1BvjP3MT55NxZMd
         LizZC2g4pyIf4XTAsKd/9E+zaeet1HKqON4lmIycObaeg/thZC1bGsrRkrvsRUNo7V3l
         T2jTp6N7nJN1aMUMdpibQwurWe/WJVDpRV584JMV7MPx9oVloig+dY7QUHBUEjf47EJU
         KJplQb5NpZIl4hc8rihuAqq1KgPOiAEyEFJyx/Xv7hXclDwcQxyZoHlesEny5hDYuP21
         r6QEojA+PbqH4aRZsbWQfRTDl8jiaMy8gpHQ5/IA+q8QdENJtSCpccwEejZqcvI9ahqo
         QY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zHABMtSO+HkuOGmD9w0Q4DVklBXduWsS/Age8ky7Hio=;
        b=mhJAEVl/0Clg8gbANEgoNYXafs7oMw0De63oVTxQvlIWi23axkSJD0ahx/WPDYLEGS
         6xi0h2bpL7ilFnN4YRzOf3xh9taXICik+xGDb4KzzqDV8RjGQi/LcFSskDxt/1OtOxrm
         Z7+VNxHxGxlzXr/u36pEEp2/q6xJ90Wzzu1C1Z3ijzVzl6zK2J9WyaBPULOPjR4IsL/G
         593ORFq3ACNy5lYBNDhDkea61zwdK/hugQGjUlkCfvD9CJcIO0tsjSVyPdCdveuI8OqZ
         9PREF3KBq9deOlNREz5pxQ/Stc3ZZcUgK2ZxEif0tFjYkGeLMNKs72BOwtmqgwenM1Pr
         uJ5A==
X-Gm-Message-State: AGi0PuZRylezTDUDBIYM0He4DOz2RNBYTmDesHxC+7AirMKWUWAq9LeJ
        nlCurjZ5s+7Dn1tSMZsOh2P4hGS41q8r4Q==
X-Google-Smtp-Source: APiQypInD/u9fFGRCbGGUiYazwVHVSG8OgR7RGVuRwOtqAstDRjqKmGWPYgozknom4VxzJOS/O9W5A==
X-Received: by 2002:a63:9d8c:: with SMTP id i134mr575092pgd.152.1588276125433;
        Thu, 30 Apr 2020 12:48:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e196sm503654pfh.43.2020.04.30.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:48:44 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:48:43 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 0/4] shallow: extract a header file
Message-ID: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a reroll of my series to introduce 'shallow.h' after some very
helpful review from yesterday evening and early this morning.

Not a ton has changed since last time, but here are the main points. A
range-diff since v1 is included below for a more detailed look at the
changes.

  * The #include in 'builtin.h' was dropped and instead the burden of
    including 'shallow.h' falls on the callers. Six builtins needed to
    be updated to include 'shallow.h', so this seems a net positive for
    the others that don't need to include it.

  * Comments were updated in the final two patches for increased
    readability and helpfulness.

  * The third patch was folded into the second patch to make the
    refactoring occur in a single step.

  * A comment was added to 'commit_graft_pos' to indicate what position
    is being returned.

Like last time, this is based on my earlier series 'tb/reset-shallow',
which should be on master shortly (perhaps in the next push-out? Not
sure.).

Thanks in advance for a re-review :).

Taylor Blau (4):
  commit: make 'commit_graft_pos' non-static
  shallow: extract a header file for shallow-related functions
  shallow.h: document '{commit,rollback}_shallow_file'
  shallow: use struct 'shallow_lock' for additional safety

 builtin/fetch.c        |  1 +
 builtin/pack-objects.c |  1 +
 builtin/prune.c        |  1 +
 builtin/receive-pack.c |  3 +-
 builtin/repack.c       |  1 +
 builtin/rev-parse.c    |  1 +
 commit-graph.c         |  1 +
 commit.c               | 16 ++-------
 commit.h               | 49 +------------------------
 environment.c          |  1 +
 fetch-pack.c           |  3 +-
 git.c                  |  1 +
 send-pack.c            |  1 +
 shallow.c              | 36 +++++++++++++------
 shallow.h              | 81 ++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c          |  1 +
 16 files changed, 123 insertions(+), 75 deletions(-)
 create mode 100644 shallow.h

Range-diff against v1:
1:  8ac4c63735 = 1:  cb8dde2ae2 commit: make 'commit_graft_pos' non-static
2:  8ee7ed0666 < -:  ---------- shallow: take 'unregister_shallow' from 'commit.c'
3:  3fb71045b6 ! 2:  0631e2a87d shallow: extract a header file for shallow-related functions
    @@ Commit message
         But, now there are a good number of shallow-related functions, and
         placing them all in 'commit.h' doesn't make sense.

    -    This patch extracts a 'shallow.h', which takes all of the headers from
    -    'commit.h' for functions which already exist in 'shallow.c'. We will
    -    bring the remaining shallow-related functions defined in 'commit.c' in a
    -    subsequent patch.
    +    This patch extracts a 'shallow.h', which takes all of the declarations
    +    from 'commit.h' for functions which already exist in 'shallow.c'. We
    +    will bring the remaining shallow-related functions defined in 'commit.c'
    +    in a subsequent patch.

         For now, move only the ones that already are implemented in 'shallow.c',
         and update the necessary includes.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    - ## builtin.h ##
    + ## builtin/fetch.c ##
     @@
    - #include "strbuf.h"
    - #include "cache.h"
    - #include "commit.h"
    + #include "branch.h"
    + #include "promisor-remote.h"
    + #include "commit-graph.h"
     +#include "shallow.h"

    - /*
    -  * builtin API
    + #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
    +
    +
    + ## builtin/pack-objects.c ##
    +@@
    + #include "dir.h"
    + #include "midx.h"
    + #include "trace2.h"
    ++#include "shallow.h"
    +
    + #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
    + #define SIZE(obj) oe_size(&to_pack, obj)
    +
    + ## builtin/prune.c ##
    +@@
    + #include "parse-options.h"
    + #include "progress.h"
    + #include "object-store.h"
    ++#include "shallow.h"
    +
    + static const char * const prune_usage[] = {
    + 	N_("git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"),
    +
    + ## builtin/receive-pack.c ##
    +@@
    + #include "protocol.h"
    + #include "commit-reach.h"
    + #include "worktree.h"
    ++#include "shallow.h"
    +
    + static const char * const receive_pack_usage[] = {
    + 	N_("git receive-pack <git-dir>"),
    +
    + ## builtin/repack.c ##
    +@@
    + #include "packfile.h"
    + #include "object-store.h"
    + #include "promisor-remote.h"
    ++#include "shallow.h"
    +
    + static int delta_base_offset = 1;
    + static int pack_kept_objects = -1;
    +
    + ## builtin/rev-parse.c ##
    +@@
    + #include "split-index.h"
    + #include "submodule.h"
    + #include "commit-reach.h"
    ++#include "shallow.h"
    +
    + #define DO_REVS		1
    + #define DO_NOREV	2

      ## commit-graph.c ##
     @@
    @@ commit.c

      static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);

    +@@ commit.c: int for_each_commit_graft(each_commit_graft_fn fn, void *cb_data)
    + 	return ret;
    + }
    +
    +-int unregister_shallow(const struct object_id *oid)
    +-{
    +-	int pos = commit_graft_pos(the_repository, oid->hash);
    +-	if (pos < 0)
    +-		return -1;
    +-	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
    +-		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
    +-			   the_repository->parsed_objects->grafts + pos + 1,
    +-			   the_repository->parsed_objects->grafts_nr - pos - 1);
    +-	the_repository->parsed_objects->grafts_nr--;
    +-	return 0;
    +-}
    +-
    + struct commit_buffer {
    + 	void *buffer;
    + 	unsigned long size;

      ## commit.h ##
     @@ commit.h: struct commit *get_fork_point(const char *refname, struct commit *commit);
    @@ fetch-pack.c
      static int transfer_unpack_limit = -1;
      static int fetch_unpack_limit = -1;

    + ## git.c ##
    +@@
    + #include "help.h"
    + #include "run-command.h"
    + #include "alias.h"
    ++#include "shallow.h"
    +
    + #define RUN_SETUP		(1<<0)
    + #define RUN_SETUP_GENTLY	(1<<1)
    +
      ## send-pack.c ##
     @@
      #include "sha1-array.h"
    @@ shallow.c

      void set_alternate_shallow_file(struct repository *r, const char *path, int override)
      {
    +@@ shallow.c: int register_shallow(struct repository *r, const struct object_id *oid)
    + 	return register_commit_graft(r, graft, 0);
    + }
    +
    ++int unregister_shallow(const struct object_id *oid)
    ++{
    ++	int pos = commit_graft_pos(the_repository, oid->hash);
    ++	if (pos < 0)
    ++		return -1;
    ++	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
    ++		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
    ++			   the_repository->parsed_objects->grafts + pos + 1,
    ++			   the_repository->parsed_objects->grafts_nr - pos - 1);
    ++	the_repository->parsed_objects->grafts_nr--;
    ++	return 0;
    ++}
    ++
    + int is_repository_shallow(struct repository *r)
    + {
    + 	FILE *fp;

      ## shallow.h (new) ##
     @@
4:  ff3620d50c < -:  ---------- shallow.h: document '{commit,rollback}_shallow_file'
-:  ---------- > 3:  c251cf3ef9 shallow.h: document '{commit,rollback}_shallow_file'
5:  839d5d0d8e ! 4:  08d8a915a0 shallow: use struct 'shallow_lock' for additional safety
    @@ Commit message
         callers to use it.

         Suggested-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/receive-pack.c ##
    @@ shallow.c: static void reset_repository_shallow(struct repository *r)
     +int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
      {
     -	int res = commit_lock_file(lk);
    -+	int res = commit_lock_file(&lk->lk);
    ++	int res = commit_lock_file(&lk->lock);
      	reset_repository_shallow(r);
      	return res;
      }
    @@ shallow.c: static void reset_repository_shallow(struct repository *r)
     +void rollback_shallow_file(struct repository *r, struct shallow_lock *lk)
      {
     -	rollback_lock_file(lk);
    -+	rollback_lock_file(&lk->lk);
    ++	rollback_lock_file(&lk->lock);
      	reset_repository_shallow(r);
      }

    @@ shallow.c: const char *setup_temporary_shallow(const struct oid_array *extra)
      	int fd;

     -	fd = hold_lock_file_for_update(shallow_lock,
    -+	fd = hold_lock_file_for_update(&shallow_lock->lk,
    ++	fd = hold_lock_file_for_update(&shallow_lock->lock,
      				       git_path_shallow(the_repository),
      				       LOCK_DIE_ON_ERROR);
      	check_shallow_file_for_update(the_repository);
    @@ shallow.c: const char *setup_temporary_shallow(const struct oid_array *extra)
      			die_errno("failed to write to %s",
     -				  get_lock_file_path(shallow_lock));
     -		*alternate_shallow_file = get_lock_file_path(shallow_lock);
    -+				  get_lock_file_path(&shallow_lock->lk));
    -+		*alternate_shallow_file = get_lock_file_path(&shallow_lock->lk);
    ++				  get_lock_file_path(&shallow_lock->lock));
    ++		*alternate_shallow_file = get_lock_file_path(&shallow_lock->lock);
      	} else
      		/*
      		 * is_repository_shallow() sees empty string as "no
    @@ shallow.c: void prune_shallow(unsigned options)
      		return;
      	}
     -	fd = hold_lock_file_for_update(&shallow_lock,
    -+	fd = hold_lock_file_for_update(&shallow_lock.lk,
    ++	fd = hold_lock_file_for_update(&shallow_lock.lock,
      				       git_path_shallow(the_repository),
      				       LOCK_DIE_ON_ERROR);
      	check_shallow_file_for_update(the_repository);
    @@ shallow.c: void prune_shallow(unsigned options)
      		if (write_in_full(fd, sb.buf, sb.len) < 0)
      			die_errno("failed to write to %s",
     -				  get_lock_file_path(&shallow_lock));
    -+				  get_lock_file_path(&shallow_lock.lk));
    ++				  get_lock_file_path(&shallow_lock.lock));
      		commit_shallow_file(the_repository, &shallow_lock);
      	} else {
      		unlink(git_path_shallow(the_repository));
    @@ shallow.h: void set_alternate_shallow_file(struct repository *r, const char *pat
      int is_repository_shallow(struct repository *r);
     +
     +/*
    -+ * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
    -+ * which locks can be used with '{commit,rollback}_shallow_file()'.
    ++ * Lock for updating the $GIT_DIR/shallow file.
    ++ *
    ++ * Use `commit_shallow_file()` to commit an update, or
    ++ * `rollback_shallow_file()` to roll it back. In either case, any
    ++ * in-memory cached information about which commits are shallow will be
    ++ * appropriately invalidated so that future operations reflect the new
    ++ * state.
     + */
     +struct shallow_lock {
    -+	struct lock_file lk;
    ++	struct lock_file lock;
     +};
     +#define SHALLOW_LOCK_INIT { LOCK_INIT }
     +
    - /*
    -  * {commit,rollback}_shallow_file commits or performs a rollback to the
    -  * '.git/shallow' file, respectively, and resets stat-validity checks.
    -  */
    + /* commit $GIT_DIR/shallow and reset stat-validity checks */
     -int commit_shallow_file(struct repository *r, struct lock_file *lk);
    --void rollback_shallow_file(struct repository *r, struct lock_file *lk);
     +int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
    + /* rollback $GIT_DIR/shallow and reset stat-validity checks */
    +-void rollback_shallow_file(struct repository *r, struct lock_file *lk);
     +void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);

      struct commit_list *get_shallow_commits(struct object_array *heads,
--
2.26.0.113.ge9739cdccc
