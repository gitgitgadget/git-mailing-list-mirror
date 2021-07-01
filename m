Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ECBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103FE613FE
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhGAOXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:23:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:14689 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhGAOXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:23:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A9B243F40E4;
        Thu,  1 Jul 2021 10:20:30 -0400 (EDT)
Received: from HOLO-STUX-BVT04.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C80E3F4095;
        Thu,  1 Jul 2021 10:20:30 -0400 (EDT)
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
References: <xmqq4kdft122.fsf@gitster.g> <87r1gicfh1.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4d72a3d6-397e-e55b-cc11-5591070d5e27@jeffhostetler.com>
Date:   Thu, 1 Jul 2021 10:20:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87r1gicfh1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 30 2021, Junio C Hamano wrote:
> 
>> * jh/builtin-fsmonitor (2021-05-24) 30 commits
>>   - t/perf: avoid copying builtin fsmonitor files into test repo
>>   - t7527: test status with untracked-cache and fsmonitor--daemon
>>   - p7519: add fsmonitor--daemon
>>   - t7527: create test for fsmonitor--daemon
>>   - fsmonitor: force update index after large responses
>>   - fsmonitor: enhance existing comments
>>   - fsmonitor--daemon: use a cookie file to sync with file system
>>   - fsmonitor--daemon: periodically truncate list of modified files
>>   - fsmonitor--daemon: implement handle_client callback
>>   - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>>   - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>>   - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>>   - fsmonitor--daemon: create token-based changed path cache
>>   - fsmonitor--daemon: define token-ids
>>   - fsmonitor--daemon: add pathname classification
>>   - fsmonitor--daemon: implement daemon command options
>>   - fsmonitor-fs-listen-macos: stub in backend for MacOS
>>   - fsmonitor-fs-listen-win32: stub in backend for Windows
>>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>>   - fsmonitor--daemon: implement client command options
>>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>>   - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
>>   - config: FSMonitor is repository-specific
>>   - help: include fsmonitor--daemon feature flag in version info
>>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>>   - fsmonitor--daemon: update fsmonitor documentation
>>   - fsmonitor--daemon: man page
>>   - simple-ipc: preparations for supporting binary messages.
>>   - Merge branch 'jk/perf-in-worktrees' into HEAD
>>   - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
>>
>>   An attempt to write and ship with a watchman equivalent tailored
>>   for our use.
>>
>>   What's the status of this one?
> 
> I think Johannes's reply to the last WC applies[1]:
> 
>      I am not Jeff, but I know that he is busy getting back to it, and
>      plans on submitting a third iteration.
> 
> FWIW I'm still curious about some details on the performance concerns
> that seem to have prompted this built-in fsmonitor endeavor, as I asked
> about (but didn't get a reply to) in [2].
> 
> Not as a "we shouldn't have this, let's keep using the hook", but just
> curiosity about why we've seemingly gotten such different performance
> numbers on the watchman hook v.s. a built-in approach.
> 
> I suspect (but don't know) that the reason is that the built-in is
> perhaps integrating differently with git somehow, in a way that we could
> retrofit the hook approach to also do (if anyone still cares about the
> hook approach).
> 
> In any case I'm interested in *why* the new approach is faster, given
> that I've done some testing (again, noted in [2]) that suggest that
> bottleneck in the previous pipeline wasn't at all what Jeff H. thought
> it was.
> 
> 1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2106171135530.57@tvgsbejvaqbjf.bet/#t
> 2. https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/
> 

A quick reply here of Junio's question. Yes, I'm working on a V3
to submit (any day now -- $DAYJOB notwithstanding (read: meetings)).

I'll push this up and then try to answer the perf questions.

Thanks for your patience.
Jeff
