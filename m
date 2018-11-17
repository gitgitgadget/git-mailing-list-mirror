Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6621F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 15:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeKRB27 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 20:28:59 -0500
Received: from mout.web.de ([212.227.15.14]:58249 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbeKRB26 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 20:28:58 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdrkJ-1fgxjS0IHz-00j5AC; Sat, 17
 Nov 2018 16:11:41 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
Date:   Sat, 17 Nov 2018 16:11:39 +0100
Message-Id: <20181117151139.22994-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jct9xQphK3ZXrZSC2s/kFvLjvL0NKAqID3RJdTDCmzU0P1KjfzV
 XRqfksZAeOMSsei38cD/ASF2yWiRG96oIaxA+x4T7eAJ+KUQ6LlA6WaclIO7d/hPUQ0I2CT
 S83YdjJaIXdbmd7EflxsWbihHuFcJSpWcwV8zunPyFErWQLrszb7D/eQUxAzx0tHC5NpL8x
 u5g0K+U6VRNbNBljTtNQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GGKdJIRmbQk=:s63Ho1K0OVFBpi+5eQJgHW
 jWIpNMBaeEze40RxdUQCyQr2Ps7IeMbd4qMnigIdhPd9mMBrC0Ik5dC3/Xs3irmfru1fmZozO
 SCGg35r8+MHzA1qriLgGaHeCMlebO8rCgsYBw5SIzu/8dIvoGCvoj5wEQl9bmXTh8LBGKvFSX
 YKzds1Kkl5ESPYC5nVu0ELgVri0nLJg3yw+BXJchQomg2SEilTIzoV9wPyoz9tumb8WM1shjS
 xGqoVTz6KCMQzia5XclvK3FleYUTwvm474LUSP8SAcZfC92zMIIU1j3wZzZz4pwXcJ8o7kv3i
 4IN1mv7oBFCKtBan/irkuchMS/OOPUoIZbV01d5Nw5uLxGFW/bvPq+0IAIX5LJrudpnHjOCHv
 9J1c56z4C2X/1BW22YXEks6cYxsQL2ydI4nOzBHuNh86ySjafFFfIsUPHiE2YjDpRmwEUUqqN
 Di+dSXdcTOxaSoa2IWkADdZAvCZ/LD7GAuPxRO5phd6UL1Bvsgg59yEotbt844vONeWcOfOPb
 JAPiz0XinIcNq3f3KEcglQwLE+PQXXoFtvce6xkFo3yphPutJ8PBKk/4Ji681R2QaBI9mPF0h
 gpggX0n3A2iTCsBS8WQbEQTJuVoS+HlAdZzfBgQZiK4+WjsN+CWfIl7rFo4HBUTDygiTxAvQP
 CI8tkVQZDunVX4r8p7GNnjrlVdq0S3iytB/zrwSkaiCqDUVKdcjekDALXthITtxUMnxgz6tXa
 uAUb7cOmocG1DKtiUM0dYW7Nrn0aL1ErTNcdNsXCaTt9Avkh/LylJ+L8UF5XciPJZppzEOBl3
 wq7OVeasrhjyDRZAV2TLObBIafwQo7S5Ap3hSvQRXreyB8++9TnQHMBW6+Ju90WnDEeXXhDoR
 LHqEocy3i+jAmL/GUgmpHN2e3ebytwCwJNfNJi3OxKKpWQ73lqun03ciSbq4ZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Currently Git users can not commit files >4Gib under 64 bit Windows,
where "long" is 32 bit but size_t is 64 bit.
Improve the code base in small steps, as small as possible.
What started with a small patch to replace "unsigned long" with size_t
in one file (convert.c) ended up with a change in many files.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This needs to go on top of pu, to cover all the good stuff
  cooking here.
I have started this series on November 1st, since that 2 or 3 rebases
  had been done to catch up, and now it is on pu from November 15.

I couldn't find a reason why changing "unsigned ling"
  into "size_t" may break anything, any thoughts, please ?
Side question: One thing I wondered about is why Git creates a conflict
like this, using git cherry-pick:
    <<<<<<< HEAD
    		unsigned long size;
    		void *data = read_object_file(oid, &type, &size);
    =======
    		size_t size;
    		void *data = repo_read_object_file(the_repository, oid, &type,
    						   &size);
    >>>>>>> 3ee0abef4c... Use size_t instead of unsigned long

One commit changed "unsigned long size" into "size_t size",
the other commit swapped repo_read_object_file() with read_object_file().
Both changed are on different lines, but Git sees a conflict here.

 apply.c                  | 14 ++++-----
 archive-tar.c            | 18 +++++------
 archive-zip.c            |  2 +-
 archive.c                |  2 +-
 archive.h                |  2 +-
 bisect.c                 |  2 +-
 blame.c                  |  6 ++--
 blame.h                  |  2 +-
 builtin/cat-file.c       | 10 +++---
 builtin/difftool.c       |  3 +-
 builtin/fast-export.c    |  6 ++--
 builtin/fmt-merge-msg.c  |  4 ++-
 builtin/fsck.c           |  6 ++--
 builtin/grep.c           |  8 ++---
 builtin/index-pack.c     | 27 ++++++++--------
 builtin/log.c            |  4 +--
 builtin/ls-tree.c        |  2 +-
 builtin/merge-tree.c     |  6 ++--
 builtin/mktag.c          |  5 +--
 builtin/notes.c          |  6 ++--
 builtin/pack-objects.c   | 56 +++++++++++++++++-----------------
 builtin/reflog.c         |  2 +-
 builtin/replace.c        |  2 +-
 builtin/tag.c            |  4 +--
 builtin/unpack-file.c    |  2 +-
 builtin/unpack-objects.c | 35 ++++++++++-----------
 builtin/verify-commit.c  |  4 +--
 bundle.c                 |  2 +-
 cache.h                  | 10 +++---
 combine-diff.c           | 11 ++++---
 commit.c                 | 22 +++++++-------
 commit.h                 | 10 +++---
 config.c                 |  2 +-
 convert.c                | 18 +++++------
 delta.h                  | 20 ++++++------
 diff-delta.c             |  4 +--
 diff.c                   | 30 +++++++++---------
 diff.h                   |  2 +-
 diffcore-pickaxe.c       |  4 +--
 diffcore.h               |  2 +-
 dir.c                    |  6 ++--
 dir.h                    |  2 +-
 entry.c                  |  4 +--
 fast-import.c            | 26 ++++++++--------
 fsck.c                   | 12 ++++----
 fsck.h                   |  2 +-
 fuzz-pack-headers.c      |  4 +--
 grep.h                   |  2 +-
 http-push.c              |  2 +-
 list-objects-filter.c    |  2 +-
 mailmap.c                |  2 +-
 match-trees.c            |  4 +--
 merge-blobs.c            |  6 ++--
 merge-blobs.h            |  2 +-
 merge-recursive.c        |  4 +--
 notes-cache.c            |  2 +-
 notes-merge.c            |  4 +--
 notes.c                  |  6 ++--
 object-store.h           | 20 ++++++------
 object.c                 |  4 +--
 object.h                 |  2 +-
 pack-check.c             |  2 +-
 pack-objects.h           | 14 ++++-----
 pack.h                   |  2 +-
 packfile.c               | 40 ++++++++++++------------
 packfile.h               |  8 ++---
 patch-delta.c            |  8 ++---
 range-diff.c             |  2 +-
 read-cache.c             | 48 ++++++++++++++---------------
 ref-filter.c             | 30 +++++++++---------
 remote-testsvn.c         |  4 +--
 rerere.c                 |  2 +-
 sha1-file.c              | 66 ++++++++++++++++++++--------------------
 sha1dc_git.c             |  2 +-
 sha1dc_git.h             |  2 +-
 streaming.c              | 12 ++++----
 streaming.h              |  2 +-
 submodule-config.c       |  2 +-
 t/helper/test-delta.c    |  2 +-
 tag.c                    |  6 ++--
 tag.h                    |  2 +-
 tree-walk.c              | 14 ++++-----
 tree.c                   |  2 +-
 xdiff-interface.c        |  4 +--
 xdiff-interface.h        |  4 +--
 85 files changed, 391 insertions(+), 384 deletions(-)

diff --git a/apply.c b/apply.c
index 3703bfc8d0..5e11b85d17 100644
--- a/apply.c
+++ b/apply.c
@@ -3096,7 +3096,7 @@ static int apply_binary_fragment(struct apply_state *state,
 				 struct patch *patch)
 {
 	struct fragment *fragment = patch->fragments;
-	unsigned long len;
+	size_t len;
 	void *dst;
 
 	if (!fragment)
@@ -3186,7 +3186,7 @@ static int apply_binary(struct apply_state *state,
 	if (has_sha1_file(oid.hash)) {
 		/* We already have the postimage */
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *result;
 
 		result = read_object_file(&oid, &type, &size);
@@ -3248,7 +3248,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		unsigned long sz;
+		size_t sz;
 		char *result;
 
 		result = read_object_file(oid, &type, &sz);
@@ -4277,7 +4277,7 @@ static int add_index_file(struct apply_state *state,
 			  const char *path,
 			  unsigned mode,
 			  void *buf,
-			  unsigned long size)
+			  size_t size)
 {
 	struct stat st;
 	struct cache_entry *ce;
@@ -4331,7 +4331,7 @@ static int add_index_file(struct apply_state *state,
  */
 static int try_create_file(struct apply_state *state, const char *path,
 			   unsigned int mode, const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -4382,7 +4382,7 @@ static int create_one_file(struct apply_state *state,
 			   char *path,
 			   unsigned mode,
 			   const char *buf,
-			   unsigned long size)
+			   size_t size)
 {
 	int res;
 
@@ -4474,7 +4474,7 @@ static int create_file(struct apply_state *state, struct patch *patch)
 {
 	char *path = patch->new_name;
 	unsigned mode = patch->new_mode;
-	unsigned long size = patch->resultsize;
+	size_t size = patch->resultsize;
 	char *buf = patch->result;
 
 	if (!mode)
diff --git a/archive-tar.c b/archive-tar.c
index a58e1a8ebf..cea52dfc0a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -13,7 +13,7 @@
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
 static char block[BLOCKSIZE];
-static unsigned long offset;
+static size_t offset;
 
 static int tar_umask = 002;
 
@@ -51,12 +51,12 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void do_write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, size_t size)
 {
 	const char *buf = data;
 
 	if (offset) {
-		unsigned long chunk = BLOCKSIZE - offset;
+		size_t chunk = BLOCKSIZE - offset;
 		if (size < chunk)
 			chunk = size;
 		memcpy(block + offset, buf, chunk);
@@ -78,7 +78,7 @@ static void do_write_blocked(const void *data, unsigned long size)
 
 static void finish_record(void)
 {
-	unsigned long tail;
+	size_t tail;
 	tail = offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -87,7 +87,7 @@ static void finish_record(void)
 	write_if_needed();
 }
 
-static void write_blocked(const void *data, unsigned long size)
+static void write_blocked(const void *data, size_t size)
 {
 	do_write_blocked(data, size);
 	finish_record();
@@ -116,7 +116,7 @@ static int stream_blocked(const struct object_id *oid)
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
@@ -199,7 +199,7 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 
 static void prepare_header(struct archiver_args *args,
 			   struct ustar_header *header,
-			   unsigned int mode, unsigned long size)
+			   unsigned int mode, size_t size)
 {
 	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
 	xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mode) ? (uintmax_t)size : (uintmax_t)0);
@@ -220,7 +220,7 @@ static void prepare_header(struct archiver_args *args,
 
 static void write_extended_header(struct archiver_args *args,
 				  const struct object_id *oid,
-				  const void *buffer, unsigned long size)
+				  const void *buffer, size_t size)
 {
 	struct ustar_header header;
 	unsigned int mode;
@@ -241,7 +241,7 @@ static int write_tar_entry(struct archiver_args *args,
 	struct ustar_header header;
 	struct strbuf ext_header = STRBUF_INIT;
 	unsigned int old_mode = mode;
-	unsigned long size, size_in_header;
+	size_t size, size_in_header;
 	void *buffer;
 	int err = 0;
 
diff --git a/archive-zip.c b/archive-zip.c
index 155ee4a779..7bc9b8d425 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -297,7 +297,7 @@ static int write_zip_entry(struct archiver_args *args,
 	void *buffer;
 	struct git_istream *stream = NULL;
 	unsigned long flags = 0;
-	unsigned long size;
+	size_t size;
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
 	unsigned int creator_version = 0;
diff --git a/archive.c b/archive.c
index 180d97cf77..541d059583 100644
--- a/archive.c
+++ b/archive.c
@@ -73,7 +73,7 @@ static void format_subst(const struct commit *commit,
 void *object_file_to_archive(const struct archiver_args *args,
 			     const char *path, const struct object_id *oid,
 			     unsigned int mode, enum object_type *type,
-			     unsigned long *sizep)
+			     size_t *sizep)
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
diff --git a/archive.h b/archive.h
index 21ac010699..5b69ee1baf 100644
--- a/archive.h
+++ b/archive.h
@@ -54,6 +54,6 @@ extern int write_archive_entries(struct archiver_args *args, write_archive_entry
 extern void *object_file_to_archive(const struct archiver_args *args,
 				    const char *path, const struct object_id *oid,
 				    unsigned int mode, enum object_type *type,
-				    unsigned long *sizep);
+				    size_t *sizep);
 
 #endif	/* ARCHIVE_H */
diff --git a/bisect.c b/bisect.c
index 4c1b80bff6..73822372d0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -137,7 +137,7 @@ static void show_list(const char *debug, int counted, int nr,
 		struct commit *commit = p->item;
 		unsigned flags = commit->object.flags;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf = read_object_file(&commit->object.oid, &type,
 					     &size);
 		const char *subject_start;
diff --git a/blame.c b/blame.c
index 43861437f7..02c412e8f4 100644
--- a/blame.c
+++ b/blame.c
@@ -222,7 +222,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		struct stat st;
 		const char *read_from;
 		char *buf_ptr;
-		unsigned long buf_len;
+		size_t buf_len;
 
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -319,7 +319,7 @@ static void fill_origin_blob(struct diff_options *opt,
 {
 	if (!o->file.ptr) {
 		enum object_type type;
-		unsigned long file_size;
+		size_t file_size;
 
 		(*num_read_blob)++;
 		if (opt->flags.allow_textconv &&
@@ -1651,7 +1651,7 @@ static const char *get_next_line(const char *start, const char *end)
 static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
-	unsigned long len = sb->final_buf_size;
+	size_t len = sb->final_buf_size;
 	const char *end = buf + len;
 	const char *p;
 	int *lineno;
diff --git a/blame.h b/blame.h
index be3a895043..0ef7ff1f3f 100644
--- a/blame.h
+++ b/blame.h
@@ -112,7 +112,7 @@ struct blame_scoreboard {
 	 * indexed with scoreboard.lineno[blame_entry.lno].
 	 */
 	const char *final_buf;
-	unsigned long final_buf_size;
+	size_t final_buf_size;
 
 	/* linked list of blames */
 	struct blame_entry *ent;
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ca56fd086..98dc4e6a1c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -30,7 +30,7 @@ static const char *force_path;
 
 static int filter_object(const char *path, unsigned mode,
 			 const struct object_id *oid,
-			 char **buf, unsigned long *size)
+			 char **buf, size_t *size)
 {
 	enum object_type type;
 
@@ -63,7 +63,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	struct object_id oid;
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	struct object_context obj_context;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
@@ -189,7 +189,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	const char *rest;
 	struct object_id delta_base_oid;
@@ -301,7 +301,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 			fflush(stdout);
 		if (opt->cmdmode) {
 			char *contents;
-			unsigned long size;
+			size_t size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
@@ -332,7 +332,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 	else {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *contents;
 
 		contents = read_object_file(oid, &type, &size);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 71318c26e1..f0a1ceb1f3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -306,7 +306,8 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 		data = strbuf_detach(&link, NULL);
 	} else {
 		enum object_type type;
-		unsigned long size;
+
+		size_t size;
 		data = read_object_file(oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 75b5cd92a5..2e764490a0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -227,7 +227,7 @@ static void show_progress(void)
  * There's no need to cache this result with anonymize_mem, since
  * we already handle blob content caching with marks.
  */
-static char *anonymize_blob(unsigned long *size)
+static char *anonymize_blob(size_t *size)
 {
 	static int counter;
 	struct strbuf out = STRBUF_INIT;
@@ -238,7 +238,7 @@ static char *anonymize_blob(unsigned long *size)
 
 static void export_blob(const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	struct object *object;
@@ -708,7 +708,7 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 
 static void handle_tag(const char *name, struct tag *tag)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf;
 	const char *tagger, *tagger_end, *message;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a4615587fd..9997bf2a4a 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -493,7 +493,9 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 	for (i = 0; i < origins.nr; i++) {
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
-		unsigned long size, len;
+
+		unsigned long len;
+		size_t size;
 		char *buf = read_object_file(oid, &type, &size);
 		struct strbuf sig = STRBUF_INIT;
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9c4c11d0ad..011f5cd32d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -359,7 +359,7 @@ static void check_connectivity(void)
 	}
 }
 
-static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj(struct object *obj, void *buffer, size_t size)
 {
 	int err;
 
@@ -407,7 +407,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten)
+			   size_t size, void *buffer, int *eaten)
 {
 	/*
 	 * Note, buffer may be NULL if type is OBJ_BLOB. See
@@ -562,7 +562,7 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 {
 	struct object *obj;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *contents;
 	int eaten;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index e3af50ca16..936338421a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -294,7 +294,7 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
-static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
+static void *lock_and_read_oid_file(const struct object_id *oid, enum object_type *type, size_t *size)
 {
 	void *data;
 
@@ -447,7 +447,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		struct object *object;
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base = STRBUF_INIT;
 
 		object = parse_object_or_die(oid, oid_to_hex(oid));
@@ -575,7 +575,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
-			unsigned long size;
+			size_t size;
 
 			data = lock_and_read_oid_file(entry.oid, &type, &size);
 			if (!data)
@@ -610,7 +610,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
-		unsigned long size;
+		size_t size;
 		struct strbuf base;
 		int hit, len;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ac1f4ea9a7..efbed1c2d1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -20,7 +20,7 @@ static const char index_pack_usage[] =
 
 struct object_entry {
 	struct pack_idx_entry idx;
-	unsigned long size;
+	size_t size;
 	unsigned char hdr_size;
 	signed char type;
 	signed char real_type;
@@ -36,7 +36,7 @@ struct base_data {
 	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ref_first, ref_last;
 	int ofs_first, ofs_last;
 };
@@ -198,7 +198,7 @@ static unsigned check_object(struct object *obj)
 		return 0;
 
 	if (!(obj->flags & FLAG_CHECKED)) {
-		unsigned long size;
+		size_t size;
 		int type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
@@ -412,7 +412,7 @@ static int is_delta_type(enum object_type type)
 	return (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA);
 }
 
-static void *unpack_entry_data(off_t offset, unsigned long size,
+static void *unpack_entry_data(off_t offset, size_t size,
 			       enum object_type type, struct object_id *oid)
 {
 	static char fixed_buf[8192];
@@ -467,7 +467,8 @@ static void *unpack_raw_entry(struct object_entry *obj,
 			      struct object_id *oid)
 {
 	unsigned char *p;
-	unsigned long size, c;
+	unsigned long c;
+	size_t size;
 	off_t base_offset;
 	unsigned shift;
 	void *data;
@@ -529,7 +530,7 @@ static void *unpack_raw_entry(struct object_entry *obj,
 }
 
 static void *unpack_data(struct object_entry *obj,
-			 int (*consume)(const unsigned char *, unsigned long, void *),
+			 int (*consume)(const unsigned char *, size_t, void *),
 			 void *cb_data)
 {
 	off_t from = obj[0].idx.offset + obj[0].hdr_size;
@@ -706,10 +707,10 @@ struct compare_data {
 	struct object_entry *entry;
 	struct git_istream *st;
 	unsigned char *buf;
-	unsigned long buf_size;
+	size_t buf_size;
 };
 
-static int compare_objects(const unsigned char *buf, unsigned long size,
+static int compare_objects(const unsigned char *buf, size_t size,
 			   void *cb_data)
 {
 	struct compare_data *data = cb_data;
@@ -741,7 +742,7 @@ static int check_collison(struct object_entry *entry)
 {
 	struct compare_data data;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	if (entry->size <= big_file_threshold || entry->type != OBJ_BLOB)
 		return -1;
@@ -761,7 +762,7 @@ static int check_collison(struct object_entry *entry)
 }
 
 static void sha1_object(const void *data, struct object_entry *obj_entry,
-			unsigned long size, enum object_type type,
+			size_t size, enum object_type type,
 			const struct object_id *oid)
 {
 	void *new_data = NULL;
@@ -785,7 +786,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (collision_test_needed) {
 		void *has_data;
 		enum object_type has_type;
-		unsigned long has_size;
+		size_t has_size;
 		read_lock();
 		has_type = oid_object_info(the_repository, oid, &has_size);
 		if (has_type < 0)
@@ -1288,11 +1289,11 @@ static int write_compressed(struct hashfile *f, void *in, unsigned int size)
 
 static struct object_entry *append_obj_to_pack(struct hashfile *f,
 			       const unsigned char *sha1, void *buf,
-			       unsigned long size, enum object_type type)
+			       size_t size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s = size;
+	size_t s = size;
 	int n = 0;
 	unsigned char c = (type << 4) | (s & 15);
 	s >>= 4;
diff --git a/builtin/log.c b/builtin/log.c
index ea15b0be4d..a2791f82a8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -502,7 +502,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	struct object_id oidc;
 	struct object_context obj_context;
 	char *buf;
-	unsigned long size;
+	size_t size;
 
 	fflush(rev->diffopt.file);
 	if (!rev->diffopt.flags.textconv_set_via_cmdline ||
@@ -529,7 +529,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 
 static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = read_object_file(oid, &type, &size);
 	int offset = 0;
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7d581d6463..c662d4d318 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -94,7 +94,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
-				unsigned long size;
+				size_t size;
 				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 70f6fc9167..02c22e4241 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -55,7 +55,7 @@ static const char *explanation(struct merge_list *entry)
 	return "removed in remote";
 }
 
-static void *result(struct merge_list *entry, unsigned long *size)
+static void *result(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	struct blob *base, *our, *their;
@@ -79,7 +79,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	return merge_blobs(&the_index, path, base, our, their, size);
 }
 
-static void *origin(struct merge_list *entry, unsigned long *size)
+static void *origin(struct merge_list *entry, size_t *size)
 {
 	enum object_type type;
 	while (entry) {
@@ -101,7 +101,7 @@ static int show_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 
 static void show_diff(struct merge_list *entry)
 {
-	unsigned long size;
+	size_t size;
 	mmfile_t src, dst;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 6fb7dc8578..ebc5d10621 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -24,7 +24,8 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 {
 	int ret = -1;
 	enum object_type type;
-	unsigned long size;
+
+	size_t size;
 	void *buffer = read_object_file(oid, &type, &size);
 	const struct object_id *repl = lookup_replace_object(the_repository, oid);
 
@@ -36,7 +37,7 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	return ret;
 }
 
-static int verify_tag(char *buffer, unsigned long size)
+static int verify_tag(char *buffer, size_t size)
 {
 	int typelen;
 	char type[20];
diff --git a/builtin/notes.c b/builtin/notes.c
index 4996a670f7..be892b058b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -122,7 +122,7 @@ static int list_each_note(const struct object_id *object_oid,
 
 static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = read_object_file(oid, &type, &size);
 	if (buf) {
@@ -252,7 +252,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	char *buf;
 	struct object_id object;
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	BUG_ON_OPT_NEG(unset);
 
@@ -613,7 +613,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 
 	if (note && !edit) {
 		/* Append buf to previous note contents */
-		unsigned long size;
+		size_t size;
 		enum object_type type;
 		char *prev_buf = read_object_file(note, &type, &size);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d0da1bed57..7f657f7937 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -142,7 +142,7 @@ static void index_commit_for_bitmap(struct commit *commit)
 
 static void *get_delta(struct object_entry *entry)
 {
-	unsigned long size, base_size, delta_size;
+	size_t size, base_size, delta_size;
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
@@ -168,11 +168,11 @@ static void *get_delta(struct object_entry *entry)
 	return delta_buf;
 }
 
-static unsigned long do_compress(void **pptr, unsigned long size)
+static size_t do_compress(void **pptr, size_t size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;
 
 	git_deflate_init(&stream, pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
@@ -193,13 +193,13 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct git_istream *st, struct hashfile *f,
+static size_t write_large_blob_data(struct git_istream *st, struct hashfile *f,
 					   const struct object_id *oid)
 {
 	git_zstream stream;
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
-	unsigned long olen = 0;
+	size_t olen = 0;
 
 	git_deflate_init(&stream, pack_compression_level);
 
@@ -240,7 +240,7 @@ static int check_pack_inflate(struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
 		off_t len,
-		unsigned long expect)
+		size_t expect)
 {
 	git_zstream stream;
 	unsigned char fakebuf[4096], *in;
@@ -282,10 +282,10 @@ static void copy_pack_data(struct hashfile *f,
 }
 
 /* Return 0 if we will bust the pack-size limit */
-static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
-					   unsigned long limit, int usable_delta)
+static size_t write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
+					   size_t limit, int usable_delta)
 {
-	unsigned long size, datalen;
+	size_t size, datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
@@ -394,7 +394,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 /* Return 0 if we will bust the pack-size limit */
 static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
-				unsigned long limit, int usable_delta)
+				size_t limit, int usable_delta)
 {
 	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
@@ -406,7 +406,7 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	unsigned long entry_size = SIZE(entry);
+	size_t entry_size = SIZE(entry);
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
@@ -477,7 +477,7 @@ static off_t write_object(struct hashfile *f,
 			  struct object_entry *entry,
 			  off_t write_offset)
 {
-	unsigned long limit;
+	size_t limit;
 	off_t len;
 	int usable_delta, to_reuse;
 
@@ -1208,7 +1208,7 @@ struct pbase_tree_cache {
 	int ref;
 	int temporary;
 	void *tree_data;
-	unsigned long tree_size;
+	size_t tree_size;
 };
 
 static struct pbase_tree_cache *(pbase_tree_cache[256]);
@@ -1235,7 +1235,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 {
 	struct pbase_tree_cache *ent, *nent;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int neigh;
 	int my_ix = pbase_tree_cache_ix(oid);
@@ -1418,7 +1418,7 @@ static void add_preferred_base(struct object_id *oid)
 {
 	struct pbase_tree *it;
 	void *data;
-	unsigned long size;
+	size_t size;
 	struct object_id tree_oid;
 
 	if (window <= num_preferred_base++)
@@ -1522,7 +1522,7 @@ static int can_reuse_delta(const unsigned char *base_sha1,
 
 static void check_object(struct object_entry *entry)
 {
-	unsigned long canonical_size;
+	size_t canonical_size;
 
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
@@ -1534,7 +1534,7 @@ static void check_object(struct object_entry *entry)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
-		unsigned long in_pack_size;
+		size_t in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1700,7 +1700,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	unsigned *idx = &to_pack.objects[entry->delta_idx - 1].delta_child_idx;
 	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	while (*idx) {
 		struct object_entry *oe = &to_pack.objects[*idx - 1];
@@ -1937,8 +1937,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
@@ -1983,14 +1983,14 @@ static pthread_mutex_t progress_mutex;
  * reconstruction (so non-deltas are true object sizes, but deltas
  * return the size of the delta data).
  */
-unsigned long oe_get_size_slow(struct packing_data *pack,
+size_t oe_get_size_slow(struct packing_data *pack,
 			       const struct object_entry *e)
 {
 	struct packed_git *p;
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, size;
+	size_t used, size;
 	size_t avail;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
@@ -2020,11 +2020,11 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 }
 
 static int try_delta(struct unpacked *trg, struct unpacked *src,
-		     unsigned max_depth, unsigned long *mem_usage)
+		     unsigned max_depth, size_t *mem_usage)
 {
 	struct object_entry *trg_entry = trg->entry;
 	struct object_entry *src_entry = src->entry;
-	unsigned long trg_size, src_size, delta_size, sizediff, max_size, sz;
+	size_t trg_size, src_size, delta_size, sizediff, max_size, sz;
 	unsigned ref_depth;
 	enum object_type type;
 	void *delta_buf;
@@ -2180,9 +2180,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem = sizeof_delta_index(n->index);
+	size_t freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
@@ -2199,7 +2199,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 {
 	uint32_t i, idx = 0, count = 0;
 	struct unpacked *array;
-	unsigned long mem_usage = 0;
+	size_t mem_usage = 0;
 
 	array = xcalloc(window, sizeof(struct unpacked));
 
@@ -2282,7 +2282,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		 * between writes at that moment.
 		 */
 		if (entry->delta_data && !pack_to_stdout) {
-			unsigned long size;
+			size_t size;
 
 			size = do_compress(&entry->delta_data, DELTA_SIZE(entry));
 			if (size < (1U << OE_Z_DELTA_BITS)) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 64a8df4f25..11d57ccbc9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -82,7 +82,7 @@ static int tree_is_complete(const struct object_id *oid)
 
 	if (!tree->buffer) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		void *data = read_object_file(oid, &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
diff --git a/builtin/replace.c b/builtin/replace.c
index a58b9c6d13..473635804d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -439,7 +439,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
 	const char *buffer;
-	unsigned long size;
+	size_t size;
 
 	if (get_oid(old_ref, &old_oid) < 0)
 		return error(_("not a valid object name: '%s'"), old_ref);
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..3a76b590c1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -165,7 +165,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 static void write_tag_body(int fd, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf, *sp;
 
@@ -286,7 +286,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	enum object_type type;
 	struct commit *c;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int subject_len = 0;
 	const char *subject_start;
 
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 58652229f2..61200ed57c 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -7,7 +7,7 @@ static char *create_temp_file(struct object_id *oid)
 	static char path[50];
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	int fd;
 
 	buf = read_object_file(oid, &type, &size);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 80478808b3..13f4d1acc1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -32,7 +32,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
  */
 struct obj_buffer {
 	char *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 static struct decoration obj_decorate;
@@ -42,7 +42,7 @@ static struct obj_buffer *lookup_object_buffer(struct object *base)
 	return lookup_decoration(&obj_decorate, base);
 }
 
-static void add_object_buffer(struct object *object, char *buffer, unsigned long size)
+static void add_object_buffer(struct object *object, char *buffer, size_t size)
 {
 	struct obj_buffer *obj;
 	obj = xcalloc(1, sizeof(struct obj_buffer));
@@ -94,7 +94,7 @@ static void use(int bytes)
 		die(_("pack exceeds maximum allowed size"));
 }
 
-static void *get_data(unsigned long size)
+static void *get_data(size_t size)
 {
 	git_zstream stream;
 	void *buf = xmallocz(size);
@@ -131,7 +131,7 @@ struct delta_info {
 	struct object_id base_oid;
 	unsigned nr;
 	off_t base_offset;
-	unsigned long size;
+	size_t size;
 	void *delta;
 	struct delta_info *next;
 };
@@ -140,7 +140,7 @@ static struct delta_info *delta_list;
 
 static void add_delta_to_list(unsigned nr, const struct object_id *base_oid,
 			      off_t base_offset,
-			      void *delta, unsigned long size)
+			      void *delta, size_t size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
@@ -199,7 +199,7 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 		die("object type mismatch");
 
 	if (!(obj->flags & FLAG_OPEN)) {
-		unsigned long size;
+		size_t size;
 		int type = oid_object_info(the_repository, &obj->oid, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
@@ -229,7 +229,7 @@ static void write_rest(void)
 }
 
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size);
+			 void *data, size_t size);
 
 /*
  * Write out nr-th object from the list, now we know the contents
@@ -237,7 +237,7 @@ static void added_object(unsigned nr, enum object_type type,
  * to be checked at the end.
  */
 static void write_object(unsigned nr, enum object_type type,
-			 void *buf, unsigned long size)
+			 void *buf, size_t size)
 {
 	if (!strict) {
 		if (write_object_file(buf, size, type_name(type),
@@ -277,11 +277,11 @@ static void write_object(unsigned nr, enum object_type type,
 }
 
 static void resolve_delta(unsigned nr, enum object_type type,
-			  void *base, unsigned long base_size,
-			  void *delta, unsigned long delta_size)
+			  void *base, size_t base_size,
+			  void *delta, size_t delta_size)
 {
 	void *result;
-	unsigned long result_size;
+	size_t result_size;
 
 	result = patch_delta(base, base_size,
 			     delta, delta_size,
@@ -297,7 +297,7 @@ static void resolve_delta(unsigned nr, enum object_type type,
  * resolve all the deltified objects that are based on it.
  */
 static void added_object(unsigned nr, enum object_type type,
-			 void *data, unsigned long size)
+			 void *data, size_t size)
 {
 	struct delta_info **p = &delta_list;
 	struct delta_info *info;
@@ -316,7 +316,7 @@ static void added_object(unsigned nr, enum object_type type,
 	}
 }
 
-static void unpack_non_delta_entry(enum object_type type, unsigned long size,
+static void unpack_non_delta_entry(enum object_type type, size_t size,
 				   unsigned nr)
 {
 	void *buf = get_data(size);
@@ -328,7 +328,7 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 }
 
 static int resolve_against_held(unsigned nr, const struct object_id *base,
-				void *delta_data, unsigned long delta_size)
+				void *delta_data, size_t delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
@@ -343,11 +343,11 @@ static int resolve_against_held(unsigned nr, const struct object_id *base,
 	return 1;
 }
 
-static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
+static void unpack_delta_entry(enum object_type type, size_t delta_size,
 			       unsigned nr)
 {
 	void *delta_data, *base;
-	unsigned long base_size;
+	size_t base_size;
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
@@ -442,7 +442,8 @@ static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack;
-	unsigned long size, c;
+	unsigned long c;
+	size_t size;
 	enum object_type type;
 
 	obj_list[nr].offset = consumed_bytes;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7772c07ed7..0c25550ef1 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -21,7 +21,7 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(const struct object_id *oid, const char *buf, size_t size, unsigned flags)
 {
 	struct signature_check signature_check;
 	int ret;
@@ -41,7 +41,7 @@ static int verify_commit(const char *name, unsigned flags)
 	enum object_type type;
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (get_oid(name, &oid))
diff --git a/bundle.c b/bundle.c
index b94992675a..a4f1d8127b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -217,7 +217,7 @@ int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
 
 static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	char *buf = NULL, *line, *lineend;
 	timestamp_t date;
diff --git a/cache.h b/cache.h
index cb53380211..aba5c0034c 100644
--- a/cache.h
+++ b/cache.h
@@ -784,7 +784,7 @@ extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char
 extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
+extern void *read_blob_data_from_index(const struct index_state *, const char *, size_t *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
@@ -1281,10 +1281,10 @@ extern char *xdg_cache_home(const char *filename);
 
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, size_t mapsize, void *buffer, size_t bufsiz);
+extern int parse_sha1_header(const char *hdr, size_t *sizep);
 
-extern int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
+extern int check_object_signature(const struct object_id *oid, void *buf, size_t size, const char *type);
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
@@ -1446,7 +1446,7 @@ extern int cache_name_stage_compare(const char *name1, int len1, int stage1, con
 
 extern void *read_object_with_reference(const struct object_id *oid,
 					const char *required_type,
-					unsigned long *size,
+					size_t *size,
 					struct object_id *oid_ret);
 
 extern struct object *peel_to_type(const char *name, int namelen,
diff --git a/combine-diff.c b/combine-diff.c
index a143c00634..d782c639b1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -287,7 +287,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 
 static char *grab_blob(struct repository *r,
 		       const struct object_id *oid, unsigned int mode,
-		       unsigned long *size, struct userdiff_driver *textconv,
+		       size_t *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
 	char *blob;
@@ -379,7 +379,7 @@ static void consume_hunk(void *state_,
 	state->sline[state->nb-1].p_lno[state->n] = state->ob;
 }
 
-static void consume_line(void *state_, char *line, unsigned long len)
+static void consume_line(void *state_, char *line, size_t len)
 {
 	struct combine_diff_state *state = state_;
 	if (!state->lost_bucket)
@@ -409,7 +409,7 @@ static void combine_diff(struct repository *r,
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
 	struct combine_diff_state state;
-	unsigned long sz;
+	size_t sz;
 
 	if (result_deleted)
 		return; /* result deleted */
@@ -979,7 +979,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
-	unsigned long result_size, cnt, lno;
+	unsigned long cnt, lno;
+	size_t result_size;
 	int result_deleted = 0;
 	char *result, *cp;
 	struct sline *sline; /* survived lines */
@@ -1097,7 +1098,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		is_binary = buffer_is_binary(result, result_size);
 		for (i = 0; !is_binary && i < num_parent; i++) {
 			char *buf;
-			unsigned long size;
+			size_t size;
 			buf = grab_blob(opt->repo,
 					&elem->parent[i].oid,
 					elem->parent[i].mode,
diff --git a/commit.c b/commit.c
index a5333c7ac6..b9d8793910 100644
--- a/commit.c
+++ b/commit.c
@@ -260,7 +260,7 @@ int unregister_shallow(const struct object_id *oid)
 
 struct commit_buffer {
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 define_commit_slab(buffer_slab, struct commit_buffer);
 
@@ -277,7 +277,7 @@ void free_commit_buffer_slab(struct buffer_slab *bs)
 	free(bs);
 }
 
-void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, unsigned long size)
+void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer, size_t size)
 {
 	struct commit_buffer *v = buffer_slab_at(
 		r->parsed_objects->buffer_slab, commit);
@@ -285,7 +285,7 @@ void set_commit_buffer(struct repository *r, struct commit *commit, void *buffer
 	v->size = size;
 }
 
-const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, unsigned long *sizep)
+const void *get_cached_commit_buffer(struct repository *r, const struct commit *commit, size_t *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(
 		r->parsed_objects->buffer_slab, commit);
@@ -301,12 +301,12 @@ const void *get_cached_commit_buffer(struct repository *r, const struct commit *
 
 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *commit,
-				   unsigned long *sizep)
+				   size_t *sizep)
 {
 	const void *ret = get_cached_commit_buffer(r, commit, sizep);
 	if (!ret) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		ret = repo_read_object_file(r, &commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
@@ -366,7 +366,7 @@ void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
 	c->object.parsed = 0;
 }
 
-const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
+const void *detach_commit_buffer(struct commit *commit, size_t *sizep)
 {
 	struct commit_buffer *v = buffer_slab_peek(
 		the_repository->parsed_objects->buffer_slab, commit);
@@ -386,7 +386,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, size_t size, int check_graph)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -455,7 +455,7 @@ int repo_parse_commit_internal(struct repository *r,
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (!item)
@@ -976,7 +976,7 @@ int parse_signed_commit(const struct commit *commit,
 			struct strbuf *payload, struct strbuf *signature)
 {
 
-	unsigned long size;
+	size_t size;
 	const char *buffer = get_commit_buffer(commit, &size);
 	int in_signature, saw_signature = -1;
 	const char *line, *tail;
@@ -1051,7 +1051,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
 	char *buf;
-	unsigned long size, len;
+	size_t size, len;
 	enum object_type type;
 
 	desc = merge_remote_util(parent);
@@ -1158,7 +1158,7 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 						      const char **exclude)
 {
 	struct commit_extra_header *extra = NULL;
-	unsigned long size;
+	size_t size;
 	const char *buffer = get_commit_buffer(commit, &size);
 	extra = read_commit_extra_header_lines(buffer, size, exclude);
 	unuse_commit_buffer(commit, buffer);
diff --git a/commit.h b/commit.h
index 42728c2906..bcf3227b85 100644
--- a/commit.h
+++ b/commit.h
@@ -79,7 +79,7 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph);
+int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, size_t size, int check_graph);
 int repo_parse_commit_internal(struct repository *r, struct commit *item,
 			       int quiet_on_missing, int use_commit_graph);
 int repo_parse_commit_gently(struct repository *r,
@@ -105,13 +105,13 @@ void free_commit_buffer_slab(struct buffer_slab *bs);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct repository *r, struct commit *, void *buffer, unsigned long size);
+void set_commit_buffer(struct repository *r, struct commit *, void *buffer, size_t size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(struct repository *, const struct commit *, unsigned long *size);
+const void *get_cached_commit_buffer(struct repository *, const struct commit *, size_t *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
@@ -120,7 +120,7 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
  */
 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *,
-				   unsigned long *size);
+				   size_t *size);
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c, s)
 #endif
@@ -156,7 +156,7 @@ void release_commit_memory(struct parsed_object_pool *pool, struct commit *c);
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
  */
-const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
+const void *detach_commit_buffer(struct commit *, size_t *sizep);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/config.c b/config.c
index 04286f7717..69e91227a0 100644
--- a/config.c
+++ b/config.c
@@ -1594,7 +1594,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	buf = read_object_file(oid, &type, &size);
diff --git a/convert.c b/convert.c
index e0848226d2..f66b23c2bf 100644
--- a/convert.c
+++ b/convert.c
@@ -43,9 +43,9 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };
 
-static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+static void gather_stats(const char *buf, size_t size, struct text_stat *stats)
 {
-	unsigned long i;
+	size_t i;
 
 	memset(stats, 0, sizeof(*stats));
 
@@ -92,7 +92,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
  * The same heuristics as diff.c::mmfile_is_binary()
  * We treat files with bare CR as binary
  */
-static int convert_is_binary(unsigned long size, const struct text_stat *stats)
+static int convert_is_binary(size_t size, const struct text_stat *stats)
 {
 	if (stats->lonecr)
 		return 1;
@@ -103,7 +103,7 @@ static int convert_is_binary(unsigned long size, const struct text_stat *stats)
 	return 0;
 }
 
-static unsigned int gather_convert_stats(const char *data, unsigned long size)
+static unsigned int gather_convert_stats(const char *data, size_t size)
 {
 	struct text_stat stats;
 	int ret = 0;
@@ -120,7 +120,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 	return ret;
 }
 
-static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *gather_convert_stats_ascii(const char *data, size_t size)
 {
 	unsigned int convert_stats = gather_convert_stats(data, size);
 
@@ -142,7 +142,7 @@ const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 					   const char *path)
 {
 	const char *ret;
-	unsigned long sz;
+	size_t sz;
 	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
@@ -224,7 +224,7 @@ static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_
 
 static int has_crlf_in_index(const struct index_state *istate, const char *path)
 {
-	unsigned long sz;
+	size_t sz;
 	void *data;
 	const char *crp;
 	int has_crlf = 0;
@@ -630,7 +630,7 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 
 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
@@ -1048,7 +1048,7 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int count_ident(const char *cp, unsigned long size)
+static int count_ident(const char *cp, size_t size)
 {
 	/*
 	 * "$Id: 0000000000000000000000000000000000000000 $" <=> "$Id$"
diff --git a/delta.h b/delta.h
index 9b67531dfa..541171230c 100644
--- a/delta.h
+++ b/delta.h
@@ -42,8 +42,8 @@ extern unsigned long sizeof_delta_index(struct delta_index *index);
  */
 extern void *
 create_delta(const struct delta_index *index,
-	     const void *buf, unsigned long bufsize,
-	     unsigned long *delta_size, unsigned long max_delta_size);
+	     const void *buf, size_t bufsize,
+	     size_t *delta_size, size_t max_delta_size);
 
 /*
  * diff_delta: create a delta from source buffer to target buffer
@@ -54,9 +54,9 @@ create_delta(const struct delta_index *index,
  * updated with its size.  The returned buffer must be freed by the caller.
  */
 static inline void *
-diff_delta(const void *src_buf, unsigned long src_bufsize,
-	   const void *trg_buf, unsigned long trg_bufsize,
-	   unsigned long *delta_size, unsigned long max_delta_size)
+diff_delta(const void *src_buf, size_t src_bufsize,
+	   const void *trg_buf, size_t trg_bufsize,
+	   size_t *delta_size, size_t max_delta_size)
 {
 	struct delta_index *index = create_delta_index(src_buf, src_bufsize);
 	if (index) {
@@ -75,9 +75,9 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-extern void *patch_delta(const void *src_buf, unsigned long src_size,
-			 const void *delta_buf, unsigned long delta_size,
-			 unsigned long *dst_size);
+extern void *patch_delta(const void *src_buf, size_t src_size,
+			 const void *delta_buf, size_t delta_size,
+			 size_t *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
@@ -86,11 +86,11 @@ extern void *patch_delta(const void *src_buf, unsigned long src_size,
  * This must be called twice on the delta data buffer, first to get the
  * expected source buffer size, and again to get the target buffer size.
  */
-static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
+static inline size_t get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned long cmd, size = 0;
+	size_t cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
diff --git a/diff-delta.c b/diff-delta.c
index e49643353b..072a5ca839 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -316,8 +316,8 @@ unsigned long sizeof_delta_index(struct delta_index *index)
 
 void *
 create_delta(const struct delta_index *index,
-	     const void *trg_buf, unsigned long trg_size,
-	     unsigned long *delta_size, unsigned long max_size)
+	     const void *trg_buf, size_t trg_size,
+	     size_t *delta_size, size_t max_size)
 {
 	unsigned int i, val;
 	off_t outpos, moff;
diff --git a/diff.c b/diff.c
index f1e901a5fc..f78ff9778e 100644
--- a/diff.c
+++ b/diff.c
@@ -2258,7 +2258,7 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
-static void fn_out_consume(void *priv, char *line, unsigned long len)
+static void fn_out_consume(void *priv, char *line, size_t len)
 {
 	struct emit_callback *ecbdata = priv;
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
@@ -2461,7 +2461,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 	return x;
 }
 
-static void diffstat_consume(void *priv, char *line, unsigned long len)
+static void diffstat_consume(void *priv, char *line, size_t len)
 {
 	struct diffstat_t *diffstat = priv;
 	struct diffstat_file *x = diffstat->files[diffstat->nr - 1];
@@ -3141,7 +3141,7 @@ static void checkdiff_consume_hunk(void *priv,
 	data->lineno = nb - 1;
 }
 
-static void checkdiff_consume(void *priv, char *line, unsigned long len)
+static void checkdiff_consume(void *priv, char *line, size_t len)
 {
 	struct checkdiff_t *data = priv;
 	int marker_size = data->conflict_marker_size;
@@ -3180,8 +3180,8 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 }
 
 static unsigned char *deflate_it(char *data,
-				 unsigned long size,
-				 unsigned long *result_size)
+				 size_t size,
+				 size_t *result_size)
 {
 	int bound;
 	unsigned char *deflated;
@@ -3209,10 +3209,10 @@ static void emit_binary_diff_body(struct diff_options *o,
 	void *delta;
 	void *deflated;
 	void *data;
-	unsigned long orig_size;
-	unsigned long delta_size;
-	unsigned long deflate_size;
-	unsigned long data_size;
+	size_t orig_size;
+	size_t delta_size;
+	size_t deflate_size;
+	size_t data_size;
 
 	/* We could do deflated delta, or we could do just deflated two,
 	 * whichever is smaller.
@@ -3997,7 +3997,7 @@ void diff_free_filespec_data(struct diff_filespec *s)
 static void prep_temp_blob(struct index_state *istate,
 			   const char *path, struct diff_tempfile *temp,
 			   void *blob,
-			   unsigned long size,
+			   size_t size,
 			   const struct object_id *oid,
 			   int mode)
 {
@@ -5657,9 +5657,9 @@ struct patch_id_t {
 	int patchlen;
 };
 
-static int remove_space(char *line, int len)
+static size_t remove_space(char *line, size_t len)
 {
-	int i;
+	size_t i;
 	char *dst = line;
 	unsigned char c;
 
@@ -5670,10 +5670,10 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
 
-static void patch_id_consume(void *priv, char *line, unsigned long len)
+static void patch_id_consume(void *priv, char *line, size_t len)
 {
 	struct patch_id_t *data = priv;
-	int new_len;
+	size_t new_len;
 
 	new_len = remove_space(line, len);
 
@@ -6434,7 +6434,7 @@ int textconv_object(struct repository *r,
 		    const struct object_id *oid,
 		    int oid_valid,
 		    char **buf,
-		    unsigned long *buf_size)
+		    size_t *buf_size)
 {
 	struct diff_filespec *df;
 	struct userdiff_driver *textconv;
diff --git a/diff.h b/diff.h
index b512d0477a..9faeab924e 100644
--- a/diff.h
+++ b/diff.h
@@ -474,7 +474,7 @@ int textconv_object(struct repository *repo,
 		    const char *path,
 		    unsigned mode,
 		    const struct object_id *oid, int oid_valid,
-		    char **buf, unsigned long *buf_size);
+		    char **buf, size_t *buf_size);
 
 int parse_rename_score(const char **cp_p);
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index ad939d2861..d78b510465 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -19,7 +19,7 @@ struct diffgrep_cb {
 	int hit;
 };
 
-static void diffgrep_consume(void *priv, char *line, unsigned long len)
+static void diffgrep_consume(void *priv, char *line, size_t len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
@@ -71,7 +71,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
 {
 	unsigned int cnt;
-	unsigned long sz;
+	size_t sz;
 	const char *data;
 
 	sz = mf->size;
diff --git a/diffcore.h b/diffcore.h
index b651061c0e..b47778dd36 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -33,7 +33,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
-	unsigned long size;
+	size_t size;
 	int count;               /* Reference count */
 	int rename_used;         /* Count of rename users */
 	unsigned short mode;	 /* file mode */
diff --git a/dir.c b/dir.c
index ab6477d777..8d68442040 100644
--- a/dir.c
+++ b/dir.c
@@ -183,7 +183,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
  */
 char *common_prefix(const struct pathspec *pathspec)
 {
-	unsigned long len = common_prefix_len(pathspec);
+	size_t len = common_prefix_len(pathspec);
 
 	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
 }
@@ -239,7 +239,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 			size_t *size_out, char **data_out)
 {
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	char *data;
 
 	*size_out = 0;
@@ -2863,7 +2863,7 @@ static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
 	oid_stat->valid = 1;
 }
 
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
+struct untracked_cache *read_untracked_extension(const void *data, size_t sz)
 {
 	struct untracked_cache *uc;
 	struct read_data rd;
diff --git a/dir.h b/dir.h
index e3ec26143d..7dc741cd41 100644
--- a/dir.h
+++ b/dir.h
@@ -360,7 +360,7 @@ void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
 void free_untracked_cache(struct untracked_cache *);
-struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
+struct untracked_cache *read_untracked_extension(const void *data, size_t sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
diff --git a/entry.c b/entry.c
index 5f213c30fe..1dd520557a 100644
--- a/entry.c
+++ b/entry.c
@@ -83,7 +83,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+static void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
 	void *blob_data = read_object_file(&ce->oid, &type, size);
@@ -259,7 +259,7 @@ static int write_entry(struct cache_entry *ce,
 	int fd, ret, fstat_done = 0;
 	char *new_blob;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	ssize_t wrote;
 	size_t newsize = 0;
 	struct stat st;
diff --git a/fast-import.c b/fast-import.c
index b7ba755c2b..adb09ef10e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -895,7 +895,7 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	size_t hdrlen, deltalen;
 	git_hash_ctx c;
 	git_zstream s;
 
@@ -1036,7 +1036,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	unsigned char *out_buf = xmalloc(out_sz);
 	struct object_entry *e;
 	struct object_id oid;
-	unsigned long hdrlen;
+	size_t hdrlen;
 	off_t offset;
 	git_hash_ctx c;
 	git_zstream s;
@@ -1154,7 +1154,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
  */
 static void *gfi_unpack_entry(
 	struct object_entry *oe,
-	unsigned long *sizep)
+	size_t *sizep)
 {
 	enum object_type type;
 	struct packed_git *p = all_packs[oe->pack_id];
@@ -1200,7 +1200,7 @@ static void load_tree(struct tree_entry *root)
 	struct object_id *oid = &root->versions[1].oid;
 	struct object_entry *myoe;
 	struct tree_content *t;
-	unsigned long size;
+	size_t size;
 	char *buf;
 	const char *c;
 
@@ -1873,7 +1873,7 @@ static int validate_raw_date(const char *src, struct strbuf *result)
 {
 	const char *orig_src = src;
 	char *endp;
-	unsigned long num;
+	size_t num;
 
 	errno = 0;
 
@@ -2400,7 +2400,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
-		unsigned long size;
+		size_t size;
 		char *buf = read_object_with_reference(&commit_oid,
 						       commit_type, &size,
 						       &commit_oid);
@@ -2453,7 +2453,7 @@ static void file_change_deleteall(struct branch *b)
 	b->num_notes = 0;
 }
 
-static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
+static void parse_from_commit(struct branch *b, char *buf, size_t size)
 {
 	if (!buf || size < GIT_SHA1_HEXSZ + 6)
 		die("Not a valid commit: %s", oid_to_hex(&b->oid));
@@ -2470,7 +2470,7 @@ static void parse_from_existing(struct branch *b)
 		oidclr(&b->branch_tree.versions[0].oid);
 		oidclr(&b->branch_tree.versions[1].oid);
 	} else {
-		unsigned long size;
+		size_t size;
 		char *buf;
 
 		buf = read_object_with_reference(&b->oid, commit_type, &size,
@@ -2507,7 +2507,7 @@ static int parse_from(struct branch *b)
 		if (!oideq(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
-				unsigned long size;
+				size_t size;
 				char *buf = gfi_unpack_entry(oe, &size);
 				parse_from_commit(b, buf, size);
 				free(buf);
@@ -2550,7 +2550,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
-			unsigned long size;
+			size_t size;
 			char *buf = read_object_with_reference(&n->oid,
 							       commit_type,
 							       &size, &n->oid);
@@ -2776,7 +2776,7 @@ static void parse_reset_branch(const char *arg)
 		unread_command_buf = 1;
 }
 
-static void cat_blob_write(const char *buf, unsigned long size)
+static void cat_blob_write(const char *buf, size_t size)
 {
 	if (write_in_full(cat_blob_fd, buf, size) < 0)
 		die_errno("Write to frontend failed");
@@ -2785,7 +2785,7 @@ static void cat_blob_write(const char *buf, unsigned long size)
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
 {
 	struct strbuf line = STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	enum object_type type = 0;
 	char *buf;
 
@@ -2869,7 +2869,7 @@ static void parse_cat_blob(const char *p)
 static struct object_entry *dereference(struct object_entry *oe,
 					struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	char *buf = NULL;
 	if (!oe) {
 		enum object_type type = oid_object_info(the_repository, oid,
diff --git a/fsck.c b/fsck.c
index 68502ce85b..208032c693 100644
--- a/fsck.c
+++ b/fsck.c
@@ -850,7 +850,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 }
 
 static int fsck_commit(struct commit *commit, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
 	int ret = fsck_commit_buffer(commit, buffer, size, options);
@@ -860,7 +860,7 @@ static int fsck_commit(struct commit *commit, const char *data,
 }
 
 static int fsck_tag_buffer(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	struct object_id oid;
 	int ret = 0;
@@ -955,7 +955,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 }
 
 static int fsck_tag(struct tag *tag, const char *data,
-	unsigned long size, struct fsck_options *options)
+	size_t size, struct fsck_options *options)
 {
 	struct object *tagged = tag->tagged;
 
@@ -1006,7 +1006,7 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 }
 
 static int fsck_blob(struct blob *blob, const char *buf,
-		     unsigned long size, struct fsck_options *options)
+		     size_t size, struct fsck_options *options)
 {
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
@@ -1042,7 +1042,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 	return data.ret;
 }
 
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options)
 {
 	if (!obj)
@@ -1084,7 +1084,7 @@ int fsck_finish(struct fsck_options *options)
 	while ((oid = oidset_iter_next(&iter))) {
 		struct blob *blob;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		char *buf;
 
 		if (oidset_contains(&gitmodules_done, oid))
diff --git a/fsck.h b/fsck.h
index b95595ae5f..939ccf856b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -53,7 +53,7 @@ struct fsck_options {
  */
 int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 /* If NULL is passed for data, we assume the object is local and read it. */
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct object *obj, void *data, size_t size,
 	struct fsck_options *options);
 
 /*
diff --git a/fuzz-pack-headers.c b/fuzz-pack-headers.c
index 99da1d0fd3..d04e264e23 100644
--- a/fuzz-pack-headers.c
+++ b/fuzz-pack-headers.c
@@ -5,10 +5,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	unpack_object_header_buffer((const unsigned char *)data,
-				    (unsigned long)size, &type, &len);
+				    size, &type, &len);
 
 	return 0;
 }
diff --git a/grep.h b/grep.h
index fb04893721..5765213f4b 100644
--- a/grep.h
+++ b/grep.h
@@ -209,7 +209,7 @@ struct grep_source {
 	void *identifier;
 
 	char *buf;
-	unsigned long size;
+	size_t size;
 
 	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
diff --git a/http-push.c b/http-push.c
index cd48590912..902790859e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -359,7 +359,7 @@ static void start_put(struct transfer_request *request)
 	enum object_type type;
 	char hdr[50];
 	void *unpacked;
-	unsigned long len;
+	size_t len;
 	int hdrlen;
 	ssize_t size;
 	git_zstream stream;
diff --git a/list-objects-filter.c b/list-objects-filter.c
index a62624a1ce..ef31a7660e 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -154,7 +154,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 	void *filter_data_)
 {
 	struct filter_blobs_limit_data *filter_data = filter_data_;
-	unsigned long object_length;
+	size_t object_length;
 	enum object_type t;
 
 	switch (filter_situation) {
diff --git a/mailmap.c b/mailmap.c
index 962fd86d6d..ec7ba47eef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -217,7 +217,7 @@ static int read_mailmap_blob(struct string_list *map,
 {
 	struct object_id oid;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (!name)
diff --git a/match-trees.c b/match-trees.c
index 2b6d31ef9d..af3ded64e9 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -53,7 +53,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 {
 	void *buffer;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	buffer = read_object_file(hash, &type, &size);
 	if (!buffer)
@@ -177,7 +177,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	char *subpath;
 	int toplen;
 	char *buf;
-	unsigned long sz;
+	size_t sz;
 	struct tree_desc desc;
 	struct object_id *rewrite_here;
 	const struct object_id *rewrite_with;
diff --git a/merge-blobs.c b/merge-blobs.c
index ee0a0e90c9..f19ee015cc 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -9,7 +9,7 @@
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
 	void *buf;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	buf = read_object_file(&obj->object.oid, &type, &size);
@@ -34,7 +34,7 @@ static void *three_way_filemerge(struct index_state *istate,
 				 mmfile_t *base,
 				 mmfile_t *our,
 				 mmfile_t *their,
-				 unsigned long *size)
+				 size_t *size)
 {
 	int merge_status;
 	mmbuffer_t res;
@@ -57,7 +57,7 @@ static void *three_way_filemerge(struct index_state *istate,
 
 void *merge_blobs(struct index_state *istate, const char *path,
 		  struct blob *base, struct blob *our,
-		  struct blob *their, unsigned long *size)
+		  struct blob *their, size_t *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
diff --git a/merge-blobs.h b/merge-blobs.h
index cc31038b80..7f37952b0e 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -6,6 +6,6 @@ struct index_state;
 
 extern void *merge_blobs(struct index_state *, const char *,
 			 struct blob *, struct blob *,
-			 struct blob *, unsigned long *);
+			 struct blob *, size_t *);
 
 #endif /* MERGE_BLOBS_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index ecf8db0b71..457e748204 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -950,7 +950,7 @@ static int update_file_flags(struct merge_options *o,
 	if (update_wd) {
 		enum object_type type;
 		void *buf;
-		unsigned long size;
+		size_t size;
 
 		if (S_ISGITLINK(mode)) {
 			/*
@@ -3003,7 +3003,7 @@ static int read_oid_strbuf(struct merge_options *o,
 {
 	void *buf;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return err(o, _("cannot read object %s"), oid_to_hex(oid));
diff --git a/notes-cache.c b/notes-cache.c
index 2473314d68..7914f1073f 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -76,7 +76,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	const struct object_id *value_oid;
 	enum object_type type;
 	char *value;
-	unsigned long size;
+	size_t size;
 
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
diff --git a/notes-merge.c b/notes-merge.c
index 72688d301b..5732a4cd56 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -297,7 +297,7 @@ static void check_notes_merge_worktree(struct notes_merge_options *o)
 }
 
 static void write_buf_to_worktree(const struct object_id *obj,
-				  const char *buf, unsigned long size)
+				  const char *buf, size_t size)
 {
 	int fd;
 	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
@@ -326,7 +326,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 				   const struct object_id *note)
 {
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	void *buf = read_object_file(note, &type, &size);
 
 	if (!buf)
diff --git a/notes.c b/notes.c
index 25cdce28b7..309f856ba0 100644
--- a/notes.c
+++ b/notes.c
@@ -791,7 +791,7 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 			      const struct object_id *new_oid)
 {
 	char *cur_msg = NULL, *new_msg = NULL, *buf;
-	unsigned long cur_len, new_len, buf_len;
+	size_t cur_len, new_len, buf_len;
 	enum object_type cur_type, new_type;
 	int ret;
 
@@ -852,7 +852,7 @@ static int string_list_add_note_lines(struct string_list *list,
 				      const struct object_id *oid)
 {
 	char *data;
-	unsigned long len;
+	size_t len;
 	enum object_type t;
 
 	if (is_null_oid(oid))
@@ -1206,7 +1206,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
 	char *msg, *msg_p;
-	unsigned long linelen, msglen;
+	size_t linelen, msglen;
 	enum object_type type;
 
 	if (!t)
diff --git a/object-store.h b/object-store.h
index 8dceed0f31..886c81d9c8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -155,16 +155,16 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 const char *loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
 
-void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
+void *map_sha1_file(struct repository *r, const unsigned char *sha1, size_t *size);
 
 extern void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
-				       unsigned long *size, int lookup_replace);
+				       size_t *size, int lookup_replace);
 static inline void *repo_read_object_file(struct repository *r,
 					  const struct object_id *oid,
 					  enum object_type *type,
-					  unsigned long *size)
+					  size_t *size)
 {
 	return read_object_file_extended(r, oid, type, size, 1);
 }
@@ -173,19 +173,19 @@ static inline void *repo_read_object_file(struct repository *r,
 #endif
 
 /* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+int oid_object_info(struct repository *r, const struct object_id *, size_t *);
 
-extern int hash_object_file(const void *buf, unsigned long len,
+extern int hash_object_file(const void *buf, size_t len,
 			    const char *type, struct object_id *oid);
 
-extern int write_object_file(const void *buf, unsigned long len,
+extern int write_object_file(const void *buf, size_t len,
 			     const char *type, struct object_id *oid);
 
-extern int hash_object_file_literally(const void *buf, unsigned long len,
+extern int hash_object_file_literally(const void *buf, size_t len,
 				      const char *type, struct object_id *oid,
 				      unsigned flags);
 
-extern int pretend_object_file(void *, unsigned long, enum object_type,
+extern int pretend_object_file(void *, size_t, enum object_type,
 			       struct object_id *oid);
 
 extern int force_object_loose(const struct object_id *oid, time_t mtime);
@@ -200,7 +200,7 @@ extern int force_object_loose(const struct object_id *oid, time_t mtime);
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents);
 
 /*
@@ -242,7 +242,7 @@ extern void assert_oid_type(const struct object_id *oid, enum object_type expect
 struct object_info {
 	/* Request */
 	enum object_type *typep;
-	unsigned long *sizep;
+	size_t *sizep;
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *type_name;
diff --git a/object.c b/object.c
index c29a97a7e9..ad8c09c041 100644
--- a/object.c
+++ b/object.c
@@ -186,7 +186,7 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
@@ -248,7 +248,7 @@ struct object *parse_object_or_die(const struct object_id *oid,
 
 struct object *parse_object(struct repository *r, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	int eaten;
 	const struct object_id *repl = lookup_replace_object(r, oid);
diff --git a/object.h b/object.h
index 796792cb32..b97a625882 100644
--- a/object.h
+++ b/object.h
@@ -140,7 +140,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, size_t size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
diff --git a/pack-check.c b/pack-check.c
index 4ff725a89c..b86a5e17b5 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -108,7 +108,7 @@ static int verify_packfile(struct repository *r,
 	for (i = 0; i < nr_objects; i++) {
 		void *data;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		off_t curpos;
 		int data_valid;
 
diff --git a/pack-objects.h b/pack-objects.h
index 3fda9da83a..24937553bb 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -320,9 +320,9 @@ static inline void oe_set_delta_sibling(struct packing_data *pack,
 		e->delta_sibling_idx = 0;
 }
 
-unsigned long oe_get_size_slow(struct packing_data *pack,
+size_t oe_get_size_slow(struct packing_data *pack,
 			       const struct object_entry *e);
-static inline unsigned long oe_size(struct packing_data *pack,
+static inline size_t oe_size(struct packing_data *pack,
 				    const struct object_entry *e)
 {
 	if (e->size_valid)
@@ -333,7 +333,7 @@ static inline unsigned long oe_size(struct packing_data *pack,
 
 static inline int oe_size_less_than(struct packing_data *pack,
 				    const struct object_entry *lhs,
-				    unsigned long rhs)
+				    size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ < rhs;
@@ -344,7 +344,7 @@ static inline int oe_size_less_than(struct packing_data *pack,
 
 static inline int oe_size_greater_than(struct packing_data *pack,
 				       const struct object_entry *lhs,
-				       unsigned long rhs)
+				       size_t rhs)
 {
 	if (lhs->size_valid)
 		return lhs->size_ > rhs;
@@ -355,7 +355,7 @@ static inline int oe_size_greater_than(struct packing_data *pack,
 
 static inline void oe_set_size(struct packing_data *pack,
 			       struct object_entry *e,
-			       unsigned long size)
+			       size_t size)
 {
 	if (size < pack->oe_size_limit) {
 		e->size_ = size;
@@ -367,7 +367,7 @@ static inline void oe_set_size(struct packing_data *pack,
 	}
 }
 
-static inline unsigned long oe_delta_size(struct packing_data *pack,
+static inline size_t oe_delta_size(struct packing_data *pack,
 					  const struct object_entry *e)
 {
 	if (e->delta_size_valid)
@@ -386,7 +386,7 @@ static inline unsigned long oe_delta_size(struct packing_data *pack,
 
 static inline void oe_set_delta_size(struct packing_data *pack,
 				     struct object_entry *e,
-				     unsigned long size)
+				     size_t size)
 {
 	if (size < pack->oe_delta_size_limit) {
 		e->delta_size_ = size;
diff --git a/pack.h b/pack.h
index da99fdd1d2..6f61f83485 100644
--- a/pack.h
+++ b/pack.h
@@ -77,7 +77,7 @@ struct pack_idx_entry {
 
 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *, enum object_type, size_t, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
diff --git a/packfile.c b/packfile.c
index 373adbc8a6..672b6aca4a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -163,8 +163,8 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		 * variable sized table containing 8-byte entries
 		 * for offsets larger than 2^31.
 		 */
-		unsigned long min_size = 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;
-		unsigned long max_size = min_size;
+		size_t min_size = 8 + 4*256 + nr*(hashsz + 4 + 4) + hashsz + hashsz;
+		size_t max_size = min_size;
 		if (nr)
 			max_size += (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size)
@@ -1047,12 +1047,12 @@ struct list_head *get_packed_git_mru(struct repository *r)
 	return &r->objects->packed_git_mru;
 }
 
-unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+size_t unpack_object_header_buffer(const unsigned char *buf,
+		size_t len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
-	unsigned long used = 0;
+	size_t size, c;
+	size_t used = 0;
 
 	c = buf[used++];
 	*type = (c >> 4) & 7;
@@ -1072,7 +1072,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
+size_t get_size_from_delta(struct packed_git *p,
 				  struct pack_window **w_curs,
 				  off_t curpos)
 {
@@ -1114,11 +1114,11 @@ unsigned long get_size_from_delta(struct packed_git *p,
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	unsigned char *base;
 	size_t left;
-	unsigned long used;
+	size_t used;
 	enum object_type type;
 
 	/* use_pack() assures us we have [base, base + 20) available
@@ -1269,7 +1269,7 @@ static enum object_type packed_to_object_type(struct repository *r,
 
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
-		unsigned long size;
+		size_t size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1339,7 +1339,7 @@ struct delta_base_cache_entry {
 	struct delta_base_cache_key key;
 	struct list_head lru;
 	void *data;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 };
 
@@ -1404,7 +1404,7 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 }
 
 static void *cache_or_unpack_entry(struct repository *r, struct packed_git *p,
-				   off_t base_offset, unsigned long *base_size,
+				   off_t base_offset, size_t *base_size,
 				   enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1437,7 +1437,7 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+	void *base, size_t base_size, enum object_type type)
 {
 	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
 	struct list_head *lru, *tmp;
@@ -1469,7 +1469,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		       off_t obj_offset, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
+	size_t size;
 	off_t curpos = obj_offset;
 	enum object_type type;
 
@@ -1554,7 +1554,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-				    unsigned long size)
+				    size_t size)
 {
 	int st;
 	git_zstream stream;
@@ -1601,13 +1601,13 @@ int do_check_packed_object_crc;
 struct unpack_entry_stack_ent {
 	off_t obj_offset;
 	off_t curpos;
-	unsigned long size;
+	size_t size;
 };
 
 static void *read_object(struct repository *r,
 			 const struct object_id *oid,
 			 enum object_type *type,
-			 unsigned long *size)
+			 size_t *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
@@ -1621,12 +1621,12 @@ static void *read_object(struct repository *r,
 }
 
 void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
-		   enum object_type *final_type, unsigned long *final_size)
+		   enum object_type *final_type, size_t *final_size)
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
 	void *data = NULL;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
@@ -1726,7 +1726,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		void *delta_data;
 		void *base = data;
 		void *external_base = NULL;
-		unsigned long delta_size, base_size = size;
+		size_t delta_size, base_size = size;
 		int i;
 
 		data = NULL;
diff --git a/packfile.h b/packfile.h
index 7384b4a201..25459f7e96 100644
--- a/packfile.h
+++ b/packfile.h
@@ -131,10 +131,10 @@ extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
 extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, size_t *);
+extern size_t unpack_object_header_buffer(const unsigned char *buf, size_t len, enum object_type *type, size_t *sizep);
+extern size_t get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 
 extern void release_pack_memory(size_t);
 
diff --git a/patch-delta.c b/patch-delta.c
index b5c8594db6..42199fa956 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -12,13 +12,13 @@
 #include "git-compat-util.h"
 #include "delta.h"
 
-void *patch_delta(const void *src_buf, unsigned long src_size,
-		  const void *delta_buf, unsigned long delta_size,
-		  unsigned long *dst_size)
+void *patch_delta(const void *src_buf, size_t src_size,
+		  const void *delta_buf, size_t delta_size,
+		  size_t *dst_size)
 {
 	const unsigned char *data, *top;
 	unsigned char *dst_buf, *out, cmd;
-	unsigned long size;
+	size_t size;
 
 	if (delta_size < DELTA_SIZE_MIN)
 		return NULL;
diff --git a/range-diff.c b/range-diff.c
index 767af8c5bb..dcb189f40d 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -192,7 +192,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 	hashmap_free(&map, 0);
 }
 
-static void diffsize_consume(void *data, char *line, unsigned long len)
+static void diffsize_consume(void *data, char *line, size_t len)
 {
 	(*(int *)data)++;
 }
diff --git a/read-cache.c b/read-cache.c
index f68f40824c..483432972c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -229,7 +229,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 {
 	int match = -1;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -1676,7 +1676,7 @@ int verify_index_checksum;
 /* Allow fsck to force verification of the cache entry order. */
 int verify_ce_order;
 
-static int verify_hdr(const struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, size_t size)
 {
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1700,7 +1700,7 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 }
 
 static int read_index_extension(struct index_state *istate,
-				const char *ext, const char *data, unsigned long sz)
+				const char *ext, const char *data, size_t sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1746,7 +1746,7 @@ int read_index(struct index_state *istate)
 static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
 					    unsigned int version,
 					    struct ondisk_cache_entry *ondisk,
-					    unsigned long *ent_size,
+					    size_t *ent_size,
 					    const struct cache_entry *previous_ce)
 {
 	struct cache_entry *ce;
@@ -1937,13 +1937,13 @@ struct load_index_extensions
 	struct index_state *istate;
 	const char *mmap;
 	size_t mmap_size;
-	unsigned long src_offset;
+	size_t src_offset;
 };
 
 static void *load_index_extensions(void *_data)
 {
 	struct load_index_extensions *p = _data;
-	unsigned long src_offset = p->src_offset;
+	size_t src_offset = p->src_offset;
 
 	while (src_offset <= p->mmap_size - the_hash_algo->rawsz - 8) {
 		/* After an array of active_nr index entries,
@@ -1971,17 +1971,17 @@ static void *load_index_extensions(void *_data)
  * A helper function that will load the specified range of cache entries
  * from the memory mapped file and add them to the given index.
  */
-static unsigned long load_cache_entry_block(struct index_state *istate,
+static size_t load_cache_entry_block(struct index_state *istate,
 			struct mem_pool *ce_mem_pool, int offset, int nr, const char *mmap,
-			unsigned long start_offset, const struct cache_entry *previous_ce)
+			size_t start_offset, const struct cache_entry *previous_ce)
 {
 	int i;
-	unsigned long src_offset = start_offset;
+	size_t src_offset = start_offset;
 
 	for (i = offset; i < offset + nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
-		unsigned long consumed;
+		size_t consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
 		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
@@ -1993,10 +1993,10 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 	return src_offset - start_offset;
 }
 
-static unsigned long load_all_cache_entries(struct index_state *istate,
-			const char *mmap, size_t mmap_size, unsigned long src_offset)
+static size_t load_all_cache_entries(struct index_state *istate,
+			const char *mmap, size_t mmap_size, size_t src_offset)
 {
-	unsigned long consumed;
+	size_t consumed;
 
 	if (istate->version == 4) {
 		mem_pool_init(&istate->ce_mem_pool,
@@ -2030,7 +2030,7 @@ struct load_cache_entries_thread_data
 	struct index_entry_offset_table *ieot;
 	int ieot_start;		/* starting index into the ieot array */
 	int ieot_blocks;	/* count of ieot entries to process */
-	unsigned long consumed;	/* return # of bytes in index file processed */
+	size_t consumed;	/* return # of bytes in index file processed */
 };
 
 /*
@@ -2051,12 +2051,12 @@ static void *load_cache_entries_thread(void *_data)
 	return NULL;
 }
 
-static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
-			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
+static size_t load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
+			size_t src_offset, int nr_threads, struct index_entry_offset_table *ieot)
 {
 	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
-	unsigned long consumed = 0;
+	size_t consumed = 0;
 
 	/* a little sanity checking */
 	if (istate->name_hash_initialized)
@@ -2127,7 +2127,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
 	int fd;
 	struct stat st;
-	unsigned long src_offset;
+	size_t src_offset;
 	const struct cache_header *hdr;
 	const char *mmap;
 	size_t mmap_size;
@@ -2414,7 +2414,7 @@ int index_has_changes(struct index_state *istate,
 
 #define WRITE_BUFFER_SIZE 8192
 static unsigned char write_buffer[WRITE_BUFFER_SIZE];
-static unsigned long write_buffer_len;
+static size_t write_buffer_len;
 
 static int ce_write_flush(git_hash_ctx *context, int fd)
 {
@@ -2999,9 +2999,9 @@ static int write_split_index(struct index_state *istate,
 
 static const char *shared_index_expire = "2.weeks.ago";
 
-static unsigned long get_shared_index_expire_date(void)
+static size_t get_shared_index_expire_date(void)
 {
-	static unsigned long shared_index_expire_date;
+	static size_t shared_index_expire_date;
 	static int shared_index_expire_date_prepared;
 
 	if (!shared_index_expire_date_prepared) {
@@ -3017,7 +3017,7 @@ static unsigned long get_shared_index_expire_date(void)
 static int should_delete_shared_index(const char *shared_index_path)
 {
 	struct stat st;
-	unsigned long expiration;
+	size_t expiration;
 
 	/* Check timestamp */
 	expiration = get_shared_index_expire_date();
@@ -3249,10 +3249,10 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 }
 
 void *read_blob_data_from_index(const struct index_state *istate,
-				const char *path, unsigned long *size)
+				const char *path, size_t *size)
 {
 	int pos, len;
-	unsigned long sz;
+	size_t sz;
 	enum object_type type;
 	void *data;
 
diff --git a/ref-filter.c b/ref-filter.c
index be61586033..f8375e8884 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -68,7 +68,7 @@ struct refname_atom {
 static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 	off_t disk_size;
 	struct object_id delta_base_oid;
 	void *content;
@@ -934,7 +934,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 }
 
 /* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	struct tag *tag = (struct tag *) obj;
@@ -956,7 +956,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 }
 
 /* See grab_values */
-static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	struct commit *commit = (struct commit *) obj;
@@ -989,7 +989,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	}
 }
 
-static const char *find_wholine(const char *who, int wholen, const char *buf, unsigned long sz)
+static const char *find_wholine(const char *who, int wholen, const char *buf, size_t sz)
 {
 	const char *eol;
 	while (*buf) {
@@ -1035,7 +1035,7 @@ static const char *copy_email(const char *buf)
 	return xmemdupz(email, eoemail + 1 - email);
 }
 
-static char *copy_subject(const char *buf, unsigned long len)
+static char *copy_subject(const char *buf, size_t len)
 {
 	char *r = xmemdupz(buf, len);
 	int i;
@@ -1085,7 +1085,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 }
 
 /* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	int wholen = strlen(who);
@@ -1144,11 +1144,11 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
-static void find_subpos(const char *buf, unsigned long sz,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+static void find_subpos(const char *buf, size_t sz,
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -1192,7 +1192,7 @@ static void find_subpos(const char *buf, unsigned long sz,
  * If 'lines' is greater than 0, append that many lines from the given
  * 'buf' of length 'size' to the given strbuf.
  */
-static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
+static void append_lines(struct strbuf *out, const char *buf, size_t size, int lines)
 {
 	int i;
 	const char *sp, *eol;
@@ -1213,11 +1213,11 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1286,7 +1286,7 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	switch (obj->type) {
 	case OBJ_TAG:
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 3af708c5b6..38f79aaf8a 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -56,7 +56,7 @@ static char *read_ref_note(const struct object_id *oid)
 {
 	const struct object_id *note_oid;
 	char *msg = NULL;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;
 
 	init_notes(NULL, notes_ref, NULL, 0);
@@ -105,7 +105,7 @@ static int note2mark_cb(const struct object_id *object_oid,
 {
 	FILE *file = (FILE *)cb_data;
 	char *msg;
-	unsigned long msglen;
+	size_t msglen;
 	enum object_type type;
 	struct rev_note note;
 
diff --git a/rerere.c b/rerere.c
index 13624038e6..8e0e590227 100644
--- a/rerere.c
+++ b/rerere.c
@@ -973,7 +973,7 @@ static int handle_cache(struct index_state *istate,
 
 	while (pos < istate->cache_nr) {
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 
 		ce = istate->cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
diff --git a/sha1-file.c b/sha1-file.c
index 5d2acbda88..643a0e9be8 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -200,7 +200,7 @@ static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
 	void *buf;
-	unsigned long size;
+	size_t size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
@@ -871,7 +871,7 @@ void *xmmap(void *start, size_t length,
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(const struct object_id *oid, void *map,
-			   unsigned long size, const char *type)
+			   size_t size, const char *type)
 {
 	struct object_id real_oid;
 	enum object_type obj_type;
@@ -1012,7 +1012,7 @@ static int quick_has_loose(struct repository *r,
  * searching for a loose object named "sha1".
  */
 static void *map_sha1_file_1(struct repository *r, const char *path,
-			     const unsigned char *sha1, unsigned long *size)
+			     const unsigned char *sha1, size_t *size)
 {
 	void *map;
 	int fd;
@@ -1040,14 +1040,14 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 }
 
 void *map_sha1_file(struct repository *r,
-		    const unsigned char *sha1, unsigned long *size)
+		    const unsigned char *sha1, size_t *size)
 {
 	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-				    unsigned char *map, unsigned long mapsize,
-				    void *buffer, unsigned long bufsiz)
+				    unsigned char *map, size_t mapsize,
+				    void *buffer, size_t bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -1061,8 +1061,8 @@ static int unpack_sha1_short_header(git_zstream *stream,
 }
 
 int unpack_sha1_header(git_zstream *stream,
-		       unsigned char *map, unsigned long mapsize,
-		       void *buffer, unsigned long bufsiz)
+		       unsigned char *map, size_t mapsize,
+		       void *buffer, size_t bufsiz)
 {
 	int status = unpack_sha1_short_header(stream, map, mapsize,
 					      buffer, bufsiz);
@@ -1077,8 +1077,8 @@ int unpack_sha1_header(git_zstream *stream,
 }
 
 static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					unsigned long mapsize, void *buffer,
-					unsigned long bufsiz, struct strbuf *header)
+					size_t mapsize, void *buffer,
+					size_t bufsiz, struct strbuf *header)
 {
 	int status;
 
@@ -1112,11 +1112,11 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	return -1;
 }
 
-static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_sha1_rest(git_zstream *stream, void *buffer, size_t size, const unsigned char *sha1)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
-	unsigned long n;
+	size_t n;
 	int status = Z_OK;
 
 	n = stream->total_out - bytes;
@@ -1166,7 +1166,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 			       unsigned int flags)
 {
 	const char *type_buf = hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len = 0;
 
 	/*
@@ -1206,7 +1206,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 		return -1;
 	if (size) {
 		for (;;) {
-			unsigned long c = *hdr - '0';
+			size_t c = *hdr - '0';
 			if (c > 9)
 				break;
 			hdr++;
@@ -1223,7 +1223,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }
 
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_sha1_header(const char *hdr, size_t *sizep)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 
@@ -1236,12 +1236,12 @@ static int sha1_loose_object_info(struct repository *r,
 				  struct object_info *oi, int flags)
 {
 	int status = 0;
-	unsigned long mapsize;
+	size_t mapsize;
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
-	unsigned long size_scratch;
+	size_t size_scratch;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -1409,7 +1409,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 /* returns enum object_type or negative */
 int oid_object_info(struct repository *r,
 		    const struct object_id *oid,
-		    unsigned long *sizep)
+		    size_t *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1425,7 +1425,7 @@ int oid_object_info(struct repository *r,
 static void *read_object(struct repository *r,
 			 const unsigned char *sha1,
 			 enum object_type *type,
-			 unsigned long *size)
+			 size_t *size)
 {
 	struct object_id oid;
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -1441,7 +1441,7 @@ static void *read_object(struct repository *r,
 	return content;
 }
 
-int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+int pretend_object_file(void *buf, size_t len, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
@@ -1467,7 +1467,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
-				unsigned long *size,
+				size_t *size,
 				int lookup_replace)
 {
 	void *data;
@@ -1503,12 +1503,12 @@ void *read_object_file_extended(struct repository *r,
 
 void *read_object_with_reference(const struct object_id *oid,
 				 const char *required_type_name,
-				 unsigned long *size,
+				 size_t *size,
 				 struct object_id *actual_oid_return)
 {
 	enum object_type type, required_type;
 	void *buffer;
-	unsigned long isize;
+	size_t isize;
 	struct object_id actual_oid;
 
 	required_type = type_from_string(required_type_name);
@@ -1549,7 +1549,7 @@ void *read_object_with_reference(const struct object_id *oid,
 	}
 }
 
-static void write_object_file_prepare(const void *buf, unsigned long len,
+static void write_object_file_prepare(const void *buf, size_t len,
 				      const char *type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
@@ -1615,7 +1615,7 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-int hash_object_file(const void *buf, unsigned long len, const char *type,
+int hash_object_file(const void *buf, size_t len, const char *type,
 		     struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
@@ -1679,7 +1679,7 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 }
 
 static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, const void *buf, size_t len,
 			      time_t mtime)
 {
 	int fd, ret;
@@ -1769,7 +1769,7 @@ static int freshen_packed_object(const struct object_id *oid)
 	return 1;
 }
 
-int write_object_file(const void *buf, unsigned long len, const char *type,
+int write_object_file(const void *buf, size_t len, const char *type,
 		      struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
@@ -1784,7 +1784,7 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
 }
 
-int hash_object_file_literally(const void *buf, unsigned long len,
+int hash_object_file_literally(const void *buf, size_t len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags)
 {
@@ -1810,7 +1810,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 int force_object_loose(const struct object_id *oid, time_t mtime)
 {
 	void *buf;
-	unsigned long len;
+	size_t len;
 	enum object_type type;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
@@ -2247,14 +2247,14 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
-			     unsigned long size,
+			     size_t size,
 			     const char *path,
 			     const unsigned char *expected_sha1)
 {
 	git_hash_ctx c;
 	unsigned char real_sha1[GIT_MAX_RAWSZ];
 	unsigned char buf[4096];
-	unsigned long total_read;
+	size_t total_read;
 	int status = Z_OK;
 
 	the_hash_algo->init_fn(&c);
@@ -2306,12 +2306,12 @@ static int check_stream_sha1(git_zstream *stream,
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
 		      enum object_type *type,
-		      unsigned long *size,
+		      size_t *size,
 		      void **contents)
 {
 	int ret = -1;
 	void *map = NULL;
-	unsigned long mapsize;
+	size_t mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 
diff --git a/sha1dc_git.c b/sha1dc_git.c
index e0cc9d988c..b24fc9af55 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -25,7 +25,7 @@ void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
 /*
  * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
  */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 {
 	const char *data = vdata;
 	/* We expect an unsigned long, but sha1dc only takes an int */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 41e1c3fd3f..847b38fb4b 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -15,7 +15,7 @@ void git_SHA1DCInit(SHA1_CTX *);
 #endif
 
 void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
diff --git a/streaming.c b/streaming.c
index 891f82f51a..1e7a656738 100644
--- a/streaming.c
+++ b/streaming.c
@@ -69,19 +69,19 @@ struct filtered_istream {
 
 struct git_istream {
 	const struct stream_vtbl *vtbl;
-	unsigned long size; /* inflated size of full object */
+	size_t size; /* inflated size of full object */
 	git_zstream z;
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
 		struct {
 			char *buf; /* from read_object() */
-			unsigned long read_ptr;
+			size_t read_ptr;
 		} incore;
 
 		struct {
 			void *mapped;
-			unsigned long mapsize;
+			size_t mapsize;
 			char hdr[32];
 			int hdr_avail;
 			int hdr_used;
@@ -112,7 +112,7 @@ static enum input_source istream_source(const struct object_id *oid,
 					enum object_type *type,
 					struct object_info *oi)
 {
-	unsigned long size;
+	size_t size;
 	int status;
 
 	oi->typep = type;
@@ -135,7 +135,7 @@ static enum input_source istream_source(const struct object_id *oid,
 
 struct git_istream *open_istream(const struct object_id *oid,
 				 enum object_type *type,
-				 unsigned long *size,
+				 size_t *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
@@ -516,7 +516,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 {
 	struct git_istream *st;
 	enum object_type type;
-	unsigned long sz;
+	size_t sz;
 	ssize_t kept = 0;
 	int result = -1;
 
diff --git a/streaming.h b/streaming.h
index 32f4626771..552eb1d7c5 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,7 +8,7 @@
 /* opaque */
 struct git_istream;
 
-extern struct git_istream *open_istream(const struct object_id *, enum object_type *, unsigned long *, struct stream_filter *);
+extern struct git_istream *open_istream(const struct object_id *, enum object_type *, size_t *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
diff --git a/submodule-config.c b/submodule-config.c
index 52702c62d9..b9444318fd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -527,7 +527,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		enum lookup_type lookup_type)
 {
 	struct strbuf rev = STRBUF_INIT;
-	unsigned long config_size;
+	size_t config_size;
 	char *config = NULL;
 	struct object_id oid;
 	enum object_type type;
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index e749a49c88..b613cd0216 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -21,7 +21,7 @@ int cmd__delta(int argc, const char **argv)
 	int fd;
 	struct stat st;
 	void *from_buf, *data_buf, *out_buf;
-	unsigned long from_size, data_size, out_size;
+	size_t from_size, data_size, out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
diff --git a/tag.c b/tag.c
index 7445b8f6ea..a6c07419dc 100644
--- a/tag.c
+++ b/tag.c
@@ -41,7 +41,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 {
 	enum object_type type;
 	char *buf;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	type = oid_object_info(the_repository, oid, NULL);
@@ -132,7 +132,7 @@ void release_tag_memory(struct tag *t)
 	t->date = 0;
 }
 
-int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, size_t size)
 {
 	struct object_id oid;
 	char type[20];
@@ -195,7 +195,7 @@ int parse_tag(struct tag *item)
 {
 	enum object_type type;
 	void *data;
-	unsigned long size;
+	size_t size;
 	int ret;
 
 	if (item->object.parsed)
diff --git a/tag.h b/tag.h
index e669c3e497..b540b100ef 100644
--- a/tag.h
+++ b/tag.h
@@ -12,7 +12,7 @@ struct tag {
 	timestamp_t date;
 };
 extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
+extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, size_t size);
 extern int parse_tag(struct tag *item);
 extern void release_tag_memory(struct tag *t);
 extern struct object *deref_tag(struct repository *r, struct object *, const char *, int);
diff --git a/tree-walk.c b/tree-walk.c
index 79bafbd1a2..aefd189e46 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -82,7 +82,7 @@ int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned l
 
 void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid)
 {
-	unsigned long size = 0;
+	size_t size = 0;
 	void *buf = NULL;
 
 	if (oid) {
@@ -108,8 +108,8 @@ static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err
 {
 	const void *buf = desc->buffer;
 	const unsigned char *end = desc->entry.oid->hash + the_hash_algo->rawsz;
-	unsigned long size = desc->size;
-	unsigned long len = end - (const unsigned char *)buf;
+	size_t size = desc->size;
+	size_t len = end - (const unsigned char *)buf;
 
 	if (size < len)
 		die(_("too-short tree file"));
@@ -489,7 +489,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 
 struct dir_state {
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id oid;
 };
 
@@ -532,7 +532,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
 {
 	int retval;
 	void *tree;
-	unsigned long size;
+	size_t size;
 	struct object_id root;
 
 	tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
@@ -601,7 +601,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 		if (!t.buffer) {
 			void *tree;
 			struct object_id root;
-			unsigned long size;
+			size_t size;
 			tree = read_object_with_reference(&current_tree_oid,
 							  tree_type, &size,
 							  &root);
@@ -697,7 +697,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
 			goto done;
 		} else if (S_ISLNK(*mode)) {
 			/* Follow a symlink */
-			unsigned long link_len;
+			size_t link_len;
 			size_t len;
 			char *contents, *contents_start;
 			struct dir_state *parent;
diff --git a/tree.c b/tree.c
index 215d3fdc7c..817d952531 100644
--- a/tree.c
+++ b/tree.c
@@ -217,7 +217,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
-	 unsigned long size;
+	 size_t size;
 
 	if (item->object.parsed)
 		return 0;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 80f060d278..cd24e6c6fe 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -169,7 +169,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 {
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 
 	if (oideq(oid, &null_oid)) {
@@ -185,7 +185,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 }
 
 #define FIRST_FEW_BYTES 8000
-int buffer_is_binary(const char *ptr, unsigned long size)
+int buffer_is_binary(const char *ptr, size_t size)
 {
 	if (FIRST_FEW_BYTES < size)
 		size = FIRST_FEW_BYTES;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 2d41fffd4c..6c99f8d047 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,7 +11,7 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
-typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_line_fn)(void *, char *, size_t);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
 				   long old_begin, long old_nr,
 				   long new_begin, long new_nr,
@@ -25,7 +25,7 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
-int buffer_is_binary(const char *ptr, unsigned long size);
+int buffer_is_binary(const char *ptr, size_t size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
-- 
2.19.0.271.gfe8321ec05

