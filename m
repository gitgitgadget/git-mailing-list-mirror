Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE5EC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 03:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiBADdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 22:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBADdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 22:33:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACFC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n8so11699899wmk.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b8GKfvnuRKk8ioouOntohVXgZyj0JVF1Aua2Y5B12C4=;
        b=lP5RkPZxVb4sEZWN8I6tPAu/WEZUkTB58uTxYk6mYI3RWMTH/pRSQYu982ZabxF4md
         pVW4GHO3/3wLIwzFHH59GRK8lMvwEgGtrlA7n/Baw0jE7ik5Tn/L6EWL9eEv8/qJn7Cj
         fVDKin8oSYOI7zx70tLEfOKpweB+Qy5qCPw9Xu4sK9IzpBKeBh/IWRnaDvm+azETo21S
         JXdJgVzmv0r9ynwl1A63P97CwFdZrJpBO6VymF3TjMQBIl9bIQtSEv0M+uozYsOM+3VE
         KuLqsCcHTpCCgjEwdKq4WI6oXSDqS6vgaRBDSdsL4pMwyh1epBJUB5DaAQqjKy6VuE/T
         ciCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b8GKfvnuRKk8ioouOntohVXgZyj0JVF1Aua2Y5B12C4=;
        b=7FPaH4IV88r3SHc7McXg4lUm1Eksx2beYjhX2vE5SWDyrWTSoheU4bjrV2qKXrm78l
         xvDkp0PeLI7m8w3N0Wk+fbIg5y6cmly6soHRkT2hFAA8isOnINtPrUmcn0d/qaAd/wrq
         5FAyMGp3htN164fWGOTb308TLE3rwOtEdLU/WoGqVizmUj94wRHTGk2EIB6oqx1xfoRn
         ZbFiIoJuUw8SY86EXXe2e1mB6mr8S+3ZG+JzAV/B0A8p4WvSXN2BGGCn0cxgiBIFTU2A
         gPrebIp7irXaKWas6abc9F/Za1Drivz9Jd73pmJ0qu7GAGyTi/dyJpAIa3Wlfpsz7No2
         lCBw==
X-Gm-Message-State: AOAM532JcvZUl+t1t1gn3d3PHA/rWkTuyEcxg76Nz5GYe1lFPWJ7Oj6E
        NY/d/KikRtY7naUM2Fuex1p+OYPMUNg=
X-Google-Smtp-Source: ABdhPJyP69jYQt9R0GKqCODoeveWk886Ewpn8qhx39sGHhLx7esqbO5nyCoHQI9Wja+pDPGPxPDeOg==
X-Received: by 2002:a05:600c:1596:: with SMTP id r22mr34350wmf.33.1643686426596;
        Mon, 31 Jan 2022 19:33:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm897999wmq.33.2022.01.31.19.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 19:33:45 -0800 (PST)
Message-Id: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 03:33:40 +0000
Subject: [PATCH v4 0/4] A design for future-proofing fsync() configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an implementation of an extensible configuration mechanism for
fsyncing persistent components of a repo.

The main goals are to separate the "what" to sync from the "how". There are
now two settings: core.fsync - Control the 'what', including the index.
core.fsyncMethod - Control the 'how'. Currently we support writeout-only and
full fsync.

Syncing of refs can be layered on top of core.fsync. And batch mode will be
layered on core.fsyncMethod.

core.fsyncObjectfiles is removed and will issue a deprecation warning if
it's seen.

I'd like to get agreement on this direction before submitting batch mode to
the list. The batch mode series is available to view at
https://github.com/gitgitgadget/git/pull/1134

Please see [1], [2], and [3] for discussions that led to this series.

After this change, new persistent data files added to the repo will need to
be added to the fsync_component enum and documented in the
Documentation/config/core.txt text.

V4 changes:

 * Rebase onto master at b23dac905bd.
 * Add a comment to write_pack_file indicating why we don't fsync when
   writing to stdout.
 * I kept the configuration schema as-is rather than switching to
   multi-value. The thinking here is that a stateless last-one-wins config
   schema (comma separated) will make it easier to achieve some holistic
   self-consistent fsync configuration for a particular repo.

