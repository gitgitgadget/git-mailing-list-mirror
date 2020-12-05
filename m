Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3513C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD662311D
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 17:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgLERud (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 12:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgLERsl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 12:48:41 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C4C08E864
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 04:26:44 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id u19so8710322edx.2
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 04:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Fj3IGdbZ0FI7nTlfPh90FQxFwJ2uGN+xjP9XIyJ392U=;
        b=Jd45fWThoNipprg3ttIXjNgPvz2qYQRAii90RIEuy9AMIYthuQNEcqUrWHBiwJCcvx
         mHac0oPow9vQsEZlxqO1XKSAjaNoYO3/s6dWmOU6iyzm/yAfxVDV3yNXOkkfR5mSzWru
         OesVDniYFiJqrYe8/5HrLTqbf1r09LcoPHrMjn0BVIg5UKEF1psWhuqO+Y2xDtvOl0+8
         YuUFIAaJxgkEH/Ebh63d88w8m65fuVeXdlPDETwEtE4XzCyezQpLwGJrubtaBBG9phwm
         D4uj/L5vL/WKEw77vM7hBtwLIOxh867C9L2JKSzwkw0sob/NdfBUp3BhdePLPsS9a2i9
         87lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Fj3IGdbZ0FI7nTlfPh90FQxFwJ2uGN+xjP9XIyJ392U=;
        b=eYarDurHQvkX4Ph/9PeIJyBgRb2G66xVHqnaruMNL3pXzlDZvm2vN3JYxwSN9RTXtF
         IspdKT1oBnSI0u6apZC3Sh8R7HdLZ17oTS5vLfk+YSxlmPEAzebVJDzO+Oyf5V9BMTYC
         y9ublBN1AYrq6yyFCNwsvtrubdoqd8hS1BeLuY3F/HWbCfKyv0d7gcP/WWkXjv/qrRuC
         ig+jzPeQ8ECv6elgqa4OCOFhA2ImaXap0EdS100TDgeQpdrSSRqMMF1LHbEk4g/kkrzE
         /0WeXZ3h3yl2JnNV3Cy5xvFWhlg6Dlgr6P4ibgANKLp2H6Dlk2mkfAkM5AU1fTusQHdc
         7thA==
X-Gm-Message-State: AOAM531I7DKuxMd6GNwCeUmsEsTj8brOIVZ2ofQgFb5L2VIuf4CHQ50l
        IIsJWpfF398qjZQlxH9eKBQ=
X-Google-Smtp-Source: ABdhPJyD41gPjbv2RNdhJLxhj7ayc+UjPAnL1WEZuZHzz6wrmctHGXkF0p6IJlYaIeDkSWsQWfv4KA==
X-Received: by 2002:a50:e786:: with SMTP id b6mr11511711edn.242.1607171203085;
        Sat, 05 Dec 2020 04:26:43 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id n14sm5526220edw.38.2020.12.05.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 04:26:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/5] pretty format %(trailers): add a "keyonly"
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201205013918.18981-4-avarab@gmail.com>
 <CAP8UFD1gTOKLs55ceVwsDW=uSyW4wx_9eF9Wra5KVP8B19Jx_Q@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAP8UFD1gTOKLs55ceVwsDW=uSyW4wx_9eF9Wra5KVP8B19Jx_Q@mail.gmail.com>
Date:   Sat, 05 Dec 2020 13:26:41 +0100
Message-ID: <87mtysxwu6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 05 2020, Christian Couder wrote:

> On Sat, Dec 5, 2020 at 2:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> Add support for a "keyonly". This allows for easier parsing out of the
>> key and value. Before if you didn't want to make assumptions about how
>> the key was formatted. You'd need to parse it out as e.g.:
>>
>>     --pretty=3Dformat:'%H%x00%(trailers:separator=3D%x00%x00)' \
>>                        '%x00%(trailers:separator=3D%x00%x00,valueonly)'
>>
>> And then proceed to deduce keys by looking at those two and
>> subtracting the value plus the hardcoded ": " separator from the
>> non-valueonly %(trailers) line. Now it's possible to simply do:
>>
>>     --pretty=3Dformat:'%H%x00%(trailers:separator=3D%x00%x00,keyonly)' \
>>                     '%x00%(trailers:separator=3D%x00%x00,valueonly)'
>>
>> Which at least reduces it to a state machine where you get N keys and
>> correlate them with N values. Even better would be to have a way to
>> change the ": " delimiter to something easily machine-readable (a key
>> might contain ": " too). A follow-up change will add support for that.
>
> Well explained.
>
>> diff --git a/trailer.c b/trailer.c
>> index b00b35ea0eb..40f31e4dfc2 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -1233,8 +1233,11 @@ static void format_trailer_info(struct strbuf *ou=
t,
>>                                 if (opts->separator && out->len !=3D ori=
glen)
>>                                         strbuf_addbuf(out, opts->separat=
or);
>>                                 if (!opts->value_only)
>> -                                       strbuf_addf(out, "%s: ", tok.buf=
);
>> -                               strbuf_addbuf(out, &val);
>> +                                       strbuf_addstr(out, tok.buf);
>
> Maybe `strbuf_addbuf(out, &tok);`

Much better, thanks.

>> +                               if (!opts->key_only && !opts->value_only)
>> +                                       strbuf_addstr(out, ": ");
>> +                               if (!opts->key_only)
>> +                                       strbuf_addbuf(out, &val);
>
> The above is probably correct, but it feels strange to write the key
> after the separator and the value, and that the key is in a variable
> called "val".

We write them in the order "key -> sep -> value". with the logic of:
=20=20=20=20
    if (!no_key)
        write_key();
    if (!no_sep)
        write_sep();
    if (!no_value)
        write_value();

So the &val here really is the value part.
=20=20=20=20
