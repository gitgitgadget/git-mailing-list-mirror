Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC30C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 00:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498BB61166
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 00:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhIVAZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhIVAZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 20:25:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EFC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 17:24:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r5so2958235edi.10
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Dxv8/wLymUXy5SdaVxoYh0QX5Tu0yQJuqCSjlGfZbe8=;
        b=basR3Snzr8jai+LSfb9jlMMDTNvvF9mAYVYMVutDWkyiRV1PSTISkTPIODq//uLcZT
         Yzdc9dfHoIdSnDH3w/AAvzSyAeLlcOQ0bTtXNfxtjW/htRvWQV7TancQrxJfdob+yrB3
         IsGhjv7E8f+tV6khzfXnMX+cW2+4rf9yRtYBuyS7O4tOx8g08F+V8LmUnBxKkLV0E8Ms
         xRbpfJGnLcq8vncvu9CqZABwE3uCFItwCpQY0TJPjPvqbPgWSABcUolk2m2XGjIuNEeJ
         nTWHVFFJh4CyqiC1yohzUYig0x7ZCaZstZUqokOVj7j/wjDXudM1JB0Ajsi06+CSy36a
         z5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Dxv8/wLymUXy5SdaVxoYh0QX5Tu0yQJuqCSjlGfZbe8=;
        b=Sm9KvLqroO195U/OGAg12gK4bqCIucjFQET7Cm2SeQIhrsnLhYU79jEyhHq10X0nqI
         CkOQUGFTia2Bt37iE+2bsZU81ozo35D+8MckzWo5X4DGa/GYNn7ZlJd6oEgn91X79cHX
         J5D+zF94dImL+QaHtXaSOrhLelk6PFrHWeanIhMDOUCJ5Yv+b6iKOO57sa8QGq4mOySQ
         911dtN6U1XrM7uKjkmOpjVuzVOBgVUglaa4InHhjU5lbWV2aQNmo0B1loW8EIeeBJqAJ
         IV3U+LivE5et1LcdlE79UkXB8o9RjLLbsq08FzSOdSIcA7hEF55DXE0Obp5nYnp77iOk
         DMMg==
X-Gm-Message-State: AOAM532xRBCl5ebt4azyt2GwPbtp4185qlK+im+9j8eKz4PYeVpiy7Fw
        rPvrcVlc/v2jbGe4rLiFmBk=
X-Google-Smtp-Source: ABdhPJxDdqfIDuffTCpaZgoTmU4tiTXR+O4zeJg/+EI3o78/yme+Tt+5A3t0ge4L73MoDckRHrbaOQ==
X-Received: by 2002:a17:906:368e:: with SMTP id a14mr37603040ejc.60.1632270249354;
        Tue, 21 Sep 2021 17:24:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k21sm191081ejj.55.2021.09.21.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 17:24:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: ns/batched-fsync (was Re: What's cooking in git.git (Sep 2021, #06;
 Mon, 20))
Date:   Wed, 22 Sep 2021 02:22:33 +0200
References: <xmqq1r5iaj9j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq1r5iaj9j.fsf@gitster.g>
Message-ID: <871r5h8nkn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Junio C Hamano wrote:

> * ns/batched-fsync (2021-09-14) 5 commits
>  - core.fsyncobjectfiles: performance tests for add and stash
>  - update-index: use the bulk-checkin infrastructure
>  - core.fsyncobjectfiles: add windows support for batch mode
>  - core.fsyncobjectfiles: batched disk flushes
>  - bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>
>  The "core.fsyncobjectfiles" configuration variable can now be set
>  to "batch" for improved performance.
>
>  Will merge to 'next'?

I think it's getting there, but left some comments on the v4, my
impression is that it'll need a re-roll or two at least.

https://lore.kernel.org/git/pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com/
