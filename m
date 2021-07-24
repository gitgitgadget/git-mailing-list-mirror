Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96443C4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758CC60E73
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 14:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhGXNdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGXNdx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 09:33:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB8C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x14-20020a7bc20e0000b0290249f2904453so5536768wmi.1
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ya4DrnmQbhfUj3Tk5LU8HERU2qjTxCAp1donR5wrCKs=;
        b=FnQnn9vViva0UPQDFVavQ5zMF9AxcfKnGh++igWFoYuNCaIm9gEIo2S3fiHyayGOhJ
         RDUGmHAm6B2ZcRm5Trb0RAgjEd1qv6QS4b/05NirEHFjyJbTfVUKfQPJUPXWYrO0zLdz
         8gHbTm4shexETcmjJu9Yyg8Nucg5zmA2jPGCXVgWEg7gjoApveHydwscaeEzMFuziqwz
         t5J60P0z531T8of+3WaOaqUSfynjColbg6zhABgRoUm4EJniDfYL0Jjw+G1i7r6xTqft
         p6vVcCa2gl/kH0QH0I/KP0doVjBJmZCeL/VQz8NVP0c680lZLKa0nuB8QeuaVABycKbG
         kNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ya4DrnmQbhfUj3Tk5LU8HERU2qjTxCAp1donR5wrCKs=;
        b=DFzBhlAh6ulO5MOer/BGaiqrlF99/QPDK5v3TMpgo9f9Ho+/zvAyjB3cMWO8kAz19F
         XYOAlWHIUR9Z4d3XuMf2KdVIuL8Xon2fsldkQOte9QaHBsvVWJOJ+qLUFRt5uFgznoA5
         GnWLHS/f+59Hy+uBmOLeQI4BWKFrD8l49PNyNNH8rqbxHZ+isGQhjcNkU6GBmLhKn4d+
         NfgAilJrJl1Vx4Xs6JDn5YskiQh+/uKwgjmLSezuC832kwI/Qu156Y9mzD1bTzhGURjZ
         n9RSNtdi2hUM+EoooeAGVeugRndjwnoiiunezSEVRKYsu3hLxJcu0J2U9iUTaB432G+G
         UhmA==
X-Gm-Message-State: AOAM531vV7zI+baqEfnlU49EnVDfWfjZ9kHvnwBDp2uKKqqZ1NqZUV1t
        5nMV6kpmEr7+3DtxSQWkB4QBNgF8cbI=
X-Google-Smtp-Source: ABdhPJxG7ixdkidHCKPTy3OuFVVQ6ED1ou5IIP0bfgxRow3n4QHwB5O7AJS5nJm+3oFpRqD9SG8TMg==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr18971713wmi.187.1627136063441;
        Sat, 24 Jul 2021 07:14:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2sm30085465wma.27.2021.07.24.07.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 07:14:23 -0700 (PDT)
