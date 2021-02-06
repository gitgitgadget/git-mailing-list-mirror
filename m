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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89DC433E9
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8464FAD
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBFJQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 04:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBFJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 04:16:29 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC77C06174A
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 01:15:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a16so9153022wmm.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 01:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hcm6pMtGd7GCsInrHL8Kyl2B94Dq9YhpOTThjsSrE9E=;
        b=SFr+/aMZAqb8kScu1v1VlLhqMP3xvRpLc/HHaqoZaCUjR3qIGkz5+s0dO2ok4ApPOW
         lHwS/yeP3hSE0utM107OSxX4PLpxTErsqGf0jiXIQ6nRElyV2n5Oy7tfTiv4xHIKDlpa
         KbKdtO1Jaf/gQeD2Csj7iOyuugXOrJ4ZOHxaVKSL9F3+ChctqeX1mUwdbU1D158U1pPF
         mmp++oPREfyHjuC6NxvnLLogyQzWZZsnPuGhh42j2OIinSXzYivAshj0y8t3EEJ0cRDR
         Z4+6oAaZwS3kc/ucL3NSq5OX6QjsKBk3FmR7OIYAnLhVHG2e73AybQ1YzsUJ29iv9PCN
         17rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hcm6pMtGd7GCsInrHL8Kyl2B94Dq9YhpOTThjsSrE9E=;
        b=othL7a1u1y7giMFotwO/KGurpgG68dz0JOl/550LvWM3QUfBlD7FsMZmNWPDXu+llr
         BrstNmUC8dCsszEP3J5zZqsP8oyZvzQxMI1XvTqsARPxSxguoa1fFv0xff2VSQFHO1eo
         5Lj9ilRVDf/LD8iUgBP6sFdlmh09af8zkvy/MT4taquMS4ZvzrU/P0WUiI7VJNo4o2Uq
         9jZoMBoWMTm30ZpAs3znuSg0DH+I1cXLZ4SN4OoycfeLZq2ZgvRXht8ShEh3XGCdbtgR
         m8UMqYtsW5b40CTmMcXf+14YY76+3uuOqnHlHYDNed/DvikpXzBP1WT2az11ozLSvxho
         flyw==
X-Gm-Message-State: AOAM531CKL1anNLzZhiS0OobsQwmJZNw6qJDeYa5nbsyuKAZj8hpqElh
        MMPsALOupXsK+Mb1oHYNST+aZkLNgzs=
X-Google-Smtp-Source: ABdhPJyaBlHrJl5v3dVeZVeAwUj2q632TFyZiX8VvfUD27z5ubC1K/XhbmCgzpAfox+TnAoXGMNyEw==
X-Received: by 2002:a1c:7d41:: with SMTP id y62mr6694479wmc.139.1612602947118;
        Sat, 06 Feb 2021 01:15:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z185sm11864440wmb.0.2021.02.06.01.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 01:15:46 -0800 (PST)
Message-Id: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 09:15:41 +0000
Subject: [PATCH v3 0/3] Unify trailers formatting logic for pretty.c and ref-filter.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a separate logic for %(trailers) in "pretty.{c,h}"
and "ref-filter.{c,h}". Both are actually doing the same thing, why not use
the same code for both of them?

This is the 3rd version of the patch series. It is focused on unifying the
"%(trailers)" logic for both 'pretty.{c,h}' and 'ref-filter.{c,h}'. So, we
can have one logic for trailers.

v3 changes:

 * replaced echo with printf in the tests failing in previous version for
   consistent behaviour.
 * strbuf_reset() is back in format_set_trailers_options().
 * made struct ref_trailer_buf static.
 * initialised structure variable ref_trailer_buf . so we may not encounter
   any problem while doing strbuf_reset().
 * refer to the trailers part of "git-log"'s man page in
   "git-for-each-ref"'s man page.
 * improved commit messages.

/* TODO */

