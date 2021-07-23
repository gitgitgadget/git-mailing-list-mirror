Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94795C4320A
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD9160E78
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhGWIXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhGWIXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:23:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9518C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w12so1472670wro.13
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iHfCrV+GAffbg6cdMgspDRx2Su7oFeQUJoV+fCO8agQ=;
        b=EE/QCsK1spa3l2mcnBOAsfo1lZX9ifm/p9vKQGzujFG4iKAuwc6isoqFpY1Lb1oV98
         AuaFIgQagMh60qv678HdZ/vDf1s0/nEYAUwwUdAR38HCKw+vs03fwEaKkdhE9e9n9Yal
         nvKsIuQB9VclUdnFYlFszzRtb8HL+nF2b4uNY14616Aynla4FpYaOKq38VEdHjgNx/sE
         Gp8KKEnPYv7Ddm2wo3lXbS7J3ioI3uTmFV9h2PsOEDpmqu3TlydojpTpQfHeKTFe2Jze
         r5YPU/yXlkv0cfRLbtIMP9GHSvX0/RZPkiqYWls0fuSMFd/J56RlgCckG2TN6qd1dgSl
         c/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=iHfCrV+GAffbg6cdMgspDRx2Su7oFeQUJoV+fCO8agQ=;
        b=oC83R+2VVUyXrkiU3HMHzW74V5xeGwRN486tevOHbZHeor5fSKzXda87qj42M2HK0K
         zvzFBw8Lg/MhwkTOIzSK4qs0BE+XcKdlByU2rcZCzVtfDstBvPBi9CX7Bvo+N5IllMYb
         jltRURpHsSC6ncVXY9TRwMoHZs6tOd3XDp9MV++12qJOtIKsaBQ0dD+KdRlEWWeMmBbW
         mVN/c+SP6AS+gNRjxb5aBv1AlVMmA6LkUxpLoo4j5vg6z4WwoVZYqK/i+5DMegIVjhDA
         4Zq82J2bWM/MomHP0y86Ij98eO0wOQwHOAmaFSEb5DPUX1cemR5+vuq1rwaAXkqOZMIp
         VtrQ==
X-Gm-Message-State: AOAM532rixMw2W35p+4S3jKRq16PsrFaZ3UZDrSoyxMNecJOfX1T/YlO
        LG75qDHlhLsbkamk+LoCNLjnnG7p8ns=
X-Google-Smtp-Source: ABdhPJxHZHzr9CmB+SRToYtEb+xqMl6j7jvJrl09MD+qaxCLmAQG5nlNLG6nTTfySUs3XQKsI+YVhQ==
X-Received: by 2002:a05:6000:44:: with SMTP id k4mr4173613wrx.174.1627031045314;
        Fri, 23 Jul 2021 02:04:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm4636822wmc.24.2021.07.23.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:04:04 -0700 (PDT)
