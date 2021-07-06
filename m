Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E5C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6926C61C77
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 20:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhGFUPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 16:15:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49730C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 13:13:00 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gn32so36199422ejc.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ehcQyPladHfLMRpOlQcss4DL45IT1rhrzanWFrunc5o=;
        b=G9GKoTpYmkAGvMneNTfbSlmNONRg6tMdaCZNMzg8dUhRm7Es2ehHr5iMgDjZz7rWnQ
         TGfe3qA6sw9dvmwVZGYIm7gQqzlOZn5jeIriFsMDBQ+oExh665w1Fit7qCxiKsiR+MQo
         YIhzX0yi07s+ZntBqE1sBKtEA7qdeZOTbvxZGKPgrx/q/7hzxDl5luqFn6xazI2rmji6
         wBRGjoX+V/tN15ckI6JvzS8le+MVir0R+sJI7yIQxuLOIFRb+X2szNLAlOUW8xdfKPnF
         WqkngChu7rzc0YMI/7LQ/bnbfprmCkb143AuTIGcD9bph5J76gWswj7gHr8lnH1hKdfP
         vCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ehcQyPladHfLMRpOlQcss4DL45IT1rhrzanWFrunc5o=;
        b=lvU4a4PsRvER7WCUSMvtfqQwqxMII26/n2zSjgPDHfHPkacNYYM+ri577VvLBTECL0
         hoBz+P+Q2drsi9CZ739WEPu/rXwC3u2ui1zEKKZuuZZ0DV4/PBvvn2Uhhw06uvJ3q9qC
         CMpuqAawzvZ1I9WZApUEAw6t4BS2zG33QNsVppAhM+aFkSVHMgevl+LEb1aTCc/RhBuP
         EO9ESbJqU663zhgXN1xhJ+vKqS+cYyt52Vs2kmNzafoggCaO8bM4D2+P7fdM2Y9D6LWH
         JtrNibI5/uVR3qic1jL601cOAGBE44p9O0CEW14E6HZnhRpGG8Na6kJpfkHjexRVke2B
         E0mg==
X-Gm-Message-State: AOAM5315F4liKSOwferkkOVQI7FKZUsqboOdHnsCjsycz4dUdj+acOSt
        ziw7Lm/5H1ik0pC3rrgyJvYyZvRb++Y=
X-Google-Smtp-Source: ABdhPJyNmOn3N92Wvbms+I1zsvgtAB+8dmR2yD7gNtN8HRJQb31jVH3v7YSkY+90sBukhPQ1Loy6iQ==
X-Received: by 2002:a17:907:7287:: with SMTP id dt7mr20177234ejc.127.1625602378627;
        Tue, 06 Jul 2021 13:12:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x2sm7828810edv.61.2021.07.06.13.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:12:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 10/35] update: add --ff option
Date:   Tue, 06 Jul 2021 22:12:15 +0200
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
 <20210705123209.1808663-11-felipe.contreras@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210705123209.1808663-11-felipe.contreras@gmail.com>
Message-ID: <875yxn5hh2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 05 2021, Felipe Contreras wrote:

>  --------
>  linkgit:git-fetch[1], linkgit:git-fast-forward[1],
> diff --git a/builtin/update.c b/builtin/update.c
> index 1a69896aa8..34681fe21a 100644
> --- a/builtin/update.c
> +++ b/builtin/update.c
> @@ -7,12 +7,22 @@
>  #include "run-command.h"
>  #include "dir.h"
>  
> +enum update_mode_type {
> +	UPDATE_MODE_FAST_FORWARD = 0
> +};

Nit: If the value isn't important let's leave it out, also if you add a
trailing comma the subsequent commit where you add another value is less
churny. C supports that just fine.
