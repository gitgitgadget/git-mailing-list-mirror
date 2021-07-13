Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0554CC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1A6610A6
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbhGMPs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:48:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:55226 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236932AbhGMPs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 11:48:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 90CEF3F40B7;
        Tue, 13 Jul 2021 11:46:06 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 538DC3F4096;
        Tue, 13 Jul 2021 11:46:06 -0400 (EDT)
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
 <87k0m9bpmv.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b19f3f2a-049f-acf2-f59e-de705dc54307@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 11:46:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87k0m9bpmv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 7:02 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach the win32 backend to register a watch on the working tree
>> root directory (recursively).  Also watch the <gitdir> if it is
>> not inside the working tree.  And to collect path change notifications
>> into batches and publish.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++
> 
> <bikeshed mode> Spying on the early history of this (looking for the
> Linux backend) I saw that at some point we had just
> compat/fsmonitor/linux.c, and presumably some of
> compat/fsmonitor/{windows,win32,macos,darwin}.c.
> 
> At some point those filenames became much much longer.
> 

Once upon a time having "foo/bar/win32.c" and "abc/def/win32.c"
would cause confusion in the debugger (I've long since forgotten
which).  Breaking at win32.c:30 was no longer unique.

Also, if the Makefile sends all .o's to the root directory or a
unified OBJS directory rather than to the subdir containing the .c,
then we have another issue during linking...

So, having been burned too many times, I prefer to make source
filenames unique when possible.


> I've noticed you tend to prefer really long file and function names,
> e.g. your borrowed daemonize() became
> spawn_background_fsmonitor_daemon(), I think aiming for shorter
> filenames & function names helps, e.g. these long names widen diffstats,
> and many people who hack on the code stick religiously to 80 character
> width terminals.
> 

I prefer self-documenting code.

Jeff
