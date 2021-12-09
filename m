Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD7C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbhLIBA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbhLIBAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:00:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F02C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 16:57:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so7051030wrw.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 16:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OyIj+QLSMYS4QH2WFq0NHThTdQ8m3DE6fDnvHyxHqi4=;
        b=U4x/z8caZvNO/CLeCMuxsZ0I4382Fny9rcTfTAqQMP6NHI5Na+8hk3fOJrx3UwKaw1
         Vdh6bbV86T795LhyCjGUJkDTC/EKLllMOn2sm09H5le2srRgSZqEvPGWD20BNo3zBbIf
         6y5KNU9la69xfrMcIwEtIQdN/x/P1j5ub022rfZzUu9ePpGmBZBzNNWgnVT3PJmL/An9
         2mqGOm1AnIyUHlkaHA/LnhCbgjsdOmiaO5z9sC2AjQE6nhcAxx4ZML5uynTUZ5MaVdMI
         MSLii72JAEqYJwyEtC78Vi8TnKOare+d62m8pvGve+E/fRK+2G3c+nZWwskXxUGGZqk9
         S5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OyIj+QLSMYS4QH2WFq0NHThTdQ8m3DE6fDnvHyxHqi4=;
        b=TsWK5V1nTlNA9CI5/VD9i0okCEtr31mMOTR+MkxoWdvpWREjciJyqQX5e5SYcqvcW7
         0sXAmzjkF3FYyH7RKfKvN3U7lAMfhct8BHRh/UOqKCcpsOr+fZmVLoe0hdxU0dK5UwCo
         1q4fdbxqWavEMS9xBMg+rTqffpfDRdfKC3+xAiYQ84Ac7PaD2OcTnAr2BrM0hCD07K/x
         jdIH5AZAtNf0+PntXal2z/luh3XzZvT/4+OCG7VySjqURJ6mGg5RYvAz8LJTn5R2gt22
         rg6+HbGlgDkbPbfMKS9sXmwhDAj9mK79fr41y+nnsPaX5KTA0RhFZv5ng8h3D0jsZZl9
         JICQ==
X-Gm-Message-State: AOAM533qtZHrncTlCXmqEZuzCuSXdjACiQgl7bFgyL35LuX75o4bVA44
        jryTT8RnGdfUUe6+MHWclaflhO4CDNc=
X-Google-Smtp-Source: ABdhPJwQsMkH0bMkl76nx6pSni1jY4wyMEfXAOxg9Futv+kkveB0PvGvn3p7Xc2xw3GfpkMabr9Vcw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr2572657wrm.49.1639011438245;
        Wed, 08 Dec 2021 16:57:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm4074674wrv.94.2021.12.08.16.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:57:17 -0800 (PST)
Message-Id: <080be1a6f642c64b5cbd74c612027245026833d3.1639011434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
        <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 00:57:11 +0000
Subject: [PATCH v3 2/4] core.fsync: introduce granular fsync control
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit introduces the `core.fsync` configuration
knob which can be used to control how components of the
repository are made durable on disk.

This setting allows future extensibility of the list of
syncable components:
* We issue a warning rather than an error for unrecognized
  components, so new configs can be used with old Git versions.
* We support negation, so users can choose one of the default
  aggregate options and then remove components that they don't
  want. The user would then harden any new components added in
  a Git version update.

This also supports the common request of doing absolutely no
fysncing with the `core.fsync=none` value, which is expected
to make the test suite faster.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 27 +++++++++----
 builtin/fast-import.c         |  2 +-
 builtin/index-pack.c          |  4 +-
 builtin/pack-objects.c        |  8 ++--
 bulk-checkin.c                |  5 ++-
 cache.h                       | 39 +++++++++++++++++-
 commit-graph.c                |  3 +-
 config.c                      | 76 ++++++++++++++++++++++++++++++++++-
 csum-file.c                   |  5 ++-
 csum-file.h                   |  3 +-
 environment.c                 |  1 +
 midx.c                        |  3 +-
 object-file.c                 |  3 +-
 pack-bitmap-write.c           |  3 +-
 pack-write.c                  | 13 +++---
 read-cache.c                  |  2 +-
 16 files changed, 164 insertions(+), 33 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index dbb134f7136..4f1747ec871 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,25 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsync::
