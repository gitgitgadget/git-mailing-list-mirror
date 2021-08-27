Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EDEC4320E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B9960EBA
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhH0Xuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhH0Xub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:50:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D56C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so8133243wmh.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MwyAq5tQxJQ7clw9aLkPfVMTXXOJE6Nf8ZujzYuNAfk=;
        b=QQ4WwXJOlVnDvT/M0SdI/ZfTGj9MXnH8eENfQxebJt+ZtudMhGW+agxO5LSMnawF9t
         YGHfIgHhjoZiudDbtF+DwxLi9aEpwzyeZbO1o6qgnAT69//24x4c3ZmkW5Ckii3+pTyS
         nWKx1PYeS2K32x3Pz6EV2gVf+OdCDrhyeKwgVODnxdO24uwBe0wjcfBxUs9SKUNpEur6
         m55lA2okHkATLZcigoi/YqVlZ4vrquhJZhGWxBvJFNHsImS+jR+FqOle+xGXQJUucm9/
         ndVCBWQP4r352HbS9DPA9QNz2TTuT1mC2Nun/IIgmSTSuficRp1V9zVgoUdEymX/AYsm
         WHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MwyAq5tQxJQ7clw9aLkPfVMTXXOJE6Nf8ZujzYuNAfk=;
        b=hSsvcfdwXroKSp+p7l/YCMl65whZUQoBltaL/nRAe4kmEs74HxDihIzri0u2C4UW6O
         Gm8NwioOpCX5p+QIWy2e4mnKoXbg2Ekh7mRsi3kyNi7Mm4Jhqo0HH+StodZ43vkkiHvg
         TgNU59lx/r1XaHIOxiC+im6C8uCvmvaj6yiewFyMnYSZkoEKCxBQvz8Rv6IEaPr9BTYd
         /ys5bH3Q1+dT24ipUfID4sCsauNZ9SOA7gt36zJc9y0a2ULZEIkrMvci6ZLcNG+BAJnG
         3BnVkgYXXzPRIQztDLg7QC4xGEz17N1Y8rSgZLk6QdDHeBZJ8iqLnX7DTlAWHevaOKcy
         7RdQ==
X-Gm-Message-State: AOAM5304oQ5uUsdLgZ3u5YuS05lDLyPBZ2cnxLZ4jznkVLLXuxTRD//k
        ZoV4a533BqO3v6db29DiBMb7xTRDeHU=
X-Google-Smtp-Source: ABdhPJxXvzued8LUl4T4TEONtREZvrgJTUvFIN/8956qb7uQ7s69azkAY169F5XJ0EDZOoVCpLagCg==
X-Received: by 2002:a05:600c:3397:: with SMTP id o23mr20701714wmp.38.1630108180092;
        Fri, 27 Aug 2021 16:49:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm7705277wrq.80.2021.08.27.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:49:39 -0700 (PDT)
Message-Id: <2c1c907b12a5a8592136dcf775c9c61fac986952.1630108177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
        <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Aug 2021 23:49:34 +0000
Subject: [PATCH v2 3/6] core.fsyncobjectfiles: batched disk flushes
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
        <avarab@gmail.com>, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When adding many objects to a repo with core.fsyncObjectFiles set to
true, the cost of fsync'ing each object file can become prohibitive.

One major source of the cost of fsync is the implied flush of the
hardware writeback cache within the disk drive. Fortunately, Windows,
macOS, and Linux each offer mechanisms to write data from the filesystem
page cache without initiating a hardware flush.

This patch introduces a new 'core.fsyncObjectFiles = batch' option that
takes advantage of the bulk-checkin infrastructure to batch up hardware
flushes.

When the new mode is enabled we do the following for new objects:

1. Create a tmp_obj_XXXX file and write the object data to it.
2. Issue a pagecache writeback request and wait for it to complete.
3. Record the tmp name and the final name in the bulk-checkin state for
   later rename.

At the end of the entire transaction we:
1. Issue a fsync against the lock file to flush the hardware writeback
   cache, which should by now have processed the tmp file writes.
