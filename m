Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617EFC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288BD20575
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbhAGJwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbhAGJww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:52:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC182C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c133so4611683wme.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNM2vHAtfHFwR9Uf+Uf/rPsmwHLOQQtwO1KMj/nJKJg=;
        b=hO24KeRkLr54jit46vRVDm/u/qokdk3qc6EOZksVNRMf7kjb0gY0U/4OzmJT4HbMm1
         f/pUsN9cJHx/MtJZHTmzug4306BZYwspQRAkkp5mXPn74uFSQIWWL8q7nZpMARB0Ur8V
         xrFfb3WQp6hhKWnMnn5TFj/nGd9I2Vz5lKVk3gvzWCMn3uAkA4yW4g9uomg24VFQbhAs
         aCqAZRIHYGgik3V8XLSUIVbkYq0edrc8z/wcbByvg+px8/nZIl9SRa2akw9xy9a3twER
         4W9WNfsg+c/DwMa0OtO9gS/cvqfr//6gmQa0ZCEF8/mec8PrubaqWR/BRNv5xNLti3Lj
         g7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNM2vHAtfHFwR9Uf+Uf/rPsmwHLOQQtwO1KMj/nJKJg=;
        b=swGwxv1OkCoSoRdiKl5oPp1GoI1oBE5Dlf9y6WBrnpD8GfZ4hQcVeV+zgVDfOWgQ+6
         lKpeDmCUDOqas8HZiRSnqBbfybb8aQHpwShl1VKgU4FTGrSZ8Q6zWof4WJxD3S1w7nq3
         h6UOAsdNdWKGk6ohFFV8ZGDuKIGzRcnnoMdBbmJ68oZTx6b9VCcUjOov7PL+4iBMijoR
         b+Y/35deIlH7bghHxcKgq19Nf8/a0CFAV0Un4PNYs/uSz430PcuPlzFMa/xr+jRkfKEj
         dE9q71D+HU4XVoQIGmmct0NbIIQs6Dm4p7tw7HQCA2iGXKFzKxx8sd2YYQiDFbcffSZ9
         Rcpw==
X-Gm-Message-State: AOAM5319rk1BUjADtaYrvmslYzW9dezo2HTahcIRsGUSwmeGIirB5LCN
        y5iqFe6RQhe+s+wbD/OGpf24fSskc/iRGA==
X-Google-Smtp-Source: ABdhPJz9JAyD5X0hXGtRcau7J+k5EdJUx9DdPLeTdg73OIc6TOBgMm3+S+YSU1IjY1u3ZUtpA+l2MQ==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr7374453wma.9.1610013130226;
        Thu, 07 Jan 2021 01:52:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] branch: --sort improvements
Date:   Thu,  7 Jan 2021 10:51:46 +0100
Message-Id: <20210107095153.4753-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses a comment Junio had on 3/5 in v1. Now there's leading
patches moving the ref_sorting flags to a bitfield, which (agreeing
with Junio) I think looks a bit better & should be more maintainable
going forward.

While I was at it I squashed the 3/5 and 4/5 patches into one. It's
less confusing to look at when we add the ref-filter.c sorting code in
the same commit we're using it in. I also made the bitfield/xor
checking/sanity BUG a bit less verbose & simpler to understand.

Ævar Arnfjörð Bjarmason (7):
  branch: change "--local" to "--list" in comment
  branch tests: add to --sort tests
  ref-filter: add braces to if/else if/else chain
  ref-filter: move "cmp_fn" assignment into "else if" arm
  ref-filter: move ref_sorting flags to a bitfield
  branch: sort detached HEAD based on a flag
  branch: show "HEAD detached" first under reverse sort

 builtin/branch.c         |  6 ++--
 builtin/for-each-ref.c   |  2 +-
 builtin/tag.c            |  2 +-
 ref-filter.c             | 75 ++++++++++++++++++++++++----------------
 ref-filter.h             | 13 ++++---
 t/t3203-branch-output.sh | 51 ++++++++++++++++++++++++++-
 wt-status.c              |  4 +--
 wt-status.h              |  2 --
 8 files changed, 111 insertions(+), 44 deletions(-)

