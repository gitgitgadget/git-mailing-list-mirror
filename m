Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA0C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18FE61214
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhIWNij (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbhIWNie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 09:38:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18547C061757
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:37:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l13so6180258qtv.3
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLeeP3tY/8eR3FPlP+aQo3NDKYZWl+iZnVXoAtAipEw=;
        b=kPEq3xe+coqkCUhz7GW6dWiDHSf0hM/og04hLnRbNgrTHSbQm8RwnYk5z4P8ELskQt
         h8cpLCvHR6qqhW12oOqFejQOFaBXcX15jrABAhotD19YpydEa/Wkdjau54a0V6En1eWI
         Hwpi83bCBhjSy5bp6dajrXuGejNJnrz6t+9Y0VpUV3uvD6YuAsTrb7obDd0153stlglo
         AfnTeJwU7mAI0ZRwgoaTZCJtmlcoHFjq3vV6knkd9u7RHMhJMjobdk08l6xCZFfPQ//K
         3VKizvabMaep3Vs7D5fCWb9rOALL3YB/qbX3IjtNmkqyXIHnaDX0/rCOjuJd0cvL3JmY
         F4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLeeP3tY/8eR3FPlP+aQo3NDKYZWl+iZnVXoAtAipEw=;
        b=wmwp29/1ioQzmY1az6RLSgnogvhdElii7kRak76M7HpPKXhqXDKRXSjE29dMmz6L5/
         eNJWTmQs6Xqrk54T11eXpzciOd+bqzUH9qz2hJjxYh3UhytUgi6u6JKqNSwKvc/6Usgq
         2l+Jot8eGMi7/3SsHtgC0V2vCK4RpvhwZW6D1Kfyul3AA8PYrZ158upJNPPKlMedQn9l
         q8Dz3rd4KoDieCaZPm54l63NO8nGkr8oOkn8bv6uXAxL5QXNOKoNfxY7PF11LgTkco+c
         2V+9fZLotf93PWCWuz8Pmm8MsWnMLX1iACRvRw44H/BpyyCjFIhGeBOvpFW3OEHfn5ND
         KutQ==
X-Gm-Message-State: AOAM530Or2NHfmJ/NdmjgAaWIs4DPuR8fuU5hkqQw8F2pPIg9eQjZdaD
        lM2zgItE2Pz0IeHKwbsINPU=
X-Google-Smtp-Source: ABdhPJzDY9lNJ4Gd7JdShYdWCs1h6IJEe7h2e0FViRwvEjoM0qDKuIvR8tA9vrpSMKUMdnZvEaEW5Q==
X-Received: by 2002:ac8:59cb:: with SMTP id f11mr4766196qtf.241.1632404222125;
        Thu, 23 Sep 2021 06:37:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe? ([2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe])
        by smtp.gmail.com with ESMTPSA id h15sm2684727qtq.41.2021.09.23.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:37:01 -0700 (PDT)
Subject: Re: [PATCH v3 02/14] t1092: behavior for adding sparse files
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
 <c7dedb41291ed6ff48dd9b9b9814e3040f4fa92c.1632159937.git.gitgitgadget@gmail.com>
 <xmqq35pw5hx5.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1efc50d-23c1-29f1-27f4-8638ecbf38dc@gmail.com>
Date:   Thu, 23 Sep 2021 09:37:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq35pw5hx5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2021 7:06 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add some tests to demonstrate the current behavior around adding files
>> outside of the sparse-checkout cone. Currently, untracked files are
>> handled differently from tracked files. A future change will make these
>> cases be handled the same way.
>>
>> Further expand checking that a failed 'git add' does not stage changes
>> to the index.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 886e78715fe..3fb764f5eb9 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -187,6 +187,16 @@ test_sparse_match () {
>>  	test_cmp sparse-checkout-err sparse-index-err
>>  }
>>  
>> +test_sparse_unstaged () {
>> +	file=$1 &&
>> +	for repo in sparse-checkout sparse-index
>> +	do
>> +		git -C $repo status --porcelain >$repo-out &&
>> +		! grep "^A  $file\$" $repo-out &&
>> +		! grep "^M  $file\$" $repo-out || return 1
> 
> Is addition and modification very special, as opposed to other kinds
> of changes?  Is the reason why we say "we do not want to see
> addition nor modification" here because there is no concrete X that
> we can say "we do want to see X" in various callers of this helper?
> 
> I am also wondering, if this is asserting that $file is not added to
> the index, why we are using "git status" and not "ls-files", for
> example.  Wouldn't
> 
>     test_must_fail git ls-files --error-unmatch "$file"
> 
> be a more direct way to do so?

The intention is to avoid a staged change, even if that is a modification
or addition. The --error-unmatch approach only works if we are trying to
avoid an add, and we need to know that the path does not exist in the
index already if we want to take that approach.

Upon reflection, perhaps what we really want is this:

	git diff --staged -- $path >diff &&
	test_must_be_empty diff

This applies to the previous patch, too.

Thanks,
-Stolee
