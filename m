Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2848C43381
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C4022CA1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405577AbhARSYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407522AbhARSYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:24:53 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14021C061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:24:13 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so1997836qtv.6
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I/7JCawOqLSlg/WXDqd7IOImZBRtQkammLx2co1/T2I=;
        b=Vs/+Xhake1jPTRM6jMi9oKV7rlxQfWLepEQM65yFSJdvq9EFP2i8QMxJFGIXu9TQX/
         +WDI2co26SMNPgAnMMgBj9sflZlyJY+Htv/EoA9fuT8xusMcPAHXpt+WSOwwt4nYM+y3
         /UYcFSoniDChSQYNM7mHFDxb54GHo2jdmSH8CEQJN/YYN8NxZeXA/GAMmsi4ft9/fVN6
         IPFHN3JtCddZ2FIBfNsmC8RI5RbIV6fJ2GaB7gEc3AjmcHWFhlJCFBGRHBc2+PBp+x+p
         fALCNwJpLTbAqopPxfZKYvWuukOmTIZdGVKGaJfYDXS8/rZx66L7PADz2WzKcFzDREAj
         h8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/7JCawOqLSlg/WXDqd7IOImZBRtQkammLx2co1/T2I=;
        b=dBQNR9IBJeeXoxtjBZIMbGesfUCUfIB5WDH4a+hEN8zovKRdpbX5CH6AsjAZbp+wgy
         XQ/JbvgSxs07p51wKGZop8fKx8vRLvDy/t2JmxfkUcLjYgRQc8nwRuc3jgzoBEag6fya
         lbbXkvNuBJTRaXbFyGl8qdj+jP784KDtYkBpvBk+XX58ddSABeL4Garagll2K5CwYWzW
         /LwPikP2mKHy+BQXBty1gd/lU8a0i7k8Dg1saGuxfCrf/miQBokwL6Zxl2huqUi9cScx
         U9mb38gW4Gh7mcX3FXo++uNTrmDkUHulF6riQf24n1AcJkE5x2mvHCNYCNU317i1WzPl
         kdig==
X-Gm-Message-State: AOAM531dlEho9hFN4IMXb0/6/SzLAqSr4jkISanz61+tvijipXYaIYu4
        taZ6zTfVjXDPRxA/n5A120E=
X-Google-Smtp-Source: ABdhPJx/jjaYSgDP/XAK7GmSmb+CRK5dVroqcWnT55R18kqcq5X1APoB/cRopDq4DjjCxdtfXwq4gw==
X-Received: by 2002:ac8:5193:: with SMTP id c19mr830493qtn.205.1610994252187;
        Mon, 18 Jan 2021 10:24:12 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1583:40fe:1fef:8885? ([2600:1700:e72:80a0:1583:40fe:1fef:8885])
        by smtp.gmail.com with UTF8SMTPSA id b65sm10950917qkg.75.2021.01.18.10.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:24:11 -0800 (PST)
Subject: Re: [PATCH 2/2] t7900: clean up some broken refs
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
 <616b73a6556824fb94753cfcc62bf01d36b8b311.1610940216.git.gitgitgadget@gmail.com>
 <YAWxh8O/XlxIfcv3@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c6e486cc-11f7-5e10-50fd-5023f4ea086a@gmail.com>
Date:   Mon, 18 Jan 2021 13:24:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YAWxh8O/XlxIfcv3@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/2021 11:04 AM, Taylor Blau wrote:
> On Mon, Jan 18, 2021 at 03:23:36AM +0000, Derrick Stolee via GitGitGadget wrote:
>> This only shows up if you run the tests verbosely and watch the output.
>> It caught my eye and I _thought_ that there was a bug where 'git gc' or
>> 'git repack' wouldn't check 'refs/prefetch/' before pruning objects.
>> That is incorrect. Those commands do handle 'refs/prefetch/' correctly.
> 
> Do you think it would be worth checking that 'does not point to a valid
> object' doesn't appear in the output?

Perhaps, but I think this isn't an actually interesting behavior
to test. It's really the test that was broken, not Git itself.

>> All that is left is to clean up the tests in t7900-maintenance.sh to
>> remove these tags and refs that are not being repacked for the
>> incremental-repack tests.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  t/t7900-maintenance.sh | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index f9031cbb44b..6be9d42767a 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -256,6 +256,11 @@ test_expect_success 'incremental-repack task' '
>>  	HEAD
>>  	^HEAD~1
>>  	EOF
>> +
>> +	# Replace the object directory with this pack layout.
>> +	# However, it does not include all objects from the remotes.
>> +	rm -rf .git/refs/prefetch &&
>> +	rm -rf .git/refs/tags &&
> 
> Hmm. Makes sense, but this will certainly need to be updated to work
> with reftables, and it would break if you ran 'git pack-refs'.
> 
> Perhaps instead:
> 
>   git for-each-ref --format='delete %(refname)' \
>     refs/prefetch refs/tags >refs &&
>   git update-ref --stdin <refs

Deleting refs in a clean way is probably good to do.
I'm guessing you didn't use a pipe because it can be
hard to diagnose a failure in the chain? That's
probably reasonable.

Thanks,
-Stolee
