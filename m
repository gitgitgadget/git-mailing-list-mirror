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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4EC432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2810C60F11
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 03:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhGZCq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZCqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:46:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA328C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so4233713wro.7
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jt3rMlnUJUE8RIt/V2exZhl1XbEUrrbLvTM4P1JajK4=;
        b=Hh+2ilSrRUQaAtlDtU/ux238gT3pdcyXv5YH1YWlZ+yW7FP0cIqsWEkHmlhQmmkinq
         B922tDEbpwabC3If0Bv8wVWvBcjCP0RIWd4an1nnqYpQlAdIMLhIX1CSNWuNaOSi+UW9
         MbiZ7QDizHdkZZHox4Xkur/gI1zG+IxoM2Dm1yxRgka4jRTFD0FAMUucwiJaSOEhWDWA
         86wbKy4tsQSnXtgRNzTSgc+1qH0CJSGgBeQeGpbV7cnOfo+HZGfsJQpI8qKsW6I02Uwn
         ZDy2lfI6SPsdHaLP3q3WFt/6Aslh7TZC5L2v4py945xAt66CU/70TYyxn0uibngLlopb
         r/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jt3rMlnUJUE8RIt/V2exZhl1XbEUrrbLvTM4P1JajK4=;
        b=fJrpWNiGx19n35ruBalqYBc4yRrZCNdqTDXbIi5Lexio/gJR7WAfDVhdyk540Rt1Xw
         Unzy4+dfBLmQzfnJSapBZUY136Q/OjnCQNKP127iB28J9TssMwW+QppLoZVcTSQrXQVp
         5+L8lr3Q3H4BK+dThWi1K98kyGnwftLpgpiztI8x1j00rxTYBYiUa3sgiN/5t1bToOOd
         +emLPwVQwqGauw/6CoXOmEnb+gQQA6SzHpp1T9Izl288Fc4WsHIsYdYOPS938iBvzbbM
         kQoEs0w04Bhwk9esPpTX9ERv+tF/gc28uHOXJOEgj/NIwun8FOvpR3nW7L6BsRlOym5e
         V1NA==
X-Gm-Message-State: AOAM531pltOcv/KC8UDzBFxqYtnnv+Z5OF0YZjDCzL2aOoXvEIEPUSza
        nvwMHkskCFwcXtz/wNStO+MDdJXxlL4=
X-Google-Smtp-Source: ABdhPJx5wUQg7FLUG0EzMj/kHGHcSo8VMDFC/pp/MI9orCIwjXhrTPxZQG4MXUnc4eacXJn0Y8F5Vg==
X-Received: by 2002:adf:f707:: with SMTP id r7mr12227228wrp.175.1627270012234;
        Sun, 25 Jul 2021 20:26:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm40768052wrt.93.2021.07.25.20.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:26:51 -0700 (PDT)
