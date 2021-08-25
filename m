Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35097C4320E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF10610FD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 01:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhHYBwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 21:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhHYBwV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 21:52:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB15C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z9so33903716wrh.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c5lN06gX993jA/pQEC6rdkEVfmxYDHYoUISOaCqIL2c=;
        b=nB/nfQThYVfqElwTjKejHJM/3UAAf0EOWGwtl/ioddpm3zS5TQ15qUr3fRs9aYULDc
         4Us1QMa4kznG1cfjpzBarCLe9PzU+CSQnUSkSX3GZhAw/eM/75Wu9+IqoWX1wi9FYPIf
         bbE3Gbpa/NSj8u5JQAToKLGEIOR8VrJ1U6hRpOK7G0GjeJFg0p/w9IhW+v2EivnhWOWs
         q8d09bj7cblun+Qmmt3rhZnfW6X/923l/R+7Fp9ti/xHj9MbuznmZmEQPEL0bOHu82O4
         8kFrcVFpiDwK4s1CsdmsGQnvcZVfnV8Z3pn7OoxIzGLi+utgnrrq2HMLo/tD9PWIF/Au
         UEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c5lN06gX993jA/pQEC6rdkEVfmxYDHYoUISOaCqIL2c=;
        b=sYPxYdq4roM8OwdCX466xacehfYf1JoOOa+ACC10IgCF3ltJ2NqmHPQJz4s9t2gKcV
         pfqyyIACl1DHN2uOVsWLpXj/PnhR5K3Ppkvnxg+Q/WIJjJ09R4vouFARaA6YRdgPnDHo
         hmmVUTwTp5amc8rHHdbnOmg7TYFPryIdJr1TYQGmNmZZzQu157IBJ8gJZADMhpm/zwyR
         pShjcO/XB7XhaPB6C50XvnZ0exdlci2OMWL4jyrQ1OIOsI0NkiOS7NJtQAJYxZWGn/HT
         18AkQDO4r7UhpFkUlUmnwzvBHgR6TW4hc2R4pc4ZGT4EN0L53su9D/QCTXwVa+1PJBXY
         UESQ==
X-Gm-Message-State: AOAM533EXTxUo58WPNsx6p4nOxKSFCjxns4PvFYpc2GsMn7Ze+dGf18V
        iuq2ih1cGMmyThQ+bst6khr/FpcInXo=
X-Google-Smtp-Source: ABdhPJxuEQcjOqMtzrLxeA5RFjK44Mq4TkMMw1i7ZPb1WRLl300bZ3H+xopH5jPvuCbtdGWVXKJuQA==
X-Received: by 2002:adf:f88d:: with SMTP id u13mr21697105wrp.297.1629856295228;
        Tue, 24 Aug 2021 18:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21sm323358wra.92.2021.08.24.18.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 18:51:34 -0700 (PDT)
Message-Id: <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 01:51:32 +0000
Subject: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
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
MacOS, and Linux each offer mechanisms to write data from the filesystem
page cache without initiating a hardware flush.

This patch introduces a new 'core.fsyncObjectFiles = 2' option that
takes advantage of the bulk-checkin infrastructure to batch up hardware
flushes.

When the new mode is enabled we do the following for new objects:

1. Create a tmp_obj_XXXX file and write the object data to it.
2. Issue a pagecache writeback request and wait for it to complete.
3. Record the tmp name and the final name in the bulk-checkin state for
   later name.

At the end of the entire transaction we:
1. Issue a fsync against the lock file to flush the hardware writeback
   cache, which should by now have processed the tmp file writes.
2. Rename all of the temp files to their final names.
3. When updating the index and/or refs, we will issue another fsync
   internal to that operation.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS and HFS+, we
would expect the fsync to trigger a journal writeout so that this
sequence is enough to ensure that the user's data is durable by the time
the git command returns.

