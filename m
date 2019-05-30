Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2451F462
	for <e@80x24.org>; Thu, 30 May 2019 20:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfE3Uay (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 16:30:54 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:8384 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfE3Uax (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 16:30:53 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id WRhLh9Ys6WIpcWRhLh8YSu; Thu, 30 May 2019 21:30:51 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=Fn3MSPI2BcvLVba--6EA:9 a=QEXdDO2ut3YA:10
Subject: Re: Request: git add --interactive: split hunk: When can't split
 further, split on empty lines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Harvey <jamespharvey20@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CA+X5Wn5bt-3zHUqtRDWtc0A82SFmWPuQ0+RvRLaAV6Vn24nf4g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905301644020.44@tvgsbejvaqbjf.bet>
 <aad93135-6280-ac6a-c72a-8a325fbbaf67@iee.org>
 <nycvar.QRO.7.76.6.1905302136400.44@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <fb5fd48d-c5fe-57dc-c307-c959ad132da6@iee.org>
Date:   Thu, 30 May 2019 21:30:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905302136400.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfEhKr7JIu0MYQu/kr214FYdgvYkJJi5xODUhr/KcARW3QES0Uv0zuwUjRU3OX75ZX0E7I35ILoiQGjc5oEPxklnOHCb+ckV05Gtverj/IQalLLu0Ft7h
 9+AOrkCXHXTaj27DsLwAZg/RTn+iRgYbcdrG1wmlgzOVUizRNDuQuiAnTag+IJlhMHIosMS2GppwvKVpOV6LQVC9mT5aHqCQAERGkMx4fbiocWOSi4qAB/fw
 AP6i7xVd/PeuoLAjgnZBuIKdf0Ux5CEa/hdNzeGPM8YIfQbYkdB2Ytm33ErFFtvrHbtpts9B5q1Yi3WyincqgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the clarification. Funny that we are "staging" the patch 
preparation to avoid real staging;-)

On 30/05/2019 20:43, Johannes Schindelin wrote:
> Hi Philip,
>
> On Thu, 30 May 2019, Philip Oakley wrote:
>
>> On 30/05/2019 15:53, Johannes Schindelin wrote:
>>> Having said that, there was a patch series recently to add the ability to
>>> stage individual lines,
>> I believe that the git-gui (in tk/tcl, but using git commands) was
>> already able to stage individual/selected lines, so there may be some
>> ideas from there.
> Sadly, no.
>
> There is one very big difference between Git GUI and `git add -p`: when
> you stage a line in Git GUI, it is staged *immediately*.
>
> When you stage a single line in the Git GUI, the diff you see in the
> window is reloaded. That is quite slow in the long run, and no fun.
>
> In contrast, `git add -p` does not stage *anything* until you're done
> selecting what you want to stage.
>
> Therefore, `git add -p` does have to do things quite a bit differently, as
> it will have to eventually build a single diff that is applied in one fell
> swoop, no matter how many lines you select individually.
>
> And naturally, there is also the difference between the user interfaces:
> while you can ask the user to select (part of) the line to stage in Git
> GUI via the mouse, that is not at all an option in `git add -p`.
>
> Likewise, the very convenient option to navigate via regular expressions
> in `git add -p` is not available in Git GUI at all.
>
> In short: I think that it makes more sense to come up with a design
> specific to `git add -p` and not get distracted by Tcl code that works
> quite differently.
>
> Ciao,
> Dscho

