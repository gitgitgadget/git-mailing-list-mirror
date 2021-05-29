Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88EC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924AB6127C
	for <git@archiver.kernel.org>; Sat, 29 May 2021 08:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE2IUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhE2IUS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 04:20:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C89DC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:18:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l3so8778774ejc.4
        for <git@vger.kernel.org>; Sat, 29 May 2021 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AII7dFCTDdkaVgaNA2ZNVURJ0jbHIehaV0OwCBTpUCA=;
        b=LnE4VPTvf661AvxDdMyb0jZlplQxhEsqvQCQBWki1amJEeG6RZVNy/RdQ/4kwJD33u
         kobpCIPf9YrOmPTgV9v4aln6ici84/3FughCiJSc4tTVDPuGryuxycil+zS+DpFm8P/I
         QUMKRmEqAqA3sqscaI0+0is5F6e2c/Vm2JvygDQ8Q80lIiGTQsP5WZdH3KqBEhd98AHi
         uxmJWTnQfI9xMkjkQgwZZuapjjMgErAPWmgtxCJ4wgMUtXhFIv/q24Xil8sPAHzX8NEp
         6DTKbYfYoP7HV8bPF/QgRwv6kXnZwYurwiEFsbSqdK4kDJfQUKRO9LImSjIpUGpMSstk
         Gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AII7dFCTDdkaVgaNA2ZNVURJ0jbHIehaV0OwCBTpUCA=;
        b=irS7jjHyZNBkUWRlieo1q/oGQTlXWKhTXVwIyNfQpZjbUxMwXwYH5+q/E5KwpT8ODt
         ZdMZjLn5cRAg1Gb8w9dVAMuN5RrsCaaCr4baDiGvxwuDGbRivYKI1hg8g+gU93PVcxYg
         c4pV4sW31JdNI4jbXTh/RaEEiFguZKKVl1fT1t/LPPj8yFVlEZUmGpUGsckOOY3zF4GR
         MtmIJ44LsHUEsobLLxuitUn/+9DLCnqUsQ4EN6ICct3UKRhsJCdbmlsR/roqWa59yy5+
         7YwHBMxtCO5qfNzNCP22wjyzdbDqfAr2hfkyoEtz5i827WwpbvWkbwxMxKEQTY0bPzFq
         vm0A==
X-Gm-Message-State: AOAM531R0lM5zd6ek6wDXXKAGPkaeqEje0nvkRrsjgdJwfardDEYH7mU
        evu1cBt4tYXE5Pn3Ibqv8Vzfbk+OLCTAOQ==
X-Google-Smtp-Source: ABdhPJzzBqVC2ABT5pyfqp+jENIydbdJ7vwUEa0XP5zH1seUYX+J6FHu4B+sttGImqd2Nut+vCfM6A==
X-Received: by 2002:a17:906:6717:: with SMTP id a23mr13039523ejp.410.1622276319626;
        Sat, 29 May 2021 01:18:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c6sm3277596eje.9.2021.05.29.01.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:18:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v5 08/13] send-email: use function syntax instead of
 barewords
Date:   Sat, 29 May 2021 10:17:19 +0200
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-08.13-f1a879a8ae9-20210528T092228Z-avarab@gmail.com>
 <60b116015b98a_4b03220857@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b116015b98a_4b03220857@natae.notmuch>
Message-ID: <87fsy62bs1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 28 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
>> doesn't have to guess that "__" is a function. This makes the code
>> more readable.
>
> Agreed. Ruby has something similar:
>
>   foo arg1, arg2
>   foo(arg1, arg2)
>
> As a C programmer I find the former a quirk of the language, and much
> harder to read.
>
> If it's a function call, present it as such.

I'm not too familiar with Ruby, but the important part here in Perl is
that it's not a "foo()" v.s. "foo" shortcut for a function invocation,
it's unambiguous whether that is a function and what its arguments are
until at that point in the program. Perl has dynamic grammar, you can't
parse it with a regular grammar without executing it.
