Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F4C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A30461425
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 09:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhFOJFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhFOJFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 05:05:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C76C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:03:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k5so11400687pjj.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yaw5Lqvpm3oxgHMTTB7I5/PaK6HpaSUGUwqEylZIpfc=;
        b=JEBQQIa8yfk2JVfbrpvReUHjjVHNVp2lHU7WVdziGM9ZO2qPszfZUkOmK0tXL1zfFP
         NsBBTcd4P/42bptm11pAessHN0hDzcKwUOBNiU52Pw5dZc8RlB/J2HmPcyYESV5C6NWa
         GojZJ14BxxArM85HmdksNrsAqBIXlUAnH38f0ERX3WDUz4l3hBPG3sHvlHWd9G2OZFIm
         9pzMyCBDH0GlzpTKoOztf7FCsYJlF4wp6dCRUVh+vmjXLNK8Zr1is/5TTqr1LOrqVLs2
         LLtn6xS0E1EhMePJ3m2T4e9A4eRn6iWnPQhL1aOKssI/EQcQv2Cjlh8dQHFTV+2gZmmR
         ZJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yaw5Lqvpm3oxgHMTTB7I5/PaK6HpaSUGUwqEylZIpfc=;
        b=KAJgcPuadzF/T3cGzTgA9bvElQ7tk1U4xXFaWWt37JOmyC2b0GLdqpB5OMgAfg8TzW
         fBEV1na8TO/RMjUaAtsVooLCrogr7j5WeIXlGYQI9sqwdojx4AZ7U3F13Q41ZSg4vQwI
         Xrtai7XuEPpUf5nXTCiWAkkBGdaevMkIJqCf6GHEvp2MYvhrSxHgeL/oX0DJ7x3F/bN9
         nR6W55LgArHmW3pveX3mVcUu8wRVqy3Gin4/g5Kq33FmZ6sgjy4xD6ZnUEKdng+lFL7X
         YW91rP+2lA1FyJ1eF1/iK7ILD4yyyd9zdlc7VwlnGl39own2VLfU+bliOBJoOGb1P9Du
         hbrw==
X-Gm-Message-State: AOAM530MANCst8Z749WhIEE3lBQtl/BfBC3egKmnhSTYtbIDlKvZGfdM
        wh7ijyPuRbkphzOI/Xx3Ceg=
X-Google-Smtp-Source: ABdhPJxt1VZgxdFfKZUm5InhCX9kyuu62v5vnUIeN1naVcoRqu4jitYbz+ZmY3GTWwFEzAwIZL/VwQ==
X-Received: by 2002:a17:902:d48e:b029:108:cd42:f914 with SMTP id c14-20020a170902d48eb0290108cd42f914mr1972885plg.7.1623747830586;
        Tue, 15 Jun 2021 02:03:50 -0700 (PDT)
Received: from smtpclient.apple ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id ge13sm2126634pjb.2.2021.06.15.02.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 02:03:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v4 1/3] submodule--helper: refactor module_clone()
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqzgvrwzsv.fsf@gitster.g>
Date:   Tue, 15 Jun 2021 14:33:46 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <393DB02F-5E7F-4558-9FB6-A1753F22A8E2@gmail.com>
References: <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210614125157.99426-2-raykar.ath@gmail.com> <xmqqzgvrwzsv.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15-Jun-2021, at 09:21, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Atharva Raykar <raykar.ath@gmail.com> writes:
>=20
>> Separate out the core logic of module_clone() from the flag
>> parsing---this way we can call the equivalent of the =
`submodule--helper
>> clone` subcommand directly within C, without needing to push =
arguments
>> in a strvec.
>> ---
>=20
> Missing sign-off?

Yes, I missed out all the trailers.

>> builtin/submodule--helper.c | 241 =
+++++++++++++++++++-----------------
>> 1 file changed, 128 insertions(+), 113 deletions(-)
>>=20
>> diff --git a/builtin/submodule--helper.c =
b/builtin/submodule--helper.c
>> index d55f6262e9..321b623d81 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1658,45 +1658,20 @@ static int module_deinit(int argc, const char =
**argv, const char *prefix)
>> 	return 0;
>> }
>>=20
>=20
>=20
>> +struct module_clone_data {
>> +	const char* prefix;
>=20
> Asterisk sticks to identifier not type in this codebase, i.e.
>=20
> 	const char *prefix;
>=20

Will fix and resend.

> Other than that, the split makes sense, especially for the purpose
> of more easily reusing this helper without having to unparse and
> reparse the option strings.
>=20