Message-Id: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 09:03:58 +0000
Subject: [PATCH v2 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
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
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is split from my main patch series zh/ref-filter-raw-data,
to make things easier for reviewers to read. It's last version is here:
https://lore.kernel.org/git/pull.993.v2.git.1626363626.gitgitgadget@gmail.com/

This patch series provided %(raw) and %(rest) for ref-filter, which will be
used by zh/cat-file-reuse-ref-filter-logic later.

Change from last version:

 1. Define ATOM_VALUE_INIT used to initialize struct atom_value and delete
    ATOM_VALUE_S_SIZE_INIT macro.
 2. Provide more complete commit message.

ZheNing Hu (5):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom

 Documentation/git-for-each-ref.txt |   9 ++
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 242 ++++++++++++++++++++++-------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 10 files changed, 464 insertions(+), 63 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1000%2Fadlternative%2Fref-filter-raw-data-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1000/adlternative/ref-filter-raw-data-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1000

Range-diff vs v1:

 1:  a7b4e45f14a ! 1:  d77268bb188 [GSOC] ref-filter: add obj-type check in grab contents
     @@ Commit message
          object contents in the current codebase.  We want to teach the
          function to also handle blobs and trees to get their raw data,
          without parsing a blob (whose contents looks like a commit or a tag)
     -    incorrectly as a commit or a tag.
     +    incorrectly as a commit or a tag. So it's needed to pass a
     +    `struct expand_data *data` instread of only `void *buf` to both
     +    `grab_sub_body_contents()` and `grab_values()` to be able to check
     +    the object type.
      
          Skip the block of code that is specific to handling commits and tags
          early when the given object is of a wrong type to help later
 2:  ecd41b370e6 ! 2:  eafb79bad62 [GSOC] ref-filter: add %(raw) atom
     @@ ref-filter.c: struct ref_formatting_state {
       	struct used_atom *atom;
       };
       
     -+#define ATOM_VALUE_S_SIZE_INIT (-1)
     ++#define ATOM_VALUE_INIT { \
     ++	.s_size = -1 \
     ++}
      +
       /*
        * Used to parse format string and sort specifiers
     @@ ref-filter.c: static int parse_ref_filter_atom(const struct ref_format *format,
       	switch (quote_style) {
       	case QUOTE_NONE:
      -		strbuf_addstr(s, str);
     -+		if (len != ATOM_VALUE_S_SIZE_INIT)
     ++		if (len != -1)
      +			strbuf_add(s, str, len);
      +		else
      +			strbuf_addstr(s, str);
     @@ ref-filter.c: static int append_atom(struct atom_value *v, struct ref_formatting
      +		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
       	else
      -		strbuf_addstr(&state->stack->output, v->s);
     -+		if (v->s_size != ATOM_VALUE_S_SIZE_INIT)
     ++		if (v->s_size != -1)
      +			strbuf_add(&state->stack->output, v->s, v->s_size);
      +		else
      +			strbuf_addstr(&state->stack->output, v->s);
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       		const char *refname;
       		struct branch *branch = NULL;
       
     -+		v->s_size = ATOM_VALUE_S_SIZE_INIT;
     ++		v->s_size = -1;
       		v->handler = append_atom;
       		v->atom = atom;
       
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
      -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
      -			? strcasecmp : strcmp;
      -		cmp = cmp_fn(va->s, vb->s);
     -+		if (va->s_size == ATOM_VALUE_S_SIZE_INIT &&
     -+		    vb->s_size == ATOM_VALUE_S_SIZE_INIT) {
     ++		if (va->s_size == -1 && vb->s_size == -1) {
      +			int (*cmp_fn)(const char *, const char *);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
      +				? strcasecmp : strcmp;
      +			cmp = cmp_fn(va->s, vb->s);
      +		} else {
     -+			size_t a_size = va->s_size == ATOM_VALUE_S_SIZE_INIT ?
     ++			size_t a_size = va->s_size == -1 ?
      +					strlen(va->s) : va->s_size;
     -+			size_t b_size = vb->s_size == ATOM_VALUE_S_SIZE_INIT ?
     ++			size_t b_size = vb->s_size == -1 ?
      +					strlen(vb->s) : vb->s_size;
      +			int (*cmp_fn)(const void *, const void *, size_t);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
       		if (va->value < vb->value)
       			cmp = -1;
      @@ ref-filter.c: int format_ref_array_item(struct ref_array_item *info,
     + 		append_literal(cp, sp, &state);
       	}
       	if (format->need_color_reset_at_eol) {
     - 		struct atom_value resetv;
     -+		resetv.s_size = ATOM_VALUE_S_SIZE_INIT;
     +-		struct atom_value resetv;
     ++		struct atom_value resetv = ATOM_VALUE_INIT;
       		resetv.s = GIT_COLOR_RESET;
       		if (append_atom(&resetv, &state, error_buf)) {
       			pop_stack_element(&state.stack);
 3:  b6438fd4308 ! 3:  00a29dd16d7 [GSOC] ref-filter: --format=%(raw) re-support --perl
     @@ ref-filter.c: static void quote_formatting(struct strbuf *s, const char *str, si
       		break;
       	case QUOTE_PERL:
      -		perl_quote_buf(s, str);
     -+		if (len != ATOM_VALUE_S_SIZE_INIT)
     ++		if (len != -1)
      +			perl_quote_buf_with_len(s, str, len);
      +		else
      +			perl_quote_buf(s, str);
 4:  33d332c664e = 4:  3a8173b42ed [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
 5:  75eb2f6740e = 5:  71249dfd4e0 [GSOC] ref-filter: add %(rest) atom

-- 
gitgitgadget
