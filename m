Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3181F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeIINnx (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35506 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINnu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so15407646ljg.2
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehxX/zt2/TaX2/M41nM6gI+W9buxm0iiR8UxcrXVK8Y=;
        b=WB41myZDMPMVPrsrlg01VZYchkfp9pfMC3ZyDDX3lhvP0czx1CeosDekNHknulOwbw
         QZMDiZlACLgXfsB32iyuuKM/D9I4XNICCGEh4EKuoIhNOWNzpfjwoRB2rqhiuEcB5sng
         6wJMYHNBjjYS2aMEw+hpHrTmio1l9luuuZQ4QLE/mIAnfN8B0pdPSFw/tbwSN1dtsdlv
         hMqjinEmzDKwwcOIS7MQ0gGkAzoWM2UkCDuscp+Z2sjbWKMJohFEOkGlgLJDwIj/PGZ5
         kUwkuerbU3Z00+tHVOKMQjH05MKZ2bk5h4x3hRtHjAYXTi6mlHWEJ72VIhoIieKUvFQo
         6yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehxX/zt2/TaX2/M41nM6gI+W9buxm0iiR8UxcrXVK8Y=;
        b=SwQGOJjPQwhO1LC/dBKaFQWUVQ33EKZpMAh58rPEu/DwaAyTYcN/ZbWrVYzwh4WzUz
         FpCcb5wlO1CbR51ZA2UcADP6bK5VYBr7RFZsUUPHuPwv79oDqTvOnMR93QQw6PVa6Yri
         x7+OScl4MCZjNfVf5rpoWqh/KcrHJrwwqnPKACVOhKAW9aCQsLLt/EjWhEIlSb19Y/k9
         gpiwBQGhXCA63tUq7Zd8YWiZlhsJqTPTbrSvaU0SbDLCMKcZTKdnrNUwmm5/6uJMgWw3
         ULqAZizrti8tdcnJLmQavNE4sbdMaRj0ZxRZC/fautx+edFDaXvkieMe7q9bWq6CbIqM
         tbBQ==
X-Gm-Message-State: APzg51C/SS/zjWAaILv5PlndnKCWOBA0210zh7NGo6fBwtKrwHGf0aJq
        WC6Mvr0UnbyjF0RPeIhj2wOHpliy
X-Google-Smtp-Source: ANB0VdaEMCcBNlvK7XRSXY4ijfLPWh9Aig2uhFO6633lR274B/A+bWk3Fiz7+qHvJGqKqtII7gcvlQ==
X-Received: by 2002:a2e:2bd3:: with SMTP id r80-v6mr9763328ljr.57.1536483288266;
        Sun, 09 Sep 2018 01:54:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/23] sha1-file.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:10 +0200