Message-Id: <pull.1000.v4.git.1627270010.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
References: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 03:26:45 +0000
Subject: [PATCH v4 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Jacob Keller <jacob.keller@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is split from my main patch series zh/ref-filter-raw-data,
to make things easier for reviewers to read. It's last version is here:
https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gmail.com/

This patch series provided %(raw) and %(rest) for ref-filter, which will be
used by zh/cat-file-reuse-ref-filter-logic later.

v3--->v4:

 1. Change the type of atom_value->s_size from size_t to ssize_t, and change
    the type of quote_formatting() parameters len from size_t to ssize_t at
    the same time. All of if (v->s_size == -1) change to if (v->s_size < 0).
 2. Correct the commit subject of "[GSOC] ref-filter: --format=%(raw)
    re-support --perl" to "[GSOC] ref-filter: --format=%(raw) support
    --perl" and its commit messages.

v3:
https://lore.kernel.org/git/pull.1000.v3.git.1627136061.gitgitgadget@gmail.com/

ZheNing Hu (5):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom

 Documentation/git-for-each-ref.txt |   9 ++
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 243 ++++++++++++++++++++++-------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 10 files changed, 465 insertions(+), 63 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1000%2Fadlternative%2Fref-filter-raw-data-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1000/adlternative/ref-filter-raw-data-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1000

Range-diff vs v3:

 1:  d77268bb188 ! 1:  0e294ff1626 [GSOC] ref-filter: add obj-type check in grab contents
     @@ Commit message
          early when the given object is of a wrong type to help later
          addition to handle other types of objects in this function.
      
     +    Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
          Helped-by: Junio C Hamano <gitster@pobox.com>
 2:  0ffa549da6e ! 2:  96d79a3d16b [GSOC] ref-filter: add %(raw) atom
     @@ Commit message
          variable in such languages, these may not support arbitrary binary data
          in their string variable type.
      
     +    Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
          Helped-by: Bagas Sanjaya <bagasdotme@gmail.com>
     @@ ref-filter.c: struct ref_formatting_state {
       
       struct atom_value {
       	const char *s;
     -+	size_t s_size;
     ++	ssize_t s_size;
       	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
       		       struct strbuf *err);
       	uintmax_t value; /* used for sorting when not FIELD_STR */
     @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       }
       
      -static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
     -+static void quote_formatting(struct strbuf *s, const char *str, size_t len, int quote_style)
     ++static void quote_formatting(struct strbuf *s, const char *str, ssize_t len, int quote_style)
       {
       	switch (quote_style) {
       	case QUOTE_NONE:
      -		strbuf_addstr(s, str);
     -+		if (len != -1)
     -+			strbuf_add(s, str, len);
     -+		else
     ++		if (len < 0)
      +			strbuf_addstr(s, str);
     ++		else
     ++			strbuf_add(s, str, len);
       		break;
       	case QUOTE_SHELL:
       		sq_quote_buf(s, str);
     @@ ref-filter.c: static int append_atom(struct atom_value *v, struct ref_formatting
       	 */
       	if (!state->stack->prev)
      -		quote_formatting(&state->stack->output, v->s, state->quote_style);
     +-	else
      +		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
     - 	else
     --		strbuf_addstr(&state->stack->output, v->s);
     -+		if (v->s_size != ATOM_SIZE_UNSPECIFIED)
     -+			strbuf_add(&state->stack->output, v->s, v->s_size);
     -+		else
     -+			strbuf_addstr(&state->stack->output, v->s);
     ++	else if (v->s_size < 0)
     + 		strbuf_addstr(&state->stack->output, v->s);
     ++	else
     ++		strbuf_add(&state->stack->output, v->s, v->s_size);
       	return 0;
       }
       
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
      -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
      -			? strcasecmp : strcmp;
      -		cmp = cmp_fn(va->s, vb->s);
     -+		if (va->s_size == ATOM_SIZE_UNSPECIFIED && vb->s_size == ATOM_SIZE_UNSPECIFIED) {
     ++		if (va->s_size < 0 && vb->s_size < 0) {
      +			int (*cmp_fn)(const char *, const char *);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
      +				? strcasecmp : strcmp;
      +			cmp = cmp_fn(va->s, vb->s);
      +		} else {
     -+			size_t a_size = va->s_size == ATOM_SIZE_UNSPECIFIED ?
     ++			size_t a_size = va->s_size < 0 ?
      +					strlen(va->s) : va->s_size;
     -+			size_t b_size = vb->s_size == ATOM_SIZE_UNSPECIFIED ?
     ++			size_t b_size = vb->s_size < 0 ?
      +					strlen(vb->s) : vb->s_size;
      +			int (*cmp_fn)(const void *, const void *, size_t);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
 3:  ac5d98647da ! 3:  d14fae52080 [GSOC] ref-filter: --format=%(raw) re-support --perl
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] ref-filter: --format=%(raw) re-support --perl
     +    [GSOC] ref-filter: --format=%(raw) support --perl
      
          Because the perl language can handle binary data correctly,
          add the function perl_quote_buf_with_len(), which can specify
          the length of the data and prevent the data from being truncated
     -    at '\0' to help `--format="%(raw)"` re-support `--perl`.
     +    at '\0' to help `--format="%(raw)"` support `--perl`.
      
     +    Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ quote.h: char *quote_path(const char *in, const char *prefix, struct strbuf *out
       void basic_regex_quote_buf(struct strbuf *sb, const char *src);
      
       ## ref-filter.c ##
     -@@ ref-filter.c: static void quote_formatting(struct strbuf *s, const char *str, size_t len, int
     +@@ ref-filter.c: static void quote_formatting(struct strbuf *s, const char *str, ssize_t len, int
       		sq_quote_buf(s, str);
       		break;
       	case QUOTE_PERL:
      -		perl_quote_buf(s, str);
     -+		if (len != -1)
     -+			perl_quote_buf_with_len(s, str, len);
     -+		else
     ++		if (len < 0)
      +			perl_quote_buf(s, str);
     ++		else
     ++			perl_quote_buf_with_len(s, str, len);
       		break;
       	case QUOTE_PYTHON:
       		python_quote_buf(s, str);
 4:  0722f546df9 = 4:  0aa398e8a8f [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
 5:  2300b0463f2 ! 5:  207cc512964 [GSOC] ref-filter: add %(rest) atom
     @@ Commit message
          Introduce the reject_atom() to reject the atom %(rest) for
          "git for-each-ref", "git branch", "git tag" and "git verify-tag".
      
     +    Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
          Suggected-by: Jacob Keller <jacob.keller@gmail.com>
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>

-- 
gitgitgadget
