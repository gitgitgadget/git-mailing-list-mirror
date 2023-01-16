Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4ADC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 14:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjAPO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjAPO2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 09:28:09 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37E429E32
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 06:11:15 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id AF1172600E1;
        Mon, 16 Jan 2023 15:10:40 +0100 (CET)
Message-ID: <31a33eac-5f1b-969a-6e34-2fc18e989293@selasky.org>
Date:   Mon, 16 Jan 2023 15:10:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     rsbecker@nexbridge.com,
        =?UTF-8?B?J01pY2hhbCBTdWNow6FuZWsn?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org, wrights@alrajhibank.com.sa
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <20230115135245.GB16547@kitsune.suse.cz>
 <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org>
 <20230116091346.GC16547@kitsune.suse.cz>
 <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
 <017801d929a6$6f8271b0$4e875510$@nexbridge.com>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <017801d929a6$6f8271b0$4e875510$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/16/23 13:31, rsbecker@nexbridge.com wrote:
> On January 16, 2023 4:56 AM, Hans Petter Selasky wrote:
>> On 1/16/23 10:13, Michal Suchánek wrote:
>>> when that data is copied to a new location a new CRC is calculated
>>> that can detect an error in that location.
>>
>> Yes, that is correct, but what is "copying data"? Are you saying that copying data is
>> always error free?
> 
> Not in all possible computing devices, no. But in certain high-reliability and mission critical systems, there are parity checks and communication mechanisms that verify the integrity of data transfers memory-to-memory, memory-to-register, and over inter-CPU bus, and memory-to-disk-storage checks. The result of a corruption on one of my systems would result in a CPU halt rather than blindly accepting the result, taking the faulty processor offline until the cause is investigated and then reloaded or repaired. This applies to any component, including disks, CLIMs, DMA, and anything else in the architecture.
> 

Hi,

I doesn't matter if the system is high-reliability or not. The problem 
is exactly the same.

If you have a CPU register which you add to another CPU register, then 
you need to recompute the parity information on the destination CPU 
register. That basically means you always trust the output of the CPU 
adder. There is simply no relationship between input parity and output 
parity in the linear adder case.

Whenever "parity" information is lost, it opens up the possiblity of 
irrecoverable errors.

That's why I say, that GIT would be better of in that regard with an 
end-to-end, CRC parity mechanism.

--HPS
