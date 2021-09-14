Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF9C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFE4610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 03:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhINDkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 23:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhINDkE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 23:40:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF11C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1369512wml.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ob8GJaYwVsO44Sl/+mthGndzbM9dWRQouJDndWLgQ+w=;
        b=UyLeOW9vOjRp9Qw5oEhTKNLGxgwIxzRyfGNg830YkfQU8cbRmkSYluLZmqV/h3SNqY
         OIHnDUHHEGB7IwDWa8GtTfgs4py2fSaPKwlmSFRPcD1luybGttGo4FlY6tICqJezz/fo
         wOodsFrzI0B/0LHkyE5ME/kYdRd3BDKuy6lEB+9CUDmyjFNz/om0meHf9wzgOaHJCgMq
         36nZV6miV37B6eNkupLU72qpjpw5ZK/EJw1k2/HiMIeMA+Cd9OMxvj9wmzaX9ijcGLo8
         SUGyWvkfaWAlUqD5s1Kdnms1+aHMl/rKyYw8Xy1N05ttUK0/t8gGc8iv1j/J1ZBwqB8e
         jXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ob8GJaYwVsO44Sl/+mthGndzbM9dWRQouJDndWLgQ+w=;
        b=vAxMT3c/2bJqDmPnnpjlVBtQfzOBVeFKWw+7IT5JIvQ8M/bY63inznJAU5l6WPuyB2
         v6F0kFmh/hw4oVdWnYYGxsXLbOe4urBFnDp/fgiq9oD/USFPYyO3NT/78P/Ciu+za1te
         +gHBETV+BXwpaprA2m+bt60M95lMIGQuiXpzAIsBwXwnUwzpyRLrCOI13vAjLUDTBdRw
         VjiC9dFOpBY6OfGIwIlY3X5HQbDhjBEhTxKpazApzFxd2lu8MeX+leWMqQBRXQnaAZ+C
         zRDGubcJb1HFqvgo6OvURdW0IfgbNxQVyhBSudruipHHlCfFPXm7KSxxLlSbkGWZD4cz
         QD5Q==
X-Gm-Message-State: AOAM532p3w5WsT6TDKtS3s3UGv72UPxlIgNnSgd0AkTxd0gT7mYAPLXd
        GoY1xOISACe08XyMAPaPNYnlvdXIocc=
X-Google-Smtp-Source: ABdhPJzjGGxqIMnjqoD7I42kwHfWPUfuLqyo239KMrR3OaxWfVDSIb+TsFv3/stwG2mYow7iK8iVJw==
X-Received: by 2002:a1c:1cc:: with SMTP id 195mr14496055wmb.188.1631590726491;
        Mon, 13 Sep 2021 20:38:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm8972519wrn.85.2021.09.13.20.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:38:45 -0700 (PDT)
