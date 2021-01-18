Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7748CC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D045206BE
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436878AbhARSao (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436833AbhARSaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:30:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29118C061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:29:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 6so10112277wri.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9NV5b6xONMU+Sr+/oojP/0VAnmMP/sV7XakA6MuEYcY=;
        b=hebRGLUAq1TAbaqbIkC+2cBal+BFi4StvPsIyDL9sxF1OvxjYo5dVFy3/0f3e6Pgmv
         WkiNqJdgC/+wWr1bfpNTsx5U+kZ3H4cq1dGWyOc8/Qyw91I5jjhVDXynJBdWU2nAndRP
         WQztQk92/sOSO4ox5uih8OuRK2KxPzXHxDa0jBqN1/zu1NK9kDjX6FI4NB3ZA+xZsnJ/
         MPWJpJ7PuZoxSHTBYfIQvmX0sOi/o4DFZGuXeYXWi+DndqldFuf2AOZKpAL9K4xWl7cR
         FUpt0Q7RKCDu8s7WAH7+zW339So11t4CaP2sAdYdhpW0bT0kXDFgD7bL5+JLNE5/8Tco
         ozUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9NV5b6xONMU+Sr+/oojP/0VAnmMP/sV7XakA6MuEYcY=;
        b=f12l4lNOHVz/gb0rCePymEdyc6KlREjWG6DGedbEHLKcih4QmcDfmaXTwgzrkvFdYD
         P42UUZotRyrepPfoF0M2ofB79+cadhiSapROjye4876euJcSUaMPDueDY5MjN6gNaCwG
         0B5OLGsqP+8EK/rVX0x1iGcZpAkv3NX43K1bU65jUgt5/yHyQkDAq/LO+J5nrhl/QRks
         z6PEIwZFXqxWT1gud0y1ldio+y3830S0LFIdm23j8rT/JllrCHOIvYI2Zs51hxZknIhd
         3BMyApTb7bodpdIOLfJUSpE7AZPp15L7f8+UapJ8T4M4tsWWqQeeTYxP+lK+s7hQed/K
         ZOMg==
X-Gm-Message-State: AOAM532toVRGTXpCgs7E8HL9of5ltIloQiJnla9tbiKNj8FrmeTEdZAS
        LlSel6RK8C/LzlrvETZ32zQ=
X-Google-Smtp-Source: ABdhPJyNXdNSR3jdHzB1Yl6oudi9P7Q+QWbCfOjF8TixOXRPmBM/iHzNKGzY1xdCjoIJu1oMUPN1og==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr791950wru.10.1610994567897;
        Mon, 18 Jan 2021 10:29:27 -0800 (PST)
Received: from [192.168.1.201] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.googlemail.com with ESMTPSA id b13sm28990034wrt.31.2021.01.18.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:29:27 -0800 (PST)
Subject: Re: [RFC PATCH 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210108092345.2178-1-charvi077@gmail.com>
 <20210108092345.2178-4-charvi077@gmail.com> <X/9DdGnYo7RQz5CE@nand.local>
 <CAPSFM5fuT0QAK9wJ_HuH3t=qThPx7Opwy0GrYieVntJ8A4ARMA@mail.gmail.com>
 <abc9334d-a9ec-a041-aa04-16cb4f01372a@gmail.com>
 <CAPSFM5eZ=_yaeNmF_SnL2jx+Tz4HdgROF=SjhbL=UbB75eFHxA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <f2085c1b-c6aa-0183-e090-8b2da3cc57c0@gmail.com>
Date:   Mon, 18 Jan 2021 18:29:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5eZ=_yaeNmF_SnL2jx+Tz4HdgROF=SjhbL=UbB75eFHxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 17/01/2021 03:39, Charvi Mendiratta wrote:
> Hi Phillip and Taylor,
> 
>> [...]
>>>>> @@ -224,7 +223,7 @@ test_expect_success 'auto squash that matches longer sha1' '
>>>>>         git cat-file blob HEAD^:file1 >actual &&
>>>>>         test_cmp expect actual &&
>>>>>         git cat-file commit HEAD^ >commit &&
>>>>> -     grep squash commit >actual &&
>>>>> +     grep "extra para" commit >actual &&
>>>>>         test_line_count = 1 actual
>>>>>    '
>>>>
>>>> Worth checking that "squash" doesn't appear in an uncommented part of
>>>> actual? Or better yet, checking that "# squash ..." _does_ appear.
>>>>
>>>> I.e., that we would leave this as:
>>>>
>>>>       -   grep squash commit >actual &&
>>>>       +   grep "^# squash" commit >actual &&
>>>>       +   grep "extra para" commit >actual &&
>>
>> This test is checking the message that gets committed, not the contents
>> of the file passed to the editor. I like the idea of checking that the
>> squash! line is indeed commented out, but we'd need to test it with
>>
>> grep -v squash
>>
> 
> It seems to me that you suggest to use 'grep -v squash' instead of
> grep "^#squash".

That's correct

> So I added to check the test as here:
> 
>               -   grep squash commit >actual &&
>               +   grep -v "squash" commit >actual &&

There is no need to redirect the output of this one - we don't expect 
any output and the test will fail if there is so we want to see what the 
output is.

>               +   grep "extra para" commit >actual &&
> 
>> Looking at the changes to the tests in this commit it highlights the
>> fact that I don't think we ever check exactly what the user sees in
>> their editor. We do add such a test for the new `fixup -C` functionality
>> in a later patch but perhaps we should improve the test coverage of the
>> squash message presented to the user before then.
> 
> I agree and in this test  it's now just checking if the commit message body of
> "squash!" i.e  line "extra para", is added in commit message or not. So, I am
> doubtful if the above is the right way to test whether squash! line is commented
> out or not , as "grep "extra para" commit >actual &&" will rewrite the
> 'actual' file.

The test above gives us reassurance that "squash! ..." does not make it 
into the commit message which is important. We'd want a separate test to 
check the message that is presented to the user however looking at patch 
7 the test 'sequence of fixup, fixup -C & squash --signoff works' checks 
that a "squash! ..." subject line gets commented out so I wouldn't worry 
about an additional test here

Best Wishes

Phillip

> Thanks and Regards,
> Charvi
> 

