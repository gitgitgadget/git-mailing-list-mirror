Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE47FC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 07:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiEZHFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 03:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbiEZHFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 03:05:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76F4B4E5
        for <git@vger.kernel.org>; Thu, 26 May 2022 00:05:02 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i15so1068566qvk.6
        for <git@vger.kernel.org>; Thu, 26 May 2022 00:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CK7+Fskd0fKlvjAoBN/iD+8Ff7ffSPY2mbKhDqFq6Dw=;
        b=BNKlzgpQF22ARRJcsbTtUH4xShgX00ADK/iBvT9FQGOn8Cru61utHcLYEpuQfrpfnj
         oEuubJoxTrn0QHZDSnh4GsMF0WqYWPJh0nkYnIjsG/NfCToU1quLSf7maIkJsTint/di
         14XEi6oUl1b9sw7WbnKAYNocmytCXMK9aQbmj9riO1d9rGiJqr/ENffD4vYhBBqZhBMp
         ClTQixahQXdonUas0dlZ5Ddbd6t7CGNmvFp/vPvQOJbvLmpJqBSIs6ZqAhy92630y8ap
         2coD1JPXnydr9QiRn+ydj9fGlB/uFYvx1xnsH88ncB8AvAu2N2X+Uq8xRs4RAQHj3MOp
         FLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CK7+Fskd0fKlvjAoBN/iD+8Ff7ffSPY2mbKhDqFq6Dw=;
        b=4zvEfaOYAsko2bVel897pZ3HvZFjY6QBOJRM5st/Z8mY1onkTXlUr5iAf8KFoV722i
         EYANnDtnSAlPLmcRCRDvZMewEYEZ6ozqOKub8A/blKE51nAekDAfuHbtdlYoCVxfcaPq
         D0Ic7pvuK1BozhPip/g19zvnOqjfXkJUYhXSBBL1V44kAiSxjFj8QV4tJim1leZGVYjG
         AAlM6Oa3Jb7BnV8zXErUVrfBEwT6Y8Slc8C7ApanEcexnYF1cTRI4l9COcuRBMTTPf8O
         NWXEkCsocPP6pnv3kLCFCdoK0x+ndVUgFy348ywjN+JQkmVceW+JbxvbU9SiwaAFc1mG
         E64w==
X-Gm-Message-State: AOAM5334fLpw8JEPd4iJZiutHxwLgAzSlKCNvqccbmDfHPKASApUuk56
        ZbKdFMBpG0VYz8RQdvvJHrHqR3Xdp5E+ByC8yjk=
X-Google-Smtp-Source: ABdhPJy2Oig9jaxoDmIvYHRDejeHDH1AhK+i5AeJb2ZbY/ecmZR2dYvjY2pTSIPKnidmlgTGIyEq/v3CIibxINVhSzI=
X-Received: by 2002:a05:6214:c21:b0:443:a2d2:a685 with SMTP id
 a1-20020a0562140c2100b00443a2d2a685mr29678790qvd.52.1653548701165; Thu, 26
 May 2022 00:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtu9d45f7.fsf@gitster.g> <20220526021540.2812-1-worldhello.net@gmail.com>
 <xmqqo7zl2b66.fsf@gitster.g> <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
 <xmqq5yls3j8i.fsf@gitster.g>
In-Reply-To: <xmqq5yls3j8i.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 May 2022 15:04:49 +0800
Message-ID: <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent duplicate targets
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 2:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >>         )
> >> -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
> >> +FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
> >>
> >>  FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
> >>  FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
> >>
> >
> > If I disabled the git-ls-files command like below,
> >
> >     @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
> >...
> > This is because the three generated header files (defined in
> > $(GENERATED_H)) are also included in the result of "SOURCES_CMD". We
> > can fix this by sorting LOCALIZED_C:
> >
> >     -LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
> >     -             $(GENERATED_H)
> >     +LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES)
> > $(SCALAR_SOURCES) \
> >     +               $(GENERATED_H))
>
> If you make FOUND_SOURCE_FILES unique upfront, the at least there
> wouldn't be any duplicates there.  Do you mean that some of what is
> in FOUND_SOURCE_FILES appear in either SCALAR_SOURCES or GENERATED_H?

Yes. If find source files using "git-ls-files", the generated headers
are not included in FOUND_SOURCE_FILES, but this is not the case for
the find command.

> If not, I think deduplicating near the source of the issue, i.e.
>
>   FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))

If we pass the "--deduplicate" option to git-ls-files, we can make
sure files are unique in FOUND_SOURCE_FILES. So sorting
FOUND_SOURCE_FILES becomes unnecessary. But FOUND_SOURCE_FILES may
contain generated files if using find instead of git-ls-files in
SOURCES_CMD, that means sort FOUND_SOURCE_FILES is not enough. Instead
of sorting it, we may want to filter-out the generated files from it,
like:

    FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))

Exclude the several generated headers by add extra fixed options to
find command is not good, but we may need to exclude the ".build"
directory from the find command in SOURCES_CMD, in case we may
duplicate C files in it in future version.


    --- a/Makefile
    +++ b/Makefile
    @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
    ## Exhaustive lists of our source files, either dynamically generated,
    ## or hardcoded.
    SOURCES_CMD = ( \
    -       git ls-files \
    +       git ls-files --deduplicate \
                   '*.[hcS]' \
                   '*.sh' \
                   ':!*[tp][0-9][0-9][0-9][0-9]*' \
    @@ -857,12 +857,13 @@ SOURCES_CMD = ( \
                   -o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
                   -o \( -name contrib -type d -prune \) \
                   -o \( -name build -type d -prune \) \
    +               -o \( -name .build -type d -prune \) \
                   -o \( -name 'trash*' -type d -prune \) \
                   -o \( -name '*.[hcS]' -type f -print \) \
                   -o \( -name '*.sh' -type f -print \) \
                   | sed -e 's|^\./||' \
           )
    -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
    +FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))

    FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
    FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))

> may be sufficient.  Deduplicating near the consumer, like
> LOCALIZED_C, may force us to dedup all the consumers of it (e.g.
> LOCALIZED_C is not the sole consumer of FOUND_C_SOURCES; you'd need
> to sort the input to COCCI_SOURCES, for example).

If we apply the above patch, sorting LOCALIZED_C is not necessary.

--
Jiang Xin
