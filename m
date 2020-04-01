Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5663C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093920714
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFxrV1CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbgDAUOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:14:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38753 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAUOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:14:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so989120ott.5
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YlmRCKqS0CVFptF5YrYFjMyAOxVUEiUdXEunPThYJPQ=;
        b=UFxrV1CQlFRNyY7h6M/V/DpCTfj49LP9QQ5WL7HMyHwRS182YRSoiCAxbpZ7r5hh3F
         5UIZSKX9+PSDXYhXF9q2etAoYlaO+pUvrBbT0E8wy1hWdPvwx9fES8Umcy3z0LIbIrRL
         vlBovP42jqzpMAfdw4vTWu9D57kIcCP5Bi2sNhljYaXaf/ul2r6QRATVCZDMoaQu9jsS
         ktsYu6bHGDTlTE/YjYUFW0C4YN9qIuZ35Klbr5hLiI16SypnWe0R9DOODsqmYXEhXfaz
         hWd8Kl8SQPGWLNwzlU4aoVItGsOPE9tTXiKbMmuaho71sMQpD79pYToHFcBvfzypA0J4
         fJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YlmRCKqS0CVFptF5YrYFjMyAOxVUEiUdXEunPThYJPQ=;
        b=YupTOKhaGBe+ukcN5UA2j8GZIRd3GSk2/2Hr7Q+XW6k/4JTLCnMf93VSr9X5gkHdJ/
         /AMt0XDEPHwz+YesVEFGYO0vbfuuG2meXBJx/oTzL5KTkQN+voQcgP65c38p+ZQpexyK
         cTBKDzhZV0kPc9+xRZ1xdkmNZxed2vUD3udVnS5P3nVG+Q0Scvs5nsJ7rUJGpZvFdG9O
         UtX9LETn2LzSqg2qgLCC08fA8fUKZl49hf6sTZzgVLT2oFl/x16NYEovsd6ItdO5fSEG
         fWAKkCqfWprDYghBqRaLSgLDEbmwQNQb9jlJ3eObNfuck9uyLSnTA/TjynfeKmgnP8vm
         tLmg==
X-Gm-Message-State: AGi0Pub59Q+dGkm5AnOjr4P5EKEJlUWhdRzl86SOJbYHJOLexfwzYgKf
        cB03Xq4xvyrucdWtBgGkwYY=
X-Google-Smtp-Source: APiQypLdUMrHF0vuE94AQwCmqek220wbV4zdkQVzutQPbB1a5ck9NdKM4u1QbJfa36fToCk0C2ibzg==
X-Received: by 2002:a4a:df05:: with SMTP id i5mr26203oou.9.1585772087246;
        Wed, 01 Apr 2020 13:14:47 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h29sm728775ooe.33.2020.04.01.13.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 13:14:46 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3bacbd6b-a320-a17f-0d94-0322bffdec37@gmail.com>
Date:   Wed, 1 Apr 2020 16:14:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8sb56m2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 3:49 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>> index 53b2e6b4555..4e4efcaff22 100755
>> --- a/t/t5324-split-commit-graph.sh
>> +++ b/t/t5324-split-commit-graph.sh
>> @@ -210,8 +210,10 @@ test_expect_success 'test merge stragety constants' '
>>  		git config core.commitGraph true &&
>>  		test_line_count = 2 $graphdir/commit-graph-chain &&
>>  		test_commit 15 &&
>> -		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
>> +		touch -m -t 201801010000.00 $graphdir/extra.graph &&
> 
> We have "test-tool chmtime" since 17e48368 (Add test-chmtime: a
> utility to change mtime on files, 2007-02-24) and refrained from
> using "touch -t" anywhere in our tests.  Can we use it here, too?

I will definitely do the more portable thing here.
 
> Especially with its "relative" form, can't we make the test to
> stay correct not just for 40 years but forever ;-)?

I should clarify: the test won't break in 40 years. It will
"fail to notice the bug" that was previously present. But the
relative form is likely to continue catching this bug.

Thanks,
-Stolee

