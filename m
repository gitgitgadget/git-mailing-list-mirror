Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC966C48BDF
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBA861353
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhFVDXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhFVDXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFCC061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y7so21747935wrh.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fa6aaQIDZrS+wKoxr0fT4DxMATEqMORiEKoG31RZkvQ=;
        b=BxDjEzXHaDk6RCQqo5yvEXjBYDh4bqu5PbcADS3MOoG63f//MpEWxEcBCXLHKLs6zn
         FMfDXH9T4FO2JmY5TLPhKa5mcLQJCkRkabxyhV4wNDMyB7h/YLBWwEBDPG4MrfTtp9Ho
         PlunUMIb6wonGry5gA3WRS+Eb2gx8GZdJm25wHAieZJ4oPLnyJb9m+XXnUkLWjHBbjqI
         ZcdMJLe6K3JNb8g4IX40mINdFgg0sZI9iV5esELt3hYD2hCpdTXZGJTlabvMN/obdctO
         hLqHlRsnK9K6n6hS3yvjocaR2c0zLpKPumb4ju1U2D331aqO6iqhHgxldCjiB/pQ1B4Z
         BmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fa6aaQIDZrS+wKoxr0fT4DxMATEqMORiEKoG31RZkvQ=;
        b=AAe3LtbaC/6Tu+EVrXzrBbktbFxdlq5fLIBMQvJGCM43CHAjZTiuOjHTpYd7unH0AR
         I2ouH5/sn40DpbRoIBB/3w1bExdUtizLAPIXyuMsBBMAcPhHyWVgsoFLUYA/ALt+9bC7
         QKn0cAr0Wi3yYGiV2sq7of4djk4wwq3t+aoF4vDzYqYCEB85R6UvQevq+6m8CiAC8lA2
         HagI3c5+nPXpXdG6ACSDGbEdxcSNFJSiPUrma5XYpRyFnQaaJnL2XGtxCrcJPrFsYkue
         2CKHEbya4bAOVCbWDnuauZ9J6UW54FDyjAjqdiZJ0g1MJ6Ha7/tMhsRMujiv0qqVshgy
         rJ/A==
X-Gm-Message-State: AOAM533vud6zCsya6faFbwVO4r0l4nphMC6tfqcjHwerZw6ycKJawGdK
        gU/Y/92oA4PZ6IAVcZQ/58/fQ1W3Wh0=
X-Google-Smtp-Source: ABdhPJwtpUC6WTgBYMKPgnbB0lGHIQOKzHzx5UzySwg/I3fpkMO8gnVZWMdhmU+CgztOjS26n3xsyA==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr1821555wrm.317.1624332056327;
        Mon, 21 Jun 2021 20:20:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4sm5970889wrw.21.2021.06.21.20.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:20:55 -0700 (PDT)
Message-Id: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:40 +0000
Subject: [PATCH v4 00/14] [GSOC][RFC] cat-file: reuse ref-filter logic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic.

Change from last version:

 1. At the suggestion of Christian Couder, split "[GSOC] cat-file: reuse
    ref-filter logic" into multiple small commits: "[GSOC] cat-file: add
    has_object_file() check", "[GSOC] ref-filter: modify the error message
    and value in get_object", "[GSOC] ref-filter: add cat_file_mode in
    struct ref_format".
 2. Change batch_objects parameter name from "opt" to "batch".
 3. Modify test subject.
 4. Begin to use the explicit initialization of REF_FORMAT_INIT in the
    design of %(rest).
 5. Fix some grammatical errors and code style issues.

ZheNing Hu (14):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: add cat_file_mode in struct ref_format
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 277 +++++++-----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 331 +++++++++++++++++++++++------
 ref-filter.h                       |  14 +-
 t/t1006-cat-file.sh                | 252 ++++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 14 files changed, 879 insertions(+), 279 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/980

