Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB281F428
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeHZNpa (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33514 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeHZNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id s12-v6so10019287ljj.0
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bhTQstJWE+Nc1lQ93SX/dthBDF9YVQQyuo0FgqNTEI=;
        b=qpF3CTEtrK0B76cbCvMgsSkJeVqsYK8MTKmXeE290P8Mf46AwPB9gz2s+YIjYoHgg6
         txYbQ9e4fVr2SYcSnW9eVkDyc5WZBDYyJ2TcIzN78XA/I9A+EYg1rzlEruTYsQEy9Puf
         wldTCxpXnV52yMpyQYittsqHMSZ+DZ/LCEOzce/MdglP7KpYB6Dkn0+f2Q4vXUSdYHpM
         Yxt+XBxcsC2o5m/aSW+kD1MYl8gAgPA3Uv3Kc88gLrYGVCJjYy12abHcajToGn8tQTS1
         T63I+wLwWSaWXxuxZYs2opa73gHzoCQJ0EvD6levdLL2GfFN0ik2XJJtZFvy+m1Tt+qm
         1sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bhTQstJWE+Nc1lQ93SX/dthBDF9YVQQyuo0FgqNTEI=;
        b=aijoXQxYHTdK/LyONJ00GbxtPJt4364LZmSrSQQJV4egoO8p8Td2RN2kFbLNtSU7Bk
         nfYmF6ZJOjFTpzLYP5rFiBNXfBvWReI+YRk17lh3cJ9bK3h9XMJSjebGOxQbv3NYfDOm
         qM1z0QwD+upQKtYvZew289hJd5+Kd8GD2rxCOO+v0MP4KHTkQL33PTSS3ak4ousKDmp/
         X5VEZ2sQQYWsDysPN1QKrdmxoBnky+QXa6bqqKuakTwfDbVs/TetT4fujeDnaOlBqNTA
         uE8PqUUrEWyLZMtZ9KwG9uPil8TlqPuP3J41YoLEISfQcBRmkRB5E7E/aQSlXwN59fxO
         qCXg==
X-Gm-Message-State: APzg51BXDx5igkfUQdM3/FswyIPpd6XCs/O5E+le5/JR4kdQPUie7Tz9
        ug8AMi/wTBcNCGrIRqCoLF0SEddH
X-Google-Smtp-Source: ANB0Vdb/JuXzSoE9w8ZTStAL0TszzYAnulkOHYACouqQ/4LTfqNqoolXSMUUxcfJz4j9+FSN7A88GQ==
X-Received: by 2002:a2e:5201:: with SMTP id g1-v6mr5666242ljb.144.1535277801574;
        Sun, 26 Aug 2018 03:03:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:20 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/21] diff.c: remove the_index dependency in textconv() functions
Date:   Sun, 26 Aug 2018 12:02:57 +0200
Message-Id: <20180826100314.5137-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 blame.c            |  7 ++++---
 builtin/cat-file.c |  6 ++++--
 builtin/log.c      |  3 ++-
 combine-diff.c     | 27 ++++++++++++++++-----------
 diff.c             | 17 +++++++++--------
 diff.h             |  9 +++++++--
 diffcore-pickaxe.c |  4 ++--
 grep.c             |  2 +-
 8 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/blame.c b/blame.c
