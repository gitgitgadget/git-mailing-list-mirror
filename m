Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261AC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49037610FC
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhHBPXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:23:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:20995 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235068AbhHBPXp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 11:23:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3F8EE3F40E4;
        Mon,  2 Aug 2021 11:23:34 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 14E8B3F404F;
        Mon,  2 Aug 2021 11:23:34 -0400 (EDT)
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
 <87o8agp29o.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <48a62d5e-28e2-7103-a5bb-5db7e197a4b9@jeffhostetler.com>
Date:   Mon, 2 Aug 2021 11:23:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87o8agp29o.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/2/21 6:22 AM, Ævar Arnfjörð Bjarmason wrote:
...
> 
> If anything the existing Windows version seems a bit unweildy, having to
> apparently deal with cycles etc., I don't think that happens under
> procfs, but maybe I'm missing some special-case.
> 

It's been a while since I did the parent lookup on Windows, but...

Yes, on Windows we observed cases where a PID would be recycled
and a child process could have the same PID as an ancient ancestor
that had long since exited.

I don't think the cycle problem exists on Unix because IIRC a
child process' parent-PID is set to Init when the parent exits.

Windows does not update the child's parent-PID when the parent
exits, so if a recently-used PID is given to one of our child
processes, we can get a loop.

Jeff
