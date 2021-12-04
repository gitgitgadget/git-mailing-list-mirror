Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197BC433FE
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 03:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbhLDDbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 22:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354735AbhLDDbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 22:31:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD58C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 19:28:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so9741688wrr.8
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PpN9sz3Mun0LKVgp85+59LBnZxWNVAJRlZQmxEKIE8I=;
        b=HDq1OMHFs0j1TZK+G7GP0EmLK0i6319YzMgUJ344+UM0LJHyVa5+LEw1ewOMg4Ziqg
         5/VqRKFHmEv7VfPCqLg3nocWzKJxXYToqm/IPqVBz6jGbXIknGi0dLmQNnRYpGhOEP1F
         lG9YCT2U2taNG1rE99dlpsl/dldfTw6MvXwdrNb/gLYKSJrTCrMnCGaJSMhArz+WzIbr
         7Ug9J3hAYgTavcS0Sagc0S1cshnU0tzbNFL7EpJHRdz8Nb5wgP3nwLS1qPaAfX6Bb80E
         b3LdD2/QCCBkdEAUmpGReA+sf/fToU6guspJn+62DbIWR2bKn5rd7l13dkzB9ftqoH2Q
         0iGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PpN9sz3Mun0LKVgp85+59LBnZxWNVAJRlZQmxEKIE8I=;
        b=IBHlj7DUsGTZixMahUkUW1hHTQsnspv1d1pxX/Yz/CbmsL5ZzQfpSdeEa1a2PHIpqR
         mpzHP3/NC/fRo9jx0aOOT7/iCW2xAQi27HmNlzUGDLooBEpPnB6rLEfSJ9YtIMccw34i
         AbN/cv83S/ijaf/LmLos7vTeVkWqrAaE8ol+Ztw29bWl+zC1A7yG+LusD5Y+6HQdmqC+
         p3++L2q2+sl7aPZ/2MHNtXzHG30Wrm0VHpz48n7y+4j6KDvk7JV27G4gu/7DC81k4pGl
         50ZwHxvEXxi8RsMMq6KWTG7tBVCPI28v18kDdOKmpyfsNXIdsQEzf8muY/DAXYTHgK/F
         35Aw==
X-Gm-Message-State: AOAM532cVEHSRskt2chLEvHpO7b7hG74sz2uC/1K9d4wR9eU51pdJnsF
        MTggp1Rlx/SymB0YvFLTu0kdy8EHfAU=
X-Google-Smtp-Source: ABdhPJzUrWMoWyEDOCQCgrlTTxqQaUoqRxlJS5520D5dgqB198p4rnBfnJFr6mvmhJA/vdKveynzEw==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr27412683wrp.112.1638588507171;
        Fri, 03 Dec 2021 19:28:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k187sm6395125wme.0.2021.12.03.19.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 19:28:26 -0800 (PST)
Message-Id: <23311a1014226b74a9d313552cd2de886db907a5.1638588503.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 03:28:23 +0000
Subject: [PATCH 2/2] core.fsync: introduce granular fsync control
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

This setting allows future extensibility of components
that could be synced in two ways:
* We issue a warning rather than an error for unrecognized
  components, so new configs can be used with old Git versions.
* We support negation, so users can choose one of the default
  aggregate options and then remove components that they don't
  want.

This also support the common request of doing absolutely no
fysncing with the `core.fsync=none` value, which is expected
to make the test suite faster.

This commit introduces the new ability for the user to harden
the index, which is a requirement for being able to actually
find a file that has been added to the repo and then deleted
from the working tree.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 28 +++++++++----
 builtin/fast-import.c         |  2 +-
 builtin/index-pack.c          |  4 +-
 builtin/pack-objects.c        |  8 ++--
 bulk-checkin.c                |  5 ++-
 cache.h                       | 41 ++++++++++++++++++-
 commit-graph.c                |  3 +-
 config.c                      | 77 ++++++++++++++++++++++++++++++++++-
 csum-file.c                   |  5 ++-
 csum-file.h                   |  2 +-
 environment.c                 |  1 +
 midx.c                        |  3 +-
 object-file.c                 |  3 +-
 pack-bitmap-write.c           |  3 +-
 pack-write.c                  | 12 +++---
 read-cache.c                  | 19 ++++++---
 16 files changed, 179 insertions(+), 37 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c91eccea598..d502f8a1bf5 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,26 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsync::
