Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA5C4167B
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiLMInP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLMInF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 03:43:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F371E40
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 00:43:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so34777306ejc.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fdpNSptqiRGPlcYUk0QSYU02eI2+FpX47PWcArGBp7U=;
        b=ZJN3475060OyEF5LnyDoEQ1H3G4wrq+MLEDLWnO6uEipx3rFTc6lHiy02nG4Lqweax
         qrqHYWYa2V9yoPonB9tswqb/Gu971GeYZmIGFcwL+h1FZY6w1EcKjHftrKgvpAnHybaH
         fCKmcnm8cSUUsE4Hsd+oDBtRVBcqoLjvzqnQ4NChbSFE6jquu8k+GnfXU06K8O/HZbQ3
         aDuH4Q3UNOqEiB0dN7zyNaSIGg3Sd1c0sou88U/ZwA25rWad97xsIYJnxoS787T52dP+
         l28NluYe1isdlo5W0//HbYxvSGzJ60vKD2SzDs6N+clfH3pgYgDk/RB5UtwB3iLU9JID
         e2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdpNSptqiRGPlcYUk0QSYU02eI2+FpX47PWcArGBp7U=;
        b=2jz2L3D4VJOcm7fIDUkkwOUwPW2cGVQxyzt3rY0GuuLMeUvUUzrii/ugN4sH+OMbuH
         LdxSphR2wwaErVOL8NPbdkZQDAUILvnbBYUXo/SXp32tA9uBCqvz6V/REvC8IcvnWXOd
         r4JxiqKwFZUWTMBsTklGJqNtV5Lr6iwxw/IEzn+h9UTUKvhTqrsx/BbWevUg20MCpfml
         2OiB19KDfFi10q5MV0JXawkYiQocV90muxCdYoAWfvmBjDukLzj8mTMwZfWm96nXseyb
         qX9B241GJC9Y60l9CgLdamnFk9bgVtMfu6NSje/MvPvApHdTu3+Q27Y1h8AWkIftfDu9
         gFaQ==
X-Gm-Message-State: ANoB5pn145Dtr/X3AikCvZRZQH/M52sYqKqDefcjSVt+3OZZNWwgzmia
        oTqSJIp7/WE1g9mZZzeXHxwqsYPDjGE=
X-Google-Smtp-Source: AA0mqf5qrYzKrKXTJvhHRoVC5i4H79TjbNAmpCVUGHlzqu3IVjMArXlJt/fYOPZ1GXX4aXF5ONU/FQ==
X-Received: by 2002:a17:907:c586:b0:7c1:700:9c4b with SMTP id tr6-20020a170907c58600b007c107009c4bmr21019524ejc.75.1670920982844;
        Tue, 13 Dec 2022 00:43:02 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fs31-20020a170907601f00b007c14ae38a80sm4181713ejc.122.2022.12.13.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 00:43:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p50sP-005V6L-31;
        Tue, 13 Dec 2022 09:43:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Date:   Tue, 13 Dec 2022 09:37:24 +0100
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
Message-ID: <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 13 2022, Ren=C3=A9 Scharfe wrote:

> apply_parse_options() passes the array of argument strings to
> parse_options(), which removes recognized options.  The removed strings
> are not freed, though.
>
> Make a copy of the strvec to pass to the function to retain the pointers
> of its strings, so we release them all at the end.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/am.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 30c9b3a9cd..dddf1b9af0 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *state, =
const char *index_file)
>  	int res, opts_left;
>  	int force_apply =3D 0;
>  	int options =3D 0;
> +	const char **apply_argv;
>
>  	if (init_apply_state(&apply_state, the_repository, NULL))
>  		BUG("init_apply_state() failed");
> @@ -1483,7 +1484,15 @@ static int run_apply(const struct am_state *state,=
 const char *index_file)
>  	strvec_push(&apply_opts, "apply");
>  	strvec_pushv(&apply_opts, state->git_apply_opts.v);
>
> -	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
> +	/*
> +	 * Build a copy that apply_parse_options() can rearrange.
> +	 * apply_opts.v keeps referencing the allocated strings for
> +	 * strvec_clear() to release.
> +	 */
> +	ALLOC_ARRAY(apply_argv, apply_opts.nr);
> +	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
> +
> +	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
>  					&apply_state, &force_apply, &options,
>  					NULL);
>
> @@ -1513,6 +1522,7 @@ static int run_apply(const struct am_state *state, =
const char *index_file)
>  	strvec_clear(&apply_paths);
>  	strvec_clear(&apply_opts);
>  	clear_apply_state(&apply_state);
> +	free(apply_argv);
>
>  	if (res)
>  		return res;

I don't mind this going in, but it really feels like a bit of a dirty
hack.

We have widespread leaks all over the place due to this
idiom. I.e. parse_options() and a couple of other APIs expect that they
can munge the "argv", which is fine if it arrives via main(), but not if
we're editing our own strvecs.

I think less of a hack is to teach the eventual parse_options() that
when it munges it it should free() it. I did that for the revisions API
in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
need free()-ing, 2022-08-02).

What do you think?
