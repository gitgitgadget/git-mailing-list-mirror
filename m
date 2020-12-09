Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA9C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8045E20829
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbgLIOlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgLIOlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:41:00 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4AC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:40:20 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so2480001ejb.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EiJtVaMgbU+4uSOOH6n5rAyH8vhayNAseJxNYZzB4tU=;
        b=qqcVzHO4DeJXmv0ybc3rDkXPIuUGV2PjVsbxOA4VCllatOJ4aepSdBHQ8B0gdmBBwC
         jhmyv3+jQoV8E9zsYPFaatoeo7aM5I/nbEzI79qOS937G2A1JCu3gGP5scvEMiZdj9yy
         RFqBq3G4bIMZjl0jvRFQnk67kNGDdqSWvJ8hpihZmRWEjus02kmEAX03mL3D2kxxogbb
         HrjwNYrPzpZRUnRHSXbEw9AQfmR+w5pnL/2TKTtwBJv1i0DJ3GpSShYMdWGTexZE/rZw
         3Mkyo41QKGqE53cwk/ks4mt8QeJid+I2v3sojMgLR60DdnjxFQ/Wguxm4OxmJ7d+MxnS
         2p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EiJtVaMgbU+4uSOOH6n5rAyH8vhayNAseJxNYZzB4tU=;
        b=D4ARtL+OXTndFw8PEc+8eapzlvC7p4raRdOUdXBrSQPLv5+JrGK2ufMtfGL5njU39p
         j/kTTRSFBaXI89JnEjew4XQDQSFnje7L8SeCIUtcKTUZv5poPNfxloYVhpWStrn9e5tJ
         NBDo1fVb7Hq8ekQ9S8sE43ul5dTRCz/Kir9kWYz8kFTFUXwdYkg/APAtWb2wQCNlNRJ4
         0Bx4sLsiOvn8XWa4l1uMNw4FGWtJmLVQLbfCaoBhvjQGUKiiLSyGnwLXBTKqxeaeVJlL
         rwH9eaZF0AMiqfPzxzsVyVwwQ6LZ8WXMJnDPYui5JDF4y2+6EMn8tQBWtahR8YcUwNox
         eRSw==
X-Gm-Message-State: AOAM531vjhOA3y3wvvDHbLa3VPuazKvbBN2odVIphZa2ZMf+PWDtTp7P
        B0n9wPKzIwIiCEl9YcNn4CYqNFRUSJ0=
X-Google-Smtp-Source: ABdhPJz8ZVyyDsJmlxxZhGlubTAbsR6il7eawiwjzvmTjArI0Jk/Uvu/mw+7hxSmwEOnIM7ua/7bEg==
X-Received: by 2002:a17:906:f0c3:: with SMTP id dk3mr2288409ejb.366.1607524818724;
        Wed, 09 Dec 2020 06:40:18 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cc8sm2005749edb.17.2020.12.09.06.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:40:18 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
Date:   Wed, 09 Dec 2020 15:40:17 +0100
Message-ID: <871rfzxctq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 09 2020, Patrick Steinhardt wrote:

> While it's already possible to pass runtime configuration via `git -c
> <key>=<value>`, it may be undesirable to use when the value contains
> sensitive information. E.g. if one wants to set `http.extraHeader` to
> contain an authentication token, doing so via `-c` would trivially leak
> those credentials via e.g. ps(1), which typically also shows command
> arguments.
>
> To enable this usecase without leaking credentials, this commit
> introduces a new switch `--config-env=<key>=<envvar>`. Instead of
> directly passing a value for the given key, it instead allows the user
> to specify the name of an environment variable. The value of that
> variable will then be used as value of the key.
> [...]
> +--config-env=<name>=<envvar>::
> +	Pass a configuration parameter to the command. The <envvar>
> +	given will be replaced with the contents of the environment
> +	variable of that name. In contrast to `-c`, an envvar must
> +	always be given and exist in the environment. Passing an
> +	environment variable with empty value will set <name> to the
> +	empty string which `git config --type=bool` will convert to
> +	`false`.

Okey, because "-c foo.bar" (true) "-c foo.bar=" is the empty string, but
that doesn't make sene with "--config-env". Also the whole part about
--type=bool is just confusing, because it's referring to `-c`'s magic
behavior when it comes to `bool` which we don't have here.

I think it's also worth describing what this is for & what the
limitations are. Maybe:

    --config-env=<name>=<envvar>

        Like `-c <name>=<var>` except the value is the name of an
        environment variable from which to retrieve the value. Unlike
        `-c` there is no shortcut for directly setting the value to an
        empty string, instead the environment variable itself must be
        set to the empty strin. Errors if the `<envvar>` does not exist
        in the environment.

        This is useful for cases where you want to pass transitory
        configuration options to git, but are doing so on OS's where
        other processes might be able to read your cmdline
        (e.g. `/proc/self/cmdline`), but not your environ
        (e.g. `/proc/self/environ`). That behavior is the default on
        Linux, but may not be on your system.

	Note that this might add security for variables such as
	`http.extraHeader` where the sensitive information is part of
	the value, but not e.g. `url.<base.insteadOf` where the
	sensitive information can be part of the key.

> +void git_config_push_env(const char *spec)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *env_name;
> +	const char *env_value;
> +
> +	env_name = strrchr(spec, '=');
> +	if (!env_name)
> +		die("invalid config format: %s", spec);
> +	env_name++;

Not something new, and maybe not something for this series, but I wish
-c and --config-env would document this limitation that we support "="
in keys in config, but not via those parameters.
