Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A4AC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiESJZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiESJZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 05:25:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1209CF46
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:25:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gi33so253077ejc.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=V9OlpwGnydwBoEaBEph8Dd254aKcAou05DzJwMmiOkY=;
        b=CDtzAgoWQTh/su4L8iKhLehTDbQAXDA+roISMSrqHFR1raqbc58vT1sVaxu9T0Gfj7
         uugrHicXtDmWBPKzUYk2614X6CHbMhAAe5FQhg9RtUo9I2CcNEUVI24nCgMJz2Z1Bttb
         h7E3/H6LtETQwULhllzxm6bptryXNVVYoFfyHUOfBMWhGnAvC+FLPtTyi/5FB412Da47
         QAcF4WaW/TL4bZIv0RYNvTC9b5+zPpio4uYtsna06UYPQIfKmb5U4AIkaESEAlCqzM0j
         bKbwvFVD3Q3q0KYRdV/QG0k2HVJnhpus3WauXJXx0uWpz4Gh1odP1NtkeOsX3AirFpHi
         nb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=V9OlpwGnydwBoEaBEph8Dd254aKcAou05DzJwMmiOkY=;
        b=xN7RI8fFMU+Oe9Ozj7GScGb9Ec71gQmXM8BpWI3/BncyBV/V8Vbjo7N1SydqI6uBiH
         AIytNFZDVSTuwSInY0GowZ1lAZOijnaowahiUp4vpSaRs/peklk/0+vHe8PRhsw+70aU
         nfyvVVfKv0XMZxr4Dp/5YhJ401JFVkQAtBUBMDgNIQD7Dhq5VvcKcCfeebz46oPq5nv6
         pyTHfR4lO/nt5FajqIq0FA9BgdNaoGeVIKMEAo1g8EIO3APLstUjf1KE/VqErlNEPcWY
         F0cqkZUyAHEWGvz65/brql5KHyzmjVVjJLx4t23hHDvuXEsM3oOW85/B3F5xvW9IKdOt
         g5zg==
X-Gm-Message-State: AOAM532dYjPrw9kH8ijpVejJs57N8ITiUmvprlAb6YiAYY4fi7nyPPRu
        sHDMZjIYJTNB/vt8EyWa6n4=
X-Google-Smtp-Source: ABdhPJx+KVl7/5YE2Do3WW04GiSEf1ZkoM/xwv1OPOLmTdlbzvZrQzKsgQlunEZYCdwCRwaOPo/MbA==
X-Received: by 2002:a17:906:c110:b0:6f5:77de:2324 with SMTP id do16-20020a170906c11000b006f577de2324mr3299394ejc.143.1652952334440;
        Thu, 19 May 2022 02:25:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id og9-20020a1709071dc900b006f3ef214deesm1900034ejc.84.2022.05.19.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:25:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrcPU-0021WY-KJ;
        Thu, 19 May 2022 11:25:32 +0200
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
Subject: Re: [PATCH v2 2/9] Makefile: generate "po/git.pot" from stable
 LOCALIZED_C
Date:   Thu, 19 May 2022 11:18:17 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-3-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-3-worldhello.net@gmail.com>
Message-ID: <220519.86pmk96fhv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When running "make pot" on different platform, we may get a different
> message template file "po/git.pot". This is because the "LOCALIZED_C"
> variable may have different C source files on different platforms or
> different compiler conditions.

As noted in my review of 1/9 this part of the rationale makes perfect
sense, no matter what we should always get the same results from "make
pot" on different platforms.

And I like the simplicity of using FOUND_C_SOURCES, unfortunately...

> We can make a stable "LOCALIZED_C" variable by applying patch snippets
> as follows:
>
>      ifdef NO_LIBGEN_H
>          COMPAT_CFLAGS += -DNO_LIBGEN_H
>          COMPAT_OBJS += compat/basename.o
>     +else
>     +    LOCALIZED_C += compat/basename.c
>      endif
>
> But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
> "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".
>
> With this update, the newly generated "po/git.pot" will have 30 new
> entries coming from the following C source files:
>
>  * compat/fsmonitor/fsm-listen-win32.c
>  * compat/mingw.c
>  * compat/regex/regcomp.c
>  * compat/simple-ipc/ipc-win32.c

Those files which list "our" code look like obvious bug fixes, i.e. we
are the primary maintainer of that compat/* code, so we should do the
translation.

But the inclusion of compat/regex/regcomp.c there is a bug IMO. It's
code we got from glibc/awk. Do we really want to be using translator
time on that?

Hrm, maybe. After all those systems (most notably Windows) won't have
glibc/awk's translation catalogs, and in any case even if they did we'd
be using some ~decade old version of the code, so the two won't match up
well.

So maybe this is fine....

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 83e968e2a4..60ca42c268 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2714,7 +2714,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
>  	--keyword=gettextln --keyword=eval_gettextln
>  XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
>  	--keyword=__ --keyword=N__ --keyword="__n:1,2"
> -LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> +LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
> +	      $(FOUND_H_SOURCES) $(GENERATED_H)

The SCALAR_SOURCES seems snuck in here, but it's worth noting in the
commit message that we effectively had it here before as part of C_OBJ.
