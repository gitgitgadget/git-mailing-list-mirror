Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FFDC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845862467B
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLSRT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:19:27 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:25973 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSRT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:19:26 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ihzSM-0005kB-7q; Thu, 19 Dec 2019 18:19:22 +0100
Subject: Re: [PATCH v2 01/18] t7107, t7526: directly test
 parse_pathspec_file()
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
 <8d5fb9f40b8fc766ef022f910529e6308d9c2d80.1576511287.git.gitgitgadget@gmail.com>
 <xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <0cf9d6a8-f804-c828-28f5-e60089190167@syntevo.com>
Date:   Thu, 19 Dec 2019 18:19:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoatcn5u.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.2019 22:57, Junio C Hamano wrote:

>> In my previous patches, `parse_pathspec_file()` was tested indirectly by
>> invoking `git reset` and `git commit` with properly crafted inputs. This
>> has some disadvantages:
>> 1) A number of tests are copy&pasted for every command where
>>     `--pathspec-from-file` is supported. With just two commands, it
>>     wasn't too bad, but I'm going to extend support to many more
>>     commands, which would make a handful of low-value tests.
>> 2) Tests are located in suboptimal test packages
>> 3) Tests are indirect
> 
> That cuts both ways.  For a developer who is too narrowly focused
> (because s/he spent enough time staring at the code), testing the
> underlying machinery in a more direct way does feel attractive, but
> at the same time, what matters to the end users is how well the
> feature, when integrated into the commands they use (not the test
> scaffolding like the "test-parse-pathspec-file" command), works.
> 
> So "indirect" is not necessarily a bad thing.

I agree that it cuts both ways.

Just recently I had an (unrelated) discussion with Johannes Schindelin 
who forced me to drop 2 of 3 tests (where #3 also by chance covered #1 
#2) in some other PR, because too many tests is also evil.

To verify: I see 13 git commands that could benefit from 
--pathspec-from-file. There are 6 tests that in fact test underlying 
machinery, which can't be easily influenced by bugs in command's code. 
That makes 12*6 = 72 tests that are copy&pasted and doesn't test 
anything new.

Do you suggest to return _all_ tests back into every command? (but also 
keep the new direct tests, I assume)
