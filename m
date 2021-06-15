Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9F1C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6806961468
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFONbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhFONbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:31:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800BEC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso2029058wmj.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LOl2wWtuFq4OR7A88dXTcqW76V2R/56GLDIcxrEYb+U=;
        b=KyHjTFh4n8Z3mWelmDGMolWUr/qSTA1haAMypYPVFErmhb2aK7eRs1VL1jF7fx+Ntk
         gD3uvxOPAvDKaHVtiYpEn98kumo0GbGTelfiNCj9o772ekkH5wA0RU1lVmtrxTVlRPsH
         xpEEO/GGk3e+4yRpGtzjYAT1fa39Zk443CPcr89MWuw2V4IgS0b3v0ptLz13xwPf0iLg
         mamrC3X1TZbzz15+00mDhYQqC7t0IWbAAlGEFECnHZr7a+tvyAMrBNbjXKW5djANUn4C
         WV8P0o4PRXrpAC0TcWZHc1Q50fnVjUUQlBOiLCmis2ed+cQg4Q4nOziyc6gjIi7GVuPc
         Wadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LOl2wWtuFq4OR7A88dXTcqW76V2R/56GLDIcxrEYb+U=;
        b=dKMDVyXagFe4PQutfKMvXg0ADO9IVuRL+pgW4LjiQa3kx6l2blSPPt2wFroFMp5sxU
         /QY5VSbEGdQKZlnvhkhdVp94vtuF+hw8gN7as22AyF0IEjKBcekT7Ww+/vCdKRPHKJs5
         JWMvgedUNscB9Z5he+K59v6xzN5/hkJ0ThPxVtTuYaLED6DxN92TmujqlYESKy/fgRwm
         0HOwLTJQydxni0PGiHM+KcHQ2Oyta4n2B/QtY770uD4MosvFAIQEZZ3KeU6k0LwyP+3W
         UglGTwiGsEaZlbr6ezBDsyPObS3RikSihl02fuCM42X4gqt1jEadEHEaxerKUbHI/3UM
         i0HA==
X-Gm-Message-State: AOAM532tQDkQiBLtfA7VBAqqZ/i0NRclvNhzSLf9sAIxFSiJVzJoTDrg
        xADk2Hasu52KLu/t7bCR1fLaLmaDBaY=
X-Google-Smtp-Source: ABdhPJyAYTwLOS8L8qBzk4kypuNzMte0DWmZOu8rCYcVGT4J5T6sieZWF4GaMEwgHkNTt3YHuyghrA==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr22813770wmk.69.1623763753009;
        Tue, 15 Jun 2021 06:29:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm15527413wmj.15.2021.06.15.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:29:12 -0700 (PDT)
Message-Id: <765337a46ab0f6c8ad38007a78c850f5dd4cfa38.1623763747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 13:29:03 +0000
Subject: [PATCH v2 7/9] [GSOC] cat-file: reuse ref-filter logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In order to let cat-file use ref-filter logic, the following
methods are used:

1. Add `cat_file_mode` member in struct `ref_format`, this can
help us reject atoms in verify_ref_format() which cat-file
cannot use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...
2. Change the type of member `format` in struct `batch_options`
to `ref_format`, We can add format data in it.
3. Let `batch_objects()` add atoms to format, and use
`verify_ref_format()` to check atoms.
4. Use `has_object_file()` in `batch_one_object()` to check
whether the input object exists.
5. Use `format_ref_array_item()` in `batch_object_write()` to
get the formatted data corresponding to the object. If the
return value of `format_ref_array_item()` is equals to zero,
use `batch_write()` to print object data; else if the return
value less than zero, use `die()` to print the error message
and exit; else return value greater than zero, only print the
error message, but not exit.
6. Let get_object() return 1 and print "<oid> missing" instead
of returning -1 and printing "missing object <oid> for <refname>",
this can help `format_ref_array_item()` just report that the
object is missing without letting Git exit.

