Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A91F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbeIUVrZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46230 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389804AbeIUVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so12081132ljj.13
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTiD7psJYxPB68LwnLu8FllE3/MHex/noFVO85mcT58=;
        b=cV5gCE1aYglCnRKNP7zyfE8FP056seWa1e2otxuszsbnPmTy4g9hloPw+5dejmYhte
         +e7bcJnqAGT2zEtVQjRODEiq16lKaHbup1B5eXXNBV8QcxAB/6mnH0FmH+1hmtwNnfAM
         0H4fnY2e3wak5UlquMByhV7ZPUh5OjCmHgVB6a+R62oS/q+u/DKxoGb9WiWsJ21Jk8+L
         93JqwaFZ6NkkoMo4Vnt5Y/5C6mJ9OpBFuz9r0W2sGn5hfyxP4bYy36AyctWEcJLC2GCT
         biNLvIr2ploiGqd2vHt2UVxY8mOXa+vCkJntZbg/ewrCjCa7bihkrMff7PvNNXucJHne
         1bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTiD7psJYxPB68LwnLu8FllE3/MHex/noFVO85mcT58=;
        b=MGxyXNHEc0bQRoRSSX8d0u5BU0yPdxmh7dx7DdlLRzF61N37oB2kvzajiN/R5w5gBl
         p6+Dx4UcxUtgCd8fNb9HyU+ixVuBdKKmHIKFEe4ll9Mj+aRuAZ4+IJESxNLkquX6RHds
         2tvclujx0ZCLPRNiEtqNFUwhBH7ePpDY91oDupEXRMH81sHG2zKgUx4bdaJkENydnJpt
         VUGrGdzIoQYUWEM2YF59UvJOVOHdDs5UemoMxDxtqRFKYQooWhnIOlktX7ZvQqlSv/sz
         n6VcmY+s20gIfOtLSt/p7tFIc/1nYRAAoUTsom2wajFMUGJeonQDlAG7DwooVokavrE1
         L0oQ==
X-Gm-Message-State: ABuFfohiucUU/o8UpD1v0VK+YjCl2NBaAr5WLh4R8Z+nQ4icHN2ovBwy
        Yi+okpEu86XxCYAw+A6Qk8iqeFpS
X-Google-Smtp-Source: ACcGV61wV3P/libr/Pu4sCdrbF+HytwczLekl+qr5IXCCse8zOrIHXaQiKI1GUwrWRF3Bs+bFK+O9Q==
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr2514209ljc.141.1537545471600;
        Fri, 21 Sep 2018 08:57:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:57:50 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 03/23] diff.c: reduce implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:19 +0200
Message-Id: <20180921155739.14407-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diff and textconv code has so widespread use that it's hard to simply
update their api and all call sites at once because it would result in
a big patch. For now reduce the_index references to two places:
diff_setup() and fill_textconv().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reset.c   |   1 +
 diff.c            | 176 +++++++++++++++++++++++++++-------------------
 diff.h            |   3 +
 diffcore-break.c  |  12 ++--
 diffcore-delta.c  |  12 ++--
 diffcore-rename.c |  35 +++++----
 diffcore.h        |  13 ++--
 line-log.c        |  21 +++---
 8 files changed, 161 insertions(+), 112 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..6d37a35e2e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -159,6 +159,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
 	opt.flags.override_submodule_config = 1;
+	opt.repo = the_repository;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
diff --git a/diff.c b/diff.c
index 145cfbae59..e5d6d30a67 100644
--- a/diff.c
+++ b/diff.c
@@ -554,14 +554,15 @@ static int count_lines(const char *data, int size)
 	return count;
 }
 
-static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
+static int fill_mmfile(struct repository *r, mmfile_t *mf,
+		       struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one)) {
 		mf->ptr = (char *)""; /* does not matter */
 		mf->size = 0;
 		return 0;
 	}
-	else if (diff_populate_filespec(one, 0))
+	else if (diff_populate_filespec(r, one, 0))
 		return -1;
 
 	mf->ptr = one->data;
@@ -570,11 +571,12 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 }
 
 /* like fill_mmfile, but only for size, so we can avoid retrieving blob */
-static unsigned long diff_filespec_size(struct diff_filespec *one)
+static unsigned long diff_filespec_size(struct repository *r,
+					struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return 0;
-	diff_populate_filespec(one, CHECK_SIZE_ONLY);
+	diff_populate_filespec(r, one, CHECK_SIZE_ONLY);
 	return one->size;
 }
 
