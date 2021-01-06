Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EFC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E82323106
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbhAFLmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAFLmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:42:32 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D08C06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:41:51 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id j8so689676oon.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bSrUCTkKvqwd+lBrqbXvHKFNKBsj9eCSvWhAfluqcJo=;
        b=Ia2YL2n8164oSrewrq6dHJwJQmtgmK2wYYJT92nqx2sVyBgw1lWbnyfEXCQDEci3HF
         vTSVwJAiyUM8cDBH9k4FpcSySFml8S46tFRp7yjupP9XeDv+KNmiJNGTNDz8aI/AIxzk
         Q3SeUCXqY+iDu3FbJBdQCLUqw7O+YrmwtoUUntYoONVJ1fXnGXUSFUY1hdERrPObDPNF
         I0bztrmIs70j41JQolpH2cobmtppAWuCSjpKyClf39x3KoX27BhfONb6FC/djy7eV8DB
         XpL5RfeKyCU5TaOOXVSYZdw58g2xsvQ18/bk98IKetDftNKSmzkolMaulTAoV1+TVrAb
         TJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSrUCTkKvqwd+lBrqbXvHKFNKBsj9eCSvWhAfluqcJo=;
        b=e2bjGGyTQN4nIAunMGUlU/ZNu+Zctc2ymPQQ3tj2Z1ao5F+yQndxCS6Okh0Tj71AjZ
         Re+1U8HGSMxPAxSd8Jl4hug3chbiKPZ+3MVBqRRQ7reseKHTYo9oHINF0Xibra6OjFQj
         tt/+a4gebhTNmSpkH3PCN25EcCDwqaAXKW9kxAlj/Y7bfNC9lP69EZ0U+sZAaIXBK6el
         bqKAZ9rp8U2GFEVWuuBWrtLgmYf+YtloRXBTnZhD24tjsuko54PsAR7+IN5O44OnYdV0
         LImXwIcJlKVKSDVYAwBHF+tyCnrPqcPRFB8vBpnZRFnpsLj5vhr30VZEFaNJrVTSXc+4
         F07Q==
X-Gm-Message-State: AOAM533xEfIodplSRccOlr3Ew3uYa/Y6UoZflTuezcKnZrCCgkYK3m57
        f5bwAYDKxw55k3GV/nKfmkQ=
X-Google-Smtp-Source: ABdhPJwXKfH7LrWK6dv0EQMcsT8yYJ/6xSAgv235Ge0qt9evR7FX6hYVXiMmfrYz8os9K5FuJeWf5A==
X-Received: by 2002:a4a:da44:: with SMTP id f4mr2472593oou.84.1609933311115;
        Wed, 06 Jan 2021 03:41:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id z6sm471631ooz.17.2021.01.06.03.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 03:41:50 -0800 (PST)
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
 <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
 <xmqqa6tmtrr1.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3be0a434-d29f-a7b5-fb46-bb1fc1649d27@gmail.com>
Date:   Wed, 6 Jan 2021 06:41:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6tmtrr1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 3:05 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> Probably not worth a re-roll, but the above has higher cognitive load than:
>>>
>>>     if (!value)
>>>         return 0;
>>>
>>> which indicates clearly that the command succeeded, whereas `return
>>> result` makes the reader scan all the code above the conditional to
>>> figure out what values `result` could possibly hold.
>>
>> True. Looking at this again, it might be better to just update the
>> loop to be
>>
>> 	for (i = 0; values && i < values->nr; i++) {
>>
>> which would run the loop zero times when there are zero results.
> 
> It is misleading, though.  It forces readers to first assume that
> the loop body may update "values" from non-NULL to NULL in some
> condition and hunt for such a code in vain.
> 
> If some clean-up starts to become needed after the loop, the "if the
> value array is empty, immediately return 0" may have to be rewritten
> to "if empty, jump to the clean-up part after the loop", but until
> then, what Eric gave us would be the easiest to read, I would think.

Ok. That works for me.

>> To me, "nonexistent" or "does not exist" doesn't adequately describe
>> this (hypothetical) situation.
>>
>> Perhaps "fail-subcommand" might be better?
> 
> I wonder if "false" or "exit 1" would fit the bill.  In any case, a
> comment may help, perhaps?
> 
> 	test_expect_success 'do nothing and succeed on empty/missing config' '
> 		# if this runs even once, "false" ensures a failure
> 		git for-each-repo --config=bogus.config -- false
> 	'

I can add a comment, but keep in mind that this example would run the
subcommand as "git false". This isn't intended as an arbitrary script
runner, but a "please run the same Git command on a list of repos".

Thanks,
-Stolee