Most of the atoms in `for-each-ref --format` are now supported,
such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
`%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
`%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
`%(flag)`, `%(HEAD)`, because our objects don't have refname.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-cat-file.txt |   6 +
 builtin/cat-file.c             | 248 +++++++-------------------------
 ref-filter.c                   |  15 +-
 ref-filter.h                   |   3 +-
 t/t1006-cat-file.sh            | 252 +++++++++++++++++++++++++++++++++
 t/t6301-for-each-ref-errors.sh |   2 +-
 6 files changed, 323 insertions(+), 203 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 4eb0421b3fd9..ef8ab952b2fa 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -226,6 +226,12 @@ newline. The available atoms are:
 	after that first run of whitespace (i.e., the "rest" of the
 	line) are output in place of the `%(rest)` atom.
 
+Note that most of the atoms in `for-each-ref --format` are now supported,
+such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
+`%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
+`%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
+`%(flag)`, `%(HEAD)`. See linkgit:git-for-each-ref[1].
+
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e83..026d9405636a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "ref-filter.h"
 
 struct batch_options {
 	int enabled;
@@ -25,7 +26,7 @@ struct batch_options {
 	int all_objects;
 	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
-	const char *format;
+	struct ref_format format;
 };
 
 static const char *force_path;
@@ -195,99 +196,10 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 struct expand_data {
 	struct object_id oid;
-	enum object_type type;
-	unsigned long size;
-	off_t disk_size;
 	const char *rest;
-	struct object_id delta_base_oid;
-
-	/*
-	 * If mark_query is true, we do not expand anything, but rather
-	 * just mark the object_info with items we wish to query.
-	 */
-	int mark_query;
-
-	/*
-	 * Whether to split the input on whitespace before feeding it to
-	 * get_sha1; this is decided during the mark_query phase based on
-	 * whether we have a %(rest) token in our format.
-	 */
 	int split_on_whitespace;
-
-	/*
-	 * After a mark_query run, this object_info is set up to be
-	 * passed to oid_object_info_extended. It will point to the data
-	 * elements above, so you can retrieve the response from there.
-	 */
-	struct object_info info;
-
-	/*
-	 * This flag will be true if the requested batch format and options
-	 * don't require us to call oid_object_info, which can then be
-	 * optimized out.
-	 */
-	unsigned skip_object_info : 1;
 };
 
-static int is_atom(const char *atom, const char *s, int slen)
-{
-	int alen = strlen(atom);
-	return alen == slen && !memcmp(atom, s, alen);
-}
-
-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			void *vdata)
-{
-	struct expand_data *data = vdata;
-
-	if (is_atom("objectname", atom, len)) {
-		if (!data->mark_query)
-			strbuf_addstr(sb, oid_to_hex(&data->oid));
-	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
-			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
-	} else if (is_atom("objectsize", atom, len)) {
-		if (data->mark_query)
-			data->info.sizep = &data->size;
-		else
-			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
-	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (data->mark_query)
-			data->info.disk_sizep = &data->disk_size;
-		else
-			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
-	} else if (is_atom("rest", atom, len)) {
-		if (data->mark_query)
-			data->split_on_whitespace = 1;
-		else if (data->rest)
-			strbuf_addstr(sb, data->rest);
-	} else if (is_atom("deltabase", atom, len)) {
-		if (data->mark_query)
-			data->info.delta_base_oid = &data->delta_base_oid;
-		else
-			strbuf_addstr(sb,
-				      oid_to_hex(&data->delta_base_oid));
-	} else
-		die("unknown format element: %.*s", len, atom);
-}
-
-static size_t expand_format(struct strbuf *sb, const char *start, void *data)
-{
-	const char *end;
-
-	if (*start != '(')
-		return 0;
-	end = strchr(start + 1, ')');
-	if (!end)
-		die("format element '%s' does not end in ')'", start);
-
-	expand_atom(sb, start + 1, end - start - 1, data);
-
-	return end - start + 1;
-}
-
 static void batch_write(struct batch_options *opt, const void *data, int len)
 {
 	if (opt->buffer_output) {
@@ -297,87 +209,31 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 		write_or_die(1, data, len);
 }
 
-static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
-{
-	const struct object_id *oid = &data->oid;
-
-	assert(data->info.typep);
-
-	if (data->type == OBJ_BLOB) {
-		if (opt->buffer_output)
-			fflush(stdout);
-		if (opt->cmdmode) {
-			char *contents;
-			unsigned long size;
-
-			if (!data->rest)
-				die("missing path for '%s'", oid_to_hex(oid));
-
-			if (opt->cmdmode == 'w') {
-				if (filter_object(data->rest, 0100644, oid,
-						  &contents, &size))
-					die("could not convert '%s' %s",
-					    oid_to_hex(oid), data->rest);
-			} else if (opt->cmdmode == 'c') {
-				enum object_type type;
-				if (!textconv_object(the_repository,
-						     data->rest, 0100644, oid,
-						     1, &contents, &size))
-					contents = read_object_file(oid,
-								    &type,
-								    &size);
-				if (!contents)
-					die("could not convert '%s' %s",
-					    oid_to_hex(oid), data->rest);
-			} else
-				BUG("invalid cmdmode: %c", opt->cmdmode);
-			batch_write(opt, contents, size);
-			free(contents);
-		} else {
-			stream_blob(oid);
-		}
-	}
-	else {
-		enum object_type type;
-		unsigned long size;
-		void *contents;
-
-		contents = read_object_file(oid, &type, &size);
-		if (!contents)
-			die("object %s disappeared", oid_to_hex(oid));
-		if (type != data->type)
-			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
-			die("object %s changed size!?", oid_to_hex(oid));
-
-		batch_write(opt, contents, size);
-		free(contents);
-	}
-}
 
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
-	if (!data->skip_object_info &&
-	    oid_object_info_extended(the_repository, &data->oid, &data->info,
-				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		printf("%s missing\n",
-		       obj_name ? obj_name : oid_to_hex(&data->oid));
-		fflush(stdout);
-		return;
-	}
+	int ret = 0;
+	struct strbuf err = STRBUF_INIT;
+	struct ref_array_item item = { data->oid, data->rest };
 
 	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format, expand_format, data);
-	strbuf_addch(scratch, '\n');
-	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
-		print_object_or_die(opt, data);
-		batch_write(opt, "\n", 1);
+	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
+	if (!ret) {
+		strbuf_addch(scratch, '\n');
+		batch_write(opt, scratch->buf, scratch->len);
+	} else if (ret < 0) {
+		die("%s\n", err.buf);
+	} else {
+		/* when ret > 0 , don't call die and print the err to stdout*/
+		printf("%s\n", err.buf);
+		fflush(stdout);
 	}
+	free_array_item_internal(&item);
+	strbuf_release(&err);
 }
 
 static void batch_one_object(const char *obj_name,
@@ -428,6 +284,13 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	if (!has_object_file(&data->oid)) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
+		fflush(stdout);
+		return;
+	}
+
 	batch_object_write(obj_name, scratch, opt, data);
 }
 
