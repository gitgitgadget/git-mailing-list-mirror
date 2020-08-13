Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E8C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E30420675
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRJFV9Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMMpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMMpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 08:45:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709FC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 05:45:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so5058128qkb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lXvs3Lrx8NbidzTirJAaMryKVSMHkkoM6nf6aJCSyi0=;
        b=cRJFV9FmDsnlmrYOPIlpD94Y0yxlGsbT3mrYIgdfhGInJh2d6JwNPURoMFDM0cSMQX
         7lyBoArDmTe2a0qCcbQhavm9Z9sxNmlSaNAZhQXhJzUexR9C8YUusdYLB3X5dePK9o7/
         pSgbJoSgXGeYJjA34sFErN9UrelRefR3vzMSGw1wQifBDU/jdEKN9+0tAS27gDlKAXnv
         tOXyq/M5bNwM2dtRR2QxN/47PmSikHP4ptxG0rV8nPa+6UvfAUTHwF1N8f4JAOdUNZ0O
         TAZ8CeQn/zfUhtMMUbJZEz1qSTmI9mu3oNW6PJaB47hq9+AW4i/D8yilyDabAwAmYrNa
         ZGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lXvs3Lrx8NbidzTirJAaMryKVSMHkkoM6nf6aJCSyi0=;
        b=I5nsoaQFdxebrJMSkRGr76qB3wLUqFuhU6jVA86mGf5uNCQ5xzPkG/8ASRcioayu5h
         5KBauKqXTeScYKFuKIELPsURPBEK0LrMw9GvMU+xqSJMcK6UYBqKSYYPWJxrXzCiol+6
         +mIdZIX205smSQpBOr945/7n2tM9SY9da3BNZvWKD4Q0g69uenQlMM5E96zbrFEqW+Ed
         EjWynm+D5uBe6Zj/XqP1I40PU4Ggq4iwtxSLbMKzxjz30iUvm6kXpTiR0qbenjm0jDLk
         mIdwAqctcujcrKgQ3EGEID+e1zlu7uOZAauxbGQWchxzJf0D6cotQ+geyEnibbEWKEoY
         LvgQ==
X-Gm-Message-State: AOAM53384cEeyGsbKh9B0EJ/loDUo3+qmY8pGM1SfEvi1tdzAO6EQZHd
        4Z8kHgcpNV7Mvp+Z89koZ4Q=
X-Google-Smtp-Source: ABdhPJyydl94oJr3TaxUt5LSfFPCRBg6V+J0xqlI9X/IQr3x8J8N1GddwzKSXjNa9Wbv5xiSGa4nOQ==
X-Received: by 2002:a05:620a:2236:: with SMTP id n22mr4318108qkh.127.1597322728178;
        Thu, 13 Aug 2020 05:45:28 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id o48sm7053706qtf.14.2020.08.13.05.45.27
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2020 05:45:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] userdiff: improve Fortran xfuncname regex
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CABPp-BENKdxqXjH07yCNojRWQ3XO+_mm8x+LSVLTBx36m6nSSw@mail.gmail.com>
Date:   Thu, 13 Aug 2020 08:45:21 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8014D105-0957-4A45-B375-1027E070C74E@gmail.com>
References: <pull.700.git.1597271429.gitgitgadget@gmail.com> <69fe977b66f9744c914cfdfa2da4b9be5e720e4f.1597271429.git.gitgitgadget@gmail.com> <CABPp-BENKdxqXjH07yCNojRWQ3XO+_mm8x+LSVLTBx36m6nSSw@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,=20

> Le 12 ao=C3=BBt 2020 =C3=A0 22:10, Elijah Newren <newren@gmail.com> a =
=C3=A9crit :
>=20
> On Wed, Aug 12, 2020 at 3:34 PM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> The third part of the Fortran xfuncname regex wants to match the
>> beginning of a subroutine or function, so it allows for all =
characters
>> except `'`, `"` or whitespace before the keyword 'function' or
>> 'subroutine'. This is meant to match the 'recursive', 'elemental' or
>> 'pure' keywords, as well as function return types, and to prevent
>> matches inside strings.
>>=20
>> However, the negated set does not contain the `!` comment character,
>> so a line with an end-of-line comment containing the keyword =
'function' or
>> 'subroutine' followed by another word is mistakenly chosen as a hunk =
header.
>>=20
>> Improve the regex by adding `!` to the negated set.
>>=20
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>> t/t4018/fortran-comment-keyword | 1 -
>> userdiff.c                      | 2 +-
>> 2 files changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/t/t4018/fortran-comment-keyword =
b/t/t4018/fortran-comment-keyword
>> index c5dbdb4c61..e9206a5379 100644
>> --- a/t/t4018/fortran-comment-keyword
>> +++ b/t/t4018/fortran-comment-keyword
>> @@ -8,7 +8,6 @@
>>       real funcB  ! grid function b
>>=20
>>       real ChangeMe
>> -      integer broken
>>=20
>>       end subroutine RIGHT
>>=20
>=20
> This change seems orthogonal to the explanation in the commit message.
> What is its purpose, and does it belong in this commit or a different
> one?

If you take a look at t/t4018/README, the way to mark t4018 tests as =
"known failures"
is to insert "broken" somewhere in the file. Since I'm fixing the regex =
in this commit to be able=20
to cope with the situation in t/t4018/fortran-comment-keyword, I'm =
unmarking this test as broken.

Cheers,

Philippe.

