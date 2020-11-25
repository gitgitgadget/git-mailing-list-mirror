Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F96DC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB37420789
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xS70Ireb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKYDj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:39:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63081 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYDj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:39:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18ED3F55A8;
        Tue, 24 Nov 2020 22:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HwW4wmODzUGU8tE/p/vmCTioHXk=; b=xS70Ir
        ebquC1otO9erDbeUp9c+vGrhNz+miEU3U2kjWMCVjYf0v4L62Ne4YoSNw0yN2+2k
        Cm5D7WlvZOKPmpAXakQ/5OQ4SCb4abWqFpqrVdeOlPuENC3+xNUMHr3rT/ZdHUyS
        BdnLSrQobf9fzv97jJBK4csezPRgTnelX5df4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BCDTWE34PX1DbBeKbdYgEXdR8LJAWsdr
        LynyhxfqKV2NE+8m7vBGZlVBLjboPSQbbTYLoOZpqM3KbSm4ZdkNtUi02Z4xhxYQ
        hVtmhtNaQalYXQ9HJh7Uagr+jOh8LFOQshwGOoq/+Baz5sQIYxWRX4/3KzubBjOE
        PyeFnrcFIU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FBDBF55A6;
        Tue, 24 Nov 2020 22:39:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 061E3F55A2;
        Tue, 24 Nov 2020 22:39:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im>
        <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
Date:   Tue, 24 Nov 2020 19:39:48 -0800
In-Reply-To: <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 24 Nov 2020 11:50:55 +0100")
Message-ID: <xmqqtutef6kb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF0FEC66-2ECF-11EB-8606-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +GIT_CONFIG_COUNT,GIT_CONFIG_KEY_<n>,GIT_CONFIG_VALUE_<n>::

I think we write a header with multiple/related items like this
instead:

    GIT_CONFIG_COUNT::
    GIT_CONFIG_KEY_<n>::
    GIT_CONFIG_VALUE_<n>::

See how -f/--file is marked up in an earlier part of the same file.

> +	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
> +	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
> +	added to the process's runtime configuration. The config pairs are
> +	zero-indexed. Any missing key or value is treated as an error. An empty
> +	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=0, namely no
> +	pairs are processed. Config entries set this way have command scope,
> +	but will be overridden by any explicit options passed via `git -c`.
> +
>  See also <<FILES>>.

Doesn't this <<FILES>> refer to GIT_CONFIG and GIT_CONFIG_NOSYSTEM
that are described earlier?  It certainly looks out of place to see
it after the KEY/VALUE thing.

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

Didn't we got bitten by number of times that the string returned by
getenv() are not necessarily nonvolatile depending on platforms?  I
think the result of getenv() would need to be xstrdup'ed.

cf. 6776a84d (diff: ensure correct lifetime of external_diff_cmd,
2019-01-11)

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

With re-indentation this patch does, it is a bit hard to see the
correspondence between common lines in preimage and postimage, but I
think the patch adds the support of the new style environments
before the existing support of the GIT_CONFIG_DATA, but when there
is no compelling reason not to, new code should be added near the
bottom, not before the existing code, in the function.

Otherwise, this part of the patch looks OK to me.

Thanks.
