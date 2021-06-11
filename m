Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E8C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CDE613CF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhFKRnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKRnL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:43:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37FC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:40:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so4064866lfr.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XifaL5eNAfsFOP31fRRuniRb5KiID4tJvoJmJspvrk0=;
        b=JskYOMY3gUgxJCdJrvpbtQWFh8A1bu8IF9AhWB7NqMaGBdNI1sBqcEEOm7ElbCNjFU
         Y63dK6uugQSP0r0P41zKXWvmgm584sc1a0QNgz4Qyhpy2Z80meKbg8hSHRCCWpcFKFIw
         QN8Vy7QoxGnSCUlVl+ShVRi1TFqU3+jx2/5oBAuVNcLv7Si8ZYpifz5AGSprrx7qB650
         jWg6uqDugNLjvdoE/pRt24T34VzqIOAa1OP6e1oDpOH+5jlEsZtHhQMwkTKnr4aO9ELq
         XUWsMzRAZ9Pxhy4S11YkKPk9jRdSACI+e25DZ4PKNKslekTmPZo3F71Z1KMXObzr2KBE
         jMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=XifaL5eNAfsFOP31fRRuniRb5KiID4tJvoJmJspvrk0=;
        b=gVipTuMPXTNbrQx1atZFYVEFjGxaYmiafxNgKXMWw+9QrBVQmcgp2l76tpRugdFxB+
         0sqoXeXkCzYIgywO87UHfS5QBYGBCSQABNCaPy5UBR0FY6mTJxvXOs0NWzjuvyjPpLew
         NYdmDNoJ38QWFHSH6utv23JNQ6iJjP23xTeUguAqG6Snxp9xdVFNqR82faKZYpB1FHc/
         X3hGlEt1bRZOanLPBzcXTeds7w7WARsas93ThZkaDgS2WNPn36jMj8Q90b9V5vsHuL4D
         V03NSMYu3caARrv9/rFFCwKchVY26GFMLy+eJcSBGlBxBCpsqYLi3LErU08b8zbNaTiH
         RYaA==
X-Gm-Message-State: AOAM533pxPpqBWjz/Wvj/+iTvyDfc/Yz+hKFt0rjmWg6I3IEZKVEJoM9
        z542x9pjztt30s+MlrrWmXXQn2l2wAc=
X-Google-Smtp-Source: ABdhPJyU4mgiBiAQYA2CchDXRViKz/51zWXVpl4rMgfF+YnqBlG2XEZCjv6tbBT5xYIKdNaiAvQ9zQ==
X-Received: by 2002:ac2:4f82:: with SMTP id z2mr3203816lfs.39.1623433256406;
        Fri, 11 Jun 2021 10:40:56 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s9sm802182ljj.52.2021.06.11.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:40:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
        <xmqqy2bg3nqw.fsf@gitster.g>
        <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
        <xmqqo8cc3maq.fsf@gitster.g> <875yykipq2.fsf@osv.gnss.ru>
        <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
        <60c39bb3b5cc4_8d0f20817@natae.notmuch>
Date:   Fri, 11 Jun 2021 20:40:55 +0300
In-Reply-To: <60c39bb3b5cc4_8d0f20817@natae.notmuch> (Felipe Contreras's
        message of "Fri, 11 Jun 2021 12:21:55 -0500")
Message-ID: <87bl8ce1ug.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Johannes Sixt wrote:
>> then diff3 must display the conflict as
>> 
>>  12<ABC|34=AXC>56
>> 
>> to be technically correct. RCS style can coalesce A and C outside of the
>> conflict and display it as
>> 
>>  12A<B=X>C34
>> 
>> and *that* is the helpful part of this simpler style.
>
> I have trouble translating the above to what I'm familiar with in my
> mind, so...
>
> diff2:
>
>   1
>   2
>   A
>   <<<<<<< l
>   B
>   =======
>   X
>   >>>>>>> r
>   C
>   5
>   6
>
> diff3:
>
>   1
>   2
>   <<<<<<< l
>   A
>   B
>   C
>   ||||||| b
>   3
>   4
>   =======
>   A
>   X
>   C
>   >>>>>>> r
>   5
>   6
>
> I personally don't mind at all having a few extra lines in order to
> visualize what actually happened.

Plus a good tool should have an option to quickly show a diff between any
2 of 3 parts, making analysis even simpler.

>
> But of course there's zdiff3:
>
>   1
>   2
>   A
>   <<<<<<< l
>   B
>   ||||||| b
>   3
>   4
>   =======
>   X
>   >>>>>>> r
>   C
>   5
>   6
>
> Which is the best of both worlds, even if not technically accurate.

Yeah, now I see, thank you both for explanations!

That said, to me it seems that for any of 3 formats one can find a case
where it's better than the other 2. I'm sure I got a few occasions where
leaving common part(s) out of conflicts resulted in a confusion and
mis-merge.

Thanks,
-- Sergey Organov
