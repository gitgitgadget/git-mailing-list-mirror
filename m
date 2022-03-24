Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AACC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiCXFAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbiCXFAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54127FE8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h16so2051039wmd.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9vMpvEaM+sNmSCY+uvOWz/pUJ62gME0is5Ox7AO4McE=;
        b=gSPxIkyMZz7pB8AjWiiZpL8+iSFS84SUe7mu7RHFYZ69jsgh3fhzccns/VwNHp99dy
         wNyhzLd0Z7IU2RVe2dsH0f0xINCmC/B7M8KnBL7vzEv8sArH+QRTJ+55mQqWUuRuAXkR
         3LaPcq8WRJlnGQdYhCxeVjYPCfZ9hMBb18ipm6FRyAAeuERkYZke5af+wNfA81Qf/FNV
         ViGUVyyqddiDrDjpwc63+fIrx3VNVcJzjExgsma6GRxAdisik3+KvtGqR3AYdqYvbUHH
         5X5b5MxfcXzI6WDIdQM17Tt1i/P4jmFN30ZIfXECrJbUp0htjduhcxZswsVxVcHTp9hh
         AKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9vMpvEaM+sNmSCY+uvOWz/pUJ62gME0is5Ox7AO4McE=;
        b=LgB0USSR3rJ1wORNWOcLIZxPnku4UElndxJ5AZUzhA5JKfhwCM8kPl5ggXWL7JVdYt
         L1lhPnJ182YTOBAHaGyj4Pbs4M4dtZGSeXFb56df3iOeZWM1+xsTaTVLpPg4IEMvHs/3
         GFQOUt5xb/K2cQEexK2qD5QBr1bIiyxo6mJfyypGNhYnubOWaN9YFhYbdJjhBx8eBeX7
         PDOd2jnGjjg7jkl2USqzgAONPknd9bvo5QB4djMDuHyxNxM1c3s79kdRqXGinoVMIveO
         2erWVW8hFbWrBGfEJ8NzahEpKr8VQputv7Fwzv9J8ZU+D6JOzmemq2ouuG6IztyKEzUz
         NLBQ==
X-Gm-Message-State: AOAM5325nng7z4zdtgbohBRGjgApoBoBiGJuQLHFU3nDwOxlEoH4PebR
        o7wUI/1xMLXy5Y+5xLEmCYyyDU58yb0=
X-Google-Smtp-Source: ABdhPJw0atswRbDNxlj1ndqgKPU+fV0eh0+ErumNaa4XBlpOEfti8qNdVm5E+xUZeGRfANu7qtNsqw==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr3091051wmi.190.1648097908571;
        Wed, 23 Mar 2022 21:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d6d8d000000b00203d77cf7b0sm1663827wrs.74.2022.03.23.21.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:27 -0700 (PDT)
Message-Id: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:15 +0000
Subject: [PATCH v3 00/11] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V3 changes:

 * Rebrand plug/unplug-bulk-checkin to "begin_odb_transaction" and
   "end_odb_transaction"
 * Add a patch to pass filenames to fsync_or_die, rather than the string
   "loose object"
 * Update the commit description for "core.fsyncmethod to explain why we do
   not directly expose objects until an fsync occurs.
 * Also explain in the commit description why we're using a dummy file for
   the fsync.
 * Create the bulk-fsync tmp-objdir lazily the first time a loose object is
   added. We now do fsync iff that objdir exists.
 * Do batch fsync if core.fsyncMethod=batch and core.fsync contains
   loose-object, regardless of the core.fsyncObjectFiles setting.
 * Mitigate the risk in update-index of an object not being visible due to
   bulk checkin.
 * Add a perf comment to justify the unpack-objects usage of bulk-checkin.
 * Add a new patch to create helpers for parsing OIDs from git commands.
 * Add a comment to the lib-unique-files.sh helper about uniqueness only
   within a repo.
 * Fix style and add '&&' chaining to test helpers.
 * Comment on some magic numbers in tests.
 * Take the object list as an argument in
   ./t5300-pack-object.sh:check_unpack ()
 * Drop accidental change to t/perf/perf-lib.sh

V2 changes:

 * Change doc to indicate that only some repo updates are batched
 * Null and zero out control variables in do_batch_fsync under
   unplug_bulk_checkin
 * Make batch mode default on Windows.
 * Update the description for the initial patch that cleans up the
   bulk-checkin infrastructure.
 * Rebase onto 'seen' at 0cac37f38f9.

