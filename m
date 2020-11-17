Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED016C5519F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F5E20729
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryapxMkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgKQODi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgKQODf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 09:03:35 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E26AC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:03:35 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f20so29582795ejz.4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xvttKg/T1CwNOlBUFiRkNwB8XFzLC1QaHHZKZcHRHQg=;
        b=ryapxMkJ++qR9hK/OcQVFE3RpjnJhs/filh983TheTUUoqyT1vEwnoFMssBxWDDMKa
         BY/Dbqx4sIKuziLqDSU4lBlxzhFLibM+ljkb7xl24zcwOYl6tFEamImKHU9lPMX7I3or
         6xuczQkGecvzydgoaCgevo/jHVU06PdtoJPvVc1ebLjfRCvGTbK4XptTh1681LlJeDLd
         XMYEH2xQkWRosoN4krd/YxkosjLTIqGloRHNhH1DofOlTzvNonH1iKxmXxjhAfStbjz3
         lV05Y86k0VRmWkt74mE0ou8agmn2XCCtzmLFKv6zzsyow9D3UUVT9t4w9yP9KPV28Ghv
         jdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xvttKg/T1CwNOlBUFiRkNwB8XFzLC1QaHHZKZcHRHQg=;
        b=KmigfSGr0RWLi8aA3Gg4lfs2xcD+jJaK72wxyFjPnhvEhy0aPncvnBbCXeFV5nNKsi
         ELnwMzetiViBPvNIgwvlmDEzdGBRbBEZKhDVyX0Ylr9lI+iILkC29IapUbodt2LDgcQ3
         qs3EI0jikdksoLjgG10P/9QjuATVy/NyVBOxZdHzKkEgbwTR6yg8pBxv3ps8gykEicEY
         DlFaIZI3olo5T0X+uxtKnYZ6OhHSxgzQq5nYMcTBFbLuU0ddm9Cal7RDYZRBHykfYNBF
         js0wR5XYZOKkfe3G0RyM4cLZ9Ghf+HiUQo27MW+P9SqLz6KdgyjB2ytLdVahyDvDJsVp
         3AHg==
X-Gm-Message-State: AOAM533YmWZI+XlWAWE5MPPPbQSolXvLiFV4pBtix7B5kpLV7fMdQ7pn
        nQ16OAWpRSWIjLSULg0pkqo=
X-Google-Smtp-Source: ABdhPJwNgFi49pIXdWaO21Xtx8/T7gunQyTDIfCCKGVL8OnPwGDy7kWF4/yfyeb1Y5NF1hZHvrAaZg==
X-Received: by 2002:a17:906:f84f:: with SMTP id ks15mr18616206ejb.337.1605621813895;
        Tue, 17 Nov 2020 06:03:33 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k23sm11867319edv.97.2020.11.17.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:03:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar pairs
References: <cover.1605269465.git.ps@pks.im> <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im> <87mtzlflw7.fsf@evledraar.gmail.com> <xmqqy2j1851k.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <xmqqy2j1851k.fsf@gitster.c.googlers.com>
Date:   Tue, 17 Nov 2020 15:03:32 +0100
Message-ID: <875z64f5cb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 16 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Fri, Nov 13 2020, Patrick Steinhardt wrote:
>>
>>> While not document, it is currently possible to specify config entries
>>
>> "While not documented..."
>>
>>> +		strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
>>> +		if ((key =3D getenv(envvar.buf)) =3D=3D NULL)
>>> +			break;
>>
>> The convention in git.git is to avoid explicit NULL checks. So maybe
>> something like this, which also avoids the assignment inside an "if"
>>
>>     key =3D getenv(envvar.buf);
>>     if (!key)
>>         break;
>
> All good suggestions, but...
>
> "While not documented" yes, for sure, but we do not document it for
> a good reason---it is a pure implementation detail between Git
> process that runs another one as its internal implementation detail.

*nod* I didn't mean it should be treated as some API, just "it happens
 to work". I do agree with Jeff downthread that it would be nice to have
 it explicitly supported.

> I especially do not think we want to read from unbounded number of
> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> script cleanse its environment to protect itself from stray such
> environment variable pair?  Count up from 1 to forever?  Run "env"
> and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
> some environment variables have newline in its values?)

Purely on an implementation note, if we went that route we could provide
something based on compat/unsetenv.c (or environ iteration in general)
that would loop over the env, but I agree it would be better to make
GIT_CONFIG_PARAMETERS nice.
