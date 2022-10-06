Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1CC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJFPpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiJFPpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 11:45:11 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81910562
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 08:45:06 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 441E6CA1246;
        Thu,  6 Oct 2022 11:45:05 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 095CDCC8324;
        Thu,  6 Oct 2022 11:45:04 -0400 (EDT)
Subject: Re: [PATCH 0/9] Trace2 timers and counters and some cleanup
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <221005.86tu4is9ib.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bb4137cb-ff59-cc4c-3d42-23f636758216@jeffhostetler.com>
Date:   Thu, 6 Oct 2022 11:45:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221005.86tu4is9ib.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/5/22 9:04 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 04 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> This patch series add stopwatch timers and global counters to the trace2
>> logging facility. It also does a little housecleaning.
>>
>> This is basically a rewrite of the series that I submitted back in December
>> 2021: [1] and [2]. Hopefully, it addresses all of the concerns raised back
>> then and does it in a way that avoids the issues that stalled that effort.
>>
>> First we start with a few housecleaning commits:
>>
>>   * The first 2 commits are unrelated to this effort, but were required to
>>     get the existing code to compile on my Mac with Clang 11.0.0 with
>>     DEVELOPER=1. Those can be dropped if there is a better way to do this.
> 
> This seems like a good thing to have, but there's no subsequent changes
> to those two files on this topic, so is this just a "to get it building
> on my laptop..." stashed-on?

Right. I needed them to get "main" to build on my laptop before I
started hacking.  I debated sending them in separately, but everyone
was busy with the 2.38 release and didn't want to add to the noise for
such a minor thing, since all the CI builds were green...

But, yeah, I can do that.

> 
> I think if so it makes sense to split these up, and as feeback on 1-2/9:
> Let's note what compiler/version & what warning we got, the details
> there for anyone to dig this up later are missing, i.e. if we ever want
> to remove the workaround syntax.
> 
>>   * The 3rd commit is in response a concern about using int rather than
>>     size_t for nr and alloc in an ALLOC_GROW() in existing trace2 code.
> 
> This small bit of cleanup also could perhaps be submitted separately?
> It's unclear (and I read the concern in the initial thread) if this is
> required by anything that follows.
> 

Nothing requires this. It was just another "while I'm here" fixup.
However, those lines are very close to new/changed lines that I added
for the timers and counters, so it would probably cause collisions if
sent independently.  So I'd like to leave them in this series to
simplify things.

Thanks,
Jeff