+	A comma-separated list of parts of the repository which should be
+	hardened via the core.fsyncMethod when created or modified. You can
+	disable hardening of any component by prefixing it with a '-'. Later
+	items take precedence over earlier ones in the list. For example,
+	`core.fsync=all,-index` means "harden everything except the index".
+	Items that are not hardened may be lost in the event of an unclean
+	system shutdown.
++
+* `none` disables fsync completely. This must be specified alone.
+* `loose-object` hardens objects added to the repo in loose-object form.
+* `pack` hardens objects added to the repo in packfile form.
+* `pack-metadata` hardens packfile bitmaps and indexes.
+* `commit-graph` hardens the commit graph file.
+* `index` hardens the index when it is modified.
+* `objects` is an aggregate option that includes `loose-objects`, `pack`,
+  `pack-metadata`, and `commit-graph`.
+* `default` is an aggregate option that is equivalent to `objects,-loose-object`
+* `all` is an aggregate option that syncs all individual components above.
+
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
@@ -556,14 +576,6 @@ core.fsyncMethod::
   hardware, but does not send any FLUSH CACHE request. If the operating system
   does not support the required interfaces, this falls back to fsync().
 
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
index 20406f67754..0ae17d63618 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -856,7 +856,7 @@ static void end_packfile(void)
 		struct tag *t;
 
 		close_pack_windows(pack_data);
-		finalize_hashfile(pack_file, cur_pack_oid.hash, 0);
+		finalize_hashfile(pack_file, cur_pack_oid.hash, REPO_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(pack_data->pack_fd, pack_data->hash,
 					 pack_data->pack_name, object_count,
 					 cur_pack_oid.hash, pack_size);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c23d01de7dc..9157a955de7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1286,7 +1286,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 			    nr_objects - nr_objects_initial);
 		stop_progress_msg(&progress, msg.buf);
 		strbuf_release(&msg);
