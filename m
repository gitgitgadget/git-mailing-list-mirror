Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18493C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CFF613C3
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 07:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhGJHzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGJHzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 03:55:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8909C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:52:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so7372347pjo.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 00:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RnoEGXO37QECwPsQxPo3lrMVfqGUgY9PMRXaxTQWb3s=;
        b=laS/yozsVOgVrF3VCRjq9vDooxbqquEf50EHyhIlKtSsParP+/+v4s3Ku/QRdonMY4
         HiSoQogCAHouewrhn+pekn0x4w7KkZiuqs9mXpkhGF5ITc2i1+c2m+CqmmSTPb39MusR
         72eRr1IkzOBJP3r/9LOnx0cBWGF7dGpA1vTDimppGfHNdVSr9lAbYU2A9+azQzLjxr2e
         Ovhf6c9Bvlr0hLssp36qVAMR2HYVXLw/mBvGKwEswhWvnHmNvfavmd79r28LMkgeKnAy
         MIsvMvVffTiQTjwjaEf1Ws60QXNM7iQyl9ZFhTLSWzT0P43zc7XAlueqKNunoMqd1dRe
         NQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RnoEGXO37QECwPsQxPo3lrMVfqGUgY9PMRXaxTQWb3s=;
        b=IhXXaerUinp+9WUkFlljBZnkMfNjoNeaw4daVdpjWmlMC/+2fSPXzB/RHLfChzLYIA
         Z9NMFVqalzdCFKsak7fN1qLatdQ7HeEAd/oVJyDdzCXkkAdwR3yYX/+NEoyzN0a/4YTY
         g+lmZlQljyedIF9NOY7KA2rqyNrD24GUKTbwyJshykCRBCd6uJJltOHK9a0fEuSEKxw0
         aiSF+EwdSjEMM09RJYxGXylRihwGoNCbQNu4HyQupKUKyejJh8MGXkEz7j39mInXgka4
         3xGvDWytNU8DDZiR7t8j5H4GIAZUpeezl5jBX5Co+JAqHEM7qqQU04+tsjGpmWLV6U+4
         2IOw==
X-Gm-Message-State: AOAM531slljWmxQcEHHOSyz3W1fvI36H4OlO9ZjlAMgjPD8JRcuAucyV
        f7e+QwPmtNm3Je4iat4XTrc=
X-Google-Smtp-Source: ABdhPJyL9Czz8kQ6m0tU++ZepLBRSFevKCTshnEZkoQ8bZ8JNA+ta/Tuw3ucQI9098st93byKWWECA==
X-Received: by 2002:a17:90a:a112:: with SMTP id s18mr3241169pjp.191.1625903542423;
        Sat, 10 Jul 2021 00:52:22 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id t6sm14628125pjo.4.2021.07.10.00.52.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 00:52:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH v2 2/4] submodule: prefix die messages with 'fatal'
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YOhirWqj7ajsqlYw@danh.dev>
Date:   Sat, 10 Jul 2021 13:22:16 +0530
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <598E78EB-48B1-4C2E-BD89-90EF003A15F6@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
 <20210708095533.26226-1-raykar.ath@gmail.com>
 <20210708095533.26226-3-raykar.ath@gmail.com> <YOhirWqj7ajsqlYw@danh.dev>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 09-Jul-2021, at 20:22, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh =
<congdanhqx@gmail.com> wrote:
>=20
> On 2021-07-08 15:25:31+0530, Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>> The standard `die()` function that is used in C code prefixes all the
>> messages passed to it with 'fatal: '. This does not happen with the
>> `die` used in 'git-submodule.sh'.
>>=20
>> Let's prefix each of the shell die messages with 'fatal: ' so that =
when
>> they are converted to C code, the error messages stay the same as =
before
>> the conversion.
>=20
> That sounds good.
>=20
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -147,7 +147,7 @@ cmd_add()
>>=20
>> 	if ! git submodule--helper config --check-writeable >/dev/null =
2>&1
>> 	then
>> -		 die "$(eval_gettext "please make sure that the =
.gitmodules file is in the working tree")"
>> +		 die "$(eval_gettext "fatal: please make sure that the =
.gitmodules file is in the working tree")"
>=20
> Except that, "fatal: " isn't subjected to translation. And this will
> create new translatable item for translator. Perhaps:
>=20
> -		 die "$(eval_gettext "please make sure that the =
.gitmodules file is in the working tree")"
> +		 die "fatal: $(eval_gettext "please make sure that the =
.gitmodules file is in the working tree")"

Okay, I have made the change. I was wondering if there any specific
reason as to why 'fatal' should not be translated? Is it because
an intermediate change like this should not create more work for
translators?=20