@@ -488,42 +351,34 @@ static int batch_unordered_packed(const struct object_id *oid,
 	return batch_unordered_object(oid, data);
 }
 
-static int batch_objects(struct batch_options *opt)
+static const char * const cat_file_usage[] = {
+	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
+	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
+	NULL
+};
+
+static int batch_objects(struct batch_options *opt, const struct option *options)
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
+	struct strbuf format = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
 
-	if (!opt->format)
-		opt->format = "%(objectname) %(objecttype) %(objectsize)";
-
-	/*
-	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to oid_object_info_extended for each
-	 * object.
-	 */
 	memset(&data, 0, sizeof(data));
-	data.mark_query = 1;
-	strbuf_expand(&output, opt->format, expand_format, &data);
-	data.mark_query = 0;
-	strbuf_release(&output);
-	if (opt->cmdmode)
-		data.split_on_whitespace = 1;
-
-	if (opt->all_objects) {
-		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			data.skip_object_info = 1;
-	}
-
-	/*
-	 * If we are printing out the object, then always fill in the type,
-	 * since we will want to decide whether or not to stream.
-	 */
+	if (!opt->format.format)
+		strbuf_addstr(&format, "%(objectname) %(objecttype) %(objectsize)");
+	else
+		strbuf_addstr(&format, opt->format.format);
 	if (opt->print_contents)
