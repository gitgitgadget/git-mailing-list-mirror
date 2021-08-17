Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDFC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AD160F41
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 18:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhHQSsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHQSsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 14:48:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134ACC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:48:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id e14so24265538qkg.3
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLqlyjhUUxCwKe1ladRIeZAaZP7ofUHfejtnd+0x6R0=;
        b=O8G+ROhLnCEzVHhAtln81ETmW2leVj6DsVPsEtaNPW2S+DImtwGRLXuwinGENrCPVr
         mWkcrn4tldboCStNiFFoUHTXgiGDrYDF96rxk6eBVtyscsf8kpIBImM2ls+kYhiCQXZI
         GToazaXFWmuxELkdMB8ulpKc8isXg5BXmYsoXQ8kNyhN0usF8aDnXis1hcaR7rUuSXBb
         z03geeIF5BYdufiAOe3ScYv5BcuR3fryz1jBHFPtNQTm/JvS5b0Z2kg6RL3TtjpdLcRx
         ji3Jg7a7OvAvnwllvi9TYzp8s19OlK++D00Cli4qRPkLnf+awCjFstd8xqJA49sN3FS3
         5T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLqlyjhUUxCwKe1ladRIeZAaZP7ofUHfejtnd+0x6R0=;
        b=iq2EC+Xob+UakhXL7KZ91msdDS5R2mneDmyY41JSN5Ou0+Q174T9ApX0MkZYC5PmQU
         PfHbwZKUmh1p3w5d8o65UcSZs/lQ4DfBKx2OvAGxersvJmKdfQiUHbAohkzWnGYA6GoI
         2Wo5VLefk3FlBHQu8lDRFHPXGRRWzMx0NYnl8Yrvk+6OP+bQd9qLB1qirucxm3oys4V1
         kk/UpgbEunQgkgGCBTj7XWI4GeZ1N0z6kGUfp8vlHai6UAvYuUL/FZumQTPtUV1r+DX7
         bj2NmHkV/SYMNmS82002nSJ0WuwSYy6QkdLAfCBr3PmZFha7zyUommt4VIj+k169D3OV
         3tcw==
X-Gm-Message-State: AOAM530pBx/D1ubNl52srcB7DM8wj70506UJSg89F/r7iqwp1qz2dg05
        krOpCMIzGuhUsCOFGRUrWbs=
X-Google-Smtp-Source: ABdhPJyjeIXk54uVddhLvCqg+r+RULsVX08z37SuyAnFsJ2tyBisCOHiLfXV+JN8UjbLuyq3kHgLVw==
X-Received: by 2002:a37:4048:: with SMTP id n69mr5447604qka.261.1629226100207;
        Tue, 17 Aug 2021 11:48:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:dc75:b61d:e533:9004? ([2600:1700:e72:80a0:dc75:b61d:e533:9004])
        by smtp.gmail.com with ESMTPSA id f24sm1516482qtp.1.2021.08.17.11.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:48:19 -0700 (PDT)
Subject: Re: [PATCH 1/6] t1600-index: remove unnecessary redirection
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210817174938.3009923-2-szeder.dev@gmail.com>
 <d8d8d59a-ecac-2cd5-18a3-f1cb65e48c2e@gmail.com>
 <20210817183917.GC2257957@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <469a6987-15ac-82ef-b330-0802d1843f17@gmail.com>
Date:   Tue, 17 Aug 2021 14:48:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817183917.GC2257957@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2021 2:39 PM, SZEDER Gábor wrote:
> On Tue, Aug 17, 2021 at 02:12:36PM -0400, Derrick Stolee wrote:
>> On 8/17/2021 1:49 PM, SZEDER Gábor wrote:
>>> In a helper function in the 't1600-index.sh' test script the stderr
>>> of a 'git add' command is redirected to its stdout, but its stdout is
>>> not redirected anywhere.  So apparently this redirection is
>>> unnecessary, remove it.
>>>
>>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>>> ---
>>>  t/t1600-index.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
>>> index c9b9e718b8..5d10cec67a 100755
>>> --- a/t/t1600-index.sh
>>> +++ b/t/t1600-index.sh
>>> @@ -79,7 +79,7 @@ test_index_version () {
>>>  		else
>>>  			unset GIT_INDEX_VERSION
>>>  		fi &&
>>> -		git add a 2>&1 &&
>>> +		git add a &&
>>>  		echo $EXPECTED_OUTPUT_VERSION >expect &&
>>>  		test-tool index-version <.git/index >actual &&
>>>  		test_cmp expect actual
>>
>> Since here we have a 'test_cmp expect actual', perhaps the
>> actual mistake is that the line isn't
>>
>> 	git add a 2>&1 >actual &&
>>
>> What do you think about that?
> 
> The actual file is written two lines later as:
> 
>   test-tool index-version <.git/index >actual
> 
> So it seems that neither stdout nor stderr of that 'git add' command
> matters.

Of course. Sorry for misreading.

> However, in most of the preceeding tests 'git add's stderr does indeed
> matter, as they do:
> 
>     git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
>     # write expect.err
>     test_cmp expect.err actual.err
> 
> I suspect that the 2>&1 redirection this patch is removing might have
> been a copy-paste error.

That makes more sense than an errant addition.

Thanks,
-Stolee