2. Rename all of the temp files to their final names.
3. When updating the index and/or refs, we assume that Git will issue
   another fsync internal to that operation.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
would expect the fsync to trigger a journal writeout so that this
sequence is enough to ensure that the user's data is durable by the time
the git command returns.

This change also updates the macOS code to trigger a real hardware flush
via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
macOS there was no guarantee of durability since a simple fsync(2) call
does not flush any hardware caches.

_Performance numbers_:

Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
Windows - Same host as Linux, a preview version of Windows 11.
	  This number is from a patch later in the series.

Adding 500 files to the repo with 'git add' Times reported in seconds.

core.fsyncObjectFiles | Linux | Mac   | Windows
----------------------|-------|-------|--------
                false | 0.06  |  0.35 | 0.61
                true  | 1.88  | 11.18 | 2.47
                batch | 0.15  |  0.41 | 1.53

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 26 ++++++++++---
 Makefile                      |  6 +++
 builtin/add.c                 |  3 +-
 bulk-checkin.c                | 70 ++++++++++++++++++++++++++++++++++-
 bulk-checkin.h                |  4 +-
 cache.h                       |  8 +++-
 config.c                      |  8 +++-
 config.mak.uname              |  2 +
 configure.ac                  |  8 ++++
 environment.c                 |  2 +-
 git-compat-util.h             |  7 ++++
 object-file.c                 | 12 +-----
 wrapper.c                     | 36 ++++++++++++++++++
 write-or-die.c                |  2 +-
 14 files changed, 170 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..0006d90980d 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -548,12 +548,26 @@ core.whitespace::
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-+
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+	A value indicating the level of effort Git will expend in
+	trying to make objects added to the repo durable in the event
+	of an unclean system shutdown. This setting currently only
+	controls the object store, so updates to any refs or the
+	index may not be equally durable.
++
+* `false` allows data to remain in file system caches according to
+  operating system policy, whence it may be lost if the system loses power
+  or crashes.
+* `true` triggers a data integrity flush for each object added to the
+  object store. This is the safest setting that is likely to ensure durability
+  across all operating systems and file systems that honor the 'fsync' system
+  call. However, this setting comes with a significant performance cost on
+  common hardware.
+* `batch` enables an experimental mode that uses interfaces available in some
+  operating systems to write object data with a minimal set of FLUSH CACHE
+  (or equivalent) commands sent to the storage controller. If the operating
+  system interfaces are not available, this mode behaves the same as `true`.
+  This mode is expected to be safe on macOS for repos stored on HFS+ or APFS
+  filesystems and on Windows for repos stored on NTFS or ReFS.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/Makefile b/Makefile
index 9573190f1d7..143d30f04cb 100644
--- a/Makefile
+++ b/Makefile
@@ -406,6 +406,8 @@ all::
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
 #
+# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
+#
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
@@ -1896,6 +1898,10 @@ ifdef HAVE_CLOCK_MONOTONIC
 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
 endif
 
+ifdef HAVE_SYNC_FILE_RANGE
+	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
+endif
+
 ifdef NEEDS_LIBRT
 	EXTLIBS += -lrt
 endif
