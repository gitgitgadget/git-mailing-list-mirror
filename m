Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81395C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2621C64DFA
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 20:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhA3Uqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 15:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhA3Uqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 15:46:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3902AC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 12:45:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a10so18219398ejg.10
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 12:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=PQAz9QYkGQgcoxxBVXP2b2gWOegq2uRAt+M76gG+JxM=;
        b=FmkiZnyMGc04v5Zo65lCbKNbs9/cDwZLoSXIijgUlg/1LzoTB82OXVtejLLhA/vh5Q
         84utnYW5tfbzpqG4VYKpXUS9WgrZGYF8KgQYezpAVR5b7e6BvNsPH3vU+vY27JIisoPL
         vNBdEUtXPmzcHStD5UxXilYjuUZ8NzYxgpGwkmMctzOzEkr2RbL7KhjXWp20T3S53/7p
         uzsrU/asMQFtX7tWs977wWHREZjr6hpg8hIUSn4kGSWhjCCsp8dMS9lgZ/4bS82kGIwn
         W7HEbPNX7xlk9uPHn91qBKIhRjFxy4usmz5ArWJDXHgY4h18OgscQloLhu2yFglJ6FLA
         x6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=PQAz9QYkGQgcoxxBVXP2b2gWOegq2uRAt+M76gG+JxM=;
        b=EcpSdmAfYP0tScGMHQwDZtiQIhwkFmL/Oi9y6jT3cSb4TZ0q0KCXT4Z8FiS0tFLunQ
         J9GXWbZ7qUwJz485sht1zk+Qz5Qq1UdZevOHqhGMMLBMbM/fq5iNXH3AeJ1O16q7X2G0
         8RQMX/05QqGAo8W3ijRshP3xEeQM2v26vZo0OoKoYSsEXH7U0wmOYxsdEp79+z0yv7FV
         3v9w14b4A2h3yl+vIekSQBIvJAjt16BPispdE+lx9FbC/HvapiyfOvWWhkuAqM8xO6JJ
         RSpzjeDOs1nvutpXLFZ+KagXmu59yKKJGjxBsxYjII0iwy+QeRPRiwyLDwMYjJssA44w
         wJsg==
X-Gm-Message-State: AOAM533SZE9jtUSQaDXepDKg+IiAdnm+4sFeq/9sgT/J9HL277aH5yuD
        v6MP4OZTqxxACbQIyxeRKgSFOqrIgKAFNw==
X-Google-Smtp-Source: ABdhPJzVYPYJJ9pRpX8Bl9E961ZaY4f73Gmo1/71GtlL6Px43NNom+JG6Bwh5/UDpIm8AAK+WZSgZg==
X-Received: by 2002:a17:906:1308:: with SMTP id w8mr10373057ejb.396.1612039549625;
        Sat, 30 Jan 2021 12:45:49 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ce7sm5627868ejb.100.2021.01.30.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 12:45:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
 <7b8cfb2721c349f2bcebec98f84291b1cffd3b49.1611954543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <7b8cfb2721c349f2bcebec98f84291b1cffd3b49.1611954543.git.gitgitgadget@gmail.com>
