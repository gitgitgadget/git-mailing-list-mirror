Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2547C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6F61919
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 11:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhGCLtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhGCLto (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 07:49:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A5C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 04:47:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m1so16888763edq.8
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=CPIBMOKNI4mKdyQ4UbRxDNaZc/bzan79Fl5FAsx8PSE=;
        b=D28lqmczaaz+MOhbLkyaKqKmScAA5cM+baggPNo/WesUa0R2xSXOyaeEJP0MqWqM6X
         8+RYTBFj5N/5i4ybv4adjHDnhXvTZJbk5gQfpwa9Xqj3CqHDPnoTmtMSqV6OvDZFQeVl
         nsrjSOLwXZZ619nxeZ0e9H9WJ+0JZoQ04mIXtkZBdz14aKPylSRxAnZhBKJxpvxqFeQ9
         z/e4xj8en8f/kqhLtsEf593YMDm9xEqZMbVBSYc+C3jBhc8QxIFXCBmxeEb6Hujfjz10
         6+cW41dcUJnRGhnpf8VXDWHMEUXIUwsnqNXU25iLE2UYxDX2EA0FLFnPiLcApdDasiUJ
         nS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=CPIBMOKNI4mKdyQ4UbRxDNaZc/bzan79Fl5FAsx8PSE=;
        b=CqmU4/+QTSpEERyFVV0Bd/fRWudu0ZO9MvtY5vDdQ6/+QkjN3qO4cgwBtTRle+zC+O
         T/JZ8ABOT9tU2UXOyo5JZe9Vktzy6n3H7LYRyDF66RreJK2fQx55TllQwnMwhmsSzxyb
         KLnD9OT8XPKrEDX1CImK/q0KgI+SkIgjnPm2VSMSQNHnb2mjlM0bWOBMUFBeWrhLYJiI
         YZUDegdyt1mEMr3yWLoTOmBxUJToKCoCJyZ6SPjLHWEENKRlwnTc7AzvImM1ETix3AvM
         SIICFLrTVovc/6MN7U5MEBk7ONBwWtM/8W8hyumV9qPn81pQCKYngxwai89gewu7vSSp
         0+yA==
X-Gm-Message-State: AOAM5321xdZ3UEJHeepWh6Qu03GqrDyQenyPRJg+yT5/f19V5Lqb9ygP
        dGptWCHJxuS4gsX1l/p44qaQyd95+WdSvg==
X-Google-Smtp-Source: ABdhPJx4AfFcINtBRU5BGNeH3uusyksiNLgWiL1CzPgQktUrKq35g11zxz/yIoWz5u91loVanSItag==
X-Received: by 2002:a05:6402:498:: with SMTP id k24mr5035387edv.25.1625312828748;
        Sat, 03 Jul 2021 04:47:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v5sm2496877edy.50.2021.07.03.04.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 04:47:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jimmy Angelakos <vyruss@hellug.gr>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>
Subject: Re: [L10N] fixed mismatched variable names
Date:   Sat, 03 Jul 2021 13:43:59 +0200
References: <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
 <20210703111837.14894-1-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210703111837.14894-1-worldhello.net@gmail.com>
Message-ID: <87sg0v8vr8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Jiang Xin wrote:

> From: Peter Krefting <peter@softwolves.pp.se>
>
> On Tue, Jun 22 2021, Peter Krefting wrote:
>
>> Andrei also pointed out another typo in the Swedish translation, where
>> a configuration option had been copied incorrectly. Could you please
>> amend your patch to contain both these changes?
>>
>> ... ...
>>
>> @@ -2734,7 +2734,7 @@ msgstr "Felaktigt %s: \"%s\""
>>   #: config.c:2512
>>   #, c-format
>>   msgid "splitIndex.maxPercentChange value '%d' should be between 0 and =
100"
>> -msgstr "v=C3=A4rdet \"%d\" f=C3=B6r splitIndex.maxPercentage borde vara=
 mellan 0 och 100"
>> +msgstr "v=C3=A4rdet \"%d\" f=C3=B6r splitIndex.maxPercentChange borde v=
ara mellan 0 och 100"
>>=20
>>   #: config.c:2558
>>   #, c-format
>
> There are definitely more typos like this! In order to find mismatched
> git config variables and other mismatched variable names in the po file,
> I implemented a checker for such typos in the "git-po-helper" in commit:
>
>  * https://github.com/git-l10n/git-po-helper/commit/e44df847abb9122777156=
0aca56719031f280068
>
> To find typos, run:
>
>     git-po-helper check-po XX.po
>
> All easy-to-fix typos can be fixed using the following patch, but there
> are still some typos need to be fixed by l10n team leaders for the
> following languages:
>
>  + bg.po=20
>  + id.po
>  + tr.po
>
> Patch for easy-to-fix typos, cut here -- 8< --
>
> Subject: [PATCH] l10n: fixed mismatched config variables
>
> Andrei pointed out a typo in the Swedish translation, where a config
> variable name had been copied incorrectly.
>
> By introducing typo detection function in "git-po-helper", more typos
> were found. All easy-to-fix typos were fixed in this commit.

This seems like a good narrow fix for now, but I'd think a much better
fix would be to e.g. add something to the CI or a lintk check based on
"git help --config" that errored if any string meant for gettext
contains such a variable.

It's data that isn't meant to be translated at all, so we should be
passing it as %s to the format string.

I see there's at least one fix that fixes a reference to a function
internal to git.git, such a check wouldn't catch that, but that message
should be fixed too. We shouldn't have anything referencing code names
except the BUG() messages (which we don't translate)>
