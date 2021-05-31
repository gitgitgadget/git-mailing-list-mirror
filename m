Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B8C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0BB61279
	for <git@archiver.kernel.org>; Mon, 31 May 2021 13:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaNF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaNFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 09:05:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C7AC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:03:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l1so16602248ejb.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RJn4rZWchTuX6IribVvRC3dhBkP2xlnl45dvLuncQcc=;
        b=OlNtumcgWDCdEF7ETauEfOD5oXBkLyqTBJwCBEbCAIsewWhqfMiULn8vYRijxYBzpo
         gUdiiFoZ0MecfprUTCPrUgbvPZsYiEcKnx3L7PZIOlF9EpHWf9tVvy2MjglPl5qGBS5c
         SZQDQS5rgimqHq8+nItaZ4j/bPMADAJO6IiB0uEJYcKgfYq5MuIrTS6iS6JzlsJSQWuu
         idb96BYwRywzx4MXKy0cW2yGNRgEqgy6zFW0jkxkE1Q5MA7I94QTQNFm9mMpr21Cr/q5
         3WvuFpmElLBud2Y+gJDbp8pkmYlGTeErWv8Ek7+OGXVEnXz5+Jb9fcsU0xMYMyObWAoo
         zCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJn4rZWchTuX6IribVvRC3dhBkP2xlnl45dvLuncQcc=;
        b=YMDWQ3fiJmJtXvyoXzesl6lwnrOWrSfyPyAr8g5WT9NvGfq+jZOKdSqyUihNDrVqxg
         Hwk3oamK321QqtH2IVEMV0HUX1GMFKITzkVk+CMUpWl8qjcPc0ohm1DxT74vQ0WrxuwA
         vIfUTnphJ6QIKSHnN0RIY92ryOUL/VFAUOBMVlG/aj7niAmI1QBwrl0Tjum/RDsOW0MZ
         05gdou0Ge8re5lsC5xv0bKh6NPxgAqCt6JjWK3hm7iLKYndOHQpHP7XeOiskpJ1cLt5r
         LVQgXmGTguHpKz0BvppOQSriHbriQno3sYraFPNlEPhC2wltNtmNoTLj96wpb4RSPAOC
         4HzA==
X-Gm-Message-State: AOAM531SqMQCAERQDROweMuO7EqGHemZIW5gYimg3lGAjvPJTatzjqu+
        0y3a9/T/kwRpg9zWKDIR7GtwBDwI3yUx/g==
X-Google-Smtp-Source: ABdhPJwXrL8igSyzQghWslZTwJaUzCwGwZi+E8lqG/fcl0G4rU8mvWA8wPOrVYgPvUyKn+YrqvQiBw==
X-Received: by 2002:a17:906:fcb5:: with SMTP id qw21mr14502262ejb.57.1622466219573;
        Mon, 31 May 2021 06:03:39 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:25d1:fff3:8887:500f? (2a02-8388-e002-8cf0-25d1-fff3-8887-500f.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:25d1:fff3:8887:500f])
        by smtp.googlemail.com with ESMTPSA id n13sm5919169ejk.97.2021.05.31.06.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 06:03:38 -0700 (PDT)
Subject: Re: Default behavior of git pull
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <7a97ac78-f405-2dca-2998-f03637cc8255@gmail.com>
 <92682abb-3062-4613-399d-a3279afb8f0b@gmail.com>
From:   Mathias Kunter <mathiaskunter@gmail.com>
Message-ID: <a5dfd06c-b3cf-2d30-2e57-d0706b75a908@gmail.com>
Date:   Mon, 31 May 2021 15:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <92682abb-3062-4613-399d-a3279afb8f0b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

thanks for your reply.

> Since you do centralized workflow like above, I advise you to integrate
> from remote with git fetch + git merge.

I'm aware of this. However, if I know that I didn't commit any changes 
to the local branch since I last pushed it (as in the given example), 
then it should be possible to use a simple "git pull" IMHO.

It seems unnecessarily complex to me that users would have to use "git 
pull origin fix-1" in this situation, when a simple "git pull" could 
also work.


Am 31.05.21 um 13:27 schrieb Bagas Sanjaya:
> Hi Mathias,
> 
> On 31/05/21 16.18, Mathias Kunter wrote:
>> Wouldn't it make sense if "git pull" would by default also pull the 
>> branch with the same name from the remote, in case no upstream is 
>> configured?
>>
>> If I can push to a remote with a simple "git push", then I'd also 
>> expect to be able to pull from that same remote with a simple "git pull".
>>
>> Does anything speak against this?
>>
>> Example:
>>
>>    git clone $url
>>    git checkout -b fix-1
>>    # do commits
>>    git push           # push to origin/fix-1 (works)
>>    git push origin    # push to origin/fix-1 (works)
>>    # other people push to origin/fix-1
>>    git pull           # pull from origin/fix-1 (fails)
>>    git pull origin    # pull from origin/fix-1 (fails)
> 
> IME, I did git fetch first before I did git pull, unless I have repos 
> that I didn't intentionally want to contribute to (just collecting 
> them). When I choose to work, I always create a branch, then submit 
> PR/patches from that against mainline.
> 
> Since you do centralized workflow like above, I advise you to integrate 
> from remote with git fetch + git merge.
> 
> And you asked whether plain git pull can work. It is yes, provided that 
> you don't do any local work on remote-tracking branches (such as 
> mainline or hotfixes).
> 
