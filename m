Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBEC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiBVSyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiBVSyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:18 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A540C114FE6
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:51 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CA1BF3F4859;
        Tue, 22 Feb 2022 13:53:50 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 823993F4854;
        Tue, 22 Feb 2022 13:53:50 -0500 (EST)
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <37f54cd9-3e53-7d38-2c23-2fc245dc1132@jeffhostetler.com>
Date:   Tue, 22 Feb 2022 13:53:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/17/22 11:06 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> Here is V5 of Part 2 of my Builtin FSMonitor series. I apologize for the
>> delay since V4 that I submitted back in October. (Insert the usual $DayJob
>> excuse...)
>>
>> I have rebased this branch onto the current "master" branch.
> 
> Thank you for your tireless work on this. I do see that it requires a ton
> of effort on your part and just wanted to let you know that I appreciate
> it very much!
> 
>> In this version I removed the core.useBuiltinFSMonitor config setting and
>> instead extended the existing core.fsmonitor.
> 
> I am somewhat surprised that a reviewer suggested this, as it breaks the
> common paradigm we use to allow using several Git versions on the same
> worktree.
> 
> Imagine, for example, that you run a Git version that understands
> `core.fsmonitor=true` to imply the built-in FSMonitor, while you _also_
> use an IDE that bundles a slightly older Git version that mistakes the
> `true` for meaning the executable `true` (which is not a FSMonitor at all,
> but its exit code suggests that everything's fine and dandy). The result
> would be that the IDE does not see _any_ updates anymore, but nothing
> would suggest that anything is wrong.
> 
> We can probably warn users about this, and we can also work around the
> fact that Git for Windows already uses `core.useBuiltinFSMonitor`, but it
> makes me somewhat uneasy nevertheless.
> 
> Thank you,
> Dscho
> 

This is a valid concern and I should have thought to mention it when
the suggestion came up on the list.  Yes, extending `core.fsmonitor` to
take a boolean or a path could confuse older clients (like ones bundled
with an IDE, like VS).

My assumption was that since we shipped `core.useBuiltinFSMonitor`
in GFW with an experimental label, that normal users would not be
using it at all and especially not from their IDEs, so it wouldn't
matter.  And experimental features are just that -- experimental
and subject to change.

But your point is valid -- if someone does have the odd hook called
"true" or "1", they'll get an unexpected result.

Jeff



