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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B18C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C323E25
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 20:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404704AbgLJU4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 15:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404659AbgLJU4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 15:56:02 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B5C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:55:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so9299560ejb.8
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hsEncgjQ/K7j0Dh74xEuKU8sQK1jYTc9ILn5z2RFnUA=;
        b=opJgKRfHrvlsA33V/rCfISkB4eD8t5IXlI1uUaWw1uJBB13Ww656avRSqPoXScS0Bc
         ZUd7S+2D1V7Mm15EhOipseJhw5VaMDNrV5ZNpxqNY3iB0/vs+DeFZMmROhoEytdKZaeT
         8EHIl7Wgscx0mURdvPlNxWfwSEzcJ1OS8Mksp2Uib7pmJI8+PJz26AavSy4Wty0dPXyc
         KF6dscdAPmpmPGRSWREY/hPT04QdaEAvgGsW3Wj0KzMlFl6n6gG33S5YjtHAnickSRvt
         jIwrjKXaVWK9vcrofiWRzXA8JjYbeum9QU6+O+CssbuwA3gB6Xf7FYhuJhPpQ1Pm1YjK
         0JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hsEncgjQ/K7j0Dh74xEuKU8sQK1jYTc9ILn5z2RFnUA=;
        b=UC/IgWChtpuLZiOWVCdja3XbKfn0cf0RAJgfLUGtTEAnlMkDLYaqaxvLgkvWsC1dbE
         gBtOZCiHJAVgwsA388HSC7dGXvJU7dX72IXaXTwAsdGxdj7TS+nTcN31zhBeS6JhhkUG
         tSjU5CyCUP0CadpTdiihddJJG41Y1aKDsRFqYmr1K1rqFKMGmLY8eS4a1RMCv1paMuZ4
         DMMLorEVLdafgNM4+qGvPlSAUw9VNF+vUVUQH3t3vOSSI1v0bXDKrF+dqLFA18Opq8LW
         A58h9I+t6rniQgKbsU2mCVNH60vcke+XEadTbhB99HJTZqIDmxV4/5ZKU1JqL7suFAyk
         CZJw==
X-Gm-Message-State: AOAM532qgxv8kd0I35ausRN0gv8ksP3WFcJzYtCmA+thLfntV8oyYd29
        BzsObqzBrXeH526zwXWIvdQ=
X-Google-Smtp-Source: ABdhPJxM5ZSFPODxFn3VV7xWtv6ekwx6CTfhQA5oYpRFcqsahphZzvCkaiQRNOa1fExYdoRsCOdejA==
X-Received: by 2002:a17:906:3ad5:: with SMTP id z21mr7915806ejd.35.1607633720135;
        Thu, 10 Dec 2020 12:55:20 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d6sm5171555ejy.114.2020.12.10.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:55:19 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] config: store "git -c" variables using more robust
 format
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
 <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
Date:   Thu, 10 Dec 2020 21:55:18 +0100
Message-ID: <87pn3hwfd5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Jeff King wrote:

