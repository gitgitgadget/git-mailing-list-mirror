Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD08C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EAD61181
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhKIXWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhKIXWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:22:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADEC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 15:19:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b15so2862723edd.7
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 15:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6Qo3EvnOX2ODzzD9NANi9KU3tftS57l+jA++43rGVkM=;
        b=hWrQZdg2dC42em3m3sLnU+nPCPUR/gndUL177V64GDr+0ZNz2uMhEIPZXAWoDuC8Np
         l8VPVVOlXyTxcGWvSggSDhxFQAk4fYCUXUR2loqIqYfFEL1GMS8v/qnm+dkLPdfT2PYe
         zKvIRrHHwJad0GXes9ua9H+D2YSWJK874qry2t3PiqwpRyNmeXY/zqWX9ZxyTBolP+8v
         lErajcK6EruwDyt1Myhp5AfHVPKI3co0kKhB7T81naeD1YgXz5qySPqkiRijQRcjbHM2
         +BDvKY9vQxF0wI2vcAFm+TaWDeI3y08S5bbxLzM8kbsXgImB+QVXfVfQiKUySpf1eUGZ
         ziGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6Qo3EvnOX2ODzzD9NANi9KU3tftS57l+jA++43rGVkM=;
        b=5TGd2TPNjDq/Usa19oeVaekZvDBMVU6VU4i4CVNyZ3utnT+olqRbeUK4fC0AcaW7zw
         u9Xhg5HwNsKl+KuELcPIVqO9FTwOvzKwLmr3prr9ep2fNC/RnbzcO2lrPsWM+bL3NZol
         fD3QhRn6c1jDvdIvs8WsSth1al+g8gbLUCfOtS1Xi7sm+8mhSfEmPo+A5wFbNb0sdgVs
         /9TcOeaMkZ3Q2NzyXSoB2Nv5MzhWVrqVB0nsfmtoB6aFn00PieSNmbq5RtAAUfT1Nrct
         kBLFjNJag0LXEtjorFiKDFE6KQI4GF25bb/TRDPE1wjY/iCEuqXOWMmgwH4w4etvlh0i
         MM5w==
X-Gm-Message-State: AOAM5317CYMPasQla3Je72N+zkdSEbyxawcDElSFSKcAqH9ljbfjfIQi
        aJMnd/783osQBWfYM14X/kk=
X-Google-Smtp-Source: ABdhPJy3HZcCgjJ+A1i+hlAag4esTKv5qTMgdTgyocyj5RJ1tcmqqkLN5kmpD5QNMBl4HyIZWiihAw==
X-Received: by 2002:a05:6402:615:: with SMTP id n21mr15447999edv.117.1636499975566;
        Tue, 09 Nov 2021 15:19:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u16sm3883776edr.43.2021.11.09.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 15:19:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkaOs-000U8d-KH;
        Wed, 10 Nov 2021 00:19:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] parse-options.c: use "enum parse_opt_result" for
 parse_nodash_opt()
Date:   Wed, 10 Nov 2021 00:18:24 +0100
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
 <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
 <patch-2.2-aa6224b10f8-20211109T110113Z-avarab@gmail.com>
 <xmqqo86t2oud.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqo86t2oud.fsf@gitster.g>
Message-ID: <211110.867ddgkjcp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the parse_nodash_opt() function to use "enum
>> parse_opt_result". In 352e761388b (parse-options.[ch]: consistently
>> use "enum parse_opt_result", 2021-10-08) its only caller
>> parse_options_step() started using that return type, and the
>> get_value() which will be called and return from it uses the same
>> enum.
>>
>> Let's do the same here so that this function always returns an "enum
>> parse_opt_result" value.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  parse-options.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/parse-options.c b/parse-options.c
>> index fc5b43ff0b2..629e7963497 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -404,8 +404,9 @@ static enum parse_opt_result parse_long_opt(
>>  	return PARSE_OPT_UNKNOWN;
>>  }
>>=20=20
>> -static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
>> -			    const struct option *options)
>> +static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
>> +					      const char *arg,
>> +					      const struct option *options)
>>  {
>>  	const struct option *all_opts =3D options;
>>=20=20
>> @@ -415,7 +416,7 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *=
p, const char *arg,
>>  		if (options->short_name =3D=3D arg[0] && arg[1] =3D=3D '\0')
>>  			return get_value(p, options, all_opts, OPT_SHORT);
>>  	}
>> -	return -2;
>> +	return PARSE_OPT_ERROR;
>>  }
>
> The current caller only checks to skip a token that yields 0 (aka
> PARSE_OPT_DONE) and does not distinguish between other values, so
> this won't change the behaviour of the current code, but it is=20
> not clear if returning -1 (aka PARSE_OPT_ERROR) is better than -2
> (aka PARSE_OPT_HELP).

I think PARSE_OPT_ERROR is probably better.

It looks like the -2 return value might have been somewhat blindly
copy/pasted between 07fe54db3cd (parse-opt: do not print errors on
unknown options, return -2 intead., 2008-06-23) and 51a9949eda7
(parseopt: add PARSE_OPT_NODASH, 2009-05-07).

I.e. we use the full enum values for the code in the former, but in the
latter we're just looking for "not zero", so error/-1 seemed like a
better fit.

