Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11061C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6615611BE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFPRqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 13:46:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A4C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:44:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d9so2487118qtp.11
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AKhaONcD9Sku7VNnVBktdpoHZTUrMMlaQd7ct7Le/aI=;
        b=jznesQl8DRpdBBIonZjT/qblBdh42ghZzdbXZNdowAlzF0UO+inmFcAIWwAORD7duw
         0mpNzHcVWtd7SP2v/f6QLM5ycGcn/1tw8u+7dOwcGeV8tvpPUohouj7J9xHoJY1+QStY
         +0ei+kYhGi+5TZPEvbnhLVHiaS8zMBJjH4vuP4KfMzywvoOVuYdwxMM4ylVe48XUt7Ph
         5tF4IdZyQu077n+81olsPF9KYF+bYQ/YGNSk0iMGvPwPQe5ECMrzQsjX0CqXsg5e/v9S
         EJpTWEDD4zuF6S0W3GBX42bbmQ4twCCjdUqS3khaWyyQ/qeAFT7SzEZNF+uzrjcaynzb
         DsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKhaONcD9Sku7VNnVBktdpoHZTUrMMlaQd7ct7Le/aI=;
        b=p6Gotz+Itgcj6EBp3dUCUu13qwap+VNZGPrMhiWIqachbUlcLVYzVTj8MRGjRXt+gn
         FgS0BJ2F5tpiZtDksbzdl+1xrUfVfwKupSTir0XP5XY/8Ojvz2/Mjb+tADZbXIldcZOA
         OKdntdAe66Rqczm4vIIXoE12A523Q1sqc1RmoAhgVAgLLQh7AwDfKE7E1+5CWullQcg/
         nS1Qp1SUNkp2bOJlo0ojjTIsCXOKsqTl+lIc4/Lt6QJ1sU7/O3uI71xt19O2eu13yi/I
         BAc8AifA85VZu9lSEldbQo3V01O31xzabIdz2kZUy8P4ldgIj0+uwxW6I8Rcghp+UpPq
         oQ4g==
X-Gm-Message-State: AOAM533gU0fnvPU5JoUg/JfdpSj+549bsxbgpcMW2cUE5HGRLkb3uvl3
        PA4ZjgBATt52SO965BFaiTQ=
X-Google-Smtp-Source: ABdhPJxsVLI8OIRa5iYqSZzPxJ4K25wVQ4plUvY62iCev4flChK8bNkq2G6llzKfdjdtJDE42r+Aug==
X-Received: by 2002:aed:306f:: with SMTP id 102mr979831qte.197.1623865449578;
        Wed, 16 Jun 2021 10:44:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4142:2009:c909:559c? ([2600:1700:e72:80a0:4142:2009:c909:559c])
        by smtp.gmail.com with ESMTPSA id s81sm2033250qka.82.2021.06.16.10.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 10:44:09 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <695e78ed-25cf-69e6-8bc1-dad8e55be697@gmail.com>
Date:   Wed, 16 Jun 2021 13:44:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqbl86qtyf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2021 1:06 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> FWIW, I am not happy with this version for that reason, either.
>>
>> I wonder if replacing the first two bullet points ("Removing" and
>> "If you need to talk about") above with what was added to the
>> CodingGuidelines by the "succinct matter-of-factly description" in
>>
>> https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/
>>
>> would be sufficient.
> 
> So, here is what I plan to queue on top of these four patches to
> replace my "not even draft" garbage with what you wrote, with a bit
> of copyediting.
> 
> Comments?
...
> +  - Prefer succinctness and matter-of-factly describing functionality
> +    in the abstract.  E.g.
> +
> +     --short:: Emit output in the short-format.
> +
> +    and avoid something like these overly verbose alternatives:
> +
> +     --short:: Use this to emit output in the short-format.
> +     --short:: You can use this to get output in the short-format.
> +     --short:: A user who prefers shorter output could....
> +     --short:: Should a person and/or program want shorter output, he
> +               she/they/it can...
> +
> +    This practice often eliminates the need to involve human actors in
> +    your description, but it is a good practice regardless of the
> +    avoidance of gendered pronouns.

I wasn't a huge fan of this "example first" approach, but you did
a good job of tying it to the purpose and the rest of the
recommendations.

> +  - When it becomes awkward to stick to this style, prefer "you" when
> +    addressing the the hypothetical user, and possibly "we" when
> +    discussing how the program might react to the user.  E.g.
> +
> +      You can use this option instead of --xyz, but we might remove
> +      support for it in future versions.
> +
> +    while keeping in mind that you can probably be less verbose, e.g.
> +
> +      Use this instead of --xyz. This option might be removed in future
> +      versions.
> +
> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned English as a second language in some parts of the world.

This version looks good to me. It is probably worth adding Ævar in
a Co-authored-by line.

Thanks,
-Stolee