Message-Id: <pull.1000.v3.git.1627136061.gitgitgadget@gmail.com>
In-Reply-To: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
References: <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 14:14:16 +0000
Subject: [PATCH v3 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
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

v2--->v3:

 1. Add macro ATOM_SIZE_UNSPECIFIED to represent the initial value of
    atom_value->s_size.
 2. Add a description about %(rest) in the commit message. (copy from
    https://git-scm.com/docs/git-cat-file)

v2:
https://lore.kernel.org/git/CAP8UFD3ENBZdm8yQn6J-yb4PvUsrzTA3KGxes42dE3bTrYbr9Q@mail.gmail.com/

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
 ref-filter.c                       | 244 ++++++++++++++++++++++-------
 ref-filter.h                       |   9 +-
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 +++++++++++++++++++++++++++
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 10 files changed, 466 insertions(+), 63 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1000%2Fadlternative%2Fref-filter-raw-data-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1000/adlternative/ref-filter-raw-data-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1000

Range-diff vs v2:

 1:  d77268bb188 = 1:  d77268bb188 [GSOC] ref-filter: add obj-type check in grab contents
 2:  eafb79bad62 ! 2:  0ffa549da6e [GSOC] ref-filter: add %(raw) atom
     @@ ref-filter.c: struct ref_formatting_state {
       	struct used_atom *atom;
       };
       
     ++#define ATOM_SIZE_UNSPECIFIED (-1)
     ++
      +#define ATOM_VALUE_INIT { \
     -+	.s_size = -1 \
     ++	.s_size = ATOM_SIZE_UNSPECIFIED \
      +}
      +
       /*
     @@ ref-filter.c: static int append_atom(struct atom_value *v, struct ref_formatting
      +		quote_formatting(&state->stack->output, v->s, v->s_size, state->quote_style);
       	else
      -		strbuf_addstr(&state->stack->output, v->s);
     -+		if (v->s_size != -1)
     ++		if (v->s_size != ATOM_SIZE_UNSPECIFIED)
      +			strbuf_add(&state->stack->output, v->s, v->s_size);
      +		else
      +			strbuf_addstr(&state->stack->output, v->s);
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
       		const char *refname;
       		struct branch *branch = NULL;
       
     -+		v->s_size = -1;
     ++		v->s_size = ATOM_SIZE_UNSPECIFIED;
       		v->handler = append_atom;
       		v->atom = atom;
       
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
      -		cmp_fn = s->sort_flags & REF_SORTING_ICASE
      -			? strcasecmp : strcmp;
      -		cmp = cmp_fn(va->s, vb->s);
     -+		if (va->s_size == -1 && vb->s_size == -1) {
     ++		if (va->s_size == ATOM_SIZE_UNSPECIFIED && vb->s_size == ATOM_SIZE_UNSPECIFIED) {
      +			int (*cmp_fn)(const char *, const char *);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
      +				? strcasecmp : strcmp;
      +			cmp = cmp_fn(va->s, vb->s);
      +		} else {
     -+			size_t a_size = va->s_size == -1 ?
     ++			size_t a_size = va->s_size == ATOM_SIZE_UNSPECIFIED ?
      +					strlen(va->s) : va->s_size;
     -+			size_t b_size = vb->s_size == -1 ?
     ++			size_t b_size = vb->s_size == ATOM_SIZE_UNSPECIFIED ?
      +					strlen(vb->s) : vb->s_size;
      +			int (*cmp_fn)(const void *, const void *, size_t);
      +			cmp_fn = s->sort_flags & REF_SORTING_ICASE
 3:  00a29dd16d7 = 3:  ac5d98647da [GSOC] ref-filter: --format=%(raw) re-support --perl
 4:  3a8173b42ed = 4:  0722f546df9 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
 5:  71249dfd4e0 ! 5:  2300b0463f2 [GSOC] ref-filter: add %(rest) atom
     @@ Metadata
       ## Commit message ##
          [GSOC] ref-filter: add %(rest) atom
      
     +    %(rest) is a atom used for cat-file batch mode, which can split
     +    the input lines at the first whitespace boundary, all characters
     +    before that whitespace are considered to be the object name;
     +    characters after that first run of whitespace (i.e., the "rest"
     +    of the line) are output in place of the %(rest) atom.
     +
          In order to let "cat-file --batch=%(rest)" use the ref-filter
     -    interface, add %(rest) atom for ref-filter. Introduce the
     -    reject_atom() to reject the atom %(rest) for "git for-each-ref",
     -    "git branch", "git tag" and "git verify-tag".
     +    interface, add %(rest) atom for ref-filter.
     +
     +    Introduce the reject_atom() to reject the atom %(rest) for
     +    "git for-each-ref", "git branch", "git tag" and "git verify-tag".
      
     +    Suggected-by: Jacob Keller <jacob.keller@gmail.com>
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>

-- 
gitgitgadget
