Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48547C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212042168B
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgBMTWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:22:50 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:20760 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgBMTWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 14:22:50 -0500
Received: from [84.175.183.167] (helo=[192.168.2.6])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j2K4U-0004J5-Li; Thu, 13 Feb 2020 20:22:46 +0100
Subject: Re: [PATCH] mingw: workaround for hangs when sending STDIN
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
 <CAPig+cQrxKuE=a99zPF7EGUSbye_s5ATEvUkz+EqsTZAfy_CbQ@mail.gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <b7bb3920-0400-df7f-0464-17d3a3583655@syntevo.com>
Date:   Thu, 13 Feb 2020 20:22:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQrxKuE=a99zPF7EGUSbye_s5ATEvUkz+EqsTZAfy_CbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.02.2020 19:56, Eric Sunshine wrote:
>>     clogged while it's trying to deal with 8MB of STDIN. Such deadlocks
>>     could  be defeated with writing less then pipe's buffer size per
> 
> s/then/than/
> 
>>     of pending reads. Therefore, if buffer is bigger then size of reads,
> 
> s/then/than/
> 
>> +test_expect_success 'stash handles large files' '
>> +       printf "%1023s\n%.0s" "x" {1..16384} >large_file.txt &&
>> +       git stash push --include-untracked -- large_file.txt
>> +'
> 
> Use of {1..16384} is not portable across shells. You should be able to
> achieve something similar by assigning a really large value to a shell
> variable and then echoing that value to "large_file.txt". Something
> like:
> 
>      x=0123456789
>      x=$x$x$x$x$x$x$x$x$x$x
>      x=$x$x$x$x$x$x$x$x$x$x
>      ...and so on...
>      echo $x >large_file.txt &&
> 
> or any other similar construct.

Thanks for having a look! I will address these in V2 next week.
