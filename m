Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FAC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiEZTV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiEZTVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:21:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7EDFF54
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:21:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rq11so4823793ejc.4
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TQRm8RwzlkzHyg/NLGPZYxSynGKWdY2y8cid+W9QBbc=;
        b=MsC1brU9j4bEGhqthtxu7nnpQsZKWIkdAUYXIKtPxWK5faYHkefpuLLBsPDDzd8WVj
         rkceAHQBXr51Db4b0nsKjlZanP8L+kfBzOqUBgRqwttEtT0wr/PpigQ6TeU2qWiJtXKX
         NwmdRrUBexnC3ZPzVfgy6SRBJSeNf0zT4g8jVJEegWO20gTQ26abck1fSzyZhEg9XyG3
         cO8RPh8e2Fj7DKePhJMozLj005cbQW1Gj2oBfQVDC4FHDbl56b01OeL64N0wiIW9PQ1F
         FS5/qjgnweIRJtbaq/vFocF7naeqKCBURwPoyEt1x2m3m14S1LIqC4+F17cnZCqVX7iP
         piXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TQRm8RwzlkzHyg/NLGPZYxSynGKWdY2y8cid+W9QBbc=;
        b=DtP8N2ZQ0xIRtUKvY33T976h9qEmGp4bd1CQ6ckf74r5k9icgTOk65oi1APZPhXlM2
         d6VBErFN8GDewxlDBNKGKqrRGF1iFm82F4CwH8QH6MMe0XYxy2OPBuEvVQoWzGpKWVOl
         nqkrCNOuPh1Fmq5Rze29CrHejmiNdqnvVNdYoccxTEnXy70tnSSbutcdpE8zAWjU4FIO
         xzr4IIujpq9gljuEXa4o7VbZasRalP0VEe8LFJF4Z6PCTlBmaNv4uPbbjTP8r8Uh6nGl
         OEGOAylAU7FZTbwuOMhdopLIhZKjUqjQ+68KlrDKikJPun/azV9PaYz8Mk+dLIybS1Z4
         yQ1A==
X-Gm-Message-State: AOAM530hxVqPPLL/NNkXmI6UShv2f6OSlo2+f1vTz7CI+zrSH3f8FIXq
        oHKj0csr29Ce3JiH3zQa1S8=
X-Google-Smtp-Source: ABdhPJyhy4rlb8MI+AdJlc9AeyEEWoYcm5E6PEgkp6wVp4b5g/1PqR2Q9oCrPnlEpSOnZ47+fSl6Hg==
X-Received: by 2002:a17:907:98ee:b0:6fe:a657:171d with SMTP id ke14-20020a17090798ee00b006fea657171dmr30007494ejc.34.1653592881353;
        Thu, 26 May 2022 12:21:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k25-20020a508ad9000000b0042bcc931c84sm1096380edk.56.2022.05.26.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 12:21:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuJ2t-000GlA-En;
        Thu, 26 May 2022 21:21:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
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
Subject: Re: [PATCH] Makefile: dedup git-ls-files output to prevent
 duplicate targets
Date:   Thu, 26 May 2022 21:17:59 +0200
References: <xmqqtu9d45f7.fsf@gitster.g>
        <20220526021540.2812-1-worldhello.net@gmail.com>
        <xmqqo7zl2b66.fsf@gitster.g>
        <CANYiYbEcNJ7+7XW-8-v+p8q=aiOP9RJYvST8ethVjxVdNugR5Q@mail.gmail.com>
        <xmqq5yls3j8i.fsf@gitster.g>
        <CANYiYbGn08N_9bOw+ss6L4U_iTomc-08_961bk40eq1BnEstiw@mail.gmail.com>
        <220526.86tu9c625s.gmgdl@evledraar.gmail.com>
        <xmqq8rqo1ad3.fsf@gitster.g>
        <220526.86czg05ert.gmgdl@evledraar.gmail.com>
        <xmqqh75cyv8y.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqh75cyv8y.fsf@gitster.g>
Message-ID: <220526.86a6b43xsg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Does "--sort-by-file" really mean that?
>>>
>>> The option is documented to sort output by file location, but does
>>> it mean without the option (i.e. default), there is no guarantee in
>>> the output order?  Or are we sure that the output is sorted by the
>>> order of input files, and that is guaranteed to hold in the future?
>>>
>>> If we are depending on certain ordering of the output produced by
>>> gettext suite of programs, I would keep the option, regardless of
>>> what we do to the input to them, if I were running the i18n part of
>>> this project.
>>>
>>> But I am not, so I would not complain if --sort-by-file is dropped
>>> against my advice ;-)
>>
>> The gettext docs are pretty light on the subject, but the default "sort
>> order" is none at all. I.e. it'll just inhale source and spew out
>> translations in the order you feed them to xgettext.
>>
>> So in order of input files, and then in order they're seen in the
>> program.
>>
>> I don't think that's ever going to change.
>
> OK, so as long as make's notion of $(sort) and gettext suite's
> notion of --sort-by-file are the same.

They're not, I mean $(sort) and xgettext's *default* behavior are the
same, but the --sort-by-file is not only a sort by file, it also affects
intra-line-number sorting, although that's an admittedly obscure case
(we have <10 messages where it matters, I think).

> , we didn't make any change, and even if they were different, since
> there is no version of Git that uses "--sort-by-file" while preparing
> the po and pot files, it still is OK.

Well, it would be OK in any case, this is just how we prepare the
git.pot file, but it does affect diff churn eventually in the *.po
files.

> As long as make's $(sort) is as stable as gettext
> suite's "--sort-by-file" across developer locales (and our filenames
> are ascii-only and hopefully will stay that way), everybody will get
> the messages in the same order either way (or we would have the same
> problem so switching from --sort-by-file to $(sort) is not making
> anything worse).

FWIW we can't in the general case rely on the Makefile's $(sort) working
the same way across our platforms, but I don't think it matters in this
case. IIRC there's versions of one Windows setup or another (this was
via CI) where "-" at least (the purely ASCII one) sorts differently.

I ran into that in some Makefile experiments where I wanted to use
$(sort) to assert that our various hardcoded lists were in sorted order
already.
