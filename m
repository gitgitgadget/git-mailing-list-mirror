Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83529C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiCVOMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiCVOMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 10:12:19 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048755E14C
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 07:10:50 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 22AB83F4823;
        Tue, 22 Mar 2022 10:10:50 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C86973F481C;
        Tue, 22 Mar 2022 10:10:49 -0400 (EDT)
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
To:     rsbecker@nexbridge.com,
        =?UTF-8?Q?=27Torsten_B=c3=b6gershausen=27?= <tboegi@web.de>,
        'Jeff Hostetler via GitGitGadget' <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, 'Derrick Stolee' <derrickstolee@github.com>,
        '??var Arnfj??r?? Bjarmason' <avarab@gmail.com>,
        'Jeff Hostetler' <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <20220313104230.ctwbskywcq5jxv36@tb-raspi4>
 <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com>
 <060401d83d79$f2540780$d6fc1680$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e8ab7689-f6eb-9fda-e7aa-87fc2c4ee601@jeffhostetler.com>
Date:   Tue, 22 Mar 2022 10:10:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <060401d83d79$f2540780$d6fc1680$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/21/22 7:18 PM, rsbecker@nexbridge.com wrote:
> On March 21, 2022 6:06 PM, Jeff Hostetler wrote:
>> On 3/13/22 6:42 AM, Torsten Bögershausen wrote:
>>> Hej Jeff,
>>>
[...]
>>
>> It looks like the ...Cloned bit was added to the SDK in 10.13 [1].
>> All the other bits were defined sometime between 10.5 and 10.10.
>>
>> I'll add something in V7 to guard that bit.  I think 10.10 is old enough that we don't
>> need to special case those bits too.
> 
> I realize it is a bit late in the game, but would you consider a pre-hook and post-hook that automatically run with fsmonitor kicks off/terminates. I am thinking about use cases where this is integrated into more complex processes and it would be nice to have notifications of what fsmonitor is doing and when.
> 
> Thanks,
> Randall
> 

I hadn't really considered having a pre/post hook for the daemon.
I'm not opposed to it; I just hadn't thought about it.

By this I assume you mean something inside the fsmonitor--daemon
process that invokes the hooks when it is starting/stopping.
As opposed to something in a client command (like status) before
it implicitly started a daemon process.  The latter method would
not give you post-hook events because the daemon usually outlives
the client command.

Perhaps you could elaborate on what you would use these hooks for
or how they would be helpful.  It would be easy to add pre/post
hooks in the main thread of the daemon.  However, I worry about
the prehook slowing the startup of the daemon -- since the client
status command might be waiting for it to become ready.  I also
have a "health" thread in part3 that would be a candidate for
pre/post and any other periodic hooks that might be useful.
But again, before I suggest a design for this, it would be good
to know what kind of things you would want to do with them.

Jeff
