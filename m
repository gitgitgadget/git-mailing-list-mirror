Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA7C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E2261037
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhKFVfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhKFVfi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:35:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0866DC061714
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:32:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b15so26719876edd.7
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w1P4saQv9f1EEZg+s45bUVttCPvHT9qfX2yG+MujfIA=;
        b=pP7ZDyXefOQyjySibGlmnRdp0uiu12lUrLuqCasWlls8F4jrwWCArhsmWXyTazXOcd
         SD1qp4pS/6FgBjp8Ttsfu9evlGctwTgwynWH6uqTq0Av6jKhgHPUI21KYqZUs2HnHKk2
         A/zsWXqniFm/nhoJpSFSHA5aZt5uf/X2JjCJniUDGjt/VvJl1S0fhR5CoYwk+Eyzp8C3
         +oIaPi71rKlRKR4l3wy+6xNAfjImoJgVpLQVm3XNdYGWIHhcjWOjKMq70s8AGogij+a1
         AIcN3nCqrUTjKbnB6LSnN1M5NLaLdqF3bkg85pRvkidrFWTInig5E18BEo7/XCR7pMen
         aZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w1P4saQv9f1EEZg+s45bUVttCPvHT9qfX2yG+MujfIA=;
        b=7VRwYMdT6SiZCCDxu1GBoZOTfDS+3nQOdM+gx/59dC9Bt+jrWSxaoQjXIxvN2YZLwF
         a1X7JaP2MTqtJIUuvKUEtbGF9wGQq3PQ0Yfqb+81uEqkd589YlxAlG4+AlBet0Jl7utV
         aJUsbNccZ2ktaCJ92Fno/WzwfK/IiKNDGzJv46ubJGi/Q+ZSUlqn8TbKtziACGuoqBWM
         Rjg4TgRBZ2dIEcSOW4ab+KM0bsd/pDVOK5qOhMhM6rvDqa9onJtzJQqKX0czzjZeVoxh
         EosxBidcnU2QvjVYFmUAqcAZ7fq9oltFlJIuJsMrShD14blozseFecflSlI0GE8x2A07
         Qalw==
X-Gm-Message-State: AOAM531TXyXk+i8vj52PpWAmhiYfLceMu14Anj363Tsj5Tma89Uq5j7X
        07DVcm+dOpx63WrcpXZ2liG5qWPr55hgDw==
X-Google-Smtp-Source: ABdhPJw0tWAhEVN4aXhVuhT86Yf0jZLncExiIuWZ4Tz8wscP+2ZXaRilrvvp2x/YNr0dNANnY63W9g==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr37789206edd.392.1636234375561;
        Sat, 06 Nov 2021 14:32:55 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r19sm6630827edt.54.2021.11.06.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:32:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjTJ0-000n9l-HM;
        Sat, 06 Nov 2021 22:32:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 03/10] parse-options.[ch]: consistently use "enum
 parse_opt_result"
Date:   Sat, 06 Nov 2021 22:31:33 +0100
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
 <patch-v3-03.10-828e8b96574-20211008T190536Z-avarab@gmail.com>
 <20211106191103.GA5811@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211106191103.GA5811@szeder.dev>
Message-ID: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 06 2021, SZEDER G=C3=A1bor wrote:

> On Fri, Oct 08, 2021 at 09:07:39PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Use the "enum parse_opt_result" instead of an "int flags" as the
>> return value of the applicable functions in parse-options.c.
>>=20
>> This will help catch future bugs, such as the missing "case" arms in
>> the two existing users of the API in "blame.c" and "shortlog.c". A
>> third caller in 309be813c9b (update-index: migrate to parse-options
>> API, 2010-12-01) was already checking for these.
>>=20
>> As can be seen when trying to sort through the deluge of warnings
>> produced when compiling this with CC=3Dg++ (mostly unrelated to this
>> change) we're not consistently using "enum parse_opt_result" even now,
>> i.e. we'll return error() and "return 0;". See f41179f16ba
>> (parse-options: avoid magic return codes, 2019-01-27) for a commit
>> which started changing some of that.
>>=20
>> I'm not doing any more of that exhaustive migration here, and it's
>> probably not worthwhile past the point of being able to check "enum
>> parse_opt_result" in switch().
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>
>> diff --git a/parse-options.c b/parse-options.c
>> index 9c8ba963400..f718242096c 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -699,13 +699,14 @@ static void free_preprocessed_options(struct optio=
n *options)
>>  	free(options);
>>  }
>>=20=20
>> -static int usage_with_options_internal(struct parse_opt_ctx_t *,
>> -				       const char * const *,
>> -				       const struct option *, int, int);
>> -
>> -int parse_options_step(struct parse_opt_ctx_t *ctx,
>> -		       const struct option *options,
>> -		       const char * const usagestr[])
>> +static enum parse_opt_result usage_with_options_internal(struct parse_o=
pt_ctx_t *,
>> +							 const char * const *,
>> +							 const struct option *,
>> +							 int, int);
>> +
>> +enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>> +					 const struct option *options,
>> +					 const char * const usagestr[])
>>  {
>>  	int internal_help =3D !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
>>=20=20
>> @@ -839,10 +840,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
>>  	return ctx->cpidx + ctx->argc;
>>  }
>>=20=20
>> -int parse_options(int argc, const char **argv, const char *prefix,
>> -		  const struct option *options,
>> -		  const char * const usagestr[],
>> -		  enum parse_opt_flags flags)
>> +enum parse_opt_result parse_options(int argc, const char **argv,
>
> The return type of this function should have been left unchanged,
> because it contains only one return statement:
>
>           return parse_options_end(&ctx);
>
> and parse_options_end() does return an int.

Indeed. I'll submit a fix for that sooner than later. I think I got that
and *_step() mixed up, parse_options() just returns "here's what we've
got left in argc".

I think due to C's happy-go-lucky enum-as-int semantics I'll probably
leave it until post-2.34, i.e. I don't think it can/will break anything
at runtime, but should be fixed for sure.

Thanks for spotting!
