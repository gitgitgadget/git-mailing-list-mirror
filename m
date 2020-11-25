Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E05C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738AF206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyAL7X9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKYJBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgKYJBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 04:01:18 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6294FC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:01:02 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so1864084ejb.13
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fpJr1k6uRd7RfTdStR3kx4+6qE6MWcfC4w/qzLaYENM=;
        b=ZyAL7X9jaL1U+2UJPJZ+Uy6IIjtWAnXZVujd7H5StSbbTB8Z9qpX2t+vDTBkGy7dlO
         B46nakfQDk4vXpeFitPXC7mng8/v9RlN66R7zdf9R9NY/EKyGe+pgc2eK+YKOTVmLsGN
         qYAga9EkTdddNJjqxVAxx4t7WwMQVYCLnJD34VY9LQjkHYvvRoJ9ZhdCGyaq1YP+tVrU
         tl0oGW56PkWyfE3Hp2tF3JUD+ZgwgY4V/4DP3Zul1aByQyvtBtjRpgTLAiHSeKeB0I1e
         /IOGj3Z8ctpHbLct1h7Dg6tJsQe3LZ6aTbMogEI218tPfHwkQAQxLzYEflJX+mgmrSIg
         2lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fpJr1k6uRd7RfTdStR3kx4+6qE6MWcfC4w/qzLaYENM=;
        b=G8ZF0hNTt+GPNgJHlrU4okQkY1BIMg4bAxXmJB+9k73AIvoYVUURoDj6yy7LAzraG3
         W5bBQZulKg0Px9ongQ31n+NjoLkj5RY8IguOVMe8bxVx0TDi1OL8imNmY3VBsm5/hQzI
         3vupshwD0lIQahG++2PKzMPDFco6BgHHQdlfY6CGd7oqtZzT2s5h8pT3fEWc6U7OzyVi
         KtP2ABjIQUX4IJJMzU0pNx16oNyYAJ/t662eee52KPpYb+Jvt/03xVLy1rIfofl5DYFH
         aDgiItJo3BpguH/L+w+IC4bPS+M/rE1uxzWYQX2qcyvpH0lo2i4+KUcutMAosE6rIPvk
         RJGw==
X-Gm-Message-State: AOAM532vmkx7xmpnv7JFUzlLG1zdDW/PCWqPTLVLf22UBxy0fh6MfwDQ
        At4Hnqq+m6BUIS4bgENOSdVlo8S7XEM=
X-Google-Smtp-Source: ABdhPJyvdsZ6ZtOpOqCKsleClQpU2xVt8ZRG+00aBy9aQWVAWMsU8wGn3atPWpqZmH9i5/V1Dq3nrw==
X-Received: by 2002:a17:906:8691:: with SMTP id g17mr2271309ejx.317.1606294860987;
        Wed, 25 Nov 2020 01:01:00 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id b7sm824812ejj.85.2020.11.25.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:01:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1606214397.git.ps@pks.im> <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
Date:   Wed, 25 Nov 2020 10:00:59 +0100
Message-ID: <87360xq08k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 24 2020, Patrick Steinhardt wrote:

...some more feedback.

> +GIT_CONFIG_COUNT,GIT_CONFIG_KEY_<n>,GIT_CONFIG_VALUE_<n>::
> +	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
> +	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
> +	added to the process's runtime configuration. The config pairs are
> +	zero-indexed. Any missing key or value is treated as an error. An empty
> +	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=0, namely no
> +	pairs are processed. Config entries set this way have command scope,
> +	but will be overridden by any explicit options passed via `git -c`.

Perhaps work in some/all of some version of these:

 - There's also a GIT_CONFIG_PARAMETERS variable, which is considered
   internal to Git itself. Users are expected to set these.

   --> I.e. even if we're not going to support some format for
   --> GIT_CONFIG_PARAMETERS document what it is.

 - This is analogous to the pre-receive `GIT_PUSH_OPTION_*` variables
   (see linkgit:githooks[5]), but unlike those the `-c` option to
   linkgit:git(1) does not set `GIT_CONFIG_*`.

 - Saying "command scope" here I think is wrong/misleading. If I didn't
   know how this worked I'd expect the first git process to see it to
   delete it from the env, so e.g. the "fetch" command would see it, but
   not the "gc" it spawned (different commands). Maybe just say "the
   scope of these is as with other GIT_* environment variables, they'll
   be inherited by subprocesses".

