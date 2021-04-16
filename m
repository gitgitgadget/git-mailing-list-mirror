Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83086C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F63B611C2
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 15:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhDPPlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhDPPlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 11:41:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C13C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:40:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r12so42808945ejr.5
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9szvXQhXaj5Q+1VLaMwubTkHas+3V0Lti+HRjvEucPc=;
        b=VVbxDyEb3VwK2onj+uzD0KAPykUVAQokSXvX1b6BzuNFfbZ8gNVSDv5deKo19EVqiD
         cYz+s2kMPNlo6Nox4Of+ihPfny0shRqj/7BPRYF/oH8VIZn5xLAIRdgqS4jevVNdsxXm
         dBBQsF7zS1ZVn3ft8Su/+g5kV0dO7/SOnZzenZ42/dwC5pQLryZHjw+G65c1gQ6kNeoz
         nq0qXwP1RhW6U6+CVYpamBHtBE8JgZXKi78Z/UKn4S7ZcZ8SyuTOBjJRsyl7N96mYXmx
         FIiqt4op0YatESA+l7SivHoGRgLopr8tnD1oWxyqSyv8PPTFnkp9WPoCR+umXwmQ2QOj
         WzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9szvXQhXaj5Q+1VLaMwubTkHas+3V0Lti+HRjvEucPc=;
        b=kkRQ28ytVwc9CmV/FDusmfU6dDGOfUs7SLDBuLDHhbKzoPllozyB3/vntpS8MsH7m4
         mOwWvWelhGQUek3GkHkjk5MpebgVq9SkVyBhvkO5rB98rYzR0FiotOVrTtNoI3aXOE5z
         Ei5JZlQvZNEfjvC4YQff89XK1LqYu3geAflDis5toAQjdrnV6mCKbDGo3Quf/ZDbHjdN
         uVBCltZfeS9EjeEPK2UwT1BjZ+N+nhBiEtuQl4YUAguNLAOhUbrt+iJLT/80PT6N97Fq
         RAyeut7xOYVUdUMb0qZkOhOXHk7WJEB+V4Kcnx9Q1phCVSVTelPsEOcRz6byUY5QD0Ta
         092A==
X-Gm-Message-State: AOAM532ScFpsbANgatQL2sdeoEAqt5aZcTM2E5Lu5fscHRBKbjj0Rdhw
        Q3AJTIUiMqosb7Fs6jr0ZEFaRR1BD/g=
X-Google-Smtp-Source: ABdhPJxImNKwmBVTnpbAJ5mhUtu4hvGW/VzV/0jajgzrWOHjJUcpY34TPIe8kuBRzUJu7NSETpoAwA==
X-Received: by 2002:a17:906:3915:: with SMTP id f21mr9148849eje.256.1618587637358;
        Fri, 16 Apr 2021 08:40:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q25sm5735105edt.51.2021.04.16.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:40:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
Date:   Fri, 16 Apr 2021 17:40:36 +0200
Message-ID: <87o8eeteyz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, Patrick Steinhardt wrote:

A minor doc bug that wasn't spotted before landing. Here we say
"--config-env foo=bar" will work:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index a6d4ad0818..d36e6fd482 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>      [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> -    [--super-prefix=<path>]
> +    [--super-prefix=<path>] [--config-env <name>=<envvar>]
>      <command> [<args>]
>  
>  DESCRIPTION
> @@ -80,6 +80,28 @@ config file). Including the equals but with an empty value (like `git -c
>  foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>  --type=bool` will convert to `false`.

But not here, we ask for "--config-env=" (note the "="):

> +--config-env=<name>=<envvar>::
> +	Like `-c <name>=<value>`, give configuration variable
> +	'<name>' a value, where <envvar> is the name of an
> +	environment variable from which to retrieve the value. Unlike
> +	`-c` there is no shortcut for directly setting the value to an
> +	empty string, instead the environment variable itself must be
> +	set to the empty string.  It is an error if the `<envvar>` does not exist
> +	in the environment. `<envvar>` may not contain an equals sign
> +	to avoid ambiguity with `<name>`s which contain one.
> ++
> [...]
> +		} else if (skip_prefix(cmd, "--config-env=", &cmd)) {
> +			git_config_push_env(cmd);

But as this...

> +test_expect_success 'git --config-env=key=envvar support' '
> +	cat >expect <<-\EOF &&
> +	value
> +	value
> +	false
> +	EOF
> +	{
> +		ENVVAR=value git --config-env=core.name=ENVVAR config core.name &&
> +		ENVVAR=value git --config-env=foo.CamelCase=ENVVAR config foo.camelcase &&
> +		ENVVAR= git --config-env=foo.flag=ENVVAR config --bool foo.flag
> +	} >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git --config-env fails with invalid parameters' '
> +	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
> +	test_i18ngrep "invalid config format: foo.flag" error &&
> +	test_must_fail git --config-env=foo.flag= config --bool foo.flag 2>error &&
> +	test_i18ngrep "missing environment variable name for configuration ${SQ}foo.flag${SQ}" error &&
> +	sane_unset NONEXISTENT &&
> +	test_must_fail git --config-env=foo.flag=NONEXISTENT config --bool foo.flag 2>error &&
> +	test_i18ngrep "missing environment variable ${SQ}NONEXISTENT${SQ} for configuration ${SQ}foo.flag${SQ}" error
> +'
> +
> +test_expect_success 'git -c and --config-env work together' '
> +	cat >expect <<-\EOF &&
> +	bar.cmd cmd-value
> +	bar.env env-value
> +	EOF
> +	ENVVAR=env-value git \
> +		-c bar.cmd=cmd-value \
> +		--config-env=bar.env=ENVVAR \
> +		config --get-regexp "^bar.*" >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git -c and --config-env override each other' '
> +	cat >expect <<-\EOF &&
> +	env
> +	cmd
> +	EOF
> +	{
> +		ENVVAR=env git -c bar.bar=cmd --config-env=bar.bar=ENVVAR config bar.bar &&
> +		ENVVAR=env git --config-env=bar.bar=ENVVAR -c bar.bar=cmd config bar.bar
> +	} >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git config --edit works' '
>  	git config -f tmp test.value no &&
>  	echo test.value=yes >expect &&

...and the tests show we just support the --opt=foo=bar form, not --opt
foo=bar.

Bonus points to anyone sorting out some of the existing inconsistencies
when fixing this, i.e. --exec-path supports either the "=" form, or not,
but various other skip_prefix() in the same function don't, seemingly
(but I have not tested) for no good reason.

It seems to me that having a skip_prefix_opt() or something would be a
good fix for this, i.e. a "maybe trim the last '='" version of
skip_prefix. Then we could just consistently use that.

Or maybe there's some reason we don't want to be as lax as --exec-path
with any other option...