This change also updates the MacOS code to trigger a real hardware flush
via fnctl(fd, F_FULLFSYNC) when fsync_or_die is called. Previously, on
MacOS there was no guarantee of durability since a simple fsync(2) call
does not flush any hardware caches.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt |  17 ++++--
 Makefile                      |   4 ++
 builtin/add.c                 |   3 +-
 builtin/update-index.c        |   3 +
 bulk-checkin.c                | 105 +++++++++++++++++++++++++++++++---
 bulk-checkin.h                |   4 +-
 config.c                      |   4 +-
 config.mak.uname              |   2 +
 configure.ac                  |   8 +++
 git-compat-util.h             |   7 +++
 object-file.c                 |  12 +---
 wrapper.c                     |  36 ++++++++++++
 write-or-die.c                |   2 +-
 13 files changed, 177 insertions(+), 30 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a1..3b672c2db67 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -548,12 +548,17 @@ core.whitespace::
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
 core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-+
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+	A boolean value or the number '2', indicating the level of durability
+	applied to object files.
++
+This setting controls how much effort Git makes to ensure that data added to
+the object store are durable in the case of an unclean system shutdown. If
+'false', Git allows data to remain in file system caches according to operating
+system policy, whence they may be lost if the system loses power or crashes. A
+value of 'true' instructs Git to force objects to stable storage immediately
+when they are added to the object store. The number '2' is an experimental
+value that also preserves durability but tries to perform hardware flushes in a
+batch.
 
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/Makefile b/Makefile
index 9573190f1d7..cb950ee43d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1896,6 +1896,10 @@ ifdef HAVE_CLOCK_MONOTONIC
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
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f1f16f2de52..64d025cf49e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "lockfile.h"
 #include "quote.h"
@@ -1152,6 +1153,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
+		plug_bulk_checkin();
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
@@ -1166,6 +1168,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				chmod_path(set_executable_bit, p);
 			free(p);
 		}
+		unplug_bulk_checkin(&lock_file);
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959aa..71004db863e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "lockfile.h"
 #include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
@@ -10,6 +11,17 @@
 #include "packfile.h"
 #include "object-store.h"
 
+struct object_rename {
+	char *src;
+	char *dst;
+};
+
+static struct bulk_rename_state {
+	struct object_rename *renames;
+	uint32_t alloc_renames;
+	uint32_t nr_renames;
+} bulk_rename_state;
+
 static struct bulk_checkin_state {
 	unsigned plugged:1;
 
@@ -21,13 +33,15 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+
+} bulk_checkin_state;
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	struct object_id oid;
 	struct strbuf packname = STRBUF_INIT;
 	int i;
+	unsigned old_plugged;
 
 	if (!state->f)
 		return;
@@ -55,13 +69,42 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 
 clear_exit:
 	free(state->written);
+	old_plugged = state->plugged;
 	memset(state, 0, sizeof(*state));
+	state->plugged = old_plugged;
 
 	strbuf_release(&packname);
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git(the_repository);
 }
 
+static void do_sync_and_rename(struct bulk_rename_state *state, struct lock_file *lock_file)
+{
+	if (state->nr_renames) {
+		int i;
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
+		for (i = 0; i < state->nr_renames; i++) {
+			if (finalize_object_file(state->renames[i].src, state->renames[i].dst))
+				die_errno(_("could not rename '%s'"), state->renames[i].src);
+
+			free(state->renames[i].src);
+			free(state->renames[i].dst);
+		}
+
+		free(state->renames);
+		memset(state, 0, sizeof(*state));
+	}
+}
+
 static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
@@ -256,25 +299,69 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+static void add_rename_bulk_checkin(struct bulk_rename_state *state,
+				    const char *src, const char *dst)
+{
+	struct object_rename *rename;
+
+	ALLOC_GROW(state->renames, state->nr_renames + 1, state->alloc_renames);
+
+	rename = &state->renames[state->nr_renames++];
+	rename->src = xstrdup(src);
+	rename->dst = xstrdup(dst);
+}
+
+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
+					      const char *filename)
+{
+	if (fsync_object_files) {
+		/*
+		 * If we have a plugged bulk checkin, we issue a call that
+		 * cleans the filesystem page cache but avoids a hardware flush
+		 * command. Later on we will issue a single hardware flush
+		 * before renaming files as part of do_sync_and_rename.
+		 */
+		if (bulk_checkin_state.plugged &&
+		    fsync_object_files == 2 &&
+		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
+			add_rename_bulk_checkin(&bulk_rename_state, tmpfile, filename);
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
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_state.plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	bulk_checkin_state.plugged = 1;
 }
 
-void unplug_bulk_checkin(void)
+void unplug_bulk_checkin(struct lock_file *lock_file)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	bulk_checkin_state.plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
+
+	do_sync_and_rename(&bulk_rename_state, lock_file);
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
diff --git a/config.c b/config.c
index f33abeab851..375bdb24b0a 100644
--- a/config.c
+++ b/config.c
@@ -1509,7 +1509,9 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
+		int is_bool;
+
+		fsync_object_files = git_config_bool_or_int(var, value, &is_bool);
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
index 607e9e2f80b..5f04143dde0 100644
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