Range-diff:
1:  c74e75dea90 = 1:  c74e75dea90 branch: change "--local" to "--list" in comment
2:  1fea125c7a6 = 2:  1fea125c7a6 branch tests: add to --sort tests
3:  11e6f274d2d < -:  ----------- ref-filter: add a "detached_head_first" sorting option
-:  ----------- > 3:  5cb44f0be40 ref-filter: add braces to if/else if/else chain
-:  ----------- > 4:  3e26cebe545 ref-filter: move "cmp_fn" assignment into "else if" arm
-:  ----------- > 5:  ad598fdc87c ref-filter: move ref_sorting flags to a bitfield
4:  faf9e23a13f ! 6:  af0c884b506 branch: use the "detached_head_first" sorting option
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    branch: use the "detached_head_first" sorting option
    +    branch: sort detached HEAD based on a flag
     
    -    Use the new ref_sorting_detached_head_first_all() sorting option in
    -    ref-filter.c to revert and amend 28438e84e04 (ref-filter: sort
    -    detached HEAD lines firstly, 2019-06-18).
    +    Change the ref-filter sorting of detached HEAD to check the
    +    FILTER_REFS_DETACHED_HEAD flag, instead of relying on the ref
    +    description filled-in by get_head_description() to start with "(",
    +    which in turn we expect to ASCII-sort before any other reference.
     
    -    In Chinese the fullwidth versions of punctuation like "()" are
    -    typically written as (U+FF08 fullwidth left parenthesis), (U+FF09
    -    fullwidth right parenthesis) instead. This form is used in both
    -    po/zh_{CN,TW}.po in most cases where "()" is translated in a string.
    -
    -    In 28438e84e04 the ability to translate this as part of the "git
    -    branch -l" output was removed because we'd like the detached line to
    -    appear first at the start of "git branch -l", e.g.:
    +    For context, we'd like the detached line to appear first at the start
    +    of "git branch -l", e.g.:
     
             $ git branch -l
             * (HEAD detached at <hash>)
               master
     
    -    Let's instead use the new ref_sorting_detached_head_first_all() in
    -    branch.c to say that we'd like these sorted before other entries.
    +    This doesn't change that, but improves on a fix made in
    +    28438e84e04 (ref-filter: sort detached HEAD lines firstly, 2019-06-18)
    +    and gives the Chinese translation the ability to use its preferred
    +    punctuation marks again.
    +
    +    In Chinese the fullwidth versions of punctuation like "()" are
    +    typically written as (U+FF08 fullwidth left parenthesis), (U+FF09
    +    fullwidth right parenthesis) instead[1]. This form is used in both
    +    po/zh_{CN,TW}.po in most cases where "()" is translated in a string.
    +
    +    Aside from that improvement to the Chinese translation, it also just
    +    makes for cleaner code that we mark any special cases in the ref_array
    +    we're sorting with flags and make the sort function aware of them,
    +    instead of piggy-backing on the general-case of strcmp() doing the
    +    right thing.
     
         As seen in the amended tests this made reverse sorting a bit more
         consistent. Before this we'd sometimes sort this message in the
    -    middle, now it's consistently at the beginning or end. Having it at
    -    the end doesn't make much sense either, but at least it behaves
    -    consistently now. A follow-up commit will make this behavior even
    -    better.
    +    middle, now it's consistently at the beginning or end, depending on
    +    whether we're doing a normal or reverse sort. Having it at the end
    +    doesn't make much sense either, but at least it behaves consistently
    +    now. A follow-up commit will make this behavior under reverse sorting
    +    even better.
     
         I'm removing the "TRANSLATORS" comments that were in the old code
         while I'm at it. Those were added in d4919bb288e (ref-filter: move
    @@ builtin/branch.c
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
      		if (!sorting)
      			sorting = ref_default_sorting();
    - 		ref_sorting_icase_all(sorting, icase);
    -+		ref_sorting_detached_head_first_all(sorting, 1);
    + 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    ++		ref_sorting_set_sort_flags_all(
    ++			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
      		print_ref_list(&filter, sorting, &format);
      		print_columns(&output, colopts, NULL);
      		string_list_clear(&output, 0);
    @@ ref-filter.c: char *get_head_description(void)
      	return strbuf_detach(&desc, NULL);
      }
      
    +@@ ref-filter.c: int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
    + 	return ret;
    + }
    + 
    ++static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
    ++{
    ++	if (!(a->kind ^ b->kind))
    ++		BUG("ref_kind_from_refname() should only mark one ref as HEAD");
    ++	if (a->kind & FILTER_REFS_DETACHED_HEAD)
    ++		return -1;
    ++	else if (b->kind & FILTER_REFS_DETACHED_HEAD)
    ++		return 1;
    ++	BUG("should have died in the xor check above");
    ++	return 0;
    ++}
    ++
    + static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
    + {
    + 	struct atom_value *va, *vb;
    +@@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
    + 	if (get_ref_atom_value(b, s->atom, &vb, &err))
    + 		die("%s", err.buf);
    + 	strbuf_release(&err);
    +-	if (s->sort_flags & REF_SORTING_VERSION) {
    ++	if (s->sort_flags & REF_SORTING_DETACHED_HEAD_FIRST &&
    ++	    ((a->kind | b->kind) & FILTER_REFS_DETACHED_HEAD)) {
    ++		cmp = compare_detached_head(a, b);
    ++	} else if (s->sort_flags & REF_SORTING_VERSION) {
    + 		cmp = versioncmp(va->s, vb->s);
    + 	} else if (cmp_type == FIELD_STR) {
    + 		int (*cmp_fn)(const char *, const char *);
    +
    + ## ref-filter.h ##
    +@@ ref-filter.h: struct ref_sorting {
    + 		REF_SORTING_REVERSE = 1<<0,
    + 		REF_SORTING_ICASE = 1<<1,
    + 		REF_SORTING_VERSION = 1<<2,
    ++		REF_SORTING_DETACHED_HEAD_FIRST = 1<<3,
    + 	} sort_flags;
    + };
    + 
     
      ## t/t3203-branch-output.sh ##
     @@ t/t3203-branch-output.sh: test_expect_success 'git branch `--sort=[-]objectsize` option' '
5:  b14a7b32cbf ! 7:  2497fffebf6 branch: show "HEAD detached" first under reverse sort
    @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array
      	int cmp;
     +	int cmp_detached_head = 0;
      	cmp_type cmp_type = used_atom[s->atom].type;
    - 	int (*cmp_fn)(const char *, const char *);
      	struct strbuf err = STRBUF_INIT;
    + 
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
    - 	     ^
    - 	     (b->kind & FILTER_REFS_DETACHED_HEAD))) {
    + 	if (s->sort_flags & REF_SORTING_DETACHED_HEAD_FIRST &&
    + 	    ((a->kind | b->kind) & FILTER_REFS_DETACHED_HEAD)) {
      		cmp = compare_detached_head(a, b);
     +		cmp_detached_head = 1;
    - 	} else if (s->version)
    + 	} else if (s->sort_flags & REF_SORTING_VERSION) {
      		cmp = versioncmp(va->s, vb->s);
    - 	else if (cmp_type == FIELD_STR)
    + 	} else if (cmp_type == FIELD_STR) {
     @@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
      			cmp = 1;
      	}
      
    --	return (s->reverse) ? -cmp : cmp;
    -+	return (s->reverse && !cmp_detached_head) ? -cmp : cmp;
    +-	return (s->sort_flags & REF_SORTING_REVERSE) ? -cmp : cmp;
    ++	return (s->sort_flags & REF_SORTING_REVERSE && !cmp_detached_head)
    ++		? -cmp : cmp;
      }
      
      static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
-- 
2.29.2.222.g5d2a92d10f8

