Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D5C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD26208A3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgniQFCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKUNEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:04:39 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42881 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNEj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:04:39 -0500
Received: by mail-qk1-f195.google.com with SMTP id i3so2907179qkk.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5aERNl/uNqYh02ESgTURdo0rA065xugBXJODGpYH+ls=;
        b=SgniQFCV/uB7qFrBxVl6y7HCJKT+nkOnRPEsUDCIjhTRvEXTLuQmSgdy3lB05JuXs5
         RjrFurdiAqUiJm7jeXjArHPjibN7bdcmzbpYRgcxpotIosYU6FUlwVucIFuag53gkwbf
         V1HJN9esTPxvp5RLZWL/vu0hkrmGlg7VFKhdiWmfjrD1nYX50lGZW3hZskxLxm8As+Vk
         ViDr0a9s+R9StbCM2d5BTEZjGxCyDBuZZzk4MyJfHWxFJWckH6mAhmvEDdJO9/BwDCdT
         uRBQRVwkBQGAqZFVDFSI+NV41NjkWUrJ3ESRiApE55FmjsuwpWSRwoNcTitzD2z1PI16
         oH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5aERNl/uNqYh02ESgTURdo0rA065xugBXJODGpYH+ls=;
        b=AOoVUYI/lPWGhrxkJ/gK2LVzCix5Vdt+XckgHDLwsDuQzZs/PmyFoaqJNARvx0P4Bb
         /v10pJ8n0YPj5nwguowdgrgkpuE3HNBemdTrmw+wMtaSyH7mgTq30QTkz8IcI+b0OMPi
         Nz67AgIDpXRnqqQ6EuuC1I6bIburSQAmLNC8v9VX++TMPG29WiSp4mMS2Qw+CD5e3668
         SqVl0IM9iD+ZkAiDFqYOXBOZhKS6ntVtRdIlfQ1HQfpVtP+/GRVTXyupJU9WiU92mJj/
         FwEuMfMPeENkyl9lWtGS553P5M5eO0sfet/387GWZGTYMnPHtDj0RGau4AgpismWBjvu
         UUVQ==
X-Gm-Message-State: APjAAAUPEyNmw9MMvyBBhh2AGYwICgZ27AjKMIXhzuANx2PwnePWIXIY
        1j9L0avO3yJWl0Zkmbe0yJ4=
X-Google-Smtp-Source: APXvYqzcsdSOEf8qEjl6dzOoTY/OT4L+MsLmTmyNXMNYHiD2w5UlGKv6Woq7UzbkWYCFxWm1Vcfj/Q==
X-Received: by 2002:a05:620a:16ba:: with SMTP id s26mr7642478qkj.107.1574341478247;
        Thu, 21 Nov 2019 05:04:38 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l12sm111788qtf.93.2019.11.21.05.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:04:37 -0800 (PST)
Subject: Re: [PATCH v5 04/17] sparse-checkout: 'set' subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <7d9d66a89f473244af3601e13caa713d929a202d.1571666186.git.gitgitgadget@gmail.com>
 <20191119154640.GG23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <64b230d4-d36f-5d92-7570-6d965db471a5@gmail.com>
Date:   Thu, 21 Nov 2019 08:04:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191119154640.GG23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2019 10:46 AM, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:13PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The 'git sparse-checkout set' subcommand takes a list of patterns
>> as arguments and writes them to the sparse-checkout file. Then, it
>> updates the working directory using 'git read-tree -mu HEAD'.
>>
>> The 'set' subcommand will replace the entire contents of the
>> sparse-checkout file. The write_patterns_and_update() method is
>> extracted from cmd_sparse_checkout() to make it easier to implement
>> 'add' and/or 'remove' subcommands in the future.
> 
> Yeah, an 'add' subcommand would be great, because 'set' throwing away
> all the existing patterns can lead to some frustration:

I plan to extend this feature when this series lands.

> Having said that, being forced to use 'git sparse-checkout set' and
> specify all patterns at once does have its own benefits: I needed like
> 6 subdirectories to build that subset of a big project that I was
> interested in, and now all the necessary patterns are saved in my Bash
> history, and I will be able to easily dig out the complete command in
> the future.  That wouldn't work with using the 'add' subcommand to add
> one pattern at a time.

In general, this "set" command is created first because tools can interact
with it more easily than "add" and "remove". Users would probably prefer the
"add" and "remove" way to interact.
 
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index cb74715ca6..bf2dc55bb1 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -96,4 +96,36 @@ test_expect_success 'clone --sparse' '
>>  	test_cmp expect dir
>>  '
>>  
>> +test_expect_success 'set enables config' '
>> +	git init empty-config &&
>> +	(
>> +		cd empty-config &&
>> +		test_commit test file &&
>> +		test_path_is_missing .git/config.worktree &&
>> +		test_must_fail git sparse-checkout set nothing &&
> 
> This command prints the same error message twice:
> 
>   + test_must_fail git sparse-checkout set nothing
>   error: Sparse checkout leaves no entry on working directory
>   error: Sparse checkout leaves no entry on working directory

At this commit, I do not see two identical lines, but instead the second
line says

	error: failed to update index with new sparse-checkout paths

(that "paths" should probably be "patterns")

Thanks,
-Stolee
