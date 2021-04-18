Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C517C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0208561026
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 08:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhDRI7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDRI7d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 04:59:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02528C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:59:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z22so11030257plo.3
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wa80MPbyUyIoEiapyr5t9N791gLHSk9hjVs93kikQfQ=;
        b=gtYnjONfCLEzB+R3ipciLDrT6RDTm6EmK4Jn1+DNRJCio0olPcD+kj9h7WIhUhZVrK
         AMaenkvTkGYoSny6PPvOVKICuzSjf0iOkRSl9+uILoJ9/zy+T7Qji2j3luZBzanY9k97
         ACd+8eznZD7WpOEt/pVZwzzW6ikUhPIHF9mb7oTK0aaPtRyO/Lf4ng5NdBCMTk67zYQU
         XgLio0LCGooi5KF124sXsyBOddl2/WzqLSruZdgwlG+oxISRwFaOeATqP8KAlTXOzGU7
         uelS05/nOOXpHQ8lcYsUiTKxul6kj1dwZbVVjq+T++MqWxUwXs+pII5oYpAljSxeqzGn
         UW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wa80MPbyUyIoEiapyr5t9N791gLHSk9hjVs93kikQfQ=;
        b=Ya8wCv/NUr9aX0iKKrOaEA8jjj6gbH84Kwx/Q7EsqB8zeeAauNTVdiWeT8ALxsC+7a
         NZ9BQtpQN9W5TV0ZnUChl+OeBIIwT8nu4WHFjAogjE/AY9rCfuaFelZeS40yPTV5JLCK
         HMbY9hoCjPDfkuFArohRL3N8ZDRPXevaFGnMuxCt1aBHkj6MTRgz1eT95RiBv3lnfPQe
         5DdCM1azbpGFMzCC5aHOCihq1tjw2oDn4lV7rFJrsAXtYLXMguBAmxqw7sD0oFx46xoo
         tpkQqrVS4iSpoCEavEAK2Hzbn9bYBmqCS9rQgCvSGwOvaQCfxVTaHmuUnaA7yCFcI01E
         SEkQ==
X-Gm-Message-State: AOAM532wYKl3Sb6ko1YqW/g2nTilubdAYrdwR7fioIagX3+5PkRbp8Nm
        mIjPsy56MJ3Pf0YYNMccHYs=
X-Google-Smtp-Source: ABdhPJzsZVkBH1jn0hNFg7mvMu4tW9Bi2ijPGE0ME+yUkyAq3gaW+hVw87S1yMxYLqeNeOE3mHrYRg==
X-Received: by 2002:a17:90b:344f:: with SMTP id lj15mr19043043pjb.211.1618736344953;
        Sun, 18 Apr 2021 01:59:04 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id b10sm1317083pfb.27.2021.04.18.01.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 01:59:04 -0700 (PDT)
Subject: Re: If the initial commit is empty, it is not shown in "git log
 --simplify-by-decoration"
To:     Matthew Timothy Kennerly <mtkennerly@gmail.com>
References: <CAKqNo6TFudrXnuPzQcOaVQrRpq_0K_fxyyMA5god-WQL7y=RcQ@mail.gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f24b8f44-b89e-7e11-c2b1-85b40f1e996e@gmail.com>
Date:   Sun, 18 Apr 2021 15:59:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAKqNo6TFudrXnuPzQcOaVQrRpq_0K_fxyyMA5god-WQL7y=RcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/04/21 06.58, Matthew Timothy Kennerly wrote:
> Hello,
> 
> This seems like a bug to me, but maybe there's a good reason for it. I
> reproduced it using Git 2.27.0 on Windows initially, and then I
> upgraded to 2.31.1 to confirm that it was still present.
> 
> After committing with "--allow-empty", the initial commit is not shown
> in "git log --simplify-by-decoration", although it is shown with "git
> log". I would have expected it to be shown in both cases:
> 
> However, if the first commit is not empty, then it is shown with or
> without "--simplify-by-decoration", as expected:
> 
> For context, this was reported to me on GitHub here:
> https://github.com/mtkennerly/dunamai/issues/14
> 
> Regards,
> 
> MTK
> 
[CC] Junio, what do you think about the issue?

-- 
An old man doll... just what I always wanted! - Clara
