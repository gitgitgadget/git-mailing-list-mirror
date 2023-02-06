Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9509C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBFTuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:50:45 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA62384F
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:50:44 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id w3so14228730qts.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0UHdRod+952KXtSdckAJNta1xdi7Qtc3dXKLcgDDt8=;
        b=dNcmsvGZNZYB50B13wn8AVBu/ZrEdo2NHeMGAJLGiwgfFEy/uSdLfcYhsKuQyFndMN
         xDh8MR55ibSmUqHmPezILMbcEy4lalmf57Z81Je1iPmEobJKUGGsyX8/rFeU8ABUWZdX
         A9gxafghyQQdB+97UWpXf6/LiezVYk2zbCpS+jiaFpsyYAxif6l2VKGGY75qDaY2pBJE
         9cNAQWw9Zo0MWVBFHy0f6h226Il1c9QoE6RM3/QdM2/chwZwwAJxy4gix+PoqgJeiXsa
         KdFW3FrivjXhqtN/K/fSabZo9KPqPQfa3yZYRNqR/7lH4tKLFNcY5LCDGxFpZJiNo60K
         3Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0UHdRod+952KXtSdckAJNta1xdi7Qtc3dXKLcgDDt8=;
        b=HI1HPW//KkgYgzgzssCa+Mhx7iAjW7gTaY/asqLASWouyKD5RTFDtGk4Ckxzvuizji
         KBbW0+t7Wq7nuk2NDeV6b8NeUqjkUDHZG2RXH1d4GMkbACMjGxne5mIFpXfr8HzsI395
         V9Luba2f5SDgqvgyBt9C2Lux/H8hLp8510ZGXeXV1yw59lUoak5K3p63mGOwXgK734kS
         zmvE08mdvJcFnpKQp7ckbmLN+bC4GvJ0txPut6r1kU0EpvnMxT7jKEBuWCO6LOXcF5Qj
         xWJKTFPcKwAjfh+2y5rP8G0WZr6IRhIHOidBP/T7IdiKo0ytH2Hoaa9b8KTdn/C80ho/
         tTTw==
X-Gm-Message-State: AO0yUKUBF+3GBNITjIxK7ReHzwNXCaiC9F/7bqzW+MFcJpQnq1LJs5s/
        pYiDAXxZEQcDqCy/4wLOfB4=
X-Google-Smtp-Source: AK7set/Sr/IxQSj3W25kBOn8uuIjMJ6pwc5DKyv8Xgbamkt9k4PnIJXynMkgPjMIa1AftbxagvX9qw==
X-Received: by 2002:ac8:5f4a:0:b0:3b8:6801:90b3 with SMTP id y10-20020ac85f4a000000b003b8680190b3mr1294477qta.0.1675713042898;
        Mon, 06 Feb 2023 11:50:42 -0800 (PST)
Received: from [192.168.1.205] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id m7-20020ac866c7000000b003b691385327sm7929036qtp.6.2023.02.06.11.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:50:42 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Mon, 06 Feb 2023 14:50:42 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com>
In-Reply-To: <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 6 Feb 2023, at 11:27, Phillip Wood wrote:

> Hi John
>
> On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> It can be useful to specify diff algorithms per file type. For example=
,
>> one may want to use the minimal diff algorithm for .json files, anothe=
r
>> for .c files, etc.
>
> Have you got any examples of why this is useful? I find myself occasion=
ally changing the algorithm when the default gives a sub-optimal diff but=
 I've not really noticed any pattern with respect to file types.

At $DAYJOB, there has been a discussion and request for a feature like th=
is [1].
One use case that came up was to be able to set a different diff algorith=
m for
=2Ejson files.

1. https://gitlab.com/gitlab-org/gitaly/-/issues/2591

>
>> Teach the diff machinery to check attributes for a diff algorithm.
>> Enforce precedence by favoring the command line option, then looking a=
t
>> attributes, then finally the config.
>>
>> To enforce precedence order, set the `xdl_opts_command_line` member
>> during options pasing to indicate the diff algorithm was set via comma=
nd
>> line args.
>
> I've only commented on the tests as it looks like Eric and had a carefu=
l look at the code
>
>> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
>> index 8d1e408bb58..630c98ea65a 100644
>> --- a/t/lib-diff-alternative.sh
>> +++ b/t/lib-diff-alternative.sh
>> @@ -107,8 +107,27 @@ EOF
>>    	STRATEGY=3D$1
>>  +	test_expect_success "$STRATEGY diff from attributes" '
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index file1 file2 > output &&
>> +		test_cmp expect output
>> +	'
>> +
>>   	test_expect_success "$STRATEGY diff" '
>> -		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > outp=
ut &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>> +		test_cmp expect output
>> +	'
>> +
>> +	test_expect_success "$STRATEGY diff command line precedence before a=
ttributes" '
>> +		echo "file* diff-algorithm=3Dmeyers" >.gitattributes &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>> +		test_cmp expect output
>> +	'
>> +
>> +	test_expect_success "$STRATEGY diff attributes precedence before con=
fig" '
>> +		git config diff.algorithm default &&
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" f=
ile1 file2 > output &&
>
> This test passes with or without the code changes in this patch. I thin=
k you need to drop --diff-algorithm=3D$STRATEGY from the diff command.

an oversight indeed, thanks for catching this.

>
>>   		test_cmp expect output
>>   	'
>>  @@ -166,5 +185,11 @@ EOF
>>   		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > out=
put &&
>>   		test_cmp expect output
>>   	'
>> +
>> +	test_expect_success "$STRATEGY diff from attributes" '
>> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
>> +		test_must_fail git diff --no-index uniq1 uniq2 > output &&
>> +		test_cmp expect output
>
> This test also passes with or without the code changes in this patch. I=
t  is the same as the first test added above but with files that give the=
 same diff irrespective of the algorithm chosen so I don't think it is do=
ing anything useful. Unless I've missed something it should be dropped.

I should have been more thorough with this one as well, thanks.

>
> Best Wishes
>
> Phillip
>
>> +	'
>>   }
>>
