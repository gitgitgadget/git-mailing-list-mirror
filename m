Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE2C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED252311C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392828AbhALRTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392813AbhALRTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:19:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96421C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:18:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u19so3204389edx.2
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xAt2Wg8TekSDkRtVoUpAYRHMMLAuHVKaRKA+HHtKDHg=;
        b=Uquu+MXJa59doReZ4uyTCJsY7trX7a17+El05lOxVWyisQmWt1jDtYM83aOjgVeOEd
         hNs+CGxNJ662lCbRXnXt3ykLuKjyt+pEPmoF6/NkhjzwOq30Yc+0n4BE37Jdh8m3MlvO
         /213L32Dk8tRPNqV4pHV/wwE041O7pILbhVz3vIoA8npHuw6MGcv2HK8qfllvY3DCR4G
         tk1/oY1wFyPsZIb82NfhBaA7aomFCfY6MpsHagrJgF9CKrzMhbbQMsSInaFVlU32kxX7
         KTuPnFXIiARCJ61S0IVpeQWZuMTEjTCRTbSSK58YX7MmZryX/NSiC1dt+ZF7XoW6s4P6
         U11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xAt2Wg8TekSDkRtVoUpAYRHMMLAuHVKaRKA+HHtKDHg=;
        b=XPbGFfFsmBT+sMk6kS8mE0sxMhkiqad1YipKsrtgKXZeo4ZplY8MCMD4N3ri1Gmz8u
         p4Zx1xkk6OjBDEwjZvZy7zWApGEpg5FtYtHUNsW0UzWD2Y6NUCAyV8H3lIwaTaVuNJp8
         05THLdc7SCbTtlMrX82xO30Rc8VSrnWV6vwlnAXYRqOKhjl6K1X2XWZmzuoO1XK3XqaV
         Ufe8YAPtQa0kjC++8Musb6p/UuYydcxbcYhCELJ5l+J131A6I9MjoKqZG0c134EhaZ8G
         H3uDrbrI6o5UVyq33fiCrlI4hyOR754yhaj9p0Bv3/M1Xt7E55GUijwzO1iEzBog4mnH
         VxXw==
X-Gm-Message-State: AOAM530xCOqFtf7guEuKCHWNMaNnf/RupXsxZyqIEc7msRvZgw+2DC0r
        s/3tpQhggZYy94Vsj1h7HwEJlhh5Z9Q=
X-Google-Smtp-Source: ABdhPJwcL6kfgCF386TAGw/+qItpA2MDY1gfNMOpLeUmF9U2TfHLEMqhMnT2oWTk8o/6OOOcpiKrNw==
X-Received: by 2002:a50:b586:: with SMTP id a6mr152167ede.206.1610471909316;
        Tue, 12 Jan 2021 09:18:29 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n13sm1436202ejr.93.2021.01.12.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:18:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
References: <cover.1610129989.git.me@ttaylorr.com>
 <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
Date:   Tue, 12 Jan 2021 18:18:28 +0100
Message-ID: <875z425b17.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 08 2021, Taylor Blau wrote:

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/index-pack.c   | 5 ++++-
>  builtin/pack-objects.c | 2 ++
>  pack-revindex.h        | 2 ++
>  t/README               | 3 +++
>  4 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 03408250b1..0bde325a8b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1748,7 +1748,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	if (prefix && chdir(prefix))
>  		die(_("Cannot come back to cwd"));
>  
> -	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
> +	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
> +		rev_index = 1;
> +	else
> +		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));

Why not make an explicit GIT_TEST_WRITE_REV_INDEX=false meaningful? It's
also sometimes handy to turn these off in the tests.

    rev_index = git_env_bool("GIT_TEST_WRITE_REV_INDEX",
    	!!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV)));

> +#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"

Micro style nit: FWIW I'm not a fan of this macro->string indirection a
few GIT_TEST_* names have had since 859fdc0c3c (commit-graph: define
GIT_TEST_COMMIT_GRAPH, 2018-08-29).

Most of them just use git_env_bool("GIT_TEST_[...]") which IMO makes it
easier to eyeball a "git grep"

> +GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
> +'pack.writeReverseIndex' setting.
> +

Re the git_env_bool() default value comment above: I see our other
boolean GIT_TEST_* docs say "when true", but mostly they mean things
like:

    GIT_TEST_WRITE_REV_INDEX=<boolean>, when set, configures the
    'pack.writeReverseIndex' setting. Defaults to 'false'.