-		finalize_hashfile(f, tail_hash, 0);
+		finalize_hashfile(f, tail_hash, REPO_COMPONENT_PACK, 0);
 		hashcpy(read_hash, pack_hash);
 		fixup_pack_header_footer(output_fd, pack_hash,
 					 curr_pack, nr_objects,
@@ -1508,7 +1508,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (!from_stdin) {
 		close(input_fd);
 	} else {
-		fsync_or_die(output_fd, curr_pack_name);
+		fsync_component_or_die(REPO_COMPONENT_PACK, output_fd, curr_pack_name);
 		err = close(output_fd);
 		if (err)
 			die_errno(_("error while closing pack file"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 857be7826f3..48c2f9f3847 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1204,11 +1204,13 @@ static void write_pack_file(void)
 		 * If so, rewrite it like in fast-import
 		 */
 		if (pack_to_stdout) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
+			finalize_hashfile(f, hash, REPO_COMPONENT_NONE,
+					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);
 		} else if (nr_written == nr_remaining) {
-			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+			finalize_hashfile(f, hash, REPO_COMPONENT_PACK,
+					  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 		} else {
-			int fd = finalize_hashfile(f, hash, 0);
+			int fd = finalize_hashfile(f, hash, REPO_COMPONENT_PACK, 0);
 			fixup_pack_header_footer(fd, hash, pack_tmp_name,
 						 nr_written, hash, offset);
 			close(fd);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac806..b9f3d315334 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -53,9 +53,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		unlink(state->pack_tmp_name);
 		goto clear_exit;
 	} else if (state->nr_written == 1) {
-		finalize_hashfile(state->f, hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+		finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK,
+				  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 	} else {
-		int fd = finalize_hashfile(state->f, hash, 0);
+		int fd = finalize_hashfile(state->f, hash, REPO_COMPONENT_PACK, 0);
 		fixup_pack_header_footer(fd, hash, state->pack_tmp_name,
 					 state->nr_written, hash,
 					 state->offset);
diff --git a/cache.h b/cache.h
index 9cd60d94952..b2966352440 100644
--- a/cache.h
+++ b/cache.h
@@ -985,7 +985,40 @@ void reset_shared_repository(void);
 extern int read_replace_refs;
 extern char *git_replace_ref_base;
 
-extern int fsync_object_files;
+/*
+ * These values are used to help identify parts of a repository to fsync.
+ * REPO_COMPONENT_NONE identifies data that will not be a persistent part of the
+ * repository and so shouldn't be fsynced.
+ */
+enum repo_component {
+	REPO_COMPONENT_NONE			= 0,
+	REPO_COMPONENT_LOOSE_OBJECT		= 1 << 0,
+	REPO_COMPONENT_PACK			= 1 << 1,
+	REPO_COMPONENT_PACK_METADATA		= 1 << 2,
+	REPO_COMPONENT_COMMIT_GRAPH		= 1 << 3,
+	REPO_COMPONENT_INDEX			= 1 << 4,
+};
+
+#define FSYNC_COMPONENTS_DEFAULT (REPO_COMPONENT_PACK | \
+				  REPO_COMPONENT_PACK_METADATA | \
+				  REPO_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_OBJECTS (REPO_COMPONENT_LOOSE_OBJECT | \
+				  REPO_COMPONENT_PACK | \
+				  REPO_COMPONENT_PACK_METADATA | \
+				  REPO_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_ALL (REPO_COMPONENT_LOOSE_OBJECT | \
+			      REPO_COMPONENT_PACK | \
+			      REPO_COMPONENT_PACK_METADATA | \
+			      REPO_COMPONENT_COMMIT_GRAPH | \
+			      REPO_COMPONENT_INDEX)
+
+
+/*
+ * A bitmask indicating which components of the repo should be fsynced.
+ */
+extern enum repo_component fsync_components;
 
 enum fsync_method {
 	FSYNC_METHOD_FSYNC,
@@ -1747,6 +1780,12 @@ int copy_file_with_time(const char *dst, const char *src, int mode);
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
 
+inline void fsync_component_or_die(enum repo_component component, int fd, const char *msg)
+{
+	if (fsync_components & component)
+		fsync_or_die(fd, msg);
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..4bed4175ab2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1939,7 +1939,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	close_commit_graph(ctx->r->objects);
-	finalize_hashfile(f, file_hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	finalize_hashfile(f, file_hash, REPO_COMPONENT_COMMIT_GRAPH,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	free_chunkfile(cf);
 
 	if (ctx->split) {
diff --git a/config.c b/config.c
index c3410b8a868..6c8b102ed7a 100644
--- a/config.c
+++ b/config.c
@@ -1213,6 +1213,74 @@ static int git_parse_maybe_bool_text(const char *value)
 	return -1;
 }
 
+static const struct fsync_component_entry {
+	const char *name;
+	enum repo_component component_bits;
+} fsync_component_table[] = {
+	{ "loose-object", REPO_COMPONENT_LOOSE_OBJECT },
+	{ "pack", REPO_COMPONENT_PACK },
+	{ "pack-metadata", REPO_COMPONENT_PACK_METADATA },
+	{ "commit-graph", REPO_COMPONENT_COMMIT_GRAPH },
+	{ "index", REPO_COMPONENT_INDEX },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "default", FSYNC_COMPONENTS_DEFAULT },
+	{ "all", FSYNC_COMPONENTS_ALL },
+};
+
+static enum repo_component parse_fsync_components(const char *var, const char *string)
+{
+	enum repo_component output = 0;
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
+			warning(_("unknown %s value '%s'"), var, component);
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
@@ -1490,6 +1558,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
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
@@ -1503,7 +1578,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		fsync_object_files = git_config_bool(var, value);
+		warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
 		return 0;
 	}
 
diff --git a/csum-file.c b/csum-file.c
index 26e8a6df44e..adc8023d5af 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -58,7 +58,8 @@ static void free_hashfile(struct hashfile *f)
 	free(f);
 }
 
-int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigned int flags)
+int finalize_hashfile(struct hashfile *f, unsigned char *result,
+		      enum repo_component component, unsigned int flags)
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
index 291215b34eb..3820b4a0e94 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -38,7 +38,7 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 struct hashfile *hashfd(int fd, const char *name);
 struct hashfile *hashfd_check(const char *name);
 struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
-int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
+int finalize_hashfile(struct hashfile *, unsigned char *, enum repo_component, unsigned int);
 void hashwrite(struct hashfile *, const void *, unsigned int);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
diff --git a/environment.c b/environment.c
index f9140e842cf..190df463475 100644
--- a/environment.c
+++ b/environment.c
@@ -42,6 +42,7 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
+enum repo_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
diff --git a/midx.c b/midx.c
index 837b46b2af5..6e9510ab0dc 100644
--- a/midx.c
+++ b/midx.c
@@ -1406,7 +1406,8 @@ static int write_midx_internal(const char *object_dir,
 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
-	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	finalize_hashfile(f, midx_hash, REPO_COMPONENT_PACK_METADATA,
+			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
 	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
diff --git a/object-file.c b/object-file.c
index eb972cdccd2..871ea6bcd53 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1809,8 +1809,7 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
-	if (fsync_object_files)
-		fsync_or_die(fd, "loose object file");
+	fsync_component_or_die(REPO_COMPONENT_LOOSE_OBJECT, fd, "loose object file");
 	if (close(fd) != 0)
 		die_errno(_("error when closing loose object file"));
 }
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9c55c1531e1..e82e87af996 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -719,7 +719,8 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
 
 	if (adjust_shared_perm(tmp_file.buf))
 		die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index a5846f3a346..d9c37803e98 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -159,8 +159,9 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 	}
 
 	hashwrite(f, sha1, the_hash_algo->rawsz);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((opts->flags & WRITE_IDX_VERIFY)
+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((opts->flags & WRITE_IDX_VERIFY)
 				    ? 0 : CSUM_FSYNC));
 	return index_name;
 }
@@ -281,8 +282,9 @@ const char *write_rev_file_order(const char *rev_name,
 	if (rev_name && adjust_shared_perm(rev_name) < 0)
 		die(_("failed to make %s readable"), rev_name);
 
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
-				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+	finalize_hashfile(f, NULL, REPO_COMPONENT_PACK_METADATA,
+			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 
 	return rev_name;
 }
@@ -390,7 +392,7 @@ void fixup_pack_header_footer(int pack_fd,
 		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
 	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
 	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
-	fsync_or_die(pack_fd, pack_name);
+	fsync_component_or_die(REPO_COMPONENT_PACK, pack_fd, pack_name);
 }
 
 char *index_pack_lockfile(int ip_out, int *is_well_formed)
diff --git a/read-cache.c b/read-cache.c
index f3986596623..883d0c0019a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2816,7 +2816,7 @@ static int record_ieot(void)
  * rely on it.
  */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
-			  int strip_extensions)
+			  int strip_extensions, unsigned flags)
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
@@ -2830,6 +2830,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 	int drop_cache_tree = istate->drop_cache_tree;
 	off_t offset;
+	int csum_fsync_flag;
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
@@ -3060,7 +3061,13 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			return -1;
 	}
 
-	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
+	csum_fsync_flag = 0;
+	if (!alternate_index_output && (flags & COMMIT_LOCK))
+		csum_fsync_flag = CSUM_FSYNC;
+
+	finalize_hashfile(f, istate->oid.hash, REPO_COMPONENT_INDEX,
+			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
+
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
@@ -3115,7 +3122,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
-	ret = do_write_index(istate, lock->tempfile, 0);
+	ret = do_write_index(istate, lock->tempfile, 0, flags);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
 				   "%s", get_lock_file_path(lock));
 
@@ -3209,7 +3216,7 @@ static int clean_shared_index_files(const char *current_hex)
 }
 
 static int write_shared_index(struct index_state *istate,
-			      struct tempfile **temp)
+			      struct tempfile **temp, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
 	int ret, was_full = !istate->sparse_index;
@@ -3219,7 +3226,7 @@ static int write_shared_index(struct index_state *istate,
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
-	ret = do_write_index(si->base, *temp, 1);
+	ret = do_write_index(si->base, *temp, 1, flags);
 	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
 
@@ -3328,7 +3335,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 			ret = do_write_locked_index(istate, lock, flags);
 			goto out;
 		}
-		ret = write_shared_index(istate, &temp);
+		ret = write_shared_index(istate, &temp, flags);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
-- 
gitgitgadget
