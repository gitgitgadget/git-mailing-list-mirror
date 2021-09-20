Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC186C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8517611ED
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347833AbhIUCVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhIUBuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA3C06AB3F
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so33744198wrb.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K3R+mxHj21M01UiIbbHonkXTFEDUTunM64ndcnL4RV0=;
        b=cJgYxYPfDqyek+R74Z3u3QMhVIs7p6tQpGgQQ8E4N6ewRhEDfTb+3aIjsyvK8aIM0U
         Gn577bvc/NE2uNbv0tkuJkOvBv5p2BH/uCjnyL6L4SpGNWgz3w/b1Qowc2Bq/yxkSlZE
         3SAwLVaKv6IFnRzqR1bd/jxH67X8m3jw72OElnM/1VUg2bV6RHey1oSG3ZUmACQphwt7
         6lHqBQQIg6BScFhEX81d7rTn2noz3JymfrPKFGp/nCkJU/PYfyr4G2UlrEIVxR0emGAp
         3p58vT36stRwpqXVTag+zEkWJUIU9+EEFW3j/XhUoNxpltJgfQLqj0u3fiAWHpIaDMUR
         dyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K3R+mxHj21M01UiIbbHonkXTFEDUTunM64ndcnL4RV0=;
        b=pMiJIz++uTnrvkWd/Th2+L6UJ24CAlIpEbFOWkvDFh3z6Vqa4l59/QxPBBj9u0GNDy
         Ha8UoieNo2o6/qZJxas3FkV5NutHJEvU00iPgVaQ/mmq+f9d7AB3cG/qGX4ylpoaXknn
         D9kHCVhx3OUIOYs6Ok/ECmDMn/AisYhyaS8kzN6jwSOKG/viqDE8eOGJMBSoYZYQXbsc
         yVtW16rAcF/b9mn5v+/ccOirM1L5zDMSgxt8j2ClgsJGa2nWzZ55qTkiiYFdrsJklH2G
         SUVjkUW9/3apuYA9ZwP9ijvQxIX+ZDx0Y8GLOzpCDWXSY3emZIr/G6opXT9Vw9plbaex
         MM3w==
X-Gm-Message-State: AOAM531Xok83jax5UJkR8kAW5KVa1J6QxrszyVwx3Yf7toM9Af2OMJOh
        7IVDPdw9N2OtOmBN5QQhQWX7/q/DEFg=
X-Google-Smtp-Source: ABdhPJzvHV2/bnwe8ieUzB9ceG7OTF5wXBg4+GjUWTfJ7/z928znDlAUqiH9EW0AhVVX26nRfSPx4A==
X-Received: by 2002:a7b:cf2f:: with SMTP id m15mr1193767wmg.37.1632176113095;
        Mon, 20 Sep 2021 15:15:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z133sm912900wmc.45.2021.09.20.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 15:15:12 -0700 (PDT)
Message-Id: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 22:15:05 +0000
Subject: [PATCH v4 0/6] Implement a batched fsync option for core.fsyncObjectFiles
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
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far! Changes since v3:

 * Fix core.fsyncobjectfiles option parsing as suggested by Junio: We now
   accept no value to mean "true" and we require 'batch' to be lowercase.

 * Leave the default fsync mode as 'false'. Git for windows can change its
   default when this series makes it over to that fork.

 * Use a switch statement in git_fsync, as suggested by Junio.

 * Add regression test cases for core.fsyncobjectfiles=batch. This should
   keep the batch functionality basically working in upstream git even if
   few users adopt batch mode initially. I expect git-for-windows will
   provide a good baking area for the new mode.

