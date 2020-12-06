Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27830C4167B
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E414923159
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgLFAZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 19:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgLFAZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 19:25:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B6FC0613CF
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 16:25:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so10301974wmf.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 16:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf+Ga//uzQT6J8kAbQa6iPO6eVQLnDTHkgdcsyMsras=;
        b=oE0Lb60TtVpW7bykFw+PTjwgnOUsKDXxyIgXh/ee7zLxxs/BQQDKWyeHb/1i5ucZZL
         hEP212mF4Oeh7HrUCyjN31ib0KNBHpI9OjraEpduZPQi5VRucuaZ1EaRB+HJyP4YrDlV
         UBSS7TVmSO4Uaemsgh5+vchdeCs5Z1nY5o4SGAgiyq8XDyZJhDIjsukkr7yeCIrI/9Yh
         jpA3sE7WEP0OWF/Q/IZZOMlliAZKE9ySrsGO+RfI4hw1NSUj3+X5sn2nVEjm/0ucSJyL
         RaYf+WVvMHOFePpSsRFJcixyr9pPjkZ+M1MZD1/rRlB2W7sMWJDQX63gDzjNJqcToWZu
         jtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf+Ga//uzQT6J8kAbQa6iPO6eVQLnDTHkgdcsyMsras=;
        b=hcnPOcOkFRKIQvH56RMscd9+oFvdqd22JPZspgnDBOEgvZGuM9bNGmkiLbRlrQA/bn
         yh8NXa12ybddF/LRO9tPW8DSBR9PNLvzen0ceBDaT5rcenHUa2LuO4rn0kub1W5yahfw
         HnAe2HdHGfP2VndSYiEjSZO2Z3Ax4I7hkyghrcFWUg29zJSAuXlR7efN6YEpEFCXt0vm
         7jOWDVMXVmlq1rUqeSX2X+hhYXdSjmXvT1mphkVINR/Pj1utZ+1fzoNzT1NJ53u23RAr
         xN/O1/vMf1tF354wUsntSovk+p53Gdor15GtVvUQVHKXl9sFa+Or/P+ymywV0fEziz6w
         SSPA==
X-Gm-Message-State: AOAM531sTjFoAWOC751VMBcLKsfb8y8sXnOVNAeTySFosE3DIqpRmant
        WcPwwHFsTSmQJA/LZxBRDjJyFGatWo9lIQ==
X-Google-Smtp-Source: ABdhPJwEOr1HBr72gWG1WfdeoNnoa+E4Az0L+QpNpJTD55I1Vs6QsH74MWiRQYoj4VKj37WM+hMlmQ==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr11428572wmc.105.1607214304359;
        Sat, 05 Dec 2020 16:25:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm9144338wrh.78.2020.12.05.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:25:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] pretty format %(trailers): improve machine readability
Date:   Sun,  6 Dec 2020 01:24:44 +0100
Message-Id: <20201206002449.31452-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201205013918.18981-1-avarab@gmail.com>
References: <20201205013918.18981-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per Anders's feedback in [1] this is now a stand-alone series based on
"master". The merge conflict with his series is trivial, both add or
change struct member(s) in trailer.h.

v2 changes:

 * Either incorporate all the feedback from Christian Couder on v1, or
   changed things around to e.g. eliminate the relevant code.

 * Drop the whole "have_options" approach. I saw it conflicted with
   Hariom Verma's cleanup of ref-filter.c in a bad way. I also wasn't
   running the for-each-ref tests in v1 (just interpret-trailers &
   log/pretty). Ran every commit in v2 with the whole test suite (as I
   should have done to begin with, sorry).

 * I'd accidentally left DEVOPTS=no-error on in v1 and didn't notice a
   missing struct member warning. Oops.

 * Lots of my own commit message rewording/cleanup/grammar fixes.

Ævar Arnfjörð Bjarmason (5):
  pretty format %(trailers) test: split a long line
  pretty format %(trailers) doc: avoid repetition
  pretty-format %(trailers): fix broken standalone "valueonly"
  pretty format %(trailers): add a "keyonly"
  pretty format %(trailers): add a "key_value_separator"

 Documentation/pretty-formats.txt | 34 ++++++-----
 pretty.c                         | 10 ++++
 t/t4205-log-pretty-formats.sh    | 99 +++++++++++++++++++++++++++++++-
 trailer.c                        | 15 ++++-
 trailer.h                        |  2 +
 5 files changed, 141 insertions(+), 19 deletions(-)