> The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
> is able to robustly handle subsections with "=" in them. Let's start
> writing the new format. Unfortunately, this does much less than you'd
> hope, because "git -c" itself has the same ambiguity problem! But it's
> still worth doing:
>
>   - we've now pushed the problem from the inter-process communication
>     into the "-c" command-line parser. This would free us up to later
>     add an unambiguous format there (e.g., separate arguments like "git
>     --config key value", etc).
>
>   - for --config-env, the parser already disallows "=" in the
>     environment variable name. So:
>
>       git --config-env section.with=equals.key=ENVVAR
>
>     will robustly set section.with=equals.key to the contents of
>     $ENVVAR.
>
> The new test shows the improvement for --config-env.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> One other side effect I just noticed is that we're very aggressive about
> trimming leading and trailing whitespace in the old-style format, but
> the new one will store values verbatim. IMHO that's better overall, but
> we might consider a preparatory patch to remove that trimming
> explicitly.
>
>  config.c          | 52 ++++++++++++++++++++++++++++++++++++++++-------
>  t/t1300-config.sh |  8 ++++++++
>  2 files changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/config.c b/config.c
> index fb160c33d2..04029e45dc 100644
> --- a/config.c
> +++ b/config.c
> @@ -333,38 +333,76 @@ int git_config_include(const char *var, const char *value, void *data)
>  	return ret;
>  }
>  
> -void git_config_push_parameter(const char *text)
> +static void git_config_push_split_parameter(const char *key, const char *value)
>  {
>  	struct strbuf env = STRBUF_INIT;
>  	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
>  	if (old && *old) {
>  		strbuf_addstr(&env, old);
>  		strbuf_addch(&env, ' ');
>  	}
> -	sq_quote_buf(&env, text);
> +	sq_quote_buf(&env, key);
> +	strbuf_addch(&env, '=');
> +	if (value)
> +		sq_quote_buf(&env, value);
>  	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
>  	strbuf_release(&env);
>  }
>  
> +void git_config_push_parameter(const char *text)
> +{
> +	const char *value;
> +
> +	/*
> +	 * When we see:
> +	 *
> +	 *   section.subsection=with=equals.key=value
> +	 *
> +	 * we cannot tell if it means:
> +	 *
> +	 *   [section "subsection=with=equals"]
> +	 *   key = value
> +	 *
> +	 * or:
> +	 *
> +	 *   [section]
> +	 *   subsection = with=equals.key=value
> +	 *
> +	 * We parse left-to-right for the first "=", meaning we'll prefer to
> +	 * keep the value intact over the subsection. This is historical, but
> +	 * also sensible since values are more likely to contain odd or
> +	 * untrusted input than a section name.
> +	 *
> +	 * A missing equals is explicitly allowed (as a bool-only entry).
> +	 */
> +	value = strchr(text, '=');
> +	if (value) {
> +		char *key = xmemdupz(text, value - text);
> +		git_config_push_split_parameter(key, value + 1);
> +		free(key);
> +	} else {
> +		git_config_push_split_parameter(text, NULL);
> +	}
> +}
> +
>  void git_config_push_env(const char *spec)
>  {
> -	struct strbuf buf = STRBUF_INIT;
> +	char *key;
>  	const char *env_name;
>  	const char *env_value;
>  
>  	env_name = strrchr(spec, '=');
>  	if (!env_name)
>  		die("invalid config format: %s", spec);
> +	key = xmemdupz(spec, env_name - spec);
>  	env_name++;
>  
>  	env_value = getenv(env_name);
>  	if (!env_value)
>  		die("config variable missing for '%s'", env_name);
>  
> -	strbuf_add(&buf, spec, env_name - spec);
> -	strbuf_addstr(&buf, env_value);
> -	git_config_push_parameter(buf.buf);
> -	strbuf_release(&buf);
> +	git_config_push_split_parameter(key, env_value);
> +	free(key);
>  }
>  
>  static inline int iskeychar(int c)
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index bd602e7720..e06961767f 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1413,6 +1413,14 @@ test_expect_success 'git -c and --config-env override each other' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--config-env handles keys with equals' '
> +	echo value=with=equals >expect &&
> +	ENVVAR=value=with=equals git \
> +		--config-env=section.subsection=with=equals.key=ENVVAR \
> +		config section.subsection=with=equals.key >actual &&
> +	test_cmp expect actual
> +'
> +

Maybe worth adding a test for the strrchr() semantics here with:

    perl -we '$ENV{"Y=Z"}="why and zed"; system "Z=zed git --config-env=X=Y=Z ..."'

Which would show that we can't look up "Y=Z", but will always get "Z".

I think that's fine b.t.w., 1/2 of the minor objection I had to
--config-env in
https://lore.kernel.org/git/87y2i7vvz4.fsf@evledraar.gmail.com/ was
mainly about being unable to e.g. support odd token usernames with the
"insteadOf" feature.

But aside from having a feature meant to improve security being able to
be combined with a config variable we have in a way that leaks the
password in ps(1) I think these improved semantics make sense.

I.e. I can't imagine someone wants an env var with "=" in it, even
though POSIX makes such a thing possible (you just can't do it in a
shellscript).