--Original definition-- When core.fsync includes loose-object, we issue an
fsync after every written object. For a 'git-add' or similar command that
adds a lot of files to the repo, the costs of these fsyncs adds up. One
major factor in this cost is the time it takes for the physical storage
controller to flush its caches to durable media.

This series takes advantage of the writeout-only mode of git_fsync to issue
OS cache writebacks for all of the objects being added to the repository
followed by a single fsync to a dummy file, which should trigger a
filesystem log flush and storage controller cache flush. This mechanism is
known to be safe on common Windows filesystems and expected to be safe on
macOS. Some linux filesystems, such as XFS, will probably do the right thing
as well. See [1] for previous discussion on the predecessor of this patch
series.

This series is important on Windows, where loose-objects are included in the
fsync set by default in Git-For-Windows. In this series, I'm also setting
the default mode for Windows to turn on loose object fsyncing with batch
mode, so that we can get CI coverage of the actual git-for-windows
configuration upstream. We still don't actually issue fsyncs for the test
suite since GIT_TEST_FSYNC is set to 0, but we exercise all of the
surrounding batch mode code.

This work is based on 'seen' at . It's dependent on ns/core-fsyncmethod.

[1]
https://lore.kernel.org/git/2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com/

Neeraj Singh (11):
  bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  object-file: pass filename to fsync_or_die
  core.fsyncmethod: batched disk flushes for loose-objects
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  test-lib-functions: add parsing helpers for ls-files and ls-tree
  core.fsyncmethod: tests for batch mode
  core.fsyncmethod: performance tests for add and stash
  core.fsyncmethod: correctly camel-case warning message

 Documentation/config/core.txt          |  8 +++
 builtin/add.c                          |  4 +-
 builtin/unpack-objects.c               |  3 +
 builtin/update-index.c                 | 33 +++++++++
 bulk-checkin.c                         | 97 ++++++++++++++++++++++----
 bulk-checkin.h                         | 17 ++++-
 cache.h                                | 12 +++-
 compat/mingw.h                         |  3 +
 config.c                               |  6 +-
 git-compat-util.h                      |  2 +
 object-file.c                          | 15 ++--
 t/lib-unique-files.sh                  | 32 +++++++++
 t/perf/p3700-add.sh                    | 59 ++++++++++++++++
 t/perf/p3900-stash.sh                  | 62 ++++++++++++++++
 t/t3700-add.sh                         | 28 ++++++++
 t/t3903-stash.sh                       | 20 ++++++
 t/t5300-pack-object.sh                 | 41 +++++++----
 t/t5317-pack-objects-filter-objects.sh | 91 ++++++++++++------------
 t/test-lib-functions.sh                | 10 +++
 19 files changed, 458 insertions(+), 85 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: c54b8eb302ffb72f31e73a26044c8a864e2cb307
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1134%2Fneerajsi-msft%2Fns%2Fbatched-fsync-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1134/neerajsi-msft/ns/batched-fsync-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1134