Changes since v2:

 * Removed an unused Makefile define (FSYNC_DOESNT_FLUSH) that slipped in
   from an intermediate change.

 * Drop the futimens part of the patch and return to just calling utime, now
   within the new bulk_checkin code. The utime to futimens change seemed to
   be problematic for some platforms (thanks Randall Becker), and is really
   orthogonal to the rest of the patch series.

 * (Optional commit) Enable batch mode by default so that we can shake loose
   any issues relating to deferring the renames until the
   unplug_bulk_checkin.

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
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  core.fsyncobjectfiles: add windows support for batch mode
  update-index: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: tests for batch mode
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt       |  26 +++++--
 Makefile                            |   6 ++
 builtin/add.c                       |   3 +-
 builtin/update-index.c              |   3 +
 bulk-checkin.c                      | 103 +++++++++++++++++++++++++---
 bulk-checkin.h                      |   5 +-
 cache.h                             |   8 ++-
 compat/mingw.h                      |   3 +
 compat/win32/flush.c                |  29 ++++++++
 config.c                            |   7 +-
 config.mak.uname                    |   3 +
 configure.ac                        |   8 +++
 contrib/buildsystems/CMakeLists.txt |   3 +-
 environment.c                       |   2 +-
 git-compat-util.h                   |   7 ++
 object-file.c                       |  22 +-----
 t/lib-unique-files.sh               |  34 +++++++++
 t/perf/p3700-add.sh                 |  43 ++++++++++++
 t/perf/p3900-stash.sh               |  46 +++++++++++++
 t/t3700-add.sh                      |  11 +++
 t/t3903-stash.sh                    |  14 ++++
 wrapper.c                           |  48 +++++++++++++
 write-or-die.c                      |   2 +-
 23 files changed, 392 insertions(+), 44 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v4
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v3:

 1:  d5893e28df1 = 1:  d5893e28df1 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 2:  f8b5b709e9e ! 2:  12cad737635 core.fsyncobjectfiles: batched disk flushes
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
       	if (!strcmp(var, "core.fsyncobjectfiles")) {
      -		fsync_object_files = git_config_bool(var, value);
     -+		if (!value)
     -+			return config_error_nonbool(var);
     -+		if (!strcasecmp(value, "batch"))
     ++		if (value && !strcmp(value, "batch"))
      +			fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
     ++		else if (git_config_bool(var, value))
     ++			fsync_object_files = FSYNC_OBJECT_FILES_ON;
      +		else
     -+			fsync_object_files = git_config_bool(var, value)
     -+				? FSYNC_OBJECT_FILES_ON : FSYNC_OBJECT_FILES_OFF;
     ++			fsync_object_files = FSYNC_OBJECT_FILES_OFF;
       		return 0;
       	}
       
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
       
      +int git_fsync(int fd, enum fsync_action action)
      +{
     -+	if (action == FSYNC_WRITEOUT_ONLY) {
     ++	switch (action) {
     ++	case FSYNC_WRITEOUT_ONLY:
     ++
      +#ifdef __APPLE__
      +		/*
     -+		 * on Mac OS X, fsync just causes filesystem cache writeback but does not
     ++		 * on macOS, fsync just causes filesystem cache writeback but does not
      +		 * flush hardware caches.
      +		 */
      +		return fsync(fd);
     @@ wrapper.c: int xmkstemp_mode(char *filename_template, int mode)
      +
      +		errno = ENOSYS;
      +		return -1;
     -+	}
     ++
     ++	case FSYNC_HARDWARE_FLUSH:
      +
      +#ifdef __APPLE__
     -+	return fcntl(fd, F_FULLFSYNC);
     ++		return fcntl(fd, F_FULLFSYNC);
      +#else
     -+	return fsync(fd);
     ++		return fsync(fd);
      +#endif
     ++
     ++	default:
     ++		BUG("unexpected git_fsync(%d) call", action);
     ++	}
     ++
      +}
      +
       static int warn_if_unremovable(const char *op, const char *file, int rc)
 3:  815a862e229 ! 3:  a5b3e21b762 core.fsyncobjectfiles: add windows support for batch mode
     @@ wrapper.c: int git_fsync(int fd, enum fsync_action action)
      +
       		errno = ENOSYS;
       		return -1;
     - 	}
     + 
 4:  6b576038986 = 4:  f7f756f3932 update-index: use the bulk-checkin infrastructure
 -:  ----------- > 5:  afb0028e796 core.fsyncobjectfiles: tests for batch mode
 5:  b7ca3ba9302 ! 6:  3e6b80b5fa2 core.fsyncobjectfiles: performance tests for add and stash
     @@ Commit message
      
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
     - ## t/perf/lib-unique-files.sh (new) ##
     -@@
     -+# Helper to create files with unique contents
     -+
     -+test_create_unique_files_base__=$(date -u)
     -+test_create_unique_files_counter__=0
     -+
     -+# Create multiple files with unique contents. Takes the number of
     -+# directories, the number of files in each directory, and the base
     -+# directory.
     -+#
     -+# test_create_unique_files 2 3 . -- Creates 2 directories with 3 files
     -+#				    each in the current directory, all
     -+#				    with unique contents.
     -+
     -+test_create_unique_files() {
     -+	test "$#" -ne 3 && BUG "3 param"
     -+
     -+	local dirs=$1
     -+	local files=$2
     -+	local basedir=$3
     -+
     -+	for i in $(test_seq $dirs)
     -+	do
     -+		local dir=$basedir/dir$i
     -+
     -+		mkdir -p "$dir" > /dev/null
     -+		for j in $(test_seq $files)
     -+		do
     -+			test_create_unique_files_counter__=$((test_create_unique_files_counter__ + 1))
     -+			echo "$test_create_unique_files_base__.$test_create_unique_files_counter__"  >"$dir/file$j.txt"
     -+		done
     -+	done
     -+}
     -
       ## t/perf/p3700-add.sh (new) ##
      @@
      +#!/bin/sh
     @@ t/perf/p3700-add.sh (new)
      +
      +. ./perf-lib.sh
      +
     -+. $TEST_DIRECTORY/perf/lib-unique-files.sh
     ++. $TEST_DIRECTORY/lib-unique-files.sh
      +
      +test_perf_default_repo
      +test_checkout_worktree
     @@ t/perf/p3700-add.sh (new)
      +# We need to create the files each time we run the perf test, but
      +# we do not want to measure the cost of creating the files, so run
      +# the tet once.
     -+if test "$GIT_PERF_REPEAT_COUNT" -ne 1
     ++if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
      +then
      +	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
      +	GIT_PERF_REPEAT_COUNT=1
     @@ t/perf/p3900-stash.sh (new)
      +
      +. ./perf-lib.sh
      +
     -+. $TEST_DIRECTORY/perf/lib-unique-files.sh
     ++. $TEST_DIRECTORY/lib-unique-files.sh
      +
      +test_perf_default_repo
      +test_checkout_worktree
     @@ t/perf/p3900-stash.sh (new)
      +# We need to create the files each time we run the perf test, but
      +# we do not want to measure the cost of creating the files, so run
      +# the tet once.
     -+if test "$GIT_PERF_REPEAT_COUNT" -ne 1
     ++if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
      +then
      +	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
      +	GIT_PERF_REPEAT_COUNT=1
 6:  55a40fc8fd5 < -:  ----------- core.fsyncobjectfiles: enable batch mode for testing

-- 
gitgitgadget
