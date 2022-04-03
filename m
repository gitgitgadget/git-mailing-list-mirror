Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C8C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353318AbiDCO5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiDCO5M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:57:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B010FD5
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:55:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot30so5183013ejb.12
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZNc+gR0tQdplMHSIcZoCiS85yA4T3KRwGO1b4nIUgHk=;
        b=j5jFzwmaoNnSCfRyi6D6v8USMgHAfI8LcsI58+PAjSsBznKrn76RcrfCScbTqpxghT
         EiQ1F1WQIWnfgoYbVkxF/P/rjl8/G754gdsRm5eNv6tZRG4Lb+P098VAIMa4azAzYQ54
         mx21bYtbJIyLfJCxBmC8PxvoB/kGjq08xvB18HoK2eHiFgk+911qZAWpYvnXFBdx1Saq
         cfX8iilLc/x6KW7v9ckZnWz7J6OPE5r9Yi6ir8/MW6l2t2XeTbuQ4XbIvDFmDTbz/mFz
         bWBSBnMhAXKhJQX+J9RA0KYWR/QoC6nIpjOtonZm0Ti69ilHJi+zdUYuwl3lgJ03Qywu
         d0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZNc+gR0tQdplMHSIcZoCiS85yA4T3KRwGO1b4nIUgHk=;
        b=TuZD/EaIi4wmMBBHbU8rTLNZg2agy4UG4b6eOEHtatUeuDqaaftpCj6hHDRyepoE20
         u29pVW6G3RSZk0iI3EWdukugMkfGK9qhDH1Z1hfJUb9spvcEEbNOripIXrP0iobK7GEy
         y8Gi5EnWJSRDXE7XTNhjWw1McKFjm8BNFjm+10LdiI9QsGK5mac2W1oD9qMPERKBAg89
         a/IEbDGAVWVe8b2IfJ0ilcRVJBYJLW/HQEUi0kn7+eRYhgZXUalt7B21XII8lv37gvaz
         otkg4myJq9+DrMrp2PjAHMRuMCIC86DfeUH9PRTA4XLUUhNb92TaEZgFfcsKJpmyEMIX
         /K5A==
X-Gm-Message-State: AOAM532qyPaKBhYpOhqAZDyI8gW8cZb0FZcHyGUjTJ0LvrVLFu8M/D0A
        CvPZV6L4kTGsxwtDQwZOfW6xgL5uZKo=
X-Google-Smtp-Source: ABdhPJyl0vthg4REA+TvXeCAnG6VtOQfDKkYMm9nU5lfJ+Suq7oSMuCfsRKQ3tZOZgeu+tBqdy+VXw==
X-Received: by 2002:a17:907:160b:b0:6e1:116e:7a59 with SMTP id hb11-20020a170907160b00b006e1116e7a59mr7182408ejc.579.1648997715849;
        Sun, 03 Apr 2022 07:55:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402090a00b004196250baeasm3874656edz.95.2022.04.03.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:55:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb1dK-002FTU-Ro;
        Sun, 03 Apr 2022 16:55:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/6] i18n: factorize generic failure messages
Date:   Sun, 03 Apr 2022 16:47:16 +0200
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
 <4bba3e1f6cb9cdc35b0dc8da440e38de256b4d2b.1648915853.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <4bba3e1f6cb9cdc35b0dc8da440e38de256b4d2b.1648915853.git.gitgitgadget@gmail.com>
Message-ID: <220403.86k0c6kyi5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 02 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> [...]
> diff --git a/add-patch.c b/add-patch.c
> index 55d719f7845..8c9e81ec78e 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1181,7 +1181,7 @@ static int run_apply_check(struct add_p_state *s,
>  			    "apply", "--check", NULL);
>  	strvec_pushv(&cp.args, s->mode->apply_check_args);
>  	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
> -		return error(_("'git apply --cached' failed"));
> +		return error(_("the command '%s' failed"), "git apply --cached");
>=20=20
>  	return 0;
>  }
> @@ -1683,7 +1683,7 @@ soft_increment:
>  			strvec_pushv(&cp.args, s->mode->apply_args);
>  			if (pipe_command(&cp, s->buf.buf, s->buf.len,
>  					 NULL, 0, NULL, 0))
> -				error(_("'git apply' failed"));
> +				error(_("the command '%s' failed"), "git apply");
>  		}
>  		if (repo_read_index(s->s.r) >=3D 0)
>  			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
> diff --git a/builtin/am.c b/builtin/am.c
> index 0f4111bafa0..a0a57049510 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -586,7 +586,7 @@ static int is_mail(FILE *fp)
>  	int ret =3D 1;
>=20=20
>  	if (fseek(fp, 0L, SEEK_SET))
> -		die_errno(_("fseek failed"));
> +		die_errno(_("the function '%s' failed"), "fseek");
>=20=20
>  	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
>  		die("invalid pattern: %s", header_regex);


I don't think this needs to happen now, but I wonder if it would be
worth it as a follow-up to e.g. create a gettext-common.h or something,
with macros like:

	#define I18N_COMMAND_FAILED N_("the command '%s' failed")
	#define I18N_FUNCTION_FAILED_ERRNO N_("the library function '%s' failed")

Then:

	error(_(I18N_FUNCTION_FAILED_ERRNO), "git apply");
	die_errno(_(I18N_FUNCTION_FAILED_ERRNO), "fseek");

But OTOH all the gettext tooling already takes care of that, so maybe
it's not worth it. I.e. "jump to definition" would jump to the wrapper
header, as opposed to the actual code involved.

So having written that, probably not. Maybe the only worthwhile thing
would be some Levenshtein distance check in CI or something to see if
we're adding strings that are too similar to existing ones...
