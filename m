Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84389C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCFSQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCFSQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 13:16:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D528D39
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 10:15:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i10so11364723plr.9
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678126545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w53l7HCvAUukdGw6GzAh38RiGMDNjlBjHYqWAKc9zg=;
        b=XeZuDBBR40HndaF/rghwhAQgm/jmyhX3Jb7WsAtq8DvxGnq/u5N4D8ffcA/EKu227t
         2RBJlt1y2JsN2SDbUJ1k08pV7xc+U88k9alJCOTBNMdcq+h4y/POTNzNJ/4+l2se0uOK
         jexejP4RAMGx1m3MXCr2zNy4sNuQwLsAw/rBf3e9Ra4ND4T34sHh4NzfbayFivOiFpks
         k3VIYJYqTYzrjDTORLiNHex1jEct9CZJwnGL5sHTrPsIfnOTBFvYyx0rRhzZFvo+NSQh
         3z5XO4YJ3AYpdSrupvqqzpNVw14RPITZmShZeWdPz/0tlramdGPjdWhqXEY2JcbtD0uj
         0bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126545;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6w53l7HCvAUukdGw6GzAh38RiGMDNjlBjHYqWAKc9zg=;
        b=THo0jvZXGo0oyCBvxIo5uFPk9vQq4ePMEkClUNmbvGCKqBl+6YhgMzd5GCANqEHOQv
         ewvGqpRh1e1vPi0o9AN7oKukhqCg+mbC1IuxRiL3FRgqziqcklQB484ENP0gU6qzOWH6
         a8kc7ueQgC8xtWl5kwzx5iOgiGuy+jlsIMzaYcOpmsEEl/of20UFrax3fmG4K2VmbEds
         D1Aa3jjEmCwZ/s24csUvEvahmvOG58TZe4PrycsSASBPZ/gzzNH5pSeDx8IGCH5DI+jL
         RCosy3dsgmE8xu3LjpaqVTmdYLLfRHKsYf/23In1fdCbO+XPOwEVACvGiOsw29lK4ufq
         h8xg==
X-Gm-Message-State: AO0yUKWbCzOWbIJ1GPKR7G7l2wPWbC8FVYpxzbGmOeTB5JCsqvLnzi5d
        1s7CGGS2tl0Au2BHkdFYQ4A=
X-Google-Smtp-Source: AK7set9kNj+QqRGvFiSx9AurtFaiNsqGHi/yE5GdTW8ZaFnurd9oucDOLKcuu5T+NwxRNEvXGdORWQ==
X-Received: by 2002:a17:90a:19e:b0:230:8ec4:3c0c with SMTP id 30-20020a17090a019e00b002308ec43c0cmr11686694pjc.18.1678126544762;
        Mon, 06 Mar 2023 10:15:44 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090acc0300b00232cc61e16bsm7957824pju.35.2023.03.06.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 10:15:44 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH] test-lib: allow storing counts with test harnesses
References: <20221224225200.1027806-1-adam@dinwoodie.org>
        <20230304212220.qkzc2joco5xj7d4s@lucy.dinwoodie.org>
        <ZAWq5VFE/UjjtPJS@coredump.intra.peff.net>
Date:   Mon, 06 Mar 2023 10:15:43 -0800
In-Reply-To: <ZAWq5VFE/UjjtPJS@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 6 Mar 2023 03:57:09 -0500")
Message-ID: <xmqqr0u1agq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So would it be worth it to just revert 8ef1abe550, and always store the
> meta-files? That's one less option to support, and one less surprise
> when some other feature is built around them.
>
> Or is there some reason that we really want to have a mode where nothing
> is written into t/? From reading 8ef1abe550 it sounded like this was
> mostly a hygiene / optimization thing, and not some special mode we
> cared about supporting.

Interesting thought.  It would simplify our lives to have fewer
conditionally-moving parts.

>>  t/test-lib.sh | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> The patch itself looks correct, if we want to go with a --counts option.

Yes.

