Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFF2C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557A060FDA
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbhHTPKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHTPKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:10:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B269C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:09:42 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso9314308otp.1
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OsNSZLAS0GBkL2sCSnCYkBgDLLYA9kycYx4ykEYkhZc=;
        b=ghgGGYt6/5fS1RkKa09bqaxjFRcoZwEn+4L4ciLX1yVq4+ofppoGga9G+nAA6p0+3I
         G+M8qphbrVNHYCH14OTMYJm1DRWEhLNulPCbbBnTjq+DTzJylQqvHbKDclfZ0MmsT/aN
         zwYwJ4eSXabbWRcbu78HPq8elXwooeIJjUuramqOT9xMr5jobzTPzXljlb0cr4szW4yB
         xKs77gnA0c6B82puoxw/kS6nfLwPIf3pcwvx9yVY/krzL8RgDUcQnq3slE+bIGEwODuK
         svGx4XpKYwthBF4IDtyoZHvOINPOCukfG5wZmjpacXYku/JO7iLOwRUQpdDvDR/i02IY
         pCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsNSZLAS0GBkL2sCSnCYkBgDLLYA9kycYx4ykEYkhZc=;
        b=aVFObufD49EaxQqZGPcnhODR6teYTbQzYS3A/DV6T3mYt8zv2dOGA5tzI0O8Dw/VTu
         N23N5Wl667rFk8WpvpNNdcYmdIJ5fAGpFXIpEp8yfVRQ2zgnS2FIytWxhrtHNJle0O1Y
         s775qmA7AsIoUUXPaAT7LZN561d0ReY/VPS8IIlkMaA5e6HmiZWpGUUN15zObBz812ig
         GUr6JW9wU1Q0f+bSNG5AeBaeg11c9d2BnwdnZTcw+uITECqct/UuNaHWn5j9LukL54IC
         3dxHEaWtQ5HUVV+tBbSWpJiJHsKGVu3Pn20jRT3djX2tumpEobC5C6+qTtMMSJFIII5L
         XyfQ==
X-Gm-Message-State: AOAM533vJHAKpHPHvmcf239ouZOHQ+79J0OvFjAwCACm+feHo6NI1s+Y
        TY7uyGtS+3RLdEpEKqxvp0k=
X-Google-Smtp-Source: ABdhPJz/ZfpGaQZjr8gMfnKZfo0vwm4wpdUFm6tVYcg77vRTaUZDG4LkjYTQGzmB2mFrV1j9xcp/YQ==
X-Received: by 2002:a05:6830:236d:: with SMTP id r13mr17428440oth.130.1629472181325;
        Fri, 20 Aug 2021 08:09:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id t1sm1524215otp.9.2021.08.20.08.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:09:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] t7519: rewrite sparse index test
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108190933210.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <24b1b932-caf9-b709-baf4-a2f8669deb88@gmail.com>
Date:   Fri, 20 Aug 2021 11:09:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108190933210.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 3:45 AM, Johannes Schindelin wrote:> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
>>  test_expect_success 'status succeeds with sparse index' '
>> -	git reset --hard &&
>> +	git clone . full &&
>> +	git clone . sparse &&
>> +	git -C sparse sparse-checkout init --cone --sparse-index &&
> 
> Would it make sense to call `git clone --sparse . sparse`? I see that
> there is no support for `--sparse=cone`, which makes me wonder whether we
> want that at some stage. In any case, cloning with `--sparse` and then
> setting up the cone mode should result in a little less work, right?

The amount of work saved is miniscule, but I can understand wanting to
shave what we can from the cost of tests.

>> +	git -C sparse sparse-checkout set dir1 dir2 &&
>>
>> -	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
>> -	check_sparse_index_behavior ! &&
>> -
>> -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
>> +	write_script .git/hooks/fsmonitor-test <<-\EOF &&
>>  		printf "last_update_token\0"
> 
> Technically, the backslash needs to be escaped because it is within double
> quotes and we do not want the shell to interpolate the `\0`, but `printf`.
> Practically, all the shells I tried handle this as expected.
> 
> Also, I have a slight preference for:
> 
> 		printf "%s\\0" last_update_token
> 
> and later
> 
> 		printf "%s\\0" last_update_token dir1/modified
> 
> What do your taste buds say about this?

I have no opinions on this one way or another. I will just point out that
the pattern used in this test is also used throughout the test script, so
any change to that format should be applied universally. The test has been
operating without complaint since it was introduced in 5c8cdcf (fsmonitor:
add test cases for fsmonitor extension, 2017-09-22), so compatibility is
likely not a problem.

Thanks,
-Stolee
