Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D643C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A59F6141D
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhFONil (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhFONii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 09:38:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDECC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:36:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d9so9034402qtp.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWoitezak/gpdtGdN4JU41+X3ZbU/rD/35ezOEIAyIo=;
        b=A3gApwe9bivXbv6xdd0UIO9lfbzcArHMlUsRe3MP1Ns7YvgCeDS6P8ChSEl7zjnaE/
         8U/DwN95HGWHDm3OCIyk4ZIHb3C0+8VecKOunJsOvbdh3Eavinfr6NmnFEsIyGdmt69f
         VwTprtHc2FBcv8T8ol7Uq5HcVawx0Qha8LyvOY4a205y/ot3Hjr0MyRNxOPb30DqQP5h
         pystonYiddeAcGkHc68tG7mln8JgjKAbYYH4zocNuqTBUBZqJWj65UAdWr9zsNByf0M3
         IwOCxlS9+q74wWpW7morz2CayTEJvbdX4T6EikScqnuu3KfHGym4im4uaKkJjhOlcGNu
         ntQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWoitezak/gpdtGdN4JU41+X3ZbU/rD/35ezOEIAyIo=;
        b=UgFkfyERGn28WHtxQ908JldujMO43MlmdPPF3N7xCU5YzxMsK9FHRXOwGR1Q7iuc/4
         m/n9X2t/8j2aFapFo6AiZVNEk+TcEJ4KSclH5+4JwPLFMTZJzm8QBmleWfyZ2WKcpyyu
         84GaWjL4TU66VAM3oo7nKOfVOwjkvQbovl5XBhBeHnFsJ25HkFWBQiEr3HdTQlvEHVVb
         H8bDBLp6D9P82vPkra4Kid2aa7ahGjff/YkN8q0Zt69ljO+GJQx9lLB6BvFMQFvEWuvk
         y8atxvWniyfb2D5wopU+v098iO/Wg8as+BKZa8qA/qhqR9RmK8zqTEDfzeGNcTHEUFsg
         8JsQ==
X-Gm-Message-State: AOAM533mkkcsIaK1tIY+pVYJQ7CUmANIG74+DjUYRksug+EqlMCjOimY
        O8hKRTVnYMl9kUK9Qv9oFcE=
X-Google-Smtp-Source: ABdhPJy3LZLebvoQJosIA779RW6Bfb1cf2nURCjIh+0xB4y0hBrYOJKn9JUu0/B/xqCTtHn0s7B5pg==
X-Received: by 2002:ac8:4984:: with SMTP id f4mr3272204qtq.106.1623764191445;
        Tue, 15 Jun 2021 06:36:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:113f:4437:94ed:3bef? ([2600:1700:e72:80a0:113f:4437:94ed:3bef])
        by smtp.gmail.com with ESMTPSA id m199sm12318703qke.71.2021.06.15.06.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 06:36:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
 <87pmwt1dz3.fsf@evledraar.gmail.com>
 <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
 <87h7i21a43.fsf@evledraar.gmail.com> <xmqqzgvrvf5g.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ffdd4b33-65b2-de66-165a-84d2ce6f2fce@gmail.com>
Date:   Tue, 15 Jun 2021 09:36:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgvrvf5g.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2021 2:02 AM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> Or, if we just fix these existing occurrences as a one-off there'll be
>> no existing examples of it in-tree, and as people tend to imitate
>> existing documentation they're unlikely to introduce new
>> occurrences.
> 
> I suspect that may be a bit too optimistic.  It is too easy to
> discuss interaction among users and introduce pronouns to refer to
> them, and when it happens, it is far easier to have a document to
> point at and tell them why we want them to rephrase if not how
> exactly.  For that reason, I'd prefer to have some word about the
> desire to make examples and explanations gender-neutral in the
> guidelines.  The mechanics we recommend to achieve the goal does not
> have to be specified if we want brevity---that can be learned by
> imitating existing practices.

Thanks. This was the whole intention of this series: to land on
a policy that improves our understanding of gendered pronouns
and be able to point to it when the situation arises again, even
if that is a rare occasion.

While my initial recommendation wasn't accepted, I'm glad we are
coming to an agreement.

>> If and when Felipe's <20210611202819.47077-1-felipe.contreras@gmail.com>
>> is applied how small is the diff you'll still have rebased on top of
>> that?
> 
> I just retried a "competing" merge that got ugly ;-)
> 
> Between Derrick's two "singular they" patches (one for comments, the
> other for docs) and Felipe's two patches (the same split), they
> touch identical base text.  Only the way they neuter the description
> is different, and to me the latter feels a bit more ESL friendly.
> 
> So, the main things that are missing from Felipe's version that we
> may want to build on top before the whole discussion can be
> concluded are:
> 
>  - Derrick's "typofix" patch, but if I recall correctly it needed a
>    fix-up in one of its hunks?
> 
>  - Guidelines; you had a more generic readability tips that would
>    (incidentally) result in nudging the writers to be more gender
>    neutral, which I think is going in the right direction, but I do
>    prefer to see an explicit mention of gender-neutrality as one
>    bullet item.

I will send a v3 soon with Felipe's two patches, a fixed typo patch,
and a new set of guidelines.

Thanks,
-Stolee
