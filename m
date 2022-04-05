Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99274C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiDEFWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDEFWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:22:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8324710D7
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:20:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso1533416pjj.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8RYEpZJoIRB0B1faz9cuSmw4Lx+0ZnqBzGSu10tOlE=;
        b=HVP6uCT3FQSUOxV/7QNQGg8SMefzoLFOeEWPUOCRFXeI+WBRHNEa8DZBy5kkcBKlie
         5BqUf21i1OhO1LWMcJG928zf4Duc9tka76ETqdOGvzNTamo3VqmKmKjCs8LkROagkU/5
         J90fPxp4w+lUEJ2REnwMX1tADCp9/9prI6DX7hIRGNIPUkZNwJJ4f2LK03uQm+hGEcvN
         APd9g42RhHua1sHZoq1S/mbpy3P1K+FBlJgP8sSoV2q7V5/g/6wmHrMHZumrUJjzP+Nb
         evyZmmaPewPoGpwiungu4yYwS6yNO/ULbbye6Zcu0tfs2LRTcJbLRjjHn2JRlzuAe39i
         h8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8RYEpZJoIRB0B1faz9cuSmw4Lx+0ZnqBzGSu10tOlE=;
        b=0d3OMJ3Zxun672NgVG5ldErd05jAIYOW+0t0rvuNsRs6OgGh9whzPetz/+xl+xUCwp
         GoQBD7YRAlXtD03i95QayPTE0YUs8xWwdw/XHALXPHK9tWzNRnbsly4lueR2y4wHJmH3
         mA9cML61fGPo0i9uJtCc+ysqTyjkq4FtpGlWoq0+adnUzBi5WXCcnUDn9lSW98pDS338
         Jh369NXtS3f3ykxSMulfVbqXXIPmtd8Hx3xNZe3xDbUyYPH69wZoJsINctjXNLD/475Q
         BB2ReiWF+AgSqBHpXF/I3ZmkOZF5GUx4+Xl4jn80BZB7oCRUsuUS0/vE4Laks5Hio2sM
         f0uw==
X-Gm-Message-State: AOAM532q4t9jWOC1ZAKdfZcoYplwK79q3LOTr6NKrgOI+cNrIigF4ajJ
        rl2hbRN2gQuGx8jlYkEDSLI=
X-Google-Smtp-Source: ABdhPJwrguh9j+thO3geUxhBdRxuzdTVYUWuTKd5JjmJS9BMJ3wpOXSih53bcTODJ1h4TyKE8avPIQ==
X-Received: by 2002:a17:90a:4890:b0:1bf:654e:e1a0 with SMTP id b16-20020a17090a489000b001bf654ee1a0mr2104955pjh.113.1649136023776;
        Mon, 04 Apr 2022 22:20:23 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm808859pjk.8.2022.04.04.22.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:20:23 -0700 (PDT)
From:   nksingh85@gmail.com
X-Google-Original-From: neerajsi@microsoft.com
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        neerajsi@microsoft.com, nksingh85@gmail.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: [PATCH v6 00/12] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects 
Date:   Mon,  4 Apr 2022 22:20:06 -0700
Message-Id: <20220405052018.11247-1-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.34.1.78.g86e39b8f8d
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

GGG closed this series erroneously, so I'm trying out git-send-email. Apologies for any mistakes.

This series is also available at https://github.com/neerajsi-msft/git/git.git ns/batched-fsync-v6.

V6 changes:

* Based on master at faa21c1 to pick up ns/fsync-or-die-message-fix. Also resolved a conflict with 8aa0209 in t/perf/p7519-fsmonitor.sh.

* Some independent patches were submitted separately on-list. This series is now dependent on ns/fsync-or-die-message-fix.

* Rename bulk_checkin_state to bulk_checkin_packfile to discourage future authors from adding any non-packfile related stuff to it. Each individual component of bulk_checkin should have its own state variable(s) going forward, and they should only be tied together by odb_transaction_nesting.

* Rename finish_bulk_checkin and do_batch_fsync to flush_bulk_checkin and flush_batch_fsync. The "finish" step is going to be the end_odb_transaction. The "flush" terminology should be consistently used for making changes visible.

* Add flush_odb_transaction and use it in update-index before printing verbose output to mitigate risk of missing objects for a tricky stdin feeder.

* Re-add shell "local with assignment": now these are all on a separate line with quotes around any values, to comply with dash. I'm running on ubuntu 20.04 LTS where I saw some of the dash issues before.

