Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AA6C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjARXG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjARXGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:06:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E126589B0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:06:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so1266266ejc.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LY2wmLoXS/K9KbPuVN0Gr4+q3FXNuo9wpP3ca+3U5fg=;
        b=Ip1AfUFcguPKDVa+dTvcsQ/nho9OaCkAA257/6J5bDnO7rA5LMnM+f1WhpNqs3PSR1
         GMxH9LhYy3NGZjbqHrgZ+ssx/jisPypb9rO7eJnnjTdFS5mQzxeofjnbkAdwKef3Y6PM
         jmoEbK3hvYZ0vAbYpFuEjP4GvzPyYMsfS9WxHF5OWMfS9Izff24LeAt1hrLttfgG69J8
         8IdNHERGa+F85KA4Rb7PaTSeMuo6ia8Z16SptM5YrUI2qgZfwmMXSCmSL7va4a2OfTDL
         XQmEP5HmGiF6c0vRnkGrYb7DYXyxy2SK+VR6X8uw4hU+80TZV+t6sW0gO/ME4BE0pHOZ
         0hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LY2wmLoXS/K9KbPuVN0Gr4+q3FXNuo9wpP3ca+3U5fg=;
        b=EYqocwt2idLziTClMo2JqJff7CHwHkv2YJm3wcyRilRYq69K4RUiwweXJZ4Ttpy2BC
         4MO5rqW5xyoR/xsPr3cizzwzMw/ZKwZ9JxexvNXZJE+0+dkJgHxRFi/+kd/+Y6pwTkFH
         SYzotnqv+zIOBaPiR4RK9GSuSR0ay6Tx6OtVMYWZMlqjPMfuBvXfydGehP/bt20/WbXr
         HlGM7h5wFpp6y7y/x1dn7hYU2Zz5Ht1rp3htpxLSglgsfn01jWU6OEGqVq8FGDLhpXo+
         e7zAlIGdZOTPuimVatAtSOQn8o3uQYPbHp3b1m4RAfkoGFtSgTlyJKj5Q8P51ciz0Ov+
         X+Uw==
X-Gm-Message-State: AFqh2kpBnIoBGhstq8eFaZqdUrVLlBmY23muXqbg9Q2sKrxFsoRBqVDu
        qnSTVfaQZr/n54ueFTvGKDI=
X-Google-Smtp-Source: AMrXdXt6+M7rDWRbphJH/QpxYirIaRxWwDU5SytQy6MU+VeSNPVK0CYNMc31lN+EFwUE9thteic1+g==
X-Received: by 2002:a17:907:1759:b0:85e:c4e4:cfbf with SMTP id lf25-20020a170907175900b0085ec4e4cfbfmr9181244ejc.15.1674083171765;
        Wed, 18 Jan 2023 15:06:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b00781dbdb292asm15333696ejc.155.2023.01.18.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:06:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIHVS-003C3q-1m;
        Thu, 19 Jan 2023 00:06:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Thu, 19 Jan 2023 00:03:48 +0100
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
        <patch-v4-08.19-1fe25bc6981-20230117T151202Z-avarab@gmail.com>
        <xmqqedrs8igj.fsf@gitster.g>
        <230118.86o7qwxg4e.gmgdl@evledraar.gmail.com>
        <xmqqedrr6cnp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqedrr6cnp.fsf@gitster.g>
Message-ID: <230119.86h6wnwihp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> diff --git c/builtin/branch.c w/builtin/branch.c
>>> index f63fd45edb..4fe7757670 100644
>>> --- c/builtin/branch.c
>>> +++ w/builtin/branch.c
>>> @@ -742,6 +742,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>>>  	if (filter.abbrev =3D=3D -1)
>>>  		filter.abbrev =3D DEFAULT_ABBREV;
>>>  	filter.ignore_case =3D icase;
>>> +	UNLEAK(filter);
>>>=20=20
>>>  	finalize_colopts(&colopts, -1);
>>>  	if (filter.verbose) {
>>
>> I'll send a v5 re-roll without this change, sorry.
>
> I'd rather see your reroll with the above addition of UNLEAK() than
> without it, to fix the breakage.

I don't mind that UNLEAK() being in-tree until a better fix for that
leak, but doesn't the v5 I sent also address this?

The issue was that I mis-marked a test as passing, when it only passed
depending on my local compiler (-fsanitize=3Dleak is fickle
sometimes). Now that we're not marking that test as leak-free there's no
need for the UNLEAK() for now, no?

Or is there some edge case I didn't spot/notice?

1. https://lore.kernel.org/git/cover-v5-00.19-00000000000-20230118T120334Z-=
avarab@gmail.com/
