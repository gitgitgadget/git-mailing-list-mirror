Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80C7C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385203AbiDUNc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385501AbiDUNc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:32:26 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFC38182
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:29:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z2so5606903oic.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ZCiQq8YRYFMm/Q+7bzYU55RROKa1mK0T9/C1iw1uQs=;
        b=KcC7JaIphhTCQC5DQg8Yb6aPBEmwTd2dtIqi/jsCHeuCNDc8hMNVvvqUmKBb2MfAZT
         Tze8val++hThR1bCaphhXy2sfi+NvaWReWB9lc7yjeIhw85zLjaDEi7pa3k32OBxJLd9
         6IBfPPhAqDEtKSuhoU8x1Q03D16WkNFdA+143QIs8PH9LA3OIJ/Jai8a4hYVAh0fCXPC
         B/bIW1iRWBcSd7XhDQ1PCLWI89pwQFS7syMFg2hEAgZn8AnaM/UkvwiYAJOY6alWFvix
         C7+ETCeq7jEOlGUJAEhbnyasuaVrIznlKS231mmNJurnopaGu8a6OCk92fN+aqbdrAY4
         PTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ZCiQq8YRYFMm/Q+7bzYU55RROKa1mK0T9/C1iw1uQs=;
        b=kanBYvF2G+vHS/Od7xrX/xO7MsN2d6erqeYkpTgWLeRCEOKAjnjO5qihy1hxqXf/as
         jcLaf7fOmICaMc0rzxHXL6SvobgqTKiWzwQoI6B+KiQ6KHYMuCW9uXB/BvKEI42QMQx3
         tpl28OUTcJ3hLHYhuLT+ipXiW7EqFm5EqCRoJAIJazVDu+Uahj9cy46jbm1vftf5acHG
         mtlgUJy6fDyy3V/ZS8LT9I32iyRJg9mxT8TYNOZp277eFWXaYRUrUUZzmt8zVSwxnbXi
         gIMa9tejr5i2mZ3fn/2b6gTFuw+P9yNaMT2ychzGET9jEwYBwTgDt182Nng2o/rtWEbG
         tbRA==
X-Gm-Message-State: AOAM531LdxSarfq6GeQIKCrJMvMHvQTdxP55zsZLuVjnSXoZ3jZPkTeP
        jpoyr/ZC3zyvQV0mJK+BD9GCKBCTHJqJ
X-Google-Smtp-Source: ABdhPJyPJU4JheosERSY0IVR0HmhOi6f7dIRzLnbG1rbFCsbkYyhjbIwVJ2X9RqeWrzrO1MOvDQkmQ==
X-Received: by 2002:a05:6808:1b26:b0:322:a467:b9e2 with SMTP id bx38-20020a0568081b2600b00322a467b9e2mr4369271oib.187.1650547773919;
        Thu, 21 Apr 2022 06:29:33 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e18-20020a544f12000000b002fa0db80b13sm7624495oiy.48.2022.04.21.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:29:33 -0700 (PDT)
Message-ID: <b884d627-4a81-5be9-eed5-feff3b2bd010@github.com>
Date:   Thu, 21 Apr 2022 09:29:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] clone: ignore invalid local refs in remote
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
References: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
 <xmqqczhbo4s3.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczhbo4s3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2022 4:53 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> Subject: Re: [PATCH] clone: ignore invalid local refs in remote
> 
> After seeing the title, I expected that cloning from such a
> repository with cruft in .git/refs/ directory would issue a warning
> and succeed without these non-ref files.
> 
> But that is not what is happening here?

Sorry, this title of the commit message is stale from a version
where I started making the clones succeed (but without these
bad refs). I changed my mind to only switch BUG() to die() to
avoid giving the impression that we have a "matching" repo after
the clone.
 
>> +test_expect_success 'local clone from repo with corrupt refs fails gracefully' '
>> +	git init corrupt &&
>> +	test_commit -C corrupt one &&
>> +	echo a >corrupt/.git/refs/heads/topic &&
>> +
>> +	test_must_fail git clone corrupt working 2>err &&
>> +	grep "has a null OID" err
>> +'
>> +
> 
> We keep expecting that clone _will_ fail.
> 
> So the net change is that we still do not tolerate a corrupt
> repository and do not let corruption to propagate through cloning,
> but we diagnose this breakage as an error by calling die(), which 
> is appropriate for dealing with runtime data error, instead of
> hitting a BUG(), which is reserved for program errors.
> 
> I agree with the fixed behaviour and implementation.  It just is
> that "ignore" on the title seems misleading.  Other than that,
> thanks for a good finding and a clean fix.

Perhaps the commit could instead start with

	clone: die() instead of BUG() on bad refs

?

Thanks,
-Stolee
