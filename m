Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6DC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 21:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhLVV7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:59:21 -0500
Received: from siwi.pair.com ([209.68.5.199]:19223 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234030AbhLVV7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 16:59:20 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F21FA3F414A;
        Wed, 22 Dec 2021 16:59:19 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A1DCE3F4148;
        Wed, 22 Dec 2021 16:59:19 -0500 (EST)
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
 <xmqqlf0equs3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 16:59:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqlf0equs3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/21/21 2:30 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Defer freeing of the Trace2 thread CTX data until program exit.
>> Create a global list of thread CTX data to own the storage.
>>
>> TLS CTX data is allocated when a thread is created and associated
>> with that thread.  Previously, that storage was deleted when the
>> thread exited.  Now we simply disassociate the CTX data from the
>> thread when it exits and let the global CTX list manage the cleanup.
> 
> By the way, TLS CTX sounds embarrassingly close and confusing to
> some function that we may find in say openssl or some crypto stuff
> X-<.  Was there a strong reason to avoid calling these functions and
> types something like tr2_thread_ctx instead of tr2tls_thread_ctx?
> 

I hadn't really thought about the term "TLS" in the context
of crypto -- I had "thread local storage" on the brain.  I guess
I've spent too much of my youth using Win32 thread APIs. :-)

Let me take a look at removing those terms.

Jeff

