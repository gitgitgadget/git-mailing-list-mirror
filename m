Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B84C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 06:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbiEZGHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346061AbiEZGHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 02:07:46 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B13BCEB3
        for <git@vger.kernel.org>; Wed, 25 May 2022 23:07:45 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dm17so1036705qvb.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJRwaopOHhwAAZvUgS5lAhF3Lkfu4fzp3SPiGSu+34s=;
        b=O3lCQs0r9uC9tq9PXh9bJ7gDvJozE8M0sWh2QhN2Oux0v8aXwzGw/T5lMEb0DG9p3o
         EaLp9BqXtljP+WAFmZdEYqGTZIT1ULdPRR5LalF2xNcZL6lBxwhJ7ktxejcft3bfxhqF
         +OiCvoGpqwfr5bIG32jtwEZGqsnWYc2k/3YjlGXQ+jEV5Xk0S2dRtp0pApF7mJ5vpvei
         G7SAc3G6787ZoJjDJLMmIGYTpfPcH0jHIxKSISP5l9gC9L9m10FTt8PTK+cFkfN5vLsk
         KIB6ZQCZkV31Z6j080ZLwS+sU+TF5d9X9QRMdnfk0b5jygEGCEYvamD3I0DeLtN5amAp
         0ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJRwaopOHhwAAZvUgS5lAhF3Lkfu4fzp3SPiGSu+34s=;
        b=gRZQ47Sq3oudLlgcE4LHjVvY0wXaIgDRmwGqCwQcyJF4YIDZ+UwRljyItsn8RWl1+Y
         TCD9OYEEGod79hTZOOyn55BmeEqLvpplRSJmTQSdCfeCbfFuQVC3dVuVFw3lhM8AQj6q
         GsazkD+/2J4Ox46fF9sl3fwyCLcCAhG9YBJe7Gb8ZzDYgH6VyHu4xJjoYP1T6jKH8nZ/
         +2D4A5DZH4DvieRgmN+ugU4R0s+n/hliICff0YoJ4rwf2ROkTf1HQiU9yuXS734tqfPA
         TcZDD3n9rGde5svbo0oEMtD7IMRmhnZMaQiF/MdWGc0a4TB/BI+0x2YWB5E0cYmFyjnE
         IV7Q==
X-Gm-Message-State: AOAM531RgsRkmZAU1kN0yX5JCkBzrMZNcgDyaCWT3RhrGnCam7hci7sZ
        jA0Q8Qej3loMllzjDOrHbVeTiOdu3COGwLQ+KqE=
X-Google-Smtp-Source: ABdhPJwO7fu5KMhtNUiJQ7LEKMu2nfXuWFS6VCiKzp8BrqAYb/BsFVRUeHoBxFRQQu8kZHzomuJcZJ7AsT5Td5AkCjs=
X-Received: by 2002:ad4:5fc9:0:b0:462:698c:772c with SMTP id
 jq9-20020ad45fc9000000b00462698c772cmr2943120qvb.28.1653545264857; Wed, 25
 May 2022 23:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtu9d45f7.fsf@gitster.g> <20220526021540.2812-1-worldhello.net@gmail.com>
 <xmqqo7zl2b66.fsf@gitster.g>
In-Reply-To: <xmqqo7zl2b66.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 26 May 2022 14:06:54 +0800
Message-ID: <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
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

On Thu, May 26, 2022 at 12:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > If there are unresolved conflicts left in the working tree, "make" may
> > report warnings as follows:
> >
> >     Makefile:xxxx: target '.build/pot/po/FOO.c.po' given more than once
> >                    in the same rule
> >
> > The duplicate targets are introduced by the following pattern rule we
> > added in the preceding commit for incremental build of "po/git.pot",
> >
> >     $(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
> >
> > and the duplicate entries in $(LOCALIZED_C_GEN_PO) come from the
> > "git ls-files" command in SOURCES_CMD.
> >
> > We can pass the option "--deduplicate" to git-ls-files to suppress
> > duplicate entries for unresolved conflicts.
>
> Thanks for a quick response.
>
> We certainly can say "your SOURCES_CMD MUST NOT produce duplicates"
> and passing the --deduplicate option is one valid way to fix this
> specific case.
>
> But I wonder if a more future-proof solution is to dedup the output
> of the SOURCES_CMD ourselves on the Makefile side.  That way, even
> if we update SOURCES_CMD in a way that could contain duplicates, we
> won't have to worry about duplicates.
>
> ---
>
> It feels way overkill to "sort" the list just to dedup its elements,
> but that is what GNU Make documentation info page recommends us to
> do, and we already do use it for deduplication in our Makefile
> twice.
>
> '$(sort LIST)'
>      Sorts the words of LIST in lexical order, removing duplicate words.
>      The output is a list of words separated by single spaces.  Thus,
>
>           $(sort foo bar lose)
>
>      returns the value 'bar foo lose'.
>
>      Incidentally, since 'sort' removes duplicate words, you can use it
>      for this purpose even if you don't care about the sort order.
>
>
> diff --git i/Makefile w/Makefile
> index 2b61f66259..1d3d3deba1 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -860,7 +860,7 @@ SOURCES_CMD = ( \
>                 -o \( -name '*.sh' -type f -print \) \
>                 | sed -e 's|^\./||' \
>         )
> -FOUND_SOURCE_FILES := $(shell $(SOURCES_CMD))
> +FOUND_SOURCE_FILES := $(sort $(shell $(SOURCES_CMD)))
>
>  FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
>  FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
>

If I disabled the git-ls-files command like below,

    @@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
     ## Exhaustive lists of our source files, either dynamically generated,
     ## or hardcoded.
     SOURCES_CMD = ( \
    -       git ls-files --deduplicate \
    +       git bad-ls-files --deduplicate \
                    '*.[hcS]' \
                    '*.sh' \
                    ':!*[tp][0-9][0-9][0-9][0-9]*' \

, and run "make", will display the following warnings:

    Makefile:2751: target `.build/pot/po/command-list.h.po' given more
than once in the same rule.
    Makefile:2751: target `.build/pot/po/config-list.h.po' given more
than once in the same rule.
    Makefile:2751: target `.build/pot/po/hook-list.h.po' given more
than once in the same rule.

This is because the three generated header files (defined in
$(GENERATED_H)) are also included in the result of "SOURCES_CMD". We
can fix this by sorting LOCALIZED_C:

    -LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    -             $(GENERATED_H)
    +LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES)
$(SCALAR_SOURCES) \
    +               $(GENERATED_H))

Will send v2 patch.
