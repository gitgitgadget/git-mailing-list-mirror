Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A741C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E242A61050
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhJLNl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhJLNl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:41:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2DC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:39:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y12so68443649eda.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=g6toAv7ven30rUD7qkAQZ3IpgMs7rrwL7SEIcaVRTno=;
        b=cu32cHaxXB9N10lQCHhyLjCC2Q5dFdZBCctNFuxhbZQlc9hhhZhQP2ntqW0kq06yb5
         THtaqe+UTVVhqk/huMDrPNyJSE6vcvMZTN7o1GhfVgcluEI5W0+juRVO+ql3twC3F1bk
         3WcuMWclOhbhGGnYhXse7LPCVk1vAnvlzSBt3OE8adNlN7yXBr1om0YsCH5Kcne93C+O
         fXo4/rg/ioJT04nDT99/C60M/rHA7rPTlTJi7H9L0MYK7scGJm2yer/MVZAXLzrLq54a
         7h1dTy6eQpEk2MCg2WH3rahUj1C3vPuT0aywix3TwRbPaflwgJUV/Z+1aVGZeScePnlC
         cI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=g6toAv7ven30rUD7qkAQZ3IpgMs7rrwL7SEIcaVRTno=;
        b=ViACRn6Sej2BBGbMFesBo3vEiP+bbc5wUqvQuc+h3V8NyBRZIpn4QNutJc1p4J9gYI
         W4wzPrjr2Dl6dMWgjfBc1VNILWg2MBXGC0PBHnTLOMMW1rgJkQ7jO3pq2uxjCmh/5c2c
         M0xmogz/ptoErORbLVRUzhoNhguEAtQMs7Guq0kbatRdHvIwYu7NpMMRu1q1bgkigsMq
         xvphPFP0H5xOqbJ+T6aHnquWNHcGfNGXg1WdI/UFKCeLgkoY7aYydY0CRtA7bm4C4hii
         5QqVyrJSbBiQv79XYxsl6ni3nr+3GzPPRC+iXaKEvJxBl2v6gHP3tHa0m/WPMEsiRvZl
         eyLg==
X-Gm-Message-State: AOAM531P6drGOqiIu09lsM01F4l+VaRMm30AJBG56hyuqYhXAbrudhFe
        e03YFbaKyIjNPWxwjPl3Uzw=
X-Google-Smtp-Source: ABdhPJwxkE+/Hefpm70JK8UZBuvJG+I8kMjATiqR3iNDa/ExyqAdHefVmyCl4rO82JBTrjR6mracJw==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr17074597edd.116.1634045965518;
        Tue, 12 Oct 2021 06:39:25 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm4971171ejo.36.2021.10.12.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:39:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] leak tests: mark t0000-init.sh as passing with
 SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:39:11 +0200
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
 <patch-03.10-3a7dd917d9f-20211006T094705Z-avarab@gmail.com>
 <xmqqr1cwo44p.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqr1cwo44p.fsf@gitster.g>
Message-ID: <87h7dmjrar.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Mark "t000-init.sh" as passing when git is compiled with SANITIZE=3Dleak.
>
> "t0000-init.sh", I think.  Why should we have a separate one for
> this script, rather than it being a part of [01/10]?

I figured t0000-init.sh was big & scary compared to the rest, but will
squash.