Neeraj Singh (12):
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  core.fsyncmethod: batched disk flushes for loose-objects
  cache-tree: use ODB transaction around writing a tree
  builtin/add: add ODB transaction around add_files_to_cache
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  test-lib-functions: add parsing helpers for ls-files and ls-tree
  core.fsyncmethod: tests for batch mode
  t/perf: add iteration setup mechanism to perf-lib
  core.fsyncmethod: performance tests for batch mode

 Documentation/config/core.txt          |   8 ++
 builtin/add.c                          |  13 ++-
 builtin/unpack-objects.c               |   3 +
 builtin/update-index.c                 |  20 +++++
 bulk-checkin.c                         | 117 +++++++++++++++++++++----
 bulk-checkin.h                         |  27 +++++-
 cache-tree.c                           |   3 +
 cache.h                                |  12 ++-
 compat/mingw.h                         |   3 +
 config.c                               |   4 +-
 git-compat-util.h                      |   2 +
 object-file.c                          |   7 +-
 t/lib-unique-files.sh                  |  34 +++++++
 t/perf/p0008-odb-fsync.sh              |  82 +++++++++++++++++
 t/perf/p4220-log-grep-engines.sh       |   3 +-
 t/perf/p4221-log-grep-engines-fixed.sh |   3 +-
 t/perf/p5302-pack-index.sh             |  15 ++--
 t/perf/p7519-fsmonitor.sh              |  18 +---
 t/perf/p7820-grep-engines.sh           |   6 +-
 t/perf/perf-lib.sh                     |  63 +++++++++++--
 t/t3700-add.sh                         |  28 ++++++
 t/t3903-stash.sh                       |  20 +++++
 t/t5300-pack-object.sh                 |  41 ++++++---
 t/t5317-pack-objects-filter-objects.sh |  91 ++++++++++---------
 t/test-lib-functions.sh                |  10 +++
 25 files changed, 513 insertions(+), 120 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p0008-odb-fsync.sh

