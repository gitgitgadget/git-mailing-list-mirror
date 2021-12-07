Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BADC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 02:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhLGCuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLGCuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 21:50:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C09C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 18:46:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso833098wmh.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 18:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RPfpEVekp1LApSQluW+CkeHNxZOpgnEWX0gcI+TylyU=;
        b=PFL0ftuB+n67dJ3Dm1NO9NK+Ajmf5rnZAFsQYbiuXgp2OBbUUSyUIh8fWSBcYIygu/
         sm2G8Xy9zfvJhKZiQGts2tw9g29KfAX/xCSSEw0yRwKfsgqLqzzQ+Zlyfu+sTXThuvjF
         hzkz7oKJQcLXfkUasHNlfdghqxsWyTZCXOhNy2JdGS23ks9kTJcQ5b9Qlp+CkyEIN8lG
         DZCFkHMAFe7ht1mIGo8OrSipO7QpH2wxzheKBKYQGpINPUfUJTSU3AXdTJXmfqgsfV7b
         HG1IDpTzDxJWqLIR6PNe9yMQzIEM5BIW4+Urw8t5YlLL/lpmGAbEJIyI8/DDAXGFFXsZ
         qwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RPfpEVekp1LApSQluW+CkeHNxZOpgnEWX0gcI+TylyU=;
        b=Vs6f1x1vgsfftCmNjcKM4C8DM8E2QTSH18Yw+NMavt2daXYV2wCp7DSnB7+XYyPcsz
         9VZwewJUxpT3ROUBPECxFQ570P5pdr3y3JGNzAdo8OrlbJYFH+QLnqB42fCg8VTk6qMZ
         lolrMqc3F92y4RdDySClN9cg9ogpdD7ff1O4amGFdW1VW2qzqH1o1/8fDEVmLgI0iR4T
         kbjNFxe2WYaXet073vJDxsXYtzxdbxSdR6RyGsx0owoqkJuUxTBiGXVENhU4JC1WuFWW
         bZzszQ42+DTX2fBLiQwXKzKwdNAT0f7111xN+K5SdfRBHbWtyfqSIl5dKBuHel340HXQ
         oSJg==
X-Gm-Message-State: AOAM532v/4PVYBS2lsvi+Dhp/lXU6wpFhvRGMIgnGGLaJT3fHTktxTb+
        HVMjzRU/369bd0DFcKnN2rtpZ3SaZXo=
X-Google-Smtp-Source: ABdhPJzQ8lk3z7ZTLKdzAL1EMf2BrGCQpXGQO1yhKebdfHEYRkXYvG/5ocd/xxtNg3kp6ihlsmw0HA==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr3285231wmq.25.1638845212655;
        Mon, 06 Dec 2021 18:46:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm12881315wru.40.2021.12.06.18.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 18:46:52 -0800 (PST)
Message-Id: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 02:46:48 +0000
Subject: [PATCH v2 0/3] A design for future-proofing fsync() configuration
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

core.fsyncobjectfiles is removed and will issue a deprecation warning if
it's seen.

I'd like to get agreement on this direction before submitting batch mode to
the list. The batch mode series is available to view at
https://github.com/neerajsi-msft/git/pull/1.

Please see [1], [2], and [3] for discussions that led to this series.

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

Neeraj Singh (3):
  core.fsyncmethod: add writeout-only mode
  core.fsync: introduce granular fsync control
  core.fsync: new option to harden the index

 Documentation/config/core.txt       | 35 +++++++++---
 Makefile                            |  6 ++
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              |  8 ++-
 bulk-checkin.c                      |  5 +-
 cache.h                             | 48 +++++++++++++++-
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 config.c                            | 89 ++++++++++++++++++++++++++++-
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
 wrapper.c                           | 56 ++++++++++++++++++
 write-or-die.c                      | 10 ++--
 25 files changed, 344 insertions(+), 43 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1093