> diff --git a/cache.h b/cache.h
> index c0072d43b1..8a36146337 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -472,6 +472,7 @@ static inline enum object_type object_type(unsigned int mode)
>  #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
>  #define CONFIG_ENVIRONMENT "GIT_CONFIG"
>  #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
> +#define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"

I was wondering if this shouldn't be "GIT_CONFIG_KEY_COUNT" to be
consistent with the push options environment, but on a closer look we
have:

 - GIT_CONFIG_COUNT
 - GIT_CONFIG_KEY_N
 - GIT_CONFIG_VALUE_N
 - GIT_PUSH_OPTION_COUNT
 - GIT_PUSH_OPTION_N

So I guess that makes sense & is consistent since we'd like to split the
key-value here to save the user the effort of figuring out which "="
they should split on.

> -	if (!env)
> -		return 0;
> -

Re the indent question to make the diff more readable question Junio
had: could set some "do we have this or that" variables here to not
reindent the existing code, but maybe not worth the effort...

> -	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> -		ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
> -		goto out;
> +		count = strtoul(env, &endp, 10);
> +		if (*endp) {
> +			ret = error(_("bogus count in %s"), CONFIG_COUNT_ENVIRONMENT);
> +			goto out;
> +		}
> +		if (count > INT_MAX) {
> +			ret = error(_("too many entries in %s"), CONFIG_COUNT_ENVIRONMENT);
> +			goto out;
> +		}
> +
> +		for (i = 0; i < count; i++) {
> +			const char *key, *value;
> +
> +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> +			key = getenv(envvar.buf);
> +			if (!key) {
> +				ret = error(_("missing config key %s"), envvar.buf);
> +				goto out;
> +			}
> +			strbuf_reset(&envvar);
> +
> +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
> +			value = getenv(envvar.buf);
> +			if (!value) {
> +				ret = error(_("missing config value %s"), envvar.buf);
> +				goto out;
> +			}
> +			strbuf_reset(&envvar);
> +
> +			if (config_parse_pair(key, value, fn, data) < 0) {
> +				ret = -1;
> +				goto out;
> +			}
> +		}
>  	}
>  
> -	for (i = 0; i < nr; i++) {
> -		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
> -			ret = -1;
> +	env = getenv(CONFIG_DATA_ENVIRONMENT);
> +	if (env) {
> +		int nr = 0, alloc = 0;
> +
> +		/* sq_dequote will write over it */
> +		envw = xstrdup(env);
> +
> +		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> +			ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
>  			goto out;
>  		}
> +
> +		for (i = 0; i < nr; i++) {
> +			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
> +				ret = -1;
> +				goto out;
> +			}
> +		}
>  	}
>  
>  out:
> +	strbuf_release(&envvar);
>  	free(argv);
>  	free(envw);
>  	cf = source.prev;
> diff --git a/environment.c b/environment.c
> index bb518c61cd..e94eca92f3 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -116,6 +116,7 @@ const char * const local_repo_env[] = {
>  	ALTERNATE_DB_ENVIRONMENT,
>  	CONFIG_ENVIRONMENT,
>  	CONFIG_DATA_ENVIRONMENT,
> +	CONFIG_COUNT_ENVIRONMENT,
>  	DB_ENVIRONMENT,
>  	GIT_DIR_ENVIRONMENT,
>  	GIT_WORK_TREE_ENVIRONMENT,
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 825d9a184f..8c90cca79d 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1316,6 +1316,107 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMETERS' '
>  		git config --get-regexp "env.*"
>  '
>  
> +test_expect_success 'git config handles environment config pairs' '

I was wondering if the patch would keep the current
GIT_CONFIG_PARAMETERS or replace it entirely with the new facility.

On the one hand it would make sense to just replace
GIT_CONFIG_PARAMETERS, we could make this code loop over the new values.

On the other hand, and this is an edge case I hadn't considered before,
any change to the semantics of GIT_CONFIG_PARAMETERS means that e.g. a
fetch->gc spawning would break in the face of a concurrent OS update to
/usr/bin/git, since "fetch" and "gc" might be of differing versions
