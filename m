Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDBFC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0837C611C0
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhGMHHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 03:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGMHHi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 03:07:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0EC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 00:04:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a14so10614208pls.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sdFqK6VzS9VE9PjFJA3l+HasczQlREE7phouGVuG8wM=;
        b=umSS/IYn6hHjF2vUZasz0KXepni/YHRY040+S6Rk1QOacogWTayE7frL6GJYtVDDkn
         kQGe2riN1+Uefu68GVZOLUMyDarMO2kItTkRjlav13VseJTHyaWJdwn4HqnozodXfYwa
         qf+rB32nBFbqsGIvixFYHArBPOyYvn1YqtSfMY0pk/qMvr4QLU+3YIIJc3xitishb025
         tRqgEinObsY8zmLniD5lBcI8m5u5boB2H0w7jsYot370sxAMkqpAFD7tHwKx3pN/DMwt
         WqLcEPG3vF7dUbZCY3FW7axMFH0na97efdgXdgDIPGy3BYTlh13L1slHs6BIBE33GxW6
         TgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdFqK6VzS9VE9PjFJA3l+HasczQlREE7phouGVuG8wM=;
        b=AZZTXPUC9d9207ZmJW5wYwNER44W/2JcFKU1cbbQGPAxR8EQeULst86mrFDrbYZMyo
         bCvqprAFD33fJKYm67655CslFdiOExW8YXnAtFS0ewwb2wQOBU1wKzR4W1PO1jj9k/Gw
         cUapEc5ooO/Lf+CNQzXH06Yh2pAbUqzAHtYgjZkR19to/cFHyMAJF9R6if5ElukcFbWS
         hba4ook1Jt6epJb8klfAdVS5YOSUFxy6yQ2F2Qh/KI1ah+XEMyGaDm1iRQSntL428S0Q
         +STd/TeYwZQwQH/iqUyoUB7LcGhmtQ3BiruVLO9/O9hrGlFjivKEQA4+EbpmeKWmqdpu
         Z6Ug==
X-Gm-Message-State: AOAM531s3+bm2d00QdU7D9PHnKPXxaDJzAmCaR8ZbTf0tafgXdjEI2rv
        NRrcaFed3LKKYgmM/LKNKow=
X-Google-Smtp-Source: ABdhPJwRXucUvjsH22KPDD/9v9dC7SrhxJpDD4bD6yHsZNO7Y2l4ALuGRdR3xP6ilhakCbYiFv5S7Q==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr2951057pjb.166.1626159887495;
        Tue, 13 Jul 2021 00:04:47 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id 133sm19258543pfx.39.2021.07.13.00.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 00:04:46 -0700 (PDT)
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBE?= =?UTF-8?Q?anh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr>
 <87h7h75hzz.fsf@evledraar.gmail.com> <xmqq5yxni2rn.fsf@gitster.g>
 <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
 <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <80ad532f-bcbe-2af2-27e3-0f503209b300@gmail.com>
Date:   Tue, 13 Jul 2021 14:04:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/21 09.22, Eric Sunshine wrote:
> Since Lénaïc is a relative newcomer to the project, can we, as
> reviewers, be clear that we don't expect him to perform the task of
> generalizing strvec_split() just to get this series -- which is
> already at v7 -- landed? I gave the previous round a pretty thorough
> going-over and -- aside from one minor test-time bug -- didn't find
> any show-stoppers which should prevent it from landing. While it may
> be the case that the series has a superficial wart here and there
> (such as #ifdef's in function bodies, and non-ASCII fancy comment
> boxes), the review comments on the latest round have pretty much all
> been subjective; I haven't seen any outright actionable observations.
> Extra polishing based upon the subjective review comments can always
> be done later atop Lénaïc's series (if someone -- not necessarily
> Lénaïc -- wants to do so) without asking him for endless re-rolls.
> 

In such situation when there is endless re-roll of patch series due to 
subjective reviews, we can ask for final call from the maintainer, right?

-- 
An old man doll... just what I always wanted! - Clara
