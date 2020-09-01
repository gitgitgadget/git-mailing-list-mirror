Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767FC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604DF20767
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvIIwLfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIAN1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgIANSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 09:18:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A4C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 06:18:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so835407qkd.9
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0iNexRwKalRj7dyWZH8QN8nWfCNx0bqs2we8Q0+XWIQ=;
        b=hvIIwLfBytfHTZ74eTyWLmZbOZMTay4L6s4vIJk8zoZCWsY9G9Do8YSvKSpwQQNAuu
         VSnH0ceiPvgM4gO84V0OxwxysXeHbHqwynAC+6LHFM7nQJH/bOG88QGRzRpWjPRWR4wH
         /v6sGaQf9RSe1A7gRcVlAah+9FWrigPliJkeVOKwbLlBDEXfy2z/R6t292WuBShIeYSE
         /F/AGhcIZOF74db7i7jGuCwgPYl97cm7nveW9boTNYKNZnRHpLkoFqCUBj20bpqcM7Hp
         TfPOJTfPELN6GgG6Mwcwy4wDv0Asgw/QpsBj9Z7PRZQtwlHaEwLW3GL+knR+byZG9h5v
         6kVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0iNexRwKalRj7dyWZH8QN8nWfCNx0bqs2we8Q0+XWIQ=;
        b=jrXDJwztwZuCzfNoM6lF4JsUQwfkwVyyABa82+zPT5clBdZZKXwtW3M1eQcttXhCj8
         cJ/3h3lBiMEn7Mew+XYjsR/9/9nIifm0bFcPWdASFExg2Sb550RSJwPjU2pgPzUvtSWY
         QpVtgL4uLxAzZs6Fv8yYkbhWyYBnFcHskch91X6Gy4dGWVwj0NS9yD/NG5hO7TMZJPSz
         9ihJ191QH2MF1V1JTTnN1wPXE3Gygat3CY7llNvBi+IsYV3byRpu9K2XzF6l+pbMCrln
         ZYipjMt/1YgEpemJKtxT299by0Zq4NvL82ddUoccubl82qXCqgg6sUsP3H5wTxJZhFqY
         3hyw==
X-Gm-Message-State: AOAM532inVdR6UF419W93UFfPPVOhdNBnRGUoc/M48LE0k5iMb9wrJHy
        eyCrnK6eai9p3ue40zrQMlQ=
X-Google-Smtp-Source: ABdhPJySF91yRM3LGR+eCm120dGT6kdK/82CRL6xePkx5fz38Sh9rQU0/noGIwfhqum2FUsIMWuukg==
X-Received: by 2002:a05:620a:4c3:: with SMTP id 3mr1862281qks.105.1598966286403;
        Tue, 01 Sep 2020 06:18:06 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m3sm1529547qkh.3.2020.09.01.06.18.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2020 06:18:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation database
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200901073827.GA3967005@coredump.intra.peff.net>
Date:   Tue, 1 Sep 2020 09:18:01 -0400
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <867D6718-E377-47B8-BD32-0800872B3DE0@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com> <20200830221004.GB241078@camp.crustytoothpaste.net> <xmqqsgc3h28s.fsf@gitster.c.googlers.com> <20200901073827.GA3967005@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 1 sept. 2020 =C3=A0 03:38, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> On Sun, Aug 30, 2020 at 09:24:03PM -0700, Junio C Hamano wrote:
>=20
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>=20
>>> On 2020-08-30 at 19:28:27, Philippe Blain via GitGitGadget wrote:
>>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>>=20
>>>> Tools based on LibClang [1] can make use of a 'JSON Compilation
>>>> Database' [2] that keeps track of the exact options used to compile =
a set
>>>> of source files.
>>>=20
>>> For additional context why this is valuable, clangd, which is a C
>>> language server protocol implementation, can use these files to
>>> determine the flags needed to compile a file so it can provide =
proper
>>> editor integration.  As a result, editors supporting the language =
server
>>> protocol (such as VS Code, or Vim with a suitable plugin) can =
provide
>>> better searching, integration, and refactoring tools.
>>=20
>> I found that the proposed commit log was very weak to sell the
>> change; some of what you gave above should definitely help strenthen
>> it.
>=20
> Likewise. Looking at the output, I'm confused how it would help with
> things like searching and refactoring. It might be nice to spell it =
out
> for those of us exposed to it for the first time (I tried following =
the
> links but remained unenlightened).

OK, I'll improve the commit message. I'm not at all an expert in this =
subject,
I just had to generate a compilation database myself to use the =
Sourcetrail source
explorer [1] with Git so I figured I'd share what I had done. Further =
exploration of the=20
topic are in [2] and [3]. Note that I did try some of the tools listed =
in [2] before resorting
to modifying the Makefile, but these tools either did not work at all or =
produced wrong=20
output (ex. strings in the JSON were not properly quoted, etc.)

> I'd also be curious to hear what advantages it gives to add a new
> Makefile knob rather than just letting interested parties add -MJ to
> their CFLAGS. Is it just a convenience to create the concatenated =
form?

Unfortunately this would not work because the '-MJ' flag needs a file =
name
to know where to put the JSON fragment.

Thanks,
Philippe.


[1] www.sourcetrail.com
[2] https://sarcasm.github.io/notes/dev/compilation-database.html
[3] =
https://eli.thegreenplace.net/2014/05/21/compilation-databases-for-clang-b=
ased-tools

