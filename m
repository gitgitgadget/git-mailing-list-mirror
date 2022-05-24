Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3AC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiEXVtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiEXVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:48:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB167CB7C
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:48:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id rs12so26255033ejb.13
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uUKZI+YUq33TwWIsv3Bx92ycLT9EzhoCfsva+wjotA0=;
        b=dP1bKTvolm/8I8x30tXycpf55hRbbnG8+ehFEMMOENPgz4DXWasVSiDWRWvMAKSO9F
         +OZ8vOLXNDjrJssqWE8C+Oy65iEsI2QCn2gHM4bPqyPOoCMEO4YCYbQitl3k6PqQ4Ocf
         iz3Dr6KSX7bSrvUwt2uMOHvqpYymhuQhxNu64RjVOZH06N9glFJn2VTrmCT3FJbthAdT
         TB/rmEpkq32Yv5lsmyQwKkoZPercnJ5KKHDmjEdXCCbMCjCl/YoiI/Q5Kxnzu50gCQVz
         uqRrxlydAzcYQzCfjkOxD8Um6HXXJ4Ix5S8drqAaHB/d2+duKgC2EMGeSCM7Z9DEZKHZ
         SgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uUKZI+YUq33TwWIsv3Bx92ycLT9EzhoCfsva+wjotA0=;
        b=zj+n0Rpxfz4scj/wQOlSVhu2h0T3GDrfq5DWmL0CUErJW+mNPFnF2NBWepnkRi2dCx
         +v/86rzKym4u8YmknuvvG9AhMTMJqW7po6NsFIvARh/U/LDvdMpNuQDC2yJoSDqpxKV2
         0HDYeHyxckoKlVXR/Pl4nEGjieYvVmIhfosKHVUJ8Ny/rdje9k1QU6H1rd2CQ4OHWHKU
         HLJyOTNgPZboR4Y0XHZGGF9uTzmHMsfkAoXa/0xVV8Jk7MF7CHSCHKE/+M0/q5tgtYBD
         B8RAQJXyh33eMLj/+7Y6g2Bt4A/Gg/Z0kXkDjDRDzZzMUOXbmoRyVm79qBaNXXaXGrIM
         S54g==
X-Gm-Message-State: AOAM530iSkZjQZdAOc6DjjoCAbW1C5KLxRwY3QcW6zXTt8Qm6fDOUxKw
        J1rS0eBoNaNzVKRYFV9UnvaHrpSGLdU=
X-Google-Smtp-Source: ABdhPJzQX0/ArMNk2UMMrUFryeHs8VF2uOKXIjOhRErEk2Bz63SELw5Xo0lC4pj2H51bzWmURHYUxA==
X-Received: by 2002:a17:907:9624:b0:6fe:c1c3:8334 with SMTP id gb36-20020a170907962400b006fec1c38334mr16109171ejc.188.1653428935864;
        Tue, 24 May 2022 14:48:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w6-20020a05640234c600b0042ab48ea729sm10453502edc.88.2022.05.24.14.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:48:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntcOc-003c1y-Ed;
        Tue, 24 May 2022 23:48:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
Date:   Tue, 24 May 2022 23:45:47 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
 <220524.86fskzxsvq.gmgdl@evledraar.gmail.com> <xmqq35gyhf11.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2205242309160.352@tvgsbejvaqbjf.bet>
Message-ID: <220524.865yluvby1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 24 May 2022, Junio C Hamano wrote:
>
>> The "clear slot->finished", by the way, is what I think is the right
>> thing to do, especially that the objective is to squelch the false
>> positive warning from a new compiler.  If there is a way to annotate
>> the line for the compiler to tell it not to warn about it, that would
>> have been even better.
>
> We could do something like this:
>
> -- snip --
> diff --git a/http.c b/http.c
> index b08795715f8a..2ac8d51d3668 100644
> --- a/http.c
> +++ b/http.c
> @@ -1365,7 +1365,14 @@ void run_active_slot(struct active_request_slot *slot)
>  	struct timeval select_timeout;
>  	int finished = 0;
>
> +#if __GNUC__ >= 12
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdangling-pointer"
> +#endif
>  	slot->finished = &finished;
> +#if __GNUC__ >= 12
> +#pragma GCC diagnostic pop
> +#endif
>  	while (!finished) {
>  		step_active_slots();
> -- snap --
>
> That's quite ugly, though. And what's worse, it is pretty unreadable, too.

Unfortunately that sort of thing is a logic error as clang, ICC and
probably others are on a mission to make __GNUC__ as useless as
possible:
https://stackoverflow.com/questions/38499462/how-to-tell-clang-to-stop-pretending-to-be-other-compilers

I think it *might* work in practice though, my local clang claims to be
gcc 4, so maybe everyone faking it stops at a low enough version?

But did you spot 9c539d1027d (config.mak.dev: alternative workaround to
gcc 12 warning in http.c, 2022-04-15)? We already disable this file-wide
in config.mak.dev, but I didn't check if the Windows code was using that
(or if you were targeting those without DEVELOPER=1).

We could move that to thake main Makefile, but then we'd have to call
detect-compiler there. I have some local patches to do something like
that if there's interest (rather, to bootstrap compilation by compiling
a C object and getting the macro values, instead of relying on that
shellscript).
