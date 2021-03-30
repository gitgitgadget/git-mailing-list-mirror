Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9988BC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B5E61994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 06:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhC3Glw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhC3Glh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 02:41:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F2C061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 23:41:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f10so10986586pgl.9
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 23:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1cAa0bF5sYe4eKRzs3nivL08Sroqru2c6aXB0fg12Os=;
        b=kcOhUq30lt8TmdebdqO0cBkT/x94QHxPshTqSwyT9xPgVfn/G6XjzRQQqL0jKSm6Cj
         NZkNJ30o6Rr3HJvlL02bY0qe6tN5zvV8iFwKD5YULusnh+0w06bNddiHohRRWCdHwVZO
         ELYGqqUeqpHAgq/uKPnS3CeItOQ2oCposol7oUTM8llnDm7U1C9IldJZ8PLCT0xW+CAj
         zSAJsixevi9Grp9/r0V5cflcgkcelMK7chAYZDFw8D8isdn0bxwsodw7R7QwNl8XPvv2
         RZi0rlg8KBb+32EytySIpnOtcSyoDHopbYTxHHvCol8m8vsDZMsCgnWr0qvSHu1RW6K3
         oS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1cAa0bF5sYe4eKRzs3nivL08Sroqru2c6aXB0fg12Os=;
        b=nxekCs7XBTOHAD+bSCzv9clyG24uJ0sxVngVqisHVINd8FyVdOXbhLcx5Qlr4JhngV
         gCW4R6sdD9ODJLvNgFWj6Xx6d9Ajis8S33HYMz+T71JI7+OTkbJ6BNzhFLIFyCXEM+hK
         gLdR9TtMu8wugP+c+FPObLZgd1GL/0QGUgljm+uLC9WmU/ARhl6k2z1sa/HqogbKWu4v
         1FHltqZLqzNEKOLGJ8KJwFTNwlylbl23crrqN3us/GoHCnmYutriF26knoOxxWTBg9l3
         /nbXcnu6ze2Yu5Wd+C0GnM9+D5IKRFkYJDvaGo12qIa9jxUcuGVhZaf0jhsd/aF7DoOt
         YUBg==
X-Gm-Message-State: AOAM531pSVMqZ2RTZb4upHIV5OKwSo7m3vbzQIxab2jkOBgw2BZA9rEe
        oREPKxIBRxIsQdOPhyoput0=
X-Google-Smtp-Source: ABdhPJwxD3FXl7L34AZ6FZ8yY16fhuD8zp53h5FcRrx2LqFqaTMJK8uiV/xidsiAum4HOLI1ClvBTQ==
X-Received: by 2002:a62:5e05:0:b029:20b:241e:4e18 with SMTP id s5-20020a625e050000b029020b241e4e18mr28843218pfb.1.1617086495587;
        Mon, 29 Mar 2021 23:41:35 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id d21sm14704400pgj.62.2021.03.29.23.41.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 23:41:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <62695830-2f9e-c3b5-856c-01b97eb2c3af@gmail.com>
Date:   Tue, 30 Mar 2021 12:11:31 +0530
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <59DFC82F-A3EA-4637-94AE-4042697448FF@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
 <87blb4nf2n.fsf@evledraar.gmail.com>
 <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
 <62695830-2f9e-c3b5-856c-01b97eb2c3af@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 29-Mar-2021, at 15:38, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
> On 28/03/2021 13:40, Atharva Raykar wrote:
>> On 28-Mar-2021, at 08:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>>> The "define-?.*" can be simplified to just "define.*", but looking =
at
>>> the tests is that the intent? =46rom the tests it looks like =
"define[- ]"
>>> is what the author wants, unless this is meant to also match
>>> "(definements".
>> Yes, you captured my intent correctly. Will fix it.
>>> Has this been tested on some real-world scheme code? E.g. I have =
guile
>>> installed locally, and it has really large top-level eval-when
>>> blocks. These rules would jump over those to whatever the function =
above
>>> them is.
>> I do not have a large scheme codebase on my own, I usually use =
Racket,
>> which is a much larger language with many more forms. Other Schemes =
like
>> Guile also extend the language a lot, like in your example, eval-when =
is
>> an extension provided by Guile (and Chicken and Chez), but not a part =
of
>> the R6RS document when I searched its index.
>> So the 'define' forms are the only one that I know would reliably be =
present
>> across all schemes. But one can also make a case where some of these =
non-standard
>> forms may be common enough that they are worth adding in. In that =
case which
>> forms to include? Should we consider everything in the SRFI's[1]? =
Should the
>> various module definitions of Racket be included? It's a little =
tricky to know
>> where to stop.
>=20
> If there are some common forms such as eval-when then it would be good =
to include them, otherwise we end up needing a different rule for each =
scheme implementation as they all seem to tweak something. Gerbil uses =
'def...' e.g def, defsyntax, defstruct, defrules rather than define, =
define-syntax, define-record etc. I'm not user if we want to accommodate =
that or not.

Yes, this is the part that is hard for me to figure out. I am going by
two heuristics: what Scheme communities in other places would generally
prefer, and what patterns I see happen more often in scheme code.

The former is tricky to do. I posted to a few mailing lists about this,
but they don't seem active enough to garner any responses.

The latter is a little easier to measure quickly. I did a GitHub search,
where I filtered results to only consider Scheme files =
(language:scheme).

Some armchair stats, just for a broad understanding:

  Total number of scheme files: 529,339
  No. of times a construct is used in those files:
    define and its variants : 431,090 (81.4%)
    def and its variants    :  18,466 ( 3.5%)
    eval-when               :   3,375 ( 0.6%)

There was no way for me to quickly know which of these uses are at the =
top
level, but either way of the more structural forms that do show up in =
Scheme
code, define and its variants seem like a clear winner. I am not sure if
it's worth adding more rules to check for def and its variants, given =
that
they are not nearly as common.=