-		data.info.typep = &data.type;
+		strbuf_addstr(&format, "\n%(raw)");
+	opt->format.format = format.buf;
+	if (verify_ref_format(&opt->format))
+		usage_with_options(cat_file_usage, options);
+
+	if (opt->cmdmode || opt->format.use_rest)
+		data.split_on_whitespace = 1;
 
 	if (opt->all_objects) {
 		struct object_cb_data cb;
@@ -556,6 +411,7 @@ static int batch_objects(struct batch_options *opt)
 			oid_array_clear(&sa);
 		}
 
+		strbuf_release(&format);
 		strbuf_release(&output);
 		return 0;
 	}
@@ -588,18 +444,13 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+	strbuf_release(&format);
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
-static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
-	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
-	NULL
-};
-
 static int git_cat_file_config(const char *var, const char *value, void *cb)
 {
 	if (userdiff_config(var, value) < 0)
@@ -622,7 +473,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
-	bo->format = arg;
+	bo->format.format = arg;
 
 	return 0;
 }
@@ -631,7 +482,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 {
 	int opt = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
-	struct batch_options batch = {0};
+	struct batch_options batch = {
+		.format = REF_FORMAT_INIT
+	};
 	int unknown_type = 0;
 
 	const struct option options[] = {
@@ -670,6 +523,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_cat_file_config, NULL);
 
 	batch.buffer_output = -1;
+	batch.format.cat_file_mode = 1;
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
@@ -713,7 +567,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		batch.buffer_output = batch.all_objects;
 
 	if (batch.enabled)
-		return batch_objects(&batch);
+		return batch_objects(&batch, options);
 
 	if (unknown_type && opt != 't' && opt != 's')
 		die("git cat-file --allow-unknown-type: use with -s or -t");
diff --git a/ref-filter.c b/ref-filter.c
index aa2ce634106b..660e52f97f79 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1017,8 +1017,15 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
-		if (used_atom[at].atom_type == ATOM_REST)
-			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
+		if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
+		    (format->cat_file_mode && (used_atom[at].atom_type == ATOM_FLAG ||
+					       used_atom[at].atom_type == ATOM_HEAD ||
+					       used_atom[at].atom_type == ATOM_PUSH ||
+					       used_atom[at].atom_type == ATOM_REFNAME ||
+					       used_atom[at].atom_type == ATOM_SYMREF ||
+					       used_atom[at].atom_type == ATOM_UPSTREAM ||
+					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
 
 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
 		    used_atom[at].u.raw_data.option == RAW_BARE)
@@ -1735,8 +1742,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	}
 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
-		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-				       oid_to_hex(&oi->oid), ref->refname);
+		return strbuf_addf_ret(err, 1, _("%s missing"),
+				       oid_to_hex(&oi->oid));
 	if (oi->info.disk_sizep && oi->disk_size < 0)
 		BUG("Object size is less than zero.");
 
