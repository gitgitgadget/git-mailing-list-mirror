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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BCC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50E964E06
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhA2VJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhA2VJr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 16:09:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ACFC06174A
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so10150463wre.13
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5yt2c8YeyvuWguck1G8TV25WZCQgAFR89M68euB3PvQ=;
        b=mr4dWpvprkaebLvIps9oqegZEkiBcnM1NK1qcnZ69V/zJ4OrZ85Ik6OTkQN/P/a8ba
         MduwxRlzhWrozVQrNowlBR4teMUPabxDiS7+bpKjjLb3b9uGJ3mrghc/hwB+eSOPyDkO
         NnI2xV+4r5/jaCVxaf8wgh77Rznpz0bRKZTECqqGIc1mhN78eabVGVqxIJEgkFOFl6Vz
         8GsZQc+mpZFDvd762u0ZlTuEOD7BZmfH1JGhcwo8eCb3lPRVleFOLH3M1wna4C7lA5qm
         0D53Ky9QWqR08HQFNkvfa0ABzTwCjIfwx/9SFqqgdW7vUZRVogyB7COmEXLE8Ex/mXZJ
         teUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5yt2c8YeyvuWguck1G8TV25WZCQgAFR89M68euB3PvQ=;
        b=DEzIxbFfraRylBzifgzoqcBvshfHSFO/EYtSQMNdDhb6jDQybtLmueVUUKcW/fLB2d
         KrM/Wf/u8eNNyXoorq130viDmrXbraN6Ha6eiUmZRzpm866wcz6dgwF34INPa5VFsB4g
         brED1/ePEK2FsRzVXHPu6PSr1phJDWNxN5XVMyZKI9IsQzWc+RWkCXGMv0UgwkLDSIAz
         n0FRKHd+tNC7Kc8JDHkb/PokQEVHIz3zYY/DT3Xg5FhCaMgR8eF4vsIKCLfzKwTGsv/k
         Ztnp6Gfv4RKwpLsHYSPyO7ckI1DQ2cLejFLcFqMvwb84A90/+N7A9utiXwCqlv8M0M2z
         BoOQ==
X-Gm-Message-State: AOAM5332crHAYP0SmVlLJEInduhL3Pykoatq9to7F1MIUGpX8EEhb0Cg
        BJJXEZqMC7uiMQrHqeivvR1fTmUcqSI=
X-Google-Smtp-Source: ABdhPJx+H92Le+pnSAO1TPyccyMRBwc9SZ9k5VR5mcfURZDA3+gI+FQ1D8fwaErxdPgFizkzzSg7ng==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr6705873wra.161.1611954545342;
        Fri, 29 Jan 2021 13:09:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm11584469wmk.20.2021.01.29.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:09:04 -0800 (PST)
Message-Id: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.1599335291.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 21:09:00 +0000
Subject: [PATCH v2 0/3] Unify trailers formatting logic for pretty.c and ref-filter.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a separate logic for %(trailers) in "pretty.{c,h}"
and "ref-filter.{c,h}". Both are actually doing the same thing, why not use
the same code for both of them?

This is the 2nd version of the patch series that I sent few months back. It
is focused on unifying the "%(trailers)" logic for both 'pretty.{c,h}' and
'ref-filter.{c,h}'. So, we can have one logic for trailers.

