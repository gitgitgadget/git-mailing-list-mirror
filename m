Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CFC49361
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9986100A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhFSHFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFSHFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:05:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD52C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i94so13226457wri.4
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 00:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xaXLRvoLXHN6b8AIaBtz9BqZZfmvjpRX/ngvIf6vnmw=;
        b=t6+sY8XbR7K4kJUCkRxSe0ePOu+PpWuWIkI392JKTT1vsgP2uK+LH0JVOm/FUuRmkN
         1yib2kfL/M+KGk8DEEsjbpgK6tsq3W71CYwwNHv0JD/QijYSgXme30ix2h9zwFKtNvby
         JCNmJTIKFt8M9dH0i2hSDt3P4yl8IY0qfe9U7Y/FDaB6rpmgzx/b1QPQes+taWiCPZos
         wmvcgOjBA0/a5itFG0m7DOSvM3Pf8LaCPoqKufXp9ryGfGbwEvDoA+h1nc2K3x/xAWMz
         sEjN7InEbFpKAtl2+F5cNScthAmuz7EhVSPmcOClBeYFaolOuPGuOay2R66N70vbbzmI
         r8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xaXLRvoLXHN6b8AIaBtz9BqZZfmvjpRX/ngvIf6vnmw=;
        b=dDIYdljD5EC4eAnxRjC3P+wkYzyYbL0bD/qTPj8BgJGCJLaXb/oTL1rE0ls6McKDT+
         Ejfrw07p5I+IbEEHPKoyJed/Je6tsYvEz1tmsJzP98iHbTs+813yKuHBDS0vwrmn6tPL
         YzQ8SbxCDLPFErGsqEjG6RrUL4Sg91xuwlPjt3jJSIx6crR6AAM40u33FVvXe9y2fqRo
         wxG2lfzOyFxMSWGvGTgMpZObekgStRiOK3OJu9SncGqvC+FakaILgEQQHLVRB1ewJadu
         WuO3plrBR6bzKY5hZZw0j3vfTSWM7j47RFboEAz55zFl3pONqNGYMsm2OTWD3FDcQnj9
         z6Ww==
X-Gm-Message-State: AOAM533S0iM6svCReIFDQihJjavr8pRGaHcYNDcYJoNvkTSX0KHy2C0c
        9gxbnvUiaNu7mpwSXGS8g/sbnToDYO0=
X-Google-Smtp-Source: ABdhPJzLq+XSwGiDn68Fh89CXF9m+s5YWbFrb/ek/yFRQUi+RvBGB7aBBfsqJ4jSC7mYOENNy5cYzw==
X-Received: by 2002:a5d:5683:: with SMTP id f3mr16498805wrv.61.1624086183029;
        Sat, 19 Jun 2021 00:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm11363934wrv.39.2021.06.19.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 00:03:02 -0700 (PDT)
Message-Id: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Jun 2021 07:02:50 +0000
Subject: [PATCH v3 00/10] [GSOC][RFC] cat-file: reuse ref-filter logic
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

This patch series make cat-file reuse ref-filter logic. As part of the
content related to zh/ref-filter-raw-data has been modified, this patch
currently sets the base on zh/ref-filter-atom-type until
zh/ref-filter-raw-data is stable And will rebase to it.

f72ad9c~1..39a0d93 of this patch belongs to zh/ref-filter-raw-data. Change
from last version:

 1. Let --format=%(raw) re-support --perl.
 2. Correct some errors in the test.
 3. Add the reason why strbuf is not used to replace atom_value's member s
    in the commit message.

39a0d93..86ac3bc of this patch is another part. Change from last version:

 1. Modify free_array_item_internal() to free_ref_array_item_value().
 2. Change some errors of the code style.
 3. Change some commit messages.

ZheNing Hu (10):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 267 ++++++-----------------
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
 14 files changed, 872 insertions(+), 276 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/980

