Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378DC433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068C3619A7
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCTLOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhCTLNr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:13:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE4C06178A
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 04:13:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q29so13873075lfb.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aYckyjfeIHGLNZC2C9qy4WogFBLdJvm8e+1XMYW8Vn4=;
        b=nDFEUYP7KX6rtou58LFE76pub+XXtVJjCuBe2AKJHQGbCAopE8aJs2vJAwURSfWarQ
         Wtlz6VV5njUalu4ipCTU6kbhwL37jTkDfx47cm0k8B19SxVrnPFm318xlJZywfxbdo9n
         YX0O3gCst/ODZkJqL1pHBdKmYDSJ1zQKeL+O+7Q6cQAqMEYQ12l6c6wVQrSF2I3ndbXY
         N98CqBEZOjoqQCdKPahy+zdWzm2G7rZX0F/pbNbB2OGH7VTk78q2ue8QY5mkV8spSNle
         Lxuoh/lJ1zqffBeQDOOWQSnSzQzlqo+s9WNt8FuDy6inob6/gVYyslYF6oNCNec2ViMo
         9QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aYckyjfeIHGLNZC2C9qy4WogFBLdJvm8e+1XMYW8Vn4=;
        b=Wi2/cUYcKMeQp7CRoQva+YeVevgbbZMqVRZZXPRZpT5UKxiHIBCO/i1fttEN6Ccx8s
         DAmYM8NGuNsW0RPfcC0apYqkwAk1R/mfi7gEaaczVEhe7se43u9hPUEGIoxWyhPOEztx
         0h/v7ULjuAQPKkrKDnf992NvX8MnoU2/2NUhJTjuzNT+inm8cfU5lKYNG1/ts3FSmbOZ
         pQ3YB9UnxzHuCSsRo/YA67kr1ArXouTFLJ6NoD46cl++xEEd1V2iPLOD7mtpIHUiTlQ9
         z3VbTLK/3bnibcGa2IBRVjcWrymghyGTU9xB290cTA+CoP9CHez7AdyDWwjsXJm6nSwp
         1wOw==
X-Gm-Message-State: AOAM532EUfQXXFwwY00O/FwAIvuyZFHgRS4XHuuPhFUhDyfgOBSU6UZo
        GlLwHceyCb6h7p0rgk69juhz+n8miTo=
X-Google-Smtp-Source: ABdhPJxeaBilHBVsh47kPfNoJHgFk/f+8cKfF494OMGsCIuTDaQqk8AfGaSNya0/G/Zwwo5/ZOJnHQ==
X-Received: by 2002:a17:906:53d7:: with SMTP id p23mr8933794ejo.140.1616231819124;
        Sat, 20 Mar 2021 02:16:59 -0700 (PDT)
Received: from evledraar (77-60-191-25.biz.kpn.net. [77.60.191.25])
        by smtp.gmail.com with ESMTPSA id 90sm5857196edf.31.2021.03.20.02.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 02:16:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-2-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet>
Date:   Sat, 20 Mar 2021 10:16:57 +0100
Message-ID: <87czvuyyk6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 19 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> just a general note: this patch, which is the first of v4, is marked as
> replying to the cover letter of v3. That feels quite odd. If you use
> threading, why not let it reply to the cover letter of the same patch
> series iteration?
>
> In other words, would you mind using the `--thread=3Dshallow` option in t=
he
> future, for better structuring on the mailing list?

Not at all, I've set it in my config now.

I've just been using the default configuration of format-patch
--in-reply-to --cover-letter && send-email *.patch all this time.

Looking around at other patch submissions (aside from GGG) this seems to
be the norm though, but isn't documented in SubmittingPatches
etc. AFAICT.

So I wonder if I'm using some different process from the norm, or if
most everyone else is just looking carefully at Message-ID/In-Reply-To
norms before sending...

> On Tue, 16 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Add the object_name member to the initialization macro. This was
>> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
>> go, 2016-07-17) when the field was added.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  fsck.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsck.h b/fsck.h
>> index 733378f126..2274843ba0 100644
>> --- a/fsck.h
>> +++ b/fsck.h
>> @@ -43,8 +43,8 @@ struct fsck_options {
>>  	kh_oid_map_t *object_names;
>>  };
>>
>> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDS=
ET_INIT }
>> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSE=
T_INIT }
>> +#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDS=
ET_INIT, NULL }
>> +#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSE=
T_INIT, NULL }
>>
>>  /* descend in all linked child objects
>>   * the return value is:
>> --
>> 2.31.0.260.g719c683c1d
>>
>>

