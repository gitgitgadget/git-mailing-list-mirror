Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7BFC636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBGUrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGUrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 15:47:13 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B79748
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 12:47:09 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id pj3so16264872pjb.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 12:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54ZhBNgGJ3g7EKZZcmV+UEPj2E/avfn1+Q1xAjYC+SE=;
        b=GTytxZxQIqUW232oEJ5B756oU3TLaXg5GBvNEQdFx6AaWn0SOZOQriUIYp66DhP6N/
         XPqzTNV/KAXJZeYbQkWz2Lp7GXFZYouIPsJvM3PSV5pQM4xZidG2g31SfIbOCVy20iug
         3VG9IwvFcZFksKLvt+qJGMN93n/BzexbyXlMqyywVqSaa6BWb7M7rAp9mUMMjc0byW11
         dBF+xW38TUSFWQql4ow79RJm8OZpfACd4lAWSdFTqHX9xWp+ctZkkxfPVKGwYuGjOvLI
         /dumHB10cZlSayepEg0H2jb9QcvH0V3sT/E6k5khC1NSlI9h+GsG7PH2IEHcbFMdr7sn
         m7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54ZhBNgGJ3g7EKZZcmV+UEPj2E/avfn1+Q1xAjYC+SE=;
        b=FRS446xbfqTlOfFFqnvxccA6FeDN7Cji/ub90XL22ZWUwB1jfPJQj6lrq1u59Z7odo
         5u3p2QAKGn8l3E/m5zQyB5F8jLNQxpkt22mxcioNIXHkKE6VAa07UiqrcB7c4uo0zsjk
         Q+eGMwR7vl92jEBYj1GPX6tVLK8kdIpDb3/IdRAwo1dPm3EZMTnxU0wOlpSmPhOBw7w+
         rsiN2Ms71GYpM/ABHJ6Ing/VQZbXT5NDqko5Rx+c2j4It6IAGJG6mG3afe+y9JpTOcFV
         pLJnHe1cOAHOuUgBmwY7b4BK6hgCmBP6EKUkAboHEWp/FdrLyHLryGSqAfS7qiwcM1ip
         AoyA==
X-Gm-Message-State: AO0yUKXRc5IGQEbR/0b0LNbg1G7iqx5yrx7M4Xf0URhzCTa5PqMzoAqL
        lI3B4AL+0Z89F0JDgdajvOk=
X-Google-Smtp-Source: AK7set9hKepYyM5ZzuLJDPtLS4M7N4DrxRzPwnm8SKG2iQBWNZYUvBwCnhWqrnfmchwnFDQxytWxZA==
X-Received: by 2002:a17:902:ca0b:b0:194:d4e5:5e5c with SMTP id w11-20020a170902ca0b00b00194d4e55e5cmr171285pld.37.1675802828350;
        Tue, 07 Feb 2023 12:47:08 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902710700b00196048cc113sm9295890pll.126.2023.02.07.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 12:47:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <Y+KQtqNPews3vBS8@coredump.intra.peff.net>
        <230207.86k00t2owm.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Feb 2023 12:47:07 -0800
In-Reply-To: <230207.86k00t2owm.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Feb 2023 21:18:33 +0100")
Message-ID: <xmqqcz6lyzhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> From the user's perspective, this is weirdly inconsistent with the
>> existing diff attributes, which would be more like:
>>
>>   # in .gitattributes
>>   *.json diff=json 
>>
>>   # in config
>>   [diff "json"]
>>   algorithm = histogram
>
> That does look more elegant.

We use attributes to define what it is, while configurations are
used to define what to do on different things.  The separation of
attributes and configuration came not from "elegance" or "security"
but from a lot more practical reasons.

For a tracked file, the fact that it contains JSON text as payload
does not change per user who cloned the project, or per platform the
user used to do so.  In-tree .gitattributes that the project
controls is a perfect way to define what it is for each file.

On the other hand, the diff program suitable to compare two JSON
files may vary per platform (your favorite Windows program may not
be available to me) and per user (a platform may support more than
one and the choice becomes the matter of personal taste).

The security aspect of giving users tighter control over which exact
programs are to be run by not allowing the attributes or so called
in-tree configuration mechansim is a small bonus that fell out as a
consequence.