As suggested by Ævar Arnfjörð Bjarmason avarab@gmail.com here
[https://public-inbox.org/git/875z3ep30j.fsf@evledraar.gmail.com/], I plan
to unify the trailers related tests for "git log" and "git for-each-ref" in
new file. Maybe on top of this patch series?

Hariom Verma (3):
  pretty.c: refactor trailer logic to `format_set_trailers_options()`
  pretty.c: capture invalid trailer argument
  ref-filter: use pretty.c logic for trailers

 Documentation/git-for-each-ref.txt |   8 +-
 pretty.c                           |  98 ++++++++++++++----------
 pretty.h                           |  12 +++
 ref-filter.c                       |  36 +++++----
 t/t6300-for-each-ref.sh            | 119 +++++++++++++++++++++++++----
 5 files changed, 200 insertions(+), 73 deletions(-)


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-726%2Fharry-hov%2Funify-trailers-logic-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-726/harry-hov/unify-trailers-logic-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/726

Range-diff vs v2:

 1:  fc5fd5217dfc ! 1:  81030f00b11b pretty.c: refactor trailer logic to `format_set_trailers_options()`
     @@ Commit message
          pretty.c: refactor trailer logic to `format_set_trailers_options()`
      
          Refactored trailers formatting logic inside pretty.c to a new function
     -    `format_set_trailers_options()`. This change will allow us to reuse
     -    the same logic in other places.
     +    `format_set_trailers_options()`. This new function returns the non-zero
     +    in case of unusual. The caller handles the non-zero by "goto trailers_out".
     +
     +    This change will allow us to reuse the same logic in other places.
      
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
     @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
      +			uintptr_t len = arglen;
      +
      +			if (!argval)
     -+				return 1;
     ++				return -1;
      +
      +			if (len && argval[len - 1] == ':')
      +				len--;
     @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
      +			opts->only_trailers = 1;
      +		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
      +			char *fmt;
     ++
     ++			strbuf_reset(sepbuf);
      +			fmt = xstrndup(argval, arglen);
      +			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
      +			free(fmt);
      +			opts->separator = sepbuf;
      +		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
      +			char *fmt;
     ++
     ++			strbuf_reset(kvsepbuf);
      +			fmt = xstrndup(argval, arglen);
      +			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
      +			free(fmt);
 2:  245e48eb6835 ! 2:  f4a6b2df1444 pretty.c: capture invalid trailer argument
     @@ Metadata
       ## Commit message ##
          pretty.c: capture invalid trailer argument
      
     -    As we would like to use this same logic in ref-filter, it's nice to
     -    get invalid trailer argument. This will allow us to print precise
     -    error message, while using `format_set_trailers_options()` in
     +    As we would like to use this trailers logic in the ref-filter, it's
     +    nice to get an invalid trailer argument. This will allow us to print
     +    precise error message while using `format_set_trailers_options()` in
          ref-filter.
      
     +    For capturing the invalid argument, we changed the working of
     +    `format_set_trailers_options()` a little bit.
     +    Original logic does "break" and fell through in mainly 2 cases -
     +        1. unknown/invalid argument
     +        2. end of the arg string
     +
     +    But now instead of "break", we capture invalid argument and return
     +    non-zero. And non-zero is handled by the caller.
     +    (We prepared the caller to handle non-zero in the previous commit).
     +
     +    Capturing invalid arguments this way will also affects the working
     +    of current logic. As at the end of the arg string it will return non-zero.
     +    So in order to make things correct, introduced an additional conditional
     +    statement i.e if encounter ")", do 'break'.
     +
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
     @@ pretty.c: int format_set_trailers_options(struct process_trailer_options *opts,
       		const char *argval;
       		size_t arglen;
       
     -+		if(**arg == ')') {
     ++		if (**arg == ')')
      +			break;
     -+		}
      +
       		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
       			uintptr_t len = arglen;
     @@ pretty.c: int format_set_trailers_options(struct process_trailer_options *opts,
      -			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
      -			break;
      +			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only)) {
     -+			size_t invalid_arg_len = strcspn(*arg, ",)");
     -+			*invalid_arg = xstrndup(*arg, invalid_arg_len);
     -+			return 1;
     ++			if (invalid_arg) {
     ++				size_t len = strcspn(*arg, ",)");
     ++				*invalid_arg = xstrndup(*arg, len);
     ++			}
     ++			return -1;
      +		}
       	}
       	return 0;
       }
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 		struct strbuf sepbuf = STRBUF_INIT;
     - 		struct strbuf kvsepbuf = STRBUF_INIT;
     - 		size_t ret = 0;
     -+		char *unused = NULL;
     - 
     - 		opts.no_divider = 1;
       
       		if (*arg == ':') {
       			arg++;
      -			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
     -+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, &unused))
     ++			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, NULL))
       				goto trailer_out;
       		}
       		if (*arg == ')') {
     -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 	trailer_out:
     - 		string_list_clear(&filter_list, 0);
     - 		strbuf_release(&sepbuf);
     -+		free((char *)unused);
     - 		return ret;
     - 	}
     - 
      
       ## pretty.h ##
      @@ pretty.h: int format_set_trailers_options(struct process_trailer_options *opts,
 3:  7b8cfb2721c3 ! 3:  47d89f872314 ref-filter: use pretty.c logic for trailers
     @@ Commit message
            :key=<K> - only show trailers with specified key.
            :valueonly[=val] - only show the value part.
            :separator=<SEP> - inserted between trailer lines.
     -      :key_value_separator=<SEP> - inserted between trailer lines
     +      :key_value_separator=<SEP> - inserted between key and value in trailer lines
      
          Enhancement to existing options(now can take value and its optional):
            :only[=val]
     @@ Documentation/git-for-each-ref.txt: contents:lines=N::
      -that each trailer appears on a line by itself with its full content with
      -`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
      +are obtained as `trailers[:options]` (or by using the historical alias
     -+`contents:trailers[:options]`). Valid [:option] are:
     -+** 'key=<K>': only show trailers with specified key. Matching is done
     -+   case-insensitively and trailing colon is optional. If option is
     -+   given multiple times trailer lines matching any of the keys are
     -+   shown. This option automatically enables the `only` option so that
     -+   non-trailer lines in the trailer block are hidden. If that is not
     -+   desired it can be disabled with `only=false`.  E.g.,
     -+   `%(trailers:key=Reviewed-by)` shows trailer lines with key
     -+   `Reviewed-by`.
     -+** 'only[=val]': select whether non-trailer lines from the trailer
     -+   block should be included. The `only` keyword may optionally be
     -+   followed by an equal sign and one of `true`, `on`, `yes` to omit or
     -+   `false`, `off`, `no` to show the non-trailer lines. If option is
     -+   given without value it is enabled. If given multiple times the last
     -+   value is used.
     -+** 'separator=<SEP>': specify a separator inserted between trailer
     -+   lines. When this option is not given each trailer line is
     -+   terminated with a line feed character. The string SEP may contain
     -+   the literal formatting codes. To use comma as separator one must use
     -+   `%x2C` as it would otherwise be parsed as next option. If separator
     -+   option is given multiple times only the last one is used.
     -+   E.g., `%(trailers:key=Ticket,separator=%x2C)` shows all trailer lines
     -+   whose key is "Ticket" separated by a comma.
     -+** 'key_value_separator=<SEP>': specify a separator inserted between
     -+   key and value. The string SEP may contain the literal formatting codes.
     -+   E.g., `%(trailers:key=Ticket,key_value_separator=%x2C)` shows all trailer
     -+   lines whose key is "Ticket" with key and value separated by a comma.
     -+** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
     -+   option was given. In same way as to for `only` it can be followed
     -+   by an equal sign and explicit value. E.g.,
     -+   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
     -+** 'valueonly[=val]': skip over the key part of the trailer line and only
     -+   show the value part. Also this optionally allows explicit value.
     ++`contents:trailers[:options]`). For valid [:option] values see `trailers`
     ++section of linkgit:git-log[1].
       
       For sorting purposes, fields with numeric values sort in numeric order
       (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
     @@ ref-filter.c: struct refname_atom {
       	int lstrip, rstrip;
       };
       
     -+struct ref_trailer_buf {
     ++static struct ref_trailer_buf {
      +	struct string_list filter_list;
      +	struct strbuf sepbuf;
      +	struct strbuf kvsepbuf;
     -+} ref_trailer_buf;
     ++} ref_trailer_buf = {STRING_LIST_INIT_NODUP, STRBUF_INIT, STRBUF_INIT};
      +
       static struct expand_data {
       	struct object_id oid;
     @@ ref-filter.c: static int subject_atom_parser(const struct ref_format *format, st
      +		char *invalid_arg = NULL;
      +
      +		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
     -+			&ref_trailer_buf.filter_list,
     -+			&ref_trailer_buf.sepbuf,
     -+			&ref_trailer_buf.kvsepbuf,
     -+			&argbuf, &invalid_arg)) {
     ++		    &ref_trailer_buf.filter_list,
     ++		    &ref_trailer_buf.sepbuf,
     ++		    &ref_trailer_buf.kvsepbuf,
     ++		    &argbuf, &invalid_arg)) {
      +			if (!invalid_arg)
      +				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
      +			else
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +	option="$2"
      +	expect="$3"
      +	test_expect_success "$title" '
     -+		echo $expect >expect &&
     ++		printf "$expect\n" >expect &&
      +		git for-each-ref --format="%($option)" refs/heads/main >actual &&
      +		test_cmp expect actual &&
      +		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&

-- 
gitgitgadget