diff --git a/builtin/add.c b/builtin/add.c
index 09e684585d9..c58dfcd4bc3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -670,7 +670,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
-	unplug_bulk_checkin();
+
+	unplug_bulk_checkin(&lock_file);
 
 finish:
 	if (write_locked_index(&the_index, &lock_file,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index f117d62c908..47b42f610c0 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,15 +3,19 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "lockfile.h"
 #include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "packfile.h"
 #include "object-store.h"
 
 static int bulk_checkin_plugged;
 
+static struct string_list bulk_fsync_state = STRING_LIST_INIT_DUP;
+
 static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
@@ -62,6 +66,32 @@ clear_exit:
 	reprepare_packed_git(the_repository);
 }
 
+static void do_sync_and_rename(struct string_list *fsync_state, struct lock_file *lock_file)
+{
+	if (fsync_state->nr) {
+		struct string_list_item *rename;
+
+		/*
+		 * Issue a full hardware flush against the lock file to ensure
+		 * that all objects are durable before any renames occur.
+		 * The code in fsync_and_close_loose_object_bulk_checkin has
+		 * already ensured that writeout has occurred, but it has not
+		 * flushed any writeback cache in the storage hardware.
+		 */
+		fsync_or_die(get_lock_file_fd(lock_file), get_lock_file_path(lock_file));
+
+		for_each_string_list_item(rename, fsync_state) {
+			const char *src = rename->string;
+			const char *dst = rename->util;
+
+			if (finalize_object_file(src, dst))
+				die_errno(_("could not rename '%s' to '%s'"), src, dst);
+		}
+
+		string_list_clear(fsync_state, 1);
+	}
+}
+
 static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
@@ -256,6 +286,42 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+static void add_rename_bulk_checkin(struct string_list *fsync_state,
+				    const char *src, const char *dst)
+{
+	string_list_insert(fsync_state, src)->util = xstrdup(dst);
+}
+
+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
+					      const char *filename)
+{
+	if (fsync_object_files != FSYNC_OBJECT_FILES_OFF) {
+		/*
+		 * If we have a plugged bulk checkin, we issue a call that
+		 * cleans the filesystem page cache but avoids a hardware flush
+		 * command. Later on we will issue a single hardware flush
+		 * before renaming files as part of do_sync_and_rename.
+		 */
+		if (bulk_checkin_plugged &&
+		    fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
+		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
+			add_rename_bulk_checkin(&bulk_fsync_state, tmpfile, filename);
+			if (close(fd))
+				die_errno(_("error when closing loose object file"));
+
+			return 0;
+
+		} else {
+			fsync_or_die(fd, "loose object file");
+		}
+	}
+
+	if (close(fd))
+		die_errno(_("error when closing loose object file"));
+
+	return finalize_object_file(tmpfile, filename);
+}
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
@@ -273,10 +339,12 @@ void plug_bulk_checkin(void)
 	bulk_checkin_plugged = 1;
 }
 
-void unplug_bulk_checkin(void)
+void unplug_bulk_checkin(struct lock_file *lock_file)
 {
 	assert(bulk_checkin_plugged);
 	bulk_checkin_plugged = 0;
 	if (bulk_checkin_state.f)
 		finish_bulk_checkin(&bulk_checkin_state);
+
+	do_sync_and_rename(&bulk_fsync_state, lock_file);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b26f3dc3b74..8efb01ed669 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -6,11 +6,13 @@
 
 #include "cache.h"
 
+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile, const char *filename);
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
 
 void plug_bulk_checkin(void);
-void unplug_bulk_checkin(void);
+void unplug_bulk_checkin(struct lock_file *);
 
 #endif
diff --git a/cache.h b/cache.h
index bd4869beee4..cde6c6ae6b1 100644
--- a/cache.h
+++ b/cache.h
@@ -985,7 +985,13 @@ void reset_shared_repository(void);
 extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
-extern int fsync_object_files;
+enum FSYNC_OBJECT_FILES_MODE {
+    FSYNC_OBJECT_FILES_OFF,
+    FSYNC_OBJECT_FILES_ON,
+    FSYNC_OBJECT_FILES_BATCH
+};
+
+extern enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index f33abeab851..ab1980f8fec 100644
--- a/config.c
+++ b/config.c
@@ -1509,7 +1509,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcasecmp(value, "batch"))
+			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
+		else
+			fsync_object_files = git_config_bool(var, value)
+				? FSYNC_OBJECT_FILES_ON : FSYNC_OBJECT_FILES_OFF;
 		return 0;
 	}
 
diff --git a/config.mak.uname b/config.mak.uname
index 69413fb3dc0..8c07f2265a8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -53,6 +53,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_MONOTONIC = YesPlease
 	# -lrt is needed for clock_gettime on glibc <= 2.16
 	NEEDS_LIBRT = YesPlease