Range-diff against v5:
 1:  c7a2a7efe6d <  -:  ----------- bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 -:  ----------- >  1:  adabdaa0290 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 2:  d045b13795b !  2:  72a6cd36c9c bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
    @@ Commit message
         writing code can optimize their operations without caring whether the
         top-level code has a transaction active.
     
    +    Add a flush_odb_transaction API that will be used in update-index to
    +    make objects visible even if a transaction is active. The flush call may
    +    also be useful in future cases if we hold a transaction active around
    +    calling hooks.
    +
         Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
     
      ## builtin/add.c ##
    @@ bulk-checkin.c
     -static int bulk_checkin_plugged;
     +static int odb_transaction_nesting;
      
    - static struct bulk_checkin_state {
    + static struct bulk_checkin_packfile {
      	char *pack_tmp_name;
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
      {
    - 	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
    + 	int status = deflate_to_pack(&bulk_checkin_packfile, oid, fd, size, type,
      				     path, flags);
     -	if (!bulk_checkin_plugged)
     +	if (!odb_transaction_nesting)
    - 		finish_bulk_checkin(&bulk_checkin_state);
    + 		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
      	return status;
      }
      
    @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
      }
      
     -void unplug_bulk_checkin(void)
    -+void end_odb_transaction(void)
    ++void flush_odb_transaction(void)
      {
     -	assert(bulk_checkin_plugged);
     -	bulk_checkin_plugged = 0;
    + 	flush_bulk_checkin_packfile(&bulk_checkin_packfile);
    + }
    ++
    ++void end_odb_transaction(void)
    ++{
     +	odb_transaction_nesting -= 1;
     +	if (odb_transaction_nesting < 0)
     +		BUG("Unbalanced ODB transaction nesting");
    @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
     +	if (odb_transaction_nesting)
     +		return;
     +
    - 	if (bulk_checkin_state.f)
    - 		finish_bulk_checkin(&bulk_checkin_state);
    - }
    ++	flush_odb_transaction();
    ++}
     
      ## bulk-checkin.h ##
     @@ bulk-checkin.h: int index_bulk_checkin(struct object_id *oid,
    @@ bulk-checkin.h: int index_bulk_checkin(struct object_id *oid,
     +/*
     + * Tell the object database to optimize for adding
     + * multiple objects. end_odb_transaction must be called
    -+ * to make new objects visible.
    ++ * to make new objects visible. Transactions can be nested,
    ++ * and objects are only visible after the outermost transaction
    ++ * is complete or the transaction is flushed.
     + */
     +void begin_odb_transaction(void);
     +
     +/*
    ++ * Make any objects that are currently part of a pending object
    ++ * database transaction visible. It is valid to call this function
    ++ * even if no transaction is active.
    ++ */
    ++void flush_odb_transaction(void);
    ++
    ++/*
     + * Tell the object database to make any objects from the
    -+ * current transaction visible.
    ++ * current transaction visible if this is the final nested
    ++ * transaction.
     + */
     +void end_odb_transaction(void);
      
 3:  2d1bc4568ac <  -:  ----------- object-file: pass filename to fsync_or_die
 4:  9e7ae22fa4a !  3:  57539f104ef core.fsyncmethod: batched disk flushes for loose-objects
    @@ Documentation/config/core.txt: core.fsyncMethod::
     +  updates in the disk writeback cache and then does a single full fsync of
     +  a dummy file to trigger the disk cache flush at the end of the operation.
     ++
    -+  Currently `batch` mode only applies to loose-object files. Other repository
    -+  data is made durable as if `fsync` was specified. This mode is expected to
    -+  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
    -+  and on Windows for repos stored on NTFS or ReFS filesystems.
    ++Currently `batch` mode only applies to loose-object files. Other repository
    ++data is made durable as if `fsync` was specified. This mode is expected to
    ++be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
    ++and on Windows for repos stored on NTFS or ReFS filesystems.
      
      core.fsyncObjectFiles::
      	This boolean will enable 'fsync()' when writing object files.
    @@ bulk-checkin.c
      
     +static struct tmp_objdir *bulk_fsync_objdir;
     +
    - static struct bulk_checkin_state {
    + static struct bulk_checkin_packfile {
      	char *pack_tmp_name;
      	struct hashfile *f;
    -@@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin_state *state)
    +@@ bulk-checkin.c: static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
      	reprepare_packed_git(the_repository);
      }
      
     +/*
     + * Cleanup after batch-mode fsync_object_files.
     + */
    -+static void do_batch_fsync(void)
    ++static void flush_batch_fsync(void)
     +{
     +	struct strbuf temp_path = STRBUF_INIT;
     +	struct tempfile *temp;
    @@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin_state *state
     +	bulk_fsync_objdir = NULL;
     +}
     +
    - static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
    + static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
      {
      	int i;
    -@@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
    +@@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_packfile *state,
      	return 0;
      }
      
    @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
     +	 * If we have an active ODB transaction, we issue a call that
     +	 * cleans the filesystem page cache but avoids a hardware flush
     +	 * command. Later on we will issue a single hardware flush
    -+	 * before as part of do_batch_fsync.
    ++	 * before renaming the objects to their final names as part of
    ++	 * flush_batch_fsync.
     +	 */
     +	if (!bulk_fsync_objdir ||
     +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
    @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      int index_bulk_checkin(struct object_id *oid,
      		       int fd, size_t size, enum object_type type,
      		       const char *path, unsigned flags)
    -@@ bulk-checkin.c: void end_odb_transaction(void)
    +@@ bulk-checkin.c: void begin_odb_transaction(void)
      
    - 	if (bulk_checkin_state.f)
    - 		finish_bulk_checkin(&bulk_checkin_state);
    -+
    -+	do_batch_fsync();
    + void flush_odb_transaction(void)
    + {
    ++	flush_batch_fsync();
    + 	flush_bulk_checkin_packfile(&bulk_checkin_packfile);
      }
    + 
     
      ## bulk-checkin.h ##
     @@
 5:  83fa4a5f3a5 =  4:  f47631e6a28 cache-tree: use ODB transaction around writing a tree
 6:  d514842ad49 =  5:  08c9b234942 builtin/add: add ODB transaction around add_files_to_cache
 7:  8cac94598a5 !  6:  bc37cdbd226 update-index: use the bulk-checkin infrastructure
    @@ Commit message
         There is some risk with this change, since under batch fsync, the object
         files will be in a tmp-objdir until update-index is complete, so callers
         using the --stdin option will not see them until update-index is done.
    -    This risk is mitigated by not keeping an ODB transaction open around
    -    --stdin processing if in --verbose mode. Without --verbose mode,
    -    a caller feeding update-index via --stdin wouldn't know when
    -    update-index adds an object, event without an ODB transaction.
    +    This risk is mitigated by flushing the ODB transaction prior to
    +    reporting any verbose output so that objects will be visible to callers
    +    that are synchronizing with update-index by snooping its output.
     
         Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
     
    @@ builtin/update-index.c
      #include "config.h"
      #include "lockfile.h"
      #include "quote.h"
    +@@ builtin/update-index.c: static void report(const char *fmt, ...)
    + 	if (!verbose)
    + 		return;
    + 
    ++	/*
    ++	 * It is possible, though unlikely, that a caller could use the verbose
    ++	 * output to synchronize with addition of objects to the object
    ++	 * database. The current implementation of ODB transactions leaves
    ++	 * objects invisible while a transaction is active, so flush the
    ++	 * transaction here before reporting a change made by update-index.
    ++	 */
    ++	flush_odb_transaction();
    + 	va_start(vp, fmt);
    + 	vprintf(fmt, vp);
    + 	putchar('\n');
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
      	 */
      	parse_options_start(&ctx, argc, argv, prefix,
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      	while (ctx.argc) {
      		if (parseopt_state != PARSE_OPT_DONE)
      			parseopt_state = parse_options_step(&ctx, options,
    -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
    - 		the_index.version = preferred_index_format;
    - 	}
    - 
    -+	/*
    -+	 * It is possible, though unlikely, that a caller could use the verbose
    -+	 * output to synchronize with addition of objects to the object
    -+	 * database. The current implementation of ODB transactions leaves
    -+	 * objects invisible while a transaction is active, so end the
    -+	 * transaction here if verbose output is enabled.
    -+	 */
    -+
    -+	if (verbose)
    -+		end_odb_transaction();
    -+
    - 	if (read_from_stdin) {
    - 		struct strbuf buf = STRBUF_INIT;
    - 		struct strbuf unquoted = STRBUF_INIT;
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
      		strbuf_release(&buf);
      	}
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
     +	/*
     +	 * By now we have added all of the new objects
     +	 */
    -+	if (!verbose)
    -+		end_odb_transaction();
    ++	end_odb_transaction();
     +
      	if (split_index > 0) {
      		if (git_config_get_split_index() == 0)
 8:  523e5fbd63e =  7:  9cf584cdb67 unpack-objects: use the bulk-checkin infrastructure
 9:  faacc19aab2 =  8:  5039b596064 core.fsync: use batch mode and sync loose objects by default on Windows
10:  4de7300a7b0 =  9:  67205b3ac25 test-lib-functions: add parsing helpers for ls-files and ls-tree
11:  1a4aff8c350 ! 10:  148e562ddb8 core.fsyncmethod: tests for batch mode
    @@ t/lib-unique-files.sh (new)
     +	local dirs="$1" &&
     +	local files="$2" &&
     +	local basedir="$3" &&
    -+	local counter=0 &&
    ++	local counter="0" &&
     +	local i &&
     +	local j &&
     +	test_tick &&
    -+	local basedata=$basedir$test_tick &&
    ++	local basedata="$basedir$test_tick" &&
     +	rm -rf "$basedir" &&
     +	for i in $(test_seq $dirs)
     +	do
    -+		local dir=$basedir/dir$i &&
    ++		local dir="$basedir/dir$i" &&
     +		mkdir -p "$dir" &&
     +		for j in $(test_seq $files)
     +		do
12:  47cc63e1dda ! 11:  1a8320828f7 t/perf: add iteration setup mechanism to perf-lib
    @@ t/perf/p7519-fsmonitor.sh: then
     -	fi
     -fi
     -
    - trace_start() {
    + trace_start () {
      	if test -n "$GIT_PERF_7519_TRACE"
      	then
    -@@ t/perf/p7519-fsmonitor.sh: setup_for_fsmonitor() {
    +@@ t/perf/p7519-fsmonitor.sh: setup_for_fsmonitor_hook () {
      
      test_perf_w_drop_caches () {
      	if test -n "$GIT_PERF_7519_DROP_CACHE"; then
    @@ t/perf/p7519-fsmonitor.sh: setup_for_fsmonitor() {
     -	test_perf "$@"
      }
      
    - test_fsmonitor_suite() {
    + test_fsmonitor_suite () {
     
      ## t/perf/p7820-grep-engines.sh ##
     @@ t/perf/p7820-grep-engines.sh: do
    @@ t/perf/perf-lib.sh: exit $ret' >&3 2>&4
      }
      
      test_wrapper_ () {
    -+	local test_wrapper_func_ test_title_
    - 	test_wrapper_func_=$1; shift
    -+	test_title_=$1; shift
    +-	test_wrapper_func_=$1; shift
    ++	local test_wrapper_func_="$1"; shift
    ++	local test_title_="$1"; shift
      	test_start_
     -	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
     -	test "$#" = 2 ||
13:  26be6ecb28b ! 12:  3eb5a6720cb core.fsyncmethod: performance tests for batch mode
    @@ t/perf/p0008-odb-fsync.sh (new)
     +}
     +
     +test_perf_fsync_cfgs () {
    -+	local method cfg &&
    ++	local method &&
    ++	local cfg &&
     +	for method in none fsync batch writeout-only
     +	do
     +		case $method in
14:  88c1f84d4c3 <  -:  ----------- core.fsyncmethod: correctly camel-case warning message
-- 
2.34.1.78.g86e39b8f8d

