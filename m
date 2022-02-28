Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFBC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiB1QgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiB1QgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:36:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F0C5A5A6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:35:31 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so1242892ejc.6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WiCTlqeKc9TmXIAY2I/0tIDxGJJ6rKbDLhBjmhKJR0A=;
        b=deqkNujknFFlaXD1OTPEAi/oCY6/UjkYu81fFEDbhKjZ0S3MwI/2fI5TLKR0l5PKts
         rzIEnrj+NZyRQe37fkApouEVEIQYdRhzgBWTcgNaPFxpZeGfJ4qkfShvQJIyWW5ndUxp
         1s74GfaPeRIZlUUZcfzIdUHKqXrEYDBcM3I4WfG0u06iirxkNDYeltaQujXjexW95QWO
         WsaScrxg2QJbQYvZxr/RQ68pyrT/gidEo5Boc9/ulx3s/bGNzUppFw6aQKuILA3wG95k
         VsfbCRw5gPvyRt9ddDK0mwY2MUYoa7czOkdw+2De1ICT1Wxi1Y27IR5k9a3zmHjltIRh
         /zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WiCTlqeKc9TmXIAY2I/0tIDxGJJ6rKbDLhBjmhKJR0A=;
        b=o5s0e1K+YRxhKd3XsdVYIRmCj6l/ets8/1ZL7DQIuyfL022dDOhW+G1GjcNL3HNMO4
         epNJ1vki8fSNvQyNNwR/GMSAdSigBTD+EWOHHBGZgpzA4J4Z+3oG43D65yopc2730Nuh
         d5EgV6n4ZV89rgbI6k11x4vDjPEj1/cM/iz6dQoZwD8DXqXNZs+FO3QyTUzLPIQZfP5Y
         prcKQX5BlfOc/hY58UXCZXZqfS1I2x/V+bemHK8EEPVwIMl6qIJU1TO0yEJ8GG0srGFZ
         U+3gcNGfC/aXVDnwIgYkgkgc9WouXw2FVq5LH06HFiC9UYK6hs3bl4e1GFNm+59VhMog
         QyNw==
X-Gm-Message-State: AOAM530WPulBKzYt5Td1teRxsiPQ9LouR/5F4cidZMgP4uEnTXLoRS4I
        nyQtnUbgFa+cOGX2lDx/yXE=
X-Google-Smtp-Source: ABdhPJxPw2AKjYixbWWW0kMaLyKI36RRCqr2APRa3rS9RBhVN+58MpO0WIowOyyQGBb66PNwEJuI3Q==
X-Received: by 2002:a17:907:9086:b0:6b3:fce8:50ee with SMTP id ge6-20020a170907908600b006b3fce850eemr15627554ejb.390.1646066130203;
        Mon, 28 Feb 2022 08:35:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id et18-20020a170907295200b006d582a4be8fsm4487079ejc.68.2022.02.28.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:35:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOizg-001TFy-PO;
        Mon, 28 Feb 2022 17:35:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
Date:   Mon, 28 Feb 2022 17:34:53 +0100
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
 <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
 <faa70086-3c15-1187-93a0-88f1e1120dbf@gmail.com>
 <220228.867d9f5jat.gmgdl@evledraar.gmail.com>
 <90d23574-a211-1294-c842-9e033757972d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <90d23574-a211-1294-c842-9e033757972d@gmail.com>
Message-ID: <220228.86zgmb2blb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Phillip Wood wrote:

> On 28/02/2022 11:16, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Feb 28 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 25/02/2022 09:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> We have various behavior that's shared across our Makefiles, or that
>>>> really should be (e.g. via defined templates). Let's create a
>>>> top-level "shared.mak" to house those sorts of things, and start by
>>>> adding the ".DELETE_ON_ERROR" flag to it.
>>>> See my own 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR"
>>>> flag, 2021-06-29) and db10fc6c09f (doc: simplify Makefile using
>>>> .DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
>>>> ".DELETE_ON_ERROR" flag.
>>>> This does have the potential downside that if
>>>> e.g. templates/Makefile
>>>> would like to include this "shared.mak" in the future the semantics of
>>>> such a Makefile will change, but as noted in the above commits (and
>>>> GNU make's own documentation) any such change would be for the better,
>>>> so it's safe to do this.
>>>
>>> I was confused about the mention of templates/Makefile in this
>>> paragraph, it seems to be saying that the behavior would change in the
>>> future if we included shared.mak in templates/Makefile but this patch
>>> does exactly that.
>> Yes, oops! It's a zombie comment that I forgot to adjust from an
>> earlier
>> version of this where that wasn't the case. Will adjust & re-roll.
>>=20
>>> Also does this patch mean we're now using .DELETE_ON_ERROR in places
>>> where we were not previously using it?
>> Yes, we'll now use it in those other Makefiles as well. The commits
>> referenced in the second paragrap of the commit message argue for this
>> being safe, and I've reviewed the logic myself & don't expect any
>> problems with it.
>
> Thanks for elaborating, maybe it is worth spelling explicitly in the
> commit message that this is turning on .DELETE_ON_ERROR in places we=20
> didn't previously use it. I had a look at the commit message you
> referenced and it seems to make a good case for using
> .DELETE_ON_ERROR. Having a shared makefile for common code makes sense
> and the speed ups from some of the other commits are nice.

Thanks, yes, willdo :) I have a re-roll of this queued up for
submission, after sitting on it for a bit longer to shake out any
potential last-minute issues...