Range-diff vs v3:

  1:  f72ad9cc5e8b =  1:  f72ad9cc5e8b [GSOC] ref-filter: add obj-type check in grab contents
  2:  ab497d66c116 =  2:  ab497d66c116 [GSOC] ref-filter: add %(raw) atom
  3:  b54dbc431e04 =  3:  b54dbc431e04 [GSOC] ref-filter: --format=%(raw) re-support --perl
  4:  9fbbb3c492f5 =  4:  9fbbb3c492f5 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  5:  39a0d93c7bc1 !  5:  08aa44e5e57b [GSOC] ref-filter: add %(rest) atom
     @@ ref-filter.h: struct ref_format {
       };
       
      -#define REF_FORMAT_INIT { NULL, 0, -1 }
     -+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
     ++#define REF_FORMAT_INIT { .use_color = -1 }
       
       /*  Macros for checking --merged and --no-merged options */
       #define _OPT_MERGED_NO_MERGED(option, filter, h) \
  6:  35a376db1fc1 =  6:  05682bccf9f9 [GSOC] ref-filter: pass get_object() return value to their callers
  7:  8c1d683ec6e9 =  7:  06db6cd6f1f9 [GSOC] ref-filter: introduce free_ref_array_item_value() function
  -:  ------------ >  8:  b0d9e139935f [GSOC] ref-filter: add cat_file_mode in struct ref_format
  -:  ------------ >  9:  db7dd8b042c2 [GSOC] ref-filter: modify the error message and value in get_object
  -:  ------------ > 10:  6b577969734e [GSOC] cat-file: add has_object_file() check
  -:  ------------ > 11:  069aa203666a [GSOC] cat-file: change batch_objects parameter name
  8:  bd534a266a40 ! 12:  258ec0a46c56 [GSOC] cat-file: reuse ref-filter logic
     @@ Metadata
       ## Commit message ##
          [GSOC] cat-file: reuse ref-filter logic
      
     -    In order to let cat-file use ref-filter logic, the following
     -    methods are used:
     +    In order to let cat-file use ref-filter logic, let's do the
     +    following:
      
     -    1. Add `cat_file_mode` member in struct `ref_format`, this can
     -    help us reject atoms in verify_ref_format() which cat-file
     -    cannot use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...
     -    2. Change the type of member `format` in struct `batch_options`
     -    to `ref_format`, We can add format data in it.
     -    3. Let `batch_objects()` add atoms to format, and use
     +    1. Change the type of member `format` in struct `batch_options`
     +    to `ref_format`, we will pass it to ref-filter later.
     +    2. Let `batch_objects()` add atoms to format, and use
          `verify_ref_format()` to check atoms.
     -    4. Use `has_object_file()` in `batch_one_object()` to check
     -    whether the input object exists.
     -    5. Let get_object() return 1 and print "<oid> missing" instead
     -    of returning -1 and printing "missing object <oid> for <refname>",
     -    this can help `format_ref_array_item()` just report that the
     -    object is missing without letting Git exit.
     -    6. Use `format_ref_array_item()` in `batch_object_write()` to
     +    3. Use `format_ref_array_item()` in `batch_object_write()` to
          get the formatted data corresponding to the object. If the
          return value of `format_ref_array_item()` is equals to zero,
          use `batch_write()` to print object data; else if the return
     -    value less than zero, use `die()` to print the error message
     -    and exit; else return value greater than zero, only print the
     -    error message, but not exit.
     -    7. Use free_ref_array_item_value() to free ref_array_item's
     +    value is less than zero, use `die()` to print the error message
     +    and exit; else if return value is greater than zero, only print
     +    the error message, but don't exit.
     +    4. Use free_ref_array_item_value() to free ref_array_item's
          value.
      
          Most of the atoms in `for-each-ref --format` are now supported,
          such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
          `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
          `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
     -    `%(flag)`, `%(HEAD)`, because our objects don't have refname.
     +    `%(flag)`, `%(HEAD)`, because our objects don't have a refname.
     +
     +    The performance for `git cat-file --batch-all-objects
     +    --batch-check` on the Git repository itself with performance
     +    testing tool `hyperfine` changes from 669.4 ms ±  31.1 ms to
     +    1.134 s ±  0.063 s.
     +
     +    The performance for `git cat-file --batch-all-objects --batch
     +    >/dev/null` on the Git repository itself with performance testing
     +    tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
     +    total" to "33.69s user 1.54s system 87% cpu 40.258 total".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      -		print_object_or_die(opt, data);
      -		batch_write(opt, "\n", 1);
      +	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
     -+	if (!ret) {
     -+		strbuf_addch(scratch, '\n');
     -+		batch_write(opt, scratch->buf, scratch->len);
     -+	} else if (ret < 0) {
     ++	if (ret < 0) {
      +		die("%s\n", err.buf);
     -+	} else {
     -+		/* when ret > 0 , don't call die and print the err to stdout*/
     ++	} if (ret) {
     ++		/* ret > 0 means when the object corresponding to oid
     ++		 * cannot be found in format_ref_array_item(), we only print
     ++		 * the error message.
     ++		 */
      +		printf("%s\n", err.buf);
      +		fflush(stdout);
     ++	} else {
     ++		strbuf_addch(scratch, '\n');
     ++		batch_write(opt, scratch->buf, scratch->len);
       	}
      +	free_ref_array_item_value(&item);
      +	strbuf_release(&err);
       }
       
       static void batch_one_object(const char *obj_name,
     -@@ builtin/cat-file.c: static void batch_one_object(const char *obj_name,
     - 		return;
     - 	}
     - 
     -+	if (!has_object_file(&data->oid)) {
     -+		printf("%s missing\n",
     -+		       obj_name ? obj_name : oid_to_hex(&data->oid));
     -+		fflush(stdout);
     -+		return;
     -+	}
     -+
     - 	batch_object_write(obj_name, scratch, opt, data);
     - }
     - 
      @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
       	return batch_unordered_object(oid, data);
       }
       
     --static int batch_objects(struct batch_options *opt)
     +-static int batch_objects(struct batch_options *batch)
      +static const char * const cat_file_usage[] = {
      +	N_("git cat-file (-t [--allow-unknown-type] | -s [--allow-unknown-type] | -e | -p | <type> | --textconv | --filters) [--path=<path>] <object>"),
      +	N_("git cat-file (--batch[=<format>] | --batch-check[=<format>]) [--follow-symlinks] [--textconv | --filters]"),
      +	NULL
      +};
      +
     -+static int batch_objects(struct batch_options *opt, const struct option *options)
     ++static int batch_objects(struct batch_options *batch, const struct option *options)
       {
       	struct strbuf input = STRBUF_INIT;
       	struct strbuf output = STRBUF_INIT;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
       	int save_warning;
       	int retval = 0;
       
     --	if (!opt->format)
     --		opt->format = "%(objectname) %(objecttype) %(objectsize)";
     +-	if (!batch->format)
     +-		batch->format = "%(objectname) %(objecttype) %(objectsize)";
      -
      -	/*
      -	 * Expand once with our special mark_query flag, which will prime the
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      -	 */
       	memset(&data, 0, sizeof(data));
      -	data.mark_query = 1;
     --	strbuf_expand(&output, opt->format, expand_format, &data);
     +-	strbuf_expand(&output, batch->format, expand_format, &data);
      -	data.mark_query = 0;
      -	strbuf_release(&output);
     --	if (opt->cmdmode)
     +-	if (batch->cmdmode)
      -		data.split_on_whitespace = 1;
      -
     --	if (opt->all_objects) {
     +-	if (batch->all_objects) {
      -		struct object_info empty = OBJECT_INFO_INIT;
      -		if (!memcmp(&data.info, &empty, sizeof(empty)))
      -			data.skip_object_info = 1;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      -	 * If we are printing out the object, then always fill in the type,
      -	 * since we will want to decide whether or not to stream.
      -	 */
     -+	if (!opt->format.format)
     -+		strbuf_addstr(&format, "%(objectname) %(objecttype) %(objectsize)");
     ++	if (batch->format.format)
     ++		strbuf_addstr(&format, batch->format.format);
      +	else
     -+		strbuf_addstr(&format, opt->format.format);
     - 	if (opt->print_contents)
     ++		strbuf_addstr(&format, "%(objectname) %(objecttype) %(objectsize)");
     + 	if (batch->print_contents)
      -		data.info.typep = &data.type;
      +		strbuf_addstr(&format, "\n%(raw)");
     -+	opt->format.format = format.buf;
     -+	if (verify_ref_format(&opt->format))
     ++	batch->format.format = format.buf;
     ++	if (verify_ref_format(&batch->format))
      +		usage_with_options(cat_file_usage, options);
      +
     -+	if (opt->cmdmode || opt->format.use_rest)
     ++	if (batch->cmdmode || batch->format.use_rest)
      +		data.split_on_whitespace = 1;
       
     - 	if (opt->all_objects) {
     + 	if (batch->all_objects) {
       		struct object_cb_data cb;
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch)
       			oid_array_clear(&sa);
       		}
       
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       		strbuf_release(&output);
       		return 0;
       	}
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     - 		batch_one_object(input.buf, &output, opt, &data);
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch)
     + 		batch_one_object(input.buf, &output, batch, &data);
       	}
       
      +	strbuf_release(&format);
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       	if (unknown_type && opt != 't' && opt != 's')
       		die("git cat-file --allow-unknown-type: use with -s or -t");
      
     - ## ref-filter.c ##
     -@@ ref-filter.c: int verify_ref_format(struct ref_format *format)
     - 		if (at < 0)
     - 			die("%s", err.buf);
     - 
     --		if (used_atom[at].atom_type == ATOM_REST)
     --			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
     -+		if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
     -+		    (format->cat_file_mode && (used_atom[at].atom_type == ATOM_FLAG ||
     -+					       used_atom[at].atom_type == ATOM_HEAD ||
     -+					       used_atom[at].atom_type == ATOM_PUSH ||
     -+					       used_atom[at].atom_type == ATOM_REFNAME ||
     -+					       used_atom[at].atom_type == ATOM_SYMREF ||
     -+					       used_atom[at].atom_type == ATOM_UPSTREAM ||
     -+					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
     -+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
     - 
     - 		if ((format->quote_style == QUOTE_PYTHON ||
     - 		     format->quote_style == QUOTE_SHELL ||
     -@@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
     - 	}
     - 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
     - 				     OBJECT_INFO_LOOKUP_REPLACE))
     --		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
     --				       oid_to_hex(&oi->oid), ref->refname);
     -+		return strbuf_addf_ret(err, 1, _("%s missing"),
     -+				       oid_to_hex(&oi->oid));
     - 	if (oi->info.disk_sizep && oi->disk_size < 0)
     - 		BUG("Object size is less than zero.");
     - 
     -
     - ## ref-filter.h ##
     -@@ ref-filter.h: struct ref_format {
     - 	 */
     - 	const char *format;
     - 	const char *rest;
     -+	int cat_file_mode;
     - 	int quote_style;
     - 	int use_rest;
     - 	int use_color;
     -@@ ref-filter.h: struct ref_format {
     - 	int need_color_reset_at_eol;
     - };
     - 
     --#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
     -+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
     - 
     - /*  Macros for checking --merged and --no-merged options */
     - #define _OPT_MERGED_NO_MERGED(option, filter, h) \
     -
       ## t/t1006-cat-file.sh ##
      @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --unordered works' '
       	test_cmp expect actual
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --unordered works' '
      +batch_test_atom refs/heads/main '%(INVALID)' fail
      +batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
      +
     -+test_expect_success 'cat-file refs/heads/main refs/tags/testtag %(rest)' '
     ++test_expect_success '%(rest) works with both a branch and a tag' '
      +	cat >expected <<-EOF &&
      +	123 commit 123
      +	456 tag 456
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --unordered works' '
      +'
      +
       test_done
     -
     - ## t/t6301-for-each-ref-errors.sh ##
     -@@ t/t6301-for-each-ref-errors.sh: test_expect_success 'Missing objects are reported correctly' '
     - 	r=refs/heads/missing &&
     - 	echo $MISSING >.git/$r &&
     - 	test_when_finished "rm -f .git/$r" &&
     --	echo "fatal: missing object $MISSING for $r" >missing-err &&
     -+	echo "fatal: $MISSING missing" >missing-err &&
     - 	test_must_fail git for-each-ref 2>err &&
     - 	test_cmp missing-err err &&
     - 	(
  9:  b66ab0f2d569 ! 13:  bda6aae9a6c9 [GSOC] cat-file: reuse err buf in batch_object_write()
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
       
      -	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
      +	ret = format_ref_array_item(&item, &opt->format, scratch, err);
     - 	if (!ret) {
     - 		strbuf_addch(scratch, '\n');
     - 		batch_write(opt, scratch->buf, scratch->len);
     - 	} else if (ret < 0) {
     + 	if (ret < 0) {
      -		die("%s\n", err.buf);
      +		die("%s\n", err->buf);
     - 	} else {
     - 		/* when ret > 0 , don't call die and print the err to stdout*/
     + 	} if (ret) {
     + 		/* ret > 0 means when the object corresponding to oid
     + 		 * cannot be found in format_ref_array_item(), we only print
     + 		 * the error message.
     + 		 */
      -		printf("%s\n", err.buf);
      +		printf("%s\n", err->buf);
       		fflush(stdout);
     + 	} else {
     + 		strbuf_addch(scratch, '\n');
     + 		batch_write(opt, scratch->buf, scratch->len);
       	}
       	free_ref_array_item_value(&item);
      -	strbuf_release(&err);
     @@ builtin/cat-file.c: struct object_cb_data {
       	return 0;
       }
       
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const struct option *options
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch, const struct option *optio
       {
       	struct strbuf input = STRBUF_INIT;
       	struct strbuf output = STRBUF_INIT;
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const st
       	struct strbuf format = STRBUF_INIT;
       	struct expand_data data;
       	int save_warning;
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const struct option *options
     - 		cb.opt = opt;
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch, const struct option *optio
     + 		cb.opt = batch;
       		cb.expand = &data;
       		cb.scratch = &output;
      +		cb.err = &err;
       
     - 		if (opt->unordered) {
     + 		if (batch->unordered) {
       			struct oidset seen = OIDSET_INIT;
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const struct option *options
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch, const struct option *optio
       
       		strbuf_release(&format);
       		strbuf_release(&output);
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const st
       		return 0;
       	}
       
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const struct option *options
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch, const struct option *optio
       			data.rest = p;
       		}
       
     --		batch_one_object(input.buf, &output, opt, &data);
     -+		batch_one_object(input.buf, &output, &err, opt, &data);
     +-		batch_one_object(input.buf, &output, batch, &data);
     ++		batch_one_object(input.buf, &output, &err, batch, &data);
       	}
       
       	strbuf_release(&format);
 10:  86ac3bcaecea ! 14:  d1114a2bd743 [GSOC] cat-file: re-implement --textconv, --filters options
     @@ Commit message
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## builtin/cat-file.c ##
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const struct option *options
     - 	if (opt->print_contents)
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *batch, const struct option *optio
     + 	if (batch->print_contents)
       		strbuf_addstr(&format, "\n%(raw)");
     - 	opt->format.format = format.buf;
     -+	if (opt->cmdmode == 'c')
     -+		opt->format.use_textconv = 1;
     -+	else if (opt->cmdmode == 'w')
     -+		opt->format.use_filters = 1;
     + 	batch->format.format = format.buf;
      +
     - 	if (verify_ref_format(&opt->format))
     ++	if (batch->cmdmode == 'c')
     ++		batch->format.use_textconv = 1;
     ++	else if (batch->cmdmode == 'w')
     ++		batch->format.use_filters = 1;
     ++
     + 	if (verify_ref_format(&batch->format))
       		usage_with_options(cat_file_usage, options);
       
      
     @@ ref-filter.h: struct ref_format {
       	int use_rest;
       	int use_color;
       
     -@@ ref-filter.h: struct ref_format {
     - 	int need_color_reset_at_eol;
     - };
     - 
     --#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
     -+#define REF_FORMAT_INIT { .use_color = -1 }
     - 
     - /*  Macros for checking --merged and --no-merged options */
     - #define _OPT_MERGED_NO_MERGED(option, filter, h) \

-- 
gitgitgadget
