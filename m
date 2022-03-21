Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5D6C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiCUXZo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Mar 2022 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiCUXYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:24:41 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A44D365496
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:18:22 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22LNIGSA091416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Mar 2022 19:18:16 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>,
        "'Jeff Hostetler via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>,
        "'Derrick Stolee'" <derrickstolee@github.com>,
        "'??var Arnfj??r?? Bjarmason'" <avarab@gmail.com>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com> <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com> <20220313104230.ctwbskywcq5jxv36@tb-raspi4> <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com>
In-Reply-To: <2bb125d3-cef7-9d47-efa8-61a1aaba5316@jeffhostetler.com>
Subject: RE: [PATCH v2 00/27] Builtin FSMonitor Part 3
Date:   Mon, 21 Mar 2022 19:18:11 -0400
Organization: Nexbridge Inc.
Message-ID: <060401d83d79$f2540780$d6fc1680$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ2rBg+5tIrWhYVzRXa2ZIa9fwxqAIsp5+cAs2ZmAcCmA0zmatRCKtg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 21, 2022 6:06 PM, Jeff Hostetler wrote:
>On 3/13/22 6:42 AM, Torsten Bögershausen wrote:
>> Hej Jeff,
>>
>> I tried your patch on both a newer Mac and an older machine (with
>> HFS+) The older machine doesn't have kFSEventStreamEventFlagItemCloned
>> As it is an enum, and not a #define, I ended up here:
>>
>>    diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-
>listen-darwin.c
>>    index 3332d3b779..fa172a05c4 100644
>>    --- a/compat/fsmonitor/fsm-listen-darwin.c
>>    +++ b/compat/fsmonitor/fsm-listen-darwin.c
>>    @@ -169,8 +169,6 @@ static void log_flags_set(const char *path, const
>FSEventStreamEventFlags flag)
>>                    strbuf_addstr(&msg, "ItemXattrMod|");
>>            if (flag & kFSEventStreamEventFlagOwnEvent)
>>                    strbuf_addstr(&msg, "OwnEvent|");
>>    -       if (flag & kFSEventStreamEventFlagItemCloned)
>>    -               strbuf_addstr(&msg, "ItemCloned|");
>>
>>            trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
>>                             path, flag, msg.buf);
>>    @@ -221,8 +219,7 @@ static int ef_ignore_xattr(const
>FSEventStreamEventFlags ef)
>>                    kFSEventStreamEventFlagItemModified |
>>                    kFSEventStreamEventFlagItemRemoved |
>>                    kFSEventStreamEventFlagItemRenamed |
>>    -               kFSEventStreamEventFlagItemXattrMod |
>>    -               kFSEventStreamEventFlagItemCloned;
>>    +               kFSEventStreamEventFlagItemXattrMod ;
>
>It looks like the ...Cloned bit was added to the SDK in 10.13 [1].
>All the other bits were defined sometime between 10.5 and 10.10.
>
>I'll add something in V7 to guard that bit.  I think 10.10 is old enough that we don't
>need to special case those bits too.

I realize it is a bit late in the game, but would you consider a pre-hook and post-hook that automatically run with fsmonitor kicks off/terminates. I am thinking about use cases where this is integrated into more complex processes and it would be nice to have notifications of what fsmonitor is doing and when.

Thanks,
Randall

