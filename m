Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43233C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiK3Tfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3Tfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 14:35:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627598B188
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:35:28 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id b2so27546650eja.7
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5HEV9LTWG8RUziQFD4DWm53/NzIfJCzdN8eno65C7A=;
        b=LF10KPgPjMNJ9l+eul7IDE9mbxqdZDZU2HKk9W0uD/uCx7S7uph4bFupLL755m16z7
         Hf5fCTZlIIoQKol+c46r5iS8m2THypRoIA8Vb0by0lf6DFgh6//B5TlYEp9F6dd96fDE
         mksX4yMn8n7Vq8nHWccR7CXU6olE6TikcUahFxlxnuWdmZupWF95wGxtPSNZ9JYuE+K8
         1FeV7f0tW+ZGk965yo06U6GH7c7LVbjDZYGlWpW37RD8WG5v//e4Bqzl8GlNWHxygh++
         4ojnq/BQ78EccfUECUEaDUved6lNRMhJgACUN9V3bx9abPZnI+9+2bxqTmPnEZCk7O5h
         hODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5HEV9LTWG8RUziQFD4DWm53/NzIfJCzdN8eno65C7A=;
        b=ZFN2DuFgl7kBtj9zKA701cU1Nl6/aZU8CKwlnQlhraL5fRK2pEO4cIcaG9MZOqGB8F
         47mLhdKlW1s1b01cvi9064iEdcVbFuEpq3XGGUct5wG7PhNPAzoLpeMvHe+YJc4lwJIT
         S7VtYn52RNvTbmfLoyvjPmyjS8kR5ZZKPtaN4WnRwt7+6WbxGp9asyd23Wd/NyQ/R0d/
         psnO3yOEzigaCqN2oahq89hR8NkGxoT1U+nZnho4Ls1aKasComcVrl7j1vcNbc6U2DPQ
         0wPYbewzbSTXqwvMC5fa/DgZ71EMPsKRdrBpdNGaCHxGImie7yYe0aC18v01on7LhrCI
         //jg==
X-Gm-Message-State: ANoB5pnZAiU1yCDOoHXGXb+qUOI6Iy0d2m38WVX2rN5zLb7QBRl8IdOb
        +Zv7LaP5kx3e8YQYRrq/XJo=
X-Google-Smtp-Source: AA0mqf7pF6K/y/Pene0XRHGcPPM83/R3h7z1FUd3rrKjMFYQW1l32zZZdwiweqE+W0PdzdQR+Un5JA==
X-Received: by 2002:a17:906:4309:b0:78d:36d7:92ae with SMTP id j9-20020a170906430900b0078d36d792aemr37176238ejm.113.1669836926710;
        Wed, 30 Nov 2022 11:35:26 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ju10-20020a17090798aa00b007bb751f9d10sm961996ejc.77.2022.11.30.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:35:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0Src-00212e-0m;
        Wed, 30 Nov 2022 20:35:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Don't pass -v to submodule command
Date:   Wed, 30 Nov 2022 20:17:23 +0100
References: <FR3P281MB21416B718C4C052A28C319B1E90F9@FR3P281MB2141.DEUP281.PROD.OUTLOOK.COM>
 <1ff185c5-4a9e-36e3-3141-8b149c1c7bb0@cs-ware.de>
 <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cad05012-7bf9-5975-3add-253b11c7bcc8@cs-ware.de>
Message-ID: <221130.868rjsi6bn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Sven Strickroth wrote:

> "git pull -v --recurse-submodules" propagates the "-v" to the submdoule
> command which does not support "-v".
>
> Commit a56771a668dd4963675914bc5da0e1e015952dae introduced this
> regression.

We refer to commits in commit messages like this: a56771a668d
(builtin/pull: respect verbosity settings in submodules, 2018-01-25);

Which also shows that this regression is quite old.

> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  builtin/pull.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1ab4de0005..b67320fa5f 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -256,7 +256,7 @@ static struct option pull_options[] = {
>  /**
>   * Pushes "-q" or "-v" switches into arr to match the opt_verbosity level.
>   */
> -static void argv_push_verbosity(struct strvec *arr)
> +static void argv_push_verbosity(struct strvec *arr, int include_v)
>  {
>  	int verbosity;
>

It looks like you're getting somewhere with this, but you never use this
"include_v", so the bug is still there. We just have the scaffolding
now.

Did you forget to add that part to this commit?

In any case, that serves as a comment on the other thing this patch
really needs: tests, please add some.

I can reproduce this locally by just running the command you noted in a
repo with submodules, so presumably we can use some of the existing
submodule tests, which have already set up such a repo.

> @@ -520,7 +520,7 @@ static int run_fetch(const char *repo, const char **refspecs)
>  	strvec_pushl(&cmd.args, "fetch", "--update-head-ok", NULL);
>
>  	/* Shared options */
> -	argv_push_verbosity(&cmd.args);
> +	argv_push_verbosity(&cmd.args, 1);
>  	if (opt_progress)
>  		strvec_push(&cmd.args, opt_progress);
>
> @@ -629,7 +629,7 @@ static int rebase_submodules(void)
>  	cp.no_stdin = 1;
>  	strvec_pushl(&cp.args, "submodule", "update",
>  		     "--recursive", "--rebase", NULL);
> -	argv_push_verbosity(&cp.args);
> +	argv_push_verbosity(&cp.args, 0);
>
>  	return run_command(&cp);
>  }
> @@ -642,7 +642,7 @@ static int update_submodules(void)
>  	cp.no_stdin = 1;
>  	strvec_pushl(&cp.args, "submodule", "update",
>  		     "--recursive", "--checkout", NULL);
> -	argv_push_verbosity(&cp.args);
> +	argv_push_verbosity(&cp.args, 0);
>
>  	return run_command(&cp);
>  }
> @@ -657,7 +657,7 @@ static int run_merge(void)
>  	strvec_pushl(&cmd.args, "merge", NULL);
>
>  	/* Shared options */
> -	argv_push_verbosity(&cmd.args);
> +	argv_push_verbosity(&cmd.args, 1);
>  	if (opt_progress)
>  		strvec_push(&cmd.args, opt_progress);
>
> @@ -881,7 +881,7 @@ static int run_rebase(const struct object_id *newbase,
>  	strvec_push(&cmd.args, "rebase");
>
>  	/* Shared options */
> -	argv_push_verbosity(&cmd.args);
> +	argv_push_verbosity(&cmd.args, 1);
>
>  	/* Options passed to git-rebase */
>  	if (opt_rebase == REBASE_MERGES)

I think the right longer term fix here is to simply make "git submodule"
support "-v" and "--verbose".

Which, as a funny implementation detail we'd support if we called "git
submodule--helper update", as its OPT__QUIET() adds both variants, but
the git-submodule.sh doesn't support it.

OTOH we've never supported it in "git submodule", so maybe we should
just make the C version stricter, I dunno...

In any case, this is a good fix for now, let's just stop passing the
unsupported flag.