Range-diff vs v1:

 1:  527380ddc3f ! 1:  e79522cbdd4 fsync: add writeout-only mode for fsyncing repo data
     @@ Metadata
      Author: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Commit message ##
     -    fsync: add writeout-only mode for fsyncing repo data
     +    core.fsyncmethod: add writeout-only mode
     +
     +    This commit introduces the `core.fsyncmethod` configuration
     +    knob, which can currently be set to `fsync` or `writeout-only`.
      
          The new writeout-only mode attempts to tell the operating system to
          flush its in-memory page cache to the storage hardware without issuing a
     @@ Documentation/config/core.txt: core.whitespace::
      +	using fsync and related primitives.
      ++
      +* `fsync` uses the fsync() system call or platform equivalents.
     -+* `writeout-only` issues requests to send the writes to the storage
     -+  hardware, but does not send any FLUSH CACHE request. If the operating system
     -+  does not support the required interfaces, this falls back to fsync().
     ++* `writeout-only` issues pagecache writeback requests, but depending on the
     ++  filesystem and storage hardware, data added to the repository may not be
     ++  durable in the event of a system crash. This is the default mode on macOS.
      +
       core.fsyncObjectFiles::
       	This boolean will enable 'fsync()' when writing object files.
       +
      
     + ## Makefile ##
     +@@ Makefile: all::
     + #
     + # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
     + #
     ++# Define HAVE_SYNC_FILE_RANGE if your platform has sync_file_range.
     ++#
     + # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
     + # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
     + #
     +@@ Makefile: ifdef HAVE_CLOCK_MONOTONIC
     + 	BASIC_CFLAGS += -DHAVE_CLOCK_MONOTONIC
     + endif
     + 
     ++ifdef HAVE_SYNC_FILE_RANGE
     ++	BASIC_CFLAGS += -DHAVE_SYNC_FILE_RANGE
     ++endif
     ++
     + ifdef NEEDS_LIBRT
     + 	EXTLIBS += -lrt
     + endif
     +
       ## cache.h ##
      @@ cache.h: extern int read_replace_refs;
       extern char *git_replace_ref_base;
 2:  23311a10142 ! 2:  ff80a94bf9a core.fsync: introduce granular fsync control
     @@ Commit message
          knob which can be used to control how components of the
          repository are made durable on disk.
      
     -    This setting allows future extensibility of components
     -    that could be synced in two ways:
     +    This setting allows future extensibility of the list of
     +    syncable components:
          * We issue a warning rather than an error for unrecognized
            components, so new configs can be used with old Git versions.
          * We support negation, so users can choose one of the default
            aggregate options and then remove components that they don't
     -      want.
     +      want. The user would then harden any new components added in
     +      a Git version update.
      
     -    This also support the common request of doing absolutely no
     +    This also supports the common request of doing absolutely no
          fysncing with the `core.fsync=none` value, which is expected
          to make the test suite faster.
      
     -    This commit introduces the new ability for the user to harden
     -    the index, which is a requirement for being able to actually
     -    find a file that has been added to the repo and then deleted
     -    from the working tree.
     -
          Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
      
       ## Documentation/config/core.txt ##
     @@ Documentation/config/core.txt: core.whitespace::
      +	hardened via the core.fsyncMethod when created or modified. You can
      +	disable hardening of any component by prefixing it with a '-'. Later
      +	items take precedence over earlier ones in the list. For example,
     -+	`core.fsync=all,-index` means "harden everything except the index".
     -+	Items that are not hardened may be lost in the event of an unclean
     -+	system shutdown.
     ++	`core.fsync=all,-pack-metadata` means "harden everything except pack
     ++	metadata." Items that are not hardened may be lost in the event of an
     ++	unclean system shutdown.
      ++
      +* `none` disables fsync completely. This must be specified alone.
      +* `loose-object` hardens objects added to the repo in loose-object form.
      +* `pack` hardens objects added to the repo in packfile form.
      +* `pack-metadata` hardens packfile bitmaps and indexes.
      +* `commit-graph` hardens the commit graph file.
     -+* `index` hardens the index when it is modified.
      +* `objects` is an aggregate option that includes `loose-objects`, `pack`,
      +  `pack-metadata`, and `commit-graph`.
      +* `default` is an aggregate option that is equivalent to `objects,-loose-object`
     @@ Documentation/config/core.txt: core.whitespace::
       	A value indicating the strategy Git will use to harden repository data
       	using fsync and related primitives.
      @@ Documentation/config/core.txt: core.fsyncMethod::
     -   hardware, but does not send any FLUSH CACHE request. If the operating system
     -   does not support the required interfaces, this falls back to fsync().
     +   filesystem and storage hardware, data added to the repository may not be
     +   durable in the event of a system crash. This is the default mode on macOS.
       
      -core.fsyncObjectFiles::
      -	This boolean will enable 'fsync()' when writing object files.
     @@ builtin/fast-import.c: static void end_packfile(void)
       
       		close_pack_windows(pack_data);
      -		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
     -+		finalize_hashfile(pack_file, cur_pack_oid.hash, REPO_COMPONENT_PACK, 0);
     ++		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
       		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
       					 pack_data->pack_name, object_count,
       					 cur_pack_oid.hash, pack_size);
     @@ builtin/index-pack.c: static void conclude_pack(int fix_thin_pack, const char *c
       		stop_progress_msg(&progress, msg.buf);
       		strbuf_release(&msg);
      -		finalize_hashfile(f, tail_hash, 0);
     -+		finalize_hashfile(f, tail_hash, REPO_COMPONENT_PACK, 0);
     ++		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
       		hashcpy(read_hash, pack_hash);
       		fixup_pack_header_footer(output_fd, pack_hash,
       					 curr_pack, nr_objects,
     @@ builtin/index-pack.c: static void final(const char *final_pack_name, const char
       		close(input_fd);
       	} else {
      -		fsync_or_die(output_fd, curr_pack_name);
     -+		fsync_component_or_die(REPO_COMPONENT_PACK, output_fd, curr_pack_name);
     ++		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name);
       		err = close(output_fd);
       		if (err)
       			die_errno(_("error while closing pack file"));
     @@ builtin/pack-objects.c: static void write_pack_file(void)
       		 */
       		if (pack_to_stdout) {
      -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
     -+			finalize_hashfile(f, hash, REPO_COMPONENT_NONE,
     ++			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
      +					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
       		} else if (nr_written == nr_remaining) {
      -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
     -+			finalize_hashfile(f, hash, REPO_COMPONENT_PACK,
     ++			finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK,
      +					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
       		} else {
      -			int fd = finalize_hashfile(f, hash, 0);
     -+			int fd = finalize_hashfile(f, hash, REPO_COMPONENT_PACK, 0);
     ++			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
       			fixup_pack_header_footer(fd, hash, pack_tmp_name,
       						 nr_written, hash, offset);
       			close(fd);
     @@ bulk-checkin.c: static void finish_bulk_checkin(struct bulk_checkin_state *state
       		goto clear_exit;
       	} else if (state->nr_written == 1) {
      -		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
     -+		finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK,
     ++		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
      +				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
       	} else {
      -		int fd = finalize_hashfile(state->f, hash, 0);
     -+		int fd = finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK, 0);
     ++		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
       		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
       					 state->nr_written, hash,
       					 state->offset);
     @@ cache.h: void reset_shared_repository(void);
      -extern int fsync_object_files;
      +/*
      + * These values are used to help identify parts of a repository to fsync.
     -+ * REPO_COMPONENT_NONE identifies data that will not be a persistent part of the
     ++ * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
      + * repository and so shouldn't be fsynced.
      + */
     -+enum repo_component {
     -+	REPO_COMPONENT_NONE			= 0,
     -+	REPO_COMPONENT_LOOSE_OBJECT		= 1 << 0,
     -+	REPO_COMPONENT_PACK			= 1 << 1,
     -+	REPO_COMPONENT_PACK_METADATA		= 1 << 2,
     -+	REPO_COMPONENT_COMMIT_GRAPH		= 1 << 3,
     -+	REPO_COMPONENT_INDEX			= 1 << 4,
     ++enum fsync_component {
     ++	FSYNC_COMPONENT_NONE			= 0,
     ++	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
     ++	FSYNC_COMPONENT_PACK			= 1 << 1,
     ++	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
     ++	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
      +};
      +
     -+#define FSYNC_COMPONENTS_DEFAULT (REPO_COMPONENT_PACK | \
     -+				  REPO_COMPONENT_PACK_METADATA | \
     -+				  REPO_COMPONENT_COMMIT_GRAPH)
     ++#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
     ++				  FSYNC_COMPONENT_PACK_METADATA | \
     ++				  FSYNC_COMPONENT_COMMIT_GRAPH)
      +
     -+#define FSYNC_COMPONENTS_OBJECTS (REPO_COMPONENT_LOOSE_OBJECT | \
     -+				  REPO_COMPONENT_PACK | \
     -+				  REPO_COMPONENT_PACK_METADATA | \
     -+				  REPO_COMPONENT_COMMIT_GRAPH)
     ++#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
     ++				  FSYNC_COMPONENT_PACK | \
     ++				  FSYNC_COMPONENT_PACK_METADATA | \
     ++				  FSYNC_COMPONENT_COMMIT_GRAPH)
      +
     -+#define FSYNC_COMPONENTS_ALL (REPO_COMPONENT_LOOSE_OBJECT | \
     -+			      REPO_COMPONENT_PACK | \
     -+			      REPO_COMPONENT_PACK_METADATA | \
     -+			      REPO_COMPONENT_COMMIT_GRAPH | \
     -+			      REPO_COMPONENT_INDEX)
     ++#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
     ++			      FSYNC_COMPONENT_PACK | \
     ++			      FSYNC_COMPONENT_PACK_METADATA | \
     ++			      FSYNC_COMPONENT_COMMIT_GRAPH)
      +
      +
      +/*
      + * A bitmask indicating which components of the repo should be fsynced.
      + */
     -+extern enum repo_component fsync_components;
     ++extern enum fsync_component fsync_components;
       
       enum fsync_method {
       	FSYNC_METHOD_FSYNC,
     @@ cache.h: int copy_file_with_time(const char *dst, const char *src, int mode);
       void write_or_die(int fd, const void *buf, size_t count);
       void fsync_or_die(int fd, const char *);
       
     -+inline void fsync_component_or_die(enum repo_component component, int fd, const char *msg)
     ++inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
      +{
      +	if (fsync_components & component)
      +		fsync_or_die(fd, msg);
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
       
       	close_commit_graph(ctx->r->objects);
      -	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
     -+	finalize_hashfile(f, file_hash, REPO_COMPONENT_COMMIT_GRAPH,
     ++	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
      +			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
       	free_chunkfile(cf);
       
     @@ config.c: static int git_parse_maybe_bool_text(const char *value)
       
      +static const struct fsync_component_entry {
      +	const char *name;
     -+	enum repo_component component_bits;
     ++	enum fsync_component component_bits;
      +} fsync_component_table[] = {
     -+	{ "loose-object", REPO_COMPONENT_LOOSE_OBJECT },
     -+	{ "pack", REPO_COMPONENT_PACK },
     -+	{ "pack-metadata", REPO_COMPONENT_PACK_METADATA },
     -+	{ "commit-graph", REPO_COMPONENT_COMMIT_GRAPH },
     -+	{ "index", REPO_COMPONENT_INDEX },
     ++	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
     ++	{ "pack", FSYNC_COMPONENT_PACK },
     ++	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
     ++	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
      +	{ "objects", FSYNC_COMPONENTS_OBJECTS },
      +	{ "default", FSYNC_COMPONENTS_DEFAULT },
      +	{ "all", FSYNC_COMPONENTS_ALL },
      +};
      +
     -+static enum repo_component parse_fsync_components(const char *var, const char *string)
     ++static enum fsync_component parse_fsync_components(const char *var, const char *string)
      +{
     -+	enum repo_component output = 0;
     ++	enum fsync_component output = 0;
      +
      +	if (!strcmp(string, "none"))
      +		return output;
     @@ csum-file.c: static void free_hashfile(struct hashfile *f)
       
      -int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
      +int finalize_hashfile(struct hashfile *f, unsigned char *result,
     -+		      enum repo_component component, unsigned int flags)
     ++		      enum fsync_component component, unsigned int flags)
       {
       	int fd;
       
     @@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned char *result, un
       			die_errno("%s: sha1 file error on close", f->name);
      
       ## csum-file.h ##
     +@@
     + #ifndef CSUM_FILE_H
     + #define CSUM_FILE_H
     + 
     ++#include "cache.h"
     + #include "hash.h"
     + 
     + struct progress;
      @@ csum-file.h: int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
       struct hashfile *hashfd(int fd, const char *name);
       struct hashfile *hashfd_check(const char *name);
       struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
      -int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
     -+int finalize_hashfile(struct hashfile *, unsigned char *, enum repo_component, unsigned int);
     ++int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
       void hashwrite(struct hashfile *, const void *, unsigned int);
       void hashflush(struct hashfile *f);
       void crc32_begin(struct hashfile *);
     @@ environment.c: const char *git_hooks_path;
       int zlib_compression_level = Z_BEST_SPEED;
       int pack_compression_level = Z_DEFAULT_COMPRESSION;
       enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
     -+enum repo_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
     ++enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
       size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
       size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
       size_t delta_base_cache_limit = 96 * 1024 * 1024;
     @@ midx.c: static int write_midx_internal(const char *object_dir,
       	write_chunkfile(cf, &ctx);
       
      -	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
     -+	finalize_hashfile(f, midx_hash, REPO_COMPONENT_PACK_METADATA,
     ++	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
      +			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
       	free_chunkfile(cf);
       
     @@ object-file.c: int hash_object_file(const struct git_hash_algo *algo, const void
       {
      -	if (fsync_object_files)
      -		fsync_or_die(fd, "loose object file");
     -+	fsync_component_or_die(REPO_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
     ++	fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
       	if (close(fd) != 0)
       		die_errno(_("error when closing loose object file"));
       }
     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct pack_idx_entry **index,
       		write_hash_cache(f, index, index_nr);
       
      -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
     -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
     ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
      +			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
       
       	if (adjust_shared_perm(tmp_file.buf))
     @@ pack-write.c: const char *write_idx_file(const char *index_name, struct pack_idx
       	hashwrite(f, sha1, the_hash_algo->rawsz);
      -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
      -				    ((opts->flags & WRITE_IDX_VERIFY)
     -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
     +-				    ? 0 : CSUM_FSYNC));
     ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
      +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
     -+			  ((opts->flags & WRITE_IDX_VERIFY)
     - 				    ? 0 : CSUM_FSYNC));
     ++			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
       	return index_name;
       }
     + 
      @@ pack-write.c: const char *write_rev_file_order(const char *rev_name,
       	if (rev_name && adjust_shared_perm(rev_name) < 0)
       		die(_("failed to make %s readable"), rev_name);
       
      -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
      -				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
     -+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
     ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
      +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
      +			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
       
     @@ pack-write.c: void fixup_pack_header_footer(int pack_fd,
       	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
       	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
      -	fsync_or_die(pack_fd, pack_name);
     -+	fsync_component_or_die(REPO_COMPONENT_PACK, pack_fd, pack_name);
     ++	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
       }
       
       char *index_pack_lockfile(int ip_out, int *is_well_formed)
      
       ## read-cache.c ##
     -@@ read-cache.c: static int record_ieot(void)
     -  * rely on it.
     -  */
     - static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     --			  int strip_extensions)
     -+			  int strip_extensions, unsigned flags)
     - {
     - 	uint64_t start = getnanotime();
     - 	struct hashfile *f;
     -@@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
     - 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
     - 	int drop_cache_tree = istate->drop_cache_tree;
     - 	off_t offset;
     -+	int csum_fsync_flag;
     - 	int ieot_entries = 1;
     - 	struct index_entry_offset_table *ieot = NULL;
     - 	int nr, nr_threads;
      @@ read-cache.c: static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
       			return -1;
       	}
       
      -	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
     -+	csum_fsync_flag = 0;
     -+	if (!alternate_index_output && (flags & COMMIT_LOCK))
     -+		csum_fsync_flag = CSUM_FSYNC;
     -+
     -+	finalize_hashfile(f, istate->oid.hash, REPO_COMPONENT_INDEX,
     -+			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
     -+
     ++	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_IN_STREAM);
       	if (close_tempfile_gently(tempfile)) {
       		error(_("could not close '%s'"), get_tempfile_path(tempfile));
       		return -1;
     -@@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
     - 	 */
     - 	trace2_region_enter_printf("index", "do_write_index", the_repository,
     - 				   "%s", get_lock_file_path(lock));
     --	ret = do_write_index(istate, lock->tempfile, 0);
     -+	ret = do_write_index(istate, lock->tempfile, 0, flags);
     - 	trace2_region_leave_printf("index", "do_write_index", the_repository,
     - 				   "%s", get_lock_file_path(lock));
     - 
     -@@ read-cache.c: static int clean_shared_index_files(const char *current_hex)
     - }
     - 
     - static int write_shared_index(struct index_state *istate,
     --			      struct tempfile **temp)
     -+			      struct tempfile **temp, unsigned flags)
     - {
     - 	struct split_index *si = istate->split_index;
     - 	int ret, was_full = !istate->sparse_index;
     -@@ read-cache.c: static int write_shared_index(struct index_state *istate,
     - 
     - 	trace2_region_enter_printf("index", "shared/do_write_index",
     - 				   the_repository, "%s", get_tempfile_path(*temp));
     --	ret = do_write_index(si->base, *temp, 1);
     -+	ret = do_write_index(si->base, *temp, 1, flags);
     - 	trace2_region_leave_printf("index", "shared/do_write_index",
     - 				   the_repository, "%s", get_tempfile_path(*temp));
     - 
     -@@ read-cache.c: int write_locked_index(struct index_state *istate, struct lock_file *lock,
     - 			ret = do_write_locked_index(istate, lock, flags);
     - 			goto out;
     - 		}
     --		ret = write_shared_index(istate, &temp);
     -+		ret = write_shared_index(istate, &temp, flags);
     - 
     - 		saved_errno = errno;
     - 		if (is_tempfile_active(temp))
 -:  ----------- > 3:  86e39b8f8d1 core.fsync: new option to harden the index

-- 
gitgitgadget