Range-diff vs v2:

  1:  48d256db5c34 =  1:  f72ad9cc5e8b [GSOC] ref-filter: add obj-type check in grab contents
  2:  abee6a03becb !  2:  ab497d66c116 [GSOC] ref-filter: add %(raw) atom
     @@ Commit message
          `100644 one\0...`, only the `100644 one` will be added to the buffer,
          which is incorrect.
      
     -    Therefore, add a new member in `struct atom_value`: `s_size`, which
     -    can record raw object size, it can help us add raw object data to
     -    the buffer or compare two buffers which contain raw object data.
     +    Therefore, we need to find a way to record the length of the
     +    atom_value's member `s`. Although strbuf can already record the
     +    string and its length, if we want to replace the type of atom_value's
     +    member `s` with strbuf, many places in ref-filter that are filled
     +    with dynamically allocated mermory in `v->s` are not easy to replace.
     +    At the same time, we need to check if `v->s == NULL` in
     +    populate_value(), and strbuf cannot easily distinguish NULL and empty
     +    strings, but c-style "const char *" can do it. So add a new member in
     +    `struct atom_value`: `s_size`, which can record raw object size, it
     +    can help us add raw object data to the buffer or compare two buffers
     +    which contain raw object data.
      
          Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
     -    `--tcl`, `--perl` because if our binary raw data is passed to a variable
     -    in the host language, the host language may not support arbitrary binary
     -    data in the variables of its string type.
     +    `--tcl`, `--perl` because if our binary raw data is passed to a
     +    variable in the host language, the host language may not support
     +    arbitrary binary data in the variables of its string type.
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Junio C Hamano <gitster@pobox.com>
     @@ t/t6300-for-each-ref.sh: test_atom tag contents 'Tagging at 1151968727
      +	git cat-file commit refs/tags/testtag^{} >expected &&
      +	git for-each-ref --format="%(*raw)" refs/tags/testtag >actual &&
      +	sanitize_pgp <expected >expected.clean &&
     ++	echo >>expected.clean &&
      +	sanitize_pgp <actual >actual.clean &&
     -+	echo "" >>expected.clean &&
      +	test_cmp expected.clean actual.clean
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_atom refs/tags/signed-empty contents:body ''
      +	git cat-file tag refs/tags/signed-empty >expected &&
      +	git for-each-ref --format="%(raw)" refs/tags/signed-empty >actual &&
      +	sanitize_pgp <expected >expected.clean &&
     ++	echo >>expected.clean &&
      +	sanitize_pgp <actual >actual.clean &&
     -+	echo "" >>expected.clean &&
      +	test_cmp expected.clean actual.clean
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_atom refs/tags/signed-short contents:signature "$s
      +	git cat-file tag refs/tags/signed-short >expected &&
      +	git for-each-ref --format="%(raw)" refs/tags/signed-short >actual &&
      +	sanitize_pgp <expected >expected.clean &&
     ++	echo >>expected.clean &&
      +	sanitize_pgp <actual >actual.clean &&
     -+	echo "" >>expected.clean &&
      +	test_cmp expected.clean actual.clean
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_atom refs/tags/signed-long contents "subject line
      +	git cat-file tag refs/tags/signed-long >expected &&
      +	git for-each-ref --format="%(raw)" refs/tags/signed-long >actual &&
      +	sanitize_pgp <expected >expected.clean &&
     ++	echo >>expected.clean &&
      +	sanitize_pgp <actual >actual.clean &&
     -+	echo "" >>expected.clean &&
      +	test_cmp expected.clean actual.clean
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_atom refs/mytrees/first contents:body ""
       
      +test_expect_success 'basic atom: refs/mytrees/first raw' '
      +	git cat-file tree refs/mytrees/first >expected &&
     -+	echo "" >>expected &&
     ++	echo >>expected &&
      +	git for-each-ref --format="%(raw)" refs/mytrees/first >actual &&
      +	test_cmp expected actual &&
      +	git cat-file -s refs/mytrees/first >expected &&
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
       
      +test_expect_success 'basic atom: refs/myblobs/first raw' '
      +	git cat-file blob refs/myblobs/first >expected &&
     -+	echo "" >>expected &&
     ++	echo >>expected &&
      +	git for-each-ref --format="%(raw)" refs/myblobs/first >actual &&
      +	test_cmp expected actual &&
      +	git cat-file -s refs/myblobs/first >expected &&
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +	printf "\0 \0a\0 " >blob6 &&
      +	printf "  " >blob7 &&
      +	>blob8 &&
     -+	git hash-object blob1 -w | xargs git update-ref refs/myblobs/blob1 &&
     -+	git hash-object blob2 -w | xargs git update-ref refs/myblobs/blob2 &&
     -+	git hash-object blob3 -w | xargs git update-ref refs/myblobs/blob3 &&
     -+	git hash-object blob4 -w | xargs git update-ref refs/myblobs/blob4 &&
     -+	git hash-object blob5 -w | xargs git update-ref refs/myblobs/blob5 &&
     -+	git hash-object blob6 -w | xargs git update-ref refs/myblobs/blob6 &&
     -+	git hash-object blob7 -w | xargs git update-ref refs/myblobs/blob7 &&
     -+	git hash-object blob8 -w | xargs git update-ref refs/myblobs/blob8
     ++	obj=$(git hash-object -w blob1) &&
     ++        git update-ref refs/myblobs/blob1 "$obj" &&
     ++	obj=$(git hash-object -w blob2) &&
     ++        git update-ref refs/myblobs/blob2 "$obj" &&
     ++	obj=$(git hash-object -w blob3) &&
     ++        git update-ref refs/myblobs/blob3 "$obj" &&
     ++	obj=$(git hash-object -w blob4) &&
     ++        git update-ref refs/myblobs/blob4 "$obj" &&
     ++	obj=$(git hash-object -w blob5) &&
     ++        git update-ref refs/myblobs/blob5 "$obj" &&
     ++	obj=$(git hash-object -w blob6) &&
     ++        git update-ref refs/myblobs/blob6 "$obj" &&
     ++	obj=$(git hash-object -w blob7) &&
     ++        git update-ref refs/myblobs/blob7 "$obj" &&
     ++	obj=$(git hash-object -w blob8) &&
     ++        git update-ref refs/myblobs/blob8 "$obj"
      +'
      +
      +test_expect_success 'Verify sorts with raw' '
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +		refs/myblobs/ refs/heads/ >actual &&
      +	test_cmp expected actual
      +'
     ++
      +test_expect_success 'validate raw atom with %(if:notequals)' '
      +	cat >expected <<-EOF &&
      +	refs/heads/ambiguous
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +	test_cmp expected actual
      +'
      +
     -+test_expect_success '%(raw) with --python must failed' '
     ++test_expect_success '%(raw) with --python must fail' '
      +	test_must_fail git for-each-ref --format="%(raw)" --python
      +'
      +
     -+test_expect_success '%(raw) with --tcl must failed' '
     ++test_expect_success '%(raw) with --tcl must fail' '
      +	test_must_fail git for-each-ref --format="%(raw)" --tcl
      +'
      +
     -+test_expect_success '%(raw) with --perl must failed' '
     ++test_expect_success '%(raw) with --perl must fail' '
      +	test_must_fail git for-each-ref --format="%(raw)" --perl
      +'
      +
     -+test_expect_success '%(raw) with --shell must failed' '
     ++test_expect_success '%(raw) with --shell must fail' '
      +	test_must_fail git for-each-ref --format="%(raw)" --shell
      +'
      +
     -+test_expect_success '%(raw) with --shell and --sort=raw must failed' '
     ++test_expect_success '%(raw) with --shell and --sort=raw must fail' '
      +	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
      +'
      +
  -:  ------------ >  3:  b54dbc431e04 [GSOC] ref-filter: --format=%(raw) re-support --perl
  3:  c99d1d070a18 =  4:  9fbbb3c492f5 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  4:  5a5b5f78aeea !  5:  39a0d93c7bc1 [GSOC] ref-filter: add %(rest) atom
     @@ ref-filter.c: static struct {
       	 * Please update $__git_ref_fieldlist in git-completion.bash
       	 * when you add new atoms
      @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
     - 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
       		if (at < 0)
       			die("%s", err.buf);
     + 
      +		if (used_atom[at].atom_type == ATOM_REST)
      +			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
      +
     - 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
     - 		    used_atom[at].u.raw_data.option == RAW_BARE)
     - 			die(_("--format=%.*s cannot be used with"
     + 		if ((format->quote_style == QUOTE_PYTHON ||
     + 		     format->quote_style == QUOTE_SHELL ||
     + 		     format->quote_style == QUOTE_TCL) &&
      @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
       			v->handler = else_atom_handler;
       			v->s = xstrdup("");
     @@ t/t3203-branch-output.sh: test_expect_success 'git branch --format option' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'git branch with --format=%(rest) must failed' '
     ++test_expect_success 'git branch with --format=%(rest) must fail' '
      +	test_must_fail git branch --format="%(rest)" >actual
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_expect_success 'basic atom: head contents:trailers
       	test_cmp expect actual.clean
       '
       
     -+test_expect_success 'basic atom: rest must failed' '
     ++test_expect_success 'basic atom: rest must fail' '
      +	test_must_fail git for-each-ref --format="%(rest)" refs/heads/main
      +'
      +
     @@ t/t7004-tag.sh: test_expect_success '--format should list tags as per format giv
       	test_cmp expect actual
       '
       
     -+test_expect_success 'git tag -l with --format="%(rest)" must failed' '
     ++test_expect_success 'git tag -l with --format="%(rest)" must fail' '
      +	test_must_fail git tag -l --format="%(rest)" "v1*"
      +'
      +
     @@ t/t7030-verify-tag.sh: test_expect_success GPG 'verifying tag with --format' '
       	test_cmp expect actual
       '
       
     -+test_expect_success GPG 'verifying tag with --format="%(rest)" must failed' '
     ++test_expect_success GPG 'verifying tag with --format="%(rest)" must fail' '
      +	test_must_fail git verify-tag --format="%(rest)" "fourth-signed"
      +'
      +
  5:  49063372e003 !  6:  35a376db1fc1 [GSOC] ref-filter: teach get_object() return useful value
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] ref-filter: teach get_object() return useful value
     +    [GSOC] ref-filter: pass get_object() return value to their callers
      
     -    Let `populate_value()`, `get_ref_atom_value()` and
     -    `format_ref_array_item()` get the return value of `get_object()`
     -    correctly. This can help us later let `cat-file --batch` get the
     -    correct error message and return value of `get_object()`.
     +    Since in the refactor of `git cat-file --batch` later,
     +    oid_object_info_extended() in get_object() will be used to obtain
     +    the info of an object with it's oid. When the object cannot be
     +    obtained in the git repository, `cat-file --batch` expects to output
     +    "<oid> missing" and continue the next oid query instead of letting
     +    Git exit. In other error conditions, Git should exit normally. So we
     +    can achieve this function by passing the return value of get_object().
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## ref-filter.c ##
     -@@ ref-filter.c: static char *get_worktree_path(const struct used_atom *atom, const struct ref_ar
     - static int populate_value(struct ref_array_item *ref, struct strbuf *err)
     +@@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
       {
       	struct object *obj;
     --	int i;
     -+	int i, ret = 0;
     + 	int i;
     ++	int ret = 0;
       	struct object_info empty = OBJECT_INFO_INIT;
       
       	CALLOC_ARRAY(ref->value, used_atom_cnt);
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       	oi.oid = ref->objectname;
      -	if (get_object(ref, 0, &obj, &oi, err))
      -		return -1;
     -+	if ((ret = get_object(ref, 0, &obj, &oi, err)))
     ++	ret = get_object(ref, 0, &obj, &oi, err);
     ++	if (ret)
      +		return ret;
       
       	/*
       	 * If there is no atom that wants to know about tagged
     -@@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
     - static int get_ref_atom_value(struct ref_array_item *ref, int atom,
     +@@ ref-filter.c: static int get_ref_atom_value(struct ref_array_item *ref, int atom,
       			      struct atom_value **v, struct strbuf *err)
       {
     -+	int ret = 0;
     -+
       	if (!ref->value) {
      -		if (populate_value(ref, err))
      -			return -1;
     -+		if ((ret = populate_value(ref, err)))
     ++		int ret = populate_value(ref, err);
     ++
     ++		if (ret)
      +			return ret;
       		fill_missing_values(ref->value);
       	}
     @@ ref-filter.c: int format_ref_array_item(struct ref_array_item *info,
       		}
       	}
       	if (*cp) {
     -@@ ref-filter.c: int format_ref_array_item(struct ref_array_item *info,
     - 	}
     - 	strbuf_addbuf(final_buf, &state.stack->output);
     - 	pop_stack_element(&state.stack);
     --	return 0;
     -+	return ret;
     - }
     - 
     - void pretty_print_ref(const char *name, const struct object_id *oid,
  6:  d2f2563eb76a !  7:  8c1d683ec6e9 [GSOC] ref-filter: introduce free_array_item_internal() function
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] ref-filter: introduce free_array_item_internal() function
     +    [GSOC] ref-filter: introduce free_ref_array_item_value() function
      
     -    Introduce free_array_item_internal() for freeing ref_array_item value.
     +    When we use ref_array_item which is not dynamically allocated and
     +    want to free the space of its member "value" after the end of use,
     +    free_array_item() does not meet our needs, because it tries to free
     +    ref_array_item itself and its member "symref".
     +
     +    Introduce free_ref_array_item_value() for freeing ref_array_item value.
          It will be called internally by free_array_item(), and it will help
     -    `cat-file --batch` free ref_array_item's memory later.
     +    `cat-file --batch` free ref_array_item's value memory later.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     @@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct ob
       
      -/*  Free memory allocated for a ref_array_item */
      -static void free_array_item(struct ref_array_item *item)
     -+void free_array_item_internal(struct ref_array_item *item)
     ++void free_ref_array_item_value(struct ref_array_item *item)
       {
      -	free((char *)item->symref);
       	if (item->value) {
     @@ ref-filter.c: static int ref_filter_handler(const char *refname, const struct ob
      +static void free_array_item(struct ref_array_item *item)
      +{
      +	free((char *)item->symref);
     -+	free_array_item_internal(item);
     ++	free_ref_array_item_value(item);
       	free(item);
       }
       
     @@ ref-filter.h: struct ref_format {
       int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
       /*  Clear all memory allocated to ref_array */
       void ref_array_clear(struct ref_array *array);
     -+/* Free array item's value */
     -+void free_array_item_internal(struct ref_array_item *item);
     ++/* Free ref_array_item's value */
     ++void free_ref_array_item_value(struct ref_array_item *item);
       /*  Used to verify if the given format is correct and to parse out the used atoms */
       int verify_ref_format(struct ref_format *format);
       /*  Sort the given ref_array as per the ref_sorting provided */
  7:  765337a46ab0 !  8:  bd534a266a40 [GSOC] cat-file: reuse ref-filter logic
     @@ Commit message
          `verify_ref_format()` to check atoms.
          4. Use `has_object_file()` in `batch_one_object()` to check
          whether the input object exists.
     -    5. Use `format_ref_array_item()` in `batch_object_write()` to
     +    5. Let get_object() return 1 and print "<oid> missing" instead
     +    of returning -1 and printing "missing object <oid> for <refname>",
     +    this can help `format_ref_array_item()` just report that the
     +    object is missing without letting Git exit.
     +    6. Use `format_ref_array_item()` in `batch_object_write()` to
          get the formatted data corresponding to the object. If the
          return value of `format_ref_array_item()` is equals to zero,
          use `batch_write()` to print object data; else if the return
          value less than zero, use `die()` to print the error message
          and exit; else return value greater than zero, only print the
          error message, but not exit.
     -    6. Let get_object() return 1 and print "<oid> missing" instead
     -    of returning -1 and printing "missing object <oid> for <refname>",
     -    this can help `format_ref_array_item()` just report that the
     -    object is missing without letting Git exit.
     +    7. Use free_ref_array_item_value() to free ref_array_item's
     +    value.
      
          Most of the atoms in `for-each-ref --format` are now supported,
          such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      +		printf("%s\n", err.buf);
      +		fflush(stdout);
       	}
     -+	free_array_item_internal(&item);
     ++	free_ref_array_item_value(&item);
      +	strbuf_release(&err);
       }
       
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
      
       ## ref-filter.c ##
      @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
     - 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
       		if (at < 0)
       			die("%s", err.buf);
     + 
      -		if (used_atom[at].atom_type == ATOM_REST)
      -			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
      +		if ((!format->cat_file_mode && used_atom[at].atom_type == ATOM_REST) ||
     @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
      +					       used_atom[at].atom_type == ATOM_WORKTREEPATH)))
      +			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
       
     - 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
     - 		    used_atom[at].u.raw_data.option == RAW_BARE)
     + 		if ((format->quote_style == QUOTE_PYTHON ||
     + 		     format->quote_style == QUOTE_SHELL ||
      @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
       	}
       	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --unordered works' '
      +batch_test_atom() {
      +	if test "$3" = "fail"
      +	then
     -+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 mast failed" "
     ++		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must fail" "
      +			test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
      +			$1
      +			EOF
  8:  058b304686fd !  9:  b66ab0f2d569 [GSOC] cat-file: reuse err buf in batch_objet_write()
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] cat-file: reuse err buf in batch_objet_write()
     +    [GSOC] cat-file: reuse err buf in batch_object_write()
      
          Reuse the `err` buffer in batch_object_write(), as the
          buffer `scratch` does. This will reduce the overhead
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      +		printf("%s\n", err->buf);
       		fflush(stdout);
       	}
     - 	free_array_item_internal(&item);
     + 	free_ref_array_item_value(&item);
      -	strbuf_release(&err);
       }
       
  9:  cbf7d51933ea ! 10:  86ac3bcaecea [GSOC] cat-file: re-implement --textconv, --filters options
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt, const st
       	opt->format.format = format.buf;
      +	if (opt->cmdmode == 'c')
      +		opt->format.use_textconv = 1;
     -+	if (opt->cmdmode == 'w')
     ++	else if (opt->cmdmode == 'w')
      +		opt->format.use_filters = 1;
      +
       	if (verify_ref_format(&opt->format))
     @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
      +		use_filters = format->use_filters;
      +		use_textconv = format->use_textconv;
      +
     - 		if (format->quote_style && used_atom[at].atom_type == ATOM_RAW &&
     - 		    used_atom[at].u.raw_data.option == RAW_BARE)
     - 			die(_("--format=%.*s cannot be used with"
     + 		if ((format->quote_style == QUOTE_PYTHON ||
     + 		     format->quote_style == QUOTE_SHELL ||
     + 		     format->quote_style == QUOTE_TCL) &&
      @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struct object **obj
       {
       	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
     @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struc
      +		oi->info.typep = NULL;
      +		oi->info.contentp = temp_contentp;
      +
     -+		if (use_textconv) {
     ++		if (use_textconv && !ref->rest)
     ++			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
     ++					       oid_to_hex(&act_oi.oid));
     ++		if (use_textconv && oi->type == OBJ_BLOB) {
      +			act_oi = *oi;
     -+
     -+			if(!ref->rest)
     -+				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
     -+						       oid_to_hex(&act_oi.oid));
     -+			if (act_oi.type == OBJ_BLOB) {
     -+				if (textconv_object(the_repository,
     -+						    ref->rest, 0100644, &act_oi.oid,
     -+						    1, (char **)(&act_oi.content), &act_oi.size)) {
     -+					actual_oi = &act_oi;
     -+					goto success;
     -+				}
     ++			if (textconv_object(the_repository,
     ++					    ref->rest, 0100644, &act_oi.oid,
     ++					    1, (char **)(&act_oi.content), &act_oi.size)) {
     ++				actual_oi = &act_oi;
     ++				goto success;
      +			}
      +		}
       	}
     @@ ref-filter.c: static int get_object(struct ref_array_item *ref, int deref, struc
       
       	if (oi->info.contentp) {
      -		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
     -+		if (use_filters) {
     -+			if(!ref->rest)
     -+				return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
     -+						       oid_to_hex(&oi->oid));
     -+			if (oi->type == OBJ_BLOB) {
     -+				struct strbuf strbuf = STRBUF_INIT;
     -+				struct checkout_metadata meta;
     -+				act_oi = *oi;
     ++		if (use_filters && !ref->rest)
     ++			return strbuf_addf_ret(err, -1, _("missing path for '%s'"),
     ++					       oid_to_hex(&oi->oid));
     ++		if (use_filters && oi->type == OBJ_BLOB) {
     ++			struct strbuf strbuf = STRBUF_INIT;
     ++			struct checkout_metadata meta;
     ++			act_oi = *oi;
      +
     -+				init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
     -+				if (convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta)) {
     -+					act_oi.size = strbuf.len;
     -+					act_oi.content = strbuf_detach(&strbuf, NULL);
     -+					actual_oi = &act_oi;
     -+				} else {
     -+					die("could not convert '%s' %s",
     -+					    oid_to_hex(&oi->oid), ref->rest);
     -+				}
     -+			}
     ++			init_checkout_metadata(&meta, NULL, NULL, &act_oi.oid);
     ++			if (!convert_to_working_tree(&the_index, ref->rest, act_oi.content, act_oi.size, &strbuf, &meta))
     ++				die("could not convert '%s' %s",
     ++					oid_to_hex(&oi->oid), ref->rest);
     ++			act_oi.size = strbuf.len;
     ++			act_oi.content = strbuf_detach(&strbuf, NULL);
     ++			actual_oi = &act_oi;
      +		}
      +
      +success:
     @@ ref-filter.h: struct ref_format {
       };
       
      -#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
     -+#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, 0, 0, -1 }
     ++#define REF_FORMAT_INIT { .use_color = -1 }
       
       /*  Macros for checking --merged and --no-merged options */
       #define _OPT_MERGED_NO_MERGED(option, filter, h) \

-- 
gitgitgadget
