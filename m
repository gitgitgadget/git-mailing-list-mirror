Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B4C3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 18:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbjACSNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 13:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjACSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 13:13:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95C11A2A
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 10:13:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so16884440wml.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2023 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enterprisedb.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9JlUiPqpoYcRpK6kjK1nNnuhl3X2myWuVAqTmouQOQ=;
        b=Un6zqdfBwLIWUcQ8Jl8tNQYj7TfXNou8aYQmHgceKzXnBWrYbMSFWoj4C+gSBins+4
         B0AZeBUqEiw7lfuttj8BR+kAOrGa9WNyccNDAb2xkMaGMgBd8QXXUqWmmYB+ozUoP4cs
         sD1QDHXV1rbEPYHM7/JKjzWpfjcjKsqEXC/NkuUaoINSARxkrtoEZkRIwoB0kDOIZM4p
         RN6gDQbhloz1dIfArr0IWDmfXHBTbiodojNWJ1VMiY/XBDCtJRbUI/UqiBYfBOIBTh0J
         haqVQQIaz2JR+wlC9Qh8kB+dC2CgH75h0MmfF5LA6v0Q8jl7i655bsGmJK5e6QSjHfRv
         QLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9JlUiPqpoYcRpK6kjK1nNnuhl3X2myWuVAqTmouQOQ=;
        b=GVDOPCnoMuIwVmRY7VrHwiqoPR7HuvURaafBhK/kDNlWvAZxi0ilc2YSFIxS68IYG5
         fH3ByJ7W9iwbCGZu9mbeaLLpSP+1rPzOhnVgJnOXrpptcwcIDmFXyUSLzW5pTYVRWnTm
         SZPKFr2juM1anSTowXbtH63BrfNzL31/z0EaLC4FhyyXn+ie20O4DQWRtOqB5vl6TTd6
         tE5J+cS5H7TudQy1x0uP0wChLtApGjuP0mFxoVnw0yBplyF3eim9AX3j3XUxKlThjfZN
         wdXUP5nN6sWcQrx/SCPCglZMgu6PMm1/DblDTxJ2sutw3GeTBNxLOoOFc2f52Y42xVS8
         WUEw==
X-Gm-Message-State: AFqh2kpUIhhEzDyWhzrRv8CHXxNfhGNIXVd7ADmxEgt1td8sLZCp2BXH
        daxSc01334IPVVrLkQkB7IDsWsBXfFoxYuLig3jG8wG3Y0eawUBbfu49AgEnZdjdn+MYXnaMDo/
        87Cna+ZrhGaexJQNwnWypzwzfWid28vPW4jOti9oeBeAq2ztlTc8Y5WjpDYXjsrU7IrABQgzrQm
        IHHw10lhURO4XWl+IVfHbxQp92Ungp5N+VISniXDJZAEjeTF0N4GEo98bX185GYQShqLxK2Son
X-Google-Smtp-Source: AMrXdXt11Lri5Nq12i5ylEbJn1FaeJLiKvie2ZWc5a6QybCIj04xUgJz90FQebZ7PyNGq9xfPlWxQQ==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr30919768wms.3.1672769585390;
        Tue, 03 Jan 2023 10:13:05 -0800 (PST)
Received: from [192.168.5.172] (net-93-145-27-202.cust.vodafonedsl.it. [93.145.27.202])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003d99469ece1sm26330282wmo.24.2023.01.03.10.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 10:13:04 -0800 (PST)
Message-ID: <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
Date:   Tue, 3 Jan 2023 19:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
From:   Marco Nenciarini <marco.nenciarini@enterprisedb.com>
In-Reply-To: <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: enterprisedb,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01/23 17:29, René Scharfe wrote:
> Am 03.01.23 um 10:53 schrieb Marco Nenciarini:
>> I've installed latest git from brew and suddenly git grep started behaving oddly when using alternatives.
>>
>> ```
>> $ echo abd > test.file
>> $ git grep --untracked 'a\(b\|c\)d' test.file
>> $ git grep --untracked 'a\(b\)d' test.file
>> test.file:abd
>> ```
>>
>> It should have matched in both cases.
>>
>>
>> If I switch to exented pattern it starts working again
>>
>> ```
>> $ git grep --untracked -E 'a(b|c)d' test.file
>> test.file:abd
>> ```
> 
> This is expected: Basic regular expressions don't support alternation.
> 
> Under which circumstances did it work for you without -E or -P?
> 

It has always worked until I installed 2.39.0 on my mac. I've also 
checked with other developers that are using a mac and they reports the 
same. On Linux it works regardless the git version.

Using grep directly also works, so it is a different behavior between 
grep and git grep, that is surprising.

>>
>> [System Info]
>> git version:
>> git version 2.39.0
>> cpu: x86_64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> shell-path: /bin/sh
>> feature: fsmonitor--daemon
>> uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:08:47 PST 2022; root:xnu-8792.61.2~4/RELEASE_X86_64 x86_64
>> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
>> libc info: no libc information available
>> $SHELL (typically, interactive shell): /usr/local/bin/bash
>>
>>
> 

-- 
Marco Nenciarini - EnterpriseDB
marco.nenciarini@enterprisedb.com | www.enterprisedb.com

