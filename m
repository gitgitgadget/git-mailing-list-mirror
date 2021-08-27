Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF1C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A05D60F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhH0Xua (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhH0Xu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9CC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d26so12849132wrc.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cNyjMeE0LGHtjYaczPV1CLhasjBVcA0GBQu/NjJjyfI=;
        b=icemqdk/mFNPPFcYDETqtL1bLAsuCUQb/8os7A71Om2zfRnFu0MPnJxYm4xi9MuN4g
         XDRYSCWahJFLdSfIy7BxQTNpdCP7aVosWZRzF/ozO3ftSVBiXTxkvBqQOGpmWFhZPmhN
         OD7d9PLpOv7icB5Xfg+JFYC0TWymIeoZ3k3aqv4xBzdyfLbXmH57VJpcCIqIbcyZIbDq
         ptam6NymLrR2s3krdt5vKIV7SCQGnOCgCoug+qRHn5oyDQgOh9yFoBj0IeyCOXBnum7i
         10TJl3l56+aaroqPlMF4hjqBLA2cOdqaL1TdfsLVqG6jE2PzqMvcH/MJKi2r3mMgGtfK
         JfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cNyjMeE0LGHtjYaczPV1CLhasjBVcA0GBQu/NjJjyfI=;
        b=Sa6f6YhtMq2Hypt4Uvl9U9XPgTvj2TrFRNrV/jg+WRbs0reeWqax4KhVk5HvxD4e/j
         MgaDyPYHnCdFwsrQopZQa1OOAlsptkTf2iz49tvbw/Wy26j62adMXWfnyWAiu+enHQd7
         EJbbKibX5g4n68JaK1OGudhKqf0rK/FcHvdhLWyUAUxby9+lJwX6fr7XKhLGBAGvFtmN
         nsfZEBCKnzOVoGy1yN080hN1EYQIt4U6fkepUCLs2weXzEvP3RXVTWCGPIxEy7/OReft
         PTqGPFIcje4DeGH4slxAuDss5eO1AivN4SywVhGFdT8NEzHPRkTgQe/NBO2zDx9rAa4o
         IU6A==
X-Gm-Message-State: AOAM532meah1zU1r3/4deihrmgi1UkG9XakriG9t/KekmdmeTMWPO/ZD
        yZpac9qzIJCiH9k7boVwZFAX3jdGpvU=
X-Google-Smtp-Source: ABdhPJxqWsR7Sg23KT5C6h6ISEADX3fwKb4/zaJOF/+45V9iJxjzRKU5P6dEYcn0ZNPVOUQV39GpZA==
X-Received: by 2002:adf:c3c9:: with SMTP id d9mr11915001wrg.339.1630108178430;
        Fri, 27 Aug 2021 16:49:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm2631247wrc.85.2021.08.27.16.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:38 -0700 (PDT)
Message-Id: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:31 +0000
Subject: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far! I've responded to the previous
feedback and changed the patch series a bit.

Changes since v1:

 * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
   to dscho's suggestion, I'm still implementing the Windows version in the
   same patch and I'm not doing autoconf detection since this is a POSIX
   function.

 * Introduce a separate preparatory patch to the bulk-checkin infrastructure
   to separate the 'plugged' variable and rename the 'state' variable, as
   suggested by dscho.

 * Add performance numbers to the commit message of the main bulk fsync
   patch, as suggested by dscho.

 * Add a comment about the non-thread-safety of the bulk-checkin
   infrastructure, as suggested by avarab.

 * Rename the experimental mode to core.fsyncobjectfiles=batch, as suggested
   by dscho and avarab and others.

 * Add more details to Documentation/config/core.txt about the various
   settings and their intended effects, as suggested by avarab.

 * Switch to the string-list API to hold the rename state, as suggested by
   avarab.

 * Create a separate update-index patch to use bulk-checkin as suggested by
   dscho.

 * Add Windows support in the upstream git. This is done in a way that
   should not conflict with git-for-windows.

 * Add new performance tests that shows the delta based on fsync mode.

NOTE: Based on Christoph Hellwig's comments, the 'batch' mode is not correct
on Linux, since sync_file_range does not provide data integrity guarantees.
There is currently no kernel interface suitable to achieve disk flush
batching as is, but he suggested that he might implement a 'syncfs' variant
on top of this patchset. This code is still useful on macOS and Windows, and
the config documentation makes that clear.

Neeraj Singh (6):
  object-file: use futimens rather than utime
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  core.fsyncobjectfiles: add windows support for batch mode
  update-index: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt       | 26 ++++++--
 Makefile                            |  6 ++
 builtin/add.c                       |  3 +-
 builtin/update-index.c              |  3 +
 bulk-checkin.c                      | 92 +++++++++++++++++++++++++----
 bulk-checkin.h                      |  4 +-
 cache.h                             |  8 ++-
 compat/mingw.c                      | 53 +++++++++++------
 compat/mingw.h                      |  5 ++
 compat/win32/flush.c                | 29 +++++++++
 config.c                            |  8 ++-
 config.mak.uname                    |  4 ++
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 environment.c                       |  2 +-
 git-compat-util.h                   |  7 +++
 object-file.c                       | 23 ++------
 t/perf/lib-unique-files.sh          | 32 ++++++++++
 t/perf/p3700-add.sh                 | 43 ++++++++++++++
 t/perf/p3900-stash.sh               | 46 +++++++++++++++
 wrapper.c                           | 40 +++++++++++++
 write-or-die.c                      |  2 +-
 22 files changed, 389 insertions(+), 58 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/perf/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v2
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v1:

 1:  2c1ddef6057 ! 1:  fc3d5a7b635 object-file: use futimes rather than utime
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    object-file: use futimes rather than utime
     +    object-file: use futimens rather than utime
      
     -    Refactor the loose object file creation code and use the futimes(2) API
     -    rather than utime. This should be slightly faster given that we already
     -    have an FD to work with.
     +    Make close_loose_object do all of the steps for syncing and correctly
     +    naming a new loose object so that it can be reimplemented in the
     +    upcoming bulk-fsync mode.
     +
     +    Use futimens, which is available in POSIX.1-2008 to update the file
     +    timestamps. This should be slightly faster than utime, since we have
     +    a file descriptor already available. This change allows us to update
     +    the time before closing, renaming, and potentially fsyincing the file
     +    being refreshed. This code is currently only invoked by git-pack-objects
     +    via force_object_loose.
     +
     +    Implement a futimens shim for the Windows port of Git.
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## compat/mingw.c ##
     +@@ compat/mingw.c: int mingw_chmod(const char *filename, int mode)
     +  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
     +  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
     +  */
     ++
     ++#define UNIX_EPOCH_FILETIME 116444736000000000LL
     ++
     + static inline long long filetime_to_hnsec(const FILETIME *ft)
     + {
     + 	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
     + 	/* Windows to Unix Epoch conversion */
     +-	return winTime - 116444736000000000LL;
     ++	return winTime - UNIX_EPOCH_FILETIME;
     + }
     + 
     + static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
     +@@ compat/mingw.c: static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
     + 	ts->tv_nsec = (hnsec % 10000000) * 100;
     + }
     + 
     ++static inline void timespec_to_filetime(const struct timespec *t, FILETIME *ft)
     ++{
     ++	long long winTime = t->tv_sec * 10000000LL + t->tv_nsec / 100 + UNIX_EPOCH_FILETIME;
     ++	ft->dwLowDateTime = winTime;
     ++	ft->dwHighDateTime = winTime >> 32;
     ++}
     ++
     + /**
     +  * Verifies that safe_create_leading_directories() would succeed.
     +  */
      @@ compat/mingw.c: int mingw_fstat(int fd, struct stat *buf)
       	}
       }
       
      -static inline void time_t_to_filetime(time_t t, FILETIME *ft)
     -+static inline void timeval_to_filetime(const struct timeval *t, FILETIME *ft)
     ++int mingw_futimens(int fd, const struct timespec times[2])
       {
      -	long long winTime = t * 10000000LL + 116444736000000000LL;
     -+	long long winTime = t->tv_sec * 10000000LL + t->tv_usec * 10 + 116444736000000000LL;
     - 	ft->dwLowDateTime = winTime;
     - 	ft->dwHighDateTime = winTime >> 32;
     - }
     - 
     --int mingw_utime (const char *file_name, const struct utimbuf *times)
     -+int mingw_futimes(int fd, const struct timeval times[2])
     - {
     - 	FILETIME mft, aft;
     +-	ft->dwLowDateTime = winTime;
     +-	ft->dwHighDateTime = winTime >> 32;
     ++	FILETIME mft, aft;
      +
      +	if (times) {
     -+		timeval_to_filetime(&times[0], &aft);
     -+		timeval_to_filetime(&times[1], &mft);
     ++		timespec_to_filetime(&times[0], &aft);
     ++		timespec_to_filetime(&times[1], &mft);
      +	} else {
      +		GetSystemTimeAsFileTime(&mft);
      +		aft = mft;
     @@ compat/mingw.c: int mingw_fstat(int fd, struct stat *buf)
      +	}
      +
      +	return 0;
     -+}
     -+
     -+int mingw_utime (const char *file_name, const struct utimbuf *times)
     -+{
     + }
     + 
     +-int mingw_utime (const char *file_name, const struct utimbuf *times)
     ++int mingw_utime(const char *file_name, const struct utimbuf *times)
     + {
     +-	FILETIME mft, aft;
       	int fh, rc;
       	DWORD attrs;
       	wchar_t wfilename[MAX_PATH];
     -+	struct timeval tvs[2];
     ++	struct timespec ts[2];
      +
       	if (xutftowcs_path(wfilename, file_name) < 0)
       		return -1;
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
      -	} else {
      -		GetSystemTimeAsFileTime(&mft);
      -		aft = mft;
     -+		memset(tvs, 0, sizeof(tvs));
     -+		tvs[0].tv_sec = times->actime;
     -+		tvs[1].tv_sec = times->modtime;
     ++		memset(ts, 0, sizeof(ts));
     ++		ts[0].tv_sec = times->actime;
     ++		ts[1].tv_sec = times->modtime;
       	}
      -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
      -		errno = EINVAL;
     @@ compat/mingw.c: int mingw_utime (const char *file_name, const struct utimbuf *ti
      -	} else
      -		rc = 0;
      +
     -+	rc = mingw_futimes(fh, times ? tvs : NULL);
     ++	rc = mingw_futimens(fh, times ? ts : NULL);
       	close(fh);
       
       revert_attrs:
     @@ compat/mingw.h: int mingw_fstat(int fd, struct stat *buf);
       
       int mingw_utime(const char *file_name, const struct utimbuf *times);
       #define utime mingw_utime
     -+int mingw_futimes(int fd, const struct timeval times[2]);
     -+#define futimes mingw_futimes
     ++int mingw_futimens(int fd, const struct timespec times[2]);
     ++#define futimens mingw_futimens
       size_t mingw_strftime(char *s, size_t max,
       		   const char *format, const struct tm *tm);
       #define strftime mingw_strftime
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      -		utb.modtime = mtime;
      -		if (utime(tmp_file.buf, &utb) < 0)
      -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
     -+		struct timeval tvs[2] = {0};
     -+		tvs[0].tv_sec = mtime;
     -+		tvs[1].tv_sec = mtime;
     -+		if (futimes(fd, tvs) < 0)
     ++		struct timespec ts[2] = {0};
     ++		ts[0].tv_sec = mtime;
     ++		ts[1].tv_sec = mtime;
     ++		if (futimens(fd, ts) < 0)
      +			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
       	}
       
 -:  ----------- > 2:  49f72800bfb bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 2:  d1e68d4a2af ! 3:  2c1c907b12a core.fsyncobjectfiles: batch disk flushes
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    core.fsyncobjectfiles: batch disk flushes
     +    core.fsyncobjectfiles: batched disk flushes
      
          When adding many objects to a repo with core.fsyncObjectFiles set to
          true, the cost of fsync'ing each object file can become prohibitive.
      
          One major source of the cost of fsync is the implied flush of the
          hardware writeback cache within the disk drive. Fortunately, Windows,
     -    MacOS, and Linux each offer mechanisms to write data from the filesystem
     +    macOS, and Linux each offer mechanisms to write data from the filesystem
          page cache without initiating a hardware flush.
      
     -    This patch introduces a new 'core.fsyncObjectFiles = 2' option that
     +    This patch introduces a new 'core.fsyncObjectFiles = batch' option that
          takes advantage of the bulk-checkin infrastructure to batch up hardware
          flushes.
      
     @@ Commit message
          1. Create a tmp_obj_XXXX file and write the object data to it.
          2. Issue a pagecache writeback request and wait for it to complete.
          3. Record the tmp name and the final name in the bulk-checkin state for
     -       later name.
     +       later rename.
      
          At the end of the entire transaction we:
          1. Issue a fsync against the lock file to flush the hardware writeback
             cache, which should by now have processed the tmp file writes.
          2. Rename all of the temp files to their final names.
     -    3. When updating the index and/or refs, we will issue another fsync
     -       internal to that operation.
     +    3. When updating the index and/or refs, we assume that Git will issue
     +       another fsync internal to that operation.
      
          On a filesystem with a singular journal that is updated during name
          operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
     @@ Commit message
          sequence is enough to ensure that the user's data is durable by the time
          the git command returns.
      
     -    This change also updates the MacOS code to trigger a real hardware flush
     +    This change also updates the macOS code to trigger a real hardware flush
          via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
     -    MacOS there was no guarantee of durability since a simple fsync(2) call
     +    macOS there was no guarantee of durability since a simple fsync(2) call
          does not flush any hardware caches.
      
     +    _Performance numbers_:
     +
     +    Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
     +    Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
     +    Windows - Same host as Linux, a preview version of Windows 11.
     +              This number is from a patch later in the series.
     +
     +    Adding 500 files to the repo with 'git add' Times reported in seconds.
     +
     +    core.fsyncObjectFiles | Linux | Mac   | Windows
     +    ----------------------|-------|-------|--------
     +                    false | 0.06  |  0.35 | 0.61
     +                    true  | 1.88  | 11.18 | 2.47
     +                    batch | 0.15  |  0.41 | 1.53
     +
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Documentation/config/core.txt ##
     @@ Documentation/config/core.txt: core.whitespace::
      -data writes properly, but can be useful for filesystems that do not use
      -journalling (traditional UNIX filesystems) or that only journal metadata
      -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
     -+	A boolean value or the number '2', indicating the level of durability
     -+	applied to object files.
     ++	A value indicating the level of effort Git will expend in
     ++	trying to make objects added to the repo durable in the event
     ++	of an unclean system shutdown. This setting currently only
     ++	controls the object store, so updates to any refs or the
     ++	index may not be equally durable.
      ++
     -+This setting controls how much effort Git makes to ensure that data added to
     -+the object store are durable in the case of an unclean system shutdown. If
     -+'false', Git allows data to remain in file system caches according to operating
     -+system policy, whence they may be lost if the system loses power or crashes. A
     -+value of 'true' instructs Git to force objects to stable storage immediately
     -+when they are added to the object store. The number '2' is an experimental
     -+value that also preserves durability but tries to perform hardware flushes in a
     -+batch.
     ++* `false` allows data to remain in file system caches according to
     ++  operating system policy, whence it may be lost if the system loses power
     ++  or crashes.
     ++* `true` triggers a data integrity flush for each object added to the
     ++  object store. This is the safest setting that is likely to ensure durability
     ++  across all operating systems and file systems that honor the 'fsync' system
     ++  call. However, this setting comes with a significant performance cost on
     ++  common hardware.
     ++* `batch` enables an experimental mode that uses interfaces available in some
     ++  operating systems to write object data with a minimal set of FLUSH CACHE
     ++  (or equivalent) commands sent to the storage controller. If the operating
     ++  system interfaces are not available, this mode behaves the same as `true`.
     ++  This mode is expected to be safe on macOS for repos stored on HFS+ or APFS
     ++  filesystems and on Windows for repos stored on NTFS or ReFS.
       
       core.preloadIndex::
       	Enable parallel index preload for operations like 'git diff'
      
       ## Makefile ##
     +@@ Makefile: all::
     + #
     + # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
     + #
     ++# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
     ++#
     + # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
     + # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
     + #
      @@ Makefile: ifdef HAVE_CLOCK_MONOTONIC
       	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
       endif
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       finish:
       	if (write_locked_index(&the_index, &lock_file,
      
     - ## builtin/update-index.c ##
     -@@
     -  */
     - #define USE_THE_INDEX_COMPATIBILITY_MACROS
     - #include "cache.h"
     -+#include "bulk-checkin.h"
     - #include "config.h"
     - #include "lockfile.h"
     - #include "quote.h"
     -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 		struct strbuf unquoted = STRBUF_INIT;
     - 
     - 		setup_work_tree();
     -+		plug_bulk_checkin();
     - 		while (getline_fn(&buf, stdin) != EOF) {
     - 			char *p;
     - 			if (!nul_term_line && buf.buf[0] == '"') {
     -@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 				chmod_path(set_executable_bit, p);
     - 			free(p);
     - 		}
     -+		unplug_bulk_checkin(&lock_file);
     - 		strbuf_release(&unquoted);
     - 		strbuf_release(&buf);
     - 	}
     -
       ## bulk-checkin.c ##
      @@
        */
     @@ bulk-checkin.c
       #include "repository.h"
       #include "csum-file.h"
       #include "pack.h"
     -@@
     + #include "strbuf.h"
     ++#include "string-list.h"
       #include "packfile.h"
       #include "object-store.h"
       
     -+struct object_rename {
     -+	char *src;
     -+	char *dst;
     -+};
     -+
     -+static struct bulk_rename_state {
     -+	struct object_rename *renames;
     -+	uint32_t alloc_renames;
     -+	uint32_t nr_renames;
     -+} bulk_rename_state;
     -+
     - static struct bulk_checkin_state {
     - 	unsigned plugged:1;
     + static int bulk_checkin_plugged;
       
     -@@ bulk-checkin.c: static struct bulk_checkin_state {
     - 	struct pack_idx_entry **written;
     - 	uint32_t alloc_written;
     - 	uint32_t nr_written;
     --} state;
     ++static struct string_list bulk_fsync_state = STRING_LIST_INIT_DUP;
      +
     -+} bulk_checkin_state;
     - 
     - static void finish_bulk_checkin(struct bulk_checkin_state *state)
     - {
     - 	struct object_id oid;
     - 	struct strbuf packname = STRBUF_INIT;
     - 	int i;
     -+	unsigned old_plugged;
     - 
     - 	if (!state->f)
     - 		return;
     -@@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin_state *state)
     - 
     - clear_exit:
     - 	free(state->written);
     -+	old_plugged = state->plugged;
     - 	memset(state, 0, sizeof(*state));
     -+	state->plugged = old_plugged;
     - 
     - 	strbuf_release(&packname);
     - 	/* Make objects we just wrote available to ourselves */
     + static struct bulk_checkin_state {
     + 	char *pack_tmp_name;
     + 	struct hashfile *f;
     +@@ bulk-checkin.c: clear_exit:
       	reprepare_packed_git(the_repository);
       }
       
     -+static void do_sync_and_rename(struct bulk_rename_state *state, struct lock_file *lock_file)
     ++static void do_sync_and_rename(struct string_list *fsync_state, struct lock_file *lock_file)
      +{
     -+	if (state->nr_renames) {
     -+		int i;
     ++	if (fsync_state->nr) {
     ++		struct string_list_item *rename;
      +
      +		/*
      +		 * Issue a full hardware flush against the lock file to ensure
     @@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin_state *state
      +		 */
      +		fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_path(lock_file));
      +
     -+		for (i = 0; i < state->nr_renames; i++) {
     -+			if (finalize_object_file(state->renames[i].src, state->renames[i].dst))
     -+				die_errno(_("could not rename '%s'"), state->renames[i].src);
     ++		for_each_string_list_item(rename, fsync_state) {
     ++			const char *src = rename->string;
     ++			const char *dst = rename->util;
      +
     -+			free(state->renames[i].src);
     -+			free(state->renames[i].dst);
     ++			if (finalize_object_file(src, dst))
     ++				die_errno(_("could not rename '%s' to '%s'"), src, dst);
      +		}
      +
     -+		free(state->renames);
     -+		memset(state, 0, sizeof(*state));
     ++		string_list_clear(fsync_state, 1);
      +	}
      +}
      +
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
       	return 0;
       }
       
     -+static void add_rename_bulk_checkin(struct bulk_rename_state *state,
     ++static void add_rename_bulk_checkin(struct string_list *fsync_state,
      +				    const char *src, const char *dst)
      +{
     -+	struct object_rename *rename;
     -+
     -+	ALLOC_GROW(state->renames, state->nr_renames + 1, state->alloc_renames);
     -+
     -+	rename = &state->renames[state->nr_renames++];
     -+	rename->src = xstrdup(src);
     -+	rename->dst = xstrdup(dst);
     ++	string_list_insert(fsync_state, src)->util = xstrdup(dst);
      +}
      +
      +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
      +					      const char *filename)
      +{
     -+	if (fsync_object_files) {
     ++	if (fsync_object_files != FSYNC_OBJECT_FILES_OFF) {
      +		/*
      +		 * If we have a plugged bulk checkin, we issue a call that
      +		 * cleans the filesystem page cache but avoids a hardware flush
      +		 * command. Later on we will issue a single hardware flush
      +		 * before renaming files as part of do_sync_and_rename.
      +		 */
     -+		if (bulk_checkin_state.plugged &&
     -+		    fsync_object_files == 2 &&
     ++		if (bulk_checkin_plugged &&
     ++		    fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
      +		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
     -+			add_rename_bulk_checkin(&bulk_rename_state, tmpfile, filename);
     ++			add_rename_bulk_checkin(&bulk_fsync_state, tmpfile, filename);
      +			if (close(fd))
      +				die_errno(_("error when closing loose object file"));
      +
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
       		       const char *path, unsigned flags)
     - {
     --	int status = deflate_to_pack(&state, oid, fd, size, type,
     -+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
     - 				     path, flags);
     --	if (!state.plugged)
     --		finish_bulk_checkin(&state);
     -+	if (!bulk_checkin_state.plugged)
     -+		finish_bulk_checkin(&bulk_checkin_state);
     - 	return status;
     - }
     - 
     - void plug_bulk_checkin(void)
     - {
     --	state.plugged = 1;
     -+	bulk_checkin_state.plugged = 1;
     +@@ bulk-checkin.c: void plug_bulk_checkin(void)
     + 	bulk_checkin_plugged = 1;
       }
       
      -void unplug_bulk_checkin(void)
      +void unplug_bulk_checkin(struct lock_file *lock_file)
       {
     --	state.plugged = 0;
     --	if (state.f)
     --		finish_bulk_checkin(&state);
     -+	bulk_checkin_state.plugged = 0;
     -+	if (bulk_checkin_state.f)
     -+		finish_bulk_checkin(&bulk_checkin_state);
     + 	assert(bulk_checkin_plugged);
     + 	bulk_checkin_plugged = 0;
     + 	if (bulk_checkin_state.f)
     + 		finish_bulk_checkin(&bulk_checkin_state);
      +
     -+	do_sync_and_rename(&bulk_rename_state, lock_file);
     ++	do_sync_and_rename(&bulk_fsync_state, lock_file);
       }
      
       ## bulk-checkin.h ##
     @@ bulk-checkin.h
       
       #endif
      
     + ## cache.h ##
     +@@ cache.h: void reset_shared_repository(void);
     + extern int read_replace_refs;
     + extern char *git_replace_ref_base;
     + 
     +-extern int fsync_object_files;
     ++enum FSYNC_OBJECT_FILES_MODE {
     ++    FSYNC_OBJECT_FILES_OFF,
     ++    FSYNC_OBJECT_FILES_ON,
     ++    FSYNC_OBJECT_FILES_BATCH
     ++};
     ++
     ++extern enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
     + extern int core_preload_index;
     + extern int precomposed_unicode;
     + extern int protect_hfs;
     +
       ## config.c ##
      @@ config.c: static int git_default_core_config(const char *var, const char *value, void *cb)
       	}
       
       	if (!strcmp(var, "core.fsyncobjectfiles")) {
      -		fsync_object_files = git_config_bool(var, value);
     -+		int is_bool;
     -+
     -+		fsync_object_files = git_config_bool_or_int(var, value, &is_bool);
     ++		if (!value)
     ++			return config_error_nonbool(var);
     ++		if (!strcasecmp(value, "batch"))
     ++			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
     ++		else
     ++			fsync_object_files = git_config_bool(var, value)
     ++				? FSYNC_OBJECT_FILES_ON : FSYNC_OBJECT_FILES_OFF;
       		return 0;
       	}
       
     @@ configure.ac: AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
       # Define NO_SETITIMER if you don't have setitimer.
       GIT_CHECK_FUNC(setitimer,
      
     + ## environment.c ##
     +@@ environment.c: const char *git_hooks_path;
     + int zlib_compression_level = Z_BEST_SPEED;
     + int core_compression_level;
     + int pack_compression_level = Z_DEFAULT_COMPRESSION;
     +-int fsync_object_files;
     ++enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
     + size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
     + size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
     + size_t delta_base_cache_limit = 96 * 1024 * 1024;
     +
       ## git-compat-util.h ##
      @@ git-compat-util.h: __attribute__((format (printf, 1, 2))) NORETURN
       void BUG(const char *fmt, ...);
 -:  ----------- > 4:  546ad9c82e8 core.fsyncobjectfiles: add windows support for batch mode
 -:  ----------- > 5:  d8843185fe4 update-index: use the bulk-checkin infrastructure
 -:  ----------- > 6:  73b5d41be94 core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