Message-Id: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 03:38:39 +0000
Subject: [PATCH v3 0/6] Implement a batched fsync option for core.fsyncObjectFiles
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
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far!

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
  core.fsyncobjectfiles: performance tests for add and stash
  core.fsyncobjectfiles: enable batch mode for testing

 Documentation/config/core.txt       |  26 +++++--
 Makefile                            |   6 ++
 builtin/add.c                       |   3 +-
 builtin/update-index.c              |   3 +
 bulk-checkin.c                      | 103 +++++++++++++++++++++++++---
 bulk-checkin.h                      |   5 +-
 cache.h                             |   8 ++-
 compat/mingw.h                      |   3 +
 compat/win32/flush.c                |  29 ++++++++
 config.c                            |   8 ++-
 config.mak.uname                    |   3 +
 configure.ac                        |   8 +++
 contrib/buildsystems/CMakeLists.txt |   3 +-
 environment.c                       |   2 +-
 git-compat-util.h                   |   7 ++
 object-file.c                       |  22 +-----
 t/perf/lib-unique-files.sh          |  32 +++++++++
 t/perf/p3700-add.sh                 |  43 ++++++++++++
 t/perf/p3900-stash.sh               |  46 +++++++++++++
 wrapper.c                           |  40 +++++++++++
 write-or-die.c                      |   2 +-
 21 files changed, 358 insertions(+), 44 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/perf/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v3
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v2:

 1:  fc3d5a7b635 < -:  ----------- object-file: use futimens rather than utime
 2:  49f72800bfb = 1:  d5893e28df1 bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 3:  2c1c907b12a ! 2:  f8b5b709e9e core.fsyncobjectfiles: batched disk flushes
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +}
      +
      +int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
     -+					      const char *filename)
     ++					      const char *filename, time_t mtime)
      +{
     ++	int do_finalize = 1;
     ++	int ret = 0;
     ++
      +	if (fsync_object_files != FSYNC_OBJECT_FILES_OFF) {
      +		/*
      +		 * If we have a plugged bulk checkin, we issue a call that
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +		    fsync_object_files == FSYNC_OBJECT_FILES_BATCH &&
      +		    git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0) {
      +			add_rename_bulk_checkin(&bulk_fsync_state, tmpfile, filename);
     -+			if (close(fd))
     -+				die_errno(_("error when closing loose object file"));
     -+
     -+			return 0;
     ++			do_finalize = 0;
      +
      +		} else {
      +			fsync_or_die(fd, "loose object file");
     @@ bulk-checkin.c: static int deflate_to_pack(struct bulk_checkin_state *state,
      +	if (close(fd))
      +		die_errno(_("error when closing loose object file"));
      +
     -+	return finalize_object_file(tmpfile, filename);
     ++	if (mtime) {
     ++		struct utimbuf utb;
     ++		utb.actime = mtime;
     ++		utb.modtime = mtime;
     ++		if (utime(tmpfile, &utb) < 0)
     ++			warning_errno(_("failed utime() on %s"), tmpfile);
     ++	}
     ++
     ++	if (do_finalize)
     ++		ret = finalize_object_file(tmpfile, filename);
     ++
     ++	return ret;
      +}
      +
       int index_bulk_checkin(struct object_id *oid,
     @@ bulk-checkin.h
       
       #include "cache.h"
       
     -+int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile, const char *filename);
     ++int fsync_and_close_loose_object_bulk_checkin(int fd, const char *tmpfile,
     ++					      const char *filename, time_t mtime);
      +
       int index_bulk_checkin(struct object_id *oid,
       		       int fd, size_t size, enum object_type type,
     @@ config.mak.uname: ifeq ($(uname_S),Linux)
       	HAVE_GETDELIM = YesPlease
       	SANE_TEXT_GREP=-a
       	FREAD_READS_DIRECTORIES = UnfortunatelyYes
     -@@ config.mak.uname: ifeq ($(uname_S),Darwin)
     - 	COMPAT_OBJS += compat/precompose_utf8.o
     - 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
     - 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
     -+	BASIC_CFLAGS += -DFSYNC_DOESNT_FLUSH=1
     - 	HAVE_BSD_SYSCTL = YesPlease
     - 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
     - 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
      
       ## configure.ac ##
      @@ configure.ac: AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
     @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void
       }
       
      -/* Finalize a file on disk, and close it. */
     --static int close_loose_object(int fd, const char *tmpfile, const char *filename)
     +-static void close_loose_object(int fd)
      -{
      -	if (fsync_object_files)
      -		fsync_or_die(fd, "loose object file");
      -	if (close(fd) != 0)
      -		die_errno(_("error when closing loose object file"));
     --	return finalize_object_file(tmpfile, filename);
      -}
      -
       /* Size of directory component, including the ending '/' */
       static inline int directory_size(const char *filename)
       {
      @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
     - 			warning_errno(_("failed futimes() on %s"), tmp_file.buf);
     - 	}
     + 		die(_("confused by unstable object source data for %s"),
     + 		    oid_to_hex(oid));
       
     --	return close_loose_object(fd, tmp_file.buf, filename.buf);
     -+	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf, filename.buf);
     +-	close_loose_object(fd);
     +-
     +-	if (mtime) {
     +-		struct utimbuf utb;
     +-		utb.actime = mtime;
     +-		utb.modtime = mtime;
     +-		if (utime(tmp_file.buf, &utb) < 0)
     +-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
     +-	}
     +-
     +-	return finalize_object_file(tmp_file.buf, filename.buf);
     ++	return fsync_and_close_loose_object_bulk_checkin(fd, tmp_file.buf,
     ++							 filename.buf, mtime);
       }
       
       static int freshen_loose_object(const struct object_id *oid)
 4:  546ad9c82e8 = 3:  815a862e229 core.fsyncobjectfiles: add windows support for batch mode
 5:  d8843185fe4 = 4:  6b576038986 update-index: use the bulk-checkin infrastructure
 6:  73b5d41be94 = 5:  b7ca3ba9302 core.fsyncobjectfiles: performance tests for add and stash
 -:  ----------- > 6:  55a40fc8fd5 core.fsyncobjectfiles: enable batch mode for testing

-- 
gitgitgadget
