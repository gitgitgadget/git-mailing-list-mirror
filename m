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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE9C28CAE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EED76128A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348237AbhIUCXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhIUB4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:56:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81EC0DBABD
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:35:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v5so66265365edc.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PKvI3/7O7S5mOsVB3trkhZWQ/OXtgnVEyFeg7ug2x7Q=;
        b=GetguOrqmtZAtAeHph80p6tcM9Gwpgsm0fyJLLH/GID3+BPm1+5Xr0tgHr5S806xdR
         QL+KWk7N+O8VJajWrBPumGjXZS0na0v9a6J7quF+ODNo3K6q8HStFi5VxD5+M/ZfQPwA
         edcF6BLikhtuzASnvwsi9KVaVj3y3KtYcElzEeAeFVjUPcAV3i1p59t+bzKaD18iYphv
         cEaC1nwLV5fuBJvc9DbgqLMsA6HX3wa4f2S0iWWWUByOSEqRS0e91Kgq5FyVKaaQUjNZ
         o5qeo2P7+UvkzkzhwTHxMWO7G9682Z+0d2ITtEx/NTfqmdBnpNwOtzxxoTq+DYrg2rX4
         u5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PKvI3/7O7S5mOsVB3trkhZWQ/OXtgnVEyFeg7ug2x7Q=;
        b=eOLkfyyAg7M7pD/ZpZc0miqZ6RV/LywLLq3h2EQ5mGTVcKvHXKxeKt09SxhlUb1VyG
         pH2K8BA6MejOGqIAYUz3n7sclU+1NGCJSMejVNYESd2RPfiaKAZSyxkhEMLp1mGe4HJx
         lU3kzrN3HGRFmPVdPq7JGOPy8pyBYWKBelZ10F1Vo3/i6tgFh3g0pt2IrM8/RJnRQZrU
         LUmX0uHTd05OaBtpdD+0FiWnMLXYJ0+e7/Ttp8YFeYEy5oBiEgfyfO0DlsBiEDgZqQUR
         uKHWZ48PGvhwTISQhiExpCPTf4ep6JUkJ4AaTxlBTBpJUZRhgrjY7CC5nUUFkKfVi8PY
         wdKg==
X-Gm-Message-State: AOAM531C/6mBC6tn/LL1cc9mlGZAbR9y0LE6wxcGXLYRAWtW1zsO+v+n
        lJvGNwty/FLCRfYkQ2ylOKsdjKSZIX6uzg==
X-Google-Smtp-Source: ABdhPJw8Ubw2pLS3qGE04j6ugdcGwg1ZyQiECqwMAMTiOGyI6KgEgyfrikazUdKdoi8mQhH0sCa3ZA==
X-Received: by 2002:a17:906:8151:: with SMTP id z17mr30858260ejw.468.1632180918583;
        Mon, 20 Sep 2021 16:35:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e28sm7570499edc.93.2021.09.20.16.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:35:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] read-cache & fetch-negotiator: check "enum"
 values in switch()
Date:   Tue, 21 Sep 2021 01:33:20 +0200
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
 <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
 <patch-v3-3.5-d837d905825-20210919T084703Z-avarab@gmail.com>
 <YUkH1LSa1WcFDmvr@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUkH1LSa1WcFDmvr@nand.local>
Message-ID: <87pmt2aki2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Taylor Blau wrote:

> On Sun, Sep 19, 2021 at 10:47:17AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change tweak_untracked_cache() in "read-cache.c" to use a switch() to
>> have the compiler assert that we checked all possible values in the
>> "enum untracked_cache_setting" type, and likewise remove the "default"
>> case in fetch_negotiator_init() in favor of checking for
>> "FETCH_NEGOTIATION_UNSET" and "FETCH_NEGOTIATION_NONE".
>>
>> As will be discussed in a subsequent we'll only ever have either of
>
> s/subsequent/& patch/ ?

Thanks.

>> these set to FETCH_NEGOTIATION_NONE, FETCH_NEGOTIATION_UNSET and
>> UNTRACKED_CACHE_UNSET within the prepare_repo_settings() function
>> itself. In preparation for fixing that code let's add a BUG() here to
>> mark this as unreachable code.
>>
>> See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
>> for when the "unset" and "keep" handling for core.untrackedCache was
>> consolidated, and aaf633c2ad1 (repo-settings: create
>> feature.experimental setting, 2019-08-13) for the addition of the
>> "default" pattern in "fetch-negotiator.c".
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  fetch-negotiator.c |  4 +++-
>>  read-cache.c       | 15 ++++++++++-----
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/fetch-negotiator.c b/fetch-negotiator.c
>> index 57ed5784e14..237f92b8696 100644
>> --- a/fetch-negotiator.c
>> +++ b/fetch-negotiator.c
>> @@ -19,8 +19,10 @@ void fetch_negotiator_init(struct repository *r,
>>  		return;
>>
>>  	case FETCH_NEGOTIATION_DEFAULT:
>> -	default:
>>  		default_negotiator_init(negotiator);
>>  		return;
>> +	case FETCH_NEGOTIATION_NONE:
>> +	case FETCH_NEGOTIATION_UNSET:
>> +		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
>
> I was briefly confused why this BUG message mentioned
> FETCH_NEGOTIATION_UNSET, since we only support FETCH_NEGOTIATION_DEFAULT
> here.
>
> But then I realized that it said "only in prepare_repo_settings()", and
> we're in fetch_negotiator_init(). So this makes sense to me.
>
> Other than the small typo in the patch message, this looks good to me.

I guess I'll also mention NONE here, so:

    BUG("FETCH_NEGOTIATION_{NONE,UNSET} only in prepare_repo_settings()");

Or elaborate a bit:

    BUG("FETCH_NEGOTIATION_{NONE,UNSET} used outside of prepare_repo_settin=
gs()!");

In any case this lives for just one commit, and is just here to
demonstrate the transition we're in.