Date:   Sat, 30 Jan 2021 21:45:48 +0100
Message-ID: <875z3ep30j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 29 2021, Hariom Verma via GitGitGadget wrote:

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 2962f85a502..ea1f8417176 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -260,11 +260,40 @@ contents:lines=N::
>  	The first `N` lines of the message.
>  
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
> -are obtained as `trailers` (or by using the historical alias
> -`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
> -with `trailers:only`. Whitespace-continuations can be removed from trailers so
> -that each trailer appears on a line by itself with its full content with
> -`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
> +are obtained as `trailers[:options]` (or by using the historical alias
> +`contents:trailers[:options]`). Valid [:option] are:
> +** 'key=<K>': only show trailers with specified key. Matching is done
> +   case-insensitively and trailing colon is optional. If option is
> +   given multiple times trailer lines matching any of the keys are
> +   shown. This option automatically enables the `only` option so that
> +   non-trailer lines in the trailer block are hidden. If that is not
> +   desired it can be disabled with `only=false`.  E.g.,
> +   `%(trailers:key=Reviewed-by)` shows trailer lines with key
> +   `Reviewed-by`.
> +** 'only[=val]': select whether non-trailer lines from the trailer
> +   block should be included. The `only` keyword may optionally be
> +   followed by an equal sign and one of `true`, `on`, `yes` to omit or
> +   `false`, `off`, `no` to show the non-trailer lines. If option is
> +   given without value it is enabled. If given multiple times the last
> +   value is used.
> +** 'separator=<SEP>': specify a separator inserted between trailer
> +   lines. When this option is not given each trailer line is
> +   terminated with a line feed character. The string SEP may contain
> +   the literal formatting codes. To use comma as separator one must use
> +   `%x2C` as it would otherwise be parsed as next option. If separator
> +   option is given multiple times only the last one is used.
> +   E.g., `%(trailers:key=Ticket,separator=%x2C)` shows all trailer lines
> +   whose key is "Ticket" separated by a comma.
> +** 'key_value_separator=<SEP>': specify a separator inserted between
> +   key and value. The string SEP may contain the literal formatting codes.
> +   E.g., `%(trailers:key=Ticket,key_value_separator=%x2C)` shows all trailer
> +   lines whose key is "Ticket" with key and value separated by a comma.
> +** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
> +   option was given. In same way as to for `only` it can be followed
> +   by an equal sign and explicit value. E.g.,
> +   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
> +** 'valueonly[=val]': skip over the key part of the trailer line and only
> +   show the value part. Also this optionally allows explicit value.

Given that the goal of this series is to unify this parsing logic
between log/for-each-ref, why do we need to then copy/paste the exact
same docs we have in pretty-formats.txt?

At the very least we should move this to pretty-formats-trailers.txt or
something, and just include it in both places, or better yet just refer
to the relevan parts of "git log"'s man page, no?

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index ca62e764b58..a8835b13915 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -825,14 +825,32 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success '%(trailers:only) shows only "key: value" trailers' '
> +test_show_key_value_trailers () {
> +	option="$1"
> +	test_expect_success "%($option) shows only 'key: value' trailers" '
> +		{
> +			grep -v patch.description <trailers &&
> +			echo
> +		} >expect &&
> +		git for-each-ref --format="%($option)" refs/heads/main >actual &&
> +		test_cmp expect actual &&
> +		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
> +		test_cmp expect actual
> +	'
> +}
> +
> +test_show_key_value_trailers 'trailers:only'
> +test_show_key_value_trailers 'trailers:only=no,only=true'
> +test_show_key_value_trailers 'trailers:only=yes'
> +
> +test_expect_success '%(trailers:only=no) shows all trailers' '
>  	{
> -		grep -v patch.description <trailers &&
> +		cat trailers &&
>  		echo
>  	} >expect &&
> -	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
> +	git for-each-ref --format="%(trailers:only=no)" refs/heads/main >actual &&
>  	test_cmp expect actual &&
> -	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
> +	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/main >actual &&
>  	test_cmp expect actual
>  '
>  
> @@ -851,17 +869,92 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
>  	test_cmp actual actual
>  '
>  
> -test_expect_success '%(trailers) rejects unknown trailers arguments' '
> -	# error message cannot be checked under i18n
> -	cat >expect <<-EOF &&
> -	fatal: unknown %(trailers) argument: unsupported
> -	EOF
> -	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
> -	test_i18ncmp expect actual &&
> -	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
> -	test_i18ncmp expect actual
> +test_trailer_option() {
> +	title="$1"
> +	option="$2"
> +	expect="$3"
> +	test_expect_success "$title" '
> +		echo $expect >expect &&
> +		git for-each-ref --format="%($option)" refs/heads/main >actual &&
> +		test_cmp expect actual &&
> +		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
> +		test_cmp expect actual
> +	'
> +}
> +
> +test_trailer_option '%(trailers:key=foo) shows that trailer' \
> +	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:key=foo) is case insensitive' \
> +	'trailers:key=SiGned-oFf-bY' 'Signed-off-by: A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:key=foo:) trailing colon also works' \
> +	'trailers:key=Signed-off-by:' 'Signed-off-by: A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:key=foo) multiple keys' \
> +	'trailers:key=Reviewed-by:,key=Signed-off-by' 'Reviewed-by: A U Thor <author@example.com>\nSigned-off-by: A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:key=nonexistent) becomes empty' \
> +	'trailers:key=Shined-off-by:' ''
> +
> +test_expect_success '%(trailers:key=foo) handles multiple lines even if folded' '
> +	{
> +		grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by &&
> +		echo
> +	} >expect &&
> +	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/main >actual &&
> +	test_cmp expect actual &&
> +	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/main >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
> +	{
> +		unfold <trailers | grep Signed-off-by &&
> +		echo
> +	} >expect &&
> +	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
> +	test_cmp expect actual &&
> +	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
> +	test_cmp expect actual
>  '
>  
> +test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
> +	{
> +		echo "Signed-off-by: A U Thor <author@example.com>" &&
> +		grep patch.description <trailers &&
> +		echo
> +	} >expect &&
> +	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
> +	test_cmp expect actual &&
> +	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
> +	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:separator) changes separator' \
> +	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'7
> +test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
> +	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>\nSigned-off-by,A U Thor <author@example.com>\n'
> +test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
> +	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>'
> +
> +test_failing_trailer_option () {
> +	title="$1"
> +	option="$2"
> +	error="$3"
> +	test_expect_success "$title" '
> +		# error message cannot be checked under i18n
> +		echo $error >expect &&
> +		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
> +		test_i18ncmp expect actual &&
> +		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
> +		test_i18ncmp expect actual
> +	'
> +}
> +
> +test_failing_trailer_option '%(trailers:key) without value is error' \
> +	'trailers:key' 'fatal: expected %(trailers:key=<value>)'
> +test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
> +	'trailers:unsupported' 'fatal: unknown %(trailers) argument: unsupported'
> +
>  test_expect_success 'if arguments, %(contents:trailers) shows error if colon is missing' '
>  	cat >expect <<-EOF &&
>  	fatal: unrecognized %(contents) argument: trailersonly

And similarly, here we have now mostly duplicated tests for this between
here and t/t4205-log-pretty-formats.sh.

I think the right thing to do is to start by moving the tests that are
now in t/t4205-log-pretty-formats.sh relevant to this formatting into
its own file or something.

Then instead of duplicating the tests here, just prepare them to be
changed so that we can add both "git log" and a "git for-each-ref"
invocation to some for-loop, so we'll test both.
