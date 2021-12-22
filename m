Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F2C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbhLVQcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 11:32:16 -0500
Received: from siwi.pair.com ([209.68.5.199]:51993 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241913AbhLVQcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 11:32:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C8E9D3F4163;
        Wed, 22 Dec 2021 11:32:14 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9B33A3F4143;
        Wed, 22 Dec 2021 11:32:14 -0500 (EST)
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
 <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
 <289f525b-93b8-6f33-e0fc-3b24fa8a54ea@jeffhostetler.com>
 <211220.86ilvjt5y8.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5d8f9882-fca7-ccfd-7430-d73a856cad39@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 11:32:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.86ilvjt5y8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 2:35 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler wrote:
> 
>> On 12/20/21 11:31 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>
>>
>> Yes, it was.  To me a "const char *" in a structure means that
>> the structure does not own the pointer and must not free it.
>> Whereas as "char *" means that the structure might own it and
>> should maybe free it when the structure is freed.  My usage here
>> is that the structure does own it (because it took it from the
>> temporary strbuf using strbuf_detach()) and so it must free it.
>> Therefore it should not be "const".  This has nothing to do with
>> whether or not we allow the thread name to be changed after the
>> fact.  (We don't, but that is a different issue).
> 
> We use the pattern of having a "const char *" that's really a "char *"
> with a cast to free() in many existing APIs for this scenario.


As I mention later in this thread, I'm going to convert the
field into a flex-array, so most of the discussion in this
part of the thread no longer applies.

