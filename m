Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D1AC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 07:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiEWH2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 03:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiEWH1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 03:27:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160E4833B
        for <git@vger.kernel.org>; Mon, 23 May 2022 00:25:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so26770830ejj.10
        for <git@vger.kernel.org>; Mon, 23 May 2022 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aq6d9PW4F+yhQPLs6Rk4jucIs1Gw+w+ObSYrX0xDXrg=;
        b=jfuKxNA0255i+pcffXFfGRaPH4pT8Hzh+WVyeDzkUs81l1NNELvWh4qauNrmkueyku
         q6FmXfs4tY/hIqjai7tRDEg6MsxvN/XJK7O2otMvvJvFxIWixlQp0xyNvUgUnGGUCtsi
         SLQuYl2GEi5mf3k4x9ug7P9bWx3r5JP7EOQ69bSPdGFJY1ibZVlZ6uiR6NXeDvY9lNYT
         8DPYHfqaZXf3flAbAwM5o8oDYYdt12/Qx6jOwgPDJS88HacpS6ewcHDW+KqwB90kAKG6
         XijQjCTBk4sN+w2AIE7AmHqPTmKxsa6cII0BpQ+0QmeMTAnlHjC5Duunfu/QhHNEEkoY
         fLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aq6d9PW4F+yhQPLs6Rk4jucIs1Gw+w+ObSYrX0xDXrg=;
        b=aeSh3B3lFIq/RtiNOyhJ881hQIw+tWN4KWCgTjZWnT+PlHAzISwmI+Qo/0ms3/N74M
         SfpRvvWR1RhSpHoF3yPmml6/aSz2pGlvYTTzZrfRuljKnz9dQEGeH2IS/Iv3NfibLWOz
         k9DBfXrf12Y0/oeVjjSIlw+p4DMWB/D0Y0aoLL21NK5B1j6HsIBK6mXFRt2dFe/e+f6D
         1gETW/z3fDK82+4qlMh9dFgW6HFFksMpGomwhsEMHjRn81XxaDkOF2L99uU1U94QpdeH
         29ZSFP6/02oZV2sHup9p7O6uidLl18c0Zir27vcwaV8Fpdz2+MGeot2FxkXc/ZwzdxGC
         VanQ==
X-Gm-Message-State: AOAM532alH8ZK/6svqQBICg6gE2b8LCyi7IDd1GNh5NpSf3HajPes16R
        cPIcU6tLcjQOe53yVV+k9ys=
X-Google-Smtp-Source: ABdhPJx0U/I6IbvOi0SbUsSB2+YRyO3W8B8K/cUKdWRAqFntN0dTZthq+DhbcM3/nNE8mIYTbtJmFg==
X-Received: by 2002:a17:907:6d90:b0:6fe:bac0:5ba with SMTP id sb16-20020a1709076d9000b006febac005bamr8847693ejc.29.1653290705171;
        Mon, 23 May 2022 00:25:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k7-20020a1709063fc700b006feece1e053sm541656ejj.90.2022.05.23.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:25:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt2R3-002mjC-Uw;
        Mon, 23 May 2022 09:25:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Mon, 23 May 2022 09:15:43 +0200
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220523012531.4505-1-worldhello.net@gmail.com>
Message-ID: <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> A workflow change for translators are being proposed.
>
> Changes since v2:
>
>  1. Patch 1/9: reword.
>  2. Patch 2/9: reword.
>  3. Patch 3/9: reword, and add "FORCE" to prerequisites of "po/git.pot".
>  4. Patch 6/9: remove "FORCE" from prerequisites of "po/git.pot".
>  5. Patch 8/9: reword, and reuse "$(gen_pot_header)" to prepare pot
>                header for "po/git-core.pot".
>  6. Patch 9/9: various updates on po/README.md.

From skimming this the *.c.po v.s. *.c extension is still left in
comments. I'm not saying you need to go for my suggestions, but it would
be very useful in CL's to note things that were suggested but not
changed, such as that.

Right now I haven't paged that v2 discussion into my brain again, so I
don't know if that was the only thing, it's the only thing I remember
right now...

But let's read on:

> Range-diff vs v2:
>
>  1:  c45f34f233 !  1:  362cd0cbe1 Makefile: sort "po/git.pot" by file location
>     @@ Metadata
>       ## Commit message ##
>          Makefile: sort "po/git.pot" by file location
>      
>     -    Before feeding xgettext with more C souce files which may be ignored
>     -    by various compiler conditions, add new option "--sort-by-file" to
>     -    xgettext program to create stable message template file "po/git.pot".
>     +    We will feed xgettext with more C souce files and in different order in
>     +    subsequent commit. To generate a stable "po/git.pot" regardless of the
>     +    number and order of input source files, we add a new option
>     +    "--sort-by-file" to xgettext program.
>      
>          With this update, the newly generated "po/git.pot" will has the same
>     -    entries while in a different order. We won't checkin the newly generated
>     -    "po/git.pot", because we will remove it from tree in a later commit.
>     +    entries while in a different order.
>     +
>     +    With the help of a custom diff driver as shown below,
>     +
>     +        git config --global diff.gettext-fmt.textconv \
>     +            "msgcat --no-location --sort-by-file"
>     +
>     +    and appending a new entry "*.po diff=gettext-fmt" to git attributes,
>     +    we can see that there are no substantial changes in "po/git.pot".
>     +
>     +    We won't checkin the newly generated "po/git.pot", because we will
>     +    remove it from tree in a later commit.


Does this actually work? This seems to suggest adding a driver for *.po,
but using it against the *.pot file. Isn't that a typo (I haven't tested
it)>

>          But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
>     -    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".
>     +    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C". We also add
>     +    "$(SCALAR_SOURCES)" files, which are part of C_OBJ but not included in
>     +    "$(FOUND_C_SOURCES)" because they are in the "contrib/" directory.

Thanks, good to note that.

[snipped the rest, will re-read individual commits]
