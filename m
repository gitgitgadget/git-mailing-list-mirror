Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF8C6FA85
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 14:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiIBOCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238807AbiIBOBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 10:01:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05287153D37
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 06:32:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 62so1599495iov.5
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1UynP8dtT9wEZWISHtm13jluTfoX5bi12JUEWYjgrxM=;
        b=YJXYYZvAaxE1GWBQ7FkmCzAZXT2ZtdvoeVcyCwpbCq0Kn8GvzJtGkmu2u2npWc2ThQ
         GtdI060RJ66jhi8fnwjc2pdWAR0iOaNql8nAkTM9HFo9E3vdN9eRdbdOLYvgajUhB5zN
         gmOvGHhXWopxVDYygmKSyZkWjtJ/GUJii/E0M8LT1CKMOKZh0a+siZKPF1qfBRa04KHX
         xwCu8rvCRW1sUZaCoj1mtPP72UdJojJ7Ak6PXFknR8BzNCrL/oUK61xaYDJWXToIugyH
         x37GSceZziFaCm+WvXgXlqLa4yXCw+cK122LH7Ka4seqSKWceiweU8Xf/C/V0ZacZF3o
         f+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1UynP8dtT9wEZWISHtm13jluTfoX5bi12JUEWYjgrxM=;
        b=feYheTdV6IcU9u/7Ka1iVXA4yzX6ZCGL/jBwjOlc/QLgzs7aSjrRG01u2TyFG20ji+
         CnKF73SLf/DRqcIBc6K1LVALaTBXLFqCd9IdaTNBSCUuwzSHxNl4yU5VZtR0vla8UFyb
         4J5eWUCtfvBaD5kbHdQVms7SSopQaOS7NUlAgvhJblJAPBrzjaqAaqL4sXqGaYhW01Ij
         qCgYzD46xkx4P0NlAolTQRpMOHJWvRUPeSXRPHVv9yoSs3fjCJMBF73D3qX/BqRsddfi
         CPyM2DoTNUH8XBAn36O+jrt2kKh2Ml6SVhkUVD/S+UoC+himsQMxQTXRp9nfnqXH74f8
         oDBg==
X-Gm-Message-State: ACgBeo0lOB//6IwNxh/Coot0otpV+t1ZcJLz/41geCxMfB7IWfuQuCDo
        TXCySJF74LqTp0cyGUAfanpasO1+g0Ny
X-Google-Smtp-Source: AA6agR61ZFkMK4rHUMta624YwyH615taNS6PwskHYuzyGNslqTcak9zPIGcqaLp3OA8KtWQOes0WPQ==
X-Received: by 2002:a05:6638:3805:b0:349:ffd0:9a86 with SMTP id i5-20020a056638380500b00349ffd09a86mr19227787jav.227.1662125524426;
        Fri, 02 Sep 2022 06:32:04 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p7-20020a056e0206c700b002e900a19516sm828793ils.38.2022.09.02.06.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 06:32:04 -0700 (PDT)
Message-ID: <8dea9ffe-d03b-f838-6cc5-db0de5024d9f@github.com>
Date:   Fri, 2 Sep 2022 09:32:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] unpack-trees: fix sparse directory recursion check
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     shaoxuan.yuan02@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 5:02 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Ensure 'is_sparse_directory_entry()' receives a valid 'name_entry *' if one
> exists in the list of tree(s) being unpacked in 'unpack_callback()'.
> 
> Currently, 'is_sparse_directory_entry()' is called with the first
> 'name_entry' in the 'names' list of entries on 'unpack_callback()'. However,
> this entry may be empty even when other elements of 'names' are not (such as
> when switching from an orphan branch back to a "normal" branch). As a
> result, 'is_sparse_directory_entry()' could incorrectly indicate that a
> sparse directory is *not* actually sparse because the name of the index
> entry does not match the (empty) 'name_entry' path.

Thank you for finding the root cause here. It was very non-obvious!

> +test_expect_success 'checkout orphan then non-orphan' '
> +	init_repos &&
> +
> +	test_all_match git checkout --orphan test-orphan &&
> +	test_all_match git status --porcelain=v2 &&
> +	test_all_match git checkout base &&
> +	test_all_match git status --porcelain=v2
> +'
> +

This test demonstrates how specific the case needs to be for this to
actually happen.

Could it also happen if we are going from a commit without that
sparse directory and then to a commit with that sparse directory? I
think that would be a more common case, but I was unable to
manipulate the test repo in t1092 to trigger this bug in the existing
test cases.

This makes me think that this bug _is_ extremely rare, so we don't
need to rush this into a 2.37.4 or anything. It would be good to
bring it into 2.38.0-rc0, though.

Thanks!
-Stolee