+	A comma-separated list of parts of the repository which should be
+	hardened via the core.fsyncMethod when created or modified. You can
+	disable hardening of any component by prefixing it with a '-'. Later
+	items take precedence over earlier ones in the list. For example,
+	`core.fsync=all,-pack-metadata` means "harden everything except pack
+	metadata." Items that are not hardened may be lost in the event of an
+	unclean system shutdown.
++
+* `none` disables fsync completely. This must be specified alone.
+* `loose-object` hardens objects added to the repo in loose-object form.
+* `pack` hardens objects added to the repo in packfile form.
+* `pack-metadata` hardens packfile bitmaps and indexes.
+* `commit-graph` hardens the commit graph file.
+* `objects` is an aggregate option that includes `loose-objects`, `pack`,
+  `pack-metadata`, and `commit-graph`.
+* `default` is an aggregate option that is equivalent to `objects,-loose-object`
+* `all` is an aggregate option that syncs all individual components above.
+
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
@@ -556,14 +575,6 @@ core.fsyncMethod::
   filesystem and storage hardware, data added to the repository may not be
   durable in the event of a system crash. This is the default mode on macOS.
 
-core.fsyncObjectFiles::
-	This boolean will enable 'fsync()' when writing object files.
-+
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
-
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
 +
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 20406f67754..e27a4580f85 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -856,7 +856,7 @@ static void end_packfile(void)
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
+		finalize_hashfile(pack_file, cur_pack_oid.hash, FSYNC_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
 					 pack_data->pack_name, object_count,
 					 cur_pack_oid.hash, pack_size);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7dc..c32534c13b4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1286,7 +1286,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		finalize_hashfile(f, tail_hash, 0);
