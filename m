Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE6ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ1AJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1AJN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 20:09:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A480E9D
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:09:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so9311622ejc.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRZ/5MkVedWKMB/PAnAGP7xXv3tgOjMmyjZUNtRikrg=;
        b=gEzkYh5KkI3R037QS2gjSZfdZrwOkgtoTPcFWg69aSgxyVYXe7bIcviNTLL0OhFVNq
         aGXBjCF+TM0I3471yOxCdOY9lDdp8HVL8M7i5sO4iFl0/KizAWn+9otXGswgP1oduQKg
         mXjgbvvuVarWB0O4SyDCnqB4rBzRxfHOdKdoSM7lrv7pSpZ1Ohs6U2jCvkMsQ7rFrkBg
         GTOUtrBFcTaFDpxbKitoZLRW6hcrWp5i0pkRBLt4HFEKwEXuRwRpWmBmLReOaGjISTeb
         dvGik/cJC1qljkBH2rZ4zn8Q8t/GdlDLpD6c8OPRKXRTNvjlMwlZ6nkY3YMZWhPK9it8
         NjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRZ/5MkVedWKMB/PAnAGP7xXv3tgOjMmyjZUNtRikrg=;
        b=YJzryj0C4ugFIGyRHzze+5FoYLxBPkddALHmKQeX8umLbfu5zBfk8Ymy+OKLQmts1x
         4+6kt/QkR2qyu4ISBbPoZEajbe0v6XL0cKBQ5QWMygxEi6kxZSi2WIq8yI9ysy15ujc0
         yX1EUz4Uqu9S3yROMSC72kWeesQba8JQeaDBr0ECiR2WdBjIeSPVGvU0hqptYDOl46pQ
         OWVMcTFGOZR0SqiIfNzFPMwfGEEvIUQ3vMkaJUbceD9VemUdQVPoJ6OkHeewt26Xbv/i
         TjjpkQfAIauUOGQQaLXcm7NCOeHqkdIwhc4vK53VyIqXhailCUHGGYOHEVGXl/LHl11T
         F3Mg==
X-Gm-Message-State: ACrzQf1zU3o8SW55PmwLVdZfaqCdr7U/pNK/czx2NjXl4e1IIQo9YHWL
        RuqdHS3RgIVj0ZuPdHEUAdI=
X-Google-Smtp-Source: AMsMyM7/KSUvVGOS3bgW4uN9WxqcOMytUi+wYO9B84OUip6IUeFr0bBZp+txJQhmIoInjh8X5epSyA==
X-Received: by 2002:a17:907:2c72:b0:7a5:47da:5893 with SMTP id ib18-20020a1709072c7200b007a547da5893mr23600858ejc.612.1666915750860;
        Thu, 27 Oct 2022 17:09:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709063c1600b007ad9028d684sm1418534ejg.104.2022.10.27.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:09:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooCvt-009gFe-0b;
        Fri, 28 Oct 2022 02:09:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] config API: add "string" version of
 *_value_multi(), fix segfaults
Date:   Fri, 28 Oct 2022 01:44:19 +0200
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <patch-09.10-bda9d504b89-20221026T151328Z-avarab@gmail.com>
 <xmqq4jvpkpxd.fsf@gitster.g> <xmqqzgdhjb89.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqzgdhjb89.fsf@gitster.g>
Message-ID: <221028.861qqsajx6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Fix numerous and mostly long-standing segfaults in consumers of
>>> the *_config_*value_multi() API. As discussed in the preceding commit
>>> an empty key in the config syntax yields a "NULL" string, which these
>>> users would give to strcmp() (or similar), resulting in segfaults.
>>
>> Sounds like a good idea.
>>
>> I would have called them _nonbool(), not _string(), especially
>> because we are not going to have other variants like _int(), though.
>
> Actually, I take it back.  Instead of introducing _string(), how
> about introducing _bool() and convert those minority callers that do
> want to see boolean values to use the new one, while rejecting NULLs
> for everybody else that calls the traditional "get_value" family of
> functions?  That would "optimize" for the majority of simpler users,
> wouldn't it?

I don't think the goal should be just to optimize for those current
users, but to leave the config API in a state where it makes sense
conceptually.

For the scalar (single) values we have a low-level "low-level" function,
and then variants to get it as a bool, path, string, int etc.

I think a "multi" function should just be the logical result of applying
one of those "types" to list. I.e. (pseudocode):

	a_raw =3D get_config_raw("a.key");
	a_string =3D stringify(a_raw);

And, as a list:

	list_raw =3D get_config_raw_multi("a.key");
	list_strings =3D map { stringify(item) } list_raw;

Now, if we don't supply the equivalent of the "raw, but multi-value"
function we'll make it hard to use the API, because now you can't think
about it as the "multi" just being a list version of what you get with
the scalar version.

E.g. what should we do about "[a]key" in a list API that stringifies by
default? If you then want "stringified bool" we're only left with bad choic=
es:

 - If you die that's bed, because that's a legit true value
 - If you coerce it to "" to help the string use case you get the wrong
   answer, because "[a]key=3D" (empty string) is false, but "[a]key"
   (value-less) is true.
 - Ditto if you prune it out, as then it won't be seen in the bool list.

Which is why I went for the end-state here. I.e. it's now easy to add
other "multi" variants (we'd need to add coercion, but that's easy
enough).
