Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244CC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 12:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3123B6052B
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 12:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhG0MqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 08:46:19 -0400
Received: from siwi.pair.com ([209.68.5.199]:44513 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhG0MqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 08:46:18 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C8D833F40F3;
        Tue, 27 Jul 2021 08:46:17 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 636273F40E6;
        Tue, 27 Jul 2021 08:46:17 -0400 (EDT)
Subject: Re: [PATCH v3 12/34] fsmonitor-fs-listen-macos: stub in backend for
 MacOS
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <587580489473a7a2ad665bdf3c482ea5d2c54f61.1625150864.git.gitgitgadget@gmail.com>
 <87sg0xbq9v.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107161748050.59@tvgsbejvaqbjf.bet>
 <871r7yxkq8.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107262338320.55@tvgsbejvaqbjf.bet>
 <xmqqr1fkfyh3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <38c22648-df46-2464-0c04-347dedbd04c6@jeffhostetler.com>
Date:   Tue, 27 Jul 2021 08:46:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1fkfyh3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/26/21 7:26 PM, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hi Ævar,
>>
>> On Fri, 16 Jul 2021, Ævar Arnfjörð Bjarmason wrote:
>>
>>> On Fri, Jul 16 2021, Johannes Schindelin wrote:
>>>
...


I'm not sure that there is a "correct" answer here, but for the sake
of harmony, in V4 I'll set this to "darwin" and update the name of
the backend driver source file to match.  So that we are consistently
using 1 term throughout "Makefile" and "config.mak.uname".

	ifeq ($(uname_S),Darwin)
	...
		FSMONITOR_DAEMON_BACKEND = darwin
	endif



FWIW, I suspect that it is not worth the effort to directly set the
backend name from $(uname_S).  For example, on Windows we currently have
two different uname values depending on which compiler is being used.

	ifeq ($(uname_S),Windows)
	...
		FSMONITOR_DAEMON_BACKEND = win32
	endif

	ifneq (,$(findstring MINGW,$(uname_S)))
	...
		FSMONITOR_DAEMON_BACKEND = win32
	endif


Also, since the backend layer is highly platform-specific, it may be
a while (if ever) before we have universal coverage for all platforms.
Until then, we can simply set $FSMONITOR_DAEMON_BACKEND to a literal
value on a platform-by-platform basis as support is added.


Thanks,
Jeff