index 08c0c6cf73..366d8d85e7 100644
--- a/blame.c
+++ b/blame.c
@@ -234,7 +234,7 @@ static struct commit *fake_working_tree_commit(struct repository *repo,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
-			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
+			    textconv_object(repo, read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
@@ -318,7 +318,8 @@ static void fill_origin_blob(struct diff_options *opt,
 
 		(*num_read_blob)++;
 		if (opt->flags.allow_textconv &&
-		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
+		    textconv_object(opt->repo, o->path, o->mode,
+				    &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
 			file->ptr = read_object_file(&o->blob_oid, &type,
@@ -1859,7 +1860,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
 			die(_("no such path %s in %s"), path, final_commit_name);
 
 		if (sb->revs->diffopt.flags.allow_textconv &&
-		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
+		    textconv_object(sb->repo, path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
 				    &sb->final_buf_size))
 			;
 		else
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 64ec1745ab..8d97c84725 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -113,7 +113,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
-		if (textconv_object(path, obj_context.mode, &oid, 1, &buf, &size))
+		if (textconv_object(the_repository, path, obj_context.mode,
+				    &oid, 1, &buf, &size))
 			break;
 		/* else fallthrough */
 
@@ -305,7 +306,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					    oid_to_hex(oid), data->rest);
 			} else if (opt->cmdmode == 'c') {
 				enum object_type type;
-				if (!textconv_object(data->rest, 0100644, oid,
+				if (!textconv_object(the_repository,
+						     data->rest, 0100644, oid,
 						     1, &contents, &size))
 					contents = read_object_file(oid,
 								    &type,
diff --git a/builtin/log.c b/builtin/log.c
index e094560d9a..f32a07f6a9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -507,7 +507,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
-	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size)) {
+	    !textconv_object(the_repository, obj_context.path,
+			     obj_context.mode, &oidc, 1, &buf, &size)) {
 		free(obj_context.path);
 		return stream_blob_to_fd(1, oid, NULL, 0);
 	}
diff --git a/combine-diff.c b/combine-diff.c
index 4fa7707b57..ec20fff63b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -285,7 +285,8 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	return base;
 }
 
-static char *grab_blob(const struct object_id *oid, unsigned int mode,
+static char *grab_blob(struct repository *repo,
+		       const struct object_id *oid, unsigned int mode,
 		       unsigned long *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
@@ -304,7 +305,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
 		fill_filespec(df, oid, 1, mode);
-		*size = fill_textconv(textconv, df, &blob);
+		*size = fill_textconv(repo, textconv, df, &blob);
 		free_filespec(df);
 	} else {
 		blob = read_object_file(oid, &type, size);
@@ -389,7 +390,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const struct object_id *parent, unsigned int mode,
+static void combine_diff(struct repository *repo,
+			 const struct object_id *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
@@ -407,7 +409,7 @@ static void combine_diff(const struct object_id *parent, unsigned int mode,
 	if (result_deleted)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
+	parent_file.ptr = grab_blob(repo, parent, mode, &sz, textconv, path);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
 	xpp.flags = flags;
@@ -993,7 +995,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
-		result = grab_blob(&elem->oid, elem->mode, &result_size,
+		result = grab_blob(opt->repo, &elem->oid, elem->mode, &result_size,
 				   textconv, elem->path);
 	else {
 		/* Used by diff-tree to read from the working tree */
@@ -1016,15 +1018,16 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
 			if (resolve_gitlink_ref(elem->path, "HEAD", &oid) < 0)
-				result = grab_blob(&elem->oid, elem->mode,
-						   &result_size, NULL, NULL);
+				result = grab_blob(opt->repo, &elem->oid,
+						   elem->mode, &result_size,
+						   NULL, NULL);
 			else
-				result = grab_blob(&oid, elem->mode,
+				result = grab_blob(opt->repo, &oid, elem->mode,
 						   &result_size, NULL, NULL);
 		} else if (textconv) {
 			struct diff_filespec *df = alloc_filespec(elem->path);
 			fill_filespec(df, &null_oid, 0, st.st_mode);
-			result_size = fill_textconv(textconv, df, &result);
+			result_size = fill_textconv(opt->repo, textconv, df, &result);
 			free_filespec(df);
 		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
@@ -1090,7 +1093,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		for (i = 0; !is_binary && i < num_parent; i++) {
 			char *buf;
 			unsigned long size;
-			buf = grab_blob(&elem->parent[i].oid,
+			buf = grab_blob(opt->repo,
+					&elem->parent[i].oid,
 					elem->parent[i].mode,
 					&size, NULL, NULL);
 			if (buffer_is_binary(buf, size))
@@ -1146,7 +1150,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			}
 		}
 		if (i <= j)
-			combine_diff(&elem->parent[i].oid,
+			combine_diff(opt->repo,
+				     &elem->parent[i].oid,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
diff --git a/diff.c b/diff.c
index 8040f8b0f0..c6ff993c56 100644
--- a/diff.c
+++ b/diff.c
@@ -1700,8 +1700,8 @@ static void emit_rewrite_diff(const char *name_a,
 	quote_two_c_style(&a_name, a_prefix, name_a, 0);
 	quote_two_c_style(&b_name, b_prefix, name_b, 0);
 
-	size_one = fill_textconv(textconv_one, one, &data_one);
-	size_two = fill_textconv(textconv_two, two, &data_two);
+	size_one = fill_textconv(o->repo, textconv_one, one, &data_one);
+	size_two = fill_textconv(o->repo, textconv_two, two, &data_two);
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = want_color(o->use_color);
@@ -3462,8 +3462,8 @@ static void builtin_diff(const char *name_a,
 			strbuf_reset(&header);
 		}
 
-		mf1.size = fill_textconv(textconv_one, one, &mf1.ptr);
-		mf2.size = fill_textconv(textconv_two, two, &mf2.ptr);
+		mf1.size = fill_textconv(o->repo, textconv_one, one, &mf1.ptr);
+		mf2.size = fill_textconv(o->repo, textconv_two, two, &mf2.ptr);
 
 		pe = diff_funcname_pattern(one);
 		if (!pe)
@@ -6337,11 +6337,11 @@ static char *run_textconv(struct repository *repo,
 	return strbuf_detach(&buf, outsize);
 }
 
-size_t fill_textconv(struct userdiff_driver *driver,
+size_t fill_textconv(struct repository *repo,
+		     struct userdiff_driver *driver,
 		     struct diff_filespec *df,
 		     char **outbuf)
 {
-	struct repository *repo = the_repository;
 	size_t size;
 
 	if (!driver) {
@@ -6386,7 +6386,8 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	return size;
 }
 
-int textconv_object(const char *path,
+int textconv_object(struct repository *repo,
+		    const char *path,
 		    unsigned mode,
 		    const struct object_id *oid,
 		    int oid_valid,
@@ -6404,7 +6405,7 @@ int textconv_object(const char *path,
 		return 0;
 	}
 
-	*buf_size = fill_textconv(textconv, df, buf);
+	*buf_size = fill_textconv(repo, textconv, df, buf);
 	free_filespec(df);
 	return 1;
 }
diff --git a/diff.h b/diff.h
index 0b67932109..07ba13ec4c 100644
--- a/diff.h
+++ b/diff.h
@@ -442,7 +442,8 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
  * struct. If it is non-NULL, then "outbuf" points to a newly allocated buffer
  * that should be freed by the caller.
  */
-size_t fill_textconv(struct userdiff_driver *driver,
+size_t fill_textconv(struct repository *repo,
+		     struct userdiff_driver *driver,
 		     struct diff_filespec *df,
 		     char **outbuf);
 
@@ -458,7 +459,11 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one);
  * if the textconv driver exists.
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
-int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
+int textconv_object(struct repository *repo,
+		    const char *path,
+		    unsigned mode,
+		    const struct object_id *oid, int oid_valid,
+		    char **buf, unsigned long *buf_size);
 
 int parse_rename_score(const char **cp_p);
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 800a899c86..7a5cf446ff 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -153,8 +153,8 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (textconv_one == textconv_two && diff_unmodified_pair(p))
 		return 0;
 
-	mf1.size = fill_textconv(textconv_one, p->one, &mf1.ptr);
-	mf2.size = fill_textconv(textconv_two, p->two, &mf2.ptr);
+	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
+	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
 	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
 		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
diff --git a/grep.c b/grep.c
index 2b26cee08d..e146ff20bb 100644
--- a/grep.c
+++ b/grep.c
@@ -1741,7 +1741,7 @@ static int fill_textconv_grep(struct userdiff_driver *driver,
 	 * structure.
 	 */
 	grep_read_lock();
-	size = fill_textconv(driver, df, &buf);
+	size = fill_textconv(the_repository, driver, df, &buf);
 	grep_read_unlock();
 	free_filespec(df);
 
-- 
2.19.0.rc0.337.ge906d732e7

