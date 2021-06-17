Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE68C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577036112D
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 13:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhFQNYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 09:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFQNYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 09:24:34 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3240C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 06:22:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a26so6486297oie.11
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+M24XBlmIFZAczBzgseykeWHF9AXCnp1oBICzeGUZc=;
        b=qz7BdggwjmEDHwObVPLpXmTf0usgEgwn9t6D0mEV/9FDuGJkZodevgfwZavCKwGvQO
         jV57PrHcGVxbE0fjl2/OI4Rjd4yiDBlEh9SkPabgJhlmR1TzccdYT8aEt8dJZcioifmk
         9ZwvTKf2sQpMEPHOGBslN9rdFw8pBBaDarg8VURG9dD15yYMcFxhA9dfo+6jv/Mr564/
         miJvRIunKvfXVQ/obLCEBO7gwqeAs30yepTzE7D3vX52uPKZHozxnYGlohLVm6IbiHez
         sN4MebvJ2gM9CyJzQbSkODfMa28i83kUtvJCZqYY00AnfAsTVrDLTTLU5UNnX/bU3qot
         eyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+M24XBlmIFZAczBzgseykeWHF9AXCnp1oBICzeGUZc=;
        b=pemXg1Kkf3XtRRNNgJQu4t6EaFh0O+ejQLEkZILP0QnuvSfyWWZnjiIgszNuy2rawM
         m7op7Xc7/3Anz4veskBi2DVwRhKMMV0vX++y0EJ77esA317fDv48Jlfmy9KYYjdg/isv
         X2EP9pyT+6dMUUhqp0geE1461/U+pPalu4N8Q9/eA/rM98vRIZh/g9uSi4UxKn0D9dJ5
         Rs3wJafyg6Wflw3Ia6O0zuH5zMSbW3fDYb4Z396SUZGeyICSJZ9atvkIt/lzo3Z2UYVW
         dWNZUnSnPYSgJrfs3XWVXMo2GEORblnYjAIqWgY8+G+J9c/QDaueKcOih8yCmZehpTxQ
         mYFA==
X-Gm-Message-State: AOAM532NCbsm/jNrdQjQK/ncN/oP78Rk1ch9QOa0bPqn6euNRwA7y11A
        GM5y1p2pGP2ua3CKMnMLMc0=
X-Google-Smtp-Source: ABdhPJyD9X4QtKul5uOFj7pgnR+Ic9ZiE5lHoV8N02p25lizzhOxKAkpU/kvkUuVFcn3sz6ODkfSuw==
X-Received: by 2002:a05:6808:128c:: with SMTP id a12mr3347237oiw.136.1623936145068;
        Thu, 17 Jun 2021 06:22:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:11b:618c:fdf2:5be3? ([2600:1700:e72:80a0:11b:618c:fdf2:5be3])
        by smtp.gmail.com with ESMTPSA id 21sm1305277otd.21.2021.06.17.06.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:22:24 -0700 (PDT)
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
 <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
 <xmqqtulxnyhb.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5755690e-ef13-e12c-4b10-9cb303ae843a@gmail.com>
Date:   Thu, 17 Jun 2021 09:22:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqtulxnyhb.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2021 8:09 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
...
>> The references to "gendered prounouns" etc. are gone, perhaps there's a
>> good reason to re-include them, but the point of "isn't that issue
>> solved by recommending an orthagonal approach?" is one of the many
>> things Stolee hasn't been addressing in the threads related to this
>> series.
>>
>> To me that whole approach is somewhere between a solution in search of a
>> problem and a "let's fix it and move on". Not something we need
>> explicitly carry in our CodingGuidelines forever.
> 
> This I think is the crux of the differences between you two.  I'd
> love to hear Derrick's response and eventually see a middle ground
> reached.

I disagree that removing gendered pronouns and updating the
guidelines are orthogonal. At minimum, we shouldn't have
guidelines that we do not follow, especially when they are
small in number and we can fix them in a few patches.

The entire point of this series was to reach a decision about
gendered pronouns so we can stop having arguments about them
when they come up. We should just be able to point to "here is
the decision we made" and it's not enough to say "If you go
look at the mailing list archive you can see that we removed
all gendered pronouns so you shouldn't add them again."

We need ways for contributors to self-discover these things.
Anything less is doing a disservice to our fellow contributors.

Thanks,
-Stolee
