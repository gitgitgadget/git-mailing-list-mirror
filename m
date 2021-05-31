Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C162C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB07661287
	for <git@archiver.kernel.org>; Mon, 31 May 2021 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEaV4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 17:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhEaV4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 17:56:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E18C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 14:55:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b17so14979408ede.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EFF64YS4zrLyFY5eirvjdypGjLIckwHc3Gjxv+nk+60=;
        b=RYqa1deQhfygvCzp7RHg8diUPgctrppfUX7e7S4IWN9/ogawmKTiHqQ26/71+OCVON
         DjvF9yZoC1GWouEAIbc2fHcaoWUXsA/2zq85MF2trebPIttU3Eh4uKLr0jMhC8x/WlCS
         8O1qTmm4wCa82LRsbbfXFS4IEAJCjYC5bYD6XqIz8QOYADuLpi9m7PjUCL5uRgk2yRbj
         LtS4NbZ8zOWr1wmTZhQrQVl6Pk3ruv9c5NzZDhGw9GDdBZmi0UFnY+SjCNbs76DXijdM
         gJey5KrtvSm68wiBYWTPZ1oOr3RlQXs73G+mkNUQbuA65flhPNTajyyrGBpgNG2VHLA5
         i9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EFF64YS4zrLyFY5eirvjdypGjLIckwHc3Gjxv+nk+60=;
        b=LYk/K4NIiPS3aBS5eC/kdpQ6wTFUGYpBrkYKj3DcwcJ1Asi5UMu6u+GGLZNnLauYRl
         rJGZVjx6c9wifSGBi8NqNGPmkECAJ7XAMLHOg1sY5LdTkGjvcSDEhXxOSIfANL6pezvU
         dhirM5PgGLLQr5gVAni6ExJrwhiDiyiZPvMqMyc7/sK6OqrjMifJ+NXFjCN10R8GWdMy
         sM5tFZKPJNvv287c8dMh0fu5eO94vwl4InJ843s5V4+Rbcxb6jIJLfDKtoCc7CKHawj4
         NmjtJKh8k7QSmw6aePr6rco/mBwVvwP4bGhQgogYncgmXluNFKrqdCach8OZueKePRbM
         X9AQ==
X-Gm-Message-State: AOAM531Pd/cBlyDaCb7bYbNaRmRUSyxDtol129bnHzPzj9dh8OSz9+SD
        63J/zYmH2Hedles/nGx/O8BHhKpinMvosg==
X-Google-Smtp-Source: ABdhPJy95ZMjjg0NdvC4w+OOGBxqOKfzXD/MU5aSTZb8rhpf5/XqT5hffqsfsSby+TZwsjjMznxeHg==
X-Received: by 2002:a05:6402:612:: with SMTP id n18mr14085961edv.83.1622498099773;
        Mon, 31 May 2021 14:54:59 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d? (2a02-8388-e002-8cf0-c4c7-70b3-fe71-c06d.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:c4c7:70b3:fe71:c06d])
        by smtp.googlemail.com with ESMTPSA id i12sm185079edx.13.2021.05.31.14.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 14:54:59 -0700 (PDT)
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
 <60b4fd4db5dee_24d282088c@natae.notmuch>
 <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
 <60b51d6c93c7d_279c820856@natae.notmuch>
 <c4bb335c-4909-8525-cbdb-bb214d18d8fd@gmail.com>
 <60b55207adad1_36bff208c9@natae.notmuch>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <73fcc154-0a95-6569-e776-56bb2f200c5c@gmail.com>
Date:   Mon, 31 May 2021 23:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <60b55207adad1_36bff208c9@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.05.21 um 23:15 schrieb Felipe Contreras:
>> I'd say it should be quite an argument if the related StackOverflow
>> question dealing with this exact issue is one of the top-voted git
>> questions of all time. [1]
> 
> That seems to be a different issue. Related, but not quite the same.

Well, what the OP actually wanted to know there is "how can I use git 
pull and git push on a new local branch". The OP knows it can be done by 
configuring an upstream branch, and therefore he also specifically asks 
about the details of how to do that.

> We'll see how this one goes.

Thank you for your efforts.
