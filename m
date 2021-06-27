Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02487C49EA6
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F7F61C17
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhF0MiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhF0MiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF39C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d11so17108874wrm.0
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JCUQ9Ch+EwAZJpqo72pR8Z2dRABHZlh8RTe692d2txQ=;
        b=OxEu9ImLr8NlT/30KVIRSRnVsn+/o63coc1FUkSAox043PxDiIFFU+nrHj5YwA5MBP
         mPVfHqCxww6P8C45z09PZGCOSoA4xjZBJK6SfTkAsVi2o/XhOJmHfVksHMO6Og4ZKOH+
         2rwfPKUrkLdCafv2mIeaZRF7XLWedPjdP7gQ293QpvVgdamXy9yrqL+tqgFb2nGXPxEV
         IC0bGGX1u6VLc5cbbEz1prTKxDTLeyRXywfGsQu+4u0vvIzVr43HXTIb9RyeO6rbG7Hh
         e3DLm8qS05nRuBtaaZPcBApFP4wG+e6CmgQVuj5cq99OdbxmsXdtJ0jZjiSHp4SMJ6Lw
         yx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JCUQ9Ch+EwAZJpqo72pR8Z2dRABHZlh8RTe692d2txQ=;
        b=n2rBLVr374yL7M1XKFuRrKwQ3cIOqz0jO8Ri35g4J5iuOjS6znWhsN5zPkC+mighXG
         KjtEG0ScI9yOQ69UV7FSJk++mEFiNPxJCrZM6x3cIENc9Xe2yli+E39iyOqsfx12W3KW
         3r8cNJ+P1FClsNaJfiUbY4+lRHNunpy07tg10A8y9SGZs6c8MrESWbgfvT8JjmAJLj5B
         kxkIzlSzBpdNglgazX1gdI0LUITcbmtE7IM0906cF0XZhzyUyCCcywL2nvouhP6N5mbm
         gO2FFFQOhfHsv/WsGg8IAXtqhcrhhd8UNNpYCMo9j0a1RAf90gJqto3Qu3L01FHTVFe5
         FPCQ==
X-Gm-Message-State: AOAM532O50ug8WGNe7SV+Kme9diJnUIrx4T2r12BkIHH4jLwW0UIewwn
        4ZTNNr+OIX+nFJYf7hQtmM7uYxAG/44=
X-Google-Smtp-Source: ABdhPJzNP0j648SLD1DZvUWEydgULLsaEpjUGlhn8kqEikM//LDN/HzIpZ7tO21AwVOjXjv5ngCvsA==
X-Received: by 2002:adf:e4c8:: with SMTP id v8mr21889822wrm.143.1624797352480;
        Sun, 27 Jun 2021 05:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h21sm2670579wmq.38.2021.06.27.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:52 -0700 (PDT)
