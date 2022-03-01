Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1F7C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiCAIHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiCAIG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:06:59 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624A82D38
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:06:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a8so29777965ejc.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fj10WZEsMuVXXOlW0/3C8JEJTHSvXn3EQU82fIVkl3w=;
        b=FpvvBtwiigwyLE8ESCabt3nIdOWccRr62FDtdtFJrb1cxIsJWNqphDlm9RVrI7qEqI
         /omakwlfT0Z97awiinHyUceUsF3UlZf980ugVDW6HR3R2p0MKmQA5Q8lKGURMobOh683
         4tJu+3rQBw+jL4FGFCaNCajgt9LS1rWVjbDo/UPjtJCCsBDrh6/1OGibrxDgdvM0/pDb
         shfaZUCoBBQ51uXUnr8Tu9S7GOZYPv6I0IwyKyzRqZUBUtBFmULHbjX8sEeHU43AMAB0
         ME5nTBEPpDS8uqEvqhymIgPPzUBItM9Gvju0H6LKAzCsqInmdyr9ejf+e4qHVVQPA6hu
         xD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fj10WZEsMuVXXOlW0/3C8JEJTHSvXn3EQU82fIVkl3w=;
        b=A1D16E4zX9f0GpDnuvwMURxalUnnOhcp1ChM4/4PMazXZhcD/ke50edZrWMxMXst96
         mcr6aBw+u3h7UdRJDbtW6lDJ1q6YB/eky7DBKvvGvUwXqGk1Jf1245mxP0g3jMnjzzfm
         Sct9UyqGV7FLuVb9iW/HrEGsglLiG2+Bes1VsPpK3haQZCgkMb9yQasnXFBnRlPML5+x
         dzNlJJZFgg6MR7xgr3xFWDA5QusosEKJVLOpX01NRil51TGezFOg6E8nGdQ70uJI3S7F
         9VImtPFrphgalRoFBw8XUzYhtnZ3pPNbwjd7xAA2NtTqE6VHMbGGNi04OQL+u/Ho4zn7
         7P/w==
X-Gm-Message-State: AOAM5338LbUJYJGTlaDBMWIqrjzBrRpCC6k74X98JPYOMiqKRI09czPI
        IuHI3f8Uq5AxvANLtO45I0w=
X-Google-Smtp-Source: ABdhPJx8youF7MzmgTa6kwndiUXIq0qxwlWXIhnvDVCriatpleTNGxYNtUnCPaMNxiU3tysBanudQw==
X-Received: by 2002:a17:906:56cd:b0:6d6:e276:f455 with SMTP id an13-20020a17090656cd00b006d6e276f455mr2432075ejc.257.1646121976671;
        Tue, 01 Mar 2022 00:06:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id er12-20020a056402448c00b00413d03ac4a2sm1411320edb.69.2022.03.01.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:06:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOxWR-001woT-Ho;
        Tue, 01 Mar 2022 09:06:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/13] submodule--helper: refactor
 get_submodule_displaypath()
Date:   Tue, 01 Mar 2022 09:05:05 +0100
References: <20220301000816.56177-1-chooglen@google.com>
 <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-10-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220301044132.39474-10-chooglen@google.com>
Message-ID: <220301.86fso214i0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Glen Choo wrote:

> From: Atharva Raykar <raykar.ath@gmail.com>
>
> We create a function called `do_get_submodule_displaypath()` that
> generates the display path required by several submodule functions, and
> takes a custom superprefix parameter, instead of reading it from the
> environment.
>
> We then redefine the existing `get_submodule_displaypath()` function
> as a call to this new function, where the superprefix is obtained from
> the environment.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/submodule--helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 99341fb343..11afdeea8a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -247,11 +247,8 @@ static int resolve_relative_url_test(int argc, const=
 char **argv, const char *pr
>  	return 0;
>  }
>=20=20
> -/* the result should be freed by the caller. */

nit: I think it's better to retain this comment here...

> -static char *get_submodule_displaypath(const char *path, const char *pre=
fix)
> +static char *do_get_submodule_displaypath(const char *path, const char *=
prefix, const char *super_prefix)
>  {
> -	const char *super_prefix =3D get_super_prefix();
> -
>  	if (prefix && super_prefix) {
>  		BUG("cannot have prefix '%s' and superprefix '%s'",
>  		    prefix, super_prefix);
> @@ -267,6 +264,13 @@ static char *get_submodule_displaypath(const char *p=
ath, const char *prefix)
>  	}
>  }
>=20=20
> +/* the result should be freed by the caller. */

..than have it here, where we don't do the xstrfmt() but just call this wra=
pper.:

> +static char *get_submodule_displaypath(const char *path, const char *pre=
fix)
> +{
> +	const char *super_prefix =3D get_super_prefix();
> +	return do_get_submodule_displaypath(path, prefix, super_prefix);
> +}
> +
>  static char *compute_rev_name(const char *sub_path, const char* object_i=
d)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;

