Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911FFC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D05920836
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgBQSCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:02:01 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:34396 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgBQSCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 13:02:01 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j3kiU-0004Ku-BD; Mon, 17 Feb 2020 19:01:58 +0100
Subject: Re: [PATCH v2] mingw: workaround for hangs when sending STDIN
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
 <pull.553.v2.git.1581956750001.gitgitgadget@gmail.com>
 <CAPig+cQWMvBi4vkAFMjV7LWjKJudja08ZqVMNfLfALxbBfpzXg@mail.gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <11825e4b-c92c-d5ad-9a6f-5fa89d48862c@syntevo.com>
Date:   Mon, 17 Feb 2020 19:01:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQWMvBi4vkAFMjV7LWjKJudja08ZqVMNfLfALxbBfpzXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.02.2020 18:24, Eric Sunshine wrote:
>> +       x=0123456789abcde\n && # 16
> 
> Did you intend for the \n in this assignment to be a literal newline?
> Every shell with which I tested treats it instead as an escaped 'n'.

I'm such a novice shell script writer :(
Yes, I intended a newline.

> By the way, are the embedded newlines actually important to the test
> itself, or are they just for human consumption if the test fails?I
> ask because I was curious about how other tests create large files,
> and found that a mechanism similar to your original (but without the
> pitfalls) has been used. For instance, t1050-large.sh uses:
> 
>      printf "%2000000s" X >large1 &&
> 
> which is plenty portable and (presumably) doesn't have such demanding
> memory consumption.

They are not important to the test; the test only needs to internally 
have a 8+ mb patch.

This only comes from my feeling that super-large lines could cause other 
unexpected things, such as hitting various completely reasonable limits 
and/or causing unwanted slowdowns. Frankly, I didn't test.

Frankly, I already had concerns about adding the test. Now I have 
re-evaluated things and finally decided to move the test into commit 
message instead. With it, all compatibility etc questions are resolved.