+		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
@@ -1508,7 +1508,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (!from_stdin) {
 		close(input_fd);
 	} else {
-		fsync_or_die(output_fd, curr_pack_name);
+		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name);
 		err = close(output_fd);
 		if (err)
 			die_errno(_("error while closing pack file"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 857be7826f3..916c55d6ce9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1204,11 +1204,13 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
+			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
+					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+			finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK,
+					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 		} else {
-			int fd = finalize_hashfile(f, hash, 0);
+			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
 			fixup_pack_header_footer(fd, hash, pack_tmp_name,
 						 nr_written, hash, offset);
 			close(fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac806..a2cf9dcbc8d 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -53,9 +53,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+		finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK,
+				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
-		int fd = finalize_hashfile(state->f, hash, 0);
+		int fd = finalize_hashfile(state->f, hash, FSYNC_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
diff --git a/cache.h b/cache.h
index 9cd60d94952..d83fbaf2619 100644
--- a/cache.h
+++ b/cache.h
@@ -985,7 +985,38 @@ void reset_shared_repository(void);
 extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
-extern int fsync_object_files;
+/*
+ * These values are used to help identify parts of a repository to fsync.
+ * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
+ * repository and so shouldn't be fsynced.
+ */
+enum fsync_component {
+	FSYNC_COMPONENT_NONE			= 0,
+	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
+	FSYNC_COMPONENT_PACK			= 1 << 1,
+	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
+	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+};
+
+#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
+				  FSYNC_COMPONENT_PACK_METADATA | \
+				  FSYNC_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
+				  FSYNC_COMPONENT_PACK | \
+				  FSYNC_COMPONENT_PACK_METADATA | \
+				  FSYNC_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
+			      FSYNC_COMPONENT_PACK | \
+			      FSYNC_COMPONENT_PACK_METADATA | \
+			      FSYNC_COMPONENT_COMMIT_GRAPH)
+
+
+/*
+ * A bitmask indicating which components of the repo should be fsynced.
+ */
+extern enum fsync_component fsync_components;
 
 enum fsync_method {
 	FSYNC_METHOD_FSYNC,
@@ -1747,6 +1778,12 @@ int copy_file_with_time(const char *dst, const char *src, int mode);
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
 
+inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
+{
+	if (fsync_components & component)
+		fsync_or_die(fd, msg);
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..c8a5dea4541 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1939,7 +1939,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	close_commit_graph(ctx->r->objects);
-	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	finalize_hashfile(f, file_hash, FSYNC_COMPONENT_COMMIT_GRAPH,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
 	if (ctx->split) {
diff --git a/config.c b/config.c
index 139df71ba17..5ab381388f9 100644
--- a/config.c
+++ b/config.c
@@ -1213,6 +1213,73 @@ static int git_parse_maybe_bool_text(const char *value)
 	return -1;
 }
 
+static const struct fsync_component_entry {
+	const char *name;
+	enum fsync_component component_bits;
+} fsync_component_table[] = {
+	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
+	{ "pack", FSYNC_COMPONENT_PACK },
+	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
+	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "default", FSYNC_COMPONENTS_DEFAULT },
+	{ "all", FSYNC_COMPONENTS_ALL },
+};
+
+static enum fsync_component parse_fsync_components(const char *var, const char *string)
+{
+	enum fsync_component output = 0;
+
+	if (!strcmp(string, "none"))
+		return output;
+
+	while (string) {
+		int i;
+		size_t len;
+		const char *ep;
+		int negated = 0;
+		int found = 0;
+
+		string = string + strspn(string, ", \t\n\r");
+		ep = strchrnul(string, ',');
+		len = ep - string;
+
+		if (*string == '-') {
+			negated = 1;
+			string++;
+			len--;
+			if (!len)
+				warning(_("invalid value for variable %s"), var);
+		}
+
+		if (!len)
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(fsync_component_table); ++i) {
+			const struct fsync_component_entry *entry = &fsync_component_table[i];
+
+			if (strncmp(entry->name, string, len))
+				continue;
+
+			found = 1;
+			if (negated)
+				output &= ~entry->component_bits;
+			else
+				output |= entry->component_bits;
+		}
+
+		if (!found) {
+			char *component = xstrndup(string, len);
+			warning(_("ignoring unknown core.fsync component '%s'"), component);
+			free(component);
+		}
+
+		string = ep;
+	}
+
+	return output;
+}
+
 int git_parse_maybe_bool(const char *value)
 {
 	int v = git_parse_maybe_bool_text(value);
@@ -1490,6 +1557,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsync")) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsync_components = parse_fsync_components(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.fsyncmethod")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -1503,7 +1577,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
+		warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
 		return 0;
 	}
 
diff --git a/csum-file.c b/csum-file.c
index 26e8a6df44e..59ef3398ca2 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -58,7 +58,8 @@ static void free_hashfile(struct hashfile *f)
 	free(f);
 }
 
-int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
+int finalize_hashfile(struct hashfile *f, unsigned char *result,
+		      enum fsync_component component, unsigned int flags)
 {
 	int fd;
 
@@ -69,7 +70,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int fl
 	if (flags & CSUM_HASH_IN_STREAM)
 		flush(f, f->buffer, the_hash_algo->rawsz);
 	if (flags & CSUM_FSYNC)
-		fsync_or_die(f->fd, f->name);
+		fsync_component_or_die(component, f->fd, f->name);
 	if (flags & CSUM_CLOSE) {
 		if (close(f->fd))
 			die_errno("%s: sha1 file error on close", f->name);
diff --git a/csum-file.h b/csum-file.h
index 291215b34eb..0d29f528fbc 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,6 +1,7 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
+#include "cache.h"
 #include "hash.h"
 
 struct progress;
@@ -38,7 +39,7 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
-int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
+int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
diff --git a/environment.c b/environment.c
index f9140e842cf..09905adecf9 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
+enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/midx.c b/midx.c
index 837b46b2af5..882f91f7d57 100644
--- a/midx.c
+++ b/midx.c
@@ -1406,7 +1406,8 @@ static int write_midx_internal(const char *object_dir,
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
 	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
diff --git a/object-file.c b/object-file.c
index eb972cdccd2..9d9c4a39e85 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1809,8 +1809,7 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (fsync_object_files)
-		fsync_or_die(fd, "loose object file");
+	fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9c55c1531e1..c16e43d1669 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -719,7 +719,8 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index a5846f3a346..51812cb1299 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -159,9 +159,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((opts->flags & WRITE_IDX_VERIFY)
-				    ? 0 : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 	return index_name;
 }
 
@@ -281,8 +281,9 @@ const char *write_rev_file_order(const char *rev_name,
 	if (rev_name && adjust_shared_perm(rev_name) < 0)
 		die(_("failed to make %s readable"), rev_name);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 
 	return rev_name;
 }
@@ -390,7 +391,7 @@ void fixup_pack_header_footer(int pack_fd,
 		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
 	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
 	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
-	fsync_or_die(pack_fd, pack_name);
+	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
 char *index_pack_lockfile(int ip_out, int *is_well_formed)
diff --git a/read-cache.c b/read-cache.c
index f3986596623..f3539681f49 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3060,7 +3060,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_IN_STREAM);
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
-- 
gitgitgadget

