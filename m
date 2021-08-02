Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB0C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDC760F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhHBMoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhHBMoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:44:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B2C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:44:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so24508380pjh.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version:content-transfer-encoding;
        bh=fGkf1IaG6PzcJAptuBjth8Q+xls+5qwH1EfZDkJel8Q=;
        b=YJ3W8X1yntVe/b0UyzINnKxY6MjvICjDQdIv0JyAdew+jbL2gsaid99OmZ8MKPB5Eu
         rOrh6/ziGEBd54ySQtqio9QhxoUopXDW3+dE5q9DcjhTFgqvMXKRIMzpvp2xZoQcw1Jy
         0S2rbCqQZ5hSnx6vUS4NY0SRwCLh9OnMFsCNTuOik2s/CrbSS7xVWCix23doa7iM+1+3
         6PlUi3fC0rh4uQObf0+gP8iK9DVLwqLNB+xcJ2sOYvOzy7O+R8QikMBvGdXIEMe9qjP0
         h/JwJqOrwm+Ri1xb65EpZAN7gLC7BgfctB8HAZuODIDd/ESYPmN58yJ8n73U2D3n6Mn0
         PfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
        bh=fGkf1IaG6PzcJAptuBjth8Q+xls+5qwH1EfZDkJel8Q=;
        b=UMQuLANOVegcBprAmMoJKDnsZH7XEpLt+/Mr6sXM1ubvUf8dPeqedmRvxmL6Qw2fFz
         9UPoEsearLDSw8XnFKzJ6JS9lTtV2d6ZEUrXV8x6+nsPpuDG7Jd5MVzcANYkruCi7Y0q
         3IyYitAxBQahZvgIekBNtIP9WJp1tqVP4OPEbQsBksFde9g1orhXy4OCxpUPL+ilAjFK
         2uCLKETuzbpg6wWDHlmXEdaECqz/ZqRLzpBjy2XYxjGWICxk25abv3bDM+bNx7RojyHT
         I+xXV1qfM6jhVfdAhnWC0r8SmbZ86Weug6jGo5mnrifqcZF9e1lXKCj3NR1oC/pl1TG3
         wKoQ==
X-Gm-Message-State: AOAM533EiFMNrP/e0FsnNSE/yV44hkHpiSstVaSSTw90fvCbNK06A4UV
        ua2OULTN90Y9SFf1AEF5OLk=
X-Google-Smtp-Source: ABdhPJyjKlrwdljwHISMHT4ahq8VF8QnQEFBIRK05Mud2p7sYooc0onNKBSi7EnOMZ7Mx/r0CLG5Eg==
X-Received: by 2002:a63:5144:: with SMTP id r4mr1322250pgl.223.1627908247082;
        Mon, 02 Aug 2021 05:44:07 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id w18sm11411323pjg.50.2021.08.02.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:44:06 -0700 (PDT)
References: <m2lf5lxog6.fsf@gmail.com> <m2k0l5xo1q.fsf@gmail.com>
 <CAP8UFD0V3hoDUkeMyAaeo_=cZ46P-Yka1v67FFNbQ5Me5Hh_+g@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Shourya Shukla <periperidip@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week 11
In-reply-to: <CAP8UFD0V3hoDUkeMyAaeo_=cZ46P-Yka1v67FFNbQ5Me5Hh_+g@mail.gmail.com>
Message-ID: <m2pmuwrp7x.fsf@gmail.com>
Date:   Mon, 02 Aug 2021 18:14:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> On Sun, Aug 1, 2021 at 4:00 PM Atharva Raykar=20
> <raykar.ath@gmail.com> wrote:
>
>> Here it is:
>> https://atharvaraykar.me/gitnotes/week11
>
> Great, thanks!
>
>> > Preview:
>> >
>> > - Project progress: where I discuss a rough plan for making=20
>> > =E2=80=99git
>> > submodule=E2=80=99 a
>> >   true builtin.
>
> So your plan is the following:
>
>   - Rename git-submodule.sh to git-submodule-legacy.sh.
>   - Create builtin/submodule.c, that will read from a config=20
>   switch
> called =E2=80=98submodule.useBuiltin=E2=80=99. If this is set to false, j=
ust=20
> call the
> legacy shell script, else use the builtin versions.
>   - Copy the functions from builtin/submodule--helper.c to
> builtin/submodule.c one by one. Make necessary changes in the=20
> flag
> parsing.
>   - Once all the functions have been successfully copied, make=20
>   the
> default value of submodule.useBuiltin to true.
>   - =E2=80=A6eventually remove submodule--helper.c and the shell script
> entirely, and deprecate the =E2=80=98submodule.useBuiltin=E2=80=99 option.
>
> I wonder though how in the tests you are going to check both the=20
> new
> builtin submodule and the old git-submodule.sh? Do you plan to=20
> run the
> tests twice (once with submodule.useBuiltin set to true, and=20
> once with
> it set to false)?

Yeah, that is what I thought of doing--first test only the=20
component
that was ported with the configuration set to true, and then test=20
the
whole thing with the configuration set to false. It does slightly
complicate things more than I'd like, but I cannot think of a=20
better
way.

From what I could discern from the older threads and other similar
efforts, this was how it was done.