+	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
@@ -133,6 +134,7 @@ ifeq ($(uname_S),Darwin)
 	COMPAT_OBJS += compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
+	BASIC_CFLAGS += -DFSYNC_DOESNT_FLUSH=1
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
diff --git a/configure.ac b/configure.ac
index 031e8d3fee8..c711037d625 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1090,6 +1090,14 @@ AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
 	[AC_MSG_RESULT([no])
 	HAVE_CLOCK_MONOTONIC=])
 GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
+
+#
+# Define HAVE_SYNC_FILE_RANGE=YesPlease if sync_file_range is available.
+GIT_CHECK_FUNC(sync_file_range,
+	[HAVE_SYNC_FILE_RANGE=YesPlease],
+	[HAVE_SYNC_FILE_RANGE])
+GIT_CONF_SUBST([HAVE_SYNC_FILE_RANGE])
+
 #
 # Define NO_SETITIMER if you don't have setitimer.
 GIT_CHECK_FUNC(setitimer,
diff --git a/environment.c b/environment.c
index d6b22ede7ea..3e23eafff80 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
-int fsync_object_files;
+enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300ab..d14e2436276 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1210,6 +1210,13 @@ __attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...);
 #endif
 
+enum fsync_action {
+    FSYNC_WRITEOUT_ONLY,
+    FSYNC_HARDWARE_FLUSH
+};
+
+int git_fsync(int fd, enum fsync_action action);
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/object-file.c b/object-file.c
index 5421811273e..94a63809613 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1859,16 +1859,6 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	return 0;
 }
 
-/* Finalize a file on disk, and close it. */
-static int close_loose_object(int fd, const char *tmpfile, const char *filename)
-{
-	if (fsync_object_files)
-		fsync_or_die(fd, "loose object file");
-	if (close(fd) != 0)
-		die_errno(_("error when closing loose object file"));
-	return finalize_object_file(tmpfile, filename);
-}
-
 /* Size of directory component, including the ending '/' */
 static inline int directory_size(const char *filename)
 {
@@ -1982,7 +1972,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
 	}
 
-	return close_loose_object(fd, tmp_file.buf, filename.buf);
+	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf, filename.buf);
 }
 
 static int freshen_loose_object(const struct object_id *oid)
diff --git a/wrapper.c b/wrapper.c
index 563ad590df1..37a8b61a7df 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -538,6 +538,42 @@ int xmkstemp_mode(char *filename_template, int mode)
 	return fd;
 }
 
+int git_fsync(int fd, enum fsync_action action)
+{
+	if (action == FSYNC_WRITEOUT_ONLY) {
+#ifdef __APPLE__
+		/*
+		 * on Mac OS X, fsync just causes filesystem cache writeback but does not
+		 * flush hardware caches.
+		 */
+		return fsync(fd);
+#endif
+
+#ifdef HAVE_SYNC_FILE_RANGE
+		/*
+		 * On linux 2.6.17 and above, sync_file_range is the way to issue
+		 * a writeback without a hardware flush. An offset of 0 and size of 0
+		 * indicates writeout of the entire file and the wait flags ensure that all
+		 * dirty data is written to the disk (potentially in a disk-side cache)
+		 * before we continue.
+		 */
+
+		return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
+						 SYNC_FILE_RANGE_WRITE |
+						 SYNC_FILE_RANGE_WAIT_AFTER);
+#endif
+
+		errno = ENOSYS;
+		return -1;
+	}
+
+#ifdef __APPLE__
+	return fcntl(fd, F_FULLFSYNC);
+#else
+	return fsync(fd);
+#endif
+}
+
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
diff --git a/write-or-die.c b/write-or-die.c
index d33e68f6abb..8f53953d4ab 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -57,7 +57,7 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
 
 void fsync_or_die(int fd, const char *msg)
 {
-	while (fsync(fd) < 0) {
+	while (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0) {
 		if (errno != EINTR)
 			die_errno("fsync error on '%s'", msg);
 	}
-- 
gitgitgadget

