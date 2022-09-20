Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB59C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiITToM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiITToK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 15:44:10 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE56CF76
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:44:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n124so5107660oih.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rG4zbL7yYpD3+Tw/q4NfR8mPBj/5KDPYbv43McyWnl4=;
        b=UDtmyMQfW4tlcXcXpkerKEwci0cOdiGdgNwTQTY0WYCRY+LlkPRbQ0UPVeDsq6izBz
         xX+xLee1Uh/Jj5Y0x+gDcimxKyajYZovX6bksdow0Eev6HI6nhGagPMwroEEKi2kxKuo
         i6AZ8qjAPI1rNmuo1i+P8DQ5p8KVhZHn0FXbCEMzHClx/C86jLgu+WUBb3hbPHjyr1rz
         XvzgUW70XA4vPT8fU6GC5mO86dQ2Bur6yCWhcqtvzlVJIVrmInP07kJGIB9GVQI/FE9V
         yWRylSR3nzae09cyBJOzsmqGWX8MT/JpRp3O9I9FB9J0VsT252MfSFhugDjc/sF5NSHM
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rG4zbL7yYpD3+Tw/q4NfR8mPBj/5KDPYbv43McyWnl4=;
        b=QRI519GwctF9ajlySOQuxfphkhIwAm2AxKoWm4pe+YCDYCLba4DIX51b7/HH89V446
         PseK/57NwhHkgwYKVUg6Et8fiKZmSGDPm4r8ZJGqEuvzYAKif4Yy2JQm7vUG2tWETEFj
         XsdAkGK762YwjlkLYiJ7H+xe3EOf34nZpp/W9nvV0pRwbu22opQzSSEDW7PTaDnaN6Ak
         1+5r42yRd7GkFWwmf9NM69W3cBsMAbe/OzwxdoztXJn5hqH0kHGh/0fU5r3KApRkaytu
         x79ehHEc1MI1PwJRtVEjm8pgTFMXf9eUTL0yBc/LPXcpXykSSoZZIGhGYRCL5Qq5/RlQ
         OZhA==
X-Gm-Message-State: ACrzQf0bs0/i9moniHGVtFz6zt3XSu5sgbecrpmekWTTftbn3FmsXAoU
        Tez4CRd6FaKoTidyzn1kNnSq8mzf+daaj1/WGi4=
X-Google-Smtp-Source: AMsMyM4/sxSlQ8YutdKBBes56OUyMMhWVrXTSfe1248BcxMFEfXt0tiKNrr0H+R4SovDLMqN+UZhB5FxnGEf4A0Aswg=
X-Received: by 2002:aca:59c4:0:b0:345:c243:4af with SMTP id
 n187-20020aca59c4000000b00345c24304afmr2312889oib.193.1663703048305; Tue, 20
 Sep 2022 12:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220920050725.326383-1-alexhenrie24@gmail.com> <YyoPXmNGAvl6p+C2@coredump.intra.peff.net>
In-Reply-To: <YyoPXmNGAvl6p+C2@coredump.intra.peff.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 20 Sep 2022 13:43:56 -0600
Message-ID: <CAMMLpeRCHbp0OgsXOoMhJcUjS=sUCDJmcA=S1_dbd6Vk31C3+w@mail.gmail.com>
Subject: Re: [PATCH] gc: don't translate literal commands
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 1:07 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Sep 19, 2022 at 11:07:25PM -0600, Alex Henrie wrote:
>
> > These commands have no placeholders to be translated.
>
> I think this is the right thing to do, but your commit message made me
> pause for a second. When you say "placeholders", I think you mean %s,
> etc. And yes there aren't any here, but that is not the reason not to
> translate. The reason not to translate is that the strings are commands
> which are given to a machine.
>
> So maybe something like:
>
>   There are no human-readable parts of these strings; the command you
>   type is still "git maintenance" even in other languages.

By "placeholders" I mean "things in angle brackets", like some of the
other usage strings in this file have. Maybe "argument placeholders"
would be more clear. I like that term a little better than the term
"human-readable parts" because these strings are part of the user
interface, so humans have to read them. But I really don't care
whether there's any explanation in the commit message at all. Junio
could just drop the sentence altogether when he commits the patch.

> Regardless, the patch looks good to me. Thanks for catching it.

No problem, and thanks for the feedback.

-Alex