V3 changes:

 * Remove relative path from git-compat-util.h include [4].
 * Updated newly added warning texts to have more context for localization
   [4].
 * Fixed tab spacing in enum fsync_action
 * Moved the fsync looping out to a helper and do it consistently. [4]
 * Changed commit description to use camelCase for config names. [5]
 * Add an optional fourth patch with derived-metadata so that the user can
   exclude a forward-compatible set of things that should be recomputable
   given existing data.

V2 changes:

 * Updated the documentation for core.fsyncmethod to be less certain.
   writeout-only probably does not do the right thing on Linux.
 * Split out the core.fsync=index change into its own commit.
 * Rename REPO_COMPONENT to FSYNC_COMPONENT. This is really specific to
   fsyncing, so the name should reflect that.
 * Re-add missing Makefile change for SYNC_FILE_RANGE.
 * Tested writeout-only mode, index syncing, and general config settings.

[1] https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/
[2]
https://lore.kernel.org/git/dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im/
[3]
https://lore.kernel.org/git/pull.1076.git.git.1629856292.gitgitgadget@gmail.com/
[4]
https://lore.kernel.org/git/CANQDOdf8C4-haK9=Q_J4Cid8bQALnmGDm=SvatRbaVf+tkzqLw@mail.gmail.com/
[5] https://lore.kernel.org/git/211207.861r2opplg.gmgdl@evledraar.gmail.com/

Neeraj Singh (4):
  core.fsyncmethod: add writeout-only mode
  core.fsync: introduce granular fsync control
  core.fsync: new option to harden the index
  core.fsync: add a `derived-metadata` aggregate option

 Documentation/config/core.txt       | 35 ++++++++---
 Makefile                            |  6 ++
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              | 24 +++++---
 bulk-checkin.c                      |  5 +-
 cache.h                             | 49 +++++++++++++++-
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 config.c                            | 90 ++++++++++++++++++++++++++++-
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 csum-file.c                         |  5 +-
 csum-file.h                         |  3 +-
 environment.c                       |  3 +-
 git-compat-util.h                   | 24 ++++++++
 midx.c                              |  3 +-
 object-file.c                       |  3 +-
 pack-bitmap-write.c                 |  3 +-
 pack-write.c                        | 13 +++--
 read-cache.c                        | 19 ++++--
 wrapper.c                           | 64 ++++++++++++++++++++
 write-or-die.c                      | 11 ++--
 25 files changed, 367 insertions(+), 47 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: b23dac905bde28da47543484320db16312c87551
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1093