v2 changes:

 * Contains Improvements as suggested by "René Scharfe" l.s.r@web.de 1
   [https://public-inbox.org/git/bf4423d5-c0ee-6bef-59ff-fcde003ec463@web.de/]
 * A new trailer option was introduced to pretty.c when I was absent i.e
   "key_value_separator". Updated the patch series with latest changes.

Sorry for taking a long break.

Link to previous version:
https://public-inbox.org/git/pull.726.git.1599335291.gitgitgadget@gmail.com/

Hariom Verma (3):
  pretty.c: refactor trailer logic to `format_set_trailers_options()`
  pretty.c: capture invalid trailer argument
  ref-filter: use pretty.c logic for trailers

 Documentation/git-for-each-ref.txt |  39 ++++++++--
 pretty.c                           |  95 +++++++++++++----------
 pretty.h                           |  12 +++
 ref-filter.c                       |  36 +++++----
 t/t6300-for-each-ref.sh            | 119 +++++++++++++++++++++++++----
 5 files changed, 228 insertions(+), 73 deletions(-)


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-726%2Fharry-hov%2Funify-trailers-logic-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-726/harry-hov/unify-trailers-logic-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/726

Range-diff vs v1:

 1:  4180f54c1de ! 1:  fc5fd5217df pretty.c: refactor trailer logic to `format_set_trailers_options()`
     @@ Commit message
          pretty.c: refactor trailer logic to `format_set_trailers_options()`
      
          Refactored trailers formatting logic inside pretty.c to a new function
     -    `format_set_trailers_options()`.
     -
     -    Also, introduced a code to get invalid trailer arguments. As we would
     -    like to use same logic in ref-filter, it's nice to get invalid trailer
     -    argument. This will allow us to print accurate error message, while
     -    using `format_set_trailers_options()` in ref-filter.
     +    `format_set_trailers_options()`. This change will allow us to reuse
     +    the same logic in other places.
      
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
      
     - ## Hariom Verma via GitGitGadget (new) ##
     -
       ## pretty.c ##
      @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
       	return 0;
     @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
      +int format_set_trailers_options(struct process_trailer_options *opts,
      +				struct string_list *filter_list,
      +				struct strbuf *sepbuf,
     -+				const char **arg,
     -+				const char **err)
     ++				struct strbuf *kvsepbuf,
     ++				const char **arg)
      +{
      +	for (;;) {
      +		const char *argval;
      +		size_t arglen;
      +
     -+		if (**arg != ')') {
     -+			size_t vallen = strcspn(*arg, "=,)");
     -+			const char *valstart = xstrndup(*arg, vallen);
     -+			if (strcmp(valstart, "key") &&
     -+				strcmp(valstart, "separator") &&
     -+				strcmp(valstart, "only") &&
     -+				strcmp(valstart, "valueonly") &&
     -+				strcmp(valstart, "unfold")) {
     -+					*err = xstrdup(valstart);
     -+					return 1;
     -+				}
     -+			free((char *)valstart);
     -+		}
      +		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
      +			uintptr_t len = arglen;
      +
     @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
      +			opts->filter_data = filter_list;
      +			opts->only_trailers = 1;
      +		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
     -+			char *fmt = xstrndup(argval, arglen);
     ++			char *fmt;
     ++			fmt = xstrndup(argval, arglen);
      +			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
      +			free(fmt);
      +			opts->separator = sepbuf;
     ++		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
     ++			char *fmt;
     ++			fmt = xstrndup(argval, arglen);
     ++			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
     ++			free(fmt);
     ++			opts->key_value_separator = kvsepbuf;
      +		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
     -+				!match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
     -+				!match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
     ++			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
     ++			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
     ++			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
      +			break;
      +	}
      +	return 0;
     @@ pretty.c: static int format_trailer_match_cb(const struct strbuf *key, void *ud)
       				const char *placeholder,
       				void *context)
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 		struct string_list filter_list = STRING_LIST_INIT_NODUP;
     - 		struct strbuf sepbuf = STRBUF_INIT;
     - 		size_t ret = 0;
     -+		const char *unused = NULL;
     - 
     - 		opts.no_divider = 1;
       
       		if (*arg == ':') {
       			arg++;
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
      -					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
      -					free(fmt);
      -					opts.separator = &sepbuf;
     +-				} else if (match_placeholder_arg_value(arg, "key_value_separator", &arg, &argval, &arglen)) {
     +-					char *fmt;
     +-
     +-					strbuf_reset(&kvsepbuf);
     +-					fmt = xstrndup(argval, arglen);
     +-					strbuf_expand(&kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
     +-					free(fmt);
     +-					opts.key_value_separator = &kvsepbuf;
      -				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
      -					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
     +-					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
      -					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
      -					break;
      -			}
     -+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &arg, &unused))
     ++			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
      +				goto trailer_out;
       		}
       		if (*arg == ')') {
       			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
     -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 	trailer_out:
     - 		string_list_clear(&filter_list, 0);
     - 		strbuf_release(&sepbuf);
     -+		free((char *)unused);
     - 		return ret;
     - 	}
     - 
      
       ## pretty.h ##
      @@
     @@ pretty.h
       
       /* Commit formats */
       enum cmit_fmt {
     -@@ pretty.h: const char *format_subject(struct strbuf *sb, const char *msg,
     - /* Check if "cmit_fmt" will produce an empty output. */
     - int commit_format_is_empty(enum cmit_fmt);
     +@@ pretty.h: int commit_format_is_empty(enum cmit_fmt);
     + /* Make subject of commit message suitable for filename */
     + void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
       
      +/*
      + * Set values of fields in "struct process_trailer_options"
      + * according to trailers arguments.
      + */
      +int format_set_trailers_options(struct process_trailer_options *opts,
     -+				struct string_list *filter_list,
     -+				struct strbuf *sepbuf,
     -+				const char **arg,
     -+				const char **err);
     ++			struct string_list *filter_list,
     ++			struct strbuf *sepbuf,
     ++			struct strbuf *kvsepbuf,
     ++			const char **arg);
      +
       #endif /* PRETTY_H */
 -:  ----------- > 2:  245e48eb683 pretty.c: capture invalid trailer argument
 2:  a3e16298262 ! 3:  7b8cfb2721c ref-filter: using pretty.c logic for trailers
     @@ Metadata
      Author: Hariom Verma <hariom18599@gmail.com>
      
       ## Commit message ##
     -    ref-filter: using pretty.c logic for trailers
     +    ref-filter: use pretty.c logic for trailers
      
          Now, ref-filter is using pretty.c logic for setting trailer options.
      
          New to ref-filter:
            :key=<K> - only show trailers with specified key.
            :valueonly[=val] - only show the value part.
     -      :separator=<SEP> - inserted between trailer lines
     +      :separator=<SEP> - inserted between trailer lines.
     +      :key_value_separator=<SEP> - inserted between trailer lines
      
          Enhancement to existing options(now can take value and its optional):
            :only[=val]
     @@ Documentation/git-for-each-ref.txt: contents:lines=N::
      +** 'separator=<SEP>': specify a separator inserted between trailer
      +   lines. When this option is not given each trailer line is
      +   terminated with a line feed character. The string SEP may contain
     -+   the literal formatting codes described above. To use comma as
     -+   separator one must use `%x2C` as it would otherwise be parsed as
     -+   next option. If separator option is given multiple times only the
     -+   last one is used. E.g., `%(trailers:key=Ticket,separator=%x2C )`
     -+   shows all trailer lines whose key is "Ticket" separated by a comma
     -+   and a space.
     ++   the literal formatting codes. To use comma as separator one must use
     ++   `%x2C` as it would otherwise be parsed as next option. If separator
     ++   option is given multiple times only the last one is used.
     ++   E.g., `%(trailers:key=Ticket,separator=%x2C)` shows all trailer lines
     ++   whose key is "Ticket" separated by a comma.
     ++** 'key_value_separator=<SEP>': specify a separator inserted between
     ++   key and value. The string SEP may contain the literal formatting codes.
     ++   E.g., `%(trailers:key=Ticket,key_value_separator=%x2C)` shows all trailer
     ++   lines whose key is "Ticket" with key and value separated by a comma.
      +** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
      +   option was given. In same way as to for `only` it can be followed
      +   by an equal sign and explicit value. E.g.,
     @@ ref-filter.c: struct refname_atom {
      +struct ref_trailer_buf {
      +	struct string_list filter_list;
      +	struct strbuf sepbuf;
     ++	struct strbuf kvsepbuf;
      +} ref_trailer_buf;
      +
       static struct expand_data {
     @@ ref-filter.c: static int subject_atom_parser(const struct ref_format *format, st
      -	int i;
      -
       	atom->u.contents.trailer_opts.no_divider = 1;
     --
     + 
       	if (arg) {
      -		string_list_split(&params, arg, ',', -1);
      -		for (i = 0; i < params.nr; i++) {
     @@ ref-filter.c: static int subject_atom_parser(const struct ref_format *format, st
      -				return -1;
      -			}
      +		const char *argbuf = xstrfmt("%s)", arg);
     -+		const char *err_arg = NULL;
     ++		char *invalid_arg = NULL;
      +
      +		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
      +			&ref_trailer_buf.filter_list,
      +			&ref_trailer_buf.sepbuf,
     -+			&argbuf, &err_arg)) {
     -+			if (!err_arg)
     ++			&ref_trailer_buf.kvsepbuf,
     ++			&argbuf, &invalid_arg)) {
     ++			if (!invalid_arg)
      +				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
      +			else
     -+				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), err_arg);
     -+			free((char *)err_arg);
     ++				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), invalid_arg);
     ++			free((char *)invalid_arg);
      +			return -1;
       		}
       	}
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:unfold) unfolds trailer
      +			grep -v patch.description <trailers &&
      +			echo
      +		} >expect &&
     -+		git for-each-ref --format="%($option)" refs/heads/master >actual &&
     ++		git for-each-ref --format="%($option)" refs/heads/main >actual &&
      +		test_cmp expect actual &&
     -+		git for-each-ref --format="%(contents:$option)" refs/heads/master >actual &&
     ++		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
      +		test_cmp expect actual
      +	'
      +}
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:unfold) unfolds trailer
      +		cat trailers &&
       		echo
       	} >expect &&
     --	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
     -+	git for-each-ref --format="%(trailers:only=no)" refs/heads/master >actual &&
     +-	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
     ++	git for-each-ref --format="%(trailers:only=no)" refs/heads/main >actual &&
       	test_cmp expect actual &&
     --	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
     -+	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/master >actual &&
     +-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
     ++	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/main >actual &&
       	test_cmp expect actual
       '
       
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +	expect="$3"
      +	test_expect_success "$title" '
      +		echo $expect >expect &&
     -+		git for-each-ref --format="%($option)" refs/heads/master >actual &&
     ++		git for-each-ref --format="%($option)" refs/heads/main >actual &&
      +		test_cmp expect actual &&
     -+		git for-each-ref --format="%(contents:$option)" refs/heads/master >actual &&
     ++		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
      +		test_cmp expect actual
      +	'
      +}
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +		grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by &&
      +		echo
      +	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/main >actual &&
      +	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/main >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +		unfold <trailers | grep Signed-off-by &&
      +		echo
      +	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
      +	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
      +	test_cmp expect actual
       '
       
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +		grep patch.description <trailers &&
      +		echo
      +	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
      +	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/master >actual &&
     ++	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
      +test_trailer_option '%(trailers:separator) changes separator' \
      +	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'
     ++test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
     ++	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>\nSigned-off-by,A U Thor <author@example.com>\n'
     ++test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
     ++	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>'
      +
      +test_failing_trailer_option () {
      +	title="$1"
     @@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:un
      +	test_expect_success "$title" '
      +		# error message cannot be checked under i18n
      +		echo $error >expect &&
     -+		test_must_fail git for-each-ref --format="%($option)" refs/heads/master 2>actual &&
     ++		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
      +		test_i18ncmp expect actual &&
     -+		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/master 2>actual &&
     ++		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
      +		test_i18ncmp expect actual
      +	'
      +}

-- 
gitgitgadget