Range-diff vs v2:

  -:  ----------- >  1:  53261f0099d bulk-checkin: rebrand plug/unplug APIs as 'odb transactions'
  1:  9c2abd12bbb !  2:  b2d9766a662 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
     @@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
       	return status;
       }
       
     - void plug_bulk_checkin(void)
     + void begin_odb_transaction(void)
       {
      -	state.plugged = 1;
      +	assert(!bulk_checkin_plugged);
      +	bulk_checkin_plugged = 1;
       }
       
     - void unplug_bulk_checkin(void)
     + void end_odb_transaction(void)
       {
      -	state.plugged = 0;
      -	if (state.f)
  -:  ----------- >  3:  26ce5b8fdda object-file: pass filename to fsync_or_die
  2:  3ed1dcd9b9b !  4:  52638326790 core.fsyncmethod: batched disk flushes for loose-objects
     @@ Commit message
          One major source of the cost of fsync is the implied flush of the
          hardware writeback cache within the disk drive. This commit introduces
          a new `core.fsyncMethod=batch` option that batches up hardware flushes.
     -    It hooks into the bulk-checkin plugging and unplugging functionality,
     -    takes advantage of tmp-objdir, and uses the writeout-only support code.
     +    It hooks into the bulk-checkin odb-transaction functionality, takes
     +    advantage of tmp-objdir, and uses the writeout-only support code.
      
          When the new mode is enabled, we do the following for each new object:
     -    1. Create the object in a tmp-objdir.
     -    2. Issue a pagecache writeback request and wait for it to complete.
     +    1a. Create the object in a tmp-objdir.
     +    2a. Issue a pagecache writeback request and wait for it to complete.
      
          At the end of the entire transaction when unplugging bulk checkin:
     -    1. Issue an fsync against a dummy file to flush the hardware writeback
     -       cache, which should by now have seen the tmp-objdir writes.
     -    2. Rename all of the tmp-objdir files to their final names.
     -    3. When updating the index and/or refs, we assume that Git will issue
     +    1b. Issue an fsync against a dummy file to flush the log and hardware
     +       writeback cache, which should by now have seen the tmp-objdir writes.
     +    2b. Rename all of the tmp-objdir files to their final names.
     +    3b. When updating the index and/or refs, we assume that Git will issue
             another fsync internal to that operation. This is not the default
             today, but the user now has the option of syncing the index and there
             is a separate patch series to implement syncing of refs.
     @@ Commit message
          operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
          we would expect the fsync to trigger a journal writeout so that this
          sequence is enough to ensure that the user's data is durable by the time
     -    the git command returns.
     +    the git command returns. This sequence also ensures that no object files
     +    appear in the main object store unless they are fsync-durable.
      
     -    Batch mode is only enabled if core.fsyncObjectFiles is false or unset.
     +    Batch mode is only enabled if core.fsync includes loose-objects. If
     +    the legacy core.fsyncObjectFiles setting is enabled, but core.fsync does
     +    not include loose-objects, we will use file-by-file fsyncing.
     +
     +    In step (1a) of the sequence, the tmp-objdir is created lazily to avoid
     +    work if no loose objects are ever added to the ODB. We use a tmp-objdir
     +    to maintain the invariant that no loose-objects are visible in the main
     +    ODB unless they are properly fsync-durable. This is important since
     +    future ODB operations that try to create an object with specific
     +    contents will silently drop the new data if an object with the target
     +    hash exists without checking that the loose-object contents match the
     +    hash. Only a full git-fsck would restore the ODB to a functional state
     +    where dataloss doesn't occur.
     +
     +    In step (1b) of the sequence, we issue a fsync against a dummy file
     +    created specifically for the purpose. This method has a little higher
     +    cost than using one of the input object files, but makes adding new
     +    callers of this mechanism easier, since we don't need to figure out
     +    which object file is "last" or risk sharing violations by caching the fd
     +    of the last object file.
      
          _Performance numbers_:
      
     @@ Documentation/config/core.txt: core.fsyncMethod::
      +* `batch` enables a mode that uses writeout-only flushes to stage multiple
      +  updates in the disk writeback cache and then does a single full fsync of
      +  a dummy file to trigger the disk cache flush at the end of the operation.
     +++
      +  Currently `batch` mode only applies to loose-object files. Other repository
      +  data is made durable as if `fsync` was specified. This mode is expected to
      +  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
     @@ bulk-checkin.c
       #include "object-store.h"
       
       static int bulk_checkin_plugged;
     -+static int needs_batch_fsync;
     -+
     -+static struct tmp_objdir *bulk_fsync_objdir;
       
     ++static struct tmp_objdir *bulk_fsync_objdir;
     ++
       static struct bulk_checkin_state {
       	char *pack_tmp_name;
     + 	struct hashfile *f;
      @@ bulk-checkin.c: clear_exit:
       	reprepare_packed_git(the_repository);
       }
     @@ bulk-checkin.c: clear_exit:
      + */
      +static void do_batch_fsync(void)
      +{
     ++	struct strbuf temp_path = STRBUF_INIT;
     ++	struct tempfile *temp;
     ++
     ++	if (!bulk_fsync_objdir)
     ++		return;
     ++
      +	/*
      +	 * Issue a full hardware flush against a temporary file to ensure
     -+	 * that all objects are durable before any renames occur.  The code in
     ++	 * that all objects are durable before any renames occur. The code in
      +	 * fsync_loose_object_bulk_checkin has already issued a writeout
      +	 * request, but it has not flushed any writeback cache in the storage
     -+	 * hardware.
     ++	 * hardware or any filesystem logs. This fsync call acts as a barrier
     ++	 * to ensure that the data in each new object file is durable before
     ++	 * the final name is visible.
      +	 */
     ++	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
     ++	temp = xmks_tempfile(temp_path.buf);
     ++	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
     ++	delete_tempfile(&temp);
     ++	strbuf_release(&temp_path);
      +
     -+	if (needs_batch_fsync) {
     -+		struct strbuf temp_path = STRBUF_INIT;
     -+		struct tempfile *temp;
     -+
     -+		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
     -+		temp = xmks_tempfile(temp_path.buf);
     -+		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
     -+		delete_tempfile(&temp);
     -+		strbuf_release(&temp_path);
     -+		needs_batch_fsync = 0;
     -+	}
     -+
     -+	if (bulk_fsync_objdir) {
     -+		tmp_objdir_migrate(bulk_fsync_objdir);
     -+		bulk_fsync_objdir = NULL;
     -+	}
     ++	/*
     ++	 * Make the object files visible in the primary ODB after their data is
     ++	 * fully durable.
     ++	 */
     ++	tmp_objdir_migrate(bulk_fsync_objdir);
     ++	bulk_fsync_objdir = NULL;
      +}
      +
       static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
       	return 0;
       }
       
     -+void fsync_loose_object_bulk_checkin(int fd)
     ++void prepare_loose_object_bulk_checkin(void)
     ++{
     ++	/*
     ++	 * We lazily create the temporary object directory
     ++	 * the first time an object might be added, since
     ++	 * callers may not know whether any objects will be
     ++	 * added at the time they call begin_odb_transaction.
     ++	 */
     ++	if (!bulk_checkin_plugged || bulk_fsync_objdir)
     ++		return;
     ++
     ++	bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
     ++	if (bulk_fsync_objdir)
     ++		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
     ++}
     ++
     ++void fsync_loose_object_bulk_checkin(int fd, const char *filename)
      +{
      +	/*
      +	 * If we have a plugged bulk checkin, we issue a call that
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +	 * command. Later on we will issue a single hardware flush
      +	 * before as part of do_batch_fsync.
      +	 */
     -+	if (bulk_checkin_plugged &&
     -+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
     -+		assert(bulk_fsync_objdir);
     -+		if (!needs_batch_fsync)
     -+			needs_batch_fsync = 1;
     -+	} else {
     -+		fsync_or_die(fd, "loose object file");
     ++	if (!bulk_fsync_objdir ||
     ++	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
     ++		fsync_or_die(fd, filename);
      +	}
      +}
      +
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags)
     -@@ bulk-checkin.c: int index_bulk_checkin(struct object_id *oid,
     - void plug_bulk_checkin(void)
     - {
     - 	assert(!bulk_checkin_plugged);
     -+
     -+	/*
     -+	 * A temporary object directory is used to hold the files
     -+	 * while they are not fsynced.
     -+	 */
     -+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT)) {
     -+		bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
     -+		if (!bulk_fsync_objdir)
     -+			die(_("Could not create temporary object directory for core.fsyncobjectfiles=batch"));
     -+
     -+		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
     -+	}
     -+
     - 	bulk_checkin_plugged = 1;
     - }
     - 
     -@@ bulk-checkin.c: void unplug_bulk_checkin(void)
     +@@ bulk-checkin.c: void end_odb_transaction(void)
       	bulk_checkin_plugged = 0;
       	if (bulk_checkin_state.f)
       		finish_bulk_checkin(&bulk_checkin_state);
     @@ bulk-checkin.h
       
       #include "cache.h"
       
     -+void fsync_loose_object_bulk_checkin(int fd);
     ++void prepare_loose_object_bulk_checkin(void);
     ++void fsync_loose_object_bulk_checkin(int fd, const char *filename);
      +
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
     @@ cache.h: extern int use_fsync;
       	FSYNC_METHOD_FSYNC,
      -	FSYNC_METHOD_WRITEOUT_ONLY
      +	FSYNC_METHOD_WRITEOUT_ONLY,
     -+	FSYNC_METHOD_BATCH
     ++	FSYNC_METHOD_BATCH,
       };
       
       extern enum fsync_method fsync_method;
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
      
       ## object-file.c ##
     -@@ object-file.c: static void close_loose_object(int fd)
     +@@ object-file.c: static void close_loose_object(int fd, const char *filename)
     + 	if (the_repository->objects->odb->will_destroy)
     + 		goto out;
       
     - 	if (fsync_object_files > 0)
     - 		fsync_or_die(fd, "loose object file");
     -+	else if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
     -+		fsync_loose_object_bulk_checkin(fd);
     +-	if (fsync_object_files > 0)
     ++	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
     ++		fsync_loose_object_bulk_checkin(fd, filename);
     ++	else if (fsync_object_files > 0)
     + 		fsync_or_die(fd, filename);
       	else
       		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
     - 				       "loose object file");
     +@@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
     + 	static struct strbuf tmp_file = STRBUF_INIT;
     + 	static struct strbuf filename = STRBUF_INIT;
     + 
     ++	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
     ++		prepare_loose_object_bulk_checkin();
     ++
     + 	loose_object_path(the_repository, &filename, oid);
     + 
     + 	fd = create_tmpfile(&tmp_file, filename.buf);
  3:  54797dbc520 !  5:  913ce1b3df9 update-index: use the bulk-checkin infrastructure
     @@ Commit message
          The update-index functionality is used internally by 'git stash push' to
          setup the internal stashed commit.
      
     -    This change enables bulk-checkin for update-index infrastructure to
     +    This change enables odb-transactions for update-index infrastructure to
          speed up adding new objects to the object database by leveraging the
          batch fsync functionality.
      
          There is some risk with this change, since under batch fsync, the object
     -    files will be in a tmp-objdir until update-index is complete.  This
     -    usage is unlikely, since any tool invoking update-index and expecting to
     -    see objects would have to synchronize with the update-index process
     -    after passing it a file path.
     +    files will be in a tmp-objdir until update-index is complete, so callers
     +    using the --stdin option will not see them until update-index is done.
     +    This risk is mitigated by unplugging the batch when reporting verbose
     +    output, which is the only way a --stdin caller might synchronize with
     +    the addition of an object.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ builtin/update-index.c
       #include "config.h"
       #include "lockfile.h"
       #include "quote.h"
     -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     +@@ builtin/update-index.c: static int allow_replace;
     + static int info_only;
     + static int force_remove;
     + static int verbose;
     ++static int odb_transaction_active;
     + static int mark_valid_only;
     + static int mark_skip_worktree_only;
     + static int mark_fsmonitor_only;
     +@@ builtin/update-index.c: enum uc_mode {
     + 	UC_FORCE
     + };
       
     - 	the_index.updated_skipworktree = 1;
     ++static void end_odb_transaction_if_active(void)
     ++{
     ++	if (!odb_transaction_active)
     ++		return;
     ++
     ++	end_odb_transaction();
     ++	odb_transaction_active = 0;
     ++}
     ++
     + __attribute__((format (printf, 1, 2)))
     + static void report(const char *fmt, ...)
     + {
     +@@ builtin/update-index.c: static void report(const char *fmt, ...)
     + 	if (!verbose)
     + 		return;
       
     -+	/* we might be adding many objects to the object database */
     -+	plug_bulk_checkin();
     ++	/*
     ++	 * It is possible, though unlikely, that a caller
     ++	 * could use the verbose output to synchronize with
     ++	 * addition of objects to the object database, so
     ++	 * unplug bulk checkin to make sure that future objects
     ++	 * are immediately visible.
     ++	 */
     ++
     ++	end_odb_transaction_if_active();
      +
     - 	/*
     - 	 * Custom copy of parse_options() because we want to handle
     - 	 * filename arguments as they come.
     + 	va_start(vp, fmt);
     + 	vprintf(fmt, vp);
     + 	putchar('\n');
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 	 */
     + 	parse_options_start(&ctx, argc, argv, prefix,
     + 			    options, PARSE_OPT_STOP_AT_NON_OPTION);
     ++
     ++	/*
     ++	 * Allow the object layer to optimize adding multiple objects in
     ++	 * a batch.
     ++	 */
     ++	begin_odb_transaction();
     ++	odb_transaction_active = 1;
     + 	while (ctx.argc) {
     + 		if (parseopt_state != PARSE_OPT_DONE)
     + 			parseopt_state = parse_options_step(&ctx, options,
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       		strbuf_release(&buf);
       	}
       
     -+	/* by now we must have added all of the new objects */
     -+	unplug_bulk_checkin();
     ++	/*
     ++	 * By now we have added all of the new objects
     ++	 */
     ++	end_odb_transaction_if_active();
     ++
       	if (split_index > 0) {
       		if (git_config_get_split_index() == 0)
       			warning(_("core.splitIndex is set to false; "
  4:  6662e2dae0f !  6:  84fd144ef18 unpack-objects: use the bulk-checkin infrastructure
     @@ Commit message
          to turn the transfered data into object database entries when there are
          fewer objects than the 'unpacklimit' setting.
      
     -    By enabling bulk-checkin when unpacking objects, we can take advantage
     +    By enabling an odb-transaction when unpacking objects, we can take advantage
          of batched fsyncs.
      
     +    Here are some performance numbers to justify batch mode for
     +    unpack-objects, collected on a WSL2 Ubuntu VM.
     +
     +    Fsync Mode | Time for 90 objects (ms)
     +    -------------------------------------
     +           Off | 170
     +      On,fsync | 760
     +      On,batch | 230
     +
     +    Note that the default unpackLimit is 100 objects, so there's a 3x
     +    benefit in the worst case. The non-batch mode fsync scales linearly
     +    with the number of objects, so there are significant benefits even with
     +    smaller numbers of objects.
     +
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void unpack_all(void)
       	if (!quiet)
       		progress = start_progress(_("Unpacking objects"), nr_objects);
       	CALLOC_ARRAY(obj_list, nr_objects);
     -+	plug_bulk_checkin();
     ++	begin_odb_transaction();
       	for (i = 0; i < nr_objects; i++) {
       		unpack_one(i);
       		display_progress(progress, i + 1);
       	}
     -+	unplug_bulk_checkin();
     ++	end_odb_transaction();
       	stop_progress(&progress);
       
       	if (delta_list)
  5:  03bf591742a !  7:  447263e8ef1 core.fsync: use batch mode and sync loose objects by default on Windows
     @@ Commit message
          in upstream Git so that we can get broad coverage of the new code
          upstream.
      
     -    We don't actually do fsyncs in the test suite, since GIT_TEST_FSYNC is
     -    set to 0. However, we do exercise all of the surrounding batch mode code
     -    since GIT_TEST_FSYNC merely makes the maybe_fsync wrapper always appear
     -    to succeed.
     +    We don't actually do fsyncs in the most of the test suite, since
     +    GIT_TEST_FSYNC is set to 0. However, we do exercise all of the
     +    surrounding batch mode code since GIT_TEST_FSYNC merely makes the
     +    maybe_fsync wrapper always appear to succeed.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
  -:  ----------- >  8:  8f1b01c9ca0 test-lib-functions: add parsing helpers for ls-files and ls-tree
  6:  1937746df47 !  9:  b5f371e97fe core.fsyncmethod: tests for batch mode
     @@ Commit message
          In this change we introduce a new test helper lib-unique-files.sh. The
          goal of this library is to create a tree of files that have different
          oids from any other files that may have been created in the current test
     -    repo. This helps us avoid missing validation of an object being added due
     -    to it already being in the repo.
     -
     -    We aren't actually issuing any fsyncs in these tests, since
     -    GIT_TEST_FSYNC is 0, but we still exercise all of the tmp_objdir logic
     -    in bulk-checkin.
     +    repo. This helps us avoid missing validation of an object being added
     +    due to it already being in the repo.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ t/lib-unique-files.sh (new)
      @@
      +# Helper to create files with unique contents
      +
     -+
     -+# Create multiple files with unique contents. Takes the number of
     -+# directories, the number of files in each directory, and the base
     ++# Create multiple files with unique contents within this test run. Takes the
     ++# number of directories, the number of files in each directory, and the base
      +# directory.
      +#
      +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
     -+#					 each in my_dir, all with unique
     -+#					 contents.
     ++#					 each in my_dir, all with contents
     ++#					 different from previous invocations
     ++#					 of this command in this run.
      +
     -+test_create_unique_files() {
     ++test_create_unique_files () {
      +	test "$#" -ne 3 && BUG "3 param"
      +
     -+	local dirs=$1
     -+	local files=$2
     -+	local basedir=$3
     -+	local counter=0
     -+	test_tick
     -+	local basedata=$test_tick
     -+
     -+
     -+	rm -rf $basedir
     -+
     ++	local dirs="$1" &&
     ++	local files="$2" &&
     ++	local basedir="$3" &&
     ++	local counter=0 &&
     ++	test_tick &&
     ++	local basedata=$basedir$test_tick &&
     ++	rm -rf "$basedir" &&
      +	for i in $(test_seq $dirs)
      +	do
     -+		local dir=$basedir/dir$i
     -+
     -+		mkdir -p "$dir"
     ++		local dir=$basedir/dir$i &&
     ++		mkdir -p "$dir" &&
      +		for j in $(test_seq $files)
      +		do
     -+			counter=$((counter + 1))
     -+			echo "$basedata.$counter"  >"$dir/file$j.txt"
     ++			counter=$((counter + 1)) &&
     ++			echo "$basedata.$counter">"$dir/file$j.txt"
      +		done
      +	done
      +}
     @@ t/t3700-add.sh: test_expect_success \
      +BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
      +
      +test_expect_success 'git add: core.fsyncmethod=batch' "
     -+	test_create_unique_files 2 4 fsync-files &&
     -+	git $BATCH_CONFIGURATION add -- ./fsync-files/ &&
     -+	rm -f fsynced_files &&
     -+	git ls-files --stage fsync-files/ > fsynced_files &&
     -+	test_line_count = 8 fsynced_files &&
     -+	awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e
     ++	test_create_unique_files 2 4 files_base_dir1 &&
     ++	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION add -- ./files_base_dir1/ &&
     ++	git ls-files --stage files_base_dir1/ |
     ++	test_parse_ls_files_stage_oids >added_files_oids &&
     ++
     ++	# We created 2 subdirs with 4 files each (8 files total) above
     ++	test_line_count = 8 added_files_oids &&
     ++	git cat-file --batch-check='%(objectname)' <added_files_oids >added_files_actual &&
     ++	test_cmp added_files_oids added_files_actual
      +"
      +
      +test_expect_success 'git update-index: core.fsyncmethod=batch' "
     -+	test_create_unique_files 2 4 fsync-files2 &&
     -+	find fsync-files2 ! -type d -print | xargs git $BATCH_CONFIGURATION update-index --add -- &&
     -+	rm -f fsynced_files2 &&
     -+	git ls-files --stage fsync-files2/ > fsynced_files2 &&
     -+	test_line_count = 8 fsynced_files2 &&
     -+	awk -- '{print \$2}' fsynced_files2 | xargs -n1 git cat-file -e
     ++	test_create_unique_files 2 4 files_base_dir2 &&
     ++	find files_base_dir2 ! -type d -print | xargs git $BATCH_CONFIGURATION update-index --add -- &&
     ++	git ls-files --stage files_base_dir2 |
     ++	test_parse_ls_files_stage_oids >added_files2_oids &&
     ++
     ++	# We created 2 subdirs with 4 files each (8 files total) above
     ++	test_line_count = 8 added_files2_oids &&
     ++	git cat-file --batch-check='%(objectname)' <added_files2_oids >added_files2_actual &&
     ++	test_cmp added_files2_oids added_files2_actual
      +"
      +
       test_expect_success \
     @@ t/t3903-stash.sh: test_expect_success 'stash handles skip-worktree entries nicel
      +BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
      +
      +test_expect_success 'stash with core.fsyncmethod=batch' "
     -+	test_create_unique_files 2 4 fsync-files &&
     -+	git $BATCH_CONFIGURATION stash push -u -- ./fsync-files/ &&
     -+	rm -f fsynced_files &&
     ++	test_create_unique_files 2 4 files_base_dir &&
     ++	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION stash push -u -- ./files_base_dir/ &&
      +
      +	# The files were untracked, so use the third parent,
      +	# which contains the untracked files
     -+	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
     -+	test_line_count = 8 fsynced_files &&
     -+	awk -- '{print \$3}' fsynced_files | xargs -n1 git cat-file -e
     ++	git ls-tree -r stash^3 -- ./files_base_dir/ |
     ++	test_parse_ls_tree_oids >stashed_files_oids &&
     ++
     ++	# We created 2 dirs with 4 files each (8 files total) above
     ++	test_line_count = 8 stashed_files_oids &&
     ++	git cat-file --batch-check='%(objectname)' <stashed_files_oids >stashed_files_actual &&
     ++	test_cmp stashed_files_oids stashed_files_actual
      +"
      +
      +
     @@ t/t3903-stash.sh: test_expect_success 'stash handles skip-worktree entries nicel
      
       ## t/t5300-pack-object.sh ##
      @@ t/t5300-pack-object.sh: test_expect_success 'pack-objects with bogus arguments' '
     + '
       
       check_unpack () {
     ++	local packname="$1" &&
     ++	local object_list="$2" &&
     ++	local git_config="$3" &&
       	test_when_finished "rm -rf git2" &&
      -	git init --bare git2 &&
      -	git -C git2 unpack-objects -n <"$1".pack &&
     @@ t/t5300-pack-object.sh: test_expect_success 'pack-objects with bogus arguments'
      -			return 1
      -		}
      -	done
     -+	git $2 init --bare git2 &&
     ++	git $git_config init --bare git2 &&
      +	(
     -+		git $2 -C git2 unpack-objects -n <"$1".pack &&
     -+		git $2 -C git2 unpack-objects <"$1".pack &&
     -+		git $2 -C git2 cat-file --batch-check="%(objectname)"
     -+	) <obj-list >current &&
     -+	cmp obj-list current
     ++		git $git_config -C git2 unpack-objects -n <"$packname".pack &&
     ++		git $git_config -C git2 unpack-objects <"$packname".pack &&
     ++		git $git_config -C git2 cat-file --batch-check="%(objectname)"
     ++	) <"$object_list" >current &&
     ++	cmp "$object_list" current
       }
       
       test_expect_success 'unpack without delta' '
     - 	check_unpack test-1-${packname_1}
     - '
     - 
     +-	check_unpack test-1-${packname_1}
     ++	check_unpack test-1-${packname_1} obj-list
     ++'
     ++
      +BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
      +
      +test_expect_success 'unpack without delta (core.fsyncmethod=batch)' '
     -+	check_unpack test-1-${packname_1} "$BATCH_CONFIGURATION"
     -+'
     -+
     ++	check_unpack test-1-${packname_1} obj-list "$BATCH_CONFIGURATION"
     + '
     + 
       test_expect_success 'pack with REF_DELTA' '
     - 	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
     - 	check_deltas stderr -gt 0
     -@@ t/t5300-pack-object.sh: test_expect_success 'unpack with REF_DELTA' '
     - 	check_unpack test-2-${packname_2}
     +@@ t/t5300-pack-object.sh: test_expect_success 'pack with REF_DELTA' '
       '
       
     -+test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
     -+       check_unpack test-2-${packname_2} "$BATCH_CONFIGURATION"
     + test_expect_success 'unpack with REF_DELTA' '
     +-	check_unpack test-2-${packname_2}
     ++	check_unpack test-2-${packname_2} obj-list
      +'
      +
     ++test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
     ++       check_unpack test-2-${packname_2} obj-list "$BATCH_CONFIGURATION"
     + '
     + 
       test_expect_success 'pack with OFS_DELTA' '
     - 	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
     - 			<obj-list 2>stderr) &&
     -@@ t/t5300-pack-object.sh: test_expect_success 'unpack with OFS_DELTA' '
     - 	check_unpack test-3-${packname_3}
     +@@ t/t5300-pack-object.sh: test_expect_success 'pack with OFS_DELTA' '
       '
       
     -+test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
     -+       check_unpack test-3-${packname_3} "$BATCH_CONFIGURATION"
     + test_expect_success 'unpack with OFS_DELTA' '
     +-	check_unpack test-3-${packname_3}
     ++	check_unpack test-3-${packname_3} obj-list
      +'
      +
     ++test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
     ++       check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
     + '
     + 
       test_expect_success 'compare delta flavors' '
     - 	perl -e '\''
     - 		defined($_ = -s $_) or die for @ARGV;
  7:  624244078c7 ! 10:  b99b32a469c core.fsyncmethod: performance tests for add and stash
     @@ Commit message
      
          Add basic performance tests for "git add" and "git stash" of a lot of
          new objects with various fsync settings. This shows the benefit of batch
     -    mode relative to an ordinary stash command.
     +    mode relative to full fsync.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     @@ t/perf/p3900-stash.sh (new)
      +done
      +
      +test_done
     -
     - ## t/perf/perf-lib.sh ##
     -@@ t/perf/perf-lib.sh: test_perf_create_repo_from () {
     - 	mkdir -p "$repo/.git"
     - 	(
     - 		cd "$source" &&
     --		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
     --			cp -R "$objects_dir" "$repo/.git/"; } &&
     -+		{ cp -Rl "$objects_dir" "$repo/.git/" ||
     -+			cp -R "$objects_dir" "$repo/.git/" 2>/dev/null;} &&
     - 
     - 		# common_dir must come first here, since we want source_git to
     - 		# take precedence and overwrite any overlapping files
  -:  ----------- > 11:  6b832e89bc4 core.fsyncmethod: correctly camel-case warning message

-- 
gitgitgadget