Message-Id: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:35 +0000
Subject: [PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
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

 1. Amend part of the description of git for-each-ref.txt.
 2. Modify the code style.
 3. Do not assign the 0 to the variable ret during it's initialization.

ZheNing Hu (15):
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
  [GSOC] ref-filter: remove grab_oid() function

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 277 ++++++----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 357 ++++++++++++++++++++++-------
 ref-filter.h                       |  14 +-
 t/t1006-cat-file.sh                | 252 ++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 +++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 14 files changed, 888 insertions(+), 296 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/980

Range-diff vs v5:

  1:  f72ad9cc5e8 =  1:  f72ad9cc5e8 [GSOC] ref-filter: add obj-type check in grab contents
  2:  4e473838b9d !  2:  d9bc50c4ae6 [GSOC] ref-filter: add %(raw) atom
     @@ Commit message
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     +    Helped-by: Bagas Sanjaya <bagasdotme@gmail.com>
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Helped-by: Felipe Contreras <felipe.contreras@gmail.com>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     @@ Documentation/git-for-each-ref.txt: and `date` to extract the named component.
      +	The raw data size of the object.
      +
      +Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
     -+`--perl` because the host language may not support arbitrary binary data in the
     -+variables of its string type.
     ++`--perl` because the such language may not support arbitrary binary data in their
     ++string variable type.
      +
       The message in a commit or a tag object is `contents`, from which
       `contents:<part>` can be used to extract various parts out of:
     @@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first contents:body ""
      +	printf "  " >blob7 &&
      +	>blob8 &&
      +	obj=$(git hash-object -w blob1) &&
     -+        git update-ref refs/myblobs/blob1 "$obj" &&
     ++	git update-ref refs/myblobs/blob1 "$obj" &&
      +	obj=$(git hash-object -w blob2) &&
     -+        git update-ref refs/myblobs/blob2 "$obj" &&
     ++	git update-ref refs/myblobs/blob2 "$obj" &&
      +	obj=$(git hash-object -w blob3) &&
     -+        git update-ref refs/myblobs/blob3 "$obj" &&
     ++	git update-ref refs/myblobs/blob3 "$obj" &&
      +	obj=$(git hash-object -w blob4) &&
     -+        git update-ref refs/myblobs/blob4 "$obj" &&
     ++	git update-ref refs/myblobs/blob4 "$obj" &&
      +	obj=$(git hash-object -w blob5) &&
     -+        git update-ref refs/myblobs/blob5 "$obj" &&
     ++	git update-ref refs/myblobs/blob5 "$obj" &&
      +	obj=$(git hash-object -w blob6) &&
     -+        git update-ref refs/myblobs/blob6 "$obj" &&
     ++	git update-ref refs/myblobs/blob6 "$obj" &&
      +	obj=$(git hash-object -w blob7) &&
     -+        git update-ref refs/myblobs/blob7 "$obj" &&
     ++	git update-ref refs/myblobs/blob7 "$obj" &&
      +	obj=$(git hash-object -w blob8) &&
     -+        git update-ref refs/myblobs/blob8 "$obj"
     ++	git update-ref refs/myblobs/blob8 "$obj"
      +'
      +
      +test_expect_success 'Verify sorts with raw' '
  3:  765cf08a108 !  3:  47f868f63d9 [GSOC] ref-filter: --format=%(raw) re-support --perl
     @@ Documentation/git-for-each-ref.txt: raw:size::
       	The raw data size of the object.
       
       Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
     --`--perl` because the host language may not support arbitrary binary data in the
     -+because the host language may not support arbitrary binary data in the
     - variables of its string type.
     +-`--perl` because the such language may not support arbitrary binary data in their
     ++because the such language may not support arbitrary binary data in their
     + string variable type.
       
       The message in a commit or a tag object is `contents`, from which
      
  4:  d2aeafd0ef3 =  4:  debca156470 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  5:  1ca3a42f041 =  5:  cb0df2b8207 [GSOC] ref-filter: add %(rest) atom
  6:  67f1a3cca9a !  6:  9873354930a [GSOC] ref-filter: pass get_object() return value to their callers
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       {
       	struct object *obj;
       	int i;
     -+	int ret = 0;
     ++	int ret;
       	struct object_info empty = OBJECT_INFO_INIT;
       
       	CALLOC_ARRAY(ref->value, used_atom_cnt);
     @@ ref-filter.c: int format_ref_array_item(struct ref_array_item *info,
       {
       	const char *cp, *sp, *ep;
       	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
     -+	int ret = 0;
     ++	int ret;
       
       	state.quote_style = format->quote_style;
       	push_stack_element(&state.stack);
  7:  2a48a48e81c =  7:  e592c21ea1d [GSOC] ref-filter: introduce free_ref_array_item_value() function
  8:  be55005be75 =  8:  b6e7757de4c [GSOC] ref-filter: add cat_file_mode in struct ref_format
  9:  937f88b7837 =  9:  85686187d49 [GSOC] ref-filter: modify the error message and value in get_object
 10:  45657499c55 = 10:  6037295ee58 [GSOC] cat-file: add has_object_file() check
 11:  bf5c0a017ad = 11:  32e1ca56389 [GSOC] cat-file: change batch_objects parameter name
 12:  370101ba65f ! 12:  9a1f0732940 [GSOC] cat-file: reuse ref-filter logic
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      -		fflush(stdout);
      -		return;
      -	}
     -+	int ret = 0;
     ++	int ret;
      +	struct strbuf err = STRBUF_INIT;
      +	struct ref_array_item item = { data->oid, data->rest };
       
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
      -		print_object_or_die(opt, data);
      -		batch_write(opt, "\n", 1);
      +	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
     -+	if (ret < 0) {
     ++	if (ret < 0)
      +		die("%s\n", err.buf);
     -+	} if (ret) {
     ++	if (ret) {
      +		/* ret > 0 means when the object corresponding to oid
      +		 * cannot be found in format_ref_array_item(), we only print
      +		 * the error message.
 13:  69eef47065d ! 13:  3fb47584924 [GSOC] cat-file: reuse err buf in batch_object_write()
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
       			       struct batch_options *opt,
       			       struct expand_data *data)
       {
     - 	int ret = 0;
     + 	int ret;
      -	struct strbuf err = STRBUF_INIT;
       	struct ref_array_item item = { data->oid, data->rest };
       
     @@ builtin/cat-file.c: static void batch_write(struct batch_options *opt, const voi
       
      -	ret = format_ref_array_item(&item, &opt->format, scratch, &err);
      +	ret = format_ref_array_item(&item, &opt->format, scratch, err);
     - 	if (ret < 0) {
     + 	if (ret < 0)
      -		die("%s\n", err.buf);
      +		die("%s\n", err->buf);
     - 	} if (ret) {
     + 	if (ret) {
       		/* ret > 0 means when the object corresponding to oid
       		 * cannot be found in format_ref_array_item(), we only print
       		 * the error message.
 14:  a7ac037a946 = 14:  e0b1a05e711 [GSOC] cat-file: re-implement --textconv, --filters options
 15:  843de8864a9 = 15:  891d62fd93f [GSOC] ref-filter: remove grab_oid() function

-- 
gitgitgadget