Range-diff vs v3:

 1:  15edfe51509 ! 1:  51a218d100d core.fsyncmethod: add writeout-only mode
     @@ Makefile: ifdef HAVE_CLOCK_MONOTONIC
       endif
      
       ## cache.h ##
     -@@ cache.h: extern int read_replace_refs;
     - extern char *git_replace_ref_base;
     +@@ cache.h: extern char *git_replace_ref_base;
       
       extern int fsync_object_files;
     + extern int use_fsync;
      +
      +enum fsync_method {
      +	FSYNC_METHOD_FSYNC,
     @@ compat/win32/flush.c (new)
      +
      +#define FLUSH_FLAGS_FILE_DATA_ONLY 1
      +
     -+       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
     ++       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, NtFlushBuffersFileEx,
      +			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
      +			 PIO_STATUS_BLOCK IoStatusBlock);
      +
     @@ contrib/buildsystems/CMakeLists.txt: if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
       		compat/nedmalloc/nedmalloc.c compat/strdup.c)
      
       ## environment.c ##
     -@@ environment.c: const char *git_attributes_file;
     - const char *git_hooks_path;
     - int zlib_compression_level = Z_BEST_SPEED;
     +@@ environment.c: int zlib_compression_level = Z_BEST_SPEED;
       int pack_compression_level = Z_DEFAULT_COMPRESSION;
     --int fsync_object_files;
     + int fsync_object_files;
     + int use_fsync = -1;
      +enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
       size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
       size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
       	int err;
      
       ## write-or-die.c ##
     -@@ write-or-die.c: void fprintf_or_die(FILE *f, const char *fmt, ...)
     - 
     - void fsync_or_die(int fd, const char *msg)
     - {
     +@@ write-or-die.c: void fsync_or_die(int fd, const char *msg)
     + 		use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
     + 	if (!use_fsync)
     + 		return;
      -	while (fsync(fd) < 0) {
      -		if (errno != EINTR)
      -			die_errno("fsync error on '%s'", msg);
      -	}
     ++
      +	if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
      +	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
      +		return;
 2:  080be1a6f64 ! 2:  7a164ba9571 core.fsync: introduce granular fsync control
     @@ builtin/index-pack.c: static void final(const char *final_pack_name, const char
      
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: static void write_pack_file(void)
     - 		 * If so, rewrite it like in fast-import
     - 		 */
     + 			display_progress(progress_state, written);
     + 		}
     + 
     +-		/*
     +-		 * Did we write the wrong # entries in the header?
     +-		 * If so, rewrite it like in fast-import
     +-		 */
       		if (pack_to_stdout) {
      -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
     ++			/*
     ++			 * We never fsync when writing to stdout since we may
     ++			 * not be writing to an actual pack file. For instance,
     ++			 * the upload-pack code passes a pipe here. Calling
     ++			 * fsync on a pipe results in unnecessary
     ++			 * synchronization with the reader on some platforms.
     ++			 */
      +			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
      +					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
       		} else if (nr_written == nr_remaining) {
     @@ builtin/pack-objects.c: static void write_pack_file(void)
      +					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
       		} else {
      -			int fd = finalize_hashfile(f, hash, 0);
     ++			/*
     ++			 * If we wrote the wrong number of entries in the
     ++			 * header, rewrite it like in fast-import.
     ++			 */
     ++
      +			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
       			fixup_pack_header_footer(fd, hash, pack_tmp_name,
       						 nr_written, hash, offset);
     @@ cache.h: void reset_shared_repository(void);
       extern char *git_replace_ref_base;
       
      -extern int fsync_object_files;
     +-extern int use_fsync;
      +/*
      + * These values are used to help identify parts of a repository to fsync.
      + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
      + * repository and so shouldn't be fsynced.
      + */
      +enum fsync_component {
     -+	FSYNC_COMPONENT_NONE			= 0,
     ++	FSYNC_COMPONENT_NONE,
      +	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
      +	FSYNC_COMPONENT_PACK			= 1 << 1,
      +	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
     @@ cache.h: void reset_shared_repository(void);
       
       enum fsync_method {
       	FSYNC_METHOD_FSYNC,
     +@@ cache.h: enum fsync_method {
     + };
     + 
     + extern enum fsync_method fsync_method;
     ++extern int use_fsync;
     + extern int core_preload_index;
     + extern int precomposed_unicode;
     + extern int protect_hfs;
      @@ cache.h: int copy_file_with_time(const char *dst, const char *src, int mode);
       void write_or_die(int fd, const void *buf, size_t count);
       void fsync_or_die(int fd, const char *);
     @@ csum-file.h: int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint
       void crc32_begin(struct hashfile *);
      
       ## environment.c ##
     -@@ environment.c: const char *git_hooks_path;
     +@@ environment.c: const char *git_attributes_file;
     + const char *git_hooks_path;
       int zlib_compression_level = Z_BEST_SPEED;
       int pack_compression_level = Z_DEFAULT_COMPRESSION;
     +-int fsync_object_files;
     + int use_fsync = -1;
       enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
      +enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
       size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
     @@ midx.c: static int write_midx_internal(const char *object_dir,
      
       ## object-file.c ##
      @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
     - /* Finalize a file on disk, and close it. */
       static void close_loose_object(int fd)
       {
     --	if (fsync_object_files)
     --		fsync_or_die(fd, "loose object file");
     -+	fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
     + 	if (!the_repository->objects->odb->will_destroy) {
     +-		if (fsync_object_files)
     +-			fsync_or_die(fd, "loose object file");
     ++		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
     + 	}
     + 
       	if (close(fd) != 0)
     - 		die_errno(_("error when closing loose object file"));
     - }
      
       ## pack-bitmap-write.c ##
      @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
 3:  2207950beba = 3:  f217dba77a1 core.fsync: new option to harden the index
 4:  a830d177d4c = 4:  5c22a41c1f3 core.fsync: add a `derived-metadata` aggregate option

-- 
gitgitgadget
