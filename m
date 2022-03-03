Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02BBC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 18:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiCCSA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCCSA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 13:00:56 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70016194A95
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 10:00:10 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BC55A3F4A9E;
        Thu,  3 Mar 2022 13:00:09 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 905563F4A9D;
        Thu,  3 Mar 2022 13:00:09 -0500 (EST)
Subject: Re: [PATCH 19/23] fsm-health-win32: force shutdown daemon if worktree
 root moves
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <023fcd6e2b1163ab3d23b0d5933c14586d814ce0.1644940774.git.gitgitgadget@gmail.com>
 <c0d69427-aee1-7341-5b5f-1fe44ee0542d@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2812e2af-4a63-09ae-89c9-bab8fb487100@jeffhostetler.com>
Date:   Thu, 3 Mar 2022 13:00:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c0d69427-aee1-7341-5b5f-1fe44ee0542d@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 11:09 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
>> index 3c3453369cd..2526ad9194f 100644
>> --- a/compat/fsmonitor/fsm-health-win32.c
>> +++ b/compat/fsmonitor/fsm-health-win32.c
>> @@ -14,7 +14,10 @@ enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
>>   typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
>>   			  enum interval_fn_ctx ctx);
>>   
>> +static interval_fn has_worktree_moved;
>> +
>>   static interval_fn *table[] = {
>> +	has_worktree_moved,
>>   	NULL, /* must be last */
>>   };
> 
> Looking at this now, I think table[] should be defined immediately
> before fsm_health__loop() so it is easier to see how they interact.
> It also avoids this static declaration of the function before its
> implementation.
> 
> Or, is there a reason it is so high up in the file?

I don't think so.  I was trying to keep all of the public API
routines at the bottom, but all of the static stuff is pretty
much free to move around.

I'll revisit.

Thanks
Jeff
