Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C6C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FBE61182
	for <git@archiver.kernel.org>; Mon,  3 May 2021 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhECR2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 13:28:46 -0400
Received: from siwi.pair.com ([209.68.5.199]:58857 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhECR2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 13:28:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 86E323F40D9;
        Mon,  3 May 2021 13:27:51 -0400 (EDT)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5C5083F4047;
        Mon,  3 May 2021 13:27:51 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: only enable it in non-bare repositories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.942.git.1619682362363.gitgitgadget@gmail.com>
 <87mttbx6ie.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <810dc60c-3730-b5f3-34f6-5cc2ddc9942a@jeffhostetler.com>
Date:   Mon, 3 May 2021 13:27:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87mttbx6ie.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/3/21 9:58 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 29 2021, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> The entire point of the FSMonitor is to monitor the worktree changes in
>> a more efficient manner than `lstat()`ing all worktree files every time
>> we refresh the index.
>>
>> But if there is no worktree, FSMonitor has nothing to monitor.
>>
>> So let's ignore if an FSMonitor is configured (e.g. in `~/.gitconfig`)
>> and we're running in a repository without worktree.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
...
>>
>> base-commit: 14d50074ff19e68e7a8d718b22d138882087bbc9
> 
> This is surely a correct fix for now, but wouldn't it in the future also
> be useful to run it in bare repositories e.g. to be able cache lookups
> for non-existing loose objects?
> 

No, the FSMonitor feature only expects data for paths within the
working directory.  (And is independent of whether the FS change
data is provided by my fsmonitor--daemon or provided by a hook-based
provider, such as Watchman.)  The FSMonitor feature uses that data to
shortcut scans of the working directory.

There is no interaction with the contents of the .git/objects
directory and I'm not sure how that would work.

Jeff