@@ -2965,18 +2967,19 @@ static void show_dirstat(struct diff_options *options)
 		}
 
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(p->one, 0);
-			diff_populate_filespec(p->two, 0);
-			diffcore_count_changes(p->one, p->two, NULL, NULL,
+			diff_populate_filespec(options->repo, p->one, 0);
+			diff_populate_filespec(options->repo, p->two, 0);
+			diffcore_count_changes(options->repo,
+					       p->one, p->two, NULL, NULL,
 					       &copied, &added);
 			diff_free_filespec_data(p->one);
 			diff_free_filespec_data(p->two);
 		} else if (DIFF_FILE_VALID(p->one)) {
-			diff_populate_filespec(p->one, CHECK_SIZE_ONLY);
+			diff_populate_filespec(options->repo, p->one, CHECK_SIZE_ONLY);
 			copied = added = 0;
 			diff_free_filespec_data(p->one);
 		} else if (DIFF_FILE_VALID(p->two)) {
-			diff_populate_filespec(p->two, CHECK_SIZE_ONLY);
+			diff_populate_filespec(options->repo, p->two, CHECK_SIZE_ONLY);
 			copied = 0;
 			added = p->two->size;
 			diff_free_filespec_data(p->two);
@@ -3250,7 +3253,8 @@ static void emit_binary_diff(struct diff_options *o,
 	emit_binary_diff_body(o, two, one);
 }
 
-int diff_filespec_is_binary(struct diff_filespec *one)
+int diff_filespec_is_binary(struct repository *r,
+			    struct diff_filespec *one)
 {
 	if (one->is_binary == -1) {
 		diff_filespec_load_driver(one);
@@ -3258,7 +3262,7 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 			one->is_binary = one->driver->binary;
 		else {
 			if (!one->data && DIFF_FILE_VALID(one))
-				diff_populate_filespec(one, CHECK_BINARY);
+				diff_populate_filespec(r, one, CHECK_BINARY);
 			if (one->is_binary == -1 && one->data)
 				one->is_binary = buffer_is_binary(one->data,
 						one->size);
@@ -3380,13 +3384,13 @@ static void builtin_diff(const char *name_a,
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite &&
-		    (textconv_one || !diff_filespec_is_binary(one)) &&
-		    (textconv_two || !diff_filespec_is_binary(two))) {
+		    (textconv_one || !diff_filespec_is_binary(o->repo, one)) &&
+		    (textconv_two || !diff_filespec_is_binary(o->repo, two))) {
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
 					 header.buf, header.len, 0);
 			strbuf_reset(&header);
 			emit_rewrite_diff(name_a, name_b, one, two,
-						textconv_one, textconv_two, o);
+					  textconv_one, textconv_two, o);
 			o->found_changes = 1;
 			goto free_ab_and_return;
 		}
@@ -3398,8 +3402,8 @@ static void builtin_diff(const char *name_a,
 		strbuf_reset(&header);
 		goto free_ab_and_return;
 	} else if (!o->flags.text &&
-	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
-	      (!textconv_two && diff_filespec_is_binary(two)) )) {
+		   ( (!textconv_one && diff_filespec_is_binary(o->repo, one)) ||
+		     (!textconv_two && diff_filespec_is_binary(o->repo, two)) )) {
 		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
@@ -3420,7 +3424,8 @@ static void builtin_diff(const char *name_a,
 			strbuf_release(&sb);
 			goto free_ab_and_return;
 		}
-		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+		if (fill_mmfile(o->repo, &mf1, one) < 0 ||
+		    fill_mmfile(o->repo, &mf2, two) < 0)
 			die("unable to read files to diff");
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
@@ -3571,20 +3576,21 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	same_contents = !oidcmp(&one->oid, &two->oid);
 
-	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
+	if (diff_filespec_is_binary(o->repo, one) ||
+	    diff_filespec_is_binary(o->repo, two)) {
 		data->is_binary = 1;
 		if (same_contents) {
 			data->added = 0;
 			data->deleted = 0;
 		} else {
-			data->added = diff_filespec_size(two);
-			data->deleted = diff_filespec_size(one);
+			data->added = diff_filespec_size(o->repo, two);
+			data->deleted = diff_filespec_size(o->repo, one);
 		}
 	}
 
 	else if (complete_rewrite) {
-		diff_populate_filespec(one, 0);
-		diff_populate_filespec(two, 0);
+		diff_populate_filespec(o->repo, one, 0);
+		diff_populate_filespec(o->repo, two, 0);
 		data->deleted = count_lines(one->data, one->size);
 		data->added = count_lines(two->data, two->size);
 	}
@@ -3594,7 +3600,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 
-		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+		if (fill_mmfile(o->repo, &mf1, one) < 0 ||
+		    fill_mmfile(o->repo, &mf2, two) < 0)
 			die("unable to read files to diff");
 
 		memset(&xpp, 0, sizeof(xpp));
@@ -3632,7 +3639,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.ws_rule = whitespace_rule(attr_path);
 	data.conflict_marker_size = ll_merge_marker_size(attr_path);
 
-	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
+	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
+	    fill_mmfile(o->repo, &mf2, two) < 0)
 		die("unable to read files to diff");
 
 	/*
@@ -3641,7 +3649,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	 * introduced changes, and as long as the "new" side is text, we
 	 * can and should check what it introduces.
 	 */
-	if (diff_filespec_is_binary(two))
+	if (diff_filespec_is_binary(o->repo, two))
 		goto free_and_return;
 	else {
 		/* Crazy xdl interfaces.. */
@@ -3714,7 +3722,10 @@ void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
  */
-static int reuse_worktree_file(const char *name, const struct object_id *oid, int want_file)
+static int reuse_worktree_file(struct index_state *istate,
+			       const char *name,
+			       const struct object_id *oid,
+			       int want_file)
 {
 	const struct cache_entry *ce;
 	struct stat st;
@@ -3733,7 +3744,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * by diff-cache --cached, which does read the cache before
 	 * calling us.
 	 */
-	if (!active_cache)
+	if (!istate->cache)
 		return 0;
 
 	/* We want to avoid the working directory if our caller
@@ -3752,14 +3763,14 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * Similarly, if we'd have to convert the file contents anyway, that
 	 * makes the optimization not worthwhile.
 	 */
-	if (!want_file && would_convert_to_git(&the_index, name))
+	if (!want_file && would_convert_to_git(istate, name))
 		return 0;
 
 	len = strlen(name);
-	pos = cache_name_pos(name, len);
+	pos = index_name_pos(istate, name, len);
 	if (pos < 0)
 		return 0;
-	ce = active_cache[pos];
+	ce = istate->cache[pos];
 
 	/*
 	 * This is not the sha1 we are looking for, or
@@ -3779,7 +3790,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * If ce matches the file in the work tree, we can reuse it.
 	 */
 	if (ce_uptodate(ce) ||
-	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+	    (!lstat(name, &st) && !ie_match_stat(istate, ce, &st, 0)))
 		return 1;
 
 	return 0;
@@ -3812,7 +3823,9 @@ static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
  * grab the data for the blob (or file) for our own in-core comparison.
  * diff_filespec has data and size fields for this purpose.
  */
-int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
+int diff_populate_filespec(struct repository *r,
+			   struct diff_filespec *s,
+			   unsigned int flags)
 {
 	int size_only = flags & CHECK_SIZE_ONLY;
 	int err = 0;
@@ -3839,7 +3852,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		return diff_populate_gitlink(s, size_only);
 
 	if (!s->oid_valid ||
-	    reuse_worktree_file(s->path, &s->oid, 0)) {
+	    reuse_worktree_file(r->index, s->path, &s->oid, 0)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
@@ -3872,7 +3885,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		 * point if the path requires us to run the content
 		 * conversion.
 		 */
-		if (size_only && !would_convert_to_git(&the_index, s->path))
+		if (size_only && !would_convert_to_git(r->index, s->path))
 			return 0;
 
 		/*
@@ -3899,7 +3912,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, conv_flags)) {
+		if (convert_to_git(r->index, s->path, s->data, s->size, &buf, conv_flags)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
@@ -3911,8 +3924,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
-			type = oid_object_info(the_repository, &s->oid,
-					       &s->size);
+			type = oid_object_info(r, &s->oid, &s->size);
 			if (type < 0)
 				die("unable to read %s",
 				    oid_to_hex(&s->oid));
@@ -3950,7 +3962,8 @@ void diff_free_filespec_data(struct diff_filespec *s)
 	FREE_AND_NULL(s->cnt_data);
 }
 
-static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
+static void prep_temp_blob(struct index_state *istate,
+			   const char *path, struct diff_tempfile *temp,
 			   void *blob,
 			   unsigned long size,
 			   const struct object_id *oid,
@@ -3968,7 +3981,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	temp->tempfile = mks_tempfile_ts(tempfile.buf, strlen(base) + 1);
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
-	if (convert_to_working_tree(&the_index, path,
+	if (convert_to_working_tree(istate, path,
 			(const char *)blob, (size_t)size, &buf)) {
 		blob = buf.buf;
 		size = buf.len;
@@ -3984,8 +3997,9 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	free(path_dup);
 }
 
-static struct diff_tempfile *prepare_temp_file(const char *name,
-		struct diff_filespec *one)
+static struct diff_tempfile *prepare_temp_file(struct repository *r,
+					       const char *name,
+					       struct diff_filespec *one)
 {
 	struct diff_tempfile *temp = claim_diff_tempfile();
 
@@ -4002,7 +4016,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->oid_valid ||
-	     reuse_worktree_file(name, &one->oid, 1))) {
+	     reuse_worktree_file(r->index, name, &one->oid, 1))) {
 		struct stat st;
 		if (lstat(name, &st) < 0) {
 			if (errno == ENOENT)
@@ -4013,7 +4027,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			struct strbuf sb = STRBUF_INIT;
 			if (strbuf_readlink(&sb, name, st.st_size) < 0)
 				die_errno("readlink(%s)", name);
-			prep_temp_blob(name, temp, sb.buf, sb.len,
+			prep_temp_blob(r->index, name, temp, sb.buf, sb.len,
 				       (one->oid_valid ?
 					&one->oid : &null_oid),
 				       (one->oid_valid ?
@@ -4038,19 +4052,21 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		return temp;
 	}
 	else {
-		if (diff_populate_filespec(one, 0))
+		if (diff_populate_filespec(r, one, 0))
 			die("cannot read data blob for %s", one->path);
-		prep_temp_blob(name, temp, one->data, one->size,
+		prep_temp_blob(r->index, name, temp,
+			       one->data, one->size,
 			       &one->oid, one->mode);
 	}
 	return temp;
 }
 
-static void add_external_diff_name(struct argv_array *argv,
+static void add_external_diff_name(struct repository *r,
+				   struct argv_array *argv,
 				   const char *name,
 				   struct diff_filespec *df)
 {
-	struct diff_tempfile *temp = prepare_temp_file(name, df);
+	struct diff_tempfile *temp = prepare_temp_file(r, name, df);
 	argv_array_push(argv, temp->name);
 	argv_array_push(argv, temp->hex);
 	argv_array_push(argv, temp->mode);
@@ -4079,11 +4095,11 @@ static void run_external_diff(const char *pgm,
 	argv_array_push(&argv, name);
 
 	if (one && two) {
-		add_external_diff_name(&argv, name, one);
+		add_external_diff_name(o->repo, &argv, name, one);
 		if (!other)
-			add_external_diff_name(&argv, name, two);
+			add_external_diff_name(o->repo, &argv, name, two);
 		else {
-			add_external_diff_name(&argv, other, two);
+			add_external_diff_name(o->repo, &argv, other, two);
 			argv_array_push(&argv, other);
 			argv_array_push(&argv, xfrm_msg);
 		}
@@ -4176,8 +4192,10 @@ static void fill_metainfo(struct strbuf *msg,
 
 		if (o->flags.binary) {
 			mmfile_t mf;
-			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
-			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
+			if ((!fill_mmfile(o->repo, &mf, one) &&
+			     diff_filespec_is_binary(o->repo, one)) ||
+			    (!fill_mmfile(o->repo, &mf, two) &&
+			     diff_filespec_is_binary(o->repo, two)))
 				abbrev = hexsz;
 		}
 		strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set,
@@ -4305,7 +4323,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		 */
 		struct diff_filespec *null = alloc_filespec(two->path);
 		run_diff_cmd(NULL, name, other, attr_path,
-			     one, null, &msg, o, p);
+			     one, null, &msg,
+			     o, p);
 		free(null);
 		strbuf_release(&msg);
 
@@ -4329,7 +4348,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		builtin_diffstat(p->one->path, NULL, NULL, NULL, diffstat, o, p);
+		builtin_diffstat(p->one->path, NULL, NULL, NULL,
+				 diffstat, o, p);
 		return;
 	}
 
@@ -4342,7 +4362,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	diff_fill_oid_info(p->one);
 	diff_fill_oid_info(p->two);
 
-	builtin_diffstat(name, other, p->one, p->two, diffstat, o, p);
+	builtin_diffstat(name, other, p->one, p->two,
+			 diffstat, o, p);
 }
 
 static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
@@ -4374,6 +4395,7 @@ void diff_setup(struct diff_options *options)
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
+	options->repo->index = &the_index;
 
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
@@ -5696,12 +5718,12 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (diff_header_only)
 			continue;
 
-		if (fill_mmfile(&mf1, p->one) < 0 ||
-		    fill_mmfile(&mf2, p->two) < 0)
+		if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
+		    fill_mmfile(options->repo, &mf2, p->two) < 0)
 			return error("unable to read files to diff");
 
-		if (diff_filespec_is_binary(p->one) ||
-		    diff_filespec_is_binary(p->two)) {
+		if (diff_filespec_is_binary(options->repo, p->one) ||
+		    diff_filespec_is_binary(options->repo, p->two)) {
 			git_SHA1_Update(&ctx, oid_to_hex(&p->one->oid),
 					GIT_SHA1_HEXSZ);
 			git_SHA1_Update(&ctx, oid_to_hex(&p->two->oid),
@@ -6004,19 +6026,21 @@ static void diffcore_apply_filter(struct diff_options *options)
 }
 
 /* Check whether two filespecs with the same mode and size are identical */
-static int diff_filespec_is_identical(struct diff_filespec *one,
+static int diff_filespec_is_identical(struct repository *r,
+				      struct diff_filespec *one,
 				      struct diff_filespec *two)
 {
 	if (S_ISGITLINK(one->mode))
 		return 0;
-	if (diff_populate_filespec(one, 0))
+	if (diff_populate_filespec(r, one, 0))
 		return 0;
-	if (diff_populate_filespec(two, 0))
+	if (diff_populate_filespec(r, two, 0))
 		return 0;
 	return !memcmp(one->data, two->data, one->size);
 }
 
-static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
+static int diff_filespec_check_stat_unmatch(struct repository *r,
+					    struct diff_filepair *p)
 {
 	if (p->done_skip_stat_unmatch)
 		return p->skip_stat_unmatch_result;
@@ -6040,10 +6064,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	    !DIFF_FILE_VALID(p->two) ||
 	    (p->one->oid_valid && p->two->oid_valid) ||
 	    (p->one->mode != p->two->mode) ||
-	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
-	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
+	    diff_populate_filespec(r, p->one, CHECK_SIZE_ONLY) ||
+	    diff_populate_filespec(r, p->two, CHECK_SIZE_ONLY) ||
 	    (p->one->size != p->two->size) ||
-	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
+	    !diff_filespec_is_identical(r, p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result = 1;
 	return p->skip_stat_unmatch_result;
 }
@@ -6058,7 +6082,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
-		if (diff_filespec_check_stat_unmatch(p))
+		if (diff_filespec_check_stat_unmatch(diffopt->repo, p))
 			diff_q(&outq, p);
 		else {
 			/*
@@ -6100,7 +6124,8 @@ void diffcore_std(struct diff_options *options)
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
 		if (options->break_opt != -1)
-			diffcore_break(options->break_opt);
+			diffcore_break(options->repo,
+				       options->break_opt);
 		if (options->detect_rename)
 			diffcore_rename(options);
 		if (options->break_opt != -1)
@@ -6251,7 +6276,7 @@ void diff_change(struct diff_options *options,
 		return;
 
 	if (options->flags.quick && options->skip_stat_unmatch &&
-	    !diff_filespec_check_stat_unmatch(p))
+	    !diff_filespec_check_stat_unmatch(options->repo, p))
 		return;
 
 	options->flags.has_changes = 1;
@@ -6273,8 +6298,10 @@ struct diff_filepair *diff_unmerge(struct diff_options *options, const char *pat
 	return pair;
 }
 
-static char *run_textconv(const char *pgm, struct diff_filespec *spec,
-		size_t *outsize)
+static char *run_textconv(struct repository *r,
+			  const char *pgm,
+			  struct diff_filespec *spec,
+			  size_t *outsize)
 {
 	struct diff_tempfile *temp;
 	const char *argv[3];
@@ -6283,7 +6310,7 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	struct strbuf buf = STRBUF_INIT;
 	int err = 0;
 
-	temp = prepare_temp_file(spec->path, spec);
+	temp = prepare_temp_file(r, spec->path, spec);
 	*arg++ = pgm;
 	*arg++ = temp->name;
 	*arg = NULL;
@@ -6314,6 +6341,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 		     struct diff_filespec *df,
 		     char **outbuf)
 {
+	struct repository *r = the_repository;
 	size_t size;
 
 	if (!driver) {
@@ -6321,7 +6349,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 			*outbuf = "";
 			return 0;
 		}
-		if (diff_populate_filespec(df, 0))
+		if (diff_populate_filespec(r, df, 0))
 			die("unable to read files to diff");
 		*outbuf = df->data;
 		return df->size;
@@ -6338,7 +6366,7 @@ size_t fill_textconv(struct userdiff_driver *driver,
 			return size;
 	}
 
-	*outbuf = run_textconv(driver->textconv, df, &size);
+	*outbuf = run_textconv(r, driver->textconv, df, &size);
 	if (!*outbuf)
 		die("unable to read files to diff");
 
diff --git a/diff.h b/diff.h
index 89544e64bc..0b67932109 100644
--- a/diff.h
+++ b/diff.h
@@ -18,6 +18,7 @@ struct userdiff_driver;
 struct oid_array;
 struct commit;
 struct combine_diff_path;
+struct repository;
 
 typedef int (*pathchange_fn_t)(struct diff_options *options,
 		 struct combine_diff_path *path);
@@ -220,6 +221,8 @@ struct diff_options {
 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
 	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
 	int color_moved_ws_handling;
+
+	struct repository *repo;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
diff --git a/diffcore-break.c b/diffcore-break.c
index c64359f489..b580d92154 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -5,7 +5,8 @@
 #include "diff.h"
 #include "diffcore.h"
 
-static int should_break(struct diff_filespec *src,
+static int should_break(struct repository *r,
+			struct diff_filespec *src,
 			struct diff_filespec *dst,
 			int break_score,
 			int *merge_score_p)
@@ -61,7 +62,8 @@ static int should_break(struct diff_filespec *src,
 	    !oidcmp(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
+	if (diff_populate_filespec(r, src, 0) ||
+	    diff_populate_filespec(r, dst, 0))
 		return 0; /* error but caught downstream */
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
@@ -71,7 +73,7 @@ static int should_break(struct diff_filespec *src,
 	if (!src->size)
 		return 0; /* we do not let empty files get renamed */
 
-	if (diffcore_count_changes(src, dst,
+	if (diffcore_count_changes(r, src, dst,
 				   &src->cnt_data, &dst->cnt_data,
 				   &src_copied, &literal_added))
 		return 0;
@@ -114,7 +116,7 @@ static int should_break(struct diff_filespec *src,
 	return 1;
 }
 
-void diffcore_break(int break_score)
+void diffcore_break(struct repository *r, int break_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
@@ -178,7 +180,7 @@ void diffcore_break(int break_score)
 		    object_type(p->one->mode) == OBJ_BLOB &&
 		    object_type(p->two->mode) == OBJ_BLOB &&
 		    !strcmp(p->one->path, p->two->path)) {
-			if (should_break(p->one, p->two,
+			if (should_break(r, p->one, p->two,
 					 break_score, &score)) {
 				/* Split this into delete and create */
 				struct diff_filespec *null_one, *null_two;
diff --git a/diffcore-delta.c b/diffcore-delta.c
index c83d45a047..5668ace60d 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -121,14 +121,15 @@ static int spanhash_cmp(const void *a_, const void *b_)
 		a->hashval > b->hashval ? 1 : 0;
 }
 
-static struct spanhash_top *hash_chars(struct diff_filespec *one)
+static struct spanhash_top *hash_chars(struct repository *r,
+				       struct diff_filespec *one)
 {
 	int i, n;
 	unsigned int accum1, accum2, hashval;
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
 	unsigned int sz = one->size;
-	int is_text = !diff_filespec_is_binary(one);
+	int is_text = !diff_filespec_is_binary(r, one);
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(st_add(sizeof(*hash),
@@ -162,7 +163,8 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 	return hash;
 }
 
-int diffcore_count_changes(struct diff_filespec *src,
+int diffcore_count_changes(struct repository *r,
+			   struct diff_filespec *src,
 			   struct diff_filespec *dst,
 			   void **src_count_p,
 			   void **dst_count_p,
@@ -177,14 +179,14 @@ int diffcore_count_changes(struct diff_filespec *src,
 	if (src_count_p)
 		src_count = *src_count_p;
 	if (!src_count) {
-		src_count = hash_chars(src);
+		src_count = hash_chars(r, src);
 		if (src_count_p)
 			*src_count_p = src_count;
 	}
 	if (dst_count_p)
 		dst_count = *dst_count_p;
 	if (!dst_count) {
-		dst_count = hash_chars(dst);
+		dst_count = hash_chars(r, dst);
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d775183c2f..f85758b233 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -128,7 +128,8 @@ struct diff_score {
 	short name_score;
 };
 
-static int estimate_similarity(struct diff_filespec *src,
+static int estimate_similarity(struct repository *r,
+			       struct diff_filespec *src,
 			       struct diff_filespec *dst,
 			       int minimum_score)
 {
@@ -165,10 +166,10 @@ static int estimate_similarity(struct diff_filespec *src,
 	 * say whether the size is valid or not!)
 	 */
 	if (!src->cnt_data &&
-	    diff_populate_filespec(src, CHECK_SIZE_ONLY))
+	    diff_populate_filespec(r, src, CHECK_SIZE_ONLY))
 		return 0;
 	if (!dst->cnt_data &&
-	    diff_populate_filespec(dst, CHECK_SIZE_ONLY))
+	    diff_populate_filespec(r, dst, CHECK_SIZE_ONLY))
 		return 0;
 
 	max_size = ((src->size > dst->size) ? src->size : dst->size);
@@ -186,12 +187,12 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
-	if (!src->cnt_data && diff_populate_filespec(src, 0))
+	if (!src->cnt_data && diff_populate_filespec(r, src, 0))
 		return 0;
-	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
+	if (!dst->cnt_data && diff_populate_filespec(r, dst, 0))
 		return 0;
 
-	if (diffcore_count_changes(src, dst,
+	if (diffcore_count_changes(r, src, dst,
 				   &src->cnt_data, &dst->cnt_data,
 				   &src_copied, &literal_added))
 		return 0;
@@ -256,10 +257,11 @@ struct file_similarity {
 	struct diff_filespec *filespec;
 };
 
-static unsigned int hash_filespec(struct diff_filespec *filespec)
+static unsigned int hash_filespec(struct repository *r,
+				  struct diff_filespec *filespec)
 {
 	if (!filespec->oid_valid) {
-		if (diff_populate_filespec(filespec, 0))
+		if (diff_populate_filespec(r, filespec, 0))
 			return 0;
 		hash_object_file(filespec->data, filespec->size, "blob",
 				 &filespec->oid);
@@ -280,7 +282,9 @@ static int find_identical_files(struct hashmap *srcs,
 	/*
 	 * Find the best source match for specified destination.
 	 */
-	p = hashmap_get_from_hash(srcs, hash_filespec(target), NULL);
+	p = hashmap_get_from_hash(srcs,
+				  hash_filespec(options->repo, target),
+				  NULL);
 	for (; p; p = hashmap_get_next(srcs, p)) {
 		int score;
 		struct diff_filespec *source = p->filespec;
@@ -316,14 +320,16 @@ static int find_identical_files(struct hashmap *srcs,
 	return renames;
 }
 
-static void insert_file_table(struct hashmap *table, int index, struct diff_filespec *filespec)
+static void insert_file_table(struct repository *r,
+			      struct hashmap *table, int index,
+			      struct diff_filespec *filespec)
 {
 	struct file_similarity *entry = xmalloc(sizeof(*entry));
 
 	entry->index = index;
 	entry->filespec = filespec;
 
-	hashmap_entry_init(entry, hash_filespec(filespec));
+	hashmap_entry_init(entry, hash_filespec(r, filespec));
 	hashmap_add(table, entry);
 }
 
@@ -344,7 +350,9 @@ static int find_exact_renames(struct diff_options *options)
 	 */
 	hashmap_init(&file_table, NULL, NULL, rename_src_nr);
 	for (i = rename_src_nr-1; i >= 0; i--)
-		insert_file_table(&file_table, i, rename_src[i].p->one);
+		insert_file_table(options->repo,
+				  &file_table, i,
+				  rename_src[i].p->one);
 
 	/* Walk the destinations and find best source match */
 	for (i = 0; i < rename_dst_nr; i++)
@@ -557,7 +565,8 @@ void diffcore_rename(struct diff_options *options)
 			    diff_unmodified_pair(rename_src[j].p))
 				continue;
 
-			this_src.score = estimate_similarity(one, two,
+			this_src.score = estimate_similarity(options->repo,
+							     one, two,
 							     minimum_score);
 			this_src.name_score = basename_same(one, two);
 			this_src.dst = i;
diff --git a/diffcore.h b/diffcore.h
index 8d81a45f51..b651061c0e 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -7,6 +7,8 @@
 #include "cache.h"
 
 struct diff_options;
+struct repository;
+struct userdiff_driver;
 
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
@@ -26,8 +28,6 @@ struct diff_options;
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
 
-struct userdiff_driver;
-
 struct diff_filespec {
 	struct object_id oid;
 	char *path;
@@ -61,10 +61,10 @@ void fill_filespec(struct diff_filespec *, const struct object_id *,
 
 #define CHECK_SIZE_ONLY 1
 #define CHECK_BINARY    2
-int diff_populate_filespec(struct diff_filespec *, unsigned int);
+int diff_populate_filespec(struct repository *, struct diff_filespec *, unsigned int);
 void diff_free_filespec_data(struct diff_filespec *);
 void diff_free_filespec_blob(struct diff_filespec *);
-int diff_filespec_is_binary(struct diff_filespec *);
+int diff_filespec_is_binary(struct repository *, struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
@@ -111,7 +111,7 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-void diffcore_break(int);
+void diffcore_break(struct repository *, int);
 void diffcore_rename(struct diff_options *);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
@@ -142,7 +142,8 @@ void diff_debug_queue(const char *, struct diff_queue_struct *);
 #define diff_debug_queue(a,b) do { /* nothing */ } while (0)
 #endif
 
-int diffcore_count_changes(struct diff_filespec *src,
+int diffcore_count_changes(struct repository *r,
+			   struct diff_filespec *src,
 			   struct diff_filespec *dst,
 			   void **src_count_p,
 			   void **dst_count_p,
diff --git a/line-log.c b/line-log.c
index 72a5fed661..35adf199a5 100644
--- a/line-log.c
+++ b/line-log.c
@@ -508,7 +508,9 @@ static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
 	return;
 }
 
-static void fill_line_ends(struct diff_filespec *spec, long *lines,
+static void fill_line_ends(struct repository *r,
+			   struct diff_filespec *spec,
+			   long *lines,
 			   unsigned long **line_ends)
 {
 	int num = 0, size = 50;
@@ -516,7 +518,7 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	unsigned long *ends = NULL;
 	char *data = NULL;
 
-	if (diff_populate_filespec(spec, 0))
+	if (diff_populate_filespec(r, spec, 0))
 		die("Cannot read blob %s", oid_to_hex(&spec->oid));
 
 	ALLOC_ARRAY(ends, size);
@@ -555,7 +557,8 @@ static const char *nth_line(void *data, long line)
 }
 
 static struct line_log_data *
-parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
+parse_lines(struct repository *r, struct commit *commit,
+	    const char *prefix, struct string_list *args)
 {
 	long lines = 0;
 	unsigned long *ends = NULL;
@@ -583,7 +586,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 
 		spec = alloc_filespec(full_name);
 		fill_blob_sha1(commit, spec);
-		fill_line_ends(spec, &lines, &ends);
+		fill_line_ends(r, spec, &lines, &ends);
 		cb_data.spec = spec;
 		cb_data.lines = lines;
 		cb_data.line_ends = ends;
@@ -739,7 +742,7 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
 	struct line_log_data *range;
 
 	commit = check_single_commit(rev);
-	range = parse_lines(commit, prefix, args);
+	range = parse_lines(rev->diffopt.repo, commit, prefix, args);
 	add_line_range(rev, commit, range);
 
 	if (!rev->diffopt.detect_rename) {
@@ -891,8 +894,8 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		return;
 
 	if (pair->one->oid_valid)
-		fill_line_ends(pair->one, &p_lines, &p_ends);
-	fill_line_ends(pair->two, &t_lines, &t_ends);
+		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
+	fill_line_ends(rev->diffopt.repo, pair->two, &t_lines, &t_ends);
 
 	fprintf(opt->file, "%s%sdiff --git a/%s b/%s%s\n", prefix, c_meta, pair->one->path, pair->two->path, c_reset);
 	fprintf(opt->file, "%s%s--- %s%s%s\n", prefix, c_meta,
@@ -1008,12 +1011,12 @@ static int process_diff_filepair(struct rev_info *rev,
 		return 0;
 
 	assert(pair->two->oid_valid);
-	diff_populate_filespec(pair->two, 0);
+	diff_populate_filespec(rev->diffopt.repo, pair->two, 0);
 	file_target.ptr = pair->two->data;
 	file_target.size = pair->two->size;
 
 	if (pair->one->oid_valid) {
-		diff_populate_filespec(pair->one, 0);
+		diff_populate_filespec(rev->diffopt.repo, pair->one, 0);
 		file_parent.ptr = pair->one->data;
 		file_parent.size = pair->one->size;
 	} else {
-- 
2.19.0.640.gcd3aa10a8a

