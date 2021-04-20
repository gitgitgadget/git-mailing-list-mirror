Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDF1C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FB9611C9
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDTKxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhDTKxR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 06:53:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B36C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:52:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd23so48934214ejb.12
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xqpnJsRR6gwf+eldfH8wgutnvuKJqOvfU75iMW2HZ9w=;
        b=YC1AlqXuLhE+gLMN2hbocNHvz0GpolRU+KIhgHTLsYJvcmwOLzkfHpF9RzmMBHGOZj
         8pkN7WlCGqjs02RD1uDiFGMf3DqxCVkgHfKYU4ZveD5KV0F0ZA+htS3T8KuCbHg7+GHa
         7LUtwHuxirpQZ2vogM2Pbq4uooyWweUIi399LYUO96MHILuDIkyvTPA3PlsJKvuS7P7d
         MFK5q7zvmgcX8v8qWBI5scLHvUNXzjClOoC8SifoiSgfkFa84R7MruEhLMen+jYoHUKQ
         1qRqbfi5jiBEnj8UojIIJdnJnjgHe1S0+A0cHAtnPZPXAv2+OZOSSFVukS5VbS7itmrt
         rbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xqpnJsRR6gwf+eldfH8wgutnvuKJqOvfU75iMW2HZ9w=;
        b=VmiDCQDEMKa2TzE+Z+w7pYaW6+ScKav499lfMnzVdErLbj3iB3zC67JIVjQk39VdTA
         TnELkzgf0DY+IzjyaENB8YZSJy8JyIdZEpGqRsg4jKcE91OBjGsfKpNDzeFFcx2zyHAF
         ah//6ArhAXe7l6okmD0j4RtmLXsdl1n6L6DVbKEgKhfU4eU41kGgGkEk3ghPHfIgx5Uj
         Xb6JwlqAI+mqrqn8sTwEuhtedOTfKnjayxI74T08mupQTSv1wJKyrz3JZXcVvEpVXqB2
         w9du2v5I423SaSKQjGagCW0uvJAWwtR6xZhgfsB7EaR92ak8Lv/JKQEz0XoLf+ZB+dw+
         RCYg==
X-Gm-Message-State: AOAM530Vk3CSqSqSocKgTaQpKMmxf3Al2PAsSKgJSrJ0yVt/jgJQ9S7j
        I4OFAu8bQbDDKV/X8RKaV7nze54oaeY=
X-Google-Smtp-Source: ABdhPJzC291rSW1Rh9Tl6O/yDkI8DcBoqLCcQWhE2ZPG13ZcGBb7MicmG0W7cwmmiF+D3dSlg+steQ==
X-Received: by 2002:a17:907:9852:: with SMTP id jj18mr2113164ejc.382.1618915964618;
        Tue, 20 Apr 2021 03:52:44 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v1sm15712124eds.17.2021.04.20.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:52:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: support separate arg for `--config-env`'s value
References: <cover.1618847606.git.ps@pks.im>
 <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
Date:   Tue, 20 Apr 2021 12:52:43 +0200
Message-ID: <874kg14490.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Patrick Steinhardt wrote:

> While not documented as such, many of the top-level options like
> `--git-dir` and `--work-tree` support two syntaxes: they accept both an
> equals sign between option and its value, and they do support option and
> value as two separate arguments. The recently added `--config-env`
> option only supports the syntax with an equals sign.
>
> Mitigate this inconsistency by accepting both syntaxes and add tests to
> verify both work.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

This whole series LGTM.

>  git.c             |  8 ++++++++
>  t/t1300-config.sh | 15 ++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index b53e665671..ad365c05c7 100644
> --- a/git.c
> +++ b/git.c
> @@ -255,6 +255,14 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			git_config_push_parameter((*argv)[1]);
>  			(*argv)++;
>  			(*argc)--;
> +		} else if (!strcmp(cmd, "--config-env")) {
> +			if (*argc < 2) {
> +				fprintf(stderr, _("no config key given for --config-env\n" ));


I found this use of fprintf() slightly odd, why not error(), but then
went back and read the function and saw that it has N number of
"fprintf(stderr, [...])" already.

That could probably all be converted to error(), but better to be
consistent for now.

> +				usage(git_usage_string);
> +			}
> +			git_config_push_env((*argv)[1]);
> +			(*argv)++;
> +			(*argc)--;
>  		} else if (skip_prefix(cmd, "--config-env=", &cmd)) {
>  			git_config_push_env(cmd);
>  		} else if (!strcmp(cmd, "--literal-pathspecs")) {
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e0dd5d65ce..18803f9953 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1374,16 +1374,29 @@ test_expect_success 'git --config-env=key=envvar support' '
>  	cat >expect <<-\EOF &&
>  	value
>  	value
> +	value
> +	value
> +	false
>  	false
>  	EOF
>  	{
>  		ENVVAR=value git --config-env=core.name=ENVVAR config core.name &&
> +		ENVVAR=value git --config-env core.name=ENVVAR config core.name &&
>  		ENVVAR=value git --config-env=foo.CamelCase=ENVVAR config foo.camelcase &&
> -		ENVVAR= git --config-env=foo.flag=ENVVAR config --bool foo.flag
> +		ENVVAR=value git --config-env foo.CamelCase=ENVVAR config foo.camelcase &&
> +		ENVVAR= git --config-env=foo.flag=ENVVAR config --bool foo.flag &&
> +		ENVVAR= git --config-env foo.flag=ENVVAR config --bool foo.flag
>  	} >actual &&
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git --config-env with missing value' '
> +	test_must_fail env ENVVAR=value git --config-env 2>error &&
> +	test_i18ngrep "no config key given for --config-env" error &&
> +	test_must_fail env ENVVAR=value git --config-env config core.name 2>error &&
> +	test_i18ngrep "invalid config format: config" error
> +'
> +
>  test_expect_success 'git --config-env fails with invalid parameters' '
>  	test_must_fail git --config-env=foo.flag config --bool foo.flag 2>error &&
>  	test_i18ngrep "invalid config format: foo.flag" error &&

