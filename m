Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CF51F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeIINnj (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38028 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINnh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id i7-v6so15144845lfh.5
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyHqFrfhdmSuq0/2pQ757no6N1fHe4EK8S8InLW6hTc=;
        b=AaBL5Q36z/pKYDco4NIgMXTZ+059VuDpfgXegGp5Di9iRQcILTpnvmm0OiVWqaE9pS
         ZIcn5H6Ny1p5gqGx3sSUFkfLlm+rK5BS7WADIax24hjZ8+ew+GCNPr/6cvb9TwFN+Zo5
         kuVJRqFSItcdt4ogc5sH7Bvb/0Mz6FtgWdcaSJM/Mamej/r50kEx2TZFcTApYY4rF2vC
         TX9po7aBjOo8jpdUNHiL8GNONqm+3QAj61O9beWk/y/KuFo1pIlMuxrIjzfzbuZMHtCw
         ACEdm2MciexYVxenRxy5P5SNb+SaFRQNk8lJ0kqYPFlYgYjQBWoaIkCNxd9Th7iXpytk
         odzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DyHqFrfhdmSuq0/2pQ757no6N1fHe4EK8S8InLW6hTc=;
        b=JaAZICl1T9ZEnvQyZKOBiX4puKCdsITJl21qxEOBQj0EptVYbBTuRNqiIfeyKri8hB
         GS/kFeeXwDb2Vebd+4qtdMrz7ZqFLhIfJCkuzqu24GTvbG3hxVY3rEGUbDYzZvnBIqti
         VLB3ccs3s8xBaDaVD/kwYx/ItfqhoVTD+6YMLi5fSQtbE/jpVOXviN0QdLvtyDnfNa5w
         +kOXaPjLMf1zfemb4v/HF19zdE3TOIADW4/oz+IzcB4YCnE9R/rdANRtFTmz3C8rfIF1
         TPiNNXb6CfUngSW0pGVoiXout+7kYvxZOdxs6q65vM93BJOp9s0RCaZf5L4GtXsOafg7
         K1fw==
X-Gm-Message-State: APzg51B4ROUCRgIcK4tV7F2DatTkCX0jOy/jIqrc14Zl/ZPhlwXdwP6W
        s9wxUKmbgENTHK+DMhEbJFc=
X-Google-Smtp-Source: ANB0VdbthQokQ6u3D4IPtzVJzMeBzN0LLQj3ps/ZXKExfdc2MlQPaVdTPz5MA7q9XlQS49I0wHdExw==
X-Received: by 2002:a19:c70a:: with SMTP id x10-v6mr9876993lff.148.1536483278370;
        Sun, 09 Sep 2018 01:54:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/23] diff.c: remove the_index dependency in textconv() functions
Date:   Sun,  9 Sep 2018 10:54:01 +0200
Message-Id: <20180909085418.31531-7-pclouds@gmail.com>
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
index 98bf50d89a..9d57c76baa 100644
--- a/blame.c
+++ b/blame.c
@@ -234,7 +234,7 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (opt->flags.allow_textconv &&
-			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
+			    textconv_object(r, read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
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
@@ -1857,7 +1858,7 @@ void setup_scoreboard(struct blame_scoreboard *sb,
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
index 4fa7707b57..9b43e557a1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -285,7 +285,8 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	return base;
 }
 
-static char *grab_blob(const struct object_id *oid, unsigned int mode,
+static char *grab_blob(struct repository *r,
+		       const struct object_id *oid, unsigned int mode,
 		       unsigned long *size, struct userdiff_driver *textconv,
 		       const char *path)
 {
@@ -304,7 +305,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 	} else if (textconv) {
 		struct diff_filespec *df = alloc_filespec(path);
 		fill_filespec(df, oid, 1, mode);
-		*size = fill_textconv(textconv, df, &blob);
+		*size = fill_textconv(r, textconv, df, &blob);
 		free_filespec(df);
 	} else {
 		blob = read_object_file(oid, &type, size);
@@ -389,7 +390,8 @@ static void consume_line(void *state_, char *line, unsigned long len)
 	}
 }
 
-static void combine_diff(const struct object_id *parent, unsigned int mode,
+static void combine_diff(struct repository *r,
+			 const struct object_id *parent, unsigned int mode,
 			 mmfile_t *result_file,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
@@ -407,7 +409,7 @@ static void combine_diff(const struct object_id *parent, unsigned int mode,
 	if (result_deleted)
 		return; /* result deleted */
 
-	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
+	parent_file.ptr = grab_blob(r, parent, mode, &sz, textconv, path);
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
index e5d6d30a67..0848ac65df 100644
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
@@ -6337,11 +6337,11 @@ static char *run_textconv(struct repository *r,
 	return strbuf_detach(&buf, outsize);
 }
 
-size_t fill_textconv(struct userdiff_driver *driver,
+size_t fill_textconv(struct repository *r,
+		     struct userdiff_driver *driver,
 		     struct diff_filespec *df,
 		     char **outbuf)
 {
-	struct repository *r = the_repository;
 	size_t size;
 
 	if (!driver) {
@@ -6386,7 +6386,8 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	return size;
 }
 
-int textconv_object(const char *path,
+int textconv_object(struct repository *r,
+		    const char *path,
 		    unsigned mode,
 		    const struct object_id *oid,
 		    int oid_valid,
@@ -6404,7 +6405,7 @@ int textconv_object(const char *path,
 		return 0;
 	}
 
-	*buf_size = fill_textconv(textconv, df, buf);
+	*buf_size = fill_textconv(r, textconv, df, buf);
 	free_filespec(df);
 	return 1;
 }
diff --git a/diff.h b/diff.h
index 0b67932109..812f71d953 100644
--- a/diff.h
+++ b/diff.h
@@ -442,7 +442,8 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
  * struct. If it is non-NULL, then "outbuf" points to a newly allocated buffer
  * that should be freed by the caller.
  */
-size_t fill_textconv(struct userdiff_driver *driver,
+size_t fill_textconv(struct repository *r,
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

