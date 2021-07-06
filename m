Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D6DC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4613661C6C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhGFUIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:08:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6F3C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:05:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bu12so36209238ejb.0
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=B++dnV0RM/eOdfsYsyluusbo0ig+5mtBPrL0O/UaYVg=;
        b=ViG1hVcHqkymevCS2rnyN9/ont6HYvbYoFsN0pWwcyk4iFh0OAPc+1QpEk9jxmztkd
         0y5Y+LTWOaInQdJnhWxRBz9sF50Px8xFaHoWzLUzPWBF1SLYyCqB+5PTdTNERGxlixtQ
         pibwl/0NNLtbHR4oT4z+aYneojxh+wegVYX4B4zx8zVxZo3QpBbQt6InRxN80RGSQdeW
         ewshrX4YFSWL8z2g5cg7qy9l+vn0j5WFeE/BWopQj4/+Jzf5UGnE/ELp3yiZ5XvGvi4m
         frZKycZ9EVAMDmtRYd/dbM2bmmqj8WzNfWtzVmbn3Lm4Mqrs5ZzA+xKMwCXHtPYA3U4F
         2t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=B++dnV0RM/eOdfsYsyluusbo0ig+5mtBPrL0O/UaYVg=;
        b=GMdzAmnVwoJDluaOyM8JJ11avFv0vW0Z8DmQzgEqck45MC8w2u0m4VVVPyiHN2SKDf
         X/KPLWQOxig8ARoFsc/iQRVU7Nb0Xbw/WvzZqEGfq+IspZQetg9zOiV5nCEIsMF5w01K
         sxb+BZH5TKsNaWXK1e7tgCDWLIzX8wN0+WgQlspjZIoAhwDsUJ4N8NvrN0cGRUHo6aaJ
         u3Ba4SMiOyu6wH5/YoIY0lWyViWpc0yHVugbDV0ldECMYyUZhrI0FWKrhC9pxLAiP6f6
         XzzjolTwhY3etUNU8ABxd3X3SE7TCnk4e1qWOripy/ug9uH6c9YYOD6yNWTefzxEts33
         Sqag==
X-Gm-Message-State: AOAM532rrGYd/kRfpKyULnTZn/ldyXe+FnB9MJKjvdOVsTKjw4dtl5hS
        0E+6D5ysTK3FXxr81brA3Jw=
X-Google-Smtp-Source: ABdhPJy5MGvZh3O/+YiUqG0xyKv1swl4y42hwWjLOjt4qAivcvEaq80eAcPdPmV2dFLbTfKLPOB4sw==
X-Received: by 2002:a17:907:7252:: with SMTP id ds18mr20484675ejc.227.1625601932438;
        Tue, 06 Jul 2021 13:05:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s6sm5914498ejo.4.2021.07.06.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:05:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 3/3] maintenance: add support for systemd timers on
 Linux
Date:   Tue, 06 Jul 2021 22:03:44 +0200
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-4-lenaic@lhuard.fr>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210702142556.99864-4-lenaic@lhuard.fr>
Message-ID: <87eecb5hth.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, L=C3=A9na=C3=AFc Huard wrote:

[nits]

> +#ifdef __linux__
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	struct child_process child =3D CHILD_PROCESS_INIT;
> +
> +	strvec_pushl(&child.args, "systemctl", "--user", "list-timers", NULL);
> +	child.no_stdin =3D 1;
> +	child.no_stdout =3D 1;
> +	child.no_stderr =3D 1;
> +	child.silent_exec_failure =3D 1;
> +
> +	if (start_command(&child))
> +		return 0;
> +	if (finish_command(&child))
> +		return 0;
> +	return 1;
> +}
> +
> +#else
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	return 0;
> +}
> +
> +#endif

Ditto the Apple macro, i.e. if most/all of the code complies better to
just compile it on all platforms.

In 2/3 we have:
=09
	+struct maintenance_start_opts {
	+	enum scheduler scheduler;
	+};
=09
It's not mentioned (perhaps discussed in previous rounds) but I assumed
the struct would grow in 3/3, but it didn't. Why not pass "enum
scheduler " around directly?
