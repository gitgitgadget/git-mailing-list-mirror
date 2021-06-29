Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158EEC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C976061CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhF2B4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhF2B4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:56:22 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91098C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:53:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g22so24800536iom.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=822F+7jg04PKc5FVTtqqNhzERkuqg23LegdWeDe+p5k=;
        b=lWOW9WjC7oO1n/rerD7DQBIPh+UVBtO9ExDpeG7fjlIoKaySBoY0e4qqV9Fmwvgv0j
         NbUGkdYKcUJ9IwKyaaRDbr3yVNy7xrJyCc3bZBMQaroVDNjJ2xr9JmQKDM4Yh6/aI1Or
         JwpLrZkxYAljEdrnWVWQjFqoz1OGTYbK5qyMEIujZ2Qov/AsUKyzr8FtYmvH0liNY81g
         EIafmQ59LVilHEz60RJKQwBvGzKynFlCTKCqZ3Rrtrsediz673n9TuosmSFO7bgGA3Dp
         76RAfwwWqI5N//fZ68RZHgNKRIrVqVyjcjkbPTMSEvW1PtCKWCYQuGsOwB824+45E5B/
         7SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=822F+7jg04PKc5FVTtqqNhzERkuqg23LegdWeDe+p5k=;
        b=PS1QhRm0nHP99jD8hBZz0MCUw0EBRTLo34wE4jP9FBu4XzKeLdKDugCKyypfS01aDb
         S/oos1P4oEGjiPMLKlOPfn63pcNFHW717EoBbiINn5ZRnEsyJ0stkqDPlOMfIARUlHl4
         Wnm8t03kcvELRR/cs1wX2M1kTK/kvHHaD0LGXXBV8M6UyIJ+MnZYm2NAhGQb3RXNI/Gi
         +mNh9C23aUpO9/ehMlRnWaGAQevQysfShir5T5tdQdRbUBnLHQTqzUfiktAbmPq8lBSE
         zhEthVJxPLReYYc9/9bphqwEdhq5Chwpw5s8H+kYk9AbsGAd0SfzgAth06ctw+RfKpq5
         9xVw==
X-Gm-Message-State: AOAM532fOarfJ9LjNkRyhw/iM4/iNpaDGs8snbrWGX7XZn8Xv2lMbbrk
        +MNw+aTvUCh81S59YjeUGOk=
X-Google-Smtp-Source: ABdhPJxIPKQvD3O1m546N5Z3mjb338Iy2TGE0qQYg57cL4mkDkoW0rW3rRrHwQAPfDncWUAl1XANpg==
X-Received: by 2002:a05:6638:1349:: with SMTP id u9mr2096317jad.43.1624931633943;
        Mon, 28 Jun 2021 18:53:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:707c:50a9:e7e5:baa? ([2600:1700:e72:80a0:707c:50a9:e7e5:baa])
        by smtp.gmail.com with ESMTPSA id h18sm9156998ilr.86.2021.06.28.18.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 18:53:53 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
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
 <YMvuprVu1MnokHM5@camp.crustytoothpaste.net> <xmqqr1gyjpyb.fsf@gitster.g>
 <xmqqfsx162nu.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b22f7fe0-4096-2c17-4c6b-dad08cd2a7e6@gmail.com>
Date:   Mon, 28 Jun 2021 21:53:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqfsx162nu.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2021 6:32 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> I would like to consider that the last draft I did [*1*] based on
>> earlier suggestions by Derrick and Ævar would be a reasonable middle
>> ground.
>>
>> I'll go mostly offline next week---I'd notice if the list came up
>> with a vastly different concensus when I come back, but hopefully
>> not ;-)
> 
> Well, I misspoke.  If the list reached a consensus while I was away,
> then that would have been a happy outcome, whether it was close to,
> or vastly different from, the one I suggested.

I hope that my reply to your attempt was clear that I found it to
be a good approach. I'm happy with it.

Thanks,
-Stolee