Message-Id: <20180909085418.31531-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/difftool.c     |  2 +-
 builtin/hash-object.c  |  2 +-
 builtin/replace.c      |  2 +-
 builtin/update-index.c |  2 +-
 cache.h                |  4 ++--
 diff.c                 | 20 ++++++++---------
 notes-merge.c          |  2 +-
 read-cache.c           | 25 ++++++++++++---------
 sha1-file.c            | 50 ++++++++++++++++++++++++------------------
 9 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index cdd585ca76..e7023e3adf 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -112,7 +112,7 @@ static int use_wt_file(const char *workdir, const char *name,
 		int fd = open(buf.buf, O_RDONLY);
 
 		if (fd >= 0 &&
-		    !index_fd(&wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
+		    !index_fd(&the_index, &wt_oid, fd, &st, OBJ_BLOB, name, 0)) {
 			if (is_null_oid(oid)) {
 				oidcpy(oid, &wt_oid);
 				use = 1;
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 9ada4f4dfd..d6f06ea32f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -40,7 +40,7 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	if (fstat(fd, &st) < 0 ||
 	    (literally
 	     ? hash_literally(&oid, fd, type, flags)
-	     : index_fd(&oid, fd, &st, type_from_string(type), path, flags)))
+	     : index_fd(&the_index, &oid, fd, &st, type_from_string(type), path, flags)))
 		die((flags & HASH_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
diff --git a/builtin/replace.c b/builtin/replace.c
index 4f05791f3e..e0b16ad44b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -295,7 +295,7 @@ static int import_object(struct object_id *oid, enum object_type type,
 			close(fd);
 			return -1;
 		}
-		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
+		if (index_fd(&the_index, oid, fd, &st, type, NULL, flags) < 0)
 			return error(_("unable to write object to database"));
 		/* index_fd close()s fd for us */
 	}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index fe84003b4f..3086212fdb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -282,7 +282,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(&ce->oid, path, st,
+	if (index_path(&the_index, &ce->oid, path, st,
 		       info_only ? 0 : HASH_WRITE_OBJECT)) {
 		discard_cache_entry(ce);
 		return -1;
diff --git a/cache.h b/cache.h
index 49fe83331c..094652a503 100644
--- a/cache.h
+++ b/cache.h
@@ -787,8 +787,8 @@ extern int ie_modified(struct index_state *, const struct cache_entry *, struct
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
-extern int index_fd(struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-extern int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+extern int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+extern int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
 /*
  * Record to sd the data from st that we use to check whether a file
diff --git a/diff.c b/diff.c
index a06c3b070c..140d0e86df 100644
--- a/diff.c
+++ b/diff.c
@@ -4252,7 +4252,7 @@ static void run_diff_cmd(const char *pgm,
 		fprintf(o->file, "* Unmerged path %s\n", name);
 }
 
-static void diff_fill_oid_info(struct diff_filespec *one)
+static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
 {
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->oid_valid) {
@@ -4263,7 +4263,7 @@ static void diff_fill_oid_info(struct diff_filespec *one)
 			}
 			if (lstat(one->path, &st) < 0)
 				die_errno("stat '%s'", one->path);
-			if (index_path(&one->oid, one->path, &st, 0))
+			if (index_path(istate, &one->oid, one->path, &st, 0))
 				die("cannot hash %s", one->path);
 		}
 	}
@@ -4311,8 +4311,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
-	diff_fill_oid_info(one);
-	diff_fill_oid_info(two);
+	diff_fill_oid_info(one, o->repo->index);
+	diff_fill_oid_info(two, o->repo->index);
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
@@ -4359,8 +4359,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_oid_info(p->one);
-	diff_fill_oid_info(p->two);
+	diff_fill_oid_info(p->one, o->repo->index);
+	diff_fill_oid_info(p->two, o->repo->index);
 
 	builtin_diffstat(name, other, p->one, p->two,
 			 diffstat, o, p);
@@ -4384,8 +4384,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_oid_info(p->one);
-	diff_fill_oid_info(p->two);
+	diff_fill_oid_info(p->one, o->repo->index);
+	diff_fill_oid_info(p->two, o->repo->index);
 
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
@@ -5685,8 +5685,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (DIFF_PAIR_UNMERGED(p))
 			continue;
 
-		diff_fill_oid_info(p->one);
-		diff_fill_oid_info(p->two);
+		diff_fill_oid_info(p->one, options->repo->index);
+		diff_fill_oid_info(p->two, options->repo->index);
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
diff --git a/notes-merge.c b/notes-merge.c
index 432edfb89a..13dd9ba158 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -710,7 +710,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		/* write file as blob, and add to partial_tree */
 		if (stat(path.buf, &st))
 			die_errno("Failed to stat '%s'", path.buf);
-		if (index_path(&blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
+		if (index_path(&the_index, &blob_oid, path.buf, &st, HASH_WRITE_OBJECT))
 			die("Failed to write blob object from '%s'", path.buf);
 		if (add_note(partial_tree, &obj_oid, &blob_oid, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
diff --git a/read-cache.c b/read-cache.c
index 563500fe98..b707edd044 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -205,14 +205,16 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 	}
 }
 
-static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
+static int ce_compare_data(struct index_state *istate,
+			   const struct cache_entry *ce,
+			   struct stat *st)
 {
 	int match = -1;
 	int fd = git_open_cloexec(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
 		struct object_id oid;
-		if (!index_fd(&oid, fd, st, OBJ_BLOB, ce->name, 0))
+		if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0))
 			match = oidcmp(&oid, &ce->oid);
 		/* index_fd() closed the file descriptor already */
 	}
@@ -257,11 +259,13 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	return oidcmp(&oid, &ce->oid);
 }
 
-static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
+static int ce_modified_check_fs(struct index_state *istate,
+				const struct cache_entry *ce,
+				struct stat *st)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
-		if (ce_compare_data(ce, st))
+		if (ce_compare_data(istate, ce, st))
 			return DATA_CHANGED;
 		break;
 	case S_IFLNK:
@@ -407,7 +411,7 @@ int ie_match_stat(struct index_state *istate,
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
-			changed |= ce_modified_check_fs(ce, st);
+			changed |= ce_modified_check_fs(istate, ce, st);
 	}
 
 	return changed;
@@ -447,7 +451,7 @@ int ie_modified(struct index_state *istate,
 	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size != 0))
 		return changed;
 
-	changed_fs = ce_modified_check_fs(ce, st);
+	changed_fs = ce_modified_check_fs(istate, ce, st);
 	if (changed_fs)
 		return changed | changed_fs;
 	return 0;
@@ -753,7 +757,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		}
 	}
 	if (!intent_only) {
-		if (index_path(&ce->oid, path, st, newflags)) {
+		if (index_path(istate, &ce->oid, path, st, newflags)) {
 			discard_cache_entry(ce);
 			return error("unable to index file %s", path);
 		}
@@ -2230,7 +2234,8 @@ static int ce_flush(git_hash_ctx *context, int fd, unsigned char *hash)
 	return (write_in_full(fd, write_buffer, left) < 0) ? -1 : 0;
 }
 
-static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
+static void ce_smudge_racily_clean_entry(struct index_state *istate,
+					 struct cache_entry *ce)
 {
 	/*
 	 * The only thing we care about in this function is to smudge the
@@ -2249,7 +2254,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 		return;
 	if (ce_match_stat_basic(ce, &st))
 		return;
-	if (ce_modified_check_fs(ce, &st)) {
+	if (ce_modified_check_fs(istate, ce, &st)) {
 		/* This is "racily clean"; smudge it.  Note that this
 		 * is a tricky code.  At first glance, it may appear
 		 * that it can break with this sequence:
@@ -2494,7 +2499,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (ce->ce_flags & CE_REMOVE)
 			continue;
 		if (!ce_uptodate(ce) && is_racy_timestamp(istate, ce))
-			ce_smudge_racily_clean_entry(ce);
+			ce_smudge_racily_clean_entry(istate, ce);
 		if (is_null_oid(&ce->oid)) {
 			static const char msg[] = "cache entry has null sha1: %s";
 			static int allow = -1;
diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..308d5e20e2 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1813,7 +1813,8 @@ static void check_tag(const void *buf, size_t size)
 		die(_("corrupt tag"));
 }
 
-static int index_mem(struct object_id *oid, void *buf, size_t size,
+static int index_mem(struct index_state *istate,
+		     struct object_id *oid, void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
@@ -1828,7 +1829,7 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	 */
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
-		if (convert_to_git(&the_index, path, buf, size, &nbuf,
+		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
@@ -1852,17 +1853,20 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	return ret;
 }
 
-static int index_stream_convert_blob(struct object_id *oid, int fd,
-				     const char *path, unsigned flags)
+static int index_stream_convert_blob(struct index_state *istate,
+				     struct object_id *oid,
+				     int fd,
+				     const char *path,
+				     unsigned flags)
 {
 	int ret;
 	const int write_object = flags & HASH_WRITE_OBJECT;
 	struct strbuf sbuf = STRBUF_INIT;
 
 	assert(path);
-	assert(would_convert_to_git_filter_fd(&the_index, path));
+	assert(would_convert_to_git_filter_fd(istate, path));
 
-	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
+	convert_to_git_filter_fd(istate, path, fd, &sbuf,
 				 get_conv_flags(flags));
 
 	if (write_object)
@@ -1875,14 +1879,15 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	return ret;
 }
 
-static int index_pipe(struct object_id *oid, int fd, enum object_type type,
+static int index_pipe(struct index_state *istate, struct object_id *oid,
+		      int fd, enum object_type type,
 		      const char *path, unsigned flags)
 {
 	struct strbuf sbuf = STRBUF_INIT;
 	int ret;
 
 	if (strbuf_read(&sbuf, fd, 4096) >= 0)
-		ret = index_mem(oid, sbuf.buf, sbuf.len, type, path, flags);
+		ret = index_mem(istate, oid, sbuf.buf, sbuf.len, type, path, flags);
 	else
 		ret = -1;
 	strbuf_release(&sbuf);
@@ -1891,14 +1896,15 @@ static int index_pipe(struct object_id *oid, int fd, enum object_type type,
 
 #define SMALL_FILE_SIZE (32*1024)
 
-static int index_core(struct object_id *oid, int fd, size_t size,
+static int index_core(struct index_state *istate,
+		      struct object_id *oid, int fd, size_t size,
 		      enum object_type type, const char *path,
 		      unsigned flags)
 {
 	int ret;
 
 	if (!size) {
-		ret = index_mem(oid, "", size, type, path, flags);
+		ret = index_mem(istate, oid, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		ssize_t read_result = read_in_full(fd, buf, size);
@@ -1909,11 +1915,11 @@ static int index_core(struct object_id *oid, int fd, size_t size,
 			ret = error(_("short read while indexing %s"),
 				    path ? path : "<unknown>");
 		else
-			ret = index_mem(oid, buf, size, type, path, flags);
+			ret = index_mem(istate, oid, buf, size, type, path, flags);
 		free(buf);
 	} else {
 		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-		ret = index_mem(oid, buf, size, type, path, flags);
+		ret = index_mem(istate, oid, buf, size, type, path, flags);
 		munmap(buf, size);
 	}
 	return ret;
@@ -1941,7 +1947,8 @@ static int index_stream(struct object_id *oid, int fd, size_t size,
 	return index_bulk_checkin(oid, fd, size, type, path, flags);
 }
 
-int index_fd(struct object_id *oid, int fd, struct stat *st,
+int index_fd(struct index_state *istate, struct object_id *oid,
+	     int fd, struct stat *st,
 	     enum object_type type, const char *path, unsigned flags)
 {
 	int ret;
@@ -1950,14 +1957,14 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
 	 * die() for large files.
 	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(&the_index, path))
-		ret = index_stream_convert_blob(oid, fd, path, flags);
+	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
+		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
-		ret = index_pipe(oid, fd, type, path, flags);
+		ret = index_pipe(istate, oid, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(&the_index, path)))
-		ret = index_core(oid, fd, xsize_t(st->st_size), type, path,
-				 flags);
+		 (path && would_convert_to_git(istate, path)))
+		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
+				 type, path, flags);
 	else
 		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
 				   flags);
@@ -1965,7 +1972,8 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 	return ret;
 }
 
-int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags)
+int index_path(struct index_state *istate, struct object_id *oid,
+	       const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
@@ -1976,7 +1984,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
-		if (index_fd(oid, fd, st, OBJ_BLOB, path, flags) < 0)
+		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error(_("%s: failed to insert into database"),
 				     path);
 		break;
-- 
2.19.0.rc0.337.ge906d732e7

