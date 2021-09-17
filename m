Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235EAC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0714761108
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhIQQxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:53:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:23848 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhIQQxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:53:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 906A43F4096;
        Fri, 17 Sep 2021 12:52:28 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b109:12e8:cc1c:b3d3:708a:a5be])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2FB4D3F4095;
        Fri, 17 Sep 2021 12:52:28 -0400 (EDT)
Subject: Re: [PATCH 2/7] simple-ipc: preparations for supporting binary
 messages.
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <7182419f6dfa49d4d8415736943c72a575ab6753.1631738177.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qbyBrCDcJgg7=DezWGfZhyAR=YuC=vbxd38B4WA=Xw@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d4c2c8f4-828a-47ca-0e8e-ca82f644f7eb@jeffhostetler.com>
Date:   Fri, 17 Sep 2021 12:52:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQ0qbyBrCDcJgg7=DezWGfZhyAR=YuC=vbxd38B4WA=Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/21 4:43 PM, Eric Sunshine wrote:
> On Wed, Sep 15, 2021 at 4:36 PM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add `command_len` argument to the Simple IPC API.
>>
>> In my original Simple IPC API, I assumed that the request
>> would always be a null-terminated string of text characters.
>> The command arg was just a `const char *`.
>>
>> I found a caller that would like to pass a binary command
>> to the daemon, so I want to ammend the Simple IPC API to
> 
> s/ammend/amend/
> 
>> take `const char *command, size_t command_len` and pass
>> that to the daemon.  (Really, the first arg should just be
>> a `void *` or `const unsigned byte *` to make that clearer.)
> 
> The reader is left wondering why you didn't also change it to `const
> void *` (or one of the other choices) while at it.
> 

The simple ipc layer just passes the buffer to the pkt-line layer
and it takes a "const char *", so to avoid confusion I just left
the type is it was.  If later we want to fix pkt-line, we can
investigate passing a "const unsigned byte *" value down the
call chain, but that is more than I want to do right now.

>> Note, the response side has always been a `struct strbuf`
>> which includes the buffer and length, so we already support
>> returning a binary answer.  (Yes, it feels a little weird
>> returning a binary buffer in a `strbuf`, but it works.)
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
