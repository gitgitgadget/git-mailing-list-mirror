Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB37C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbjFCBiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbjFCBiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:38:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72961B6
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:38:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b0424c5137so24437775ad.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756292; x=1688348292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ihz/rDOg0fJ6WUpoI5WrknwJIw9C5udCnZ3ifBB98g=;
        b=pAdRtG1bsRUn8/cFBnmTOlgIaBpLT41KK0h2G0FViquaWVnI9xgd0Yg2b8GqPozjBK
         E4wdSR4uEvfOAPef2wuq0cYLN7YL2eXpLg33YjZUKvBgwUToFrgUN+wPd/Gw2ULjH2LM
         8hiMENdzcWK1Gz8d6TYfqcXqZ97OgDZsmdUof0IwoL9dc/2SeFII5GmDRhAzjXmUNC26
         nnk9mrd5LXhRAypNQMfUs/f2eP/7XQvfir0M4B4LUfEazbOiAua+1JojWE3Tc8d+jCLE
         aoBuzijma4NveGpjCmDowOfvUS8mq9wSZAZX1JwesMJG1w4X4gf1/2So9dRJdnZZcHSp
         yPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756292; x=1688348292;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ihz/rDOg0fJ6WUpoI5WrknwJIw9C5udCnZ3ifBB98g=;
        b=U3ttBYpG+FtRfV0eC4Sw8NzSGfUEqgUXMukgx6gvWNyILL34xeRZXUluHHleFrUQIh
         5xdD3eKgqcFLGBrApv+DBrxVWF8ZHG84jV4kw7k/wCPw4KQQfcyqALxVNE5gJRn5ZD54
         /se/OK70f55cgYNxPjUeL38F6BfWv8eOQkl0XoBvwBVocdmQ6N7BQBrLDkewMGoocIVm
         7rSqEAg5WFT/xcHltZvWGYMl4yYmJMHscCWWmhUnwyAgpb0tpU5UmHILBGYSyWC1+Xdr
         L2l9lyS66JNmpwC9L/6fhQIf6/WrBTz0CAdT0e4pvsCqvY2GkOWeREGgl31gKxzd9D5F
         jiWw==
X-Gm-Message-State: AC+VfDwg4GCx/IFm1mXPavO6IvkAnmnuMXNx4Is8QEUTVSm/QuMsKOye
        EGyVsRE1t5QOJex5xDymb/4UYR7i9+cIyQ==
X-Google-Smtp-Source: ACHHUZ4+qXdyhRxFMSISZdCgTfX2/64NN70fO+6rYfsf3Zy7G3qFqmYy4rQNUzhxH7ukXi9cPpQM/g==
X-Received: by 2002:a17:902:e543:b0:1b1:a617:7df3 with SMTP id n3-20020a170902e54300b001b1a6177df3mr1774875plf.30.1685756292064;
        Fri, 02 Jun 2023 18:38:12 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001b027221393sm1985340plh.43.2023.06.02.18.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:38:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? subprocesses can use wrong Git if $PATH is unset
References: <E7D87B07-C416-4A58-8726-CCDA0907AC66@lanl.gov>
        <ZHk5V6U9gfkuwErH@tapette.crustytoothpaste.net>
        <412E82B5-79C0-4AAD-8219-AA7664E9EE1E@lanl.gov>
        <ZHpO9/4RSbeTy0HJ@tapette.crustytoothpaste.net>
Date:   Sat, 03 Jun 2023 10:38:11 +0900
In-Reply-To: <ZHpO9/4RSbeTy0HJ@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 2 Jun 2023 20:20:07 +0000")
Message-ID: <xmqqwn0l72bg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-06-02 at 16:14:47, Priedhorsky, Reid wrote:
>> Hello Brian,
>> 
>> I do wonder if the behavior would be worth documenting, e.g. at
>> https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables,
>> where Git’s relationship to $HOME is also documented. I would be happy
>> to submit a pull request.
>
> I don't think it's necessary, since it's expected behaviour for me, but
> I am not the only person on this list, and perhaps others would
> appreciate a patch.

I tend to agree that it is an expected behaviour.  In addition,
unsetting PATH is not something people deliberately do every day
without understanding its implications, so I would rather not see us
add "if you do this esteric thing, this would happen" for them.

Thanks.