Range-diff:
1:  51a7a6d8cfe ! 1:  4b134a62aec pretty format %(trailers) test: split a long line
    @@ Commit message
     
         Split a very long line in a test introduced in 0b691d86851 (pretty:
         add support for separator option in %(trailers), 2019-01-28). This
    -    makes it easier to read, and it'll be used as a template in follow-up
    -    commits.
    +    makes it easier to read, especially as follow-up commits will copy
    +    this test as a template.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  2340d856a90 ! 2:  0d3fe6daf6c pretty format %(trailers): avoid needless repetition
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    pretty format %(trailers): avoid needless repetition
    +    pretty format %(trailers) doc: avoid repetition
     
         Change the documentation for the various %(trailers) options so it
         isn't repeating part of the documentation for "only" about how boolean
    -    values are handled. Instead let's split the description of that into
    +    values are handled. Instead, let's split the description of that into
         general documentation at the top.
     
         It then suffices to refer to it by listing the options as
    -    "opt[=bool]". I'm also changing it to "[=bool]" from "[=val]". It took
    -    me a couple of readings to realize that while to realize that these
    -    options were referring back to the "only" option's treatment of
    -    boolean values. Let's try to make this more explicit.
    +    "opt[=<BOOL>]". I'm also changing it to upper-case "[=<BOOL>]" from
    +    "[=val]" for consistency with "<SEP>"
    +
    +    It took me a couple of readings to realize that these options were
    +    referring back to the "only" option's treatment of boolean
    +    values. Let's try to make this more explicit, and upper-case "BOOL"
    +    for consistency with the existing "<SEP>" and "<K>".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/pretty-formats.txt: endif::git-rev-list[]
      			  `trailers` string may be followed by a colon
     -			  and zero or more comma-separated options:
     +			  and zero or more comma-separated options.
    ++			  If any option is provided multiple times the
    ++			  last occurance wins.
     ++
    -+The boolean options accept an optional value. The values `true`,
    -+`false`, `on`, `off` etc. are all accepted. See the "boolean"
    ++The boolean options accept an optional value `[=<BOOL>]`. The values
    ++`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
     +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
    -+option is given with no value it's enabled. If any option is provided
    -+multiple times the last occurance wins.
    ++option is given with no value, it's enabled.
     ++
      ** 'key=<K>': only show trailers with specified key. Matching is done
         case-insensitively and trailing colon is optional. If option is
    @@ Documentation/pretty-formats.txt: endif::git-rev-list[]
     -   `false`, `off`, `no` to show the non-trailer lines. If option is
     -   given without value it is enabled. If given multiple times the last
     -   value is used.
    -+** 'only[=bool]': select whether non-trailer lines from the trailer
    ++** 'only[=BOOL]': select whether non-trailer lines from the trailer
     +   block should be included.
      ** 'separator=<SEP>': specify a separator inserted between trailer
         lines. When this option is not given each trailer line is
    @@ Documentation/pretty-formats.txt: endif::git-rev-list[]
     -** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
     -   option was given. In same way as to for `only` it can be followed
     -   by an equal sign and explicit value. E.g.,
    -+** 'unfold[=bool]': make it behave as if interpret-trailer's `--unfold`
    ++** 'unfold[=BOOL]': make it behave as if interpret-trailer's `--unfold`
     +   option was given. E.g.,
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
     -** 'valueonly[=val]': skip over the key part of the trailer line and only
     -   show the value part. Also this optionally allows explicit value.
    -+** 'valueonly[=bool]': skip over the key part of the trailer line and only
    ++** 'valueonly[=BOOL]': skip over the key part of the trailer line and only
     +   show the value part.
      
      NOTE: Some placeholders may depend on other options given to the
4:  e9ca1e8d88c ! 3:  ea44eeff510 pretty-format %(trailers): fix broken standalone "valueonly"
    @@ Commit message
         pretty-format %(trailers): fix broken standalone "valueonly"
     
         Fix %(trailers:valueonly) being a noop due to on overly eager
    -    optimization. When new trailer options were added they needed to be
    -    listed at the start of the format_trailer_info() function. E.g. as was
    -    done in 250bea0c165 (pretty: allow showing specific trailers,
    -    2019-01-28).
    +    optimization in format_trailer_info() which skips custom formatting if
    +    no custom options are given.
     
    -    When d9b936db522 (pretty: add support for "valueonly" option in
    -    %(trailers), 2019-01-28) was added this was omitted by mistake. Thus
    -    %(trailers:valueonly) was a noop, instead of showing only trailer
    -    value. This wasn't caught because the tests for it always combined it
    -    with other options.
    +    When "valueonly" was added in d9b936db522 (pretty: add support for
    +    "valueonly" option in %(trailers), 2019-01-28) we forgot to add it to
    +    the list of options that optimization checks for. See e.g. the
    +    addition of "key" in 250bea0c165 (pretty: allow showing specific
    +    trailers, 2019-01-28) for a similar change where this wasn't missed.
     
    -    Let's fix the bug, and switch away from this pattern requiring us to
    -    remember to add new flags to the start of the function. Instead as
    -    soon as we see the ":" in "%(trailers:" we skip the fast path. That
    -    over-matches for "%(trailers:)", but I think that's OK.
    +    Thus the "valueonly" option in "%(trailers:valueonly)" was a noop and
    +    the output was equivalent to that of a plain "%(trailers)". This
    +    wasn't caught because the tests for it always combined it with other
    +    options.
     
    -    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Fix the bug by adding !opts->value_only to the list. I initially
    +    attempted to make this more future-proof by setting a flag if we got
    +    to ":" in "%(trailers:" in format_commit_one() in pretty.c. However,
    +    "%(trailers:" is also parsed in trailers_atom_parser() in
    +    ref-filter.c.
     
    - ## pretty.c ##
    -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
    - 		opts.no_divider = 1;
    - 
    - 		if (*arg == ':') {
    -+			/* over-matches on %(trailers:), but that's OK */
    -+			opts.have_options = 1;
    - 			arg++;
    - 			for (;;) {
    - 				const char *argval;
    +    There is an outstanding patch[1] unify those two, and such a fix, or
    +    other future-proofing, such as changing "process_trailer_options"
    +    flags into a bitfield, would conflict with that effort. Let's instead
    +    do the bare minimum here as this aspect of trailers is being actively
    +    worked on by another series.
    +
    +    Let's also test for a plain "valueonly" without any other options, as
    +    well as "separator". All the other existing options on the pretty.c
    +    path had tests where they were the only option provided. I'm also
    +    keeping a sanity test for "%(trailers:)" being the same as
    +    "%(trailers)". There's no reason to suspect it wouldn't be in the
    +    current implementation, but let's keep it in the interest of black box
    +    testing.
    +
    +    1. https://lore.kernel.org/git/pull.726.git.1599335291.gitgitgadget@gmail.com/
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4205-log-pretty-formats.sh ##
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers) shows trailers' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'pretty format %(trailers:) enables no options' '
    ++	git log --no-walk --pretty="%(trailers:)" >actual &&
    ++	# "expect" the same as the test above
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success '%(trailers:only) shows only "key: value" trailers' '
    + 	git log --no-walk --pretty="%(trailers:only)" >actual &&
    + 	{
     @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
      	test_cmp expect actual
      '
    @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:key=foo,valueonly
     +	test_cmp expect actual
     +'
     +
    - test_expect_success '%(trailers:key=foo,keyonly,valueonly) shows nothing' '
    - 	git log --no-walk --pretty="format:%(trailers:key=Acked-by,keyonly,valueonly)" >actual &&
    - 	echo >expect &&
    + test_expect_success 'pretty format %(trailers:separator) changes separator' '
    ++	git log --no-walk --pretty=format:"X%(trailers:separator=%x00)X" >actual &&
    ++	(
    ++		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
    ++		printf "Acked-by: A U Thor <author@example.com>\0" &&
    ++		printf "[ v2 updated patch description ]\0" &&
    ++		printf "Signed-off-by: A U Thor\n  <author@example.com>X"
    ++	) >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separator' '
    + 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
    + 	(
    + 		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
     
      ## trailer.c ##
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
    - 	size_t origlen = out->len;
      	size_t i;
      
    --	/* If we want the whole block untouched, we can take the fast path. */
    + 	/* If we want the whole block untouched, we can take the fast path. */
     -	if (!opts->only_trailers && !opts->unfold && !opts->filter && !opts->separator) {
    -+	if (!opts->have_options) {
    ++	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
    ++	    !opts->separator && !opts->value_only) {
      		strbuf_add(out, info->trailer_start,
      			   info->trailer_end - info->trailer_start);
      		return;
    -
    - ## trailer.h ##
    -@@ trailer.h: struct new_trailer_item {
    - };
    - 
    - struct process_trailer_options {
    -+	int have_options;
    - 	int in_place;
    - 	int trim_empty;
    - 	int only_trailers;
3:  b71a700fa9b ! 4:  4fd193fd90c pretty format %(trailers): add a "keyonly"
    @@ Commit message
         change the ": " delimiter to something easily machine-readable (a key
         might contain ": " too). A follow-up change will add support for that.
     
    +    I don't really have a use-case for just "keyonly" myself. I suppose it
    +    would be useful in some cases as "key=*" matches case-insensitively,
    +    so a plain "keyonly" will give you the variants of the keys you
    +    matched. I'm mainly adding it to fix the inconsistency with
    +    "valueonly".
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/pretty-formats.txt ##
    -@@ Documentation/pretty-formats.txt: multiple times the last occurance wins.
    - ** 'unfold[=bool]': make it behave as if interpret-trailer's `--unfold`
    +@@ Documentation/pretty-formats.txt: option is given with no value, it's enabled.
    + ** 'unfold[=BOOL]': make it behave as if interpret-trailer's `--unfold`
         option was given. E.g.,
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
    --** 'valueonly[=bool]': skip over the key part of the trailer line and only
    +-** 'valueonly[=BOOL]': skip over the key part of the trailer line and only
     -   show the value part.
    -+** 'keyonly[=bool]': only show the key part of the trailer.
    -+** 'valueonly[=bool]': only show the value part of the trailer.
    ++** 'keyonly[=BOOL]': only show the key part of the trailer.
    ++** 'valueonly[=BOOL]': only show the value part of the trailer.
      
      NOTE: Some placeholders may depend on other options given to the
      revision traversal engine. For example, the `%g*` reflog options will
    @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:key) without valu
      	test_cmp expect actual
      '
      
    -+test_expect_success '%(trailers:key=foo,keyonly) shows only keys' '
    ++test_expect_success '%(trailers:keyonly) shows only keys' '
     +	git log --no-walk --pretty="format:%(trailers:keyonly)" >actual &&
     +	test_write_lines \
     +		"Signed-off-by" \
    @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:key) without valu
      test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
      	git log --no-walk --pretty="format:%(trailers:key=Acked-by,valueonly)" >actual &&
      	echo "A U Thor <author@example.com>" >expect &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:valueonly) shows only values' '
      	test_cmp expect actual
      '
      
    @@ t/t4205-log-pretty-formats.sh: test_expect_success '%(trailers:key) without valu
     +'
     +
      test_expect_success 'pretty format %(trailers:separator) changes separator' '
    - 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
    + 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00)X" >actual &&
      	(
    -@@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers:separator) changes separator' '
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
      	test_cmp expect actual
      '
      
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers) co
     
      ## trailer.c ##
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
    + 
    + 	/* If we want the whole block untouched, we can take the fast path. */
    + 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
    +-	    !opts->separator && !opts->value_only) {
    ++	    !opts->separator && !opts->key_only && !opts->value_only) {
    + 		strbuf_add(out, info->trailer_start,
    + 			   info->trailer_end - info->trailer_start);
    + 		return;
    +@@ trailer.c: static void format_trailer_info(struct strbuf *out,
      				if (opts->separator && out->len != origlen)
      					strbuf_addbuf(out, opts->separator);
      				if (!opts->value_only)
     -					strbuf_addf(out, "%s: ", tok.buf);
     -				strbuf_addbuf(out, &val);
    -+					strbuf_addstr(out, tok.buf);
    ++					strbuf_addbuf(out, &tok);
     +				if (!opts->key_only && !opts->value_only)
     +					strbuf_addstr(out, ": ");
     +				if (!opts->key_only)
    @@ trailer.h: struct process_trailer_options {
      	int no_divider;
     +	int key_only;
      	int value_only;
    - 	int canonicalize;
      	const struct strbuf *separator;
    -+	const struct strbuf *key_value_separator;
    - 	int (*filter)(const struct strbuf *, const char *alias, void *);
    - 	void *filter_data;
    - };
    + 	int (*filter)(const struct strbuf *, void *);
5:  cd4b3b52cf3 ! 5:  6cc6fc79388 pretty format %(trailers): add a "key_value_separator"
    @@ Metadata
      ## Commit message ##
         pretty format %(trailers): add a "key_value_separator"
     
    -    As noted in a previous commit which added "keyonly" it's needlessly
    -    hard to use the "log" machinery to produce machine-readable output for
    -    %(trailers). with the combination of the existing "separator" and this
    -    new "key_value_separator" this becomes trivial, as seen by the test
    -    being added here.
    +    Add a "key_value_separator" option to the "%(trailers)" pretty format,
    +    to go along with the existing "separator" argument. In combination
    +    these two options make it trivial to produce machine-readable (e.g. \0
    +    and \0\0-delimited) format output.
    +
    +    As elaborated on in a previous commit which added "keyonly" it was
    +    needlessly tedious to extract structured data from "%(trailers)"
    +    before the addition of this "key_value_separator" option. As seen by
    +    the test being added here extracting this data now becomes trivial.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/pretty-formats.txt ##
    -@@ Documentation/pretty-formats.txt: multiple times the last occurance wins.
    +@@ Documentation/pretty-formats.txt: option is given with no value, it's enabled.
         `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
    - ** 'keyonly[=bool]': only show the key part of the trailer.
    - ** 'valueonly[=bool]': only show the value part of the trailer.
    + ** 'keyonly[=BOOL]': only show the key part of the trailer.
    + ** 'valueonly[=BOOL]': only show the value part of the trailer.
     +** 'key_value_separator=<SEP>': specify a separator inserted between
     +   trailer lines. When this option is not given each trailer key-value
    -+   pair separated by ": ". Otherwise it shares the same semantics as 
    -+   'separator=<SEP>' above.
    ++   pair is separated by ": ". Otherwise it shares the same semantics
    ++   as 'separator=<SEP>' above.
      
      NOTE: Some placeholders may depend on other options given to the
      revision traversal engine. For example, the `%g*` reflog options will
    @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
      					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
     
      ## t/t4205-log-pretty-formats.sh ##
    -@@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers:separator) changes separator' '
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers:separator=X,unfold) changes separa
      	test_cmp expect actual
      '
      
     +test_expect_success 'pretty format %(trailers:key_value_separator) changes key-value separator' '
    ++	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00)X" >actual &&
    ++	(
    ++		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
    ++		printf "Acked-by\0A U Thor <author@example.com>\n" &&
    ++		printf "[ v2 updated patch description ]\n" &&
    ++		printf "Signed-off-by\0A U Thor\n  <author@example.com>\nX"
    ++	) >expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'pretty format %(trailers:key_value_separator,unfold) changes key-value separator' '
     +	git log --no-walk --pretty=format:"X%(trailers:key_value_separator=%x00,unfold)X" >actual &&
     +	(
     +		printf "XSigned-off-by\0A U Thor <author@example.com>\n" &&
    @@ t/t4205-log-pretty-formats.sh: test_expect_success 'pretty format %(trailers:sep
     
      ## trailer.c ##
     @@ trailer.c: static void format_trailer_info(struct strbuf *out,
    + 
    + 	/* If we want the whole block untouched, we can take the fast path. */
    + 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
    +-	    !opts->separator && !opts->key_only && !opts->value_only) {
    ++	    !opts->separator && !opts->key_only && !opts->value_only &&
    ++	    !opts->key_value_separator) {
    + 		strbuf_add(out, info->trailer_start,
    + 			   info->trailer_end - info->trailer_start);
    + 		return;
    +@@ trailer.c: static void format_trailer_info(struct strbuf *out,
      					strbuf_addbuf(out, opts->separator);
      				if (!opts->value_only)
    - 					strbuf_addstr(out, tok.buf);
    + 					strbuf_addbuf(out, &tok);
     -				if (!opts->key_only && !opts->value_only)
     -					strbuf_addstr(out, ": ");
     +				if (!opts->key_only && !opts->value_only) {
    @@ trailer.c: static void format_trailer_info(struct strbuf *out,
      				if (!opts->key_only)
      					strbuf_addbuf(out, &val);
      				if (!opts->separator)
    +
    + ## trailer.h ##
    +@@ trailer.h: struct process_trailer_options {
    + 	int key_only;
    + 	int value_only;
    + 	const struct strbuf *separator;
    ++	const struct strbuf *key_value_separator;
    + 	int (*filter)(const struct strbuf *, void *);
    + 	void *filter_data;
    + };
-- 
2.29.2.222.g5d2a92d10f8

