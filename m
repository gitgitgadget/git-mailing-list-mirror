Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CAC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151F861CBE
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 22:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGGWig (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:38:36 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:46725 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGGWig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 18:38:36 -0400
Received: from [84.163.68.234] (helo=[192.168.2.202])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1G8G-0006mq-6f; Thu, 08 Jul 2021 00:35:04 +0200
Subject: Re: What actually is a branch?
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
From:   Martin <git@mfriebe.de>
Message-ID: <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
Date:   Thu, 8 Jul 2021 00:35:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <877di13hhe.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2021 00:07, Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>> This is works if your base (or tail, or whatever) is static, but many
>> branches jump around, and that's where @{tail} comes in handy.
> 
> Yeah, I see. When I need to make a branch jump around, I do need to
> manually move my references, but that's fortunately very rare use-case
> for me. Having direct support for that is still a win.
> 
>>
>> You can do this:
>>
>>    git rebase --onto foo@{upstream} foo@{tail}
>>
>> This will always rebase the right commits (no need to look into the
>> reflog). So you can say that the branch is foo@{tail}..foo.
> 

Maybe I am missing something, is tail for tracking branches only, or for 
just any branch?

If for any branch, looking at

   A => B => C => D  master
        |
         \          / => G => H  branch_1
          => E => F
                    \ => I => J  branch_2

Where is the base of branch_1 and branch_2?
(and does it matter if they have an upstream)

Maybe branch_1 diverged from Master, and then branch_2 from branch_1?

Maybe the other way round.

Maybe there was a branch_0 (that got removed),
and branch_0 diverged from master, and branch_1 and branch_2 both from 
branch_0?

---
Also base may be misleading.

If head is the one end of the commit chains, then base should be the other.
But all branches contain commits A (and B). So the base would be A.

"fork" would be more descriptive IMHO?

Also, if that is to save the user from looking up fork points, maybe 
extend the syntax
   branch_1@{fork:branch_2}
   branch_1@{fork:master}

Depending on some of the answers to the above
   branch_1@{fork}
nearest fork, or upstream fork?
