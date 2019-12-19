Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868AC2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC1324672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLSSDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:03:24 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:43956 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfLSSDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:03:24 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ii08u-0002Bb-BV; Thu, 19 Dec 2019 19:03:20 +0100
Subject: Re: [PATCH 1/5] parse_branchname_arg(): fix dash_dash_pos, drop
 argcount
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
 <771947d01f759a72b9f8999e929bf1f7765327aa.1574969538.git.gitgitgadget@gmail.com>
 <xmqqk16tea9u.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <807d4e5c-89b9-298b-c022-08d330fbd3c9@syntevo.com>
Date:   Thu, 19 Dec 2019 19:03:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqk16tea9u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for having a look at my patches!

On 18.12.2019 19:52, Junio C Hamano wrote:
>> Simplify the code by dropping `argcount` and useless `argc` / `argv`
>> manipulations.
> 
> I am not sure if this is a good change, though.  It goes against the
> reasoning that makes the above "dash-dash-pos" change is a good one,
> doesn't it?  When the code changes over time, wouldn't it make the
> code more clear to keep track of the count of args it saw in a
> separate variable, than relying on the invariant that currently
> happens to hold which is "if dash-dash is after the first argument,
> return 2 and otherwise return 1"?

My bad that I forgot to write a detailed explanation for that. In V3 in 
other topic [2] I have separated this change as a separate commit with a 
good message.

>> +	if (opts->accept_pathspec) {
>> +	    if (dash_dash_pos == 0)
>> +		    return 1; /* case (2) */
>> +	    else if (dash_dash_pos == 1)
>> +		    has_dash_dash = 1; /* case (3) or (1) */
>> +	    else if (dash_dash_pos >= 2)
>> +		    die(_("only one reference expected, %d given."), dash_dash_pos);
> 
> Non-standard indentation?  In our code, a level of indent is another
> horizontal tab.

Sorry, my Visual Studio was acting up again. It's doing pretty weird 
things when I have tab size 4 (due to other projects), which is 
overridden by git repo settings to 8.

Fixed it in V3 in other topic [2]

----
[1] Commit 09ebad6f ("checkout: split off a function to peel away 
branchname arg", 2011-02-08)
[2] 
https://lore.kernel.org/git/pull.490.v3.git.1576778515.gitgitgadget@gmail.com/
