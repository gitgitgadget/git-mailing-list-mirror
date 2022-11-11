Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8848C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 14:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiKKOO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiKKOOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 09:14:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A471F33
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:04:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m22so12735937eji.10
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D4n1JUqpMot2nUsZZLLHLhqvnO2GqEAQRM902EPlrTE=;
        b=PNOSQnAi/ntJUKYIHyf4eKuq2ssoXTyE3JHK8bGQB8Df3n6kNvw4rAhRbjgmhI+5lg
         gxkufgtKQNzHr0Mb8OHoahbRDuXSuPHyfwqNG7yGuMccYFdGfCQHB+VU9JPSS7TxiWNj
         oe6FPgi1+66yTbup/RYGnCCQ0G50JLELsrwWPw2c2rpoBVuudwVwH2/BlH4y5erJke4e
         tdlNnK1geYKwdRjHWUftGbLlF2nPKlSttTayBa7QIkT+Iww4eilvYIEhzKzRrVY1+6hJ
         MghhnF1vaA+mTLpZTfW4bTjRgLQrYADHPDX6g0O0K9yTD8BYXyRRouVNuiekhCVcoET0
         MkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4n1JUqpMot2nUsZZLLHLhqvnO2GqEAQRM902EPlrTE=;
        b=34jL/BMmerZ2sGB435g6cSNcT+cfLBN4i+jSJAV+pWcrYgru7lruEilU4kq7rJ1hmV
         Hbped1tuwDqQrfgXmMfy8Be1+RT5N8N9yAAFYr3ffsI3aiQjsvJijhqLn5vTlcVrf7PI
         Lf/nGRyHkRZYBOF9/iLXSDgyc+QnwJ+9WQyTEVZaYcyshOhheLpk0YJC7oBs/sef8P1C
         uq88qax/UIdwBAiFz974KkXlIKAxzBiJlJdW1M6e0R44BOeeGfU32Wbry9LHAx1lKgLs
         orZvHVHh+yYrF2nQZjhjxClnqcJIYAiwfT3sDO4rL94FN1Xq01oNTQReJABM6tmoA/fG
         ZzLA==
X-Gm-Message-State: ANoB5pkHQUkmDQciiVlwTrzAiTePUm4jmTeo9GTF+mmoyeJsQjiV3G+B
        m345ZHMpssvVdmWFOObXPUFz4/7GQFOYSQ==
X-Google-Smtp-Source: AA0mqf6Vkl3cVwFe4iFd/Cu8vxkNWlc6jxN2ltiAEVZgbp4nOD78ucLIIYS0H1BB4lGOa8iN5wS2Gg==
X-Received: by 2002:a17:907:7853:b0:78d:ee08:1867 with SMTP id lb19-20020a170907785300b0078dee081867mr2079658ejc.123.1668175495169;
        Fri, 11 Nov 2022 06:04:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709066b0100b0073d83f80b05sm917245ejr.94.2022.11.11.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:04:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otUeM-001uvZ-0R;
        Fri, 11 Nov 2022 15:04:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 10/11] bisect--helper: log: allow arbitrary number of
 arguments
Date:   Fri, 11 Nov 2022 15:01:38 +0100
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
 <de3075eff9ffffea27d19e749af897b72f83ef41.1668097966.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <de3075eff9ffffea27d19e749af897b72f83ef41.1668097966.git.congdanhqx@gmail.com>
Message-ID: <221111.86iljload5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In a later change, we would like to turn bisect into a builtin by
> renaming bisect--helper.
>
> However, there's an oddity that "git bisect log" accepts any number of
> arguments and it will just ignore them all.
>
> Let's prepare for the next step by ignoring any arguments passed to
> "git bisect--helper log"
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  builtin/bisect--helper.c | 4 +---
>  git-bisect.sh            | 2 --
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 29d5a26c64..6066f553fd 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1347,10 +1347,8 @@ static int cmd_bisect__next(int argc, const char *=
*argv UNUSED, const char *pref
>  	return res;
>  }
>=20=20
> -static int cmd_bisect__log(int argc, const char **argv UNUSED, const cha=
r *prefix UNUSED)
> +static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, co=
nst char *prefix UNUSED)
>  {
> -	if (argc)
> -		return error(_("'%s' requires 0 arguments"), "git bisect log");
>  	return bisect_log();
>  }
>=20=20
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 9f6c8cc093..f95b8103a9 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -57,8 +57,6 @@ case "$#" in
>  	case "$cmd" in
>  	help)
>  		git bisect -h ;;
> -	log)
> -		git bisect--helper log || exit ;;
>  	*)
>  		git bisect--helper "$cmd" "$@" ;;
>  	esac

I'm agnostic on whether we keep this oddity, or just say we're fixing it
as we're converting things. We could also go for some in-between and
issue a warning(), if we suspect users in the wild are relying on this
for whatever reason.

I'd be fine with just making it error. E.g. in my upcoming (and already
aired on the list as an RFC) series to migrate git-submodule.sh to a
built-in I *do* change some behavior, because some of it's too insane to
carry forward in a bug-for-bug compatible way.

But I when doing so I add tests for it, explain why etc.

So, I think whatever we do here, we should be adding tests for this. If
it's worth preserving it's worth testing.
