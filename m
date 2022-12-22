Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B055C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 09:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiLVJSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 04:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiLVJSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 04:18:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859A21839
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:18:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so3481238ejc.4
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOGFH2oPm8C2M73Ht3ngy4JqJoP3QiRw90dzG7FdjsI=;
        b=NKPRyM/kiDvwBq1Hk0aFetAQq6QFZ0GTB2F0lWgCyKMcA7KEfDTYzvQZOK+k/wq4B3
         TDtOG8+szEkeBoSwA9K4M6J9eYBPxgJDTKf47elA7gvs4Iy9DfTwZAjdZ6/tJqM1bFP1
         RW5sTC+Qy2N3EOK3xHKYWtipnfIV3rzx342fvctOMrbkfykVQS+8j1HsprfcUUF6inlP
         6MIt2In17KEooc8+dLwasZkj3F/X93G8aXI/P3fR144p+hUmS/DsQ80T6YcRwMv25NSr
         l/VXPcWZtsBixEjFldi7ifBO/Zz+sjWvojke09necS5r74nFwj5M1mws48IVLbJ/ssWh
         Cm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOGFH2oPm8C2M73Ht3ngy4JqJoP3QiRw90dzG7FdjsI=;
        b=ouGmA81V1h7FhH2vqKTdqN8KASikQ+MhsVWn09Mn7Q7kNuKVoJWzphBdiu/3Ex2nmR
         TYTjvpcYW/JdoCYXYaNvjeF/YKqMTZ+znvCHIamP/S/BIdm0svYzMD+2JGeHIQHKq3CF
         1JkpYGOICEnSx6GkDc5EZQTTMy5LmfTJqpzETvsKYAzXmaltClPFwTefv1gPFIKaIJpu
         o41ux3P6IuPG4sAlm1z7azedN7ZNLK7h/f1TMuALjlKHZ5vN47rTbPDAFiFtyjLy4nCt
         D49IH8yQRIr+4lla/Fr9IyDA5Tepy2hsi9HE16Sl8FP1tJIUaXhc2AlDqrQSO2upCB68
         bdmg==
X-Gm-Message-State: AFqh2krU48XaggCUMbA/6z+H1kCdHZNVDfSxx4Be7dS20jsGXhqotCm+
        48z4nu8F6kM7ETvoC5i3iRo=
X-Google-Smtp-Source: AMrXdXud/erqPHaLENnHEr0MckO0C8YzKRZsocxdUOY5T7jaFgmf3Pz6gwyZ+phef8pLEeNFssxh1A==
X-Received: by 2002:a17:907:8748:b0:7c1:ad6:7331 with SMTP id qo8-20020a170907874800b007c10ad67331mr4955779ejc.27.1671700713022;
        Thu, 22 Dec 2022 01:18:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id mr30-20020a170907829e00b007c0dacbe00bsm23741ejc.115.2022.12.22.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:18:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p8Hii-007ZtG-15;
        Thu, 22 Dec 2022 10:18:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta <edecosta@mathworks.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #03; Mon, 10)
Date:   Thu, 22 Dec 2022 09:58:01 +0100
References: <xmqqlepnz1vu.fsf@gitster.g>
 <Y0S7/jA5tNeoQ2Hm@coredump.intra.peff.net> <xmqqczazx7dn.fsf@gitster.g>
 <Y0Vq3iGifYeBxPbn@coredump.intra.peff.net>
 <92cc457a-d267-d20f-b516-295646b989ca@gmx.de>
 <Y6OTR2iwcORPsTxz@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y6OTR2iwcORPsTxz@coredump.intra.peff.net>
Message-ID: <221222.867cyjx0d3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 21 2022, Jeff King wrote:

> I'm not sure how you saw a hundred new issues, though. My dashboard has
> 10 unresolved issues total since the beginning of September, which is
> before 2.38 was released, and I think I sent 2 fixes since then (which
> are not counted, since they're now resolved, so 2/12).
>
> I do think it would be less noisy if we could somehow convince Coverity
> that yes, strbuf really does NUL-terminate the result. But I haven't
> wanted to sink time into figuring out how to annotate it.

I don't have Coverity set up, but perhaps it's satisfied by the same
thing that placeted GCC's -fanalyzers in strbuf.c:

	https://lore.kernel.org/git/RFC-patch-07.15-cf1a5f3ed0f-20220603T183608Z-avarab@gmail.com/

I run my local build with a version of that branch, I'd still like to
follow-up on it (and as that RFC thread shows others had some alternate
suggestions, e.g. for this strbuf case).

I don't think it's true that a strbuf "really does NUL-terminate the
result" the way an analyzer like -fanalyzer sees it. I.e. if you do:

	struct strbuf sb = { .alloc = 123 };
	strbuf_addstr(&sb, "blah");

You'll segfault because the sb->buf isn't the slopbuf, nor
'\0'-terminated, it's just NULL.

Now, we know we always init it with STRBUF_INIT or equivalent, but I
think it's correct to flag that if you're analyzing strbuf.c in
isolation, as -fanalyze (and presumably Coverity) is doing.


