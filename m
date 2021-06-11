Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7150BC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7FC6141E
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFKOWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFKOWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:22:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2931C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:20:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so3306284otg.2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=k/8oBvoVysTrwYjKM24hUrzZhO2O9E0sgOH4DPQIHcM=;
        b=V5qnsK10cEvRluAx/yX53qUrKTGmt6IKP0HQuzg/fEtSUMO07cRjwaFIByRQEKIE/C
         d+W/XxrwqQI11ZrMvRgnw3O8j1wulVUP6TBnYL/OKjcUicNsqROciUyWlPt8pvw7L6ss
         0HFXXngVhSq/j2xOc/NHYZVIzEufHNBTT3vIZSg5XXZoBW6mg/6CfB5DbBUKW5e3gO4w
         kADh0UG8XS0oazvtq18gEDRVRHc+kYPupDv7lRlqQkLb1NUfrHJjGW3ETkITWSw8kt0h
         uhhmiCtB0xXgEn38sD9lE8weREnUvRtir5RYyC5bKyoMgDdeyHxgubSrLwPt31O8JI06
         YjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=k/8oBvoVysTrwYjKM24hUrzZhO2O9E0sgOH4DPQIHcM=;
        b=K22qxi6snTdIg6LckBKFOsJAtITorOSI/DaVE+xjsrEZ/PTwOpgdXWo76fTK585+O6
         NHlmBqRNu9gTq9rD+0GWyklKIQaCqlqzIc3E3tge5RbgmjSrY6UD2PstoY3wJy4HfSlP
         LkYXLKt4fxp58ZBRRpwEUNhaeKLafzdk1Svc5ZmwWAZF+uA5+XXVD3VR7dub4pR5WzUH
         1wGj6SbdT/PIxvosSRb0nbIaK/guJ4H/Sgx3fvJH/jZ+ShOj+2lrT5EoTiyAgIjJhKuf
         irHadeXNMubzxFP9dix7oRONVGBeqCSMHiXL6kI0BCJ6js7eacePI33fvle7lp5mqfqZ
         CS8w==
X-Gm-Message-State: AOAM533YtoAhdjpMRKxhpawkchChSyC7iKvfUNgq5+xosUUlUItHF/yz
        O3Vw0OopRBHKXyr2HRfLQbM=
X-Google-Smtp-Source: ABdhPJyagHPPJNNfEl3F2yKwbhTs0mhtoo4ThMauo5vVxuBMPo/uMAVyRpKI9+7KOaCwVVgdj1Hajw==
X-Received: by 2002:a9d:7c95:: with SMTP id q21mr3298427otn.111.1623421206269;
        Fri, 11 Jun 2021 07:20:06 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t14sm1191349ooh.39.2021.06.11.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:20:05 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:20:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c3711466f39_3ad920831@natae.notmuch>
In-Reply-To: <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:

> I understand that diff3 is very useful for an integrator like you who
> does a lot of merges of code that was not written by yourself.
> 
> But I would estimate that most conflicts (in absolute number among all
> developers using Git) arise during rebase operations and cherry-picking,
> i.e., while one is working on their own code.

The vast majority of developers don't rebase their code. They only do it
when absolutely necessary, and that is when they have to rebase it on
top of another person's code.

> In such sitations, the simpler conflict markup is sufficient, because
> one knows the background and reason of the conflicts.

I don't know about you, but I often don't know the background of my own
code from one month ago, hell, sometimes not even one week ago.

I consider myself from one year ago to be pretty much a different
developer.

> And then the ability to compact conflicts is a life-saver.

I don't see how shifting one's sight a couple lines below would save
anybody's life.

On the other hand opening another tool just to find out was was the
original code is tedious as hell.

> Therefore, I argue that simple conflict style should remain the
> default even if the presentation of inner conflicts under diff3 style
> is improved.

First let's get rid of all the assumptions you made above.

Just because you personally do X doesn't mean most people do.

Cheers.

-- 
Felipe Contreras
