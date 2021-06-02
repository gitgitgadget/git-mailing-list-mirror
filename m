Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2077C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 03:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D093613CA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 03:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFBDpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 23:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFBDpC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 23:45:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7444EC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 20:43:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t28so1103773pfg.10
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tGwwoSNRzVD/RrtpFcQGWt0FnAdqFQLatlLa3OChrUs=;
        b=hD4/JgWZtFITC0wIq78njVIb1SjiqdlRqQAjjV3XIWVwEkMUBUYsrXSxjLB0WSEMgS
         6xbWFjm25CyNw3shT35RP4bqVrWS10aaz8ea5EczZ9Cig+8qQf7uRZzGLLQra1CG2XNW
         4boqxLgjqOrNA5a0dF5gKOVA3FwivF4Vt2xwAuZM/YGNIc6hAMDMQ1RWJS2FTI+AK+Oy
         53gtW/b3XQVkymbiHSYEw8XMoworM3kR0KT9icPupRNvMUxYnxttOUlsxv/yRKr4Pcc4
         045ih5pLaacTObpWiFs3Sm4BNeeCokmOSqUSGf+l27dRIhqXgsSS2jEz6Otvhw6SZ9y0
         0Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tGwwoSNRzVD/RrtpFcQGWt0FnAdqFQLatlLa3OChrUs=;
        b=b2t8099BwZb95uMur7kG9k2Cy2+sPefCoSi1qLMn0Cw7V9HzyscuwIAxTDU1fNCXXE
         Q9JNJli2hurl8wK2chVDxtgCgaty6USLJZrXStfw+jVeP5waAfaSakdWg4+wBj6fpxk6
         HvCdQathPlqlzNBaCA0rRWVVFMrZnPHJdLu9NWPNRwWUcSiztKE4DrXykHLkhNQa0Ujf
         wI9flalY3Pb7SawKfOPWnmBVzjfPFSolRvJxL+g6deCZYfOyKdj3FpumZXMqHomlWgDX
         0pz1Kns4TzEMxQdnOzYhQmuxDiYpZCk+fgVIKaebYjy1rpwZK4+UK+DQUp4o2nO2kL60
         F97A==
X-Gm-Message-State: AOAM533zRvbnpv07LE5/Jf1vjKppNTSQ2ozJjmBtJrAE1Hcy4Wy6htJK
        +/oghAlnFqkih/0h4zMhhbsh1NTOpWkfLQ==
X-Google-Smtp-Source: ABdhPJwB6VZZdW9iPNL217lvWidsDb3DdNeK3F5KBhl1+j4WrBbewUapsVzeXbCHkrW5gGsUtj1CYQ==
X-Received: by 2002:a65:66d3:: with SMTP id c19mr11956829pgw.184.1622605398730;
        Tue, 01 Jun 2021 20:43:18 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id 18sm3343932pje.22.2021.06.01.20.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 20:43:18 -0700 (PDT)
Subject: Re: The git spring cleanup challenge
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <60b5d281552d6_e359f20828@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8f8d023a-936a-948f-7b36-655774319ba9@gmail.com>
Date:   Wed, 2 Jun 2021 10:43:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60b5d281552d6_e359f20828@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe, sorry for responding in long time.

On 01/06/21 13.24, Felipe Contreras wrote:
> Once you've lost, reply to this message with the configuration you could
> not live without.
> 

I'm not opting in into the challenge, but here are my mandatory global 
configurations:

> [core]
>         editor = rvim

I set core.editor to rvim because of my habit to edit using restricted 
vim (as I only use vim to edit files, nothing else).

> [merge]
>         conflictstyle = diff3

With diff3 conflict style, I can clearly see the context of conflict 
(base) instead of having to choose between either side without context.

For several repos, I do GPG-sign commits, so the required config is:

> [user]
>         signingkey = <key>

On very large repos I have (for example GCC and Linux kernel), I have:

> [pack]
>         packSizeLimit = 650m
>         windowMemory = 400m

Both pack.packSizeLimit and pack.windowMemory helps when doing 
git-repack there. With the former, the resulting pack file is limited to 
650M size each, and the latter set memory window during delta compression.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