diff --git a/ref-filter.h b/ref-filter.h
index d4531fef5f91..3db07729f46d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -78,6 +78,7 @@ struct ref_format {
 	 */
 	const char *format;
 	const char *rest;
+	int cat_file_mode;
 	int quote_style;
 	int use_rest;
 	int use_color;
@@ -86,7 +87,7 @@ struct ref_format {
 	int need_color_reset_at_eol;
 };
 
-#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74ad..5efa7397cfbc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -586,4 +586,256 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+. "$TEST_DIRECTORY"/lib-gpg.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
+
+test_expect_success 'cat-file --batch|--batch-check setup' '
+	echo 1>blob1 &&
+	printf "a\0b\0\c" >blob2 &&
+	git add blob1 blob2 &&
+	git commit -m "Commit Message" &&
+	git branch -M main &&
+	git tag -a -m "v0.0.0" testtag &&
+	git update-ref refs/myblobs/blob1 HEAD:blob1 &&
+	git update-ref refs/myblobs/blob2 HEAD:blob2 &&
+	git update-ref refs/mytrees/tree1 HEAD^{tree}
+'
+
+batch_test_atom() {
+	if test "$3" = "fail"
+	then
+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 mast failed" "
+			test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
+			$1
+			EOF
+		"
+	else
+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
+			git for-each-ref --format='$2' $1 >expected &&
+			git cat-file --batch-check='$2' >actual <<-EOF &&
+			$1
+			EOF
+			sanitize_pgp <actual >actual.clean &&
+			cmp expected actual.clean
+		"
+	fi
+}
+
+batch_test_atom refs/heads/main '%(refname)' fail
+batch_test_atom refs/heads/main '%(refname:)' fail
+batch_test_atom refs/heads/main '%(refname:short)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=1)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=2)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:lstrip=-2)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=1)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=2)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:rstrip=-2)' fail
+batch_test_atom refs/heads/main '%(refname:strip=1)' fail
+batch_test_atom refs/heads/main '%(refname:strip=2)' fail
+batch_test_atom refs/heads/main '%(refname:strip=-1)' fail
+batch_test_atom refs/heads/main '%(refname:strip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream)' fail
+batch_test_atom refs/heads/main '%(upstream:short)' fail
+batch_test_atom refs/heads/main '%(upstream:lstrip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:lstrip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream:rstrip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:rstrip=-2)' fail
+batch_test_atom refs/heads/main '%(upstream:strip=2)' fail
+batch_test_atom refs/heads/main '%(upstream:strip=-2)' fail
+batch_test_atom refs/heads/main '%(push)' fail
+batch_test_atom refs/heads/main '%(push:short)' fail
+batch_test_atom refs/heads/main '%(push:lstrip=1)' fail
+batch_test_atom refs/heads/main '%(push:lstrip=-1)' fail
+batch_test_atom refs/heads/main '%(push:rstrip=1)' fail
+batch_test_atom refs/heads/main '%(push:rstrip=-1)' fail
+batch_test_atom refs/heads/main '%(push:strip=1)' fail
+batch_test_atom refs/heads/main '%(push:strip=-1)' fail
+batch_test_atom refs/heads/main '%(objecttype)'
+batch_test_atom refs/heads/main '%(objectsize)'
+batch_test_atom refs/heads/main '%(objectsize:disk)'
+batch_test_atom refs/heads/main '%(deltabase)'
+batch_test_atom refs/heads/main '%(objectname)'
+batch_test_atom refs/heads/main '%(objectname:short)'
+batch_test_atom refs/heads/main '%(objectname:short=1)'
+batch_test_atom refs/heads/main '%(objectname:short=10)'
+batch_test_atom refs/heads/main '%(tree)'
+batch_test_atom refs/heads/main '%(tree:short)'
+batch_test_atom refs/heads/main '%(tree:short=1)'
+batch_test_atom refs/heads/main '%(tree:short=10)'
+batch_test_atom refs/heads/main '%(parent)'
+batch_test_atom refs/heads/main '%(parent:short)'
+batch_test_atom refs/heads/main '%(parent:short=1)'
+batch_test_atom refs/heads/main '%(parent:short=10)'
+batch_test_atom refs/heads/main '%(numparent)'
+batch_test_atom refs/heads/main '%(object)'
+batch_test_atom refs/heads/main '%(type)'
+batch_test_atom refs/heads/main '%(raw)'
+batch_test_atom refs/heads/main '%(*objectname)'
+batch_test_atom refs/heads/main '%(*objecttype)'
+batch_test_atom refs/heads/main '%(author)'
+batch_test_atom refs/heads/main '%(authorname)'
+batch_test_atom refs/heads/main '%(authoremail)'
+batch_test_atom refs/heads/main '%(authoremail:trim)'
+batch_test_atom refs/heads/main '%(authoremail:localpart)'
+batch_test_atom refs/heads/main '%(authordate)'
+batch_test_atom refs/heads/main '%(committer)'
+batch_test_atom refs/heads/main '%(committername)'
+batch_test_atom refs/heads/main '%(committeremail)'
+batch_test_atom refs/heads/main '%(committeremail:trim)'
+batch_test_atom refs/heads/main '%(committeremail:localpart)'
+batch_test_atom refs/heads/main '%(committerdate)'
+batch_test_atom refs/heads/main '%(tag)'
+batch_test_atom refs/heads/main '%(tagger)'
+batch_test_atom refs/heads/main '%(taggername)'
+batch_test_atom refs/heads/main '%(taggeremail)'
+batch_test_atom refs/heads/main '%(taggeremail:trim)'
+batch_test_atom refs/heads/main '%(taggeremail:localpart)'
+batch_test_atom refs/heads/main '%(taggerdate)'
+batch_test_atom refs/heads/main '%(creator)'
+batch_test_atom refs/heads/main '%(creatordate)'
+batch_test_atom refs/heads/main '%(subject)'
+batch_test_atom refs/heads/main '%(subject:sanitize)'
+batch_test_atom refs/heads/main '%(contents:subject)'
+batch_test_atom refs/heads/main '%(body)'
+batch_test_atom refs/heads/main '%(contents:body)'
+batch_test_atom refs/heads/main '%(contents:signature)'
+batch_test_atom refs/heads/main '%(contents)'
+batch_test_atom refs/heads/main '%(HEAD)' fail
+batch_test_atom refs/heads/main '%(upstream:track)' fail
+batch_test_atom refs/heads/main '%(upstream:trackshort)' fail
+batch_test_atom refs/heads/main '%(upstream:track,nobracket)' fail
+batch_test_atom refs/heads/main '%(upstream:nobracket,track)' fail
+batch_test_atom refs/heads/main '%(push:track)' fail
+batch_test_atom refs/heads/main '%(push:trackshort)' fail
+batch_test_atom refs/heads/main '%(worktreepath)' fail
+batch_test_atom refs/heads/main '%(symref)' fail
+batch_test_atom refs/heads/main '%(flag)' fail
+
+batch_test_atom refs/tags/testtag '%(refname)' fail
+batch_test_atom refs/tags/testtag '%(refname:short)' fail
+batch_test_atom refs/tags/testtag '%(upstream)' fail
+batch_test_atom refs/tags/testtag '%(push)' fail
+batch_test_atom refs/tags/testtag '%(objecttype)'
+batch_test_atom refs/tags/testtag '%(objectsize)'
+batch_test_atom refs/tags/testtag '%(objectsize:disk)'
+batch_test_atom refs/tags/testtag '%(*objectsize:disk)'
+batch_test_atom refs/tags/testtag '%(deltabase)'
+batch_test_atom refs/tags/testtag '%(*deltabase)'
+batch_test_atom refs/tags/testtag '%(objectname)'
+batch_test_atom refs/tags/testtag '%(objectname:short)'
+batch_test_atom refs/tags/testtag '%(tree)'
+batch_test_atom refs/tags/testtag '%(tree:short)'
+batch_test_atom refs/tags/testtag '%(tree:short=1)'
+batch_test_atom refs/tags/testtag '%(tree:short=10)'
+batch_test_atom refs/tags/testtag '%(parent)'
+batch_test_atom refs/tags/testtag '%(parent:short)'
+batch_test_atom refs/tags/testtag '%(parent:short=1)'
+batch_test_atom refs/tags/testtag '%(parent:short=10)'
+batch_test_atom refs/tags/testtag '%(numparent)'
+batch_test_atom refs/tags/testtag '%(object)'
+batch_test_atom refs/tags/testtag '%(type)'
+batch_test_atom refs/tags/testtag '%(*objectname)'
+batch_test_atom refs/tags/testtag '%(*objecttype)'
+batch_test_atom refs/tags/testtag '%(author)'
+batch_test_atom refs/tags/testtag '%(authorname)'
+batch_test_atom refs/tags/testtag '%(authoremail)'
+batch_test_atom refs/tags/testtag '%(authoremail:trim)'
+batch_test_atom refs/tags/testtag '%(authoremail:localpart)'
+batch_test_atom refs/tags/testtag '%(authordate)'
+batch_test_atom refs/tags/testtag '%(committer)'
+batch_test_atom refs/tags/testtag '%(committername)'
+batch_test_atom refs/tags/testtag '%(committeremail)'
+batch_test_atom refs/tags/testtag '%(committeremail:trim)'
+batch_test_atom refs/tags/testtag '%(committeremail:localpart)'
+batch_test_atom refs/tags/testtag '%(committerdate)'
+batch_test_atom refs/tags/testtag '%(tag)'
+batch_test_atom refs/tags/testtag '%(tagger)'
+batch_test_atom refs/tags/testtag '%(taggername)'
+batch_test_atom refs/tags/testtag '%(taggeremail)'
+batch_test_atom refs/tags/testtag '%(taggeremail:trim)'
+batch_test_atom refs/tags/testtag '%(taggeremail:localpart)'
+batch_test_atom refs/tags/testtag '%(taggerdate)'
+batch_test_atom refs/tags/testtag '%(creator)'
+batch_test_atom refs/tags/testtag '%(creatordate)'
+batch_test_atom refs/tags/testtag '%(subject)'
+batch_test_atom refs/tags/testtag '%(subject:sanitize)'
+batch_test_atom refs/tags/testtag '%(contents:subject)'
+batch_test_atom refs/tags/testtag '%(body)'
+batch_test_atom refs/tags/testtag '%(contents:body)'
+batch_test_atom refs/tags/testtag '%(contents:signature)'
+batch_test_atom refs/tags/testtag '%(contents)'
+batch_test_atom refs/tags/testtag '%(HEAD)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(refname)' fail
+batch_test_atom refs/myblobs/blob1 '%(upstream)' fail
+batch_test_atom refs/myblobs/blob1 '%(push)' fail
+batch_test_atom refs/myblobs/blob1 '%(HEAD)' fail
+
+batch_test_atom refs/myblobs/blob1 '%(objectname)'
+batch_test_atom refs/myblobs/blob1 '%(objecttype)'
+batch_test_atom refs/myblobs/blob1 '%(objectsize)'
+batch_test_atom refs/myblobs/blob1 '%(objectsize:disk)'
+batch_test_atom refs/myblobs/blob1 '%(deltabase)'
+
+batch_test_atom refs/myblobs/blob1 '%(contents)'
+batch_test_atom refs/myblobs/blob2 '%(contents)'
+
+batch_test_atom refs/myblobs/blob1 '%(raw)'
+batch_test_atom refs/myblobs/blob2 '%(raw)'
+batch_test_atom refs/mytrees/tree1 '%(raw)'
+
+batch_test_atom refs/myblobs/blob1 '%(raw:size)'
+batch_test_atom refs/myblobs/blob2 '%(raw:size)'
+batch_test_atom refs/mytrees/tree1 '%(raw:size)'
+
+batch_test_atom refs/myblobs/blob1 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)'
+batch_test_atom refs/myblobs/blob2 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)'
+batch_test_atom refs/mytrees/tree1 '%(if:equals=tree)%(objecttype)%(then)tree%(else)not tree%(end)'
+
+batch_test_atom refs/heads/main '%(align:60) objectname is %(objectname)%(end)|%(objectname)'
+batch_test_atom refs/heads/main '%(align:left,60) objectname is %(objectname)%(end)|%(objectname)'
+batch_test_atom refs/heads/main '%(align:middle,60) objectname is %(objectname)%(end)|%(objectname)'
+batch_test_atom refs/heads/main '%(align:60,right) objectname is %(objectname)%(end)|%(objectname)'
+
+batch_test_atom refs/heads/main 'VALID'
+batch_test_atom refs/heads/main '%(INVALID)' fail
+batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
+
+test_expect_success 'cat-file refs/heads/main refs/tags/testtag %(rest)' '
+	cat >expected <<-EOF &&
+	123 commit 123
+	456 tag 456
+	EOF
+	git cat-file --batch-check="%(rest) %(objecttype) %(rest)" >actual <<-EOF &&
+	refs/heads/main 123
+	refs/tags/testtag 456
+	EOF
+	test_cmp expected actual
+'
+
+batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsize)
+%(raw)'
+batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objectsize)
+%(raw)'
+batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(objectsize)
+%(raw)'
+batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(objectsize)
+%(raw)'
+
+
+test_expect_success 'cat-file --batch equals to --batch-check with atoms' '
+	git cat-file --batch-check="%(objectname) %(objecttype) %(objectsize)
+%(raw)" >expected <<-EOF &&
+	refs/heads/main
+	refs/tags/testtag
+	EOF
+	git cat-file --batch >actual <<-EOF &&
+	refs/heads/main
+	refs/tags/testtag
+	EOF
+	cmp expected actual
+'
+
 test_done
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 40edf9dab534..3553f84a00c1 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -41,7 +41,7 @@ test_expect_success 'Missing objects are reported correctly' '
 	r=refs/heads/missing &&
 	echo $MISSING >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	echo "fatal: $MISSING missing" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
 	test_cmp missing-err err &&
 	(
-- 
gitgitgadget

